PSO7P341 ;BAY PINES-CIOFO/TN - Patch 341 Post Install routine;9/9/09 5:06pm ; 10/22/09 10:50am
 ;;7.0;OUTPATIENT PHARMACY;**341**;DEC 1997;Build 8
 ;
 NEW ZTIO,ZTRTN,ZTDESC
 S ZTIO="",ZTRTN="START^PSO7P341",ZTDESC="PSO*7*341 post-int process"
 D ^%ZTLOAD
 W !!,$S($D(ZTSK):"PSO*7*341 post-init has been queued - Task number ")
 W ZTSK KILL ZTSK
 QUIT
 ;
 ;--------------------------------------------------------------
START KILL ^TMP("PSO7P341")
 ;
 S ^TMP("PSO7P341")="0^0"
 S IEN=0
 ;
START1 I $G(RESTART) S IEN=$P($G(^TMP("PSO7P341")),U)
 ;
 F  S IEN=$O(^PSRX(IEN)) Q:'IEN  D
 . S REFILL=0,$P(^TMP("PSO7P341"),U)=IEN
 . S RX=$P($G(^PSRX(IEN,0)),U) I RX="" Q
 . F  S REFILL=$O(^PSRX(IEN,1,REFILL)) Q:'REFILL  D
 . . ;
 . . ;Check "EPH" Node
 . . I $D(^PSRX(IEN,1,REFILL,"EPH")),'$D(^PSRX(IEN,1,REFILL,0)) D
 . . . KILL ^PSRX(IEN,1,REFILL,"EPH")
 . . . S $P(^TMP("PSO7P341"),U,2)=$P(^TMP("PSO7P341"),U,2)+1
 . . . S ^TMP("PSO7P341",RX,REFILL)=""
 ;
 D EMAIL:$G(DUZ)
 ;
 KILL IEN,REFILL,RESTART,^TMP("PSO7P341")
 QUIT
 ;-------------------------------------------------------------
EMAIL NEW XMSUB,XMTEXT,XMY,XMDUZ,PSOMSG,PSONAME,PSOCNT,PSOCNT1
 NEW PSOIEN,PSOFILL S PSOIEN=""
 S PSONAME="PSO*7*341 Post-Init"
 S PSOMSG(1)=PSONAME_" has completed"
 S PSOMSG(2)="Number of invalid EPH nodes killed is "
 S PSOMSG(2)=PSOMSG(2)_$P($G(^TMP("PSO7P341")),U,2)
 S PSOMSG(3)="                                                 "
 S XMSUB=PSONAME
 S XMDUZ="OUTPATIENT PHARMACY"
 S XMTEXT="PSOMSG("
 S XMY(DUZ)=""
 S PSOCNT=0,PSOCNT1=4
 F  S PSOIEN=$O(^TMP("PSO7P341",PSOIEN)) Q:PSOIEN=""  D
 . S PSOFILL=""
 . F  S PSOFILL=$O(^TMP("PSO7P341",PSOIEN,PSOFILL)) Q:PSOFILL=""  D
 . . S PSOCNT1=PSOCNT1+1,PSOCNT=PSOCNT+1
 . . S PSOMSG(PSOCNT1)=$E(100000+PSOCNT,2,99)
 . . S PSOMSG(PSOCNT1)=PSOMSG(PSOCNT1)_"    RX:"_PSOIEN_"    "
 . . S PSOMSG(PSOCNT1)=PSOMSG(PSOCNT1)_"INVALID FILL#:"_PSOFILL
 D ^XMD
 Q
 ;-------------------------------------------------------------
RESTART NEW ZTSAVE,ZTIO,ZTRTN,ZTDESC
 S ZTSAVE("RESTART")=1
 S ZTIO="",ZTRTN="START1^PSO7P341",ZTDESC="PSO*7*341 Post-init"
 D ^%ZTLOAD
 W !!,$S($D(ZTSK):"PSO*7*341 post-init (RESTARTED) - Task number ")
 W ZTSK KILL ZTSK
 Q
 ;
TEST ;Create entries and stop compile to test restart
 ;Call routine at RESTART^PSO7P341 to restart
 ;This subroutine is for testing only
 ;
 NEW STOP,IEN,REFILL,RX
 KILL ^TMP("PSO7P341")
 S ^TMP("PSO7P341")="0^0"
 S IEN=0
 F  S IEN=$O(^PSRX(IEN)) Q:'IEN  Q:$G(STOP)  D
 . S REFILL=0,$P(^TMP("PSO7P341"),U)=IEN
 . S RX=$P($G(^PSRX(IEN,0)),U) I RX="" Q
 . F  S REFILL=$O(^PSRX(IEN,1,REFILL)) Q:'REFILL  D
 . . S $P(^TMP("PSO7P341"),U,2)=$P(^TMP("PSO7P341"),U,2)+1
 . . S ^TMP("PSO7P341",RX,REFILL)=""
 . . I $P($G(^TMP("PSO7P341")),U,2)>12 S STOP=1
 I $G(STOP) D
 . W !,"Test compile completed."
 . W !,"Type D RESTART^PSO7P341 to test restart",!
 QUIT
