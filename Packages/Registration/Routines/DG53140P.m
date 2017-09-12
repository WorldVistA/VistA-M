DG53140P ;ALB/ABR - POST-INSTALL DG*5.3*140 EDR SHUTDOWN ; 8-Sep-97
 ;;5.3;Registration;**140**;Aug 13, 1993
 ;
EN ; post-install entry point
 D HL7CLN
 D MAILGR
 D REMOVE
 Q
 ;
 ;
REMOVE ; deletes file 391.51, both data and dd
 N DIU
 S DIU="^VAT(391.51,",DIU(0)="D"
 D EN^DIU2
 D BMES^XPDUTL(">>PIMS EDR EVENT file #391.51 deleted")
 Q
 ;
HL7CLN ; remove EDR ENTRIES from HL7 NON-DHCP APPLICATION PARAMETER file #770
 ; and HL7 APPLICATION PARAMETER file (#771)
 N DIK,DIC,X,Y,I
 S (DIK,DIC)="^HL(770,",DIC(0)="X"
 F X="EDR-MAS","EDR-PL" D ^DIC I Y>0 D
 . S DA=+Y
 . D MES^XPDUTL(">>Removing HL7 NON-DHCP APPLICATION PARAMETER - "_X)
 . D ^DIK
 S (DIK,DIC)="^HL(771,",DIC(0)="X"
 F X="EDR-MAS","EDR-PL","EDR-MAS-DHCP","EDR-PL-DHCP" D ^DIC I Y>0 D
 . S DA=+Y
 . D MES^XPDUTL(">>Removing HL7 DHCP APPLICATION PARAMETER - "_X)
 . D ^DIK
 Q
 ;
MAILGR ; remove EDR mailgroups
 N DIK,DIC,X,Y
 S (DIK,DIC)="^XMB(3.8,",DIC(0)="X"
 F X="EDR-PL MESSAGES","EDR-RCP","RCP-EDR REPORTS" D ^DIC I Y>0 D
 . S DA=+Y
 . D MES^XPDUTL(">>Removing EDR mailgroup "_X)
 . D ^DIK
 Q 
