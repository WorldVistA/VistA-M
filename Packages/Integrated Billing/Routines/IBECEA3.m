IBECEA3 ;ALB/CPM - Cancel/Edit/Add... Add a Charge ;30-MAR-93
 ;;2.0;INTEGRATED BILLING;**7,57,52,132,150,153,166,156,167,176,198,188,183,202,240,312,402,454,563,614,618,646,651,656,663,677,678,682,728**;21-MAR-94;Build 14
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
ADD ; Add a Charge protocol
 N IBGMT,IBGMTR,IBUSNM,IBUC    ;IB*2.0*618 Add IBUSNM IB*2.0*646 Add IBUC
 N IBDUPIEN,IBDPDATA,IBDPXA,IBDPAMT,IBCONT,IBVST ; IB*2.0*678 added
 N IBCLDA,IBCLDY,IBCLEDT,IBCLST,IBCLSTDT,IBCLZ ;  IB*2.0*728
 ; Check for IB EDIT key.  If not present
 I '$$IBEDIT^IBECEA36 Q
 S (IBGMT,IBGMTR,IBUC)=0
 S IBCOMMIT=0,IBEXSTAT=$$RXST^IBARXEU(DFN,DT),IBCATC=$$BILST^DGMTUB(DFN),IBCVAEL=$$CVA^IBAUTL5(DFN),IBLTCST=$$LTCST^IBAECU(DFN,DT,1)
 ;I 'IBCVAEL,'IBCATC,'$G(IBRX),+IBEXSTAT<1 W !!,"This patient has never been Means Test billable." S VALMBCK="" D PAUSE^VALM1 G ADDQ1
 ;
 ; - clear screen and begin
 D CLOCK^IBAUTL3 I 'IBCLDA S (IBMED,IBCLDAY,IBCLDOL,IBCLDT)=0
 D HDR^IBECEAU("A D D")
 I IBY<0 D NODED^IBECEAU3 G ADDQ
 ;
 ; - ask for the charge type
 D CHTYP^IBECEA33 G:IBY<0 ADDQ
 ;
 ;***IB*2.0*618 change to add more Action Types to this list...
 ; Allow user to add an extra "co-payment" charge if the Action Type
 ; selected is an Outpatient FEE BASIS, CHOICE, CC or CCN charge type
 N IBAFEE
 S IBUSNM=$P($G(^IBE(350.1,+$G(IBATYP),0)),"^",8)
 I IBUSNM'="" D
 . I IBUSNM="FEE SERVICE/OUTPATIENT" S IBAFEE=IBATYP Q
 . I (IBUSNM["CC")!(IBUSNM["CHOICE") D 
 . . I (IBUSNM["OPT")!(IBUSNM["OUTPATIENT")!(IBUSNM["URGENT") S IBAFEE=IBATYP  ;IB*2.0*646  added URGENT 
 ;*** END IB*2.0*618 ***
 ;
 ; - process CHAMPVA charges
 I IBXA=6 D CHMPVA^IBECEA32 G ADDQ
 ;
 ; - process TRICARE charges
 I IBXA=7 D CUS^IBECEA35 G ADDQ
 ;
 ; - display MT billing clock data
 I IBXA=2,$P($G(^IBE(350.1,+IBATYP,0)),"^",8)'["NHCU",IBCLDAY>90 S IBMED=IBMED/2
 I IBXA=1,IBCLDAY>90 D MED^IBECEA34 G:IBY<0 ADDQ
 I "^1^2^3^"[("^"_IBXA_"^"),IBCLDA W !!,"  ** Active Billing Clock **   # Inpt Days: ",IBCLDAY,"    ",$$INPT^IBECEAU(IBCLDAY)," 90 days: $",+IBCLDOL,!
 ;
 ; - if LTC OPT (non-institutional) and CD display message of warning
 I IBXA=8,$$CDEXMPT^IBAECU(DFN,DT) W !!,"  ** Patient is currently Catastrophically Disabled",!
 ;
 ; - ask date, units and maybe tier for rx copay charge
 I IBXA=5 D  G ADDQ:IBY<0,PROC
 . N IBA,IBB,IBC,IBX
 . ;; IBREBILL array is defined in REBILL^IBECEA4
 . S IBLIM=DT D FR^IBECEAU2($S($G(IBREBILL("EVDT"))'="":IBREBILL("EVDT"),1:0)) Q:IBY<0  ; IB*2.0*682
 . S (IBTO,IBEFDT)=IBFR
 . ;
 . ;PRCA*4.5*338 - if Community Care RX copay, set event date
 . S IBEVDA="*",IBEVDT=IBEFDT
 . ;I (IBXA=5),(IBUSNM["RX"),((IBUSNM["CC")!(IBUSNM["CHOICE")) S IBEVDA="*",IBEVDT=IBEFDT
 . ;
 . ; ask tier if needed
 . S IBTIER=$$TIER^IBECEAU2(IBATYP,IBEFDT) Q:IBY<0
 . ;
 . ; ask units
 . D UNIT^IBECEAU2(0) Q:IBY<0
 . ;
 . ; has patient been previously tracked for cap info
 . D TRACK^IBARXMN(DFN)
 . ;
 . D CTBB^IBECEAU3
 . ;
 . ; check if above cap
 . I IBY'<0 D
 .. N IBB,IBN,DIR,DIRUT,DUOUT,DTOUT,X,Y
 .. D NEW^IBARXMC(1,IBCHG,IBFR,.IBB,.IBN) Q:'IBN
 .. ;
 .. ; display message ask to proceed
 .. W !!,"This charge will put the patient > $",$J(IBN,0,2)," above their cap amount."
 .. S DIR(0)="Y",DIR("A")="Okay to proceed" D ^DIR S:'Y IBY=-1
 .. ;
 S IBLIM=$S(IBXA=4!(IBXA=3):DT,1:$$FMADD^XLFDT(DT,-1))
 ;
FR ; - ask 'bill from' date
 D FR^IBECEAU2($S($G(IBREBILL("BILLFR"))'="":IBREBILL("BILLFR"),1:0))  ; IB*2.0*682
 ;
 ;IB*2.0*646/656
 ; If Urgent Care copay, skip clock checks, go to prompt for copay amount.
 I $G(IBUC),(IBFR<3190606) D  G ADDQ
 . W !!,"The Urgent Care Copayment/Mission Act legislation went into effect on 6/6/19. "
 . W !,"Dates of service prior to this date will need to be billed using other ",!,"outpatient copayment charges."
 G:$G(IBUC) UCPAY
 ; end IB*2.0*646/656
 ;
 ;
 S IBGMT=$$ISGMTPT^IBAGMT(DFN,IBFR),IBGMTR=0 ;GMT Copayment Status
 I IBGMT>0,IBXA>0,IBXA<4 W !,"The patient has GMT Copayment Status."
 ; - check the MT billing clock
 I IBXA'=8,IBXA'=9 D CLMSG^IBECEA33 G:IBY<0 ADDQ
 ;Adjust Deductible for GMT patient
 I IBGMT>0,IBXA>0,IBXA<4,$G(IBMED) S IBMED=$$REDUCE^IBAGMT(IBMED) W !,"Medicare Deductible reduced due to GMT Copayment Status ($",$J(IBMED,"",2),")."
 ;
 ; - check LTC non-institutional (opt) for CD exemption
 I IBXA=8,$$CDEXMPT^IBAECU(DFN,IBFR) W !,"Patient is LTC non-institutional exempt, Catastrophically Disabled" G ADDQ
 ;
 ; - check the LTC billing clock
 I IBXA>7,IBXA<10 D  I IBY<0 W !!,"The patient has no LTC clock active for this date.",! G ADDQ
 .; IB*2.0*728
 .; get the latest LTC clock
 .S (IBCLSTDT,IBCLEDT)=0,IBCLDA=$$FNDOPEN^IBAECU4(DFN)
 .I IBCLDA S IBCLZ=^IBA(351.81,IBCLDA,0),IBCLSTDT=$P(IBCLZ,U,3),IBCLEDT=$P(IBCLZ,U,4),IBCLDY=+$P(IBCLZ,U,6)
 .; is IBFR within date range of the LTC clock?
 .I IBFR<IBCLSTDT D  Q
 ..S IBCLSTDT=+$O(^IBA(351.81,"AE",DFN,IBFR),-1) I IBCLSTDT>0 D  Q  ; found a previous LTC clock, try to use this one
 ...S IBCLDA=+$O(^IBA(351.81,"AE",DFN,IBCLSTDT,""),-1) I 'IBCLDA S IBY=-1 Q
 ...S IBCLDY=+$P(^IBA(351.81,IBCLDA,0),U,6)
 ...W !!,"This charge will be applied to the following closed LTC clock:"
 ...W !,"Start Date: ",$$FMTE^XLFDT(IBCLSTDT),"  Free Days Remaining: ",IBCLDY
 ...I IBCLDY W !,"The patient must use his free days first." S IBY=-1 Q
 ...Q
 ..S IBY=-1
 ..Q
 .I IBFR>IBCLEDT D  Q
 ..; date of service if past exp.date of the clock - ask user if they want to open a new LTC clock
 ..I $$ASKLTC() S IBCLDA=$$OPTB^IBAECC(DFN,IBCLDA,IBCLEDT,IBFR) S:'IBCLDA IBY=-1 I IBY'<0,+$P(^IBA(351.81,IBCLDA,0),U,6) W !,"The patient must use his free days first." S IBY=-1 Q
 ..; user didn't want to open a new clock
 ..W !!,"The Open LTC Billing Clock detected for the patient has expired."
 ..W !,"Please Open a New Clock and apply any available Free Days before"
 ..W !,"continuing to charge this copayment.",!
 ..D ASKCONT^IBAECC W !
 ..Q
 .; we'll be using the current clock if we got here
 .W !!,"This charge will be applied to the following open LTC clock:"
 .W !,"Start Date: ",$$FMTE^XLFDT(IBCLSTDT),"  Free Days Remaining: ",IBCLDY
 .I IBCLDY W !,"The patient must use his free days first." S IBY=-1
 .Q
 I IBY<0 G ADDQ
 ; end IB*2.0*728
 ;
 ; - calculate the MT inpt copay charge
 I IBXA=2 S IBDT=IBFR D COPAY^IBAUTL2 G ADDQ:IBY<0 S:IBGMT>0 IBGMTR=1,IBCHG=$$REDUCE^IBAGMT(IBCHG) I IBCHG+IBCLDOL<IBMED W *7,"   ($",IBCHG,"/day)" W:IBGMTR " GMT Rate"
 ;
 ; - find the correct clock from the 'bill from' date (ignore LTC)
 I IBXA'=8,IBXA'=9,('IBCLDA!(IBCLDA&(IBFR<IBCLDT))) D NOCL^IBECEA33 G:IBY<0 ADDQ
 ;
UCPAY ;IB*2.0*646 Added to allow for skip of clock checks - required for Urgent Care Copays
 ; - perform outpatient edits
 N IBSTOPDA
 ;
 ;Start- IB*2.0*651
 ;Check to see if there is another medical copay (inpatient or outpatient) on that same day for this patient.
 ;If there is, print warning message to user and abort copay entry.
 ;I ((IBXA=4)!(IBXA=8)),$$BFCHK^IBECEAU(DFN,IBFR) D  G ADDQ
 ;. S IBVST=0
 ;. D PRTWRN  ;Print warning message
 ;. I IBUC D
 ;. . S IBVST=$$VSTCHK()
 ;. . I IBVST D ADDVST^IBECEA36(DFN,IBFR,"",4,5)
 ;end IB*2.0*651
 ;
 ;
 ;IB*2.0*678 Modified entire section to allow Dup Check to cancel existing lower copays or tell users they can't add a copay
 ;IB*2.0*663 Added changes for Urgent Care Visit Tracking
 I IBXA=4,IBUC D UCCHRG2^IBECEA36(DFN,IBFR) G ADDQ:IBY<0
 ;end IB*2.0*646
 ;
 I IBXA=4,'IBUC,$$CHKHRFS^IBAMTS3(DFN,IBFR,IBFR) W !!,"This patient is 'Exempt' from Outpatient Visit charges on that date of service.",! G ADDQ  ;IB*2.0*614 (no copayment if HRfS flag)
 I IBXA=4,'IBUC D  G ADDQ:IBY<0
 .   ;  for visits prior to 12/6/01 or FEE
 .   I IBFR<3011206!($G(IBAFEE)) D OPT^IBECEA33 Q
 .   ;  for visits on or after 12/5/01
 .   D OPT^IBEMTSCU
 ;
 S IBDUPIEN=0
 S IBDUPIEN=$$BFCHK^IBECEAU(DFN,IBFR)
 I (IBXA=4),IBDUPIEN D  G ADDQ:'IBCONT
 . S IBDPDATA=$$DUPINFO(IBDUPIEN),IBDPXA=$P(IBDPDATA,U,2),IBDPAMT=$P(IBDPDATA,U)
 . S IBCONT=0
 . I (IBDPXA'=4),(IBDPXA'=8) D PRTWRN Q
 . S IBVST=0
 . D PRTWRN  ;Print warning message
 . I IBCHG>IBDPAMT D  Q    ; The new Outpatient charge is greater than existing charge.
 . . S IBCONT=1
 . . I '$$CANDUP(IBDUPIEN) S IBCONT=0 Q
 . I IBUC D
 . . S IBVST=$$VSTCHK()
 . . I IBVST D ADDVST^IBECEA36(DFN,IBFR,"",4,5)
 ;
 ;If outpatient copay and has passed all other checks, go to PROC
 G:IBXA=4 PROC
 ;
 ;end IB*2.0*678
 ;
 ; - if LTC outpatient calculate the charge
 ;I IBXA=8 D  G:IBY<0 ADDQ S (IBDT,IBTO,IBEVDT)=IBFR,IBDESC=$P(^IBE(350.1,IBATYP,0),"^",8),IBUNIT=1,IBEVDA="*" D COST^IBAUTL2,CALC^IBAECO,CTBB^IBECEAU3 G @$S(IBCHG:"PROC",1:"ADDQ")
 I IBXA=8 D  G:IBY<0 ADDQ S (IBDT,IBTO,IBEVDT)=IBFR,IBDESC=$P(^IBE(350.1,IBATYP,0),"^",8),IBUNIT=1,IBEVDA="*" D COST^IBAUTL2,CALC^IBAECO,CTBB^IBECEAU3 G:'IBCHG ADDQ
 . ;
 . ; is this day already a free day
 . I $D(^IBA(351.81,IBCLDA,1,"AC",IBFR)) W !!,"This day is already marked as a Free Day." S IBY=-1
 . ;
 . ; have we already billed for this day  IB*2.0*678 - moved below.
 . ;I $$BFO^IBECEAU(DFN,IBFR) W !!,"This patient has already been billed for this date." S IBY=-1
 ;
 S IBCONT=0
 I IBXA=8 D  G:IBY<1 ADDQ
 . S IBY=1  ; assume no duplicate
 . S IBDUPIEN=$$BFCHK^IBECEAU(DFN,IBFR)
 . ; If so, either allow removal of duplicate or prevent user from continuing to bill
 . I IBDUPIEN D
 . . S IBY=0   ;Duplicate found
 . . ; Print Warning message
 . . D PRTWRN
 . . ; get Duplicate Bill info
 . . S IBDPDATA=$$DUPINFO(IBDUPIEN),IBDPXA=$P(IBDPDATA,U,2),IBDPAMT=$P(IBDPDATA,U)
 . . ; If an Inpatient Med, warn user and prevent further billing
 . . I (IBDPXA'=4),(IBDPXA'=8) S IBY=-1 Q
 . . ; If potential charge is greater than the amount already billed
 . . I IBCHG>IBDPAMT D
 . . . I '$$CANDUP(IBDUPIEN) S IBCONT=0 Q
 . . . S IBCONT=1
 ;
 G:IBXA=8 PROC
 ;
 ; - find per diem charge and description
 I IBXA=3 D  I 'IBCHG W !!,"Unable to determine the per diem rate.  Please check your rate table." G ADDQ
 .N IBDT S IBDT=IBFR,IBGMTR=0 D COST^IBAUTL2
 .I IBGMT>0 S IBGMTR=1,IBCHG=$$REDUCE^IBAGMT(IBCHG)
 .S IBDESC="" X:$D(^IBE(350.1,IBATYP,20)) ^(20)
 ;
 ; - calculate charge for the inpatient copay
 I IBXA=2,IBCHG+IBCLDOL'<IBMED S IBCHG=IBMED-IBCLDOL,IBUNIT=1,IBTO=IBFR D CTBB^IBECEAU3 G EV
 ;
TO ; - ask 'bill to' date
 D TO^IBECEAU2($S($G(IBREBILL("BILLTO"))'="":IBREBILL("BILLTO"),1:0)) G:IBY<0 ADDQ  ; IB*2.0*682
 ;
 ;Start- IB*2.0*651
 ;Check to see if there is another medical copay (inpatient or outpatient) on that same day for this patient.
 ;If there is, print warning message to user and abort copay entry.
 I ((IBXA<4)!(IBXA=9)) D  G:IBY<1 ADDQ
 . S IBDUPIEN=$$BFCHK^IBECEAU(DFN,IBFR)
 . ; If so, either allow removal of duplicate or prevent user from continuing to bill
 . S IBY=1
 . I IBDUPIEN D
 . . S IBY=0   ;Duplicate found
 . . ; Print Warning message
 . . D PRTWRN
 . . ; get Duplicate Bill info
 . . S IBDPDATA=$$DUPINFO(IBDUPIEN),IBDPXA=$P(IBDPDATA,U,2),IBDPAMT=$P(IBDPDATA,U)
 . . ; If an Inpatient Med, warn user and prevent further billing
 . . I (IBDPXA'=4),(IBDPXA'=8) S IBY=-1 Q
 . . ; Inpatient automatically forces outpatient copays to cancel
 . . I $$CANDUP(IBDUPIEN) S IBY=1 Q
 ;end IB*2.0*651
 ;end IB*2.0*678
 ;
 I IBXA>0,IBXA<4,IBGMT'=$$ISGMTPT^IBAGMT(DFN,IBTO) W !!,"The patient's GMT Copayment status changed within the specified period!",! G ADDQ
 ;
 ;- IB*2.0*663 - check for Free days used in this billing period
 I IBXA=9 D  G ADDQ:IBY<0
 . F IBFEDT=IBFR:1:IBTO I $D(^IBA(351.81,IBCLDA,1,"AC",IBFEDT)) W !!,"One or more of the days in this period is marked as a Free Day." S IBY=-1 Q
 ;end IB*2.0*663
 ;
 ; - calculate unit charge for LTC inpatient in IBCHG
 I IBXA=9 S IBDT=IBFR,IBEVDA=$$EVF^IBECEA31(DFN,IBFR,IBTO,IBNH),IBEVDT=$E(IBFR,1,5)_"01" D:IBEVDA<1  G ADDQ:IBY<0 D COST^IBAUTL2 I $E(IBFR,1,5)'=$E(IBTO,1,5) W !!,"  LTC Copayment charges cannot go from one month to another." G ADDQ
 . D NOEV^IBECEA31 I '$G(IBDG)!(IBY<0) S IBY=-1 Q
 . ; - build the event record
 . N IBNHLTC S IBNHLTC=1 D ADEV^IBECEA31
 ;
 ; - calculate units and total charge
 S IBUNIT=$$FMDIFF^XLFDT(IBTO,IBFR) S:IBXA'=3!(IBFR=IBTO) IBUNIT=IBUNIT+1
 I IBXA=1 D:IBGMT>0  D FEPR^IBECEA32 G ADDQ:IBY<0,EV
 . S IBGMTR=1
 . W !,"The patient has GMT Copayment Status! GMT rate must be applied.",!
 S IBCHG=IBCHG*IBUNIT S:IBXA=2 IBCHG=$S(IBCLDOL+IBCHG>IBMED:IBMED-IBCLDOL,1:IBCHG)
 ;
 ; adjust the LTC charge based on the calculated copay cap
 I IBXA=9 D CALC^IBAECI G:IBY<1!('IBCHG) ADDQ S IBDESC="LTC INPATIENT COPAY"
 ;
 D CTBB^IBECEAU3 W:IBXA=3!(IBXA=9) "  (for ",IBUNIT," day",$E("s",IBUNIT>1),")" W:IBGMTR " GMT Rate"
 ;
EV ; - find event record, or select admission for linkage
 I IBXA'=9 S IBEVDA=$$EVF^IBECEA31(DFN,IBFR,IBTO,IBNH)
 I IBEVDA'>0 D NOEV^IBECEA31 G ADDQ:IBY<0,PROC
 S IBSL=$P($G(^IB(+IBEVDA,0)),"^",4)
 W !!,"Linked charge to ",$$TYP(),"admission on ",$$DAT1^IBOUTL($P(IBEVDA,"^",2)),"  ("
 W $S($P(IBEVDA,"^",3)=9999999:"Still admitted)",1:"Discharged on "_$$DAT1^IBOUTL($P(IBEVDA,"^",3))_$S($P(IBEVDA,"^",3)>DT:" [pseudo])",1:")"))," ..."
 S IBEVDA=+IBEVDA
 I '$G(IBSIBC) D SPEC^IBECEA32(0,$O(^IBE(351.2,"AD",IBEVDA,0)))
 ;
 ;
PROC ; - okay to proceed?
 N IBRES,IBBILL  ; IB*2.0*682
 D PROC^IBECEAU4("add") G:IBY<0 ADDQ
 ;
 ; - build the event record first if necessary
 I $G(IBDG),IBXA'=9 D @("ADEV^IBECEA3"_$S($G(IBFEEV):4,1:1)) G:IBY<0 ADDQ
 ;
 ; - disposition the special inpatient billing case, if necessary
 I $G(IBSIBC) D CEA^IBAMTI1(IBSIBC,IBEVDA)
 ;
 ; - generate entry in file #354.71 (for VA RX only per IB*2.0*618) and #350
 I IBXA=5,(IBUSNM'["CC"),(IBUSNM'["CHOICE") W !!,"Building the new transaction...  " S IBAM=$$ADD^IBARXMN(DFN,"^^"_IBEFDT_"^^P^^"_IBUNIT_"^"_IBCHG_"^"_IBDESC_"^^"_IBCHG_"^0^"_IBSITE_"^^^^^^^"_$G(IBTIER)) G:IBAM<0 ADDQ
 D ADD^IBECEAU3 G:IBY<0 ADDQ W " done."
 ;
 ; - pass the charge off to AR on-line
 W !,"Passing the charge directly to Accounts Receivable... "
 D PASSCH^IBECEA22 W:IBY>0 " done." G:IBY<0 ADDQ   ;IB*2.0*663 added space before done to correct display issue.
 ;
 I IBUC D
 .; Handle re-billing  IB*2.0*682
 .I $G(IBREBILL("UC")) D  Q
 ..; get bill # or set it to "on hold" if bill status in file 350 = 8 (on hold)
 ..S IBBILL=$S($$GET1^DIQ(350,$G(IBN)_",",.05,"I")=8:"ON HOLD",1:$$GET1^DIQ(350,IBEVDA_",",.11,"E"))
 ..S IBRES=$$UPDATE^IBECEA38(IBREBILL("UC"),2,IBBILL,"",1,"IBRES")
 ..Q
 .;
 .D ADDVST^IBECEA36(DFN,IBFR,IBEVDA,2)
 .Q
 ;
 ; - review the special inpatient billing case
 I $G(IBSIBC1) D CHK^IBAMTI1(IBSIBC1,IBEVDA)
 ;
 ; - handle updating of clock
 I IBXA'=8,IBXA'=9,'IBUC D CLUPD^IBECEA32  ;IB*2.0*646
 ;
ADDQ ; - display error, rebuild list, and quit
 ; IB*2.0*682 skip list rebuild and killing of some variables if we're coming from ^IBECEA4 - it's done in 'Cancel charge' code
 I $G(IBREBILL("EVDT"))="" D
 .D ERR^IBECEAU4:IBY<0,PAUSE^IBECEAU S VALMBCK="R"
 .I IBCOMMIT S IBBG=VALMBG W !,"Rebuilding list of charges..." D ARRAY^IBECEA0 S VALMBG=IBBG
 .K IBCHG,IBDESC,IBIL,IBN,IBND,IBSEQNO,IBTOTL,IBUNIT,IBATYP,IBEVDA,IBXA,IBSL,IBFR,IBTO,IBNOS
 .Q
 ;
 K IBMED,IBCLDA,IBCLDT,IBCLDOL,IBCLDAY,IBDG,IBNH,IBBS,IBLIM,IBRTED,IBSIBC,IBSIBC1,IBBG,IBFEEV,IBAM
 K IBX,IBDT,IBEVDT,IBARTYP,IBTRAN,IBAFY,IBCVA,IBCLSF,IBDD,VADM,VA,VAERR,IBADJMED
ADDQ1 K IBEXSTAT,IBCATC,IBCVAEL,IBLTCST,IBTIER,IBEFDT,IBFEDT
 K:$G(IBREBILL("EVDT"))="" IBCOMMIT  ; IB*2.0*682
 Q
 ;
 ;
TYP() ; Return descriptive admission type.
 N X S X=""
 I IBNH'=2 G TYPQ
 I $G(IBADJMED) S X=$S(IBADJMED=1:"C",1:"H")
 E  S X=$S($P($G(^IBE(350.1,+IBATYP,0)),"^")["NHCU":"C",1:"H")
 S X=$S(X="C":"CNH ",1:"Contract Hospital ")
TYPQ Q X
 ;
 ;IB*2.0*651
PRTWRN ; Print warning message about medical copayment already applied 
 ;
 W !!!,"This patient has already been billed a medical copayment for this date."
 W !,"Please review the associated dates and charges for this patient.",!
 Q
 ;
 ;IB*2.0*678
VSTCHK()  ; Ask the user to see if they wish to update the UC Visit Tracking DB
 ;
 N DIR,DIRUT,DUOUT,X,Y,IBY
 W !
 S IBY=-1   ; Default exit value
 S DIR(0)="YA",DIR("A")="Do you want this Urgent Care visit added to the Visit Tracking Database?  : "
 D ^DIR
 W !     ;force a line feed between the messages
 Q:$D(DIRUT) IBY
 Q:$D(DUOUT) IBY
 Q:'Y Y       ; user selected No
 Q 1          ;Otherwise, the answer was yes
 ;
DUPINFO(IBIEN) ;Retrieve the needed information from the duplicate bill 
 ;Input - IEN of the Bill already charged on that date
 ;Output - Amount ^ Billing Group
 N IBDATA0,IBDPIEN,IBDPXA
 S IBDATA0=$G(^IB(IBIEN,0))
 S IBDPIEN=$P(IBDATA0,U,3)
 S IBDPXA=$$GET1^DIQ(350.1,IBDPIEN_",",.11,"I")
 Q $P(IBDATA0,U,7)_U_IBDPXA
 ;
CANDUP(IBN) ;Cancel the duplicate copay if the user wishes to.
 ;
 ;INPUT -   IBN - IEN for the Copay to be cancelled (File 350)
 ;OUTPUT -  0   - Didn't Cancel the copay
 ;          1   - Cancelled the Copay
 ;
 ;Display Duplicate Copay
 ;Get the info
 N IBCNRSLT,IBFRDT,IBTODT,IBACTY,IBSTCD,IBBLNM,IBSTAT,IBCHRG,IBI
 N DIR,DIRUT,DUOUT,X,Y,IBY
 S IBFRDT=$$GET1^DIQ(350,IBN_",",.14,"I")
 S IBFRDT=$$FMTE^XLFDT(IBFRDT,"2Z")
 S IBTODT=$$GET1^DIQ(350,IBN_",",.15,"I")
 S IBTODT=$$FMTE^XLFDT(IBTODT,"2Z")
 S IBACTY=$$GET1^DIQ(350,IBN_",",.03,"E")
 S IBSTCD=$$GET1^DIQ(350,IBN_",",.2,"E")
 S IBSTAT=$$GET1^DIQ(350,IBN_",",.05,"E")
 S IBBLNM=$$GET1^DIQ(350,IBN_",",.11,"E")
 S IBCHRG=$$GET1^DIQ(350,IBN_",",.07,"E")
 W !,"BILL",?10,"BILL",?40,"STOP",?45,"BILL",!
 W "FROM",?10," TO",?21,"CHARGE TYPE",?40,"CODE",?45,"NUMBER",?60,"STATUS",?70,"CHARGE",!
 F IBI=1:1:80 W "-"
 W !,IBFRDT,?10,IBTODT,?21,$E(IBACTY,1,17),?40,IBSTCD,?45,IBBLNM,?60,IBSTAT,?70,IBCHRG,!
 ;
 N DIR,DIRUT,DUOUT,X,Y,IBY
 W !     ;force a line feed between the messages
 S IBY=-1   ; Default exit value
 S DIR(0)="YA"
 S DIR("A",1)="Do you wish to cancel this existing copayment and continue billing the current",DIR("A")="copayment?  : "
 D ^DIR
 S IBY=+Y
 W !     ;force a line feed between the messages
 ;
 ;Quit if user does not answer yes.
 I +IBY<1 D  Q 0
 .W !,"The existing copayment was not cancelled. "
 .Q
 ; Cancel the copay.
 S IBCNRSLT=$$CANCAPI^IBECEA4(IBN)
 I +$G(IBCNRSLT)<0 D  Q 0
 .W !!,"The copayment was not cancelled."
 .Q
 W !!,"The copayment was cancelled.  Please continue adding the new copay."
 ;
 R !!,?10,"Press any key to continue.    ",IBX:DTIME
 ;
 Q 1
 ;
ASKLTC() ; LTC clock confirmation prompt IB*2.0*728
 ;
 ; returns 1 for "yes", or 0 otherwise
 ;
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT
 W !
 S DIR("A",1)="The Date of Service entered is beyond the end of the current clock."
 S DIR("A")="Do you wish to close this LTC clock and start a new LTC clock? (Y/N): "
 S DIR(0)="YAO"
 D ^DIR
 Q $S(+Y=1:1,1:0)
