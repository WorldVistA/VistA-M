ECX146PT ;ALB/AG-PATCH ECX*3.0*146 POST-INIT RTN ; 4/2/13 9:49am
 ;;3.0;DSS EXTRACTS;**146**;DEC 22, 1997;Build 1
 ;
 ;Post-init routine adding new entries and updating current entries to
 ;
 ;NATIONAL CLINIC file(#728.441)
 ;
 ;
 Q
EN ;Routine entry point
 D ADDNEW     ;add new Clinic codes
 D UPDATE     ;change name to existing Clinic codes
 Q
 ;
 ;
ADDNEW ;Add new entry to file 728.441
 ;ECXREC is in format:code^short description
 ;
 ;
 N ECXFDA,ECXERR,ECXCODE,ECXREC,I
 ;
 ;-get National Clinic record
 F I=1:1 S ECXREC=$P($T(ADDCLIN+I),";;",2) Q:ECXREC="QUIT"  D
 .;
 .;-National Clinic Code
 .S ECXCODE=$P(ECXREC,"^")
 .;
 .;-quit w/error message if entry already exists in file #728.441
 .I $$FIND1^DIC(728.441,"","X",ECXCODE) D  Q
 ..D BMES^XPDUTL(">>>..."_ECXCODE_" "_$P(ECXREC,U,2)_" not added, entry already exists.")
 ..D BMES^XPDUTL(">>>Delete entry and reinstall patch if entry was not created by a ")
 ..D BMES^XPDUTL(">>> previous installation of this patch.")
 .;
 .;Setup field values of new entry
 .S ECXFDA(728.441,"+1,",.01)=ECXCODE
 .S ECXFDA(728.441,"+1,",1)=$P(ECXREC,"^",2)
 .;
 .;-add new entry to file #728.441
 .D UPDATE^DIE("E","ECXFDA","","ECXERR")
 .;
 .I '$D(ECXERR) D BMES^XPDUTL(">>>...."_ECXCODE_" "_$P(ECXREC,U,2)_" added to file.")
 .I $D(ECXERR) D BMES^XPDUTL(">>>....Unable to add "_ECXCODE_" "_$P(ECXREC,U,2)_"     to file.")
 ;
 Q
UPDATE ;changing short description of existing clinic
 N ECXCODE,ECXDESC,ECXIEN,DIE,DA,DR,I
 D BMES^XPDUTL(">>>Updating entry in the NATIONAL CLINIC (728.441) file...")
 F I=1:1 S ECXREC=$P($T(UPDCLIN+I),";;",2) Q:ECXREC="QUIT"  D
 .S ECXCODE=$P(ECXREC,"^"),ECXDESC=$P(ECXREC,"^",2)
 .S ECXIEN=$$FIND1^DIC(728.441,"","X",ECXCODE,"","","ERR")
 .I ECXIEN="" D  Q
 ..D BMES^XPDUTL(">>>...Unable to add "_ECXCODE_" "_$P(ECXREC,U,2)_" to file.")
 ..D BMES^XPDUTL("Contact support for assistance")
 .S DIE="^ECX(728.441,",DA=ECXIEN,DR="1///^S X=ECXDESC"
 .D ^DIE
 .D BMES^XPDUTL(">>>...."_ECXCODE_" "_$P(ECXREC,U,2)_" updated")
 ;
ADDCLIN ;Contains the NATIONAL CLINIC entries to be added
 ;;AMSP^Antimicrb Stwrdshp Pharmacist
 ;;CSCC^CnsltSprtClinc CreatvArtsFestvl
 ;;CSCF^CnsltSprtClinc GolfPgm
 ;;CSCG^CnsltSprtClinc GldnAgGms
 ;;CSCL^CnsltSprtClinc WellnessPgm
 ;;CSCN^CnsltSprtClinc WintrSprtClinc
 ;;CSCS^CnsltSprtClinc SummrClinc 
 ;;CSCT^CnsltSprtClinc TEE Trnmt
 ;;CSCW^CnsltSprtClinc WhlchrGms
 ;;ECOP^E-Cnslt Pharmacist
 ;;GERP^Geriatric Pharmacist
 ;;PIMI^Polytrauma Integ Med Init
 ;;SMOP^Smk Cessation Pharmacist
 ;;SPAP^SpcltyCare Anticoag Pharmacist
 ;;VITL^VITAL Initiative
 ;;ABCD^Locally Defined A
 ;;BCDE^Locally Defined B
 ;;CDEF^Locally Defined C
 ;;DEFG^Locally Defined D
 ;;EFGH^Locally Defined E
 ;;FGHI^Locally Defined F
 ;;GHIJ^Locally Defined G
 ;;HIJK^Locally Defined H
 ;;IJKL^Locally Defined I
 ;;JKLM^Locally Defined J
 ;;KLMN^Locally Defined K
 ;;LMNO^Locally Defined L
 ;;MNOP^Locally Defined M
 ;;NOPQ^Locally Defined N
 ;;OPQR^Locally Defined O
 ;;PQRS^Locally Defined P
 ;;QRST^Locally Defined Q
 ;;RSTU^Locally Defined R
 ;;STUV^Locally Defined S
 ;;TUVW^Locally Defined T
 ;;UVWX^Locally Defined U
 ;;VWXY^Locally Defined V
 ;;WXYZ^Locally Defined W
 ;;XYZA^Locally Defined X
 ;;YZAB^Locally Defined Y
 ;;ZABC^Locally Defined Z
 ;;QUIT
UPDCLIN ;Contains the NATIONAL CLINIC entry description to be updated
 ;;CGPH^CntrlzAnticoagMgmt Pharmacist
 ;;CPRY^SCAN Mini-Spec Clinic
 ;;PACP^PACT Anticoag Tm Pharmacist
 ;;WCNC^VITAL Initiative (temp)
 ;;QUIT
