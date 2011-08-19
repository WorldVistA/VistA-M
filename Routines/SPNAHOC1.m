SPNAHOC1 ;HISC/DAD-AD HOC REPORTS: SORT/PRINT SELECTION ;9/9/96  14:03
 ;;2.0;Spinal Cord Dysfunction;**14,15**;01/02/1997
 ;
ENASK ; *** Prompt user for sort/print fields
 S SPNNEXT=0 I SPNSEQ>SPNMAXOP(SPNTYPE) D  Q
 . W !!?3,"Maximum of ",SPNMAXOP(SPNTYPE)," ",SPNTYPE(0)
 . W " fields reached. ",$C(7) R SP:SPNDTIME S SPNNEXT=1
 . Q
 D LIST
 W !!?3,SPNTYPE(1)," selection # ",SPNSEQ," : "
 R SPNSELOP:DTIME S:'$T SPNSELOP=U I SPNSELOP="^" K J,X,I,SPNARPT
 I (SPNSEQ=1)&(SPNSELOP="") D  G:SPNNONE=2 ENASK Q:SPNNEXT
 . F  D  Q:%
 .. S SPNNONE=2
 .. W $C(7),!!?3,"You have not selected any "
 .. W $S(SPNNUMOP("S")'>0:"sort or ",1:""),"print categories !!"
 .. W !?3,"Do you wish to exit the program"
 .. S %=1 D YN^DICN S SPNNONE=% I '% W !!?5,SPNYESNO
 .. Q
 . Q:SPNNONE=2
 . S (SPNNEXT,SPNQUIT)=1 W !!?3,"No report will be produced." K J,X,I,SPNARPT
 . Q:(SPNNONE=-1)!(SPNMOUTP'>0)
 . F  D  Q:%
 .. W !!?3,"You previously asked for macro output, do you still want it"
 .. S %=2 D YN^DICN I '% W !!?5,SPNYESNO
 .. Q
 . D:%=1 EN2^SPNAHOC4
 . Q
 S:SPNSELOP="" SPNNEXT=1 S:$E(SPNSELOP)=U (SPNNEXT,SPNQUIT)=1
 Q:SPNNEXT!SPNQUIT
 I $E(SPNSELOP)="[" D  Q:SPNNEXT  G:SPNMLOAD'>0 ENASK S SPNNEXT=1 Q
 . D ^SPNAHOC3,HELP:SPNSELOP=-1
 . Q
 I SPNSELOP["," D  S SPNNEXT='SPNAGIN Q:SPNNEXT  G ENASK
 . S SPNAGIN=0,SPNLIST=SPNSELOP
 . I SPNSEQ>1 D  S SPNAGIN=1 Q
 .. W !!?3,SPNTYPE(1)," lists may only be entered at the"
 .. W " first ",SPNTYPE(0)," selection prompt !! ",$C(7) R SP:SPNDTIME
 .. Q
 . I $L(SPNLIST,",")>SPNMAXOP(SPNTYPE) D  S SPNAGIN=1 Q
 .. W !!?3,"Too many ",SPNTYPE(0)," fields chosen !! ",$C(7) R SP:SPNDTIME
 .. Q
 . F SPNLST=1:1:$L(SPNSELOP,",") D  Q:SPNAGIN
 .. S SPNSELOP=$P(SPNLIST,",",SPNLST),SPNSEQ=SPNLST D CHECK
 .. Q
 . S SPNSEQ=SPNSEQ+1 Q:'SPNAGIN
 . I SPNTYPE="S" K FR,TO
 . K SPNCHOSN,SPNOPTN(SPNTYPE) S SPNSEQ=1
 . Q
 S (SPNAGIN,SPNLST)=0 D CHECK G:SPNAGIN ENASK
 Q
CHECK ; *** Check user's input
 S SPNPREFX(0)=$S(SPNTYPE="S":"+-!#@'",1:"&!+#") D FIX^SPNAHOC2
 S SPNPREFX(SPNTYPE,SPNSEQ)=SPNPREFX,SPNSUFFX(SPNTYPE,SPNSEQ)=SPNSUFFX
 I SPNTYPE="P",$L(SPNPREFX)>1 S (SPNSELOP,SPNPREFX)=""
 I SPNLST'>0 W "   ",$P($G(SPNMENU(+SPNSELOP)),U,2)
 E  W:SPNTYPE="S" !!?3,"Sort by: ",$P($G(SPNMENU(+SPNSELOP)),U,2)
 I $S(SPNSELOP<1:1,SPNSELOP>SPNMMAX:1,SPNSELOP'?1.N:1,$D(SPNMENU(SPNSELOP))[0:1,1:0) D HELP S SPNAGIN=1 Q
 I $D(SPNCHOSN(SPNSELOP))#2 D  S SPNAGIN=1 Q
 . W $C(7),!!?3,"You have already chosen item ",SPNSELOP,", "
 . W $P(SPNMENU(SPNSELOP),U,2),",",!?3,"as a ",SPNTYPE(0)," field !!  "
 . W "Please re-enter your selection. " R SP:SPNDTIME
 . Q
 I SPNTYPE="S",SPNMENU(SPNSELOP)'>0 D  Q
 . W !!?3,"You are not allowed to sort by "
 . W $P(SPNMENU(SPNSELOP),U,2)," !! ",$C(7)
 . R SP:SPNDTIME S SPNAGIN=1
 . Q
 I SPNTYPE="S" D  Q:SPNAGIN
 . S SPNDIR(0)=$P($P(SPNMENU(SPNSELOP),U,4,99),"|")
 . S SPNDIR("S")=$P(SPNMENU(SPNSELOP),"|",2)
 . D ^SPNAHOC2 I SPNQUIT!SPNNEXT S (SPNQUIT,SPNNEXT)=0 S SPNAGIN=1
 . Q
 S X=$P(SPNMENU(SPNSELOP),U,3),X=$P(X,"~")_SPNPREFX_$P(X,"~",2)
 S X(0)=$P(X,";"),X(1)=$P($P(X,";"""),";",2,99),X("T")=$P(X,";""",2)
 S SPNSUFFX(1)=$P(SPNSUFFX,";"""),SPNSUFFX("T")=$P(SPNSUFFX,";""",2)
 S SPN=X(0)_$S(SPNSUFFX(1)]"":SPNSUFFX(1),X(1)]"":";"_X(1),1:"")
 S X=SPN_$S(SPNSUFFX("T")]"":";"""_SPNSUFFX("T"),X("T")]"":";"""_X("T"),1:"")
 S SPNOPTN(SPNTYPE,SPNSEQ,SPNSELOP)=X,SPNCHOSN(SPNSELOP)=$C(96+SPNSEQ)
 Q
LIST ; *** Display the sort/print menus
 W @IOF
 I $G(SPNMHDR)'="@" D
 . S X=$S($G(SPNMHDR)]"":$E(SPNMHDR,1,45)_" ",1:"")
 . S X=X_"Ad Hoc Report Generator"
 . S Y="",$P(Y,"=",70-$L(X)/2)=""
 . W "  ",Y," ",X," ",Y,!
 . Q
 S Y=1,SPN=$Y,SPNMMAX(0)=SPNMMAX#2+SPNMMAX\3+1
 F SP=1:1:SPNMMAX(0) D  Q:Y'>0
 . S SPI=SP,SPNTAB=0 D  S SPI=SP+SPNMMAX(0),SPNTAB=24 D  S SPI=SPI+SPNMMAX(0),SPNTAB=50 D
 .. Q:$D(SPNMENU(SPI))[0
 .. W:SPNTAB=0 ! W ?SPNTAB,$S(SPNTYPE="P"!SPNMENU(SPI):$J(SPI,2),1:"  ")
 .. W $S($D(SPNCHOSN(SPI)):SPNCHOSN(SPI),1:" ")
 .. W $E($P(SPNMENU(SPI),U,2),1,26)
 .. Q
 . I $Y>(IOSL+SPN-3) S SPN=$Y K DIR S DIR(0)="E" D ^DIR K DIR
 . Q
 Q
 ; changed to make room for three new fields (IOSL+SPN-3) was -4
HELP ; *** Display the sort/print help screens
 I $E(SPNSELOP)'="?" W " ??",$C(7),!
 E  W @IOF
 W !,"Select the ",$S(SPNSEQ=1:$S(SPNTYPE="S":"major",1:"first"),1:"next")
 W " data element to ",$S(SPNTYPE="S":"sort by",1:"print")
 W ".  Maximum of ",SPNMAXOP(SPNTYPE)," ",SPNTYPE(0)," fields allowed."
 W !,SPNBLURB,$S(SPNSEQ>1:", 'abc' indicates order chosen",1:""),".",!
 D:$E(SPNSELOP)="?" EN^SPNAHOCH($S(SPNTYPE="S":"H1",1:"H2"))
 R SP:(2*SPNDTIME)
 Q
