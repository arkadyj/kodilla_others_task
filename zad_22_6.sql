create index fname_idx on readers(firstname);

create index lname_idx on readers(lastname);

create index title_idx on books(title);

explain select * from readers where firstname = 'John';