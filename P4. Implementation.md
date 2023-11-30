## Bidding System

## DDL Results

SELECT NAME, [OBJECT_ID], TYPE_DESC, CREATE_DATE, MODIFY_DATE FROM SYS.TABLES;

| name            | object_id  | type_desc  | create_date             | modify_date             |
| --------------- | ---------- | ---------- | ----------------------- | ----------------------- |
| User            | 901578250  | USER_TABLE | 2023-11-22 18:23:54.470 | 2023-11-22 18:28:47.997 |
| Buyer           | 949578421  | USER_TABLE | 2023-11-22 18:27:00.237 | 2023-11-22 19:05:21.890 |
| Seller          | 997578592  | USER_TABLE | 2023-11-22 18:28:47.990 | 2023-11-22 19:03:58.893 |
| Chat            | 1045578763 | USER_TABLE | 2023-11-22 18:40:05.613 | 2023-11-22 18:40:05.613 |
| Block           | 1109578991 | USER_TABLE | 2023-11-22 18:40:08.880 | 2023-11-22 18:40:08.880 |
| AdItemCategory  | 1237579447 | USER_TABLE | 2023-11-22 18:45:54.730 | 2023-11-22 18:54:12.470 |
| Admin           | 1269579561 | USER_TABLE | 2023-11-22 18:48:06.153 | 2023-11-22 18:54:12.470 |
| AdStatus        | 1349579846 | USER_TABLE | 2023-11-22 18:48:55.383 | 2023-11-22 18:54:12.470 |
| AdItem          | 1397580017 | USER_TABLE | 2023-11-22 18:54:12.463 | 2023-11-22 19:06:20.570 |
| Feedback        | 1493580359 | USER_TABLE | 2023-11-22 18:55:18.337 | 2023-11-22 18:55:18.337 |
| Auction         | 1573580644 | USER_TABLE | 2023-11-22 19:03:42.703 | 2023-11-22 19:09:02.803 |
| Alert           | 1637580872 | USER_TABLE | 2023-11-22 19:03:58.880 | 2023-11-22 19:03:58.880 |
| WatchList       | 1733581214 | USER_TABLE | 2023-11-22 19:05:21.883 | 2023-11-22 19:06:20.570 |
| AdItemWatchList | 1781581385 | USER_TABLE | 2023-11-22 19:06:20.563 | 2023-11-22 19:06:20.563 |
| Bid             | 1861581670 | USER_TABLE | 2023-11-22 19:09:02.793 | 2023-11-22 19:09:02.793 |
| BidStatus       | 1909581841 | USER_TABLE | 2023-11-22 19:10:30.273 | 2023-11-22 19:10:30.273 |

## Trigger

- On every bid, an alert is created based on watchlist to the buyers
- Skip update when seller wants to buy his own item

## Stored Procedures

- Upon deletion of an item, all bids are deleted
- Upon deletion of an item, all watchlist items are deleted
- Upon deletion of an item, all alerts are deleted
- Upon deletion of an item, all feedbacks are deleted
- Upon deletion of an item, all chats are deleted
- Upon deletion of an item, all blocks are deleted
- Upon deletion of an item, all auctions are deleted
- Upon deletion of an item, all aditems are deleted

- Upon admin deletion of a user, all bids are deleted
- Upon admin deletion of a user, all watchlist items are deleted
- upon admin delete the aditem, all bids are deleted
- upon admin delete the aditem, all watchlist items are deleted
- upon admin delete the aditem, all alerts are deleted
- upon admin delete the aditem, all feedbacks are deleted
- upon admin delete the aditem, all chats are deleted
