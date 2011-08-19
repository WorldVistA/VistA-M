LEXDM4 ; ISL Default Misc - Files/User/Svc/Loc    ; 02-02-96
 ;;2.0;LEXICON UTILITY;**4**;Sep 23, 1996
 ;
DFI(LEXX) ; Select one application
 N D,DIC,DTOUT,DUOUT I $D(LEXX),LEXX'="" S X=LEXX,DIC(0)="QM"
 I '$D(LEXX) S DIC(0)="AQEM" W !
 S DIC("W")="W ?45,$P($G(^(5)),U,5)"
 S DIC="^LEXT(757.2,",DIC("S")="I +($P($G(^(5)),U,3))>0"
 S D="B^C^AN" S DIC("A")="Select application:  " D MIX^DIC1 K DIC
 S LEXX=$S(+Y>0:+Y,1:0)
 Q LEXX
FI(LEXX) ; Select one or more applications
FI2 W ! N LEXMAX,LEXI,LEXA,LEXAI,LEXAN,LEXC,LEXLEN
 K ^TMP("LEXIL",$J)
 S ^TMP("LEXIL",$J,0)=0
FIB ; Build the list of files/applications
 S (LEXAI,LEXC,LEXLEN)=0,(LEXAN,LEXA)=""
 F  S LEXA=$O(^LEXT(757.2,"ADEF",LEXA)) Q:LEXA=""  D
 . S LEXI=$O(^LEXT(757.2,"ADEF",LEXA,0))
 . S LEXAN=$P(^LEXT(757.2,LEXI,0),U,1)
 . Q:$D(^TMP("LEXIL",$J,"B",LEXAN))
 . S:$L(LEXAN)>LEXLEN LEXLEN=$L(LEXAN)
 . S LEXC=LEXC+1,^TMP("LEXIL",$J,LEXC)=LEXAN_U_LEXI,^TMP("LEXIL",$J,0)=^TMP("LEXIL",$J,0)+1,^TMP("LEXIL",$J,"B",LEXAN)=LEXC,^TMP("LEXIL",$J,"C",$$UP^XLFSTR(LEXAN))=LEXC
 I $D(LEXMGR) D  ; Pch 4
 . S LEXC=+($G(^TMP("LEXIL",$J,0)))+1
 . S ^TMP("LEXIL",$J,0)=LEXC,^TMP("LEXIL",$J,LEXC)="All of the Above"
 . S ^TMP("LEXIL",$J,"B","All of the Above")=LEXC,^TMP("LEXIL",$J,"C","ALL OF THE ABOVE")=LEXC
 . S:$L($G(^TMP("LEXIL",$J,LEXC)))>LEXLEN LEXLEN=$L($G(^TMP("LEXIL",$J,LEXC)))
FIP ; Prompt user
 G:'$D(^TMP("LEXIL",$J)) FIQ
 W !,"Applications"
FIL ; Display the list
 S LEXMAX=^TMP("LEXIL",$J,0)
 W ! F LEXI=1:1:^TMP("LEXIL",$J,0) W !,$J(LEXI,6),"   ",$E($P(^TMP("LEXIL",$J,LEXI),U,1),1,50)
 S LEXX=$$FIS G:LEXX="" FIQ S LEXX=+LEXX I '$D(LEXMGR),+LEXX>0,+LEXX<LEXMAX+1 S LEXX=$P(^TMP("LEXIL",$J,LEXX),U,2) G FIQ
 I $D(LEXMGR),+LEXX>0,+LEXX<LEXMAX D  G FIQ
 . S ^TMP("LEXMGR",$J,"FI",0)=1
 . S ^TMP("LEXMGR",$J,"FI",1)=$P(^TMP("LEXIL",$J,LEXX),U,2)_U_$S($P(^TMP("LEXIL",$J,LEXX),U,1)'[" (":$P(^TMP("LEXIL",$J,LEXX),U,1),1:$P($P(^TMP("LEXIL",$J,LEXX),U,1)," (",1))
 . S LEXX=$P(^TMP("LEXIL",$J,LEXX),U,2)
 I $D(LEXMGR),LEXX=LEXMAX S LEXX="" D  G FIQ
 . F LEXI=1:1:^TMP("LEXIL",$J,0) D
 . . S ^TMP("LEXMGR",$J,"FI",LEXI)=$P(^TMP("LEXIL",$J,LEXI),U,2)_U_$S($P(^TMP("LEXIL",$J,LEXI),U,1)'[" (":$P(^TMP("LEXIL",$J,LEXI),U,1),1:$P($P(^TMP("LEXIL",$J,LEXI),U,1)," (",1))
 . . S LEXX=LEXX_";"_$P(^TMP("LEXIL",$J,LEXI),U,2)
 . . S ^TMP("LEXMGR",$J,"FI",0)=LEXI
 . F  Q:$E(LEXX,1)'=";"  S LEXX=$E(LEXX,2,$L(LEXX))
 . F  Q:$E(LEXX,$L(LEXX))'=";"  S LEXX=$E(LEXX,1,($L(LEXX)-1))
 G FIP Q
FIS(X) ; Select from the list
 W ! N Y,DIR,DIC,DTOUT,DUOUT,DIRUT,DIROUT
 S LEXLEN=+($G(LEXLEN)) S:LEXLEN=0 LEXLEN=15
 S DIR("A")="Select (1-"_LEXMAX_"):  "
 S DIR("?")="^D FIHLP^LEXDM4"
 S DIR(0)="FAO^1:"_LEXLEN_"^S X=+($$FIW^LEXDM4(X)) K:'X X"  ; PCH 4
 D ^DIR S:$D(DTOUT)!($D(DUOUT)) X="" S:$L(X) X=$$FIW(X) Q X  ; PCH 4
FIHLP ; Help for selection
 I $D(LEXMGR) D
 . W !!,"User defaults for both the Lexicon and applications using the Lexicon"
 . W !,"(by agreement) will be stored along with their application definitions"
 . W !,"contained in the Subset Definition File."
 . W !!,"You may set user defaults for one or all of the listed applications"
 I '$D(LEXMGR) D
 . W !!,"User defaults for the Lexicon may be set for individual applications."
 . W !!!,"Select an application:"
 S LEXMAX=^TMP("LEXIL",$J,0) S:$D(LEXMGR) LEXMAX=LEXMAX+1
 W ! F LEXI=1:1:^TMP("LEXIL",$J,0) D
 . W !,$J(LEXI,6),"   ",$E($P(^TMP("LEXIL",$J,LEXI),U,1),1,50)
 Q
FIQ ; Quit application selection
 K ^TMP("LEXIL",$J),^TMP("LEXMGR",$J)
 K LEXA,LEXAI,LEXAN,LEXC,LEXI,LEXMAX
 Q LEXX
FIW(LEXX) ; Input transform for DIR  Pch 4
 S LEXX=$G(LEXX) S:$G(LEXX)["^" LEXX="^" Q:LEXX["^" LEXX Q:$G(LEXX)="" ""
 I +($G(LEXX))>0,$D(^TMP("LEXIL",$J,+($G(LEXX)))) S LEXX=+($G(LEXX)) Q LEXX
 N LEXU,LEXO,LEXOC,LEXCT S LEXU=$TR($G(LEXX),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ") Q:'$L(LEXU) LEXX
 S LEXCT=0,(LEXO,LEXOC)=$E(LEXU,1,($L(LEXU)-1))_$C($A($E(LEXU,$L(LEXU)))-1)_"~"
 F  S LEXOC=$O(^TMP("LEXIL",$J,"C",LEXOC)) Q:LEXOC=""!($E(LEXOC,1,$L(LEXU))'=LEXU)  S LEXCT=LEXCT+1
 S LEXOC="" I LEXCT=1 S LEXOC=$O(^TMP("LEXIL",$J,"C",LEXO)),LEXOC=+($G(^TMP("LEXIL",$J,"C",LEXOC)))
 I +LEXOC>0,$D(^TMP("LEXIL",$J,+LEXOC)) S LEXX=+LEXOC Q LEXX
 Q ""
SERV(LEXX) ; Select a service
 S DIC="^DIC(49,",DIC("A")="Select users by service:  ",DIC(0)="AMEQ"
 N LEXI S LEXI="" F  S LEXI=$O(^DIC(49,"B",LEXI)) Q:LEXI=""  D  Q:LEXI=""
 . I LEXI["MEDI",((LEXI["GEN")!(LEXI["INTER")) S ^TMP("LEXSERV",$J,1)=$O(^DIC(49,"B",LEXI,0))
 . I LEXI["AMBULAT" S ^TMP("LEXSERV",$J,2)=$O(^DIC(49,"B",LEXI,0))
 . I LEXI["OUT",LEXI["PAT" S ^TMP("LEXSERV",$J,2)=$O(^DIC(49,"B",LEXI,0))
 I $D(^TMP("LEXSERV",$J,1)) S DIC("B")=$P(^DIC(49,^TMP("LEXSERV",$J,1),0),U,1) K ^TMP("LEXSERV",$J)
 I $D(^TMP("LEXSERV",$J,2)) S DIC("B")=$P(^DIC(49,^TMP("LEXSERV",$J,2),0),U,1)
 K ^TMP("LEXSERV",$J) D ^DIC S LEXX=Y W:+Y'>0 "  No Service Selected"
 S:X["^" LEXX="^" S:X["^^" LEXX="^^" K LEXI,Y,X,DIC,DIC("A"),DIC(0),DIC("B")
 S:LEXX'[U&(+LEXX'>0) LEXX=""
 Q LEXX
LOC(LEXX) ; Select a Hospital Location
 S DIC="^SC(",DIC("A")="Select users by Hospital Location:  ",DIC(0)="AMEQ"
 D ^DIC S LEXX=Y W:+Y'>0 "  No Location Selected"
 S:X["^" LEXX="^" S:X["^^" LEXX="^^" K Y,X,DIC,DIC("A"),DIC(0),DIC("B")
 S:LEXX'[U&(+LEXX'>0) LEXX=""
 Q LEXX
USER(LEXX) ; Select a single user
 K DIC N X,Y S DIC="^VA(200,",DIC("A")="Select a single user:  ",DIC(0)="AMEQ"
 D ^DIC S LEXX=Y W:+Y'>0 "  No User Selected"
 S:X["^" LEXX="^" S:X["^^" LEXX="^^" K Y,X,DIC,DIC("A"),DIC(0),DIC("B")
 S:LEXX'[U&(+LEXX'>0) LEXX=""
 Q LEXX
