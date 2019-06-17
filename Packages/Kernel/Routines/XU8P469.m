XU8P469 ;ISF/RWF - Patch XU*8*469 post-init ;1/30/08  09:08
 ;;8.0;KERNEL;**469**;Jul 10, 1995;Build 7
POST ;Post-init to clean-up files
 D MES^XPDUTL("Begin POST-INIT.")
 D F19,EN1,EN2,SLOG
 D MES^XPDUTL("Finished POST-INIT.")
 Q
 ;
EN1 ;Change $N in file 200, field 9 to $O
 D
 . N ITRANS,PIECE
 . S PIECE="$N(^VA(200,""SSN"",X,0))"
 . S ITRANS=$P(^DD(200,9,0),U,5,99)
 . I ITRANS'[PIECE Q  ;Already altered Input Transform
 . S ITRANS=$P(ITRANS,PIECE)_"$O(^VA(200,""SSN"",X,0))"_$P(ITRANS,PIECE,2)
 . S $P(^DD(200,9,0),U,5,99)=ITRANS
 . Q
 Q
 ;
EN2 ;Now queue the removal of QAR fields and data.
 ;D MES^XPDUTL("Begin clean up of the NEW PERSON(#200) file...")
 N ZTRTN,ZTDTH,ZTDESC,ZTSK,ZTIO
 S ZTRTN="F200^XU8P469",ZTDTH=$H,ZTDESC="QAR data removal",ZTIO=""
 D ^%ZTLOAD
 D MES^XPDUTL("Queued the removal of QAR fields and data as task #"_ZTSK)
 Q
 ;
SLOG ;Clean up any long last signon nodes.
 N DA S DA=0
 F  S DA=$O(^VA(200,DA)) Q:'DA  I $L($G(^VA(200,DA,1.1)),U)>5 D
 . S ^VA(200,DA,1.1)=$P(^VA(200,DA,1.1),U,1,5)
 . Q
 Q
 ;
 ;From Cameron 2/9/2005
 ;Kernel should delete the whole range of fields from 747.1 through 747.9, all fields and all multiples between.
F200 ;Only remove if the pointed to files have been removed.
 I $D(^DIC(747.25,0))!$D(DIC(747.5,0))!$D(^DIC(747.7,0)) Q
 N FLD,DIU,DA,DIK
 ;First remove the multipuls
 S FLD=747
 ;F FLD=.111,.13,.2,.27,.28,.31,.32,.34,.36,.43,.45,.5,.6,.7,.8 D
 F  S FLD=$O(^DD(200,FLD)) Q:FLD'["747."  D
 . S DIU(0)="S"
 . I $D(^DD(200,FLD,0)),$P(^(0),U,2)>1 S DIU=+$P(^(0),U,2) D EN^DIU2
 . Q
 ;Now remove the other fields.
 S FLD=747
 F  S FLD=$O(^DD(200,FLD)) Q:FLD'["747."  S DIK="^DD(200,",DA=FLD,DA(1)=200 D ^DIK
 ;
QAR ;Delete all QAR data from the NPF
 N DA,ND
 S DA=.5
 F  S DA=$O(^VA(200,DA)) Q:DA'>0  D
 . S ND="QAQz"
 . F  S ND=$O(^VA(200,DA,ND)) Q:$E(ND,1,3)'="QAR"  D
 . . K ^VA(200,DA,ND)
 . . Q
 . Q
 Q
 ;
F19 ;File 19 Field 24.
 D MES^XPDUTL("Remove Field #24 from the OPTION(#19) file...")
 I '$D(^DD(19,24,0))#2 D MES^XPDUTL("Field #24 is not defined.") G DONE
 N DIK,DA
 S DIK="^DD(19,",DA=24,DA(1)=19
 D ^DIK
DONE D MES^XPDUTL("Finished cleaning up the OPTION(#19) file.")
 Q
