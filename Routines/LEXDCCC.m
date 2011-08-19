LEXDCCC ; ISL Default Display - Create             ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
 ; Entry:  S X=$$EN^LEXDCCC
 ;
 ; Function returns a two piece string
 ;  
 ; $P 1    String of classifications coding 
 ;         system mnemonics, i.e., "ICD/CPT",
 ;         and a legitimate value for LEXSHOW.
 ;         This will be null if input is "^"
 ;  
 ; $P 2    Name of display string selected i.e., 
 ;         "ICD/CPT only"  This will be null only
 ;         when user input is "^^"
 ;   
 ; LEXA   Answer to prompt (Yes 1 No 0)
 ; LEXC   Counter
 ; LEXI   Incremental Counter
 ; LEXS   Source, i.e., ICD94, NAN90, CPT89
 ; LEXSO  Source abbreviation, i.e., ICD, CPT, DSM
 ; LEXR   Internal Entry (Record) Number in #757.31
 ; 
 ; LEXFIL Flag, indicates that the 
 ;         classification codes selected are 
 ;         for building a filter - DIC("S")
 ;
T S X=$$EN W !!,X Q
EN(LEXX) ; Entry point S X=$$EN^LEXDCCC
BUILD ; Build the list to select from
 K ^TMP("LEXX",$J) W @IOF
 W:$D(LEXFIL) !,"Include terms linked to the following classification systems:",!!
 W:'$D(LEXFIL) !,"Display codes belonging to the following classification systems:",!!
 N LEXA,LEXC,LEXI,LEXSO,LEXR,LEXS
 S LEXS=""
 F  S LEXS=$O(^LEX(757.03,"B",LEXS)) Q:LEXS=""  D
 . Q:'$D(^LEX(757.02,"ASRC",$E(LEXS,1,3)))
 . S LEXSO=$E(LEXS,1,3) I LEXSO="UND" Q
 . S LEXR=$O(^LEX(757.03,"B",LEXS,0))
 . S LEXC=$S($D(^TMP("LEXX",$J,LEXSO)):LEXC+1,1:1)
 . S ^TMP("LEXX",$J,LEXSO,0)=LEXC
 . S ^TMP("LEXX",$J,LEXSO,LEXC)=$P(^LEX(757.03,LEXR,0),U,2,299)
LIST ; Display the list to select from
 S (LEXX,LEXA,LEXSO)=""
 F  S LEXSO=$O(^TMP("LEXX",$J,LEXSO)) Q:LEXSO=""!(LEXA[U)  D
 . W !,LEXSO F LEXI=1:1:^TMP("LEXX",$J,LEXSO,0) D
 . . W ?5,$P(^TMP("LEXX",$J,LEXSO,LEXI),U,2),!
ANS . ; Ask for user selection
 . W:'$D(LEXFIL) "Display these codes during look-up"
 . W:$D(LEXFIL) "Include terms linked to these codes during look-up"
 . S %=2 D YN^DICN S LEXA=%Y I %=2 W ! Q
 . I '%,'$D(LEXFIL) W !,"The codes from the selected coding systems may be displayed with the term.",! G ANS
 . I '%,$D(LEXFIL) W !,"Searches will display terms linked to the selected coding systems",! G ANS
 . I +($G(%))<0 S:%Y["^" LEXA="^" S:%Y["^^" LEXA="^^" W ! Q
 . S LEXX=LEXX_"/"_LEXSO W ! Q
 I $E(LEXX,1)="/" S LEXX=$E(LEXX,2,$L(LEXX))
 S:$D(LEXFIL) LEXX=LEXX_"^" I '$D(LEXFIL) D
 . N LEXNAM S LEXNAM=""
 . S:$P(LEXX,U,1)'="" LEXNAM=$$NAME^LEXDM3
 . S LEXX=LEXX_"^"_$S($L(LEXX):LEXNAM,1:"No display selected")
 S:LEXA["^^" LEXX="^^"
 K ^TMP("LEXX",$J),%,LEXA,LEXC,LEXI,LEXSO,LEXS,LEXR
 Q LEXX
