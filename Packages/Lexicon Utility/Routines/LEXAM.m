LEXAM ; ISL Look-up Misc (Setup/Parse)           ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
SETUP(LEXSUB) ; Set up search variables
 I '$L($G(LEXSUB)) D  Q
 . S LEX("ERR",0)=+($G(LEX("ERR",0)))+1
 . S LEX("ERR",LEX("ERR",0))="Default Vocabulary missing or invalid"
 S ^TMP("LEXSCH",$J,"VOC",0)=LEXSUB
 I '$D(^LEXT(757.2,"AA",^TMP("LEXSCH",$J,"VOC",0))) D  Q
 . S LEX("ERR",0)=+($G(LEX("ERR",0)))+1
 . S LEX("ERR",LEX("ERR",0))="Default Vocabulary missing or invalid"
 N LEXSUBS S LEXSUBS=$O(^LEXT(757.2,"AA",^TMP("LEXSCH",$J,"VOC",0),0))
 S ^TMP("LEXSCH",$J,"IDX",0)="A"_^TMP("LEXSCH",$J,"VOC",0)
 I $D(^LEXT(757.2,LEXSUBS,1)) D
 . S ^TMP("LEXSCH",$J,"GBL",0)=^LEXT(757.2,LEXSUBS,1)
 . S ^TMP("LEXSCH",$J,"FLN",0)=+($P(^TMP("LEXSCH",$J,"GBL",0),"(",2))
 . I +^TMP("LEXSCH",$J,"FLN",0)=0!('$D(^DD(+^TMP("LEXSCH",$J,"FLN",0)))) D  Q
 . . S LEX("ERR",0)=+($G(LEX("ERR",0)))+1
 . . S LEX("ERR",LEX("ERR",0))="File Number missing or invalid"
 . I '$D(^DIC(^TMP("LEXSCH",$J,"FLN",0),0,"GL")) D  Q
 . . S LEX("ERR",0)=+($G(LEX("ERR",0)))+1
 . . S LEX("ERR",LEX("ERR",0))="Global Location missing or invalid"
 . I $G(^DIC(^TMP("LEXSCH",$J,"FLN",0),0,"GL"))'=^TMP("LEXSCH",$J,"GBL",0) D  Q
 . . S LEX("ERR",0)=+($G(LEX("ERR",0)))+1
 . . S LEX("ERR",LEX("ERR",0))="Global Location missing or invalid"
 . I $D(^TMP("LEXFND",$J)) D
 . . N LEXI,LEXE S LEXI=-999999999,^TMP("LEXSCH",$J,"EXM",0)=""
 . . F  S LEXI=$O(^TMP("LEXFND",$J,LEXI)) Q:LEXI=0!(^TMP("LEXSCH",$J,"EXM",0)'="")  D
 . . . S ^TMP("LEXSCH",$J,"EXM",0)=$O(^TMP("LEXFND",$J,LEXI,0)) S:+(^TMP("LEXSCH",$J,"EXM",0))=0 ^TMP("LEXSCH",$J,"EXM",0)=""
 Q
 ;
 ; Entry      D TOLKEN^LEXAM("USER INPUT")
 ; Returns    LEXTKN(#)=TOLKEN LIST
 ; 
 ; LEXFOC(   Array by frequency of occurance
 ; LEXTKN(   Array by frequency
 ; LEXTKNS(  Array by input
 ;
 ; LEXLOOK   Flag for PTX^LEXTOLKN indicating parse for look-up
 ; LEXI      Incremental counter
 ; LEXF      Frequency of occurance
 ; LEXKEY    Key for spell check
 ; LEXK      Tolken
 ; LEXKF     Tolken found
 ; LEXNK     Next tolken
 ;
TOLKEN(LEXX) ; Return list of tolkens in ascending order of usage
 Q:'$L($G(LEXX))  D PARSE,ORD K ^TMP("LEXTKN",$J) Q
PARSE ; Parse user input into tolkens
 K ^TMP("LEXTKN",$J) N X,LEXLOOK S X=LEXX,LEXLOOK="" D PTX^LEXTOLKN Q
ORD ; tolken list in frequency order
 Q:'$D(^TMP("LEXTKN",$J,0))  K LEXFOC,LEXTKN N LEXKEY,LEXI,LEXF,LEXK,LEXCT
 ; Get possible key
 S (LEXCT,LEXI)=0 F  S LEXI=$O(^TMP("LEXTKN",$J,LEXI)) Q:+LEXI=0  D
 . S LEXK=$O(^TMP("LEXTKN",$J,LEXI,""))
 . I $D(^LEX(757.01,"ASL",LEXK)) S LEXF=$O(^LEX(757.01,"ASL",LEXK,0)),LEXKEY(LEXF)=LEXK
 I $D(LEXKEY) N LEXKF S LEXKF=$O(LEXKEY(0)),LEXKF=LEXKEY(LEXKF) K LEXKEY S LEXKEY=LEXKF
 S:'$D(LEXKEY) LEXKEY=""
 ; Order by frequency
 S (LEXCT,LEXI)=0 F  S LEXI=$O(^TMP("LEXTKN",$J,LEXI)) Q:+LEXI=0  D
 . S LEXK=$O(^TMP("LEXTKN",$J,LEXI,""))
 . I $D(^LEX(757.01,"ASL",LEXK)) D
 . . N LEXNK S LEXNK=$$EXP^LEXAS6(LEXK)
 . . I $D(^LEX(757.01,"ASL",LEXNK)),LEXNK[LEXK,$L(LEXNK)>$L(LEXK) S LEXK=LEXNK
 . . S LEXCT=LEXCT+1,LEXF=$O(^LEX(757.01,"ASL",LEXK,0))
 . . S LEXTKNS(LEXCT)=LEXK,LEXFOC(LEXF,LEXK)=""
 . . S LEXTKNS(0)=LEXCT
 . I '$D(^LEX(757.01,"ASL",LEXK)),$D(^LEX(757.01,"AWRD",LEXK)) D FRQ(LEXK) Q
 . I '$D(^LEX(757.01,"ASL",LEXK)),'$D(^LEX(757.01,"AWRD",LEXK)) D
 . . S LEXK=$$SPL^LEXAS(LEXK)
 . . I LEXK["^" D  Q
 . . . N LEXF,LEXT S LEXF=$P(LEXK,"^",1),LEXT=$P(LEXK,"^",2)
 . . . D FRQ(LEXF),FRQ(LEXT)
 . . D FRQ(LEXK)
 K ^TMP("LEXTKN",$J) Q:'$D(LEXFOC)  S LEXI=-999999999,LEXF=0
 F  S LEXI=$O(LEXFOC(LEXI)) Q:+LEXI=0  D
 . S LEXK="" F  S LEXK=$O(LEXFOC(LEXI,LEXK)) Q:LEXK=""  D
 . . S LEXF=LEXF+1,LEXTKN(LEXF)=LEXK K LEXFOC(LEXI,LEXK)
 S:LEXF>0 LEXTKN(0)=LEXF
 Q
FRQ(LEXK) ; Frequency
 I $D(^LEX(757.01,"ASL",LEXK)) D
 . S LEXCT=LEXCT+1,LEXF=$O(^LEX(757.01,"ASL",LEXK,0))
 . S LEXTKNS(LEXCT)=LEXK,LEXFOC(LEXF,LEXK)=""
 . S LEXTKNS(0)=LEXCT
 I '$D(^LEX(757.01,"ASL",LEXK)),$D(^LEX(757.01,"AWRD",LEXK)) D
 . S LEXCT=LEXCT+1 N LEXC,LEXI S (LEXC,LEXI)=0
 . F  S LEXI=$O(^LEX(757.01,"AWRD",LEXK,LEXI)) Q:+LEXI=0  S LEXC=LEXC+1
 . S LEXF=LEXC,LEXTKNS(LEXCT)=LEXK,LEXFOC(LEXF,LEXK)=""
 . S LEXTKNS(0)=LEXCT
 Q
