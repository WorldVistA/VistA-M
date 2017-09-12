LBRVPOST ;SSI/ALA-Post Library Patch Clean-Up ;[ 04/15/98  3:45 PM ]
 ;;2.5;Library;**2**;Mar 11, 1996
 S %=$$PARCP^XPDUTL("PRE1","PRE")
 I %=0 K % D RC G EXIT
 K X,DIK,DA
STA N %
 S %=$$NEWCP^XPDUTL("MOVE","MOV^LBRVPOST")
INDX ;reindex cross-references for File#680.6 
 F LBRDI="B","C" K ^LBRY(680.6,LBRDI)
 S DIK="^LBRY(680.6," D IXALL^DIK
FIL ;  File the site into the data files
 S %=$$PARCP^XPDUTL("FILE","PRE"),LBRVY=%
 F LBRDI=680,681,682 D  D MES^XPDUTL("File "_LBRDI_" done.") K DA,DR,DIC,DIE
 . S DIC="^LBRY("_LBRDI_",",DA=0
 . S DR=".04////^S X=LBRVY"
 . F  S DA=$O(^LBRY(LBRDI,DA)) Q:'DA  S DIE=DIC D ^DIE W:DA#100=0 "."
 K DA,DR,DIC,DIE,LBRDI
 S DR=".02////^S X=LBRVY",DIC="^LBRY(680.7,",DIE=DIC,DA=0
 F  S DA=$O(^LBRY(680.7,DA)) Q:'DA  D ^DIE W:DA#10=0 "."
 K DA,DR,DIC,DIE
 S DR="1////^S X=LBRVY",DIC="^LBRY(680.4,",DIE=DIC,DA=0
 F  S DA=$O(^LBRY(680.4,DA)) Q:'DA  D ^DIE W:DA#10=0 "."
 K DA,DR,DIC,DIE
 Q
MOV ;  Move data into scratch file if appropriate
 S %=$$PARCP^XPDUTL("PRE1","PRE"),LBRFL=%
 S LBRWSTA=$$PARCP^XPDUTL("STNCD","PRE")
CV I LBRFL="LEG" D
 . S LBRVDT=$$FMADD^XLFDT(DT,7)
 . S ^XTMP("LBRY",0)=LBRVDT_"^"_DT
 . S ^XTMP("LBRY",LBRWSTA)=LBRWSTA
 . D ^LBRVCONV
 . D RC
 . D MES^XPDUTL("You are now ready to move your data to the primary system.")
 . D MES^XPDUTL("Please move temporary global, ^XTMP(""LBRY"" to correct directory and install LBR*2.5*3.")
 I LBRFL="PRI" D RC
 G EXIT
RC ;  Find bad records
 S DIK="^LBRY(681,",DA=0 W "."
 F  S DA=$O(^LBRY(681,DA)) Q:'DA  D
 . S TAF=$P(^LBRY(681,DA,0),U,2)
 . I TAF="" D ^DIK Q
 . I '$D(^LBRY(680,TAF)) D ^DIK
 S DIK="^LBRY(682,",DA=0 W "."
 F  S DA=$O(^LBRY(682,DA)) Q:'DA  D
 . S TAF=$P(^LBRY(682,DA,0),U,2)
 . I TAF="" D ^DIK Q
 . I '$D(^LBRY(680,TAF)) D ^DIK
 S DIK="^LBRY(682.1,",DA="" W "."
 F  S DA=$O(^LBRY(682.1,DA)) Q:DA=0  D
 . K ^LBRY(682.1,DA)
 F IND="AA","AC","AD","B","C" K ^LBRY(682.1,IND)
 D IXALL^DIK
 W "."
REINDX ; re-indexing of all cross-references 
 D MES^XPDUTL("I am now re-indexing all cross-references")
 W !
 F J=680,681,682,680.4,680.7,680.3,680.5 S LX="A" F  S LX=$O(^LBRY(J,LX)) Q:LX=""  K ^LBRY(J,LX)
 F DIK="^LBRY(680,","^LBRY(681,","^LBRY(682,","^LBRY(680.4,","^LBRY(680.7,","^LBRY(680.3,","^LBRY(680.5," D
 . W DIK,! D IXALL^DIK
 Q
EXIT K DA,DIC,LBRVY,LBRDI,DIE,DR,LFLG,LBRWSTA,LSTN,GSTN,LBRWSTN,LBRFL,CKDA
 K LBRVDT
 Q
