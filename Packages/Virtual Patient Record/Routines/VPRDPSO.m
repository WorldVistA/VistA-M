VPRDPSO ;SLC/MKB -- Outpatient Pharmacy extract ;8/2/11  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**1,4**;Sep 01, 2011;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; PSODI                         4858
 ; PSOORDER,^TMP("PSOR",$J)      1878
 ; PSS50P7                       4662
 ; PSS51P2                       4548
 ; XLFDT                        10103
 ; XLFSTR                       10104
 ;
 ; ------------ Get prescription from VistA ------------
 ;
RX(ID,MED) ; -- return a prescription in MED("attribute")=value
 N RX0,RX1,DRUG,PSOI,X,I,START,STOP,ORIFN,FILL,RFD,PRV K MED
 N VPR ;PSOORDER kills VPR
 K ^TMP("PSOR",$J) D EN^PSOORDER(DFN,+ID)
 S RX0=$G(^TMP("PSOR",$J,+ID,0)),RX1=$G(^(1)),DRUG=$G(^("DRUG",0))
 S MED("medID")=ID_";O",MED("vaType")="O",MED("type")="Prescription"
 S ORIFN=+$P(RX1,U,8) S:ORIFN MED("orderID")=ORIFN
 S PSOI=$G(^TMP("PSOR",$J,+ID,"DRUGOI",0)) I PSOI D
 . S MED("name")=$P(PSOI,";",2)
 . D ZERO^PSS50P7(+PSOI,,,"OI")
 . S MED("form")=$P($G(^TMP($J,"OI",+PSOI,.02)),U,2)
 . S:+$G(^TMP($J,"OI",+PSOI,.09)) MED("supply")=1
 D:DRUG NDF^VPRDPS(+DRUG) ;add NDF data
 S START=$P(RX0,U) S:START MED("start")=START
 S STOP=$P(RX0,U,12) S:STOP MED("stop")=STOP ;_".2359"?
 S X=$$GET1^PSODI(52,+ID_",",26,"I") S:X MED("expires")=$P(X,U,2) ;1^date
 S X=$P(RX0,U,17) S:X MED("ordered")=X
 S MED("vaStatus")=$$UP^XLFSTR($P($P(RX0,U,4),";",2)),X=$P($P(RX0,U,4),";")
 S MED("status")=$S(X="H":"hold",X="DC":"not active",X="D"!(X="E"):"historical",1:"active")
 S MED("quantity")=$P(RX0,U,6),MED("daysSupply")=$P(RX0,U,7)
 S MED("fillsAllowed")=$P(RX0,U,8),MED("fillsRemaining")=$P(RX0,U,9)
 S MED("routing")=$P($P(RX1,U,6),";"),MED("prescription")=$P(RX0,U,5)
 S MED("lastFilled")=$P(RX0,U,3) K FILL
 S I=0 F  S I=$O(^TMP("PSOR",$J,+ID,"REF",I)) Q:I<1  S X=$G(^(I,0)),FILL(+X)=X
 S I=0 F  S I=$O(^TMP("PSOR",$J,+ID,"RPAR",I)) Q:I<1  S X=$G(^(I,0)),$P(X,U,14)=1,FILL(+X)=X
 S (I,RFD,PRV)=0 F  S RFD=$O(FILL(RFD)) Q:RFD<1  S X=$G(FILL(RFD)) D  ;sort 1st
 . N MW,REL S I=I+1
 . S MW=$P($P(X,U,10),";"),REL=$P($P(X,U,8),".")
 . S MED("fill",I)=$P(RFD,".")_U_MW_U_REL_U_$P(X,U,4,5)_$S($P(X,U,14):"^1",1:"")
 . S:$P(X,U,2) PRV=$P(X,U,2) ;save last provider
 . ; fill comments?
 S X=$S($P(RX0,U,11):$P(RX0,U,11),$P(RX0,U,10):$P(RX0,U,10),1:0)
 S:X MED("fillCost")=X
 S X=$G(^TMP("PSOR",$J,+ID,"SIG",1,0)),I=1
 F  S I=$O(^TMP("PSOR",$J,+ID,"SIG",I)) Q:I<1  S X=X_$G(^(I,0))
 S MED("sig")=X
 S X=$G(^TMP("PSOR",$J,+ID,"PI",1,0)),I=1
 F  S I=$O(^TMP("PSOR",$J,+ID,"PI",I)) Q:I<1  S X=X_$G(^(I,0))
 S:$L(X) MED("ptInstructions")=X
 S I=0 F  S I=$O(^TMP("PSOR",$J,+ID,"MI",I)) Q:I<1  S X=$G(^(I,0)) D
 . N UD,NOUN,DOSE,UNIT,RTE,SCH,DUR,CONJ,END
 . S UD=$P(X,U,2),NOUN=$P(X,U,4)
 . S DOSE=$P(X,U),UNIT=$P($P(X,U,3),";",2)
 . S RTE=+$P(X,U,7) D ALL^PSS51P2(RTE,,,,"MR")
 . S RTE=$G(^TMP($J,"MR",RTE,1))
 . S DUR=$P(X,U,5),CONJ=$P(X,U,6),SCH=$P(X,U,8)
 . S END=$S(DUR:$$STOP(START,DUR),1:STOP)
 . S MED("dose",I)=DOSE_U_UNIT_U_UD_U_NOUN_U_RTE_U_SCH_U_DUR_U_CONJ_U_START_U_END
 . I $E(CONJ)="T",DUR S START=END
 S:RX1 X=$TR($P(RX1,U),";","^")_U_$$PROVSPC^VPRD(+RX1),MED("orderingProvider")=X,MED("currentProvider")=X
 S:$G(PRV) MED("currentProvider")=$TR(PRV,";","^")_U_$$PROVSPC^VPRD(+PRV)
 S:$P(RX1,U,9) MED("pharmacist")=$TR($P(RX1,U,9),";","^")
 S:$P(RX1,U,4) MED("location")=$TR($P(RX1,U,4),";","^")
 S MED("facility")=$$FAC^VPRD(+$P(RX1,U,4))
 K ^TMP("PSOR",$J),^TMP($J,"MR"),^TMP($J,"NDF"),^TMP($J,"OI")
 Q
 ;
STOP(BEG,X) ; -- Return date after adding X to BEG
 N D,H,M,UNT,Y
 S Y=BEG,(D,H,M)=0,UNT=$P(X,+X,2),X=+X
 S:$E(UNT)=" " UNT=$E(UNT,2,99) I UNT="" S UNT="D"
 S:UNT="L" D=30*X
 S:UNT="W" D=7*X
 S:UNT="D" D=X
 S:UNT="H" H=X
 S:UNT="M" M=X
 S Y=$$FMADD^XLFDT(BEG,D,H,M)
 Q Y
 ;
ACTIVE(X) ; -- return 1 or 0, if X is an active status
 N Y S Y=1
 I X="PURGE" S Y=0
 I X="DELETED" S Y=0
 I X="EXPIRED" S Y=0 ;keep, to renew?
 I $P(X," ")="DISCONTINUED" S Y=0
 Q Y
