DGPTFFB ;ALB/JDS - FEE BASIS PTF ; 26 JUN 87
 ;;5.3;Registration;;Aug 13, 1993
 ;
EN D LO^DGUTL F DGDUMB=0:0 K DGPTOUT D SEL Q:$D(DGPTOUT)
 K DIPGM,DISYS,DN,DGPTOUT,DGDUMB Q
 ;
SEL ; -- ask for pt
 W ! K DIC
 S DIC(0)="AEQMZ",DIC("A")="Enter Non-VA PTF Patient: ",DIC="^DPT("
 D ^DIC K DIC I Y'>0 S DGPTOUT="" G SELQ
 S (DA,DFN)=+Y D INFO
 ;
AD ; -- ask for adm date
 R !!,"Enter NEW Non-VA PTF Admission Date: ",X:DTIME G SELQ:(U[X)!('$T) S %DT="XETP" D ^%DT G AD:Y<2000000 S DGADM=+Y D CHK G AD:'Y
 ;
 ; -- create new PTF rec
 S Y=1 D RTY^DGPTUTL S Y=DGADM_"^1" D CREATE^DGPTFCR S PTF=+Y
 ;
 ; -- go to load edit
 S DGREL=$S($D(^XUSEC("DG PTFREL",DUZ)):1,1:0),DGADPR=9999999,DGPR=0,DGST=0,DGPTFE=1 K DGDFN
 D INCOME^DGPTUTL1,GETD^DGPTF
 ;
SELQ K DGADM,DGPTF,POP,D0,C,DN,PTF,DFN,DGREL,DA,DGADPR,DGDD,DGDFN,DIC,DIE,DIK,DR,I,L,X,Y,DGRTY,DGRTY0
 Q
 ;
INFO ; -- brief PTF rec profile for DFN pt
 ; -- is template compiled?
 S X="DGPTXB" X ^%ZOSF("TEST") K DXS G INFOQ:'$T
 S IOP="HOME" D ^%ZIS K IOP D PID^VADPT6
 W @IOF,?5,"****   PTF Record Profile for ",$E($P(Y(0),U),1,25),"  (",VA("PID"),")  ****"
 D HEAD^DGPTXB K DGPTX S DGPTCNT=0,DGPTMAX=$S($D(DGPTMAX):+DGPTMAX,1:15)
 ; -- sort in inverse date order
 F I=0:0 S I=$O(^DGPT("B",DFN,I)) Q:'I  I $D(^DGPT(I,0)) S DGPTX(9999999.999999-$P(^(0),"^",2),I)=""
 ; -- display data
 I $D(DGPTX) F DGPTX=0:0 S DGPTX=$O(DGPTX(DGPTX)) Q:'DGPTX  S DGPTCNT=DGPTCNT+1 Q:DGPTCNT>DGPTMAX  F PTF=0:0 S PTF=$O(DGPTX(DGPTX,PTF)) Q:'PTF  S D0=PTF K DXS D ^DGPTXB W !
 I DGPTCNT>DGPTMAX W !?5,"...only last ",DGPTMAX," records are displayed."
 I '$D(DGPTX) W !?5," No PTF records on file for patient."
INFOQ K DXS,DGPTCNT,DGPTX,VA,D0,PTF,DGPTMAX
 Q
 ;
CHK ; -- check if adm on date already exists
 K Y
 F I=0:0 S I=$O(^DGPT("B",DFN,I)) Q:'I  I $D(^DGPT(I,0)),$P(DGADM,".")=$P($P(^(0),U,2),".") S Y=$P(^(0),U,2) Q
 I '$D(Y) S Y=1 G CHKQ
 X ^DD("DD") W !!,*7,"PTF #",I," already exist for that admission date (",Y,").",!
 S DIR(0)="Y",DIR("A")="Do you still want to create a new PTF"
 S DIR("?",1)="Answer 'Yes' to add a new PTF record"
 S DIR("?",2)="       'NO'  to not add another PTF record"
 S DIR("?")=" "
 S DIR("B")="NO" D ^DIR K DIR
CHKQ Q
