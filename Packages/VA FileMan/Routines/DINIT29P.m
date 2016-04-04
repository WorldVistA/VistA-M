DINIT29P ;SFISC/MKO-SCREENMAN POSTINIT ;27NOV2010
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 N B,F
 ;
 ;Delete the "AZ" global for each form. Starting in Version 22.0
 ;compiled data will be stored in ^DIST(.403,form#,"AY") instead of
 ;^DIST(.403,form#,"AZ")
 S F=0 F  S F=$O(^DIST(.403,F)) Q:F'=+$P(F,"E")  K ^DIST(.403,F,"AZ")
 ;
 ;Update Field Type field of fields on old blocks.
 ;Convert 0 or null to 3 (data dictionary field)
 S B=0 F  S B=$O(^DIST(.404,B)) Q:B'=+B  D
 . Q:$P($G(^DIST(.404,B,0)),U)?1"DDGF".E
 . S F=0 F  S F=$O(^DIST(.404,B,40,F)) Q:F'=+F  D
 .. Q:$D(^DIST(.404,B,40,F,0))[0
 .. S:'$P(^DIST(.404,B,40,F,0),U,3) $P(^(0),U,3)=3
 ;
 ;Rename two version 19 options
 I $P($G(^DIC(19,0)),U)="OPTION" D
 . D:$D(^DIC(19,"B","DDS CREATE FORM")) RENAME("DDS CREATE FORM","DDS EDIT/CREATE A FORM")
 . D:$D(^DIC(19,"B","DDS CREATE BLOCK")) RENAME("DDS CREATE BLOCK","DDS RUN A FORM")
AUD .;ADD ONE NEW AUDIT OPTION, REMOVE ANOTHER
 . D:'$D(^DIC(19,"B","DIAUDIT MONITOR USER"))
 ..N DIC,X,Y,DLAYGO
 ..S DIC="^DIC(19,",DLAYGO=19,X="DIAUDIT MONITOR USER",DIC(0)="L",DIC("DR")="1///Monitor a User;4///R;11///y;25///2^DIAU"
 ..D ^DIC Q:Y<0
 ..S ^DIC(19,+Y,1,0)="^19.06^2^2",^(1,0)="This Option allows tracking of a given user's access to entries in a",^DIC(19,+Y,1,2,0)="given (audited) File.  Display starts with a selected access date."
 .D:$D(^DIC(19,"B","DIAUDIT DD"))
 ..N DA,DIE,DR S DA=$O(^("DIAUDIT DD",0)),DIE=19,DR="2////NO LONGER FUNCTIONAL -- ALL DATA DICTIONARIES ARE NOW AUDITED" D ^DIE
 ;
 G ^DINIT2A0
 ;
RENAME(DDSOLD,DDSNEW) ;Rename options
 N DIC,X,Y
 S DIC="^DIC(19,",DIC(0)="Z",X=DDSOLD
 D ^DIC Q:Y<0
 ;
 N DIE,DA,DR
 S DIE=DIC,DA=+Y,DR=".01///"_DDSNEW
 D ^DIE
 Q
 ;
PRE ;ScreenMan pre-init
 ;Delete old forms and blocks used by FileMan
 N I
 S I=0 F  S I=$O(^DIST(.403,I)) Q:'I!(I'<1)  K ^DIST(.403,I)
 S I=0 F  S I=$O(^DIST(.404,I)) Q:'I!(I'<1)  K ^DIST(.404,I)
 Q
