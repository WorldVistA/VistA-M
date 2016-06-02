HMPEQLM1 ;SLC/MJK,ASMR/RRB - HMP Freshness Report;02-JUL-2014
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN(HMPSRV) ; -- main entry point for HMPM EVT QUE FRESHNESS REPORT
 D EN^VALM("HMPM EVT QUE FRESHNESS REPORT")
 Q
 ;
HDR ; -- header code
 Q
 ;
INIT ; -- init variables and list array
 N IEN,SRVNM,HMPDATA,SEQ,X
 ;
 D KILL
 S VALMCNT=0
 ;
 ; -- show current server and then the rest
 I +$G(HMPSRV) D SRV^HMPEQ("HMPDATA",+HMPSRV),SRV(.HMPDATA)
 D SET("   ")
 ;
 ; -- loop & sort thru defined HMP servers
 K HMPDATA
 S HMPDATA=$NA(^TMP("HMP FRESHNESS RPT",$J))
 K @HMPDATA
 D SRVS^HMPEQ(HMPDATA)
 S SEQ=0
 F  S SEQ=$O(@HMPDATA@("servers",SEQ)) Q:'SEQ  d
 . M X=@HMPDATA@("servers",SEQ) D SRV(.X)
 ;
 I VALMCNT=0 D NOROWS^HMPEQ("No HMP server information to display")
 S VALMBG=1
 S VALMSG="* updates waiting"
 K @HMPDATA
 Q
 ;
SRV(SRV) ; -- process one server
 N X,SEQ
 S X=""
 S X=$$SETFLD^VALM1($G(SRV("name")),X,"SERVER")
 S X=$$SETFLD^VALM1($G(SRV("lastUpdate")),X,"LAST")
 S X=$$SETFLD^VALM1($S($G(SRV("repeated")):" x"_$G(SRV("repeated")),1:""),X,"REPEATED")
 S X=$$SETFLD^VALM1($G(SRV("queueEnd")),X,"END")
 I $G(SRV("lastUpdate")),$G(SRV("lastUpdate"))'=$G(SRV("queueEnd")) S X=$$SETFLD^VALM1("*",X,"BEHIND")
 D SET(X)
 D FLDCTRL^VALM10(VALMCNT,"SERVER",IOINHI,IOINORM)
 ;
 I '$D(SRV("extracts")) Q
 ; -- loop thru extracts for this server
 D SET($J("Extract Information:",25))
 S SEQ=0
 F  S SEQ=$O(SRV("extracts",SEQ)) Q:'SEQ  D
 . S X=$J($G(SRV("extracts",SEQ,"domain")),15)
 . S X=X_"     Task(s): "_$G(SRV("extracts",SEQ,"tasks"))
 . D SET(X)
 . I $G(SRV("extracts",SEQ,"waiting")) D SET($J("Waiting: ",29)_$G(SRV("extracts",SEQ,"waiting"))_" seconds") Q
 . D SET($J("Extracting: "_$G(SRV("extracts",SEQ,"lastCount")),40))
 Q
 ;
SET(X,BOLD) ; -- add line
 S VALMCNT=VALMCNT+1
 S @VALMAR@(VALMCNT,0)=X
 Q
 ;
KILL ; -- kill off build data
 K @VALMAR
 ; clean up video control data
 D KILL^VALM10()
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
