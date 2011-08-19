VAQDIS01 ;ALB/JFP - DISPLAY MINIMAL DATA, DRIVER ;01MAR93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
EP ; -- Main entry point for the list processor
 ;
PT S VAQTYPE="PT" G EP1 ; -- Minimal data extracted from ^DPT(2,
TR S VAQTYPE="TR" G EP1 ; -- Minimal data extracted from ^VAT(394.62,
 ;
EP1 D EN^VALM("VAQ DISPLAY MINIMUM") ; -- Protocol = VAQ DIS1 (MENU)
 QUIT
 ;
INIT ; -- Builds array of minimal data for the patient entered (DFN)
 ;W !,"DFN = ",DFN
 K ^TMP("VAQD1",$J),^TMP("VAQDIS",$J)
 N ROOT,SEGPTR,X,MSG,VAQIGNC,XTRCT,OFFSET
 S (VAQADFL,ERRPOP,VALMCNT)=0
 ;
 S ROOT="^TMP(""VAQDIS"",$J)"
 S SEGPTR=$O(^VAT(394.71,"C","PDX*MIN",""))
 S VAQIGNC=1 ; -- turns of encryption
 I VAQTYPE="PT" D
 .D CHGCAP^VALM("LOCAL"," Local Patient Data")
 .S X=$$SEGXTRCT^VAQDBI(0,DFN,ROOT,SEGPTR)
 I VAQTYPE="TR" D
 .D CHGCAP^VALM("LOCAL"," Remote Patient Data")
 .S X=$$SEGEXT^VAQUPD1(DFN,SEGPTR,ROOT)
 I +X=-1 D  QUIT
 .S MSG="Extract not successful...Error: "_$P(X,U,2)
 .S X=$$SETSTR^VALM1(" ","",1,79) D TMP
 .S X=$$SETSTR^VALM1(MSG,"",1,80) D TMP
 .S ERRPOP=1
 ; -- extraction sucessful, call display load
 S XTRCT=ROOT
 S ROOT="^TMP(""VAQD1"",$J)"
 S (OFFSET,DSP)=0
 S X=$$DISPMIN^VAQDIS21(XTRCT,SEGPTR,ROOT,OFFSET,DSP)
 I +X=-1 D  QUIT
 .S MSG="Display load not successful...Error: "_$P(X,U,2)
 .S X=$$SETSTR^VALM1(" ","",1,79) D TMP
 .S X=$$SETSTR^VALM1(MSG,"",1,80) D TMP
 .S ERRPOP=1
 S VALMBCK="Q"
 QUIT
 ;
TMP ; -- Set the array used by list processor
 S VALMCNT=VALMCNT+1
 S ^TMP("VAQD1",$J,VALMCNT,0)=$E(X,1,79)
 QUIT
 ;
HD ; -- Make header line for list processor
 D HD1^VAQEXT02 QUIT
 ;
EXIT ; -- Note: The list processor cleans up its own variables.
 ;          All other variables cleaned up here.
 ;
 K ^TMP("VAQD1",$J),^TMP("VAQDIS",$J)
 K VAQTYPE,VAQIGNC
 K ROOT,SEGPTR,X,MSG,XTRCT,OFFSET,DSP,ERRPOP
 Q
 ;
END ; -- End of code
 QUIT
