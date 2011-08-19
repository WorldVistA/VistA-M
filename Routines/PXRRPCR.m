PXRRPCR ;HIN/MjK - Clinic Specfic Workload Reports ;6/7/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**146**;Aug 12, 1996
HDR D TITLE I $D(^TMP($J)) W @IOF,?(IOM-20),$E($$HTE^XLFDT($H),1,18)
 W @$S($D(^TMP($J)):"!?((IOM/2)-($L(PXRROPT)/2))",1:"!!?((IOM/2)-($L(PXRROPT)/2))"),PXRROPT,!!
 Q
ADMH W !,"Admission",?13,"Discharge",?30,"Patient",?61,"SSN",?69,"Room-Bed",!,"==========",?13,"========",?30,"=======",?57,"=========",?69,"======="
 Q
ERH W !,"ER Encounter Dt",?30,"Patient",?61,"SSN",!,"============",?30,"=======",?56,"============"
 Q
LABH W !,"LAB Date",?13,"Patient",?38,"SSN",?48,"Lab Test/Value",?73,"Hi/Low",!,"============",?13,"================",?35,"===========",?50,"=================",?73,"====="
 Q
DEMOG D HDR W ?1,"Clinic: ",$P($G(^SC(PXRRCLIN,0)),U),!
 W ?1,"Compared to the mean of: " D
 .  I $D(PXRSTPNM) W ?26,PXRSTPNM," Clinic Stop",!?26,"for ",PXRRCNUM," of ",PXRCLNUM," clinics with data" Q
 .  W ?27,$P($G(PXRRCLIN(1)),U) F I=2:1 Q:'$D(PXRRCLIN(I))  D
 .. I ($L($P(PXRRCLIN(I),U))+$X+3)<IOM W ", ",$P(PXRRCLIN(I),U) Q
 .. W !?27,$P($G(PXRRCLIN(I)),U)
 D LINE
 W ! I $D(^TMP($J,"CLINIC TOTALS",PXRRCLIN)) W ?1,"CASELOAD DEMOGRAPHICS for Encounter date range",?52,"|     Clinic     |",?72,"Overall" S Y=$P(PXRRBDT,".") D XD W !?1,Y," to " S Y=$P(PXRREDT,".") D XD S PXRREDT(1)=Y W Y D
 . W ?52,"|",?56,"#",?60,"|",?65,"%",?69,"|",?73,"Mean %" D DASH
 W ! Q
QLM D LINE W !?1,"QUALITY OF CARE MARKERS (6 mos. prior to ",PXRREDT(1),")",?61,"| Clinic",?71,"|Overall" S Y=$P(PXRRSXMO,".") D XD W !?1,Y," to " W PXRREDT(1),?61,"|   #",?71,"| Mean #" D DASH
 W ! Q
PREVMD D LINE W !?1,"PREVENTIVE MEDICINE (12 mos. prior to ",PXRREDT(1),")",?52,"|      Clinic      |Overall" S Y=$P(PXRRYR,".") D XD W !?1,Y," to " W PXRREDT(1),?52,"|    #",?61,"|   %",?71,"| Mean %" D DASH
 Q
UTIL D LINE W !?1,"UTILIZATION DATA (12 months prior to ",PXRREDT(1),?61,"| Number | Overall" S Y=$P(PXRRYR,".") D XD W !?1,Y," to " W PXRREDT(1),?61,"|   #    |   Mean #" D DASH
 Q
MEAN W ?1,"The overall mean values for this report will be for the clinic(s) selected",!?1,"which had encounters during the selected date range.",!
 Q
XD ;_._._._._._._._.Execute DD node for Date Format_._._._._._._._._._.
 S Y=$$FMTE^XLFDT(Y) Q
TITLE   ;_._._._._._.Set Common Title From Option file Name_._._._._.
 D OP^XQCHK S PXRROPT=$P(XQOPT,U,2)
 Q
COL ;_._._._._._._._._.Column Headings for WL report_._._._._._._._._
 W !?30,"|-------------PCE ENCOUNTERS DOCUMENTED----------------|"
 W ?89,"|---------SCHEDULING DATA------------|",!
 W ?30,"|-------E&M PATIENT CATEGORIES-------| NON  NO  TOTAL  |"
 W ?89,"|   WALK-INS   NO-SHOW   CANCELLED   |",!
 W ?0,"CLINIC NAME"
 W ?30,"|NEW   ESTABLISHED   CONSULT   OTHER | E&M  CPT ENCTRS |"
 W ?89,"|               APPTS     APPTS      |",!
 F I=1:1:127 W "="
 W ! Q
FTR ;_._._._._._._._._._._.Footer for WL report_._._._._._._._.__._._
 W !! F Z=1:1:127 W "="
 W !,?0,"TOTAL NUMBER OF CLINIC(S):",?64,$P($J(PXRRCN,4,1),".")
 W !,?0,"AVERAGE NUMBER OF PCE ENCOUNTERS PER CLINIC = ",?64,$J(PXRRAV,4,1)
 W !!,"This report presents a distribution of Clinic Encounters based"
 W " on CPT procedures associated with encounters. CPT",!
 W "Evaluation and Management (E&M) procedures are categorized to provide encounters by patient type, with non E&M and ",!,"no CPT procedures making up the remaining encounters."
 Q
BDT ;_._._.Help for Beginning Date Range_._._._.
 W !,"This is the beginning date for encounters that should be included in the creation of this report."
 Q
EDT ;_._._.Help for Ending Date Range_._._._.
 W !,"This is the ending date for encounters that should be included in the creation of this report."
 Q
LINE ;_._.Write a line_._.
 W ! F I=1:1:IOM W "_"
 Q
DASH ;_._.Write a line of dashes_._.
 W ! F I=1:1:IOM W "-"
 Q
