SDDPA ;MAN/GRR,ALB/TMP - DISPLAY APPOINTMENTS ; 13 SEP 84  4:21 pm
 ;;5.3;Scheduling;**140,334,545**;Aug 13, 1993;Build 8
 D:'$D(DT) DT^SDUTL K SDACS
RD Q:$D(SDACS)  S HDT=DT,APL="",SDRG=0,SDEDT=""
 K ^UTILITY($J) W ! S SDEND=0,DIC="^DPT(",DIC(0)="AEQM" D ^DIC G:X=""!(X="^") END I Y<0 W !,*7,*7,"PATIENT NOT FOUND",*7,*7 G RD
 S DA=+Y,DFN=DA,NAME=$P(Y,"^",2)
RD1 S %=1,DTOUT=0 W !,"Do you want to see only pending appointments" D YN^DICN G:%<0!$T RD I '% W !,"Respond YES or NO" G RD1
 S (SDONE,POP)=0,SDYN=% D:SDYN=2 RANGE G:POP RD
 S DGVAR="BEGDATE^ENDATE^SDYN^DFN^HDT^APL^SDRG^SDONE^SDEDT^SDEND",DGPGM="1^SDDPA" D ZIS^DGUTQ G:POP SDDPA D 1 G SDDPA
1 U IO S SDSTR=$S($D(^DPT(DFN,0)):^(0),1:""),SDN=$P(SDSTR,U)
 S SDSSN=$P(SDSTR,U,9),%DT="R",X="N" D ^%DT
 W !,"APPOINTMENTS FOR: ",$E(SDN,1,22)
 W ?42,$E(SDSSN,1,3),"-",$E(SDSSN,4,5),"-",$E(SDSSN,6,9)
 W ?54,"PRINTED: ",$$FMTE^XLFDT(Y,"5")
 G:$O(^DPT(DFN,"S",HDT))'>0 NO S NDT=HDT,L=0
EN1 F J=1:1 S NDT=$O(^DPT(DFN,"S",NDT)) Q:NDT'>0!(SDRG&(NDT>SDEDT))  I $S($P(^(NDT,0),"^",2)']"":1,$P(^(0),"^",2)["NT":1,$P(^(0),"^",2)["I":1,SDRG:1,1:0) D CHKSO,FLEN S ^UTILITY($J,L)=NDT_"^"_SC_"^"_COV_"^"_APL_"^^"_SDNS_"^"_SDBY
 G:L'>0 NO F ZZ=1:1:L S AT=$S($P(^UTILITY($J,ZZ),"^",2)'?.N:1,1:0) W !! S Y=$P($P(^(ZZ),"^",1),".",1) D DT^SDM0 S X=$P(^(ZZ),"^",1) X ^DD("FUNC",2,1) W " ",$J(X,8) D MORE Q:SDEND
 G END
 ;
NO W !,"NO ",$S('SDRG:"PENDING APPOINTMENTS",1:"APPOINTMENTS FOUND DURING RANGE SELECTED")
 G END
RANGE D DATE^SDUTL Q:POP  S HDT=BEGDATE,SDEDT=ENDDATE_.9,SDRG=1,SDONE=0
 I $D(^DPT(DFN,"ARCH","AB","S")) S X=$O(^("S",0)) I $D(^DPT(DFN,"ARCH",X)) F A=0:0 S A=$O(^DPT(DFN,"ARCH",X,1,A)) Q:A'>0  S Z=^(A,0),B=$P(Z,"^",3),C=$P(Z,"^",4),D=$P(Z,"^",5),E=$P(Z,"^",2) I B'<HDT&(B'>SDEDT)!(C'<HDT&(C'>SDEDT)) D ARCH
 Q
ARCH I 'SDONE W @IOF,!!,"This patient has archived appts during this time period:",! W !,?3,"ARCHIVED DATE RANGE    # APPOINTMENTS     TAPE #      DATE ARCHIVED",!
 W !,?3,$S(B:$$FMTE^XLFDT(B,"5D"),1:""),"-",$S(C:$$FMTE^XLFDT(C,"5D"),1:""),?32,+D,?45,E S Y=+Z D DTS^SDUTL W ?59,Y
 S SDONE=1 K B,C,D,E,Z Q
FLEN ;following code changed with SD/545
 S SC=+^DPT(DFN,"S",NDT,0),L=L+1,COV=$S($P(^DPT(DFN,"S",NDT,0),U,11)=1:" (COLLATERAL) ",1:"") I $D(^SC(SC,"S",NDT)) F ZL=0:0 S ZL=$O(^SC(SC,"S",NDT,1,ZL)) Q:ZL=""  D
 .N POP S POP=0
 .I '$D(^SC(SC,"S",NDT,1,ZL,0)) I $D(^SC(SC,"S",NDT,1,ZL,"C")) D RESET I POP S APL=APLEN Q
 .I +^SC(SC,"S",NDT,1,ZL,0)=DFN S APL=$P(^SC(SC,"S",NDT,1,ZL,0),U,2)
 K POP,APLEN
 Q
 ;
RESET ;reset zero node of appt multiple in file #44 if values are known SD/545
 I 'DFN S POP=1 Q
 I '$D(^DPT(DFN,"S",NDT,0)) S POP=1 Q
 I '$G(^DPT(DFN,"S",NDT,0)) S POP=1 Q
 I '+^DPT(DFN,"S",NDT,0) S POP=1 Q
 I $P(^DPT(DFN,"S",NDT,0),U,2)="CA"!($P(^(0),U,2)="PC")!($P(^(0),U,2)="PCA") K ^SC(SC,"S",NDT,1,ZL,"C") S APLEN=+^SC(SC,"SL"),POP=1 Q
 S (NODE,APLEN,STAT1)=""
 S NODE=^DPT(DFN,"S",NDT,0),APLEN=+^SC(SC,"SL"),STAT1=$P(NODE,U,2)
 S DA=ZL,DA(1)=NDT,DA(2)=SC
 S DIE="^SC("_DA(2)_",""S"","_DA(1)_",1,"
 S DR=".01///^S X=DFN;1///^S X=APLEN" D ^DIE
 S SC=DA(2)
 S $P(^SC(SC,"S",NDT,1,ZL,0),U,6)=$P(NODE,U,18)
 S $P(^SC(SC,"S",NDT,1,ZL,0),U,7)=$P(NODE,U,19)
 I STAT1="C" S $P(^SC(SC,"S",NDT,1,ZL,0),U,9)=STAT1
 K NODE,APLEN,STAT1,DA,DR,DIE
 Q
 ;
CHKSO S SDNS=$S($P(^DPT(DFN,"S",NDT,0),"^",2)']""!($P(^(0),"^",2)["I"):"",1:$P(^(0),"^",2)),SDBY="" I SDNS["C" S SDU=+$P(^DPT(DFN,"S",NDT,0),"^",12),SDBY=$S($D(^VA(200,SDU,0)):$P(^(0),"^",1),1:SDU) K SDU
 F SDJ=3,4,5 I $P(^DPT(DFN,"S",NDT,0),"^",SDJ)]"" S L=L+1,^UTILITY($J,L)=$P(^(0),"^",SDJ)_"^"_$S(SDJ=3:"LAB",SDJ=4:"XRAY",1:"EKG")_"^0^0"
 Q
END W ! K %DT,A,C,APL,AT,BEGDATE,ENDDATE,COV,DA,DFN,DGPGM,DGVAR,DIPGM,DIC,HDT,J,L,NAME,NDT,POP,SC,SDED,SDBD,SDBY,SDEDT,SDEND,SDJ,SDN,SDNS,SDONE,SDRG,SDSSN,SDSTR,SDYN,X,Y,ZL,ZX,ZZ,^UTILITY($J) D CLOSE^DGUTQ Q
MORE I AT W ?36,$P(^UTILITY($J,ZZ),"^",2) I ($Y+4)>IOSL,$E(IOST,1,2)="C-" D OUT^SDUTL Q:SDEND  W @IOF
 Q:AT
 W " (",$P(^UTILITY($J,ZZ),"^",4)," MINUTES)  ",$S($D(^SC(+$P(^UTILITY($J,ZZ),"^",2),0)):$P(^SC(+$P(^UTILITY($J,ZZ),"^",2),0),"^"),1:"Deleted Clinic"),$P(^UTILITY($J,ZZ),"^",3),"  ",$P(^(ZZ),"^",5)
 I $P(^(ZZ),"^",6)]"" W !,$S($P(^(ZZ),"^",6)["NT":" *** ACTION REQUIRED ***",$P(^(ZZ),"^",6)["N":" *** NO-SHOW ***",$P(^(ZZ),"^",6)["C":" *** CANCELLED BY "_$P(^(ZZ),"^",7)_" ***",1:"") ;NAKED REFERENCE - ^UTILITY($J,ZZ)
 I ($Y+4)>IOSL,IOST?1"C-".E D OUT^SDUTL W:'SDEND @IOF
 Q
