VAFHLZCD ;ALB/KCL,Zoltan,JAN,TDM - Create HL7 Catastrophic Disability (ZCD) segment ; 9/19/05 11:31am
 ;;5.3;Registration;**122,232,387,653**;Aug 13, 1993;Build 2
 ;
 ;
 ; This generic extrinsic function is designed to return the
 ; HL7 Catastrophic Disability (ZCD) segment. This segment
 ; contains VA-specific catastrophic disability information
 ; for a patient.
 ;
EN(DFN,VAFSTR,VAFNUM,VAFHLQ,VAFHLFS) ; --
 ; Entry point for creating HL7 Catastrophic Disability (ZCD) segment. 
 ;     
 ;  Input(s):
 ;        DFN - internal entry number of Patient (#2) file
 ;     VAFSTR - (optional) string of fields requested, separated by
 ;              commas.  If not passed, return all data fields.
 ;     VAFNUM - (optional) sequential number for SET ID (default=1)
 ;     VAFHLQ - (optional) HL7 null variable
 ;    VAFHLFS - (optional) HL7 field separator
 ;
 ;  Performance Note:
 ;   VAFCDLST - Optional array (created by MAKELST subroutine below.)
 ;              In cases involving multiple ZCD segments, performance
 ;              is enhanced by calling MAKELST to create this array
 ;              before invoking this function.  This may not apply
 ;              in cases where BUILD is invoked to create multiple
 ;              ZCD segments.  
 ;
 ;  Other optional input variables:
 ;   HLQ      - HL7 default value to use when a sequence is empty.
 ;   HLFS     - HL7 default primary delimiter (between sequences.)
 ;
 ; Output(s):
 ;    String containing the desired components of the HL7 ZCD segment
 ;
 ; NOTE:
 ;    In cases where multiple diagnoses, procedures, and/or conditions
 ;    exist to support a status of CATASTROPHICALLY DISABLED, the
 ;    MAKELST subroutine (see below) is invoked to serialize them
 ;    (along with any related information) into separate ZCD
 ;    segments.  This function will return the text of a single
 ;    ZCD segment based on the segment number in VAFNUM.
 ;
 N VAFCAT,VAFY,X,SETID,VALOK,SUB
 ;
 ; if VAFHLQ or VAFHLFS not passed, use default HL7 variables
 I $D(VAFHLQ)[0 S VAFHLQ=$G(HLQ)
 I $G(VAFHLFS)="" S VAFHLFS=$G(HLFS,"^")
 ;
 ; if set id not passed, use default
 S VAFNUM=$S($G(VAFNUM):VAFNUM,1:1)
 ;
 ; if DFN not passed, exit
 I '$G(DFN) S VAFY=1 G ENQ
 ;
 ; get catastrophic disability info for a patient into VAFCAT
 I '$$GET^DGENCDA(DFN,.VAFCAT) S VAFY=1 G ENQ
 ; If sequence 13="Y" or "N", then sequences 2 through 6 are required.
 ; If sequence 13="" then sequences 2 through 6 should not be sent.
 S VALOK=1
 I VAFCAT("VCD")'="" F SUB="REVDTE","BY","FACDET","DATE","METDET" I $G(VAFCAT(SUB))="" S VALOK=0
 I 'VALOK F SUB="REVDTE","BY","FACDET","DATE","METDET","VCD" S VAFCAT(SUB)=""
 ;
 ; if VAFSTR not passed, return all data fields
 I $G(VAFSTR)="" S VAFSTR="1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16"
 ;
 ; initialize output string and requested data fields
 S $P(VAFY,VAFHLFS,$L(VAFSTR,","))=""
 S VAFSTR=","_VAFSTR_","
 ;
 ; Create a list to restrict multiple-valued fields to separate 
 ; segments.  For example, if there are any DIAG, PROC and COND
 ; entries, then no two of those values (or their associated sub-
 ; fields) may occupy the same ZCD segment.  (See MAKELST below 
 ; for implementation details.)
 I '$D(VAFCDLST) N VAFCDLST D MAKELST(.VAFCDLST,.VAFCAT)
 ;
 ; set-up segment data fields
 ; 1 - Set ID
 S SETID=$S($G(VAFNUM):VAFNUM,1:1)
 S $P(VAFY,VAFHLFS,1)=SETID
 ; 2 - Review Date
 I VAFSTR[",2," S $P(VAFY,VAFHLFS,2)=$S(VAFCAT("REVDTE")'="":$$HLDATE^HLFNC(VAFCAT("REVDTE")),1:VAFHLQ)
 ; 3 - Decided By
 I VAFSTR[",3," S $P(VAFY,VAFHLFS,3)=$S(VAFCAT("BY")'="":VAFCAT("BY"),1:VAFHLQ)
 ; 4 - Facility Making Determination
 I VAFSTR[",4," S X=$$STATION^VAFHLFNC(VAFCAT("FACDET")) S $P(VAFY,VAFHLFS,4)=$S(X'="":X,1:VAFHLQ)
 ; 5 - Date of Decision
 I VAFSTR[",5," S $P(VAFY,VAFHLFS,5)=$S(VAFCAT("DATE")'="":$$HLDATE^HLFNC(VAFCAT("DATE")),1:VAFHLQ)
 ; 6 - Method of Determination
 I VAFSTR[",6," S $P(VAFY,VAFHLFS,6)=$S(VAFCAT("METDET")'="":$$METH2HL7^DGENA5(VAFCAT("METDET")),1:VAFHLQ)
 ; 7 - Diagnosis (multiple)
 I VAFSTR[",7," S $P(VAFY,VAFHLFS,7)=$S($G(VAFCDLST(SETID,"DIAG"))'="":$$RSNTOHL7^DGENA5(VAFCDLST(SETID,"DIAG")),1:VAFHLQ)
 ; 8 - Procedure (multiple)
 I VAFSTR[",8," S $P(VAFY,VAFHLFS,8)=$S($G(VAFCDLST(SETID,"PROC"))'="":$$RSNTOHL7^DGENA5(VAFCDLST(SETID,"PROC")),1:VAFHLQ)
 ; 9 - Affected Extremity (Procedure sub-field)
 I VAFSTR[",9," S $P(VAFY,VAFHLFS,9)=$S($G(VAFCDLST(SETID,"EXT"))'="":$$LIMBTOHL^DGENA5(VAFCDLST(SETID,"EXT")),1:VAFHLQ)
 ; 10 - Condition (multiple)
 I VAFSTR[",10," S $P(VAFY,VAFHLFS,10)=$S($G(VAFCDLST(SETID,"COND"))'="":$$RSNTOHL7^DGENA5(VAFCDLST(SETID,"COND")),1:VAFHLQ)
 ; 11 - Score (Condition sub-field)
 I VAFSTR[",11," S $P(VAFY,VAFHLFS,11)=$S($G(VAFCDLST(SETID,"SCORE"))'="":VAFCDLST(SETID,"SCORE"),1:VAFHLQ)
 ; 12 - Veteran Catastrophically Disabled?
 I VAFSTR[",12," S $P(VAFY,VAFHLFS,12)=$S(VAFCAT("VCD")'="":VAFCAT("VCD"),1:VAFHLQ)
 ; 13 - Permanent Indicator (Condition sub-field)
 I VAFSTR[",13," S $P(VAFY,VAFHLFS,13)=$S($G(VAFCDLST(SETID,"PERM"))'="":$$PERMTOHL^DGENA5(VAFCDLST(SETID,"PERM")),1:VAFHLQ)
 ; 14 - Date Veteran Requested CD Evaluation
 I VAFSTR[",14," S $P(VAFY,VAFHLFS,14)=$S(VAFCAT("VETREQDT")'="":$$HLDATE^HLFNC(VAFCAT("VETREQDT")),1:VAFHLQ)
 ; 15 - Date Facility Initiated Review
 I VAFSTR[",15," S $P(VAFY,VAFHLFS,15)=$S(VAFCAT("DTFACIRV")'="":$$HLDATE^HLFNC(VAFCAT("DTFACIRV")),1:VAFHLQ)
 ; 16 - Date Veteran Was Notified
 I VAFSTR[",16," S $P(VAFY,VAFHLFS,16)=$S(VAFCAT("DTVETNOT")'="":$$HLDATE^HLFNC(VAFCAT("DTVETNOT")),1:VAFHLQ)
 ;
 S:$E(VAFSTR,1)="," VAFSTR=$E(VAFSTR,2,$L(VAFSTR))
 S:$E(VAFSTR,$L(VAFSTR))="," VAFSTR=$E(VAFSTR,1,$L(VAFSTR)-1)
ENQ Q "ZCD"_VAFHLFS_$G(VAFY)
 ;
 ; Subroutines follow...
MAKELST(VAFCDLST,VAFCAT) ; Make list of ZCD Segments.
 ; Inputs:
 ;  VAFCDLST - By reference (used to hold output array.)
 ;  VAFCAT   - By reference, an array containing the patient's CD
 ;             data (as created in $$GET^DGENCDA).
 ; Output:
 ;  VAFCDLST(Segment#,"DIAG") = CD Diagnosis (pointer to #27.17).
 ;  VAFCDLST(Segment#,"PROC")= CD Procedure(pointer to #27.17).
 ;  VAFCDLST(Segment#,"EXT") = Affected Extremity (for procedure).
 ;  VAFCDLST(Segment#,"COND")= CD Condition (pointer to #27.17).
 ;  VAFCDLST(Segment#,"PERM") = Permanent Indicator (for condition).
 ;  VAFCDLST(Segment#,"SCORE") = Test Score (for condition).
 ;
 ; Per Enrollment Phase II SRS (Section 4.2.4) no ZCD segment should
 ; contain more than one CD Reason (Diagnosis, Procedure, Condition.)
 ; So this procedure adds each one as a separate ZCD segment.
 ;
 N ITEM,SITEM,STR
 K VAFCDLST
 S VAFCDLST=0
 S (ITEM,SITEM)=""
 ; Add each Diagnosis as a separate ZCD segment.
 F  S ITEM=$O(VAFCAT("DIAG",ITEM)) Q:ITEM=""  D
 . D ADDNEW(.VAFCDLST,"DIAG",VAFCAT("DIAG",ITEM))
 ; Add each Procedure as a separate ZCD segment.
 F  S ITEM=$O(VAFCAT("PROC",ITEM)) Q:ITEM=""  D
 . F  S SITEM=$O(VAFCAT("EXT",ITEM,SITEM)) Q:SITEM=""  D
 .. D ADDNEW(.VAFCDLST,"PROC",VAFCAT("PROC",ITEM))
 .. D INSERT(.VAFCDLST,"EXT",VAFCAT("EXT",ITEM,SITEM))
 ; Add each Condition as a separate ZCD segment.
 F  S ITEM=$O(VAFCAT("COND",ITEM)) Q:ITEM=""  D
 . D ADDNEW(.VAFCDLST,"COND",VAFCAT("COND",ITEM))
 . D INSERT(.VAFCDLST,"SCORE",VAFCAT("SCORE",ITEM))
 . D INSERT(.VAFCDLST,"PERM",VAFCAT("PERM",ITEM))
 I VAFCDLST=0 S VAFCDLST=1 ; At least one ZCD segment.
 Q
ADDNEW(LIST,NAME,ITEM) ; Add an item to the list (internal use only).
 ; Inputs:
 ;   LIST - By reference, a list of items.
 ;   NAME - Name of one item to add.
 ;   ITEM - Value of item to add.
 ; Note: a new position is created in the list.
 S LIST=LIST+1
 S LIST(LIST,NAME)=ITEM
 Q
INSERT(LIST,NAME,ITEM) ; Insert item into existing list position (internal).
 ;  LIST - By reference, a list of items.
 ;  NAME - Name of one item to add.
 ;  ITEM - Value of item to add.
 ; Note: the list should already contain at least one item.
 S LIST(LIST,NAME)=ITEM
 Q
BUILD(VAFSEGS,DFN,VAFSTR,VAFHLQ,VAFHLFS) ;
 ; Entry point for creating HL7 Catastrophic Disability (ZCD) segments.
 ; This is the preferred entry point for building ZCD segments.
 ;     
 ;  Input(s):
 ;    VAFSEGS - Pass-by-reference array to contain all ZCD segments
 ;              for this patient.
 ;        DFN - internal entry number of Patient (#2) file
 ;     VAFSTR - (optional) string of fields requested, separated by
 ;              commas.  If not passed, return all data fields.
 ;     VAFHLQ - (optional) HL7 null variable
 ;    VAFHLFS - (optional) HL7 field separator
 ;
 ;  Output:
 ;    VAFSEGS - By reference, an array containing all ZCD segments.
 ;      Format:  VAFSEGS = Number of ZCD Segments
 ;               VAFSEGS(1) = First ZCD Segment
 ;               VAFSEGS(2) = Second ZCD Segment (if any)...
 ;               etc.
 ;
 ; NOTE:
 ;    Per Enrollment Phase II SRS (Section 4.2.4) no ZCD segment should
 ;    contain more than one CD Reason (Diagnosis, Procedure, Condition.)
 ;    As a result, multiple ZCD segments will be created if more than
 ;    one of these fields has a value.  The MAKELST procedure contains
 ;    logic to enforce this requirement.
 ;
 N VAFCDLST ; Temporary array of CD REASON info.
 K VAFSEGS S VAFSEGS=0 ; Initialize array.
 ; DFN is required.
 I '$G(DFN) Q
 ; get catastrophic disability info for a patient into VAFCAT
 I '$$GET^DGENCDA(DFN,.VAFCAT) Q
 ; Create a list VAFCDLST to enforce one CD REASON per segment.
 D MAKELST(.VAFCDLST,.VAFCAT)
 I 'VAFCDLST Q
 ; Create an array of HL7 segments.
 F VAFSEGS=1:1:VAFCDLST S VAFSEGS(VAFSEGS)=$$EN(DFN,.VAFSTR,VAFSEGS,.VAFHLQ,.VAFHLFS)
 Q
