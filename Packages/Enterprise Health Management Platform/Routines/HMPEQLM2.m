HMPEQLM2 ;SLC/MJK,ASMR/RRB - HMP Temporary Global Lister;01-JUL-2014
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN(HMPSRV) ; -- main entry point for HMPM EVT QUE GLOBALS
 D EN^VALM("HMPM EVT QUE GLOBALS")
 Q
 ;
HDR ; -- header code
 Q
 ;
INIT ; -- init variables and list array
 N SRVNM,HMPDATA,X,SEQ,TYPE
 K HMPDATA
 S HMPDATA=$NA(^TMP("HMP TEMP GLOBALS RPT",$J))
 K @HMPDATA
 D GLBS^HMPEQ(HMPDATA)
 ;
 D KILL
 S VALMCNT=0
 ;
 ; -- just get selected server info if defined
 S SRVNM=$S('$G(HMPSRV):"",1:$P($G(^HMP(800000,+$G(HMPSRV),0)),"^"))
 S SEQ=0 F  S SEQ=$O(@HMPDATA@("xtmpNodes",SEQ)) Q:'SEQ  D
 . M X=@HMPDATA@("xtmpNodes",SEQ) D:$G(X("server"))=SRVNM GLB(.X)
 ;
 S TYPE="" F  S TYPE=$O(@HMPDATA@(TYPE)) Q:TYPE=""  D
 . D SET("  ")
 . S SEQ=0 F  S SEQ=$O(@HMPDATA@(TYPE,SEQ)) Q:'SEQ  D
 . . M X=@HMPDATA@(TYPE,SEQ) D GLB(.X)
 ;
 I VALMCNT=0 D NOROWS^HMPEQ("No globals to display")
 S VALMBG=1
 K @HMPDATA
 Q
 ;
GLB(GLB) ; --
 S X=""
 S X=$$SETFLD^VALM1($$DOTS($G(GLB("rootNode"))),X,"SUBSCRIPT")
 S X=$$SETFLD^VALM1($G(GLB("lastNode")),X,"LAST")
 D SET(X)
 Q
 ;
SET(X) ; -- add line
 S VALMCNT=VALMCNT+1
 S @VALMAR@(VALMCNT,0)=X
 Q
 ;
DOTS(Z) ; -- use dots
 N DOTS
 S $P(DOTS,".   ",20)=""
 Q Z_$E(DOTS,$L(Z),65)
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
