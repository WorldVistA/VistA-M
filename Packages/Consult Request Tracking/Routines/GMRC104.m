GMRC104 ;SLC/GDU - FILE 123.5 CLEAN UP ;08/09/18 ; 10/4/18 5:06pm
 ;;3.0;CONSULT/REQUEST TRACKING;**104**;Aug 13, 2018;Build 9
 ;This routine is to:
 ;Locate orphan APC Index records, back them up to ^XTEMP, delete them
 ;
 ;Routine variables:
 ;GMRCC=Child Service IEN
 ;GMRCD=Child Service Data
 ;GMRCP=Parent Service IEN
 ;GMRCE=Entry in Parent Sub-service multiple
 ;%,%H,%I,X,X1,X2 = Variables used by ^%DTC
 ;^XTMP("GMRC104"=Stores orphan APC index records
 ;DTCREATE=Date ^XTMP("GMRC104" is created, date run
 ;DTPURGE=Date ^XTMP("GMRC104" to be purged, date run plus 90 days
 ;U="^" Field delimiter, set during log in
 ;
 ;Integrations Agreements Used
 ;IA # 10000   C^%DTC, NOW^%DTC
 Q
EN1 ;READING THE APC INDEX OF FILE 123.5
 N GMRCC,GMRCD,GMRCP,GMRCE
 N %,%H,%I,X,X1,X2,DTCREATE,DTPURGE
 D NOW^%DTC S (DTCREATE,X1)=X,X2=90
 D C^%DTC S DTPURGE=X
 S ^XTMP("GMRC104",0)=DTPURGE_U_DTCREATE_U_"ORPHAN APC INDEX RECORDS"
 S GMRCC=0
 F  S GMRCC=$O(^GMR(123.5,"APC",GMRCC)) Q:'+GMRCC  D
 . S GMRCP=0
 . F  S GMRCP=$O(^GMR(123.5,"APC",GMRCC,GMRCP)) Q:'+GMRCP  D
 .. S GMRCE=0
 .. F  S GMRCE=$O(^GMR(123.5,"APC",GMRCC,GMRCP,GMRCE)) Q:'+GMRCE  D
 ... I $L($G(^GMR(123.5,GMRCP,10,GMRCE,0))) Q
 ... S ^XTMP("GMRC104","APC",GMRCC,GMRCP,GMRCE)=""
 ... K ^GMR(123.5,"APC",GMRCC,GMRCP,GMRCE)
 Q
