alter table books add column BESTSELLER boolean;

drop procedure if exists UpdateBestsellers;

delimiter $$

create procedure UpdateBestsellers()
begin
	declare booksrent, days, bk_id int;
	declare bookspermonth decimal(5,2);
    declare finished int default 0;
    declare all_books cursor for select book_id from books;
    declare continue handler for not found set finished = 1;
    open all_books;
    while (finished = 0) do
		fetch all_books into bk_id;
        if (finished = 0) then
			select count(*) from rents where book_id = bk_id
            into booksrent;
            select datediff(current_date(), min(rent_date)) from rents
            where book_id = bk_id
            into days;
            set bookspermonth = booksrent / (days/30);            
            if (bookspermonth >2) then            
				update books set bestseller = true
				where book_id = bk_id;
            else
				update books set bestseller = false
				where book_id = bk_id;
            end if;    
            commit;
         end if;
	end while;
    close all_books;
end $$

delimiter ;