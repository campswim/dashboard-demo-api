delete from Roles;

insert into Roles (Id, RestrictedActions, RestrictedPages, Role) values (1, 'None', 'None', 'Admin');
insert into Roles (Id, RestrictedActions, RestrictedPages, Role) values (11, 'Delete', 'Users, Settings', 'Agent');
insert into Roles (Id, RestrictedActions, RestrictedPages, Role) values (21, 'All', 'Users, Settings', 'User');
