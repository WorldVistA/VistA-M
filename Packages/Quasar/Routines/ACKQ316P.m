ACKQ316P ;ALB/BR-Compile Templates;
 ;;3.0;QUASAR;**16**;May 9, 2007;Build 37
 ;Per VHA Directive 2004-038, this routine SHOULD NOT be modified.
 ;This Post install routine will compile the templates for fields 40 and 45.
POST ;Post init
 N DGFLD,DGMFLD,DGOUT,DGFILE
 D TEMPL
 Q
 ;
TEMPL ;Determine templates on the FILE file to be compiled.
 N GLOBAL,FIELD,NFIELD,FILE,CNT
 D BMES^XPDUTL("Beginning to compile templates on the A&SP CLINIC VISIT (#509850.6) file.")
 ;
 S NFIELD="40,45",FILE=509850.6,FIELD="",CNT=1
 F  S FIELD=$P(NFIELD,",",CNT) Q:FIELD=""  D LOOP(FIELD,FILE) S CNT=CNT+1
 W !!
 S (X,Y)=""
 D BMES^XPDUTL("The following routine namespace was compiled:")
 F  S X=$O(CFIELD(X)) Q:X=""  S Y=$G(Y)+1 S PRINT(Y)=" "_X_"*"
 D MES^XPDUTL(.PRINT)
 K X,Y,PRINT,CFIELD
 Q
LOOP(FIELD,FILE) ;Compile templates.
 N GLOBAL,TEMPLATP,TEMPLATN,X,Y,DMAX
 F GLOBAL="^DIE","^DIPT" D
 .I $D(@GLOBAL@("AF",FILE,FIELD)) D
 ..S TEMPLATP=0
 ..F  S TEMPLATP=$O(@GLOBAL@("AF",FILE,FIELD,TEMPLATP)) Q:'TEMPLATP  D
 ...S TEMPLATN=$P($G(@GLOBAL@(TEMPLATP,0)),"^",1)
 ...I TEMPLATN="" D BMES^XPDUTL("Could not compile template "_TEMPLATN_$C(13,10)_"Please review!") Q
 ...S X=$P($G(@GLOBAL@(TEMPLATP,"ROUOLD")),"^")
 ...I X=""&($D(@GLOBAL@(TEMPLATP,"ROU"))'=0) D BMES^XPDUTL("Could not find routine for template "_TEMPLATN_$C(13,10)_"Please review!") Q
 ...I X=""&($D(@GLOBAL@(TEMPLATP,"ROU"))=0) Q
 ...;W !,"Field: "_FIELD,!
 ...;W !,"Template "_TEMPLATN_" needs to be compiled.",!
 ...I $D(CFIELD(X)) Q  ;already compiled
 ...S CFIELD(X)="" ;  remember the template was compiled
 ...S Y=TEMPLATP ;  set up the call for FileMan
 ...S DMAX=$$ROUSIZE^DILF
 ...I GLOBAL="^DIE" D BMES^XPDUTL(" "),BMES^XPDUTL("   Compiling Input Templates") D EN^DIEZ Q
 ...I GLOBAL="^DIPT" D BMES^XPDUTL(" "),BMES^XPDUTL("   Compiling Print Templates") D EN^DIPZ Q
 Q
 ;
 ;
