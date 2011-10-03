ORLP00 ; slc/dcm,cla - Modify Patient Lists ;8/13/91  15:06
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
DEL ;Delete items from patient list
 I '$D(^XUTL("OR",$J,"ORLP")) W !,"You must build a Patient List before using this option" Q
L1 S:'$D(OROPREF) OROPREF=$$GET^XPAR("USR.`"_DUZ,"ORLP DEFAULT LIST ORDER",1,"I") S ORUS="^XUTL(""OR"",$J,""ORLP"",",ORUS(0)="40MN",ORUS("T")="W @IOF,?37,""PATIENT LIST"",! ;F I=1:1:IOM-1 W ""-"""
 S ORUS("W")="S X=$S(OROPREF=""R"":$P(^XUTL(""OR"",$J,""ORLP"",ORDA,0),""^"",5),1:"""")_"" ""_$P(^XUTL(""OR"",$J,""ORLP"",ORDA,0),""^"")_"" (""_$E($P(^(0),""^"",2),6,9)_"")""",ORUS("A")="Select Patient(s) to Remove: "
 S ORUS("F")="^XUTL(""OR"",$J,""ORLP"","""_$S($L($P(^XUTL("OR",$J,"ORLP",0),"^",3)):$P(^(0),"^",3),1:"B")_""","
 S ORUS("H")="W !,""Enter a name, number or range separated by commas or a dash"""
 D EN^ORUS
 I ($D(Y)<10) D END Q
 S I=0 W !
 F  S I=$O(Y(I)) Q:I<1  I $D(^XUTL("OR",$J,"ORLP",+Y(I),0)) S X=^(0) D
 . K ^XUTL("OR",$J,"ORLP",+Y(I)),^XUTL("OR",$J,"ORLP","B",$P(X,"^"),+Y(I)),^XUTL("OR",$J,"ORLP","C",$P(X,"^",2),+Y(I)) W !,"..."_$P(Y(I),"^",2)_" removed"
 K ^XUTL("OR",$J,"ORV"),^("ORU"),^("ORW") S (C,I)=0 F  S I=$O(^XUTL("OR",$J,"ORLP",I)) Q:I<1  S C=C+1
 S $P(^XUTL("OR",$J,"ORLP",0),"^",4)=C
 D STOR^ORLP1
 S %=1 W !!,"Show modified working list" D YN^DICN Q:%=-1  I %=1 G L1
 D END
 Q
END K ORUS,OROPREF,Y
 Q
 ;
ASKPT(TEAM) ;from ^ORLPL or internally - ask for patients
 N Y,ORDIR
 F  D  Q:$D(DTOUT)!($D(DUOUT))!(ORDIR']"")
 . K DIR S DIR(0)="SO^N:NAME;W:WARD;C:CLINIC;P:PROVIDER;T:TREATING SPECIALTY"
 . S DIR("A")="    to enter additional patients. (? for help)"
 . S DIR("?",3)="a PROVIDER, or patients in a TREATING SPECIALTY."
 . S DIR("?",1)="You may add patients to this list individually by patient NAME, or as a"
 . S DIR("?",2)="group such as an entire WARD, patients in a CLINIC, all patients seeing"
 . S DIR("?",4)=""
 . S DIR("?",5)="                               ** CAUTION **"
 . S DIR("?")="The patients added here will create a static list that will not change through MAS movements."
 . D ^DIR S ORDIR=Y K DIR Q:Y=""!(Y["^")
 . I Y="N" D ADD^ORLP0 K ^XUTL("OR",$J,"ORLP"),^("ORV"),^("ORU"),^("ORW") S ORCNT=0 Q
 . I Y="W" D WARD^ORLP01 K ^XUTL("OR",$J,"ORLP"),^("ORV"),^("ORU"),^("ORW") S ORCNT=0 Q
 . I Y="C" D CLIN^ORLP01 K ^XUTL("OR",$J,"ORLP"),^("ORV"),^("ORU"),^("ORW") S ORCNT=0 Q
 . I Y="P" D PROV^ORLP01 K ^XUTL("OR",$J,"ORLP"),^("ORV"),^("ORU"),^("ORW") S ORCNT=0 Q
 . I Y="T" D SPEC^ORLP01 K ^XUTL("OR",$J,"ORLP"),^("ORV"),^("ORU"),^("ORW") S ORCNT=0 Q
 Q
