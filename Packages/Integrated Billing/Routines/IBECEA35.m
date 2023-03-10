IBECEA35 ;ALB/CPM - Cancel/Edit/Add... TRICARE Support ; 09-AUG-96
 ;;2.0;INTEGRATED BILLING;**52,240,361,715**;21-MAR-94;Build 25
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
CUS ; Process all TRICARE copayment charges.
 ;
 N X,IBCS,IBINS,IBPLAN,IBATYPN
 N IBDESC,IBDG,IBEVDA  ; IB*2.0*715
 ;
 ; - display TRICARE coverage
 S IBCS=$$CUS^IBACUS(DFN,DT)
 D DISP(DFN,IBCS)
 ;
 ; - collect parameters needed to create the charge
 ; IB*2.0*715
 S IBATYPN=$P($G(^IBE(350.1,IBATYP,0)),U),IBUNIT=1
 I IBATYPN["RX" D  G GO
 .S IBLIM=DT D FR^IBECEAU2(0),AMT^IBECEAU2:IBY>0
 .S IBDESC="TRICARE RX COPAY",(IBEVDT,IBEFDT)=IBFR
 .Q
 ;
 I IBATYPN["OPT" D  G GO
 .S IBLIM=DT D FR^IBECEAU2(0),AMT^IBECEAU2:IBY>0
 .S IBDESC="TRICARE OPT COPAY",(IBEVDT,IBTO)=IBFR,IBEVDA="*"
 I IBATYPN["INPT" D  G GO
 .; IB*2.0*715
 .S IBLIM=DT,IBDG=0 D FR^IBECEAU2(0) S IBTO=IBFR
 .S IBEVDA=$$EVF^IBECEA31(DFN,IBFR,IBTO,IBNH) S:IBEVDA>0 IBSL=$P($G(^IB(+IBEVDA,0)),U,4),(IBEVDT,IBFR)=$P($G(^IB(+IBEVDA,0)),U,17)
 .I IBEVDA'>0 D  Q:IBY'>0  S IBEVDA="*"
 ..D NOEV^IBECEA31
 ..I 'IBDG D
 ...W !!,"An admission was not available or not selected."
 ...W !,"This transaction has been cancelled."
 ...S IBY=-1
 ...Q
 ..S IBSL="405:"_+IBDG,(IBEVDT,IBFR)=$P(IBDG,U,2)
 ..Q
 .S IBDESC="TRICARE INPT COPAY"
 .D AMT^IBECEAU2 Q:IBY'>0
 .S IBTO=$$DIS^IBECEA31(IBSL),IBTO=$S(IBTO>DT:DT,1:IBTO)
 .Q
 ;
GO ; - bill the charge
 N IBATIEN,IBDUPARY,IBDUPIEN,IBDUPNM,Z
 I IBY<0 G CUSQ
 ; check for duplicates  IB*2.0*715
 I IBATYPN'["RX" S Z=$$BFCHK(DFN,IBFR,$S($G(IBTO)>0:IBTO,1:""),.IBDUPARY) D:Z
 .S IBY=0  ; duplicates found
 .W !!!,"TRICARE cost shares has already been billed for this patient during the",!," selected date range." ; print warning message
 .I $$DISPDUP(.IBDUPARY) S IBY=1  ; user wishes to continue
 .Q
 I IBY'>0 G CUSQ
 ;
 ; - okay to proceed?
 D PROC^IBECEAU4("add") I IBY<0 G CUSQ
 ;
 ; - create charge and pass to AR
 W !,"Billing the TRICARE patient copayment charge..."
 D ADD^IBECEAU3,AR^IBR:IBY>0 I IBY<0 G CUSQ
 ;
 S IBCOMMIT=1 W "completed."
 ;
CUSQ K IBCS
 Q
 ;
DISP(DFN,INS) ; Display TRICARE beneficiary insurance information.
 ;  Input:    DFN  --  Pointer to the patient in file #2
 ;            INS  --  Pointer to the patient policy in file #2.312
 ;
 I '$G(INS) W *7,!!,"Please note that this patient does not have active TRICARE coverage!",! G DISPQ
 ;
 N IBINS,IBINS3,IBPLAN,IBS S IBS=0
 S IBINS=$G(^DPT(DFN,.312,INS,0)),IBINS3=$G(^(3))
 S IBPLAN=$G(^IBA(355.3,+$P(IBINS,"^",18),0))
 W !!," TRICARE coverage for ",$P($G(^DPT(DFN,0)),"^"),":"
 W !!," Insured Person: ",$E($P(IBINS,"^",17),1,20)
 W ?42,"Company: ",$P($G(^DIC(36,+IBINS,0)),"^")
 W !," Effective Date: ",$$DAT1^IBOUTL($P(IBINS,"^",8))
 W ?40,"Plan Name: ",$P(IBPLAN,"^",3)
 W !,"Expiration Date: ",$$DAT1^IBOUTL($P(IBINS,"^",4))
 W ?38,"Plan Number: ",$P(IBPLAN,"^",4),!
 I $P(IBINS3,"^",2)]"" S IBS=1 W " Service Branch: ",$P($G(^DIC(23,+$P(IBINS3,"^",2),0)),"^")
 I $P(IBINS3,"^",3)]"" S IBS=1 W ?37,"Service Rank: ",$P(IBINS3,"^",3)
 W:IBS !
DISPQ Q
 ;
BFCHK(DFN,SDATE,EDATE,IBRES) ; check for duplicates  IB*2.0*715
 ;
 ; DFN   - patient DFN
 ; SDATE - Start Date of the Patient Visit (inpatient or outpatient)
 ; EDATE - (Optional) End Date of the Patient Visit (inpatient only)
 ; IBRES - array of results (passed by reference).
 ;           format is IBRES(ien)="", where ien is file 350 ien of a duplicate, populated only if at least one duplicate was found.
 ;
 ; returns: 0 if no duplicates were found, 1 otherwise
 ;
 N IBATYP,IBATYPN,IBATYPNM,IBGRP,IBFDT,IBL,IBLPDT,IBN,IBND,IBTDT
 I '$G(DFN)!'$G(SDATE) Q 0
 I $G(EDATE)="" S EDATE=SDATE  ; if no end date, assume 1 day length
 S IBLPDT=-$$FMADD^XLFDT(EDATE,,,,1)  ; set starting point for the lookup
 F  S IBLPDT=$O(^IB("AFDT",DFN,IBLPDT)) Q:'IBLPDT!(-IBLPDT<SDATE)  D
 .S IBN=0 F  S IBN=$O(^IB("AFDT",DFN,IBLPDT,IBN)) Q:'IBN  D
 ..S IBL=$$LAST^IBECEAU(+$P($G(^IB(IBN,0)),U,9)),IBND=$G(^IB(IBL,0)),IBFDT=$P(IBND,U,14),IBTDT=$P(IBND,U,15)
 ..I IBFDT="",IBTDT="" Q  ; this is a parent Admission VA/CC/LTC Record.  Does not Dup check.
 ..I EDATE<IBFDT Q        ; start date of the bill is after the end date of the copay being entered.
 ..I SDATE>IBTDT Q        ; start date of the copay being entered is after the end date of the bill.
 ..S IBATYP=$G(^IBE(350.1,+$P(IBND,U,3),0))     ; action type for the bill
 ..S IBATYPN=$G(^IBE(350.1,+$P(IBATYP,U,9),0))  ; associated new action type for the bill
 ..S IBATYPNM=$P(IBATYPN,U) ; new action type name
 ..S IBGRP=$P(IBATYPN,U,11) ; billing group for the bill (IBXA = billing group for copay being entered)
 ..; check for Tricare duplicates
 ..I IBXA=7 Q:IBGRP'=IBXA!(IBATYPNM["RX")  ; non-Tricare charge and Tricare RX are not duplicates
 ..I "^1^3^"[(U_$P(IBATYP,U,5)_U),"^1^2^3^4^8^20^"[(U_+$P(IBND,U,5)_U) S IBRES(IBN)=""
 ..Q
 .Q
 Q $S($D(IBRES):1,1:0)
 ;
DISPDUP(IBARY) ; Display list of duplicates and ask if the user wishes to continue.  IB*2.0*715
 ;
 ; IBARY - Array of duplicate iens in file 350. Format: IBARY(ien)="".
 ;
 ; returns: 1 if user wishes to continue with adding the copay, 0 otherwise
 ;
 N IBACTY,IBBLNM,IBCHRG,IBCNRSLT,IBFRDT,IBI,IBN,IBTODT,IENS
 N DIR,DIRUT,DUOUT,X,Y
 ;Display Duplicate Copays
 W !,"BILL",?10,"BILL",?45,"BILL",!,"FROM",?10," TO",?21,"CHARGE TYPE",?45,"NUMBER",?70,"CHARGE",!
 F IBI=1:1:80 W "-"
 S IBN=0 F  S IBN=$O(IBARY(IBN)) Q:'IBN  D
 .;Get the info
 .S IENS=IBN_","
 .S IBFRDT=$$FMTE^XLFDT($$GET1^DIQ(350,IENS,.14,"I"),"2Z")
 .S IBTODT=$$FMTE^XLFDT($$GET1^DIQ(350,IENS,.15,"I"),"2Z")
 .S IBACTY=$$GET1^DIQ(350,IENS,.03,"E")
 .S IBBLNM=$$GET1^DIQ(350,IENS,.11,"E")
 .S IBCHRG=$$GET1^DIQ(350,IENS,.07,"E")
 .W !,IBFRDT,?10,IBTODT,?21,$E(IBACTY,1,17),?45,IBBLNM,?70,IBCHRG
 .Q
 ;
 W !
 S DIR(0)="YA"
 S DIR("A")="Do you wish to continue processing this cost share as well (Y/N) ? "
 D ^DIR
 Q $S(+Y>0:1,1:0)
