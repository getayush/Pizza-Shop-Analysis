-- Answering Questions
-- 1) Find Total orders
-- 2) Find Total sales
-- 3) Find Total items
-- 4) Find Average order value
-- 5) Find Sales by category
-- 6) Find Top selling items
-- 7) Find Orders by hour
-- 8) Find Sales by hour
-- 9) Find Orders by address
-- 10) Find Orders by delivery/pick up

select
o.order_id,
i.item_price,
o.quantity,
i.item_category,
i.item_name,
o.created_at,
a.delivery_address1,
a.delivery_address2,
a.delivery_city,
a.delivery_zipcode,
o.delivery

FROM orders o
LEFT JOIN item i on o.item_id = i.item_id
LEFT JOIN address a on o.address_id = a.address_id


 -- Answering the following
 -- 1) Total quantity by ingredient
 -- 2) Total cost of ingredients
 -- 3) Calculated cost of pizza
 -- 4) Percentage stock remaining by ingredient
SELECT 
S1.item_name,
S1.ing_id,
S1.ing_name,
S1.ing_weight,
S1.ing_price,
S1.order_quantity,
S1.recipe_quantity,
S1.order_quantity * S1.recipe_quantity as ordered_weight,
S1.ing_price/S1.ing_weight as unit_cost,
(S1.order_quantity * S1.recipe_quantity) * (S1.ing_price/S1.ing_weight) as ingredient_cost
FROM (
  SELECT 
    o.item_id, 
    i.sku,
    i.item_name,
    r.ing_id,
    ing.ing_name,
    r.quantity as recipe_quantity,
    SUM(o.quantity) as order_quantity, -- Missing comma added here
    ing.ing_weight,
    ing.ing_price
  FROM orders o
  LEFT JOIN item i ON o.item_id = i.item_id
  LEFT JOIN recipe r ON i.sku = r.recipe_id
  LEFT JOIN ingredient ing ON ing.ing_id = r.ing_id
  GROUP BY 
    o.item_id, 
    i.sku, 
    i.item_name,
    r.ing_id,
    r.quantity,
    ing.ing_name,
    ing.ing_weight,
    ing.ing_price
) S1

Go
create view stock1 AS
SELECT 
S1.item_name,
S1.ing_id,
S1.ing_name,
S1.ing_weight,
S1.ing_price,
S1.order_quantity,
S1.recipe_quantity,
S1.order_quantity * S1.recipe_quantity as ordered_weight,
S1.ing_price/S1.ing_weight as unit_cost,
(S1.order_quantity * S1.recipe_quantity) * (S1.ing_price/S1.ing_weight) as ingredient_cost
FROM (
  SELECT 
    o.item_id, 
    i.sku,
    i.item_name,
    r.ing_id,
    ing.ing_name,
    r.quantity as recipe_quantity,
    SUM(o.quantity) as order_quantity, -- Missing comma added here
    ing.ing_weight,
    ing.ing_price
  FROM orders o
  LEFT JOIN item i ON o.item_id = i.item_id
  LEFT JOIN recipe r ON i.sku = r.recipe_id
  LEFT JOIN ingredient ing ON ing.ing_id = r.ing_id
  GROUP BY 
    o.item_id, 
    i.sku, 
    i.item_name,
    r.ing_id,
    r.quantity,
    ing.ing_name,
    ing.ing_weight,
    ing.ing_price
) S1
Go


select 
 S2.ing_name,
 S2.ordered_weight, 
 ing.ing_weight * inv.quantity as total_inv_weight
from (select
 ing_id,
 ing_name, 
 sum(ordered_weight) as ordered_weight
from 
 stock1
 group by ing_name, ing_id) S2

left join inventory inv on inv.item_id = S2.ing_id
left join ingredient ing on ing.ing_id = S2.ing_id


SELECT
  r.date,
  s.first_name,
  s.last_name,
  s.hourly_rate,
  sh.start_time,
  sh.end_time,
  -- Calculate the difference in hours including minutes
  (DATEDIFF(minute, sh.start_time, sh.end_time) / 60.0) AS hours_in_shift,
  -- Calculate the cost by multiplying hourly rate by hours worked (as a decimal)
  (DATEDIFF(minute, sh.start_time, sh.end_time) / 60.0) * s.hourly_rate AS staff_cost
FROM rota r
LEFT JOIN staff s ON r.staff_id = s.staff_id
LEFT JOIN shift sh ON r.shift_id = sh.shift_id;




















