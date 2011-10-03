OR3CONV1 ;SLC/MLI-Conversion utilities and cleanup ;8/2/97 [5/25/99 9:33am]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**14,40,296**;Dec 17, 1997;Build 19
 ;
 ; Continuation calls from OR3CONV - used by OE/RR version 3 conversion
 ;
 ; Utilities for site to call:
 ;   RESTART - if process stopped for any reason, this can be used
 ;             to restart the background portion of the conversion.
 ;
 ;   STATUS  - display the status of the conversion via TaskMan and
 ;             via OE/RR.
 ;
STOP ; entry point to stop conversion cleanly
 N X
 S X=$G(^ORD(100.99,1,"CONV"))
 I +X W !,"The conversion has already run to completion." Q
 I '$P(X,"^",6) W !,"The background job conversion has not yet started." Q
 D STATUS
 I $$RUSURE("stop") D SET^OR3CONV(11,1)
 Q
 ;
RESTART ; entry point to restart conversion
 N X
 S X=$$CHECK()
 I X]"" D  Q
 . W !,"You can not use the RESTART call at this time."
 . W !,X
 . W !!,"Call STATUS^OR3CONV1 to get current status of conversion."
 D STATUS
 I $$RUSURE("restart") D
 . S ZTSAVE("ORESTART")=$P(^ORD(100.99,1,"CONV"),"^",9)
 . D QUEUE^OR3CONV
 Q
 ;
CHECK() ; check status to see if restart should be allowed
 N X
 S X=$G(^ORD(100.99,1,"CONV"))
 I +X Q "The conversion has already run to completion."
 I '$P(X,"^",6) Q "The background job conversion has not yet started."
 S X=+$P(X,"^",10) I X S X=$$ZTSKCHK(X) I '$P(X,"^",2) Q $P(X,"^",1)
 Q ""
 ;
RUSURE(TEXT) ; return 1 if yes, 0 otherwise
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="YA",DIR("B")="No"
 S DIR("A")="Are you sure you want to "_TEXT_" the conversion? "
 D ^DIR
 Q +Y
 ;
STATUS ; get status of conversion
 N STAGE,X
 S X=$G(^ORD(100.99,1,"CONV"))
 I +X W !,"The conversion has already completed!" Q
 I $P(X,"^",1)="" W !,"The conversion has not yet started." Q
 I $P(X,"^",11) W !,"The background job was requested to stop." Q
 I '$P(X,"^",6),'$P(X,"^",10) D  Q
 . W !,"The background conversion of patient orders has not"
 . W !,"started yet.  This process is queued to run by the post-"
 . W !,"installation process of CPRS.  It has not yet been queued."
 I $P(X,"^",10) D  Q
 . W !,"The background conversion of patient orders is running."
 . W !,"The task number assigned to the conversion was ",$P(X,"^",10),"."
 . W !,"The following is the status of the process according to TaskMan:"
 . W !?5,$P($$ZTSKCHK($P(X,"^",10)),"^",1)
 . W !
 . S STAGE=$$STAGE($P(X,"^",8))
 . I +STAGE=0 D  Q
 . . W !,"The background job is currently populating the list of"
 . . W !,"patients that will need to be processed by the conversion."
 . . W !,"Last DFN populated: ",$O(^ORD(100.99,1,"PTCONV","A"),-1)
 . W !,"The background conversion is currently on stage ",+STAGE,"."
 . W !,"This stage converts ",$S(STAGE<7:"patients who ",1:""),$P(STAGE,"^",2),"."
 . I $P(X,"^",9) D
 . . W !,"It last completed processing "
 . . W $P(STAGE,"^",3)," ",$P(X,"^",9),"."
 . W !!,"So far, orders for ",+$P(X,"^",12)," patients have converted."
 . W !,"There are currently ",+$P(^ORD(100.99,1,"PTCONV",0),"^",4)," patients left to process."
 . I +STAGE'=1 Q  ; show more info for inpatients
 . W !!,"Patients on ward ",$P(X,"^",4)," are currently being processed."
 . W !,"The last patient to be converted was DFN #",$P(X,"^",5),"."
 Q
 ;
ZTSKCHK(ZTSK) ; check status of task via TaskMan utilities
 ; return message^flag where flag is 1 to allow requeue...0 otherwise
 D STAT^%ZTLOAD
 Q $P($T(ZTSKMSG+ZTSK(1)),";;",2)
 ;
ZTSKMSG ;;Unable to find task on current volume set^1
 ;;Task is scheduled and waiting to run^0
 ;;The task is running^0
 ;;The task completed^1
 ;;The task was created without being scheduled^0
 ;;The process stopped for some reason^1
 ;;Unable to obtain status from TaskMan^1
 ;
STAGE(STAGE) ; return text of what stage does
 Q $P($T(STAGETXT+STAGE),";;",2)
 ;
 ; stages - number^text^up to text
STAGETXT ;;0^populating list of patients to convert
 ;;1^are current inpatients^ward
 ;;2^have future scheduled admissions on file^scheduled admission date
 ;;3^have waiting list file entries^DFN
 ;;4^have discharges within last 4 weeks^discharge date
 ;;5^have appointments in last 4 or next 4 weeks^hospital location
 ;;6^have not already been converted^DFN
 ;;7^orders not associated with PATIENT file entries^variable pointer
 ;
CLEANUP ; conversion is completed
 N X
 I '$$FINALCHK() D ERROR Q
 D KILL^OR3C101,REQUEUE^ORMTIME(1)
 D BADNAMES^PSJIPST3
 D MAIL
 Q
 ;
FINALCHK() ; check to see if every patient converted
 N DFN,ERROR
 S ERROR=1
 F DFN=0:0 S DFN=$O(^ORD(100.99,1,"PTCONV",DFN)) Q:'DFN  D  Q:ERROR
 . S ERROR=$$CONVERT^OR3CONV(DFN,1)         ; try again to convert
 . I '$$PTDONE^OR3CONV(DFN) S ERROR=0
 Q ERROR
 ;
MAIL ; send e-mail that the conversion completed
 N COUNT,X
 S COUNT=0,X=$G(^ORD(100.99,1,"CONV"))
 D LINE("The orders conversion has completed")
 D LINE(" ")
 D LINE("The conversion was first started:  "_$$FMTE^XLFDT($P(X,"^",6)))
 D LINE("It ran to completion:              "_$$FMTE^XLFDT($P(X,"^",7)))
 D SEND("OE/RR version 3.0 conversion complete")
 Q
 ;
ERROR ; create mail message if unconverted patients found
 N COUNT
 S COUNT=0
 D LINE("A problem was encountered in the OE/RR conversion.  After")
 D LINE("going through all patients, it was still unable to convert")
 D LINE("orders for some patients.  Please contact the national")
 D LINE("customer support help desk for further assistance.")
 D SEND("OE/RR version 3.0 conversion encountered problem")
 Q
 ;
LINE(TEXT) ; store data in array for mail message
 S COUNT=COUNT+1
 S ORTEXT(COUNT)=TEXT
 Q
 ;
SEND(SUBJECT) ; define rest of XM variables and fire message off
 N DIFROM,XMDUZ,XMSUB,XMTEXT,XMY
 S XMSUB=SUBJECT,XMTEXT="ORTEXT("
 S XMDUZ="OE/RR CONVERSION"
 F I="G.CPRS INSTALLATION@ISC-SLC.VA.GOV",DUZ S XMY(I)=""
 D ^XMD
 Q
 ;
PTCONV ; populate OR3 PATIENTS TO CONVERT multiple...hard set for speed
 N COUNT,DFN,LAST
 S COUNT=0,LAST=""
 F DFN=0:0 S DFN=$O(^DPT(DFN)) Q:'DFN!(DFN'=+DFN)  I $D(^(DFN,0)) D
 . S LAST=DFN,COUNT=COUNT+1
 . I $D(^ORD(100.99,1,"PTCONV",DFN,0)) Q
 . S ^ORD(100.99,1,"PTCONV",DFN,0)=DFN,^ORD(100.99,1,"PTCONV","B",DFN,DFN)=""
 S ^ORD(100.99,1,"PTCONV",0)="^100.9903PA^"_LAST_"^"_COUNT
 Q
