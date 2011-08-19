LROCM ;SLC/FHS - WARNING MESSAGE ORDER LIST CLEAN-UP ;8/8/89  07:48
 ;;5.2;LAB SERVICE;;Sep 27, 1994
EN ;
 S LRPD=$S($P(^LAB(69.9,1,0),U,9):$P(^(0),U,9),1:7),%DT="",X="T-"_LRPD D ^%DT,ADD^LRX S LRPDATE=Y
 ;W !!?7,"This option will purge Orders OLDER than '",LRPDATE,"'",!," from the Accession File 68 #",!," There are  ",LRPD," days set for 'GRACE PERIOD FOR ORDERS' in file #69.9 ",!
 W !!?7,"This Option will not purge the last ",LRPD," days of ORDERS/ACCESSIONS",!
 W "As defined by the 'GRACE PERIOD FOR ORDER' field in file #69.9 "
 W !!?10,"Orders/Accession OLDER than ",LRPDATE," will be PURGED",!
 K LRPD,LRPDATE,%DT Q
