WVGETAL1 ;HCIOFO/FT-Autoload Female Patients (cont.) ;2/18/00  13:17
 ;;1.0;WOMEN'S HEALTH;**7,10**;Sep 30, 1998
EC ; prompt for Eligibility codes
 W ! K DIR
 S DIR(0)="Y",DIR("A")="     Include patients by eligibility code, too"
 S DIR("?")="Answer YES to include non-veteran patients with a desired eligibility code"
 D ^DIR K DIR
 I $D(DIRUT) S WVPOP=1
 Q:$G(WVPOP)!(Y=0)
 K DIC N WVLOOP
 S WVLOOP=0,DIC="^DIC(8,",Y=0
 F  Q:Y<0  D
 .S WVLOOP=WVLOOP+1
 .S DIC(0)="AEMQZ"
 .S DIC("A")="     Select "_$S(WVLOOP>1:"Next ",1:"")_"Eligibility Code: "
 .D ^DIC
 .S:$D(DTOUT)!($D(DUOUT)) WVPOP=1
 .I $D(DTOUT)!($D(DUOUT))!(Y<0) Q
 .S WVEC(+Y)=""
 .Q
 K DIC
 Q
VECCHK(WVN) ; Veteran/Eligibility Code check
 N DFN,WVLOOP,VAEL,VAERR,X,Y
 ; get veteran status
 I $$GET1^DIQ(2,WVN,1901,"I")="Y" Q 1
 S DFN=WVN
 D ELIG^VADPT ;get elibility code
 S WVLOOP=+$P($G(VAEL(1)),U,1) ;VAEL(1)=internal^external
 I 'WVLOOP Q 0
 I $D(WVEC(WVLOOP)) Q 1
 Q 0
 ;
