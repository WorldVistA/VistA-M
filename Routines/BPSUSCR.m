BPSUSCR ;BHAM ISC/FLS - ECME STRANDED CLAIMS SCREEN MAIN ;03/07/08  10:44
 ;;1.0;E CLAIMS MGMT ENGINE;**1,7**;JUN 2004;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;STRANDED CLAIMS SCREEN
EN ; -- main entry point for BPS ECME USER SCREEN
 N BPTMPGL,DUOUT,DTOUT,BPQ
 S BPQ=$$MESSAGE^BPSUSCR1() I BPQ=1 Q
 D GETDTS^BPSUSCR1(.BPARR) Q:$D(DUOUT)!$D(DTOUT)
 D EN^VALM("BPS LSTMN ECME UNSTRAND")
 Q
 ;
HDR ; -- header code
 S BPBDT=$$FMTE^XLFDT($P(BPBDT,"."),"5Z")
 S BPEDT=$$FMTE^XLFDT($P(BPEDT,"."),"5Z")
 S VALMHDR(1)="Claims Stranded from "_BPBDT_" through "_BPEDT
 S VALMHDR(2)="Sorted by Transaction Date"
 Q
 ;
INIT ; -- init variables and list array
 W !,"Please wait..."
 D INIT^BPSUSCR1
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 K X
 Q
 ;
EXIT ; -- exit code
 K BPARR,BPEDT,BPBDT
 D CLEAN^VALM10
 Q
