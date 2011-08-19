IBCNBU1 ;ALB/ARH-Ins Buffer: Utilities ;1 Jun 97
 ;;2.0;INTEGRATED BILLING;**82,184,263**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
BUFFER(DFN) ; returns IFN of first buffer entry found for the patient, 0 otherwise
 Q +$O(^IBA(355.33,"C",+$G(DFN),0))
 ;
SELINS() ; user select an insurance company
 N IBX,DIE,DTOUT,DUOUT,DIC,X,Y S IBX=0
 S DIC="^DIC(36,",DIC(0)="AEQ",DIC("A")="Select INSURANCE COMPANY: ",DIC("S")="I '$P(^(0),U,5)" D ^DIC
 I +Y>0 S IBX=Y
 Q IBX
 ;
SELGRP(IBINSDA) ; given a specific insurance company, allow user to choose a group/plan
 N IBX,DIE,DTOUT,DUOUT,DIC,X,Y,IBINSNM S IBX=0
 S IBINSNM=$P($G(^DIC(36,+IBINSDA,0)),U,1)
 W !,IBINSNM
 S X=IBINSNM,DIC="^IBA(355.3,",DIC(0)="EQ",DIC("S")="I +^(0)="_+IBINSDA_"&('$P(^(0),U,11))" D ^DIC
 I +Y>0 S IBX=Y
 Q IBX
 ;
SELEXT(DFN) ; user select existing ins co, group, and if the patient is a member of the group also return the policy
 N IBX,IBINSDA,IBGRPDA,IBPOLDA S (IBINSDA,IBGRPDA,IBPOLDA)=""
 S IBINSDA=$$SELINS() S IBX=+IBINSDA
 I +IBINSDA S IBGRPDA=$$SELGRP(+IBINSDA) I +IBGRPDA S IBX=IBX_U_+IBGRPDA
 I +IBGRPDA,+$G(DFN) S IBPOLDA=$$PTGRP(DFN,IBINSDA,IBGRPDA) I +IBPOLDA S IBX=IBX_U_+IBPOLDA
 Q IBX
 ;
PTGRP(DFN,IBINSDA,IBGRPDA) ; return policy ifn if patient is a member of this group plan
 N IBX,IBY S IBX=0,DFN=+$G(DFN),IBINSDA=+$G(IBINSDA),IBGRPDA=+$G(IBGRPDA)
 S IBY=0 F  S IBY=$O(^DPT(DFN,.312,"B",IBINSDA,IBY)) Q:'IBY  I +$P($G(^DPT(DFN,.312,IBY,0)),U,18)=IBGRPDA S IBX=IBY
 Q IBX
 ;
DISPBUF(IBBUFDA) ; display summary info on a buffer entry
 ;
 Q:'$G(IBBUFDA)
 N IB0,IB60 S IB0=$G(^IBA(355.33,IBBUFDA,0)) Q:IB0=""  S IB60=$G(^IBA(355.33,IBBUFDA,60))
 ;
 W !,"--------------------------------------------------------------------------------"
 W !,?2,"Entered: ",?15,$$FMTE^XLFDT(+IB0,2),?50,"Source: ",?60,$$EXPAND^IBTRE(355.33,.03,$P(IB0,U,3))
 W !,?2,"Entered By: ",?15,$$EXPAND^IBTRE(355.33,.02,+$P(IB0,U,2)),?50,"Verified: ",?60,$$FMTE^XLFDT($P(IB0,U,10),2)
 I +$P(IB0,U,10) W !,?50,"Verif By: ",?60,$E($$EXPAND^IBTRE(355.33,.11,$P(IB0,U,11)),1,20)
 W !!,?2,"Patient: ",?15,$$EXPAND^IBTRE(355.33,60.01,$P(IB60,U,1)),?50,"Sub Id: ",?60,$P(IB60,U,4)
 W !,?2,"Insurance: ",?15,$P($G(^IBA(355.33,+IBBUFDA,20)),U,1),?50,"Group #: ",?60,$P($G(^IBA(355.33,+IBBUFDA,40)),U,3)
 W !,?15,$P($G(^IBA(355.33,+IBBUFDA,21)),U,1)
 W !,"--------------------------------------------------------------------------------"
 Q
 ;
LOCK(IBBUFDA,DISP,TO) ; return true if able to lock the buffer entry, if not an DISP is true then will display a message
 ; TO - lock attempt time out & hang time in seconds, default to 4
 N IBX S IBX=0
 S TO=$G(TO,4)
 I +$G(IBBUFDA) L +^IBA(355.33,+IBBUFDA):TO I +$T S IBX=1
 I 'IBX,+$G(DISP) W !!,"Another user is currently editing/processing this entry, please try again later.",! H TO
 Q IBX
 ;
UNLOCK(IBBUFDA) ; unlock a Buffer entry
 L -^IBA(355.33,+IBBUFDA)
 Q
 ;
DICINS(INSNAME,IBSCACT,IBLISTN) ; user search/selection of existing Insurance Company Names, does not list duplicates, based on names and synonyms
 ;
 ; Input parameters
 ;    INSNAME - user input; partial name match of insurance company
 ;    IBSCACT - 0/1 flag indicating if inactive insurance companies
 ;              should get screened out during the list building
 ;              Default is 0 (no screen)
 ;    IBLISTN - number of entries to display in the lister before
 ;              giving the user a chance to select. Default is 4.
 ; Output
 ;    returns Ins name, or -1 if ^, or 0 if none selected
 ;
 S IBSCACT=$G(IBSCACT,0)  ; flag to screen out inactive ins
 S IBLISTN=$G(IBLISTN,4)  ; number of list entries before user selection
 ;
 N IBX,IBINB,IBCX,IBSEL,IBXRF,IBNAME,IBSYNM,IBCNT,IBC1,IBINSIEN,IBLINE
 S IBSEL=0 K ^TMP($J,"IBINSS"),^TMP($J,"IBINSSB") I INSNAME="" G DINSQ
 ;
 S INSNAME=$$UP^XLFSTR(INSNAME),IBX=$L(INSNAME),IBINB=$E(INSNAME,1,(IBX-1))_$C($A($E(INSNAME,IBX))-1)_"~"
 ;
 F IBCX="C","B" S IBXRF=IBINB D
 . F  S IBXRF=$O(^DIC(36,IBCX,IBXRF)) Q:IBXRF=""!($E(IBXRF,1,IBX)'=INSNAME)  D
 .. S IBINSIEN=0
 .. F  S IBINSIEN=+$O(^DIC(36,IBCX,IBXRF,IBINSIEN)) Q:'IBINSIEN  D
 ... I '$D(^DIC(36,IBINSIEN,0)) Q  ; bad xref entry?
 ... I IBSCACT,$P($G(^DIC(36,IBINSIEN,0)),U,5) Q   ; inactive
 ... I IBSCACT,$P($G(^DIC(36,IBINSIEN,5)),U,1) Q   ; scheduled for deletion
 ... S IBNAME=$P($G(^DIC(36,IBINSIEN,0)),U,1)
 ... I IBNAME="" Q
 ... I $D(^TMP($J,"IBINSSB",IBNAME)) Q
 ... S ^TMP($J,"IBINSSB",IBNAME)=$S(IBNAME=IBXRF:"",1:IBXRF)
 ... Q
 ;
 S IBCNT=0,IBX="" F  S IBX=$O(^TMP($J,"IBINSSB",IBX)) Q:IBX=""  S IBCNT=IBCNT+1,^TMP($J,"IBINSS",IBCNT)=IBX
 ;
 S (IBCNT,IBC1)=0 F  S IBCNT=$O(^TMP($J,"IBINSS",IBCNT)) Q:'IBCNT  D  I +IBSEL Q
 . S IBNAME=^TMP($J,"IBINSS",IBCNT) Q:IBNAME=""  S IBSYNM=$G(^TMP($J,"IBINSSB",IBNAME))
 . S IBLINE=$J(IBCNT,7)_"   "_$$FO^IBCNEUT1(IBNAME,40)_IBSYNM
 . DO EN^DDIOL(IBLINE)
 . S IBC1=IBC1+1 I '(IBCNT#IBLISTN) S IBSEL=$$DIR(IBC1)
 . Q
 ;
 I 'IBSEL,+(IBC1#IBLISTN) S IBSEL=$$DIR(IBC1)
 ;
 I IBSEL>0 S IBSEL=$G(^TMP($J,"IBINSS",IBSEL))
 ;
DINSQ K ^TMP($J,"IBINSS"),^TMP($J,"IBCNSSB")
 Q IBSEL
 ;
DIR(MAX) ; DIR call for DICINS search for insurance company name
 N DIR,DIRUT,DTOUT,DUOUT,IBX,X,Y S IBX=0,DIR(0)="LOA^1:"_MAX_"^K:X'>0!(X>"_MAX_") X",DIR("A")="CHOOSE 1-"_MAX_": "
 I $G(MAX)>0 D ^DIR K DIR S IBX=$S($D(DTOUT)!$D(DUOUT):-1,+Y:+Y,1:0)
 Q IBX
 ;
DICBUF(INSNAME,DFN,IBDUZ) ; display list of editable buffer entries based on insurance name, may specify patient and/or enterer
 ; (non-MCCR people: only the person that created an entry should be able to edit it, everyone else should create new ones)
 N X,Y,IBX,DIC,DA,DR,DIR,DIRUT,DTOUT,DUOUT,D S IBX=0
 ;
 S DIC("W")="W ""   "",$P($G(^(20)),U,1),""   "",$P($G(^(21)),U,1)"
 S DIC("S")="I $P(^(0),U,4)=""E""&('$P(^(0),U,10))" S:+$G(IBDUZ) DIC("S")=DIC("S")_"&(+$P(^(0),U,2)="_IBDUZ_")" S:+$G(DFN) DIC("S")=DIC("S")_"&(+$G(^(60))="_DFN_")"
 S DIC="^IBA(355.33,",DIC(0)="EM",X=$$UP^XLFSTR($G(INSNAME)),D="D" D IX^DIC I '$D(DTOUT),'$D(DUOUT),+Y>0 S IBX=+Y
 Q IBX
