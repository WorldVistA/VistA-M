VIABRPC3 ;AAC/PB - VIA RPCs ;10/06/2016
 ;;1.0;VISTA INTEGRATION ADAPTER;**9,20**;06-FEB-2014;Build 5
 ;Per VA Directive 6402, this routine should not be modified.
 ;Reference to ^SC( supported by IA 10040
 ;Reference to XPAR APIS supported by IA 2263
 ;Reference to PSSP51P supported by IA 4546
 ;Reference to ^LAB(61 supported by IA 2388
 ;Reference to $$VALID^LR7OV4 supported by IA 2429#
 ; supported ICRs below.
 ;Reference to ^%DTC supported by IA # 10003
 ;Reference to $$FIND1^DIC supported by IA #2051
 ;Reference to GETS^DIQ supported by IA 2056#
 ;Reference to ^XLFDT supported by IA #10103
 ;Reference to ^XPAR supported by IA #2263
 ;Reference to DEM^VADPT supported by IA #10061
 ;
 ; This is routine contains several OR RPCs that have been cloned into the VIAB namespace
 Q
 ;
ALLSPEC(RESULT,FROM,DIR) ; Return a set of specimens from topography file, clonded from ORWDLR32 ALLSPEC RPC
 ;Called by VIAB ALLSPEC RPC
 ;RESULT - Return results IEN for the entry in File 61 ^ .01 FIELD for the entry in File 61 (SNOMED CODE)
 ;Input 
 ;FROM - starting point of the search
 ;DIR - Direction to search, forwards or backwards in the cross reference
 ;Returns the first 44 entries starting from the FROM parameter. 
 N I,IEN,CNT,A,%,NOW,B
 D NOW^%DTC S NOW=$P(%,".")
 S I=0,CNT=44
 F  Q:I'<CNT  S FROM=$O(^LAB(61,"B",FROM),DIR) Q:FROM=""  D
 . S IEN=0 F  S IEN=$O(^LAB(61,"B",FROM,IEN)) Q:'IEN  D
 . . S A=$G(^LAB(61,IEN,64.91)) S B=$P(A,"^",3) I B]"",B'>NOW Q
 . . S I=I+1,RESULT(I)=IEN_U_FROM_"  ("_$P($G(^LAB(61,IEN,0)),U,2)_")"
 Q
 ;
GETLABTM(RESULT,VIADATE,VIALOC) ;Return list of lab collect times for a date and location
 ;Called by VIAB GET LAB TIMES
 ;This RPC is a similar to ORWDLR32 GET LAB TIMES
 ;RESULT - Returns the results
 ;Input:
 ;VIADATE - order datetime
 ;VIALOC - IEN for the location in the Hospital Location File (#44)
 N VIADA,VIATI,VIANOW,VIADOW,X,%,%H
 S RESULT(0)=0 Q:'$G(VIADATE)!($G(VIADATE)<0)!('$G(VIALOC))
 S VIADA=$P(VIADATE,".",1)
 S VIANOW=$$NOW^XLFDT,VIATI=$P(VIANOW,".",2)
 I VIADA<$P(VIANOW,".",1) S RESULT(0)="-1^Dates in the past are not allowed." Q
 I '+$$GET^XPAR(VIALOC_";SC(","LR EXCEPTED LOCATIONS",1,"Q") D
 . S X=VIADA D DW^%DTC S VIADOW=X
 . I '+$$GET^XPAR("ALL","LR COLLECT "_VIADOW,1,"Q") S RESULT(0)="-1^No collections on "_VIADOW Q
 . I '+$$GET^XPAR("ALL","LR IGNORE HOLIDAYS",1,"Q"),$D(^HOLIDAY(VIADA,0)) S RESULT(0)="-1^No holiday collections" Q
 I +RESULT(0)>-1 D 
 . D GETLST^XPAR(.RESULT,"ALL","LR PHLEBOTOMY COLLECTION","Q")
 . I +$G(RESULT)=0 S RESULT(0)="-1^No lab collect times defined for this division" Q
 S I=0 F  S I=$O(RESULT(I)) Q:'I  D
 . D NOW^%DTC S VIATI=%,%H=+%H_","_+RESULT(I) D YMD^%DTC
 . I (VIADA=$P(VIATI,".",1)),(+(VIADA+%)<+VIATI) K RESULT(I) S RESULT=RESULT-1 Q   ; cutoff time has passed for this collect time
 . S RESULT(I)=$P(RESULT(I),U,2)
 I +$G(RESULT)=0,('$D(RESULT(0))) S RESULT(0)="-1^All of today's collection times have passed."
 Q
 ;
LOCTYPE(RESULT,VIALOC) ; Returns type of location (C,W)
 ;Called by VIAB LOC TYPE RPC
 ;Returns C for Clinic or W for Ward, if the location is not a Ward or Clinic returns a -1
 ;Input:
 ;VIALOC = IEN for the location in the Hospital Location File ($44)
 S RESULT=-1
 Q:$G(VIALOC)=""
 S RESULT=$P($G(^SC(+$G(VIALOC),0)),U,3)
 Q
 ;
DOWSCH(RESULT,DFN,LOCIEN)     ; return all schedules
 ;Called by VIAB DOWSCH
 ;This RPC is a similar to ORWDPS1 DOWSCH
 ;DFN - Patient DFN
 ;LOCIEN - IEN for the location in the Hospital Location File (#44)
 N CNT,FREQ,ILST,VIABARRAY,WIEN
 S WIEN=$$WARDIEN(+$G(LOCIEN))
 D SCHED^PSS51P1(WIEN,.VIABARRAY)
 S ILST=0
 S CNT=0 F  S CNT=$O(VIABARRAY(CNT)) Q:CNT'>0  D
 .N NODE
 .S NODE=$G(VIABARRAY(CNT))
 .I $P(NODE,U,4)="C" D
 ..K ^TMP($J,"VIABRPC3 DOWSCH")
 ..D ZERO^PSS51P1($P(NODE,U),,,,"VIABRPC3 DOWSCH")
 ..S FREQ=$G(^TMP($J,"VIABRPC3 DOWSCH",$P(NODE,U),2))
 ..K ^TMP($J,"VIABRPC3 DOWSCH")
 ..I +FREQ=0 Q
 ..I +FREQ>1440 Q
 ..S ILST=ILST+1,RESULT(ILST)=$P(VIABARRAY(CNT),U,2,5)
 Q
 ;
WARDIEN(LOCIEN) ;
 N RESULT
 S RESULT=0
 I LOCIEN=0 Q RESULT
 I $P($G(^SC(LOCIEN,42)),U)="" Q RESULT
 S RESULT=+$P($G(^SC(LOCIEN,42)),U)
 Q RESULT
 ;
LCFUTR(RESULT,VIALOC,VIADIV)  ;Get # of days for future Lab Collects
 ;Called by VIAB FUTURE LAB COLLECTS
 ;This RPC is a similar to ORWDLR33 FUTURE LAB COLLECTS
 ; For Event Delay Order
 ;  --VIALOC Event default location
 ;  --VIADIV Event default division
 S RESULT=0
 Q:'$$FIND1^DIC(8989.51,,"X","LR LAB COLLECT FUTURE","B")
 I $G(VIADIV) S RESULT=+$$GET^XPAR(+$G(VIALOC)_";SC("_"^"_+$G(VIADIV)_";DIC(4,^SYS^PKG","LR LAB COLLECT FUTURE",1,"I")
 E  S RESULT=+$$GET^XPAR(+$G(VIALOC)_";SC("_"^DIV^SYS^PKG","LR LAB COLLECT FUTURE",1,"I")
 Q
 ;
ICVALID(RESULT,VIATIME) ;Is the time a valid immediate collect time?
 ;Called by VIAB IC VALID
 ;This RPC is a similar to ORWDLR32 IC VALID
 ;VIATIME - Date/time in FileMan format
 S VIATIME=$P(VIATIME,".",1)_"."_$E($P(VIATIME,".",2),1,4)
 S RESULT=$$VALID^LR7OV4(DUZ(2),VIATIME)
 Q
 ;
DEATEXT(RESULT) ;returns the mandatory dea text to show when a user checks a controlled substance order to be signed on the signature dialog
 ;Called by VIAB DEATEXT
 ;This RPC is a similar to ORDEA DEATEXT
 N I,VIAY
 D GETWP^XPAR(.VIAY,"SYS","OR DEA TEXT")
 S I=0 F  S I=$O(VIAY(I)) Q:'I  S RESULT(I)=VIAY(I,0)
 Q
 ;
GETDEM(RESULT,DFN) ; GET PATIENT DEMOGRAPHICS (Supported (#10061) DEM^VADPT API Call, PIMS Technical manual)
 ;INPUT DFN (REQUIRED)
 ;RETURNS RESULT ARRAY IN FORMAT OF:
 ;RESULT(1) The NAME of the patient. (e.g., ADTPATIENT,ONE)
 ;RESULT(2) The SSN of the patient in internal^external format.
 ;RESULT(3) The DOB of the patient in internal^external format.
 ;RESULT(4) The AGE of the patient as of today, unless a date of death exists, in which case the age returned will be as of that date. (e.g., 36)
 ;RESULT(5) The SEX of the patient in internal^external format. (e.g., M^MALE)
 ;RESULT(6) The DT Of Death of the patient, should one exist, in internal^external format.
 ;RESULT(7) Any REMARKS concerning this patient which may be on file. (e.g., Need to obtain dependent info.)
 ;RESULT(8) (Deprecated - see RESULT(12))
 ;RESULT(9) The RELIGION of the patient in internal^external format. (e.g., 99^CATHOLIC)
 ;RESULT(10) The MARITAL STATUS of the patient in internal^external format. (e.g., 1^MARRIED)
 ;RESULT(11) Number of entries found in the ETHNICITY INFORMATION multiple. (e.g., 1) 
 ;  "," Nth repetition of ETHNICITY INFORMATION for the patient in internal^external format. (e.g., 1^HISPANIC OR LATINO)
 ;    "," METHOD OF COLLECTION for the Nth repetition of ETHNICITY
 ;RESULT(12) Number of entries found in the RACE INFORMATION multiple.
 ;  "," Nth repetition of RACE INFORMATION for the patient in internal^external format. (e.g., 11^WHITE)
 ;    "," METHOD OF COLLECTION for the Nth repetition of RACE INFORMATION for the patient in internal^external format. (e.g., 2^PROXY))
 ;RESULT(13) Patients' current pt preferred language (FM version^human readable)
 ;  "," Pointer^human readable
 ;RESULT("BID") The PRIMARY SHORT ID for a patient. The format of this variable will depend on the type of patient if VAPTYP is set. (e.g., 6789)
 ;RESULT("PID") The PRIMARY LONG ID for a patient. The format of this variable will depend on the type of patient if VAPTYP is set. (e.g., 000-45-6789)
 ;Global Array will send data to webservice without array subscripts
 ;
 I $G(DFN)="" S RESULT(0)="DFN REQUIRED - NOT RECEIVED" Q
 S RESULT=$NA(^TMP("VIABDEM",$J))
 D DEM^VADPT
 M ^TMP("VIABDEM",$J)=VADM K VADM
 M ^TMP("VIABDEM",$J)=VA K VA
 Q
 ;
