RA84POS ;Hines OI/GJC - Post-init Driver, patch 84 ;01/07/06  06:32
VERSION ;;5.0;Radiology/Nuclear Medicine;**84**;Mar 16, 1998;Build 13
 ;
 ;Integration Agreements
 ;----------------------
 ;$$FIND1^DIC(2051); FILE^DIE(2053); UPDATE^DIE(2053); BMES^XPDUTL(10141)
 ;
EN ;Entry point
 N DIERR,RAERR,RAF,RAFDA,RAHLAPP,RAIEN,RATXT,RAY
 S:'$D(U) U="^"
 ;Find the IEN of 'RA-SCIMAGE-TCP' in the RAD/NUC MED HL7 APPLICATION EXCEPTION (#79.7) file.
 ;Is 'RA-SCIMAGE-TCP' already in 79.7? If not find the IEN in file 771 & add it to file 79.7.
 S RAHLAPP=$$FIND1^DIC(79.7,"","X","RA-SCIMAGE-TCP")
 I 'RAHLAPP D
 .S RAHLAPP=$$FIND1^DIC(771,"","X","RA-SCIMAGE-TCP")
 .S RAFDA(79.7,"+1,",.01)=RAHLAPP,RAFDA(79.7,"+1,",1)=1
 .S RAIEN(1)=RAHLAPP D UPDATE^DIE("","RAFDA","RAIEN","RAERR")
 .S:$G(RAIEN(1))'>0 RAERR("DIERR")=""
 .Q
 ;
 I ($D(RAERR("DIERR"))#2) D  Q
 .S RATXT(1)="'RA-SCIMAGE-TCP' is not a record in the RAD/NUC MED HL7 APPLICATION EXCEPTION"
 .S RATXT(2)="(#79.7) file. Please contact the national Radiology development team about this"
 .S RATXT(3)="issue." D BMES^XPDUTL(.RATXT)
 .Q
 ;
 ;The 'TELERADIOLOGY APPLICATION' (fld: 1) for 'RA-SCIMAGE-TCP' should be defined as '1' or Yes
 I $P(^RA(79.7,RAHLAPP,0),U,2)'=1 D
 .S RAFDA(79.7,RAHLAPP_",",1)=1 ;internal value
 .D FILE^DIE("","RAFDA","RAERR") S RATXT(1)=""
 .S:($D(RAERR("DIERR")))#2 RATXT(2)="Error setting 'RA-SCIMAGE-TCP' as a 'TELERADIOLOGY' application type."
 .S:$G(RATXT(2))="" RATXT(2)="'RA-SCIMAGE-TCP' is now defined as a 'TELERADIOLOGY' application type."
 .D BMES^XPDUTL(.RATXT)
 .Q
 ;
 ;The 'APPLICATION TYPE' (fld: 1.3) for 'RA-SCIMAGE-TCP' should be defined as 'S' for
 ;'Speech Recognition'.
 I $P(^RA(79.7,RAHLAPP,0),U,5)'="S" D
 .S RAFDA(79.7,RAHLAPP_",",1.3)="S" ;internal value
 .D FILE^DIE("","RAFDA","RAERR") S RATXT(1)=""
 .S:($D(RAERR("DIERR")))#2 RATXT(2)="Error setting 'RA-SCIMAGE-TCP' as a 'Speech Recognition' APPLICATION TYPE."
 .S:$G(RATXT(2))="" RATXT(2)="'RA-SCIMAGE-TCP' is now defined as a 'Speech Recognition' APPLICATION TYPE."
 .D BMES^XPDUTL(.RATXT)
 .Q
 ;
 K DIERR,RAERR,RAFDA,RATXT
 ;update the following fields in the RAD/NUC MED HL7 APPLICATION EXCEPTION
 ;(#79.7) file with the most recent Dx Codes (999-1003 series implemeted with V9)
 ; DEFAULT DX FOR 'R' REPORT (#2.1)
 ; DEFAULT DX FOR 'F' REPORT (#2.2)
 I $G(^RA(78.3,999,0))="TELERADIOLOGY, NOT YET DICTATED^^N^n" D
 .S RAFDA(79.7,RAHLAPP_",",2.1)=999
 .I $G(^RA(78.3,1000,0))="NO ALERT REQUIRED^^N^n" S RAF=1,RAFDA(79.7,RAHLAPP_",",2.2)=1000
 .D FILE^DIE("","RAFDA","RAERR")
 .I ($D(RAERR("DIERR")))#2 D
 ..S RAY=0 F  S RAY=$O(RAERR("DIERR",RAY)) Q:'RAY  S RATXT(RAY)=$G(RAERR("DIERR",RAY,"TEXT",1))
 ..Q
 .E  D
 ..S RATXT(1)="'TELERADIOLOGY, NOT YET DICTATED' added as the 'DEFAULT DX FOR 'R' REPORT' value."
 ..S:$G(RAF)=1 RATXT(2)="'NO ALERT REQUIRED' added as the 'DEFAULT DX FOR 'F' REPORT' value."
 ..Q
 .D BMES^XPDUTL(.RATXT)
 .Q
 ;
ILOC ; assign active imaging locations to RADIOLOGY,OUTSIDE SERVICE
 ;
 N DIERR,RAERR,RAFDA,RAIEN,RATODAY
 S (RAIEN,RAIEN(0))=$$FIND1^DIC(200,"","X","RADIOLOGY,OUTSIDE SERVICE"),RATODAY=$$DT^XLFDT()
 I RAIEN=0!($D(DIERR)#2) D  Q
 .D BMES^XPDUTL("Failed NEW PERSON file lookup on: RADIOLOGY,OUTSIDE SERVICE") Q
 ;
 ;if this i-loc have been assigned to RADIOLOGY,OUTSIDE SERVICE quit (do not create duplicates)
 Q:$O(^VA(200,RAIEN,"RAL",0))
 ;
 ;find only active radiology imaging locations...
 N RAX,RAY S RAY=0,RAIEN=","_RAIEN_","
 F  S RAY=$O(^RA(79.1,RAY)) Q:'RAY  S RAX=$G(^(RAY,0)) D
 .I $P(RAX,U,19),($P(RAX,U,19)'>RATODAY) Q  ;inactive location
 .S RAFDA(200.074,"+"_RAY_RAIEN,.01)=RAY Q
 ;
 Q:'($D(RAFDA(200.074))\10)  ;quit there is no data to file
 ;
 ;lock the RADIOLOGY,OUTSIDE SERVICE record in file 200, exit gracefully if locked by another
 L +^VA(200,RAIEN(0)):$G(DILOCKTM,3)
 I '$T D BMES^XPDUTL("RADIOLOGY,OUTSIDE SERVICE is locked by another user!") Q
 ;
 D UPDATE^DIE("","RAFDA","","RAERR")
 I $D(RAERR("DIERR"))#2 D
 .N RATXT S RATXT(1)="Error assigning imaging locations to RADIOLOGY,OUTSIDE SERVICE."
 .S RATXT(2)=$G(RAERR("DIERR","1","TEXT",1)) D BMES^XPDUTL(.RATXT) Q
 E  D BMES^XPDUTL("Imaging locations have been assigned to RADIOLOGY,OUTSIDE SERVICE.")
 ;
 ;unlock the RADIOLOGY,OUTSIDE SERVICE record in the NEW PERSON file
 L -^VA(200,RAIEN(0))
 Q
 ;
