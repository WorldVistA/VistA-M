PXCA ;ISL/dee & LEA/Chylton - Main entry points to PCE Device Interface Module ;12/17/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**5,14**;Aug 12, 1996
 Q
 ;
 ;----------------------------- FOREGROUND ---------------------------
FOREGND(PXCA,PXCASTAT,PXCAVSIT) ;            Invoke the event point in the foreground
 ;                                              if there are no errors
 S PXCASTAT=0 ;             assume that event processing did not occur
 D EN^PXCA0
 I '$D(PXCA("ERROR")),PXCASTAT=0 S PXCASTAT=1 ; there were no errors so report that
 ;                                           event processing occurred
 I PXCASTAT>0!(PXCASTAT<-1) D EVENT ;        Let the rest of the world look at the array
 ;                                             if there are now errors
 Q
 ;
 ;----------------------------- BACKGROUND ---------------------------
BACKGND(PXCA,PXCASTAT,PXCAVSIT) ;            Invoke the event point in the background
 D VALIDATE(.PXCA) ;     Verfify minimal data set is present and valid
 S PXCASTAT=0 ;             assume that event processing did not occur
 Q:$D(PXCA("ERROR"))  ;                   data did not pass validation
 S ZTRTN="TASKED^PXCA",ZTDESC="PCE Device Interface Module"
 S ZTDTH=$H,ZTIO=""
 I $G(DUZ)'>0 S DUZ=$P(PXCA("SOURCE"),"^",2)
 I $G(DUZ)'>0 S DUZ=.5
 I $D(DUZ("AG"))#2'=1 S DUZ("AG")="V"
 S ZTSAVE("DUZ")=DUZ,ZTSAVE("DUZ(")=""
 S ZTSAVE("PXCA(")=""
 D ^%ZTLOAD
 K ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 I $D(ZTSK) S PXCASTAT=1 ;       report that event processing occurred
 E  S PXCASTAT=0,PXCA("ERROR","ENCOUNTER",0,0,0)="Tasking of job failed."
 Q
 ;
 ;------------------------------- TASKED -----------------------------
 ;                processing of event point was off-loaded to the host
TASKED ;                                              called by BACKGND only
 N DIC
 K DTOUT,DIROUT,X
 S PXCASTAT=0 ; assume that event processing did not occur (for debug)
 D EN^PXCA0
 K DTOUT,DIC,DIROUT,X
 S:'$D(PXCA("ERROR")) PXCASTAT=1 ; there were no errors so report that
 ;                               event processing occurred (for debug)
 D EVENT ;                 Let the rest of the world look at the array
 Q
 ;
 ;----------------------------- VALIDATED ----------------------------
VALIDATE(PXCA,PXCAVSIT) ;
 D PROCESS^PXCA0(.PXCA,0,0)
 Q
 ;
 ;---------------------------- EVENT POINT ---------------------------
EVENT ;
 S X=+$O(^ORD(101,"B","PXCA DATA EVENT",0))_";ORD(101,"
 D:+X>0 EN^XQOR
 Q
 ;
