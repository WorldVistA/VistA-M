DINIT29P ;SFISC/MKO-SCREENMAN POSTINIT ;11:21 AM  2 Oct 1998
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
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
