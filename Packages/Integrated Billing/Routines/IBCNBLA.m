IBCNBLA ;ALB/ARH - Ins Buffer: LM action calls ;1 Jun 97
 ;;2.0;INTEGRATED BILLING;**82,149,153,184,271,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
NEWSCRN(TEMPLAT,TMPARR,IBBUFDA) ; open a new screen for a specific buffer entry, pass in LM template and the array to select from
 ; if temp array is defined then user selects the buffer entry, otherwise use entry passed in
 ;
 I $G(TMPARR)'="" N IBBUFDA S IBBUFDA=$$SEL(TMPARR)
 I +$G(IBBUFDA),$G(TEMPLAT)'="",+$$LOCK^IBCNBU1(IBBUFDA,1) D EN^VALM(TEMPLAT) D UNLOCK^IBCNBU1(IBBUFDA)
 S VALMBCK="R"
 Q
 ;
SEL(TMPARR) ; user selects one of the items from the list on the screen
 ;
 N VALMY,IBX,IBY,IBSELN S IBX=""
 I $G(TMPARR)'="",'$O(^TMP(TMPARR,$J,0)) D  G SELQ
 . W !!,"There are no '",$S($G(VALM("ENTITY"))'="":VALM("ENTITY"),1:"record"),"s' to select.",! S DIR(0)="E" D ^DIR K DIR
 ;
 D EN^VALM2($G(XQORNOD(0)),"OS")
 I $D(VALMY),$G(TMPARR)'="" S IBSELN=0 F  S IBSELN=$O(VALMY(IBSELN)) Q:'IBSELN  D
 . S IBX=$P($G(^TMP(TMPARR,$J,IBSELN)),U,2,99)
 . ;
 . I TMPARR="IBCNBLLX" S IBY=$P($G(^IBA(355.33,+IBX,0)),U,4) I IBY'="E" D  S IBX=""
 .. W !!," >>> Selected entry has been ",$S(IBY="A":"ACCEPTED",IBY="R":"REJECTED",1:"UNKNOWN STATUS")
 .. W " and may no longer be edited or modified.",! S DIR(0)="E" D ^DIR K DIR
 ;
SELQ Q IBX
 ;
PNXTSCRN(TEMPLAT,IBBUFDA) ; open a new screen for a buffer entry, rebuild the process screen on return since it may have changed
 D NEWSCRN^IBCNBLA(TEMPLAT,"",IBBUFDA)
 D CLEAN^VALM10,INIT^IBCNBLP,HDR^IBCNBLP S VALMBCK="R"
 Q
 ;
LNXTSCRN(TEMPLAT,TMPARR,AVIEW) ; select entries from list to process/expand
 ;
 ; This procedure is called from the ListMan action protocols for
 ; processing and expanding buffer entries.
 ;    TEMPLAT - list template name for associated action
 ;    TMPARR  - subscript in scratch global
 ;
 NEW IBCNEZAR,IBCNEZEN,IBCNEZCT,IBCNEZGD,IBCNEZBF,IBCNEZQ,IBBUFDA
 NEW ACT,REMAIN,DIR,X,Y,DIRUT,DTOUT,DUOUT,DIROUT
 D FULL^VALM1
 D MULSEL^IBCNBLA2(TMPARR,.IBCNEZAR,.IBCNEZGD)
 I '$D(IBCNEZAR) G LNXTX
 ;
 ; loop through the list of selected buffer entries
 S IBCNEZEN=0,IBCNEZCT=0
 F  S IBCNEZEN=$O(IBCNEZAR(IBCNEZEN)) Q:'IBCNEZEN  D
 . I 'IBCNEZAR(IBCNEZEN) Q      ; user could not get this one
 . S IBCNEZBF=$P(IBCNEZAR(IBCNEZEN),U,3)    ; buffer ien
 . S IBBUFDA=IBCNEZBF           ; just in case IB rtns need this
 . S IBCNEZCT=IBCNEZCT+1
 . I '$D(IBCNEZQ) D
 .. D EN^VALM(TEMPLAT)                      ; invoke list template
 .. I $G(IBFASTXT) S IBCNEZQ=1 Q            ; Fast Exit processing
 .. S ACT="expand"
 .. I TEMPLAT["PROCESS" S ACT="process"
 .. S REMAIN=IBCNEZGD-IBCNEZCT
 .. I 'REMAIN Q
 .. W @IOF
 .. W !!!,"You are ",ACT,"ing multiple insurance buffer entries."
 .. W !,"You just completed entry number ",IBCNEZEN,"  (",IBCNEZCT," of ",IBCNEZGD,")."
 .. S DIR(0)="Y"
 .. S DIR("A")="Do you want to "_ACT_" the remaining entry"
 .. I REMAIN>1 S DIR("A")="Do you want to "_ACT_" the remaining "_REMAIN_" entries"
 .. S DIR("B")="YES"
 .. W ! D ^DIR K DIR
 .. I 'Y S IBCNEZQ=1       ; User said NO so set the Quitting variable
 .. Q
 . ;
 . ; Make sure to unlock the buffer entry in all cases when finished,
 . ; even if the user wants to quit out of this loop
 . D UNLOCK^IBCNBU1(IBCNEZBF)
 . Q
LNXTX ;
 S VALMBCK="R"
 Q
 ;
LREJECT(TMPARR) ; user select entries from list then reject/delete them
 ;
 ; This procedure is called from the ListMan action protocol for
 ; rejecting buffer entries.
 ;    TMPARR  - subscript in scratch global
 ;
 NEW IBCNEZAR,IBCNEZEN,IBCNEZCT,IBCNEZGD,IBCNEZBF,IBCNEZQ,IBBUFDA
 D FULL^VALM1
 D MULSEL^IBCNBLA2(TMPARR,.IBCNEZAR,.IBCNEZGD)
 I '$D(IBCNEZAR) G LREJX
 ;
 ; loop through the list of selected buffer entries
 S IBCNEZEN=0,IBCNEZCT=0
 F  S IBCNEZEN=$O(IBCNEZAR(IBCNEZEN)) Q:'IBCNEZEN  D
 . I 'IBCNEZAR(IBCNEZEN) Q      ; user could not get this one
 . S IBCNEZBF=$P(IBCNEZAR(IBCNEZEN),U,3)
 . S IBBUFDA=IBCNEZBF           ; just in case IB rtns need this
 . S IBCNEZCT=IBCNEZCT+1
 . I '$D(IBCNEZQ) D
 .. W @IOF,!?2,$G(IORVON)
 .. W " Entry ",IBCNEZEN,"  (",IBCNEZCT," of ",IBCNEZGD,") "
 .. W $G(IORVOFF)
 .. D REJECT^IBCNBLA1(IBCNEZBF,.IBCNEZQ)
 .. ;
 .. ; If the user wants to stop and we're not processing the last one,
 .. ; then determine if we should process the remaining entries
 .. ;
 .. I $D(IBCNEZQ),IBCNEZCT<IBCNEZGD D
 ... NEW REMAIN,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 ... S REMAIN=IBCNEZGD-IBCNEZCT
 ... S DIR(0)="Y"
 ... S DIR("A")="Do you want to process the remaining entry"
 ... I REMAIN>1 S DIR("A")="Do you want to process the remaining "_REMAIN_" entries"
 ... S DIR("B")="NO"
 ... W ! D ^DIR K DIR
 ... ; if user wants to continue, then kill the quitting variable
 ... I Y KILL IBCNEZQ
 ... Q
 .. Q
 . ;
 . ; Make sure to unlock the buffer entry in all cases when finished,
 . ; even if the user wants to quit out of this loop
 . D UNLOCK^IBCNBU1(IBCNEZBF)
 . Q
LREJX ;
 S VALMBCK="R"
 Q
 ;
 ;
FASTEXIT ; sets flag signaling system should be exited
 N DIR,DIRUT,X,Y
 S VALMBCK="Q"
 D FULL^VALM1
 S DIR(0)="Y",DIR("A")="Exit option entirely",DIR("B")="NO" D ^DIR
 I +Y S IBFASTXT=1
 Q
 ;
SELSORT ;  select the way to sort the list screen
 N DIR,DIRUT,X,Y,DTOUT,DUOUT,DIROUT,ST,STDES
 ;
 D FULL^VALM1 W !
 W !,"Select the item to sort the buffer records on the buffer list screen."
 S DIR(0)="SO^1:Patient Name;2:Insurance Company;3:Source of Information;4:Date Entered;5:Inpatients;6:Means Test;7:On Hold;8:Verified;9:eIV Status;10:Positive Response"
 S DIR("A")="Sort the list by",DIR("B")=$P($G(IBCNSORT),"^",2)
 D ^DIR K DIR
 I 'Y G SELSORTX
 S IBCNSORT=Y_"^"_Y(0)
 ;
 ; ESG - 6/7/02 - SDD 5.1.1
 ; If the user wants to sort by symbol, then ask them which
 ; symbol should appear first and process accordingly.
 ;
 KILL IBCNSORT(1)       ; initialize the symbol sort array
 I +IBCNSORT=9 D  I $D(DIRUT)!('Y) G SELSORTX
 . ;
 . ; build the array of default sort order
 . S IBCNSORT(1,"+")=10
 . S IBCNSORT(1,"-")=20
 . S IBCNSORT(1,"#")=25 ; Added pound to sort criteria
 . S IBCNSORT(1,"!")=30
 . S IBCNSORT(1," ")=40
 . S IBCNSORT(1,"?")=50
 . S IBCNSORT(1,"*")=60
 . ;
 . ; build the DIR array to ask the question
 . S DIR(0)="SO^"
 . F ST="1:+'A1","2:-'D1","3:#'U1","4:!'B1","5: '","6:?'Q1" D  ; removed blanks ; replaced tilde w/apostrophe and added pound as option 3
 .. I ST="5: '" S STDES="No Problems Identified, Awaiting Electronic Processing" ; removed blanks
 .. E  S STDES=$$GET1^DIQ(365.15,$$FIND1^DIC(365.15,"","X",$P(ST,"'",2)),.01,"E")
 .. S DIR(0)=DIR(0)_$P(ST,"'")_"  "_STDES_$S(ST="6:?'Q1":"",1:";")
 . S DIR("A")="Which eIV Status do you want to appear first?"
 . S DIR("B")=1
 . S DIR("?",1)=" Please identify the eIV status that you want to appear first in the Insurance"
 . S DIR("?",2)=" Buffer listing.  The symbol appears immediately to the left of the patient"
 . S DIR("?",3)=" name in the list.  The default sort order for statuses is the same as"
 . S DIR("?",4)=" they are presented in this list below.  You may choose which status will appear"
 . S DIR("?",5)=" first in the list.  The remaining statuses will be sorted according to this"
 . S DIR("?",6)=" default sort order.  When sorting by eIV status, the secondary sort"
 . S DIR("?",7)=" is the entered date and the final sort is by patient name."
 . S DIR("?")=" "
 . D ^DIR K DIR
 . I $D(DIRUT) Q
 . I 'Y Q
 . ;
 . ; update the sort order array with the chosen symbol
 . S IBCNSORT(1,$E(Y(0)))=1
 . S $P(IBCNSORT,U,3)=$E(Y(0))
 . Q
 ;
 ; rebuild and resort the list and update the list header
 D INIT^IBCNBLL,HDR^IBCNBLL
 ;
SELSORTX ;
 S VALMBCK="R",VALMBG=1
 Q
 ;
TGLSCRN(IBBUFDA) ; toggle process screen from policy to insurance info, glbal variable IBCNSCRN contains ins co chosen
 Q:'$G(IBBUFDA)
 D FULL^VALM1
 W !!,"Enter an Insurance Company to display the Groups/Plans for that company or ",!,"enter Return to display a patient's policies.",!!
 S IBCNSCRN=+$$SELINS^IBCNBU1
 ;
 D CLEAN^VALM10,INIT^IBCNBLP,HDR^IBCNBLP S VALMBCK="R",VALMBG=1
 Q
 ;
AMCHK ; This procedure is called from the main buffer screen as an action
 ; to check the insurance company names in the buffer file.  This will
 ; invoke another ListMan screen that shows a list of all insurance 
 ; company names that do not exist in File 36 either as names or as
 ; synonyms and also they do not exist in the Auto Match file.  These
 ; are bad insurance company names that need to be corrected before
 ; electronic insurance verification attempts can be made.
 ; esg - 6/20/02 - SDD 5.1.11 - Add an action on the main buffer
 ;       screen to call the buffer names check option
 ;
 D EN^IBCNEAMC
 S VALMBCK="R"
AMCHKX ;
 Q
 ;
