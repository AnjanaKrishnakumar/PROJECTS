 --- 1)To find the senior most employee
 
SELECT * FROM music_store.employee 
ORDER BY levels desc
LIMIT 1;

-- Adams Andrew is the senior most employee


--- 2)To find which country has the most invoices
SELECT COUNT(*) as c,billing_country FROM music_store.invoice
GROUP BY billing_country
ORDER BY C DESC;

--- USA has the most number of invoices

--- 3)To find the top 3 values of invoices
SELECT * FROM music_store.invoice
ORDER BY total desc 
LIMIT 3;

--- Top value are 23.759, 19.8, 19.8 rewspectively

--- 4) City with highest sum of total invoices
SELECT * FROM music_store.invoice;
SELECT SUM(total) as sum , billing_city FROM music_store.invoice
group by billing_city
ORDER BY 1 DESC 
LIMIT 1 ;

--- Prague has the best customers 

--- 5) Finding the best customer 
SELECT * FROM music_store.customer;
SELECT  music_store.customer.customer_id,music_store.customer.firstname,music_store.customer.lastname,
SUM( music_store.invoice.total) as total from  music_store.customer
 JOIN 
 music_store.invoice ON music_store.customer.customer_id=music_store.invoice.customer_id
 group by music_store.customer.customer_id,music_store.customer.firstname,music_store.customer.lastname
 order by total desc
 limit 1;
 
 
--- Frantiek Wichterlov is the best customer

--- 6) Finding name,emailid and genre of all Rock Music listeners
SELECT firstname,lastname,email FROM music_store.customer 
JOIN music_store.invoice 
ON music_store.customer.customer_id=music_store.invoice.customer_id
JOIN  music_store.invoice_line ON music_store.invoice.invoice_id=music_store.invoice_line.invoice_id
WHERE track_id IN 
(
SELECT  track_id FROM music_store.track 
JOIN music_store.genre ON music_store.track.genre_id=music_store.genre.genre_id
WHERE music_store.genre.name LIKE 'Rock'
)
ORDER BY email;

--- 7) Finding total track count of top 10 rock bands and the artist name 

SELECT music_store.artist.artist_id,music_store.artist.name,COUNT(music_store.artist.artist_id) as total_songs FROM music_store.track
join music_store.album2 ON music_store.album2.album_id=music_store.track.album_id
join music_store.artist ON music_store.artist.artist_id=music_store.album2.artist_id
join  music_store.genre on music_store.genre.genre_id=music_store.track.genre_id
where  music_store.genre.name LIKE 'Rock'
GROUP BY music_store.artist.artist_id,music_store.artist.name
order by total_songs desc
limit 10;

--- 8) Finding the customer that have spent most on music along with the country thet belongs 

WITH CSE AS (
SELECT music_store.customer.firstname,music_store.customer.lastname,music_store.invoice.billing_country,
SUM(music_store.invoice.total)AS total,
ROW_NUMBER()OVER(PARTITION BY invoice.billing_country ORDER BY SUM(music_store.invoice.total) DESC) AS row_no
FROM invoice JOIN customer on customer.customer_id=invoice.customer_id
GROUP BY 1,2,3 
ORDER BY 5 DESC
)
 SELECT * FROM CSE WHERE row_no<=1;
 
 --- 9) Finding most popular music genre for each country 
 
WITH ASE AS (
 SELECT customer.country, COUNT(invoice_line.quantity) as total_pourchases,genre.name,genre.genre_id,
 ROW_NUMBER()OVER(PARTITION BY customer.country ORDER BY COUNT(invoice_line.quantity) DESC) AS row_num
 FROM invoice_line join invoice on invoice.invoice_id=invoice_line.invoice_id
 join customer on customer.customer_id=invoice.customer_id
 join track on track.track_id=invoice_line.track_id
 join genre on genre.genre_id=track.genre_id
 group by 1,3,4
 order by  1 asc,2 desc
)
select * from ASE where row_num<=1;