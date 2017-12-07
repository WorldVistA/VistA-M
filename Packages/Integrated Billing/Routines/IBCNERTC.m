IBCNERTC ;AITC/HN - Covered by Health Insurance ;03-MAR-2017
 ;;2.0;INTEGRATED BILLING;**593**;21-MAR-94;Build 31
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This program will loop through the ACHI Index of the Patient (2) file to update the 
 ;  Covered by Health Insurance (2.3192) field based on current active policies.
 ;
 ;  This option is designed to run through TaskMan after midnight.  It shouldn't take long since there
 ;  should not be many entries in the ACHI index per day.
 ;
 ;  UPATF should be used with care since it will process the entire Patient File
 ;
 Q
 ;
EN(IBDT) ;From Taskman nightly job.  Call from label TASK.
 N DFN
 S DFN=""
 F  S DFN=$O(^DPT("ACHI",IBDT,DFN)) Q:'DFN  D INS(DFN,IBDT)
 Q
 ;
INS(DFN,IBDT) ;Check insurance
 N DA,DIE,IBCOV,IBIND,IBINS,IBNCOV,DR,IBINSD,IENS,EFFDT,IBIENS,DEFIND,IBIEN,IBSYM
 S (IBCOV,IBNCOV)=$$GET1^DIQ(2,DFN_",","COVERED BY HEALTH INSURANCE?","I")
 D ALL^IBCNS1(DFN,"IBINS",2,IBDT) S IBINSD=+$G(IBINS(0))
 ;
 ; -- initial value ="" or Unknown
 I $TR(IBCOV,"U","")']"" S IBNCOV=$S('$O(^DPT(DFN,.312,0)):"U",IBINSD:"Y",1:"N")
 ; -- initial value = YES or NO (treat the same)
 I "YN"[IBCOV S IBNCOV=$S('$O(^DPT(DFN,.312,0)):"N",IBINSD:"Y",1:"N")
 ;
 I IBCOV'=IBNCOV S DIE="^DPT(",DR=".3192///"_IBNCOV,DA=DFN D ^DIE
 ;
 ; Create Buffer entry for those whose Effective Date = IBDT
 ;
 S DA=0 F  S DA=$O(IBINS(DA)) Q:'DA  D
 . S IBIEN=+IBINS(DA,0)
 . S IBIENS=DA_","_DFN_","
 . S EFFDT=$$GET1^DIQ(2.312,IBIENS,8,"I")
 . I EFFDT'=IBDT Q
 . ; Add check to see if already in buffer
 . S DEFIND=$$BFEXIST(DFN,IBIEN) Q:DEFIND=1
 . S IBSYM=$P($$INSERROR^IBCNEUT3("I",IBIEN),"^",1)
 . D PT^IBCNEBF(DFN,DA,IBSYM,,1)
 Q
 ;
UPATF ;Update the entire Patient File
 ; This should be tasked for late evening since it will take awhile to run.
 N DFN,IENS
 S DFN=0
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  D
 . D INS(DFN,DT)
 Q
 ;
BFEXIST(DFN,INSNAME) ; Function returns 1 if an Entered Ins Buffer File 
 ; entry exists with the same DFN and INSNAME, otherwise it returns a 0
 ;
 ; DFN - Patient DFN
 ; INSNAME - Insurance Company Name File 36 - Field .01
 ;
 NEW EXIST,IEN,EDATE
 S EXIST=0
 S INSNAME=$P($G(^DIC(36,IBIEN,0)),U) ;$$TRIM^XLFSTR(INSNAME)  ; trimmed
 I ('DFN)!(INSNAME="") G BFEXIT
 ;
 S IEN=0
 F  S IEN=$O(^IBA(355.33,"C",DFN,IEN)) Q:'IEN!EXIST  D
 .  ; Quit if status is NOT 'Entered'
 .  I $$GET1^DIQ(355.33,IEN_",","STATUS","I")'="E" Q
 .  ; Quit if Ins Buffer Ins Co Name (trimmed) is NOT EQUAL to 
 .  ;  the Ins Co Name parameter (trimmed)
 .  I $$TRIM^XLFSTR($$GET1^DIQ(355.33,IEN_",","INSURANCE COMPANY NAME"))'=INSNAME Q
 .  ; Quit if Date Enterd Matches
 .  S EDATE=$P($$GET1^DIQ(355.33,IEN_",","DATE ENTERED","I"),".")
 .  I IBDT'=EDATE Q
 .  ; Match found
 .  S EXIST=1
 .  Q
BFEXIT ;
 Q EXIST
 ;
XREF ;Build the "ACHI" cross reference
 N CNT,DA,DFN,FILE,DIK,X,Y
 S DFN=0
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  D
 . I $$GET1^DIQ(2,DFN_","_"DATE OF DEATH") Q  ;Patient Deceased
 . S DA(1)=DFN
 . S DIK="^DPT("_DA(1)_",.312,"
 . S DIK(1)="3^ACHI"
 . D ENALL^DIK
 . S DIK(1)="8^ACHI"
 . D ENALL^DIK
 Q
