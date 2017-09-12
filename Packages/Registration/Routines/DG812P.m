DG812P ;;ALB/DEP - POST-INSTALL DG*5.3*812 ; 2/5/13 5:09pm
 ;;5.3;REGISTRATION;**812**;Aug 13,1993;Build 19
 ;;Check for updated X-REFS (Field: .17) used in Input Templates
 ;;
 Q
 ;;
POST ;Post init
 N DGFLD,DGMFLD,DGOUT,DGFILE,DNM
 D TEMPL
 Q
 ;
TEMPL ;Determine templates on the FILE file to be compiled.
 N GLOBAL,FIELD,FILE,CNT
 D BMES^XPDUTL("Beginning to compile templates on the INDIVIDUAL ANNUAL INCOME (#408.21) file.")
 ;
 S FIELD=".17",FILE=408.21
 D LOOP(FIELD,FILE)
 S (X,Y)=""
 D BMES^XPDUTL("The following routine namespace compiled:")
 F  S X=$O(CFIELD(X)) Q:X=""  S Y=$G(Y)+1 S PRINT(Y)=" "_X
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
 .. I GLOBAL="^DIE" D BMES^XPDUTL("   Compiling Input Templates")
 .. I GLOBAL="^DIPT" D BMES^XPDUTL("   Compiling Print Template")
 .. F  S TEMPLATP=$O(@GLOBAL@("AF",FILE,FIELD,TEMPLATP)) Q:'TEMPLATP  D
 ... S TEMPLATN=$P($G(@GLOBAL@(TEMPLATP,0)),"^",1)
 ... I TEMPLATN="" D BMES^XPDUTL("Could not compile template "_TEMPLATN_$C(13,10)_"Please review!") Q
 ... S X=$P($G(@GLOBAL@(TEMPLATP,"ROUOLD")),"^")
 ... I X=""&($D(@GLOBAL@(TEMPLATP,"ROU"))'=0) D BMES^XPDUTL("Could not find routine for template "_TEMPLATN_$C(13,10)_"Please review!") Q
 ... I X=""&($D(@GLOBAL@(TEMPLATP,"ROU"))=0) Q
 ... I $D(CFIELD(X)) Q  ;already compiled
 ... S CFIELD(X)="" ;  remember the template was compiled
 ... S Y=TEMPLATP ;  set up the call for FileMan
 ... S DMAX=$$ROUSIZE^DILF
 ... I GLOBAL="^DIE" D EN^DIEZ Q
 ... I GLOBAL="^DIPT" D EN^DIPZ Q
 Q
 ;
