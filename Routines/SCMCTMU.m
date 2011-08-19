SCMCTMU ;ALB/REW - Team-Patient Utilities ; 1 May 95
 ;;5.3;Scheduling;**41**;AUG 13, 1993
 ;1
ACTTM(SCTM,SCDT) ;is the team  currently active?
 ; Used by computed field #300 (CURRENTLY ACTIVE?) OF file #404.51
 ; Input:
 ;  SCTM  - Pointer to Team file #404.51
 ;  SCDT  - Date to check for, Default=DT
 ; Returns:
 ;   1  if after effective date and before inactive date
 ;   0  if not yet active or inactivated
 ;   -1 if error
 ;
 Q $$DATES^SCAPMCU1(404.58,.SCTM,.SCDT)
 ;
ENROLL(DFN,CLINIC,DATE) ;is this patient enrolled in this clinic on a date?
 ;Input:
 ;    DFN - ien of Patient file
 ; CLINIC - Pointer to file 44
 ;   DATE - (Optional) Effective Date, default=DT
 ;Return: [1|Yes, he is enrolled;0|he is not]
 ;
 N SCCL,SCL1,SCNODE,SCACT,SCINACT,SCYES
 S SCYES=0
 S SCCL=0
 F  S SCCL=$O(^DPT(DFN,"DE","B",CLINIC,SCCL)) Q:'SCCL  D
 .S SCCL1=0
 .F  S SCCL1=$O(^DPT(DFN,"DE",SCCL,1,SCCL1)) Q:'SCCL1  D
 ..S SCNODE=$G(^DPT(DFN,"DE",SCCL,1,SCCL1,0))
 ..S SCACT=+SCNODE
 ..S SCINACT=$P(SCNODE,U,3)
 ..S:$S('SCACT:0,(SCACT>DATE):0,'SCINACT:1,(SCINACT<DATE):0,1:1) SCYES=1
 Q SCYES
 ;
RESTCONS(DFN) ;does this patient have restricted consults?
 ; for a clinic in which the patient is NOT enrolled, some patients/teams
 ; require more authority to enroll or make appointments
 ; this will often be used with $$ENROLL(dfn) to see if he is enrolled
 ;
 ; Input: DFN - ien of Patient File
 ; Return: [1|Yes, restrict 0|No
 Q 1
WHOCLIN(SDCL,DATE) ;give clinic & date return prt to 200
 ; SDCL - ien of #44
 ; DATE - effective date (optional) default =DT
 ; Returned: ien of 200
 ;
 Q
POSCLIN(SDCL,DATE) ;given clinic & date, return ptr to team position 404.57
 ;  SDCL - ien of Hospital Location (#44)
 ;  Returned: If exactly one position for clinic - ien of team postion
 ;            else null
 ;
 N X,SCD
 S:'$G(DATE) DATE=DT
 S SCD=$O(^SCTM(404.57,"ACLINDT",+SDCL,-DATE)) ;SCD is the effective date
 S X=$O(^SCTM(404.57,"ACLINDT",+SDCL,+SCD,"")) ;position assoc w/ clinic
 Q $G(X)
WHOPOS(SCTP,DATE) ;given position & date,return pointer to 200^name of pr
 ;SCTP - ien of Team Position File (#404.57)
 ; Date - (Optional) effective date - default=today
 ;
 Q $$GETPRTP^SCAPMCU2(SCTP,.DATE)
DISPWHO(SCPOS,DATE) ;given position & date, return external of 200
 ;SCPOS - ien of 404.48)
 ; DATE - (Optional) effective date - default=today
 ;
 N Y,SCP
 S:'$G(DATE) DATE=DT
 S SCP=$$WHOPOS(SCPOS,DATE)
 S:SCP Y=$S($D(^VA(200,+SCP,0)):$P(^(0),U,1),1:"Unknown")
 Q $G(Y)
PR(SDNPI) ;Provider Display Data
 ; Input  -- SDNPI    New Person IEN
 ; Output -- Provider Display Data - Provider Name
 N Y
 S Y=$S($D(^VA(200,SDNPI,0)):$P(^(0),"^"),1:"Unknown")
 Q $G(Y)
PTTMSCRN ;define dic('s') to ensure patient team position assignement is ok
 ;
CK N SCTM,SCTMA
 S SCTMA=$P($G(^SCPT(404.43,Y,0)),U,1)
 S SCTM=$P($G(^SCPT(404.42,SCTMA,0)),U,3)
 S DIC("S")="IF $D(^SCTM(404.57,""C"","_SCTM_",Y))"
 Q
OKPTTM(SCNODE,DA) ;check pt team assignment - 404.42
 ; SCNODE is proposed new node
 Q 1
 N OK,DFN,SCTM,SCACT,SCINACT,SCDTS,SCTMHIST,SCB4,SCAFT
 S OK=1
 G:'DA QTOKTM
 S DFN=$P(SCNODE,U,1)
 S SCTM=$P(SCNODE,U,3)
 S SCACT=$P(SCNODE,U,2)
 S SCINACT=$P(SCNODE,U,9)
 S:$G(SCACT) SCDTS("BEGIN")=SCACT
 S:$D(SCACT) SCDTS("END")=$S(SCINACT:SCINACT,1:3990101)
 S:$D(SCDTS) SCDTS("INCL")=1
 ;check patient (.01) - none now
 ;check team (.03)
 IF SCINACT&('SCACT) S OK=0_U_"Activation must be defined before Discharge" G QTOKTM
 IF SCTM&SCACT&DFN D
 .S SCTMHIST=$$ACTHIST^SCAPMCU2(404.58,.SCTM,.SCDTS)
 .S:'SCTMHIST OK=0_U_"Team Not Active"
 .;check assignment dt (.02)
 .;  - is there an assignment on exactly the same date in 404.42?
 .S SCPTTMA=0 F  S SCPTTMA=$O(^SCPT(404.42,"AIDT",DFN,SCTM,-SCACT,SCPTTMA)) Q:SCPTTMA=""!(SCPTTMA=DA)!(DA="")  S OK=0_U_"Already an activation for patient/team on this date"
 .;  - is there an assignment w/o a discharge before in 404.42?
 .S SCB4=$O(^SCPT(404.42,"AIDT",DFN,SCTM,-SCACT))
 .S SCB4A=$O(^SCPT(404.42,"AIDT",DFN,SCTM,+SCB4,0))
 .S:SCB4A&('$P($G(^SCPT(404.42,+SCB4A,0)),U,9)) OK=0_U_"Existing active patient/team assignment already"
 .;check inactivation dt (.09)
 .;  - if exists, is inactivation after assignment dt
 .S:SCINACT&(SCACT'<SCINACT) OK=0_U_"Activation must be before discharge"
 .;  - if there is a future assignment is it after this inactivation?
 .S SCAFT=-$O(^SCPT(404.42,"AIDT",DFN,SCTM,-SCINACT),-1)
 .S:SCAFT&(SCAFT'>SCINACT) OK=0_U_"Existing future activation before this inactivation"
QTOKTM Q OK
 ;
INSTPCTM(DFN,SCEFF) ;return institution & team for pt's pc team
 ; return ptr4^institution^sctm^team name
 N SCTM,SCINST,SCOK
 S SCOK=0
 S SCTM=+$$GETPCTM^SCAPMCU2(.DFN,.SCEFF,1)
 S SCINST=+$P($G(^SCTM(404.51,+$G(SCTM),0)),U,7)
 S:SCTM&SCINST SCOK=1
 Q $S('SCOK:0,1:SCTM_U_$P($G(^SCTM(404.51,SCTM,0)),U,1)_U_SCINST_U_$P($G(^DIC(4,SCINST,0)),U,1))
 ;
EVT(SCCVEVT,SCCVORG) ;Invoke encounter conversion event driver
 ; Input  -- SCCVEVT  Conversion event
 ;                    0=Estimate, 1=Convert, 2=Re-convert
 ;           SCCVORG  Originating process type
 ; Output -- ^TMP("SCCVEVT",$J, disposition array
 K DTOUT,DIROUT
 S X=+$O(^ORD(101,"B","SCMC ENCOUNTER CONVERSION EVENTS",0))_";ORD(101,"
 I X D EN^XQOR
 K X,^TMP("SCCVEVT",$J)
EVTQ Q
