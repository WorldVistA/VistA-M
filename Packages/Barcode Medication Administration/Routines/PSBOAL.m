PSBOAL ;BIRMINGHAM/EFC-BCMA UTILITIES ;08/09/17  10:19
 ;;3.0;BAR CODE MED ADMIN;**93**;Mar 2004;Build 111
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
 .W !,"   Nature of Reaction   : "_$S($P(PSBARRY,U,6)="ALLERGY":"Allergy",$P(PSBARRY,U,6)="PHARMACOLOGIC":"Adverse Reaction",$P(PSBARRY,U,6)="UNKNOWN":"Unknown",1:"")  ;93
 .W !,""
 .I $D(PSBARRY("S",1)) D SYMP
 .I $D(PSBARRY("V",1)) D CLAS
 .W !,"   Originator           : "_$P(PSBARRY,U,2)_$S($L($P(PSBARRY,U,3)):" ("_$P(PSBARRY,U,3)_")",1:"")  ;93
 .W !,"   Originated           : "_$P(PSBARRY,U,10) ;93
 .W !
 .W !,"   Verified             : "_$S($P(PSBARRY,U,4)="VERIFIED":"Yes",1:"No")
 .W !,"   Observed/Historical  : "_$S($P(PSBARRY,U,5)="OBSERVED":"Observed",$P(PSBARRY,U,5)="HISTORICAL":"Historical",1:"")
 .;W !
 .I $D(PSBARRY("O",1)) D OBS  ;93
 .I $D(PSBARRY("C",1)) D COM  ;93
 .W !
 .W !,"   ******************************************"
 Q
 ;
SYMP ;
 S K=0,N=0 F  S K=$O(PSBARRY("S",K)) Q:K'>0  D
 .I N=0 W !,"   Signs/symptoms       : "_PSBARRY("S",K)
 .E  W !,"                          "_PSBARRY("S",K)
 .S N=N+1
 W !
 K N,K
 Q
CLAS ;
 S K=0,N=0 F  S K=$O(PSBARRY("V",K)) Q:K'>0  D
 .I N=0 W !,"   Drug Classes         : "_$P(PSBARRY("V",K),U,2)
 .E  W !,"                          "_$P(PSBARRY("V",K),U,2) ;MOVED TO THE RIGHT
 .S N=N+1
 W !
 K N,K
 Q
OBS     ;Display originator name  ;added tag 93
 N N,K,Y
 S K=0,N=0 F  S K=$O(PSBARRY("O",K)) Q:K'>0  D
 .I N=0 D
 ..S Y=$P(PSBARRY("O",K),U) D DD^%DT
 ..W !,"   Date/Severity        : "_Y_" "_$P(PSBARRY("O",K),U,2)
 .E  D
 ..S Y=$P(PSBARRY("O",K),U) D DD^%DT
 ..W !,"                          "_Y_" "_$P(PSBARRY("O",K),U,2)
 .S N=N+1
 K N,K,Y
 Q
COM    ;display comments - tag added 93
 N N,K,L,Y
 S K=0,N=0,Y=0
 W !
 F  S K=$O(PSBARRY("C",K)) Q:K'>0  D
 .I N=0 W !,"   Comments             :"
 .S Y=$P(PSBARRY("C",K),U) D DD^%DT
 .W " "_Y_" by "_$P(PSBARRY("C",K),U,2)
 .I $D(PSBARRY("C",K,1,0)) S L=0 F  S L=$O(PSBARRY("C",K,L)) Q:L'>0  D
 .. W !,"                          ",PSBARRY("C",K,L,0)
 .S N=N+1
 K N,K,L,Y
 Q
