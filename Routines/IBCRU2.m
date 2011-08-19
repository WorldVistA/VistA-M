IBCRU2 ;ALB/ARH - RATES: UTILITIES (CI DEFINITIONS) ; 22-MAY-1996
 ;;2.0;INTEGRATED BILLING;**52,106,138,210**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
FNDBI(T,N) ; returns IFN of Billing Items entry (363.21) if Name N is found and of Type T
 N X,I,Y S X=0,T=$G(T),T=$S(T["NDC":1,T["MISCELLANEOUS":9,1:T)
 I +T,$G(N)'="" S I=0 F  S I=$O(^IBA(363.21,"B",$E(N,1,30),I)) Q:'I  S Y=$G(^IBA(363.21,I,0)) I +$P(Y,U,2)=T,$P(Y,U,1)=N S X=I Q
 Q X
 ;
BIFILE(BI) ; returns the source file reference for a billable item (363.3,.04)
 N IBX S IBX="",BI=+$G(BI)
 I BI=1 S IBX=";DGCR(399.1,^399.1" ;       billable bedsections
 I BI=2 S IBX=";ICPT(^81" ;                CPT procedures
 I BI=3 S IBX=";IBA(363.21,^363.21" ;      NDC numbers
 I BI=4 S IBX=";ICD(^80.2" ;               DRG codes
 I BI=9 S IBX=";IBA(363.21,^363.21" ;      Miscellaneous
 Q IBX
 ;
ITPTR(BI,NAME) ; returns pointer to item in source file if found for this billable item type
 N IBX S IBX=0 S BI=+$G(BI),NAME=$G(NAME)
 I BI=1,NAME'="" S IBX=$$MCCRUTL^IBCRU1(NAME,5)
 I BI=2,NAME'="" S IBX=$$CPTIEN^IBACSV(NAME)
 I BI=3,NAME'="" S IBX=$$FNDBI("NDC",NAME)
 I BI=4,NAME'="" S IBX=$$DRGIEN^IBACSV(NAME)
 I BI=9,NAME'="" S IBX=$$FNDBI("MISCELLANEOUS",NAME)
 Q +IBX
 ;
ITFILE(BI,ITEM,EFFDT) ; returns source item pointer (true) if the item is an active source entry for this billable item type
 N IBX,IBY S IBX=0,BI=+$G(BI),ITEM=+$G(ITEM),EFFDT=$G(EFFDT) I 'EFFDT S EFFDT=DT
 I BI=1,+ITEM S IBY=$G(^DGCR(399.1,ITEM,0)) I IBY'="",+$P(IBY,U,5) S IBX=ITEM
 I BI=2,+ITEM,$$CPTACT^IBACSV(ITEM,EFFDT) S IBX=ITEM
 I BI=3,+ITEM S IBY=$G(^IBA(363.21,ITEM,0)) I IBY'="",+$P(IBY,U,2)=1 S IBX=ITEM
 I BI=4,+ITEM,$$DRGACT^IBACSV(ITEM,EFFDT) S IBX=ITEM
 I BI=9,+ITEM S IBY=$G(^IBA(363.21,ITEM,0)) I IBY'="",+$P(IBY,U,2)=9 S IBX=ITEM
 Q IBX
 ;
ITBICHK(CS,ITEM,NAME) ; returns source item pointer (true) if the item is a valid active item for the Charge Set
 N IBX,IBBI,IBITEM S IBX=0
 S IBBI=$$CSBI^IBCRU3($G(CS))
 S IBITEM=$G(ITEM) I 'IBITEM,$G(NAME)'="" S IBITEM=$$ITPTR(IBBI,NAME)
 I +IBBI,+IBITEM S IBX=$$ITFILE(+IBBI,+IBITEM)
 Q IBX
