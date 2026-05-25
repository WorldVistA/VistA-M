DG531143P ;ALB/JAM - PATCH DG*5.3*1143 POST-INSTALL ROUTINE ;05 May 2025 10:00 AM
 ;;5.3;Registration;**1143**;Aug 13, 1993;Build 36
 ; ICRs:
 ; Reference to BMES^XPDUTL supported by ICR #10141
 ; Reference to MES^XPDUTL supported by ICR #10141
 ; Reference to EN^XPAR supported by ICR #2263 
 ; Reference to DIEZ^DIKCUTL3 support by ICR #3352 
 ; ICRs:
 ;         5421 : GENPORT^XOBWLIB
 ;         7190 : R/W access to file 18.02
 ;         7191 : R/W access to file 18.12
 ;         2240 : $$ENCRYP^XUSRB1
 ;        10096 : ^%ZSOF("DEL")
 ;
 ; This routine is also used as an Environmental Check routine, though it does nothing except make the HELP
 ;  tag below available for the Installation question in the build.
 Q
 ;
HELP ; Help for ?? on Installation Question POS (use direct writes in env check routine)
 W !,"Enter 1 if patch is being installed in a Preprod/Mirror system."
 W !,"Enter 2 if patch is being installed in a Software Quality Assurance system."
 W !,"Enter 3 if patch is being installed in a Development system."
 Q
 ;
ENV ;Main entry point for Environment check
 Q
 ;
PRE ;Main entry point for Pre-Install items
 ;
 Q
POST ;Main entry point for Post-Install items
 ;
 D BMES^XPDUTL(">>> Beginning the DG*5.3*1143 Post-install routine...")
 ; Get the site type entered in the Installation question POS
 S DGTYPE=$G(XPDQUES("POS1"))
 ; DGTYPE will be a value of 1-3 (MIRROR/PRE-PROD, SQA, DEVELOPMENT) (if no value, this is a PRODUCTION system)
 I 'DGTYPE S DGTYPE=4
 D POST1
 D POST2(DGTYPE)
 D POST3(DGTYPE)
 D POST4
 D POST5
 D BMES^XPDUTL(">>> Patch DG*5.3*1143 - Post-install complete.")
 Q
 ;
POST1 ; Set MAS PARAMETER for Real-time Address Update
 N DGFDA,DGERR,X,Y
 D BMES^XPDUTL("   o Set ENABLE REALTIME ADDRESS UPDATE (#1403) field")
 D MES^XPDUTL("       in the MAS PARAMETERS (#43) file")
 ; Set MAS Parameter to NO
 S DGFDA(43,"1,",1403)=0 D FILE^DIE("","DGFDA","DGERR")
 I '$D(DGERR) D MES^XPDUTL("   o ENABLE REALTIME ADDRESS UPDATE (#1403) field set to "_$$GET1^DIQ(43,1,1403,"E"))
 I $D(DGERR) D
 . D BMES^XPDUTL("   *** ERROR: "_DGERR("DIERR",1,"TEXT",1))
 . D MES^XPDUTL("    Please log YOUR IT Services ticket. ***")
 ;
 Q
POST2(DGTYPE) ; Setup DG RTAU CONTACTINFO SERVICE AND DG RTAU SERVER
 ; DGTYPE will be a value of 1-4 (MIRROR/PRE-PROD, SQA, DEVELOPMENT PRODUCTION)
 N DGSRVR,DGSRVC
 D BMES^XPDUTL(" o  Post-install set up for SSL Configuration...")
 S DGSRVR="DG RTAU SERVER"
 S DGSRVC="DG RTAU CONTACTINFO"
 ; If the DG RTAU SERVER is installed, set it to DISABLED so the update of the server won't cause errors
 ; The patch installation will set it back to ENABLED.
 D DISABLE
 D SERVICE
 D SERVER(DGTYPE)
 Q
 ;
SERVICE ; Set up service - use REGREST^XOBWLIB
 N DGI,DGILOWCASE,DGCNTXTRT
 D BMES^XPDUTL("    >> Updating WEB SERVICE (#18.02) file...")
 S DGCNTXTRT="/ves-contact-brk/contact-info"
 D REGREST^XOBWLIB(DGSRVC,DGCNTXTRT) ; REGREST^XOBWLIB handles all messaging.
 Q
 ;
SERVER(DGTYPE) ; set up web server
 ; DGTYPE will be a value of 1-4 (MIRROR/PRE-PROD, SQA, DEVELOPMENT, PRODUCTION)
 N DGEXIT,DGCOUNT,DGEPT,DGPW,DGPORT,DGDATA
 N DGIEN,DGIENS,DGSERVER,DGFDAI,DGERR,DGERR12,DGERR02,DGSRVIEN,DGSERVICE
 D MES^XPDUTL(" o  Setting up the server for "_$S(DGTYPE=1:"MIRROR/PRE-PROD",DGTYPE=2:"SQA",DGTYPE=3:"DEVELOPMENT",1:"PRODUCTION")_".")
 S DGEXIT=0
 ; Get the matching endpoint and port for the site type
 F DGCOUNT=1:1 S DGDATA=$P($T(TYPEMAP+DGCOUNT),";;",2) D  Q:DGEXIT
 . I $P(DGDATA,";",1)=DGTYPE S DGEPT=$P(DGDATA,";",3),DGPORT=$P(DGDATA,";",4),DGEXIT=1
 S DGIEN("SRV")=$$FIND1^DIC(18.12,,"B",DGSRVR)
 I DGIEN("SRV") S DGIENS("SRV")=DGIEN("SRV")_","
 E  S DGIENS("SRV")="+1,"
 ; NAME
 S DGSERVER(18.12,DGIENS("SRV"),.01)=DGSRVR
 ; PORT
 S DGSERVER(18.12,DGIENS("SRV"),.03)=DGPORT
 ; SERVER endpoint
 S DGSERVER(18.12,DGIENS("SRV"),.04)=DGEPT
 ; STATUS
 ; For Mirror, set Status to disabled, otherwise, enable
 ;S DGSERVER(18.12,DGIENS("SRV"),.06)=$S(DGTYPE=1:0,1:1)
 ; ENABLE SERVER
 S DGSERVER(18.12,DGIENS("SRV"),.06)=1
 ; SSL ENABLED
 S DGSERVER(18.12,DGIENS("SRV"),3.01)=1
 ; SSL CONFIGURATION
 S DGSERVER(18.12,DGIENS("SRV"),3.02)="encrypt_only_tlsv12"
 ; SSL PORT
 S DGSERVER(18.12,DGIENS("SRV"),3.03)=DGPORT
 ;
 I DGIEN("SRV") D FILE^DIE("","DGSERVER","DGERR12")    ; update existing entry
 I 'DGIEN("SRV") D UPDATE^DIE("","DGSERVER","DGFDAI","DGERR") ; create new entry
 I $D(DGFDAI) S DGIENS("SRV")=DGFDAI(1)_",",DGIEN("SRV")=DGFDAI(1)
 I '$D(DGERR12("DIERR",1,"TEXT",1)) D BMES^XPDUTL(" o  WEB SERVER '"_DGSRVR_"' addition/update succeeded.")
 I $D(DGERR12("DIERR",1,"TEXT",1)) D BMES^XPDUTL(" o  WEB SERVER '"_DGSRVR_"' Error: "_DGERR12("DIERR",1,"TEXT",1)) Q
 ; once server is set up add the web service
 S DGIENS("SRC")="+1,"
 S DGSRVIEN=0
 F  S DGSRVIEN=$O(^XOB(18.12,DGIEN("SRV"),100,"B",DGSRVIEN)) Q:'DGSRVIEN  D
 . I $$GET1^DIQ(18.02,DGSRVIEN,.01)=DGSRVC S DGIENS("SRC")=DGSRVIEN_","
 I DGIENS("SRC")'="+1," Q  ; don't update subentry pointers if already exist.
 K DGSERVICE,DGFDAI
 S DGSERVICE(18.121,DGIENS("SRC")_DGIENS("SRV"),.01)=DGSRVC
 S DGSERVICE(18.121,DGIENS("SRC")_DGIENS("SRV"),.06)="ENABLED"
 D UPDATE^DIE("E","DGSERVICE","DGFDAI","DGERR02") ; create new entry
 I $D(DGERR02("DIERR",1,"TEXT",1)) D MES^XPDUTL(" o  "_DGERR02("DIERR",1,"TEXT",1))
 I '$D(DGERR02("DIERR",1,"TEXT",1)) D BMES^XPDUTL(" o  '"_DGSRVC_"' service successfully authorized on server.")
 Q
 ;
DISABLE ; Disable DG RTAU SERVER server if it exists - update of server will set it back to enabled (except for Mirror)
 N DGIEN,DGSERVER,DGERR12
 S DGIEN("SRV")=$$FIND1^DIC(18.12,,"B",DGSRVR)
 I 'DGIEN("SRV") Q
 ; Set STATUS to DISABLED
 S DGSERVER(18.12,DGIEN("SRV")_",",.06)=0
 D FILE^DIE("","DGSERVER","DGERR12")    ; update existing entry
 D BMES^XPDUTL(" o  '"_DGSRVR_"' server temporarily disabled.")
 Q
 ;
POST3(DGTYPE) ; Set the API Key for the site into the parameter DG RTAU API KEY 
 ; DGTYPE will be a value of 1-4 (MIRROR/PRE-PROD, SQA, DEVELOPMENT PRODUCTION)
 N DGFDA,DGERR,DGKEY
 ;
 ; If API already defined, quit
 S DGKEY=$$GET^XPAR("PKG","DG RTAU API KEY",1)
 I DGKEY'="" Q
 ; Prod Key: 6ekfHkOzlN0KTV37vFBR1kqbOaSn7Po41ceMmd3h
 ; Non-Prod Key: 1xXofbhGbO37Ccb1ml0kmyCFL5y4dSafoKMl3d00
 S DGKEY=$S(DGTYPE=4:"6ekfHkOzlN0KTV37vFBR1kqbOaSn7Po41ceMmd3h",1:"1xXofbhGbO37Ccb1ml0kmyCFL5y4dSafoKMl3d00")
 D BMES^XPDUTL(" o Set Parameter instance DG RTAU API KEY in the PARAMETER (#8989.5) file")
 D EN^XPAR("PKG","DG RTAU API KEY",1,DGKEY,.DGERR)
 I '$G(DGERR) D MES^XPDUTL(" o DG RTAU API KEY Parameter set successfully.")
 I $G(DGERR) D
 . D BMES^XPDUTL(" *** Parameter set failed: "_DGERR)
 . D MES^XPDUTL("  Please log YOUR IT Services ticket. ***")
 Q
 ;
POST4 ; Set the DG RTAU API KEY parameter PROHIBIT EDITING (#.06) to 1 (YES)
 N DGPARAM,DGRTAKEY,DGERR
 ; Get the IEN of the Parameter Definition DG UAM API KEY
 S DGPARAM=$$FIND1^DIC(8989.51,,"B","DG RTAU API KEY")
 Q:'DGPARAM
 D BMES^XPDUTL(" o Setting parameter definition DG RTAU API KEY in the PARAMETER")
 D MES^XPDUTL("   DEFINITION (#8989.51) file to prohibit editing")
 ; Set PROHIBIT EDITING (#.06) field to 1
 S DGRTAKEY(8989.51,DGPARAM_",",.06)=1
 D FILE^DIE("","DGRTAKEY","DGERR")
 I $G(DGERR) D
 . D BMES^XPDUTL(" *** Parameter set failed: "_DGERR)
 . D MES^XPDUTL("  Please log YOUR IT Services ticket. ***")
 Q
 ;
POST5 ; Recompile templates
 ; Build array of file and field numbers for top-level file and fields being exported
 ; Array format: DGFLD(file#,field)=""
 ; Recompile all compiled input templates that contain the fields in the DGLFD array passed by reference 
 ; PATIENT file #2
 N DGFLD
 D BMES^XPDUTL(" o Recompile all compiled input templates that contain the following fields:")
 D MES^XPDUTL("    PATIENT file(#2): ")
 D MES^XPDUTL("    o RESIDENTIAL ADDRESS FIELDS")
 D MES^XPDUTL("    o MAILING ADDRESS FIELDS")
 D MES^XPDUTL("    o TEMPORARY ADDRESS FIELDS")
 D MES^XPDUTL("    o CONFIDENTIAL ADDRESS FIELDS")
 D MES^XPDUTL("    o EMAIL ADDRESS AND CELL PHONE FIELDS")
 D MES^XPDUTL("    o HOME, OFFICE, TEMPORARY AND CONFIDENTIAL PHONE FIELDS")
 ;
 ; Residential Address
 ; Line 1
 S DGFLD(2,.1151)=""
 ; Line 2
 S DGFLD(2,.1152)=""
 ; Line 3
 S DGFLD(2,.1153)=""
 ; City
 S DGFLD(2,.1154)=""
 ; State
 S DGFLD(2,.1155)=""
 ; Zip+5
 S DGFLD(2,.1156)=""
 ; County
 S DGFLD(2,.1157)=""
 ; Province
 S DGFLD(2,.11571)=""
 ; Postal Code
 S DGFLD(2,.11572)=""
 ; Country
 S DGFLD(2,.11573)=""
 ; Home Phone
 S DGFLD(2,.131)=""
 ; Work phone
 S DGFLD(2,.132)=""
 ; Mailing Address
 ; Line 1
 S DGFLD(2,.111)=""
 ; Line 2
 S DGFLD(2,.112)=""
 ; Line 3
 S DGFLD(2,.113)=""
 ; City
 S DGFLD(2,.114)=""
 ; State
 S DGFLD(2,.115)=""
 ; Zip
 S DGFLD(2,.116)=""
 ; County
 S DGFLD(2,.117)=""
 ; Province
 S DGFLD(2,.1171)=""
 ; Postal Code
 S DGFLD(2,.1172)=""
 ; Country
 S DGFLD(2,.1173)=""
 ; Zip+4
 S DGFLD(2,.1112)=""
 ; Bad Address Indicator
 S DGFLD(2,.121)=""
 ; Temporary Address
 ; Line 1
 S DGFLD(2,.1211)=""
 ; Line 2
 S DGFLD(2,.1212)=""
 ; Line 3
 S DGFLD(2,.1213)=""
 ; City
 S DGFLD(2,.1214)=""
 ; State
 S DGFLD(2,.1215)=""
 ; Zip 
 S DGFLD(2,.1216)=""
 ; Start Date
 S DGFLD(2,.1217)=""
 ; End Date
 S DGFLD(2,.1218)=""
 ; Address Active?
 S DGFLD(2,.12105)=""
 ; Temp Phone
 S DGFLD(2,.1219)=""
 ; County
 S DGFLD(2,.12111)=""
 ; Zip+4
 S DGFLD(2,.12112)=""
 ; Province
 S DGFLD(2,.1221)=""
 ; Postal Code
 S DGFLD(2,.1222)=""
 ; Country
 S DGFLD(2,.1223)=""
 ; Confidential Address
 ; Line 1
 S DGFLD(2,.1411)=""
 ; Line 2
 S DGFLD(2,.1412)=""
 ; Line 3
 S DGFLD(2,.1413)=""
 ; City
 S DGFLD(2,.1414)=""
 ; State
 S DGFLD(2,.1415)=""
 ; Zip 
 S DGFLD(2,.1416)=""
 ; Start Date
 S DGFLD(2,.1417)=""
 ; End Date
 S DGFLD(2,.1418)=""
 ; Address Active?
 S DGFLD(2,.14105)=""
 ; County
 S DGFLD(2,.14111)=""
 ; Province
 S DGFLD(2,.14114)=""
 ; Postal Code
 S DGFLD(2,.14115)=""
 ; Country
 S DGFLD(2,.14116)=""
 ; Conf Phone
 S DGFLD(2,.1315)=""
 ; CASS Indicator
 S DGFLD(2,.14117)=""
 ;
 ; EMAIL
 S DGFLD(2,.133)=""
 ; Cell number 
 S DGFLD(2,.134)=""
 ;
 D DIEZ^DIKCUTL3(2,.DGFLD)
 Q
 ;
TYPEMAP ; Map the system type to the SERVER endpoint and Port values
 ;;1;MIRROR;prep.ves.domain.ext;443
 ;;2;SQA;sqa.ves.domain.ext;443
 ;;3;DEV;dev.ves.domain.ext;443
 ;;4;PROD;ves.domain.ext;443
