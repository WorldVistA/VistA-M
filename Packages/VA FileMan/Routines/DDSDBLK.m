DDSDBLK ;SFISC/MKO-DELETE UNUSED BLOCKS ;01:25 PM  11 Oct 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999**
 ;
 N %,D,DIAC,DIC,DIFILE,DIOVRD,X,Y
 D INIT
 S DDSFILE=$$FILE G:DDSFILE=-1 QUIT
 D SUB(+DDSFILE,DDSSUB),FINDB(DDSSUB,DDSBLK),PROC,QUIT
 Q
 ;
ALL ;Purge all unused blocks regardless of file
 N %,DIC,DIOVRD,X,Y
 K DDSFILE
 D INIT,FINDALL(DDSBLK),PROC,QUIT
 Q
 ;
PROC ;Delete blocks in @DDSBLK
 I '$D(@DDSBLK) D  Q
 . W !!!,"There are no unused blocks associated with this file."
 ;
 D REPORT
 D ASKDEL Q:DDSQUIT
 D ASKCONT Q:DDSQUIT
 ;
 ;Delete blocks
 D:$G(DDSDEL) DELNPR
 D:'$G(DDSDEL) DELPR
 W !!,"DONE!"
 Q
 ;
INIT ;Initialize variables
 S (DDSDEL,DDSQUIT)=0,DIOVRD=1
 S DDSBLK=$NA(^TMP("DDSDBLK",$J,"BLK"))
 S DDSSUB=$NA(^TMP("DDSDBLK",$J,"SUB"))
 K @DDSBLK,@DDSSUB
 Q
 ;
QUIT ;Cleanup
 K @DDSBLK,@DDSSUB
 K DDSBLK,DDSDEL,DDSFILE,DDSQUIT,DDSSUB
 K DDH,DIRUT,DIROUT,DTOUT,DUOUT
 Q
 ;
FINDB(DDSSUB,DDSBLK) ;Find blocks associated with a specific file
 N B,B0,N
 S B=0 F  S B=$O(^DIST(.404,B)) Q:'B  S B0=$G(^(B,0)) D
 . S N=$P(B0,U,2)
 . I N,$D(@DDSSUB@(N)),'$D(^DIST(.403,"AB",B)),'$D(^DIST(.403,"AC",B)) S @DDSBLK@(B)=$P(B0,U)
 Q
 ;
FINDALL(DDSBLK) ;Find all unused blocks
 N B,B0
 S B=0 F  S B=$O(^DIST(.404,B)) Q:'B  S B0=$G(^(B,0)) D
 . I '$D(^DIST(.403,"AB",B)),'$D(^DIST(.403,"AC",B)) D
 .. S @DDSBLK@(B)=$P(B0,U)
 Q
 ;
FILE() ;Prompt for form
 ;Select file
 N DIC,Y
EGP S DDS1=8108.1 D W^DICRW K DDS1 G:Y<0 FILEQ ;**CCO/NI  'PURGE UNUSED BLOCKS'
 S:'$D(@(DIC_"0)")) Y=-1
FILEQ Q Y
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
 . W !,"Deleting block "_$P(@DDSBLK@(DDSB),U)_" (IEN #"_DDSB_") ..."
 . S DA=DDSB D ^DIK
 K DIK,DA
 Q
 ;
ASKDEL ;Ask if user wants to delete all unused blocks w/o confirmation
 W ! S DIR(0)="YA",DIR("B")="NO"
 S DIR("A",1)=""
 S DIR("A")="Delete all unused blocks without prompting (Y/N)? "
 S DIR("?",1)="  Enter 'Y' to delete unused blocks from the BLOCK file"
 S DIR("?",2)="    without confirmation."
 S DIR("?",3)=""
 S DIR("?")="  Enter 'N' to confirm each delete."
 D ^DIR K DIR I $D(DIRUT) S DDSQUIT=1 Q
 S DDSDEL=Y
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
 W !!!
 W "  UNUSED BLOCKS"
 W:$D(DDSFILE) " ASSOCIATED WITH FILE "_$P(DDSFILE,U,2)_" (#"_$P(DDSFILE,U)_")"
 W !!,"  Internal"
 W !,"  Entry Number   Block Name"
 W !,"  ------------   ----------"
 ;
 S B="" F  S B=$O(@DDSBLK@(B)) Q:B=""  W !,"  "_B,?17,@DDSBLK@(B)
 Q
 ;
SUB(FN,OUT) ;
 ;Set OUT array for file number FN and all its subfiles
 N SUB
 I $D(^DD(FN)) S @OUT@(FN)=""
 S SUB="" F  S SUB=$O(^DD(FN,"SB",SUB)) Q:SUB=""  D SUB(SUB,OUT)
 Q
