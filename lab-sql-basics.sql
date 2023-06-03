-- Get the id values of the first 5 clients from district_id with a value equals to 1.

select client_id
from client
where district_id = 1
limit 5;

-- In the client table, get an id value of the last client where the district_id equals to 72.

select max(client_id) as Last_client 
from client
where district_id = 72;

-- Get the 3 lowest amounts in the loan table.

select amount
from loan
Order by amount ASC
limit 3;

-- What are the possible values for status, ordered alphabetically in ascending order in the loan table?

select distinct(status)
from loan
Order by status ASC;

-- What is the loan_id of the highest payment received in the loan table?

select loan_id
from loan
where payments = (SELECT MAX(payments) FROM loan);

-- What is the loan amount of the lowest 5 account_ids in the loan table? Show the account_id and the corresponding amount

select account_id, amount
from loan
order by account_id ASC
limit 5;

-- What are the account_ids with the lowest loan amount that have a loan duration of 60 in the loan table?

select account_id
from loan
where duration = 60 
Order by amount asc
limit 5;

-- What are the unique values of k_symbol in the order table?

select distinct(k_symbol)
from `order`;

-- In the order table, what are the order_ids of the client with the account_id 34?

select order_id, account_id
from `order`
where account_id = 34
order by order_id;

-- In the order table, which account_ids were responsible for orders between order_id 29540 and order_id 29560 (inclusive)?

select distinct(account_id)
from `order`
where order_id between 29540 and 29560
group by account_id;

-- In the order table, what are the individual amounts that were sent to (account_to) id 30067122?

select amount
from `order`
where account_to = 30067122;

-- In the trans table, show the trans_id, date, type and amount of the 10 first transactions from account_id 793 in chronological order, from newest to oldest.

select trans_id, date, type, amount
from trans
where account_id = 793
Order by date desc
Limit 10;

-- In the client table, of all districts with a district_id lower than 10, how many clients are from each district_id? Show the results sorted by the district_id in ascending order.

select district_id, COUNT(client_id)
from client
where district_id < 10
Group by district_id
Order by district_id asc;

-- In the card table, how many cards exist for each type? Rank the result starting with the most frequent type

select type, COUNT(card_id)
from card
group by type;

-- Using the loan table, print the top 10 account_ids based on the sum of all of their loan amounts.

select amount, account_id
from loan
where account_id = max(amount)
limit 10;

-- In the loan table, retrieve the number of loans issued for each day, before (excl) 930907, ordered by date in descending order.

select COUNT(loan_id), date  
from loan
where date < 930907
group by date
Order by date desc;

-- In the loan table, for each day in December 1997, count the number of loans issued for each unique loan duration, ordered by date and duration, both in ascending order. You can ignore days without any loans in your output.

select distinct duration, loan_id, date
from loan 
where date like '%9712%' 
order by date and duration;

-- In the trans table, for account_id 396, sum the amount of transactions for each type (VYDAJ = Outgoing, PRIJEM = Incoming). Your output should have the account_id, the type and the sum of amount, named as total_amount. Sort alphabetically by type.

SELECT sum(amount) as total_trans, type, account_id 
FROM trans
where account_id = 396
GROUP BY type 
having type IN ('VYDAJ', 'PRIJEM')
ORDER BY type;

-- From the previous output, translate the values for type to English, rename the column to transaction_type, round total_amount down to an integer

SELECT round(sum(amount), 0) as total_trans, type, account_id,
case when type = 'VYDAJ' then 'outgoing' 
when type = 'PRIJEM' then 'incoming'
else null
end as transaction_type
from trans
where account_id = 396
GROUP BY type 
having type IN ('VYDAJ','PRIJEM')
ORDER BY type;

-- From the previous result, modify your query so that it returns only one row, with a column for incoming amount, outgoing amount and the difference.

select total_trans_a-total_trans_b as Grand_total, a.account_id, total_trans_a, total_trans_b from (SELECT round(sum(amount), 0) as total_trans_a, account_id
from trans  
where type = 'VYDAJ' and account_id = 396) as a 
join
(SELECT round(sum(amount), 0) as total_trans_b, account_id
from trans 
where type = 'PRIJEM' and account_id = 396) as b
on a.account_id = b.account_id; 

-- Continuing with the previous example, rank the top 10 account_ids based on their difference.

-- I give up:(


