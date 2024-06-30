CREATE DATABASE Libraray;
USE Libraray;
CREATE TABLE Branch(branch_no int PRIMARY KEY,manager_id INT NOT NULL,branch_address VARCHAR(100),contact_no CHAR(12));
CREATE TABLE Employee(emp_id INT PRIMARY KEY,emp_name VARCHAR(20),position VARCHAR(15),salary INT,branch_no INT,FOREIGN KEY(branch_no) REFERENCES branch(branch_no));
CREATE TABLE customer(customer_id INT PRIMARY KEY,customer_name VARCHAR(20),customer_address VARCHAR(30),reg_date DATE);
CREATE TABLE books(ISBN VARCHAR(50) PRIMARY KEY,book_title VARCHAR(50),category VARCHAR(30),rental_price INT,status ENUM('yes','no'),author VARCHAR(50),publisher VARCHAR(50));
CREATE TABLE issuestatus(issue_id INT PRIMARY KEY,issued_cust INT,FOREIGN KEY(issued_cust) REFERENCES customer(customer_id),issued_book_name VARCHAR(30),issue_date DATE,isbn_book VARCHAR(50),FOREIGN KEY(isbn_book) REFERENCES books(isbn)); 
CREATE TABLE returnstatus(return_id INT PRIMARY KEY,return_cust VARCHAR(20),return_book_name VARCHAR(30),return_date DATE,isbn_book2 VARCHAR(20),FOREIGN KEY(isbn_book2) REFERENCES books(isbn));
INSERT INTO Branch (branch_no ,manager_id ,branch_address ,contact_no ) VALUES
(1,101,'resd St ABC','9876543210'),
(2,102,'bjn St ABC','9876512210'),
(3,103,'bfjm St ABC','9876545210'),
(4,104,'vhn St ABC','9786543210'),
(51,105,'cbhn St ABC','9096543210');

INSERT INTO Employee(emp_id,emp_name,position,salary,branch_no ) VALUES
(201,'Rai','Librarian',25000,1),
(202,'Helen','Manager',60000,2),
(203,'Ram','Manager',70000,3),
(204,'Ravi','Librarian',15000,1),
(205,'Fera','Librarian',25000,4),
(206,'Milan','Librarian',50000,51),
(207,'Yami','Clerk',12000,1),
(208,'Lihar','Librarian',15000,1),
(209,'Lithu','Clerk',12000,3),
(210,'Abid','Librarian',25000,51),
(211,'Gyan','Manager',60000,2),
(212,'Nizam','Manager',65000,1),
(213,'Radha','Librarian',25000,4),
(214,'Kai','Clerk',12000,4),
(215,'Ozil','Librarian',15000,4);

INSERT INTO customer(customer_id,customer_name,customer_address,reg_date) VALUES
(301,'Yuaan','Sm st , calicut','2022-02-4'),
(302,'Hamd','Vn st , Mavvoor','2021-08-1'),
(303,'Riyaam','HN st , kalpetta','2022-02-4'),
(304,'Kais','KL st , vallikkapatta','2021-07-4'),
(305,'Kam','AS st , pallipuram','2021-9-2');


INSERT INTO books(ISBN,book_title,category ,rental_price,status,author,publisher) VALUES
('9781554600247','Addys Race','Life story',7.95,'yes','Debby','orca'),
('9234554667854','Harbour Room','History',10,'No','Willaim','Hodder'),
('9652924652987','Jeen vala','History',8,'yes','Jeen','Maple tree press'),
('9764352314345','A childish life','Story',6.09,'yes','Hentry','Hentry Holt'),
('9233555456754','Tale of Manuish','Life story',12,'No','Yuaan','Dc books'),
('9547655465654','Kappa Story','History',15,'No','Milanuish','Dc books'),
('9735646005433','Tragedy','Illumination',6,'yes','Ozi','Henp');

INSERT INTO issuestatus(issue_id,issued_cust,issued_book_name,issue_date,isbn_book) VALUES
(401,301,'Addys Race','2023-01-2','9781554600247'),
(402,302,'Harbour Room','2020-01-7','9234554667854'),
(403,303,'Jeen vala','2023-01-1','9652924652987'),
(404,304,'A childish life','2023-01-6','9764352314345');

INSERT INTO returnstatus(return_id,return_cust,return_book_name,return_date,isbn_book2) VALUES
(501,301,'Addys Race','2020-01-15','9781554600247'),
(502,302,'Harbour Room','2020-01-30','9234554667854'),
(503,303,'Jeen vala','2020-01-15','9652924652987'),
(504,304,'A childish life','2020-01-20','9764352314345');

# 1. Retrieve the book title, category, and rental price of all available books.
SELECT book_title,category,rental_price FROM books WHERE status='yes';

# 2. List the employee names and their respective salaries in descending order of salary.
SELECT emp_name,salary FROM employee ORDER BY salary DESC;

# 3. Retrieve the book titles and the corresponding customers who have issued those books.
SELECT books.book_title,customer.customer_name FROM issuestatus
JOIN books ON issuestatus.isbn_book=books.isbn
JOIN customer ON issuestatus.issued_cust=customer.customer_id;

#4. Display total count of books in each category.
SELECT category,COUNT(category) AS total_count FROM books GROUP BY category;

#5. Retreive the employee names and their positions for the employes whose salaries are above Rs 50,000.
SELECT emp_name,position FROM employee WHERE salary > 50000;

#6.List the customer names who regestered before 2022-01-01 and have not issue any books yet.
SELECT customer_name FROM customer WHERE reg_date < '2022-01-01' AND customer_id NOT IN (SELECT issued_cust FROM issuestatus);

# 7. Display the branch numbers and the total count of employees in each branch.
SELECT Branch_no, count(Emp_name) AS Total_Count_Of_Employees FROM Employee GROUP BY Branch_no;

# 8. Display the names of customers who have issued books in the month of June 2023.
SELECT DISTINCT Customer.Customer_name FROM Customer JOIN IssueStatus ON Customer.Customer_Id = IssueStatus.Issued_cust
WHERE MONTH(IssueStatus.Issue_date) = 6 AND YEAR(IssueStatus.Issue_date) = 2023;

# 9. Retrieve book_title from book table containing history.
SELECT Book_title FROM Books WHERE Category = 'History';

# 10. Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.
SELECT Branch_no, Count(*) AS Count_Of_Employees From Employee GROUP BY Branch_no HAVING Count(*) > 5;
