GMRCSLMA ;SLC/DLT - List Manager protocol entry, exit actions ; 11/25/2000
 ;;3.0;CONSULT/REQUEST TRACKING;**4,18,63**;DEC 27, 1997;Build 10
 ; This routine invokes IA #875,#2638
 ;Variables used in entry and exit actions
 ; GMRCALFL is 1 flags the action is executing from an alert
 ;        set logic is GMRCALFL=$S($D(XQAID)&($D(XQADATA):1,1:0)
 ; VALMBCK="R" to refresh screen
 ;        =NULL to clear bottom portion of screen and prompt for action
 ;        =Q to exit List manager
 ; GMRC("NMBR") = the currently highlighed entry in the list
 ; BLK=
 ; LNCT= Set to 1 if the GMRCALFL flag is 1
 ; GMRCQUT= if defined than exit list manager?
 ; GMRCEN = defined if branched to date range prompt by EN^GMRCSLM
 ; GMRCOER= used to indicate whether CPRS or consults initiated action
 ;         0 for Consults List Manager
 ;         1 for GUI
 ;         2 for CPRS Consults tab to Detailed Display
 ; ^TMP("GMRC",$J,"CURRENT","MENU"))= the action menu for user
 ;        based on the service by EN^GMRCMENU
 ;Entry points called:
 ;  AD^GMRCSLM1  ;Loop through AD cross-reference doing SET
 ;  SET^GMRCSLM1 ;Format entries into ^TMP("GMRCR",$J,"CS"
 ;  INIT^GMRCSLM ;Initialize variables and list array
 ;  END^GMRCSLM1 ;Resets BLK and LNCT and kills variables
 ;  HDR^GMRCSLM  ;Reset the VALMHDR values
 ;  AGAIN^GMRCSLMV(GMRC("NMBR")) ;Reset the video attribute only, do not redisplay
 ;  RESET^GMRCSLMV(GMRC("NMBR")) ;turn reverse video off when another item is selected
 ;
ENTRY(TYPE) ; -- Entry action for list manager actions
 ;Actions: RT,DT
 ;TYPE="" when the list and header have no change
 ;TYPE["L"
 ;    Assumes Rebuild the list due to change in the list information
 ;    Use for GMRCACT CANCEL REQUEST, GMRCACT DISCONTINUE
 ;            GMRCACT COMPLETE,GMRCACT EDIT/RESUBMIT
 ;TYPE["H"
 ;    Assumes need to rebuild the header too due to change in the list
 ;        manager used while processing the action
 ;    Use for GMRCACT COMPLETE, DD, RT, since it goes to TIU
 S VALMBCK="R"
 ;Q:$D(GMRCQUT)
 ;
 I $D(GMRCALFL) D  Q  ;Processing from an alert, quit
 . K ^TMP("GMRCR",$J,"CS"),GMRCDA
 . S BLK=0,LNCT=1
 . S VALMBCK="R"
 . D SET^GMRCSLM1
 . D INIT^GMRCSLM
 . S VALMCNT=1
 . ;D END^GMRCSLM1 ;cancel,receive
 . Q
 ;
 ;Processing from Consults action
 I $G(TYPE)["L" D AD^GMRCSLM1,INIT^GMRCSLM S VALMBG=1
 I $G(TYPE)["H" D HDR^GMRCSLM,INIT^GMRCSLM
 Q
 ;alert logic not flushed out
 ;. I $G(TYPE)["L" D
 ;. . ; rebuild the list
 ;. . K ^TMP("GMRCR",$J,"CS")
 ;. . D SET^GMRCSLM1
 ;. . D INIT^GMRCSLM
 ;. I $G(TYPE)["H" D HDR^GMRCSLM,INIT^GMRCSLM
 ;. I $G(TYPE)["L" D END^GMRCSLM1 ;cancel,receive
 ;. Q
 ;
EXIT(LINE) ; -- Exit action for list manager to refresh screen and reset the menu
 ;Actions using this: RT,DT
 ;LINE contains "A" Re-highlight line on list
 ;LINE contains "R" Remove highlight on list
 ;Used by GMRCACT CANCEL REQUEST,GMRCACT COMMENT ORDERS,
 ;        GMRCACT EDIT/RESUBMIT
 I "A"[LINE,$D(GMRC("NMBR")) D AGAIN^GMRCSLMV(GMRC("NMBR")) ;DD entry and RD exit action
 I "R"[LINE,$D(GMRC("NMBR")) D RESET^GMRCSLMV(GMRC("NMBR")) K GMRC("NMBR")
 S VALMBCK="R"
 S:$D(^TMP("GMRC",$J,"CURRENT","MENU")) XQORM("HIJACK")=^("MENU")
 S VALMBG=1
 K GMRCSEL,GMRCO,GMRCND
 Q
 ;
PHDR ; -- protocol header code called from the protocol action menus
 ;S VALMSG=$$MSG
 D SHOW^VALM
 S XQORM("#")=$O(^ORD(101,"B","GMRC SELECT ITEM",0))_"^1:"_VALMCNT
 S XQORM("A")="Select: "
 S XQORM("KEY","EX")=$O(^ORD(101,"B","GMRCACT QUIT",0))_"^1"
 S XQORM("KEY","Q")=$O(^ORD(101,"B","GMRCACT QUIT",0))_"^1"
 S XQORM("KEY","CLOSE")=$O(^ORD(101,"B","GMRCACT QUIT",0))_"^1"
 S XQORM("KEY","NX")=$O(^ORD(101,"B","GMRCACT NEXT SCREEN",0))_"^1"
 S XQORM("KEY","NEXT")=$O(^ORD(101,"B","GMRCACT NEXT SCREEN",0))_"^1"
 S XQORM("KEY","PS")=$O(^ORD(101,"B","GMRCACT PRINT CONSULT FORM",0))_"^1"
 S XQORM("KEY","CM")=$O(^ORD(101,"B","GMRCACT COMMENT ORDERS",0))_"^1"
 K GMRCNMBR
 Q
 ;I '+$G(OVRRIDE),$$VALID^GMRCAU(+$G(GMRCSS)) D  ;set 2.5 mnem's into XQORM("KEY")
 ;. S XQORM("KEY","AC")="$O(^ORD(101,"B","GMRCACT ADMIN COMPLETE",0)_"^1"
 ;. S XQORM("KEY","DY")=$O(^ORD(101,"B","GMRCACT CANCEL",0))_"^1"
 ;. S XQORM("KEY","ED")=$O(^ORD(101,"B","GMRC CHANGE ORDERS",0))_"^1"
 Q
MSG() ; -- LMgr message bar
 Q "Enter the number of the item you wish to act on, or select an action."
 ;
MARGIN ; -- Reset bottom margin if menu display off
 N BM S BM=$S(VALMMENU:17,1:21) Q:BM=VALM("BM")  ; no change
 S VALM("BM")=BM,VALM("LINES")=VALM("BM")-VALM("TM")+1,VALMBCK="R"
 Q
 ;
SELEXIT ; -- Exit action for list manager when selection criteria changed
 S:$D(^TMP("GMRC",$J,"CURRENT","MENU")) XQORM("HIJACK")=^("MENU")
 S VALMBCK="R"
 Q:($D(GMRCQUT)!$D(GMRCQUIT))  ;status exit using GMRCQUIT??
 I $D(GMRC("NMBR")) D RESET^GMRCSLMV(GMRC("NMBR")) K GMRC("NMBR")
 D AD^GMRCSLM1
 D INIT^GMRCSLM ;from select patient, select service
 D HDR^GMRCSLM  ;from select patient, select date range
 K GMRCSEL,GMRCO,GMRCND
 Q
 ;
