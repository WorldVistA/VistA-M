VAFHPST1 ;ALB/JRP,PKE - POST INIT ROUTINE;07-JUN-1996
 ;;5.3;Registration;**91**;AUG 13, 1993
 ;
FACILITY ;set facility name in HL7 APPLICATIONS #771
 ;
 ;input  : None
 ;ouput  : None
 D BMES^XPDUTL(">>> Adding Facility-Station number to 'VAFH PIMS' entry in File #771")
 N DIC,DIE,DA,DR,C,D,DI,D0,DQ,%,X,Y,DTOUT,DUOUT
 S X="VAFH PIMS",DIC(0)="MZ" S (DIE,DIC)="^HL(771,"
 D ^DIC
 I Y<1 DO  QUIT
 .D BMES^XPDUTL(">>> 'VAFH PIMS' entry NOT found in File #771")
 .D BMES^XPDUTL("...  ")
 S DA=+Y,DR="3///^S X=+$$SITE^VASITE()"
 D ^DIE
 ;
 D BMES^XPDUTL(">>> Adding Facility-Station number to 'VAFC PIMS' entry in File #771")
 N DIC,DIE,DA,DR,C,D,DI,D0,DQ,%,X,Y,DTOUT,DUOUT
 S X="VAFC PIMS",DIC(0)="MZ" S (DIE,DIC)="^HL(771,"
 D ^DIC
 I Y<1 DO  QUIT
 .D BMES^XPDUTL(">>> 'VAFC PIMS' entry NOT found in File #771")
 .D BMES^XPDUTL("...  ")
 S DA=+Y,DR="3///^S X=+$$SITE^VASITE()"
 D ^DIE
 Q
 ;
PARA ;this tag will set the pivot file number at install time.  It will
 ;not write over an existing number.
 N VAR,VAR1
 S VAR1=$O(^DG(43,0))
 I 'VAR1 DO  Q
 .D MES^XPDUTL("There does not seem to be an MAS PARAMETER file.  Did not set Pivot Number.")
 ;
 I +$G(^DG(43,VAR1,"HL7")) Q
 S VAR=+$O(^DGPM("A"),-1)
 I 'VAR DO  Q
 .D MES^XPDUTL("Could not obtain a number from the Patient Movement file.  Pivot Number not updated.")
 ;
 S VAR=VAR+1000
 S $P(^DG(43,VAR1,"HL7"),U,1)=VAR
 D MES^XPDUTL(".")
 Q
 ;
 ;
DISABLE ;this tag will disable the protocol from the first development effort.
 ;just in case
 K DIC,DIE,X,Y,DA,DR
 S DIC="^ORD(101,",DIC(0)="MZ",X="A1BV PHILADELPHIA HL7 UPDATES"
 D ^DIC
 K DIC
 I Y<0 S VAFHX=X DO
 .;D BMES^XPDUTL("Could not find the protocol ",X," Nothing closed.")
 I Y>0 DO
 .S DIE="^ORD(101,",DIC(0)="MZ",DA=+Y,DR="2///Out of Order"
 .D ^DIE
 .D BMES^XPDUTL("A1BV PHILADELPHIA HL7 UPDATES now out of order!")
 K DIC,DIE,X,Y,DA,DR
 Q
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
 .; go find templates on fields on fields that have added cross-ref
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
 . . . I X="" DO  Q
 . . . . D BMES^XPDUTL("Could not find routine for template "_TEMPLATN_$C(13,10)_"Please review!")
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
AFIELDS ;;,.01,.02,.03,.05,.06,.08,.09,.111,.1112,.112,.113,.114,.115,.117,.131,.132,.211,.219,.2403,.301,.302,.31115,.323,.351,.363,391,1901,
 Q
