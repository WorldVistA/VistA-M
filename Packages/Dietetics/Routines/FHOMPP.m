FHOMPP ; OIFO/RTK - Patient Profile for Outpatients ;7/2/2007
 ;;5.5;DIETETICS;**9**;Jan 28, 2005;Build 7
 D DEV Q
DEV ;get device and set up queue
 W ! K %ZIS,IOP S %ZIS="Q" D ^%ZIS Q:POP
 I '$D(IO("Q")) U IO D DISP,^%ZISC,END Q
 S ZTRTN="DISP^FHOMPP"
 S ZTSAVE("FHDFN")=""
 S ZTDESC="Outpatient Meals Recurring Meals Display" D ^%ZTLOAD
 D ^%ZISC K %ZIS,IOP
 D END Q
DISP ;
 S EX="" D HDR
 D ALG^FHCLN I ALG'="" W !!,"Allergies: ",ALG
 K ^TMP($J) F FHFP=0:0 S FHFP=$O(^FHPT(FHDFN,"P",FHFP)) Q:FHFP'>0  D
 .S FHFPZN=$G(^FHPT(FHDFN,"P",FHFP,0))
 .S FHFPIEN=$P(FHFPZN,U,1),FHMEAL=$P(FHFPZN,U,2),FHQTY=$P(FHFPZN,U,3)
 .Q:FHFPIEN=""
 .S FHNORD=$S($L(FHMEAL)=3:1,$E(FHMEAL)="B":2,$E(FHMEAL)="N":3,1:4)
 .S FHMEAL=FHNORD_FHMEAL
 .S FHFPLD=$P($G(^FH(115.2,FHFPIEN,0)),U,2) Q:FHFPLD=""
 .S FHFPNM=$P($G(^FH(115.2,FHFPIEN,0)),U,1) Q:FHFPNM=""
 .S ^TMP($J,FHFPLD,FHMEAL,FHFPIEN)=FHQTY_" "_FHFPNM
 .Q
 W !!,"Food Preferences Currently on file: "
 I $D(^TMP($J,"L")) W !!?20,"Likes"
 S FHM="" F  S FHM=$O(^TMP($J,"L",FHM)) Q:FHM=""!(EX=U)  D
 .F FHP=0:0 S FHP=$O(^TMP($J,"L",FHM,FHP)) Q:FHP'>0  W !!,^TMP($J,"L",FHM,FHP) I $Y>(IOSL-4) D PG I EX=U Q
 I $D(^TMP($J,"D")) W !!?20,"Dislikes"
 S FHM="" F  S FHM=$O(^TMP($J,"D",FHM)) Q:FHM=""!(EX=U)  D
 .F FHP=0:0 S FHP=$O(^TMP($J,"D",FHM,FHP)) Q:FHP'>0  W !!,^TMP($J,"D",FHM,FHP) I $Y>(IOSL-4) D PG I EX=U Q
 ;
 S FHIPX=$P($G(^FHPT(FHDFN,0)),U,5) I FHIPX'="" W !!,"Isolation/Precaution type is ",$P($G(^FH(119.4,FHIPX,0)),"^",1) I $Y>(IOSL-4) D PG I EX=U Q
 W !!,"Recurring Meals on File: " I $Y>(IOSL-4) D PG I EX=U Q
 W ! S STDT=DT S FHPP=1 D DISP^FHOMRR1 K FHPP
 I EX'=U,IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR
 Q
PG ;
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 D HDR Q
HDR ;
 W:$Y @IOF
 W !!,"OUTPATIENT NAME: " D PATNAME^FHOMUTL W FHPTNM,"   ",FHSSN
 W ?65,FHSEX," Age ",FHAGE Q
END ;
 K FHM,FHP,FHT Q
 ;
CPRS ; Call from FHWOR71 to get outpatient profile for CPRS
 ; Data is returned in ^TMP($J,"FHPROF",DFN,FHX)
 S FHZ115="P"_DFN D CHECK^FHOMDPA I FHDFN="" Q "-1^Invalid outpatient"
 K ^TMP($J,"FHPROF"),^TMP($J,"L"),^TMP($J,"D") S (FHX,N)=0 D PATNAME^FHOMUTL
 S FHB="" F I=1:1:80 S FHB=FHB_" "
 S ^TMP($J,"FHPROF",DFN,FHX)="OUTPATIENT NAME: "_FHPTNM_"   "_FHSSN
 S FHJ=66 D PAD^FHOMPP1 S ^TMP($J,"FHPROF",DFN,FHX)=^TMP($J,"FHPROF",DFN,FHX)_PAD_FHSEX_" Age "_FHAGE
 D ALG^FHCLN I ALG'="" S N=1 D NEWL S ^TMP($J,"FHPROF",DFN,FHX)="Allergies: "_ALG
 F FHFP=0:0 S FHFP=$O(^FHPT(FHDFN,"P",FHFP)) Q:FHFP'>0  D
 .S FHFPZN=$G(^FHPT(FHDFN,"P",FHFP,0))
 .S FHFPIEN=$P(FHFPZN,U,1),FHMEAL=$P(FHFPZN,U,2),FHQTY=$P(FHFPZN,U,3)
 .Q:FHFPIEN=""
 .S FHNORD=$S($L(FHMEAL)=3:1,$E(FHMEAL)="B":2,$E(FHMEAL)="N":3,1:4)
 .S FHMEAL=FHNORD_FHMEAL
 .S FHFPLD=$P($G(^FH(115.2,FHFPIEN,0)),U,2) Q:FHFPLD=""
 .S FHFPNM=$P($G(^FH(115.2,FHFPIEN,0)),U,1) Q:FHFPNM=""
 .S ^TMP($J,FHFPLD,FHMEAL,FHFPIEN)=FHQTY_" "_FHFPNM
 .Q
 S N=1 D NEWL S ^TMP($J,"FHPROF",DFN,FHX)="Food Preferences Currently on file: "
 I $D(^TMP($J,"L")) S N=1 D NEWL S ^TMP($J,"FHPROF",DFN,FHX)="Likes"
 S FHM="" F  S FHM=$O(^TMP($J,"L",FHM)) Q:FHM=""  D
 .F FHP=0:0 S FHP=$O(^TMP($J,"L",FHM,FHP)) Q:FHP'>0  S N=0 D NEWL S ^TMP($J,"FHPROF",DFN,FHX)=^TMP($J,"L",FHM,FHP)
 I $D(^TMP($J,"D")) S N=1 D NEWL S ^TMP($J,"FHPROF",DFN,FHX)="Dislikes"
 S FHM="" F  S FHM=$O(^TMP($J,"D",FHM)) Q:FHM=""  D
 .F FHP=0:0 S FHP=$O(^TMP($J,"D",FHM,FHP)) Q:FHP'>0  S N=0 D NEWL S ^TMP($J,"FHPROF",DFN,FHX)=^TMP($J,"D",FHM,FHP)
 ;
 S N=1 D NEWL S ^TMP($J,"FHPROF",DFN,FHX)="Recurring Meals on File: "
 S STDT=DT D ^FHOMPP1
 Q
NEWL ;New line before next line of text in ^TMP global
 I N=1 S FHX=FHX+1,^TMP($J,"FHPROF",DFN,FHX)=" "
 S FHX=FHX+1
 Q
