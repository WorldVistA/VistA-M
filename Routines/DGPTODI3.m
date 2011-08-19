DGPTODI3 ;ALB/MTC - DRG INDEX(CONT),PRINT FROM ^UTILITY GLOBAL ; 8/29/01 11:08am
 ;;5.3;Registration;**51,158,164,375,606,744**;Aug 13, 1993;Build 5
 S (DGPAG,DGAT,DGBT,DGAAL,DGTP,DG1DAY,DGTDRG,DGTP(1),DGUNIQ,SSN(1))=0,$P(DGLN,"=",132)="",$P(DGLN2,"-",132)=""
 F DRG=0:0 D:DRG>0 TOT S DRG=$O(^UTILITY($J,"DGDRGI",DRG)) Q:DRG'>0  D HDR S J1=0 F J=0:0 S J1=$O(^UTILITY($J,"DGDRGI",DRG,J1)) Q:J1']""  S:DGP DGPT=J1 S:'DGP DGTD=J1 D L2
 W @IOF,!?61,"Summary Page",!!!,"Total combined hits for Medical Center of all DRGs: ",DGTP(1),!,"The following list gives the total hits by DRG:"
 S DRG="" F J=0:0 Q:DRG<0  W ! F %=1:1:8 S DRG=$O(DRG(DRG)) S:DRG'>0 DRG=-1 Q:DRG'>0  W "    DRG ",$J(DRG,3),":",$J(DRG(DRG),4)
 D:$D(^UTILITY($J,"DGDRGI","DGNOCODE")) NC K DGAT,DGBT,DGAAL,DG1DAY,DGTDRG,DGUNIQ,DGLN,DGLN2,DGPT,DGAL,DGTD,DGDT,DGHI,DGLO,DGPAG,DGNC,DGTP,I,J,J1,K,L Q
L2 F K=0:0 S K=$O(^UTILITY($J,"DGDRGI",DRG,J1,K)) Q:K'>0  F L=0:0 S L=$O(^UTILITY($J,"DGDRGI",DRG,J1,K,L)) Q:L']""  S DGDT=L,X=^(L) D LN
 Q
LN I $Y>$S('$D(IOSL):60,1:(IOSL-6)) D HDR
 S DGTP=DGTP+1,DGTDRG=DGTDRG+1 W !! W:DGP DGPT I 'DGP S DFN=$P(X,"^",2) W $P(^DPT(DFN,0),"^",1)
 S SSN(2)=$P(X,"^") W ?33,SSN(2),?44 S:SSN(2)'=SSN(1) DGUNIQ=DGUNIQ+1,SSN(1)=SSN(2) S Y=$P(X,"^",6) D DT W:DGD=0 ?55,"----------" I DGD S Y=$P(X,"^",7) I Y W ?55 D DT
 W ?66 W:DGDT=1!(DGDT=$P(X,"^",7)) "----------" I DGDT>1&(DGDT'=$P(X,"^",7)) S Y=DGDT D DT
 W ?76 S DGLOS=$P(X,"^",3),DGBE=$P(X,"^",9) W $J(DGLOS,4),?83,$J(DGBE,5) I DGLOS>0 W ?91 D FLG
 W ?99 S DGSTAT=$P(X,"^",8) W $S(DGSTAT=0:"O",DGSTAT=1:"C",DGSTAT=2:"R",1:"T")
 S DGPRO=$P(X,"^",4),DGBS=$P(X,"^",5) W ?103 W:DGPRO'>0 "not specified/" I DGPRO>0 W $S($D(^VA(200,DGPRO,0)):$E($P(^VA(200,DGPRO,0),"^",1),1,29),1:"not specified"),"/"
 I DGBS>0 W !,?103,$E($P(^DIC(42.4,DGBS,0),"^",1),1,29)
 Q
FLG I DGLOS=1 S DG1DAY=DG1DAY+1 W "   *" Q
 S %="" S:DGBE]""&(DGLOS>DGBE) DGBT=DGBT+1,%="B" S:DGHI]""&(DGLOS>DGHI) DGAT=DGAT+1,%=%_"H" S:DGAL]""&(DGLOS>DGAL) DGAAL=DGAAL+1,%=%_"A" W:%]"" $J(%,4) Q
TOT W !,DGLN,!?3,"Total: ",DGTP,!,?3,"Total Unique Patients: ",DGUNIQ S %=$S('$D(IOSL):56,1:(IOSL-10)) F I=$Y:1:% W !
 W !!,"FLAGS:  H - Total Above High Trim: ",DGAT,"   * - Total 1 Day LOS: ",DG1DAY,"   A - Total Above ALOS: ",DGAAL
 S DRG(DRG)=DGTP,DGTP(1)=DGTP(1)+DGTP,(DGTP,DGBT,DGAT,DG1DAY,DGAAL,DGUNIQ,SSN(1))=0 W !!?64,"-",DGPAG,"-" Q
DT W $TR($$FMTE^XLFDT(Y,"5DF")," ","0") S Y="" Q
HDR W @IOF,!,"DRG INDEX FOR DRG ",DRG,?30,"Weight: "
HD1 S %=$S($D(^ICD(DRG,"FY",DGFY2K,0)):(^(0)),1:"")
 I %="",DGFY2K="3070000" N DGFY2KSV,DGFY2KYR S DGFY2KSV=DGFY2K,DGFY2KYR=$E(DGFY2K,1,3)-1,DGFY2K=DGFY2KYR_"0000" G HD1
 I $G(DGFY2KSV) S DGFY2K=DGFY2KSV
 W $P(%,"^",2),?46,"Low Trim: " S DGLO=$P(%,"^",3),DGHI=$P(%,"^",4),DGAL=$P(%,"^",9) W DGLO,?60,"High Trim: ",DGHI,?76,"Avg LOS: ",DGAL
 W ?105,"PRINTED: " S Y=DT X ^DD("DD") W Y,!?3,"For ",$S(DGD:"Discharge Dates from: ",1:"Active Admissions") I DGD S Y=DGSD+.1 X ^DD("DD") W $P(Y,"@")," to " S Y=DGED X ^DD("DD") W $P(Y,"@") I DGB W " including TRANSFER DRGs"
 ;W !!,?5,"Description:" F %=0:0 S %=$O(^ICD(DRG,1,%)) Q:%'>0  W ?18,^ICD(DRG,1,%,0),!
 N DXD,DGDX S DXD=$$DRGD^ICDGTDRG(DRG,"DGDX",,DT)
 W !!,?5,"Description:" F %=0:0 S %=$O(DGDX(%)) Q:'+%  Q:DGDX(%)=" "  W ?18,DGDX(%),!
 W !!,?44,"ADMISSION",?55,"DISCHARGE",?66,"TRANSFER",?97,"PTF",?103,"TRANSFERRING PROVIDER/"
 W !,"PATIENT NAME",?33,"SSN",?44,"DATE",?55,"DATE",?66,"DATE",?77,"LOS",?91,"FLGS",?97,"STAT",?103,"LOSING SPECIALTY"
 W !,DGLN S DGPAG=DGPAG+1 S:'$D(^UTILITY($J,"DGTC",DRG)) ^UTILITY($J,"DGTC",DRG,DGPAG)="" Q
PNC W !,DGNC,?9,$P(^DPT(DFN,0),"^"),?45,$P(^(0),"^",9),?63 S Y=DGDT D DT Q
HD2 W:DGPAG>0 !,?64,"-",DGPAG,"-",@IOF S DGPAG=DGPAG+1 W !,"PTF #",?9,"PATIENT NAME",?45,"SSN",?60,"ADMISSION DATE",!,DGLN Q
NC S (DGPAG,DGTP)=0
 W @IOF,"A ",$S(DGB:"transfer ",1:""),"DRG can not be computed for 1 or more movement(s) associated with the following PTF records because ",$S(DGB:"transfer ",1:""),"ICD code(s) "
 W:DGB ! W "are missing:"
 D HD2
 F DGNC=0:0 S DGNC=$O(^UTILITY($J,"DGDRGI","DGNOCODE",DGNC)) Q:DGNC'>0  S DGTP=DGTP+1,DFN=+^UTILITY($J,"DGDRGI","DGNOCODE",DGNC),DGDT=$P(^(DGNC),"^",2) D PNC D:$Y>$S('$D(IOSL):58,1:(IOSL-8)) HD2
 S:DGPAG=0 DGPAG=1 W !,DGLN,!,"Total PTF Records: ",DGTP S %=$S('$D(IOSL):60,1:IOSL-6) F I=$Y:1:% W !
 W !?64,"-",DGPAG,"-",! Q
