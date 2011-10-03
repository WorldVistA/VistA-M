SDV53PR ;alb/mjk - SD Application Specific Init Driver for v5.3 ; 3/26/93
 ;;5.3;Scheduling;;Aug 13, 1993
 ;
EN ; -- main entry point
 D OPT ; change option name
 D PROT ; clean up old protocol for valm conversion
ENQ Q
 ;
PROT ; -- delete protocols
 N DIK,DA
 F SDX="SDAM MENU","SD PARM PARAMETERS MENU" D
 .S DA=$O(^ORD(101,"B",SDX,0)),DIK="^ORD(101," D ^DIK:DA
 Q
 ;
OPT ; -- change option name
 N DR,DA,DIE,DE,DQ
 S DA=+$O(^DIC(19,"B","SDAM APPT CHECK IN",0))
 I DA S DR=".01///SDAM APPT CHECK IN/OUT",DIE="^DIC(19," D ^DIE
 Q 
