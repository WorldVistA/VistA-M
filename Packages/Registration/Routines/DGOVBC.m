DGOVBC ;ALB/MRL - VBC DRIVER ROUTINE ; 12 FEB 87
 ;;5.3;Registration;**162,279**;Aug 13, 1993
 W ! D DT^DICRW S IOP="HOME" D ^%ZIS K IOP I $D(IOF),IOF']"" W @IOF
1 W ! S DGHOW="S",VAUTNALL="",VAUTNI=2,DIC("S")="S DG36=$S($D(^(.36)):^(.36),1:0) I $S('DG36:1,'$D(^DIC(8,+$P(DG36,U,1),0)):1,$P(^DIC(8,+$P(DG36,U,1),0),U,5)=""Y"":1,1:0)" D PATIENT^VAUTOMA I Y<0 G Q^DGOVBC1
P W !!,"DISPLAY THE FOLLOWING PATIENTS",!,"------------------------------" S DFN=0 F DFN1=0:0 S DFN=$O(VAUTN(DFN)) Q:DFN=""  I $D(^DPT(DFN,0)) S X=^(0),Y=$P(X,"^",3) X:Y]"" ^DD("DD") W !,$P(X,"^",1),?40,Y,?60,$P(X,"^",9)
OK W !!,"IS THIS CORRECT" S %=2 D YN^DICN G QUE:%=1,Q^DGOVBC1:%=2!(%=-1) W !!?4,"Y - If you want to see VBC data for these patients.",!?4,"N - If you want to QUIT and reconsider this action." G OK
2 W ! F I=1:1 S J=$P($T(T+I),";;",2) Q:J']""  W !,J
 D DT^DICRW W !! S DGHOW="A",%DT="EAX",%DT("A")="Start with ADMISSION DATE:  " D ^%DT G Q^DGOVBC1:Y'>0 S (DGFR,DGHFR)=Y,X1=DGFR,X2=-1 D C^%DTC S DGFR=X_".9999"
D S Y=DT,%DT(0)=DGHFR K DGHFR X ^DD("DD") S %DT("A")="     Go to ADMISSION DATE:  "_Y_"// " D ^%DT I X']"" S DGTO=DT_".9999" G M
 G Q^DGOVBC1:Y'>0 S DGTO=Y_".9999" I DGFR>DGTO W !?4,"TO DATE CAN'T BE BEFORE FROM DATE!!",*7,! G D
M S DGDFN=DGFR_"^"_DGTO
 ;Ask division (sets VAUTD)
 W ! Q:'$$ASKDIV^DGUTL()
QUE W !!,*7,"Note: This report requires a column width of 132." S DGPGM=DGHOW_"^DGOVBC",DGVAR="DUZ^DGDFN^VAUTN#^VAUTD#" D ZIS^DGUTQ G Q^DGOVBC1:POP U IO
 G @DGPGM
S D SET S DFN=0 F DFN1=0:0 S DFN=$O(VAUTN(DFN)) Q:DFN=""  I $D(^DPT(DFN,0)),$P(^(0),"^",1)]"" S ^UTILITY($J,"DGOVBC",$P(^DPT(DFN,0),"^",1))=DFN
 G ^DGOVBC1
A D SET S DGFR=$P(DGDFN,"^",1),DGTO=$P(DGDFN,"^",2) F I=0:0 S DGFR=$O(^DGPM("AMV1",DGFR)) Q:'DGFR!(DGFR>DGTO)  F DFN=0:0 S DFN=$O(^DGPM("AMV1",DGFR,DFN)) Q:'DFN  F DGCA=0:0 S DGCA=$O(^DGPM("AMV1",DGFR,DFN,DGCA)) Q:'DGCA  I $D(^DGPM(DGCA,0)) D A1
 G ^DGOVBC1
A1 I $D(^DPT(DFN,0)),$P(^(0),"^",1)]"",$D(^DPT(DFN,.36)) S X=$P(^(.36),"^",1) I $D(^DIC(8,+X,0)),$P(^(0),"^",5)="Y" D
 .I 'VAUTD S DGWD=+$P($G(^DGPM(DGCA,0)),U,6) Q:'DGWD  S DGWD=+$P($G(^DIC(42,DGWD,0)),U,11) Q:'$D(VAUTD(DGWD))
 .S ^UTILITY($J,"DGOVBC",$P(^DPT(DFN,0),"^",1))=DFN
 Q
SET S U="^",DGHD=$S($D(^DD("SITE"))#2:^("SITE"),1:"")_$S($D(^DD("SITE",1)):" ("_^(1)_")",1:""),DGHD1=1-$L(DGHD)-1,DGLIN="",$P(DGLIN,"=",131)="" K ^UTILITY($J,"DGOVBC") Q
ERR S Y=-1 K DIC,SDALL,SDEF Q
T ;
 ;;This option is used to generate the 'VETERANS ASSISTANCE UNIT RECORD' for any 
 ;;veterans admitted during a specified date range.  The user will be prompted to
  ;;select the 'Start with' and 'Go To' range for admissions and the DEVICE desired 
 ;;for output.  A VBC document will be generated only for those patients admitted
 ;;during the requested timeframe who are veterans.         
