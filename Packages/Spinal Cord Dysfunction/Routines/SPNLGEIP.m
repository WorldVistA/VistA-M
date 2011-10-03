SPNLGEIP ; ISC-SF/GMB - SCD GATHER INPATIENT ADMISSIONS DATA;17 MAY 94 [ 09/01/94  6:23 AM ] ;6/23/95  11:22
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
EXTRACT(DFN,FDATE,TDATE,CLEARTXT,ABORT) ;
 ; This entry point is to be used solely for gathering data to be sent
 ; to the national registry.
 ; DFN       Patient's internal entry number in the Patient file
 ; FDATE     "From" date
 ; TDATE     "Thru" date, default=today
 ; CLEARTXT  1=translate all codes to their meaning,
 ;           0=don't translate codes (default=0)
 N RECNR,NODE0,NODE70,ZDD,ZAD
 I '$D(TDATE) S TDATE=DT
 I '$D(CLEARTXT) S CLEARTXT=0
 ; We will take only those admissions whose discharge date is within
 ; the desired date range.
 S RECNR=""
 F  S RECNR=$O(^DGPT("B",DFN,RECNR)) Q:RECNR=""  D
 . S NODE0=$G(^DGPT(RECNR,0))
 . Q:$P(NODE0,U,11)'=1  ; 1=PTF record, 2=census record
 . S NODE70=$G(^DGPT(RECNR,70))
 . S ZDD=$P(NODE70,U,1)\1 Q:ZDD=0  ; Discharge date
 . Q:ZDD<FDATE!(ZDD>TDATE)
 . S ZAD=$P(NODE0,U,2)\1 Q:ZAD=0  ; Admit date
 . D ADMIT(ZAD,ZDD,NODE70,CLEARTXT)
 . D BSMOVE(RECNR,ZAD)
 . D SURGERY(RECNR,ZAD)
 . D NONSURG(RECNR,ZAD)
 Q
ADMIT(ZAD,ZDD,NODE70,CLEARTXT) ;  deal with inpatient admission data
 N TYPEDISP,BEDSECN,ICDCODES,PIECE
 S TYPEDISP=$P(NODE70,U,3)
 I CLEARTXT S TYPEDISP=$$TRANSLAT^SPNLGU(TYPEDISP,45,72)
 S BEDSECN=$P($G(^DIC(42.4,+$P(NODE70,U,2),0)),U,1)
 S ICDCODES=""
 F PIECE=10,16:1:24 D  ; get the ICD codes
 . S ICDCODES=ICDCODES_"^"_$P($G(^ICD9(+$P(NODE70,U,PIECE),0)),U,1)
 D ADDREC^SPNLGE("IP",ZAD_"^"_ZDD_"^"_BEDSECN_"^"_TYPEDISP_ICDCODES)
 Q
BSMOVE(RECNR,MOVEOUT) ; deal with inpatient bedsection movement
 N SUBRECNR,MOVEIN,NODE0,BEDSECN,ICDCODES,PIECE,MOVEDATE
 S MOVEDATE=""
 F  S MOVEDATE=$O(^DGPT(RECNR,"M","AM",MOVEDATE)) Q:MOVEDATE'>0  D
 . S SUBRECNR=$O(^DGPT(RECNR,"M","AM",MOVEDATE,0))
 . S MOVEIN=MOVEOUT
 . S MOVEOUT=MOVEDATE\1
 . S NODE0=$G(^DGPT(RECNR,"M",SUBRECNR,0))
 . S BEDSECN=$P($G(^DIC(42.4,+$P(NODE0,U,2),0)),U,1)
 . S ICDCODES=""
 . F PIECE=5:1:9,11:1:15 D  ; get ICD codes
 . . S ICDCODES=ICDCODES_"^"_$P($G(^ICD9(+$P(NODE0,U,PIECE),0)),U,1)
 . D ADDREC^SPNLGE("IPM",MOVEIN_"^"_MOVEOUT_"^"_BEDSECN_ICDCODES)
 Q
SURGERY(RECNR,ZAD) ; deal with inpatient surgical procedures
 N SUBRECNR,NODE0,PDATE,PCODES,PIECE
 S SUBRECNR=0
 F  S SUBRECNR=$O(^DGPT(RECNR,"S",SUBRECNR)) Q:SUBRECNR'>0  D
 . S NODE0=$G(^DGPT(RECNR,"S",SUBRECNR,0))
 . S PDATE=$P(NODE0,U,1) ; procedure (operation) date
 . S PCODES=""
 . F PIECE=8:1:12 D  ; get procedure codes
 . . S PCODES=PCODES_"^"_$P($G(^ICD0(+$P(NODE0,U,PIECE),0)),U,1)
 . D ADDREC^SPNLGE("IPS",ZAD_"^"_PDATE_PCODES)
 Q
NONSURG(RECNR,ZAD) ; deal with inpatient non-surgical procedures
 N SUBRECNR,NODE0,PDATE,BEDSECN,PCODES,PIECE
 S SUBRECNR=0
 F  S SUBRECNR=$O(^DGPT(RECNR,"P",SUBRECNR)) Q:SUBRECNR'>0  D
 . S NODE0=$G(^DGPT(RECNR,"P",SUBRECNR,0))
 . S PDATE=$P(NODE0,U,1)\1 ; procedure date
 . S BEDSECN=$P($G(^DIC(42.4,+$P(NODE0,U,2),0)),U,1)
 . S PCODES=""
 . F PIECE=5:1:9 D  ; get procedure codes
 . . S PCODES=PCODES_"^"_$P($G(^ICD0(+$P(NODE0,U,PIECE),0)),U,1)
 . D ADDREC^SPNLGE("IPP",ZAD_"^"_PDATE_PCODES)
 Q
