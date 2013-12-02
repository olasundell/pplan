using NUnit.Framework;
using System;

namespace client {
	[TestFixture ()]
	public class ProgrammeListerTest {
		[Test ()]
		public void ListerShouldReturnNonNullResponse() {
			ProgrammeLister lister = new ProgrammeLister();

			Response response = lister.MakeRequest (lister.CreateUrl ());
			Assert.NotNull (response);
		}

		[Test ()]
		public void ListerShouldListProgrammes() {
			ProgrammeLister lister = new ProgrammeLister();

			Response response = lister.MakeRequest (lister.CreateUrl ());
			Assert.Greater (response.programmes.Count, 0);
		}
	}
}

