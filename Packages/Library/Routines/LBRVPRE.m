LBRVPRE ;SSI/ALA-PreInit for patch ;[ 04/15/98  3:22 PM ]
 ;;2.5;Library;**2**;Mar 11, 1996
 ;
DD ;Remove fields from data dictionary
 S DIK="^DD(680,",DA=10.7,DA(1)=680 D ^DIK
 S DIK="^DD(681,",DA=1.7,DA(1)=681 D ^DIK
 S DIK="^DD(681.02,",DA=.01,DA(1)=681.02 D ^DIK
 S DIK="^DD(680.01,",DA(1)=680.01,DA=1 D ^DIK
 S DIK="^DD(680.5,",DA=.01,DA(1)=680.5 D ^DIK
 K DIK,DA
 ;  remove FORUM data dictionaries
 S DIU="^LBRL(688,",DIU(0)="D" D EN^DIU2
 S DIU="^LBRL(689,",DIU(0)="D" D EN^DIU2
 S DIU="^LBRL(689.1,",DIU(0)="D" D EN^DIU2
 S DIU="^LBRY(687,",DIU(0)="D" D EN^DIU2
 S DIU="^LBRY(687.1,",DIU(0)="D" D EN^DIU2
 S DIU="^LBRY(689.2,",DIU(0)="D" D EN^DIU2
 K DIU
 W "."
DT ; remove data from file 680 from deleted field
 S LBRD0=0
LP1 S LBRD0=$O(^LBRY(680,LBRD0)) G ON:'LBRD0
 S LBRD1=0
LP2 S LBRD1=$O(^LBRY(680,LBRD0,4,LBRD1)) G LP1:'LBRD1
 S ^LBRY(680,LBRD0,4,LBRD1,0)=$P(^LBRY(680,LBRD0,4,LBRD1,0),U)
 G LP2
ON K TAF,DA,DIK,IND,LBRD0,LBRD1
 I $$PATCH^XPDUTL("LBR*2.5*2")=1 D EN Q
STA N %
 S %=$$NEWCP^XPDUTL("STNCD","STA1^LBRVPRE")
 S %=$$NEWCP^XPDUTL("PRE1","EN^LBRVPRE")
 S %=$$NEWCP^XPDUTL("PRE3","MUL^LBRVPRE")
 S %=$$NEWCP^XPDUTL("FILE")
 Q
STA1 ;  Get station number
 S LBRWSTA=$P($G(^XTMP("LBRV",0)),"^",3)
 S %=$$UPCP^XPDUTL("STNCD",LBRWSTA)
 Q
EN ;  Check for type of site
 ;  PRI = Station (also applicable for single stations)
 ;  LEG = Legacy (applicable for stations who may move data)
 N %
 Q:($G(XPDQUES("PRE1"))="")
 S $P(^XTMP("LBRV",0),";",2)=$G(XPDQUES("PRE1"))
 S %=$$UPCP^XPDUTL("PRE1",$G(XPDQUES("PRE1")))
 Q
MUL ;  Multiple site set
 N %
 Q:'XPDQUES("PRE3")
 S %=$$UPCP^XPDUTL("PRE3",$G(XPDQUES("PRE3")))
 S LBRVY=XPDQUES("PRE3")
 S DA=+LBRVY I $G(LBRWSTA)="" S LBRPRT=$P($G(^XTMP("LBRV",0)),"^",3),LBRWSTA=$P(LBRPRT,";",1)
 S DIC="^LBRY(680.6,",DIE=DIC
 S DR=".07////^S X=LBRWSTA" D ^DIE K DA,DR,DIC,DIE,LBRPRT
 S %=$$UPCP^XPDUTL("FILE",LBRVY)
 Q
EXIT ;
 Q
