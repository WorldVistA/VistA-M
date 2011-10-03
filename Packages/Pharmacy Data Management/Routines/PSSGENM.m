PSSGENM ;BIR/WRT-Input transform for .01 field in file 50 ; 09/02/97 8:36;
 ;;1.0;PHARMACY DATA MANAGEMENT;;9/30/97
EDIT K:$D(^PSDRUG("AQ",+$G(DA)))!(X["""")!($A(X)=45)!('$D(PSSZ))!(X[";") X I $D(X) K:$L(X)>40!($L(X)<1)!'(X'?1P.E)!(X'?.ANP) X
 Q
