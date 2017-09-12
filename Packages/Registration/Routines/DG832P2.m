DG832P2 ;;ALB/RGB - POST-INSTALL DG*5.3*832 ; 6/24/10 6:42pm
 ;;5.3;Registration;**832**;Aug 13, 1993;Build 9
 ;;Check for updated X-REFS (Fields: .01,.04,.06,.14,.18) used in Input Templates
 ;;
 ; IA #2796 for use of calls to RGHLLOG in UPDBAI
POST ;Post init
 N DGFLD,DGMFLD,DGOUT,DGFILE
 D TEMPL
 Q
 ;
TEMPL ;Determine templates on the FILE file to be compiled.
 N GLOBAL,FIELD,NFIELD,FILE,CNT
 D BMES^XPDUTL("Beginning to compile templates on the PATIENT MOVEMENT (#405) file.")
 ;
 S NFIELD=".01,.04,.06,.14,.18",FILE=405,FIELD="",CNT=1
 F  S FIELD=$P(NFIELD,",",CNT) Q:FIELD=""  D LOOP(FIELD,FILE) S CNT=CNT+1
 W !!
 S (X,Y)=""
 D BMES^XPDUTL("The following routine namespace compiled:")
 F  S X=$O(CFIELD(X)) Q:X=""  S Y=$G(Y)+1 S PRINT(Y)=" "_X_"*"
 ;
 D MES^XPDUTL(.PRINT)
 K X,Y,PRINT,CFIELD
 Q
LOOP(FIELD,FILE) ;Compile templates.
 N GLOBAL,TEMPLATP,TEMPLATN,X,Y,DMAX,TYPE
 F GLOBAL="^DIE","^DIPT" D
 . S TYPE="Input" S:GLOBAL="^DIPT" TYPE="Print"
 . I $D(@GLOBAL@("AF",FILE,FIELD)) D
 .. S TEMPLATP=0
 .. F  S TEMPLATP=$O(@GLOBAL@("AF",FILE,FIELD,TEMPLATP)) Q:'TEMPLATP  DO
 ... S TEMPLATN=$P($G(@GLOBAL@(TEMPLATP,0)),"^",1)
 ... I TEMPLATN="" D BMES^XPDUTL("Could not compile template "_TEMPLATN_$C(13,10)_"Please review!") Q
 ... S X=$P($G(@GLOBAL@(TEMPLATP,"ROUOLD")),"^")
 ... I X=""&($D(@GLOBAL@(TEMPLATP,"ROU"))'=0) D BMES^XPDUTL("Could not find routine for template "_TEMPLATN_$C(13,10)_"Please review!") Q
 ... I X=""&($D(@GLOBAL@(TEMPLATP,"ROU"))=0) Q
 ... I $D(CFIELD(X)) Q  ;already compiled
 ... S CFIELD(X)="" ;  remember the template was compiled
 ... S Y=TEMPLATP ;  set up the call for FileMan
 ... S DMAX=$$ROUSIZE^DILF
 ... I GLOBAL="^DIE" D BMES^XPDUTL(" "),BMES^XPDUTL("   Compiling Input Templates") D EN^DIEZ Q
 ... I GLOBAL="^DIPT" D BMES^XPDUTL(" "),BMES^XPDUTL("   Compiling Print Templates") D EN^DIPZ Q
 Q
 ;
 ;
