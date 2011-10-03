SDWLFULU ;;IOFO BAY PINES/TEH - SAVE/RESTORE UTILITY FOR ENROLLE STATUS;06/12/2002 ; 20 Aug 2002 2:10 PM
 ;;5.3;scheduling;**525**;AUG 13 1993;Build 47
 ;
 ;
 ;
 ;
 ;
 ;
 Q
EN D HD
 W !!
 S DIR(0)="SA^B:BACKUP;R:RESTORE"
 S DIR("A")="(B)ackup or (R)estore " D ^DIR
 I X["^" Q
 I X["b" D BACKUP
 I X["B" D BACKUP
 I X["R" D RESTORE
 I X["r" D RESTORE
 I X="" Q
END K DA,DIE,DIR,DR,SDWLE,SDWLX,X,SDWLEE
 Q
BACKUP ;
 ;CHECK FOR RUN STATUS
 S Y=1 I $D(^XTMP("SDWLFULSTAT",$J,"1B")) W !,"This option has already been run." D  I Y D RESTART G EN0
 .S DIR(0)="Y",DIR("A")="Do you want to re-run all options",DIR("B")="N" D ^DIR
 .I X["^" S Y=0 Q
 .I X["Y"!(X["y") S Y=1 Q
 .S Y=0
 I 'Y Q
EN0 K ^XTMP("409.3")
 S SDWLX=0 F  S SDWLX=$O(^SDWL(409.3,SDWLX)) Q:SDWLX<1  D
 .S SDWLE=$G(^SDWL(409.3,SDWLX,0)) Q:SDWLE=""  D
 ..S SDWLEE=$P(SDWLE,U,20)
 ..S ^XTMP("409.3",SDWLX)=SDWLEE
 W !!,"Backup Completed in ^XTMP(""409.3"")"
 S ^XTMP("SDWLFULSTAT",$J,"1B")=""
 Q
RESTORE ;
 ;CHECK RUN STATUS
 I '$D(^XTMP("SDWLFULSTAT",$J,"1B")) W !,"Must run BACK-UP before RESTORE." Q
 I '$D(^XTMP("409.3")) W !,"Nothing to Restore." Q
 S SDWLX=0,SDWLCNT=0 F  S SDWLX=$O(^XTMP("409.3",SDWLX)) Q:SDWLX<1  D
 .S SDWLCNT=SDWLCNT+1
 .S SDWLE=$G(^XTMP("409.3",SDWLX))
 .S DR="27////^S X=SDWLE",DIE="^SDWL(409.3,",DA=SDWLX D ^DIE
 W !!,"Restore Completed" D MESS
 K SDWLCNT S ^XTMP("SDWLFULSTAT",$J,"1R")=""
 Q
MESS ;
 N XMSUB,XMY,XMTEXT,XMDUZ,SDWLMSG,SDWLI,SDWLIN,XQSUB,Y
 S XMY("BENBOW.PHYLLIS2@FORUM.VA.GOV")=""
 S XMY("DERDERIAN.JOHN@FORUM.VA.GOV")=""
 S XMY("HOUTCHENS.THOMAS@FORUM.VA.GOV")=""
 S XMY("BROWN.BONNIE@FORUM.VA.GOV")=""
 S XMY("KROCHMAL.CHUCK@FORUM.VA.GOV")=""
 S XMY("TAPPER.BRIAN@FORUM.VA.GOV")=""
 S XMY("LANDRIE.LARRY@FORUM.VA.GOV")=""
 S XMY("TOWSON.LINDA@FORUM.VA.GOV")=""
 S XMSUB="Patch SD*5.3*525 restored."
 S XMTEXT="SDWLMSG(",XMDUZ="POSTMASTER"
 S SDWLIN=$$GET1^DIQ(4,DUZ(2)_",",.01,,)
 S SDWLMSG(1,0)="A RESTORE has been performed on patch SD*5.3*525 at "_SDWLIN
 S Y=DT D DD^%DT
 S SDWLMSG(2,0)="At "_Y
 S SDWLMSG(3,0)=SDWLCNT_"Records had the EWL Enrollee Status restored to pre-patch values."
 S SDWLMSG(4,0)="",SDWLMSG(0)=4
 D ^XMD
 Q
HD W:$D(IOF) @IOF W !,?80-$L("SD WAIT LIST file save/restore utility")\2,"EWL WAIT LIST save/restore utility"
 Q
RESTART ;
 S DIR(0)="Y",DIR("A")="Are you absolutely sure you want to restart this process"
 D ^DIR I X["^" Q
 I X["Y"!(X["y") K ^XTMP("SDWLFULSTAT") Q
 Q
