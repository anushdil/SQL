WITH G1 as (SELECT tb1.mobile_no,tb2.sales_account_type,tb1.connected_date
             FROM tb1,tb2
             WHERE tb1.connected_date >= '2023-02-01'
             AND   tb1.connected_date <='2023-02-28'
             AND   tb1.debit_led_acc_code=tb2.ledger_acc_code ) ,
	
G2  as (select G1.mobile_no ,min(tb1.connected_date)	 as min_date
from G1 JOIN tb1
on G1.mobile_no =tb1.mobile_no
group by G1.mobile_no ) ,

G3 as (select G1.* from G1 INNER JOIN G2
ON G1.mobile_no =G2.mobile_no
where G2.min_date>='2023-02-01'),
							  
G4 as( SELECT tb3.acc_mangr_name,tb4.location_code
       FROM   tb3,tb4
        WHERE  tb4.acc_mangr_code = tb3.acc_mangr_code
        AND tb4.terminated_on IS NULL 
        AND (tb3.valid_untill IS NULL OR tb3.valid_untill > TODAY)
        ORDER BY tb3.acc_mangr_name)  ,

G5 as ( select x.* , tb6.voice from tb6 join 
(select G3.*,tb5.service_pak_code
from G3 left join tb5
on G3.mobile_no=tb5.mobile_no
where tb5.terminated_date IS NULL )  x
ON tb6.service_pak_code=x.service_pak_code  ) ,

G6 as (select G5.* ,G4.acc_mangr_name ,G4.location_code
from G5 left join G4
ON G5.sales_code=G4.acc_mangr_code)

select G6.acc_mangr_name, G6.location_code,G6.sales_account_type, count(G6.mobile_no)
from G6
group by G6.acc_mangr_name,G6.location_code,G6.sales_account_type






							  
                      
                      
    			  
