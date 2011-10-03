HDI1002A ;BPFO/JRP,ALB/RMO - PATCH 2 POST INSTALL;9/27/2005
 ;;1.0;HEALTH DATA & INFORMATICS;**2**;Feb 22, 2005
 ;
POST ;Main entry point for post-install routine
 ; Input: None
 ;        All variables set by Kernel for KIDS post-installs
 ;Output: None
 N HDIMSG
 S HDIMSG(1)=" "
 S HDIMSG(2)="~~~~~~~~~~~~~~~~~~~~"
 S HDIMSG(3)="Post-Installation (POST^HDI1002A) will now be run"
 S HDIMSG(4)=" "
 D MES^XPDUTL(.HDIMSG) K HDIMSG
 D SCAN
 S HDIMSG(1)=" "
 S HDIMSG(2)="Post-Installation ran to completion"
 S HDIMSG(3)="~~~~~~~~~~~~~~~~~~~~"
 S HDIMSG(4)=" "
 D MES^XPDUTL(.HDIMSG) K HDIMSG
 Q
 ;
SCAN ;Scan XTID VUID FOR SET OF CODES file for duplicate statuses
 ; Input: None
 ;Output: None
 ; Notes: Call assumes it is being run within the context of KIDS
 N COUNT,PTRXTID,XPDIDTOT,TEXT
 S TEXT(1)=" "
 S TEXT(2)="Scanning EFFECTIVE DATE/TIME multiple (subfile #8985.11)"
 S TEXT(3)="of the XTID VUID FOR SET OF CODES file (#8985.1) for"
 S TEXT(4)="consecutive storage of the same status"
 S TEXT(5)=" "
 D MES^XPDUTL(.TEXT)
 S XPDIDTOT=+$O(^XTID(8985.1,"A"),-1)
 ;Traverse file
 S PTRXTID=0
 F COUNT=1:1 S PTRXTID=+$O(^XTID(8985.1,PTRXTID)) Q:'PTRXTID  D
 .;Show progress through KIDS status bar
 .I '(COUNT#10) D UPDATE^XPDID(PTRXTID)
 .;Execute check
 .D CHECK(PTRXTID)
 D UPDATE^XPDID(XPDIDTOT)
 Q
 ;
CHECK(PTRXTID) ;Check entry for duplicate statuses
 ; Input: PTRXTID - Pointer to XTID VUID FOR SET OF CODES file
 ;Output: None
 ; Notes: Assumes validity of PTRXTID (internal call)
 S PTRXTID=+$G(PTRXTID) Q:'PTRXTID
 N MLTIEN,STAT,STDT,PRVSTAT,PRVSTDT,NODE
 S (PRVSTAT,PRVSTDT)=""
 ;Traverse date x-ref of multiple
 S STDT=0
 F  S STDT=+$O(^XTID(8985.1,PTRXTID,"TERMSTATUS","B",STDT)) Q:'STDT  D
 .S MLTIEN=0
 .F  S MLTIEN=+$O(^XTID(8985.1,PTRXTID,"TERMSTATUS","B",STDT,MLTIEN)) Q:'MLTIEN  D
 ..;Get node/status
 ..S NODE=$G(^XTID(8985.1,PTRXTID,"TERMSTATUS",MLTIEN,0))
 ..S STAT=$P(NODE,"^",2)
 ..;Bad node/status - delete and quit
 ..I (NODE="")!(NODE="^")!(STAT="") D  Q
 ...D DELETE(PTRXTID,MLTIEN)
 ..;First status entry - set as previous status and quit
 ..I PRVSTAT="" D SETPRV Q
 ..;Same as previous status - delete
 ..I STAT=PRVSTAT D DELETE(PTRXTID,MLTIEN) Q
 ..;Different status - keep and remember status change
 ..D SETPRV
 Q
 ;
DELETE(PTRXTID,MLTIEN) ;Delete entry from EFFECTIVE DATE/TIME multiple
 ; Input: PTRXTID - Pointer to XTID XTID VUID FOR SET OF CODES file
 ;        MLTIEN - Pointer to entry in EFFECTIVE DATE/TIME multiple
 ;Output: None
 ; Notes: Assumes validity of PTRXTID & MLTIEN (internal call)
 S PTRXTID=+$G(PTRXTID) Q:'PTRXTID
 S MLTIEN=+$G(MLTIEN) Q:'MLTIEN
 N DA,DIK
 S DA=MLTIEN
 S DA(1)=PTRXTID
 S DIK="^XTID(8985.1,"_DA(1)_",""TERMSTATUS"","
 D ^DIK
 Q
 ;
SETPRV ;Set previous values
 ; Input: STAT
 ;        STDT
 ;Output: PRVSTAT
 ;        PRVSTDT
 S PRVSTAT=$G(STAT)
 S PRVSTDT=$G(STDT)
 Q
