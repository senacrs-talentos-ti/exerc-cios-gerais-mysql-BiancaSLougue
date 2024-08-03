create database Store;

use store; 
create table clients(
	id int primary key auto_increment,
    name varchar(50) not null,
    email varchar(50) not null
);

use store;
create table products(
	id int primary key auto_increment,
    name varchar(50) not null,
    price decimal(10,2) not null
);

use store;
create table orders(
	id int primary key auto_increment,
    client_id int,
    order_date date not null,
    total decimal(10,2) not null,
    foreign key (client_id) references clients(id)
);

use store;
create table order_items(
	order_id int,
    product_id int,
    quantity int(50) not null,
    price decimal(10,2) not null,
    primary key (order_id, product_id),
    foreign key (order_id) references orders(id),
    foreign key (product_id) references products(id)
);

use store;
insert into clients (id,name,email) values 
(default,'Maria','maria@gmail.com'), (default,'Isabel','isabel@bol.com'),
(default,'Joana','joana@yahoo.com.br'), (default,'Jonatan','jonatan@hotmail.com');
insert into products (id,name,price) values 
(default, 'Ipad',2500.00), (default, 'Maionese',12.50),(default, 'Martelo',60.00),
(default, 'Ketchup',15.00),(default, 'Mostarda',9.75),(default, 'JBL',280.00);

use store; -- Exercício 6
insert into orders (id,client_id,order_date,total) values 
(default,2,'2024-06-18',2512.50),(default,4,'2024-04-08',69.75),(default,4,'2024-06-18',280),
(default,1,'2024-02-28',15),(default,3,'2024-06-18',60),(default,2,'2024-06-18',280);

use store; -- Exercício 7
insert into order_items (order_id,product_id,quantity,price) values 
(1,1,1,2500),(1,2,1,12.50),(2,3,1,60),(2,5,1,9.75),(3,6,1,280),(4,4,1,15),(5,3,1,60),(6,6,1,280);

use store; -- Exercício 8
update products set price = 10 where id=5;
update orders set total = 70 where id=2;
update order_items set price=10 where product_id=5;

use store; -- Exercício 9
delete from clients where id=3;
delete from orders where client_id=3;
delete from order_items where order_id=5;

use store; -- Exercício 10
alter table clients add column birthdate date;

use store; -- Exercício 11
select orders.id as pedido, clients.name as Cliente, products.name as Produto
from orders
inner join clients on clients.id=orders.client_id
inner join order_items on order_items.order_id= orders.id
inner join products on products.id=order_items.product_id;

use store; -- Exercício 12
insert into clients (id,name,email) values (default,'Joelma','joelma@gmail.com');
select * from clients;

select clients.name as Cliente, products.name as Produto
from clients
left join orders on orders.client_id = clients.id
left join order_items on order_items.order_id = orders.id
left join products on products.id = order_items.product_id;

use store; -- Exercício 13
insert into products (id,name,price) values 
(default, 'Macacão',80.00);
select products.name as Produto, order_items.order_id as Pedido
from order_items
right join products on order_items.product_id = products.id;

use store; -- Exercício 14
select sum(total) from orders;
select count(quantity) from order_items;

use store; -- Exercício 15
select clients.name as Cliente, count(orders.id) as Quantidade
from clients 
left join orders on orders.client_id = clients.id
group by Cliente 
order by Quantidade desc;

use store; -- Exercício 16
select products.name as Produto, count(order_items.quantity) as Quantidade
from products
left join order_items on order_items.product_id = products.id
group by Produto
order by Quantidade desc;

use store; -- Exercício 17
select clients.name as Cliente, sum(orders.total) as Total_gasto
from clients 
left join orders on orders.client_id = clients.id 
group by cliente
order by Total_gasto desc;

use store; -- Exercício 18
select products.name as Produto, count(order_items.order_id) as Total_vendas
from products
left join order_items on order_items.product_id = products.id
group by Produto
order by Total_vendas desc
limit 3;

use store; -- Exercício 19
select clients.name as Clientes, sum(orders.total) as Total_gasto
from clients
left join orders on orders.client_id = clients.id
group by Clientes
order by Total_gasto desc
limit 3;

use store; -- Exercício 20
select clients.name as Clientes, avg(order_items.quantity) as Media_quantidade
from clients
left join orders on orders.client_id = clients.id 
left join order_items on order_items.order_id = orders.id
group by Clientes
order by Media_quantidade desc;

use store; -- Exercício 21
select sum(orders.client_id), sum(orders.id), month(orders.order_date) as Mes
from orders
group by Mes
order by Mes desc;

use store; -- Exercício 22
select products.name as Produto, order_items.order_id as Pedido
from products
left join order_items on order_items.product_id = products.id 
where order_items.order_id is null
group by Produto, Pedido;

use store; -- Exercício 23
insert into orders (id,client_id,order_date,total) values (default,4,'2024-06-18',2572.50);
insert into order_items (order_id,product_id,quantity,price) values (7,1,1,2500),(7,2,1,12.50),(7,3,1,60);

select order_items.order_id as Pedido, count(distinct order_items.product_id) as Produtos
from order_items
group by Pedido
having Produtos >2;

use store; -- Exercício 24
with UltimoMes AS (
	Select max(month(order_date)) as UltimoMes from orders
)
select clients.name as Cliente, orders.order_date as mes
from clients
inner join orders on clients.id = orders.client_id
join UltimoMes on month(order_date) = UltimoMes.UltimoMes
group by cliente, mes



-- month(now()) 

use store; -- Exercício 25
select clients.name as Cliente, avg(orders.total) as Media
from clients 
inner join orders on clients.id = orders.client_id
group by Cliente
order by Media desc;
