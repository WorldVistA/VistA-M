DDSCLONE ;SFISC/MKO-CLONE A FORM ;2OCT2003
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999,1003**
 ;
 N %,%CHK,%RET,%X,%Y,D,D0,D1,DA,DI,DIOVRD,DIC,DIR,DIZ,DQ,DREF,X,Y
 K ^TMP("DDSCLONE",$J)
 S DDSQUIT=0,DIOVRD=1
 ;
 S DDSFORM=$$FORM G:DDSFORM=-1 QUIT
 ;
 D GETBLKS
 D REPORT G:DDSQUIT QUIT
 D RENMSP G:DDSQUIT QUIT
 D RENAME G:DDSQUIT QUIT
 D ^DDSCLONF
DONE I '$G(DDSQUIT) W !!!,"DONE!"
 ;
QUIT ;Cleanup
 K ^TMP("DDSCLONE",$J)
 K DDSBK,DDSBKDA,DDSFILE,DDSFORM,DDSNFRM,DDSNNS,DDSONS,DDSQUIT
 K DDH,DIRUT,DIROUT,DTOUT,DUOUT
 Q
 ;
FORM() ;Prompt for form
 ;Select file
 N D,DIC
EGP S DDS1=8108 D W^DICRW K DDS1 G:Y<0 FORMQ ;**CCO/NI 'CLONE FORM'
 I '$D(@(DIC_"0)")) S Y=-1 G FORMQ
 S DDSFILE=Y
 ;
 ;Select form
 W ! K DIC
 S DIC="^DIST(.403,",DIC(0)="QEAM"
 S DIC(0)="QEA",D="F"_+DDSFILE
 S DIC("S")="I $P(^(0),U,8)=+DDSFILE"
 S DIC("A")="Select FORM to clone: "
 S DIC("W")=$P($T(DICW),";",3,999)
DICW ;;N %G S %G=^(0) W:$X>35 ! W ?35,"#"_Y N Y S Y=$P(%G,U,5) W:Y]"" ?43,$$OUT^DIALOGU(Y,"FMTE","2D") S Y=$P(%G,U,4) W:Y]"" ?53," User #"_Y S Y=$P(%G,U,8) W:Y]"" ?65," File #"_Y ;**CCO/NI NICE DATE OUTOUT
 D IX^DIC
 ;
FORMQ Q Y
 ;
GETBLKS ;Get all blocks on form
 ; ^TMP("DDSCLONE",$J,bk#)=Block name
 ;
 N B,P
 S P=0 F  S P=$O(^DIST(.403,+DDSFORM,40,P)) Q:'P  D
 . S B=$P(^DIST(.403,+DDSFORM,40,P,0),U,2)
 . I B]"",'$D(^TMP("DDSCLONE",$J,B)) D
 .. S ^TMP("DDSCLONE",$J,B)=$P($G(^DIST(.404,B,0)),U)
 . S B=0
 . F  S B=$O(^DIST(.403,+DDSFORM,40,P,40,B)) Q:'B  D
 .. Q:$D(^TMP("DDSCLONE",$J,B))
 .. S ^TMP("DDSCLONE",$J,B)=$P($G(^DIST(.404,B,0)),U)
 Q
 ;
REPORT ;Print report
 N B
 W !!!
 I '$D(^TMP("DDSCLONE",$J)) S DDSQUIT=1 W "There are no blocks on this form." Q
 ;
 W "  BLOCKS USED ON FORM """_$P(DDSFORM,U,2)_""" (IEN #"_+DDSFORM_")"
 W !!,"  Internal"
 W !,"  Entry Number   Block Name"
 W !,"  ------------   ----------"
 ;
 S B="" F  S B=$O(^TMP("DDSCLONE",$J,B)) Q:B=""  D
 . W !,"  "_B,?17,$P(^TMP("DDSCLONE",$J,B),U)
 ;
 K DIR
 S DIR(0)="E"
 W ! D ^DIR K DIR
 I $D(DIRUT) S DDSQUIT=1
 W !
 Q
 ;
RENMSP ;Prompt for new namespace
 W !!,"The new form and blocks must be given unique names.",!
 ;
 K DIR
 S DIR(0)="Y",DIR("B")="YES"
 S DIR("A",1)="Give the new form and blocks the same names as the original,"
 S DIR("A")="but a different namespace"
 S DIR("?",1)="   Answer 'YES' if the original form and blocks are namespaced, and you want"
 S DIR("?")="   the new forms and blocks to have a different namespace."
 D ^DIR K DIR
 I $D(DIRUT) S DDSQUIT=1 Q
 I 'Y K DDSONSP,DDSNNSP Q
 ;
 K DIR
 W !!
 S DIR(0)="FA^1:30"
 S DIR("A")="Original namespace: "
 S DIR("?")="   Enter the namespace of the original form and blocks"
 D ^DIR K DIR
 I $D(DIRUT) S DDSQUIT=1 Q
 S DDSONS=Y
 ;
 K DIR,X,Y
 S DIR(0)="FA^1:30"
 S DIR("A")="     New namespace: "
 S DIR("?")="   Enter the namespace of the new form and blocks"
 D ^DIR K DIR
 I $D(DIRUT) S DDSQUIT=1 Q
 S DDSNNS=Y
 K X,Y
 Q
 ;
RENAME ;Prompt for new names
 N DDSBK,DDSBKDA
 D:'$D(IOST) HOME^%ZIS
 W @IOF
 W "Enter names for the new form and blocks."
 ;
 D RENFORM Q:DDSQUIT
 ;
 W !
 S DDSBKDA=0
 F  S DDSBKDA=$O(^TMP("DDSCLONE",$J,DDSBKDA))  Q:'DDSBKDA!DDSQUIT  D
 . S DDSBK=^TMP("DDSCLONE",$J,DDSBKDA)
 . D RENBLK(.DDSBK) Q:DDSQUIT
 . S ^TMP("DDSCLONE",$J,DDSBKDA)=DDSBK
 . S ^TMP("DDSCLONE",$J,"B",$P(DDSBK,U,2))=""
 ;
 Q
 ;
RENFORM ;Rename the form
 N DDSANS,DDSCOD
 F  D  Q:DDSANS]""!DDSQUIT
 . W !!,"Original form name: "_$P(DDSFORM,U,2)
 . W !,"     New form name: "
 . D EN^DIR0($S($Y>IOSL:IOSL-1,1:$Y),$X,30,1,$$NAME($P(DDSFORM,U,2),$G(DDSONS),$G(DDSNNS)),30,"","","",.DDSANS,.DDSCOD)
 . ;
 . I $P(DDSCOD,U)="TO"!(DDSANS=U) S DDSQUIT=1 Q
 . I DDSANS?1."?" W !!,"  Enter the name of the new form." S DDSANS=""
 . Q:DDSANS=""
 . S X=DDSANS X $P(^DD(.403,.01,0),U,5,999)
 . I '$D(X) S DDSANS="" W !!,$C(7)_"  Invalid name." Q
 . I $D(^DIST(.403,"B",DDSANS)) D  Q
 .. S DDSANS=""
 .. W !!,$C(7)_"  Form with this name already exists."
 Q:DDSQUIT
 ;
 S $P(DDSFORM,U,3)=DDSANS
 Q
 ;
RENBLK(DDSBK) ;Rename the blocks
 N DDSANS,DDSCOD
 F  D  Q:DDSANS]""!DDSQUIT
 . W !!,"Original block name: "_$P(DDSBK,U)
 . W !,"     New block name: "
 . D EN^DIR0($S($Y>IOSL:IOSL-1,1:$Y),$X,30,1,$$NAME($P(DDSBK,U),$G(DDSONS),$G(DDSNNS)),30,"","","",.DDSANS,.DDSCOD)
 . ;
 . I $P(DDSCOD,U)="TO"!(DDSANS=U) S DDSQUIT=1 Q
 . I DDSANS?1."?" W !!,"  Enter the name of the new form." S DDSANS=""
 . Q:DDSANS=""
 . S X=DDSANS X $P(^DD(.404,.01,0),U,5,999)
 . I '$D(X) S DDSANS="" W !!,$C(7)_"  Invalid name." Q
 . D:$D(^DIST(.404,"B",DDSANS))!$D(^TMP("DDSCLONE",$J,"B",DDSANS))
 .. S DDSANS=""
 .. W !!,$C(7)_"  Block with this name already exists."
 Q:DDSQUIT
 ;
 S $P(DDSBK,U,2)=DDSANS
 Q
 ;
NAME(NAME,ONS,NNS) ;Replace old namespace with new
 I $G(ONS)=""!($G(NNS)="") Q NAME
 I $P(NAME,ONS)]"" Q NAME
 Q NNS_$E(NAME,$L(ONS)+1,999)
