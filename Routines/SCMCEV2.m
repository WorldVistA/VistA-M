SCMCEV2 ;ALB/CMM - TEAM EVENT DRIVER UTILITIES ; 03/20/96
 ;;5.3;Scheduling;**41**;AUG 13, 1993
 ;
ACT(DFN,TIEN) ; active team assignment
 N ACTD,FND,ENT
 S ACTD="",FND=0
 F  S ACTD=$O(^SCPT(404.42,"AIDT",DFN,TIEN,ACTD)) Q:ACTD=""!(FND)  D
 .S ENT=$O(^SCPT(404.42,"AIDT",DFN,TIEN,ACTD,""))
 .Q:ENT=""
 .I $P($G(^SCPT(404.42,ENT,0)),"^",9)="" S FND=1
 Q FND
 ;
CHK(DFN,CLIEN,FLG) ;
 ;check if auto enroll/discharge is appropriate
 ;DFN - patient ien
 ;EN1 - "DE" entry ien
 ;CLIEN - clinic ien
 ;FLG - add-1/del-2/both-3 flag
 ;
 ;RETURNS: 1^team ien = auto enroll/discharge
 ;         0 - don't allow auto enroll/discharge
 ;
 N RETURN,LIST,ERR,OKAY,ACTIVE,TNODE,TIEN
 S RETURN=0,LIST="TCLIST",ERR="ERR1"
 K @LIST,@ERR
 S OKAY=$$TMCL^SCAPMC16(CLIEN,"",.LIST,.ERR)
 G:'OKAY EXIT
 G:@LIST@(0)<0!(@LIST@(0)>1) EXIT
 ;unique team
 S TIEN=+$P($G(@LIST@(1)),"^")
 I FLG=1!(FLG=3),$P($G(^SCTM(404.51,TIEN,0)),"^",11)'=1 G EXIT
 I FLG=2!(FLG=3),$P($G(^SCTM(404.51,TIEN,0)),"^",12)'=1 G EXIT
 ;auto enroll/discharge flag on to allow
 S TNODE=$G(^SCTM(404.51,TIEN,0))
 I $P(TNODE,"^",10)=1 G EXIT ;team close to future assignments
 I $P(TNODE,"^",5)=1&($G(^DPT(DFN,"VET"))'="Y") G EXIT ;pc team but not vet
 S ACTIVE=0
 I $D(^SCPT(404.42,"AIDT",DFN,TIEN)) S ACTIVE=$$ACT(DFN,TIEN)
 ;enrolled on team but is it still active
 I ACTIVE&(FLG=1) G EXIT ;already enrolled
 S RETURN="1^"_TIEN ;update/enroll
EXIT ;
 K @LIST,@ERR
 Q RETURN
 ;
POSASS(DFN,TM) ;patient assigned to position on team TM
 ;DFN - patient ien
 ;TM - team ien
 N PPLIST,ERR,OKAY,CNT,STOP
 S STOP=0
 S OKAY=$$TPPT^SCAPMC23(DFN,"","","","","","","PPLIST","ERR")
 ;returns all positions patient assigned to today
 Q:'OKAY -1
 Q:'$D(PPLIST) 1  ;no associated positions
 S CNT=0
 F  S CNT=$O(PPLIST(CNT)) Q:CNT=""!(CNT'?.N)!(STOP)  D
 .I +$P($G(PPLIST(CNT)),"^",3)=TM S STOP=1
 I 'STOP Q 1
 Q 0
