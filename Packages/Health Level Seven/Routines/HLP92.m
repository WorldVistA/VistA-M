HLP92 ;OAKCIOFO/JG - HL*1.6*92 PRE & POST INSTALL ROUTINE ;04/08/2002
 ;;1.6;HEALTH LEVEL SEVEN;**92**;JUL 17, 1995
 ;Reference to FILE^DICN for ^DIC(4 supported by IA#3555
 ;
PRE ;PRE INSTALL
 ;Is station #200 in the INSTITUTION (#4) file?
 ;If yes, quit.  If not, create it.  If can't create, abort install.
 N HLSTN
 S HLSTN=+$$FIND1^DIC(4,"","MX",200)
 I HLSTN>0 D BMES^XPDUTL(" Station number 200 exists in the INSTITUTION file.") D MES^XPDUTL(" Pre-install routine completed successfully.") G ENDPRE
 I HLSTN=0 D  ;Not there, so create station #200
 .K DIC,DR,X,Y
 .S XUMF=1
 .S DIC="^DIC(4,",DIC(0)="",X="AUSTIN"
 .S DIC("DR")=".02////TEXAS;11////National;13////DPC;99////200;100////AUSTIN"
 .K DO,DD D FILE^DICN
 .I +Y<0 D BMES^XPDUTL(" Unable to add station number 200 to the INSTITUTION file.") D MES^XPDUTL(" Contact NVS or log a NOIS for assistance before proceeding.") S XPDABORT=1 Q
 .D BMES^XPDUTL(" Station number 200 has been added to the INSTITUTION file.")
 .D MES^XPDUTL(" Pre-install routine completed successfully.")
ENDPRE ;Kill variables and quit
 K DD,DIC,DO,DR,HLSTN,X,XUMF,Y
 Q
 ;
PST ;POST INSTALL
 ;Is VAFHIE entry in the HL LOGICAL LINK (#870) file?
 ;If yes, set AUTOSTART (#4.5) field to Enabled.  If no, quit.
 N HLLLK
 S HLLLK=+$$FIND1^DIC(870,"","MX","VAFHIE")
 I HLLLK=0 D BMES^XPDUTL(" 'VAFHIE' logical link failed to come in with this patch.") D MES^XPDUTL(" Contact NVS or log a NOIS for assistance before proceeding.") S XPDABORT=1 G ENDPST ;Abort install.
 L +^HLCS(870,HLLLK):10
 S DIE="^HLCS(870,",DA=HLLLK,DR="4.5///1"
 D ^DIE K DIE,DA,DR
 L -^HLCS(870,HLLLK)
 D BMES^XPDUTL(" The AUTOSTART (#4.5) field for the 'VAFHIE' entry in") D MES^XPDUTL(" the HL LOGICAL LINK (#870) file has been set to 'Enabled'.")
 ;
 ;If production account, quit - install complete.
 ;If test account, remove TCP/IP ADDRESS (#400.01) and DOMAIN (#.03)
 ;for VAFHIE entry in the HL LOGICAL LINK (#870) file.
 ;
 ;check default processing id in HL7 Site Parameters
 S HLPARAM3=$P($$PARAM^HLCS2,U,3)
 I HLPARAM3="P" D BMES^XPDUTL(" Post-install routine completed successfully.") G ENDPST ;Production account, so quit.
 E  D
 .;Test account or can't determine account, continue
 .;Is VAFHIE entry in the HL LOGICAL LINK (#870) file?
 .N HLLLK
 .S HLLLK=+$$FIND1^DIC(870,"","MX","VAFHIE")
 .Q:'HLLLK  ;VAFHIE entry not found, so quit.
 .L +^HLCS(870,HLLLK):10
 .S DIE="^HLCS(870,",DA=HLLLK,DR=".03///@;400.01///@"
 .D ^DIE K DIE,DA,DR
 .L -^HLCS(870,HLLLK)
 .D BMES^XPDUTL(" Because this is not a production account, the TCP/IP ADDRESS")
 .D MES^XPDUTL(" and DOMAIN fields were deleted for the 'VAFHIE' entry in the")
 .D MES^XPDUTL(" HL LOGICAL LINK (#870) file.")
 .D BMES^XPDUTL(" Post-install routine completed successfully.")
ENDPST ;Kill variables and quit
 K DA,DIE,DR,IEN,HLL,HLPARAM3,HLLLK
 Q
 ;
