IBCD ;ALB/ARH - AUTOMATED BILLER ;8/6/93
 ;;2.0;INTEGRATED BILLING;**312**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;This routine is the begining of the auto biller.  No variables are required on entry.  It is be called by the
 ;IB nightly job routine IBAMTC.  It first checks to see if it should run based on the auto biller frequency
 ;site parameter.  It then gathers the Claims Tracking events with an EABD into a temporary file by patient,
 ;event type, and episode date.  This temporary file ("IBACAB") is then used to sort the events into groups
 ;that should be added to individual bills based on the individual event type billing cycle parameters.  This
 ;second temporary file is then used to create the actual bills in IBCD1-2.
 ;
EN ;begin process of finding and creating bills
 ;determine if auto biller should run, check site parameters (350.9,7.01-7.02)
 N IBSWINFO,IBPFSS S IBSWINFO=$$SWSTAT^IBBAPI()            ;IB*2.0*312
 S IBPAR7=$G(^IBE(350.9,1,7)) G:'$P(IBPAR7,U,1) EXIT
 I +IBPAR7,+$P(IBPAR7,U,2),$$FMADD^XLFDT(+$P(IBPAR7,U,2),+IBPAR7)>DT G EXIT
 S IBAUTO=1
 ;
 ;begin search for events to bill, create array of events by patient
 ;^TMP("IBCAB",$J, PATIENT, EVENT TYPE, EPISODE DATE, EVENT IFN)=""
 ;adds all events in Claims Tracking that have an EABD not after today
 S IBDFN=0 F  S IBDFN=$O(^IBT(356,"ATOBIL",IBDFN)) Q:'IBDFN  D
 . S IBTYP=0 F  S IBTYP=$O(^IBT(356,"ATOBIL",IBDFN,IBTYP)) Q:'IBTYP  D
 .. S IBEABD=0 F  S IBEABD=$O(^IBT(356,"ATOBIL",IBDFN,IBTYP,IBEABD)) Q:'IBEABD!(IBEABD>DT)  D
 ... S IBTRN=0 F  S IBTRN=$O(^IBT(356,"ATOBIL",IBDFN,IBTYP,IBEABD,IBTRN)) Q:'IBTRN  D
 .... S IBX=$$EVBILL^IBCU81(IBTRN) I 'IBX!(IBX>DT) D TEABD(IBTRN,+IBX) D:$P(IBX,U,2)'="" TERR(IBTRN,0,$P(IBX,U,2)) Q
 .... S IBX=$$EVNTCHK^IBCU82(IBTRN) I +IBX D TEABD(IBTRN,0) D TERR(IBTRN,0,$P(IBX,U,2)) Q
 .... S IBTRND=$G(^IBT(356,IBTRN,0))
 .... I +IBSWINFO D  Q:IBPFSS                               ;IB*2.0*312
   ..... S IBPFSS=1                                         ;IB*2.0*312
   ..... ; Do NOT PROCESS on VistA if DT>=Switch Eff Date   ;CCR-930
   ..... I ($P(IBTRND,"^",6)+1)>$P(IBSWINFO,"^",2) Q        ;IB*2.0*312
   ..... I $P($G(^DPT(IBDFN,.1)),"^")'="" Q                 ;IB*2.0*312
   ..... Q:$$CHKDIS()                                       ;CCR-1081
   ..... S IBPFSS=0     ;Before EffDt & Discharged          ;IB*2.0*312
 .... ;
 .... S ^TMP("IBCAB",$J,IBDFN,IBTYP,+$P(IBTRND,U,6),IBTRN)=""
 K IBDFN,IBTYP,IBEABD,IBTRN,IBTRND,IBX
 ;
 I $D(^TMP("IBCAB",$J)) D ^IBCD1 ; consolidate events into bills, create bills
 D ^IBCDC ; set comments into file
 S DIE="^IBE(350.9,",DA=1,DR="7.02////"_DT D ^DIE ;reset last date auto biller run
 K ^TMP("IBCAB",$J),^TMP("IBEABD",$J),^TMP("IBCE",$J),^TMP("IBILL",$J)
 F IBX=1:1:10 K ^TMP(("IBC"_IBX),$J)
EXIT K IBX,IBPAR7,DIE,DA,DR,IBAUTO,IBBS,IBSC,IBT
 Q
CHKDIS() ; Returns 1 if discharge was on or after effective date   ;CCR-1081
 N IBADMLNK,IBDISLNK
 S IBADMLNK=$P(IBTRND,"^",5) G:'IBADMLNK CHKDISQ
 S IBDISLNK=$P($G(^DGPM(IBADMLNK,0)),"^",17) G:'IBDISLNK CHKDISQ
 ;
 I (^DGPM(IBDISLNK,0)+1)>$P(IBSWINFO,"^",2) Q 1
CHKDISQ Q 0
 ;
TEABD(TRN,IBDT) ;array contains the list of claims tracking events that need EABD updated, and the new date
 S IBDT=+$G(IBDT),^TMP("IBEABD",$J,TRN,+IBDT)=""
 Q
TERR(TRN,IFN,ER) ;array contains events or bills that need entries created in the comments file, and the comment
 N X S TRN=+$G(TRN),IFN=+$G(IFN),X=+$G(^TMP("IBCE",$J,DT,TRN,IFN))+1
 S ^TMP("IBCE",$J,DT,TRN,IFN,X)=$G(ER),^TMP("IBCE",$J,DT,TRN,IFN)=X
 Q
TBILL(TRN,IFN) ;array contains list of events and bills to be inserted into 356.399
 I '$D(^IBT(356,+$G(TRN),0))!('$D(^DGCR(399,+$G(IFN),0))) Q
 S ^TMP("IBILL",$J,TRN,IFN)=""
 Q
