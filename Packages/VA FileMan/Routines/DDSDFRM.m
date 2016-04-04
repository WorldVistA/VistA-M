DDSDFRM ;SFISC/MKO-DELETE A FORM ;11:22 AM  4 Dec 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999**
 ;
 N %,DIC,DIOVRD,X,Y
 D INIT
 S (DDSDEL,DDSQUIT)=0
 ;
 S DDSFORM=$$FORM G:DDSFORM=-1 QUIT
 ;
 D GETBLKS
 D REPORT
 I $D(@DDSBLK) D ASKDEL G:DDSQUIT QUIT
 D ASKCONT G:DDSQUIT QUIT
 ;
 ;Delete form
 W !!,"Deleting form "_$P(DDSFORM,U,2)_" (IEN #"_+DDSFORM_") ..."
 S DIK="^DIST(.403,",DA=+DDSFORM
 D ^DIK K DIK,DA
 ;
 ;Delete blocks
 I DDSDEL D:'$G(DDSDEL(1)) DELPR D:$G(DDSDEL(1)) DELNPR
 W !!,"DONE!"
 D QUIT
 Q
 ;
EN(DDSFORM) ;Delete form number DDSFORM
 N %,DA,DDSB,DDSBLK,DIC,DIK,DIOVRD,X,Y
 I '$D(DIFM) N DIFM S DIFM=1 D INIZE^DIEFU
 D INIT
 D GETBLKS
 ;
 ;Delete form
 S DIK="^DIST(.403,",DA=+DDSFORM
 D ^DIK K DIK,DA
 ;
 ;Delete blocks
 S DIK="^DIST(.404,"
 S DDSB="" F  S DDSB=$O(@DDSBLK@(DDSB)) Q:DDSB=""  D
 . Q:$P(@DDSBLK@(DDSB),U,2)
 . S DA=DDSB D ^DIK
 ;
 K @DDSBLK
 Q
 ;
INIT ;Setup
 S DIOVRD=1
 S DDSBLK=$NA(^TMP("DDSDFRM",$J,"BLK"))
 K @DDSBLK
 Q
 ;
QUIT ;Cleanup
 K @DDSBLK
 K DDSBLK,DDSDEL,DDSFILE,DDSFORM,DDSQUIT
 K DDH,DIRUT,DIROUT,DTOUT,DUOUT
 Q
 ;
FORM() ;Prompt for form
 ;Select file
 N D,DIC
EGP S DDS1=8108.2 D W^DICRW K DDS1 G:Y<0 FORMQ ;**CCO/NI  'DELETE FORM'
 I '$D(@(DIC_"0)")) S Y=-1 G FORMQ
 S DDSFILE=Y
 ;
 ;Select form
 W ! K DIC
 S DIC="^DIST(.403,",DIC(0)="QEAM"
 S DIC(0)="QEA",D="F"_+DDSFILE
 S DIC("S")="I $P(^(0),U,8)=+DDSFILE"
 S DIC("A")="Select FORM to delete: "
 S DIC("W")=$P($T(DICW),";",3,999)
DICW ;;N %G S %G=^(0) W:$X>35 ! W ?35,"#"_Y N Y S Y=$P(%G,U,5) W:Y]"" ?43,$$OUT^DIALOGU(Y,"FMTE","2D") S Y=$P(%G,U,4) W:Y]"" ?53," User #"_Y S Y=$P(%G,U,8) W:Y]"" ?65," File #"_Y ;**CCO/NI   NICE DATE FORMAT
 D IX^DIC
 ;
FORMQ Q Y
 ;
GETBLKS ;Get all blocks on form
 ; @DDSBLK@(bk#)=Block name^flag (1=used on other forms)
 ;
 N P,B
 S P=0 F  S P=$O(^DIST(.403,+DDSFORM,40,P)) Q:'P  D
 . S B=$P(^DIST(.403,+DDSFORM,40,P,0),U,2)
 . I B]"",'$D(@DDSBLK@(B)) D
 .. S @DDSBLK@(B)=$P($G(^DIST(.404,B,0)),U)_U_$$COMMON(B,+DDSFORM)
 . S B=0
 . F  S B=$O(^DIST(.403,+DDSFORM,40,P,40,B)) Q:'B  D:'$D(@DDSBLK@(B))
 .. S @DDSBLK@(B)=$P($G(^DIST(.404,B,0)),U)_U_$$COMMON(B,+DDSFORM)
 Q
 ;
DELPR ;Delete blocks with prompting
 N DDSB
 W ! K DIK,DIR,DIRUT
 S DIR(0)="YA",DIR("B")="NO"
 S DIR("?")="  Enter 'Y' to delete, 'N' to keep."
 S DIK="^DIST(.404,"
 ;
 S DDSB=""
 F  S DDSB=$O(@DDSBLK@(DDSB)) Q:DDSB=""!DDSQUIT  D
 . Q:$P(@DDSBLK@(DDSB),U,2)
 . S DIR("A")=$P(@DDSBLK@(DDSB),U)_$J("",30-$L($P(@DDSBLK@(DDSB),U)))_"Delete (Y/N)? "
 . D ^DIR S:$D(DIRUT) DDSQUIT=1 Q:'Y
 . S DA=DDSB D ^DIK
 K DA,DIR,DIK,DIRUT,DTOUT,DUOUT,DIROUT
 Q
 ;
DELNPR ;Delete blocks without prompting
 N DDSB
 W ! K DIK
 S DIK="^DIST(.404,"
 S DDSB=""
 F  S DDSB=$O(@DDSBLK@(DDSB)) Q:DDSB=""  D
 . Q:$P(@DDSBLK@(DDSB),U,2)
 . W !,"Deleting block "_$P(@DDSBLK@(DDSB),U)_" (IEN #"_DDSB_") ..."
 . S DA=DDSB D ^DIK
 K DIK,DA
 Q
 ;
ASKDEL ;Ask if user wants to delete all the blocks on this form
 K DIR W ! S DIR(0)="YA",DIR("B")="YES"
 S DIR("A",1)=""
 S DIR("A",2)="Delete all deletable blocks used on form "_$P(DDSFORM,U,2)
 S DIR("A")="from the BLOCK file (Y/N)? "
 S DIR("?",1)="  Enter 'Y' to delete blocks used on form"
 S DIR("?",2)="    "_$P(DDSFORM,U,2)_" from the BLOCK file."
 S DIR("?",3)="    (Only blocks not used on other forms can be deleted.)"
 S DIR("?",4)=""
 S DIR("?")="  Enter 'N' to delete the form but not the blocks."
 D ^DIR K DIR I $D(DIRUT) S DDSQUIT=1 Q
 S DDSDEL=Y Q:'DDSDEL
 ;
 ;Ask if user wants to delete without prompting
 W ! S DIR(0)="YA",DIR("B")="NO"
 S DIR("A",1)=""
 S DIR("A")="Delete blocks without prompting (Y/N)? "
 S DIR("?",1)="  Enter 'Y' to delete blocks from the BLOCK file"
 S DIR("?",2)="    without confirmation."
 S DIR("?",3)=""
 S DIR("?")="  Enter 'N' to confirm each delete."
 D ^DIR K DIR I $D(DIRUT) S DDSQUIT=1 Q
 S DDSDEL(1)=Y
 Q
 ;
ASKCONT ;Final chance to abort
 K DIR S DIR(0)="YA",DIR("B")="NO"
 S DIR("A",1)=""
 S DIR("A")="Continue (Y/N)? "
 S DIR("?")="  Enter 'Y' to delete form.  Enter 'N' to exit."
 D ^DIR K DIR
 S:$D(DIRUT)!'Y DDSQUIT=1
 Q
 ;
REPORT ;Print report
 N B
 W !!! I '$D(@DDSBLK) W "There are no blocks on this form." Q
 W "  BLOCKS USED ON FORM """_$P(DDSFORM,U,2)_""" (IEN #"_+DDSFORM_")"
 W !!,"  Internal",?50,"Used on"
 W !,"  Entry Number   Block Name",?50,"Other Forms?   Deletable?"
 W !,"  ------------   ----------",?50,"------------   ----------"
 ;
 S B="" F  S B=$O(@DDSBLK@(B)) Q:B=""  D
 . W !,"  "_B,?17,$P(@DDSBLK@(B),U),?54
 . W $S($P(@DDSBLK@(B),U,2):"YES",1:"NO")
 . W ?68,$S($P(@DDSBLK@(B),U,2):"NO",1:"YES")
 Q
 ;
COMMON(B,F) ;Is block B found on forms other than F
 N C,F1
 S C=0,F1=""
 F  S F1=$O(^DIST(.403,"AB",B,F1)) Q:F1=""  I F1'=F S C=1 Q
 I 'C S F1="" F  S F1=$O(^DIST(.403,"AC",B,F1)) Q:F1=""  I F1'=F S C=1 Q
 Q C
