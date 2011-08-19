IBCNBME ;ALB/ARH-Ins Buffer: external entry points, add/edit buffer ;1 Jun 97
 ;;2.0;INTEGRATED BILLING;**82,103,184**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
FEE(DFN) ; ENTRY FOR FEE BASIS:  add/edit a buffer entry
 I '$D(^DPT(+$G(DFN),0)) Q
 Q:'$$INSCOV(+DFN)
 D DISPLAY
 D EDADD(1,+DFN)
 Q
 ;
REG(DFN) ; ENTRY FOR REGISTRATION:  add/edit a buffer entry
 I '$D(^DPT(+$G(DFN),0)) Q
 Q:'$$INSCOV(+DFN)
 D DISPLAY
 D EDADD(1,+DFN)
 Q
 ;
PREG(DFN) ; ENTRY FOR PRE-REGISTRATION:  add/edit a buffer entry
 I '$D(^DPT(+$G(DFN),0)) Q
 Q:'$$INSCOV(+DFN)
 D DISPLAY
 D EDADD(4,+DFN)
 Q
 ;
EDADD(IBSOURCE,DFN) ; add or select a specific patient's buffer entry then edit all data
 ; IBSOURCE = 1-interview, 2-data match, 3-ivm, 4-pre-reg, 5-eiiv
 N X,Y,IBX,IBY,IBBUFDA,DIR,DIRUT,IBINSNM I '$D(^DPT(+$G(DFN),0))!('$G(IBSOURCE)) Q
 ;
 ; allow user to choose one of their own entries for this patient to edit or add a new one
 S DIR("?")="^D HELP^IBCNBME"
 S DIR(0)="FO^3:30",DIR("A")="Select INSURANCE COMPANY" D ^DIR I $D(DIRUT)!(Y="") Q
 ;
 S IBINSNM=$$UP^XLFSTR(Y),IBBUFDA=0
 ;
 ; -- If Medicare (WNR) entered call MII
 I IBINSNM="MEDICARE (WNR)" D ENR^IBCNSMM(DFN,IBSOURCE) Q
 ;
 S IBX=$$DICBUF^IBCNBU1(IBINSNM,DFN,DUZ) I +IBX>0 S IBY=$$EDIT Q:IBY<0  I +IBY>0 S IBBUFDA=+IBX
 ;I 'IBBUFDA S IBX=$$DICINS^IBCNBU1(IBINSNM) Q:IBX<0  I IBX'=0 S IBINSNM=IBX
 I 'IBBUFDA S IBBUFDA=$$NEW(DFN,IBINSNM,IBSOURCE)
 Q:'IBBUFDA  W !!
 ;
 I '$$LOCK^IBCNBU1(IBBUFDA,1) Q
 ;
 D INS^IBCNBEE(IBBUFDA,"OT") W !
 D GRP^IBCNBEE(IBBUFDA,"OT") W !
 D POLICY^IBCNBEE(IBBUFDA,"OT")
 ;
 ; set buffer symbol
 D BUFF^IBCNEUT2(IBBUFDA,+$$INSERROR^IBCNEUT3("B",IBBUFDA))
 ;
 D UNLOCK^IBCNBU1(IBBUFDA)
 Q
 ;
HELP ;
 N Z W !!,"You may add a new Insurance Buffer entry or edit an entry you have already ",!,"created for this patient.  Insurance Company name must be 3-30 characters.",!
 W "To 'fast enter' Medicare coverage information, please enter 'MEDICARE (WNR)'.",!
 S Z=$$DICBUF^IBCNBU1("??",DFN,DUZ)
 Q
 ;
NEW(DFN,INSNAME,SOURCE) ; ask then add new insurance buffer entry
 N X,Y,IBX,DIR,DIRUT,IBDATA S IBX=0 W !
 S DIR(0)="YO",DIR("A")="Add a new Insurance Buffer entry for this patient",DIR("B")="YES" D ^DIR
 I Y=1 S IBDATA(20.01)=INSNAME,IBDATA(60.01)=DFN S IBX=+$$ADDSTF^IBCNBES(SOURCE,DFN,.IBDATA)
 Q IBX
 ;
EDIT() ; ask user if they want to edit an existing buffer entry
 ; returns 0 if don't want to edit, -1 if trys to exit, 1 if wants to edit existing buffer entry
 N X,Y,IBX,DIR,DIRUT,DUOUT,DTOUT S IBX=0 W !
 S DIR(0)="Y",DIR("A")="Edit existing Insurance Buffer entry for this patient",DIR("B")="YES" D ^DIR S IBX=Y I $D(DIRUT) S IBX=-1
 Q IBX
 ;
 ;
DISPLAY ;
 ;
 W !!,?2,"This option adds or edits insurance information in the Insurance Buffer File."
 W !,?2,"This is a temporary file that will hold all new insurance information until"
 W !,?2,"authorized insurance personnel can coordinate this new information with the"
 W !,?2,"patient's existing insurance.  You may add a new Buffer entry or edit a"
 W !,?2,"Buffer entry that you previously created for this patient if that entry"
 W !,?2,"has not yet been processed by insurance personnel."
 W !!,?2,"Please enter all available insurance information.",!!
 Q
 ;
INSCOV(DFN) ; return true if covered by insurance is yes, false if not covered or user ^ out
 ; allow user to edit 'Covered By Insurance' question (2,.3192), then auto correct if if they were wrong
 ; (primarily needed because this field an inconsistancy check in registration so it must have a value)
 ;
 N IBX,IBY,IBCOV1 S IBX=1
 S IBY=$$ASKCOVD^IBCNSP2(DFN,"",.IBCOV1),IBX=+IBY
 D COVERED^IBCNSM31(DFN,IBCOV1)
 Q IBX
