MMRSCRE4 ;TCK/LEIDOS - Print CRE Report Cont. (Contains functions to print report) ; 11/29/16 1:33pm
 ;;1.0;MDRO PROGRAM TOOLS;**4**;JUN 01, 2016;Build 130
 ;
PRINT ;Prints report data
 N PG,MMRSNOW,NUMLOCS,LOCNAME,LN,PREVLOC,INDATE,DFN,OUTDATE,DATA
 S PG=0
 S MMRSNOW=$$NOW^XLFDT()
 S NUMLOCS=0
 S LOCNAME="" F  S LOCNAME=$O(^TMP($J,"MMRSCRE","D",LOCNAME)) Q:LOCNAME=""  S NUMLOCS=NUMLOCS+1
 I PRTSUM S RPTYP="SUMMARY"
 I 'PRTSUM S RPTYP="DETAILED"
 S LOCNAME="" F  S LOCNAME=$O(^TMP($J,"MMRSCRE","D",LOCNAME)) Q:LOCNAME=""  D
 .I '$D(DIVARY(LOCNAME)) K DIVARY(LOCNAME) Q
 .I $D(DIVARY(LOCNAME)) K DIVARY(LOCNAME)
 .Q:$G(LOCNAME)=""
 .D PATDAYS^MMRSCRE
 .D PRTSUMA(LOCNAME)
 S $P(LN,"-",165)=""
 Q:'$D(DIVARY)
 S DVSN="" F  S DVSN=$O(DIVARY(DVSN)) Q:DVSN=""  D
 .Q:$G(DVSN)=""
 .S LOC=DVSN
 .D PRTHDRD
 .W !!!,"NO RECORDS FOUND FOR REPORTING PERIOD."
 .W !!!
 W !!,"END OF REPORT"
 Q
PRINTADM(LOC) ; Print cont.
 S $P(LN,"-",165)=""
 D PRTHDRD
 N NODE,IN,WRD,PTN,L4,IND,ADT,MMV,SRC,SC,CC,VAL,INC
 S IN=""
 Q:LOC=""
 I '$D(^TMP($J,"MMRSCRE","DETAIL",LOC)) D  Q
 .W !!!,"NO RECORDS FOUND FOR REPORTING PERIOD."
 F  S IN=$O(^TMP($J,"MMRSCRE","DETAIL",LOC,IN)) Q:IN=""  D
 .S NODE=^TMP($J,"MMRSCRE","DETAIL",LOC,IN)
 .S WRD=$P(NODE,"^"),PTN=$P(NODE,"^",2),L4=$P(NODE,"^",3)
 .S IND=$P(NODE,"^",4),ADT=$P(NODE,"^",5),MMV=$P(NODE,"^",6)
 .S SRC=$P(NODE,"^",7),SRC=$$GET1^DIQ(61,SRC,.01,"E")
 .S SC=$P(NODE,"^",8),CC=$P(NODE,"^",9)
 .S VAL=$P(NODE,"^",10) I VAL="Y" S VAL="POS"
 .S DTTE=$P(IND,"."),TIM=$P(IND,".",2),TIM=$E(TIM,1,4)
 .S IND=DTTE_"."_TIM,IND=$$FMTE^XLFDT(IND)
 .S WD="",WD=$O(^DIC(42,"B",WRD,WD))
 .I $G(WD)'="" S SPCTY=$$GET1^DIQ(42,WD,.017,"E")
 .Q:$G(VAL)=""
 .W !,WRD,?21,$G(SPCTY),?46,PTN,?70,L4,?77,IND,?97,ADT,?109,MMV,?122,SRC,?131,SC,?145,CC,?157,VAL
 .I $Y+1>IOSL,LOC'="" D PRTHDRD
 Q
PRTHDRD ;
 S PG=PG+1
 W @IOF
 S $P(LN,"-",165)=""
 W ?13,"CRE ACUTE CARE IPEC REPORT - "_RPTYP
 W !,?13,"Division: ",LOC
 W !,?13,"Report period: ",$$FMTE^XLFDT(STRTDT)," to ",$$FMTE^XLFDT(ENDDT)
 W !,?13,"Report printed on: ",$$FMTE^XLFDT(MMRSNOW),?70,"PAGE: ",PG
 W !!
 Q:PRTSUM
 W ?77,"DATE",?111,"MAS MOVE",?131,"SURVEILLANCE",?145,"CLINICAL",?157,"CULTURE"
 W !,"WARD",?21,"SERVICE",?46,"PATIENT",?70,"LAST4",?77,"ENTERED WARD",?97,"ADT",?111,"TYPE",?122,"SOURCE",?131,"CULTURE",?145,"CULTURE",?157,"RESULT"
 W !,LN
 ;S PG=PG+1
 Q
PRTSUMA(LOC) ;
 N II,L
 W @IOF
 S PG=$G(PG)+1
 W ?13,"CRE ACUTE CARE IPEC REPORT - "_RPTYP
 I $G(LOC)'="" W !,?13,"Division: ",LOC
 I $G(LOC)="" W !,?13,"Divisions: " D  Q
 .S II=1 S L="" F  S L=$O(^TMP($J,"MMRSCRE","DSUM",L)) Q:L=""  W:II>1&($X>37) ", " W L_"," S II=II+1 I $X>110 W !,?37
 W !,?13,"Report period: ",$$FMTE^XLFDT(STRTDT)," to ",$$FMTE^XLFDT(ENDDT)
 W !,?13,"Report printed on: ",$$FMTE^XLFDT(MMRSNOW),?70,"PAGE: ",PG
 I $G(LOC)'="" S DATA=$G(^TMP($J,"MMRSCRE","DSUM",LOC))
 I $G(LOC)="" S DATA=$G(^TMP($J,"MMRSCRE","DSUM"))
 I $G(LOC)'="" S DATA1=$G(^TMP($J,"MMRSCREPD","DSUM",LOC))
 I $G(LOC)="" S DATA1=$G(^TMP($J,"MMRSCREPD","DSUM"))
 W !!,"Basic Measures and Device Days of Care"
 W !,?3,"01 Total # of admissions to the acute care inpatient facility for the period: ",$P(DATA,"^")
 W !,?3,"02 Total # of bed days of care for acute care for the period: ",DATA1
 W !!,"Admission Prevalence Measures (Facility/Division Wide)"
 W !,?3,"07 # of (01) with surveillance screens for CRE/CPE collected upon admission: ",$P(DATA,U,2)
 W !,?3,"08 # of (07) that were positive for CRE/CPE based on surveillance screen: ",$P(DATA,U,3)
 W !,?3,"09 # of (01) that were positive for CRE/CPE based on clinical cultures: ",$P(DATA,"^",4)
 S (POS,CC,SC,SCPCT,CCPCT)=0
 S TOTAL=$P(DATA,"^")
 S TSC=$P(DATA,"^",2)
 S SCPOS=$P(DATA,"^",3)
 S CC=$P(DATA,"^",4)
 I SCPOS=0 S SCPCT=0
 I SCPOS>0 D
 .I SCPOS=TSC S SCPCT=100 Q
 .I SCPOS<TOTAL S SCPCT=(SCPOS/TSC)*100
 .I SCPCT>0 D
 ..I SCPCT["." D
 ...S SPCT=$P(SCPCT,"."),SCDEC=$P(SCPCT,".",2),SCDEC=$E(SCDEC,1,2)
 ...S SCPCT=SPCT_"."_SCDEC
 ;I CC<TOTAL S CCPCT=(CC/TOTAL)*100
 I CC=0 S CCPCT=0
 I CC>0 D
 .I CC=TOTAL S CCPCT=100 Q
 .I CC<TOTAL S CCPCT=(CC/TOTAL)*100
 .I CCPCT["." D
 ..S PCT=$P(CCPCT,"."),CCDEC=$P(CCPCT,".",2),CCDEC=$E(CCDEC,1,2)
 ..S CCPCT=PCT_"."_CCDEC
 W !,?3,"10 % of (01) that were positive for CRE/CPE based on surveillance screening: ",$G(SCPCT)_"%"
 W !,?3,"11 % of (01) that were positive for CRE/CPE based on clinical cultures: ",$G(CCPCT)_"%"
 W !!,"Incidence Measures: Healthcare-Associated Colonized Cases"
 W !,?3,"12 # of patients with screens for CRE/CPE collected 3 or more days after admission: ",$P(DATA,U,5)
 W !,?3,"13 # of (12) that were positive for CRE/CPE based on surveillance screen collected 3 or more days after admission: ",$P(DATA,U,6)
 W !,?3,"14 # of patients with clinical cultures positive for CRE/CPE 3 or more days after admission: ",$P(DATA,U,7)
 S RATE=0
 I DATA1>0 D
 .S T=$P(DATA,U,6)+$P(DATA,U,7)
 .I T>0 S RATE=(T/DATA1)*1000
 .I RATE>0&(RATE[".") D
 ..S RTE=$P(RATE,"."),RTDEC=$P(RATE,".",2),RTDEC=$E(RTDEC,1,2)
 ..S RATE=RTE_"."_RTDEC
 ;I $L(RATE)=1 S RA
 W !,?3,"15 Rate of healthcare-associated colonized cases: ",$G(RATE)
 W !!,"Infection Prevention and Control Measures"
 W !,?3,"33 # of cases with CRE/CPE for the period: ",$P(DATA,U,8)
 ;I PRTSUM W !!!,"END OF REPORT." Q
 I 'PRTSUM D PRINTADM(LOCNAME)
 I '$D(DIVARY) W !!!,"END OF REPORT"
 Q
 ;
