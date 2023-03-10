ORY599 ;SLC/JLC - MAKE INDICATIONS NOT REQUIRED;Dec 13, 2022
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**599**;Dec 17, 1997;Build 2
 Q
POST ;
 N ORDGIEN,ORPIEN,ORDGITEM
 S ORDGIEN=$O(^ORD(101.41,"B","PSO OERR",""))
 S ORPIEN=$O(^ORD(101.41,"B","OR GTX INDICATION",""))
 I ORDGIEN=""!(ORPIEN="") D MES^XPDUTL("Problem with Outpatient order dialog. Please enter a YourIT ticket for assistance.")
 S ORDGITEM=$O(^ORD(101.41,ORDGIEN,10,"D",ORPIEN,""))
 I ORDGITEM="" D MES^XPDUTL("Indication not on the Outpatient order dialog. Please enter a YourIT ticket for assistance.")
 S $P(^ORD(101.41,ORDGIEN,10,ORDGITEM,0),"^",6)=0
 D MES^XPDUTL("Indication set to not required.")
 Q
