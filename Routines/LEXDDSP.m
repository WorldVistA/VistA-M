LEXDDSP ; ISL Display Defaults - Single User Parse ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
 ;
DISP ; Display single user defaults
 S:$D(ZTQUEUED) ZTREQ="@"
 G:+($G(LEXAP))=0 EXIT S LEXAP=+LEXAP G:'$L($G(^LEXT(757.2,LEXAP,0))) EXIT
 G:$P($G(^LEXT(757.2,LEXAP,5)),U,3)'=1 EXIT K LEX
 D NAME,VOC,DIS,FIL,CTX,DSPLY^LEXDDSD
EXIT ; Cleanup/quit
 K LEX,LEXV,LEXN,DIR,DIROUT,DIRUT,DTOUT,DUOUT,LEX,^TMP("LEXDIC",$J) Q
 ;
NAME ; Name
 N LEXV,LEXN S LEXV=$P(^VA(200,DUZ,0),"^",1),LEXN=""
 I LEXV["," S LEXN=$P(LEXV,",",2),LEXV=$P(LEXV,",",1)
 S:LEXN'="" LEXN=$$MIXED(LEXN) S:LEXV'="" LEXV=$$MIXED(LEXV)
 D NAME^LEXDDSS((LEXN_" "_LEXV)) Q
 ;
VOC ; Vocabulary
 N LEXV,LEXN S LEXV=$G(^LEXT(757.2,LEXAP,200,DUZ,3)) S:LEXV="" LEXV="WRD"
 S:$D(^LEXT(757.2,"AA",LEXV)) LEXN=$P(^LEXT(757.2,+($O(^LEXT(757.2,"AA",LEXV,0))),0),"^",1)
 D VOC^LEXDDSS(LEXN)
 Q
 ;
DIS ; Display Format
 D LEXSHOW^LEXDDSD Q
 ;
FIL ;     Filter
 N LEXV D DICS($G(^LEXT(757.2,LEXAP,200,DUZ,1)))
 K ^TMP("LEXDIC",$J) W:IOST["C-" @IOF S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
DICS(LEXV) ; Translate filter
 Q:'$D(LEXV)  N LEXS,LEXSHOW,LEXIN,LEXEX
 I $G(LEXV)="" D FIL^LEXDDSS("No search filter defined") Q
 S LEXS=LEXV D PARSE S:LEXV["SO^" LEXSHOW=LEXS
 D FIL^LEXDDSS($G(^LEXT(757.2,LEXAP,200,DUZ,1.5)))
 I $G(LEXS)=""!(LEXV="I 1") D
 . N LEXDA S LEXDA=0
 . F  S LEXDA=$O(^LEX(757.11,LEXDA)) Q:+LEXDA=0  D
 . . S LEXS=LEXS_"/"_$P(^LEX(757.11,LEXDA,0),U,1)
 . S:$E(LEXS,1)="/" LEXS=$E(LEXS,2,$L(LEXS)) S LEXS=LEXS_";"
 I LEXV["SC^"!(LEXV="I 1") D
 . S:$L(LEXS,";")=3 LEXSHOW=$P(LEXS,";",3)
 . D LB^LEXDDSS("    Look-up filter will: ")
 . D INCEXC,DICS^LEXDDSD
 I $G(LEXSHOW)'="" D
 . I LEXV["SC^" D BLB^LEXDDSS("    Look-up filter will also include terms linked to:")
 . I LEXV["SO^" D LB^LEXDDSS("    Look-up filter will include terms linked to: ")
 . D CODES^LEXDDSD(LEXSHOW)
 K ^TMP("LEXDIC",$J) Q
PARSE ; Parse DIS("S") string into INCLUDE;EXCLUDE;LEXSHOW
 S (LEXIN,LEXEX)="" S:LEXS["," LEXS=$P(LEXS,",",2)
 S LEXS=$TR(LEXS,"()",""),LEXS=$TR(LEXS,"""","") Q
INCEXC ; Include/Exclude Components
 S LEXIN=$P(LEXS,";",1),LEXEX=$P(LEXS,";",2) K ^TMP("LEXDIC",$J)
 I $D(LEXIN),LEXIN'="",LEXIN["/" D
 . N LEXI F LEXI=1:1:$L(LEXIN,"/") D
 . . I +($P(LEXIN,"/",LEXI))=0 D
 . . . S ^TMP("LEXDIC",$J,"INC","CLASS",$P(LEXIN,"/",LEXI))=""
 . . I +($P(LEXIN,"/",LEXI))'=0 D
 . . . S ^TMP("LEXDIC",$J,"INC","TYPE",$P(LEXIN,"/",LEXI))=""
 I $D(LEXIN),LEXIN'="",LEXIN'["/" D
 . I +LEXIN=0 S ^TMP("LEXDIC",$J,"INC","CLASS",LEXIN)="" Q
 . S ^TMP("LEXDIC",$J,"INC","TYPE",LEXIN)=""
 I $D(LEXEX),LEXEX'="",LEXEX["/" D
 . N LEXI F LEXI=1:1:$L(LEXEX,"/") D
 . . I +($P(LEXEX,"/",LEXI))=0 D
 . . . S ^TMP("LEXDIC",$J,"EXC","CLASS",$P(LEXEX,"/",LEXI))=""
 . . I +($P(LEXEX,"/",LEXI))'=0 D
 . . . S ^TMP("LEXDIC",$J,"EXC","TYPE",$P(LEXEX,"/",LEXI))=""
 I $D(LEXEX),LEXEX'="",LEXEX'["/" D
 . I +LEXEX=0 S ^TMP("LEXDIC",$J,"EXC","CLASS",LEXEX)="" Q
 . S ^TMP("LEXDIC",$J,"EXC","TYPE",LEXEX)=""
 S LEXN="" F  S LEXN=$O(^LEX(757.11,"B",LEXN)) Q:LEXN=""  D
 . Q:LEXIN[LEXN  N LEXTT,LEXTI S LEXTI=1,LEXT=0
 . F  S LEXT=$O(^LEX(757.12,"C",LEXN,LEXT)) Q:+LEXT=0!(+LEXTI=0)  D
 . . I LEXIN[LEXT S LEXTI=0
 . I LEXTI S ^TMP("LEXDIC",$J,"EXC","CLASS",LEXN)=""
 Q
 ;
CTX ; Shortcut Context
 N LEXV S LEXV=$G(^LEXT(757.2,LEXAP,200,DUZ,4.5)) I LEXV="" D
 . N LEXN S LEXN=+($G(^LEXT(757.2,LEXAP,200,DUZ,4.5)))
 . Q:+LEXN'>0  Q:'$D(^LEX(757.41,+LEXN))
 . S LEXV=$P(^LEX(757.41,+LEXN,0),U,1)
 D CON^LEXDDSS(LEXV)
 Q
MIXED(LEXV) ; Convert UPPERCASE to Mixed case
 S LEXV=$E(LEXV,1)_$$LOW^XLFSTR($E(LEXV,2,$L(LEXV)))
 Q LEXV
