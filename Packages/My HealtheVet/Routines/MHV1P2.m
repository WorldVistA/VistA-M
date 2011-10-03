MHV1P2 ;WAS/GPM - My HealtheVet Install Utility Routine ; 2/2/08 12:35pm
 ;;1.0;My HealtheVet;**2**;Aug 23, 2005;Build 22
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;  Integration Agreements:
 ;        10141 : BMES^XPDUTL
 ;              : MES^XPDUTL
 ;         3552 : PARAM^HLCS2
 ;
ENV ;
 Q
 ;
PRE ; Pre-init routine
 ; Turn on MHV Application Logging, add a log entry for the start
 ; of the patch install.
 D LOGON
 D LOG^MHVUL2(XPDNM,"PRE-INIT","S","TRACE")
 Q
 ;
POST ; Post-init routine
 ; Add a log entry for the post init, and turn off logging.
 D LOG^MHVUL2(XPDNM,"POST-INIT BEGIN","S","TRACE")
 ;
 D BMES^XPDUTL("     Updating MHVVA logical link")
 I '$$UPDLINK D
 . D BMES^XPDUTL("     *** Update to MHVVA logical link failed.")
 . D MES^XPDUTL("     Please update the MHVVA logical link manually.")
 . D MES^XPDUTL("     The DNS DOMAIN field shoud be 'MHV.MED.VA.GOV'")
 . D MES^XPDUTL("     The AUTOSTART field should be 'Enabled'")
 . D MES^XPDUTL("     No other fields should be changed.")
 . D MES^XPDUTL("     If you need help with this please consult the HL7 System Manager")
 . D MES^XPDUTL("     Guide, or log a Remedy Ticket.")
 . Q
 ;
 I '$$LOGCHK D
 . D LOG^MHVUL2("LOG CHECK","FAILED","S","TRACE")
 . D BMES^XPDUTL("     *** An HL7 message was processed by MHV during installation.")
 . D MES^XPDUTL("     Please check your error trap.  If you find an error in an MHV")
 . D MES^XPDUTL("     routine, please log a remedy ticket.")
 . Q
 D LOG^MHVUL2(XPDNM,"POST-INIT END","S","TRACE")
 D LOGOFF
 D RESET^MHVUL2
 Q
 ;
LOGON ; Turn on MHV application logging
 N UPDATE,SUCCESS
 D BMES^XPDUTL("     Turning on MHV Application Logging")
 S UPDATE("STATE")=1
 S UPDATE("DELETE")=$$HTFM^XLFDT($H+60)
 S UPDATE("LEVEL")="DEBUG"
 D LOGSET^MHVUL1(.SUCCESS,.UPDATE)
 Q
 ;
LOGOFF ; Turn off MHV application logging
 N SUCCESS
 D BMES^XPDUTL("     Turning off MHV Application Logging")
 D LOGOFF^MHVUL1(.SUCCESS)
 Q
 ;
LOGCHK() ; Check for log entries during patch installation
 N DTM,PREDTM,J,FLAG
 S PREDTM=$G(^TMP("MHV7LOG",$J))
 Q:PREDTM="" 1
 S DTM=$O(^XTMP("MHV7LOG",2,""))
 I DTM'="",DTM<PREDTM Q 0
 S J="",FLAG=0
 F  S J=$O(^XTMP("MHV7LOG",2,PREDTM,J)) Q:J=""  I J'=$J S FLAG=1 Q
 I FLAG Q 0
 Q 1
 ;
UPDLINK() ; Update Logical Link
 N FDA,ERR,IEN
 ;
 D LOG^MHVUL2("UPDATE LOGICAL LINK","BEGIN","S","TRACE")
 S ERR=""
 S IEN=$$FIND1^DIC(870,"","X","MHVVA","B","","ERR")
 I 'IEN D  Q 0
 . I '$G(ERR("DIERR")) S ERR("DIERR",1,"TEXT",1)="NOT FOUND"
 . S ERR=$G(ERR("DIERR",1))_"^"_$G(ERR("DIERR",1,"TEXT",1))
 . D LOG^MHVUL2("UPDATE FAILED",ERR,"S","ERROR")
 . Q
 ;
 S ERR=""
 S IEN=IEN_","
 I $P($$PARAM^HLCS2,U,3)="P" D
 . S FDA(870,IEN,.08)="MHV.MED.VA.GOV"
 . S FDA(870,IEN,4.5)=1
 . S FDA(870,IEN,400.01)="10.224.43.21"
 . S FDA(870,IEN,400.02)=5410
 . Q
 E  D
 . S FDA(870,IEN,.08)=""
 . S FDA(870,IEN,4.5)=0
 . S FDA(870,IEN,400.01)=""
 . S FDA(870,IEN,400.02)=""
 . Q
 D UPDATE^DIE("","FDA","","ERR")
 I $G(ERR("DIERR")) D  Q 0
 . S ERR=$G(ERR("DIERR",1))_"^"_$G(ERR("DIERR",1,"TEXT",1))
 . D LOG^MHVUL2("UPDATE FAILED",ERR,"S","ERROR")
 . Q
 ;
 I '$$CHKLINK(.ERR) D  Q 0
 . D LOG^MHVUL2("CHECK FAILED",ERR,"S","ERROR")
 . Q
 ;
 D LOG^MHVUL2("UPDATE LOGICAL LINK","SUCCESS","S","TRACE")
 Q 1
 ;
CHKLINK(ERR) ; Check Logical Link
 N ARY,IEN
 ;
 K ERR
 S ERR=""
 I $P($$PARAM^HLCS2,U,3)'="P" Q 1
 S IEN=$$FIND1^DIC(870,"","X","MHVVA","B","","ERR")
 I 'IEN S ERR="DOES NOT EXIST" Q 0
 S IEN=IEN_","
 D GETS^DIQ(870,IEN,".08;4.5;400.01;400.02","","ARY","ERR")
 I $G(ERR("DIERR")) S ERR=$G(ERR("DIERR",1))_"^"_$G(ERR("DIERR",1,"TEXT",1)) Q 0
 I $G(ARY(870,IEN,.08))'="MHV.MED.VA.GOV" S ERR="DNS DOMAIN NOT UPDATED" Q 0
 I $G(ARY(870,IEN,4.5))'="Enabled" S ERR="AUTOSTART NOT ENABLED" Q 0
 I $G(ARY(870,IEN,400.01))'="10.224.43.21" S ERR="INCORRECT IP ADDRESS" Q 0
 I $G(ARY(870,IEN,400.02))'=5410 S ERR="INCORRECT TCP PORT" Q 0
 Q 1
 ;
