DGPTODA1 ;ALB/AS - PTF DRG ALOS REPORTS (DRIVER ROUTINE) ; 8/29/01 2:28pm
 ;;5.3;Registration;**375**;Aug 13, 1993
 S $P(DGLN,"=",132)="",$P(DGLN2,"-",132)="",DGCPG(2)="For "_$S(DGD:"Discharge dates from ",1:"Active Admissions")
 I DGD S Y=(DGSD+.1) X ^DD("DD") S DGCPG(2)=DGCPG(2)_$P(Y,"@")_" to ",Y=$P(DGED,".") X ^DD("DD") S DGCPG(2)=DGCPG(2)_Y,DGCPG(3)=$S('DGB:"not ",1:"")_"including TRANSFER DRGs"
 I DGS'="S"&($D(^UTILITY($J,"DGPTFR","D"))) D IN S DGRNO=1,DGFLAG="Medical Center by DRG",DGCPG(1)="AVERAGE LOS Report for "_DGFLAG,DGTCH="Average LOS by DRG^DRG^PAGE #" D C^DGUTL,HD,^DGPTODA2 G:DGS="D" Q
 G:'$D(^UTILITY($J,"DGPTFR","SB")) Q D IN S DGRNO=2 F %=1:1:7 S (DGMC(%),DGAMT(%))=0
 S DGSV="",DGCPG(1)="AVERAGE LOS Report by SERVICE by SPECIALTY",DGTCH=DGCPG(1)_"^SPECIALTY^PAGE #" D C^DGUTL
 F D=0:0 D:DGSV]"" WS^DGPTODA2 S DGSV=$O(^UTILITY($J,"DGPTFR","SB",DGSV)) Q:DGSV']""  S ^UTILITY($J,"DGLOS",DGSV)=^(DGSV),DGFLAG=^UTILITY($J,"DGLOS",DGSV)_" Service by Specialty by DRG" D HD,SV^DGPTODA2
 K DGBNM F %=1:1:7 S DGTT(%)=DGMC(%)
 D WM^DGPTODA2 K DGMC,D5,DGBS
 D IN S DGRNO=3,DGSV="",DGCPG(1)="AVERAGE LOS Report by SERVICE",DGTCH=DGCPG(1)_"^SERVICE^PAGE #" D C^DGUTL
 F I=0:0 D:DGSV]"" WS^DGPTODA2 S DGSV=$O(^UTILITY($J,"DGLOS",DGSV)) Q:DGSV']""  S X=^(DGSV),DGFLAG=X_" Service" D HD S (DRG,^UTILITY($J,"DGTC",X,DGPAG))="" F J=0:0 S DRG=$O(^UTILITY($J,"DGLOS",DGSV,DRG)) Q:DRG']""  S Z=^(DRG) D LN
 F %=1:1:7 S DGTT(%)=DGAMT(%)
 D WM^DGPTODA2 G Q
LN D LN^DGPTODA2 S D3=0 F D=0:0 S D3=$O(^UTILITY($J,"DGLOS",DGSV,DRG,D3)) Q:D3']""  S Z=^UTILITY($J,"DGLOS",DGSV,DRG,D3) S:D3="AA" DGA="A",DGLA=$P(Z,"^"),DGDA=$P(Z,"^",2),DGHI=$P(Z,"^",3),DGTT(3)=DGTT(3)+DGDA,DGTT(4)=DGTT(4)+DGLA I D3="BA" D BA
 D WLN^DGPTODA2 Q
BA S DGU="B",DGLU=$P(Z,"^"),DGDU=$P(Z,"^",2),DG1DAY=$P(Z,"^",4),DGLODAY=$P(Z,"^",5),DGLODC=$P(Z,"^",6),DGTT(1)=DGTT(1)+DGDU,DGTT(2)=DGTT(2)+DGLU Q
HD I DGPAG>0 S %=$S($D(IOSL):(IOSL-11),1:55) F I=$Y:1:% W !
 I DGPAG>0 D DIS^DGPTOD1 W !!?64,"-",DGPAG,"-",!
 S DGPAG=DGPAG+1 W @IOF,!!,"AVERAGE LOS Report for ",DGFLAG,?110,"PRINTED: " S Y=DT X ^DD("DD") W $P(Y,"@"),!,$P(DGCPG(2),U) I DGD W " ",$P(DGCPG(3),U)
 W !!?37,"|",?43,"BELOW AVG LOS",?60,"|    ABOVE AVG LOS     |",?92,"TOTAL",?107,"|",!?29,"        |----------------------|----------------------|-----------------------|",!,?16,"National",?31,"     "
 W " | Total  Total   ALOS/ | Total  Total   ALOS/ | Total  Total    ALOS/ | ",?110,"Total",?123,"Average",!,"DRG  Low  High    ALOS    Weight     | Disch   LOS    Disch | Disch   LOS    Disch | Disch   LOS     Disch |"
 W ?109,"Weight(*)",?124,"Weight",!,DGLN Q
IN F %=1:1:7 S DGTT(%)=0
 S DGPAG=0 K DGBNM,^UTILITY($J,"DGTC") Q
Q W @IOF K DGTT,DGAMT,%,DGDA,DGLA,DGA,DGU,DGDU,DGLU,D,D3,DGHI,DGFLAG,DGLN,DGLN2,DGPAG,DGRNO,DGSV,DGTCH,DRG,DG1DAY,I,J,X,X2,Y,DGWU,DGTD,DGTL,DGTWW,DGLODAY,DGLOTRIM,^UTILITY($J,"DGLOS"),DGCPG,DGLODC,Z Q
