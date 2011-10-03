MDRPCOL ; HOIFO/DP - Object RPCs (Logfile) ; [02-11-2002 13:41]
 ;;1.0;CLINICAL PROCEDURES;;Apr 01, 2004
RPC(RESULTS,OPTION,P1,P2,P3,P4) ; [Procedure] Main RPC Call
 ; Input parameters
 ;  1. RESULTS [Literal/Required] No description
 ;  2. OPTION [Literal/Required] No description
 ;
 ; RPC: [MD TMDLOGFILE]
 S RESULTS=$NA(^TMP($J)) K @RESULTS
 D:$T(@OPTION)]"" @OPTION
 D:'$D(@RESULTS) BADRPC^MDRPCU("MD TMDLOGFILE","MDRPCOL",OPTION)
 D CLEAN^DILF
 Q
 ;
GET40R ; Get next 40 Results from file 703.1
 N MDCNT,MDSTOP,MDSTRT
 S MDSTOP=+$G(P1),MDSTRT=+$G(P2,0)
 S X=MDSTRT,Y=0,MDCNT=0
 F  S X=$O(^MDD(703.1,"ADTP",X)) Q:'X!(X>MDSTOP)  D  Q:MDCNT>39
 .F Y=0:0 S Y=$O(^MDD(703.1,"ADTP",X,Y)) Q:'Y  D
 ..S MDCNT=MDCNT+1
 ..S @RESULTS@(MDCNT)="703.1;"_Y_"^"_$G(^MDD(703.1,Y,0))
 S @RESULTS@(0)=MDCNT_U_X
 Q
 ;
