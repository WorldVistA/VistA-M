RORDD01 ;HCIOFO/SG - DATA DICTIONARY UTILITIES ;6/14/06 2:07pm
 ;;1.5;CLINICAL CASE REGISTRIES;**1,14**;Feb 17, 2006;Build 24
 ;
 ; This routine uses the following IAs:
 ;
 ; #2762         ^DPT(D0,-9 (controlled)
 ;
 Q
 ;******************************************************************************
 ;******************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*14   APR  2011   A SAUNDERS   AIDSOI: Since clinical aids can be 9 
 ;                                      'unknown', we can't just quit if field
 ;                                      value is not zero.  Only quit if 'yes'.
 ;******************************************************************************
 ;******************************************************************************
 ;
 ;***** "AIDSOI" TRIGGER OF THE "AIDS INDICATOR DISEASE" MULTIPLE
 ;
 ; .SDA          Reference to a local array of record IENs
 ;
 ; DATE          Date of an AIDS indicator disease
 ;
AIDSOI(SDA,DATE) ;
 N IENS,TMP,RORFDA,RORMSG
 ;--- Do not do anything if the CLINICAL AIDS field is already set
 S IENS=+$G(SDA(1))  Q:IENS'>0  S IENS=IENS_","
 ;Q:$$GET1^DIQ(799.4,IENS,.02,"I",,"RORMSG")
 I $$GET1^DIQ(799.4,IENS,.02,"I",,"RORMSG")=1 Q
 ;---
 S DATE=$P(DATE,".")
 I DATE>0  D
 . S:'$E(DATE,4,5) $E(DATE,4,5)="01"
 . S:'$E(DATE,6,7) $E(DATE,6,7)="01"
 E  S DATE=$$DT^XLFDT
 ;---
 S RORFDA(799.4,IENS,.02)=1
 S RORFDA(799.4,IENS,.03)=DATE
 D FILE^DIE(,"RORFDA","RORMSG")
 Q
 ;
 ;***** "ANC" INDEX OF THE "REGISTRY NAME" MULTIPLE OF THE FILE #799.6
 ;
 ; .SDA          Reference to a local array of record IENs
 ;
 ; REGNAME       Registry name
 ;
 ; MODE          1 - Set, 0 - Kill
 ;
ANC7996(SDA,REGNAME,MODE) ;
 I MODE  S MODE=($D(^RORDATA(799.6,SDA(1),3,"ANC"))>1)  D
 . S ^RORDATA(799.6,SDA(1),3,"ANC",$E(REGNAME,1,30),SDA)=""
 E  D  S MODE=($D(^RORDATA(799.6,SDA(1),3,"ANC"))>1)
 . K ^RORDATA(799.6,SDA(1),3,"ANC",$E(REGNAME,1,30),SDA)
 Q:MODE
 ;--- Re-index the main record (the "ADNAUTO" index, in particular)
 N DA,DIK
 S DIK="^RORDATA(799.6,",DIK(1)=".01",DA=SDA(1)
 D EN^DIK
 Q
 ;
 ;***** DELETES THE DATA ASSOCIATED WITH THE MAIN REGISTRY RECORD
 ;
 ; IEN           IEN of the registry record (file #798)
 ; PTIEN         Patient IEN
 ;
DEL798(IEN,PTIEN) ;
 N DA,DIK,I,PTDEL
 ;--- Delete the HIV record from the ROR HIV RECORD file (#799.4)
 I $D(^RORDATA(799.4,IEN))  S DIK="^RORDATA(799.4,",DA=IEN  D ^DIK
 ;--- Check if the patient is added to more than one registry
 S I="",PTDEL=1
 F  S I=$O(^RORDATA(798,"B",PTIEN,I))  Q:I=""  S:I'=IEN PTDEL=0
 ;--- Delete corresponding patient's records if they are not
 ;    referenced by other registries and the patient's record
 ;--- in the PATIENT file (#2) is not a "merged" one.
 I PTDEL  D:$G(^DPT(PTIEN,-9))'>0
 . ;--- Delete the record from the ROR PATIENT file
 . S DIK="^RORDATA(798.4,",DA=PTIEN  D ^DIK
 . ;--- Delete the record from the ROR PATIENT EVENTS file
 . S DIK="^RORDATA(798.3,",DA=PTIEN  D ^DIK
 Q
 ;
 ;***** RETURNS THE VALUE OF 'DATE SELECTED' COMPUTED FIELD
 ;
 ; IEN           IEN of the registry record (file #798)
 ;
DTSEL(IEN) ;
 N DTSEL
 ;--- Earliest date of a selection rule
 S DTSEL=$O(^RORDATA(798,IEN,1,"AD",""))\1
 ;--- If SELECTION RULE multiple is empty, return DATE ENTERED
 Q $S(DTSEL>0:DTSEL,1:$P($G(^RORDATA(798,IEN,0)),U,3)\1)
 ;
 ;***** STORE THE VALUE INTO THE FIELD
 ;
 ; FILE          Sub(file) number
 ; IENS          IENS of the record
 ; FIELD         Field number
 ; VALUE         Internal value to be assigned
 ;
FILE(FILE,IENS,FIELD,VALUE) ;
 N ROR8FDA,ROR8MSG,TMP
 S TMP=$S($E(IENS,$L(IENS))=",":IENS,1:IENS_",")
 S ROR8FDA(+FILE,TMP,+FIELD)=VALUE
 D FILE^DIE(,"ROR8FDA","ROR8MSG")
 Q
 ;
 ;***** STATUS OF THE HISTORICAL DATA DEFINITION
 ;
 ; HDEIEN        IEN of the HDE definition (file #799.6)
 ;
 ; Return Values:
 ;       ""  Unknown/Undefined
 ;        0  Inactive
 ;        1  Pending/Active
 ;        2  Completed
 ;
HDESTAT(HDEIEN) ;
 N BUF,STATUS,TYPE
 S HDEIEN=+HDEIEN,BUF=$G(^RORDATA(799.6,HDEIEN,0))
 S TYPE=+$P(BUF,U,2),STATUS=""
 ;=== Auto
 I TYPE=1  D  Q STATUS
 . N ADT
 . ;--- Activation Date
 . S ADT=+$P(BUF,U,7)
 . I (ADT'>0)!(ADT<DT)  S STATUS=0  Q
 . ;--- Check if all registries have completion dates
 . I $D(^RORDATA(799.6,HDEIEN,3,"ANC"))<10  S STATUS=2  Q
 . ;--- Pending or Active
 . S STATUS=1
 ;=== Manual
 I TYPE=2  D  Q STATUS
 . N TSKIEN,TSKSTAT
 . ;--- Check if any tasks are defined
 . I $O(^RORDATA(799.6,HDEIEN,4,0))'>0  S STATUS=0  Q
 . ;--- Check if all tasks have been completed
 . I $D(^RORDATA(799.6,HDEIEN,4,"ANC"))<10  S STATUS=2  Q
 . ;--- Pending, Active, or Errors
 . S STATUS=1
 ;=== Unknown or Undefined
 Q ""
 ;
 ;***** CHECKS IF THE LOCAL REGISTRY FIELD IS ACTIVE
 ;
 ; IEN           IEN of the local field definition (file #799.53)
 ;
 ; Return Values:
 ;        0  Inactivated
 ;        1  Active
 ;
LFACTIVE(IEN) ;
 N TMP
 S TMP=$G(^ROR(799.53,+IEN,0))  Q:TMP="" 0
 S TMP=$P(TMP,U,2)\1            Q:TMP'>0 1
 Q (TMP>DT)
 ;
 ;***** RETURNS THE VALUE OF 'LOCATION' COMPUTED FIELD
 ;
 ; IEN           IEN of the registry record (file #798)
 ;
LOCSEL(IEN) ;
 N DTSEL,SRIEN
 S DTSEL=$O(^RORDATA(798,IEN,1,"AD",""))  Q:DTSEL'>0 ""
 S SRIEN=$O(^RORDATA(798,IEN,1,"AD",DTSEL,""))
 Q $S(SRIEN>0:$P($G(^RORDATA(798,IEN,1,SRIEN,0)),U,3),1:"")
 ;
 ;***** RE-INDEXES ONE RECORD OF THE (SUB)FILE
 ;
 ; FILE          File number
 ;
 ; .DA           Reference to a local array of record IENs
 ;
 ; [FIELD]       Optional field number. If it is provided, then only
 ;               cross-references for this field are re-indexed.
 ;
REINDEX1(FILE,DA,FIELD) ;
 N DIK
 S DIK=$$ROOT^DILFD(FILE,$$IENS^DILF(.DA))
 S:$G(FIELD)>0 DIK(1)=+FIELD
 D EN^DIK
 Q
 ;
 ;***** REACTS ON THE REGISTRY RECORD STATUS CHANGES
 ;
 ; MODE          Execution mode (1 - Set, 2 - Kill)
 ;
 ; IEN           Internal entry number of the registry record
 ;
 ; STOLD         Old and new internal values of the STATUS field
 ; STNEW
 ;
RST798(MODE,IEN,STOLD,STNEW) ;
 Q:STNEW=STOLD
 N IENS,RORFDA,RORMSG
 S IENS=(+IEN)_","
 ;---
 D
 . ;--- Deleted
 . I STNEW=5  D  Q
 . . S RORFDA(798,IENS,6)=$$NOW^XLFDT
 . . S:$G(DUZ)>0 RORFDA(798,IENS,6.1)=+DUZ
 . ;--- Confirmed
 . I STOLD=4,'STNEW  D  Q
 . . S RORFDA(798,IENS,2)=$$NOW^XLFDT
 . . S:$G(DUZ)>0 RORFDA(798,IENS,2.1)=+DUZ
 ;---
 D:$D(RORFDA)>1 FILE^DIE(,"RORFDA","RORMSG")
 Q
 ;
 ;***** GENERATES THE INDEX VALUE OF THE REPORT ELEMENT
 ;
 ; MODE          Sort mode (see the SORT BY field of the REPORT
 ;               ELEMENT multiple of the ROR TASK file for details)
 ; VAL           Value of the report element
 ;
SORTBY(MODE,VAL) ;
 Q $S(MODE=3:+VAL,VAL="":" ",MODE=2:$E(VAL,1,29)_" ",1:$E(VAL,1,30))
