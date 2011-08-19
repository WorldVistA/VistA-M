IBEFURF ;ALB/ARH - UTILITY: FIND RELATED FIRST PARTY BILLS ; 3/7/00
 ;;2.0;INTEGRATED BILLING;**130,347**;21-MAR-94;Build 24
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; the following procedures search for First Party charges for specific events, matchs are returned in TMP
 ; only a single record of a charge event is returned, defining the charges current status, although there may 
 ; have been cancellations or updates to the original charge
 ;    o Inpatient Events may have multiple charge events (Copay and Per Diem)
 ;    o Opt and Rx Events have only a single charge event (Copay)
 ; 
 ; ^TMP("IBRBF",$J, XRF, charge ifn) = 
 ; BILL FROM ^ BILL TO ^ CANCELLED? (1/0)^ AR BILL NUMBER ^ TOTAL CHARGE ^ ACTION TYPE (SHORT) ^ # DAYS ON HOLD
 ;
FPINPT(DFN,ADMDT,XRF) ; given a patient and admission date, find any Inpatient Charges
 ; find the record of the Event (based on Event Date) then find all charges with that Event as the Parent Event
 N IBFPIFN,IBEVDT,IBEVIFN,IB0 S ADMDT=+$G(ADMDT)\1
 I +$G(DFN),+$G(ADMDT) S IBEVDT=-(ADMDT+.01) F  S IBEVDT=$O(^IB("AFDT",DFN,IBEVDT)) Q:'IBEVDT!(-IBEVDT<ADMDT)  D
 . S IBEVIFN=0 F  S IBEVIFN=$O(^IB("AFDT",DFN,IBEVDT,IBEVIFN)) Q:'IBEVIFN  D
 .. S IBFPIFN=0 F  S IBFPIFN=$O(^IB("AF",IBEVIFN,IBFPIFN)) Q:'IBFPIFN  D
 ... S IB0=$G(^IB(IBFPIFN,0)) Q:IB0=""  I $P($G(^IBE(350.1,+$P(IB0,U,3),0)),U,1)["OPT" Q
 ... D FPONE(IBFPIFN,$G(XRF))
 Q
 ;
FPOPV(DFN,DT1,DT2,XRF) ; given a patient and date range, find any Outpatient Charges
 ; find all records where the Event Date is within the selected date range and the charge is Outpatient
 N IBFPIFN,IBEVDT,IB0 I '$G(DT2) S DT2=+$G(DT1)
 I +$G(DFN),+$G(DT1) S IBEVDT=-(DT2+.01) F  S IBEVDT=$O(^IB("AFDT",DFN,IBEVDT)) Q:'IBEVDT!(-IBEVDT<DT1)  D
 . S IBFPIFN=0 F  S IBFPIFN=$O(^IB("AFDT",DFN,IBEVDT,IBFPIFN)) Q:'IBFPIFN  D
 .. S IB0=$G(^IB(IBFPIFN,0)) Q:IB0=""  I $P($G(^IBE(350.1,+$P(IB0,U,3),0)),U,1)'["OPT" Q
 .. D FPONE(IBFPIFN,$G(XRF))
 Q
 ;
FPRX(RXIFN,FILLDT,XRF) ; given the prescription ifn (52) and the fill date, find any First Party charges
 ; get specific charge entry for an Rx from the Prescription file (52,106 and 52,52,9)
 N IBFPIFN,IBFILLN,DFN S IBFPIFN=""
 I '+$G(RXIFN) Q
 I '+$G(FILLDT) Q
 S DFN=$$FILE^IBRXUTL(RXIFN,2) Q:'DFN
 I $$FILE^IBRXUTL(RXIFN,22)=$G(FILLDT) D
 . S IBFPIFN=+$P($$IBND^IBRXUTL(DFN,RXIFN),"^",2)
 . D FPONE(IBFPIFN,$G(XRF))
 E  D
 . S IBFILLN=$$RFLNUM^IBRXUTL(RXIFN,FILLDT)
 . S IBFPIFN=+$$IBNDFL^IBRXUTL(DFN,RXIFN,IBFILLN)
 . D FPONE(IBFPIFN,$G(XRF))
 Q
 ;
FPONE(FPIFN,XRF) ; for a FP charge entry get the one line item that defines the entire events charge(s)
 ; get the Parent Charge then use the last charge entry as the current record for the event
 N IBPARENT,IBLAST,IBDATA Q:'$G(FPIFN)
 ;
 S IBPARENT=+$P($G(^IB(+FPIFN,0)),U,9) Q:'IBPARENT
 S IBLAST=+$$LAST^IBECEAU(IBPARENT) Q:'IBLAST
 ;
 I '$$DONE(IBLAST,$G(XRF)) S IBDATA=$$LN2(IBLAST) D SAVELN2(IBLAST,IBDATA,$G(XRF))
 Q
 ;
 ; ========================================================================================
 ;
DONE(FPIFN,XRF) ; return true if item charge (last) is already included
 N IBX S IBX="" S XRF=$S($G(XRF)="":"FP",1:XRF) I +$G(FPIFN),$D(^TMP("IBRBF",$J,XRF,+FPIFN)) S IBX=1
 Q IBX
 ;
SAVELN1(XRF,DATA) ; set charges found into array, ^TMP("IBRBF",$J,XRF) = DATA
 S XRF=$S($G(XRF)="":"FP",1:XRF),^TMP("IBRBF",$J,XRF)=$G(DATA)
 Q
 ;
SAVELN2(FPIFN,DATA,XRF) ; set charges found into array, ^TMP("IBRBF",$J,XRF,charge ifn) = DATA (from $$LN2)
 I +$G(FPIFN),$D(^IB(+FPIFN,0)) S XRF=$S($G(XRF)="":"FP",1:XRF),^TMP("IBRBF",$J,XRF,+FPIFN)=$G(DATA)
 Q
 ;
LN2(FPIFN) ; return data for a specific First Party Bill:
 ; BILL FROM ^ BILL TO ^ CANCELLED? (1/0)^ AR BILL NUMBER ^ TOTAL CHARGE ^ ACTION TYPE (SHORT) ^ # DAYS ON HOLD
 ; for rx's: FROM date is the (re)fill date in 52 and TO is the date entry added (release date)
 ; also set # Days On Hold only if the bill is currently in On Hold status
 N IBX,IB0,IB1 S IBX="",IB0=$G(^IB(+$G(FPIFN),0)) I IB0="" G LN2Q
 S IB1=$G(^IB(+FPIFN,1))
 ;
 S $P(IBX,U,1)=$S(+$P(IB0,U,4)=52:$$RXDT(+FPIFN),+$P(IB0,U,14):+$P(IB0,U,14),1:+$P(IB1,U,2))\1
 S $P(IBX,U,2)=$S(+$P(IB0,U,15):+$P(IB0,U,15),1:+$P(IB1,U,2))\1
 S $P(IBX,U,3)=$$CANC(+FPIFN)
 S $P(IBX,U,4)=$P(IB0,U,11)
 S $P(IBX,U,5)=$P(IB0,U,7)
 S $P(IBX,U,6)=$$ATAB($P(IB0,U,3))
 S $P(IBX,U,7)=$$OHDT(+FPIFN)
LN2Q Q IBX
 ;
 ; ========================================================================================
 ; 
 ; these procedures return First Party charge specific data and status
 ;
ATAB(AT) ; given an Action Type (ptr to 350.1), return a shortened/abbreviated form of Action Type (350.1,.01)
 N IBX,IBY S IBX="",IBY=$P($G(^IBE(350.1,+$G(AT),0)),U,1) I IBY="" G ATABQ
 I "IB DG PSO"'[$E(IBY,1,3) S IBX=IBY
 I IBX="" S IBY=$P(IBY," ",2,999),IBY=$P(IBY," ",1,$L(IBY," ")-1) S IBX=IBY
ATABQ Q IBX
 ;
CANC(FPIFN) ; given a First Party Charge (ptr to 350), return 1 if charge is Cancelled, "" otherwise
 ; is cancelled if the Action Type (350,.03) Sequence Number (350.1,.05) is Cancel
 ; or is cancelled if the Status (350,.05) is Cancelled (350.21,.05) (never passed to AR)
 N IBX,IBY,IB0 S IBX="",IB0=$G(^IB(+$G(FPIFN),0)) I IB0="" G CANCQ
 S IBY=$P($G(^IBE(350.1,+$P(IB0,U,3),0)),U,5) I +IBY=2 S IBX=1 ;  action is cancel
 I 'IBX S IBY=$P($G(^IBE(350.21,+$P(IB0,U,5),0)),U,5) I +IBY S IBX=1 ;  status is cancel
CANCQ Q IBX
 ;
RXDT(FPIFN) ; return fill date of rx being billed, Resulting From must be 52
 ; fill date for Original = (52,22), for Refill = (52,52,.01)
 N IBX,IBY,IB0,IBRX,IBRXN S IBX="",IB0=$G(^IB(+$G(FPIFN),0)) I IB0="" G RXDTQ
 S IBY=$P(IB0,U,4) I +IBY=52 S IBRX=+$P(IBY,":",2),IBRXN=+$P(IBY,":",3) D  I +IBY S IBX=IBY\1
 . S IBY=$S('IBRXN:$$FILE^IBRXUTL(IBRX,22),1:+$$SUBFILE^IBRXUTL(IBRX,IBRXN,52,.01))
RXDTQ Q IBX
 ;
OHDT(FPIFN) ; return the bills # DAYS ON HOLD, if the bill is currently in the On Hold Status
 N IBX,IBY,IB0 S IBX="",IB0=$G(^IB(+$G(FPIFN),0)) I IB0="" G OHDQ
 S IBY=$P($G(^IBE(350.21,+$P(IB0,U,5),0)),U,6)
 I +IBY S IBY=$P($G(^IB(+FPIFN,1)),U,6) I +IBY S IBX=$$FMDIFF^XLFDT(DT,IBY)
OHDQ Q IBX
