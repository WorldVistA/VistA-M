SROAPRT1 ;BIR/MAM - PREOP INFO (PAGE 1) ;04/05/2012
 ;;3.0;Surgery;**38,47,125,153,166,174,176,182,184**;24 Jun 93;Build 35
 N SRX,Y F I=200,200.1,206,207,210 S SRA(I)=$G(^SRF(SRTN,I))
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
 S Y=$P(SRA(200.1),"^",15),SRX=667,SRAO("1GG")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",7),SRX=238,SRAO("1H")=$$OUT(SRX,Y)_"^"_SRX
 ;S Y=$P(SRA(200.1),"^",2),SRX=492,SRAO("1I")=$S(Y=1:"INDEPENDENT",Y=2:"PARTIAL DEPENDENT",Y=3:"TOTALLY DEPENDENT",Y="NS":"NS",1:"")_"^"_SRX
 S Y=$P(SRA(200.1),"^",2),SRX=492,SRAO("1I")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(210),"^",5),SRX=670,SRAO("1J")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(210),"^",6),SRX=671,SRAO("1K")=$S(Y=1:"AMB W/O ASSISTIVE DEVICE",Y=2:"AMB WITH CANE OR WALKER",Y=3:"USES MANUAL WHEELCHAIR INDEPENDENTLY",Y=4:"DOES NOT AMB",1:"")_"^"_SRX
 S Y=$P(SRA(200),"^",9),SRX=241,SRAO(2)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",10),SRX=204,SRAO("2A")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",11),SRX=203,SRAO("2B")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",12),SRX=326,SRAO("2C")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",13),SRX=244,SRAO(3)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",15),SRX=212,SRAO("3A")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200.1),"^"),SRX=486,SRAO(4)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",16),SRX=213,SRAO("4A")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",30),SRX=242,SRAO(5)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(207),"^",29),SRX=423,SRAO("5A")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(206),"^",14),SRX=205,SRAO("5B")=$S(Y=0:"NO",Y=1:"< OR = 7 DAYS OF SURG",Y=2:"BETWEEN 7 DAYS AND 6 MONTHS OF SURG",Y=3:"UNKNOWN",Y=4:"> 6 MONTHS",Y=5:"UNKNOWN",1:"")_"^"_SRX
 S Y=$P(SRA(200),"^",56),SRX=640,SRAO("5C")=$S(Y=1:"NONE",Y=2:"<12 HRS OF SURG",Y=3:">12 HRS-7 DAYS",Y=4:">7 DAYS",Y=5:"UNKNOWN",1:"")_"^"_SRX
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
 W !,"Height:",?24,$P(SRAO("1A"),"^"),?40,"Ascites:",?66,$P(SRAO("3A"),"^")
 W !,"Weight:",?24,$P(SRAO("1B"),"^")
 W !,"Diabetes - Long Term:",?24,$E($P(SRAO("1C"),"^"),1,14),?40,"GASTROINTESTINAL:",?72,$P(SRAO(4),"^")
 W !,"Diabetes - 2 Wks Preop:",?24,$E($P(SRAO("1CC"),"^"),1,14),?40,"Esophageal Varices:",?66,$P(SRAO("4A"),"^")
 W !,"Tobacco Use:",?24,$P(SRAO("1D"),"^")
 W !,"Tobacco Use Timeframe: ",?24,$P(SRAO("1DD"),"^")
 W !,"ETOH > 2 Drinks/Day:",?24,$P(SRAO("1E"),"^"),?40,"CARDIAC:",?72,$P(SRAO(5),"^")
 W !,"Positive Drug Screening:",?24,$E($P(SRAO("1FF"),"^"),1,8),?40,"Congestive Heart Failure:",?66,$E($P(SRAO("5A"),"^"),1,14)
 W !,"Dyspnea:",?24,$E($P(SRAO("1F"),"^"),1,14),?40,"Prior MI:",?66,$E($P(SRAO("5B"),"^"),1,14)
 W !,"Preop Sleep Apnea:",?24,$P(SRAO("1G"),"^"),?40,"PCI:",?66,$P(SRAO("5C"),"^")
 W !,"Sleep Apnea-Compliance:",?24,$E($P(SRAO("1GG"),"^"),1,9)
 W !,"DNR Status:",?24,$P(SRAO("1H"),"^"),?40,"Prior Heart Surgery: " D H485
 W !,"Functional Status:",?24,$E($P(SRAO("1I"),"^"),1,14),?40,"Angina Severity:",?66,$P(SRAO("5E"),"^")
 W !,"Current Residence: ",$E($P(SRAO("1J"),"^"),1,19)
 W ?40,"Angina Timeframe:",$J($E($P(SRAO("5F"),"^"),1,20),22)
 W !,"Ambulation Device: ",$E($P(SRAO("1K"),"^"),1,19),?40,"Hypertension: ",?(74-$L($P(SRAO("5G"),"^"))),$P(SRAO("5G"),"^")
 W !!,"PULMONARY:",?31,$P(SRAO(2),"^")
 W !,"Ventilator Dependent:",?25,$P(SRAO("2A"),"^"),?40,"VASCULAR:",?72,$P(SRAO(6),"^")
 W !,"History of Severe COPD:",?25,$P(SRAO("2B"),"^"),?40,"PAD:",?(79-$L($P(SRAO("6A"),"^"))),$P(SRAO("6A"),"^")
 W !,"Current Pneumonia:",?25,$P(SRAO("2C"),"^"),?40,"Rest Pain/Gangrene:",?72,$P(SRAO("6B"),"^")
 Q
OUT(SRFLD,SRY) ; get data in output form
 N C,Y
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
 S X=SHEMP I $L(X)<14 W ?66,X Q
 W $J($P(X,",")_",",15) I $L($P(X,", ",2,9))<40 W !,?41,$P(X,", ",2,9) Q
 W !,?41,$P(X,", ",2,4)_",",!,?41,$P(X,", ",5,9)
 Q
