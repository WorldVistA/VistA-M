FHMMNPRT ;Hines OIFO/RTK,AAC - Mult Monitor Report Print ;02/08/06  10:29
 ;;5.5;DIETETICS;**4**;Jan 28, 2005;Build 32
 ;
 S (COUNT,COMM,CTCOMM,MON,ALLMON,ALLMON1,M1,M2,M3,M4,M5)=0
 S PG=0,(EX,XX)="" D NOW^%DTC S Y=X D DD^%DT S FHNDT=Y
 K FHMNTT
 ;
PRINT ;
 S (MM1,MM2,MM3,MM4,MM5)=0
 D MNAME
 Q:XX="*"
 I FHNXIEN'="ALL" I '$D(^TMP($J,"FHDATA",COMM,FHNXIEN)) D MESSAGE Q
 I FHNXIEN'="ALL" S ZZ=FHNXIEN D DISP,D1END Q
 I FHNXIEN="ALL" S ZZ="" F  S ZZ=$O(^TMP($J,"FHDATA",COMM,ZZ)) Q:ZZ=""!(EX=U)  D
 .D PG
 .D DISP
 .S ALLMON=ALLMON+MON
 .S ALLMON1=ALLMON1+MON
 .S M1=M1+MON1,M2=M2+MON2,M3=M3+MON3,M4=M4+MON4,M5=M5+MON5
 .S MM1=MM1+MON1,MM2=MM2+MON2,MM3=MM3+MON3,MM4=MM4+MON4,MM5=MM5+MON5
 .Q
 I FHNXIEN'="ALL"!(EX=U) G END Q
 I ALLMON=0 W !!?5,"NO PATIENTS WITH MONITORS IN GIVEN DATE RANGE" D END Q
 ;
 W !!,"** TOTAL COMMUNICATIONS OFFICE - Admissions.....: ",NAME I $Y>(IOSL-4) D PG I EX=U Q
 ;
 W !!?16,"Totals for ALL ",$S(FHSORT="C":"Clinicians.......: ",1:"Wards............: "),$J(ALLMON1,3) I $Y>(IOSL-4) D PG I EX=U Q
 ;I ZCO'="Y",ALLMON1=0 G PRINT
 I ALLMON>0 W !?16,"Monitor: Albumin < 2.8..........: ",$J(MM1,3),"   ",$J(((MM1/ALLMON)*100),1,2),"%" I $Y>(IOSL-4) D PG I EX=U Q
 I ALLMON>0 W !?16,"Monitor: BMI < 18.5...............: ",$J(MM2,3),"   ",$J(((MM2/ALLMON)*100),1,2),"%" I $Y>(IOSL-4) D PG I EX=U Q
 I ALLMON>0 W !?16,"Monitor: NPO+Clr Liq > 3 days...: ",$J(MM3,3),"   ",$J(((MM3/ALLMON)*100),1,2),"%" I $Y>(IOSL-4) D PG I EX=U Q
 I ALLMON>0 W !?16,"Monitor: On Hyperals............: ",$J(MM4,3),"   ",$J(((MM4/ALLMON)*100),1,2),"%" I $Y>(IOSL-4) D PG I EX=U Q
 I ALLMON>0 W !?16,"Monitor: On Tubefeeding.........: ",$J(MM5,3),"   ",$J(((MM5/ALLMON)*100),1,2),"%" I $Y>(IOSL-4) D PG I EX=U Q
 ;
 ;
 S (MM1,MM2,MM3,MM4,MM5,ALLMON1)=0
 G PRINT Q
 Q
 ;
THEND ;
 S NAME="ALL COMMUNICATION OFFICES " D PG I EX=U Q
 W !!,"*** TOTAL PATIENTS WITH MONITORS ALL COMMUNICATION OFFICES....: ",CTCOMM
 ;
 W !!?16,"Totals for ALL ",$S(FHSORT="C":"Clinicians.......: ",1:"Wards............: "),$J(ALLMON,3)
 I ALLMON>0 W !?16,"Monitor: Albumin < 2.8..........: ",$J(M1,3),"   ",$J(((M1/ALLMON)*100),1,2),"%" I $Y>(IOSL-4) D PG I EX=U Q
 I ALLMON>0 W !?16,"Monitor: BMI < 18.5...............: ",$J(M2,3),"   ",$J(((M2/ALLMON)*100),1,2),"%" I $Y>(IOSL-4) D PG I EX=U Q
 I ALLMON>0 W !?16,"Monitor: NPO+Clr Liq > 3 days...: ",$J(M3,3),"   ",$J(((M3/ALLMON)*100),1,2),"%" I $Y>(IOSL-4) D PG I EX=U Q
 I ALLMON>0 W !?16,"Monitor: On Hyperals............: ",$J(M4,3),"   ",$J(((M4/ALLMON)*100),1,2),"%" I $Y>(IOSL-4) D PG I EX=U Q
 I ALLMON>0 W !?16,"Monitor: On Tubefeeding.........: ",$J(M5,3),"   ",$J(((M5/ALLMON)*100),1,2),"%" I $Y>(IOSL-4) D PG I EX=U Q
 ;
 ;W !!!,"TOTAL ADMISSIONS....:",?23,FHTADM
 ;W !,"TOTAL MONITORS......:",?23,ALLMON
 ;I FHTADM>0 W !,"PERCENTAGE..........:",?23,$J(((ALLMON/FHTADM)*100),1,2),"%"
 D LINE
 S XX="*"
 Q
 ;I $Y>(IOSL-4)
 ;
D1END W ! K DIR Q:EX'=U  S DIR(0)="E" D ^DIR  ;I IOST?1"C".E,EX'=U 
 D END Q
 Q
DISP ;
 S (TOT,MON,MON1,MON2,MON3,MON4,MON5)=0
 F YY=0:0 S YY=$O(^TMP($J,"FHDATA",COMM,ZZ,YY)) Q:YY'>0  D
DISP2 .F HH=0:0 S HH=$O(^TMP($J,"FHDATA",COMM,ZZ,YY,HH)) Q:HH'>0!(EX=U)  D
 ..I $Y>(IOSL-4) I EX=U Q  W ! D HDR
 ..S CTCOMM=CTCOMM+1
 ..S DFN=$P(^TMP($J,"FHDATA",COMM,ZZ,YY,HH),U,5)
 ..S Y=YY X ^DD("DD") W !,Y
 ..W ?13,$P(^TMP($J,"FHDATA",COMM,ZZ,YY,HH),U,2)
 ..W ?39,$P(^TMP($J,"FHDATA",COMM,ZZ,YY,HH),U,3)
 ..W ?47,$P(^TMP($J,"FHDATA",COMM,ZZ,YY,HH),U,6)
 ..I $P(^TMP($J,"FHDATA",COMM,ZZ,YY,HH),U,7)="Yes"  D
 ...F NUM=0:0 S NUM=$O(FHMON(DFN,HH,NUM)) Q:NUM'>0!(EX=U)  D
 ....I NUM'=1 W !
 ....S MON=MON+1,MONTYP=$P($P(FHMON(DFN,HH,NUM),U,1),": ",2)
 ....S PC=$S(MONTYP["Albumin":1,MONTYP["BMI":2,MONTYP["NPO+Clr":3,MONTYP["Hyper":4,1:5)
 ....I $G(FHMNTT(COMM,ZZ))="" S FHMNTT(COMM,ZZ)=""
 ....S $P(FHMNTT(COMM,ZZ),U,PC)=$P(FHMNTT(COMM,ZZ),U,PC)+1
 ....W ?56,MONTYP I $Y>(IOSL-4) D PG I EX=U Q
 ....Q
 ...Q
 ..S TOT=TOT+1
 ..Q
 .Q
 I MON=0!(EX=U) Q
 I FHSORT="C" W !!,"*  CLINICIAN: ",ZZ
 I FHSORT="W" W !!,"*  WARD: ",ZZ
 W !?16,"Total Number of Monitors........: ",$J(MON,3) I $Y>(IOSL-4) D PG I EX=U Q
 S PCE=$P(FHMNTT(COMM,ZZ),U,1) I PCE>0 W !?16,"Monitor: Albumin < 2.8..........: ",$J(PCE,3),"   ",$J(((PCE/MON)*100),1,2),"%" S MON1=PCE I $Y>(IOSL-4) D PG I EX=U Q
 S PCE=$P(FHMNTT(COMM,ZZ),U,2) I PCE>0 W !?16,"Monitor: BMI < 18.5...............: ",$J(PCE,3),"   ",$J(((PCE/MON)*100),1,2),"%" S MON2=PCE I $Y>(IOSL-4) D PG I EX=U Q
 S PCE=$P(FHMNTT(COMM,ZZ),U,3) I PCE>0 W !?16,"Monitor: NPO+Clr Liq > 3 days...: ",$J(PCE,3),"   ",$J(((PCE/MON)*100),1,2),"%" S MON3=PCE I $Y>(IOSL-4) D PG I EX=U Q
 S PCE=$P(FHMNTT(COMM,ZZ),U,4) I PCE>0 W !?16,"Monitor: On Hyperals............: ",$J(PCE,3),"   ",$J(((PCE/MON)*100),1,2),"%" S MON4=PCE I $Y>(IOSL-4) D PG I EX=U Q
 S PCE=$P(FHMNTT(COMM,ZZ),U,5) I PCE>0 W !?16,"Monitor: On Tubefeeding.........: ",$J(PCE,3),"   ",$J(((PCE/MON)*100),1,2),"%" S MON5=PCE
 W !
 Q
 ;
MESSAGE ;
 W !!?5,"NO PATIENTS WITH MONITORS IN GIVEN DATE RANGE"
 W !?10,"FOR THIS ",$S(FHSORT="C":"CLINICIAN",1:"WARD"),": ",FHNXIEN
 Q
END K FHMNTT,HH,M1,M2,M3,M4,M5,MON,MON1,MON2,MON3,MON4,MON5,MONTYP
 K NUM,PC,PCE,PG,PER,TOT,YY
 QUIT
 Q
 ;
PG ;
 I IOST?1"C".E  W ! K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 D HDR Q
 Q
HDR ;Header
 W:$Y @IOF W !,FHNDT,?60,"Page: " S PG=PG+1 W PG,!
 W !,?25,"Nutrition Monitor Statistic Report"
 W !,NAME,!
 W "Admission",?13,"Patient",?39,"SSN",?45,"Status",?56,"Monitor(s)"
LINE W ! F Z=1:1:79 W "="
 Q
MNAME ;
 I ZCO'="Y" S CONUMX=CONUMX-1 G:CONUMX<1 THEND  S COXX=$P(CO,"^",CONUMX),NAME=$P(CONAME,"^",CONUMX) S COMM=COXX Q
 I ZCO="Y" S COUNT=COUNT+1 G:COUNT>ZOUT THEND  S NAME=$G(^FH(119.73,COUNT,0)),NAME=$P(NAME,"^") S COMM=COUNT
 I $D(^FH(119.73,COUNT,"I"))!'$D(^FH(119.73,COUNT,0)) G MNAME
 Q
QUIT ;
 W !
 Q
