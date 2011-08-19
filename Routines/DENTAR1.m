DENTAR1 ;ISC2/SAW,HAG-RELEASE DENTAL TREATMENT DATA SERVICE REPORTS FOR TRANSMISSION TO AUSTIN ;1/26/98  13:54 ;
 ;;1.2;DENTAL;**2,24**;JAN 26, 1989
 D:'$D(DT) DT^DICRW S %O="OPT",U="^",S=";",O=$T(@(%O)),DENTV=$$VERSION^XPDUTL("DENT") I $D(^DOPT($P(O,S,5),"VERSION")),(DENTV=^DOPT($P(O,S,5),"VERSION")) G IN
 K ^DOPT($P(O,S,5))
 F I=1:1 Q:$T(@(%O)+I)=""  S ^DOPT($P(O,S,5),I,0)=$P($T(@(%O)+I),S,3),^DOPT($P(O,S,5),"B",$P($P($T(@(%O)+I),S,3),"^",1),I)=""
 S K=I-1,^DOPT($P(O,S,5),0)=$P(O,S,4)_U_1_U_K_U_K K I,K,X S ^DOPT($P(O,S,5),"VERSION")=DENTV
IN I $P(O,S,6)'="" D @($P(O,S,6))
PR S O=$T(@(%O)),S=";" S IOP=$I D ^%ZIS W:IOST'["PK-" @IOF K IOP
 I $P(O,S,7)'="" D @($P(O,S,7))
 E  W !!,$P(O,S,3),":",!,$$VERSION^XPDUTL("DENT")," ",$P($T(+1),S,1),!!,$P(O,S,4),"S:",!
 F J=1:1 Q:'$D(^DOPT($P(O,S,5),J,0))  S K=$S(J<10:15,1:14) W !,?K,J,". ",$P(^DOPT($P(O,S,5),J,0),U,1)
RE W ! S DIC("A")="Select "_$P($T(OPT),S,4)_": EXIT// ",DIC="^DOPT("_""""_$P($T(OPT),S,5)_""""_",",DIC(0)="AEQMN" D ^DIC G:X=""!(X=U) EXIT G:Y<0 RE K DIC,J,O D @($P($T(OPT+Y),S,4)) G PR
PROV D DATE G EXIT:Y<0 D ^DENTAR11 G ASK
SITPROV D DATE G EXIT:Y<0 D ^DENTAR12 G ASK
CLINIC D DATE G EXIT:Y<0 D ^DENTAR13 G ASK
SIT D DATE G EXIT:Y<0 D ^DENTAR14 G ASK
NOREV D DATE G EXIT:Y<0 D NOREV^DENTAR16 G ASK
DATE W !! K ^UTILITY($J,"DENTERR"),^UTILITY($J,"DENTV"),^UTILITY($J,"DENTR"),^UTILITY($J,"DENTP") S U="^",Z5="",Z1=0 G W:'$D(^DENT(225,0)) F Z3=0:1:2 S Z1=$O(^(Z1)) Q:Z1'>0  S Z2=Z1
 G:Z3=0 W I Z3>1 S DIC="^DENT(225,",DIC(0)="AEMNQZ",DIC("A")="Select STATION.DIVISION: " S:$D(DENTSTA) DIC("B")=$S(DENTSTA[" ":+DENTSTA,1:DENTSTA) D ^DIC Q:Y<0  K DIC("A"),DIC("B")
 S Z1=$S(Z3=1:Z2,1:+Y) S (DENTSTA,Z3)=$P(^DENT(225,Z1,0),U,1) I DENTSTA="" D W S Y=-1 Q
 S:$L(DENTSTA)=3 DENTSTA=DENTSTA_"  "
D1 W !!,"Enter the starting and ending dates for the Treatment Data entries that",!,"you wish to review/release",!
 S %DT("A")="STARTING DATE: ",%DT="AEPX" D ^%DT K %DT("A") Q:Y<0  S DENTSD=Y X ^DD("DD") S H1=Y
 S %DT("A")="ENDING DATE: ",%DT="AEPX" D ^%DT K %DT("A") Q:Y<0  S DENTED=Y+.24 X ^DD("DD") S H2=Y
 I DENTED<DENTSD W *7,!!,"End Date before Start Date?" G D1
 Q
ASK I '$D(DENTC)!($D(ZTSK))!($D(DENTF1)) G CLOSE
 G CLOSE:'DENTC!(IO'=IO(0)) U IO(0) I IO=IO(0)
A W !!,"Okay to release this report for transmission to Austin" S %=2 D YN^DICN D:%=0 Q4^DENTQ G A:%=0 I %'=1 W !,"Nothing released",*7 G CLOSE
EN1 S ^UTILITY($J,"DENTV",Q,DENTC,0)=^UTILITY($J,"DENTV",Q,DENTC,0)_"$"
 S DENTA=$S($E(DENTSTA,4,5)="  ":+DENTSTA,1:DENTSTA),DENTA=$O(^DENT(225,"B",DENTA,0)) I DENTA S DENTA=$S($D(^DENT(225,DENTA,0)):$P(^(0),"^",3),1:"")
 I DENTA="Y" F Q1=1:1:Q S XMDUZ=DUZ,XMY(DUZ)="",XMY("XXX@Q-DAS.VA.GOV")="",XMSUB="DENTAL SERVICE TREATMENT DATA, "_$P(H5,":",1)_": "_Z3_" ( MESSAGE NO.: "_Q1_")",XMTEXT="^UTILITY("_$J_",""DENTV"","_Q1_"," D ^XMD
 G M:DENTA="Y" S K=0,Q1=$S($D(^UTILITY("DENTV")):^("DENTV"),1:0) F I=1:1:Q S N="" F J=0:0 S N=$O(^UTILITY($J,"DENTV",I,N)) Q:N=""  S K=K+1,%X="^UTILITY("_$J_",""DENTV"","_I_","_N_",",%Y="^UTILITY(""DENTV"","_(Q1+K)_"," D %XY^%RCR
 S ^UTILITY("DENTV")=Q1+K
M F X=0:0 S X=$O(^UTILITY($J,"DENTP",X)) Q:X=""  S X1=^(X),^DENT(221,X,.1)=DUZ_"^"_DT,^DENT(221,"AG",Z3,DT,X)="" K:X1["," ^DENT(221,"AC",Z3,X1,X),^DENT(221,"A",Z3,$P(X1,",",1),X) K:X1'["," ^DENT(221,"AC",Z3,X1),^DENT(221,"A",Z3,X1)
 W !,"Report released for transmission to Austin"
 G CLOSE
W W !!,"Stations have not been entered in the Dental Site Parameter file.",!,"You must enter a station before you can use this option" Q
CLOSE X ^%ZIS("C")
EXIT K %,%DT,%X,%Y,A,DENTA,DENTC,DENTED,DENTF,DENTF1,DENTSD,DENTV,DIC,H1,H2,H5,I,J,K,N,O,Q,Q1,S,X,X1,XMDUZ,XMSUB,XMTEXT,XMY,Y,Z1,Z2,Z3,Z5
EXIT1 K ^UTILITY($J,"DENTERR"),^UTILITY($J,"DENTV"),^UTILITY($J,"DENTR"),^UTILITY($J,"DENTP") K:$D(ZTSK) ^%ZTSK(ZTSK) Q
OPT ;;REVIEW TREATMENT DATA SERVICE REPORTS;OPTION;DENTAR1
 ;;PROVIDER SUMMARY;PROV
 ;;SITTINGS BY PROVIDER;SITPROV
 ;;CLINIC SUMMARY;CLINIC
 ;;INDIVIDUAL SITTINGS;SIT
 ;;NO REVIEW;NOREV
