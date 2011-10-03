IBCNEPM ;DAOU/ESG - PAYER MAINTENANCE PAYER LIST SCREEN ;22-JAN-2003
 ;;2.0;INTEGRATED BILLING;**184**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="Payers with potential matches to active insurance companies."
 Q
 ;
INIT ; -- init variables and list array
 ;
 ;Create scratch global of payer w/ potential matches missing
 KILL ^TMP("IBCNEPM",$J)
 NEW INS,DATA,PROFID,INSTID,IEN,APP,ACTIVE,PAYER
 ;
 ; First build a scratch global cross reference with all existing
 ; professional and institutional EDI ID numbers in file 36.
 S INS=0
 F  S INS=$O(^DIC(36,INS)) Q:'INS  D
 . I '$$ACTIVE^IBCNEUT4(INS) Q          ; inactive ins co
 . S DATA=$G(^DIC(36,INS,3))
 . I $P(DATA,U,10)'="" Q                ; already linked to a payer
 . S PROFID=$P(DATA,U,2),INSTID=$P(DATA,U,4)
 . I PROFID'="" S ^TMP("IBCNEPM",$J,"P",PROFID,INS)=""
 . I INSTID'="" S ^TMP("IBCNEPM",$J,"I",INSTID,INS)=""
 . Q
 ;
 ; Next loop through all payers.  Count up the number of insurance 
 ; companies that have matching EDI ID numbers but no payer links.  
 ; These are possible payer-insurance company links that have not yet 
 ; been made.
 ;
 S IEN=0
 F  S IEN=$O(^IBE(365.12,IEN)) Q:'IEN  D
 . S DATA=$G(^IBE(365.12,IEN,0))
 . ;
 . I '$$ACTAPP^IBCNEUT5(IEN) Q  ; no active payer applications
 . ;
 . ; must have at least 1 nationally active payer application
 . S APP=0,ACTIVE=0
 . F  S APP=$O(^IBE(365.12,IEN,1,APP)) Q:'APP!(ACTIVE)  D
 .. I $P($G(^IBE(365.12,IEN,1,APP,0)),U,2)=1 S ACTIVE=1
 . Q:'ACTIVE    ; no nationally active payer application found
 . ;
 . S PAYER=$P(DATA,U),PROFID=$P(DATA,U,5),INSTID=$P(DATA,U,6)
 . ;
 . ; Look at the payer's professional ID and see how many unique
 . ; insurance companies also have this professional ID
 . I PROFID'="",$D(^TMP("IBCNEPM",$J,"P",PROFID)) D
 .. S INS="" F  S INS=$O(^TMP("IBCNEPM",$J,"P",PROFID,INS)) Q:'INS  D
 ... S ^TMP("IBCNEPM",$J,"INS",INS,IEN)=PAYER
 ... I $D(^TMP("IBCNEPM",$J,"PYR",PAYER,IEN,INS)) Q
 ... S ^TMP("IBCNEPM",$J,"PYR",PAYER,IEN,INS)=""
 ... S ^TMP("IBCNEPM",$J,"PYR",PAYER,IEN)=$G(^TMP("IBCNEPM",$J,"PYR",PAYER,IEN))+1  ; increment tot
 . ;
 . ; Look at the payer's institutional ID and see how many unique
 . ; insurance companies also have this institutional ID
 . I INSTID'="",$D(^TMP("IBCNEPM",$J,"I",INSTID)) D
 .. S INS="" F  S INS=$O(^TMP("IBCNEPM",$J,"I",INSTID,INS)) Q:'INS  D
 ... S ^TMP("IBCNEPM",$J,"INS",INS,IEN)=PAYER
 ... I $D(^TMP("IBCNEPM",$J,"PYR",PAYER,IEN,INS)) Q
 ... S ^TMP("IBCNEPM",$J,"PYR",PAYER,IEN,INS)=""
 ... S ^TMP("IBCNEPM",$J,"PYR",PAYER,IEN)=$G(^TMP("IBCNEPM",$J,"PYR",PAYER,IEN))+1  ; increment tot
 ;
 D BUILD
 ;
INITX ;
 Q
 ;
BUILD ; This procedure builds the ListMan display global based on the 
 ; "PYR" area of the scratch global.  
 ;
 NEW LINE,PAYER,IEN,STRING,LINKS
 KILL ^TMP("IBCNEPM",$J,1)
 S LINE=0,(PAYER,IEN)=""
 F  S PAYER=$O(^TMP("IBCNEPM",$J,"PYR",PAYER)) Q:PAYER=""  D
 . F  S IEN=$O(^TMP("IBCNEPM",$J,"PYR",PAYER,IEN)) Q:IEN=""  D
 .. S STRING="",LINE=LINE+1
 .. S ^TMP("IBCNEPM",$J,"IDX",LINE,IEN)=PAYER
 .. S LINKS=^TMP("IBCNEPM",$J,"PYR",PAYER,IEN)
 .. S STRING=$$SETFLD^VALM1(LINE,STRING,"LINE")
 .. S STRING=$$SETFLD^VALM1(PAYER,STRING,"PAYER")
 .. S STRING=$$SETFLD^VALM1(LINKS,STRING,"LINKS")
 .. D SET^VALM10(LINE,STRING)
 ;
 S VALMCNT=LINE
 I VALMCNT=0 S VALMSG=" No Active Payers with potential missing links."
BUILDX ;
 Q
 ;
 ;
HELP ; -- help code
 N X S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 Q
 ;
EXPND ; -- expand code
 Q
 ;
