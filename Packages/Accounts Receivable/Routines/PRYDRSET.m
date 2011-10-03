PRYDRSET ;Washington ISC@Altoona,Pa/TJK-Deletes Data In File 347.2 ;7/3/95  10:24 AM
V ;;4.5;Accounts Receivable;**4**;Mar 20, 1995
 N REC
 W !,"RE-SETTING AMOUNT FIELDS IN 348.1 TO ZERO"
 S REC=0
 F  S REC=$O(^RC(348.1,REC)) Q:REC'?1N.N  S $P(^(REC,0),U,7,12)="0^0^0^0^0^0"
 W !,"DONE" Q
