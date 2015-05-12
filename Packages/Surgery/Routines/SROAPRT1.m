SROAPRT1 ;BIR/MAM - PREOP INFO (PAGE 1) ;04/05/2012
 ;;3.0;Surgery;**38,47,125,153,166,174,176,182**;24 Jun 93;Build 49
 N SRX,Y F I=200,200.1,206 S SRA(I)=$G(^SRF(SRTN,I))
 S Y=$P(SRA(200),"^"),SRX=402,SRAO(1)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(206),"^"),SRX=236,SRAO("1A")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(206),"^",2),SRX=237,SRAO("1B")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200.1),"^",11),SRX=519,SRAO("1C")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200.1),"^",12),SRX=520,SRAO("1CC")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200.1),"^",9),SRX=517,SRAO("1D")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P($G(^SRF(SRTN,200.1)),"^",9) D  S SRA(200.1)=$G(^SRF(SRTN,200.1))
 .I Y'="",Y<3 S $P(^SRF(SRTN,200.1),"^",10)="NA" Q
 S Y=$P(SRA(200.1),"^",10),SRX=518,SRAO("1DD")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",4),SRX=246,SRAO("1E")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",6),SRX=325,SRAO("1F")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200.1),"^",8),SRX=237.1,SRAO("1G")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",7),SRX=238,SRAO("1H")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200.1),"^",2),SRX=492,SRAO("1I")=$$OUT(SRX,Y)_"^"_SRX
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
 S Y=$P(SRA(200),"^",57),SRX=641,SRAO("5G")=$$H641(Y)_"^"_SRX
 S Y=$P(SRA(200),"^",40),SRX=206,SRAO(6)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(206),"^",16),SRX=265,SRAO("6A")=$$OUT^SROAPS1(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",42),SRX=330,SRAO("6B")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",55),SRX=618,SRAO("1FF")=$$H618^SROACL1(Y)_"^"_SRX
 W:$E(IOST)="P" ! W !,?28,"PREOPERATIVE INFORMATION",!!
 W "GENERAL:",?31,$P(SRAO(1),"^"),?40,"HEPATOBILIARY:",?72,$P(SRAO(3),"^")
 W !,"Height: ",?22,$J($P(SRAO("1A"),"^"),15),?40,"Ascites:",?72,$P(SRAO("3A"),"^")
 W !,"Weight:",?22,$J($P(SRAO("1B"),"^"),15)
 W !,"Diabetes - Long Term:",?31,$P(SRAO("1C"),"^"),?40,"GASTROINTESTINAL:",?72,$P(SRAO(4),"^")
 W !,"Diabetes - 2 Wks Preop:",?31,$P(SRAO("1CC"),"^"),?40,"Esophageal Varices:",?72,$P(SRAO("4A"),"^")
 W !,"Tobacco Use:",?16,$J($P(SRAO("1D"),"^"),21)
 W !,"Tobacco Use Timeframe: ",$P(SRAO("1DD"),"^")
 W !,"ETOH > 2 Drinks/Day:",?31,$P(SRAO("1E"),"^"),?40,"CARDIAC:",?72,$P(SRAO(5),"^")
 W !,"Positive Drug Screening: ",?31,$E($P(SRAO("1FF"),"^"),1,8),?40,"Congestive Heart Failure:",?72,$P(SRAO("5A"),"^")
 W !,"Dyspnea: ",?13,$J($P(SRAO("1F"),"^"),25),?40,"Prior MI:",?(74-$L($E($P(SRAO("5B"),"^"),1,28))),$E($P(SRAO("5B"),"^"),1,28)
 W !,"Preop Sleep Apnea:",?30,$P(SRAO("1G"),"^"),?40,"PCI:",?(76-$L($P(SRAO("5C"),"^"))),$P(SRAO("5C"),"^")
 W !,"DNR Status: ",?31,$P(SRAO("1H"),"^"),?40,"Prior Heart Surgery: " D H485
 W !,"Preop Funct Status: ",$J($P(SRAO("1I"),"^"),17),?40,"Angina Severity:",?(76-$L($P(SRAO("5E"),"^"))),$P(SRAO("5E"),"^")
 W !,?40,"Angina Timeframe: ",$J($E($P(SRAO("5F"),"^"),1,20),22)
 W !,?40,"Hypertension: ",?(74-$L($P(SRAO("5G"),"^"))),$P(SRAO("5G"),"^")
 W !,"PULMONARY:",?31,$P(SRAO(2),"^")
 W !,"Ventilator Dependent:",?31,$P(SRAO("2A"),"^"),?40,"VASCULAR:",?72,$P(SRAO(6),"^")
 W !,"History of Severe COPD:",?31,$P(SRAO("2B"),"^"),?40,"PAD:",?(74-$L($P(SRAO("6A"),"^"))),$P(SRAO("6A"),"^")
 W !,"Current Pneumonia:",?31,$P(SRAO("2C"),"^"),?40,"Rest Pain/Gangrene:",?72,$P(SRAO("6B"),"^")
 Q
OUT(SRFLD,SRY) ; get data in output form
 N C,Y
 I SRFLD=207 Q $S(SRY="N":"NONE",1:SRY)
 S Y=SRY,C=$P(^DD(130,SRFLD,0),"^",2) D:Y'="" Y^DIQ
 S Y=$S(Y="NO STUDY":"NS",Y="N/A":"NA",1:Y)
 I SRFLD=237.1 S Y=$E(Y,1,7)
 I SRFLD=236!(SRFLD=237)!(SRFLD=346) S Y=$E(Y,1,15)
 I SRFLD=240!(SRFLD=492) D
 .I SRY=2 S Y="PARTIAL DEPENDENT" Q
 .I SRY=4 S Y=Y_"  "
 I SRFLD=325,$L(Y)=2 S Y=Y_"     "
 Q Y
H641(Y) ;
 S Y=$S(Y=1:"NO",Y=2:"YES WITHOUT MED",Y=3:"YES WITH MED",Y=4:"UNKNOWN",1:"")
 Q Y
H485 S SHEMP="",X=$P(SRA(206),"^",42) F I=1:1:$L(X,",") D
 .S C=$P(X,",",I) S:I>1 SHEMP=SHEMP_", " S SHEMP=SHEMP_$S(C=0:"None",C=1:"CABG-only",C=2:"Valve-only",C=3:"CABG/valve",C=4:"Other",C=5:"CABG/Other",C=6:"Unknown",1:"")
 S X=SHEMP I $L(X)<16 W $J(X,15) Q
 W $J($P(X,",")_",",15) I $L($P(X,", ",2,9))<40 W !,?41,$P(X,", ",2,9) Q
 W !,?41,$P(X,", ",2,4)_",",!,?41,$P(X,", ",5,9)
 Q
