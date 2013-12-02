using System.Collections.Generic;
using System;
using System.Net;
using System.Web;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Json;

namespace client {
	public class Response {
		public List<Programme> programmes { get; set; }

		public Response(Programme[] programmes) {
			this.programmes = new List<Programme>(programmes);
		}
	}

	[DataContract]
	public class Programme {
		[DataMember]
		public int pid { get; set; }
		[DataMember]
		public String title { get; set; }
		[DataMember]
		public String description { get; set; }
	}

	public class ProgrammeLister {
		public String CreateUrl() {
			return "http://localhost:3000/programmes";
		}


		public Response MakeRequest(string requestUrl) {
			try {
				HttpWebRequest request = WebRequest.Create(requestUrl) as HttpWebRequest;
				using (HttpWebResponse response = request.GetResponse() as HttpWebResponse) {
					if (response.StatusCode != HttpStatusCode.OK)
						throw new Exception(String.Format(
							"Server error (HTTP {0}: {1}).",
							response.StatusCode,
							response.StatusDescription));
					DataContractJsonSerializer jsonSerializer = new DataContractJsonSerializer(typeof(Programme[]));
					object objResponse = jsonSerializer.ReadObject(response.GetResponseStream());
//					Response jsonResponse = objResponse as List<Programme>;
					return new Response(objResponse as Programme[]);
				}
			} catch (Exception e) {
				Console.WriteLine(e.Message);
				return null;
			}
		}
		static void Main (string[] args) {
			ProgrammeLister lister = new ProgrammeLister ();
			Response response = lister.MakeRequest(lister.CreateUrl());
		}
		}
}
