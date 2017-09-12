ECX147PT ;ALB/AG-ECX*3.0*147 Post-Init Rtn;10/8/13; ; 12/4/13 3:52pm
 ;;3.0;DSS EXTRACTS;**147**;Dec 22,1997;Build 4
 ;
 ;Post-init routine adding new entries and updating current entries to
 ;
 ;NATIONAL CLINIC file(#728.441)
 ;
 Q
 ;
EN ;
 ;Routine entry point
 D UNLOCK     ;unlock Data Dictionary to allow changes
 D ADDNEW     ;add new Clinic codes
 D UPDATE     ;change name to existing Clinic codes
 D LOCK       ;lock Data Dictionary to restrict changes
 Q
 ;
UNLOCK ;
 K ^DD(728.441,.01,7.5)
 N ECXI
 F ECXI=.01,1,3 S $P(^DD(728.441,ECXI,0),"^",2)=$TR($P(^DD(728.441,ECXI,0),"^",2),"I","")
 Q
ADDNEW ;Add new entry to file 728.441
 ;ECXREC is in format:code^short description
 ;
 ;
 N ECXFDA,ECXERR,ECXCODE,ECXREC,ECXI
 ;
 ;-get National Clinic record
 F ECXI=1:1 S ECXREC=$P($T(ADDCLIN+ECXI),";;",2) Q:ECXREC="QUIT"  D
 .;
 .;-National Clinic Code
 .S ECXCODE=$P(ECXREC,"^")
 .;
 .;-quit w/error message if entry already exists in file #728.441
 .I $$FIND1^DIC(728.441,"","X",ECXCODE) D  Q
 ..D BMES^XPDUTL(">>>..."_ECXCODE_" "_$P(ECXREC,U,2)_" not added, entry already exists.")
 ..D BMES^XPDUTL(">>> Contact Support for assistance.")
 .;
 .;Setup field values of new entry
 .S ECXFDA(728.441,"+1,",.01)=ECXCODE
 .S ECXFDA(728.441,"+1,",1)=$P(ECXREC,"^",2)
 .;
 .;-add new entry to file #728.441
 .D UPDATE^DIE("E","ECXFDA","","ECXERR")
 .;
 .I '$D(ECXERR) D BMES^XPDUTL(">>>...."_ECXCODE_" "_$P(ECXREC,U,2)_" added to file.")
 .I $D(ECXERR) D BMES^XPDUTL(">>>....Unable to add "_ECXCODE_" "_$P(ECXREC,U,2)_"     to file.") D
 ..D BMES^XPDUTL(">>>....Contact Support for assistance.")
 ;
 Q
UPDATE ;changing short description of existing clinic
 N ECXCODE,ECXDESC,ECXIEN,DIE,DA,DR,ECXI
 D BMES^XPDUTL(">>>Updating entry in the NATIONAL CLINIC (728.441) file...")
 I $P(^DD(728.441,.01,0),"^",2)["I" D  Q
 .D BMES^XPDUTL(">>Unable to update File 728.441 is locked")
 .D BMES^XPDUTL("Contact support for assistance")
 F ECXI=1:1 S ECXREC=$P($T(UPDCLIN+ECXI),";;",2) Q:ECXREC="QUIT"  D
 .S ECXCODE=$P(ECXREC,"^"),ECXDESC=$P(ECXREC,"^",2)
 .S ECXIEN=$$FIND1^DIC(728.441,"","X",ECXCODE,"","","ERR")
 .I 'ECXIEN D  Q
 ..D BMES^XPDUTL(">>>....Unable to add "_ECXCODE_" "_$P(ECXREC,U,2)_" to file.")
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
ADDCLIN ;Contains the NATIONAL CLINIC entries to be added
 ;;AMSM^Antimicrb Stwrdshp MD
 ;;PEER^Peer Support
 ;;APSZ^E-Consult NP or CNS
 ;;CLSZ^E-Consult PSO or POD
 ;;PASZ^E-Consult PA
 ;;RESZ^E-Consult Resident/Fellow
 ;;VL5Z^E-Consult Contract Labor
 ;;QUIT
UPDCLIN ;Contains the NATIONAL CLINIC entry description to be updated
 ;;FEEZ^Profee
 ;;HDGC^Employment Specialist
 ;;RHAC^Reserved
 ;;RHEC^Rehab Audiology
 ;;RHFC^Rehab Blind Rehab
 ;;RHGC^Rehab Chiropractic
 ;;RHHC^Rehab KT
 ;;RHJC^Rehab MD
 ;;RHMC^Rehab OT
 ;;RHRC^Rehab RT
 ;;RHSC^Rehab SP
 ;;CNSZ^E-Consult MD/PSI/Gen'l
 ;;QUIT
