YTWJSONU ;SLC/KCM - JSON Instrument Spec Utilities ; 7/20/2018
 ;;5.01;MENTAL HEALTH;**130**;Dec 30, 1994;Build 62
 ;
 ; External Reference    ICR#
 ; ------------------   -----
 ; DIR                  10026
 ; XLFDT                10103
 ; XLFSTR               10104
 ;
PROMPT(TEXT) ; prompt for text value and return, otherwise ""
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="F",DIR("A")=TEXT
 I $D(^XTMP("YTWPROMPTS",TEXT)) S DIR("B")=^XTMP("YTWPROMPTS",TEXT)
 D ^DIR I $G(DIRUT) S X=""
 I $L(X) D
 . S ^XTMP("YTWPROMPTS",0)=$$FMADD^XLFDT(DT,7)_U_DT_U_"MH Default Prompts"
 . S ^XTMP("YTWPROMPTS",TEXT)=X
 Q X
 ;W !,"X=",X,!,"Y=",Y,!,$G(DTOUT),?5,$G(DUOUT),?10,$G(DIRUT),?15,$G(DIROUT)
 ;
BLDTXT(WPREF,TEXT) ; build array of JSON text from WP field
 N I,LN,LASTLN,IDX
 S IDX=-1
 S I=0 F  S I=$O(@WPREF@(I)) Q:'I  D
 . S LN=@WPREF@(I,0),IDX=IDX+1
 . S LN=$$HTMLESC(LN)
 . I IDX=0 S TEXT=LN,LASTLN=LN Q
 . I ($E(LASTLN,$L(LASTLN))'=" "),($E(LN)'=" ") S LN=" "_LN
 . S TEXT("\",IDX)=LN,LASTLN=LN
 Q
HTMLESC(X) ; return X HTML escaped
 N SPEC
 S SPEC("|")="<br />"
 ; use unicode character since JSX treats &char; as code injection
 S SPEC("""")="\u0022"  ; "&quot;"
 S SPEC(">")="\u003E"   ; "&gt;"
 S SPEC("<")="\u003C"   ; "&lt;"
 Q $$REPLACE^XLFSTR(X,.SPEC)
 ;
 ;
NAMES(OUT) ; build JSON of all active test names
 N LN,NAME,TEST,STAFF
 S LN=1,OUT(LN)="{""instruments"":["
 S NAME=0 F  S NAME=$O(^YTT(601.71,"B",NAME)) Q:'$L(NAME)  D
 . S TEST=0 F  S TEST=$O(^YTT(601.71,"B",NAME,TEST)) Q:'TEST  D
 . . I $P($G(^YTT(601.71,TEST,2)),U,2)'="Y" QUIT
 . . D ADDPROP("name",NAME)
 . . D ADDPROP("fullName",$P(^YTT(601.71,TEST,0),U,3))
 . . D ADDPROP("isBattery","false")
 . . S STAFF=($P($G(^YTT(601.71,TEST,1)),U,7)="Y")
 . . D ADDPROP("staffOnly",$S(STAFF=1:"true",1:"false"))
 S OUT(LN)=$E(OUT(LN),1,$L(OUT(LN))-1)  ; remove last comma
 S LN=LN+1,OUT(LN)="]}"
 ;N I S I=0 F  S I=$O(OUT(I)) Q:'I  W !,OUT(I)
 Q
 ;
ADDPROP(NAME,VALUE) ; add property to test select object
 ; expects OUT,LN
 N X
 S X=""
 I NAME="name" S X=X_"{",LN=LN+1,OUT(LN)=""
 S X=X_""""_NAME_""":"
 I NAME="staffOnly" D
 . S X=X_VALUE_"},"
 E  S X=X_""""_VALUE_""","
 S OUT(LN)=OUT(LN)_X
 Q
