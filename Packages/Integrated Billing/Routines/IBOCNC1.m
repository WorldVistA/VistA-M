IBOCNC1 ;ALB/ARH - CPT USAGE IN CLINICS (SEARCH); 1/23/92
 ;;2.0;INTEGRATED BILLING;**91,133**;21-MAR-94
 ;
 ;entry pt. for tasked jobs
FIND ;find, save, and print the data that satisfies the search parameters, save clinic/division names
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOCNC" D T1^%ZOSV ;stop rt clock
 ;S XRTL=$ZU(0),XRTN="IBOCNC-2" D T0^%ZOSV ;start rt clock
 I VAUTC,VAUTD S ^TMP("IBCU",$J,"D","ALL")="",IBPRC(1)="ALL DIVISIONS AND CLINICS"
 S X=0
 I VAUTC,'VAUTD S X=X+1,IBC="",IBPRC(X)="DIVISIONS: ",IBDIV="" F IBI=1:1 S IBDIV=$O(VAUTD(IBDIV)) Q:IBDIV=""  D
 . S ^TMP("IBCU",$J,"D",IBDIV)=""
 . I ($L(IBPRC(X))+$L(VAUTD(IBDIV))+2)>IOM S X=X+1,IBPRC(X)="           ",IBC=""
 . S IBPRC(X)=IBPRC(X)_IBC_VAUTD(IBDIV),IBC=", "
 I 'VAUTC S X=X+1,IBC="",IBPRC(X)="CLINICS: ",IBCLN="" F IBI=1:1 S IBCLN=$O(VAUTC(IBCLN)) Q:IBCLN=""  D
 . S ^TMP("IBCU",$J,"C",IBCLN)=""
 . I ($L(IBPRC(X))+$L(VAUTC(IBCLN))+2)>IOM S X=X+1,IBPRC(X)="         ",IBC=""
 . S IBPRC(X)=IBPRC(X)_IBC_VAUTC(IBCLN),IBC=", "
 K VAUTD,VAUTC,IBC,X
 ;entire divisions were chosen, find all clinics
 I $D(^TMP("IBCU",$J,"D","ALL")) S IBDIV="" F  S IBDIV=$O(^DG(40.8,IBDIV)) Q:IBDIV'?1N.N  S ^TMP("IBCU",$J,"D",IBDIV)=""
 I $D(^TMP("IBCU",$J,"D")) S IBCLN="" F IBI=1:1 S IBCLN=$O(^SC(IBCLN)) Q:IBCLN'?1N.N  D
 . S IBLN=$G(^SC(IBCLN,0))  Q:$P(IBLN,"^",3)'="C"!('$D(^TMP("IBCU",$J,"D",+$P(IBLN,"^",15))))
 . S ^TMP("IBCU",$J,"C",IBCLN)=""
 K IBLN,IBCLN,IBDIV,IBI,^TMP("IBCU",$J,"D")
 ;I $D(XRT0),'$D(^TMP("IBCU",$J,"C")) S:'$D(XRTN) XRTN="IBOCNC" D T1^%ZOSV ;stop rt clock
 Q:'$D(^TMP("IBCU",$J,"C"))
 ;
SAVE ;for each clinic chosen collect counts on CPTs used and save in sorted tmp file
 N IBVAL,IBCBK,IBFILTER
 S IBVAL("BDT")=IBBDT,IBVAL("EDT")=IBEDT+.3
 ; Must be an encounter for one of the clinics chosen,
 ;   only count each visit (in v-file) once
 S IBFILTER=""
 S IBCBK="I '$P(Y0,U,6),$D(^TMP(""IBCU"",$J,""C"",+$P(Y0,U,4))),'$D(^TMP(""VIS"",$J,+$P(Y0,U,5))) S ^TMP(""VIS"",$J,+$P(Y0,U,5))="""" D CKENC^IBOCNC1(Y,Y0,.SDSTOP) S:$G(SDSTOP) IBQ=1"
 S IBQ=0
 K ^TMP("VIS",$J)
 D SCAN^IBSDU("DATE/TIME",.IBVAL,IBFILTER,IBCBK)
 ;
 K IBB,IBE,IBX,IBCLN,IBCLNN,IBCPT,IBLN,IBI,^TMP("IBCU",$J,"C"),^TMP("VIS",$J)
 D:IBSRT BILL
PRINT I 'IBQ D ^IBOCNC2
 K IBPRC,IBSRT,IBQ,^TMP("IBCU",$J)
 I $D(ZTQUEUED) S ZTREQ="@"
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOCNC" D T1^%ZOSV ;stop rt clock
 Q
 ;
BILL ;when sorting by CPT, get count on CPT's entered in billing for the date range
 ;count number of CPTs in old format, using event date as procedure date
 Q:IBQ  S IBEVDT=IBBDT-.001,IBE=IBEDT+.3
 F  S IBEVDT=$O(^DGCR(399,"D",IBEVDT)) Q:IBEVDT=""!(IBEVDT>IBE)!IBQ  D  S IBQ=$$STOP
 . S IBN="" F  S IBN=$O(^DGCR(399,"D",IBEVDT,IBN)) Q:IBN=""  D
 .. Q:$P($G(^DGCR(399,IBN,0)),"^",9)'=4!('$D(^DGCR(399,IBN,"C")))!($P($G(^DGCR(399,IBN,0)),"^",13)=7)  S IBX=$G(^DGCR(399,IBN,"C"))
 .. F IBI=1,2,3,7,8,9 S IBCPT=$P(IBX,"^",IBI) I $$CPT^ICPTCOD(+IBCPT)>0 S ^TMP("IBCU",$J,+IBCPT,"B")=$G(^TMP("IBCU",$J,+IBCPT,"B"))+1,^TMP("IBCU",$J,"B")=$G(^TMP("IBCU",$J,"B"))+1
 ;count number of CPTs in "CP" multiple using the cross-reference and the correct procedure date
 Q:IBQ  S IBPDT=-(IBEDT+.3)
 F  S IBPDT=$O(^DGCR(399,"ASD",IBPDT)) Q:IBPDT=""!(-IBPDT<IBBDT)!IBQ  D  S IBQ=$$STOP
 . S IBCPT="" F  S IBCPT=$O(^DGCR(399,"ASD",IBPDT,IBCPT)) Q:IBCPT=""  D
 .. S IBN="" F  S IBN=$O(^DGCR(399,"ASD",IBPDT,IBCPT,IBN)) Q:IBN=""  D
 ... Q:$P($G(^DGCR(399,IBN,0)),U,13)=7
 ... S IBX="" F  S IBX=$O(^DGCR(399,"ASD",IBPDT,IBCPT,IBN,IBX)) Q:IBX=""  D
 .... S ^TMP("IBCU",$J,+IBCPT,"B")=$G(^TMP("IBCU",$J,+IBCPT,"B"))+1,^TMP("IBCU",$J,"B")=$G(^TMP("IBCU",$J,"B"))+1
 K IBEVDT,IBPDT,IBN,IBE,IBI,IBCPT,IBX
 Q
 ;
CKENC(IBOE,IBOE0,SDSTOP) ;
 N PARRAY,P,IBZERR,IBQUANTY
 I $$STOP S SDSTOP=1 Q
 D GETCPT^SDOE(IBOE,"PARRAY","IBZERR")
 Q:'$O(PARRAY(0))
 S IBCLN=$P(IBOE0,U,4)
 S P=0 F  S P=$O(PARRAY(P)) Q:'P  S IBCPT=+PARRAY(P) D
 . S IBQUANTY=$P($G(PARRAY(P)),U,16)
 . I IBSRT S ^TMP("IBCU",$J,IBCPT)=$G(^TMP("IBCU",$J,IBCPT))+IBQUANTY,^TMP("IBCU",$J)=$G(^TMP("IBCU",$J))+IBQUANTY Q
 . S IBCLNN=$P($G(^SC(IBCLN,0)),U),^TMP("IBCU",$J,IBCLNN,"N")=IBCLN
 . S ^TMP("IBCU",$J,IBCLNN)=$G(^TMP("IBCU",$J,IBCLNN))+IBQUANTY
 . S ^TMP("IBCU",$J,IBCLNN,IBCPT)=$G(^TMP("IBCU",$J,IBCLNN,IBCPT))+IBQUANTY
 Q
 ;
STOP() ;check for user requested stop when queued
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ I +$G(IBPGN) W !!,"TASK STOPPED BY USER",!!
 Q +$G(ZTSTOP)
