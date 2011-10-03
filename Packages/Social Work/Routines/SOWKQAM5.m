SOWKQAM5 ;B'HAM ISC/SAB,DLR-Routine to print quality mgmt. monitor V report ; 20 Apr 93 / 7:58 AM [ 09/26/94  8:44 AM ]
 ;;3.0; Social Work ;**34,53,64**;27 Apr 93;Build 6
 ;Reference to GETPLIST^SDAMA202 supported by IA #3869
 ;Reference to ^DIC(40.7 supported by IA #557
 ;
BEG W ! S %DT="AEXP",%DT("A")="ALL CASES STARTING FROM: " D ^%DT G:"^"[X CLOS G:Y'>0 BEG S SB1=Y X ^DD("DD") S SBA=Y
END W ! S %DT("A")="ALL CASES ENDING: " D ^%DT G:"^"[X CLOS G:Y'>0 END S SE1=Y X ^DD("DD") S SEA=Y I SE1<SB1 W !,"Ending date must be after starting date ",! G BEG
DEV W !!,"WARNING !!!",!?5,"This report is formatted for 132 columns and will be",!?5,"difficult to read if printed to the screen.",!
 K ZTSK,%ZIS,IOP S SOWKION=ION,%ZIS="QM",%ZIS("B")="" D ^%ZIS K %ZIS I POP S IOP=SOWKION D ^%ZIS K SOWKION,IOP G CLOS Q
 K SOWKION I $D(IO("Q")) S ZTRTN="ENQ^SOWKQAM5",ZTDESC="QUALITY MGMT. MONITOR V REPORT - SOCIAL WORK" F G="SE1","SB1","SBA","SEA" S:$D(@G) ZTSAVE(G)=""
 I  K IO("Q") D ^%ZTLOAD I '$D(ZTSK) G CLOS
 I $D(ZTSK) W !!,"Task Queued to Print",! K ZTSK G CLOS
ENQ ;
 F I=0:0 S I=$O(^SOWK(650.1,1,4,I)) Q:'I  D
 . S SWCL=+^(I,0),SWCC=$G(^DIC(40.7,$P($G(^SC(SWCL,0)),"^",7),0)),SWCL(SWCL)=SWCL_"^"_$P(SWCC,"^",2)_"^"_$P(SWCC,"^",5)
 S (TOT1,TOT2)=0
 F SWCL=0:0 S SWCL=$O(SWCL(SWCL)) Q:'SWCL  D
 . S CL=$P(SWCL(SWCL),"^"),CLP=$P(SWCL(SWCL),"^",2)
 . S CLS=0 D SWCL S CLS=1 D TOC
 ;
 D PRI I $G(OUT)'=1 W !?64,"----",?90,"----",?118,"----",!,"TOTALS",?65,$J(TOT1,3,0),?91,$J(TOT2,3,0),?119,$S(TOT2:$J((TOT1/TOT2)*100,3,0)_"%",1:"***")
 ;
CLOS W ! W:$E(IOST)'["C" @IOF D ^%ZISC
 K CL,ID,CLP,CLS,DFN,I,ZZ,I2,SB1,CDC,CN,SBA,SEA,Y,TOT1,TOT2,SE1,IOP,OUT,POP,SOWK,%DT,I1,G,SWCC,X,SWCL
 D KVA^VADPT D:$D(ZTSK) KILL^%ZTLOAD
 Q
TOC ;
 F CL=0:0 S CL=$O(^SC(CL)) Q:'CL  D
 . I $P($G(^SC(CL,0)),"^",7)'="" D
 . . I CLP=$P($G(^DIC(40.7,$P(^SC(CL,0),"^",7),0)),U,2) D SWCL
 Q
 ;CALCULATE TOTALS
SWCL ;
 K ^TMP($J,"SDAMA202","GETPLIST")
 D GETPLIST^SDAMA202(CL,"3;12",,SB1,SE1)
 F ID=0:0 S ID=$O(^TMP($J,"SDAMA202","GETPLIST",ID)) Q:'ID  D
 . I $G(^TMP($J,"SDAMA202","GETPLIST",ID,3))="R",$G(^TMP($J,"SDAMA202","GETPLIST",ID,12))="O" D
 . . S $P(SWCL(SWCL),"^",$S(CLS:5,1:4))=$P(SWCL(SWCL),"^",$S(CLS:5,1:4))+1
 K ^TMP($J,"SDAMA202","GETPLIST")
 Q
PRI ;print data
 U IO W:$Y @IOF D HDR1 Q:$G(OUT)=1  F CDC=0:0 S CDC=$O(SWCL(CDC)) Q:'CDC!($G(OUT)=1)  D:($Y+13)>IOSL CHK D:$G(OUT)'=1 OUT
 Q
HDR1 W !!?45,"Department of Veterans Affairs",!?45,$P(^DD("SITE"),"^")_" ("_$P(^DD("SITE",1),"^")_")",!?40,"Social Work Information Management System",!?45,"Quality Management Monitor V"
 W !?40,"Access to Social Work Services by Location",!,"Date: "_$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3),?60,"Reporting Period "_SBA_" to "_SEA,!
 W !?34,"Stop",?60,"# Pats. Open/",?86,"Total # Patients",?116,"% Population",!,"Clinic",?34,"Code",?46,"Location",?60,"# PT. Visits",?86,"Treatment Episodes",?118,"Served",!
 Q
OUT W !,$P(^SC($P(SWCL(CDC),"^"),0),"^"),?35,$P(SWCL(CDC),"^",2)
 W ?46,$P(SWCL(CDC),"^",3),?65,$J($P(SWCL(CDC),"^",4),3,0),?91,$J($P(SWCL(CDC),"^",5),3,0),?119,$S(+$P(SWCL(CDC),"^",5):$J(+$P(SWCL(CDC),"^",4)/+$P(SWCL(CDC),"^",5)*100,3,0),1:$J("0",3,0))
 S TOT1=TOT1+$P(SWCL(CDC),"^",4),TOT2=TOT2+$P(SWCL(CDC),"^",5)
 Q
CHK ;
 N SWXX
 I $E(IOST)["C" R !,"Press <RETURN> to continue: ",SWXX:DTIME I SWXX["^" S OUT=1 W @IOF Q
 W @IOF D HDR1
 Q
