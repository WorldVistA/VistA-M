DGENCDA1 ;ALB/CJM,RMM Zoltan,JAN,PHH,BRM,CKN,DJS - Catastrophic Disabilty API - File Data;Sep 16, 2002 ; 9/22/05 5:25pm
 ;;5.3;Registration;**121,147,232,302,356,387,475,451,653,894**;Aug 13,1993;Build 48
 ;
 ; DG*5.3*894 - Enhance Catastrophic Disability to use Descriptors rather than Diagnoses/Procedures/Conditions.
 ;
LOCK(DFN) ;
 ;Description: Locks the catastrophic disability record for a patient
 ;Input:
 ;  DFN - Patient IEN
 ;Output:     
 ;  Function Value - returns 1 if the patient is catastrophic disability
 ;     record can be locked, otherwise 0
 I $G(DFN) L +^DPT(DFN,.39):2
 Q $T
 ;
UNLOCK(DFN) ;
 ;Description: Unlocks the catastrophic disability record for a patient
 ;Input:
 ;  DFN - Patient IEN
 ;Output:     
 ;  None
 I $G(DFN) L -^DPT(DFN,.39)
 Q
 ;
CHECK(DGCDIS,ERROR) ;
 ;Description: Validity checks on the catastrophic disability contained
 ;   in the DGCDIS array
 ;Input:
 ;  DGCDIS - the catastrophic disability array, passed by reference
 ;Output:
 ;  Function Value - returns 1 if validation checks passed, 0 otherwise
 ;  ERROR - if validation fails an error mssg is returned, pass by
 ;          reference
 N VALID,RESULT,EXTERNAL,ITEM,EIEN,EXIT,OK,ISCD,POP,FLD
 S ERROR=""
 Q:DGCDIS("VCD")="@" 1  ;this is a deletion
 Q:DGCDIS("VCD")="N" 1  ;NO value for VCD
 D  ;drops out of block if invalid condition found
 . S VALID=0 ; Usually invalid if it exits early.
 . ; CD Flag must have a value if any other CD field is populated
 . S POP=0
 . I DGCDIS("VCD")="" D  Q:POP
 . . F FLD="BY","DATE","FACDET","REVDTE","METDET" D  Q:POP
 . . . I $G(DGCDIS(FLD))]"" S POP=1
 . . I POP S ERROR="'VETERAN CATASTROPHICALLY DISABLED?' FIELD MUST HAVE A RESPONSE" Q
 . ; Decided by.
 . I DGCDIS("VCD")'="",$G(DGCDIS("BY"))="" S ERROR="CATASTROPHIC DISABILITY 'DECIDED BY' REQUIRED" Q
 . I $G(DGCDIS("BY"))'="",($L(DGCDIS("BY"))<3)!($L(DGCDIS("BY"))>35) S ERROR="CATASTROPHIC DISABILITY 'DECIDED BY' NOT VALID" Q
 . I $$UPPER^DGUTL($G(DGCDIS("BY")))="HINQ" S ERROR="CATASTROPHIC DISABILITY 'DECIDED BY' CAN NOT BE 'HINQ'" Q
 . ; Date of Decision
 . S OK=1,EXTERNAL=""
 . I DGCDIS("VCD")'="",$G(DGCDIS("DATE"))="" S ERROR="'DATE OF CATASTOPHIC DISABILITY DECISION' REQUIRED" Q
 . I $G(DGCDIS("DATE"))'="" D
 . . I 'DGCDIS("DATE") S OK=0 Q
 . . S EXTERNAL=$$EXTERNAL^DILFD(2,.392,"",DGCDIS("DATE"))
 . . I EXTERNAL="" S OK=0
 . . D CHK^DIE(2,.392,,EXTERNAL,.RESULT)
 . . I RESULT="^" S OK=0
 . I 'OK S ERROR="'DATE OF CATASTOPHIC DISABILITY DECISION' NOT VALID" Q
 . ; Facility Making Determination.
 . I DGCDIS("VCD")'=""!(DGCDIS("FACDET")'=""),$$EXTERNAL^DILFD(2,.393,"",$G(DGCDIS("FACDET")))="" S ERROR="'FACILITY MAKING CATASTROPHIC DISABILITY DETERMINATION' NOT VALID" Q
 . ; Review Date
 . I DGCDIS("VCD")'="",$G(DGCDIS("REVDTE"))="" S ERROR="'CATASTROPHIC DISABILITY REVIEW DATE' REQUIRED" Q
 . I DGCDIS("REVDTE")'="" D  Q:ERROR'=""
 . . S EXTERNAL=$$EXTERNAL^DILFD(2,.394,"",DGCDIS("REVDTE"))
 . . I EXTERNAL="" S ERROR="'CATASTROPHIC DISABILITY REVIEW DATE' NOT VALID" Q
 . . D CHK^DIE(2,.394,,EXTERNAL,.RESULT)
 . . I RESULT="^" S ERROR="'CATASTROPHIC DISABILTY REVIEW DATE' INVALID" Q
 . . I $G(DGCDIS("DATE")),DGCDIS("REVDTE")>DGCDIS("DATE") S ERROR="'CD REVIEW DATE' GREATER THAN 'CD DATE OF DETERMINATION'." Q
 . ; Method of Determination
 . I $G(DGCDIS("METDET"))="",DGCDIS("VCD")'="" S ERROR="'METHOD OF DETERMINATION' IS A REQUIRED VALUE." Q
 . I "..2.3."'[("."_$G(DGCDIS("METDET"))_".") S ERROR="'METHOD OF DETERMINATION' NOT VALID" Q
 . S ITEM="",EXIT=0
 . ; Descriptor
 . F  S ITEM=$O(DGCDIS("DESCR",ITEM)) Q:'ITEM  Q:EXIT  D
 . . I DGCDIS("DESCR",ITEM)="" Q
 . . I $$TYPE^DGENA5(DGCDIS("DESCR",ITEM))'="DE" S EXIT=1,ERROR="'CD DESCRIPTOR' NOT VALID"
 . Q:EXIT
 . ; Diagnoses
 . F  S ITEM=$O(DGCDIS("DIAG",ITEM)) Q:'ITEM  Q:EXIT  D
 . . I DGCDIS("DIAG",ITEM)="" Q
 . . I $$TYPE^DGENA5(DGCDIS("DIAG",ITEM))'="D" S EXIT=1,ERROR="'CD STATUS DIAGNOSES' NOT VALID"
 . Q:EXIT
 . ; Procedures
 . F  S ITEM=$O(DGCDIS("PROC",ITEM)) Q:'ITEM  Q:EXIT  D
 . . I DGCDIS("PROC",ITEM)="" Q
 . . I $$TYPE^DGENA5(DGCDIS("PROC",ITEM))'="P" S EXIT=1,ERROR="'CD STATUS PROCEDURE' NOT VALID" Q
 . . S EIEN="" F  S EIEN=$O(DGCDIS("EXT",ITEM,EIEN)) Q:EIEN=""  D
 . . . I '$$LIMBOK^DGENA5(DGCDIS("PROC",ITEM),DGCDIS("EXT",ITEM,EIEN)) S EXIT=1,ERROR="'CD STATUS AFFECTED EXTREMITY' INVALID"
 . Q:EXIT
 . ; Conditions
 . F  S ITEM=$O(DGCDIS("COND",ITEM)) Q:'ITEM  Q:EXIT  D
 . . I DGCDIS("COND",ITEM)="" Q
 . . I $$TYPE^DGENA5(DGCDIS("COND",ITEM))'="C" S EXIT=1,ERROR="'' NOT VALID" Q
 . . I '$$VALID^DGENA5(DGCDIS("COND",ITEM),DGCDIS("SCORE",ITEM)) S EXIT=1,ERROR="'CD CONDITION SCORE' NOT VALID" Q
 . . I ".1.2.3."'[("."_DGCDIS("PERM",ITEM)_".") S ERROR="'PERMANENT STATUS INDICATOR' NOT VALID" Q
 . Q:EXIT
 . ; No reason present?
 . I DGCDIS("VCD")="Y",('$D(DGCDIS("DESCR"))&('$D(DGCDIS("DIAG")))&('$D(DGCDIS("PROC")))&('$D(DGCDIS("COND")))) S ERROR="'CD REASON' NOT PRESENT" Q
 . S VALID=1
 Q VALID
 ;
ISCD(DGCDIS) ; Returns 1/0, is the patient CD?
 ; DGCDIS("DESCR",N)=CD REASON for Descriptor.
 ; DGCDIS("DIAG",N)=CD REASON for Diagnosis.
 ; DGCDIS("COND",N)=CD REASON for Condition.
 ; DGCDIS("SCORE",N)=SCORE (for condition.)
 ; DGCDIS("PERM",N)=Permanent Indicator (for condition).
 ; DGCDIS("PROC",N)=CD REASON for procedure.
 ; DGCDIS("EXT",N)=Affected Extremity (for procedure.)
 N CD S CD=0 ; True if patient is CD.
 N SUB,LIMB,LCODE,EXT,LIEN,EXCLUDE
 S SUB=""
 ; DG*5.3*894 - Add Descriptor
 F  S SUB=$O(DGCDIS("DESCR",SUB)) Q:SUB=""  D
 . I $$TYPE^DGENA5($G(DGCDIS("DESCR",SUB)))'="DE" Q
 . S CD=CD+1
 F  S SUB=$O(DGCDIS("DIAG",SUB)) Q:SUB=""  D
 . I $$TYPE^DGENA5($G(DGCDIS("DIAG",SUB)))'="D" Q
 . S CD=CD+1
 F  S SUB=$O(DGCDIS("PROC",SUB)) Q:SUB=""  D
 . I $$TYPE^DGENA5($G(DGCDIS("PROC",SUB)))'="P" Q
 . S LCODE=0
 . F  S LCODE=$O(DGCDIS("EXT",SUB,LCODE)) Q:'LCODE  D
 . . S EXT=DGCDIS("EXT",SUB,LCODE)
 . . Q:EXT=""
 . . S LIEN=$O(^DGEN(27.17,DGCDIS("PROC",SUB),1,"B",EXT,0))
 . . Q:LIEN=""
 . . S LIMB=$$LIMBCODE^DGENA5(DGCDIS("PROC",SUB),LIEN)
 . . I LIMB'=EXT Q
 . . I $D(EXCLUDE(SUB,LIMB)) Q
 . . S EXCLUDE(SUB,LIMB)=""
 . . S CD=CD+.5
 F  S SUB=$O(DGCDIS("COND",SUB)) Q:SUB=""  D
 . I $$TYPE^DGENA5($G(DGCDIS("COND",SUB)))'="C" Q
 . I '$$RANGEMET^DGENA5(DGCDIS("COND",SUB),DGCDIS("SCORE",SUB),DGCDIS("PERM",SUB)) Q
 . S CD=CD+1
 S CD=(CD'<1)
 Q CD
 ;
ERRDISP(FILE) ; Display error.
 N LINE
 S LINE=0
 W:$X !
 W "ERROR updating ",$S(FILE=2.401:"CD DESCRIPTORS",FILE=2.399!(FILE=2.409):"CD HISTORY",1:"PATIENT CD DATA"),!
 F  S LINE=$O(DGCDERR("DIERR",1,"TEXT",LINE)) Q:'LINE  W ?5,DGCDERR("DIERR",1,"TEXT",LINE),!
 W !
 Q
 ;
DELETE(DFN) ;
 ;Description: Delete a catastrophic disability record for a patient
 ;Input:
 ;  DFN - Patient IEN
 ;Output:
 ;  Function Value - returns 1 if successful, otherwise 0
 N SUCCESS,DIK,DA
 S SUCCESS=1
 D  ;drops out if invalid condition found
 . I $G(DFN),$D(^DPT(DFN,0))
 . E  S SUCCESS=0 Q
 . I '$$LOCK(DFN) S SUCCESS=0 Q
 . ;
 . N DA,DIK
 . S DA(1)=DFN
 . S DA=.39
 . S DIK="^DPT("_DFN_","_DA_","
 . D ^DIK
 . ;
 . N SIEN,SUBFILE
 . F SUBFILE=.401,.396,.397,.398 I $D(^DPT(DFN,SUBFILE))  D
 . . S SIEN=0
 . . F  S SIEN=$O(^DPT(DFN,SUBFILE,SIEN)) Q:SIEN=""  Q:SIEN'?.N  D
 . . . N DA,DIK
 . . . S DA=SIEN
 . . . S DA(1)=DFN
 . . . S DIK="^DPT("_DFN_","_SUBFILE_","
 . . . D ^DIK
 . ;
 . N DA,DIK
 . S DA(1)=DFN
 . S DA=2.401
 . S DIK="^DPT("_DFN_","
 . D ^DIK
 . ; Note -- CD HISTORY field (#.399) must not be deleted.
 D UNLOCK(DFN)
 Q SUCCESS
 ;
