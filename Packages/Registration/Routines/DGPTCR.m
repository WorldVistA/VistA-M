DGPTCR ;ALB/MJK - Census Worklist Re-gen ; JAN 27, 2005
 ;;5.3;Registration;**136,383,643**;Aug 13, 1993
 ;
GEN ; -- ask user regen ques
 D CHKCUR^DGPTCO1
 W ! D DATE^DGPTCO1
 S DIC("A")="Generate CENSUS WORKFILE for Census date: ",DIC="^DG(45.86,",DIC(0)="AEMQ" S:Y]"" DIC("B")=Y
 D ^DIC K DIC G GENQ:Y<0 S DGCN=+Y,DGCDT=+$P(Y,U,2)_".9"
 ;
GEN1 W !!,"Are you sure" S %=2 D YN^DICN
 I %<0!(%=2) W "   (Ok, work file will remain the same.)" G GENQ
 I '% W !?5,"Answer 'YES' if you want the system to re-calculate which",!?5,"admissions require Census records.",!?5,"Otherwise, answer 'NO'." G GEN1
 S ZTRTN="REGEN^DGPTCR",ZTIO="",ZTDESC="Regenerating CENSUS WORKFILE"
 S ZTSAVE("DGCN")="",ZTSAVE("DGCDT")="" W ! D ^%ZTLOAD
GENQ K DGCN,%,Y Q
 ;
REGEN ; -- census workfile generation
 ; -- kill off old values
 ; input: DGCN    := ifn of census date file
 ;        DGCDT   := date of census
 ;        DGFIRST := flag(1/0) to send bulletin (option)
 ;
 ;Lock global to prevent duplicate entries in Census Workfile
 L +^DG(45.85,"DGPT CENSUS REGEN WORKFILE"):5 I '$T N DGPTMSG D BLDMSG,SNDMSG Q
 K ^UTILITY("DGPT REGEN",$J) S:'$D(XQM) XQM=0
 S:'$D(DGFIRST) DGFIRST='$O(^DG(45.85,"ACENSUS",DGCN,0))
 S DGOLD="^UTILITY(""DGPT REGEN"",$J,""OLD"")",DGNEW="^UTILITY(""DGPT REGEN"",$J,""NEW"")"
 F DGI=0:0 S DGI=$O(^DG(45.85,"ACENSUS",DGCN,DGI)) Q:'DGI  D
 . S DIK="^DG(45.85,",DA=DGI
 . I $D(^DG(45.85,DA,0)) D
 . . S DGPTF=$P(^DG(45.85,DA,0),U,12)
 . . S @DGOLD@(+^DG(45.85,DA,0),+$P(^(0),U,3),+DGPTF)="" D ^DIK K DIK,DGPTF
 ; -- scan and create new values
 F DGDT=0:0 S DGDT=$O(^DGPM("ATT1",DGDT)) Q:'DGDT!(DGDT>DGCDT)  F DGAD=0:0 S DGAD=$O(^DGPM("ATT1",DGDT,DGAD)) Q:'DGAD  D CHK
 D FEE
 S DIE="^DG(45.86,",DA=DGCN,DR=".06///NOW" D ^DIE
 L -^DG(45.85,"DGPT CENSUS REGEN WORKFILE")
 D BULL
Q K DGEW,DGOLD,DGI,DGMV,DGAD0,DGAD1,DGDT,DFN,DGFIRST,^UTILITY("DGPT REGEN",$J),DGOLD,DGNEW
 Q
 ;
CHK ; -- determine if good adm then set work entry
 G CHKQ:'$D(^DGPM(DGAD,0)) S DGPMCA=DGAD,(DGPMAN,DGAD0)=^(0)
 S DFN=+$P(DGAD0,U,3) G CHKQ:'$D(^DPT(DFN,0))
 S DGT=DGCDT D WARD^DGPTC1 G CHKQ:'Y S DGCWD=+Y
 S DGPTF=+$P(DGAD0,U,16)
 S DGAD1=$S($D(^DGPM(+$P(DGAD0,U,17),0)):^(0),1:"")
 S:'$D(@DGOLD@(DFN,DGAD,+DGPTF)) @DGNEW@(DFN,DGAD,+DGPTF)="" K @DGOLD@(DFN,DGAD,+DGPTF)
 S X=DFN,DIC="^DG(45.85,",DIC(0)="L",DIC("DR")="[DGPT STUFF ENTRY]"
 K DD,DO D FILE^DICN K DIC
CHKQ K DFN,DGT,DGPMCA,DGPMAN,DGCWD Q
FEE ; --check for fee entries
 F DFN=0:0 S DFN=$O(^DGPT("AFEE",DFN)) Q:'DFN  D
 . F DGDT=0:0 S DGDT=$O(^DGPT("AFEE",DFN,DGDT)) Q:'DGDT  D
 ..; -- dgds=discharge date
 .. S PTFEE=$O(^DGPT("AFEE",DFN,DGDT,0))
 .. Q:'$D(^DGPT(PTFEE,0))
 .. Q:$P(^DGPT(PTFEE,0),U,11)=2
 .. S DGDS="" I $D(^DGPT(PTFEE,70)) S DGDS=$P(^(70),"^")
 .. I DGDS="" S DGDS=9999999
 .. D FEECHK
 Q
FEECHK ; -- determine if good adm then set work entry
 G FEECHKQ:'$D(^DGPT(PTFEE,0))
 G FEECHKQ:'$D(^DPT(DFN,0))
 I DGDT<DGCDT,DGDS>DGCDT D
 . S DGAD0=DGDT,$P(DGAD0,U,16)=PTFEE
 . S DGAD1=$S((DGDS=9999999):"",1:DGDS)
 . S:'$D(@DGOLD@(DFN,0,+PTFEE)) @DGNEW@(DFN,0,+PTFEE)="" K @DGOLD@(DFN,0,+PTFEE)
 . S X=DFN,DIC="^DG(45.85,",DIC(0)="L",DIC("DR")="[DGPT STUFF ENTRY]"
 . K DD,DO D FILE^DICN K DIC
FEECHKQ K PTFEE,DGDS Q
 ;
BULL ; -- bull to user re-generating
 G BULLQ:DGFIRST K ^UTILITY("DGPT REGEN",$J,"TEXT")
 K DGBLK S $P(DGBLK," ",100)="",Y=+^DG(45.86,DGCN,0) X ^DD("DD")
 S XMSUB="Census Workfile Update (CENSUS DATE: "_Y_")",XMY(DUZ)="",XMTEXT="^UTILITY(""DGPT REGEN"",$J,""TEXT"",",DGLINE=0
 D BLANK
 S Y=$P(^DG(45.86,DGCN,0),U,6) X ^DD("DD") S DGL=" Census Work File Regeneration Finished:  "_Y D SET,BLANK
 I $D(DGPTCV5) K @DGOLD,@DGNEW ;for v5 conversion only
 I '$D(@DGOLD),'$D(@DGNEW) D BLANK S DGL="  **** Work File did NOT change as a result of update. ****" D SET G BULL1
 S DGL="Changes resulting from regeneration of census work file:" D SET
 D OLD:$D(@DGOLD),NEW:$D(@DGNEW)
BULL1 D ^XMD
BULLQ K DGBLK,DGI,DGX,DGL,DGLINE,XMY,XMSUB,XMTEXT Q
 ;
SET ; -- set line in xmtext array
 S DGLINE=DGLINE+1
 S ^UTILITY("DGPT REGEN",$J,"TEXT",DGLINE,0)=DGL
 Q
 ;
BLANK S DGL=" " D SET Q
 ;
OLD ;
 D BLANK
 S DGL=">>> OLD ADMISSIONS no longer needing a Census Record <<< " D SET,HEAD
 F DFN=0:0 S DFN=$O(@DGOLD@(DFN)) Q:'DFN  F DGAD=0:0 S DGAD=$O(@DGOLD@(DFN,DGAD)) Q:'DGAD  D AD
 Q
 ;
NEW ;
 D BLANK,BLANK
 S DGL=">>> NEW ADMISSIONS added to workfile needing a Census Record <<< " D SET,HEAD
 F DFN=0:0 S DFN=$O(@DGNEW@(DFN)) Q:'DFN  F DGAD=0:0 S DGAD=$O(@DGNEW@(DFN,DGAD)) Q:'DGAD  D AD
 F DFN=0:0 S DFN=$O(@DGNEW@(DFN)) Q:'DFN  F PTFEE=0:0 S PTFEE=$O(@DGNEW@(DFN,0,+PTFEE)) Q:'PTFEE  D AD1
 Q
 ;
HEAD ;
 D BLANK
 S DGL="Name                            Admission Date           PTF#      Census#" D SET
 S DGL="----                            --------------           ----      -------" D SET
 Q
 ;
AD G ADQ:'$D(^DGPM(DGAD,0)) S DGX=^(0),DGL=""
 S DGL=$E($S($D(^DPT(DFN,0)):$P(^(0),U),1:"")_DGBLK,1,20)_" ("_$E($P(^(0),U,9),6,10)_")"
 S Y=+DGX X ^DD("DD") S DGL=DGL_$E(DGBLK,1,5)_$E(Y_DGBLK,1,20)_$E(DGBLK,1,4)_$J($P(DGX,U,16),5)_$E(DGBLK,1,8)
 F DGCI=0:0 S DGCI=$O(^DGPT("ACENSUS",+$P(DGX,U,16),DGCI)) Q:'DGCI  I $D(^DGPT(DGCI,0)),$P(^(0),U,13)=DGCN S DGL=DGL_$J(DGCI,5) Q
 D SET
ADQ K DGCI Q
AD1 G AD1Q:'$D(^DGPT(PTFEE,0)) S DGX=^(0),DGL=""
 S DGL=$E($S($D(^DPT(DFN,0)):$P(^(0),U),1:"")_DGBLK,1,20)_" ("_$E($P(^(0),U,9),6,10)_")"
 S Y=$P(DGX,U,2) X ^DD("DD") S DGL=DGL_$E(DGBLK,1,5)_$E(Y_DGBLK,1,20)_$E(DGBLK,1,4)_$J(PTFEE,5)_$E(DGBLK,1,8)
 F DGCI=0:0 S DGCI=$O(^DGPT("ACENSUS",PTFEE,DGCI)) Q:'DGCI  I $D(^DGPT(DGCI,0)),$P(^(0),U,13)=DGCN S DGL=DGL_$J(DGCI,5) Q
 D SET
AD1Q Q
 ;
BLDMSG ;Build message text if regen currently running
 S DGPTMSG(1,0)="The Census Status Report or the Regenerate Census Workfile option was"
 S DGPTMSG(2,0)="running at the time of your request.  If these options are scheduled"
 S DGPTMSG(3,0)="simultaneously, duplicate census records may be created in"
 S DGPTMSG(4,0)="the Census Workfile."
 S DGPTMSG(5,0)=""
 S DGPTMSG(6,0)="To prevent this possible duplication, these options may not be"
 S DGPTMSG(7,0)="scheduled at the same time.  Please try again."
 Q
SNDMSG ;Generate mail message to user
 N XMSUB,XMDUZ,XMY,XMTEXT
 S XMSUB="Could not generate Census Workfile"
 S XMDUZ="Census Workfile option"
 S XMY(DUZ)=""
 S XMTEXT="DGPTMSG("
 D ^XMD
 Q
