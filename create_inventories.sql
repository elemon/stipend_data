create table inventories(
	id INT GENERATED ALWAYS AS IDENTITY,
	model varchar(50),
	hgp_nbr varchar(50),
	serial_nbr varchar(50),
	os varchar(50),
	student_id int,
	created_at timestamp not null,
	updated_at timestamp not null,
	primary key(id),
	constraint fk_students
		foreign key(student_id)
			references students(id)
			on delete set null
);