/** top 5 countires**/
select c.country,sum(p.revenue)as revenue from customers c
join orders o on o.customerNumber=c.customerNumber
join orderdetails od on od.orderNumber=o.orderNumber
join products p on p.productCode=od.productCode
group by c.country 
order by revenue desc;

/** top 5 customers**/
select c.customerName,sum(p.revenue)as revenue from customers c
join orders o on o.customerNumber=c.customerNumber
join orderdetails od on od.orderNumber=o.orderNumber
join products p on p.productCode=od.productCode
group by c.customerName 
order by revenue desc;

/*Top 5 Products*/
select productline,sum(revenue) from products group by productLine order by sum(revenue) desc limit 5;

/* cost by productline*/

select productline,sum(expenses) from products group by productline order by sum(expenses) desc ;

/* profit by productline*/

select productline,sum(totalprofit) from products group by productline order by sum(totalprofit) desc ;

/*Quantity ordered by year*/
select sum(quantityOrdered),year(o.orderDate)as year,monthname(o.orderDate) as MonthName from orderdetails od
join orders o on o.orderNumber=od.orderNumber
group by year,MonthName
having year=2003;

/*Total Revenue vs total expenditure*/

select sum(p.revenue),sum(p.expenses),monthname(o.orderDate) as MonthName,year(o.orderDate)as year from products p
join orderdetails od on p.productCode=od.productCode 
join orders o on o.orderNumber=od.orderNumber
group by MonthName,year
having year=2003
order by MonthName desc ;

/*Quantity ordered by country and productline*/
select sum(od.quantityOrdered),c.country,p.productLine from orderdetails od 
join products p on p.productCode=od.productCode
join orders o on o.orderNumber=od.orderNumber
join customers c on c.customerNumber=o.customerNumber
group by p.productLine,c.country
order by country;

/*Monthly order count*/
select Count(*) from orderdetails;
select Count(od.orderNumber)as orderCount,monthname(orderDate)as monthName from orderdetails od 
join orders o on o.orderNumber=od.orderNumber
group by monthname;

/*sum of revenue by orderdtae*/
select sum(p.revenue),o.orderDate from products p 
join orderdetails od on od.productCode=p.productCode
join orders o on o.orderNumber=od.orderNumber
group by o.orderDate;


/*order processinng time*/
create temporary table orderProcessingTime
SELECT
    CAST(orderDate AS DATE) as order_date,
    CAST(shippedDate AS DATE) AS shipped_date,
   ABS( DATEDIFF(CAST(orderDate AS DATE), CAST(shippedDate AS DATE))) AS order_processing
FROM
    orders;
    
select * from  orderProcessingTime;

/* Sum of order processing time by order date*/
select order_date,order_Processing from orderProcessingTime; 

/*customer number orderprocessing time*/
select c.customerNumber,op.order_Processing from customers c
join orders o on o.customerNumber=c.customerNumber
join orderProcessingTime op on op.order_date=o.orderDate;

/*count of orderNumber by  processinng time */

select count(o.orderNumber),op.order_Processing  from orders o 
join orderProcessingTime op on op.order_date=o.orderDate
group by op.order_Processing;

/* country wise of customer count*/
select country,count(customerNumber) from customers group by country;

/*individual customer details*/
select c.customerNumber,sum(revenue),sum(expenses),sum(TotalProfit) from customers c
join orders o on o.customerNumber=c.customerNumber
join orderdetails od on od.orderNumber=o.orderNumber
join products p on p.productCode=od.productCode
group by c.customerNumber;

/* count of orderNumber by customer wise */
select customerName,count(orderNumber) from customers c
join orders o on o.customerNumber=c.customerNumber group by customerName
order by  count(orderNumber) desc;

/* count of stock by productLine*/

select productline,count(quantityInStock) from 
 products  
group by productLine


