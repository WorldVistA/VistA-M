FHMNPRT ;Hines OIFO/RTK - Dietetics Monitor Report Print ;02/08/06  10:29
 ;;5.5;DIETETICS;**4**;Jan 28, 2005;Build 32
 ;
PRINT ;
 K FHMNTT S PG=0,EX="" D NOW^%DTC S Y=X D DD^%DT S FHNDT=Y D HDR
 S (ALLMON,M1,M2,M3,M4,M5)=0
 I FHNXIEN'="ALL",'$D(FHDATA(FHNXIEN)) D MESSAGE Q
 I FHNXIEN'="ALL" S ZZ=FHNXIEN D DISP,D1END Q
 I FHNXIEN="ALL" S ZZ="" F  S ZZ=$O(FHDATA(ZZ)) Q:ZZ=""!(EX=U)  D
 .D DISP
 .S ALLMON=ALLMON+MON
 .S M1=M1+MON1,M2=M2+MON2,M3=M3+MON3,M4=M4+MON4,M5=M5+MON5
 .Q
 I FHNXIEN'="ALL"!(EX=U) D END Q
 I ALLMON=0 W !!?5,"NO PATIENTS WITH MONITORS IN GIVEN DATE RANGE" D END Q
 W !!?16,"Totals for ALL ",$S(FHSORT="C":"Clinicians.......: ",1:"Wards............: "),$J(ALLMON,3)
 W !?16,"Monitor: Albumin ...............: ",$J(M1,3),"   ",$J(((M1/ALLMON)*100),1,2),"%"
 W !?16,"Monitor: BMI .....................: ",$J(M2,3),"   ",$J(((M2/ALLMON)*100),1,2),"%"
 W !?16,"Monitor: NPO+Clr Liq > 3 days...: ",$J(M3,3),"   ",$J(((M3/ALLMON)*100),1,2),"%"
 W !?16,"Monitor: On Hyperals............: ",$J(M4,3),"   ",$J(((M4/ALLMON)*100),1,2),"%"
 W !?16,"Monitor: On Tubefeeding.........: ",$J(M5,3),"   ",$J(((M5/ALLMON)*100),1,2),"%"
 I $Y>(IOSL-4) D PG I EX=U Q
 W !!!,"TOTAL ADMISSIONS....:",?23,FHTADM
 W !,"TOTAL MONITORS......:",?23,ALLMON
 I FHTADM>0 W !,"PERCENTAGE..........:",?23,$J(((ALLMON/FHTADM)*100),1,2),"%"
 ;
D1END I IOST?1"C".E,EX'=U W ! K DIR S DIR(0)="E" D ^DIR
 D END Q
DISP ;
 I FHSORT="C" W !!?25,"CLINICIAN: ",ZZ
 I FHSORT="W" W !!?25,"WARD: ",ZZ
 S (TOT,MON,MON1,MON2,MON3,MON4,MON5)=0
 F YY=0:0 S YY=$O(FHDATA(ZZ,YY)) Q:YY'>0  D
 .F HH=0:0 S HH=$O(FHDATA(ZZ,YY,HH)) Q:HH'>0!(EX=U)  D
 ..I $Y>(IOSL-4) D PG I EX=U Q
 ..S DFN=$P(FHDATA(ZZ,YY,HH),U,5)
 ..S Y=YY X ^DD("DD") W !,Y
 ..W ?13,$P(FHDATA(ZZ,YY,HH),U,1)
 ..W ?39,$P(FHDATA(ZZ,YY,HH),U,2)
 ..W ?47,$P(FHDATA(ZZ,YY,HH),U,6)
 ..I $P(FHDATA(ZZ,YY,HH),U,3)="Yes" D
 ...F NUM=0:0 S NUM=$O(FHMON(DFN,HH,NUM)) Q:NUM'>0!(EX=U)  D
 ....I NUM'=1 W !
 ....S MON=MON+1,MONTYP=$P($P(FHMON(DFN,HH,NUM),U,1),": ",2)
 ....S PC=$S(MONTYP["Albumin":1,MONTYP["BMI":2,MONTYP["NPO+Clr":3,MONTYP["Hyper":4,1:5)
 ....I $G(FHMNTT(ZZ))="" S FHMNTT(ZZ)=""
 ....S $P(FHMNTT(ZZ),U,PC)=$P(FHMNTT(ZZ),U,PC)+1
 ....W ?56,MONTYP I $Y>(IOSL-4) D PG I EX=U Q
 ....Q
 ...Q
 ..S TOT=TOT+1
 ..Q
 .Q
 I EX=U Q
 W !!?16,"Total Number of Monitors........: ",$J(MON,3) I $Y>(IOSL-4) D PG I EX=U Q
 S PCE=$P(FHMNTT(ZZ),U,1) I PCE>0 W !?16,"Monitor: Albumin ...............: ",$J(PCE,3),"   ",$J(((PCE/MON)*100),1,2),"%" S MON1=PCE I $Y>(IOSL-4) D PG I EX=U Q
 S PCE=$P(FHMNTT(ZZ),U,2) I PCE>0 W !?16,"Monitor: BMI .....................: ",$J(PCE,3),"   ",$J(((PCE/MON)*100),1,2),"%" S MON2=PCE I $Y>(IOSL-4) D PG I EX=U Q
 S PCE=$P(FHMNTT(ZZ),U,3) I PCE>0 W !?16,"Monitor: NPO+Clr Liq > 3 days...: ",$J(PCE,3),"   ",$J(((PCE/MON)*100),1,2),"%" S MON3=PCE I $Y>(IOSL-4) D PG I EX=U Q
 S PCE=$P(FHMNTT(ZZ),U,4) I PCE>0 W !?16,"Monitor: On Hyperals............: ",$J(PCE,3),"   ",$J(((PCE/MON)*100),1,2),"%" S MON4=PCE I $Y>(IOSL-4) D PG I EX=U Q
 S PCE=$P(FHMNTT(ZZ),U,5) I PCE>0 W !?16,"Monitor: On Tubefeeding.........: ",$J(PCE,3),"   ",$J(((PCE/MON)*100),1,2),"%" S MON5=PCE
 W ! Q
 ;
MESSAGE ;
 W !!?5,"NO PATIENTS WITH MONITORS IN GIVEN DATE RANGE"
 W !?10,"FOR THIS ",$S(FHSORT="C":"CLINICIAN",1:"WARD"),": ",FHNXIEN
 Q
END K FHMNTT,HH,M1,M2,M3,M4,M5,MON,MON1,MON2,MON3,MON4,MON5,MONTYP
 K NUM,PC,PCE,PG,PER,TOT,YY
 Q
PG ;
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 D HDR Q
HDR ;Header
 W:$Y @IOF W !,FHNDT,?60,"Page: " S PG=PG+1 W PG,!!
 W "Admission",?13,"Patient",?39,"SSN",?45,"Status",?56,"Monitor(s)"
 W ! F Z=1:1:79 W "="
 Q
