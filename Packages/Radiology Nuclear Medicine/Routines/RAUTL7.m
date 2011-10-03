RAUTL7 ;HISC/CAH,FPT,GJC-Utility for RACCESS array ;5/8/97  14:55
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
DIVIACC ; Sets up division and imaging access based on location.
 ; Requires RACCESS array.  Creates 'DIV-IMG' elements of
 ; array:  RACCESS(DUZ,"DIV-IMG",Division name,Imaging type name)=""
 I '$D(RACCESS(DUZ,"LOC")) D  Q
 . W !?5,"Please contact your ADPAC regarding access to"
 . W !?5,"Imaging Locations.",$C(7)
 . Q
 N X,Y S X=0
 F  S X=$O(RACCESS(DUZ,"LOC",X)) Q:'X  D
 . S X(0)=$G(^RA(79.1,X,0)),X("DIV")=+$G(^RA(79.1,X,"DIV"))
 . S X("DIV")=+$G(^RA(79,X("DIV"),0)),X("IMG")=+$P(X(0),"^",6)
 . S Y("DIV")=$P($G(^DIC(4,X("DIV"),0)),"^")
 . S Y("IMG")=$P($G(^RA(79.2,X("IMG"),0)),"^")
 . I Y("DIV")]"",(Y("IMG")]"") D
 .. S RACCESS(DUZ,"DIV-IMG",Y("DIV"),Y("IMG"))=""
 .. Q
 . Q
 Q
SETUPDI() ; Set up Division/Imaging Type access
 ; Requires RACCESS(DUZ,"IMG").  Passes back to calling routine
 ; a 1 if failure because user has no imaging type access based on
 ; location access (probably no location access in File 200) .
 ; Passes back 0 if success.  Does a call to
 ; above routine to set up "DIV-IMG" elements of RACCESS array.
 ; If "DIV-IMG" elements do not exist, displays error message
 ; to user.
 N Y S Y=0
 I '$D(RACCESS(DUZ,"IMG")) S Y=1 D  Q Y
 . W !?5,"You do not have access to any Imaging Locations."
 . W !?5,"Contact your ADPAC.",$C(7)
 . Q
 D DIVIACC^RAUTL7 ; Set up Div-Img access array
 I '$D(RACCESS(DUZ,"DIV-IMG")) S Y=1 D  Q Y
 . W !?5,"You have no Imaging Location Access Privileges."
 . W !?5,"Contact your ADPAC.",$C(7)
 . H 3 Q
 Q Y
SELDIV ; Select Division, if exists
 ; Requires RACCESS "DIV" elements.  Prompts user to select division(s).
 ; Creates ^TMP($J,"RA D-TYPE",Division name,Division IEN)="" which
 ; contains all divisions selected.
 N RAONE S RAONE=$$DIV1()
 I $P(RAONE,"^")]"" S RAQUIT=0 D  Q
 . S ^TMP($J,"RA D-TYPE",$P(RAONE,"^"),$P(RAONE,"^",2))=""
 . Q
 S RADIC="^RA(79,",RADIC(0)="QEAMZ"
 S RADIC("A")="Select Rad/Nuc Med Division: ",RADIC("B")="All"
 S RADIC("S")="I $D(RACCESS(DUZ,""DIV"",+Y))",RAUTIL="RA D-TYPE"
 D EN1^RASELCT(.RADIC,RAUTIL) K %W,%Y1,DIC,RADIC,RAUTIL,X,Y
 Q
SELIMG ; Select Imaging Type, if exists
 ; Prompts user to select Imaging Type(s).
 ; Creates ^TMP($J,"RA I-TYPE",Imaging Type name,Imaging Type IEN)=""
 N RA,RAIMGNUM,RAONE S RA="",RAONE=$$IMG1()
 ; .... chk if only 1 img type is available
 I $P(RAONE,"^")]"",('$D(^TMP($J,"RA D-TYPE"))) S RAQUIT=0 D  Q
 . S ^TMP($J,"RA I-TYPE",$P(RAONE,"^"),$P(RAONE,"^",2))=""
 . Q
 ; .... chk if only 1 img type within selectable division is available
 ; raimgnum = number of selectable img types
 I $D(^TMP($J,"RA D-TYPE")) D
 . D SETUP^RAUTL7A S RAIMGNUM=$$IMGNUM^RAUTL7A()
 . Q
 I $D(^TMP($J,"RA D-TYPE")),(RAIMGNUM=1) D  S RAQUIT=0 Q
 . N RA0,RA1
 . S RA1=+$O(^TMP($J,"DIV-IMG",0)),RA0=$P($G(^RA(79.2,RA1,0)),"^")
 . S ^TMP($J,"RA I-TYPE",RA0,RA1)=""
 . Q
 S RADIC="^RA(79.2,",RADIC(0)="QEAMZ",RAUTIL="RA I-TYPE"
 S RADIC("A")="Select Imaging Type: ",RADIC("B")="All"
 I $D(^TMP($J,"RA D-TYPE")) D
 . S RADIC("S")="I $D(^TMP($J,""DIV-IMG"",+Y)),($D(RACCESS(DUZ,""IMG"",+Y)))"
 . Q
 ; why do we need to check the alternative ?  DIVLOC+3 prevents this
 ; alternative from occurring.
 E  S RADIC("S")="I $D(RACCESS(DUZ,""IMG"",+Y))"
 W !! D EN1^RASELCT(.RADIC,RAUTIL) K %W,%Y1,DIC,RADIC,RAUTIL,X,Y
 Q
SELLOC ; Select Imaging Location
 ; Prompts user to select Imaging Location(s)
 ; Creates ^TMP($J,"RA LOC-TYPE",img-loc name,img-loc ien)
 N RALOCNUM,RAONE S RAONE=$$LOC1()
 ; .... chk if only 1 img type is available
 I $P(RAONE,"^")]"",('$D(^TMP($J,"RA D-TYPE"))) S RAQUIT=0 D  Q
 . S ^TMP($J,"RA LOC-TYPE",$P($G(^SC(+$P(RAONE,"^"),0)),U),$P(RAONE,"^",2))=""
 . Q
 ; .... chk if only 1 img type within selectable division is available
 I $D(^TMP($J,"RA D-TYPE")) D
 . D SETUPL^RAUTL7A S RALOCNUM=$$LOCNUM^RAUTL7A()
 . Q
 I $D(^TMP($J,"RA D-TYPE")),(RALOCNUM=1) D  S RAQUIT=0 Q
 . N RA0,RA1
 . S RA1=+$O(^TMP($J,"DIV-ITYP-ILOC",0)),RA0=$P($G(^RA(79.1,RA1,0)),"^")
 . S RA0=$P($G(^SC(+RA0,0)),U)
 . S ^TMP($J,"RA LOC-TYPE",RA0,RA1)=""
 . Q
 S RADIC="^RA(79.1,",RADIC(0)="QEAMZ",RAUTIL="RA LOC-TYPE"
 S RADIC("A")="Select Imaging Location: ",RADIC("B")="All"
 I $D(^TMP($J,"RA D-TYPE")) D
 . S RADIC("S")="I $D(^TMP($J,""DIV-ITYP-ILOC"",+Y))"
 . Q
 ; the alternative is included here to match that in SELIMG
 E  S RADIC("S")="I $D(RACCESS(DUZ,""LOC"",+Y))"
 W !! D EN1^RASELCT(.RADIC,RAUTIL) K %W,%Y1,DIC,RADIC,RAUTIL,X,Y
 Q
DIV1() ; Check if the user has access to more than one division
 ; Returns Division name AND Division IEN if one only.
 ; Returns Null if more than one division.
 N X,Y S X=+$O(RACCESS(DUZ,"DIV",0)) Q:'X ""
 S Y=+$O(RACCESS(DUZ,"DIV",X)) Q:'Y $P($G(^DIC(4,X,0)),"^")_"^"_X
 Q ""
IMG1() ; Check if the user has access to more than one i-type
 ; Returns Imaging type name AND Imaging Type IEN if one only.
 ; Returns Null if more than one imaging type.
 N X,Y S X=+$O(RACCESS(DUZ,"IMG",0)) Q:'X ""
 S Y=+$O(RACCESS(DUZ,"IMG",X)) Q:'Y $P($G(^RA(79.2,X,0)),"^")_"^"_X
 Q ""
LOC1() ; Check if the user has access to more than one location
 ; Returns Rad/Nuc Med Location if one only.
 ; Returns Null if more than one Rad/Nuc Med Location, or no access
 N X,Y S X=+$O(RACCESS(DUZ,"LOC",0)) Q:'X ""
 S Y=+$O(RACCESS(DUZ,"LOC",X)) Q:'Y $P($G(^RA(79.1,X,0)),"^")_"^"_X
 Q ""
DIVLOC() ; Entry point to setup  division/img-typ/img-loc  access
 N X S X=$$SETUPDI^RAUTL7() Q:X 1
 D SELDIV^RAUTL7 ; Select Rad division(s)
 I '$D(^TMP($J,"RA D-TYPE"))!(RAQUIT) D  Q 1
 . K RACCESS(DUZ,"DIV-IMG"),^TMP($J,"DIV-IMG")
 . Q
 N RASUB S RASUB="" D SELIMG^RAUTL7 ; Select I-Type
 I '$D(^TMP($J,"RA I-TYPE"))!(RAQUIT) D  Q 1
 . K RACCESS(DUZ,"DIV-IMG"),^TMP($J,"DIV-IMG")
 . Q
 K ^TMP($J,"DIV-IMG")
 Q 0
