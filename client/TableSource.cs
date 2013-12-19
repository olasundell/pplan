using System;
using System.
namespace client {
	public class TableSource : UITableViewSource {
		string[] tableItems;
		string cellIdentifier = "TableCell";

		public TableSource (string[] items) {
			tableItems = items;
		}

		public override int RowsInSection (UITableView tableview, int section) {
			return tableItems.Length;
		}

		public override UITableViewCell GetCell (UITableView tableView, MonoTouch.Foundation.NSIndexPath indexPath) {
			UITableViewCell cell = tableView.DequeueReusableCell (cellIdentifier);
			// if there are no cells to reuse, create a new one

			if (cell == null) {
				cell = new UITableViewCell (UITableViewCellStyle.Default, cellIdentifier);
			}

			cell.TextLabel.Text = tableItems[indexPath.Row];
			return cell;
		}
	}
}

