SROACL1 ;BIR/MAM - CARDIAC PREOP CLINICAL DATA ;06/13/06
 ;;3.0; Surgery ;**38,71,95,125,153,160,174**;24 Jun 93;Build 8
 ;
 ; Reference to EN1^GMRVUT0 supported by DBIA #1446
 ;
 F I=0,200,202,205,206,206.1,208,209,200.1 S SRA(I)=$G(^SRF(SRTN,I))
HT N SRSD,SRED S SRED=$P(SRA(0),"^",9)
 I $P(SRA(206),"^")="" S SRSD=$$FMADD^XLFDT(SRED,-365),NYUK=$$HW(SRSD,SRED,"HT") D
 .I NYUK'="" S NYUK=NYUK+.5\1,$P(^SRF(SRTN,206),"^")=NYUK,SRA(206)=$G(^SRF(SRTN,206))
 S NYUK=$P(SRA(206),"^") S:NYUK'="" NYUK=$S(NYUK["C"!(NYUK["c"):+NYUK_" cm",+NYUK=NYUK:+NYUK_" in",NYUK="NS":" NS",1:NYUK) S SRAO(1)=NYUK_"^236"
WT I $P(SRA(206),"^",2)="" S SRSD=$$FMADD^XLFDT(SRED,-30),NYUK=$$HW(SRSD,SRED,"WT") D
 .I NYUK'="" S NYUK=NYUK+.5\1,$P(^SRF(SRTN,206),"^",2)=NYUK,SRA(206)=$G(^SRF(SRTN,206))
 S NYUK=$P(SRA(206),"^",2) S:NYUK'="" NYUK=$S(NYUK["K"!(NYUK["k"):+NYUK_" kg",+NYUK=NYUK:+NYUK_" lb",NYUK="NS":" NS",1:NYUK) S SRAO(2)=NYUK_"^237"
 K SRA(0) S NYUK=$P(SRA(209),"^",3),SRAO(3)=$S(NYUK="N":"   NO",NYUK="D":"  DIET",NYUK="O":"  ORAL",NYUK="I":" INSULIN",1:"")_"^475",NYUK=$P(SRA(200),"^",11) D YN S SRAO(4)=SHEMP_"^203"
 S SRAO(5)=$P(SRA(206),"^",5)_"^347",NYUK=$P(SRA(206),"^",6) D YN S SRAO(6)=SHEMP_"^209",NYUK=$P(SRA(206),"^",7) D YN S SRAO(7)=SHEMP_"^348"
 S Y=$P(SRA(200.1),"^",5),C=$P(^DD(130,510,0),"^",2) D Y^DIQ S SRAO(8)=$S(Y["-":$E($P(Y,"-",2),1,19),1:$E(Y,1,19))_"^510"
 S NYUK=$P(SRA(206),"^",10) D YN S SRAO(9)=SHEMP_"^349"
 S NYUK=$P(SRA(206),"^",11) D YN S SRAO(10)=SHEMP_"^350",NYUK=$P(SRA(200),"^",8),SRAO(11)=$S(NYUK=1:"INDEPENDENT",NYUK=2:"PARTIAL DEPENDENT",NYUK=3:"TOTALLY DEPENDENT",NYUK="NS":"NO STUDY",1:"")_"^240"
 S NYUK=$P(SRA(206),"^",13),SRAO(12)=$S(NYUK=0:"NONE    ",NYUK=1:"NONE RECENT",NYUK=2:"12-72 HRS",NYUK=3:"<12 hrs  ",NYUK=12:"12 - 72 hrs",NYUK=72:">72 hrs - 7 days",NYUK=7:">7 days  ",NYUK="NS":"NO STUDY",1:"")_"^351"
 S NYUK=$P(SRA(206),"^",14),SRAO(13)=$S(NYUK=0:"NONE",NYUK=1:"< OR = 7 DAYS",NYUK=2:"> 7 DAYS",1:"")_"^205"
 S NYUK=$P(SRA(206),"^",15) S SRAO(14)=$S(NYUK=0:"NONE",NYUK=">":">3",NYUK="Y":"YES",NYUK="N":"NO",1:NYUK)_"^352"
 S SRAO(15)=$P(SRA(206),"^",42)_"^485"
 S NYUK=$P(SRA(206),"^",16) D YN S SRAO(16)=SHEMP_"^265",NYUK=$P(SRA(206),"^",17) D YN S SRAO(17)=SHEMP_"^264"
 S SRAO(18)=$P(SRA(206),"^",18)_"^267",SRAO(19)=$P(SRA(206),"^",19)_"^207",NYUK=$P(SRA(206),"^",20) D YN S SRAO(20)=SHEMP_"^353",NYUK=$P(SRA(206),"^",21) D YN S SRAO(21)=SHEMP_"^354"
 S NYUK=$P(SRA(206),"^",22) D YN S SRAO(22)=SHEMP_"^355"
 S NYUK=$P(SRA(209),"^",2),SRAO(23)=$S(NYUK="N":"NONE",NYUK="I":"IABP",NYUK="V":"VAD",NYUK="A":"ARTI",NYUK="O":"OTHER",1:"")_"^474"
 S NYUK=$P(SRA(206),"^",38) D YN S SRAO(24)=SHEMP_"^463"
 S NYUK=$P(SRA(208),"^",19) D YN S SRAO(25)=SHEMP_"^509"
DISP ; display fields
 S SRPAGE="PAGE: 1" D HDR^SROAUTL
 W !," 1. Height:",?29,$P(SRAO(1),"^"),?41,"14. Number prior heart surgeries: ",?70,$P(SRAO(14),"^")
 W !," 2. Weight:",?29,$P(SRAO(2),"^"),?41,"15. Prior heart surgeries:" D H485
 W !," 3. Diabetes:",?27,$P(SRAO(3),"^"),?41,"16. Peripheral Vascular Disease:",?75,$P(SRAO(16),"^")
 W !," 4. COPD:",?30,$P(SRAO(4),"^"),?41,"17. Cerebral Vascular Disease:",?75,$P(SRAO(17),"^")
 W !," 5. FEV1:",?($S($P(SRAO(5),"^")="NS":30,1:27)),$P(SRAO(5),"^")_$S($P(SRAO(5),"^")="":"",$P(SRAO(5),"^")="NS":"",1:" liters"),?41,"18. Angina (use CCS Class):",?75,$P(SRAO(18),"^")
 W !," 6. Cardiomegaly (X-ray):",?30,$P(SRAO(6),"^"),?41,"19. CHF (use NYHA Class):",?75,$P(SRAO(19),"^")
 W !," 7. Pulmonary Rales:",?30,$P(SRAO(7),"^"),?41,"20. Current Diuretic Use:",?75,$P(SRAO(20),"^")
 W !," 8. Current Smoker: ",$J($P(SRAO(8),"^"),19),?41,"21. Current Digoxin Use:",?75,$P(SRAO(21),"^")
 W !," 9. Active Endocarditis:",?30,$P(SRAO(9),"^"),?41,"22. IV NTG within 48 Hours:",?75,$P(SRAO(22),"^")
 W !,"10. Resting ST Depression:",?30,$P(SRAO(10),"^"),?41,"23. Preop Circulatory Device:",?75,$P(SRAO(23),"^")
 W !,"11. Functional Status: ",$J($P(SRAO(11),"^"),17),?41,"24. Hypertension (Y/N):",?75,$P(SRAO(24),"^")
 W !,"12. PCI: ",$J($P(SRAO(12),"^"),29),?41,"25. Preop Atrial Fibrillation:",?75,$P(SRAO(25),"^")
 W !,"13. Prior MI: ",$J($P(SRAO(13),"^"),24)
 W !! F MOE=1:1:80 W "-"
 Q
YN ; store answer
 S SHEMP=$S(NYUK="NS":"NS",NYUK="N":"NO",NYUK="Y":"YES",1:"")
 Q
H485 S SHEMP="",X=$P(SRAO(15),"^") F I=1:1:$L(X,",") D
 .S C=$P(X,",",I) S:I>1 SHEMP=SHEMP_", " S SHEMP=SHEMP_$S(C=0:"NONE",C=1:"CABG-ONLY",C=2:"VALVE-ONLY",C=3:"CABG/VALVE",C=4:"OTHER",C=5:"CABG/OTHER",1:"")
 ;
 S X=SHEMP I $L(X)<12 W ?68,$J(X,11) Q
 W ?68,$J($P(X,",")_",",11) I $L($P(X,", ",2,9))<36 W !,?44,$P(X,", ",2,9) Q
 W !,?44,$P(X,", ",2,4)_",",!,?44,$P(X,", ",5,9)
 Q
HW(SRSD,SRED,SVTYPE) ; get weight & height from Vitals
 N GMRVSTR,SRTYPE,SRBCNT,SRBRDT,SRBIEN,SRBDATA,RESULTS
 K ^UTILITY($J,"GMRVD"),RESULTS S GMRVSTR=SVTYPE,GMRVSTR(0)=SRSD_"^"_SRED_"^^"
 D EN1^GMRVUT0 Q:'$D(^UTILITY($J,"GMRVD")) ""
 S SRTYPE="",SRBCNT=1 F  S SRTYPE=$O(^UTILITY($J,"GMRVD",SRTYPE)) Q:SRTYPE=""  D
 .S SRBRDT=0 F  S SRBRDT=$O(^UTILITY($J,"GMRVD",SRTYPE,SRBRDT)) Q:'SRBRDT  D
 ..S SRBIEN=0 F  S SRBIEN=$O(^UTILITY($J,"GMRVD",SRTYPE,SRBRDT,SRBIEN)) Q:'SRBIEN  D
 ...S SRBDATA=$G(^UTILITY($J,"GMRVD",SRTYPE,SRBRDT,SRBIEN))
 ...S RESULTS(SRTYPE,SRBRDT)=$P(SRBDATA,"^",1,2)_"^"_$P(SRBDATA,"^",8),SRBCNT=SRBCNT+1
 I $D(RESULTS(SVTYPE)) S SRI=$O(RESULTS(SVTYPE,0)) Q $P(RESULTS(SVTYPE,SRI),"^",3)
 Q ""
