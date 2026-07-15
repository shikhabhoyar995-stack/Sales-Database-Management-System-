create database sales;
use sales;
Create table  Customers(
Customer_id varchar (50)primary key,
Customer_Name varchar(50) not null ,
Gender varchar(10)Check (Gender in ("Male","Female","Other")),
City varchar(50),
State varchar(50),
Phone varchar(10) unique,
Email varchar(50) unique
);
Create table Products(
Product_id varchar(50) primary key,
Product_Name varchar(50),
Category varchar(50),
Price int not null,
Stock int 
);
Create Table Employees(
Employee_id varchar(50) primary key,
Employee_Nmae varchar (50) not null,
Department varchar(50) not null,
Designation varchar(50),
Salary int check (salary>0)
);
Create Table Orders(
Order_id varchar(50) primary key,
Customer_id varchar(50),
Employee_id varchar(50),
 Order_date date,
 Total_Amount int not null,
 Foreign key (Customer_id) references Customers(Customer_id),
 Foreign key (Employee_id) references Employees(Employee_id)
 );
 Create table Order_Details(
 Order_Detail_id varchar(50) primary key,
 Order_id varchar(50),
 Product_id varchar(50),
 Quantity int ,
 Unit_price int not null,
 Foreign key(Order_id) references Orders(Order_id),
 Foreign Key (Product_id) references Products(Product_id)
 );
 
 Insert into Customers values
 ( "C101","Amit Sharma","Male","Nagpur","Maharashtra","9876543210","amit@gmail.com"),
 ("C102","Priya Verma","Female","Pune","Maharashtra","9878090987","priya@gmail.com"),
 ("C103"," Rahul Singh","Male","Mumbai","Maharashtra","9898989898","rahul@gmail.com"),
 ("C104","Sneha Patil","Female","Nashik","Maharashtra","9090909090","sneha@gmail.com"),
 ("C105","Karan Joshi","Male","Indore","Madhya Pradesh","8989898989","karan@gmail.com"),
 ("C106","Anjali Gupta","Female","Chennai","Tamil Nadu","8787878787","anjali@gmail.com"),
 ("C107","Rohit Mehta","Male","Vadodara","Gujrat","7878787878","rohit@gamil.com"),
 ("C108","Neha Shah","Female","Kanpur","Uttar Pradesh","9876546797","neha@gmail.com"),
 ("C109","Sahil Jain","Male","Lucknow","Uttar Pradesh","7865424796","sahil@gmail.com"),
 ("C110","Pooja Sharma","Female","Jaipur","Rajasthan","9087541265","pooja@gmail.com");
 
 

INSERT INTO Products VALUES
('P101','Laptop','Electronics',55000,20),
('P102','Mouse','Electronics',700,150),
('P103','Keyboard','Electronics',1200,100),
('P104','Headphones','Electronics',2500,80),
('P105','Printer','Electronics',9000,15),
('P106','Monitor','Electronics',15000,30),
('P107','Webcam','Electronics',3000,40),
('P108','SSD 512GB','Electronics',4500,60),
('P109','USB Drive 64GB','Electronics',800,120),
('P110','Router','Electronics',2200,35);
 
INSERT INTO Employees VALUES
('E101','Rohan Gupta','Sales','Sales Executive',35000),
('E102','Neha Jain','Sales','Sales Manager',60000),
('E103','Vivek Kumar','Sales','Sales Executive',38000),
('E104','Pooja Shah','Sales','Team Lead',50000),
('E105','Arjun Patel','Sales','Sales Executive',36000);

INSERT INTO Orders VALUES
('O101','C101','E101','2026-01-10',55700),
('O102','C102','E102','2026-01-12',2500),
('O103','C103','E103','2026-01-15',9000),
('O104','C104','E104','2026-01-18',1200),
('O105','C105','E105','2026-01-20',700),
('O106','C106','E101','2026-01-22',15000),
('O107','C107','E103','2026-01-25',3000),
('O108','C108','E104','2026-01-28',4500),
('O109','C109','E102','2026-01-30',2200),
('O110','C110','E105','2026-02-02',800);


INSERT INTO Order_Details VALUES
('OD101','O101','P101',2,55000),
('OD102','O101','P102',3,700),
('OD103','O102','P104',4,2500),
('OD104','O103','P105',1,9000),
('OD105','O104','P103',9,1200),
('OD106','O105','P102',9,700),
('OD107','O106','P106',1,15000),
('OD108','O107','P107',5,3000),
('OD109','O108','P108',1,4500),
('OD110','O109','P110',8,2200),
('OD111','O110','P109',4,800);

-- Display All Tables --
select*from Customers;
select *from Products;
select*from Employees;
select*from Orders;
select*from Order_Details;

-- where clause
select*from customers
where city="Nagpur"; 
 
-- PRODUCTS WITH PRICE GREATER THAN 5000
select*from products
where Price>5000;

-- Employees having salary more than 30000
select*from employees
where salary>30000;

-- ORDER BY
-- products sorted by price
select*from products
order by price desc;

-- customers sorted alphabetically
select*from customers
order by customer_name;

-- Aggregate Functions
-- Total_Revenue
select sum(Total_Amount)as total_revenue 
from orders;

-- average product price
select avg(price) as average_price
from products;

-- Maximum salary
select max(salary) as highest_salary
from employees;

-- Minimum product price
select min(price) as lowest_price
from products;

-- total customers
select count(*) as Total_customers
from customers;


-- Group by and having
-- city wise customers
select city,count(*) as 
Total_customers 
from customers
group by city;

-- cities having more than 1 customer
select city,count(*) as
total_customers
from customers
group by city
having count(*)>1;

-- joins
-- customers with their orders
select c.customer_name,o.order_id,o.total_amount
from customers c 
inner join orders o
on c.customer_id=o.customer_id;

-- PRODUCT DETAILS IN EACH ORDER
select od.order_id,p.product_name,od.quantity
from order_details od
inner join products p
on od.product_id=p.product_id;

-- subqueries
-- product with the highest price
select*from products
where price = (select max(price) from  products);

-- top 3 expensive products
select*from products
order by price desc
limit 3;

-- customers who spent more than 5000
select*from orders
where total_amount>5000;

-- total sales by employee
select employee_id,sum(Total_Amount)
as total_sales
from orders
group by employee_id;

-- total sales by customer
select customer_id,sum(total_amount)
as total_spent 
from orders
group by customer_id;

-- windows function
-- highest to lowest employee salary
select employee_id ,salary ,
row_number()over(order by salary desc) as ROW_num
from employees;

-- rank employees based on salary
select employee_id,salary,
rank() over(order by salary desc) as rank_no
from employees;

-- denserank of employees based on salary
select employee_id ,salary,
dense_rank() over(order by salary desc) as Dense_Rankno
from employees;

-- average salary of employees with department
select employee_id,designation,salary,
avg(salary) over(partition by designation)as avg_deapartment_salary
from employees;

-- divide employees into four salary groups
select employee_id ,salary,
ntile(4) over (order by salary desc) as salary_group 
from employees;

-- which product sold the most
select product_name from products
where product_id=(select product_id from order_details group by product_id
order by sum(quantity) desc
limit 1);

-- which customer spent the most
select customer_name
from customers
where customer_id=(select customer_id from orders 
group by customer_id
order by sum(Total_amount) desc
limit 1
);