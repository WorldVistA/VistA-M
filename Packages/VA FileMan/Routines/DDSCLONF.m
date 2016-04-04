DDSCLONF ;SFISC/MKO-CLONE A FORM ;15OCT2003
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 D ASKCONT Q:DDSQUIT
 D CREATBK Q:DDSQUIT
 D CREATFM Q:DDSQUIT
 D EDITFM
 D INDEXFM
 K DDSNFRM
 Q
 ;
CREATBK ;Create blocks
 N DA,DIC
 W !!,"Creating new blocks ...",!
 S DDSBKDA=0
 F  S DDSBKDA=$O(^TMP("DDSCLONE",$J,DDSBKDA)) Q:'DDSBKDA!DDSQUIT  D
 . S DDSBK=^TMP("DDSCLONE",$J,DDSBKDA)
 . W !?2,$P(DDSBK,U,2)
 . K DIC,DD,DO
 . S DIC="^DIST(.404,",DIC(0)="QL",X=$P(DDSBK,U,2)
 . D FILE^DICN K DIC
 . I Y=-1 D  Q
 .. W !,$C(7)_"Attempt to create block "_$P(DDSBK,U,2)_" failed."
 .. S DDSQUIT=1
 . M ^DIST(.404,+Y)=^DIST(.404,DDSBKDA)
 . S $P(^DIST(.404,+Y,0),U)=$P(DDSBK,U,2)
 . W ?35,"#"_+Y
 . S $P(^TMP("DDSCLONE",$J,DDSBKDA),U,3)=+Y
 Q
 ;
CREATFM ;Create form
 N DA,DIC,DDSI,DDSJ
 W !!,"Creating new form ..."
 W !?2,$P(DDSFORM,U,3)
 K DIC
 S DIC="^DIST(.403,",DIC(0)="QL",X=$P(DDSFORM,U,3)
 D FILE^DICN K DIC
 I Y=-1 D  Q
 . W !,$C(7)_"Attempt to create form "_$P(DDSFORM,U,3)_" failed."
 . S DDSQUIT=1
 M ^DIST(.403,+Y)=^DIST(.403,+DDSFORM)
 S $P(^DIST(.403,+Y,0),U,5)=DT ;GFT  CREATE DATE IS TODAY!
 ;
 ;Kill page and block multiple indexes
 S DDSJ=" " F  S DDSJ=$O(^DIST(.403,+Y,40,DDSJ)) Q:DDSJ=""  D
 . K ^DIST(.403,+Y,40,DDSJ)
 S DDSI=0 F  S DDSI=$O(^DIST(.403,+Y,40,DDSI)) Q:'DDSI  D
 . S DDSJ=" "
 . F  S DDSJ=$O(^DIST(.403,+Y,40,DDSI,40,DDSJ)) Q:DDSJ=""  D
 .. K ^DIST(.403,+Y,40,DDSI,40,DDSJ)
 K @$$REF^DDS0(+Y)
 ;
 S $P(^DIST(.403,+Y,0),U)=$P(DDSFORM,U,3)
 W ?35,"#"_+Y
 S DDSNFRM=+Y
 Q
 ;
EDITFM ;Edit blocks used on new form
 W !!,"Repointing to new blocks ..."
 N DDSBK,DDSNBK,DDSPG
 S DDSPG=0 F  S DDSPG=$O(^DIST(.403,DDSNFRM,40,DDSPG)) Q:'DDSPG  D
 . S DDSBK=$P(^DIST(.403,DDSNFRM,40,DDSPG,0),U,2)
 . I DDSBK]"" D
 .. N DIE,DA,DR
 .. S DIE="^DIST(.403,"_DDSNFRM_",40,"
 .. S DA(1)=DDSNFRM,DA=DDSPG
 .. S DR="1////"_$P(^TMP("DDSCLONE",$J,DDSBK),U,3)
 .. D ^DIE
 . ;
 . N DA,DIK
 . S DIK="^DIST(.403,"_DDSNFRM_",40,"_DDSPG_",40,"
 . S DA(2)=DDSNFRM,DA(1)=DDSPG
 . S DDSBK=0
 . F  S DDSBK=$O(^DIST(.403,DDSNFRM,40,DDSPG,40,DDSBK)) Q:'DDSBK  D
 .. Q:$D(^TMP("DDSCLONE",$J,DDSBK))[0  S DDSNBK=$P(^(DDSBK),U,3)
 .. M ^DIST(.403,DDSNFRM,40,DDSPG,40,DDSNBK)=^DIST(.403,DDSNFRM,40,DDSPG,40,DDSBK)
 .. S $P(^DIST(.403,DDSNFRM,40,DDSPG,40,DDSNBK,0),U)=DDSNBK
 .. S DA=DDSBK
 .. D ^DIK
 Q
 ;
INDEXFM ;Index new form
 W !,"Reindexing new form ..."
 N DIK,DA
 S DIK="^DIST(.403,",DA=DDSNFRM
 D IX1^DIK
 ;
 D EN^DDSZ(DDSNFRM)
 Q
 ;
ASKCONT ;Final chance to abort
 K DIR S DIR(0)="Y"
 S DIR("A",1)=""
 S DIR("A")="Ready to clone form"
 S DIR("?")="  Enter 'Y' to clone form.  Enter 'N' to exit."
 D ^DIR K DIR
 S:$D(DIRUT)!'Y DDSQUIT=1
 Q
