EAS150P1 ;ALB/SCK - PATCH EAS-50 POST UTILITIES ; 28-APR-2004
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**50,55**;Mar 15, 2004
 ;
 Q
QUE ;
 N EACY,%I,Y,DIR,DIRUT
 ;
 D NOW^%DTC S Y=%I(3) D DD^%DT S EACY=Y
 W !!
 S DIR(0)="F",DIR("B")=EACY,DIR("A")="Print UE Status Report for Calendar Year"
 S DIR("?",1)=""
 S DIR("?",2)="This report will display the User Enrollee Status information for all"
 S DIR("?",3)="patients with a Means Test Letter pending in the selected Calendar Year."
 S DIR("?")="Enter ""ALL"" for all entries."
 D ^DIR K DIR
 Q:$D(DIRUT)
 I +Y>0!(Y="ALL") S EACY=Y
 E  Q
 ;
 S ZTSAVE("DUZ")="",ZTSAVE("EACY")=""
 D EN^XUTMDEVQ("EN^EAS150P1","EAS UE STATUS REPORT",.ZTSAVE)
 ;
 Q
 ;
EN ; Entry point for UE Status report
 N EALIEN,EACNT,EAX,EADFN,EADFN1,EANAME,EAPTR,EAS60
 ;
 K ^TMP("EASUES",$J)
 K ^TMP("SCK",$J)
 F EAX=0,1,2 S EACNT(EAX)=0
 S EALIEN=0
 F  S EALIEN=$O(^EAS(713.2,EALIEN)) Q:'EALIEN  D
 . Q:$D(^EAS(713.2,"AC",1,EALIEN))  ; Quit if MT has been returned
 . S EAPTR=$$GET1^DIQ(713.2,EALIEN,2,"I") ; Get pointer to file #713.1
 . Q:$D(^EAS(713.1,"AP",1,EAPTR))  ; Quit if Prohibit Flag is set for patch
 . ; If EACY is not "ALL" then check Calendar year for 60 day letter.  
 . ; Quit if letter date is not in the selected CY
 . S EAS60=$$GET1^DIQ(713.2,EALIEN,8,"I")
 . S Y=$E(EAS60,1,3) D DD^%DT S EAS60=Y
 . I +EACY>0 Q:EAS60'=EACY 
 . Q:$$DECEASED^EASMTUTL(EALIEN)  ; Quit if patient is deceased
 . S EADFN1=$$GET1^DIQ(713.2,EALIEN,2,"I")
 . S EADFN=$$GET1^DIQ(713.1,EADFN1,.01,"I")
 . S EANAME=$$GET1^DIQ(2,EADFN,.01)
 . S ^TMP("EASUES",$J,$S(EANAME]"":EANAME,1:"UNKNOWN"),EADFN)=EALIEN_U_EAS60
 D REPORT
 Q
 ;
REPORT ;
 N EANAME,EADFN,PAGE,EASABRT
 ;
 S (EASABRT,PAGE)=0
 D HDR
 ;
 S EANAME=""
 F  S EANAME=$O(^TMP("EASUES",$J,EANAME)) Q:EANAME']""  D  Q:$G(EASABRT)
 . S EADFN=0
 . F  S EADFN=$O(^TMP("EASUES",$J,EANAME,EADFN)) Q:'EADFN  D
 . . D LINE(EANAME,EADFN,$P($G(^TMP("EASUES",$J,EANAME,EADFN)),U,2))
 . . I ($Y+6)>IOSL D HDR  Q:$G(EASABRT)
 ;
 I '$G(EASABRT) D
 . N XX F XX=$Y:1:IOSL-6 W !
 . D FTR
 Q:$G(EASABRT)
 I $E(IOST,1,2)="C-" D  Q:$D(DIRUT)!('Y)
 . S DIR(0)="E" D ^DIR K DIR
 D SUMMARY
 ;
 Q
 ;
LINE(EANAME,DFN,EAS60) ;
 N EAUES,VA
 ;
 S EAUES=$$UESTAT^EASUER(DFN)
 S EACNT(EAUES)=EACNT(EAUES)+1
 D PID^VADPT6
 W !,$E(EANAME,1,25),?28,VA("BID")
 W ?35,$$GET1^DIQ(2,EADFN,.3617)
 W ?42,$S(EAUES=1:"UE",EAUES=0:"Not UE",EAUES=2:"Diff. Site",1:"")
 W ?54,$E($$GET1^DIQ(2,EADFN,.3618),1,18),?74,EAS60
 Q
 ;
SUMMARY ;
 N DDASH
 ;
 W @IOF
 W !,"User Enrollee Status Summary for Pending Means Test Letters"
 W !,"Print Date: ",$$FMTE^XLFDT(DT)
 S $P(DDASH,"=",IOM)="" W !,DDASH,!
 W !?4,"Patients with User Enrollee Status at this site:              ",$FN(EACNT(1),",")
 W !!?4,"Patients which DO NOT have User Enrollee Status at this site: ",$FN(EACNT(2),",")
 W !!?4,"Patients which do not have User Enrollee Status:              ",$FN(EACNT(0),",")
 W !!?4,"Total Patients Reviewed:                                      ",$FN(EACNT(0)+EACNT(1)+EACNT(2),",")
 Q
 ;
HDR ;
 N DDASH,EASITE,EAPRNT
 ;
 I PAGE>0,$E(IOST,1,2)="C-" D  Q:$G(EASABRT)
 . S DIR(0)="E"
 . D ^DIR K DIR
 . I 'Y S EASABRT=1
 ;
 S EASITE=$$SITE^VASITE,EAPRNT=$$PSITE^EASUER($P(EASITE,U,3))
 W @IOF
 S PAGE=PAGE+1
 W !,"User Enrollee Status for Pending Means Test Letters"
 W !,"Calendar Year for MT Letters to Print: ",EACY
 W !,"Print Date: ",$$FMTE^XLFDT(DT)
 W !,"Page: ",PAGE
 W !!,"Current Site: ",$P(EASITE,U,2),"  Current Station#: ",$P(EASITE,U,3)
 W !,"Administrative Parent for ",$P(EASITE,U,2)," is ",$$GET1^DIQ(4,EAPRNT,.01)
 W !!,"Name",?28,"LAST4",?35,"UE-FY",?42,"UE Status",?54,"UE Site",?74,"LT-CY"
 ;
 S $P(DDASH,"=",IOM)="" W !,DDASH
 W !
 Q
 ;
FTR ;
 I $E(IOST,1,2)'="C-" D
 . W !?5,"UE         -User Enrollee Status at Site "
 . W !?5,"Not UE     -User is not a User Enrollee"
 . W !?5,"Diff. Site -User Enrollee Status, but at Another Site."
 Q
