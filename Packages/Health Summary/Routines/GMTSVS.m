GMTSVS ; SLC/KER - Vital Signs Component          ; 02/27/2002
 ;;2.7;Health Summary;**8,20,28,35,49,78**;Oct 20, 1995
 ;                          
 ; External References
 ;   DBIA  4791  EN1^GMVHS
 ;   DBIA 10141  $$VERSION^XPDUTL
 ;                    
 ; Health Summary patch GMTS*2.7*35 will require 
 ; Vitals version 4.0, patch GMRV*4.0*7
 ;                          
OUTPAT ; Outpatient Vital Signs Main Control
 N GMRVSTR
 S CNTR=$S(+($G(GMTSNDM))>0:+($G(GMTSNDM)),1:100)
 K ^UTILITY($J,"GMRVD"),ARRAY
 S T1=GMTSEND,T2=GMTSBEG,END=0,TN=0,LF=0
 S GMRVSTR="T"_";"_"P"_";"_"R"_";"_"BP"_";"_"HT"_";"_"WT"_";"_"CVP"_";"_"PO2"_";"_"CG"_";"_"PN"
 S GMRVSTR(0)=T2_"^"_T1_"^"_CNTR_"^"_1
 S GMRVSTR("LT")="^C^" ;Set to only get Vital Sign for Clinics
 ;D EN1^GMRVUT0
 D EN1^GMVHS
 ; If no data, display message and get
 ; most recent inpatient measurements
 I '$D(^UTILITY($J,"GMRVD")) D  Q
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W "*** No Outpatient measurements ***",!!
 . S CNTR=1 D ENVS
 D FIRST,SECOND:GMTSVMVR>3,KILLVS Q
 ;                          
ENVS ; Set up for Vitals Extraction Routine
 S CNTR=$S(+($G(CNTR))>0:+($G(CNTR)),+($G(CNTR))'>0&(+($G(GMTSNDM))>0):+($G(GMTSNDM)),1:100)
 K ^UTILITY($J,"GMRVD"),ARRAY,GMRVSTR("LT")
 S T1=GMTSEND,T2=GMTSBEG,END=0,TN=0,LF=0
 S GMRVSTR="T"_";"_"P"_";"_"R"_";"_"BP"_";"_"HT"_";"_"WT"_";"_"CVP"_";"_"PO2"_";"_"CG"_";"_"PN"
 S GMRVSTR(0)=T2_"^"_T1_"^"_CNTR_"^"_1
 ;D EN1^GMRVUT0 I '$D(^UTILITY($J,"GMRVD")) D KILLVS Q
 D EN1^GMVHS I '$D(^UTILITY($J,"GMRVD")) D KILLVS Q
 D FIRST,SECOND:GMTSVMVR>3,KILLVS Q
 ;                          
FIRST ; First Set of Vitals
 ;  1     2      3     4   5     6       7         8
 ; Date^Temp()^Pulse^Respt^BP^Height()^Weight()^Control
 N GMW,GMTSCCNT,GMTSCTL S CNTR("HOLDER")=CNTR S GMTSVMVR=$$VERSION^XPDUTL("GMRV")
 I GMTSVMVR'>3 D  Q:$D(GMTSQIT)
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W "Measurement DT",?20,"TEMP",?29,"PULSE",?36,"RESP",?45,"BP",?55,"HT",?68,"WT",!
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W ?20,"F(C)",?55,"IN(CM)",?68,"LB(KG)",!
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W ?20,"----",?29,"-----",?36,"----",?45,"--",?55,"------",?68,"------",!!
 I GMTSVMVR>3 D  Q:$D(GMTSQIT)
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W "Measurement DT",?18,"TEMP",?30,"PULSE",?36,"RESP",?41,"BP",?53,"HT",?63,"WT",!
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W ?18,"F(C)",?53,"IN(CM)",?63,"LB(KG)[BMI]",!
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W ?18,"----",?30,"-----",?36,"----",?41,"--",?53,"------",?63,"-----------",!!
 S GMTSCCNT=0,GMT="" F  S GMT=$O(^UTILITY($J,"GMRVD",GMT)) Q:GMT<0!(GMT="")!(END=1)  D FLOOP,FWRT
 W:GMTSCCNT=0 "No data",!
 Q
FLOOP ;   Loop through first set of vitals by date
 S (GMTSCTL,GMTSVT)=""
 F  S GMTSVT=$O(^UTILITY($J,"GMRVD",GMT,GMTSVT)) Q:GMTSVT=""  S IEN=$O(^UTILITY($J,"GMRVD",GMT,GMTSVT,0)) D FFMT
 Q
FFMT ;   Extract and format first set of vitals
 S GMTSVS=^UTILITY($J,"GMRVD",GMT,GMTSVT,IEN),X=$P(GMTSVS,U,1) D REGDT4^GMTSU S TDT=X
 S X=$P(GMTSVS,U,1) D MTIM^GMTSU S TI=X S TDT=TDT_" "_TI,$P(ARRAY,U,1)=TDT
 S GMTAB=$S(GMTSVT="T":2,GMTSVT="P":3,GMTSVT="R":4,GMTSVT="BP":5,GMTSVT="HT":6,GMTSVT="WT":7,1:0)
 I GMTAB="2" S $P(ARRAY,U,GMTAB)=$$FN($P(GMTSVS,U,8),1)_"("_$$FN($P(GMTSVS,U,13),1)_")"
 I GMTAB="6" S $P(ARRAY,U,GMTAB)=$$FN($P(GMTSVS,U,8),1)_"("_$$FN($P(GMTSVS,U,13),0)_")"
 I GMTAB="7" S $P(ARRAY,U,GMTAB)=$$FN($P(GMTSVS,U,8),0)_"("_$$FN($P(GMTSVS,U,13),1)_")"
 I "^2^7^"[GMTAB,$P(GMTSVS,U,8)?1A.E S $P(ARRAY,U,GMTAB)=$P(GMTSVS,U,8)
 I GMTAB=6,$P(GMTSVS,U,8)?1A.E S $P(ARRAY,U,GMTAB)=$E($P(GMTSVS,U,8),1,9)
 I "^2^6^7^"'[GMTAB S $P(ARRAY,U,GMTAB)=$P(GMTSVS,U,8)
 I GMTAB=3,$P(ARRAY,U,GMTAB)?1A.E S $P(ARRAY,U,GMTAB)=$E($P(ARRAY,U,GMTAB),1,5)
 I GMTAB=4,$P(ARRAY,U,GMTAB)?1A.E S $P(ARRAY,U,GMTAB)=$E($P(ARRAY,U,GMTAB),1,4)
 ;I "^3^4^5^"[GMTAB,$P(ARRAY,U,GMTAB)?1A.E S $P(ARRAY,U,GMTAB)=$E($P(ARRAY,U,GMTAB),1,7)
 I GMTAB=7,$P(GMTSVS,U,14)]"" S $P(ARRAY,U,GMTAB)=$P(ARRAY,U,GMTAB)_"["_$P(GMTSVS,U,14)_"]"
 S:GMTAB>1 GMTSCTL=GMTSCTL_$P(ARRAY,U,GMTAB),$P(ARRAY,U,8)=GMTSCTL
 Q
FWRT ;   Write first set of vitals by date
 Q:$P($G(ARRAY),U,8)=""  S GMTSCCNT=$G(GMTSCCNT)+1
 D CKP^GMTSUP Q:$D(GMTSQIT)
 I GMTSVMVR'>3 W $P(ARRAY,U,1),?18,$P(ARRAY,U,2),?30,$P(ARRAY,U,3),?37,$P(ARRAY,U,4),?42,$P(ARRAY,U,5),?54,$P(ARRAY,U,6),?67,$P(ARRAY,U,7),!
 I GMTSVMVR>3 W $P(ARRAY,U,1),?18,$P(ARRAY,U,2),?30,$P(ARRAY,U,3),?36,$P(ARRAY,U,4),?41,$P(ARRAY,U,5),?53,$P(ARRAY,U,6),?63,$P(ARRAY,U,7),!
 S CNTR=CNTR-1 I CNTR=0 S END=1
 K ARRAY
 Q
 ;                          
SECOND ; Second Set of Vitals
 ;  1    2   3     4     5      6
 ; Date^CVP^POx^Cir/Gir^Pain^Control
 N GMW,GMTSCCNT,GMTSCTL S (GMTSCCNT,END)=0,CNTR=CNTR("HOLDER")
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W !,"Measurement DT",?18,"CVP",?32,"POx",?45,"CG"
 W !,?18,"CMH20(MMHG)",?32,"(L/MIN)(%)",?45,"IN(CM)",?73,"Pain",!,?18,"-----------",?32,"----------",?45,"------",?73,"----",!!
 S GMT="" F  S GMT=$O(^UTILITY($J,"GMRVD",GMT)) Q:GMT<0!(GMT="")!(END=1)  D SLOOP,SWRT
 W:GMTSCCNT=0 "No data",!
 Q
SLOOP ;   Loop through second set of vitals by date
 S (GMTSCTL,GMTSVT)="" F  S GMTSVT=$O(^UTILITY($J,"GMRVD",GMT,GMTSVT)) Q:GMTSVT=""  S IEN=$O(^UTILITY($J,"GMRVD",GMT,GMTSVT,0)) D SFMT
 Q
SFMT ;   Extract and format second set of vitals
 S GMTSVS=^UTILITY($J,"GMRVD",GMT,GMTSVT,IEN)
 S X=$P(GMTSVS,U,1) D REGDT4^GMTSU S TDT=X S X=$P(GMTSVS,U,1) D MTIM^GMTSU S TI=X S TDT=TDT_" "_TI,$P(ARRAY,U,1)=TDT
 S GMTAB=$S(GMTSVT="CVP":2,GMTSVT="PO2":3,GMTSVT="CG":4,GMTSVT="PN":5,1:0)
 S $P(ARRAY,U,GMTAB)=$P(GMTSVS,U,8)
 I GMTAB=2 S $P(ARRAY,U,GMTAB)=$P(ARRAY,U,GMTAB)_$S($P(ARRAY,U,GMTAB)?1A.E:"",1:"("_$P(GMTSVS,U,13)_")")
 I GMTAB=3 S $P(ARRAY,U,GMTAB)=$P(ARRAY,U,GMTAB)_$S($P(ARRAY,U,GMTAB)?1A.E:"",($P($G(GMTSVS),U,15)="")&($P($G(GMTSVS),U,16)=""):"",1:"("_$P(GMTSVS,U,15)_")("_$P(GMTSVS,U,16)_")")
 I GMTAB=4 S $P(ARRAY,U,GMTAB)=$P(ARRAY,U,GMTAB)_$S($P(ARRAY,U,GMTAB)?1A.E:"",1:"("_$$FN($P(GMTSVS,U,13),0)_")"_$S($P(GMTSVS,U,17)]"":"["_$P(GMTSVS,U,17)_"]",1:""))
 I GMTAB=5 S $P(ARRAY,U,GMTAB)=$S($L($P(ARRAY,U,GMTAB))&(+($P(ARRAY,U,GMTAB))=0):$P(ARRAY,U,GMTAB),$L($P(ARRAY,U,GMTAB))&(+($P(ARRAY,U,GMTAB))'=99):$$FN($P(ARRAY,U,GMTAB),0),$L($P(ARRAY,U,GMTAB))&(+($P(ARRAY,U,GMTAB))=99):"No Response",1:"")
 S:GMTAB>1 GMTSCTL=$G(GMTSCTL)_$P($G(ARRAY),U,GMTAB),$P(ARRAY,U,6)=GMTSCTL
 Q
SWRT ;   Write second set of vitals by date
 Q:$P($G(ARRAY),U,6)=""
 D CKP^GMTSUP Q:$D(GMTSQIT)
 I GMTSNPG=1 D
 . W !,"Measurement DT",?18,"CVP",?34,"POx",?46,"CG"
 . W !,?18,"CMH20(MMHG)",?32,"(L/MIN)(%)",?45,"IN(CM)",?73,"Pain",!,?18,"-----------",?32,"----------",?45,"------",?73,"----",!!
 S GMTSCCNT=$G(GMTSCCNT)+1
 W $P(ARRAY,U,1),?18,$P(ARRAY,U,2),?32,$P(ARRAY,U,3),?45,$P(ARRAY,U,4),?73,$S($P(ARRAY,U,5)?1A.E:$E($P(ARRAY,U,5),1,7),1:$P(ARRAY,U,5)),!
 S CNTR=CNTR-1 I CNTR=0 S END=1
 K ARRAY
 Q
 ;                          
KILLVS ; Kill Variables
 K CNTR,T1,T2,TDT,TI,END,TN,IEN,LF,GMTSVMVR,GMTSVS,GMTSVT,GMT,ARRAY,GMTAB,X
 K ^UTILITY($J,"GMRVD")
 Q
FN(X,Y) ; Format Number 
 N VAL S VAL=+($G(X)),Y=$G(Y) Q:+Y'=Y X
 S X=$FN(VAL,"",Y) Q X
