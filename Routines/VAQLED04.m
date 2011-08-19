VAQLED04 ;ALB/JFP - CREATES COMPARE ARRAYS FOR LOAD EDIT;01APR93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
MAIN ;-- Main entry point
 N VAQIGNC,ROOT,SEGPTR
 D:$D(XRTL) T0^%ZOSV ; -- Capacity start
 W !!,"Please wait while MAS information is collected..."
 S VAQIGNC=1
 S SEGPTR=$O(^VAT(394.71,"C","PDX*MAS",""))
 I $D(^VAT(394.61,DFNTR,"SEG","B",SEGPTR)) D EXTR,EXIT QUIT
 S SEGPTR=$O(^VAT(394.71,"C","PDX*MIN",""))
 D EXTR,EXIT
 S:$D(XRT0) XRTN=$T(+0) D:$D(XRT0) T1^%ZOSV ; -- Capacity stop
 QUIT
 ;
EXTR ; -- loads extraction arrays
 S ROOT="^TMP(""VAQTR"",$J)"
 K @ROOT
 S X=$$SEGEXT^VAQUPD1(DFNTR,SEGPTR,ROOT)
 I X=-1 W !,"     Error extracting ",$P($G(^VAT(394.71,SEGPTR,0)),U,2)," segment"
 ;
 S ROOT="^TMP(""VAQPT"",$J)"
 K @ROOT
 S X=$$SEGXTRCT^VAQDBI(0,DFNPT,ROOT,SEGPTR)
 I X=-1 W !,"     Error extracting ",$P($G(^VAT(394.71,SEGPTR,0)),U,2)," MAS data patient file"
 QUIT
 ;
EXIT ; -- Cleans up variables
 K VAQIGNC,X,ROOT,SEGPTR
 QUIT
 ;
END ; -- End of code
 QUIT
