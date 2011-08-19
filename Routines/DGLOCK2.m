DGLOCK2 ;ALB/MRL - PATIENT FILE DATA EDIT CHECKS ; 28 Jan 2002  2:37 PM
 ;;5.3;Registration;**18,244,624**;Aug 13, 1993
K1 ;NOK Add
 I '$G(DFN) N DFN S DFN=$G(DA) Q:'DFN
 I $S('$D(^DPT(DFN,.21)):1,$P(^(.21),U,1)']"":1,1:0) W !?4,*7,"'NEXT OF KIN' name must be specified to enter/edit this field" K X
 Q
K1D ;NOK Delete
 I '$G(DFN) N DFN S DFN=$G(DA) Q:'DFN
 I $D(^DPT(DFN,.21)),$P(^(.21),U,1)]"" W !?4,*7,"Can't be deleted as long as 'NEXT OF KIN' is specified" K X
 Q
K2 ;NOK2 Add
 I '$G(DFN) N DFN S DFN=$G(DA) Q:'DFN
 D K1 I $D(X),$S('$D(^DPT(DFN,.211)):1,$P(^(.211),U,1)']"":1,1:0) W !?4,*7,"'NEXT OF KIN-2' name must be specified to enter/edit this field" K X
 Q
K2D ;NOK2 Delete
 I '$G(DFN) N DFN S DFN=$G(DA) Q:'DFN
 I $D(^DPT(DFN,.211)),$P(^(.211),U,1)]"" W !?4,*7,"Can't be deleted as long as 'NEXT OF KIN-2' is specified" K X
 Q
E1 ;Emer Add
 I '$G(DFN) N DFN S DFN=$G(DA) Q:'DFN
 I $S('$D(^DPT(DFN,.33)):1,$P(^(.33),U,1)']"":1,1:0) W !?4,*7,"'EMERGENCY CONTACT' name must be specified to enter/edit this field" K X
 Q
E1D ;Emer Delete
 I '$G(DFN) N DFN S DFN=$G(DA) Q:'DFN
 I $D(^DPT(DFN,.33)),$P(^(.33),U,1)]"" W !?4,*7,"Can't be deleted as long as 'EMERGENCY CONTACT' is specified" K X
 Q
E2 ;Emer2 Add
 I '$G(DFN) N DFN S DFN=$G(DA) Q:'DFN
 D E1 I $D(X),$S('$D(^DPT(DFN,.331)):1,$P(^(.331),U,1)']"":1,1:0) W !?4,*7,"'EMERGENCY CONTACT-2' name must be specified to enter/edit this field" K X
 Q
E2D ;Emer2 Delete
 I '$G(DFN) N DFN S DFN=$G(DA) Q:'DFN
 I $D(^DPT(DFN,.331)),$P(^(.331),U,1)]"" W !?4,*7,"Can't be deleted as long as 'EMERGENCY CONTACT-2' is specified" K X
 Q
D ;Desig Add
 I '$G(DFN) N DFN S DFN=$G(DA) Q:'DFN
 I $S('$D(^DPT(DFN,.34)):1,$P(^(.34),U,1)']"":1,1:0) W !?4,*7,"'DESIGNEE' name must be specified to enter/edit this field" K X
 Q
DD ;Desig Delete
 I '$G(DFN) N DFN S DFN=$G(DA) Q:'DFN
 I $D(^DPT(DFN,.34)),$P(^(.34),U,1)]"" W !?4,*7,"Can't be deleted as long as 'DESIGNEE' is specified" K X
 Q
SDD ;Spouse/Dependent Delete
 Q:'DA
 I $D(^DGPR(408.13,DA,0)),$P(^(0),U,1)]"" D EN^DDIOL("    Can't be deleted as long as Spouse/Dependent Income Person is specified.") K X
 Q
EM ;Emp Add
 I $S('$D(^DPT(DA,.311)):1,"^3^9^"[$P(^(.311),U,15):1,1:0) G EMW
 Q
EMW W !?4,*7,"'EMPLOYMENT STATUS' must be specified to enter/edit this field" K X Q
EM1 I '$G(DFN) N DFN S DFN=$G(DA) Q:'DFN
 I $S('$D(^DPT(DFN,.311)):1,"^3^9^"[$P(^(.311),U,15):1,1:0) G EMW
 I $P(^DPT(DFN,.311),U)']"" W !?4,*7,"'EMPLOYER NAME' must be specified to enter/edit this field" K X
 Q
EMD ;Emp Delete
 I '$G(DFN) N DFN S DFN=$G(DA) Q:'DFN
 I $D(^DPT(DFN,.311)),$P(^(.311),U,1)]"" W !?4,*7,"Can't be deleted as long as 'EMPLOYER NAME' is specified" K X
 Q
SE ;Sp Emp Add
 I '$G(DFN) N DFN S DFN=$G(DA) Q:'DFN
 D MAR I $D(X),$S('$D(^DPT(DFN,.25)):1,$P(^(.25),U,1)']"":1,1:0) W !?4,*7,"'SPOUSES EMPLOYER' name must be specified to enter/edit this field" K X
 Q
SED ;Sp Emp Delete
 I '$G(DFN) N DFN S DFN=$G(DA) Q:'DFN
 I $D(^DPT(DFN,.25)),$P(^(.25),U,1)]"" W !?4,*7,"Can't be deleted as long as 'SPOUSES EMPLOYER' is specified" K X
 Q
MAR ;Married or Separated
 I '$G(DFN) N DFN S DFN=$G(DA) Q:'DFN
 I $S('$D(^DIC(11,+$P(^DPT(DFN,0),U,5),0)):1,$P(^(0),U,1)="MARRIED":0,$P(^(0),U,1)="SEPARATED":0,1:1) W !?4,*7,"NOT POSSIBLE...Applicant is not Married." K X Q
 Q
AAC1 ;Agency/Country Screen
 S DGAAC=$S($D(^DPT(DFN,.36)):$S($D(^DIC(8,+$P(^DPT(DFN,.36),U,1),0)):+$P(^(0),U,4),1:""),1:""),DGAAC(1)=$S('$D(^DPT(DFN,"VET")):"",^("VET")'="N":"",DGAAC=4:"A",DGAAC=5:"C",1:"")
 Q
AAC D AAC1 S DIC("S")="I $P(^(0),U,4)=DGAAC(1)" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X Q
 ;
DOL I $S(X']"":1,X'["*":1,1:0) S:X["$" X=+$P(X,"$",2) G DOL2
DOL1 I $L(X),"$*"[$E(X) S X=$E(X,2,999) G DOL1
 Q:'+X  S X=+X,X=X*12
DOL2 S:X["." X=+$P(X,".",1)_"."_$E($P(X,".",2)_"00",1,2) W "  ($",X,")" Q
TOTCHK(DFN) ;Returns 1 if Any of 4 'Received' YES/NO amounts =YES
 ;For A&A, HB, Pension, Disability
 S:'$D(DFN) DFN=DA
 Q ($P($G(^DPT(DFN,.362)),U,12,14)_$P($G(^DPT(DFN,.3)),U,11))["Y"
TOTCKMSG ;ERROR MESSAGE FOR ABOVE
 W !,?4,*7,"Must Receive A&A, HB, Pension, or Disability Benefits."
 Q
TOTCKDEL ;ERROR MESSAGE IF DELETE .36295
 S DFN=DA I $$TOTCHK(DFN) W !,?4,*7,"Delete by indicating receipt of A&A, HB, Pension, & Disability as 'NO'." K X
 Q
