PSBOAL ;BIRMINGHAM/EFC-BCMA UTILITIES ;Mar 2004
 ;;3.0;BAR CODE MED ADMIN;;Mar 2004
 ;
 ; Reference/IA
 ; ^GMRADPT/10099
 ; ^GMRAOR2/2422
EN ;
 N PSBLIST,PSBGBL,DFN
 S PSBGBL="^TMP(""PSBO"",$J,""B"")"
 F  S PSBGBL=$Q(@PSBGBL) Q:PSBGBL=""  Q:$QS(PSBGBL,2)'=$J  Q:$QS(PSBGBL,1)'["PSBO"  D
 .S DFN=$QS(PSBGBL,5)
 .D EN1
 K ^TMP("PSBO",$J)
 Q
 ;
EN1 ;
 S GMRA="0^0^111" S PSBLIST=""
 D EN1^GMRADPT
 F  S PSBLIST=$O(GMRAL(PSBLIST)) Q:'PSBLIST  D
 .K PSBARRY
 .D EN1^GMRAOR2(PSBLIST,"PSBARRY")
 .W !,""
 .W !,"   Causative agent      : "_$P(PSBARRY,U)
 .W !,""
 .I $D(PSBARRY("S",1)) D SYMP
 .I $D(PSBARRY("V",1)) D CLAS
 .W !,"   Verified             : "_$S($P(PSBARRY,U,4)="VERIFIED":"Yes",1:"No")
 .W !,"   Observed/Historical  : "_$S($P(PSBARRY,U,5)="OBSERVED":"Observed",$P(PSBARRY,U,5)="HISTORICAL":"Historical",1:"")
 .W !,"   ******************************************"
 Q
 ;
SYMP ;
 S K=0,N=0 F  S K=$O(PSBARRY("S",K)) Q:K'>0  D
 .I N=0 W !,"   Signs/symptoms       : "_PSBARRY("S",K)
 .E  W !,"              "_PSBARRY("S",K)
 .S N=N+1
 W !
 K N,K
 Q
CLAS ;
 S K=0,N=0 F  S K=$O(PSBARRY("V",K)) Q:K'>0  D
 .I N=0 W !,"   Drug Classes         : "_$P(PSBARRY("V",K),U,2)
 .E  W !,"     "_$P(PSBARRY("V",K),U,2)
 .S N=N+1
 W !
 K N,K
 Q
