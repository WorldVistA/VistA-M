PSJDDUT3 ;BIR/LDT-INPATIENT MEDICATIONS DD UTILITY ;26 JUN 97 / 9:35 AM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
 ;(The following call replaces EN^PSIVHLP3)
EN(HELP) F PSIVHLP=1:1 Q:$P($T(@HELP+PSIVHLP),";",3)=""  S PSJHLP(PSIVHLP)=$P($T(@HELP+PSIVHLP),";",3) D WRITE
 K HELP,PSIVHLP Q
 ;
ENI ;(Replaces ENI^PSIVSP)
 K:$L(X)<1!($L(X)>30)!(X["""")!($A(X)=45) X I '$D(X)!'$D(P(4)) Q
 I P(4)="P"!(P(5))!(P(23)="P") Q:'X  S X="INFUSE OVER "_X_" MIN." D EN^DDIOL("   "_X,"","?0") Q
 I X'=+X,($P(X,"@",2,999)'=+$P(X,"@",2,999)!(+$P(X,"@",2,999)<0)) K X Q
 S SPSOL=$O(DRG("SOL",0)) I 'SPSOL K SPSOL,X D EN^DDIOL("  You must define at least one solution !!") Q
 I X=+X S X=X_" ml/hr" D EN^DDIOL(" ml/hr","","?0") D SPSOL S P(15)=$S('X:0,1:SPSOL\X*60+(SPSOL#X/X*60+.5)\1) K SPSOL Q
 S SPSOL=$P(X,"@",2) S:$P(X,"@")=+X $P(X,"@")=$P(X,"@")_" ml/hr" D EN^DDIOL("   "_+SPSOL_" Label"_$S(SPSOL'=1:"s",1:"")_" per day"),EN^DDIOL("at an infusion rate of: "_$P(X,"@"),"","!?15") S P(15)=$S('SPSOL:0,1:1440/SPSOL\1) K SPSOL
 Q
SPSOL S SPSOL=0 F XXX=0:0 S XXX=$O(DRG("SOL",XXX)) Q:'XXX  S SPSOL=SPSOL+$P(DRG("SOL",XXX),U,3)
 K XXX Q
 ;
 ;(The following call replaces 59^PSIVUTL)
59 ; Validate the Infusion rate entered using IV Quick order code.
 N I F I=2,3,5,7,8,9,11,15,23 S P(I)=""
 S P(4)="A",P(8)=$P($G(^PS(57.1,PSJQO,1)),U,5)
 I $G(^PS(57.1,PSJQO,4,1,0)) S DRG("SOL",1)=^(0),DRG("SOL",0)=1
 I X["?" S F1=53.1,F2=59 D ENHLP^PSIVORC1 G 59
 I X]"" D ENI S:$D(X) P(8)=X
 Q
 ;
STPDTHLP ;
 ;;A number of doses (dose limit) may be entered and the stop date will
 ;;be automatically calculated. To specify a dose limit enter a number
 ;;corresponding to the number of doses the to be administered.
 ;;(Example: 4 for 4 doses).
 ;
WRITE ;Calls EN^DDIOL to write text
 D EN^DDIOL(.PSJHLP) K PSJHLP Q
