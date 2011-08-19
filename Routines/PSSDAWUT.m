PSSDAWUT ;BIRM/MFR - ECME (BPS) Utilities ;10/15/04
 ;;1.0;PHARMACY DATA MANAGEMENT;**90**;9/30/97
 ;Reference to File #9002313.24 supported by DBIA 4715
 ;
DAWEXT(CODE) ; Returns description for DAW code (Dispense as Written)
 N DIC,X,Y
 S DIC=9002313.24,DIC(0)="Z",X=CODE D ^DIC
 Q $P($G(Y(0)),"^",2)
 ;
INPUT ; Input Transform for DAW CODE
 I $L(X)<1!($L(X)>2)!'$D(X) K X Q
 I X="?" X ^DD(50,81,4) Q
 S DIC(0)="QM",DIC="^BPS(9002313.24," D ^DIC
 S X=$P(Y,U,2) K:Y<0 X
 Q
 ;
HLP ; Executable help for DAW CODE field
 N DIC,D,DO
 S DIC="^BPS(9002313.24,",D="B",DIC(0)="" D DQ^DICQ
 Q
