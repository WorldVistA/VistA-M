SROAPCA ;BIR/MAM - PRINT CLINICAL DATA ;07/19/2011
 ;;3.0;Surgery;**38,47,71,95,125,134,153,160,174,175,176,182,184**;24 Jun 93;Build 35
 F I=0,200,206,207,208,209,200.1,210 S SRA(I)=$G(^SRF(SRTN,I)),$P(LN,"-",79)=""
 S X=$P(SRA(0),"^",9),SRADATE=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 W:$Y @IOF W !,?7,"VA SURGICAL QUALITY IMPROVEMENT PROGRAM - CARDIAC SPECIALTY",!
 W ! F MOE=1:1:80 W "="
 W !,"I. IDENTIFYING DATA",?60,"Case #: "_SRTN
 N SRSPH1,SRZIP S (SRSPH1,SRZIP)=""
 S STATNUM=+$P($$SITE^SROVAR,"^",3) D ADD^VADPT
 W !,"Patient: "_SRANM,?60,"Fac./Div. #: "_STATNUM
 W !,"Surgery Date: "_SRADATE,?25,"Address: "_VAPA(1)
 S SRSPH1=VAPA(8) S:SRSPH1="" SRSPH1="NS/Unknown" S SRZIP=$S(VAPA(11)'="":$P(VAPA(11),"^",2),1:VAPA(6)) S:SRZIP="" SRZIP="NS/Unknown"
 W !,"Phone: "_SRSPH1,?25,"Zip Code: "_SRZIP
 S X=VADM(3) W ?53,"Date of Birth: ",$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 S SRAO(1)=SRADATE,NYUK=$P(SRA(0),"^",4),SRAO(2)=$P(VADM(5),"^",2)
 S SRAO(3)=AGE,NYUK=$P(SRA(206),"^") S:NYUK'="" NYUK=$S(NYUK["C"!(NYUK["c"):+NYUK_" cm",1:+NYUK_" in") S SRAO(4)=NYUK_"^236"
 S NYUK=$P(SRA(206),"^",2) S:NYUK'="" NYUK=$S(NYUK["K"!(NYUK["k"):+NYUK_" kg",1:+NYUK_" lb") S SRAO(5)=NYUK_"^237"
 S Y=$P(SRA(200.1),"^",11),C=$P(^DD(130,519,0),"^",2) D:Y'="" Y^DIQ S SRAO(6)=Y_"^519"
 S Y=$P(SRA(200.1),"^",12),C=$P(^DD(130,520,0),"^",2) D:Y'="" Y^DIQ S SRAO(31)=Y_"^520"
 S NYUK=$P(SRA(200),"^",11) D YN S SRAO(7)=SHEMP_"^203"
 S SRAO(8)=$P(SRA(206),"^",5)_"^347",NYUK=$P(SRA(206),"^",6) D YN S SRAO(9)=SHEMP_"^209",NYUK=$P(SRA(206),"^",7) D YN S SRAO(10)=SHEMP_"^348"
 S Y=$P(SRA(200.1),"^",9),C=$P(^DD(130,517,0),"^",2) D:Y'="" Y^DIQ S SRAO(11)=Y_"^517"
 S Y=$P(SRA(200.1),"^",10),C=$P(^DD(130,518,0),"^",2) D:Y'="" Y^DIQ S SRAO(12)=Y_"^518"
 S NYUK=$P(SRA(206),"^",11) D YN S SRAO(14)=SHEMP_"^350"
 S NYUK=$P(SRA(200.1),"^",2),SRAO(15)=$S(NYUK=1:"INDEPENDENT",NYUK=2:"PARTIAL DEPENDENT",NYUK=3:"TOTALLY DEPENDENT",NYUK="NS":"NS",1:"")_"^492"
 S NYUK=$P(SRA(200),"^",56),SRAO(16)=$S(NYUK=1:"NONE",NYUK=2:"<12 HRS OF SURG",NYUK=3:">12 HRS - 7 DAYS",NYUK=4:">7 DAYS",NYUK=5:"UNKNOWN",1:"")_"^640"
 S NYUK=$P(SRA(206),"^",14),SRAO(17)=$S(NYUK=0:"NO",NYUK=1:"< OR = 7 DAYS OF SURG",NYUK=2:"BETWEEN 7 DAYS AND 6 MONTHS OF SURG",NYUK=3:"UNKNOWN",NYUK=4:"> 6 MONTHS",NYUK=5:"UNKNOWN",NYUK="NS":"NS",1:"")_"^205"
 S NYUK=$P(SRA(206),"^",15) S SHEMP=$S(NYUK=0:"NONE",NYUK=">":">3",NYUK="NS":"NS",NYUK="N":"NO",NYUK="Y":"YES",1:NYUK) S SRAO(18)=SHEMP_"^352"
 S NYUK=$P(SRA(200.1),"^",13),SRAO(20)=$S(NYUK=0:"NO CVD",NYUK=1:"YES/NO SURG",NYUK=2:"YES/PRIOR SURG",1:"")_"^521"
 S NYUK=$P(SRA(200.1),"^",14),SRAO(21)=$S(NYUK=0:"NO CVD",NYUK=1:"HIST OF TIA'S",NYUK=2:"CVA W/O NEURO DEF",NYUK=3:"CVA W/ NEURO DEF",1:"")_"^522"
 S NYUK=$P(SRA(206),"^",16) S SRAO(19)=$$OUT^SROACL1(265,NYUK)_"^265"
 S SRAO(22)=$$OUT^SROAPRT1(267,$P(SRA(206),"^",18))_"^267"
 S Y=$P(SRA(200),"^",59),SRAO("22A")=$S(Y=1:"NO ANGINA",Y=2:"W/N 14 DAY OF SURG",Y=3:"W/N 15-30 DAYS OF SURG",Y=4:"UNKNOWN",1:"")_"^643"
 S Y=$P(SRA(207),"^",29),SRAO(23)=Y_"-"_$S(Y=0:"N CARD DX",Y=1:"Y CARD DX",Y=2:"Y CARD DX",Y=3:"Y CARD DX",Y=4:"Y CARD DX",Y=5:"N CARD DX",Y=6:"Y CARD DX",1:"")_"^423"
 S NYUK=$P(SRA(206),"^",20) D YN S SRAO(24)=SHEMP_"^353",NYUK=$P(SRA(206),"^",21) D YN S SRAO(25)=SHEMP_"^354"
 S NYUK=$P(SRA(206),"^",22) D YN S SRAO(26)=SHEMP_"^355"
 S NYUK=$P(SRA(209),"^",2),SRAO(27)=$S(NYUK="N":"NONE",NYUK="I":"IABP",NYUK="V":"VAD",NYUK="A":"ARTI",NYUK="O":"OTHER",1:NYUK)_"^474"
 S NYUK=$P(SRA(200),"^",57) D H641^SROACL1 S SRAO(28)=SHEMP_"^641"
 S NYUK=$P(SRA(206),"^",10) D YN S SRAO(29)=SHEMP_"^349"
 S NYUK=$P(SRA(208),"^",19) D YN S SRAO(30)=SHEMP_"^509"
 S NYUK=$P(SRA(200),"^",55) S SRAO(13)=$$H618^SROACL1(NYUK)_"^618"
 S NYUK=$P(SRA(200.1),"^",8),SRAO(32)=$$OUT^SROACL1(237.1,NYUK)_"^237.1"
 S NYUK=$P(SRA(210),"^"),SRAO("32A")=$$OUT^SROACL1(662,NYUK)_"^662"
 S NYUK=$P(SRA(200.1),"^",15),SRAO("32B")=$$OUT^SROACL1(667,NYUK)_"^667"
DISP ; display fields
 W ! F MOE=1:1:80 W "="
 W !,"II. CLINICAL DATA"
 W !,"Gender:",?26,$P(SRAO(2),"^"),?40,"Age:",?(79-$L(SRAO(3))),SRAO(3)
 W !,"Height:",?26,$P(SRAO(4),"^"),?40,"Prior MI: " I $L($P(SRAO(17),"^"))>24 W ?54,$E($P(SRAO(17),"^"),1,25)
 I $L($P(SRAO(17),"^"))<25 W ?(79-$L($P(SRAO(17),"^"))),$P(SRAO(17),"^")
 W !,"Weight:",?26,$P(SRAO(5),"^"),?40,"Number of prior heart surgeries:",?(79-$L($P(SRAO(18),"^"))),$P(SRAO(18),"^")
 W !,"Diabetes - Long Term:",?26,$E($P(SRAO(6),"^"),1,12),?40,"Prior heart surgery: " D H485
 W !,"Diabetes - 2 Wks Preop:",?26,$E($P(SRAO(31),"^"),1,12),?40,"PAD:",?(79-$L($P(SRAO(19),"^"))),$P(SRAO(19),"^")
 W !,"COPD:",?26,$P(SRAO(7),"^"),?40,"CVD Repair/Obstruct:",?(79-$L($P(SRAO(20),"^"))),$P(SRAO(20),"^")
 W !,"FEV1:",?26,$P(SRAO(8),"^")_$S($P(SRAO(8),"^")="":"",$P(SRAO(8),"^")="NS":"",1:" liters"),?40,"History of CVD:",?(79-$L($P(SRAO(21),"^"))),$P(SRAO(21),"^")
 W !,"Cardiomegaly (X-ray): ",?26,$P(SRAO(9),"^"),?40,"Angina Severity: ",?(79-$L($P(SRAO(22),"^"))),$P(SRAO(22),"^")
 W !,"Tobacco Use: ",$J($P(SRAO(11),"^"),24),?40,"Angina Timeframe: ",?(79-$L($P(SRAO("22A"),"^"))),$P(SRAO("22A"),"^")
 W !,"Tobacco Use Timeframe: ",$J($P(SRAO(12),"^"),14),?40,"Congestive Heart Failure:",?(79-$L($P(SRAO(23),"^"))),$P(SRAO(23),"^")
 W !,"Positive Drug Screening: ",?26,$P(SRAO(13),"^"),?40,"Current Diuretic Use:",?(79-$L($P(SRAO(24),"^"))),$P(SRAO(24),"^")
 W !,"Active Endocarditis:",?26,$P(SRAO(29),"^"),?40,"IV NTG 48 Hours Preceding Surgery:",?(79-$L($P(SRAO(26),"^"))),$P(SRAO(26),"^")
 W !,"Functional Status: ",$J($P(SRAO(15),"^"),18),?40,"Preop Circulatory Device:",?(79-$L($P(SRAO(27),"^"))),$P(SRAO(27),"^")
 W !,"PCI:",?((18-$L($P(SRAO(16),"^"))\2)+19),$P(SRAO(16),"^"),?40,"Hypertension: ",?(79-$L($P(SRAO(28),"^"))),$P(SRAO(28),"^")
 W !,"Preop Sleep Apnea:",?26,$P(SRAO(32),"^"),?40,"Preoperative Atrial Fibrillation:",?(79-$L($P(SRAO(30),"^"))),$P(SRAO(30),"^")
 W !,"Sleep Apnea-Compliance:",$E($P(SRAO("32B"),"^"),1,16),?40,"Impaired Cognitive Function: ",$E($P(SRAO("32A"),"^"),1,11)
 K SRA,SRAO D ^SROAPCA1
 Q
YN ; store answer
 S SHEMP=$S(NYUK="NS":"NS",NYUK="NA":"N/A",NYUK="N":"NO",NYUK="Y":"YES",1:"")
 Q
PAGE I $E(IOST)'="P" W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 W @IOF,!,SRANM,! F MOE=1:1:80 W "="
 Q
H485 S SHEMP="",X=$P(SRA(206),"^",42) F I=1:1:$L(X,",") D
 .S C=$P(X,",",I) S:I>1 SHEMP=SHEMP_", " S SHEMP=SHEMP_$S(C=0:"NONE",C=1:"CABG-ONLY",C=2:"VALVE-ONLY",C=3:"CABG/VALVE",C=4:"OTHER",C=5:"CABG/OTHER",C=6:"UNKNOWN",1:"")
 S X=SHEMP I $L(X)<17 W $J(X,18) Q
 W $J($P(X,",")_",",16) I $L($P(X,", ",2,9))<40 W !,?41,$P(X,", ",2,9) Q
 W !,?41,$P(X,", ",2,4)_",",!,?41,$P(X,", ",5,9)
 Q
