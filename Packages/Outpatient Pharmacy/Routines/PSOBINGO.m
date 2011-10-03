PSOBINGO ;BHAM ISC/LC - BINGO BOARD OPTION DRIVER ;8/1/07 1:45pm
 ;;7.0;OUTPATIENT PHARMACY;**12,28,56,125,152,232,268,275,326**;DEC 1997;Build 11
 ;External Ref. to ^PS(55 is supp. by DBIA# 2228
 ;External Ref. to ^PSDRUG(, is supp. by DBIA# 221
 ;
 ;*232 add ATIC xref set/kill code here
 ;*275 BA xref sometimes gets corrupted, kill bad BA xref and quit
 ;
 S (FLAG,FLAG1)=0,(TRIPS,JOES,ADV,DGP)="" G:'$G(PSOAP) END D:'$D(PSOPAR) ^PSOLSET G:'$D(PSOPAR) END
BEG ;PSOAP=1 NEW ENTRY; 2=DISPLAY; 3=REMOVE
 D NOW^%DTC S TM=$E(%,1,12),TM1=$P(TM,".",2) G:PSOAP=1 NEW I PSOAP=3 D BCRMV^PSOBING1 G:'$D(X) END
 I PSOAP=3 S DIC=52.11,DIC(0)="EMQZ",DIC("S")="I '$P($G(^PS(52.11,Y,0)),U,8)" D ^DIC K DIC G:+Y'>0 BEG G:($G(DTOUT))!($G(DUOUT)) END S DA=+Y,NAM=Y(0,0)
 I PSOAP=2 W !! K DIC,DIE,DLAYGO S (DIC,DIE)=52.11,DIC(0)="AEMQZ",DIC("A")="Enter Patient Name to Display: ",DIC("S")="I $P($G(^PS(52.11,Y,0)),U,4)=PSOSITE&'$P($G(^PS(52.11,Y,0)),U,7)"
 I PSOAP=2 D ^DIC K DIC G:+Y'>0!($G(DTOUT))!($G(DUOUT)) END S (DA,ODA)=+Y,NAM=Y(0,0)
 I PSOAP=3 D STUF,REMOVE1 G BEG
 I PSOAP=2,($P($G(^PS(52.11,DA,0)),"^",7)]"") W !!,NAM,"  is already in the display queue.",$C(7) G BEG
 I PSOAP=2,$P($P($G(^PS(52.11,DA,0)),"^",5),".")'=DT S Y=$P($P($G(^PS(52.11,DA,0)),"^",5),".") D DD^%DT W !!,$C(7),NAM," was entered on "_Y_".",!,"It can't be displayed and is now deleted." S DIK="^PS(52.11," D ^DIK K DIK G BEG
 I PSOAP=2&($P(^PS(52.11,ODA,0),"^",4)'=+PSOSITE) W !!,$C(7),NAM," was entered under the "_$P(^PS(59,$P(^(0),"^",4),0),"^")_" division." G BEG
 I PSOAP=2 S PSODRF=0 D CREF^PSOBING1 G:PSODRF BEG D  G BEG
 .S NM=$P(^DPT($P(^PS(52.11,ODA,0),"^"),0),"^"),DR="6////"_$E(TM1_"0000",1,4)_";8////"_NM_""
 .D PASS,SETUP S DA=ODA D STATS1^PSOBRPRT,WTIME^PSOBING1
NEW ;Init lookup
 W !! K DIC S DIC=2,DIC(0)="QEAM",DIC("A")="Enter Patient Name : " D EN^PSOPATLK S Y=PSOPTLK K DIC,PSOPTLK G:Y<0!($G(DUOUT))!($G(DTOUT)) END S (DA,ADA,DFN)=+Y D DEM^VADPT Q:VAERR  S NAM=VADM(1),SSN=$P(VADM(2),"^")
 K DD,DO S:$D(DISGROUP) DGP=$P($G(^PS(59.3,DISGROUP,0)),"^") S (DIC,DIE)="^PS(52.11,",X=ADA,DIC("DR")=$S($G(GROUPCNT)=1&($G(DISGROUP)):"2////"_DISGROUP_"",1:"2//^S X=DGP")
 S DIC(0)="LMNQZ",DLAYGO=59.3 D FILE^DICN K DD,DO,DIC G:Y'>0 NEW
 S JOES=$P(Y(0),"^",3),ADV=$P($G(^PS(59.3,JOES,0)),"^",2),DA=+Y
 I $G(DTOUT)!($G(DUOUT))!(X="") D WARN G NEW
TIC K TFLAG I ADV="T" S DIR(0)="NA^1:999999:0",DIR("A")="TICKET #:",DIR("?")="Ticket # must be numeric and unique" D ^DIR I $D(DUOUT)!($D(DTOUT))!($D(DIRUT)) D WARN G BEG
 S TFLAG=1 I PSOAP=1,$G(ADV)="T" W !! S TIC=+Y D
 .F TIEN=0:0 S TIEN=$O(^PS(52.11,"C",TIC,TIEN)) Q:'TIEN  I DA'=TIEN,($G(PSOSITE)=+$P(^PS(52.11,TIEN,0),"^",4)) D
 ..S TDFN=$P(^PS(52.11,TIEN,0),"^"),TSSN=$P(^PS(52.11,TIEN,1),"^",2),TFLAG=0 W !,$C(7),$P(^DPT(TDFN,0),"^")_" ("_TSSN_") was issued ticket # "_TIC,". Try again!",!
 .K TDFN,TIEN,TSSN Q:'TFLAG
 G:'TFLAG TIC I ADV="T" S DR="1////"_TIC_";3////"_PSOSITE_";4////"_TM_";5////"_$E(TM1_"0000",1,4)_";8////"_NAM_";9////"_SSN_";13////0",FLAG1=1 G PASS
 S DR="3////"_PSOSITE_";4////"_TM_";5////"_$E(TM1_"0000",1,4)_";8////"_NAM_";9////"_SSN_";13////0"
PASS S NFLAG=1 L +^PS(52.11,DA):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) E  W !!,$C(7),Y(0,0)," is being edited!",! Q
 D ^DIE L -^PS(52.11,DA) I $G(DUOUT)!($G(DTOUT))!(X="") D WARN G BEG
 S:$G(PSOAP)=1 FLGG=0 G:$G(PSOAP)'=1 STRX1
STRX ;sto Rx #'s IN 52.11
 N BRXNUM,BBFTYP,BBFNUM,BBMW,MWDIR,II,FL,FLN,PR,PRN,PRNDT,FLNDT,Y
STRX0 S DIR(0)="FO^1:11",DIR("A")="Enter Rx #",DIR("?")="^D HELP^PSOBINGO",DIR("??")="^D HELP2^PSOBINGO" D ^DIR G:X=""&($G(FLGG)) STRX1 I $D(DIRUT) D WARN G BEG
 S DIC=52,DIC(0)="EQM",DIC("S")="I $P($G(^PSRX(Y,0)),U,2)=ADA" D ^DIC K DIC I $D(DUOUT)!($D(DTOUT)) D WARN G BEG
 G:Y=-1 STRX0
 I $G(Y)<0&('$G(FLGG)) D WARN G BEG
 I $G(Y)<0&($G(FLGG)) G STRX1
 S BRXNUM=$P(Y,"^")
 I $D(^PSRX(BRXNUM,1,0)) F II=0:0 S II=$O(^PSRX(BRXNUM,1,II)) Q:'II  S FLN=II
 I $D(FLN) S FLNDT=$P(^PSRX(BRXNUM,1,FLN,0),"^"),FL="F"
 I $D(^PSRX(BRXNUM,"P",0)) F II=0:0 S II=$O(^PSRX(BRXNUM,"P",II)) Q:'II  S PRN=II
 I $D(PRN) S PRNDT=$P(^PSRX(BRXNUM,"P",PRN,0),"^"),PR="P"
 S:$D(FLN)!($D(PRN)) BBFTYP=$S($G(PRNDT)>$G(FLNDT):PR,1:"F")
 I $G(BBFTYP)="P" S BBFNUM=PRN,BBMW=$P(^PSRX(BRXNUM,"P",PRN,0),"^",2)
 I $G(BBFTYP)="F" S BBFNUM=FLN,BBMW=$P(^PSRX(BRXNUM,1,FLN,0),"^",2)
 I '$D(BBFTYP) S BBFTYP="F",BBFNUM=0,BBMW=$P(^PSRX(BRXNUM,0),"^",11)
MW ;
 I $G(BBMW)="M" W !?5,$C(7),"Routing is set for Mail" D DIR
 I $D(MWDIR) K BRXNUM,BBFTYP,BBFNUM,BBMW,MWDIR,II,FL,FLN,PR,PRN,PRNDT,FLNDT,Y G STRX
 ;
 S X=BRXNUM,DIC("DR")="1////"_BBFTYP_";2////"_BBFNUM_"",DLAYGO=52.11
 S DA(1)=DA,DIC="^PS(52.11,"_DA(1)_",2,",DIC(0)="L",DIC("P")=$P(^DD(52.11,12,0),"^",2) K DD,DO D FILE^DICN K Y,DD,DO,X,BRXNUM,BBFTYP,BBFNUM,II,FL,PR,PRNDT,FLNDT S FLGG=1 G STRX
 ;
STRX1 D:PSOAP=1&($G(ADV)="N") CHKUP,NOTE G:'NFLAG BEG D STUF G:FLAG BEG Q:PSOAP=2
SETUP S ZZZ=0 I '$D(^PS(59.2,DT,0)) K DD,DIC,DO,DA S X=DT,DIC="^PS(59.2,",DIC(0)="",DINUM=X,DLAYGO=59.2 D FILE^DICN K DD,DO S ZZZ=1 Q:Y'>0
 I ZZZ=1 K DD,DO S DLAYGO=59.2,DA(1)=+Y,DIC=DIC_DA(1)_",1,",(DINUM,X)=PSOSITE,DIC(0)="",DIC("P")=$P(^DD(59.2,1,0),"^",2) D FILE^DICN K DD,DO,DIC,DA Q:Y'>0
 Q:PSOAP=2&($P($G(^PS(59.2,DT,1,PSOSITE,0)),"^"))  I ZZZ=0 K DD,DIC,DO,DA S DA(1)=DT,(DINUM,X)=PSOSITE,DIC="^PS(59.2,"_DT_",1,",DIC(0)="LZ",DLAYGO=59.2 D FILE^DICN K DD,DIC,DA,DO Q:PSOAP=2  G NEW
 G BEG
STUF S RX0=^PS(52.11,DA,0),JOES=$P(RX0,"^",4),TICK=$P($G(RX0),"^",2) Q:PSOAP=3  G:ADV="T"&($G(FLAG1)=1)&('$G(TICK)) WARN G:'$G(JOES)!($G(NAM)']"") WARN
 W:PSOAP=2 !!,"Patient added in display queue." W:PSOAP=1 !!,"Record is added." Q
WARN W !!!,$C(7),"Patient record incomplete!" S FLAG=1,DIK="^PS(52.11," D ^DIK G SHOW Q
REMOVE S DIK="^PS(52.11," D ^DIK
SHOW K DIK,DA,ADA W !!,"Record is removed."
 Q
REMOVE1 ;
 Q:'$D(^PS(52.11,"ANAM",$P(^PS(52.11,DA,0),"^",3),$P(^(1),"^",3)_$P(^(1),"^",4)_" "_$P(^DPT(+$P(^PS(52.11,DA,0),"^"),0),"^"),DA))
 N DIE,DR I $D(^PS(52.11,"ANAM",$P(^PS(52.11,DA,0),"^",3),$P(^(1),"^",3)_$P(^(1),"^",4)_" "_$P(^DPT(+$P(^PS(52.11,DA,0),"^"),0),"^"),DA)) S DIE="^PS(52.11,",DR="7////1" D
 .D ^DIE
 .K ^PS(52.11,"ANAM",$P(^PS(52.11,DA,0),"^",3),$P(^(1),"^",3)_$P(^(1),"^",4)_" "_$P(^DPT(+$P(^PS(52.11,DA,0),"^"),0),"^"),DA)
 I $D(^PS(52.11,"ATIC",+$P(^PS(52.11,DA,0),"^",3),+$P(^(0),"^",2),DA)) S DIE="^PS(52.11,",DR="7////1" D
 .D ^DIE
 .K ^PS(52.11,"ATIC",+$P(^PS(52.11,DA,0),"^",3),+$P(^(0),"^",2),DA)
 Q
CHKUP ;Multi & dupe names
 S SDA=DA S:'$D(DFN) DFN=PSODFN G:$O(^PS(52.11,"B",DFN,0))=DA BROW F P=0:0 S P=$O(^PS(52.11,"B",DFN,P)) Q:'P!(P=DA)  S LAST=P
 Q:'$G(LAST)  S TRIPS=$P($G(^PS(52.11,LAST,1)),"^",4) I TRIPS]"" S TRIPS=$A(TRIPS),TRIPS=TRIPS+1,TRIPS=$C(TRIPS) S DR="11////"_TRIPS_"" D ^DIE S F1=1 G BROW
 K TRIPS
FIRST ;Set 1st dup
 S DR="11////A" D ^DIE K DR,CNT
BROW S DA=SDA,NOPE=0,CNT=0
 F NIEN=0:0 S NIEN=$O(^PS(52.11,"BA",NAM,NIEN)) Q:'NIEN!(NIEN=$G(DA))  D  Q:NOPE
 . ;add check for bad xref and kill        *275
 . I '$D(^PS(52.11,NIEN,0)) K ^PS(52.11,"BA",NAM,NIEN) Q
 . D:$D(^PS(52.11,"BI")) BICK Q:CNT>0
 . D SETNEW
 Q
SETNEW S SSN1=$O(^PS(52.11,"BA",NAM,NIEN,0)),ADFN=$P(^PS(52.11,NIEN,0),"^"),CNT=1 I SSN1=SSN S NOPE=1 Q
 S DR="10////1" D ^DIE S F1=1 Q
BICK ;Chks "BI" Xref & assigns seq#
 S SSN1=$O(^PS(52.11,"BA",NAM,NIEN,0)) I SSN1=SSN&('$P($G(^PS(52.11,SDA,1)),"^",3)) S NOPE=1 Q
 S CNT=0 I $D(^PS(52.11,"BI",DFN)) S CNT=$O(^(DFN,0)),DA=SDA,DR="10////"_CNT_"" D ^DIE S F1=1 Q
 F NDFN=0:0 S NDFN=$O(^PS(52.11,"BI",NDFN)) Q:'NDFN  S CNT=$O(^(NDFN,0))+1
 S DR="10////"_CNT_"" D ^DIE S F1=1 Q
NOTE S DFN=$P($G(^PS(52.11,DA,0)),"^"),NFLAG=1 W !!,?5,"NAME",?30,"SSN",?45,"ID",?50,"ORDER"
 F Z=0:0 S Z=$O(^PS(52.11,"B",DFN,Z)) Q:'Z  S ZDA=Z S NODE=$G(^PS(52.11,ZDA,1)),Z1=$P(NODE,"^"),Z2=$P(NODE,"^",3),Z3=$P(NODE,"^",4),Z4=$P(NODE,"^",2) W:NODE'="" !,?5,Z1,?30,Z4,?46,Z2,?52,Z3
 W !! S DIR(0)="F,O",DIR("A")="Press return to add the last prescription or '^' to remove it."
 S DIR("A",1)="Please advise the patient that the above ID # or ORDER Letter",DIR("A",2)="or both will be displayed with his/her name on the Bingo Display",DIR("A",3)=" "
 D ^DIR K DIR K NODE,Z1,Z2,Z3 I $G(DTOUT)!(Y="^") S NFLAG=0 D REMOVE
 Q
DIR K DIR,X,Y S DIR(0)="Y",DIR("A")="Continue ",DIR("B")="N",DIR("?")="Answer YES to continue, NO to bypass"
 D ^DIR K DIR S:$D(DIRUT)!('Y) MWDIR=1 K DIRUT,DTOUT,DUOUT,X,Y
 Q
HELP2 S (PA,PD)="",PL=0 F  S PA=$O(^PS(55,ADA,"P","A",PA)) Q:'PA  D:DT-1<PA
 .F  S PD=$O(^PS(55,ADA,"P","A",PA,PD)) Q:'PD  S PL=PL+1 W !,$P(^PSRX(PD,0),"^"),"      ",$P(^PSDRUG($P(^PSRX(PD,0),"^",6),0),"^")
 .I $G(PL)>15 N DIR S DIR(0)="E",DIR("A")="Press return to continue" D ^DIR K DIR S PL=0
 Q
HELP W !,"Enter the patient's Rx number.",!
 Q
ATICSET ;Set ATIC xref                                                PSO*232
 Q:'+$P(^PS(52.11,DA,0),"^",3)
 Q:'+$P(^PS(52.11,DA,0),"^",2)
 I $P(^PS(59.3,$P(^PS(52.11,DA,0),"^",3),0),"^",2)["T" D
 .S ^PS(52.11,"ATIC",+$P(^PS(52.11,DA,0),"^",3),+$P(^(0),"^",2),DA)=""
 Q
ATICKIL ;Kill ATIC xref                                               PSO*232
 Q:'+$P(^PS(52.11,DA,0),"^",3)
 Q:'+$P(^PS(52.11,DA,0),"^",2)
 I $P(^PS(59.3,$P(^PS(52.11,DA,0),"^",3),0),"^",2)["T" D
 .K ^PS(52.11,"ATIC",+$P(^PS(52.11,DA,0),"^",3),+$P(^(0),"^",2),DA)
 Q
 ;
END K %,ADA,ADFN,ADV,CNT,DA,DATE,DFN,DINUM,DLAYGO,DR,DTOUT,DUOUT,F1,FLAG,FLAG1,FLGG,JOES,LAST,NAM,NDFN,NIEN,NFLAG,NODE,NOPE,NM
 K PSODRF,ODA,P,PSOAP,RX0,TM,TM1,SDA,SSN,SSN1,RX0,TIC,TICK,TFLAG,VADM,X,Y,Z,Z1,Z2,Z3,Z4,ZDA,ZZZ,PL,PD,PA
 Q
