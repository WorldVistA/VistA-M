ECX150PT ;ALB/AG-ECX*3.0*150 Post-Init RTN ; 4/7/14 12:05pm
 ;;3.0;DSS EXTRACTS;**150**;;Build 3
 ;
 ;Post-init routine adding new entries and updating current entries to
 ;NATIONAL CLINIC (#728.441) file
 ;
 Q
 ;
EN ;routine entry point
 D UNLOCK     ;unlock Data Dictionary to allow changes
 D UPDATE     ;change name to existing Clinic codes
 D INACT^ECX150P1
 D INACT^ECX150P2
 D LOCK       ;lock Data Dictionary to restrict changes
 Q
 ;
UNLOCK ;
 K ^DD(728.441,.01,7.5)
 N ECXI
 F ECXI=.01,1,3 S $P(^DD(728.441,ECXI,0),"^",2)=$TR($P(^DD(728.441,ECXI,0),"^",2),"I","")
 Q
UPDATE ;changing short description of existing clinic
 N ECXCODE,ECXDESC,ECXIEN,DIE,DA,DR,ECXI,ECXREC
 D BMES^XPDUTL(">>>Updating entry in the NATIONAL CLINIC (728.441) file..")
 I $P(^DD(728.441,.01,0),"^",2)["I" D  Q
 .D BMES^XPDUTL(">>Unable to update File 728.441, it is locked")
 .D BMES^XPDUTL("Contact support for assistance")
 F ECXI=1:1 S ECXREC=$P($T(UPDCLIN+ECXI),";;",2) Q:ECXREC="QUIT"  D
 .S ECXCODE=$P(ECXREC,"^"),ECXDESC=$P(ECXREC,"^",2)
 .S ECXIEN=$$FIND1^DIC(728.441,"","X",ECXCODE,"","","ERR")
 .I 'ECXIEN D  Q
 ..D BMES^XPDUTL(">>>....Unable to update "_ECXCODE_" "_$P(ECXREC,U,2)_".")
 ..D BMES^XPDUTL(">>>....Contact support for assistance")
 .S DIE="^ECX(728.441,",DA=ECXIEN,DR="1///^S X=ECXDESC"
 .D ^DIE
 .D BMES^XPDUTL(">>>...."_ECXCODE_" "_$P(ECXREC,U,2)_" updated")
 Q
 ;
LOCK ;
 N ECXI
 S ^DD(728.441,.01,7.5)="I $G(DIC(0))[""L"",'$D(ECX4CHAR) D EN^DDIOL(""Entries can only be added by CHAR4 Council."","""",""!?5"") K X"
 F ECXI=.01,1,3 I $P(^DD(728.441,ECXI,0),U,2)'["I" S $P(^DD(728.441,ECXI,0),U,2)=$P(^DD(728.441,ECXI,0),U,2)_"I" ;Makes all fields uneditable
 Q
UPDCLIN ;Contains the NATIONAL CLINIC entry description to be updated
 ;;PDIA^PILOT DIALYSIS Physician
 ;;PTEM^PILOT DIALYSIS Multidisc
 ;;RHQC^Reserved
 ;;WCQC^Women's Telehlth Pilot
 ;;XREC^PIM Demo
 ;;QUIT
