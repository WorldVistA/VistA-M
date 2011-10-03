ORPRPM1 ;DAN/SLC Performance Measure Print; ;10/4/01  10:45
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**114,119**;Dec 17, 1997
 ;
 ;This routine will print a report indicating the percent of
 ;orders entered for a provider by a provider holding the ORES key.
 ;The data for the report will be stored in ^TMP as follows:
 ;^TMP($J,"SUM",Provider Name,Patient Status)=Total # of order (universe)^Denominator^Numerator^Verbal^Written^Telephone^Policy^Electronically entered^Student entered^Outpatient narcotic orders
 ;Where Patient Status is I for inpatient or O for outpatient.
 ;
PRINT ;Print out report
 S REPDT=$$FMTE^XLFDT($$DT^XLFDT)
 ;Detailed Report Section
 I ORREP="B"!(ORREP="D") D  Q:$G(ORSTOP)  ;print detailed report if selected
 .D HDR("D") I '$D(^TMP($J,"DET")) W !,"There is no data for the criteria you selected." S ORSTOP=1 Q
 .S ORI="" F  S ORI=$O(^TMP($J,"DET",ORI)) Q:ORI=""!($G(ORSTOP))  W !,"PROVIDER: ",ORI,!! S ORJ="" F  S ORJ=$O(^TMP($J,"DET",ORI,ORJ)) Q:ORJ=""!($G(ORSTOP))  D
 ..W $$FMTE^XLFDT($P(^OR(100,ORJ,8,1,0),"^")\1,2),?9,$J(ORJ,9)
 ..S ORPAT=$P(^OR(100,ORJ,0),"^",2) W ?20,$S(ORPAT["DPT":$E($P(^DPT(+ORPAT,0),"^"),1)_$E($P(^(0),"^",9),6,9),1:"Refrl") ;Print 1st letter of last name/last 4 SSN if patient file entry else referral
 ..W ?27,$S($P($G(^OR(100,ORJ,.1,1,0)),"^"):$E($P(^ORD(101.43,$P(^(0),"^"),0),"^"),1,12),1:"")
 ..W ?41,$S($P($G(^OR(100,ORJ,8,1,0)),"^",12):$E($P(^ORD(100.02,$P(^(0),"^",12),0),"^"),1,3),1:"")
 ..W ?47,$S($P($G(^OR(100,ORJ,0)),"^",10):$E($P(^SC(+$P(^(0),"^",10),0),"^"),1,12),1:"")
 ..W ?61,$S($P($G(^OR(100,ORJ,0)),"^",14):$E($P(^DIC(9.4,$P(^(0),"^",14),0),"^"),1,11),1:"")
 ..W ?77,$S(^TMP($J,"DET",ORI,ORJ):"Y",1:"N"),! I $Y>(IOSL-4) D HDR("D")
 .Q:$G(ORSTOP)
 ;Summary report section
 I ORREP="B"!(ORREP="S") D  Q:$G(ORSTOP)  ;print summary report if selected
 .D HDR("S") Q:$G(ORSTOP)  I '$D(^TMP($J,"SUM")) W !,"There is no data for the criteria you selected." S ORSTOP=1 Q
 .S ORI="" F  S ORI=$O(^TMP($J,"SUM",ORI)) Q:ORI=""!($G(ORSTOP))  D  Q:$G(ORSTOP)  D SUBTOT:'ORFS
 ..S ORWROTE=0 K ORSTOT F ORP="I","O" Q:$G(ORSTOP)  I $D(^TMP($J,"SUM",ORI,ORP)) D
 ...I 'ORFS D  ;If not summary total only then write provider specific information
 ....W:'ORWROTE $E(ORI,1,25),! S ORWROTE=1 W ?1,$S(ORP="I":" Inpt",1:"Outpt")," Tot"
 ....W ?12,$J(+$P(^TMP($J,"SUM",ORI,ORP),"^"),6) I $P(^(ORP),"^")'=$P(^(ORP),"^",2) W ?19,$J(+$P(^(ORP),"^",10)_"/"_+$P(^(ORP),"^",9)_"/"_+$P(^(ORP),"^",8),15) ;Universe DEA Wet Sig Reqd/Student/Policy
 ....W ?34,$J(+$P(^TMP($J,"SUM",ORI,ORP),"^",2),8),?44,$J(+$P(^(ORP),"^",3),8),?53,$S(+$P(^(ORP),"^",2)'=0:$J($P(^(ORP),"^",3)/$P(^(ORP),"^",2)*100,3,0)_"%",1:"NONE")
 ....I $P(^(ORP),"^",2)'=$P(^(ORP),"^",3) W ?58,+$P(^(ORP),"^",4),"/",+$P(^(ORP),"^",5),"/",+$P(^(ORP),"^",6),"/",+$P(^(ORP),"^",7)
 ....W !
 ...F ORJ=1:1:10 S ORTOT(ORJ)=$G(ORTOT(ORJ))+$P(^(ORP),"^",ORJ),ORTOT(ORJ,ORP)=$G(ORTOT(ORJ,ORP))+$P(^(ORP),"^",ORJ) ;Overall totals
 ...S ORSTOT(1)=$G(ORSTOT(1))+$P(^(ORP),"^"),ORSTOT(2)=$G(ORSTOT(2))+$P(^(ORP),"^",2),ORSTOT(3)=$G(ORSTOT(3))+$P(^(ORP),"^",3)
 ...I $Y>(IOSL-4) D HDR("S")
 .Q:$G(ORSTOP)
 .I 'ORFS W $$REPEAT^XLFSTR("-",78)
 .F ORP="I","O" I $D(ORTOT(1,ORP)) D
 ..W !,$S(ORP="I":"INPT",1:"OUTPT"),?10,$J($G(ORTOT(1,ORP)),8),?19,$J(+$G(ORTOT(10,ORP))_"/"_+$G(ORTOT(9,ORP))_"/"_+$G(ORTOT(8,ORP)),15)
 ..W ?34,$J($G(ORTOT(2,ORP)),8),?44,$J($G(ORTOT(3,ORP)),8),?53,$S(+$G(ORTOT(2,ORP))'=0:$J($G(ORTOT(3,ORP))/$G(ORTOT(2,ORP))*100,3,0)_"%",1:"NONE")
 ..W ?58,+$G(ORTOT(4,ORP)),"/",+$G(ORTOT(5,ORP)),"/",+$G(ORTOT(6,ORP)),"/",+$G(ORTOT(7,ORP))
 .W !,"TOTAL",?10,$J($G(ORTOT(1)),8),?19,$J(+$G(ORTOT(10))_"/"_+$G(ORTOT(9))_"/"_+$G(ORTOT(8)),15)
 .W ?34,$J(ORTOT(2),8),?44,$J(ORTOT(3),8),?53,$S(+ORTOT(2)'=0:$J(ORTOT(3)/ORTOT(2)*100,3,0)_"%",1:"NONE"),?58,+$G(ORTOT(4)),"/",+$G(ORTOT(5)),"/",+$G(ORTOT(6)),"/",+$G(ORTOT(7))
 Q
 ;
SUBTOT ;Print individual sub totals
 W ?1,"  Sub-tot",?12,$J($G(ORSTOT(1)),6),?34,$J($G(ORSTOT(2)),8),?44,$J($G(ORSTOT(3)),8)
 W ?53,$S(+ORSTOT(2)'=0:$J($G(ORSTOT(3))/$G(ORSTOT(2))*100,3,0)_"%",1:"NONE"),!
 Q
 ;
HDR(TYPE) ;Print appropriate header
 I $E(IOST,1,2)="C-"&($G(PG)) S DIR(0)="E" D ^DIR S ORSTOP='Y K DIR Q:ORSTOP
 I $G(PG)!('$G(PG)&($E(IOST,1,2)="C-")) W @IOF
 S PG=$G(PG)+1
 W !,"CPRS Performance Monitor ",$S(TYPE="D":"- Detailed",ORFS:"- Summary Totals",1:"- Summary")," Report",?52,REPDT,?72,"PAGE ",$G(PG),!,"Selected Date Range: ",$$FMTE^XLFDT(ORSD+.1,2)," to ",$$FMTE^XLFDT(ORED\1,2),!
 W "Sort criteria: ",$S(ORPT="I":"IN",ORPT="O":"OUT",1:"ALL "),"PATIENTS/",$S(ORTYPE="P":"PHARMACY",1:"ALL")," ORDERS"
 I TYPE="D" W ?72,"ENTERED",!,"ORDER",?41,"ORD",?47,"PATIENT",?73,"BY HAS",!,"DATE",?11,"ORDER #",?19,"PAT ID",?27,"1st ORD ITEM",?41,"TYPE",?47,"LOCATION",?61,"PACKAGE",?74,"ORES?",!
 I TYPE="S" W ?58,"BREAKDOWN OF ORDERS",!,?34,"PROVIDER",?44,"PROVIDER",?58,"NOT SELF ENTERED",! W:'ORFS "PROVIDER" W ?10,"UNIVERSE",?23,"DEA/STU/POL",?36,"ORDERS",?45,"ENTERED",?56,"%",?58,"WR/VE/TE/EL",!
 W $$REPEAT^XLFSTR("-",IOM),!
 Q
 ;
