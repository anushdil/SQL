select mangr_name, location_code, 
count(CASE WHEN sales_account_type='01' and voice='Y' THEN mobile_no END ) as type_A,
count(CASE WHEN sales_account_type='02'  and voice='Y' THEN mobile_no END ) as type_B,
count(CASE WHEN sales_account_type='06'  and voice='Y' THEN mobile_no END ) as type_C,
count(CASE WHEN sales_account_type='02'  and voice='N' THEN mobile_no END ) as type_D,
from product_det  
group by mangr_name,location_code   
order by mangr_name,location_code asc
