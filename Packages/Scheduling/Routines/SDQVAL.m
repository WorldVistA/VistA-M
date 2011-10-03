SDQVAL ;ALB/MJK - Query Object Validation Methods ;8/12/96
 ;;5.3;Scheduling;**131**;Aug 13, 1993
 ;
QRY(SDQ,SDERR) ; -- validate query input
 ;
 ; -- do checks
 IF SDQ,$D(@SDQUERY@(SDQ)) Q 1
 ;
 ; -- build error msg
 N SDIN,SDOUT
 S SDIN("QUERY")=SDQ
 S SDOUT("QUERY")=SDQ
 D BLD(4096800.101,.SDIN,.SDOUT,$G(SDERR))
 Q 0
 ;
 ;
QRYINACT(SDQ,SDMSG,SDERR) ; -- is query inactive?
 ;
 ; -- do checks
 IF '$G(@SDQUERY@(SDQ,"ACTIVE")) Q 1
 ;
 ; -- build error msg indicating that query is active
 N SDIN,SDOUT
 S SDIN("QUERY")=SDQ
 S SDOUT("QUERY")=SDQ
 D BLD(4096800.106,.SDIN,.SDOUT,$G(SDERR))
 Q 0
 ;
 ;
QRYACT(SDQ,SDMSG,SDERR) ; -- is query active?
 ;
 ; -- do checks
 IF $G(@SDQUERY@(SDQ,"ACTIVE")) Q 1
 ;
 ; -- build error msg indicating that query is inactive
 N SDIN,SDOUT
 S SDIN("QUERY")=SDQ
 S SDOUT("QUERY")=SDQ
 D BLD(4096800.102,.SDIN,.SDOUT,$G(SDERR))
 Q 0
 ;
 ;
ACTION(SDACT,SDERR) ; -- validate action input
 ;
 ; -- do checks
 IF SDACT="SET"!(SDACT="GET") Q 1
 ;
 ; -- build error msg
 N SDIN,SDOUT
 S SDIN("ACTION")=SDACT
 S SDOUT("ACTION")=SDACT
 D BLD(4096800.108,.SDIN,.SDOUT,$G(SDERR))
 Q 0
 ;
 ;
FILTER(SDFIL,SDERR) ; -- validate filter input
 N X
 ;
 ; -- do checks
 ; S X=SDFIL D ^DIM IF $D(X) Q 1   ; -- bug in DIR/DIM combo
 Q 1
 ;
 ; -- build error msg
 N SDIN,SDOUT
 S SDIN("FILTER")=SDFIL
 S SDOUT("FILTER")=SDFIL
 D BLD(4096800.104,.SDIN,.SDOUT,$G(SDERR))
 Q 0
 ;
 ;
INDEX(SDQ,SDIDX,SDERR) ; -- validate index input
 ;
 ; -- do checks
 IF $O(^TMP("SDQUERY CLASS",$J,SDQ,"INDEX","B",SDIDX,0)) Q 1
 ;
 ; -- build error msg
 N SDIN,SDOUT
 S SDIN("INDEX")=SDIDX
 S SDOUT("INDEX")=SDIDX
 D BLD(4096800.105,.SDIN,.SDOUT,$G(SDERR))
 Q 0
 ;
 ;
STATUS(SDSTA,SDERR) ; -- validate active status
 ;
 ; -- do checks
 IF SDSTA="TRUE"!(SDSTA="FALSE") Q 1
 ;
 ; -- build error msg
 N SDIN,SDOUT
 S SDIN("STATUS")=SDSTA
 S SDOUT("STATUS")=SDSTA
 D BLD(4096800.103,.SDIN,.SDOUT,$G(SDERR))
 Q 0
 ;
 ;
PAT(DFN,SDERR) ; -- validate DFN input
 ;
 ; -- do checks
 IF DFN,$D(^DPT(DFN,0)) Q 1
 ;
 ; -- build error msg
 N SDIN,SDOUT
 S SDIN("ID")=DFN
 S SDOUT("ID")=DFN
 D BLD(4096800.002,.SDIN,.SDOUT,$G(SDERR))
 Q 0
 ;
 ;
RANGE(SDBEG,SDEND,SDERR) ; -- validate date range
 ;
 ; -- do checks
 ; **** ADD MORE CHECKS HERE! ****
 IF SDBEG,SDEND,SDBEG'>SDEND Q 1
 ;
 ; -- build error msg
 N SDIN,SDOUT
 S SDIN("BEGIN")=SDBEG
 S SDIN("END")=SDEND
 S SDOUT("BEGIN")=SDBEG
 S SDOUT("END")=SDEND
 D BLD(4096800.022,.SDIN,.SDOUT,$G(SDERR))
 Q 0
 ;
 ;
PROP(SDQ,SDERR) ; -- are properties set for execution
 N SDTYPE,SDOK,SDPROP
 S SDOK=1,SDPROP=""
 S SDTYPE=+$G(@SDQUERY@(SDQ,"INDEX TYPE"))
 ;
 ; -- do checks
 ; -- check if type is invalid
 IF SDTYPE=0!(SDTYPE>4) D
 . S SDOK=0
 . S SDPROP=SDPROP_"INDEX / "
 ;
 ; -- if type is regular or composite date range
 IF SDTYPE=1!(SDTYPE=4),$G(@SDQUERY@(SDQ,"MASTER VALUE"))="" D
 . S SDOK=0
 . S SDPROP=SDPROP_$G(@SDQUERY@(SDQ,"INDEX EXTERNAL"))_" / "
 ;
 ;
 ; -- if type is regular date range or composite date range
 IF SDTYPE=2!(SDTYPE=4) D
 . IF $G(@SDQUERY@(SDQ,"BEGIN DATE"))="" D  Q
 . . S SDOK=0
 . . S SDPROP=SDPROP_"BEGIN DATE / "
 . ;
 . IF $G(@SDQUERY@(SDQ,"END DATE"))="" D  Q
 . . S SDOK=0
 . . S SDPROP=SDPROP_"END DATE / "
 ;
 ;
 ; -- if type is composite (currently not supported [10/97])
 IF SDTYPE=3 D
 . S SDOK=0
 . S SDPROP=SDPROP_"NO SUPPORTED / "
 ;
 ;
 ; -- build error msg
 IF 'SDOK D
 . N SDIN,SDOUT
 . S SDIN("PROPERTIES")=SDPROP
 . S SDOUT("PROPERTIES")=SDPROP
 . D BLD(4096800.109,.SDIN,.SDOUT,$G(SDERR))
 ;
PROPQ Q SDOK
 ;
 ;
SCAN(SDQ,SDERR) ; -- is everything set up for SCAN to proceed?
 ;
 ; -- do checks
 ; -- is callback defined
 IF $G(@SDQUERY@(SDQ,"SCAN APP CALLBACK"))]"" Q 1
 ;
 ; -- build error msg
 D BLD(4096800.112,"","",$G(SDERR))
 Q 0
 ;
 ;
SCANCB(SDCB,SDERR) ; -- is scan callback valid M code?
 N X
 ;
 ; -- do checks
 ;S X=SDCB D ^DIM IF $D(X) Q 1   ; -- bug in DIR/DIM combo
 Q 1
 ;
 ; -- build error msg
 N SDIN,SDOUT
 S SDIN("CALLBACK")=SDCB
 S SDOUT("CALLBACK")=SDCB
 D BLD(4096800.113,.SDIN,.SDOUT,$G(SDERR))
 Q 0
 ;
 ;
BLD(SDMSG,SDIN,SDOUT,SDERR) ; -- build message
 D BLD^DIALOG(SDMSG,.SDIN,.SDOUT,$G(SDERR),"F")
 IF $G(SDEBUG) D
 . D MSG^DIALOG("WES","","",5,$G(SDERR))
 . N DIR
 . S DIR(0)="E",DIR("A")="Press RETURN to continue"
 . W ! D ^DIR
 Q
 ;
