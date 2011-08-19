LEXAR ;ISA/FJF/KER-Look-up (Interpret User Response) ;11/30/2008
 ;;2.0;LEXICON UTILITY;**3,19,25,55**;Sep 23, 1996;Build 11
 ;
 ; User Responses
 ;
 ; Numeric  -----------------------------------------------
 ;
 ; #             Select Entry
 ;
 ; Numeric^Comment ----------------------------------------
 ;
 ; IEN^COMMENT   Application comment about term
 ;
 ; Up-Arrow -----------------------------------------------
 ;
 ; ^#            Jump to # on list
 ; ^             End dialog with the user
 ; ^^            End dialog with the application
 ;
 ; Question -----------------------------------------------
 ;
 ; ?             Standard help in LEX("HLP")
 ; ??            Extended help in LEX("HLP")
 ; ?#            Definition for # in LEX("HLP")
 ;
 ; Null ---------------------------------------------------
 ;
 ;               Advance the selection list
 ;
 ; String -------------------------------------------------
 ;
 ; Narrative     Return and store Unresolved Narrative
 ;
 ; --------------------------------------------------------
EN(LEXUR,LEXVDT) ; Interpret user response
 I '$D(LEX) D APN Q
 K LEX("HLP")
 N LEXLL,LEXMAX
 I $D(LEX("LIST",0)),+$G(^TMP("LEXSCH",$J,"NUM",0))>0 D
 .S LEX=+$G(^TMP("LEXSCH",$J,"NUM",0))
 I LEXUR="END",+LEX>0 S LEXUR="^"_LEX
 S LEXLL=+$G(^TMP("LEXSCH",$J,"LEN",0))
 S:LEXLL=0 LEXLL=5
 S LEXMAX=+$G(^TMP("LEXSCH",$J,"LST",0))
 S LEXUR=$G(LEXUR)
 S (LEX("RES"),^TMP("LEXSCH",$J,"RES",0))=LEXUR
 S ^TMP("LEXSCH",$J,"RES",1)="User Response"
 ; Timed out/Quit
 I LEXUR="DTOUT"!(LEXUR="QUIT") D EDA Q
 ; Yes/No response list has one entry
 I $G(LEX)=1,+LEXUR=0,LEXUR'["^" D
 .I $E(LEXUR,1)="Y"!($E(LEXUR,1)="y") S LEXUR=1 Q
 .I LEXUR["?" D HLP^LEXAR3 Q
 .S LEXUR=""
 ; Null (Page Down)
 I LEXUR="" D NULL^LEXAR2 D END Q
 ; Minus (Page Up)
 I $E(LEXUR,1)="-" D LIST^LEXAL2("PGUP") D END Q
 ; Help
 I LEXUR["?" D HLP^LEXAR3 D END Q
 ; Up Arrow
 I LEXUR["^",$D(^TMP("LEXSCH",$J)) D UPA^LEXAR2(LEXUR) D END Q
 ; Select
 I +LEXUR>0,+LEXUR'>LEXMAX D SEL^LEXAR4(+LEXUR,$G(LEXVDT)) D END Q
 ; User Unresolved Narrative
 I LEXUR=$G(^TMP("LEXSCH",$J,"NAR",0)),+$G(^TMP("LEXSCH",$J,"UNR",0))=1 D  D END Q
 .D SAVE^LEXAR6
APN ; Application Unresolved Narrative
 I LEXUR["^",'$D(^TMP("LEXSCH",$J)),+LEXUR>0,$D(^LEX(757.01,+LEXUR,0)),$L($P(LEXUR,"^",2)) D  Q
 .K LEX
 .D COM^LEXAR6(LEXUR)
 D END
 Q
END ; End of Interpretation of the Users Response
 I $D(^TMP("LEXSCH",$J)) D
 .S (LEX("RES"),^TMP("LEXSCH",$J,"RES",0))=LEXUR
 .S ^TMP("LEXSCH",$J,"RES",1)="User Response"
 I $D(LEX("LIST",0)),+$G(^TMP("LEXSCH",$J,"NUM",0))>0 D
 .S LEX=+$G(^TMP("LEXSCH",$J,"NUM",0))
 Q
SEL ; Selection made
 K LEX("RES"),LEX("ERR"),LEX("LIST"),LEX("MIN"),LEX("MAX"),LEX("MAT"),LEX("HLP")
 D NAR,EMF,KLST,KSCH
 S:$D(LEX("SEL")) LEX=0
 Q
EDU ; End Dialog with the User
 D NAR,EMF,KLST,KARL,KSCH
 S LEX=0
 Q
EDA ; End Dialog with the Application
 K LEX
 D KLST,KSCH
 Q
LST ; List exist
 D NAR,MAX,MIN,MAT,EML
 Q
 ;
KLST ; Kill Global List 
 ;      ^TMP("LEXFND",$J)
 ;      ^TMP("LEXHIT",$J)
 K ^TMP("LEXFND",$J),^TMP("LEXHIT",$J)
 Q
KSCH ; Kill Search Variables
 ;      ^TMP("LEXSCH",$J)
 ; PCH 55 - The only way to kill ^TMP("LEXSCH",$J) is exiting LEXA1
 Q
KARL ; Kill Array List and supporting variables
 ;       LEX("LIST"),LEX("MAT"),LEX("MIN"),LEX("MAX")
 K LEX("LIST"),LEX("MAT"),LEX("MIN"),LEX("MAX")
 K LEX("EXC"),LEX("EXM")
 Q
LEX ; Set LEX to the number of entries on the list
 S:+$G(^TMP("LEXSCH",$J,"NUM",0))>0 LEX=+$G(^TMP("LEXSCH",$J,"NUM",0))
 Q
NAR ; Set LEX("NAR") to the user narrative
 K LEX("NAR")
 S:$L($G(^TMP("LEXSCH",$J,"NAR",0))) LEX("NAR")=$G(^TMP("LEXSCH",$J,"NAR",0))
 Q
MAX ; Set LEX("MAX") to the last entry reviewed by the user
 K LEX("MAX")
 S:+$G(^TMP("LEXSCH",$J,"LST",0))>0 LEX("MAX")=+$G(^TMP("LEXSCH",$J,"LST",0))
 Q
MIN ; Set LEX("MIN") to the first entry reviewed by the user
 K LEX("MIN")
 S:+$G(LEX("MAX"))>0 LEX("MIN")=1
 Q
EML ; Set LEX("EXM") post-selection IEN^Expression text
 K LEX("EXM")
 S:$L($G(^TMP("LEXSCH",$J,"EXM",2))) LEX("EXM")=$G(^TMP("LEXSCH",$J,"EXM",2))
 Q
EMF ; Set LEX("EXM") pre-selection LIST#^Expression text
 K LEX("EXM")
 I $L($G(^TMP("LEXSCH",$J,"EXM",0))),$L($G(^TMP("LEXSCH",$J,"EXM",1))) D
 .S LEX("EXM")=$G(^TMP("LEXSCH",$J,"EXM",0))_"^"_$G(^TMP("LEXSCH",$J,"EXM",1))
 Q
MAT ; Set "matches found" string and top of list flag
 ;       LEX("MAT")                 # Matches found
 ;       ^TMP("LEXSCH",$J,"TOL",0)  1 - Top of list
 ;                                   0 - Not top of list
 K LEX("MAT")
 I $D(LEX("SEL"))!('$D(^TMP("LEXSCH",$J)))!('$D(LEX("LIST"))) Q
 N LEXOL,LEXL
 S LEXOL=$G(^TMP("LEXSCH",$J,"TOL",0))
 S LEXL=$O(LEX("LIST",0))
 I LEXOL'=0,LEXL=1 S ^TMP("LEXSCH",$J,"TOL",0)=1
 I LEXOL'=0,LEXL'=1 S ^TMP("LEXSCH",$J,"TOL",0)=0
 I LEXOL=1,$L($G(^TMP("LEXSCH",$J,"MAT",0))) D
 .S LEX("MAT")=$G(^TMP("LEXSCH",$J,"MAT",0))
 Q
