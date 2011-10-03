IB20PT8 ;ALB/MJK/CPM - CONDITIONALLY EXPORT ROUTINES ; 14-FEB-94
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;
 ;
EXPORT ; Conditionally installs other package routines
 N DIE,DIF,X,XCN,XCNP,IBTO,IBFR,IBI,IBX
 W !!,">>> Loading routines of other packages, if appropriate..."
 F IBI=1:1 S IBX=$T(ROU+IBI) Q:$P(IBX,";",3)="$END"  D
 .S IBTO=$P(IBX,";",3),IBFR=$P(IBX,";",4) D LOAD(IBTO) D
 ..S X=$G(^UTILITY("IBLOAD",$J,2,0)) X $P(IBX,";",5)
 ..I $T D INSTALL(IBTO,IBFR)
 K ^UTILITY("IBLOAD",$J)
EXPORTQ Q
 ;
LOAD(IBTO) ; -- load current routine
 K ^UTILITY("IBLOAD",$J)
 S X=IBTO X ^%ZOSF("TEST")
 I $T S XCNP=0,DIF="^UTILITY(""IBLOAD"",$J," X ^%ZOSF("LOAD")
 Q
 ;
INSTALL(IBTO,IBFR) ; -- install routine
 K ^UTILITY("IBLOAD",$J)
 W !," >> Installing ",IBTO," routine from ",IBFR," routine...  "
 S X=IBFR,XCNP=0,DIF="^UTILITY(""IBLOAD"",$J," X ^%ZOSF("LOAD")
 S X=IBTO,XCN=3,DIE="^UTILITY(""IBLOAD"",$J," X ^%ZOSF("SAVE")
 K ^UTILITY("IBLOAD",$J)
 W IBTO," filed."
 Q
 ;
ROU ; -- routines to export
 ;;DGBLRV;IB20PT81;I $S(X="":1,1:X["5.3"),X'["*26",X'[",26"
 ;;DGPTF;IB20PT82;I $S(X="":1,1:X["5.3"),X'["*26",X'[",26"
 ;;DGPTTS;IB20PT83;I $S(X="":1,1:X["5.3"),X'["*26",X'[",26"
 ;;DGPTTS1;IB20PT84;I $S(X="":1,1:X["5.3"),X'["*26",X'[",26"
 ;;DGPTTS3;IB20PT85;I $S(X="":1,1:X["5.3"),X'["*26",X'[",26"
 ;;DGPTUTL;IB20PT86;I $S(X="":1,1:X["5.3"),X'["*26",X'[",26"
 ;;DGRPDB;IB20PT87;I $S(X="":1,1:X["5.3"),X'["*26",X'[",26"
 ;;DG3PR0;IB20PT88;I $S(X="":1,1:X["5.3"),X'["*26",X'[",26"
 ;;DG3PR1;IB20PT89;I $S(X="":1,1:X["5.3"),X'["*26",X'[",26"
 ;;DG3PR2;IB20PT8A;I $S(X="":1,1:X["5.3"),X'["*26",X'[",26"
 ;;DGPMVBUR;IB20PT8B;I $S(X="":1,1:X["5.3"),X'["*26",X'[",26"
 ;;FBUINS;IB20PT8C;I +$G(^DD(161.4,0,"VR"))=3,X'["*5",X'[",5"
 ;;$END
 ;
 ;    piece 3 --> routine to replace
 ;      "   4 --> post-init routine holding new verion
 ;      "   5 --> 'ok to replace' IF test
 ;                  - X will be defined to be the 2nd line of
 ;                    current version
 ;
