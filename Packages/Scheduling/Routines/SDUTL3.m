SDUTL3 ;ALB/REW - Primary Care API Calls ;2/13/15  10:36
 ;;5.3;Scheduling;**30,39,41,148,177,568,633**;Aug 13, 1993;Build 8
 ;
OUTPTPR(DFN,SCDATE,SCPCROLE) ;given patient, return internal^external of the pc practitioner
 ; Input: DFN - ien of patient file (#2)
 ;     SCDATE - Relevant Date (Default=DT)
 ;   SCPCROLE - Type of PC Role (Default =1 (PC Practitioner),2=Attending
 ; Returned: pointer to file #200^external value of name 
 ;           or, if error or none defined, returns a 0 or null
 ; Note: This call will continue to be supported with the PCMM release
 ;     
 ;       *** SUPPORTED API ***
 ;
 Q:'$G(DFN) 0
 S SCDATE=$G(SCDATE,DT)
 S SCPCROLE=$G(SCPCROLE) I $L(SCPCROLE)'=1!(12'[SCPCROLE) S SCPCROLE=1
 Q $$NMPCPR^SCAPMCU2(.DFN,.SCDATE,.SCPCROLE)
 ;
OUTPTAP(DFN,SCDATE) ;given patient, return internal^external of the pc associate provider
 ; Input: DFN - ien of patient file (#2)
 ;     SCDATE - Relevant Date (Default=DT)
 ; Returned: pointer to file #200^external value of name 
 ;           or, if error or none defined, returns a 0 or null
 ;
 ;    *** SUPPORTED API ***
 ;
 Q:'$G(DFN) 0
 S SCDATE=$G(SCDATE,DT)
 Q $$NMPCPR^SCAPMCU2(.DFN,.SCDATE,3)
 ;
OUTPTTM(DFN,SCDATE,ASSTYPE) ;given patient, return internal^external of the pc team
 ;Input: DFN - ien of patient file (#2)
 ;    SCDATE - Date of interest (Default=dt)
 ;   ASSTYPE - Assignment Type (Default=1: PC Team)
 ;  
 ; Returned: pointer to team file (#404.51)
 ;           or, if error or none defined, returns 0 or null
 ; Note: This call will continue to be supported with the PCMM release
 ;       additional, optional parameters may be added (e.g. effective dt)
 ;
 Q:'$G(DFN) 0
 S SCDATE=$G(SCDATE,DT)
 S ASSTYPE=$G(ASSTYPE,1)
 Q $$NMPCTM^SCAPMCU2(.DFN,.SCDATE,.ASSTYPE)
 ;
INPTPR(DFN,PRACT) ;store current PC practitioner; return SDOKS=1, if OK
 ; Input: DFN:    ien of patient file (#2)
 ;        PRACT:  ien of file #200 if adding,changing field
 ;                null or '@' if deleting field
 ; Output:SDOKS:  0, if fails to store, 1 otherwise
 ;
 ; Note: This data is stored in field #404.01 of the patient file.
 ;       With the release of PCMM, this is no longer a valid method
 ;       to enter provider information for PCMM.
 ; 
 ;       **** PLANNED FOR REMOVAL IN THE FUTURE ****
 ; 
 ; Selected NEW PERSON entry must be active and must hold provider key
 I '$G(DFN)!('$D(PRACT)#2)!('$D(^DPT(+DFN,0))) S SDOKS=0 Q
 D EN^DDIOL("Note: This is NOT automatically added to PCMM Files")
 D EN^DDIOL("This data should now be entered via PCMM Input Screens")
 S SDOKS=1
 N DIE,DIC,DR,DA,X
 I PRACT=""!(PRACT="@") D  G QTIPR
 .S DIE="^DPT("
 .S DR="404.01////^S X=""@"""
 .S DA=DFN
 .D ^DIE
 I '$$SCREEN^DGPMDD(PRACT) S SDOKS=0 Q
 I $D(^VA(200,+PRACT,0)) D
 .S DIE="^DPT("
 .S DR="404.01////^S X=+PRACT"
 .S DA=DFN
 .D ^DIE
 E  D
 .S SDOKS=0
QTIPR Q
INPTTM(DFN,TEAM) ;store current PC team; return SDOKS=0, if fails
 ; Input: DFN:   ien of patient file (#2)
 ;        TEAM:  ien of file #404.51 if adding,changing field
 ;               null or '@' if deleting field
 ; Output:SDOKS: 0, if fails to store, 1 otherwise
 ;
 ; Note: This data is stored in field #404.02 of the patient file.
 ;       With the release of PCMM, this is no longer a valid method 
 ;       to enter team information for PCMM. 
 ;  
 ;       **** PLANNED FOR REMOVAL IN THE FUTURE ****
 ; 
 I '$G(DFN)!('$D(TEAM)#2)!('$D(^DPT(+DFN,0))) S SDOKS=0 Q
 D EN^DDIOL("This data should now be entered via PCMM Input Screens")
 N DIE,DIC,DR,DA,X
 S SDOKS=1
 I TEAM=""!(TEAM="@") D  G QTITM
 .S DIE="^DPT("
 .S DR="404.02////^S X=""@"""
 .S DA=DFN
 .D ^DIE
 I $D(^SCTM(404.51,+TEAM,0)) D
 .S DIE="^DPT("
 .S DR="404.02////^S X=+TEAM"
 .S DA=DFN
 .D ^DIE
 E  D
 .S SDOKS=0
QTITM Q
