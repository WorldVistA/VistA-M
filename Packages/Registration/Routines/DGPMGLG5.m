DGPMGLG5 ;ALB/LM - G&L GENERATION, CONT.; 27 APR 2003
 ;;5.3;Registration;**34,137,515,570**;Aug 13, 1993
 ;
A ;
 S NLS=0 ; non-loss indicator
 I MV("TT")=2!(MV("TT")=3) D NLS ; MV("TT")=2 (transfer) MV("TT")=3 (disch)
 I MV("TT")=1!(MV("TT")=3)!(MV("TT")=6) D ID ; MV("TT")=1 (adm)  MV("TT")=6 (TS transfer)
 ;
Q Q
 ;
NLS ;  Non-Loss
 S X=$P(MDP,"^",18) ;  type of movement
 I "^1^2^3^25^26^"[("^"_X_"^") S NLS=+X ;  NLS=1 (PASS), NLS=2 (AA), NLS=3 (UA), NLS=25 (FROM AA TO UA), NLS=26 (FROM UA TO AA)
 S:MV("MT")=42 NLS=42 ;  WHILE ASIH
 S:MV("MT")=47 NLS=47 ;  DISCHARGE FROM NHCU/DOM WHILE ASIH
 Q
 ;
ID ; ID info for patient and legend LEG(X) setup
 ; Q:MV("TT")'=1!(MV("TT")'=3)  ;  1=adm, 3=disch
 ;  Means Test
 ;I MT,$D(^DG(41.3,DFN,0)) S X=9999999.999998-TO S X=+$O(^DG(41.3,DFN,2,X)) I $D(^(X,0)) S X=$P(^(0),"^",2) I "^A^B^C^R^"[("^"_X_"^") S X=$C($A(X)+32),ID=ID_X,LEG(X)="" K X
 I MT,$D(^DGMT(408.31,"C",DFN)) N DGX,X D
 . S DGX=$$MTIENLT^DGMTU3(1,DFN,-TO)
 . I $D(^DGMT(408.31,+DGX,0)) D
 . . S X=$P(^(0),"^",3),X=$P(^DG(408.32,+X,0),"^",2)
 . . I $G(X)="P" D  ;evaluate pending adjudication to MT (C) or GMT (G)
 . . . I '$D(DGX) S X="U" Q
 . . . S X=$$PA^DGMTUTL(DGX),X=$S('$D(X):"U",X="MT":"C",X="GMT":"G",1:"U")
 . . I "^A^B^C^G^R^"[("^"_X_"^") S X=$C($A(X)+32),ID=ID_X,LEG(X)="" K X,DGX
INS ;  Reimburse Insurance (+)
 S INS=0
 N DGINS,DGX
 ; API returns ONLY Active and Re-imbursable Insurance entries
 I $$INSUR^IBBAPI(DFN,"","",.DGINS,9) D
 . S DGX=0 F  S DGX=$O(DGINS("IBBAPI","INSUR",DGX)) Q:'DGX  S INS=INS+1
 S:INS>0 ID=ID_"+",LEG("+")=""
 K INS,INS1,JJ
 Q:MV("TT")'=3
 ;  While ASIH (*), Discharge after less than 48 hours (#)
 I $D(^DGPM(+MV("CA"),0)) S X=^(0) S:$P(X,"^",15) ID=ID_"*",LEG("*")="" S X1=+X,X2=2 D C^%DTC I +MD'>X S ID=ID_"#",LEG("#")="" K X,X1,X2
 ;  Absence (!)
 I MDP]"",$P(MDP,"^",2)=2 S X=$P(MDP,"^",18) I "^1^2^3^25^26^"[("^"_X_"^") S ID=ID_"!",LEG("!")="" K X
 Q
