PSSGMI ;BIR/CML3-MISCELLANEOUS INFORMATION ; 08/30/96 10:17
 ;;1.0;PHARMACY DATA MANAGEMENT;;9/30/97
 ;
ENPDN(X) ; orderable item name
 ; X - pointer to Orderable Item (50.7) file
 N Y I $G(X)="" Q "NOT FOUND"
 I X S Y=$P($G(^PS(50.7,X,0)),"^") S:Y="" Y=X_";PS(50.7," Q Y
 Q X
 ;
ENDDN(X) ; dispense drug name
 ; X - pointer to Drug (50) file
 N Y I $G(X)="" Q "NOT FOUND"
 I X S Y=$P($G(^PSDRUG(X,0)),"^") S:Y="" Y=X_";PSDRUG(" Q Y
 Q X
 ;
ENMRN(X) ; med route name
 ; X - pointer to Medication Route (51.2) file
 N Y I $G(X)="" Q "NOT FOUND"
 I X S Y=$G(^PS(51.2,X,0)),Y=$S($P(Y,"^",3)]"":$P(Y,"^",3),1:$P(Y,"^")) S:Y="" Y=X_";PS(51.2," Q Y
 Q X
 ;
ENMRA(X) ; Med Route Abbrev.
 Q $P($G(^PS(51.2,X,0)),U,3)
 ;
ENNPN(X) ; new person name
 ; X - pointer to New Person (200) file
 N Y I $G(X)="" Q "NOT FOUND"
 I X S Y=$P($G(^VA(200,X,0)),"^") S:Y="" Y=X_";VA(200," Q Y
 Q X
 ;
ENSTN(X) ; schedule type name
 ; X - Schedule Type code
 S X=$S($G(X)="":"NOT FOUND",X="C":"CONTINUOUS",X="O":"ONE TIME",X="OC":"ON CALL",X="P":"PRN",X="R":"FILL on REQUEST",1:X)
 Q X
 ;
ENDTC(Y) ; FM internal date/time to user readable, Inpatient style
 ; Y - date in FileMan internal format
 I $G(Y) S Y=Y_$E(".",Y'[".")_"0000" Q $E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)_"  "_$E(Y,9,10)_":"_$E(Y,11,12)
 Q "********"
 ;
ENDTC1(Y) ; FM internal date/time to user readable, only 1 space before time.
 ; Y - date in FileMan internal format
 I $G(Y) S Y=Y_$E(".",Y'[".")_"0000" Q $E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)_" "_$E(Y,9,10)_":"_$E(Y,11,12)
 Q "********"
ENDD(Y) ; FM internal date/time to user readable - stolen from ^DD("DD")
 ; Y - date in FileMan internal format
 S:$G(Y) Y=$S($E(Y,4,5):$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",+$E(Y,4,5))_" ",1:"")_$S($E(Y,6,7):+$E(Y,6,7)_",",1:"")_($E(Y,1,3)+1700)_$P("@"_$E(Y_0,9,10)_":"_$E(Y_"000",11,12)_$S($E(Y,13,14):":"_$E(Y_0,13,14),1:""),"^",Y[".")
 Q Y
 ;
ENPDS(Y,CODES) ; look-up screen for primary drugs
 ; CODES - set of codes separated by commas
 ; Y - pointer to the Primary Drug (50.3) file
 N ND,X,Z I 0
 S ND=$G(^PS(50.7,+Y,0))
 Q $S($P(ND,U,4)>DT:1,1:0)
 F Z=1:1:$L(CODES,",") S X=$P(CODES,",",Z) Q:X=""  I $D(^PS(50.3,Y,1,"AFI",X))'[0 S ND=$G(^(X)) I $S('$P(ND,"^",2):1,1:$P(ND,"^",2)>DT) Q
 Q $T
 ;
ENLU(X) ; convert lower case to upper case
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
ENUL(X) ; convert upper case to lower case
 Q $TR(X,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
