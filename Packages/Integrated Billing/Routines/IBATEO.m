IBATEO ;ALB/BGA - TRANSFER PRICING OUTPATIENT TRACKER ; 19-MAR-99
 ;;2.0;INTEGRATED BILLING;**115**;21-MAR-94
 ;;Per VHA DIRECTIVE 10-93-142, this routine should not be modified.
 ;
 ; Comment- This routine is invoked via the appointment driver ^IBAMTS
 ;          This program checks for check outs and determines if
 ;          the person checking out is a Transfer Pricing Patient
 ;          if TP the routine prices the procedures and files the
 ;          transaction in 351.61 
 ;
 ; Determine if this encounter has a status of checked out
 N IBORG,IBOE,IBEVT,IBEV0,IBERR,IB,IBI,IBDATE,IBRATE,IBPREF,IBPROC
 N IBERR,IBQTY,IBATFILE,IBSDHDL,IBPROC,IBSOURCE,IBATIEN,IBOIEN,IBERR2
 I '$P($G(^IBE(350.9,1,10)),"^",3) Q  ; transfer pricing turned off
 S IBSDHDL=0,U="^" F  S IBSDHDL=$O(^TMP("SDEVT",$J,IBSDHDL)) Q:'IBSDHDL  D
 . S IBORG=0 F  S IBORG=$O(^TMP("SDEVT",$J,IBSDHDL,IBORG)) Q:'IBORG  D
 . . S IBOE=0 F  S IBOE=$O(^TMP("SDEVT",$J,IBSDHDL,IBORG,"SDOE",IBOE)) Q:'IBOE  S IBEVT=$G(^(IBOE,0,"AFTER")),IBEV0=$G(^("BEFORE")) D
 . . . Q:$P(IBEVT,U,6)  ; do not evaluate sibling encounters
 . . . Q:$P(IBEVT,U,12)=8  ; do not evaluate inpatient encounters
 . . . ; Check encounter is checked out and is not being tracked in 351.61
 . . . ; === NEW Entry
 . . . I IBEVT]" ",('$D(^IBAT(351.61,"AD",(IBOE_";SCE(")))),$P(IBEVT,U,12)=2,$$TPP^IBATUTL($P(IBEVT,U,2)) D  Q
 . . . . K IBPROC,IBERR D IBPRICE(IBOE,IBEVT,.IBPROC,.IBERR)
 . . . . Q:$P(IBERR,U)
 . . . . ; Pass in (dfn,event date,facility,ibsource,procedure array)
 . . . . S IBATFILE=$$OUT^IBATFILE($P(IBEVT,U,2),IBDATE,IBPREF,IBSOURCE,.IBPROC)
 . . . . ; Encounter has status of checked out and has an entry in 351.61
 . . . . ; and the Encounter has been updated.
 . . . I IBEVT]" ",$D(^IBAT(351.61,"AD",(IBOE_";SCE("))),$P(IBEVT,U,12)=2 D  Q
 . . . . S IBSOURCE=IBOE_";SCE("
 . . . . S IBATIEN=$O(^IBAT(351.61,"AD",IBSOURCE,""))
 . . . . K IBPROC,IBERR D IBPRICE(IBOE,IBEVT,.IBPROC,.IBERR)
 . . . . Q:$P(IBERR,U)
 . . . . S IBATFILE=$$UPDATE^IBATFILE(IBATIEN,.IBPROC)
 . . . I IBEVT]" ",$D(^IBAT(351.61,"AD",(IBOE_";SCE("))),$P(IBEVT,U,12)'=2 D  Q
 . . . . I $P(IBEV0,U,12)=2 D  Q 
 . . . . . ; This is the case where I have a check out that has been deleted
 . . . . . ; "BEFORE" has a status of checked out the "AFTER" has a status
 . . . . . ; of not check out and shows no date for check out process date
 . . . . . S IBSOURCE=IBOE_";SCE("
 . . . . . S IBATIEN=$O(^IBAT(351.61,"AD",IBSOURCE,""))
 . . . . . D CANC^IBATFILE(IBATIEN)
 Q
IBPRICE(IBOIEN,IBEVT,IBPROC,IBERR) ;
 S IBERR=0
 I $G(IBOIEN)<1!($G(IBEVT)<1) S IBERR=1 Q
 I '$$TPP^IBATUTL($P(IBEVT,U,2)) S IBERR="1^Not currently a TP patient" Q  ; determine if transfer pricing patient
 S IBPREF=$$PPF^IBATUTL($P(IBEVT,U,2)) I 'IBPREF S IBERR="1^No pref. facility found" Q
 K IB,IBERR2 D GETCPT^SDOE(IBOE,"IB","IBERR2")
 I $D(IBERR2) S IBERR="1^No procedures could be found for IBOE="_IBOIEN Q
 S IBDATE=$P($P(IBEVT,U),".") I 'IBDATE S IBERR="1^No event date found for IBOE="_IBOIEN Q
 S IBSOURCE=IBOE_";SCE("
 K IBPROC S IBI=0 F  S IBI=$O(IB(IBI)) Q:'IBI  D
 . S IBRATE=$$OPT^IBATCM($P(IB(IBI),U),IBDATE,IBPREF)
 . I '$P(IBRATE,U)!($P(IBRATE,U,4)<1) Q  ; could not price the procedure
 . S IBRATE=$P(IBRATE,U,4),IBQTY=$P(IB(IBI),U,16)
 . S IBPROC($P(IB(IBI),U))=IBQTY_U_IBRATE
 I '$D(IBPROC) S IBERR="1^Could not find any procedures for IBOE="_IBOIEN
 Q
