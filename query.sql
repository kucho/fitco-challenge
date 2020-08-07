SET @from := '2000-01-01';
SET @to := CURDATE();

# V1 - Considerando que las membresías recurrentes son las que tienen el tipo de pago subscripción
SELECT *
FROM (
         SELECT ROUND(SUM(amount), 2) as sales, ROUND(SUM(unpaid), 2) as unpaid
         FROM memberships as m
                  INNER JOIN invoice_membership as im ON im.membershipId = m.id
                  INNER JOIN payment_invoice_membership as pim ON pim.invoiceMembershipId = m.id
         WHERE typePayment = '1'
           and m.startDate >= @from
           and m.endDate <= @to) as data
         JOIN (SELECT COUNT(*) as total_active_users
               FROM memberships
               WHERE typePayment = '1'
                 and startDate >= @from
                 and endDate <= @to
) as users;

# V2 - Considerando que las membresías recurrentes son las que llevan el nombre de recurrente
SELECT *
FROM (
         SELECT ROUND(SUM(amount), 2) as sales, ROUND(SUM(unpaid), 2) as unpaid
         FROM memberships as m
                  INNER JOIN plans ON m.planId = plans.id
                  INNER JOIN payment_invoice_membership as pim on plans.id = pim.invoiceMembershipId
         WHERE name LIKE 'Recurrente'
           and m.startDate >= @from
           and m.endDate <= @to
     ) as data
         JOIN (SELECT COUNT(*) as total_active_users
               FROM memberships as m
                        INNER JOIN plans as p on m.planId = p.id
               WHERE p.name like 'Recurrente'
                 and m.startDate >= @from
                 and m.endDate <= @to) as users;

