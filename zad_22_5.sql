create table stats (
	stat_id int(11) auto_increment primary key,
    state_date datetime not null,
    stat varchar(20) not null,
    value int(11) not null
);    

--------------

create view BESTSELLERS_COUNT as
select count(*) as ilosc from books where BESTSELLER=true

--------------


use kodilla_course;

drop event if exists bestsellet_event;

delimiter $$

create event bestsellet_event
on schedule every 1 minute
ON COMPLETION PRESERVE
do  		
	begin
		declare count int;
        call UpdateBestsellers();   
        select ilosc from bestsellers_count into count;		
		insert into stats (state_date,stat, value)
			values (current_time(),"BESTSELLERS",count);
        
    end $$
    
delimiter ;    