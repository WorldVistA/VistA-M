SCMCEV1 ;ALB/CMM - TEAM EVENT DRIVER UTILITIES ; 03/20/96
 ;;5.3;Scheduling;**41,130,140**;AUG 13, 1993
 ;
ENROLL(DFN,TIEN,ENDATE,DISDATE,CNAME) ;
 ;enroll DFN patient in team TIEN
 ;DFN - patient ien
 ;TIEN - team ien
 ;ENDATE - clinic enrollment date
 ;DISDATE - clinic discharge date
 ;CNAME - clinic name
 ;
 N OKAY,ERR,PUR,SC,SCERR,TNAME,TEXT
 S TNAME=$P($G(^SCTM(404.51,TIEN,0)),"^") ;team name
 S OKAY=$$ACPTTM^SCAPMC6(DFN,TIEN,,ENDATE,"ERR")
 I OKAY=0 Q
 ;okay = ien of 404.42
 S PUR(1,0)="Automatic Team Enrollment/Update via Clinic: "_CNAME
 I '$D(SCERR) D
 .D WP^DIE(404.42,+OKAY_",","1","A","PUR","SCERR")
 .S TEXT="Enrolled in Team: "_TNAME
 .D:'$G(DGQUIET) EN^DDIOL(TEXT,"","!,?10")
 K SCERR,ERR
 I $D(DISDATE) D
 .S PUR(1,0)="Automatic Team Discharge via Clinic: "_CNAME
 .Q:'$$POSASS^SCMCEV2(DFN,TIEN)
 .S OKAY=$$INPTTM^SCAPMC7(DFN,TIEN,DISDATE,"ERR")
 .I OKAY'=0 D
 ..D WP^DIE(404.42,+OKAY_",","1","A","PUR","SCERR")
 ..S TEXT="Discharged from Team: "_TNAME
 ..D:'$G(DGQUIET) EN^DDIOL(TEXT,"","!,?10")
 Q
 ;
UPDATE(DFN,TIEN,EDATE,DDATE,CNAME) ;
 ;update enrollment date/discharge date
 ;DFN - patient ien
 ;TIEN - team ien
 ;EDATE - enrollment date
 ;DDATE - discharge date
 ;CNAME - clinic name
 ;
 N TPA,TDATE,TEXT,TNAME
 S TNAME=$P($G(^SCTM(404.51,TIEN,0)),"^") ;team name
 I '$D(^SCPT(404.42,"AIDT",DFN,TIEN)) D ENROLL(TIEN,DFN,EDATE,DDATE,CNAME) Q
 ; ^ new enrollment
 S TDATE=$O(^SCPT(404.42,"AIDT",DFN,TIEN,"")) ; -team assignment date (most recent)
 S TPA=$O(^SCPT(404.42,"AIDT",DFN,TIEN,TDATE,"")) ; team assignment ien
 Q:'$D(^SCPT(404.42,+TPA,0))
 K SC($J,404.42),SCERR
 I EDATE'=0 D
 .S SC($J,404.42,TPA_",",.13)=DUZ
 .S SC($J,404.42,TPA_",",.14)=DT
 .S SC($J,404.42,TPA_",",.02)=$P(EDATE,".") ;date only
 .D FILE^DIE("","SC($J)","SCERR")
 .S PUR(1,0)="Automatic Team Update via Clinic:  "_CNAME
 .D WP^DIE(404.42,TPA_",","1","A","PUR","SCERR")
 .S TEXT="Update Team Enrollment "_TNAME
 .D:'$G(DGQUIET) EN^DDIOL(TEXT,"","!,?10")
 I +DDATE'=0 D
 .Q:'$$POSASS^SCMCEV2(DFN,TIEN)
 .; ^ assigned to a position
 .S OKAY=$$INPTTM^SCAPMC7(DFN,TPA,DDATE,"ERR") ; discharge from team
 .I OKAY'=0 D
 ..D WP^DIE(404.42,+OKAY_",","1","A","PUR","SCERR")
 ..S TEXT="Discharged from Team: "_TNAME
 ..D:'$G(DGQUIET) EN^DDIOL(TEXT,"","!,?10")
 Q
 ;
DELT(DFN,CLN) ;deleted clinic entry/enrollment date w/'@'
 ;DFN - patient ien
 ;CLN - clinic ien
 ;
 N CHECK,TM,EDATE,OKAY,CNAME,ERR,TEXT,TNAME
 S CNAME=$P($G(^SC(+CLN,0)),"^") ;clinic name
 S CHECK=$$CHK^SCMCEV2(DFN,CLN,2)
 ; ^ auto discharge okay
 Q:'+CHECK
 ;check if assigned to a position on team
 S TM=+$P(CHECK,"^",2) ;team ien
 S OKAY=$$POSASS^SCMCEV2(DFN,TM)
 Q:'OKAY
 ;delete entry
 S ERR=$$DELTE(DFN,TM)
 I ERR D
 .;deleted entry
 .S TNAME=$P($G(^SCTM(404.51,TM,0)),"^") ;team name
 .S TEXT="Deleted team "_TNAME_" assignment due to deleting clinic assignment"
 .D:'$G(DGQUIET) EN^DDIOL(TEXT,"","!,?10")
 Q
 ;
DELTE(DFN,TIEN) ;delete team assignment entry
 ;DFN - patient ien
 ;TIEN - team ien
 N PTA,ADATE,RET
 S RET=1
 S ADATE=$O(^SCPT(404.42,"AIDT",DFN,TIEN,-($$FMADD^XLFDT(DT,1))))
 I ADATE="" S RET=0 G EXD
 S PTA=$O(^SCPT(404.42,"AIDT",DFN,TIEN,ADATE,""))
 I PTA="" S RET=0 G EXD
 S DA=PTA,DIK="^SCPT(404.42,"
 D ^DIK
 K DA,DIK
EXD Q RET
