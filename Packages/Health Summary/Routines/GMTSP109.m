GMTSP109 ;MWA/VMP - install routine for GMTS*2.7*109 ; 5/23/13 2:35pm
 ;;2.7;Health Summary;**109**;;Build 4
 Q  ; should not be run from anywhere but entry 
 ; 
EN ; main entry point
 N X,MSGCNT,GMTSMSG S MSGCNT=4
 S X=$O(^GMT(142,"B","REMOTE CLINICAL DATA (1Y)",0)) I $D(^GMT(142,X)) D SET(X,"Remote Clinical Data (1y)")
 S X=$O(^GMT(142,"B","REMOTE CLINICAL DATA (3M)",0)) I $D(^GMT(142,X)) D SET(X,"Remote Clinical Data (3m)")
 S X=$O(^GMT(142,"B","REMOTE CLINICAL DATA (4Y)",0)) I $D(^GMT(142,X)) D SET(X,"Remote Clinical Data (4y)")
 S X=$O(^GMT(142,"B","REMOTE DEMO/VISITS/PCE (1Y)",0)) I $D(^GMT(142,X)) D SET(X,"Remote Demo/Visits/PCE (1y)")
 S X=$O(^GMT(142,"B","REMOTE DEMO/VISITS/PCE (3M)",0)) I $D(^GMT(142,X)) D SET(X,"Remote Demo/Visits/PCE (3m)")
 S X=$O(^GMT(142,"B","REMOTE DIS SUM/SURG/PROD (12Y)",0)) I $D(^GMT(142,X)) D SET(X,"Remote Dis Sum/Surg/Prod (12y)")
 S X=$O(^GMT(142,"B","REMOTE LABS ALL (1Y)",0)) I $D(^GMT(142,X)) D SET(X,"Remote Labs All (1y)")
 S X=$O(^GMT(142,"B","REMOTE LABS ALL (3M)",0)) I $D(^GMT(142,X)) D SET(X,"Remote Labs All (3m)")
 S X=$O(^GMT(142,"B","REMOTE LABS LONG VIEW (12Y)",0)) I $D(^GMT(142,X)) D SET(X,"Remote Labs Long View (12y)")
 S X=$O(^GMT(142,"B","REMOTE MEDS/LABS/ORDERS (1Y)",0)) I $D(^GMT(142,X)) D SET(X,"Remote Meds/Labs/Orders (1y)")
 S X=$O(^GMT(142,"B","REMOTE MEDS/LABS/ORDERS (3M)",0)) I $D(^GMT(142,X)) D SET(X,"Remote Meds/Labs/Orders (3m)")
 S X=$O(^GMT(142,"B","REMOTE MH HIGH RISK PATIENT",0)) I $D(^GMT(142,X)) D SET(X,"Remote MH High Risk Patient")
 S X=$O(^GMT(142,"B","REMOTE ONCOLOGY VIEW",0)) I $D(^GMT(142,X)) D SET(X,"Remote Oncology View")
 S X=$O(^GMT(142,"B","REMOTE TEXT REPORTS (1Y)",0)) I $D(^GMT(142,X)) D SET(X,"Remote Text Reports (1y)")
 S X=$O(^GMT(142,"B","REMOTE TEXT REPORTS (3M)",0)) I $D(^GMT(142,X)) D SET(X,"Remote Text Reports (3m)")
 D SENDMAIL
 Q
SET(GMTSIEN,NWTXT) ;sets the title to the new value and creates mail string
 N DIE,DA,DR,OLDTXT S DIE="^GMT(142,",DA=GMTSIEN,DR=".02////"_NWTXT
 S OLDTXT=$P($G(^GMT(142,GMTSIEN,"T")),U,1)
 D ^DIE
 S GMTSMSG(MSGCNT)=$P($G(^GMT(142,GMTSIEN,0)),U,1)_" (IEN #"_GMTSIEN_")",MSGCNT=MSGCNT+1
 S GMTSMSG(MSGCNT)="FROM: "_OLDTXT_" TO: "_NWTXT,MSGCNT=MSGCNT+1
 S GMTSMSG(MSGCNT)=" ",MSGCNT=MSGCNT+1
 Q
 ;
SENDMAIL ; sends mailman message to inform that routine has run
 N XMSUB,XMDUZ,XMTEXT,XMY,DIFROM
 S GMTSMSG(1)="GMTS*2.7*109 install routine has completed"
 S GMTSMSG(2)="The TITLES for the following HEALTH SUMMARY TYPES have been changed"
 S GMTSMSG(3)=" "
 I '$D(GMTSMSG(4)) S GMTSMSG(4)="No changes"
 S XMSUB="GMTS*2.7*109 install routine has completed"
 S XMDUZ="HEALTH SUMMARY PACKAGE"
 S XMTEXT="GMTSMSG("
 S XMY(DUZ)=""
 D ^XMD
 Q
