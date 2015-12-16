IBCSC4A ;ALB/MJB - MCCR PTF SCREEN  ;24 FEB 89 9:49
 ;;2.0;INTEGRATED BILLING;**106,228,339,479,522**;21-MAR-94;Build 11
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
DX ;
PRO ; Get PTF Procedures for a bill in ^UTILITY($J,"IB")
 ; includes ICD Surgeries (401) and ICD Procedures (601) or CPT Professional Services (801) based on PCM
 N IB0,IBU,IBPTF,IBFDT,IBTDT,IBPCM K ^UTILITY($J) Q:'$G(IBIFN)
 S IB0=$G(^DGCR(399,+$G(IBIFN),0)),IBPTF=$P(IB0,U,8),IBPCM=+$P(IB0,U,9) Q:'IBPTF
 S IBU=$G(^DGCR(399,+IBIFN,"U")),IBFDT=+IBU,IBTDT=$P(IBU,U,2) Q:$P(IB0,U,5)>2
 ;
 D PTFPRDT(IBPTF,IBFDT,IBTDT,IBPCM,IBIFN)
 Q
 ;
 ;
PTFPRDT(PTF,IBDT1,IBDT2,PCM,IBIFN) ; collect PTF Procedures within a date range
 ; includes ICD Surgeries (401) and ICD Procedures (601) or CPT Professional Services (801)
 ; the procedure coding method (PCM) determines if ICD (401/601) or CPT (801) procedures returned
 N DFN K ^UTILITY($J,"IB") Q:'$G(PTF)
 S IBDT1=+$G(IBDT1),IBDT2=+$G(IBDT2),DFN=+$G(^DGPT(PTF,0)) Q:'DFN
 I '$G(PCM) S PCM=9
 ; 
 I +PCM'=9 D PTFPS(DFN,PTF,IBDT1,IBDT2) Q  ; get CPT Procedures (601)
 ;
 D PTFPR(PTF,IBDT1,IBDT2,$G(IBIFN)) ; get ICD Procedures (401/601)
 ;
 Q
 ;
 ;
PTFPR(IBPTF,IBDT1,IBDT2,IBIFN) ; collect PTF ICD Procedures, Surgeries (401) and Procedures (601), for a date range
 ; Output:  UTILITY($J,"IB",X,1) = ICD IEN ^ Date ^ Seq Group Letter ^ Type (401="", 601="*")
 ;          UTILITY($J,"IB",X,Y) = ICD IEN
 ;          UTILITY($J,"IB","B", Seq Group Letter_Y ) = X ^ Y ^ on bill (Y/N)
 ; where X is 1:1 of the number of events found, order by: Surgeries first, then Procedures, then by reverse date
 N IBXRF,IBPI,IBPDT,IBECNT,IBCNT,IBTYPE,IBSGRP,IBFIRST,IBPRC,IBPB,IBI,IBJ,IBARR,PTFCOD,BPARR K ^UTILITY($J,"IB")
 S IBDT1=$S(+$G(IBDT1):IBDT1\1,1:0),IBDT2=$S(+$G(IBDT2):IBDT2\1,1:9999999)+.999999 Q:'$G(IBPTF)
 I +$G(IBIFN) D BILLPRC(IBIFN,.BPARR)
 ;
 ; get list of Procedure and Surgery Events and order by reverse date
 F IBXRF="S","P" S IBPI=0 F  S IBPI=$O(^DGPT(IBPTF,IBXRF,IBPI)) Q:'IBPI  D
 . S IBPDT=+$G(^DGPT(IBPTF,IBXRF,IBPI,0))\1 I IBPDT'<IBDT1,IBPDT'>IBDT2 S IBARR(IBXRF,-IBPDT,IBPI)=IBPDT
 ;
 ; collect PTF Procedure (601) and Surgeries (401) associated ICD codes, by type and reverse date
 S IBECNT=0  F IBXRF="S","P" S IBJ="" F  S IBJ=$O(IBARR(IBXRF,IBJ)) Q:IBJ=""  D
 . S IBPI="" F  S IBPI=$O(IBARR(IBXRF,IBJ,IBPI)) Q:IBPI=""  S IBPDT=IBARR(IBXRF,IBJ,IBPI),IBECNT=IBECNT+1 D
 .. ;
 .. S IBTYPE=$S(IBXRF="S":401,IBXRF="P":601,1:0),IBSGRP=$$SEQGRP(IBECNT)
 .. S IBFIRST=IBPDT\1_U_IBSGRP_U_$S(IBTYPE=601:"*",1:"")
 .. S ^UTILITY($J,"IB",IBECNT,1)="UNSPECIFIED CODE"_U_IBFIRST
 .. ;
 .. D PTFCDS^IBCSC4F(IBPTF,IBTYPE,IBPI,.PTFCOD) D  K PTFCOD ; get surgery/procedure codes
 ... S IBCNT=0,IBI="" F  S IBI=$O(PTFCOD(IBI)) Q:IBI=""  S IBPRC=PTFCOD(IBI) I +IBPRC S IBCNT=IBCNT+1 D
 .... S IBPB=+$O(BPARR(+IBPRC,+IBPDT,0)) S BPARR=$S('$G(IBIFN):"",+IBPB:"Y",1:"N") K BPARR(+IBPRC,+IBPDT,+IBPB)
 .... S ^UTILITY($J,"IB",IBECNT,IBCNT)=+IBPRC_U_IBFIRST S IBFIRST=""
 .... I IBSGRP'="" S ^UTILITY($J,"IB","B",IBSGRP_IBCNT)=IBECNT_U_IBCNT_U_BPARR
 Q
 ;
 ;
SEQGRP(ECNT) ; return sequence group alpha character (A-Z, a-z, 52 max)
 N IBX S IBX="" I +$G(ECNT) S ECNT=$S(ECNT>52:0,ECNT>26:ECNT+6,1:ECNT) I +ECNT S IBX=$C(64+ECNT)
 Q IBX
 ;
 ;
BILLPRC(IBIFN,ARRAY) ; return array of ICD procedures on bill,  ARRAY(PRC,DATE,X)="" pass by reference
 N IBPI,IBP0 K ARRAY
 S IBPI=0 F  S IBPI=$O(^DGCR(399,+$G(IBIFN),"CP",IBPI)) Q:'IBPI  D
 . S IBP0=$G(^DGCR(399,IBIFN,"CP",IBPI,0)) Q:IBP0'[";ICD0"  S ARRAY(+IBP0,+$P(IBP0,U,2),IBPI)=""
 Q
 ;
 ;
PTFPS(DFN,IBPTF,IBFDT,IBTDT) ; this will return a list of professional
 ; services from the ptf records.  If no date range specified, then
 ; it will return all services for that ptf entry.
 ;  return:  ^utility($j,"IB",count for event,count for procedures) =
 ;           pices: 1 = procedure
 ;                  2 = date (only if new date)
 ;                  3 = sequentual grouping letter (only if new date) 
 ;                  4 = "+" to flag as CPT 4 procedure
 ;                  5 = if exemption applicable, info for that
 ;                6-9 = assoc dx in order
 ;                 10 = quantity
 ;              11-12 = modifiers
 ;                 13 = provider
 ;                 14 = location
 ;
 ; the exemption information returned will be first evaluated at the
 ; dx level and if nothing there to exempt, it will be at the procedure
 ; level.
 ;
 N IBX,IBY,IBDT,IBXX,IBP,IBC,IBD,IBSGRP,IBRMARK,IBDX,IBDXX,IBPP,IB46
 K ^TMP("PTF",$J),^TMP("IBPTFPS",$J)
 S IBFDT=$S(+$G(IBFDT):IBFDT\1,1:0),IBTDT=$S(+$G(IBTDT):IBTDT\1,1:9999999)+.999999
 ;
 ; get starting place for ^utility global
 S IBC=+$O(^UTILITY($J,"IB",":"),-1)
 ;
 D PTFINFOR^DGAPI(DFN,IBPTF) I '$D(^TMP("PTF",$J)) G PTFPSQ
 ;
 S IBX=0 F  S IBX=$O(^TMP("PTF",$J,IBX)) Q:IBX<1  S IBY=^TMP("PTF",$J,IBX) I $S(IBFDT<+IBY&(IBTDT>+IBY):1,1:0) S ^TMP("IBPTFPS",$J,+IBY)=""
 I '$D(^TMP("IBPTFPS",$J)) G PTFPSQ
 ;
 K ^TMP("PTF",$J)
 D ICDINFO^DGAPI(DFN,IBPTF) ;get the dx's for the ptf
 ;
 S IBDT=0 F  S:'IBC!($D(^UTILITY($J,"IB",IBC))) IBC=IBC+1 S IBDT=$O(^TMP("IBPTFPS",$J,IBDT)) Q:IBDT<1  D
 . ; 
 . S IBD=0,IBSGRP=$$SEQGRP(IBC)
 . D CPTINFO^DGAPI(DFN,,IBDT) I '$D(^TMP("PTF",$J,46)) Q
 . S IB46=$P($G(^TMP("PTF",$J,46,0)),"^",2)_"^"_$P($G(^(0)),"^",4)
 . ;
 . S IBX=0 F  S IBX=$O(^TMP("PTF",$J,46,IBX)) Q:IBX<1  S IBY=^TMP("PTF",$J,46,IBX) D
 .. S IBRMARK=""
 .. F IBP=5:1:8,16:1:19 S IBDX=$P(IBY,"^",IBP),IBDXX=0 F  S IBDXX=$O(^TMP("PTF",$J,46.1,IBDXX)) Q:IBDXX<1!(IBRMARK)  I $P(^TMP("PTF",$J,46.1,IBDXX),"^",2)=IBDX D
 ... F IBPP=3:1:10 I $P(^TMP("PTF",$J,46.1,IBDXX),"^",IBPP) S IBRMARK=IBPP Q
 .. S IBD=IBD+1,^UTILITY($J,"IB",IBC,IBD)=$P(IBY,"^",2)_"^"_$S(IBD=1:$P(IBDT,".")_"^"_IBSGRP_"^+^",1:"^^^")_$S(IBRMARK:$P($T(EXEMPT+(IBRMARK-2)),";",3),1:"")_"^"_$P(IBY,"^",5,8)_"^"_$P(IBY,"^",15)_"^"_$P(IBY,"^",3,4)_"^"_IB46
 .. I IBSGRP'="" S ^UTILITY($J,"IB","B",IBSGRP_IBD)=IBC_"^"_IBD
 . S IBD=0
 . K ^TMP("PTF",$J,46)
 ;
PTFPSQ K ^TMP("PTF",$J),^TMP("IBPTFPS",$J),^TMP("CPT",$J)
 Q
 ;
EXEMPT ; exemption reasons
 ;;SC
 ;;AO
 ;;IR
 ;;SW
 ;;MT
 ;;HC
 ;;CV
 ;;SH
 ;
 ;
 ;
P Q
 ;S M=($A($E(X,1))-64),S=$E(X,2),IB5=$S($D(^UTILITY($J,"IB",M,S)):^(S),1:"") I IB5]"" Q:$P(^UTILITY($J,"IB",M,1),U,3)=$E(X,1)
 ;F J=M:1:26 Q:'$D(^UTILITY($J,"IB",J))  I $P(^UTILITY($J,"IB",J,1),U,3)=$E(X,1) S M=J,IBA=1 Q
 ;S:'$D(IBA) M=0 K IBA Q
D Q
 ;S M=($A($E(X,1))-64),S=$E(X,2),IB4=$S($D(^UTILITY($J,"IBDX",M,S)):^(S),1:"") I IB4]"" Q:$P(^UTILITY($J,"IBDX",M,1),U,3)=$E(X,1)
 ;F J=M:1:26 Q:'$D(^UTILITY($J,"IBDX",J))  I $P(^UTILITY($J,"IBDX",J,1),U,3)=$E(X,1) S M=J,IBA=1 Q
 ;S:'$D(IBA) M=0 K IBA Q
