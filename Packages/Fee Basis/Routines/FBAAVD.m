FBAAVD ;AISC/DMK-DISPLAY/EDIT VENDOR DEMOGRAPHICS ; 8/28/09 12:35pm
 ;;3.5;FEE BASIS;**9,98,111,122**;JAN 30, 1995;Build 8
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;FBTEMP set = 1 if called from input template
RDV ;ask vendor
 W ! K DFN,FBRATE S FEEO="",DIC="^FBAAV(",DIC(0)="AEQLM",DLAYGO=161.2,DIC("DR")="1;6;7;8" D ^DIC K DIC,DLAYGO G Q:$D(DTOUT)!(X="")!($D(DUOUT)),RDV:Y<0 S DA=+Y
 D NEW:$P(Y,U,3)=1 D EN1
 I $G(DA) W ! I $D(^XUSEC("FBAA ESTABLISH VENDOR",DUZ)) S DIR(0)="Y",DIR("B")="No",DIR("A")="Want to edit data" D ^DIR K DIR I $G(Y) D EDITV
 Q:$G(FBTEMP)
 G RDV
 ;
EN1 ;display vendor demographics
 ;DA = IEN of vendor in file 161.2
 ;
 N C,I
 Q:'$G(DA)
 S Z=$G(^FBAAV(DA,0)),V=$G(^(1)),T=$G(^("AMS")),A=$G(^("ADEL")),FBNPI=$P($G(^(3)),U,2),FBTXC=$P($G(^(3)),U,3)
 F X=1:1:17 S Z(X)=$P(Z,U,X)
 S FBDEL=$S($P(A,U)="Y":1,1:0),FBAAPN=$P(V,U),FBAAFN=$P(V,U,9)
 ;Z=zero node,V=one node,T=ams node,A=adel node
 ;
 S IOP=$S($D(ION):ION,1:"HOME") D ^%ZIS W @IOF K IOP
 I +$G(DFN)>0 W !,"Patient Name: ",$P($G(^DPT(DFN,0)),U),?48,"Pt.ID: ",$$SSN^FBAAUTL(DFN),!
 W !?22,"***  VENDOR DEMOGRAPHICS  ***" D
 .I FBDEL W !?19,"==> FLAGGED FOR DELETION <==" Q
 .I $$CKVEN^FBAADV(DA) W !?20,"==> AWAITING AUSTIN APPROVAL <=="
 W !!,$J("Name:",13),?15,$E(Z(1),1,30),?47,"ID Number: ",Z(2)
 W !?40,"Billing Prov NPI: ",FBNPI
 W !?31,"Billing Prov Taxonomy code: ",FBTXC ;FB*3.5*122
 W !,$J("Address:",13),?15,Z(3),?47,"Specialty: ",$E($P($G(^FBAA(161.6,+Z(8),0)),U),1,20)
 I Z(14)]"" W !,$J("Address [2]:",13),?15,Z(14)
 W !,$J("City:",13),?15,Z(4),?52,"Type:",?58,$P($P(^DD(161.2,6,0),Z(7)_":",2),";")
 ;
 W !,$J("State:",13),?15,$P($G(^DIC(5,+Z(5),0)),U),?38,"Participation Code:",?58,$S($D(^FBAA(161.81,+Z(9),0)):$E($P(^(0),U),1,21),1:"UNKNOWN")
 W !,$J("ZIP:",13),?15,Z(6),?38,"Medicare ID Number:",?59,Z(17)
 W !,$J("County:",13),?15,$P($G(^DIC(5,+Z(5),1,+Z(13),0)),U)
 W ?51,"Chain: ",Z(10)
 W !,$J("Phone:",13),?15,FBAAPN,!,$J("Fax:",13),?15,FBAAFN
 W:$P(T,U,2)="Y" ?44,"Pricer Exempt: Yes"
 W !,$J("Type (FPDS):",13),?15,$$EXTERNAL^DILFD(161.2,24,"",$P(V,U,10))
 S (C,I)=0 F  S I=$O(^FBAAV(DA,2,I)) Q:'I  D
 . S X=$P($G(^FBAAV(DA,2,I,0)),U) Q:'X
 . S X=$$GET1^DIQ(420.6,X,1) Q:X=""
 . S C=C+1
 . I '(C#2) W !,$J("Group (FPDS):",13),?15,$E(X,1,21)
 . I (C#2) W ?44,"Group (FPDS):",?59,$E(X,1,21)
 W !,$J("Austin Name:",13),?15,$P(T,U)
 W !,$J("Last Change ",13),?43,"Last Change" I $P(A,U,5)]"" W " by ",$S($P(A,U,5)="000":"Non-Fee User",1:"Station "_$P(A,U,5))
 W !,$J("TO Austin:",13),?15,$$DATX^FBAAUTL($P(A,U,2))
 W ?45,"FROM Austin:  ",$$DATX^FBAAUTL($P(A,U,4))
 ;
 I Z(9)=5 D ^FBAAVD1
 K A,T,V,Z,FBAAFN
 Q
 ;
NEW ;called when adding a new vendor
 Q:'$G(DA)
 S FBT="N",DIE="^FBAAV(",DR="[FBAA NEW VENDOR]" D ^DIE S Y=$G(^FBAAV(DA,0)) S FBOVEN="" D  I +FBOVEN K FBOVEN W ! S DR="3;4;5;5.5" D ^DIE K DIE,DR D CHKVEN Q:'$G(DA)
 .I $P(Y,U,4)']"" S FBOVEN=1
 .I '$P(Y,U,5) S FBOVEN=$S(+FBOVEN:FBOVEN_"^"_2,1:2)
 .I $P(Y,U,6)']"" S FBOVEN=$S(+FBOVEN:FBOVEN_"^"_3,1:3)
 .I $P(Y,U,13)']"" S FBOVEN=$S(+FBOVEN:FBOVEN_"^"_4,1:4)
 .I +FBOVEN D  K XX,X
 ..W !!?9,"The following data must be entered when adding a new vendor:",!
 ..W !?28,">>> W A R N I N G <<<",!?14,"Entering an '^' at this point will delete vendor!",!
 ..F XX=1:1 S X=$P(FBOVEN,U,XX) Q:'X  D
 ...W !?8,$P($T(ERROR+X),";;",2)
 D SETGL
 S FBVIEN=DA D CONTR^FBAAVD2 S DA=FBVIEN Q
 ;
EDITV ;called when editing an existing vendor
 N FBHDA Q:'$G(DA)
 N FBAAOUT G:$G(FBT)="N" EDITV1 I $D(^FBAA(161.25,DA,0))!($D(^FBAA(161.25,"AF",DA))) W !!?5,*7,"Current Vendor information is pending Austin processing.  Changing Vendor" D  I $G(FBAAOUT) K FBAAOUT Q
 .W !?5,"information at this time may jeopardize the processing of the existing",!?5,"Master Record Adjustment!",! D
 ..S DIR(0)="Y",DIR("A")="Do you wish to continue editing this Vendor",DIR("B")="No" D ^DIR K DIR S:$D(DIRUT)!('Y) FBAAOUT=1
EDITV1 D ^FBAAVD2 K FBCIEN,FBR,FBT
 Q
 ;
SETGL ;called to file an entry in 161.25 (vendor correction file)
 I $S('$G(DA):1,$G(FBT)="C"&('$D(FBIEN1)):1,1:0) Q
 S Z1=$G(^FBAAV(DA,0)),FBTOV=$S($P(Z1,U,7)=3:"P",1:"O")
 I $G(FBT)="N"!($G(FBT)="R") S DIE="^FBAAV(",DR="9///@;13///@" D ^DIE K DIE
 I '$D(^FBAA(161.25,DA,0)) F  L +^FBAA(161.25,DA):$G(DILOCKTM,3) Q:$T  W:'$D(ZTQUEUED) !,"Unable to setup SG MRA transaction.  Trying again."
 K DD,DO S (X,DINUM)=DA,DIC="^FBAA(161.25,",DIC(0)="L",DLAYGO=161.25 D FILE^DICN K DLAYGO L -^FBAA(161.25,DA) Q:Y<0
NEXT L +^FBAA(161.25,DA):$G(DILOCKTM,3) I '$T W:'$D(ZTQUEUED) !,"Unable to setup NEXT MRA transaction.  Trying again.",! G NEXT
 S DIE="^FBAA(161.25,",DR="[FBAA VENDOR MRA]" D ^DIE L -^FBAA(161.25,DA)
 K DIE,DIC,Y
 Q
 ;
Q K DA,DR,DIC,DIE,DIRUT,DTOUT,DUOUT,A,D,FBX,FBOUT,X2,FY,FBAAPN,FEEO,FBDEL,FBPARCD,FBT,FBTOV,FBTV,X,Y,Z0,Z1,Z2,ZZ,FBCNUM,FBID,FBVIEN,FBLIEN,FBAAFN
 Q
ERROR ;edit check text when adding a new vendor
 ;;CITY
 ;;STATE
 ;;ZIP CODE
 ;;COUNTY CODE
CHKVEN ;check if fields 3,4,5,5.5 have been answered. If not delete vendor
 S Y=$G(^FBAAV(DA,0))
 F X=4,5,6,13 I $P(Y,U,X)']"" D  Q
 .S DIK="^FBAAV(" D ^DIK K DIK,DA W !?3,$C(7),".... Vendor deleted",!
 Q
