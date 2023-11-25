## Todo

- [ ] Create DDL for all tables
- [ ] Create DML for all tables (insert atleast 10 rows)
- [ ] Create table level check constraints
- [ ] Create views for all tables
  - [ ] Use views in the dashboard
- [ ] Create Computed Column based on UDF
- [ ] Create Non-Clustered Indexes
- [ ] Create Stored Procedures
- [ ] Create DML Triggers
- [ ] Create Column Encryption on all password columns

> For each task, create a file.

- ddl.sql for DDL and Create table level check constraints
- dml.sql for DML
- views.sql for - Create views for all tables
- udf.sql for - Create Computed Column based on UDF
- indexes.sql for - Create Non-Clustered Indexes
- sp.sql for - Create Stored Procedures
- triggers.sql for - Create DML Triggers
- encryption.sql for - Create Column Encryption on all password columns

## Details

### DDL

- [ ] Create table User
- [ ] Create table Buyer
- [ ] Create table Seller
- [ ] Create table Chat
- [ ] Create table Block
- [ ] Create table Admin
- [ ] Create table AdItemCategory
- [ ] Create table AdStatus
- [ ] Create table AdItem
- [ ] Create table Feedback
- [ ] Create table Auction
- [ ] Create table Alert
- [ ] Create table WatchList
- [ ] Create table AdItemWatchList
- [ ] Create table Bid
- [ ] Create table BidStatus
- [ ] Create table BidLog

## Add sample records to all tables

### DDL

- [ ] Insert sample data into table User
- [ ] Insert sample data into table Buyer
- [ ] Insert sample data into table Seller
- [ ] Insert sample data into table Chat
- [ ] Insert sample data into table Block
- [ ] Insert sample data into table Admin
- [ ] Insert sample data into table AdItemCategory
- [ ] Insert sample data into table AdStatus
- [ ] Insert sample data into table AdItem
- [ ] Insert sample data into table Feedback
- [ ] Insert sample data into table Auction
- [ ] Insert sample data into table Alert
- [ ] Insert sample data into table WatchList
- [ ] Insert sample data into table AdItemWatchList
- [ ] Insert sample data into table Bid
- [ ] Insert sample data into table BidStatus
- [ ] Insert sample data into table BidLog

## Create table level check constraints

Add check constraints

- [ ] `Block:` CONSTRAINT Reason_CHK CHECK (Reason IN ('Inappropriate', 'Spam', 'Other')),
- [ ] `Admin:` CONSTRAINT AdminRole_CHK CHECK (AdminRole IN ('Super', 'Regular'))
- [ ] `Feedback:` CONSTRAINT FeedbackRating_CHK CHECK (FeedbackRating IN (1, 2, 3, 4, 5)),
- [ ] `Alert:` CONSTRAINT AlertType_CHK CHECK (AlertType IN ('Bid', 'Buy', 'Sell')),
- [ ] `AdItemWatchList:` CONSTRAINT AdItemWatchListEventType_CHK CHECK (EventType IN ('Active', 'Inactive', 'Sold')),

## Create views for all tables

- [ ] Create view for table User masking password
- [ ] Create view for associated tables with corresponding foreign key values. For example, AdItemCategoryName, AdStatusName, etc.

## Create Computed Column based on UDF

- [ ] Create a UDF to calculate the age of the user
- [ ] Create a computed column to know if the adItem is active or not based on the adItemEndDate
- [ ] Create a computed column to know if the bid is active or not based on the bidEndDate
- [ ] Create a computed column in the AdItem table to know if the adItem is sold or not based on the bidEndDate

## Create Non-Clustered Indexes

- [ ] Create Non-Clustered Indexes on all foreign key columns
- [ ] Create Non-Clustered Indexes on all columns used in the where clause
- [ ] Create Non-Clustered Indexes on all columns used in the join clause
- [ ] Create Non-Clustered Indexes on all columns used in the order by clause
- [ ] Create Non-Clustered Indexes on all columns used in the group by clause

## Create Stored Procedures

- [ ] Create a stored procedure to insert a new user
- [ ] Create a stored procedure to update a user
- [ ] Create a stored procedure to delete a user
- [ ] Create a stored procedure to insert a new adItem
- [ ] Create a stored procedure to update an adItem
- [ ] Create a stored procedure to delete an adItem
- [ ] Create a stored procedure to insert a new bid
- [ ] Create a stored procedure to update a bid
- [ ] Create a stored procedure to delete a bid
- [ ] Create a stored procedure to insert a new feedback
- [ ] Create a stored procedure to update a feedback
- [ ] Create a stored procedure to delete a feedback
- [ ] Create a stored procedure to insert a new chat
- [ ] Create a stored procedure to update a chat
- [ ] Create a stored procedure to delete a chat
- [ ] Create a stored procedure to insert a new block
- [ ] Create a stored procedure to update a block
- [ ] Create a stored procedure to delete a block
- [ ] Create a stored procedure to insert a new alert
- [ ] Create a stored procedure to update an alert
- [ ] Create a stored procedure to delete an alert
- [ ] Create a stored procedure to insert a new watchlist
- [ ] Create a stored procedure to update a watchlist
- [ ] Create a stored procedure to delete a watchlist
- [ ] Create a stored procedure to insert a new adItemWatchlist
- [ ] Create a stored procedure to update an adItemWatchlist
- [ ] Create a stored procedure to delete an adItemWatchlist
- [ ] Create a stored procedure to insert a new auction
- [ ] Create a stored procedure to update an auction
- [ ] Create a stored procedure to delete an auction
- [ ] Create a stored procedure to insert a new buyer
- [ ] Create a stored procedure to update a buyer
- [ ] Create a stored procedure to delete a buyer
- [ ] Create a stored procedure to insert a new seller
- [ ] Create a stored procedure to update a seller
- [ ] Create a stored procedure to delete a seller
- [ ] Create a stored procedure to insert a new admin
- [ ] Create a stored procedure to update an admin
- [ ] Create a stored procedure to delete an admin
- [ ] Create a stored procedure to insert a new bidStatus
- [ ] Create a stored procedure to update a bidStatus
- [ ] Create a stored procedure to delete a bidStatus
- [ ] Create a stored procedure to insert a new bidLog
- [ ] Create a stored procedure to update a bidLog
- [ ] Create a stored procedure to delete a bidLog
- [ ] Create a stored procedure to insert a new adItemCategory
- [ ] Create a stored procedure to update an adItemCategory
- [ ] Create a stored procedure to delete an adItemCategory

## Create DML Triggers

- [ ] Create a trigger to insert a new alert when a new bid is placed
- [ ] Create a trigger to insert a new alert when a new adItem is created
- [ ] Create a trigger to insert a new alert when a new adItem is sold
- [ ] Create a trigger to insert a new alert when a new adItem is bought
- [ ] Create a trigger to insert a new alert when a new adItem is deleted
- [ ] Create a trigger to insert a new alert when a new bid is deleted
- [ ] Create a trigger to insert a new alert when a new feedback is created

## Create Column Encryption on all password columns

- [ ] Create column encryption on all password columns

## Create a dashboard

- TODO:
