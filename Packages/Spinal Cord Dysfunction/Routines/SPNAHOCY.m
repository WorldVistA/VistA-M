SPNAHOCY ;HISC/DAD-AD HOC REPORTS: INTERFACE COMPILER ;9/9/96  11:44
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
 ;
 S (SPNMMAX,SPNSORT)=0,SPNLEVEL=1,SPNFILE(SPNLEVEL)=SPNFILE
FLD ; *** Process the sort/print fields
 W !!,"Choose a field for menu item number ",SPNMMAX+1
 W ", <RETURN> to end, ^ to exit."
 W !,"Select ",$S(SPNLEVEL=1:"",1:$P(SPNFILE(SPNLEVEL-1),U,3)_" SUB-")
 W "FIELD: " R X:DTIME S:'$T X=U S SPNQUIT=$S($E(X)=U:1,1:0)
 I X="?",SPNMMAX D LIST G:SPNQUIT FLD W !
 K DIC S DIC="^DD("_+SPNFILE(SPNLEVEL)_",",DIC(0)="EMNQZ"
 S DIC("W")="W ""  "",$$ID^SPNAHOCY"
 D ^DIC S SPNY=Y
 I SPNY'>0 S:X="" SPNLEVEL=SPNLEVEL-1 G EXIT:'SPNLEVEL!SPNQUIT,FLD
 S SPNATTR="LABEL;MULTIPLE-VALUED;POINTER;SPECIFIER;TYPE" K SPNDD,SPNERR
 D FIELD^DID(+SPNFILE(SPNLEVEL),+SPNY,"",SPNATTR,"SPNDD","SPNERR")
 I $O(SPNERR(""))]"" W " ??",$C(7) G FLD
 S SPNDD=SPNDD("LABEL")_U_SPNDD("SPECIFIER")_U_SPNDD("POINTER")
 S $P(SPNFILE(SPNLEVEL),U,2,3)=+SPNY_U_$P(SPNDD,U),SPNWP=0
 ; *** SPNFILE(Level#) = Dict # ^ Fld # ^ Fld Name
 I +$P(SPNDD,U,2) D  G:'SPNWP FLD
 . S SPNWP=(SPNDD("TYPE")="WORD-PROCESSING")
 . I 'SPNWP S SPNLEVEL=SPNLEVEL+1,SPNFILE(SPNLEVEL)=+$P(SPNDD,U,2)
 . Q
 I $D(SPNCHOSN(SPNFILE(SPNLEVEL)))#2 D  G FLD
 . W !!?5,"*** You have already chosen that field !! ***",$C(7)
 . Q
 F SP=1:1:5 S SPNTEXT(SP)=""
NAME ; *** Prompt user for the external field name
 K DIR S DIR(0)="FOA^2:30^K:X[U X",DIR("?")="^D EN^SPNAHOCH(""H7"")"
 S DIR("A")="Menu text the user should see: "
 S DIR("B")=$$CASE($P(SPNDD,U))
 D ^DIR G:$D(DIRUT) FLD S SPNTEXT(2)=Y
SORT ; *** Allow sorting on this field (Y/N)
 G:SPNWP SETLINE ; *** Don't ask sort questions for WP fields
 F  D  Q:%
 . S X=$P(SPNDD,U,2)
 . S %=$S($P(SPNFILE(SPNLEVEL),U,2)=.01:1,X["F":2,X["K":2,X["V":2,1:1)
 . W !,"Want to allow sorting by ",SPNTEXT(2)
 . D YN^DICN S SPNTEXT(1)=(%=1),SPNSORT=SPNSORT+SPNTEXT(1)
 . I '% W !!?5,SPNYESNO,!
 . Q
 G:%=-1 FLD
SCREEN ; *** Prompt user for screen on pointers and sets
 S X=$P(SPNDD,U,2)
 I SPNTEXT(1),$TR(X,$TR(X,"PS"))]"" D  G:$D(DTOUT)!$D(DUOUT)!$D(DIROUT) FLD
 . F  D  Q:SPNTEXT(5)]""!$D(DIRUT)
 .. K DIR S DIR(0)="FOAU^1:245^"
 .. S DIR("A")="Sort from/to look-up screen: "
 .. S DIR("?")="^D EN^SPNAHOCH(""H12"")"
 .. D ^DIR I Y=""!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q
 .. S X=Y D ^DIM
 .. I $G(X)]"" S SPNTEXT(5)=X
 .. E  W " ??",$C(7)
 .. Q
 . Q
DIR ; *** Set up DIR(0) for sort from/to prompts
 S X=$P(SPNDD,U,2)
 G NUMERIC:X["N",POINTER:X["P",SET:X["S",DATE:X["D",TEXT
DATE S SPNTEXT(4)="DAO^::AETS^D DATE^SPNAHOC2" G SETLINE
NUMERIC S SPNTEXT(4)="NAO^-999999999:999999999:9^" G SETLINE
POINTER S SP=$P(SPNDD,U,2),SP=$TR(SP,$TR(SP,".0123456789"))
 S SPNTEXT(4)="PAO^"_SP_":AEMNQZ^D POINTER^SPNAHOC2" G SETLINE
SET S SPNTEXT(4)="SAOM^"_$P(SPNDD,U,3)_"^D SET^SPNAHOC2" G SETLINE
TEXT S SPNTEXT(4)="FAO^1:60^"
SETLINE ; *** Save menu $TEXT line in ^TMP
 F SP=1:1:SPNLEVEL S SPNTEXT(3)=SPNTEXT(3)_$S(SP=SPNLEVEL:"~",1:"")_$P(SPNFILE(SP),U,2)_$S(SP'=SPNLEVEL:",",1:$S(SPNTEXT(2)'=$P(SPNFILE(SP),U,3):";"""_$TR(SPNTEXT(2),",;^~","    ")_"""",1:""))
 S Y=8+$L(SPNTEXT(2))+$L(SPNTEXT(3))+$L(SPNTEXT(4))+$L(SPNTEXT(5))-245
 I Y>0 D  G FLD
 . W !!?5,"*** This line is ",Y," character",$S(Y>1:"s",1:"")
 . W " too long, maximum is 245 !! ***",$C(7)
 . Q
 S SPNMMAX=SPNMMAX+1,SPNCHOSN(SPNFILE(SPNLEVEL))=""
 S ^TMP($J,"SPNTXT",1000+SPNMMAX,0)=" ;;"_+SPNTEXT(1)_U_SPNTEXT(2)_U_SPNTEXT(3)_U_SPNTEXT(4)_"|"_SPNTEXT(5)
 G FLD
EXIT ; *** Exit field questions loop
 Q
LIST ; *** Display the fields already chosen
 N X
 W !!,"You have already selected the following:  (Menu Item #   Menu Text)",!
 S SPN=$Y,SPNMMAX(0)=SPNMMAX#2+SPNMMAX\2
 F SP=1001:1:SPNMMAX(0)+1000 D  Q:SPNQUIT
 . S SPI=SP,SPNTAB=0 D  S SPI=SP+SPNMMAX(0),SPNTAB=40 D
 .. S X=$P($G(^TMP($J,"SPNTXT",SPI,0)),";;",2,99)
 .. Q:X=""  W:SPNTAB=0 !
 .. W ?SPNTAB,$S($P(X,U):$J(SPI-1000,2),1:"  "),"   ",$P(X,U,2)
 .. Q
 . I ($Y>(IOSL+SPN-4))!(SPNMMAX(0)+1000=SP) D
 .. S SPN=$Y K DIR S DIR(0)="E" W ! D ^DIR K DIR S SPNQUIT=$S(Y'>0:1,1:0)
 .. Q
 . Q
 Q
CASE(SPN) ; *** Convert text to initial capital letters
 N X,SP S X=""
 F SP=1:1:$L(SPN) D
 . S X(0)=$E(SPN,SP-1),X(1)=$E(SPN,SP)
 . S X=X_$S(X(0)?.1P:$$U(X(1)),X(0)?1U:$$L(X(1)),X(1)?1U:$$L(X(1)),1:X(1))
 . Q
 Q X
U(X) Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
L(X) Q $TR(X,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
ID() ; *** DD identifiers
 N SPNDD,SPNERR,SPNID S SPNID=""
 D FIELD^DID(+SPNFILE(SPNLEVEL),+Y,"","SPECIFIER;TYPE","SPNDD","SPNERR")
 I $O(SPNERR(""))="" D
 . I SPNDD("SPECIFIER") S SPNID="(multiple)"
 . I SPNDD("TYPE")="WORD-PROCESSING" S SPNID="("_$$L(SPNDD("TYPE"))_")"
 . Q
 Q SPNID
