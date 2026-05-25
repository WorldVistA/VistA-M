XUIAMDD1 ;BHM/JFW - IAM DATA DICTIONARY UTILITIES ; 1/27/20 11:42am
 ;;8.0;KERNEL;**799**;Jul 10, 1995;Build 3
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
 ;**663 STORY 1203246 (jfw) - NEW PERSON field monitoring X-Ref
 ;**799 VAMPI-22625           processing and Monitor file
 ;
 ;Input : XUDUZ - Pointer to entry in NEW PERSON (#200) file that edited record
 ;        XUIEN - Pointer to entry in NEW PERSON (#200) file that was modified
 ;        XUOLD - Existing values for NEW PERSON (#200) fields (By REF)
 ;        XUNEW - Existing/Updated values for NEW PERSON (#200) fields (By REF)
 ;Output: None
AVIAM(XUDUZ,XUIEN,XUOLD,XUNEW) ;AVIAM X-REF for NEW PERSON (#200) file
 ;Notes : The AVIAM X-REF is used to remember that changes were
 ;        made to the NEW PERSON (#200) file. Execution of this X-REF
 ;        will create (if one doesn't exist) or update (existing)
 ;        entry in the NEW PERSON FIELD MONITOR (#8933.1) file and mark
 ;        it as requiring transmission to PSIM via Web Services.
 ;        
 ;        Local variable XUIAMNPF should be initialized to 1 if the
 ;        'AVIAM' X-REF is NOT to be executed, because the entry is
 ;        being initially 'ADD'ed to the system.
 ;
 ;    *** XUIEN for a person will only be entered once in the
 ;        NEW PERSON FIELD MONITOR FILE (#8933.1) for a given day.
 ;
 ;        GLOBAL: ^XTV(8933.1,
 ;
 ;        Each time any of the following fields in the NEW PERSON (#200)
 ;        file are modified the field #_";" will get appended to the
 ;        FIELD(S) MODIFIED (#1) field in the NEW PERSON FIELD MONITOR
 ;        (#8933.1) file, except as noted below:
 ;
 ;             NAME (#.01)
 ;             EMAIL ADDRESS(#.151) 
 ;             SEX (#4)
 ;             DOB (#5)
 ;             DISUSER (#7)
 ;             SSN (#9)
 ;             TERMINATION DATE (#9.2)
 ;             NPI (#41.99)
 ;             LAST SIGN-ON DATE/TIME (#202) - *ONLY added once per day!
 ;             SECID (#205.1)
 ;             SUBJECT ORGANIZATION (#205.2)
 ;             SUBJECT ORGANIZATION ID (#205.3)
 ;             UNIQUE USER ID (#205.4)
 ;             ADUPN (#205.5)
 ;             NETWORK USERNAME (#501.1)
 ;             PRIMARY MENU OPTION (#201)
 ;   
 Q:($G(XUIAMNPF))  ;Initial 'ADD'ing of an entry NOT logged
 ;Validate Input     
 I +$G(XUIEN),$D(^VA(200,XUIEN,0)),$D(XUOLD),$D(XUNEW)
 E  Q
 ;
PVT4NP  ;Create/Update entry in the NEW PERSON FIELD MONITOR (#8933.1) file
 ;Determine if record already exists for IEN Today
 N XUMIEN,XUFDA,XUFLDS,XUSGNON
 S XUMIEN=$O(^XTV(8933.1,"C",XUIEN,DT,"")),XUFLDS=$$MODFLDS(XUMIEN,.XUOLD,.XUNEW)
 S XUSGNON=$S(XUFLDS="202;":1,1:0)  ;Determine if Sign-On Only
 Q:(XUFLDS="")  ;Quit if NO Fields Modified
 D:('XUMIEN)  ;Create NEW PERSON FIELD MONITOR File (#8933.1) entry
 .S XUFDA(8933.1,"+1,",.01)=DT
 .S XUFDA(8933.1,"+1,",.02)=XUIEN
 .S XUFDA(8933.1,"+1,",.03)=1  ;Requires transmission
 .I +$G(XUDUZ),$D(^VA(200,XUDUZ,0)),'XUSGNON S XUFDA(8933.1,"+1,",.05)=XUDUZ  ;User who Edited Record
 .S XUFDA(8933.1,"+1,",1)=XUFLDS
 .L +^XTV(8933.1,0):10 I '$T Q
 .D UPDATE^DIE("","XUFDA")
 .L -^XTV(8933.1,0)
 D:(XUMIEN)  ;Update NEW PERSON FIELD MONITOR File (#8933.1) entry
 .S XUFDA(8933.1,XUMIEN_",",.03)=1  ;Requires transmission
 .I +$G(XUDUZ),$D(^VA(200,XUDUZ,0)),'XUSGNON S XUFDA(8933.1,XUMIEN_",",.05)=XUDUZ  ;User who Last Edited Record
 .S XUFDA(8933.1,XUMIEN_",",1)=$G(^XTV(8933.1,XUMIEN,1))_XUFLDS  ;Modified Field List
 .L +^XTV(8933.1,XUMIEN):10 I '$T Q
 .D FILE^DIE("","XUFDA")
 .L -^XTV(8933.1,XUMIEN)
 Q
 ;
 ;Input:  XUMIEN - IEN for record in NEW PERSON FIELD MONITOR File (#8933.1)
 ;        XUOLD  - See above (By REF)
 ;        XUNEW  - See above (By REF) 
 ;Output: XURTN  - ';' Delimitted list of fields modified for NP (#200) record
MODFLDS(XUMIEN,XUOLD,XUNEW) ;Determine/Return which NP #200 fields were modified
 N XUI,XUFLDS,XURTN,XUSGNFLG
 ;XUFLDS needs to match Field Order/Sequencing in the 'AVIAM' New Style X-REF
 S XUFLDS=".01;.151;4;5;7;9;9.2;41.99;202;205.1;205.2;205.3;205.4;205.5;501.1;201;"
 S (XURTN,XUI)="",XUSGNFLG=0
 ;Determine if LAST SIGN-ON DATE/TIME in list for existing record, if applicable
 S:(XUMIEN) XUSGNFLG=($L(";"_$G(^XTV(8933.1,XUMIEN,1)),";202;")>1)
 ;determine which fields were modified by looking at before/after values
 F  S XUI=$O(XUOLD(XUI)) Q:(XUI="")  D
 .Q:('$D(XUNEW(XUI)))  ;Quit if Lists (New/Old) are out of Sync
 .Q:((XUOLD(XUI))=(XUNEW(XUI)))  ;Quit if field didn't change
 .;LAST SIGN-ON DATE/TIME (Field #202) ONLY allowed to be in list 1x per day
 .Q:(($P(XUFLDS,";",XUI)=202)&(XUSGNFLG))
 .S XURTN=XURTN_$P(XUFLDS,";",XUI)_";"
 Q XURTN
 ;
FTOP ;future termination date is now from XUAUTODEACTIVATE background job
 ;XUIFN is the NEW PERSON entry that is being reviewed in the background job
 ;Create entry in the NEW PERSON FIELD MONITOR (#8933.1) file
 N XUMIEN,XUFDA,XUFLDS,XUSGNON,XUTRMDT,XUPRGDAY
 S XUTRMDT=$P(^VA(200,XUIFN,0),"^",11)-1,XUPRGDAY=$$GET1^DIQ(8989.3,$O(^XTV(8989.3,0))_",",875,"I")
 S XUPRGDAY=$S(+XUPRGDAY>0:XUPRGDAY,1:365)
 ;Quit if NO Purge Flag AND User Rec already transmitted to PSIM since Termination Date OR DT to Term Date DIFF is older than 8933.1 Purge Days
 Q:(('$$GET^XPAR("SYS","XU645",1,"Q"))&((+$O(^XTV(8933.1,"C",XUIFN,XUTRMDT)))!($$FMDIFF^XLFDT(DT,XUTRMDT+1)>=XUPRGDAY)))
 S XUMIEN=$O(^XTV(8933.1,"C",XUIFN,DT,""))
 Q:XUMIEN'=""  ;found have entry for today already don't need another one as existing termination date will go already
 ;Create NEW PERSON FIELD MONITOR File (#8933.1) entry
 S XUFDA(8933.1,"+1,",.01)=DT
 S XUFDA(8933.1,"+1,",.02)=XUIFN
 S XUFDA(8933.1,"+1,",.03)=1  ;Requires transmission
 I +$G(DUZ),$D(^VA(200,DUZ,0)) S XUFDA(8933.1,"+1,",.05)=DUZ  ;User who is running the job
 S XUFDA(8933.1,"+1,",1)="9.2;"
 L +^XTV(8933.1,0):10 I '$T Q
 D UPDATE^DIE("","XUFDA")
 L -^XTV(8933.1,0)
 Q
