QACI5 ; OAKOIFO/TKW - DATA MIGRATION - OPTIONS OUT-OF-ORDER/IN-ORDER ;7/27/05  16:22
 ;;2.0;Patient Representative;**19**;07/25/1995;Build 55
EN ; Put Patient Rep (QAC) options out-of-order or back in order again
 N QACIEN,QACIO,QACX,DIR,X,Y
 S QACIEN=$$FIND1^DIC(19,,"X","QAC NEW")
 I 'QACIEN W "QAC NEW option not found!" Q
 S QACX=$$GET1^DIQ(19,QACIEN_",",2,"I")
 ; Set QACIO to 0 if menus are out of order, 1 if they're active
 S QACIO=$S(QACX]"":0,1:1)
 K DIR,Y
 W !!,"  The Patient Rep Options are currently "_$S(QACIO=0:"OUT OF ORDER.",1:"ACTIVE."),!
 S DIR("A")="  Put Patient Rep Options OUT OF ORDER"
 I QACIO=0 S DIR("A")="  Reactivate Patient Rep Options"
 S DIR(0)="YO",DIR("B")="YES"
 D ^DIR
 Q:Y'=1
 D E0
 Q
E0 ; Activate/Inactivate Patient Rep menu options. 
 N QACOPT,QACTXT
 F QACOPT="QAC NEW","QAC EDIT","QAC STATUS","QAC SETUP MENU","QAC ALERT","QAC ROLLUP (MANUAL)" D
 . I QACIO=1 S QACTXT="Use data migration UTIL option to reactivate."
 . E  S QACTXT=""
 . D OUT^XPDMENU(QACOPT,QACTXT) Q
 W !!,"  * Patient Rep Options have been "_$S(QACIO=0:"Reactivated.",1:"put OUT OF ORDER."),!
 Q
 ;
EN1() ; Entry point from ^QACI2 (set options out of order, kill rollup task
 ; when data is moved to staging area.)
 N QACIO S QACIO=1
 ; Kill the TaskMan task that rolls Patient Rep data up to Austin for VSSC Reports
 W !!,"  Stopping (killing) task that rolls up data to Austin..."
 I '$$KILLRLUP Q 0
 ; Call routine to put Patient Rep options OUT OF ORDER.
 D E0
 Q 1
 ;
ENRTASK ; Reschedule task that rolls data up to Austin
 N DIR,Y W !
 S DIR("A")="  Reschedule task to roll up data to Austin"
 S DIR(0)="YO",DIR("B")="YES"
 S DIR("?",1)="When you migrated data to the staging area, the task that rolls up data"
 S DIR("?",2)="from the Patient Rep application to Austin was automatically stopped (killed)."
 S DIR("?",3)=""
 S DIR("?")="Answer YES if you want to restart the scheduled rollup task."
 D ^DIR
 I Y'=1 W !,"   * no action taken" Q
 W !,"...processing task--please wait..."
 D ^QACMAIL0
 W !,"  * Task has been rescheduled.",!,"    Data will be rolled up from Patient Rep to Austin."
 Q
 ;
ENKTASK ; Kill task that rolls data up to Austin
 N DIR,Y W !
 S DIR("A")="  Stop (kill) task that rolls up data to Austin"
 S DIR(0)="YO",DIR("B")="YES"
 S DIR("?",1)="After data has been migrated into PATS, you will no longer want to run the"
 S DIR("?",2)="scheduled task that rolls up data from the Patient Rep application to Austin."
 S DIR("?",3)=""
 S DIR("?")="Answer YES if you want to stop (kill) the scheduled rollup task."
 D ^DIR
 I Y'=1 W !,"   * no action taken" Q
 I $$KILLRLUP Q
 Q
 ;
KILLRLUP() ; Kill Taskman Task that rolls Patient Rep data up to Austin for VSSC reports
 ; Get task number from QAC SITE PARAMETER FILE  
 N QACZTSK,QACHK,ZTSK
 S ZTSK=""
 D CHKTSK^QACMAIL0
 ; If no task number in SITE PARAMETER FILE, job is not scheduled, we can continue.
 I $G(ZTSK)'>0 W !,"  * No task is currently scheduled--rollup to Austin is stopped." Q 1
 I $G(ZTSK(1))=2 W !!,"  * Task that rolls data up to Austin is currently running.",!,"    Please try later." Q 0
 ; If task is not currently scheduled, we can continue.
 I $G(QACHK)'=1 W !,"  * No task is currently scheduled--rollup to Austin is stopped." Q 1
 ; Otherwise, kill the task
 D KILL^%ZTLOAD
 I $G(ZTSK(0))'=1 W !!,"  * Error attempting to kill task "_ZTSK_"!",!,"    Please contact IRM staff for assistance." Q 0
 W !,"  * Task has been stopped (killed).",!,"    Data will not be rolled up from Patient Rep to Austin."
 Q 1
 ;
EN3 ; Print list of pending ARNs
 I $E($O(^XTV(8992,"AXQAN","QAC-")),1,4)'="QAC-" W !!,"There are no Pending Notifications!",!! Q
 N PATSHDR
 S PATSHDR="Pending Notifications"
 S PATSHDR(1)="ROC No.      From                            To"
 N ZTSAVE S ZTSAVE("PATSHDR")=""
 D EN^XUTMDEVQ("DQRPT3^QACI5","Report of Pending Notifications",.ZTSAVE)
 Q
 ;
EN4 ; Counts of migrated/unmigrated/total/errors
 N PATSHDR
 S PATSHDR="PATS Migration Counts"
 N ZTSAVE S ZTSAVE("PATSHDR")=""
 D EN^XUTMDEVQ("DQRPT4^QACI5",PATSHDR,.ZTSAVE)
 Q
 ;
DQRPT3 ; Report pending ARNs
 N PAGENO,LNCNT,NKEY,NIEN,NDATE,NOTIF0,ERRMSG,HDDATE,QACFROM,QACTO,ROCNO,DATESENT,X,%,%H,%I
 S PAGENO=1,LNCNT=0
 D NOW^%DTC S HDDATE=$$FMTE^XLFDT(%)
 U IO D HDR^QACI1A
 W ! S LNCNT=1
 S NKEY="QAC-"
 F  S NKEY=$O(^XTV(8992,"AXQAN",NKEY)) Q:$E(NKEY,1,4)'="QAC-"  D
 . F NIEN=0:0 S NIEN=$O(^XTV(8992,"AXQAN",NKEY,NIEN)) Q:'NIEN  F NDATE=0:0 S NDATE=$O(^XTV(8992,"AXQAN",NKEY,NIEN,NDATE)) Q:'NDATE  D
 .. S NOTIF0=$G(^XTV(8992,NIEN,"XQA",NDATE,0))
 .. S QACTO=$P($G(^VA(200,NIEN,0)),"^")
 .. S QACFROM=$P($G(^VA(200,$P(NOTIF0,";",2),0)),"^")
 .. S DATESENT=$$FMTE^XLFDT(NDATE)
 .. S ROCNO=$P(NOTIF0,"-",2)
 .. D:LNCNT>55 HDR^QACI1A
 .. W ROCNO,?13,QACFROM,?45,QACTO,!
 .. W ?2,"Sent: "_DATESENT,!
 .. W ?2,"Msg:  ",$P(NOTIF0,"^",3),!!
 .. S LNCNT=LNCNT+4
 .. Q
 . Q
 D ^%ZISC Q
 ;
DQRPT4 ; Print various counts for migration
 N PAGENO,CNT,HDDATE,TYPE,DSPTYPE,DASH,X,%,%H,%I
 S PAGENO=1
 S DASH=" ",$P(DASH,"-",24)=""
 D NOW^%DTC S HDDATE=$$FMTE^XLFDT(%)
 S DSPTYPE("ROC")="ROCs",DSPTYPE("HL")="Hospital Locations"
 S DSPTYPE("USER")="PATS Users",DSPTYPE("PT")="Patients"
 S DSPTYPE("CC")="Congressional Contacts"
 S DSPTYPE("EMPINV")="Employees Involved"
 S DSPTYPE("FSOS")="Service/Disciplines"
 U IO D HDR^QACI1A
 W ! S LNCNT=1
 S CNT=0 F TYPE="ROC","HL","USER","PT","CC","EMPINV","FSOS" D
 . S CNT=CNT+$G(^XTMP("QACMIGR",TYPE,"U")) Q
 I CNT=0 W "** No data in staging area. **",!!
 E  W "** Data moved to the staging area, ready to migrate to PATS **",!!
 S CNT=0 F I=0:0 S I=$O(^QA(745.1,I)) Q:'I  S CNT=CNT+1
 W "Total Number of ROCs:",$E(DASH,1,20),?42,CNT,!
 F TYPE="ROC","HL","USER","PT","CC","EMPINV","FSOS" D
 . W DSPTYPE(TYPE)_" ready to migrate:",$E(DASH,1,23-$L(DSPTYPE(TYPE))),?42,+$G(^XTMP("QACMIGR",TYPE,"U")),!
 . W ?8,"migrated:"_DASH,?42,+$G(^XTMP("QACMIGR",TYPE,"D")),!
 . W ?8,"with errors:"_$E(DASH,1,21),?42,+$G(^XTMP("QACMIGR",TYPE,"E")),!!
 . Q
 D ^%ZISC Q
 ;
ENRSTAT ; Return status for a selected ROC
 N DIC,X,Y,OLDROC,NEWROC
 S DIC="^QA(745.1,",DIC(0)="AEMQZ",DIC("A")="Select CONTACT NUMBER: "
 D ^DIC Q:'Y!(Y=-1)
 S OLDROC=$P(Y(0),"^")
 S NEWROC=$$CONVROC^QACI2C(OLDROC)
 W !!,"**** ROC Status: "
 I $D(^XTMP("QACMIGR","ROC","D",NEWROC)) W "This ROC has been successfully migrated into PATS.",! Q
 I $D(^XTMP("QACMIGR","ROC","E",OLDROC_" ")) W "This ROC has errors.",! Q
 I $D(^XTMP("QACMIGR","ROC","U",NEWROC_" ")) W "This ROC is in the staging area, ready to migrate.",! Q
 W "No action has been taken for this ROC.",!
 Q
 ;
 ;
