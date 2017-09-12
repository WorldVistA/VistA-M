ONCPST47 ;Hines OIFO/GWB - POST-INSTALL ROUTINE FOR PATCH ONC*2.11*47
 ;;2.11;ONCOLOGY;**47**;Mar 07, 1995;Build 19
 ;
 ;Set the COLLABORATIVE STAGING URL (160.1,19) value in all ONCOLOGY
 ;SITE PARAMETERS entries = http://websrv.oncology.domain.ext/oncsrv.exe
 S RC=$$UPDCSURL^ONCSAPIU("http://websrv.oncology.domain.ext/oncsrv.exe")
 ;
ITEM1 ;ACOS STATE AT DIAGNOSIS (160.15)
 ;Edit code ZZ (Residence unknown)
 ;Add codes CD (Resident of Canada, NOS) and
 ;          US (Resident of United States, NOS)
 S DIC="^ONCO(160.15,",X="ZZ" D ^DIC
 I Y'=-1 S DIE="^ONCO(160.15,",DA=+Y,DR="1///Residence unknown" D ^DIE
 I '$D(^ONCO(160.15,"B","CD")) D
 .K DD,DO
 .S DIC="^ONCO(160.15,",DIC(0)="L"
 .S DIC("DR")="1///Resident of Canada, NOS",X="CD" D FILE^DICN
 I '$D(^ONCO(160.15,"B","US")) D
 .K DD,DO
 .S DIC="^ONCO(160.15,",DIC(0)="L"
 .S DIC("DR")="1///Resident of United States, NOS",X="US" D FILE^DICN
 K DIC,X,Y,DIE,DR,DA
 ;
ITEM3 I '$D(^VIC(5.1,"B","BEN HILL")) D
 .K DD,DO
 .S DIC="^VIC(5.1,"
 .S DIC(0)="L"
 .S DIC("DR")="1///13;2///017",X="BEN HILL" D FILE^DICN
