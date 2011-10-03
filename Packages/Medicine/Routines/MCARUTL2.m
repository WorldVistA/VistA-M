MCARUTL2 ;HOIFO/WAA-Utility Routine #2;11/29/00  09:55
 ;;2.3;Medicine;**30**;09/13/1996
 ;;
 ;;These APIs are referenced in DBIA 3279
 ;Input:
 ;   Required: 
 ;     ARRAY = Array that data is to be stored in
 ;     DFN = Patient DFN
 ;     SUB = Sub Speciality on file 697.2
 ;   Optional:
 ;     FROM = From date
 ;     TO = To date
 ;
SUB(ARRAY,DFN,SUB,FROM,TO) ; Set a Screen for certain Speciality
 N PATNAM,SPEC,CNT,FLG,PDATE,PEDATE,SUBTXT,FILE,FNAME,FN,IEN,%,I,X
 N %I,%H,DISYS
 K ARRAY ; Purge Array
 S PATNAM="",CNT=0 ; init
 I DFN'="" S PATNAM=$$GET1^DIQ(2,DFN_",",.01,"I") ; Get patient name
 I PATNAM="" S ARRAY(CNT)="0^No patient has been defined." Q  ; no patient name
 I '$D(^MCAR(690,DFN,0)) S ARRAY(CNT)="0^"_PATNAM_" has NO Medicine Procedures on file." Q  ; Patient is not in Medicine patient
 I $G(FROM)="" S FROM=0 ; get from the beginning of time
 I $G(TO)="" D NOW^%DTC S TO=% ; get to now
 I SUB="" S ARRAY(CNT)="0^No Procedure defined." Q
 S SUBTXT=SUB ; if passing Text name saving it
 I SUB'?1N.N S SUB=$O(^MCAR(697.2,"B",SUB,0))
 I SUB<1 S ARRAY(CNT)="0^"_SUBTXT_"is an invalid Sub Speciality." Q
 ; ^----Will quit id Sub is not found in the 697.2,"B"
 S SPEC=$G(^MCAR(697.2,SUB,0)) ; Getting Sub Spec
 I SPEC="" S ARRAY(CNT)="0^"_SUBTXT_"is an invalid Sub Speciality." Q
 ; ^--- No Sub Spec.
 S FILE=$P(SPEC,U,2) ; Extended Reference
 S FN=$P(FILE,"(",2) ; file Number in MCAR name Range
 S FNAME=$P(SPEC,U) ; Procedure Name
 S IEN=0 ; v--- Looping in file FN for Patient DFN
 F  S IEN=$O(^MCAR(FN,"C",DFN,IEN)) Q:IEN<1  D
 . N LIN
 . S LIN=$G(^MCAR(FN,IEN,0))
 . Q:LIN=""  ; Invalid entry
 . ;Filter 699 and 699.5 for valid procedures
 . I FN=699,$P(LIN,U,12)'=SUB Q
 . I FN=699.5,$P(LIN,U,6)'=SUB Q
 . ;Filter dates
 . S PDATE=$P(LIN,U) ; Procedure date 
 . I PDATE<FROM Q  ; quit out of range
 . I PDATE>TO Q  ; quit out of range
 . S PEDATE=$$FMTE^XLFDT(PDATE,8) ; convert date to external format
 . S CNT=CNT+1
 . S ARRAY(CNT)=PEDATE_U_FNAME_U_PATNAM_U_FILE_U_IEN
 . ; getting Imaging PT
 . I (+$P($G(^MCAR(FN,IEN,2005,0)),U,3)) N CNT2,IMAGE S (IMAGE,CNT2)=0 F  S IMAGE=$O(^MCAR(FN,IEN,2005,IMAGE)) Q:IMAGE<1  D
 . . N IEN2005
 . . S IEN2005=$P($G(^MCAR(FN,IEN,2005,IMAGE,0)),U) Q:IEN2005<1
 . . S CNT2=CNT2+1
 . . S ARRAY(CNT,2005,CNT2)=IEN2005
 . . Q
 . ; ^------ Building Array for entry
 . I $D(ARRAY(CNT,2005,1)) S ARRAY(CNT)=ARRAY(CNT)_U_"1"_U
 . E  S ARRAY(CNT)=ARRAY(CNT)_U_"0"_U
 . Q
 I CNT<1 S ARRAY(CNT)="0^No "_FNAME_" procedure found for Patient "_PATNAM
 ; ^------- No entries found for patient
 E  S ARRAY(0)="1^"_CNT_" "_FNAME_" Procedure"_$S(CNT=1:"",1:"s")_" found for Patient "_PATNAM
 ; ^------- Processing 0 node on array if data was found
 S ARRAY=CNT ; passing total number of entries found for patient
 Q
PATLK() ; Lookup patient in medicine file.
 N DIC,X,Y,DILN,%,I,%I,DGMT,DGMTE,DGWRT,DISYS,DST,DGNOCOPF
 S DIC="^MCAR(690,",DIC(0)="AEMQ"
 D ^DIC
 Q +Y
PATSUB(ARRAY,DFN) ; Find all Subs for a patient
 N PATNAM,SPEC,CNT,FLG,PDATE,PEDATE,IMAGE,SUBTXT,FILE,FNAME,FN,IEN,SUB,DISYS
 K ARRAY ; Purge Array
 S PATNAM="",CNT=0 ; init
 I DFN'="" S PATNAM=$$GET1^DIQ(2,DFN_",",.01,"I") ; Get patient name
 I PATNAM="" S ARRAY(CNT)="0^No patient has been defined." Q  ; no patient name
 I '$D(^MCAR(690,DFN,0)) S ARRAY(CNT)="0^"_PATNAM_" has NO Medicine Procedures on file." Q  ; Patient is not in Medicine patient
 S SUB=0
 F  S SUB=$O(^MCAR(697.2,SUB)) Q:SUB<1  D
 . ; Go thur all the entries in 697.2
 . N LN,IEN,PCNT
 . S LN=$G(^MCAR(697.2,SUB,0)) ; insure that the entry is valid
 . Q:LN=""
 . S FILE=$P(LN,U,2) ; get the MCAR file name
 . S FN=$P(FILE,"(",2) ; get the file number
 . S FNAME=$P(LN,U) ; get the procedure name
 . Q:'$D(^MCAR(FN,"C",DFN))  ; quit if there is no entry for that patient
 . S PCNT=$$VALDT(DFN,FN,SUB) I PCNT=0 Q  ; Validate that there are SUBs
 . S CNT=CNT+1
 . S ARRAY(CNT)=FNAME_U_SUB_U_PCNT ; Build array string
 . Q
 S ARRAY=CNT
 I CNT=0 S ARRAY(CNT)="0^There are no Procedures on file for "_PATNAM
 E  S ARRAY=CNT S ARRAY(0)="1^There were "_CNT_" procedures found for patient "_PATNAM
 Q
VALDT(DFN,FN,SUB) ; Validate that there is a report for that patient
 N ANS,IEN
 S (ANS,IEN)=0 ; Init
 F  S IEN=$O(^MCAR(FN,"C",DFN,IEN)) Q:IEN<1  D
 . ; Loop thru and validate each entry for a subspeciality
 . N LIN ; init
 . S LIN=$G(^MCAR(FN,IEN,0)) ; check the 0 node valid
 . Q:LIN=""  ; Invalid entry
 . ;Filter 699 and 699.5 for valid procedures
 . I FN=699,$P(LIN,U,12)'=SUB Q
 . I FN=699.5,$P(LIN,U,6)'=SUB Q
 . S ANS=ANS+1 ; If it is valid then add 1 to the count
 . Q
 Q ANS ; pass back the total number of valid entries found
