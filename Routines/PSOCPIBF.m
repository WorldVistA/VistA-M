PSOCPIBF ;BIR/EJW-Clean up to bill unbilled CMOP copays ;01/14/02
 ;;7.0;OUTPATIENT PHARMACY;**93**;DEC 1997
 ;External reference to ^XUSEC supported by DBIA 10076
 ;External reference to ^XPD(9.7, supported by DBIA 2197
 S ZTDTH=""
 I $D(ZTQUEUED) S ZTDTH=$H
 I ZTDTH="" D
 .W !,"The background job to clean up unbilled, released CMOP prescription fills must"
 .W !,"be queued to run and complete before 02/01/2002 when tracking for the "
 .W !,"annual copay cap begins."
 .W !!,"If no start date/time is entered when prompted, the background job will be "
 .W !,"queued to run NOW."
 .W !
 .D PATCHDT
 .D CHKSITE
 .D GETDATE
 .D BMES^XPDUTL("Queuing background job to reprocess unbilled copay CMOP Prescription fills...")
 S ZTRTN="EN^PSOCPIBF",ZTIO="",ZTDESC="Background job to bill CMOP unbilled copays" D ^%ZTLOAD K ZTDTH,ZTRTN,ZTIO,ZTDESC
 W:$D(ZTSK)&('$D(ZTQUEUED)) !!,"Task Queued !",!
 Q
EN ;
 N PSODATE,RXP,PSOTEXT,YY,PSOCNT,PSOSTART,PSOEND,PSOSTOP
 S PSOCNT=0
 S PSOSTOP=0
 D NOW^%DTC S Y=% D DD^%DT S PSOSTART=Y
 I '$G(DT) S DT=$$DT^XLFDT
 I DT>3020201 S PSOSTOP=1 D MAIL Q  ; TOO LATE TO RUN CLEAN-UP
 S PSOINST=$O(^XPD(9.7,"B","PSX*2.0*35","")) I PSOINST'="" S PSODATE=$P($G(^XPD(9.7,PSOINST,1)),"^",3)
 I $G(PSODATE)'="" S PSODATE=PSODATE-1
 I $G(PSODATE)="" S PSODATE=3011011 ; DAY BEFORE PSX*2*35 WAS INSTALLED ANYWHERE
 F  S PSODATE=$O(^PSRX("AR",PSODATE)) Q:'PSODATE  S RXP="" F  S RXP=$O(^PSRX("AR",PSODATE,RXP)) Q:'RXP  S YY="" F  S YY=$O(^PSRX("AR",PSODATE,RXP,YY)) Q:YY=""  Q:PSOSTOP  D
 .S PSOIB=+$P($G(^PSRX(RXP,"IB")),"^") I 'PSOIB Q  ; NOT MARKED AS A COPAY RX
 . ; IF NO IB NUMBER FOR THIS FILL, SET UP VARIABLES AND CALL CP^PSOCP.  IF THERE IS AN IB NUMBER AFTER THIS CALL, COUNT IT FOR SUMMARY MAIL MSG
 .I 'YY D  Q
 ..I $P(^PSRX(RXP,"IB"),"^",2)'="" Q
 ..D NOW^%DTC I %>3020201 S PSOSTOP=1 Q  ; STOP IF REACH DATE OF COPAY RATE CHANGE
 ..D SITE
 ..I PSODATE>3011231 D CP^PSOCP
 ..I PSODATE<3020101 D CP^PSOCPIBC ; BEFORE NEW EXEMPTION CHECKS WENT INTO EFFECT
 ..I $P(^PSRX(RXP,"IB"),"^",2)'="" S PSOCNT=PSOCNT+1
 .I $P($G(^PSRX(RXP,1,YY,"IB")),"^",1)="" D
 ..D NOW^%DTC I %>3020201 S PSOSTOP=1 Q  ; STOP IF REACH DATE OF COPAY RATE CHANGE
 ..D SITE
 ..I PSODATE>3011231 D CP^PSOCP
 ..I PSODATE<3020101 D CP^PSOCPIBC ; BEFORE NEW EXEMPTION CHECKS WENT INTO EFFECT
 ..I $P($G(^PSRX(RXP,1,YY,"IB")),"^",1)'="" S PSOCNT=PSOCNT+1
MAIL ;
 D NOW^%DTC S Y=% D DD^%DT S PSOEND=Y
 I $G(DUZ) S XMY(DUZ)=""
 S XMDUZ="Outpatient Pharmacy",XMSUB="Outpatient Pharmacy Copay Clean-up"
 F PSOCXPDA=0:0 S PSOCXPDA=$O(^XUSEC("PSO COPAY",PSOCXPDA)) Q:'PSOCXPDA  S XMY(PSOCXPDA)=""
 I $O(XMY(""))="" Q  ; no recipients for mail message
 S PSOTEXT(1)="The Rx copay clean up job for the Outpatient Pharmacy patch (PSO*7*93)"
 S PSOTEXT(2)="started "_PSOSTART_" and completed "_PSOEND_"."
 I PSOCNT>0 S PSOTEXT(3)="Released unbilled copay Rxs have now been reprocessed."
 I PSOCNT>0 S PSOTEXT(4)="There were "_PSOCNT_" Rx fills successfully billed."
 I PSOCNT=0 S PSOTEXT(3)="No released unbilled copay Rxs were found to reprocess."
 I PSOSTOP D
 .S PSOTEXT(5)=""
 .S PSOTEXT(6)="PROCESSING CANNOT CONTINUE BEYOND JAN. 31,2002 BECAUSE OF COPAY RATE CHANGE."
 .I $G(PSODATE)'="" S Y=PSODATE D DD^%DT S PSOTEXT(7)="AT TIME JOB TERMINATED, RELEASE DATE BEING PROCESSED WAS "_Y
 S XMTEXT="PSOTEXT(" N DIFROM D ^XMD K XMDUZ,XMTEXT,XMSUB
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
GETDATE ; GET DATE/TIME OF WHEN BACKGROUND JOB SHOULD BE RUN
 S ZTDTH=""
 S NOW=0
 D NOW^%DTC S (Y,TODAY)=% D DD^%DT 
 W !!,"Background job must be queued to start by "_$S(Y<3020131:"Jan 30, 2002 or before.",1:"Jan 31, 2002.")
 I Y>3020131 S ZTDTH=Y Q  ; LET JOB RUN IF IT'S FEB 1,2002 OR LATER.  THE MAILMAN MESSAGE WILL SHOW THAT NO CLEAN UP WAS DONE
 W !!,"At the following prompt, enter a starting date/time after ",Y,!,"and before "_$S(Y<3020131:"Jan 31, 2002",1:"Feb 1, 2002")," or enter NOW to queue the job immediately."
 W !,"If this prompting is during patch installation, you will not see what you type."
 W ! K %DT D NOW^%DTC S %DT="RAEX",%DT(0)=%,%DT("A")="Queue copay clean-up Job to run Date/Time: "
 D ^%DT K %DT I $D(DTOUT)!(Y<0) W "Task will be queued to run NOW" S ZTDTH=$H,NOW=1
 I 'NOW I Y>0,$P(Y,".")>3020130 I TODAY<3020131 W !!,"Must queue background job to start on Jan. 30 or before." G GETDATE
 I 'NOW,Y>0 D
 .S SAVEY=Y
 .D DD^%DT
 .S X=Y
 .S Y=SAVEY
ASK W !!,"Task will be queued to run "_$S(NOW:"NOW",1:X)_" Is that correct?  :"
 R XX:300 S:'$T XX="Y" I XX'="Y",XX'="y",XX'="N",XX'="n" W " Enter Y or N" G ASK
 I XX'="Y",XX'="y" G GETDATE
 I Y>0,ZTDTH="" S ZTDTH=Y
 I ZTDTH="" S ZTDTH=$H
 Q
 ;
SITE ; SET UP VARIABLES NEEDED BY BILLING
 S PSOSITE=$S(YY=0:$P(^PSRX(RXP,2),"^",9),1:$P($G(^PSRX(RXP,1,YY,0)),"^",9))
 I PSOSITE="" Q
 S PSOPAR=$G(^PS(59,PSOSITE,1))
 S PSOSITE7=$P($G(^PS(59,PSOSITE,"IB")),"^")
 Q
 ;
PATCHDT ; SHOW USER WHEN CMOP PATCH WAS FIRST INSTALLED
 S PSOFIRST="Oct 12, 2001" ; DEFAULT FOR WHEN FIRST SITE INSTALLED THE PATCH
 S PSOINST=$O(^XPD(9.7,"B","PSX*2.0*35","")) I PSOINST'="" S Y=$P($G(^XPD(9.7,PSOINST,1)),"^",3) D DD^%DT S PSOFIRST=Y
 W !,"CMOP patch PSX*2*35 was first installed at your facility on ",PSOFIRST
 Q
 ;
CHKSITE ; SEE IF ANY DIVISIONS HAD THE PROBLEM
 S PROBTEXT="'BARCODES ON ACTION PROFILES'"
 N SITE,PROB
 S PROB=0
 S SITE="" F  S SITE=$O(^PS(59,SITE)) Q:SITE=""  I '$P($G(^PS(59,SITE,1)),"^",1) D  S PROB=1 Q
 .W !!,"The Outpatient Site (File #59) parameter, "_PROBTEXT
 .W !,"for one or more outpatient sites is either not defined or set to 'No'."
 .W !,"All copay eligible, released CMOP prescription fills from those outpatient"
 .W !,"sites would not have been billed since the installation of PSX*2*35."
 .W !!,"NOTE:  If the estimated number of CMOP prescriptions involved is high based"
 .W !,"on when the patch was first installed and the number of outpatient sites "
 .W !,"involved, you may want to disable journaling for Integrated Billing and"
 .W !,"Accounts Receivable globals ^IB and ^PRCA while the clean up job"
 .W !,"is running."
 W !!,"When the background job is complete, a MailMan message will be sent to the"
 W !,"installer indicating how many copay eligible CMOP prescription fills were "
 W !,"successfully billed."
 I PROB Q
 W !!,"All "_PROBTEXT_" are set to 'YES' for all divisions."
 W !,"The MailMan message at the end should indicate that no fills were found to"
 W !,"reprocess.  (i.e. All released CMOP fills have already been billed.)"
 Q
 ;
