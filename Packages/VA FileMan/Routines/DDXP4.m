DDXP4 ;SFISC/DPC,S0-EXPORT DATA ;7:37 AM  30 May 2000
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**9,38**
 ;
EN1 ;
 K ^UTILITY($J)
 D ^DICRW I Y=-1 G QUIT
 S DDXPFINO=+Y
XTEM ;
 S DIC="^DIPT(",DIC(0)="QEASZ",DIC("A")="Choose an EXPORT template or '^' to Quit: ",DIC("S")="I $P(^(0),U,8)=3",D="F"_DDXPFINO W !
 D IX^DIC K DIC,D I $D(DTOUT)!$D(DUOUT) G QUIT
 I Y=-1 G XTEM
 S DDXPXTNO=+Y,DDXPXTNM=$P(Y,U,2),FLDS="["_DDXPXTNM_"]"
 I DUZ(0)[$E($P(Y(0),U,6),1)!(DUZ(0)="@") D  I $D(DIRUT) G QUIT
 . W !,"Do you want to delete the "_DDXPXTNM_" template",!,"after the data export is complete?",!
 . S DDXPTMDL=0,DIR(0)="Y",DIR("B")="NO" D ^DIR K DIR W !
 . S:Y DDXPTMDL=1
 S DDXPFFNO=+$G(^DIPT(DDXPXTNO,105)),DDXPFMZO=$G(^DIST(.44,DDXPFFNO,0))
 I $G(^DIST(.44,DDXPFFNO,6))]"" S DDXPDATE=1
 S DDXPATH=$P($G(^DIPT(DDXPXTNO,105)),U,4) I DDXPATH]"" D MULTBY
SORS ;
 W ! S DIR(0)="YA",DIR("B")="NO",DIR("A")="Do you want to SEARCH for entries to be exported? "
 S DIR("?",1)="To use VA FileMan's SEARCH option to choose entries, answer 'YES'."
 S:'$D(BY) DIR("?",2)="After the SEARCH, you can respond to VA FileMan's 'SORT BY:' prompt."
 S DIR("?")="If you answer 'NO', "_$S('$D(BY):"you can only SORT entries before export.",1:"the data export will begin.")
 D ^DIR K DIR I $D(DIRUT) G QUIT
 S DDXPSORS=Y,DIC=DDXPFINO,L=0
 D DIOBEG,DIOEND
 I DDXPSORS D EN^DIS
 I $G(X)="^"!($G(POP)) G QUIT
 I 'DDXPSORS D EN1^DIP
 I $G(X)="^"!($G(POP)) G QUIT
 I $G(DDXPQ),$G(DDXPTMDL) W !,?5,"Export template "_DDXPXTNM_" will be deleted",!,?5,"when queued export is completed." G DONE
 I $G(DDXPTMDL) S DIK="^DIPT(",DA=DDXPXTNO D ^DIK K DIK,DA
 G DONE
QUIT ;
 W !!,?10,"Export NOT completed!"
DONE ;
 K DDXPFINO,DDXPSORS,DDXPIOM,DDXPIOSL,DDXPXTNO,DDXPXTNM,DDXPFFNO,DDXPFMZO,DDXPCUSR,DDXPDATE,DDXPTMDL,DDXPY,DDXPATH,L,Y,DTOUT,DUOUT,DIRUT,DIC,FLDS,BY,FR,DIOEND,DIOBEG,DDXPQ,X,POP
 Q
ZIS ;
 S %ZIS="Q"
 S DDXPIOM=$S($P(DDXPFMZO,U,8):$P(DDXPFMZO,U,8),$G(^DIPT(DDXPXTNO,"IOM")):^("IOM"),1:80)
 S DDXPIOSL=99999
 Q
MULTBY ;
 N NUMPC,I,C S BY="",C=",",NUMPC=$L(DDXPATH,C)
 W !!,"Since you are exporting fields from multiples,"
 W !,"a sort will be done automatically."
 W !,"You will NOT have the opportunity to sort the data before export.",!
 F I=1:1:NUMPC D
 . S BY=BY_DDXPATH_",NUMBER,"
 . S DDXPATH=$P(DDXPATH,C,1,$L(DDXPATH,C)-1)
 . Q
 S BY=$E(BY,1,$L(BY)-1),FR=""
 Q
DIOBEG ;
 S DDXPBEG=$G(^DIST(.44,DDXPFFNO,1))
 I DDXPBEG']"" G QBEG
 I $E(DDXPBEG)="""" S DIOBEG="W "_DDXPBEG G QBEG
 S DIOBEG=DDXPBEG
QBEG K DDXPBEG
 Q
DIOEND ;
 S DDXPEND=$G(^DIST(.44,DDXPFFNO,2))
 I DDXPEND']"" G QEND
 I $E(DDXPEND)="""" S DIOEND="W "_DDXPEND G QEND
 S DIOEND=DDXPEND
QEND K DDXPEND
 Q
DJTOPY(Y) ;
 N BJ,EJ,YOUT,NUMW,TYPEJ,DDXPXORY,SUB S YOUT=Y
 S BJ=$F(Y,"$J(") I BJ D
 . S DDXPXORY=$P($E(Y,BJ,999),",",1)
 . S NUMW=$L($E(Y,1,BJ),"W")-1 I NUMW'>0 Q
 . S EJ=$F(Y,") ",BJ)
 . S TYPEJ=$L($E(Y,BJ,$S(EJ:EJ-1,1:999)),",")
 . I TYPEJ'=2&(TYPEJ'=3) Q
 . I TYPEJ=3 S SUB="$S("_DDXPXORY_"]"""":+"_DDXPXORY_",1:"""_$P(DDXPFMZO,U,13)_""")"
 . I TYPEJ=2 S SUB=DDXPXORY
 . S YOUT=$P($E(Y,1,BJ),"W",1,NUMW)_"W "_SUB_$S(EJ:$E(Y,EJ-1,999),1:"")
 . Q
 Q YOUT
DT ;
 N X
 I 'Y S DDXPY=Y Q
 S X=Y
 I $D(^DIST(.44,DDXPFFNO,6)) X ^(6) S DDXPY=$G(Y)
 Q
EN2 ; Export API from EXPORT^DDXP
 N DDXP,DDXPXTNO,DDPXFFNO,DDXPFMZO,DDXPDATE,DDXPATH,DDXPOUT,ERROR,DIA
 K ^UTILITY($J)
 ; Check for valild file number
 I '$G(DDXPFINO) S ERROR="File Number Missing." D EN2ERR G DONE
 I DDXPFINO[U D  I $D(DDXPOUT) K DDXPOUT G DONE
 . I $P(DDXPFINO,U)'=1.1 S DDXPOUT=1,ERROR="You can only use the "","" syntax if doing an Export of the Audit File(1.1)" D EN2ERR Q
 . I '$D(^DIC(+$P(DDXPFINO,U,2),0))#2 S DDXPOUT=1,ERROR="File Does Not Exist on This System." D EN2ERR Q
 I DDXPFINO'[U,'$D(^DIC(+DDXPFINO,0))#2 S ERROR="File Does Not Exist on This System." D EN2ERR G DONE
 N DIC,D,X
 S DIC="^DIPT(",DIC(0)="SZ",DIC("S")="I $P(^(0),U,8)=3",D="F"_+DDXPFINO,X=DDXPXTNM
 D IX^DIC K DIC
 I Y<0 S ERROR="The Template is Not an Export Template or Is Missing." D EN2ERR G DONE
 S DDXPXTNO=+Y
 S DDXPFFNO=+$G(^DIPT(DDXPXTNO,105)),DDXPFMZO=$G(^DIST(.44,DDXPFFNO,0))
 I $G(^DIST(.44,DDXPFFNO,6))]"" S DDXPDATE=1
 I $G(DDXPBY)="" S DDXPATH=$P($G(^DIPT(DDXPXTNO,105)),U,4) I DDXPATH]"" D MULTBY
 ; Setup For Sort Template If BY NOT Setup by MULTBY
 I '$D(BY) D  I $D(DDXPOUT) K DDXPOUT S ERROR="Sort Template Invalid or Missing." D EN2ERR G DONE
 . I $G(DDXPBY)]"" D  Q:$D(DDXPOUT)
 .. N DIC,X
 .. S DIC="^DIBT(",DIC(0)="Z",X=DDXPBY
 .. D ^DIC K DIC
 .. I Y<0 S DDXPOUT=1 Q
 .. D SORTCHK I $D(DDXPOUT) Q
 .. S BY="["_DDXPBY_"]"
 S DDXP=4 ; Tell other FileMan routines we are Exporting
 S DIC=$S(+DDXPFINO=1.1:"^DIA("_+$P(DDXPFINO,U,2)_",",1:+DDXPFINO)
 S L=0
 S FLDS="["_DDXPXTNM_"]"
 D DIOBEG,DIOEND,EN1^DIP
 I $G(X)="^"!($G(POP)) K DDXP,DDXPBY,DDXPFR,DDXPTO G QUIT
 K:$D(DIA) DIA ; **Leaking Variable**
 I $G(DDXPTMDL) S DIK="^DIPT(",DA=DDXPXTNO D ^DIK K DIK,DA
 K DDXP,DDXPBY,DDXPFR,DDXPTO
 G DONE
SORTCHK ; Check Sort For Illegal Qualifiers
 N D0,D1,DDXPX,I
 S D0=+Y
 S D1=0
 F  S D1=$O(^DIBT(D0,2,D1)) Q:D1<1!$D(DDXPOUT)  D
 . S DDXPX=^DIBT(D0,2,D1,0)
 . F I="#","!","+","@" D  Q:$D(DDXPOUT)
 .. I $P(DDXPX,U,4)[I,I'="@" S DDXPOUT=1,ERROR="You can not use the """_I_""" when exporting." D EN2ERR Q
 .. I I="@",$P(DDXPX,U,4)["@",$P(DDXPX,U,4)'["@B" S DDXPOUT=1,ERROR="You can not use the ""@"" when exporting." D EN2ERR Q
 . F I=";C",";S" D  Q:$D(DDXPOUT)
 .. I $P(DDXPX,U,5)[I S DDXPOUT=1,ERROR="You can not use "_I_" when exporting." D EN2ERR Q
 .. I $P(DDXPX,U,5)[";""" S DDXPOUT=1,ERROR="You can Replace a Caption when exporting." D EN2ERR Q
 Q
EN2ERR ; Error Processing
 I $D(IOST),$E(IOST,1,2)="C-" W $C(7)
 W "=>"_ERROR,!
 K DDXPBY,DDXPFR,DDXPTO,ERROR
 Q
