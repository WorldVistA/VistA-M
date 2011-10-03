TIUSRVPL ; SLC/JER - RPC's Supporting Links ;4/20/2001 09:46
 ;;1.0;TEXT INTEGRATION UTILITIES;**63,114**;Jun 20, 1997
PUTIMAGE(TIUY,TIUDA,IMGDA) ; Create link Image-to-Document
 N D,D0,DI,DQ,DIC,DA,DIE,DR,X,Y
 I $S('+$G(IMGDA):1,'$D(^MAG(2005,+IMGDA,0)):1,1:0) D  Q
 . S TIUY="0^ Invalid Image Pointer."
 I $S('+$G(TIUDA):1,'$D(^TIU(8925,+TIUDA,0)):1,1:0) D  Q
 . S TIUY="0^ Invalid Document Pointer."
 I $$DUPLINK(TIUDA,IMGDA) S TIUY="0^ Document already linked to this image." Q
 S X=""""_"`"_TIUDA_"""",(DIC,DLAYGO)=8925.91,DIC(0)="LX"
 D ^DIC I +Y'>0 S TIUY="0^ Unable to create Image Link" Q
 S TIUY=+Y
 S DIE=DIC,DR=".02////^S X=IMGDA" D ^DIE
 Q
DUPLINK(TIUDA,IMGDA) ; identify duplicate links
 Q $S(+$O(^TIU(8925.91,"ADI",+TIUDA,+IMGDA,0)):1,1:0)
DELIMAGE(TIUY,TIUDA,IMGDA) ; Delete link Image-to-Document
 N TIUI
 I '+$O(^TIU(8925.91,"ADI",TIUDA,IMGDA,0)) D  Q
 . S TIUY="0^ Document and Image not currently linked."
 S TIUI=0
 F  S TIUI=$O(^TIU(8925.91,"ADI",TIUDA,IMGDA,TIUI)) Q:+TIUI'>0  D
 . N DIDEL,DIE,DA,DR
 . S (DIE,DIDEL)=8925.91,DR=".01///@",DA=TIUI D ^DIE
 S TIUY=1
 Q
GETILST(TIUY,TIUDA) ; Given a document, get list of associated images
 N IMGDA,TIUI S (IMGDA,TIUI)=0
 F  S IMGDA=$O(^TIU(8925.91,"ADI",TIUDA,IMGDA)) Q:+IMGDA'>0  D
 . S TIUI=TIUI+1,TIUY(TIUI)=IMGDA
 Q
GETDLST(TIUY,IMGDA) ; Given an Image, get list of associated documents
 N TIUDA,TIUI S (TIUDA,TIUI)=0
 F  S TIUDA=$O(^TIU(8925.91,"AID",IMGDA,TIUDA)) Q:+TIUDA'>0  D
 . S TIUI=TIUI+1,TIUY(TIUI)=TIUDA
 Q
