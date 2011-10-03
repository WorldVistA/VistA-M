SROAPCA ;BIR/MAM - PRINT CLINICAL DATA ;09/27/04
 ;;3.0; Surgery ;**38,47,71,95,125,134,153,160,174**;24 Jun 93;Build 8
 F I=0,206,207,208,200.1 S SRA(I)=$G(^SRF(SRTN,I)),$P(LN,"-",79)=""
 S X=$P(SRA(0),"^",9),SRADATE=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 W:$Y @IOF W !,?5,"VA CONTINUOUS IMPROVEMENT IN CARDIAC SURGERY PROGRAM (CICSP/CICSP-X)",!
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
 S SRA(200)=$G(^SRF(SRTN,200)),SRA(209)=$G(^SRF(SRTN,209))
 S NYUK=$P(SRA(209),"^",3),SRAO(6)=$S(NYUK="N":"NO",NYUK="O":"ORAL",NYUK="D":"DIET",NYUK="I":"INSULIN",1:"")_"^475",NYUK=$P(SRA(200),"^",11) D YN S SRAO(7)=SHEMP_"^203"
 S SRAO(8)=$P(SRA(206),"^",5)_"^347",NYUK=$P(SRA(206),"^",6) D YN S SRAO(9)=SHEMP_"^209",NYUK=$P(SRA(206),"^",7) D YN S SRAO(10)=SHEMP_"^348"
 S Y=$P(SRA(200.1),"^",5),C=$P(^DD(130,510,0),"^",2) D Y^DIQ S SRAO(11)=$S(Y["-":$E($P(Y,"-",2),1,22),1:$E(Y,1,22))_"^510"
 S NYUK=$P(SRA(206),"^",11) D YN S SRAO(14)=SHEMP_"^350",NYUK=$P(SRA(200),"^",8),SRAO(15)=$S(NYUK=1:"INDEPENDENT",NYUK=2:"PARTIAL DEPENDENT",NYUK=3:"TOTALLY DEPENDENT",NYUK="NS":"NS",1:"")_"^240"
 S NYUK=$P(SRA(206),"^",13),SRAO(16)=$S(NYUK=0:"None",NYUK=1:"NONE RECENT",NYUK=2:"12-72 HRS",NYUK=3:"<12 hrs",NYUK=12:"12 - 72 hrs",NYUK=72:">72 hrs - 7 days",NYUK=7:">7 days",NYUK="NS":"NO STUDY",1:"")_"^351"
 S NYUK=$P(SRA(206),"^",14),SRAO(17)=$S(NYUK=0:"NONE",NYUK=1:"< OR = 7 DAYS OF SURG",NYUK=2:"> 7 DAYS OF SURG",NYUK="NS":"NS",1:"")_"^205"
 S NYUK=$P(SRA(206),"^",15) S SHEMP=$S(NYUK=0:"NONE",NYUK=">":">3",NYUK="NS":"NS",NYUK="N":"NO",NYUK="Y":"YES",1:NYUK) S SRAO(18)=SHEMP_"^352"
 S NYUK=$P(SRA(206),"^",42)
 S NYUK=$P(SRA(206),"^",16) D YN S SRAO(19)=SHEMP_"^265",NYUK=$P(SRA(206),"^",17) D YN S SRAO(20)=SHEMP_"^264"
 S SRAO(21)=$P(SRA(206),"^",18)_"^267",SRAO(22)=$P(SRA(206),"^",19)_"^207",NYUK=$P(SRA(206),"^",20) D YN S SRAO(23)=SHEMP_"^353",NYUK=$P(SRA(206),"^",21) D YN S SRAO(24)=SHEMP_"^354"
 S NYUK=$P(SRA(206),"^",22) D YN S SRAO(25)=SHEMP_"^355"
 S NYUK=$P(SRA(209),"^",2),SRAO(26)=$S(NYUK="N":"NONE",NYUK="I":"IABP",NYUK="V":"VAD",NYUK="A":"ARTI",NYUK="O":"OTHER",1:NYUK)_"^474"
 S NYUK=$P(SRA(206),"^",38) D YN S SRAO(27)=SHEMP_"^463"
 S NYUK=$P(SRA(206),"^",10) D YN S SRAO(29)=SHEMP_"^349"
 S NYUK=$P(SRA(208),"^",19) D YN S SRAO(30)=SHEMP_"^509"
DISP ; display fields
 W ! F MOE=1:1:80 W "="
 W !,"II. CLINICAL DATA"
 W !,"Gender:",?26,$P(SRAO(2),"^"),?40,"Prior MI:",$J($P(SRAO(17),"^"),30)
 W !,"Age:",?26,SRAO(3),?40,"# of prior heart surgeries:",?75,$P(SRAO(18),"^")
 W !,"Height:",?26,$P(SRAO(4),"^"),?40,"Prior heart surgeries: " D H485
 W !,"Weight:",?26,$P(SRAO(5),"^"),?40,"Peripheral Vascular Disease:",?75,$P(SRAO(19),"^")
 W !,"Diabetes:",?26,$P(SRAO(6),"^"),?40,"Cerebral Vascular Disease:",?75,$P(SRAO(20),"^")
 W !,"COPD:",?26,$P(SRAO(7),"^"),?40,"Angina (use CCS Class):",?75,$P(SRAO(21),"^")
 W !,"FEV1:",?26,$P(SRAO(8),"^")_$S($P(SRAO(8),"^")="":"",$P(SRAO(8),"^")="NS":"",1:" liters"),?40,"CHF (use NYHA Class):",?75,$P(SRAO(22),"^")
 W !,"Cardiomegaly (X-ray): ",?26,$P(SRAO(9),"^"),?40,"Current Diuretic Use:",?75,$P(SRAO(23),"^")
 W !,"Pulmonary Rales:",?26,$P(SRAO(10),"^"),?40,"Current Digoxin Use:",?75,$P(SRAO(24),"^")
 W !,"Current Smoker: ",$J($P(SRAO(11),"^"),22),?40,"IV NTG 48 Hours Preceding Surgery:",?75,$P(SRAO(25),"^")
 W !,"Active Endocarditis:",?26,$P(SRAO(29),"^"),?40,"Preop Circulatory Device:",?74,$P(SRAO(26),"^")
 W !,"Resting ST Depression:",?26,$P(SRAO(14),"^"),?40,"Hypertension:",?75,$P(SRAO(27),"^")
 W !,"Functional Status: ",$J($P(SRAO(15),"^"),18),?40,"Preoperative Atrial Fibrillation:",?75,$P(SRAO(30),"^")
 W !,"PCI: ",$J($P(SRAO(16),"^"),34)
 K SRA,SRAO D ^SROAPCA1
 Q
YN ; store answer
 S SHEMP=$S(NYUK="NS":"NS",NYUK="N":"NO",NYUK="Y":"YES",1:"")
 Q
PAGE I $E(IOST)'="P" W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 W @IOF,!,SRANM,! F MOE=1:1:80 W "="
 Q
H485 S SHEMP="",X=$P(SRA(206),"^",42) F I=1:1:$L(X,",") D
 .S C=$P(X,",",I) S:I>1 SHEMP=SHEMP_", " S SHEMP=SHEMP_$S(C=0:"None",C=1:"CABG-only",C=2:"Valve-only",C=3:"CABG/valve",C=4:"Other",C=5:"CABG/Other",1:"")
 S X=SHEMP I $L(X)<17 W $J(X,16) Q
 W $J($P(X,",")_",",16) I $L($P(X,", ",2,9))<40 W !,?41,$P(X,", ",2,9) Q
 W !,?41,$P(X,", ",2,4)_",",!,?41,$P(X,", ",5,9)
 Q
