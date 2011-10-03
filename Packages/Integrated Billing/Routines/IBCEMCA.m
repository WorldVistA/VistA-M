IBCEMCA ;ALB/ESG - Multiple CSA Message Management ;20-SEP-2005
 ;;2.0;INTEGRATED BILLING;**320**;21-MAR-1994
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
 ;
SCREEN ; Change the message selection criteria
 NEW DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,EDI,IBDONE,IBPAYER,INST,PROF,RESET,X,Y
 S VALMBCK="R",RESET=0
 D FULL^VALM1
 W !
 S DIR(0)="Y",DIR("A")="Do you want to change the MCS selection criteria"
 S DIR("B")="Yes" D ^DIR K DIR
 I 'Y G SCREENX          ; get out; no list rebuild
 K ^TMP($J,"IBCEMCA")    ; kill selection area and rebuild below
 K VALMHDR               ; recalculate totals in header area
 S VALMBG=1              ; begin new list display at line 1
 ;
Q1 ; payer
 W !!,"PAYER SELECTION:"
 S IBPAYER=""
 S DIR(0)="SA^A:All Payers;S:Selected Payers"
 S DIR("A")="Include All Payers or Selected Payers? "
 S DIR("B")="All"
 D ^DIR K DIR
 I $D(DIROUT)!$D(DIRUT) S RESET=1 G QX  ; kill scratch and rebuild list
 I Y="A" K ^TMP($J,"IBCEMCA","INS") G Q2
 W !
 S DIR(0)="Y"
 S DIR("A")="   Include all payers with the same electronic Payer ID"
 S DIR("B")="Yes"
 D ^DIR K DIR
 I $D(DIROUT) S RESET=1 G QX   ; kill scratch and rebuild the list
 I $D(DIRUT) G Q1
 S IBPAYER=Y
 W !
 ;
 S IBDONE=0
 F  D  Q:IBDONE
 . S DIC=36,DIC(0)="AEMQ",DIC("A")="   Select Insurance Company: "
 . I $O(^TMP($J,"IBCEMCA","INS",1,"")) S DIC("A")="   Select Another Insurance Company: "
 . S DIC("W")="D INSLIST^IBCEMCA(Y)"
 . D ^DIC K DIC                ; lookup
 . I X="^^" S IBDONE=2 Q       ; user entered ^^
 . I +Y'>0 S IBDONE=1 Q        ; user is done
 . S ^TMP($J,"IBCEMCA","INS",1,+Y)=$P(Y,U,2)
 . I 'IBPAYER Q
 . S EDI=$$UP^XLFSTR($G(^DIC(36,+Y,3)))
 . S PROF=$P(EDI,U,2)
 . S INST=$P(EDI,U,4)
 . I PROF'="",PROF'["PRNT" S ^TMP($J,"IBCEMCA","INS",2,PROF,+Y)=""
 . I INST'="",INST'["PRNT" S ^TMP($J,"IBCEMCA","INS",2,INST,+Y)=""
 . Q
 ;
 I IBDONE=2 S RESET=1 G QX      ;kill scratch and rebuild the list
 ;
 I '$O(^TMP($J,"IBCEMCA","INS",1,"")) D  G Q1
 . W *7,!!?3,"No payers have been selected.  Please try again."
 . Q
 ;
Q2 ; division
 W !!,"DIVISION SELECTION:"
 S DIR(0)="SA^A:All Divisions;S:Selected Divisions"
 S DIR("A")="Include All Divisions or Selected Divisions? "
 S DIR("B")="All"
 D ^DIR K DIR
 I $D(DIROUT) S RESET=1 G QX  ; kill scratch and rebuild list
 I $D(DIRUT) G Q1
 I Y="A" K ^TMP($J,"IBCEMCA","DIV") G Q3
 ;
 W !
 S IBDONE=0
 F  D  Q:IBDONE
 . S DIC=40.8,DIC(0)="AEMQ",DIC("A")="   Select Division: "
 . I $O(^TMP($J,"IBCEMCA","DIV","")) S DIC("A")="   Select Another Division: "
 . D ^DIC K DIC                ; lookup
 . I X="^^" S IBDONE=2 Q       ; user entered ^^
 . I +Y'>0 S IBDONE=1 Q        ; user is done
 . S ^TMP($J,"IBCEMCA","DIV",+Y)=$P(Y,U,2)
 . Q
 ;
 I IBDONE=2 S RESET=1 G QX      ;kill scratch and rebuild the list
 ;
 I '$O(^TMP($J,"IBCEMCA","DIV","")) D  G Q2
 . W *7,!!?3,"No divisions have been selected.  Please try again."
 . Q
 ;
Q3 ; message text
 W !!,"ERROR MESSAGE TEXT SELECTION:"
 S DIR(0)="SA^A:All Error Message Text;S:Select Error Message Text"
 S DIR("A")="Include All Error Message Text or Select Error Message Text? "
 S DIR("B")="All"
 D ^DIR K DIR
 I $D(DIROUT) S RESET=1 G QX  ; kill scratch and rebuild list
 I $D(DIRUT) G Q2
 I Y="A" K ^TMP($J,"IBCEMCA","TEXT") G Q4
 ;
 W !
 S IBDONE=0
 F  D  Q:IBDONE
 . S DIR(0)="FAOU"
 . S DIR("A")="   Text String: "
 . I $O(^TMP($J,"IBCEMCA","TEXT",""))'="" S DIR("A")="   Another Text String: "
 . D ^DIR K DIR                ; user response
 . I $D(DIROUT) S IBDONE=2 Q   ; user entered ^^
 . I $D(DIRUT) S IBDONE=1 Q    ; leading up-arrow or time-out
 . I Y="" S IBDONE=1 Q         ; null response
 . S ^TMP($J,"IBCEMCA","TEXT",Y)=""
 . Q
 ;
 I IBDONE=2 S RESET=1 G QX      ;kill scratch and rebuild the list
 ;
 I $O(^TMP($J,"IBCEMCA","TEXT",""))="" D  G Q3
 . W *7,!!?3,"No text has been selected.  Please try again."
 . Q
 ;
Q4 ; date range for when message received
 W !!,"DATE MESSAGE RECEIVED SELECTION:"
 S DIR(0)="SA^A:All Dates;S:Select Date Range"
 S DIR("A")="Include All Dates or Select a Date Range? "
 S DIR("B")="All"
 D ^DIR K DIR
 I $D(DIROUT) S RESET=1 G QX  ; kill scratch and rebuild list
 I $D(DIRUT) G Q3
 I Y="A" K ^TMP($J,"IBCEMCA","DATE") G QX
 ;
Q4A ; beginning date
 W !
 S DIR(0)="DAO^:"_DT_":AEX",DIR("A")="   Enter the beginning date: "
 D ^DIR K DIR
 I $D(DIROUT) S RESET=1 G QX   ; kill scratch and rebuild list
 I $D(DIRUT)!'Y G Q4
 S $P(^TMP($J,"IBCEMCA","DATE"),U,1)=Y
 ;
Q4B ; ending date
 W !
 S DIR(0)="DAO^"_Y_":"_DT_":AEX",DIR("A")="   Enter the ending date: "
 D ^DIR K DIR
 I $D(DIROUT) S RESET=1 G QX   ; kill scratch and rebuild list
 I $D(DIRUT)!'Y G Q4A
 S $P(^TMP($J,"IBCEMCA","DATE"),U,2)=Y
 ;
QX ; end of questions, rebuild the list with user supplied selections
 I RESET KILL ^TMP($J,"IBCEMCA")
 D INIT^IBCEMCL
 ;
SCREENX ;
 Q
 ;
TOGGLE ; Select/De-select entries in the list
 NEW IBSEL,DIR,X,Y,DIRUT,DIROUT,DTOUT,DUOUT,IBCEMLST,IBCEMSUB,IBCEMPCE,IBZ,IBIFN,IBDA,IBVALM,Z,RSTA
 D FULL^VALM1
 I '$D(^TMP($J,"IBCEMCL",3)) D  G TOGGLEX
 . W !!?5,"There are no messages to select." D PAUSE^VALM1
 . Q
 S DIR(0)="LO^1:"_+$O(^TMP($J,"IBCEMCL",3,""),-1)
 S DIR("A")="Select EDI Status Messages"
 W ! D ^DIR K DIR
 I $D(DIRUT) G TOGGLEX
 M IBCEMLST=Y
 F IBCEMSUB=0:1 Q:'$D(IBCEMLST(IBCEMSUB))  F IBCEMPCE=1:1 S IBSEL=$P(IBCEMLST(IBCEMSUB),",",IBCEMPCE) Q:'IBSEL  D
 . S IBZ=$G(^TMP($J,"IBCEMCL",3,IBSEL))
 . S IBIFN=+IBZ,IBDA=+$P(IBZ,U,2),IBVALM=+$P(IBZ,U,4)
 . I 'IBIFN Q
 . I 'IBDA Q
 . I 'IBVALM Q
 . I '$D(^TMP($J,"IBCEMCL",2,IBVALM,0)) Q
 . D MARK^IBCEMCL(IBDA,IBIFN,IBVALM,IBSEL,.Z)
 . I Z'="" S RSTA(Z)=$G(RSTA(Z))+1
 . Q
 ;
 I $G(RSTA("L")) D   ; display results only if some could not be selected
 . W !!?8,"Number of messages selected:  ",+$G(RSTA("S"))
 . W !?5,"Number of messages de-selected:  ",+$G(RSTA("D"))
 . W !?2,"Number of messages that could not"
 . W !?4,"be selected because other users"
 . W !?12,"have them locked in CSA:  ",+$G(RSTA("L"))
 . D PAUSE^VALM1
 . Q
TOGGLEX ;
 S VALMBCK="R"
 Q
 ;
INSLIST(INS) ; lister for DIC call.  INS is ien to file 36.
 NEW AD,L1,CITY,ST,EDI,PROF,INST,PYRID
 S AD=$G(^DIC(36,INS,.11))
 S L1=$P(AD,U,1),CITY=$P(AD,U,4),ST=$P(AD,U,5)
 I ST S ST=$P($G(^DIC(5,ST,0)),U,2)
 S CITY=$E(CITY,1,15)
 I CITY'="",ST'="" S CITY=CITY_","
 S CITY=CITY_$E(ST,1,2)
 ;
 S EDI=$G(^DIC(36,INS,3))
 S PROF=$P(EDI,U,2),INST=$P(EDI,U,4)
 S PYRID=$E(PROF,1,5)
 I PROF'="",INST'="" S PYRID=PYRID_"/"
 S PYRID=PYRID_$E(INST,1,5)
 ;
 W ?27,$E(L1,1,20)        ; address line 1
 W ?47,"  ",CITY          ; city,state
 W ?67,"  ",PYRID         ; payer IDs
INSLISTX ;
 Q
 ;
