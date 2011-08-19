PXRHS14 ;ISL/SBW - PCE Visit data extract routine ;7/25/96  09:06
 ;;1.0;PCE PATIENT CARE ENCOUNTER;;Aug 12, 1996
 ; Extract returns visit data in block of OCCLIM. Can be called multiple
 ; times for a patient. Parameter passing by reference with FROM and
 ; RECNO variables allows the routine to process multiple calls without
 ; missing data.
VISIT(DFN,FROM,RECNO,OCCLIM,CATCODE,PSTAT) ; Control branching
 ;INPUT:   DFN      - Pointer to PATIENT file (#2).
 ;         FROM     - Index entry from which to begin the list.
 ;                    Passed by reference.
 ;         RECNO    - Record number. Passed by reference.
 ;                  - Should be null for 1st call to this entry point.
 ;         OCCLIM   - Maximum number of visits to return.
 ;         CATCODE  - Pattern Match which controls visit data that is
 ;                    returned (Can include multiple codes).
 ;               A = AMBULATORY
 ;               H = HOSPITALIZATION
 ;               I = IN HOSPITAL
 ;               C = CHART REVIEW
 ;               T = TELECOMMUNICATIONS
 ;               N = NOT FOUND
 ;               S = DAY SURGERY
 ;               O = OBSERVATION
 ;               E = EVENT (HISTORICAL)
 ;               R = NURSING HOME
 ;               D = DAILY HOSPITALIZATION DATA
 ;               X = ANCILLARY PACKAGE DAILY DATA
 ;         PSTAT    - Patient Status.
 ;               1         = Inpatient
 ;               0 or NULL = Outpatient
 ;
 ;OUTPUT: 
 ;  Data from VISIT (9000010) file except for hosp. loc. abbr.
 ;  ^TMP("PXV",$J,InvExDt,RecNo,0) = VISIT/ADMIT DATE&TIME [I;.01]
 ;    ^ LOC. OF ENCOUNTER [E;.06] ^ SERVICE CATEGORY [E;.07] 
 ;    ^ CLINIC [E;.08] ^ WALK IN/APPT (deleted field always null)[E;.16] 
 ;    ^ EVALUATION AND MANAGEMENT CODE (deleted field always null)[E;.17]
 ;    ^ HOSPITAL LOCATION [E;.22]
 ;
 ;   [] = [I(nternal)/E(xternal); Field #]
 ;   Subscripts:
 ;     InvExDt - Inverted Visit Date from "AA" x-ref
 ;     RecNo   - Record Number
 ;
 ; Calling routine is required to delete ^TMP("PXV",$J). It can be
 ; deleted between multiple calls to this entry point or after
 ; the calling routine makes the last call depending on how the data
 ; needs to be accumulated.
 Q:$G(DFN)']""!'$D(^AUPNVSIT("AA",DFN))
 N PXCNT,FIRST
 N DIC,DIQ,DR,DA,VISIT,LOC,SERCAT,CLINIC,WALKAPT,LEVEL,HLOC
 S FIRST=1
 S:+$G(OCCLIM)'>0 OCCLIM=999
 S:+$G(FROM)'>0 FROM=""
 S:+$G(RECNO)'>0 RECNO=""
 S PXCNT=0
 F  S:(RECNO=""!'FIRST) FROM=$O(^AUPNVSIT("AA",DFN,FROM)) Q:+FROM'>0  D  Q:PXCNT'<OCCLIM
 . I 'FIRST S RECNO=0
 . S FIRST=0
 . F  S RECNO=$O(^AUPNVSIT("AA",DFN,FROM,RECNO)) Q:+RECNO'>0  D  Q:PXCNT'<OCCLIM
 . . N REC
 . . S DIC=9000010,DA=RECNO,DIQ="REC(",DIQ(0)="IE"
 . . S DR=".01;.06;.07;.08;.09;.11;.22;15002"
 . . D EN^DIQ1
 . . Q:'$D(REC)
 . . Q:$G(CATCODE)'[REC(9000010,DA,.07,"I")!(REC(9000010,DA,.09,"I")'>0)!+(REC(9000010,DA,.11,"I"))!(+$G(PSTAT)'=+REC(9000010,DA,15002,"I"))
 . . S VISIT=REC(9000010,DA,.01,"I")
 . . S LOC=REC(9000010,DA,.06,"E")
 . . S SERCAT=REC(9000010,DA,.07,"E")
 . . S CLINIC=REC(9000010,DA,.08,"E")
 . . ;- return null for deleted fields .16 and .17
 . . S WALKAPT="" ;REC(9000010,DA,.16,"E")
 . . S LEVEL="" ;REC(9000010,DA,.17,"E")
 . . S HLOC=REC(9000010,DA,.22,"E")
 . . S ^TMP("PXV",$J,FROM,RECNO)=VISIT_U_LOC_U_SERCAT_U_CLINIC_U_WALKAPT_U_HLOC
 . . S PXCNT=PXCNT+1
 Q
