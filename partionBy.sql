select t.package ,t.mobile_no 
     from (SELECT pos.service_pak_code as package, pos.mobile_no 
      FROM (SELECT a.service_pak_code, a.mobile_no, 
        RANK() OVER(PARTITION by a.mobile_no  ORDER BY a.subscribed_date DESC) row_num
        FROM pre_pack_tb a 
        where a.terminated_date is null ) pos WHERE pos.row_num = 1
         
         UNION ALL 
            SELECT pre.service_pak_code as package, pre.mobile_no 
            FROM (SELECT a.service_pak_code,a.mobile_no, 
            RANK() OVER(PARTITION by a.mobile_no ORDER BY a.subscribed_date DESC) row_num
            FROM pos_pack_tb a
             where a.terminated_date is null  ) pre WHERE pre.row_num =1 ) t 