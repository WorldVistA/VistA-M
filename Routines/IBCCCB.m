IBCCCB ;ALB/ARH - COPY BILL FOR COB ; 2/13/06 10:46am
 ;;2.0;INTEGRATED BILLING;**80,106,51,151,137,182,155,323,436**;21-MAR-94;Build 31
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Copy bill for COB w/out cancelling, update some flds
 ; Primary->Secondary->Tertiary
ASK ;
 S IBCBCOPY=1 ; flag that copy function entered thru Copy COB option
 ;
 D KVAR S IBCAN=2,IBU="UNSPECIFIED"
 ;
 S IBX=$$PB^IBJTU2 S:+IBX=2 IBIFN=$P(IBX,U,2) I +IBX=1 S DFN=$P(IBX,U,2),IBV=1,IBAC=5 D DATE^IBCB
 I '$G(IBIFN) G EXIT
 ;
 ; Restrict access to this process for REQUEST MRA bills in 2 Cases:
 ; 1. No MRA EOB's on File for bill
 I $P($G(^DGCR(399,IBIFN,0)),U,13)=2,'$$CHK^IBCEMU1(IBIFN) D  G ASK
 . W !!?4,"This bill is in a status of REQUEST MRA and it has No MRA EOB's"
 . W !?4,"on file.  Access to this bill is restricted."
 ;
 ; 2. At least one MRA EOB appears on the MRA management worklist
 I $P($G(^DGCR(399,IBIFN,0)),U,13)=2,$$MRAWL^IBCEMU2(IBIFN) D  G ASK
 . W !!?4,"This bill is in a status of REQUEST MRA and it does appear on the"
 . W !?4,"MRA Management Work List.  Please use the 'MRA Management Menu' options"
 . W !?4,"for all processing related to this bill."
 . Q
 ;
 ; If MRA is Activated and bill is in Entered/Not Reviewed status and current insurance Co. is WNR -->
 ; ask if user wants to continue
 I $$EDIACTV^IBCEF4(2),$P($G(^DGCR(399,IBIFN,0)),U,13)=1,$$MCRWNR^IBEFUNC(+$$CURR^IBCEF2(IBIFN)) D  I 'Y G ASK
 . W !!?4,"This bill is in a status of ENTERED/NOT REVIEWED and current payer is "
 . W !?4,"MEDICARE (WNR). No MRA has been requested for this bill."
 . S DIR(0)="YA",DIR("B")="NO",DIR("A")="    Are you sure you want to continue to process this bill?: "
 . D ^DIR K DIR
 ;
 ; Display related bills
 D DSPRB^IBCCCB0(IBIFN)
 ;
CHKB ; Entrypoint-COB processing via EDI's COB Mgmt
 ; Ask if final EOB was received for previous bill
 I '$$FINALEOB^IBCCCB0(IBIFN) S IBSECHK=1
 I $G(IBSECHK)=1,$$MCRONBIL^IBEFUNC(IBIFN) G EXIT
 ;
 ; Warn if previous bill not at least authorized
 I '$$MCRONBIL^IBEFUNC(IBIFN) I '$$COBOK^IBCCCB0(IBIFN) G EXIT
 ;
CHKB1 ; Entry point for Automatic/Silent COB Processing.
 ; No writes or reads can occur from this point forward if variable
 ; IBSILENT=1.  Any and all error messages should be processed with
 ; the ERROR procedure below.
 ;
 S IBX=$G(^DGCR(399,+IBIFN,0)),DFN=$P(IBX,U,2),IBDT=$P(IBX,U,3)\1,IBER=""
 I IBCAN>1 D NOPTF^IBCB2 I 'IBAC1 D NOPTF1^IBCB2 G ASK1
 ;
 F IBI=0,"S","U1","M","MP","M1" S IB(IBI)=$G(^DGCR(399,IBIFN,IBI))
 I IB(0)="" S IBER="Invalid Bill Number" D ERROR G ASK1
 ;
 ; check to see if the bill has been cancelled
 I $P(IB("S"),U,16),$P(IB("S"),U,17) D  G ASK1
 . N WHO
 . S IBER="This bill was cancelled on "
 . S IBER=IBER_$$FMTE^XLFDT($P(IB("S"),U,17),"1Z")_" by "
 . S WHO="UNSPECIFIED"
 . I $P(IB("S"),U,18) S WHO=$P($G(^VA(200,$P(IB("S"),U,18),0)),U,1)
 . S IBER=IBER_WHO_"."
 . D ERROR
 . Q
 ;
 S IBCOB=$$COB^IBCEF(IBIFN),IBCOBN=$TR(IBCOB,"PSTA","12")
 S IBMRAIO=+$$CURR^IBCEF2(IBIFN),IBMRAO=$$MCRWNR^IBEFUNC(IBMRAIO)
 S IBNMOLD=$S(IBCOB="P":"Primary",IBCOB="S":"Secondary",IBCOB="T":"Tertiary",IBCOB="A":"Patient",1:"")_$S(IBMRAO:"-MRA Only",1:"")
 S IBINSOLD=$G(^DIC(36,$S(IB("MP"):+IB("MP"),IBMRAO:IBMRAIO,1:0),0))
 ;
NEXTP ; If current bill=MEDICARE WNR and valid 'next payer', use same
 ;  bill for new payer
 ; If next valid 'payer' is ins co or MEDICARE WNR, create new bill
 S IBCOBN=IBCOBN+1,IBNM=$S(IBCOBN=2:"Secondary Payer",IBCOBN=3:"Tertiary Payer",1:"")
 ;
 I IBNM="" S IBER=$P(IB(0),U,1)_" is a "_IBNMOLD_" bill, there is no next bill in the series." D ERROR G ASK1
 ;
 S IBX=+$P(IB("M1"),U,(4+IBCOBN)),IBY=$G(^DGCR(399,+IBX,0)),IBCOBIL(+IBIFN)=""
 ;
 I $P(IBY,U,13)=7 S IBER="The "_$P(IBNM," ",1)_" bill "_$P(IBY,U,1)_" has been cancelled." D ERROR S IBX=""
 ;
 I +IBX,$D(IBCOBIL(+IBX)) S IBER="Next bill in series can not be determined." D ERROR G ASK1
 I +IBX S IBER=$P(IBNM," ",1)_" bill already defined for this series: "_$P(IBY,U,1) D ERROR S IBIFN=IBX G ASK1
 ;
 S IBINSN=$P(IB("M"),U,IBCOBN) I 'IBINSN S IBER="There is no "_IBNM_" for "_$P(IB(0),U,1)_"." D ERROR G ASK1
 S IBINS=$G(^DIC(36,+IBINSN,0)) I IBINS="" S IBER="The "_IBNM_" for "_$P(IB(0),U,1)_" is not a valid Insurance Co." D ERROR G ASK1
 ;
 S IBMRA=0
 I $P(IBINS,U,2)="N" S IBQ=0 D  G:IBQ NEXTP
 . I $$MCRWNR^IBEFUNC(IBINSN) D  Q
 .. ; Check if a valid tert ins if MCR WNR secondary
 .. I IBCOBN'>2 D
 ... N Z
 ... S Z=+$P(IB("M"),U,IBCOBN+1)
 ... I Z,$D(^DIC(36,Z,0)),$P(^(0),U,2)'="N" S IBMRA=1,IBNM=$P(IBNM," ")_"-MRA.Only"
 .. I 'IBMRA S IBER="MEDICARE will not reimburse and no further valid insurance for bill" D ERROR S IBQ=1
 . S IBER=$P(IB(0),U,1)_" "_IBNM_", "_$P(IBINS,U,1)_", will not Reimburse" D ERROR S IBQ=1
 ;
 ; If processing in silent mode, skip over the following reads
 I $G(IBSILENT) G SKIP
 ;
 W !!
 S DIR("?")="Enter Yes to "_$S('$G(IBMRAO):"create a new bill in the bill series for this care.  The new bill will be the "_$P(IBNM," ")_" bill ",1:"enter the MRA information and change the payer to the "_$P($P(IBNM,"-")," ")_" payer ")
 S DIR("?")=DIR("?")_$S('IBMRA:"with the "_IBNM_" responsible for payment.",1:"and will request an MRA from MEDICARE.")
 S DIR(0)="YO",DIR("A")=$S('$G(IBMRAO):"Copy "_$P(IB(0),U,1)_" for a bill to the ",1:"Change payer on bill "_$P(IB(0),U,1)_" to ")_IBNM_", "_$P(IBINS,U,1) D ^DIR K DIR I Y'=1 S IBSECHK=1 G ASK1
 ;
 W !
 S IBQ=0
 I '$G(IBMRAO) D  G:IBQ ASK1
 . N Z
 . S DIR("?")="Enter the amount of the payment from the payer of the "_IBNMOLD_" bill."
 . S DIR("?")=DIR("?")_"  This will be added to the new bill as a prior payment and subtracted from the charges due for the new bill."
 . S DIR("A")="Prior Payment from "_$P(IB(0),U,1)_" "_IBNMOLD_" Payer, "_$P(IBINSOLD,U,1)_": "
 . S Z=$$EOBTOT^IBCEU1(IBIFN,$$COBN^IBCEF(IBIFN))
 . S:Z DIR("B")=Z
 . S DIR(0)="NOA^0:99999999:2"
 . D ^DIR K DIR I Y=""!$D(DIRUT) S IBQ=1
 . K IBCOB
 . S IBCOB("U2",IBCOBN+2)=Y
 . Q
 ;
SKIP ; Jump here if skipping over the preceeding reads
 ;
 ;** start IB*2*436 **
 ;
 ;IB2INSNO = Secondary Insurance Number - IEN 
 ;IBGRPNO  = Group Insurance Number     - IEN 
 ;IBTYNAME = TYPE OF PLAN name          - for example: MEDIGAP (SUPPLEMENTAL)
 ;IBTYPLAN = TYPE OF PLAN               - IEN
 ;IBPNCAT  = Plan category              - Part A or B
 ;IBMDGFL  = Medigap Supplemental Flag
 ;IBFRMTYP = Form type
 ;
 N IB2INSNO,IBGRPNO,IBMDGPFL,IBTYNAME,IBTYPLAN,IBINPAT,IBPNCAT,IBFRMTYP
 S (IB2INSNO,IBGRPNO,IBTYNAME,IBTYPLAN,IBPNCAT,IBFRMTYP)=""
 S IBMDGPFL=0
 ;
 ; Get secondary insurance information
 I $D(^DGCR(399,IBIFN,"M")) D
 . S IB2INSNO=+$P($G(^DGCR(399,IBIFN,"M")),U,2)  ; secondary insurance
 . S IBGRPNO=+$P($G(^DGCR(399,IBIFN,"I2")),U,18) ; group plan number
 . S IBTYPLAN=+$P($G(^IBA(355.3,IBGRPNO,0)),U,9) ; type of plan - IEN
 . I (IBTYPLAN=0)!(IB2INSNO=0)!(IBGRPNO=0) Q
 . S IBTYNAME=$P($G(^IBE(355.1,IBTYPLAN,0)),U,1) ; type of plan - name
 . I IBTYNAME="MEDIGAP (SUPPLEMENTAL)" S IBMDGPFL=1 Q 
 ;
 S IBFRMTYP=$P($G(^DGCR(399,IBIFN,0)),U,19)  ; Form Type 2=1500, 3=UB
 S IBPNCAT=$S(IBFRMTYP=2:"B",1:"A")    ; plan category - PART A or B
 ;
 ;
 ; If payer is Medicare (WNR) update payer sequence and quit
 I IBMRAO D  G END
 . N IBPRTOT,IBTOTCHG,IBPTRESP
 . S IBTOTCHG=0
 . ;
 . ; Get Total Charges from BILLS/CLAIMS (#399) file
 . S IBTOTCHG=$P($G(^DGCR(399,IBIFN,"U1")),U,1)
 . ;
 . ; Calculate Patient Responsibility for Bill
 . S IBPTRESP=$$PREOBTOT^IBCEU0(IBIFN)
 . S IBINPAT=$$INPAT^IBCEF(IBIFN)     ;Inpat/Outpat Flag
 . ;
 . ; Process inpatients (see IB*2*436 RSD/flow chart for details)
 . I IBINPAT D
 . . I IBPNCAT="A" D  ; Plan type is A  (institutional claim)
 . . . ;patient responsibility
 . . . S IBPRTOT=IBTOTCHG-IBPTRESP
 . . I IBPNCAT'="A" D   ; Other plan type   (Part B, professional claim)
 . . . I 'IBMDGPFL D  ; Not MEDIGAP (SUPPLEMENTAL)
 . . . . ;patient responsibility + Medicare unallowed amount (aka Medicare contr. adj.)
 . . . . S IBPRTOT=IBTOTCHG-(IBPTRESP+$$MRACALC2^IBCEMU2(IBIFN))
 . . . I IBMDGPFL D  ; MEDIGAP (SUPPLEMENTAL)
 . . . . ;patient responsibility
 . . . . S IBPRTOT=IBTOTCHG-IBPTRESP
 . ;
 . ; Process outpatients (see IB*2*436 RSD/flow chart for details)
 . I 'IBINPAT  D  ; Outpatient processing
 . . I IBMDGPFL D  ; MEDIGAP (SUPPLEMENTAL)
 . . . ;patient responsibility
 . . . S IBPRTOT=IBTOTCHG-IBPTRESP
 . . I 'IBMDGPFL  D  ; Not MEDIGAP (SUPPLEMENTAL) 
 . . . ;patient responsibility + Medicare unallowed amount (aka Medicare contr. adj.)
 . . . S IBPRTOT=IBTOTCHG-(IBPTRESP+$$MRACALC2^IBCEMU2(IBIFN))
 . ;
 . ; ** End IB*2*436 **
 . ;
 . I IBPRTOT<0 S IBPRTOT=0      ; don't allow negative prior payment or offset
 . S IBCOB("U2",IBCOBN+2)=IBPRTOT
 . D COBCHG^IBCCC2(IBIFN,IBMRAIO,.IBCOB)
 . D STAT^IBCEMU2(IBIFN,1.5,1)     ; mra eob status update
 . I $G(IBSILENT) S IBERRMSG=""
 . Q
 ;
 ; We should NOT get to here in silent mode .... just in case
 I $G(IBSILENT) G END    ; currently only MCRWNR in silent mode
 ;
 ; Payer is not Medicare (WNR) - Perform additional steps
 S IBCOB(0,15)=""
 S IBCOB(0,21)=$S(IBCOBN=2:"S",IBCOBN=3:"T",1:"")
 I IBCOB(0,21)="" G END
 S IBCOB("M1",IBCOBN+3)=IBIFN
 S IBIDS(.15)=IBIFN
 D KVAR
 G STEP2^IBCCC
 ;
END ;
 Q
 ;
 ;
ASK1 ; If entering thru EDI COB processing, don't ask for new bill, quit
 I $G(IBCBASK) G EXIT
 G ASK
 ;
ERROR ; Display/Save error message
 I '$G(IBSILENT) W !,IBER,!
 E  S IBERRMSG=IBER
 S IBER=""
 I $D(IBSECHK) S IBSECHK=1
 Q
 ;
EXIT K IBCAN,IBCOB,IBU
KVAR K IBX,IBY,IBI,IBIFN,DFN,IBDT,IB,IBCOBN,IBNMOLD,IBINSOLD,IBNM,IBINSN,IBINS,IBER,DIR,IBAC,IBAC1,IBV,X,Y,IBDATA,IBT,IBND0,DIRUT,IBCOBIL,IBMRA,IBMRAI,IBMRAO,IBMRAIO,IBCBCOPY
 K ^UTILITY($J)
 Q
 ;
DSPRB(IBIFN) ; display related bills
 ;
 D DSPRB^IBCCCB0(IBIFN) ; Code moved for size too big
 Q
 ;
 ; ==============
 ; 
 ; Copy a bill for Reasonable Charges without cancelling it, update certain fields
 ;
 ; there is always both inpt inst (created first) and prof charges, always need both bills
 ; there may be both outpt inst (created first) and prof charges, may not need both bills
 ; if billing by episode rather than by day (current standard) then may need multiple prof bills per day
 ; 
 ; Inst bills are copied to create prof Bills automatically
 ; Subsequent prof bills may be created if the user wants them
 ;
 ; Only the first bill in the COB series of bills should be copied for the next prof bill
 ; The primary inst bill should be copied to get the secondary inst bill
 ; The primary prof bill should be copied to get the secondary prof bill
 ;
CTCOPY(IBIFN,IBMRA) ; based on the type of bill, copy without cancelling
 ; IBMRA = 1 if an MRA bill and copy for prof components is desired
 ;
 D CTCOPY^IBCCCB0(IBIFN,$G(IBMRA)) ;Moved due to routine size
 Q
 ;
