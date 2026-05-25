XMDB1P4 ;OAK/LMB - v4 MAILMAN DOMAIN POST INSTALL UPDATE; 22 Aug 2024
 ;;1.0;MAILMAN DOMAIN UPDATES;**4**;Nov 8, 2016;Build 14
 ;;Per VHA Directive 2004-038, this routine should not be modified
 Q
 ;
POST ;post install entry point
 N XUIEN,XMDB,FERR,XUDOMAIN
 S XMDB=$G(XUDOMAIN,"SURGERYSRA.DOMAIN.EXT")
 S XUIEN=$$ADDENT(XMDB) IF XUIEN=0 Q
 I $$ADDSUB(XUIEN)=0 Q
 I $$ADDWF(XUIEN)=0 Q
 D:$$PROD^XUPROD'=0 BMES^XPDUTL("NOTE: Flag was set to 'S' due to PRODUCTION environment.")
 D:$$PROD^XUPROD=0 BMES^XPDUTL("NOTE: Flag was set to 'C' due to NON-PRODUCTION environment.")
 Q
 ;
ADDENT(XMDB) ;add DOMAIN entry if matching entry not found
 N FDA
 S FDA(4.2,"?+1,",.01)=XMDB
 S FDA(4.2,"?+1,",1)="S" ;default 
 S:$$PROD^XUPROD=0 FDA(4.2,"?+1,",1)="C" ;for non-production environments
 D UPDATE^DIE("E","FDA","IEN","DIERR")
 I $D(DIERR) D BMES^XPDUTL("Error adding/modifying domain "_$G(DIERR)) Q 0
 Q 1
 ;
ADDSUB(XUIEN) ;Add/modify TRANSMISSION SCRIPT subfile
 K FDA,DIERR,IENS
 S XUIEN=IEN(1)
 S IENS="?+2,"_XUIEN_","
 S FDA(4.21,IENS,.01)="TCP/IP"
 S FDA(4.21,IENS,1)=1
 S FDA(4.21,IENS,1.1)=5
 S FDA(4.21,IENS,1.2)="SMTP"
 S FDA(4.21,IENS,1.3)="NULL DEVICE"
 S FDA(4.21,IENS,1.4)="ecp.surgerysra.domain.ext"
 D UPDATE^DIE("","FDA","XUIEN","DIERR")
 I $D(DIERR) D BMES^XPDUTL("Error adding subfile to domain "_$G(DIERR)) Q 0
 Q 1
 ;
ADDWF(XUIEN) ;Set TEXT of WP field using the same TRANSMISSION SCRIPT called by FO-HINES.DOMAIN.EXT
 K DIERR,IENS
 N FIEN,XFM,XFMC,XFMX,TXIEN,LASTLINE,FWP
 I $$FIND1^DIC(4.2,"","","FO-HINES.DOMAIN.EXT")'=0 D
 .S FIEN=$$FIND1^DIC(4.2,"","","FO-HINES.DOMAIN.EXT")
 .S FIEN1=","_FIEN_","
 .S TXIEN=$$FIND1^DIC(4.21,FIEN1,"","TCP")
 .I TXIEN>0 D
 ..S FIEN2=TXIEN_","_FIEN
 ..S XFM=$$GET1^DIQ(4.21,FIEN2,2,"","FWP")
 ..S LASTLINE=$ORDER(FWP(""),-1)
 ..I LASTLINE=2,FWP(2)?1"C ".E S XFMC=FWP(2)
 ..I LASTLINE=3,FWP(3)?1"C ".E S XFMX=FWP(2),XFMC=FWP(3)
 I $D(XFMC)=0 D
 .S XFMC="**If PRODUCTION - I need a SCRIPT to call. Contact support.**"
 .D:$$PROD^XUPROD'=0 BMES^XPDUTL("**WARNING: No SCRIPT could be identified! Contact support.**")
 S XUIEN=IEN(1)
 S IENS="1,"_XUIEN_","
 S ^TMP($J,"WP",1)="O H=SURGERYSRA.DOMAIN.EXT,P=TCP/IP-MAILMAN"
 S:$G(XFMX)'="" ^TMP($J,"WP",2)=XFMX,^TMP($J,"WP",3)=XFMC
 S:$G(XFMX)="" ^TMP($J,"WP",2)=XFMC
 D WP^DIE(4.21,IENS,2,"","^TMP($J,""WP"")","DIERR")
 K FWP,IEN,^TMP($J,"WP"),FIEN,XFM,XUIEN,IENS,FIEN1,FIEN2,TXIEN
 I $D(DIERR) D BMES^XPDUTL("Error adding TEXT for "_XMDB_$G(DIERR)) Q 0
 Q 1
