IBATLM1 ;LL/ELZ - TRANSFER PRICING PT TRANSACTION LIST MANAGER ; 10-SEP-1998
 ;;2.0;INTEGRATED BILLING;**115**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN(DFN) ; -- main entry point for IBAT PT TRANS LIST
 D EN^VALM("IBAT PT TRANS LIST")
 Q
 ;
HDR ; -- header code
 N IBNAM,INST S IBNAM=$$PT^IBEFUNC(DFN)
 S IBNAM=$E("Patient: "_$P(IBNAM,"^"),1,25)_" "_$E(IBNAM)_$P(IBNAM,"^",3)
 S VALMHDR(1)=$$SETSTR^VALM1($$FDATE^VALM1(IBBDT)_" THRU "_$$FDATE^VALM1(IBEDT),IBNAM,59,22)
 S INST=$$INST^IBATUTL($$PPF^IBATUTL(DFN))
 S VALMHDR(2)="Enrolled Facility: "_$P(INST,"^")_" ("_$P(INST,"^",2)_")"
 S VALMHDR(2)=$$SETSTR^VALM1("Current Status: "_$$LOWER^VALM1($$EX^IBATUTL(351.6,.04,$P(^IBAT(351.6,DFN,0),"^",4))),VALMHDR(2),57,24)
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("VALM DATA",$J),^TMP("VALMAR",$J)
 I $$SLDR^IBATUTL("Date range will be used to specify Event Dates of transactions shown.") S VALMQUIT="" G EXIT
 S VALMBCK="R"
 D ARRAY^IBATLM1A(VALMAR)
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K IBDTR,IBEDT,IBBDT
 Q
