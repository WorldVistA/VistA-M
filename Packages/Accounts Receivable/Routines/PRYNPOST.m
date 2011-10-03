PRYNPOST ;Washington ISC@Altoona,Pa/TJK-SETS FILE 433 "CA" X-REF ;10/19/95  12:23 PM [ 10/25/95   7:10 AM ]
V ;;4.5;Accounts Receivable;**23**;Mar 20, 1995
 N RCI,TRTYP
 W !,"STARTING POST-INIT"
 W !,"SETTING CA X-REF IN FILE 433"
 S RCI=0 F  S RCI=$O(^PRCA(433,RCI)) Q:RCI'?1N.N  D
    .S TRTYP=$P($G(^PRCA(433,RCI,1)),U,2)
    .I TRTYP=35,$P($G(^PRCA(433,RCI,8)),U,8) D
       ..S ^PRCA(433,"CA",RCI)=""
       ..W "."
       ..Q
    .Q
 W !,"CA X-REF SET"
 S ^PRCA(433,"CA",0)=""
 W !,"POST-INIT COMPLETED"
 Q
