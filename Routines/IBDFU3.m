IBDFU3 ;ALB/CJM - ENCOUNTER FORM - BUILD FORM(deleting blocks) ; 08-JAN-1993
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
DLTBLK(BLOCK,FORM,FILE) ;deletes BLOCK (in FILE) if not part of the toolkit (unless IBTKBLK=1) and, if FORM is passed in, the block actually is on FORM
 Q:('$G(BLOCK))
 Q:(FILE'=357.1)&(FILE'=358.1)
 N NODE,DIK,DA
 S NODE=$G(^IBE(FILE,BLOCK,0))
 K DA S DA=BLOCK,DIK="^IBE("_FILE_","
 ;don't delete it if part of the toolkit or doesn't belong to the form (messed up cross-references), unless IBTKBLK=1 (means deletion is durring special option for editing the tk)
 G:$G(IBTKBLK) JUSTDOIT
 I ($P(NODE,"^",14)) D  Q
 .S $P(^IBE(FILE,BLOCK,0),"^",2)=$O(^IBE(FILE\1,"B","TOOL KIT",""))
 .I $G(FORM)'="" K ^IBE(FILE,"C",FORM,BLOCK) D IX1^DIK
 I $G(FORM)'="",($P(NODE,"^",2)'=FORM) D  Q
 .;don't delete it - instead re-index it and quit
 .K ^IBE(FILE,"C",FORM,BLOCK) D IX1^DIK
JUSTDOIT ;
 ;delete its components
 D DLTCNTNT(BLOCK,FILE)
 ;delete the block (DIC,DA are newed)
 D ^DIK
 Q
 ;
DLTCNTNT(BLOCK,FILE) ;delete everything in BLOCK, but not the block itself
 Q:('$G(BLOCK))!('$G(FILE))
 Q:(FILE'=357.1)&(FILE'=358.1)
 N LIST,FLD,LINE,TEXT,TARGET,DIK,DA
 ;delete selection lists from BLOCK
 S TARGET=$S(FILE[358:358.2,1:357.2)
 S LIST="" F  S LIST=$O(^IBE(TARGET,"C",BLOCK,LIST)) Q:'LIST  D DLTLIST(TARGET,BLOCK,LIST)
 ;delete data fields
 S TARGET=$S(FILE[358:358.5,1:357.5)
 S FLD="" F  S FLD=$O(^IBE(TARGET,"C",BLOCK,FLD)) Q:'FLD  D DLTFLD(TARGET,BLOCK,FLD)
 ;delete multiple choice fields
 S TARGET=$S(FILE[358:358.93,1:357.93)
 S FLD="" F  S FLD=$O(^IBE(TARGET,"C",BLOCK,FLD)) Q:'FLD  D DLTIFLD(TARGET,BLOCK,FLD)
 ;delete hand print fields
 S TARGET=$S(FILE[358:358.94,1:359.94)
 S FLD="" F  S FLD=$O(^IBE(TARGET,"C",BLOCK,FLD)) Q:'FLD  D DLTHFLD(TARGET,BLOCK,FLD)
 ;delete lines
 S TARGET=$S(FILE[358:358.7,1:357.7)
 S LINE="" F  S LINE=$O(^IBE(TARGET,"C",BLOCK,LINE)) Q:'LINE  D DLTLINE(TARGET,BLOCK,LINE)
 ;delete text areas
 S TARGET=$S(FILE[358:358.8,1:357.8)
 S TEXT="" F  S TEXT=$O(^IBE(TARGET,"C",BLOCK,TEXT)) Q:'TEXT  D DLTTEXT(TARGET,BLOCK,TEXT)
 Q
 ;
DLTLIST(FILE,BLOCK,LIST) ;delete the LIST, its selections and groups
 Q:'$G(LIST)!'$G(BLOCK)!(($G(FILE)'=357.2)&($G(FILE)'=358.2))
 N GRP,SLCTN,DIK,DA
 S DIK="^IBE("_FILE_",",DA=LIST
 ;don't delete it if it does not belong to BLOCK - instead, reindex it and quit
 I $P($G(^IBE(FILE,LIST,0)),"^",2)'=BLOCK K ^IBE(FILE,"C",BLOCK,LIST) D IX1^DIK Q
 ;delete its contents(DIK,DA are newed)
 D DLISTCNT(LIST,FILE)
 ;delete the list
 D ^DIK
 Q
DLISTCNT(LIST,FILE) ;delete the list's selections and groups
 N GRP,SLCTN,DIK,DA,GFILE,SFILE
 Q:('$G(LIST))!('$G(FILE))
 Q:(FILE'=357.2)&(FILE'=358.2)
 S GFILE=$S(FILE[358:358.4,1:357.4)
 S SFILE=$S(FILE[358:358.3,1:357.3)
 ;now delete list's contents
 S GRP="" F  S GRP=$O(^IBE(GFILE,"D",LIST,GRP)) Q:'GRP  S DA=GRP D
 .I $P($G(^IBE(GFILE,GRP,0)),"^",3)=LIST D
 ..S DIK="^IBE("_GFILE_"," D ^DIK
 ..S SLCTN="",DIK="^IBE("_SFILE_"," F  S SLCTN=$O(^IBE(SFILE,"D",GRP,SLCTN)) Q:'SLCTN  S DA=SLCTN D
 ...I $P($G(^IBE(SFILE,SLCTN,0)),"^",4)=GRP D
 ....D ^DIK
 ...E  K ^IBE(SFILE,"C",LIST,SLCTN) D IX1^DIK
 .;
 .E  K ^IBE(GFILE,"D",LIST,GRP) D IX1^DIK
 S SLCTN="",DIK="^IBE("_SFILE_"," F  S SLCTN=$O(^IBE(SFILE,"C",LIST,SLCTN)) Q:'SLCTN  S DA=SLCTN D
 .I $P($G(^IBE(SFILE,SLCTN,0)),"^",3)=LIST D
 ..D ^DIK
 .E  K ^IBE(SFILE,"C",LIST,SLCTN) D IX1^DIK
 Q
 ;
DLTFLD(FILE,BLOCK,FLD) ;delete a display field
 Q:('$G(BLOCK))!('$G(FLD))!('$G(FILE))
 Q:(FILE'=357.5)&(FILE'=358.5)
 N DA,DIK
 S DIK="^IBE("_FILE_",",DA=FLD
 I $P($G(^IBE(FILE,FLD,0)),"^",2)=BLOCK D
 .D ^DIK
 E  K ^IBE(FILE,"C",BLOCK,FLD) D IX1^DIK
 Q
 ;
DLTIFLD(FILE,BLOCK,FLD) ;delete a multiple choice field
 Q:('$G(BLOCK))!('$G(FLD))!('$G(FILE))
 Q:(FILE'=357.93)&(FILE'=358.93)
 N DA,DIK
 S DIK="^IBE("_FILE_",",DA=FLD
 I $P($G(^IBE(FILE,FLD,0)),"^",8)=BLOCK D
 .D ^DIK
 E  K ^IBE(FILE,"C",BLOCK,FLD) D IX1^DIK
 Q
DLTHFLD(FILE,BLOCK,FLD) ;delete a hand print field
 Q:('$G(BLOCK))!('$G(FLD))!('$G(FILE))
 Q:(FILE'=359.94)&(FILE'=358.94)
 N DA,DIK
 S DIK="^IBE("_FILE_",",DA=FLD
 I $P($G(^IBE(FILE,FLD,0)),"^",8)=BLOCK D
 .D ^DIK
 E  K ^IBE(FILE,"C",BLOCK,FLD) D IX1^DIK
 Q
 ;
DLTTEXT(FILE,BLOCK,TEXT) ;delete the TEXT AREA
 Q:('$G(BLOCK))!('$G(TEXT))!('$G(FILE))
 Q:(FILE'=357.8)&(FILE'=358.8)
 N DA,DIK
 S DIK="^IBE("_FILE_",",DA=TEXT
 I $P($G(^IBE(FILE,TEXT,0)),"^",2)=BLOCK D
 .D ^DIK
 E  K ^IBE(FILE,"C",BLOCK,TEXT) D IX1^DIK
 Q
DLTLINE(FILE,BLOCK,LINE) ;delete the line
 Q:('$G(BLOCK))!('$G(LINE))!('$G(FILE))
 Q:(FILE'=357.7)&(FILE'=358.7)
 N DA,DIK
 S DIK="^IBE("_FILE_",",DA=LINE
 I $P($G(^IBE(FILE,LINE,0)),"^",6)=BLOCK D
 .D ^DIK
 E  K ^IBE(FILE,"C",BLOCK,LINE) D IX1^DIK
 Q
FASTEXIT ;just sets a flag signaling system should be exited
 S VALMBCK="Q"
 K DIR S DIR(0)="Y",DIR("A")="Exit Encounter Form Option",DIR("B")="NO" D ^DIR
 I $D(DIRUT)!(Y) S IBFASTXT=1
 K DIR
 Q
