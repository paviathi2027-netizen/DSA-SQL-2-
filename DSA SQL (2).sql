SELECT u.city,count(t.order_id) as total_orders from trades t 
INNER JOIN users u on t.user_id=u.user_id
where status= 'Completed'
GROUP BY u.city 
ORDER BY count(t.order_id) desc limit 3;

SELECT product_id,
EXTRACT(MONTH from submit_date) as mth,
round(avg(stars),2) as avg_stars from reviews
GROUP BY product_id,EXTRACT(MONTH from submit_date)
ORDER BY mth asc , product_id asc;

#SELF-Join: comparision between the manager salary and the employee salary
select
mrg.employee_id as manager_id,
mrg.name as manager_name,
mrg.salary as manager_salary,
emp.employee_id as emp_id,
emp.name as emp_name,
emp.salary as emp_salary
from employee as mrg -- Represents the manager's table
Inner Join employee as emp  -- Represent the employee's table
ON mrg.employee_id = emp.manager_id -- mrg.employee_id is mrg_id in mrg table 
where emp.salary > mrg.salary;	        -- & emp.manager_id is manager_id in employee's table

# identify all employees who earn more than their direct managers
select
emp.employee_id as emp_id,
emp.name as emp_name
from employee as mrg
Inner Join employee as emp 
ON mrg.employee_id = emp.manager_id
where emp.salary > mrg.salary;

# Group the users by the number of tweets they posted in 2022 
# and count the number of users in each group.

with total_tweet as (SELECT
user_id,
count(tweet_id) as tweet_count_per_user
from tweets
where tweet_date BETWEEN '2022-01-01' and '2022-12-31'
GROUP BY user_id)

select tweet_count_per_user as tweet_bucket,
count(user_id) as user_num
from total_tweet
GROUP BY tweet_count_per_user;