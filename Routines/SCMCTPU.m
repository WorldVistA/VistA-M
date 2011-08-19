SCMCTPU ;ALB/REW - Team Position Utilities ; 9 Jun 1995
 ;;5.3;Scheduling;**41,130**;AUG 13, 1993
 ;1
ACTPTTM(SCPTTM,SCDT) ;is the patient- team assignment currently active?
 ; Used by computed field #300 (CURRENTLY ACTIVE?) OF file #404.57
 ; Input:
 ;  SCPTTM  - Pointer to Patient Team Assignment file -404.42
 ;  SCDT  - Date to check for, Default=DT
 ; Returns
 ;   status^status change date
 ; status:
 ;   1  if after effective date and before inactive date
 ;   0  if not yet active or inactivated already
 ;   -1 if error
 ;999
 ;new code
 N SCOK,STATUS,EFFDT,SCNODE
 S:'$D(SCDT) SCDT=DT
 S SCNODE=$G(^SCPT(404.42,+SCPTTM,0))
 ;no act=-1,dt before act=0,no inact=1,dt after inact=0,o/w=1
 Q $S(('$P(SCNODE,U,2)):-1,(SCDT<$P(SCNODE,U,2)):0,('$P(SCNODE,U,9)):1,(SCDT>$P(SCNODE,U,9)):0,1:1)
 ;
ACTTP(SCTP,SCDT) ;is the team position currently active?
 ; Used by computed field #300 (CURRENTLY ACTIVE?) OF file #404.57
 ; Input:
 ;  SCTP  - Pointer to Team Position file #404.57
 ;  SCDT  - Date to check for, Default=DT
 ; Returns
 ;   status^status change date
 ; status:
 ;   1  if after effective date and before inactive date
 ;   0  if not yet active or inactivated
 ;   -1 if error
 ;
 ;new code
 N SCX,STATUS,EFFDT
 S:'$D(SCDT) SCDT=DT
 S SCX=$$DATES^SCAPMCU1(404.59,SCTP,SCDT)
 S STATUS=$P(SCX,U,1)
 S EFFDT=$S(STATUS=0:$P(SCX,U,3),(STATUS=1):$P(SCX,U,2),1:"")
QTACTTP Q STATUS_U_EFFDT
 ;
ITSCF(CRITERIA,REPORT,X) ;
 ;Input transform for 404.93
 ;CRITERIA - value of the .01 in 404.93 for entry DA
 ;REPORT - value of the .02 in 404.93 for entry DA
 ;X - value entered by user
 ;X is killed if duplicate
 ;
 Q:'$G(DA)!'$D(X)
 S:'$D(CRITERIA) CRITERIA=$P($G(^SD(404.93,DA,0)),U)
 S:'$D(REPORT)#2 REPORT=$P($G(^SD(404.93,DA,0)),U,2)
 I $D(^SD(404.93,"APRIM",CRITERIA,REPORT)) D
 .D:'$G(DGQUIET) EN^DDIOL("Duplicate Criteria Not Allowed for Same Report","","?5")
 .K X
 Q
 ;
AKEY(REPORT,SORT,X) ;
 ;Input transform for 404.92
 ;REPORT - value of the .01 in 404.92 for entry DA
 ;SORT - value of the .02 in 404.92 for entry DA
 ;X - value entered by user
 ;X is killed if duplicate
 ;
 Q:'$G(DA)!'$D(X)
 S:'$D(REPORT) REPORT=$P($G(^SD(404.92,DA,0)),U)
 S:'$D(SORT)#2 SORT=$P($G(^SD(404.92,DA,0)),U,2)
 I $D(^SD(404.92,"AKEY",REPORT,SORT)) D
 .D:'$G(DGQUIET) EN^DDIOL("Duplicate SORT BY TEXT Not Allowed for Same Report","","?5")
 .K X
 Q
 ;
IPTF(POSITION,TEAM,X) ;input transform for 404.57
 ;kills x if duplicate
 Q:'$G(DIUTIL)="VERIFY FIELDS"
 Q:'$G(DA)!'$D(X)
 S:'$D(POSITION) POSITION=$P($G(^SCTM(404.57,DA,0)),U,1)
 S:'$D(TEAM)#2 TEAM=$P($G(^SCTM(404.57,DA,0)),U,2)
 ;S:'$G(TEAM) TEAM=$O(^SCTM(404.51,"B",TEAM,0))
 IF $D(^SCTM(404.57,"APRIMARY",POSITION,TEAM)) D
 .D:'$G(DGQUIET) EN^DDIOL("Duplicate Team Positions Not Allowed","","?5")
 .K X
 Q
OKACTTP(SCNODE,ACTDT) ;input transform for position assigned date for 404.43
 ;
 N OK
 S OK=1
 ;must have input defined
 IF '$D(SCNODE)#2!('$G(ACTDT)) S OK=0_U_"Bad input data" G QTOKAC
 ;if inactivation exists must be after activation
 S:$P(SCNODE,U,4)&($P(SCNODE,U,4)<ACTDT) OK=0_U_"Inactivation date is after this date"
 ;position must be active during assignment activation
 S:'$$ACTTP(+$P(SCNODE,U,2),ACTDT) OK=0_U_"Position Not active on this date"
 S:1>$$ACTPTTM(+$P(SCNODE,U,1),ACTDT) OK=0_U_"No active Patient Team Assignment on this date"
QTOKAC Q OK
OKINTP(SCNODE,INACTDT) ;input transform for inactivation date for 404.43
 ;
 N OK
 S OK=1
 ;must have input defined
 IF '$D(SCNODE)#2!('$G(INACTDT)) S OK=0 G QTOKIN
 ;must have activation date
 S:'$P(SCNODE,U,3) OK=0_U_"No activation date in Pt Team Assignment"
 ;activation date can't be after inactivation
 S:$P(SCNODE,U,3)>INACTDT OK=0_U_"Activation date is after this date"
 ;inactivation must be during time when position is active
 S:'$$ACTTP(+$P(SCNODE,U,2),INACTDT) OK=0_U_"Inactivation date must be when position is active"
QTOKIN Q OK
 ;
OKTP(DA,SCX) ;used by team position field of 404.43
 N OK,SCTM,SCPTTMA,SCNODE
 S SCNODE=$G(^SCPT(404.43,DA,0))
 S OK=1
 ;must have input defined
 IF '$D(SCNODE)#2!('$G(SCX)) S OK=0 G QTOKTP
 S SCTM=$P($G(^SCTM(404.57,SCX,0)),U,2)
 S SCPTTMA=$P(SCNODE,U,1)
 S:$P($G(^SCPT(404.42,SCPTTMA,0)),U,3)'=SCTM OK=0_U_"Team Position Must be from Team in Pt Team Assignment"
QTOKTP Q OK
 ;
OKROLE(DA,SCX) ;used by role .05 field of 404.43
 N OK,SCNODE,SCPTTMA,SCPC
 S SCNODE=$G(^SCPT(404.43,DA,0))
 S OK=1
 ;must have input defined
 IF '$D(SCNODE)#2!('$D(SCX)) S OK=0_U_"Undefined Patient Team Data" G QTOKTP
 S SCPTTMA=$P(SCNODE,U,1)
 S:$P($G(^SCPT(404.42,SCPTTMA,0)),U,8)=1 SCPC=1
 ;if not a pc team & role is a pc role - not ok
 S:('$G(SCPC))&$G(SCX) OK=0_U_"PC Roles only allowed if Pt Team Assignment is for Primary Care"
QTOKRL Q OK
 ;
USEUSR() ;should user class functionality be employed?
 ;  Returned [1=Use USR Class,0=Don't)
 Q +$G(^SD(404.91,1,"PCMM"))
 ;
ACCLIN(SC44,DATE) ;is clinic active on this date?
 ;  Return: 1=Yes,0=N0
 N SCX
 S SCX=+$G(^SC(+$G(SC44),"I"))
 Q $S('SCX:1,(SCX>DATE):1,1:0)
