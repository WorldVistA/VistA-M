IBECEA1 ;ALB/RLW - Cancel/Edit/Add... Action Entry Points ; Sep 30, 2020@15:16:44
 ;;2.0;INTEGRATED BILLING;**15,27,45,176,312,663,630**;21-MAR-94;Build 39
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
PASS ; 'Pass a Charge' Entry Action (added by Jim Moore 4/30/92)
 N C,IBII,IBNOS,IBND,IBMSG,IBY,IBLINE,IBSTAT,IBAFY,IBATYP,IBHLDR,IBERROR
 N IBARTYP,IBN,IBSEQNO,IBSERV,IBTOTL,IBTRAN,IBIL,IBNOS2,Y,IBXA,IBVSTIEN,IBEXCOPAY
 ;
 S VALMBCK="R" D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) I '$$PFSSWARN^IBBSHDWN() S VALMBCK="R" Q
 ;
 ; Start of IB*2.0*630 changes
 N IBDUPCPY S IBDUPCPY="" ; IB*2.0*630
 S IBII="" F  S IBII=$O(VALMY(IBII)) Q:'IBII  D  Q:IBDUPCPY
 . S IBY=1,IBLINE=^TMP("IBACM",$J,IBII,0)
 . S IBNOS2=+$P(^TMP("IBACMIDX",$J,IBII),"^",4)
 . ; Check for duplicate copay
 . S IBDUPCPY=$$DUPCPYCHK^IBECEA1(IBNOS2)
 . ; If duplicate copay exists, display message
 . I IBDUPCPY D  Q
 . . D FULL^VALM1
 . . D CPYDISPLAY^IBECEA1(IBNOS2,IBDUPCPY)
 . . ; Send user back to selection prompt if duplicate copays exist
 . . S VALMBCK="R"
 . . Q
 . Q
 ; If duplicate was found, return user to Action list
 Q:IBDUPCPY
 ; End of IB*2.0*630 changes
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
 Q:+$G(IBDUPCPY)>0  ; IB*2.0*630
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
 ;
 ; Beginning of IB*2.0*630 changes
DUPCPYCHK(IBIENS) ;
 ; Input: IBIENS = A single charge IEN to release or a series of charge IENs separated by commas
 ; Output: 0: No Duplicate Copay exists for the patient/date
 ;         #: IEN of the Duplicate Copay
 ; If the charge currently being released is a Copay charge, then check for duplicates
 ; All charges including ON HOLD Copay charges will be in the ACHDT x-ref
 N IBARY,IBDT,IBDUPCPY,IBIEN,IBPRTY
 ; Initialize Copay check to 0:No duplicate copay for Patient/Date
 S IBDUPCPY=0
 ; Prioritize charges in Y into IBARY array
 D IBARY(IBIENS,.IBARY)
 ; Quit if no entries in IBARY
 Q:'$D(IBARY) 0
 ; Loop through charges in IBARY by Date, Priority and IEN
 S IBDT=""
 F  S IBDT=$O(IBARY(IBDT)) Q:IBDT=""  D  Q:IBDUPCPY
 . S IBPRTY=""
 . F  S IBPRTY=$O(IBARY(IBDT,IBPRTY)) Q:'IBPRTY  D  Q:IBDUPCPY
 . . S IBIEN=""
 . . F  S IBIEN=$O(IBARY(IBDT,IBPRTY,IBIEN)) Q:'IBIEN  D  Q:IBDUPCPY
 . . . ; Check charge in IBARY against any existing charge in AR
 . . . S IBDUPCPY=$$COPAYCHK^IBAUTL8(DFN,IBIEN,1)
 . . . ; If a duplicate copay was found Quit
 . . . Q:IBDUPCPY
 . . Q
 . Q
 Q IBDUPCPY
 ;
IBARY(IBIENS,IBARY) ; Process user selection and save in IBARY ordered by priority
 ; IBARY will only contain the Copay related charges that need to be checked for duplicates.
 ; Input: Y = A single charge IEN to release or a series of charge IENs separated by commas
 ; IBARY = Array name passed by reference for return array.
 ; Output: IBARY(Date of Interest, Priority Index, IEN in "#350)=""
 N IBAT,IBDATA0,IBDT,IBINDX,IBIEN
 ; Loop through selected IENs
 F IBINDX=1:1 S IBIEN=$P(IBIENS,",",IBINDX) Q:IBIEN=""  D
 . S IBDATA0=$G(^IB(IBIEN,0))
 . Q:IBDATA0=""
 . ; Load ACTION TYPE (#.03)
 . S IBAT=$P(IBDATA0,U,3)
 . Q:IBAT=""
 . ; Load EVENT DATE (#.17)
 . S IBDT=$P(IBDATA0,U,17)
 . ; If EVENT DATE not defined, use DATE BILLED FROM (#.14)
 . I IBDT="" S IBAT=$P(IBDATA0,U,14)
 . Q:IBDT=""
 . ; Check prioritization Billing Group #1
 . I IBAT=130 S IBARY(IBDT,1,IBIEN)="" Q
 . ; Billing Group #2
 . I "^16^17^18^19^20^21^22^23^24^"[("^"_IBAT_"^") D  Q
 . . S IBARY(IBDT,2,IBIEN)=""
 . ; Billing Group #3
 . I "^45^48^133^"[("^"_IBAT_"^") D  Q
 . . S IBARY(IBDT,3,IBIEN)=""
 . ; Billing Group #4 - Outpatient Observation Copays have precedence over other copays in Billing Group #3
 . I IBAT=74 S IBARY(IBDT,4,IBIEN)="" Q
 . ; Billing Group #4 - Everything but Outpatient Observation Copays
 . I "^51^136^203^"[("^"_IBAT_"^") D  Q
 . . S IBARY(IBDT,5,IBIEN)=""
 . ; Billing Group #8
 . I "^89^92^95^105^108^"[("^"_IBAT_"^") D  Q
 . . S IBARY(IBDT,6,IBIEN)=""
 Q
 ;  
GETINFO(IBIEN) ; Display Duplicate Copay info to the user.
 ; IBIEN = Existing Copay already charged for Patient/Date
 N IBBIL,IBCSTOP,IBDATE,IBTCH,IBTEXT,IBTRN,IBATYP
 ; Get data in External format for charge being passed to AR
 S IBATYP=$$GET1^DIQ(350,IBIEN_",",".03","E") ; ACTION TYPE
 S IBATYP=$E(IBATYP,1,25)
 S IBTCH=$$GET1^DIQ(350,IBIEN_",",".07","E")  ; TOTAL CHARGE
 S IBBIL=$$GET1^DIQ(350,IBIEN_",",".11","E")  ; AR BILL NUMBER
 S IBTRN=$$GET1^DIQ(350,IBIEN_",",".12","E")  ; AR TRANSACTION NUMBER
 S IBCSTOP=$$GET1^DIQ(350,IBIEN_",",".2","E")  ; CLINIC STOP
 S IBCSTOP=$J(IBCSTOP,3)
 S IBDATE=$$GET1^DIQ(350,IBIEN_",",".17","I")  ; EVENT DATE
 I IBDATE="" S IBDATE=$$GET1^DIQ(350,IBIEN_",",".14","I") ; DATE BILLED FROM
 S IBDATE=$$FMTE^XLFDT(IBDATE,"2Z")
 S IBTEXT=IBDATE,$E(IBTEXT,10)=" "
 S IBTEXT=IBTEXT_IBATYP,$E(IBTEXT,37)=" "
 S IBTEXT=IBTEXT_IBCSTOP,$E(IBTEXT,44)="$"
 S IBTEXT=IBTEXT_$J(IBTCH,9,2),$E(IBTEXT,55)=" "
 S IBTEXT=IBTEXT_IBBIL,$E(IBTEXT,69)=" "
 S IBTEXT=IBTEXT_IBTRN
 Q IBTEXT
 ;
CPYDISPLAY(IBIEN1,IBIEN2) ; Display Duplicate Copay info to the user.
 ; Input: IBIEN1 - IEN of 1st charge - Currently in IB
 ;        IBIEN2 - IEN of 2nd charge - Could be in IB or AR
 ;
 ; Output: Info related to the duplicate charges
 ;
 Q:IBIEN1=""!(IBIEN2="")
 ; Get info to display
 N IBFLAG,IBTEXT1,IBTEXT2,IBTEXT3,IBTRANS
 S IBTEXT1=$$GETINFO^IBECEA1(IBIEN1)
 S IBTEXT2=$$GETINFO^IBECEA1(IBIEN2)
 S IBTEXT3=""
 ; Load AR TRANSACTION NUMBER of Duplicate Copay found
 S IBTRANS=$$GET1^DIQ(350,IBIEN2_",",".12","I")
 S IBFLAG=+IBTRANS
 ; For Inpatient copays, check for an existing Outpatient Observation copays
 ; and display that info if it exists.
 I $P(IBIEN2,U,2) S IBTEXT3=$$GETINFO^IBECEA1($P(IBIEN2,U,2))
 ;
 W !
 ; Display message if both charges are only in IB
 I 'IBFLAG D
 . W !,"There are ",$S(IBTEXT3'="":"three ",1:"two "),"On Hold copay charges in the selection you made for the same"
 . W !,"patient/date."
 . I IBTEXT3'="" D
 . . W !,"Also check the following Outpatient Observation charge."
 . W !!,"Date      Charge Type                Stop      Charge"
 ;
 ; Display message if the duplicate charge has already been passed AR
 I IBFLAG D
 . W !,"There are ",$S(IBTEXT3'="":"three ",1:"two "),"copay charges for this Patient/Date."
 . W !,"The first charge is currently On Hold, the second charge has already been"
 . W !,"passed to AR:"
 . I IBTEXT3'="" D
 . . W !,"Also check the following Outpatient Observation charge."
 . W !!,"Date      Charge Type                Stop      Charge  Bill          Transaction"
 ;
 ; Display info for the charges
 W !,"================================================================================"
 W !,IBTEXT1
 W !,IBTEXT2
 I IBTEXT3'="" W !,IBTEXT3
 ;
 W !!,"Please review these charges and determine what action(s) should be taken."
 D PAUSE
 Q
 ; End of IB*2.0*630 changes
