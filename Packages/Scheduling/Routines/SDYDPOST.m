SDYDPOST ;MJK/ALB - API Post Init;01 APR 1993
 ;;5.3;Scheduling;**27**;08/13/93
 ;
EN ;
 D STUFF ; set notification parameters
 D VISIT ; add SD in visit parameters
 D FIXPRO ; enable new CPT protocols
 Q
 ;
STUFF ; -- stuff parameters if both not set
 S X=$G(^DG(43,1,"SCLR"))
 IF $P(X,U,26)="",$P(X,U,27)="" D
 . D BMES^XPDUTL(">>> Setting API Notification Parameters...")
 . S DIE=43,DR="226////"_$P(X,U,17)_";227////E",DA=1 D ^DIE
 Q
 ;
VISIT ; -- add SD in visit parameters
 S X="VSITAPI" X ^%ZOSF("TEST")
 IF $T,$$PKGON^VSIT("SD")=-1 D
 . N SDVAR
 . D BMES^XPDUTL(">>> Adding Scheduling to Visit Parameters files...")
 . S SDVAR=$$PKG^VSIT("SD",0)
 . IF SDVAR>0 D
 . . D BMES^XPDUTL("     ...successfully added with value of 'ACTIVE FLAG' set to '"_$S($P(SDVAR,U,2):"ON",1:"OFF")_"'.")
 . ELSE  D
 . . D MES^XPDUTL("     ...NOTE: Unable to add Scheduling.")
 Q
 ;
NOTE ; -- manually set notification parameters
 D BMES^XPDUTL(">>> Set API Notification Parameters...")
 S DIE=43,DR="226;227",DA=1 D ^DIE
 Q
 ;
FIXPRO ;Enable CPT protocols
 ;
 ;Input  : None
 ;Output : None
 ;Notes  : This is a KIDS complient check point
 ;
 ;Declare variables
 N DIC,DIE,DA,DR,X,Y,DTOUT,DUOUT,MSGTXT,PTRPROT,SDYDX
 D BMES^XPDUTL(">>> Enabling New CPT Protocols")
 ;Find protocol
 F SDYDX="SDCO CPT","SDAM CPT" D
 .S PTRPROT=+$O(^ORD(101,"B",SDYDX,""))
 .I ('PTRPROT) D  Q
 ..S MSGTXT(1)="    ** Unable to find SDCO CPT in PROTOCOL file (#101)"
 ..S MSGTXT(2)="    ** Entry must be manually created"
 ..D MES^XPDUTL(.MSGTXT)
 .;Enable protocol
 .S DIE="^ORD(101,"
 .S DA=PTRPROT
 .S DR="2///@"
 .D ^DIE
 ;Done
 Q
 ;
