SROAPS1 ;BIR/MAM - PREOP INFO (PAGE 1) ;08/11/2011
 ;;3.0;Surgery;**38,47,125,153,166,174,176,182**;24 Jun 93;Build 49
 ;
 ; Reference to EN1^GMRVUT0 supported by DBIA #1446
 ;
 N I S SRPAGE="PAGE: 1 OF 2" D HDR^SROAUTL,PRE1
 W ! F I=1:1:80 W "-"
 Q
PRE1 N SRX,Y D HW,TUT^SROAUTL3 F I=200,200.1,206 S SRA(I)=$G(^SRF(SRTN,I))
 S Y=$P(SRA(200),"^"),SRX=402,SRAO(1)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(206),"^"),SRX=236,SRAO("1A")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(206),"^",2),SRX=237,SRAO("1B")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200.1),"^",11),SRX=519,SRAO("1C")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200.1),"^",12),SRX=520,SRAO("1D")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200.1),"^",9),SRX=517,SRAO("1E")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200.1),"^",10),SRX=518,SRAO("1F")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",4),SRX=246,SRAO("1G")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",55),SRX=618,SRAO("1H")=$$H618^SROACL1(Y)_"^"_SRX
 S Y=$P(SRA(200),"^",6),SRX=325,SRAO("1I")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200.1),"^",8),SRX=237.1,SRAO("1J")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",7),SRX=238,SRAO("1K")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200.1),"^",2),SRX=492,SRAO("1L")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",9),SRX=241,SRAO(2)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",10),SRX=204,SRAO("2A")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",11),SRX=203,SRAO("2B")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",12),SRX=326,SRAO("2C")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",13),SRX=244,SRAO(3)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",15),SRX=212,SRAO("3A")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200.1),"^"),SRX=486,SRAO(4)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",16),SRX=213,SRAO("4A")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",30),SRX=242,SRAO(5)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(206),"^",19),SRX=207,SRAO("5A")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(206),"^",14),SRX=205,SRAO("5B")=$S(Y=0:"NO",Y=1:"< OR = 7 DAYS OF SURG",Y=2:"BETWEEN 7 DAYS AND 6 MONTHS OF SURG",Y=3:"UNKNOWN",1:"")_"^"_SRX
 S Y=$P(SRA(200),"^",56),SRX=640,SRAO("5C")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(206),"^",42),SRX=485,SRAO("5D")=Y_"^"_SRX
 S Y=$P(SRA(206),"^",18),SRX=267,SRAO("5E")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",59),SRX=643,SRAO("5F")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",57),SRX=641,SRAO("5G")=$$H641^SROAPRT1(Y)_"^"_SRX
 S Y=$P(SRA(200),"^",40),SRX=206,SRAO(6)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(206),"^",16),SRX=265,SRAO("6A")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",42),SRX=330,SRAO("6B")=$$OUT(SRX,Y)_"^"_SRX K SRA
 W "1. GENERAL:",?32,$P(SRAO(1),"^"),?41,"3. HEPATOBILIARY:",?76,$P(SRAO(3),"^")
 W !,"  A. Height:" S Y=$P(SRAO("1A"),"^") W:Y'="NS" ?14,$J($P(Y,"^"),25) W:Y="NS" ?32,Y
 W ?43,"A. Ascites:",?76,$P(SRAO("3A"),"^")
 W !,"  B. Weight:" S Y=$P(SRAO("1B"),"^") W ?($S(Y="NS":19,1:24)),$J(Y,15)
 W !,"  C. Diabetes - Long Term:",?32,$P(SRAO("1C"),"^"),?41,"4. GASTROINTESTINAL:",?76,$P(SRAO(4),"^")
 W !,"  D. Diabetes - 2 Wks Preop:",?32,$P(SRAO("1D"),"^"),?43,"A. Esophageal Varices:",?76,$P(SRAO("4A"),"^")
 W !,"  E. Tobacco Use:",?19,$J($P(SRAO("1E"),"^"),21)
 W !,"  F. Tobacco Use Timeframe:",?28,$P(SRAO("1F"),"^")
 W !,"  G. ETOH > 2 Drinks/Day:",?32,$P(SRAO("1G"),"^"),?41,"5. CARDIAC:",?76,$P(SRAO(5),"^")
 W !,"  H. Positive Drug Screening:",?30,$P(SRAO("1H"),"^"),?43,"A. Congestive Heart Failure: ",?76,$P(SRAO("5A"),"^")
 W !,"  I. Dyspnea: ",?14,$J($P(SRAO("1I"),"^"),25),?43,"B. Prior MI: ",$J($E($P(SRAO("5B"),"^"),1,23),22)
 W !,"  J. Preop Sleep Apnea:",?31,$P(SRAO("1J"),"^"),?43,"C. PCI: ",$J($P(SRAO("5C"),"^"),29)
 W !,"  K. DNR Status: ",?32,$P(SRAO("1K"),"^"),?43,"D. Prior Heart Surgery:" D H485($P(SRAO("5D"),"^"))
 W !,"  L. Preop Funct Status: ",$J($P(SRAO("1L"),"^"),17),?43,"E. Angina Severity:",$J($P(SRAO("5E"),"^"),18)
 W !,?43,"F. Angina Timeframe:",$J($E($P(SRAO("5F"),"^"),1,15),17)
 W !,?43,"G. Hypertension:",$J($P(SRAO("5G"),"^"),21)
 W !,"2. PULMONARY:",?32,$P(SRAO(2),"^")
 W !,"  A. Ventilator Dependent:",?32,$P(SRAO("2A"),"^"),?41,"6. VASCULAR:",?76,$P(SRAO(6),"^")
 W !,"  B. History of Severe COPD:",?32,$P(SRAO("2B"),"^"),?43,"A. PAD:",?(78-$L($P(SRAO("6A"),"^"))),$P(SRAO("6A"),"^")
 W !,"  C. Current Pneumonia:",?32,$P(SRAO("2C"),"^"),?43,"B. Rest Pain/Gangrene:",?76,$P(SRAO("6B"),"^")
 Q
OUT(SRFLD,SRY) ; get data in output form
 N C,Y,Z
 I SRFLD=207 Q $S(SRY="N":"NONE",1:SRY)
 S Y=SRY,C=$P(^DD(130,SRFLD,0),"^",2) D:Y'="" Y^DIQ
 S Y=$S(Y="NO STUDY":"NS",Y="N/A":"NA",1:Y)
 I SRFLD=237.1 S Y=$E(Y,1,7)
 I SRFLD=237!(SRFLD=346) S Y=$E(Y,1,15)
 I SRFLD=236 S Z=$P($G(^SRF(SRTN,200.1)),"^",7) I Z'="" S Y="("_$E(Z,4,5)_"/"_$E(Z,6,7)_"/"_$E(Z,2,3)_")  "_Y
 I SRFLD=492 D
 .I SRY=2 S Y="PARTIAL DEPENDENT" Q
 .I SRY=1 S Y=Y_"    " Q
 .I SRY=4 S Y=Y_"      "
 I SRFLD=325,$L(Y)=2 S Y=Y_"     "
 I SRFLD=265 S Y=$S(SRY=1:"NO",SRY=2:"YES-W/O ANGI,REVASC,or AMPUT",SRY=3:"YES-W HX ANGI,REVASC,or AMPUT",SRY=4:"UNKNOWN",1:"") Q Y
 Q Y
HW ; get weight & height from Vitals
 N SREND,SREQ,SREX,SREY,SRSTRT
WT I $P($G(^SRF(SRTN,206)),"^",2)="" D
 .S SREND=$P($G(^SRF(SRTN,0)),"^",9),SRSTRT=$$FMADD^XLFDT(SREND,-30),SREX=$$HW^SROACL1(SRSTRT,SREND,"WT")
 .I SREX'="" S SREX=SREX+.5\1 D CHK^DIE(130,237,"E",SREX,.SREY) I SREY'="^" S $P(^SRF(SRTN,206),"^",2)=SREY
HT I $P($G(^SRF(SRTN,206)),"^")'="" Q
 N GMRVSTR,SRBRDT,SRBIEN,SRBDATA,SRHTDT
 K ^UTILITY($J,"GMRVD"),RESULTS S SREND=$P($G(^SRF(SRTN,0)),"^",9),GMRVSTR="HT",GMRVSTR(0)="^"_SREND_"^^0"
 D EN1^GMRVUT0 Q:'$D(^UTILITY($J,"GMRVD"))
 S SRBRDT="",SRBRDT=$O(^UTILITY($J,"GMRVD","HT",SRBRDT)) Q:'SRBRDT  D
 .S SRBIEN=0 F  S SRBIEN=$O(^UTILITY($J,"GMRVD","HT",SRBRDT,SRBIEN)) Q:'SRBIEN  D
 ..S SRBDATA=$G(^UTILITY($J,"GMRVD","HT",SRBRDT,SRBIEN)),SREX=$P(SRBDATA,"^",8)
 ..I SREX'="" S SREX=SREX+.5\1 D CHK^DIE(130,236,"E",SREX,.SREY) I SREY'="^" D
 ...S $P(^SRF(SRTN,206),"^")=SREY
 ...S SRHTDT=$P(SRBDATA,"^") I SRHTDT'="" S $P(^SRF(SRTN,200.1),"^",7)=SRHTDT
 Q
H485(X) S SHEMP="" F I=1:1:$L(X,",") D
 .S C=$P(X,",",I) S:I>1 SHEMP=SHEMP_", " S SHEMP=SHEMP_$S(C=0:"NONE",C=1:"CABG-ONLY",C=2:"VALVE-ONLY",C=3:"CABG/VALVE",C=4:"OTHER",C=5:"CABG/OTHER",C=6:"UNKNOWN",1:"")
 S X=SHEMP I $L(X)<12 W ?68,$J(X,12) Q
 W ?68,$J($P(X,",")_",",12) I $L($P(X,", ",2,9))<36 W !,?45,$P(X,", ",2,9) Q
 W !,?45,$P(X,", ",2,4)_",",!,?45,$P(X,", ",5,9)
 Q
