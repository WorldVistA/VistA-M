IBNCDNC ;ALB/SS - DRUGS NON COVERED ;11/13/07
 ;;2.0;INTEGRATED BILLING;**384**;21-MAR-94;Build 74
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;IA # 5185
 ;called from RESP1^BPSOSQL
 ;add/update a record in the file (#366.16) IB NDC NON COVERED BY PLAN
 ;IBRXN - ien of #52
 ;IBNDC - ndc
 ;IBPLAN - ien of #355.3
 ;IBRJCODE -reject code ien of #9002313.93
UPDLST(IBRXN,IBNDC,IBPLAN,IBRJCODE) ;
 I $$RECHCKIN^IBNCDNC1()=0 Q
 I (+$G(IBRXN)=0)!($G(IBNDC)="")!(+$G(IBPLAN)=0)!($G(IBRJCODE)="") Q
 I $$VALIDREJ^IBNCDNC1(IBRJCODE)=0 Q
 D UPDREC^IBNCDNC1(IBNDC,IBPLAN,IBRJCODE,$E($$RXAPI1^IBNCPUT1(IBRXN,6,"E"),1,80))
 Q
 ;checks if the NDC and GROUP PLAN combination is listed in the file (#366.15) IB NDC NOT COVERED BY PLAN
 ;input:
 ; IBNDC - drug's NDC
 ; IBPLAN - group plan
 ; IBDAYS - in how many days the status needs to be rechecked
 ;returned values:
 ; 1 - is in the list of active NON COVERED drugs ^ reject code
 ; 0 - is NOT in the list of active NON COVERED drugs
 ;     OR it is in the list but the list is older than IBDAYS, specified in the IB SITE PARAMETERS file
 ;     OR the NON COVERED DRUG functionality is turned OFF
 ; exmp: W $$CHECK^IBNCDNC(IBD("NDC"),IBPLAN)
CHECK(IBNDC,IBPLAN,IBDAYS) ;
 I IBNDC="" Q 0
 N IBZ,IBIEN,X1,X2,X
 S X1=+$O(^IBCNR(366.16,"AC",IBNDC,+$G(IBPLAN),999999999),-1)
 I X1=0 Q 0
 ;if found
 S X2=IBDAYS
 D C^%DTC
 I +X'<DT Q 1
 Q 0
 ;
RPT ;
 N IBPLAN,IBRJCODE,Y,IBM1,IBM2,IBSCR,IBPAGE
 N IBECME,IBQ
 S IBQ=0
 D SETVARS^IBNCDNC1
 Q:IBQ
 D START
 D ^%ZISC
 I IBQ W !,"Cancelled"
 D PAUSE^IBNCDNC1
 Q
 ;report itself
START ;
 N IBDAYS,IBNDC,IBREJ,IBPLN,IBIEN
 S IBDAYS=$$RECHCKIN^IBNCDNC1()
 S IBPAGE=0
 D HDR^IBNCDNC1
 S IBNDC=""
 F  S IBNDC=$O(^IBCNR(366.16,"AD",IBNDC)) Q:IBNDC=""!(IBQ=1)  D
 . S IBREJ=""
 . F  S IBREJ=$O(^IBCNR(366.16,"AD",IBNDC,IBREJ)) Q:IBREJ=""!(IBQ=1)  D
 . . I IBRJCODE'="ALL" Q:IBRJCODE'=IBREJ
 . . S IBPLN=""
 . . F  S IBPLN=$O(^IBCNR(366.16,"AD",IBNDC,IBREJ,IBPLN)) Q:IBPLN=""!(IBQ=1)  D
 . . . I IBPLAN'="ALL" Q:IBPLAN'=IBPLN
 . . . S IBIEN=0
 . . . F  S IBIEN=$O(^IBCNR(366.16,"AD",IBNDC,IBREJ,IBPLN,IBIEN)) Q:(IBIEN="")!(IBQ=1)  D
 . . . . D CHKP^IBNCDNC1 Q:IBQ
 . . . . D PRNLINE^IBNCDNC1(IBIEN,IBDAYS)
 Q
 ;---
 ;Check for non-covered drugs
 ;called from IBNCPDP1
 ;input:
 ;IBD array by reference
 ;return value:
 ;"" : submit to the payer
 ;"0^non- billable reason (IBRMARK text)" : do not submit - non covered drug
CHCK(IBD) ;
 N IBDAYS,IBC,IBPLAN
 S IBDAYS=$$RECHCKIN^IBNCDNC1()
 I IBDAYS=0 Q ""
 ;If the NONCOVERED DRUG functionality ON
 S IBC=$O(IBD("INS",""))  Q:'IBC ""  ; get the first insurance in COB order
 S IBPLAN=+$G(IBD("INS",+IBC,1)) Q:'IBPLAN ""  ; plan
 I $$CHECK^IBNCDNC($G(IBD("NDC")),IBPLAN,IBDAYS)=0 Q ""
 Q "0^NON COVERED DRUG PER PLAN"
 ;
 ;IBNCDNC
