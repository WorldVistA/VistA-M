ICPT62 ;DAN/SLC - Add Health Summary to application group of CPT file ;1/13/98  14:50
 ;;6.0;CPT/HCPCS**2**;May 19, 1997
POST ;
 ;Need to add "GMTS" to the application group of file 81 to allow
 ;SURGERY SEL NON OR PROCEDURES component to be able to select CPT
 ;codes.
 D BMES^XPDUTL("Adding 'GMTS' to the application group of the CPT (#81) file.")
 N DIE,DA,DR
 S DIE=1,DA=81,DR="10///GMTS"
 D ^DIE
 D BMES^XPDUTL("Done.")
 Q
 ;
