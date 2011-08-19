IBCCPT1 ;OAK/ELZ - MCCR OUTPATIENT VISITS LISTING CONT.(2) ;30-JUL-2003
 ;;2.0;INTEGRATED BILLING;**260**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
NBOEP(IBOEO,IBBCPT,IBDXDAT) ; returnes if a procedure is billable
 ;
 N IBRMARK,IBPCEX,IBARR,IBP,IBDX,IBL,IBT,IBVST800,IBCPT800,IBDX800,DFN,IBDT,IBCPT
 S IBRMARK="",IBPCEX=$P(IBOEO,"^",5)
 S DFN=$P(IBOEO,"^",2),IBDT=IBOEO/1
 ;
 ; look up classification info needed (if any)
 D CL^SDCO21(DFN,IBDT,"",.IBARR) ;I '$D(IBARR) G NBOEPQ
 ;
 ; look up PCE info
 D ENCEVENT^PXKENC(IBPCEX)
 S IBVST800=$G(^TMP("PXKENC",$J,IBPCEX,"VST",IBPCEX,800))
 ;
 ; do comparison to find dx to cpt relations
 S IBCPT=0 F  S IBCPT=$O(^TMP("PXKENC",$J,IBPCEX,"CPT",IBCPT)) Q:IBCPT<1  S IBDX=0 I IBBCPT=+^(IBCPT,0) F  S IBDX=$O(^TMP("PXKENC",$J,IBPCEX,"POV",IBDX)) Q:IBDX<1  D
 . F IBP=5,9,10,11 Q:'$D(^TMP("PXKENC",$J,IBPCEX,"CPT",IBCPT,0))  I $P(^TMP("PXKENC",$J,IBPCEX,"CPT",IBCPT,0),"^",IBP)=+$G(^TMP("PXKENC",$J,IBPCEX,"POV",IBDX,0)) D
 .. S IBDXDAT=$G(IBDXDAT)_+$G(^TMP("PXKENC",$J,IBPCEX,"POV",IBDX,0))_"^"
 .. S IBDX800=$G(^TMP("PXKENC",$J,IBPCEX,"POV",IBDX,800))
 .. S IBCPT800=$G(^TMP("PXKENC",$J,IBPCEX,"CPT",IBCPT,800))
 .. ;
 .. ; is classification filled in as true on dx level?
 .. F IBL=2:1  S IBT=$P($T(CLDATA+IBL^IBTRKR41),";",3) Q:IBT=""  I $D(IBARR(+IBT)),$P(IBDX800,"^",$P(IBT,"^",2)) S IBRMARK=$P(IBT,"^",3) Q
 .. ;
 .. ; if no cl filled in for dx, then check cpt level for true
 .. I $D(^TMP("PXKENC",$J,IBPCEX,"CPT",IBCPT,0)) F IBL=2:1  S IBT=$P($T(CLDATA+IBL^IBTRKR41),";",3) Q:IBT=""  I $D(IBARR(+IBT)),$P(IBDX800,"^",$P(IBT,"^",2))="",$P(IBCPT800,"^",$P(IBT,"^",2)) S IBRMARK=$P(IBT,"^",3) Q
 .. ;
 .. ; if no cl for dx or cpt, use visit level
 .. I $D(^TMP("PXKENC",$J,IBPCEX,"CPT",IBCPT,0)) F IBL=2:1  S IBT=$P($T(CLDATA+IBL^IBTRKR41),";",3) Q:IBT=""  D
 ... I $D(IBARR(+IBT)),$P(IBDX800,"^",$P(IBT,"^",2))="",$P(IBCPT800,"^",$P(IBT,"^",2))="",$P(IBVST800,"^",$P(IBT,"^",2)) S IBRMARK=$P(IBT,"^",3) Q
 ;
 ;
NBOEPQ K ^TMP("PXKENC",$J)
 Q IBRMARK
 ;
ADDDX(IBIFN,IBPROCP,IBDX,IBDR) ; file assoc dx, add to DR string for bill
 N DIC,X,Y,DLAYGO,IBP,IBDXDA,DD,DO
 F IBP=1:1:4 S X=$P(IBDX,"^",IBP) D:X
 . S IBDXDA=$O(^IBA(362.3,"AIFN"_IBIFN,X,0)) I IBDXDA S IBDR=$G(IBDR)_$S($L($G(IBDR)):";",1:"")_(IBP+9)_"////"_IBDXDA Q
 . S DIC("DR")=".02////"_IBIFN,DIC="^IBA(362.3,",DIC(0)="L",DLAYGO=362.3 K DD,DO D FILE^DICN I Y>0 S IBDR=$G(IBDR)_$S($L($G(IBDR)):";",1:"")_(IBP+9)_"////"_(+Y)
 Q
