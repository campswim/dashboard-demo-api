delete from ProcessJobs;

insert into ProcessJobs (DataDirection, ExternalSystem, Id, Name) values ('IN', 'Burrito', 100, 'Pull Unshipped Orders');
insert into ProcessJobs (DataDirection, ExternalSystem, Id, Name) values ('IN', 'Burrito', 101, 'Pull Shipped Orders');
insert into ProcessJobs (DataDirection, ExternalSystem, Id, Name) values ('IN', 'Burrito', 102, 'Pull Fee Orders/Chargebacks');
insert into ProcessJobs (DataDirection, ExternalSystem, Id, Name) values ('IN', 'Burrito', 103, 'Pull Completed ReturnOrders');
insert into ProcessJobs (DataDirection, ExternalSystem, Id, Name) values ('OUT', 'Burrito', 110, 'Push Tracking Info');
insert into ProcessJobs (DataDirection, ExternalSystem, Id, Name) values ('OUT', 'Burrito', 111, 'Push ReturnOrders');
insert into ProcessJobs (DataDirection, ExternalSystem, Id, Name) values ('IN', 'BC', 200, 'Pull Tracking info');
insert into ProcessJobs (DataDirection, ExternalSystem, Id, Name) values ('IN', 'BC', 201, 'Pull ReturnOrders');
insert into ProcessJobs (DataDirection, ExternalSystem, Id, Name) values ('OUT', 'BC', 210, 'Push Orders/Customers');
insert into ProcessJobs (DataDirection, ExternalSystem, Id, Name) values ('OUT', 'BC', 211, 'Push Cash Receipts');
insert into ProcessJobs (DataDirection, ExternalSystem, Id, Name) values ('OUT', 'BC', 212, 'Push Shipping Info');
insert into ProcessJobs (DataDirection, ExternalSystem, Id, Name) values ('OUT', 'BC', 213, 'Push Completed ROs');
insert into ProcessJobs (DataDirection, ExternalSystem, Id, Name) values ('OUT', 'CCLS', 310, 'Generate File Can');
insert into ProcessJobs (DataDirection, ExternalSystem, Id, Name) values ('IN', 'CCLS', 311, 'Parse File Can');
insert into ProcessJobs (DataDirection, ExternalSystem, Id, Name) values ('OUT', 'LBC', 320, 'Generate File Phl');
insert into ProcessJobs (DataDirection, ExternalSystem, Id, Name) values ('IN', 'LBC', 321, 'Parse File Phl');
