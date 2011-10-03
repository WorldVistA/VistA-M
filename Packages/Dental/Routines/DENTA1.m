DENTA1 ;ISC2/SAW,HAG-DENTAL TREATMENT DATA SERVICE REPORTS ; 1/10/89  11:08 AM ;
 ;;1.2;DENTAL;**24**;JAN 26, 1989
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
PROV D DATE G EXIT:Y<0 D ^DENTA11,CLOSE G PROV
SITPROV D DATE G EXIT:Y<0 D ^DENTA12,CLOSE G SITPROV
CLINIC D DATE G EXIT:Y<0 D ^DENTA13,CLOSE G CLINIC
SIT D DATE G EXIT:Y<0 D ^DENTA14,CLOSE G SIT
DATE W !! K ^UTILITY($J,"DENTERR"),^UTILITY($J,"DENTR"),^UTILITY($J,"DENTDUP") S U="^",Z5="",Z1=0 G:'$D(^DENT(225,0)) W F Z3=0:1:2 S Z1=$O(^(Z1)) Q:Z1'>0  S Z2=Z1
 G:Z3=0 W I Z3>1 S DIC="^DENT(225,",DIC(0)="AEMNQ",DIC("A")="Select STATION.DIVISION: " S:$D(DENTSTA) DIC("B")=$S(DENTSTA[" ":+DENTSTA,1:DENTSTA) D ^DIC Q:Y<0  K DIC("A"),DIC("B")
 S Z1=$S(Z3=1:Z2,1:+Y) S DENTSTA=$P(^DENT(225,Z1,0),U,1) I DENTSTA="" D W S Y=-1 Q
D1 W !!,"Enter the starting and ending dates for the data entries that",!,"you wish to include in this report.",!
 S %DT("A")="STARTING DATE: ",%DT="AEPX" D ^%DT K %DT("A") Q:Y<0  S (DENTSD1,DENTSD)=Y X ^DD("DD") S H1=Y
 S %DT("A")="ENDING DATE: ",%DT="AEPX" D ^%DT K %DT("A") Q:Y<0  S DENTED=Y+.24 X ^DD("DD") S H2=Y
 I DENTED<DENTSD W *7,!!,"End Date before Start Date?" G D1
 Q
W W !!,"Stations have not been entered in the Dental Site Parameter file.",!,"You must enter a station before you can use this option" Q
CLOSE X ^%ZIS("C")
EXIT K %,%DT,DENTC,DENTED,DENTF,DENTF1,DENTSD,DENTSD1,DENTV,DIC,H1,H2,H5,I,J,K,O,Q,Q1,S,X,X1,Y,Z1,Z2,Z5
EXIT1 K ^UTILITY($J,"DENTERR"),^UTILITY($J,"DENTR"),^UTILITY($J,"DENTV"),^UTILITY($J,"DENTP") K:$D(ZTSK) ^%ZTSK(ZTSK),ZTSK Q
OPT ;;TREATMENT DATA SERVICE REPORTS;OPTION;DENTA1
 ;;PROVIDER SUMMARY;PROV
 ;;SITTINGS BY PROVIDER;SITPROV
 ;;CLINIC SUMMARY;CLINIC
 ;;INDIVIDUAL SITTINGS;SIT
