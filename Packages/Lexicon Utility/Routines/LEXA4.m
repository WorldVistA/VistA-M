LEXA4 ;ISA/CJE-Look-up (Loud) Unresolved Narrative ;01-13-00
 ;;2.0;LEXICON UTILITY;**3,6,15**;Sep 23, 1996
 ; JPK;Added more explanatory help text for display
 ;
EN ; User input was not found
 ; PCH 6 first two lines deleted (Narrative/Exact Match)
 S LEX("UNR")=+($G(^TMP("LEXSCH",$J,"UNR",0)))
 ; PCH 3 - Save number of matches found
 S LEX=+($G(^TMP("LEXSCH",$J,"NUM",0)))
 ; PCH 3 - "not found" flag
 N LEXNF S LEXNF=$S(LEX=0:1,1:0)
 ; Comment out next 2 lines to allow for unresolved narratives
 ; after the user enters an up-arrow ("^")
 ; S LEX("RES")=$G(^TMP("LEXSCH",$J,"RES",0))
 ; I LEX("RES")["^" K LEX("RES"),LEX("NAR"),LEX("UNR") Q
 S LEX("RES")=$G(^TMP("LEXSCH",$J,"RES",0))
 I LEX("RES")["^" K LEX("RES"),LEX("NAR"),LEX("UNR") Q
 ; Quit if:
 ;   User Narrative is NULL   LEX("NAR")=""   or
 ;   Unresolved not allowed   ^TMP("LEXSCH",$J,"UNR",0)=0
 I $G(LEX("NAR"))=""!($G(LEX("UNR"))=0) D EN^LEXAR("QUIT") Q
 N LEXN
 S:'LEXNF LEXN=$$NNS(LEX("NAR"))  ; PCH 3 - Prompt for user when matches were found
 S:LEXNF LEXN=$$NNF(LEX("NAR"))  ; PCH 3 - Prompt for user when no matches were found
 I LEXN["^" D EN^LEXAR(LEXN) Q
 I +LEXN=1,LEX("UNR")=1 D  Q
 . ; Unresolved pointer when "not found"  ; PCH 3 - added
 . I LEXNF,$L($G(LEX("NAR"))),$L($G(DIC)),$L($G(DUZ)) D  Q
 . . S:+LEXN>0&($G(DIC(0))["F") ^DISV(DUZ,DIC)=LEXN_"^"_LEX("NAR")
 . . S:DIC(0)["Z" Y(0)=$G(^LEX(757.01,1,0)),Y(0,0)=$P($G(^LEX(757.01,1,0)),"^",1)
 . . K:'$L($G(Y(0,0))) Y(0,0)
 . . D SET^LEXAR4(1)
 . ; Unresolved pointer when not an exact match 
 . I $L($G(LEX("NAR"))),'$L($G(LEX("EXM"))),$L($G(DIC)),$L($G(DUZ)) D
 . . S:+LEXN>0&($G(DIC(0))["F") ^DISV(DUZ,DIC)=LEXN_"^"_LEX("NAR")
 . . S:DIC(0)["Z" Y(0)=$G(^LEX(757.01,1,0)),Y(0,0)=$P($G(^LEX(757.01,1,0)),"^",1)
 . . K:'$L($G(Y(0,0))) Y(0,0)
 . . D EN^LEXAR(LEX("NAR")),SET^LEXAR4(1)
 . ; Resolved the pointer if an exact match is found
 . I $L($G(LEX("NAR"))),$L($G(LEX("EXM"))),$L($G(DIC)),$L($G(DUZ)) D
 . . S:+($G(LEX("EXM")))>2&($G(DIC(0))["F") ^DISV(DUZ,DIC)=+($G(LEX("EXM")))
 . . S:DIC(0)["Z" Y(0)=$G(^LEX(757.01,+(LEX("EXM")),0)),Y(0,0)=$P($G(^LEX(757.01,+(LEX("EXM")),0)),"^",1)
 . . K:'$L($G(Y(0,0))) Y(0,0)
 . . D EN^LEXAR(+($G(LEX("EXM")))),SET^LEXAR4(+($G(LEX("EXM"))))
 Q
NNS(X) ; Narrative not selected (LEX>0)
 W ! N LEXNARR,LEXANY,LEXPMT1,LEXPMT2,%,%Y S LEXANY="",LEXNARR=X
 D NNSA Q X
NNSA ; Use Narrative (anyway)
 I +($G(LEX("EXM")))=0 D
 . S LEXPMT1=">>>  You have not selected a term from the Lexicon"
 . S LEXPMT2=$S($L(LEXANY):">>>  ",1:"     ")_"Use "_LEXNARR_LEXANY
 I +($G(LEX("EXM")))>0 D
 . S LEXPMT1=">>>  Exact match found"
 . S LEXPMT2=$S($L(LEXANY):">>>  ",1:"     ")_"Use "_LEXNARR
 W:$L(LEXPMT1)&('$L(LEXANY)) !,LEXPMT1 W:$L(LEXANY) !
 W:$L(LEXPMT2) !,LEXPMT2
 S %=$S(+($G(LEX("EXM")))>2:1,1:2)
 D YN^DICN S:%Y["^" X="^" S:%Y["^^" X="^^" Q:X["^"  I %=-1 S X=0 Q
 I '%,+($G(LEX("EXM")))>0 D  G NNSA
 . W !!,"An exact match was found in the Lexicon.  By answering"
 . W !,"""Yes"" you will be selecting the exact match found in"
 . W !,"Lexicon.",!
 I '%,+($G(LEX("EXM")))'>0 D  G NNSA
 . W !!,"A suitable term was not found in the Lexicon.  By answering"
 . W !,"""Yes"" you will be keeping your exact text as typed rather than"
 . W !,"a term from the Lexicon"
 . S LEXANY=" anyway"
 I %=1 S X=% Q
 S X=0 Q
NNF(X) ; Narrative was not found ; PCH 3 - added
 W ! N LEXNARR,LEXANY,LEXPMT1,LEXPMT2,LEXPMT3,LEXPMT4,LEXPMT5,%,%Y
 S LEXANY="",LEXNARR=X
 D NNFA Q X
NNFA ; Use Narrative (anyway) ; PCH 3 - added
 N LEXC,LEXF,LEXV S LEXC=1,LEXF=$G(^TMP("LEXSCH",$J,"FIL",0)),LEXV=$G(^TMP("LEXSCH",$J,"VOC",0))
 S LEXPMT1=">>>  A suitable term was not found based on user input"
 S:LEXF="I 1" LEXF="" S:$L(LEXF)!(LEXV'="WRD") LEXPMT1=LEXPMT1_" and current defaults"
 S LEXPMT1=LEXPMT1_"."
 S LEXPMT2="NOTE : "_$S($L($G(LEXNARR)):"'"_LEXNARR_"' m",1:"You m")
 S LEXPMT2=LEXPMT2_"ay have found too many matches."
 S LEXPMT3="         You can refine your search by entering more descriptive text"
 S LEXPMT4="         (Eg. 'DISEASE' instead of 'DIS') ..."
 S LEXPMT5=$S($L(LEXANY):">>>  ",1:"     ")_"Use "_LEXNARR_LEXANY
 W:$L(LEXPMT1)&('$L(LEXANY)) !,LEXPMT1
 ; W:$L(LEXANY) !
 W !!,LEXPMT2,!,LEXPMT3,!,LEXPMT4
 W:$L(LEXPMT5) !!!,LEXPMT5
 S %=$S(+($G(LEX("EXM")))>2:1,1:2)
 D YN^DICN S:%Y["^" X="^" S:%Y["^^" X="^^" Q:X["^"  I %=-1 S X=0 Q
 I '% D  G NNFA
 . W !!,"A suitable term was not found in the Lexicon.  By answering"
 . W !,"""Yes"" you will be keeping the exact text as typed rather than"
 . W !,"a term from the Lexicon.",!
 . S LEXANY=" anyway"
 I %=1 S X=% Q
 S X=0 Q
