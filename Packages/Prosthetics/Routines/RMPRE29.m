RMPRE29 ;PHX/JLT,RVD-EDIT 2319 ;10/2/03  13:04
 ;;3.0;PROSTHETICS;**36,41,51,57,62,74,81,61,145,150**;Feb 09, 1996;Build 10
 ;
 ;RVD patch #62 - call PCE API to update patient care encounter.
 ;              - add a screen display if no changes to the HCPCS.
 ;RVD patch #74 - call $$STATCHK^ICPTAPIU to check if CPT Code is 
 ;                active for a given date.
 ;RVD patch #81 - roll back patch RMPR*3.0*74 and returns the screen
 ;                to the STATUS field of file #661.1.
 ;RVD patch #61 - added screen not to process stock issue entries.
 ;uses DBIA # 1995 & 1997.
 W ! S DIC="^RMPR(660,",DIC(0)="AEMQZ",DIC("A")="Select PATIENT: "
 S DIC("W")="D EN^RMPRD1",RMEND=0
 S DIC("S")="I ($P(^(0),U,6)!($P(^(0),U,26)'="""")),($P(^(0),U,13)'=11)" W !
 D ^DIC G:+Y'>0 EXIT L +^RMPR(660,+Y,0):1 I $T=0 W !,?5,$C(7),"Someone else is Editing this entry!" G EXIT
 ;S (RMPRDA,DA)=+Y,DIE=DIC,DR="[RMPRE2319]" D ^DIE L -^RMPR(660,DA,0)
 S DIE=DIC,(RMPRDA,DA)=+Y
TYP1 ;edit type of transaction....
 S R1(0)=$G(^RMPR(660,RMPRDA,0)),R1(1)=$G(^(1)),R1("AM")=$G(^("AM"))
 S RMTOTCOS=$P(R1(0),U,16)
 S (RMHCPC,RMHCOLD)=$P(R1(1),U,4),(RMTYPE,RMTYPS)=$P(R1(0),U,4),(RMCAT,RMCATS)=$P(R1("AM"),U,3),(RMSPE,RMSPES)=$P(R1("AM"),U,4),RMSOUR=$P(R1(1),U,14)
TRAN K DIR S DIR(0)="660,2"
 ;S DIR("A")="Enter Type of Transaction: "
 S:$D(RMTYPS) DIR("B")=$S(RMTYPS="I":"INITIAL",RMTYPS="X":"REPAIR",RMTYPS="R":"REPLACE",RMTYPS="S":"SPARE",1:"")
 D ^DIR
 I $D(DUOUT)!$D(DTOUT) S RMEND=1 D SETED2 G QED2
 I Y="" W !,"Please enter type of Transaction!!" G TRAN
 S $P(R1(0),U,4)=Y,RMTYPE=Y
 S RMTYPS=$S(Y="I":"INITIAL",Y="X":"REPAIR",Y="R":"REPLACE",Y="S":"SPARE",1:"")
PCAT K DIR S DIR(0)="660,62"
 S:$D(RMCATS) DIR("B")=$S(RMCATS=1:"SC/OP",RMCATS=2:"SC/IP",RMCATS=3:"NSC/IP",RMCATS=4:"NSC/OP",1:"")
 D ^DIR
 I $D(DUOUT)!$D(DTOUT) S RMEND=1 D SETED2 G QED2
 I Y="" W !,"Please enter Patient Category!!" G PCAT
 S RMCAT=Y
 S $P(R1("AM"),U,3)=Y,RMCATS=$S(Y=1:"SC/OP",Y=2:"SC/IP",Y=3:"NSC/IP",Y=4:"NSC/OP",1:"")
 K DIR I RMCAT<4 S $P(R1("AM"),U,4)="" G HCPC
 S DIR(0)="660,63"
 S:$D(RMSPES) DIR("B")=$S(RMSPES=1:"SPECIAL LEGISLATION",RMSPES=2:"A&A",RMSPES=3:"PHC",RMSPES=4:"ELIGIBILITY REFORM",1:"")
 I RMCAT=4 D ^DIR I $D(DUOUT)!$D(DTOUT) S RMEND=1 D SETED2 G QED2
 I RMCAT=4 S $P(R1("AM"),U,4)=Y,RMSPE=Y,RMSPES=$S(Y=1:"SPECIAL LEGISLATION",Y=2:"A&A",Y=3:"PHC",Y=4:"ELIGIBILITY REFORM",1:"")
 K DIR
 ;
HCPC ;set type and ask item and HCPCS
 D SETED2
 ;ask source
 N SRC
 S SRC=$P(R1(0),U,14)
 S DIE("NO^")="BACK"
 S DR="12;4;4.5" D ^DIE
 K DIE("NO^")
 I $D(DUOUT)!$D(DTOUT)!$D(Y) S RMEND=1 G QED2
 S R1(0)=$G(^RMPR(660,RMPRDA,0)),R1(1)=$G(^(1))
 I $P(R1(0),U,14)'=SRC S RMHCOLD=""
 S RMHCPC=$P(R1(1),U,4)
 W !,"OLD CPT MODIFER: ",$P(R1(1),U,6)
 ;if HCPCS was changed, Modifier must be changed
 I RMHCOLD'=RMHCPC D
 .S RDA=RMHCPC_"^"_$P(R1(0),U,4)_"^"_$P(R1(0),U,14)_"^"_660
 .D CPT^RMPRCPTU(RDA) S $P(^RMPR(660,RMPRDA,1),U,6)=RMCPT
 .W !,"NEW CPT MODIFIER: ",RMCPT
 ;if HCPCS the same, ask user if want to edit modifier.
 E  D
 .S DIR(0)="Y",DIR("B")="N",DIR("A")="Would you like to edit the CPT Modifier "
 .D ^DIR Q:$D(DUOUT)!$D(DTOUT)
 .I (Y>0) D
 ..S RDA=RMHCPC_"^"_$P(R1(0),U,4)_"^"_$P(R1(0),U,14)_"^"_660
 ..D CPT^RMPRCPTU(RDA) S $P(^RMPR(660,RMPRDA,1),U,6)=RMCPT
 ..K DIR
 ..W:RMCPT=$P(R1(1),U,6) !!,"***Based on the information given above, CPT modifier string has not changed!!!",!
 ..W:RMCPT'=$P(R1(1),U,6) !,"NEW CPT MODIFIER: ",RMCPT
 S DR="9;21;16;28" D ^DIE
 I RMTOTCOS'=$P(^RMPR(660,DA,0),U,16) S DR="35////^S X=DUZ;36////^S X=DT" D ^DIE
 I $D(DTOUT)!('$G(Y))!($D(DUOUT)) D CHK
QED2 ;
 Q:$D(RMPREDT)
 L -^RMPR(660,RMPRDA,0)
 K DIR W ! S DIR(0)="Y",DIR("A")="Would You like to Edit another Entry (Y/N) " D ^DIR
 G:'$D(DTOUT)&(Y>0) RMPRE29
EXIT ;
 N RMPR,RMPRSITE D KILL^XUSCLEAN
 K DIC,DIE,DIR,%,X,Y
 Q
SETED2 ;set 660
 S ^RMPR(660,DA,0)=R1(0),^RMPR(660,DA,1)=R1(1),^RMPR(660,DA,"AM")=R1("AM")
 S DIK="^RMPR(660,",DA=RMPRDA D IX1^DIK K DIC
 D CHK
 Q
 ;
QUICK ;quick edit for HCPCS and type
 K RMCPT
 W ! S DIC="^RMPR(660,",DIC(0)="AEMNQZ",DIC("A")="Select NUMBER, or Patient: "
 S DIC("W")="D EN^RMPRD1"
 S DIC("S")="I $P(^(0),U,6)!($P(^(0),U,26)'="""")" W !
 D ^DIC G:+Y'>0 EXIT L +^RMPR(660,+Y,0):1 I $T=0 W !,?5,$C(7),"Someone else is Editing this entry!" G EXIT
 ;add source
 S (RMPRDA,DA)=+Y,DIE=DIC,DR="2;4.5"
 S R1(0)=$G(^RMPR(660,DA,0)),R1(1)=$G(^RMPR(660,DA,1))
 S RMTYPE=$P(R1(0),U,4),RMSOUR=$P(R1(0),U,14)
 S RMHCOLD=$P(R1(1),U,4)
 D ^DIE G:$D(DUOUT)!$D(DTOUT)!$D(DIROUT)!$D(Y) SET
 S RMHCNEW=$P($G(^RMPR(660,DA,1)),U,4)
 S RMTYPE=$P($G(^RMPR(660,DA,0)),U,4)
 S RDA=RMHCNEW_"^"_RMTYPE_"^"_RMSOUR_"^"_660
 W !,"OLD CPT MODIFER: ",$P(R1(1),U,6)
 I RMHCOLD'=RMHCNEW D
 .D CPT^RMPRCPTU(RDA)
 .W !,"NEW CPT MODIFIER: ",RMCPT
 .S $P(^RMPR(660,DA,1),U,6)=RMCPT
 I RMHCOLD=RMHCNEW D
 .W ! S DIR("B")="N",DIR(0)="Y",DIR("A")="Would You like to Edit CPT MODIFIER " D ^DIR
 .I $D(DTOUT)!('$G(Y)) K DIR Q
 .D CPT^RMPRCPTU(RDA)
 .W:RMCPT=$P(R1(1),U,6) !!,"***Based on the information given above, CPT modifier string has not changed!!!",!
 .W:RMCPT'=$P(R1(1),U,6) !,"NEW CPT MODIFIER: ",RMCPT
 .S $P(^RMPR(660,DA,1),U,6)=RMCPT
SET K DIR D CHK
 W ! S DIR(0)="Y",DIR("A")="Would You like to Edit another Entry (Y/N)" D ^DIR
 G:'$D(DTOUT)&(Y>0) QUICK^RMPRE29
 L -^RMPR(660,RMPRDA,0)
 D KILL^XUSCLEAN Q
 ;
CHK ;check for transaction changes
 S RMTYPE=$P($G(^RMPR(660,RMPRDA,0)),U,4)
 S RMHCPC=$P($G(^RMPR(660,RMPRDA,1)),U,4) Q:'$G(RMHCPC)
 S RMCPT1=$P($G(^RMPR(661.1,RMHCPC,4)),U,1)
 S RMCPT=$P($G(^RMPR(660,RMPRDA,1)),U,6)
 I ((RMTYPE="R")!(RMTYPE="X")),(RMCPT'["RP"),($G(^RMPR(661.1,RMHCPC,4))["RP") D ADDRP
 I ((RMTYPE="I")!(RMTYPE="S")),(RMCPT["RP") D DELRP
 I (RMSOUR="C"),(RMCPT["RR") D DELNU
 I (RMSOUR="C"),(RMCPT'["RR"),(RMCPT1["NU"),(RMCPT'["N") D ADDNU
 K RMHCPC,RMCI,RMC,RMCLEN,RMLPIECE,RMF,RMFPIECE,RMTYPE,RMPRA,R4DA Q
 ;return to EDIT option
DELRP ;logic for deleting 'RP' modifier with transaction change.
 F RMCI=1:1:8 S RMC=$P(RMCPT,",",RMCI) I RMC="RP" S $P(RMCPT,",",RMCI)="" D
 .S RMF=$F(RMCPT,",,"),RMFPIECE=$E(RMCPT,1,RMF-2)
 .S RMLPIECE=$E(RMCPT,RMF,32),RMCPT=RMFPIECE_RMLPIECE,RMCLEN=$L(RMCPT)
 .I $E(RMCPT,1)="," S RMCPT=$E(RMCPT,2,RMCLEN)
 .I $E(RMCPT,RMCLEN)="," S RMCPT=$E(RMCPT,1,RMCLEN-1)
 .S $P(^RMPR(660,RMPRDA,1),U,6)=RMCPT
 Q
DELNU ;logic for deleting 'NU' modifier.
 F RMCI=1:1:8 S RMC=$P(RMCPT,",",RMCI) I RMC="NU" S $P(RMCPT,",",RMCI)="" D
 .S RMF=$F(RMCPT,",,"),RMFPIECE=$E(RMCPT,1,RMF-2)
 .S RMLPIECE=$E(RMCPT,RMF,32),RMCPT=RMFPIECE_RMLPIECE,RMCLEN=$L(RMCPT)
 .I $E(RMCPT,1)="," S RMCPT=$E(RMCPT,2,RMCLEN)
 .I $E(RMCPT,RMCLEN)="," S RMCPT=$E(RMCPT,1,RMCLEN-1)
 .S $P(^RMPR(660,RMPRDA,1),U,6)=RMCPT
 Q
 ;
ADDRP ;logic for adding 'RP' modifier with transaction change.
 S RMCPT=RMCPT_",RP" S $P(^RMPR(660,RMPRDA,1),U,6)=RMCPT
 Q
ADDNU ;logic for adding 'NU' modifier.
 S RMCPT=RMCPT_",NU" S $P(^RMPR(660,RMPRDA,1),U,6)=RMCPT
 Q
 ;END
