IBCEP0A ;ALB/TMP - EDI UTILITIES for insurance assigned provider ID ;01-NOV-00
 ;;2.0;INTEGRATED BILLING;**137,232,320,377**;21-MAR-94;Build 23
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
NEW(IBINS,IBPRV,IBPTYP,IBDEF) ; Add new insurance co assigned id
 ; IBDEF = flag sent as 1 if only insurance co defaults are being added
 N DIC,DIR,X,Y,Z,DA,DR,DIE,DO,DD,DLAYGO,IBQ,IBIEN,IBCUND,DTOUT,DUOUT
 D FULL^VALM1
 S IBQ=0
 I $G(IBDEF)="D" W !!,"YOU ARE ADDING A PROVIDER ID THAT WILL BE THE INSURANCE CO DEFAULT",!
 I '$G(IBPRV),$G(IBDEF)'="D" D  G:IBQ NEWQ
 . N DA,IBO
 . S IBO=($G(IBDSP)'="I")
 . S DIR(0)="355.9,.01A"_$S(IBO:"O",1:""),DIR("A")="Select PROVIDER"_$S(IBO:" (optional)",1:"")_": "
 . S DIR("?")="Select the PROVIDER to be assigned a provider ID"
 . I IBO S DIR("?",1)=DIR("?"),DIR("?")="Or    Press ENTER to add an insurance co level default id (all providers)"
 . W ! D ^DIR K DIR W !
 . I $D(DTOUT)!$D(DUOUT) S IBQ=1 Q
 . S IBPRV=$S(Y>0:$P(Y,U),1:"")
 . Q:IBPRV
 . S DIR(0)="YA",DIR("B")="YES",DIR("A",1)="YOU ARE ADDING A PROVIDER ID THAT WILL BE THE INSURANCE CO DEFAULT",DIR("A")="IS THIS OK?: "
 . W ! D ^DIR K DIR W !
 . I $D(DTOUT)!$D(DUOUT)!(Y'=1) S IBQ=1
 . Q
 ;
 I '$G(IBPTYP) D  G:IBQ NEWQ
 . S DIR(0)="PAr^355.97:AEMQ",DIR("A")="Select Provider ID Qualifier: "
 . S DIR("?")="Enter a Qualifier to identify the type of ID number you are entering."
 . S DIR("S")="I $$RAINS^IBCEPU(Y)"   ; Rendering/Attending IDs provided by ins
 . S DA=0
 . W ! D ^DIR K DIR W !
 . I $D(DTOUT)!$D(DUOUT)!'Y S IBQ=1 Q
 . S IBPTYP=+Y
 ;
 S IBQ=$$ADDID(IBINS,IBPRV,IBPTYP)
 ;
NEWQ D:'$G(IBQ) BLD^IBCEP0($G(IBINS),$G(IBDSP),$G(IBSORT))
 S VALMBCK="R"
 Q
 ;
DEL1 ; Delete Insurance Co assigned provider ID's
 ; IBPRV = vp ien of provider if editing entry in file 355.9
 ;         otherwise, null
 N IB1,IBDA,IBFILE
 D FULL^VALM1
 D SEL^IBCEP0(.IBDA)
 G:'$O(IBDA(0)) DEL1Q
 S IBDA=+$O(IBDA("")),IBDA=$G(IBDA(IBDA))
 G:'IBDA DEL1Q
 S IB1=$P(IBDA,U,2),IBDA=+IBDA
 S IBFILE=$S(IB1:355.9,1:355.91)
 I IBDA>0 D DEL^IBCEP5B(IBFILE,IBDA,1),BLD^IBCEP0($G(IBINS),$G(IBDSP),$G(IBSORT))
 ;
DEL1Q S VALMBCK="R"
 Q
 ;
CHG1 ; Edit Provider ID's
 N IBDA,IB1,IBFILE
 D FULL^VALM1
 D SEL^IBCEP0(.IBDA)
 G:'$O(IBDA(0)) CHG1Q
 S IBDA=+$O(IBDA("")),IBDA=$G(IBDA(IBDA))
 G:'IBDA CHG1Q
 S IB1=$P(IBDA,U,2),IBDA=+IBDA
 S IBFILE=$S(IB1:355.9,1:355.91)
 I IBDA>0 D
 . I IBFILE=355.9 W !!,"PROVIDER: ",$$EXPAND^IBTRE(355.9,.01,IB1)
 . I IBFILE'=355.9 W !!,"  <<INS CO DEFAULT>>"
 . D CHG^IBCEP5B(IBFILE,IBDA),BLD^IBCEP0($G(IBINS),$G(IBDSP),$G(IBSORT))
 ;
CHG1Q S VALMBCK="R"
 Q
 ;
PRVJMP(IBDSP) ; Navigate to a specific sort level in current LM list
 ;   (from insurance co option)
 ; IBDSP = 'I', 'A' or 'D' to indicate format selected for display
 ;        ([P]ROVIDER, PROVIDER [T]YPE OR [I]NSURANCE DEFAULT)
 ; Sets VALMBG = LINE # if a provider in list selected
 ;
 I $G(IBDSP)="I" D PRVNJMP(.VALMBG)
 I $G(IBDSP)="D"!($G(IBDSP)="A") D PRVTJMP(.VALMBG)
 S VALMBCK="R"
 Q
 ;
PRVNJMP(VALMBG) ; Navigate to a specific provider name (from insurance co
 ;  option)
 ;
 N DIR,X,Y,DA
 D FULL^VALM1
 S DIR(0)="355.9,.01AO^^I '$D(^TMP(""IBPRV_INS_ID"",$J,""ZXPRV"",U_$$EXPAND^IBTRE(355.9,.01,Y)_U_$P(Y,U))) K X"
 S DIR("?",1)="*** YOU MAY ONLY SELECT PROVIDERS INCLUDED IN THE CURRENT LIST ***",DIR("?",2)=" ",DIR("?",3)="SELECTING A PROVIDER WILL FORCE THE DISPLAY TO SKIP TO THE DATA FOR THAT",DIR("?")="   PROVIDER"
 S DIR("A")="SELECT PROVIDER: "
 S DIR("S")="N Z S Z=$P(^(0),U) I $D(^TMP(""IBPRV_INS_ID"",$J,""ZXPRV"",U_$$EXPAND^IBTRE(355.9,.01,Z)_U_Z))"
 W ! D ^DIR K DIR W !
 I Y>0,'$D(DTOUT),'$D(DUOUT) D
 . N Z
 . S Z=$G(^TMP("IBPRV_INS_ID",$J,"ZXPRV",U_$$EXPAND^IBTRE(355.9,.01,$P(Y,U))_U_$P(Y,U)))
 . I Z S VALMBG=Z Q
 . S DIR(0)="EA",DIR("A",1)="THIS PROVIDER DOES NOT EXIST IN THE CURRENT DISPLAY",DIR("A")="PRESS THE ENTER KEY TO CONTINUE"
 . W ! D ^DIR K DIR W !
 Q
 ;
PRVTJMP(VALMBG) ; Navigate to a specific type of ID qualifier (from ins co option)
 ;
 N DIR,X,Y
 D FULL^VALM1
 S DIR(0)="PAO^355.97:AEMQ",DIR("A")="Select type of ID Qualifier: "
 S DIR("?")="Select a type of ID Qualifier to display the IDs of that type."
 S DIR("S")="I $D(^TMP(""IBPRV_INS_ID"",$J,""ZXPTYP"",+Y))"
 W ! D ^DIR K DIR W !
 I Y>0,'$D(DTOUT),'$D(DUOUT) D
 . N Z
 . S Z=$G(^TMP("IBPRV_INS_ID",$J,"ZXPTYP",+Y))
 . I Z S VALMBG=Z Q
 . S DIR(0)="EA",DIR("A",1)="This type of ID Qualifier does not exist in the current display",DIR("A")="Press the Enter key to continue"
 . W ! D ^DIR K DIR W !
 Q
 ;
CHGINS ; Change insurance co being displayed, using the same or new params
 ; Assumes IBINS exists = IEN of insurance co (file 36)
 N IBINEW,IBSAVE,DIC,DA,Y,X,DIR
 D FULL^VALM1
 S DIC="^DIC(36,",DIC(0)="AEMQ" D ^DIC
 S IBINEW=+Y
 ;
 I IBINEW>0,IBINS'=IBINEW D
 . D COPYPROV^IBCEP5A(IBINS)
 . S DIR(0)="YA",DIR("?")="IF YOU WANT TO CHANGE THE FORMAT OF THE DISPLAY, RESPOND NO HERE"
 . S DIR("A")="DO YOU WANT TO DISPLAY THE NEW INS. CO IDS USING THE CURRENT DISPLAY FORMAT?: ",DIR("B")="YES" W ! D ^DIR W ! K DIR
 . Q:Y'=1
 . S IBSAVE("IBINS")=IBINS
 . K ^TMP("IBPRV_INS_ID",$J),VALMHDR S VALMBG=1,IBINS=IBINEW
 . I Y=1 D BLD^IBCEP0($G(IBINS),$G(IBDSP),$G(IBSORT)) Q
 . D INIT^IBCEP0
 . I '$G(VALMQUIT) Q
 . S IBINS=IBSAVE("IBINS") D BLD^IBCEP0($G(IBINS),$G(IBDSP),$G(IBSORT))
 S VALMBCK="R"
 Q
 ;
CHGFMT ; Change format parameters for display
 N IBSAVE
 S IBSAVE("IBINS")=$G(IBINS)
 D INIT^IBCEP0
 I '$G(VALMQUIT) G CHGFMTQ
 S IBINS=IBSAVE("IBINS") D BLD^IBCEP0($G(IBINS),$G(IBDSP),$G(IBSORT))
CHGFMTQ S VALMBCK="R"
 Q
 ;
IPARAM ; Display Insurance co parameters and care unit requirements
 ; Assumes IBINS exists = IEN of insurance co
 N IBDSP,IBSORT,IBHOLD
 D FULL^VALM1
 S IBHOLD("IBINS")=$G(IBINS)
 D EN^VALM("IBCE PRVINS PARAM DISPLAY")
 S:$G(IBHOLD("IBINS"))'="" IBINS=IBHOLD("IBINS")
 K VALMQUIT
 S VALMBCK="R"
 Q
 ;
ADDID(IBINS,IBPRV,IBPTYP) ; Adds a new ID for the provider and/or ins co
 ; IBINS = ien of file 36
 ; IBPRV = vp ien of file 355.9
 ; IBPTYP = ien of file 355.97
 ; FUNCTION returns 1 if record not added, 0 if filed OK
 N IBIEN,IBQ,DIC,DA,DO,DD,DLAYGO,X,Y
 S IBQ=0
 I $G(IBPRV) D  G:IBQ ADDIDQ
 . ; Provider specific for insurance co - add to file 355.9
 . S DIC(0)="L",DLAYGO=355.9,DIC="^IBA(355.9,",X=IBPRV
 . S:$G(IBINS) DIC("DR")=".02////"_IBINS
 . D FILE^DICN K DIC,DLAYGO,DD,DO
 . I Y'>0!$D(DUOUT)!$D(DTOUT) S IBIEN=0,IBQ=1 Q
 . S IBIEN=+Y
 . D NEWID^IBCEP5B(355.9,IBINS,IBPRV,IBPTYP,IBIEN,"")
 E  D
 . ; Insurance co default - add to file 355.91
 . S DIC(0)="L",DLAYGO=355.91,DIC="^IBA(355.91,",X=IBINS
 . D FILE^DICN K DIC,DLAYGO,DD,DO
 . I Y'>0!$D(DUOUT)!$D(DTOUT) S IBIEN=0,IBQ=1 Q
 . S IBIEN=+Y
 . D NEWID^IBCEP5B(355.91,IBINS,"",IBPTYP,IBIEN,1)
ADDIDQ Q IBQ
