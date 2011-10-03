HDISVU02 ;BPFO/JRP - STORE VUIDS FOR SET OF CODES;5/12/2005
 ;;1.0;HEALTH DATA & INFORMATICS;**1,2**;Feb 22, 2005
 ;
VUIDL(TAG,ROUTINE) ;Instantiate VUIDs for set of code fields
 ; Input: TAG - Line tag under which VUID data has been placed
 ;        ROUTINE - Routine line tag is in
 ;                  Leave blank if in this routine
 ;Output: 0 = Stop post-install (error)
 ;        1 = Continue with post-install
 ; Notes: Data lines must be in the format
 ;          File~Field~Code~VUID~Status~EffectiveDateTime
 ;          (Status and EffectiveDateTime must be in internal format)
 ;          (Default value for Status is 0 - Inactive)
 ;          (Default value for EffectiveDateTime is NOW)
 ;      : Call assumes that all input (TAG & ROUTINE) is valid
 ;      : Call assumes that data lines are valid
 ;        (i.e. no missing/bad data)
 ;      : The incoming status/date will not be stored in an existing
 ;        entry for the VUID if the currently stored status is the
 ;        same as the input status.
 ;
 N OFFSET,DATA,FILE,FIELD,IREF,VUID,STAT,STDT,DONE,RESULT,HDIMSG
 S ROUTINE=$G(ROUTINE)
 S RESULT=1
 S DONE=0
 F OFFSET=1:1 D  Q:DONE
 .S DATA=$S(ROUTINE="":$T(@TAG+OFFSET),1:$T(@TAG+OFFSET^@ROUTINE))
 .S DATA=$P(DATA,";;",2)
 .I DATA="" S DONE=1 Q
 .S FILE=$P(DATA,"~",1)
 .S FIELD=$P(DATA,"~",2)
 .S IREF=$P(DATA,"~",3)
 .S VUID=$P(DATA,"~",4)
 .S STAT=$P(DATA,"~",5)
 .I STAT="" S STAT=0
 .S STDT=$P(DATA,"~",6)
 .I STDT="" S STDT=$$NOW^XLFDT()
 .I '$$STOREIT(FILE,FIELD,IREF,VUID,STAT,STDT) D
 ..S HDIMSG(1)="**"
 ..S HDIMSG(2)="** Unable to store VUID and/or status information for file"
 ..S HDIMSG(3)="** "_FILE_", field "_FIELD_", and internal value "_IREF
 ..S HDIMSG(4)="**"
 ..D MES^XPDUTL(.HDIMSG) K HDIMSG
 ..S RESULT=0
 Q RESULT
 ;
STOREIT(FILE,FIELD,IREF,VUID,STAT,STDT) ;Store VUID info
 ; Input: FILE - File number
 ;        FIELD - Field number
 ;        IREF - Internal reference
 ;        VUID - VUID
 ;        STAT - Status
 ;               0 = Inacive (default)     1 = Active
 ;        STDT - Status Date/Time (FileMan)
 ;               (Defaults to NOW)
 ;Output: 1 = Success
 ;        0 = Failure
 ; Notes: Existance/validity of input assumed (internal call)
 ;      : Call will automatically inactivate terms when appropriate
 ;      : The input status/date will not be stored in an existing
 ;        entry for the VUID if the currently stored status is the
 ;        same as the input status.  Success (1) will be returned.
 ;
 N MASTER,CURSTAT
 S STAT=+$G(STAT)
 S STDT=+$G(STDT)
 I 'STDT S STDT=$$NOW^XLFDT()
 ;Is VUID already on file
 S CURSTAT=$$GETSTAT^XTID(FILE,FIELD,IREF)
 ;Don't store new date for same status (return SUCCESS)
 I $P(CURSTAT,"^",1)=STAT Q 1
 ;Store VUID (also sets master entry flag, if appropriate)
 I '$$SETVUID^XTID(FILE,FIELD,IREF,VUID) Q 0
 ;Inactivate non-master entries
 I '$$GETMASTR^XTID(FILE,FIELD,IREF) D
 .S STAT=0
 .S STDT=$$NOW^XLFDT()
 ;Store status
 Q $$SETSTAT^XTID(FILE,FIELD,IREF,STAT,STDT)
