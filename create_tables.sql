/******************************************
* Author : Baba Lemon 				      *
* Title  : create_tables.sql			  *
* Date   : 12/26/2021				   	  *
* Postgresql Source Code to:              *
* 	create students table Structure       *
*.  populate table from students.csv file *
* 	create stipends table Structure       *
*.  populate table from stipends.csv file *
* 	create Inventories table Structure.   *
*****************************************/

drop table if exists students;
drop table if exists stipends;	
drop table if exists inventories;

/******* Create students structure *******/
create table students (
  	id integer,
    name varchar not null,
    created_at  timestamp not null,
    updated_at  timestamp null null,
    last_name varchar,
    cohort varchar,
    comment varchar,
    address varchar,
    city varchar,
    zip varchar,
    cell varchar,
    email varchar,
    guardian varchar,
    guardian_cell varchar,
    guardian_email varchar,
    pod varchar,
    school varchar
    );

/******* Create stipends structure *******/
create table stipends (
	 id integer,
	 date date,
	 credit float,
	 debit float,
	 comment text,
	 student_id integer,
	 created_at timestamp,
	 updated_at timestamp
	 );


/********** Populate student tables data from CSV file *******/
COPY students(
  	id,
    name,
    created_at,
    updated_at,
    last_name,
    cohort,
    comment,
    address,
    city,
    zip,
    cell,
    email,
    guardian,
    guardian_cell,
    guardian_email,
    pod,
    school)
    
	FROM '/Users/babalemon/genius_stipend_tables/students.csv' 
		CSV HEADER;


create table inventories(
	id INT,
	model varchar,
	hgp_nbr varchar,
	serial_nbr varchar,
	os varchar,
	student_id int,
	created_at timestamp not null,
	updated_at timestamp not null
);


/********** Populate stipends tables data from CSV file *******/
COPY stipends(
  	id,
  	date,
  	credit,
  	debit,
  	comment,
  	student_id,
  	created_at,
  	updated_at)
  	
	FROM '/Users/babalemon/genius_stipend_tables/stipends.csv'
		DELIMITER ','
		CSV HEADER;

/************ Display student table **************/
select 
	student_id,
	students.id,
	name,
	last_name,
	credit,
	debit,
	stipends.comment
	
    from stipends 
    	join students 
    		on students.id = student_id 
    			and students.pod = 'BRotation'
    	order by name,last_name;


/************ Display stipend table **************/
select 
	name,
	sum(credit-debit)
	
	from stipends 
		join students 
			on 
				students.id = stipends.student_id 
					group by name 
						order by name;