IBCNEPM1 ;DAOU/ESG - PAYER MAINT/INS COMPANY LIST FOR PAYER ;22-JAN-2003
 ;;2.0;INTEGRATED BILLING;**184,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN(IEN,PAYER,PROFID,INSTID) ; -- main entry point for IBCNE PAYER EXPAND LIST
 ; IEN is the IEN of the Payer(#365.12).  PAYER is the payer's name.
 ; PROFID and INSTID are the EDI ID numbers for the selected payer
 ; These are passed into this routine from EXPND^IBCNEPM2.
 ;
 N IBCNEPRB
 D EN^VALM("IBCNE PAYER EXPAND LIST")    ; call the 2nd list
 I $G(IBCNEPRB) D INIT^IBCNEPM G ENX     ; special variable to rebuild the whole scratch global
 D BUILD^IBCNEPM                         ; just rebuild the list#1 display
ENX ;
 S VALMBCK="R"
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="PAYER: "_$E(PAYER,1,30)_"     Prof. EDI#: "_$E($G(PROFID),1,15)_"  Inst. EDI#: "_$E($G(INSTID),1,15)
 S VALMHDR(2)="Insurance Company Name - Active Only"
 Q
 ;
INIT ; -- init variables and list array
 ; Variable PAYER (payer name) is returned by this procedure and used 
 ; by the list header.  Variable LINE is also set before coming into 
 ; this procedure.
 ;
 KILL ^TMP("IBCNEPM",$J,2),^TMP("IBCNEPM",$J,"LINK")
 NEW INS,ROW,STRING2,NAME,DATA,ADDRESS,DATA2,PROFID,INSTID
 ;
 ;IEN is the payer ien (#365.12)
 ;PAYER is the payer name
 I IEN=""!(PAYER="") Q
 ;
 ; INS is the insurance company ien
 S INS="",ROW=0
 F  S INS=$O(^TMP("IBCNEPM",$J,"PYR",PAYER,IEN,INS)) Q:INS=""  D
 . S STRING2="",ROW=ROW+1
 . S NAME=$P($G(^DIC(36,INS,0)),U,1)   ; insurance company name
 . S DATA=$G(^DIC(36,INS,.11))
 . S ADDRESS=$P(DATA,U,1)
 . I $P(DATA,U,4)'="" S ADDRESS=ADDRESS_"  "_$P(DATA,U,4)
 . I $P(DATA,U,5) S ADDRESS=ADDRESS_","_$P($G(^DIC(5,+$P(DATA,U,5),0)),U,2)
 . S DATA2=$G(^DIC(36,INS,3))
 . S PROFID=$P(DATA2,U,2),INSTID=$P(DATA2,U,4)
 . S STRING2=$$SETFLD^VALM1(NAME,STRING2,"INSURANCE CO")
 . S STRING2=$$SETFLD^VALM1(ADDRESS,STRING2,"ADDRESS")
 . S STRING2=$$SETFLD^VALM1(ROW,STRING2,"LINE")
 . S STRING2=$$SETFLD^VALM1(PROFID,STRING2,"PROFEDI")
 . S STRING2=$$SETFLD^VALM1(INSTID,STRING2,"INSTEDI")
 . D SET^VALM10(ROW,STRING2)
 . ;
 . ; "LINK" scratch global structure = payer ien^ins co ien^payer name
 . S ^TMP("IBCNEPM",$J,"LINK",ROW)=IEN_U_INS_U_PAYER
 . Q
 ;
 S VALMCNT=ROW
 I VALMCNT=0 S VALMSG=" No Matching Insurance Companies "
 Q
 ;
HELP ; -- help code
 N X S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 Q
 ;
LINK ; -- code to facilitate the linking between the ins company and payer
 NEW DIR,X,Y,DIRUT,DIROUT,DTOUT,DUOUT,LINKDATA,PIEN,INS,TPAYER
 NEW DA,DIE,DR,D,D0,DI,DIC,DISYS,DQ,%,PMCNT,PMLST,PMPCE,PMSEL,PMSUB
 ;
 ;PIEN - temp variable for payer IEN (#365.12)
 ;TPAYER - temp variable for payer name
 ;
 D FULL^VALM1
 I 'VALMCNT D  G LINKX
 . W !!?5,"There are no insurance companies to select."
 . D PAUSE^VALM1
 . Q
 ;
 ; If there is only one ins. company, then assume it's selection and skip the reader
 I VALMCNT=1 S (Y,Y(0))="1," G L1
 ;
 S DIR(0)="LO^1:"_VALMCNT_":0"
 S DIR("A")="Select 1 or more Insurance Company Entries"
 W ! D ^DIR K DIR
 I $D(DIRUT) G LINKX
L1 ;
 M PMLST=Y S PMCNT=0,TPAYER=""
 F PMSUB=0:1 Q:'$D(PMLST(PMSUB))  F PMPCE=1:1 S PMSEL=$P(PMLST(PMSUB),",",PMPCE) Q:PMSEL=""  D
 . ; this is the loop that counts up the numbers selected for display purposes
 . S PMCNT=PMCNT+1
 . I TPAYER'="" Q
 . S LINKDATA=$G(^TMP("IBCNEPM",$J,"LINK",+PMSEL)) I LINKDATA="" Q
 . S PIEN=+$P(LINKDATA,U,1)                   ; payer ien
 . S TPAYER=$P($G(^IBE(365.12,PIEN,0)),U,1)   ; payer name
 . Q
 ;
 I 'PMCNT D  G LINKX
 . W !!?5,"No insurance companies selected."
 . D PAUSE^VALM1
 . Q
 ;
 ; get confirmation
 S DIR(0)="YO"
 S DIR("A")="OK to proceed"
 S DIR("A",1)="You have selected "_PMCNT_" insurance compan"_$S(PMCNT=1:"y",1:"ies")
 S DIR("A",2)="to be linked to payer "_TPAYER_"."
 S DIR("B")="YES"
 W ! D ^DIR K DIR
 I 'Y!$D(DIRUT) G LINKX
 ;
 ; At this point, confirmation has been received.   Go ahead and do all the links!
 ;
 F PMSUB=0:1 Q:'$D(PMLST(PMSUB))  F PMPCE=1:1 S PMSEL=$P(PMLST(PMSUB),",",PMPCE) Q:PMSEL=""  D
 . ; this is the loop that makes all the links
 . ; with all of the selected insurance companies
 . S LINKDATA=$G(^TMP("IBCNEPM",$J,"LINK",+PMSEL))
 . I LINKDATA="" Q
 . S PIEN=+$P(LINKDATA,U,1)
 . S TPAYER=$P($G(^IBE(365.12,PIEN,0)),U,1)
 . S INS=+$P(LINKDATA,U,2)
 . ;
 . ; Make the linkage
 . S DA=INS,DIE=36,DR="3.1////"_PIEN D ^DIE
 . ;
 . ; update the scratch global by removing this insurance company
 . KILL ^TMP("IBCNEPM",$J,"PYR",$P(LINKDATA,U,3),PIEN,INS)
 . S ^TMP("IBCNEPM",$J,"PYR",$P(LINKDATA,U,3),PIEN)=$G(^TMP("IBCNEPM",$J,"PYR",$P(LINKDATA,U,3),PIEN))-1
 . KILL ^TMP("IBCNEPM",$J,"INS",INS,PIEN)
 . ;
 . ; search scratch global for remaining pointers to this ins. company
 . S PIEN="" F  S PIEN=$O(^TMP("IBCNEPM",$J,"INS",INS,PIEN)) Q:'PIEN  D
 .. S TPAYER=$G(^TMP("IBCNEPM",$J,"INS",INS,PIEN))
 .. Q:TPAYER=""
 .. KILL ^TMP("IBCNEPM",$J,"PYR",TPAYER,PIEN,INS)
 .. S ^TMP("IBCNEPM",$J,"PYR",TPAYER,PIEN)=$G(^TMP("IBCNEPM",$J,"PYR",TPAYER,PIEN))-1
 .. KILL ^TMP("IBCNEPM",$J,"INS",INS,PIEN)
 .. Q
 . Q
 ;
 ; rebuild the LINK area and the ListMan display global
 D INIT
 ;
 ; user message
 W !!?5,"Link process is complete."
 W !?5,"You may view/edit this relationship by using the"
 W !?5,"Insurance Company Entry/Edit option."
 D PAUSE^VALM1
LINKX ;
 S VALMBCK="R"
 ;
 ; if there are no more insurance companies for this payer, then quit this 2nd list
 ; and set a special variable that will rebuild the main, first list
 I '$D(^TMP("IBCNEPM",$J,"LINK")) K VALMSG S VALMBCK="Q",IBCNEPRB=1
 Q
 ;
