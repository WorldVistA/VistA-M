ORY632 ;SLCOIFO/MWA - Post install routine for patch OR*3*632 ; Feb 06, 2026@14:00:18
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**632**;Dec 17, 1997;Build 9
 ;
 ;
 Q
POST ; initiate post install processes
 ;Recompile the Order Check System
 N OCXOETIM
 D BMES^XPDUTL("---Recompiling Order Check Routines-----------------------------------")
 D AUTO^OCXOCMP
 D BMES^XPDUTL(" ---Recompiling Complete---")
 Q
 ;
BACKUP ;Backup the CONVERT DATE FROM OCX FORMAT TO READABLE FORMAT entry in #860.8 file
 N NEWDT,OCRIEN,ORDESC
 I $D(^XTMP("ORY632",0)) D  Q  ;Quit if backup already created
 . ;Extend Purge Date by 120 days
 . S NEWDT=$$FMADD^XLFDT($P(^XTMP("ORY632",0),U,1),120,0,0,0)
 . S $P(^XTMP("ORY632",0),U,1)=NEWDT
 S OCRIEN=$O(^OCXS(860.8,"B","CONVERT DATE FROM OCX FORMAT T",0))
 I OCRIEN'>0 Q
 D BMES^XPDUTL("---Saving INT2DT code to XTMP(""ORY632""------------------------------")
 M ^XTMP("ORY632",1)=^OCXS(860.8,OCRIEN)
 I $D(^XTMP("ORY632",1)) D
 . I 'DT S DT=$$DT^XLFDT
 . S NEWDT=$$FMADD^XLFDT(DT,120,0,0,0) ;Add 120 days to today's date for Purge
 . S ORDESC="OR*3*632 Post-Init Backup of 860.8 CONVERT DATE FROM OCX FORMAT TO READABLE FORMAT"
 . S ^XTMP("ORY632",0)=NEWDT_U_DT_U_ORDESC
 D BMES^XPDUTL(" ---Save Complete---")
 Q
