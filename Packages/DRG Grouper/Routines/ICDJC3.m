ICDJC3 ;ALB/ARH - DRG GROUPER CALCULATOR 2015 - DRG SELECT ;05/26/2016
 ;;18.0;DRG Grouper;**89**;Oct 20, 2000;Build 9
 ;
 ; DRG Calcuation for re-designed grouper ICD-10 2015, continuation
 ;
 ;
DRGLS(ICDDATE,PRATT,DXATT,CDSET,DRGARR) ; get all possible DRGs and their MCC/CC defined by the event diagnosis, procedures and attributes
 ; DRGs are selected based on Code Sets, defined by the event diagnosis and procedures
 ; each DRG may have one or more sets of Code Sets (Cases) that lead to the DRG
 ; 
 ; selected DRGs have at least one DRG Case with all required Code Sets defined and following criteria met:
 ; a DRGs MDC must match the MDC of the events Primary diagnosis, except DRG MDCs 00 and 99
 ; a Medical DRG may not have an event OR procedure unless it is specifically assigned to the Case Code Set
 ; if a DRG Case includes an 'EXCEPT' Code Set (Set or Case level), that code set must not be defined by the event
 ; if a DRG Case requires Any OR procedure, it may not be satisfied by a code used to satisfy any other code set
 ; if a DRG Case requires a Secondary Dx then that Dxs MCC/CC may not affect the MCC/CC designation of that DRG
 ; when this occurs the MCC/CC applied to that specific DRG is updated and may be different than the event MCC/CC
 ;
 ; Input:   PRATT  - event Procedure Attributes array
 ;          DXATT  - event Diagnosis Attributes array
 ;          CDSET  - Code Sets defined by event Diagnosis and Procedures array
 ; Output:  DRGARR - array of DRGs (83.1) with at least one Case (83.2) defined by event Code Sets and attributes
 ;          DRGARR(drg ifn) = MCC or CC or null - DRG valid for event, applicable MCC/CC (event or DRG specific)
 ;          DRGARR(drg ifn, case ifn) [ 1 if Case is valid for event and selects the DRG
 ;          DRGARR(drg ifn, case ifn) [ 2 ^ MCC or CC or null if Case is valid for event and selects the DRG,
 ;                                      with a DRG specific MCC/CC that overrides the event MCC/CC
 ;          DRGARR(drg ifn, case ifn) [ 3 if there are any unassigned Operating Room Procedures for the Case
 N DRG0,SETIFN,CSEIFN,DRGIFN,MDCIFN,MDC0,CASEFND,RESET,ARRCSE,ARRDRG S DXATT=$G(DXATT),PRATT=$G(PRATT) K DRGARR
 ;
 ; get list of all potential DRGs: for each code set, find all cases, then for those cases find all drgs
 S SETIFN=0 F  S SETIFN=$O(CDSET(SETIFN)) Q:'SETIFN  D
 . S CSEIFN=0 F  S CSEIFN=$O(^ICDD(83.2,"ACS",SETIFN,CSEIFN)) Q:'CSEIFN  D
 .. S DRGIFN=0 F  S DRGIFN=$O(^ICDD(83.1,"ACE",CSEIFN,DRGIFN)) Q:'DRGIFN  S ARRDRG(DRGIFN)=""
 ;
 ; for each potential DRG check that all criteria is met and if at least one Case had all code sets fully defined
 S DRGIFN=0 F  S DRGIFN=$O(ARRDRG(DRGIFN)) Q:'DRGIFN  D
 . S DRG0=$G(^ICDD(83.1,DRGIFN,0)) S MDCIFN=+$P(DRG0,U,2),MDC0=$G(^ICDD(83,MDCIFN,0))
 . ;
 . I '$$DRGACT(+DRG0,$G(ICDDATE)) Q  ; is DRG active
 . ;
 . I $P(MDC0,U,2)'="00",$P(MDC0,U,2)'="99",$P(DXATT,U,2)'[$P(MDC0,U,2) Q  ; DRG MDC must match Primary Dx MDC
 . ;
 . D GETCSE(DRGIFN,$G(ICDDATE),.ARRCSE) S RESET=0 ; get active Cases associated with the DRG
 . ;
 . ; for each Case associated with a potential DRG, determine if it is defined by the event and meets criteria
 . S CSEIFN=0 F  S CSEIFN=$O(ARRCSE(CSEIFN)) Q:'CSEIFN  D
 .. ;
 .. S CASEFND=$$CSESET(MDCIFN,CSEIFN,.CDSET,.DXATT,.PRATT) Q:'CASEFND
 .. ;
 .. I +CASEFND[3,$P(DRG0,U,4)="M" Q  ; medical DRGs should not have OR procedures
 .. ;
 .. S DRGARR(DRGIFN,CSEIFN)=CASEFND
 .. S DRGARR(DRGIFN)=$S(+CASEFND[2&'RESET:$P(CASEFND,U,2),1:$P(DXATT,U,1)) I +CASEFND'[2 S RESET=1 ; 2nd Dx MCC/CC
 ;
 Q
 ;
DRGACT(DRG,DATE) ; get the status of the DRG on a date  DRG STATUS (#80.2,66,.03)
 ; input:  DRG - ptr to 80.2, DATE - date to determine status
 ; output: return true if the DRG is active on the date
 N DRGSB,DRGSTAT S (DRGSB,DRGSTAT)=0 I '$G(DATE) S DATE=DT
 I +$G(DRG) S DATE=DATE+.0001 S DATE=+$O(^ICD(+DRG,66,"B",DATE),-1) S DRGSB=$O(^ICD(+DRG,66,"B",+DATE,0))
 I +DRGSB S DRGSTAT=+$P($G(^ICD(+DRG,66,DRGSB,0)),U,3)
 Q DRGSTAT
 ;
GETCSE(DRGIFN,DATE,ARRCSE) ; get all active Cases associated with the DRG (83.1,10)
 ; input:  DRGIFN - ptr to mdc drg (83.1)
 ; output: ARRCSE(case ifn (83.2)) = DRGIFN - array of active Cases (83.2) linked to the DRG (83.1)
 N IX,LINE,BEGIN,END S DRGIFN=+$G(DRGIFN) K ARRCSE I '$G(DATE) S DATE=DT
 ;
 S IX=0 F  S IX=$O(^ICDD(83.1,DRGIFN,10,IX)) Q:'IX  D
 . S LINE=$G(^ICDD(83.1,DRGIFN,10,IX,0)) Q:'LINE
 . S BEGIN=$P(LINE,U,1),END=$P(LINE,U,2) I 'END S END=9999999
 . I DATE'<BEGIN,DATE'>END S ARRCSE(+$P(LINE,U,3))=DRGIFN
 Q
 ;
CSESET(MDCIFN,CSEIFN,CDSET,DXATT,PRATT) ; determine if a Case is fully satisfied by the event
 ; all Code Sets required by a Case have event codes assigned (CDSET) and satisfy the criteria
 ; input:  MDCIFN - ptr to DRGs MDC (83),  CSEIFN - ptr to a Case (83.2)
 ; output: return true if all the code sets for the case have event codes assigned and meet the criteria
 ;         1 if all case codes sets and criteria satisfied, MCC/CC not affected
 ;         3 if any Operating Room Procedures unassigned to a case code set
 ;         2 ^ MCC or CC or null if all case code sets and criteria satisfied and reset the MCC/CC for the DRG
 ; a code set identified as EXCEPT, at case or set level, invalidates the case, unless AnyOR overrides it
 ; the codes used to satisfy the ANY OR Procedure Code Set must not be used to satisfy any other case code set
 ; clusters apply within the MDC of its Set and if no other procedure is necessary to select the case
 ; therefore a cluster with members incompletely assigned to the case may override the selection
 ; if a Secondary Diagnosis is used to select the DRG then its MCC/CC are removed from the DRGs MCC/CC
 N IX,LINE,SETIFN,SET0,LINK,LNKSET,EXCEPT,ANYOR,EXTRAOR,DXSND,ARRSET,FND S CSEIFN=+$G(CSEIFN) S FND=0
 ;
 ; get all code sets required by a Case, add linked sets with codes assigned so all criteria can be applied
 S IX=0 F  S IX=$O(^ICDD(83.2,CSEIFN,10,IX)) Q:'IX  D
 . S LINE=$G(^ICDD(83.2,CSEIFN,10,IX,0)),SETIFN=+LINE S SET0=$G(^ICDD(83.3,SETIFN,0))
 . ;
 . S ARRSET(SETIFN)=LINE
 . I $P(SET0,U,6)>3 S LINK=$P(SET0,U,7) I LINK'="" D  ; unpack linked sets
 .. S LNKSET=0 F  S LNKSET=$O(^ICDD(83.3,"ACSL",LINK,LNKSET)) Q:'LNKSET  I $O(CDSET(LNKSET,0)) S ARRSET(LNKSET)=LINE
 ;
 S (FND,ANYOR,DXSND)=0 S SETIFN=$O(^ICDD(83.3,"ACSC",1,0)) I $D(ARRSET(SETIFN)) S ANYOR=1 ; ANY OPERATING ROOM PROCEDURE
 ;
 ; for each Code Set required by the Case, check if it is defined for the event and passes all criteria
 S SETIFN=0 F  S SETIFN=$O(ARRSET(SETIFN)) Q:'SETIFN  D  Q:'FND
 . S LINE=ARRSET(SETIFN) S SET0=$G(^ICDD(83.3,SETIFN,0))
 . I $P(SET0,U,3)="DX",$P(SET0,U,4)'="P" S DXSND=1 ; a specific secondary dx is required for set
 . ;
 . S FND=1
 . ;
 . S EXCEPT=0 I ($P(LINE,U,2)=1)!($P(SET0,U,5)=1) S EXCEPT=1 I '$D(CDSET(SETIFN)) Q  ; code set except not defined
 . I EXCEPT I ($P(SET0,U,3)'="PR")!('ANYOR) S FND=0 Q  ; code set except exists, may be overriden by Any OR Procedure
 . ;
 . I '$D(CDSET(SETIFN)) S FND=0 Q  ; code set required for case is not found
 ;
 ; if a Case is selected by individual Code Sets, check Case for relationships between Code Sets
 ;
 I FND S EXTRAOR=$$PRCOR($G(MDCIFN),.ARRSET,.CDSET,.PRATT) I +EXTRAOR S FND=FND_3 ; OR Procedures unassigned
 ;
 I FND,ANYOR,'EXTRAOR S FND=0 ; No OR Procedure unassigned, fails ANY OR set
 ;
 I FND,'$$PRCLS($G(MDCIFN),.ARRSET,.CDSET) S FND=0 ; Procedure Cluster incompletely used by a set
 ; 
 I FND,DXSND S DXSND=$$DXSND(.ARRSET,.CDSET,.DXATT) I +DXSND=2 S FND=FND_DXSND ; Secondary selects case, reset MCC/CC
 ;
 Q FND
 ;
PRCOR(DRGMDCFN,ARRSET,CDSET,PRATT) ; determine if any event OR Procedures are unassigned or unused
 ; input:  ARRSET(SETIFN) - all code sets that define the case, codes assigned to these sets are considered used
 ; output: returns true if any event OR Procedure codes are unused - not assigned to any of the cases code sets
 ; checks if any OR procedure is unassigned to the Case Sets, excludes generic code sets like Any OR
 ; also excludes members of clusters defined outside the DRGs MDC that are cluster members only, not singles
 N LINE,IX,M0,DRGCAT,DRGMDC,SETIFN,SETCAT,SETMDC,FND,ARRCDX S FND=0
 S M0=$G(^ICDD(83,+$G(DRGMDCFN),0)) S DRGCAT=$P(M0,U,1),DRGMDC=$P(M0,U,2)
 ;
 ; get all event procedure codes assigned to the cases procedure code sets (non-generic)
 S SETIFN=0 F  S SETIFN=$O(ARRSET(SETIFN)) Q:'SETIFN  D
 . S LINE=$G(^ICDD(83.3,SETIFN,0)) I $P(LINE,U,3)="PR",+$P(LINE,U,2) D
 .. S M0=$G(^ICDD(83,+$P(LINE,U,2),0)) S SETCAT=$P(M0,U,1),SETMDC=$P(M0,U,2)
 .. S IX=0 F  S IX=$O(CDSET(SETIFN,IX)) Q:'IX  I (DRGMDC=SETMDC)!($P(CDSET(SETIFN,IX),U,3)) S ARRCDX(IX)=""
 ;
 ; find if any event OR procedure is not assigned to the case code sets
 S IX=0 F  S IX=$O(PRATT(IX)) Q:'IX  I $P(PRATT(IX),U,2)="O",'$D(ARRCDX(IX)) S FND=1 Q
 ;
 Q FND
 ;
PRCLS(DRGMDCFN,ARRSET,CDSET) ; deterime if a cluster is defined by the event and affects the case
 ; procedures within a cluster must all exist for the cluster to satisfy a set
 ; the cluster applies only within the MDC of its Set and if no other procedure is necessary to select the case
 ; input:  ARRSET(SETIFN) - all code sets that define the case, codes assigned to these sets are considered used
 ; output: returns true (1) if a procedure cluster does not invalidate the set
 ;         returns false (0) if cluster is defined and invalidates the case
 ; if a cluster is defined by the event, it may or may not need to be fully assigned to the case sets
 ; when applied to cases, the clusters individual procedures may be used outside the clusters MDC or if there
 ; are non-cluster procedures necessary to select the case
 N IX,M0,DRGCAT,DRGMDC,SETIFN,SET0,SETCAT,SETMDC,CLSTR,ARRCDX,ARRCLS,FND S FND=1
 S M0=$G(^ICDD(83,+$G(DRGMDCFN),0)) S DRGCAT=$P(M0,U,1),DRGMDC=$P(M0,U,2)
 ;
 ; find event procedures that satisfy the Case procedure Sets, Case MDC and Category
 S SETIFN=0 F  S SETIFN=$O(ARRSET(SETIFN)) Q:'SETIFN  D
 . S SET0=$G(^ICDD(83.3,SETIFN,0)) I $P(SET0,U,3)="PR" S IX=0 F  S IX=$O(CDSET(SETIFN,IX)) Q:'IX  S ARRCDX(IX)=""
 ;
 ; find event procedure clusters in the Case MDC but not assigned to the Case MDC Category (not used)
 I $O(ARRCDX(0)) S SETIFN=0 F  S SETIFN=$O(CDSET(SETIFN)) Q:'SETIFN  D
 . S IX=0 F  S IX=$O(CDSET(SETIFN,IX)) Q:'IX  S CLSTR=$P(CDSET(SETIFN,IX),U,4) I +CLSTR  D
 .. S SET0=$G(^ICDD(83.3,SETIFN,0)) S M0=$G(^ICDD(83,+$P(SET0,U,2),0)) S SETCAT=$P(M0,U,1),SETMDC=$P(M0,U,2)
 .. I SETMDC=DRGMDC,SETCAT'=DRGCAT S ARRCLS(IX)=""
 ;
 ; reject if event cluster is not used to satisfy the Case unless there is also a non-cluster procedure required
 I +FND S IX=0 F  S IX=$O(ARRCLS(IX)) Q:'IX  I '$D(ARRCDX(IX)) S FND=0 ; not all cluster proc defined for event
 I 'FND S IX=0 F  S IX=$O(ARRCDX(IX)) Q:'IX  I '$D(ARRCLS(IX)) S FND=1 ; non-cluster proc defined, overrides cluster
 Q FND
 ;
DXSND(ARRSET,CDSET,DXATT) ; get updated DRG MCC/CC if a Secondary Dx was used to select the DRG Case
 ; if an event diagnosis is assigned to a cases secondary dx code set then remove its MCC/CC from the DRGs MCC/CC
 ; input:  ARRSET(SETIFN) - all code sets that define the case, codes assigned to these sets are considered used
 ; output: 2 ^ MCC or CC or null - updated DRG MCC/CC
 ;         null if secondary dx code sets did not affect the MCC/CC
 ; if a Secondary Diagnosis is used to select the DRG then its MCC/CC may not be used for the DRGs MCC/CC
 N SETIFN,LINE,IX,NEWMCC,DXCC,FND,ARRCDX S NEWMCC="",FND=""
 ;
 ; get secondary event diagnosis codes assigned to the cases secondary dx code sets
 S SETIFN=0 F  S SETIFN=$O(ARRSET(SETIFN)) Q:'SETIFN  S LINE=$G(^ICDD(83.3,SETIFN,0)) D
 . I $P(LINE,U,3)="DX" S IX=0 F  S IX=$O(CDSET(SETIFN,IX)) Q:'IX  I IX'=$O(DXATT(0)) S ARRCDX(IX)=""
 ;
 ; if an event diagnosis is assigned to a case secondary dx code set then remove its MCC/CC from use on the DRG
 ; recalculate the MCC/CC based on the event diagnosis not assigned to the cases secondary dx code sets
 I $O(ARRCDX(0)) S NEWMCC="" S IX=0 F  S IX=$O(DXATT(IX)) Q:'IX  D  I NEWMCC="MCC" Q
 . S DXCC=$P(DXATT(IX),U,7) I DXCC'="",'$D(ARRCDX(IX)) S NEWMCC=DXCC
 ;
 I $O(ARRCDX(0)),NEWMCC'=$P(DXATT,U,1) S FND=2_U_NEWMCC
 ;
 Q FND
