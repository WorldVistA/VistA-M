DG53149P ;SF/CMC,PTD,DLR-PRE and POST INSTALL FOR DG*5.3*149 ;1/14/99
 ;;5.3;Registration;**149**;Aug 13, 1993
 ;
PRE ;Pre-Install for DG*5.3*149
 L +^XTMP("NO NEW JOBS"):60 I '$T D BMES^XPDUTL("Unable to get lock on VAFC BATCH UPDATE task, Install Aborted!") S XPDABORT=2 Q
 L +^XTMP("ADT/HL7 VAFC BATCH UPDATE"):60 I '$T D BMES^XPDUTL("Unable to get lock on VAFC BATCH UPDATE task, Install Aborted!") S XPDABORT=2 Q
 L +^VAT(391.71,"VAFC BATCH UPDATE ADT/HL7"):1 I '$T D BMES^XPDUTL("Unable to get lock on VAFC BATCH UPDATE task, Install Aborted!") S XPDABORT=2 Q
 Q
 ;
POST ;Post-Install for DG*5.3*149
 L -^XTMP("NO NEW JOBS")
 L -^XTMP("ADT/HL7 VAFC BATCH UPDATE")
 L -^VAT(391.71,"VAFC BATCH UPDATE ADT/HL7")
 ;
HL7SITE ;Update FACILITY in the HL7 APPLICATION PARAMETER file.
 N DA,DIC,DIE,DR,I,SITE,X,Y
 S SITE=$$SITE^VASITE,SITE=$P(SITE,"^",3),SITE=SITE\1
 ; ^ SITE is Station Number of site doing install
 S DIC="^HL(771,",DIC(0)="XQZ",X="VAFC PIMS"
 D ^DIC Q:+Y<0
 S DA=+Y,DIE="^HL(771,",DR="3///^S X=SITE"
 D ^DIE
 K DA,DIC,DIE,DR,I,SITE,X,Y
 ;
COMPILE N GLOBAL,FIELD,CFIELD,NFIELD,TEMPLATP,TEMPLATN
 ;
 D BMES^XPDUTL("Beginning to compile templates on the patient file.")
 ;
 S NFIELD=$P($T(AFIELDS),";;",2) ;get the fields that have new xref
 ;
 F GLOBAL="^DIE","^DIPT" DO
 .I GLOBAL="^DIE" D BMES^XPDUTL("   Compiling Input Templates")
 .I GLOBAL="^DIPT" DO
 . . D BMES^XPDUTL(" ")
 . . D BMES^XPDUTL("   Compiling Print Templates")
 .;
 .S FIELD=0
 .; go find templates on fields that have added cross-ref
 .F  S FIELD=$O(@GLOBAL@("AF",2,FIELD)) Q:'FIELD  DO
 . .;
 . .S CFIELD=","_FIELD_","
 . .;if we didn't add the cross reference, quit
 . .I NFIELD'[CFIELD Q
 . .;
 . .S TEMPLATP=0
 . .F  S TEMPLATP=$O(@GLOBAL@("AF",2,FIELD,TEMPLATP)) Q:'TEMPLATP  DO
 . . . S TEMPLATN=$P($G(@GLOBAL@(TEMPLATP,0)),"^",1)
 . . . I TEMPLATN="" DO  Q
 . . . . D BMES^XPDUTL("Could not compile template "_TEMPLATN_$C(13,10)_"Please review!")
 . . . .;
 . . . S X=$P($G(@GLOBAL@(TEMPLATP,"ROUOLD")),"^")
 . . . I X=""&($D(@GLOBAL@(TEMPLATP,"ROU"))'=0) DO  Q
 . . . . D BMES^XPDUTL("Could not find routine for template "_TEMPLATN_$C(13,10)_"Please review!")
 . . . I X=""&($D(@GLOBAL@(TEMPLATP,"ROU"))=0) Q
 . . . I $D(FIELD(X)) Q  ;already compiled
 . . .;
 . . . S FIELD(X)="" ;                remember the template was compiled
 . . . S Y=TEMPLATP ;                 set up the call for fman
 . . . S DMAX=$$ROUSIZE^DILF
 . . . I GLOBAL="^DIE" D EN^DIEZ Q
 . . . I GLOBAL="^DIPT" D EN^DIPZ Q
 .;
 W !!!
 S (X,Y)=""
 D BMES^XPDUTL("The following routine namespace was compiled:")
 F  S X=$O(FIELD(X)) Q:X=""  DO
 . S Y=$G(Y)+1 S PRINT(Y)=" "_X_"*"
 ;
 D MES^XPDUTL(.PRINT)
 Q
 ;
 ;these are the fields that have a new cross-ref
AFIELDS ;;,.01,.02,.03,.05,.08,.09,.111,.1112,.112,.113,.114,.115,.117,.131,.132,.211,.219,.2403,.301,.302,.31115,.323,.351,391,991.01,991.02,991.03,991.04,991.05,991.06,9910.7,1901,
 Q
