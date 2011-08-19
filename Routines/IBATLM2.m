IBATLM2 ;LL/ELZ - TRANSFER PRICING PT TRANSACTION DETAIL ; 15-SEP-1998
 ;;2.0;INTEGRATED BILLING;**115**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; -- main entry point for IBAT PT TRANS DET
 N IBVAL,IBIEN
 D LMOPT^IBATUTL,EN^VALM2($G(XQORNOD(0)))
 S (IBVAL,IBIEN)=0,IBVAL=$O(VALMY(IBVAL)) Q:'IBVAL
 S IBIEN=$O(@VALMAR@("INDEX",IBVAL,IBIEN))
 D EN^VALM("IBAT PT TRANS DET")
 Q
 ;
HDR ; -- header code
 S DFN(0)=^DPT(DFN,0)
 S VALMHDR(1)="Patient: "_$P(DFN(0),"^")_" ("_$P(DFN(0),"^",9)_")"
 S VALMHDR(1)=$$SETSTR^VALM1("Transaction Ref #: "_$P(^IBAT(351.61,IBIEN,0),"^"),VALMHDR(1),50,29)
 Q
 ;
INIT ; -- init variables and list array
 S VALMCNT=0
 D ^IBATLM2A
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 D LMOPT^IBATUTL
 K ^TMP("IBATEE",$J)
 Q
