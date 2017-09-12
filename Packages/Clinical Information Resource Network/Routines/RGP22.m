RGP22 ;BIR/PTD-PATCH RG*1*22 PRE & POST INSTALL ROUTINE ;09/14/01
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**22**;30 Apr 99
 ;Reference to FILE^DICN for ^DIC(4 supported by IA#3453
 ;References to LINK^HLUTIL3 and $$GET1^DIQ(870 supported by IA #3335
 ;Reference to $$FIND1^DIC(870 supported by IA#2525
 ;Reference to DIE call on ^HLCS(870, supported by IA#3454
 ;
PRE ;PRE INSTALL
 ;Is station #776 in the INSTITUTION (#4) file?
 ;If yes, quit.  If not, create it.  If can't create, abort install.
 N RGSTN
 S RGSTN=+$$FIND1^DIC(4,"","MX","OFFICE OF INFORMATION SRV CNTR")
 I RGSTN>0 D BMES^XPDUTL(" Station number 776 exists in the INSTITUTION file.") D MES^XPDUTL(" Pre-install routine completed successfully.") G ENDPRE
 I RGSTN=0 D  ;Not there, so create station #776
 .K DIC,DR,X,Y
 .S XUMF=1
 .S DIC="^DIC(4,",DIC(0)="",X="OFFICE OF INFORMATION SRV CNTR"
 .S DIC("DR")=".02////OHIO;11////National;13////VAMC;99////776;100////OFFICE OF INFORMATION SERVICE CENTER"
 .K DO,DD D FILE^DICN
 .I +Y<0 D BMES^XPDUTL(" Unable to add station number 776 to the INSTITUTION file.") D MES^XPDUTL(" Contact NVS or log a NOIS for assistance before proceeding.") S XPDABORT=1 Q
 .D BMES^XPDUTL(" Station number 776 has been added to the INSTITUTION file.")
 .D MES^XPDUTL(" Pre-install routine completed successfully.")
ENDPRE ;Kill variables and quit
 K DD,DIC,DO,DR,RGSTN,X,XUMF,Y
 Q
 ;
PST ;POST INSTALL
 ;Is VACIO entry in the HL LOGICAL LINK (#870) file?
 ;If yes, set AUTOSTART (#4.5) field to Enabled.  If no, quit.
 N RGLLK
 S RGLLK=+$$FIND1^DIC(870,"","MX","VACIO")
 I RGLLK=0 D BMES^XPDUTL(" 'VACIO' logical link failed to come in with this patch.") D MES^XPDUTL(" Contact NVS or log a NOIS for assistance before proceeding.") S XPDABORT=1 G ENDPST ;Abort install.
 L +^HLCS(870,RGLLK):10
 S DIE="^HLCS(870,",DA=RGLLK,DR="4.5///1"
 D ^DIE K DIE,DA,DR
 L -^HLCS(870,RGLLK)
 D BMES^XPDUTL(" The AUTOSTART (#4.5) field for the 'VACIO' entry in") D MES^XPDUTL(" the HL LOGICAL LINK (#870) file has been set to 'Enabled'.")
 ;
 ;If production account, quit - install complete.
 ;If test account, remove TCP/IP ADDRESS (#400.01) and DOMAIN (#.03)
 ;for VACIO entry in the HL LOGICAL LINK (#870) file.
 ;
 ;Determine test or production account (production must have
 ;"MPI-AUSTIN.DOMAIN.EXT" domain for logical link "MPIVA").
 ;Get logical link IEN for "MPIVA".
 ;Get domain for "MPIVA" logical link in HL LOGICAL LINK (#870) file.
 N RGDOMAIN S RGDOMAIN=""
 D LINK^HLUTIL3("200M",.HLL,"I")
 S IEN=$O(HLL(0)) I +IEN>0 S RGDOMAIN=$$GET1^DIQ(870,+IEN_",",.03)
 I RGDOMAIN="MPI-AUSTIN.DOMAIN.EXT" D BMES^XPDUTL(" Post-install routine completed successfully.") G ENDPST ;Production account, so quit.
 I RGDOMAIN'="MPI-AUSTIN.DOMAIN.EXT" D
 .;Test account or can't determine account, continue
 .;Is VACIO entry in the HL LOGICAL LINK (#870) file?
 .N RGLLK
 .S RGLLK=+$$FIND1^DIC(870,"","MX","VACIO")
 .Q:'RGLLK  ;VACIO entry not found, so quit.
 .L +^HLCS(870,RGLLK):10
 .S DIE="^HLCS(870,",DA=RGLLK,DR=".03///@;400.01///@"
 .D ^DIE K DIE,DA,DR
 .L -^HLCS(870,RGLLK)
 .D BMES^XPDUTL(" Because this is not a production account, the TCP/IP ADDRESS")
 .D MES^XPDUTL(" and DOMAIN fields were deleted for the 'VACIO' entry in the")
 .D MES^XPDUTL(" HL LOGICAL LINK (#870) file.")
 .D BMES^XPDUTL(" Post-install routine completed successfully.")
ENDPST ;Kill variables and quit
 K DA,DIE,DR,IEN,HLL,RGDOMAIN,RGLLK
 Q
 ;
