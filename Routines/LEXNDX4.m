LEXNDX4 ; ISL Set/kill indexes (Part 4) Link       ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
LINK ; Link a Keyword to an expression
 I $D(^LEX(757.05,DA,1,"B",1)) Q
 W !,"LINK" S X=LEXBY D PTX^LEXTOLKN
 I ^TMP("LEXTKN",$J,0)>0 S (LEXLINK,LEXKEY)="",LEXKEY=$O(^TMP("LEXTKN",$J,1,LEXKEY))
 S LEXREC=0 F  S LEXREC=$O(^LEX(757.01,"AWRD",LEXKEY,LEXREC)) Q:+LEXREC=0!(LEXLINK[U)  D
 . I ^TMP("LEXTKN",$J,0)=1 S LEXASK=1
 . I ^TMP("LEXTKN",$J,0)>1 S LEXASK=1 D
 . . F LEXA=2:1:^TMP("LEXTKN",$J,0) D
 . . . S LEXAKEY="",LEXAKEY=$O(^TMP("LEXTKN",$J,LEXA,LEXAKEY))
 . . . S LEXSRC=$$UP^XLFSTR(^LEX(757.01,LEXREC,0))
 . . . I LEXSRC'[$E(LEXAKEY,1,4) S LEXASK=0
 . S LEXLINK="" I LEXASK D
 . . I $D(^LEX(757.05,DA,1,"B",LEXREC)) Q
MOK . . ; Prompt to Map/Link a keyword to an expression
 . . W !!,"Map       ",^LEX(757.01,LEXREC,0),!,"To        ",LEXREP,!,"OK" S %=1 D YN^DICN S LEXLINK=% I %=-1 W ! S LEXLINK=U Q
 . . I '% W !!,"By answering ""Yes"", an index reference will be made to link the",!,"term to the key word ",LEXREP G MOK
 . I +LEXLINK=1 D
 . . N LEXYPE,LEXT S ^LEX(757.05,"ALINK",DA,LEXREC)=""
 . . S LEXYPE=+($P($G(^LEX(757.01,LEXREC,1)),U,2))
 . . S LEXT=+($P($G(^LEX(757.011,LEXYPE,0)),U,2))
 . . S:+LEXT>0 ^LEX(757.01,"AWRD",LEXREP,LEXREC,"LINKED")="" W !
 . . I $D(^LEX(757.05,DA,1,0)) D
 . . . S LEXSREC=0 F  S LEXSREC=$O(^LEX(757.05,DA,1,LEXSREC)) Q:+LEXSREC=0  D
 . . . . S ^LEX(757.05,DA,1,"B",^LEX(757.05,DA,1,LEXSREC,0),LEXSREC)=""
 . . . I '$D(^LEX(757.05,DA,1,"B",LEXREC)) D
 . . . . S LEXSREC=0  F  S LEXSREC=$O(^LEX(757.05,DA,1,LEXSREC)) Q:+LEXSREC=0  S LEXLNK=LEXSREC+1
 . . . . K LEXSREC S ^LEX(757.05,DA,1,LEXLNK,0)=LEXREC
 . . . . S ^LEX(757.05,DA,1,"B",LEXREC,LEXLNK)="",$P(^LEX(757.05,DA,1,0),U,4)=$P(^LEX(757.05,DA,1,0),U,4)+1
 . . . . S $P(^LEX(757.05,DA,1,0),U,3)=LEXLNK K LEXLNK
 . . I '$D(^LEX(757.05,DA,1,0)) S ^LEX(757.05,DA,1,1,0)=LEXREC,^LEX(757.05,DA,1,"B",LEXREC,1)="",^LEX(757.05,DA,1,0)="^757.53P^1^1"
 D VERIFY K ^TMP("LEXTKN",$J),^TMP("LEXTKN",$J,0),LEXSRC,LEXKEY,LEXA,LEXAKEY,LEXREC,LEXASK,LEXLINK
 Q
VERIFY ; Display linkages made for user verification
 Q:'$D(DA)
 I '$D(^LEX(757.05,DA,1,0)) W !,"No Word Linkages Created",! Q
 W !!,$P(^LEX(757.05,DA,0),"^",1)," has been linked to:  ",!
 N LEXSREC S LEXSREC=0
 F  S LEXSREC=$O(^LEX(757.05,DA,1,LEXSREC)) Q:+LEXSREC=0  D
 . W !,?4,$E(^LEX(757.01,^LEX(757.05,DA,1,LEXSREC,0),0),1,75)
 W ! I +$$OK D  K LEXSREC,LEXLNK Q
 . S LEXSREC=0  F  S LEXSREC=$O(^LEX(757.05,DA,1,LEXSREC)) Q:+LEXSREC=0  S LEXLNK=LEXSREC+1
 . K LEXSREC S ^LEX(757.05,DA,1,LEXLNK,0)=1,^LEX(757.05,DA,1,"B",1,LEXLNK)=""
 . S $P(^LEX(757.05,DA,1,0),U,4)=$P(^LEX(757.05,DA,1,0),U,4)+1
 . S $P(^LEX(757.05,DA,1,0),U,3)=LEXLNK K LEXLNK
 D UNLINK
 Q
OK(LEXOK) ; Get user response
OK1 ; Prompt "Is this correct"
 W !,"Is this correct" S %=1 D YN^DICN
 I %=-1!(%=2) K %,%Y Q 0
 I %=1 K %,%Y Q 1
 I '% D  G OK1
 . W !,"By confirming the word linkages displayed above, a look-up"
 . W !,"conducted on ",$P(^LEX(757.05,DA,0),"^",1)
 . W " will retrieve the linked terms."
 Q 0
RELINK ; Relink Keywords to expressions
 Q:'$D(DA)  Q:'$D(^LEX(757.05,DA,1,1,0))
 D SUB N LEXMC,LEXCTR,LEXSREC,LEXERM S (LEXCTR,LEXSREC)=0,LEXERM=$P(^LEX(757.05,DA,0),"^",1)
 F  S LEXSREC=$O(^LEX(757.05,DA,1,LEXSREC)) Q:+LEXSREC=0  D
 . S LEXCTR=LEXCTR+1
 . S ^LEX(757.05,DA,1,0)="^757.53P^"_LEXCTR_"^"_LEXCTR
 . S ^LEX(757.05,DA,1,"B",^LEX(757.05,DA,1,LEXSREC,0),LEXSREC)=""
 . I ^LEX(757.05,DA,1,LEXSREC,0)'=1 D
 . . S LEXMC=^LEX(757.05,DA,1,LEXSREC,0)
 . . N LEXYPE,LEXT S LEXYPE=+($P($G(^LEX(757.01,LEXMC,1)),U,2))
 . . S LEXT=+($P($G(^LEX(757.011,LEXYPE,0)),U,2))
 . . I +LEXT>0 D
 . . . S ^LEX(757.01,"AWRD",LEXERM,LEXMC,"LINKED")=""
 . . . N X S X=LEXERM D SSF^LEXNDX6
 . . S ^LEX(757.05,"ALINK",DA,LEXMC)=""
 K LEXSREC,LEXERM
 Q
UNLINK ; Unlink a Keyword from an expression
 Q:'$D(^LEX(757.05,DA,1,0))  N LEXMC,LEXLNK
 S LEXMC=0  F  S LEXMC=$O(^LEX(757.05,DA,1,"B",LEXMC)) Q:+LEXMC=0  D
 . S LEXLNK=0  F  S LEXLNK=$O(^LEX(757.05,DA,1,"B",LEXMC,LEXLNK)) Q:+LEXLNK=0  D
 . . S LEXWRD=$P(^LEX(757.05,DA,0),U,1)
 . . K ^LEX(757.01,"AWRD",LEXWRD,LEXMC,"LINKED")
 . . N X S X=LEXWRD D KSF^LEXNDX6
 . . K ^LEX(757.05,"ALINK",DA,LEXMC)
 . . I $D(X),X=0 K ^LEX(757.05,DA,1,LEXLNK,0),^LEX(757.05,DA,1,"B",LEXMC,LEXLNK),^LEX(757.05,DA,1,0)
 K LEXLNK,LEXMC
 Q
SUB ; Index linked words in sub-file before UNLINK and RELINK
 Q:'$D(DA)  I $D(^LEX(757.05,DA,1,1,0)) N LEXSREC,LEXMC S LEXSREC=0 F  S LEXSREC=$O(^LEX(757.05,DA,1,LEXSREC)) Q:+LEXSREC=0  S ^LEX(757.05,DA,1,"B",^LEX(757.05,DA,1,LEXSREC,0),LEXSREC)=""
 Q
