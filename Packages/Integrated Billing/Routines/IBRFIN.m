IBRFIN ;ALB/JWS - RFAI Message Detail Worklist; 21-OCT-2015
 ;;2.0;INTEGRATED BILLING;**547**;21-MAR-94;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;
EN ; -- main entry point for IBRFI COMMENTS
 N VALMCNT,VALMBG,VALMHDR
 S VALMCNT=0,VALMBG=1
 D EN^VALM("IBRFI COMMENTS")
 S VALMBCK="R"
 Q
 ;
HDR ; -- header code
 N IBCLAIM
 S IBCLAIM=$$GET1^DIQ(368,RFAIEN,111.01)
 S:IBCLAIM="" IBCLAIM=$$GET1^DIQ(368,RFAIEN,11.01)
 ;S VALMHDR(1)="RFAI Claim Comment History"
 S VALMHDR(1)=IBCLAIM
 Q
 ;
INIT ; -- init variables and list array
 N LN,CO1,CO0,IBDUZ,IBDATE,STR,CMT,CMT0,MAX,POS,LEN
 K @VALMAR
 S LN=1
 ; check if we have any comments to display
 ; loop through all available comments
 S CO1=0 F  S CO1=$O(^IBA(368,RFAIEN,201,CO1)) Q:CO1'=+CO1  D
 . S CO0=$G(^IBA(368,RFAIEN,201,CO1,0)) I CO0="" Q
 . S IBDUZ=$P(CO0,U,2),IBDATE=$P(CO0,U)
 . D SET^VALM10(LN,"") S LN=LN+1
 . S STR="",STR=$$SETFLD^VALM1("Entered by "_$$GET1^DIQ(200,IBDUZ,.01)_" on "_$$FMTE^XLFDT(IBDATE,"2ZM"),STR,"ENTERED")
 . D SET^VALM10(LN,STR),FLDCTRL^VALM10(LN) S LN=LN+1
 . S CMT=0 F  S CMT=$O(^IBA(368,RFAIEN,201,CO1,1,CMT)) Q:CMT'=+CMT  D
 .. S CMT0=$G(^IBA(368,RFAIEN,201,CO1,1,CMT,0)) I CMT0="" Q
 .. S MAX=$P(VALMDDF("MESSAGE"),U,3) ; max. number of characters in the "MESSAGE" field
 .. ; if comment line is too long, split it into chunks that fit in the "MESSAGE" field
 .. F  D  Q:CMT0=""
 ... S (POS,LEN)=$L(CMT0) I LEN>MAX S POS=MAX F  Q:POS=0  Q:$E(CMT0,POS)=" "  S POS=POS-1 ; try to make a split on a space char.
 ... S:'POS POS=MAX ; if we couldn't find a space, split at the max. number of chars
 ... ; populate list manager array with this substring and remove it from the comment line
 ... S STR="",STR=$$SETFLD^VALM1($E(CMT0,1,POS),STR,"MESSAGE") D SET^VALM10(LN,STR) S LN=LN+1,CMT0=$E(CMT0,POS+1,LEN)
 ... Q
 .. Q
 . Q
 S VALMCNT=LN-1
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K @VALMAR
 Q
 ;
EXPND ; -- expand code
 Q
 ;
