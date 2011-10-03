IBCNBLA1 ;ALB/ARH - Ins Buffer: LM action calls (cont) ;1 Jun 97
 ;;2.0;INTEGRATED BILLING;**82,133,149,184,252,271,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
ADDBUF ; add a new buffer entry protocol
 N DIC,DIR,DIRUT,DUOUT,X,Y,IBIN,DFN,IBBUFDA,IBDATA,AMLIST,IBHELP
 D FULL^VALM1 S VALMBCK="R"
 ;
 ; Patient lookup
 S DIC(0)="AEQM",DIC="^DPT(" D ^DIC Q:Y'>0  S DFN=+Y W !
 ;
INS ; Insurance company lookup
 S DIR("A")="Insurance Company",DIR(0)="FO^1:30"
 S DIR("?",1)="Please enter the name of the insurance company that provides coverage for this"
 S DIR("?",2)="patient.  This response is a free text response, however, a partial insurance"
 S DIR("?")="company name look-up is available here."
 ; BHS - 10/15/03 - Removed quit condition when user enters a caret
 ;                  during the insurance lister and only sets IBIN
 ;                  when a valid selection is made
 D ^DIR K DIR Q:$D(DIRUT)  S IBIN=Y,Y=$$DICINS^IBCNBU1(Y,1,10) I Y'<0,Y'=0 S IBIN=Y
 ;
 ; ESG - 6/17/02 - Usage of Auto Match file when adding a buffer entry
 ;     - SDD 5.1.3
 ;
 ; BHS - 10/15/03 - Added condition to allow Auto Match lookup when user
 ;                  entered a caret during the insurance lister
 I Y=0!(Y<0),$$AMLOOK^IBCNEUT1(IBIN,1,.AMLIST) S Y=$$AMSEL^IBCNEUT1(.AMLIST) I Y'<0,Y'=0 S IBIN=Y
 I '$$INPTTR(355.33,20.01,$$UP^XLFSTR(IBIN)) D  G INS
 . D FIELD^DID(355.33,20.01,"","HELP-PROMPT","IBHELP")
 . W !?5,IBHELP("HELP-PROMPT") Q
 ;
 S DIR(0)="Y",DIR("A")="Add a new Insurance Buffer entry for this patient and company",DIR("B")="YES" W ! D ^DIR K DIR Q:Y'=1
 ;
 S IBDATA(20.01)=$$UP^XLFSTR(IBIN),IBDATA(60.01)=DFN
 S IBBUFDA=+$$ADDSTF^IBCNBES(1,DFN,.IBDATA) K IBDATA Q:'IBBUFDA
 ;
 I '$$LOCK^IBCNBU1(IBBUFDA,1) Q
 D INSHELP^IBCNBEE,INS^IBCNBEE(IBBUFDA)
 D GRPHELP^IBCNBEE,GRP^IBCNBEE(IBBUFDA)
 D POLHELP^IBCNBEE,POLICY^IBCNBEE(IBBUFDA)
 D BUFF^IBCNEUT2(IBBUFDA,+$$INSERROR^IBCNEUT3("B",IBBUFDA))   ; symbol
 D UNLOCK^IBCNBU1(IBBUFDA)
 ;
 D INIT^IBCNBLL,HDR^IBCNBLL S VALMBCK="R"
 Q
 ;
INSEDIT(IBBUFDA) ; edit the Insurance data of a buffer entry
 ;
 Q:'$G(IBBUFDA)  D FULL^VALM1
 D INSHELP^IBCNBEE,INS^IBCNBEE(IBBUFDA)
 ;
 D CLEAN^VALM10,INIT^IBCNBLE,HDR^IBCNBLE S VALMBCK="R" D UPDLN^IBCNBLL(IBBUFDA,"EDITED")
 Q
 ;
GRPEDIT(IBBUFDA) ; edit the Group/Plan data of a buffer entry
 ;
 Q:'$G(IBBUFDA)  D FULL^VALM1
 D GRPHELP^IBCNBEE,GRP^IBCNBEE(IBBUFDA)
 ;
 D CLEAN^VALM10,INIT^IBCNBLE,HDR^IBCNBLE S VALMBCK="R"
 Q
 ;
POLEDIT(IBBUFDA) ; edit the Subscriber Policy data of a buffer entry
 ;
 Q:'$G(IBBUFDA)  D FULL^VALM1
 D POLHELP^IBCNBEE,POLICY^IBCNBEE(IBBUFDA)
 ;
 D CLEAN^VALM10,INIT^IBCNBLE,HDR^IBCNBLE S VALMBCK="R" D UPDLN^IBCNBLL(IBBUFDA,"EDITED")
 Q
 ;
ALLEDIT(IBBUFDA) ; edit All data of a buffer entry
 ;
 Q:'$G(IBBUFDA)  D FULL^VALM1
 D INSHELP^IBCNBEE,INS^IBCNBEE(IBBUFDA)
 D GRPHELP^IBCNBEE,GRP^IBCNBEE(IBBUFDA)
 D POLHELP^IBCNBEE,POLICY^IBCNBEE(IBBUFDA)
 ;
 D CLEAN^VALM10,INIT^IBCNBLE,HDR^IBCNBLE S VALMBCK="R" D UPDLN^IBCNBLL(IBBUFDA,"EDITED")
 Q
 ;
CMPEDIT(IBBUFDA) ; display a buffer entry and an existing ins entry for comparison, allow edit of buffer data
 Q:'$G(IBBUFDA)
 N IBDA,IBPOLDA,IBGRPDA,IBINSDA,DIR,DIRUT,X,Y
 ;
 D FULL^VALM1
 ;
 S IBDA=$$SEL^IBCNBLA("IBCNBLPX") I 'IBDA G CMPQ
 I $P(IBDA,U,4)'="",+$G(^IBA(355.33,+IBBUFDA,60))'=$P(IBDA,U,4) W !,"Buffer Patient doesn't match Policy Patient, can't continue." G CMPQ
 S IBINSDA=+IBDA,IBGRPDA=+$P(IBDA,U,2),IBPOLDA=+$P(IBDA,U,3)
 ;
CEINS W @IOF
 I 'IBINSDA W !,"No Insurance Company Selected for Comparison."
 W ! D INS^IBCNBCD(IBBUFDA,IBINSDA)
 S DIR("?")="The Buffer entry's Insurance Company data may be edited or Return advances the display to the Group/Plan data.",DIR("??")="^D HELP^IBCNBUH,WAIT^IBCNBUH,INS^IBCNBCD("_IBBUFDA_","_IBINSDA_")"
 W ! S DIR(0)="FO",DIR("A")="Enter 'E' to edit buffer data or Return to continue"
 D ^DIR K DIR I Y'="",$D(DIRUT) G CMPQ
 I Y'="","EEee"[Y D INSHELP^IBCNBEE,INS^IBCNBEE(IBBUFDA) G CEINS
 ;
CEGRP W @IOF
 I 'IBGRPDA W !,"No Insurance Group/Plan Selected for Comparison."
 I +IBGRPDA W !,?14,"Patient is "_$S(+IBPOLDA:"",1:"NOT ")_"a member of this Insurance Group/Plan",!
 W ! D GRP^IBCNBCD(IBBUFDA,IBGRPDA)
 S DIR("?")="The Buffer entry's Group/Plan data may be edited or Return advances the display to the Patient Policy data.",DIR("??")="^D HELP^IBCNBUH,WAIT^IBCNBUH,GRP^IBCNBCD("_IBBUFDA_","_IBGRPDA_")"
 W ! S DIR(0)="FO",DIR("A")="Enter 'E' to edit buffer data or Return to continue"
 D ^DIR K DIR I Y'="",$D(DIRUT) G CMPQ
 I Y'="","EEee"[Y D GRPHELP^IBCNBEE,GRP^IBCNBEE(IBBUFDA) G CEGRP
 ;
CEPOL W @IOF
 I 'IBPOLDA W !,"No Patient Policy Selected for Comparison."
 W ! D POLICY^IBCNBCD(IBBUFDA,IBPOLDA)
 S DIR("?")="The Buffer entry's Patient Policy data may be edited or return to the screen display.",DIR("??")="^D HELP^IBCNBUH,WAIT^IBCNBUH,POLICY^IBCNBCD("_IBBUFDA_","_IBPOLDA_")"
 W ! S DIR(0)="FO",DIR("A")="Enter 'E' to edit buffer data or Return to continue"
 D ^DIR K DIR I Y'="",$D(DIRUT) G CMPQ
 I Y'="","EEee"[Y D POLHELP^IBCNBEE,POLICY^IBCNBEE(IBBUFDA) G CEPOL
 ;
CELIG W @IOF
 W ! D ELIG^IBCNBCD(IBBUFDA,IBPOLDA)
 ;
CMPQ D CLEAN^VALM10,INIT^IBCNBLP,HDR^IBCNBLP S VALMBCK="R" D UPDLN^IBCNBLL(IBBUFDA,"EDITED")
 Q
 ;
VERIFY(IBBUFDA) ; verify a buffer entry
 ;
 N DIR,DIRUT,X,Y,IBX,IBY Q:'$G(IBBUFDA)
 D FULL^VALM1 S VALMBCK="R"
 W ! D DISPBUF^IBCNBU1(IBBUFDA)
 ;
 S IBX=$G(^IBA(355.33,IBBUFDA,0)),IBY="" I +$P(IBX,U,10) S IBY="Re-" W !!,"This entry already verified by ",$$EXPAND^IBTRE(355.33,.11,$P(IBX,U,11))," on ",$$FMTE^XLFDT($P(IBX,U,10)),"."
 ;
 S DIR("?")="Enter Yes if the coverage and information in this Buffer entry has been verified to be accurate." W !!
 S DIR(0)="YO",DIR("B")="N",DIR("A")=IBY_"Verify the coverage in this buffer entry"
 D ^DIR
 I Y=1 D
 . ; WCW - 04/11/2003 Clear out IIV Status when manually verified
 . D CLEAR^IBCNEUT4(IBBUFDA,.IIVERR,1) K IIVERR
 . K IBX S IBX(.1)="NOW",IBX(.11)=DUZ D EDITSTF^IBCNBES(IBBUFDA,.IBX)
 . D INIT^IBCNBLE,HDR^IBCNBLE S VALMBCK="R" D UPDLN^IBCNBLL(IBBUFDA,"EDITED") W "  Coverage Verified ..." H 2
 ;
 Q
 ;
REJECT(IBBUFDA,DIRUT) ; process a reject and then delete a buffer entry
 ; Output parameter DIRUT is optional and passed in by reference.  This
 ; variable will be defined if the user enters a leading up-arrow,
 ; times out, or enters a null response.  This is so the calling routine
 ; can detect if the user did something other than say Yes or No to
 ; this question.
 ;
 N DIR,X,Y,IBX Q:'$G(IBBUFDA)
 D FULL^VALM1 S VALMBCK="R"
 W ! D DISPBUF^IBCNBU1(IBBUFDA)
 W !!,"This action will delete all insurance and patient specific data from a buffer ",!,"entry without first saving that data to the insurance files, leaving a stub ",!,"entry for reporting purposes.",!
 ;
 S IBX=$G(^IBA(355.33,IBBUFDA,0)) I +$P(IBX,U,10) W !!,"This entry has been verified by ",$$EXPAND^IBTRE(355.33,.11,$P(IBX,U,11))," on ",$$FMTE^XLFDT($P(IBX,U,10)),".",!!
 ;
 S DIR("?")="Enter Yes to delete this buffer entry without saving any of it's data to the Insurance files."
 S DIR(0)="YO",DIR("B")="N",DIR("A")="Reject this buffer entry (delete without saving to Insurance files)"
 D ^DIR
 I $D(DIRUT) G REJX
 I Y=1 D REJECT^IBCNBAR(IBBUFDA) S VALMBCK="Q" D UPDLN^IBCNBLL(IBBUFDA,"REJECTED")
REJX ;
 Q
 ;
ACCEPT(IBBUFDA) ; process a buffer entry for acceptance
 ;
 Q:'$G(IBBUFDA)
 N IBDA,IBINSDA,IBGRPDA,IBPOLDA,IBACCEPT S IBACCEPT=0
 ;
 D FULL^VALM1
 ;
 S IBDA=$$SEL^IBCNBLA("IBCNBLPX")
 I $P(IBDA,U,4)'="",+$G(^IBA(355.33,+IBBUFDA,60))'=$P(IBDA,U,4) W !,"Buffer Patient doesn't match Policy Patient, can't continue." G ACCPTQ
 I +$P(IBDA,U,3),'$P(IBDA,U,2) W !!,"Error: the selected policy has no associated plan.  Can not continue." D WAIT^IBCNBUH G ACCPTQ
 ;
 S IBINSDA=+IBDA,IBGRPDA=+$P(IBDA,U,2),IBPOLDA=+$P(IBDA,U,3)
 S:'IBINSDA (IBGRPDA,IBPOLDA)=0 S:'IBGRPDA IBPOLDA=0
 ;
 I 'IBINSDA,'$D(^XUSEC("IB INSURANCE COMPANY ADD",DUZ)) D  G ACCPTQ
 . W !!,"Sorry, but you do not have the required privileges to add",!,"new Insurance Companies."
 . D WAIT^IBCNBUH
 ;
 S IBACCEPT=$$ACCEPT^IBCNBAA(IBBUFDA,IBINSDA,IBGRPDA,IBPOLDA)
 ;
ACCPTQ S VALMBCK="R" I +IBACCEPT S VALMBCK="Q" D UPDLN^IBCNBLL(IBBUFDA,"ACCEPTED")
 Q
 ;
RESP(BUFF) ; List Response Report for Trace # associated with this entry
 ; BUFF = buffer IEN
 N NG,IBRSP,IBSTR,IBTRC,STOP,IBCNERTN,POP,IBCNESPC
 ; Reset to Full Screen Mode
 D FULL^VALM1
 S NG=0
 I $G(BUFF)="" S NG=1
 I 'NG S IBRSP=$O(^IBCN(365,"AF",BUFF,"")) I IBRSP="" S NG=1
 I 'NG S IBSTR=$G(^IBCN(365,IBRSP,0)),IBTRC=$P(IBSTR,U,9) I IBTRC="" S NG=1
 I NG W !!,"This entry does not have an associated eIV response." D PAUSE^VALM1 G RESPX
 S STOP=0,IBCNERTN="IBCNERP1",IBCNESPC("TRCN")=IBTRC_U_IBRSP
 D R100^IBCNERP1
RESPX S VALMBCK="R"
 Q
INPTTR(FILE,FLD,X) ; Does value X pass input transform for file, field?
 N XCUTE
 S XCUTE=$$GET1^DID(FILE,FLD,,"INPUT TRANSFORM")
 X XCUTE
 Q $D(X)
