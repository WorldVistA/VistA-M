SD53222P ;ALB/MRY - Correct Validation Logic for codes 704/7040;10/30/00
 ;;5.3;Scheduling;**222**;Oct 30,  2000
 ;
 ;
ADJUST ;--- Patch will include routine (SD53222P) to edit Data
 ;    Dictionary #31 field.
 ;
 ;--- Adjust the number of parameters in the Validation Logic
 ;    for codes 704 and 7040 of the TRANSMITTED OUTPATIENT
 ;    ENCOUNTER ERROR CODE File (#409.76).
 ;
 ;    Was:  S RES=$$MSTSTAT^SCMSVUT3(DATA,ENCDT)
 ;    Now:  S RES=$$MSTSTAT^SCMSVUT3(DATA)
 ;
 N SDIEN,SDARY,SDCODE
EN D BMES^XPDUTL(">>> Updating TRANSMITTED OUTPATIENT ENCOUNTER ERROR CODE File (#409.76)")
 D MES^XPDUTL(">>> for entries 704, 706, 903 and 7040.")
 S SDIEN=+$O(^SD(409.76,"B",7040,"")) I SDIEN D
 . S DIE="^SD(409.76,",DA=SDIEN,DR="31////S RES=$$MSTSTAT^SCMSVUT3(DATA)" D ^DIE K DIE,DR,DA
 E  S SDCODE=7040 D ERR
 ;
 F SDCODE=704,706,903 D
 . S SDIEN=+$O(^SD(409.76,"B",SDCODE,"")) I SDIEN D
 . . S DIE="^SD(409.76,",DA=SDIEN,DR="31////@;.02////N" D ^DIE K DIE,DR,DA
 . E  D ERR
 ;
 D BMES^XPDUTL("Done.")
 ;
 Q
 ;
ERR ;-- Display error message if missing code.
 D BMES^XPDUTL("  ")
 S SDARY(1)="Code "_SDCODE_" is missing from File (#409.76).  Please"
 S SDARY(2)="contact the National VISTA Support Team for assistance."
 D MES^XPDUTL(.SDARY)
 Q
