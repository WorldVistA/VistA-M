SD53247P ;BP/ESW  TRANSMITTED OUTPATIENT ENCOUNTER ERROR CODE' File Update - POST INST ; 1/31/02 9:11am
 ;;5.3;Scheduling;**247**;Aug 13, 1993
 ;
 ; This is the post-install for patch 247 to modify CORRECTIVE ACTION
 ; DESCRIPTION field (#21) of ERROR CODE: 4200 in TRANSMITTED
 ; OUTPATIENT ENCOUNTER ERROR CODE File (#409.76). This error code 
 ; is denoting why an entry in the TRANSMITTED OUTPATIENT ENCOUNTER
 ; file could not be transmitted or successfully processed.
 ;
EN ;
 N FILE,FLD,BREF
 S FILE=409.76,FLD=21,BREF=4200
 D BMES^XPDUTL("SD*5.3*247 Post Installation --")
 D MES^XPDUTL("   Update to TRANSMITTED OUTPATIENT ENCOUNTER ERROR CODE file (#"_FILE_").")
 D MES^XPDUTL("  ")
 I '$D(^SD(FILE)) D BMES^XPDUTL("Missing file "_FILE_".")
 I $D(^SD(FILE)) D
 .D ACT
 Q
 ;
ACT ;enter a new text
 N LINE,IEN,SDX,WP,ERR,SD
 I '$D(^SD(FILE,"B",BREF)) D MISS Q
 S IEN=$O(^SD(FILE,"B",BREF,""))
 I '$D(^SD(FILE,IEN)) D MISS Q
 F SDX=1:1 S LINE=$P($T(TXTNEW+SDX),";;",2) Q:LINE="QUIT"  D
 .S SD(SDX,0)=LINE
 S IEN=IEN_","
 D WP^DIE(FILE,IEN,FLD,"K","SD","ERR")
 ;display error messages if unsuccessful
 I $D(ERR) D  Q
 .S SDX="ERR" F  S SDX=$Q(@SDX) Q:SDX=""  D
 ..D BMES^XPDUTL(SDX)
 ..D MES^XPDUTL(@SDX)
 .D BMES^XPDUTL("  *** Warning - Field #21")
 .D MES^XPDUTL("                of ERROR CODE 4200, file #409.76")
 .D MES^XPDUTL("                could not be modified.")
 .D BMES^XPDUTL(" Please contact the PIMS NATIONAL VISTA SUPPORT Team.")
 .D MES^XPDUTL("                for assistance.")
 D BMES^XPDUTL(" CORRECTIVE ACTION DESCRIPTION of ERROR CODE 4200")
 D MES^XPDUTL("     successfully modified.")
 D MES^XPDUTL("  ")
 Q
MISS ; missing messages
 D BMES^XPDUTL("Missing ERROR CODE 4200 in file #409.76...")
 D MES^XPDUTL("Please contact the PIMS NATIONAL VISTA SUPPORT Team.")
 Q
 ;
 ; New text for CORRECTIVE ACTIOB DESCRIPTION field:
TXTNEW ;
 ;;If the encounter date is invalid, or before the date of transmission,
 ;;the appointment will need to be canceled and remade through
 ;;the Appointment Manager. It may also be possible that the encounter
 ;;is not acceptable because the activity occurred after the NPCD was closed.
 ;;Contact your ADPAC to check on this possibility.
 ;;
 ;;QUIT
