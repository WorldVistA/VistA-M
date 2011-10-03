ORY268 ;SLC/JEH -- post-install for OR*3*268 ;12/14/2005
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**268**;Dec 17, 1997;Build 6
 ;
EN1 ; 
 I $G(DUZ)="" W "Your DUZ is not defined.",! Q
 N ZTDESC,ZTIO,ZTRTN,ZTSK,ZTSAVE,ZTREQ,ZTQUEUED,XMDUZ,XMSUB,XMTEXT
TASK S ZTRTN="EN^ORY268",ZTIO=""
 S ZTDESC="Update Alert Names in OE/RR NOTIFICATIONS File (#100.9)"
 D ^%ZTLOAD
 W !!,"The update of alert names is",$S($D(ZTSK):"",1:" NOT")," queued",!
 I $D(ZTSK) W " (to start NOW).",!!,"YOU WILL RECEIVE A MAILMAN MESSAGE WHEN TASK #"_ZTSK_" HAS COMPLETED."
 Q
 ;
EN ; -- tasked entry point
 K ORMSG,XMY N FDA
 S XMDUZ="CPRS, SEARCH",XMSUB="OE/RR NOTIFICATIONS ALERT NAME UPDATES",XMTEXT="ORMSG(",XMY(DUZ)=""
 S:$D(ZTQUEUED) ZTREQ="@"
 I $P(^ORD(100.9,22,0),"^",1)="IMAGING RESULTS"  D
 . S FDA(100.9,"22,",.01)="IMAGING RESULTS, NON CRITICAL",FDA(100.9,"22,",.03)="Imaging Results, Non Critical."
 . D FILE^DIE("","FDA")
 I $P(^ORD(100.9,25,0),"^",1)="ABNORMAL IMAGING RESULTS"  D
 . S FDA(100.9,"25,",.01)="ABNL IMAGING RESLT, NEEDS ATTN",FDA(100.9,"25,",.03)="Abnl Imaging Reslt, Needs Attn."
 . D FILE^DIE("","FDA")
 S ORMSG(1)="Alert Names in OE/RR NOTIFICATIONS File (#100.9) updated. Please verify."
 S ORMSG(2)=" "
 D ^XMD
 Q
