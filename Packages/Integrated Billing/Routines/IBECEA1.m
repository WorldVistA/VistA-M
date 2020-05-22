IBECEA1 ;ALB/RLW-Cancel/Edit/Add... Action Entry Points ; 12-JUN-92
 ;;2.0;INTEGRATED BILLING;**15,27,45,176,312,663**;21-MAR-94;Build 27
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
PASS ; 'Pass a Charge' Entry Action (added by Jim Moore 4/30/92)
 N C,IBII,IBNOS,IBND,IBMSG,IBY,IBLINE,IBSTAT,IBAFY,IBATYP,IBHLDR,IBERROR
 N IBARTYP,IBN,IBSEQNO,IBSERV,IBTOTL,IBTRAN,IBIL,IBNOS2,Y,IBXA,IBVSTIEN
 ;
 S VALMBCK="R" D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) I '$$PFSSWARN^IBBSHDWN() S VALMBCK="R" Q
 ;
 S IBII="" F  S IBII=$O(VALMY(IBII)) Q:'IBII  D  L -^IB(IBNOS2) D MSG
 .S IBY=1,IBLINE=^TMP("IBACM",$J,IBII,0)
 .S (IBNOS,IBNOS2)=+$P(^TMP("IBACMIDX",$J,IBII),"^",4)
 .;
 .; - perform up-front edits
 .L +^IB(IBNOS2):5 I '$T S IBMSG="was not passed - record not available, please try again" Q
 .S IBND=$G(^IB(IBNOS2,0)) I IBND="" S IBMSG="was not passed - record missing the zeroth node" Q
 .I $P(IBND,"^",12) S IBMSG="was not passed - the charge already has an AR Transaction Number" Q
 .S IBSTAT=+$P(IBND,"^",5) I $P($G(^IBE(350.21,IBSTAT,0)),"^",4) S IBMSG="was not passed - the status indicates that the charge is billed" Q
 .I $P(IBND,"^",7)'>0 S IBMSG="was not passed - there is no charge amount" Q
 .S IBSEQNO=$P($G(^IBE(350.1,+$P(IBND,"^",3),0)),"^",5) I 'IBSEQNO S IBMSG="was not passed (Bulletin will be generated)",IBY="-1^IB023" Q
 .I $P($G(^IBE(350.1,+$P(IBND,"^",3),0)),"^",11)=6 S IBMSG="was not passed - CHAMPVA charges must be cancelled and rebilled" Q
 .S IBHLDR=(IBSTAT=21)
 .; - pass charge to AR and update list
 .D ^IBR S IBY=$G(Y)
 .S IBND=$G(^IB(IBNOS2,0))
 .S (IBSTAT,Y)=$P(IBND,"^",5),C=$P($G(^DD(350,.05,0)),"^",2) D Y^DIQ
 .S IBLINE=$$SETSTR^VALM1(Y,IBLINE,+$P(VALMDDF("STATUS"),"^",2),+$P(VALMDDF("STATUS"),"^",3))
 .S IBLINE=$$SETSTR^VALM1($P($P(IBND,"^",11),"-",2),IBLINE,+$P(VALMDDF("BILL#"),"^",2),+$P(VALMDDF("BILL#"),"^",3))
 .S ^TMP("IBACM",$J,IBII,0)=IBLINE
 .S IBMSG=$S(+IBY=-1:"was not passed -",IBSTAT=8:"has now been placed ON HOLD",1:"has now been passed")
 .;
 .;IB*2.0*663 If charge successfully passed, extract the bill number and update the visit tracking database if this is a CC URGENT CARE Charge
 .I $P(IBND,U,11)'="",$P($G(^IBE(350.1,+$P(IBND,"^",3),0)),"^")["CC URGENT CARE" D
 .. ; send update to the Visit Tracking file.
 .. S IBVSTIEN=$$FNDVST^IBECEA4("ON HOLD",$P(IBND,U,14),$P(IBND,U,2))
 .. ;ADD THE NOT FOUND MESSAGE HERE?
 .. D:+IBVSTIEN UPDATE^IBECEA38(IBVSTIEN,2,$P(IBND,U,11),"",1,.IBERROR)
 .; - if there is no active billing clock, add one
 .;   added check for LTC, don't do this for LTC
 .S IBXA=$P($G(^IBE(350.1,+$P(IBND,"^",3),0)),"^",11)
 .I $P(IBND,"^",14),'$P($G(^IB(IBNOS2,1)),"^",5),'$D(^IBE(351,"ACT",DFN)),IBXA'=8,IBXA'=9 D
 ..W !,"This patient has no active billing clock.  Adding a new one... "
 ..S IBCLDT=$P(IBND,"^",14)
 ..I '$D(IBSERV) D SERV^IBAUTL2
 ..D CLADD^IBAUTL3 W $S(IBY>0:"done.",1:"error (see msg)")
 .;
 .; - if charge was on hold pending review, pass data to IVM
 .I IBHLDR W !,"Passing billing data to the IVM package...  " D IVM^IBAMTV32(IBND) W "done."
 Q
 ;
MSG ; Display results message.
 W !,"Charge #"_IBII_" "_IBMSG I +IBY=-1 D ^IBAERR1
 W ! S DIR(0)="E" D ^DIR K DIR W !
 Q
 ;
 ;
ADD ; 'Add a Charge' Entry Action
 I '$$PFSSWARN^IBBSHDWN() S VALMBCK="R" Q                   ;IB*2.0*312
 G ^IBECEA3
 ;
UPD ; 'Edit a Charge' Entry Action
 S IBAUPD=1
 ;
CAN ; 'Cancel a Charge' Entry Action
 D EN^VALM2(IBNOD(0)) I '$O(VALMY(0)) S VALMBCK="" G CANQ
 I $G(IBAUPD) I '$$PFSSWARN^IBBSHDWN() S VALMBCK="R" Q       ;IB*2.0*312
 ;
 S (IBNBR,IBCOMMIT)=0,VALMBCK="R"
 F  S IBNBR=$O(VALMY(IBNBR)) Q:'IBNBR  D ^@$S($G(IBAUPD):"IBECEA2",1:"IBECEA4")
 I IBCOMMIT S IBBG=VALMBG W !,"Rebuilding list of charges..." D ARRAY^IBECEA0 S VALMBG=IBBG
 K IBBG,IBNBR,IBAUPD,IBCOMMIT
CANQ Q
 ;
PAUSE ; Keep this around for awhile.
 W ! S DIR(0)="E" D ^DIR K DIR W !
 Q
