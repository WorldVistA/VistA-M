FBPST35C ;AISC-CMR;ELIMINATION OF FIELDS;JUN 29, 1994
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;FBFILE = file # with obsolete fields in it
 ;FBFLD = field # to be deleted
 ;FBGOT = set to 1 if fields still require deleting (flag to determine
 ;        if job has previously run to completion)
 F I=1:1:4 S FBFILE=$P($T(FILES+I),";;",2) Q:$G(FBGOT)  F J=3:1 S FBFLD=$P($T(FILES+I),";;",J) Q:'FBFLD!($G(FBGOT))  I $D(^DD(FBFILE,FBFLD,0)) S FBGOT=1
 I '$G(FBGOT) W "FBPST35C has previously run to completion!" G END
 W !!,"Beginning FBPST35C",!!?5,"REMOVAL OF FIELDS PREVIOUSLY STARRED FOR DELETION.",!!
 F I=1:1:13 W !,$P($T(TEXT+I),";;",2)
 W !! I '$D(DUZ) G START
ASK S DIR(0)="Y",DIR("A")="Do you want me to task this job in the background for you",DIR("B")="Yes"
 S DIR("?")="Answerring 'YES' will run the job in the background and send you a bulletin",DIR("?",1)="when completed.  Answerring 'NO' will run the job now (no",DIR("?",2)="bulletin will be sent)."
 D ^DIR K DIR I $D(DIRUT) W !!,*7,"Required response!" G ASK
 I Y S ZTRTN="START^FBPST35C",ZTIO="",ZTDTH=$H D ^%ZTLOAD I $D(ZTSK) W !?5,"Routine FBPST35 to remove obsolete fields has been tasked." G END
START ;
DATA ;delete data from obsolete fields in FB pt. file (#161)
 I '$D(ZTQUEUED) W !!,"Deleting any data remaining in the obsolete fields."
 S DFN=0 F  S DFN=$O(^FBAAA(DFN)) Q:'DFN  K ^FBAAA(DFN,"ADEL") S FBV=0 F  S FBV=$O(^FBAAA(DFN,1,FBV)) Q:'FBV  K ^FBAAA(DFN,1,FBV,"CNH")
 ;delete data from obsolete fields in FB vendor file (#161.2)
 S FBV=0 F  S FBV=$O(^FBAAV(FBV)) Q:'FBV  S DIE="^FBAAV(",DR="16////@;17////@;21////@",DA=FBV D ^DIE K DIE,DA,DR
 ;delete data from obsolete fields in FB site parameter file (#161.4)
 S FBSP=0 F  S FBSP=$O(^FBAA(161.4,FBSP)) Q:'FBSP  S DIE="^FBAA(161.4,",DR="36////@;37////@",DA=FBSP D ^DIE K DIE,DA,DR
FIELDS ;remove obsolete fields
 F I=1:1:4 S FBFILE=$P($T(FILES+I),";;",2) F J=3:1 S FBFLD=$P($T(FILES+I),";;",J) Q:'FBFLD  I $D(^DD(FBFILE,FBFLD,0)) D
 .I '$D(ZTQUEUED) W !!,"Deleting field # ",FBFLD," from file # ",FBFILE,"."
 .S DIK="^DD("_FBFILE_",",DA=FBFLD,DA(1)=FBFILE D ^DIK K DIK,DA
 I '$D(ZTQUEUED) W !!!,"Completed FBPST35C" G END
 S FBTEXT(1,0)="Post initialization routine FBPST35C has run to completion.",XMSUB="FEE BASIS POST-INIT COMPLETE",XMDUZ=.5,XMY(DUZ)="",XMTEXT="FBTEXT("
 D ^XMD K FBTEXT,XMSUB,XMDUZ,XMY,XMTEXT
END K FBFILE,FBFLD,I,J,FBGOT,FB
 Q
FILES ;;
 ;;161.01;;4
 ;;161;;102;;103;;104
 ;;161.2;;16;;17;;21
 ;;161.4;;36;;37
TEXT ;;
 ;;I will now remove the following fields that have been starred for
 ;;deletion:
 ;;          File                     Field
 ;;          ----                     -----
 ;; 161     Fee Basis Patient         102  *AUSTIN DELETED
 ;;                                   103  *DATE OF AUSTIN DELETE
 ;;                                   104  *DATE TRANSMITTED TO AUSTIN
 ;; 161.01  Fee Basis Patient           4  *CNH LEVEL OF CARE
 ;; 161.2   Fee Basis Vendor           16  *NUMBER OF SKILLED BEDS
 ;;                                    17  *NUMBER OF INTERMEDIATE BEDS
 ;;                                    21  *LEVELS OF CARE PROVIDED
 ;; 161.4   Fee Basis Site Parameters  36  *LAST UC UPDATED
 ;;                                    37  *DATE UC CONVERSION COMPLETED
