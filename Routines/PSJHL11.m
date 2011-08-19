PSJHL11  ;BIR/LDT-PROVIDER COMMENTS FOR MOB ORDER ; 17 Mar 98 / 11:05 AM
 ;;5.0; INPATIENT MEDICATIONS ;**58**;16 DEC 97
 ;
ENPC(PSJTYP,LEN) ; Copy Provider Comments -> Special Instructions/Other Print Info.
 Q:'$D(PROCOM) ""
 N PSGSI,X,Y
 S Y="",X=0 F  S X=$O(PROCOM(X)) Q:'X  S Y=Y_PROCOM(X)_" " Q:$L(Y)>LEN
 S:$G(PSJTYP)'="V" Y=$$ENSET(Y) S:$G(PSJTYP)="V" Y=$E(Y,1,$L(Y)-1)
 I $L(Y)'<LEN S PSGSI="REFERENCE PROVIDER COMMENTS IN CPRS FOR INSTRUCTIONS." Q PSGSI
 S PSGSI=Y Q PSGSI
ENSET(X) ; expands the SPECIAL INSTRUCTIONS field contained in X into Y
 N X1,X2,Y S Y=""
 F X1=1:1:$L(X," ") S X2=$P(X," ",X1) I X2]"" S Y=Y_$S($L(X2)>30:X2,'$D(^PS(51,+$O(^PS(51,"B",X2,0)),0)):X2,$P(^(0),"^",2)]""&$P(^(0),"^",4):$P(^(0),"^",2),1:X2)_" "
 S Y=$E(Y,1,$L(Y)-1) Q Y
