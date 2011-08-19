IBATLM3 ;LL/ELZ - TRANSFER PRICING PATIENT INFO SCREEN ; 13-APR-1999
 ;;2.0;INTEGRATED BILLING;**115**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; -- main entry point for IBAT PATIENT DETAIL
 D EN^VALM("IBAT PATIENT DETAIL")
 Q
 ;
HDR ; -- header code
 N IBDFN0,IBAT0,VA
 ;
 S IBDFN0=^DPT(DFN,0),IBAT0=^IBAT(351.6,DFN,0)
 D PID^VADPT
 ;
 S VALMHDR(1)="Name: "_$P(IBDFN0,"^")
 D SET("SSN: "_VA("PID"),.VALMHDR,1,54,26,0)
 ;
 D SET("Current TP Status:",.VALMHDR,2,1,18,0)
 D SET($$EX^IBATUTL(351.6,.04,$P(IBAT0,"^",4)),.VALMHDR,2,20,40,1)
 D SET("Enrolled Facility:",.VALMHDR,2,40,18,0)
 D SET($P($$INST^IBATUTL($$PPF^IBATUTL(DFN)),"^"),.VALMHDR,2,59,20,1)
 Q
 ;
INIT ; -- init variables and list array
 S VALMCNT=0
 D ^IBATLM3A
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 Q
 ;
EXPND ; -- expand code
 Q
 ;
SET(TEXT,STRING,S,COL,LENGTH,L) ; -- set up string with valm1
 I '$D(STRING(S)) S STRING(S)=""
 I L S TEXT=$$LOWER^VALM1(TEXT)
 S STRING(S)=$$SETSTR^VALM1(TEXT,STRING(S),COL,LENGTH)
 Q
