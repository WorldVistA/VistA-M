DGQEP0 ;ALB/JFP - VIC PRE INIT UTILITES; 09/01/96
 ;;V5.3;REGISTRATION;**73**;DEC 11,1996
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
TYPE ;-- Create entry in TERMINAL TYPE file (#3.2)
 ;
 ;Input  : None
 ;Output : None
 ;Note   : This is a KIDS complient check point
 ;
 ; -- Declare variables
 N DIC,X,Y,DLAYGO,DTOUT,DUOUT,NEWENTRY,MSGTXT,PTREVNT,DIE,DA,DR
 ; -- Create/find entry
 D BMES^XPDUTL(">>> Creating entry for P-VIC-OTHER in TERMINAL TYPE file (#3.2)")
 S DIC=3.2
 S DIC(0)="LX"
 S DLAYGO=3.2
 S X="P-VIC-OTHER"
 D ^DIC
 S PTREVNT=+Y
 S NEWENTRY=+$P(Y,"^",3)
 S MSGTXT(1)="    Existing entry found and updated"
 S:(NEWENTRY) MSGTXT(1)="    New entry created "
 I (PTREVNT<0) D  Q
 .S MSGTXT(1)="    ** Unable to create entry for P-VIC-OTHER"
 .S MSGTXT(2)="    ** Entry must be created manually"
 .D MES^XPDUTL(.MSGTXT)
 .K MSGTXT
 ;
 ; -- update remaining fields
 S DIE=3.2,DA=+Y
 S DR=".02///1;1///0;2///#;3///66;4///$C(8)"
 D ^DIE
 ; -- Display message 
 D MES^XPDUTL(.MSGTXT)
 ;Done
 Q
 ;
DEVICE ; -- Create entry in DEVICE file (#3.5)
 ;
 ;Input  : $I device            - Pre init question 2 
 ;       : Location of terminal - Pre init question 1
 ;Output : None
 ;Note   : This is a KIDS complient check point
 ;
 ; -- Declare variables
 N DIC,X,Y,DLAYGO,DTOUT,DUOUT,NEWENTRY,MSGTXT,PTREVNT,DIE,DA,DR
 N DGQEI,DGQELOC
 ; -- Create/find entry
 D BMES^XPDUTL(">>> Creating entry for VIC CARD in DEVICE file (#3.5)")
 ; -- Check for existance of input
 I '$D(XPDQUES("PRE1","B")) S DGQELOC=""
 I '$D(XPDQUES("PRE2","B")) S DGQEI=""
 S DGQELOC=$G(XPDQUES("PRE1","B"))
 S DGQEI=$G(XPDQUES("PRE2","B"))
 S DIC=3.5
 S DIC("DR")="1///"_DGQEI
 S DIC(0)="LX"
 S DLAYGO=3.5
 S X="VIC CARD"
 D ^DIC
 I $D(DTOUT) D  Q
 .S MSGTXT(1)="    ** Unable to create entry for VIC CARD"
 .S MSGTXT(2)="    ** Time out expired"
 .S MSGTXT(3)="    ** Entry must be created manually"
 .D MES^XPDUTL(.MSGTXT)
 .K MSGTXT
 S PTREVNT=+Y
 S NEWENTRY=+$P(Y,"^",3)
 S MSGTXT(1)="    Existing entry found and updated"
 S:(NEWENTRY) MSGTXT(1)="    New entry created "
 I (PTREVNT<0) D  Q
 .S MSGTXT(1)="    ** Unable to create entry for VIC CARD"
 .S MSGTXT(2)="    ** Entry must be created manually"
 .D MES^XPDUTL(.MSGTXT)
 .K MSGTXT
 ;
 ; -- update remaining fields
 S DIE=3.5,DA=+Y
 S DR="1///"_DGQEI_";.02///"_DGQELOC_";1.95///0;2///OTH;3///P-VIC-OTHER;9///132;10///#;11///66;11.2///1;12///$C(8);51.2///3;51.3///900;51.5///0;63///N"
 D ^DIE
 ; -- Display message 
 I DGQELOC="" S MSGTXT(1)=" ",MSGTXT(2)="    Location entered as null, this will need manual update"
 I DGQEI="" D
 .S MSGTXT(3)=" "
 .S MSGTXT(4)="** $I is a critical element and it has been entered as null"
 .S MSGTXT(5)="   This will need to manually updated for VIC to function properly"
 D MES^XPDUTL(.MSGTXT)
 ;Done
 Q
 ;
