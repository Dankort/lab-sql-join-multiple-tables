use sakila;

-- 1. Write a query to display for each store, the store ID, city, and country.

select
    s.store_id,
    ci.city,
    co.country
from
    store s
join
    address a on s.address_id = a.address_id
join
    city ci on a.city_id = ci.city_id
join
    country co on ci.country_id = co.country_id;
    
-- 2 Write a query to display how much business, in dollars, each store brought in.

select
    s.store_id,
    SUM(p.amount) as total_sales
from
    store s
join
    staff st on s.manager_staff_id = st.staff_id
join
    payment p on st.staff_id = p.staff_id
group by
    s.store_id;
    
-- 3. What is the average running time of films by category?

select
    c.name as category_name,
    AVG(f.length) as average_running_time
from
    film f
join
    film_category fc on f.film_id = fc.film_id
join
    category c on fc.category_id = c.category_id
group by
    c.name;
    
-- 4. Which film categories are longest?

select
    c.name as category_name,
    avg(f.length) as average_length
from
    film f
join
    film_category fc on f.film_id = fc.film_id
join
    category c on fc.category_id = c.category_id
group by
    c.name
order by
    average_length desc;
    
-- 5. Display the most frequently rented movies in descending order.

select
    f.title as film_title,
    COUNT(r.rental_id) as rental_count
from
    film f
join
    inventory i on f.film_id = i.film_id
join
    rental r on i.inventory_id = r.inventory_id
group by
    f.film_id, f.title
order by
    rental_count desc;
    
-- 6. List the top five genres in gross revenue in descending order.

select
    c.name as genre,
    SUM(p.amount) as gross_revenue
from
    category c
join
    film_category fc on c.category_id = fc.category_id
join
    inventory i on fc.film_id = i.film_id
join
    rental r on i.inventory_id = r.inventory_id
join
    payment p on r.rental_id = p.rental_id
group by
    c.category_id
order by
    gross_revenue desc
limit 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?

select
    f.title as film_title,
    s.store_id,
    case
        when COUNT(r.rental_id) > 0 then 'Available'
        else 'Not Available'
    end as availability_status
from
    film f
join
    inventory i on f.film_id = i.film_id
join
    rental r on i.inventory_id = r.inventory_id
join
    store s on i.store_id = s.store_id
where
    f.title = 'Academy Dinosaur'
    and s.store_id = 1
group by
    f.title, s.store_id;







    
