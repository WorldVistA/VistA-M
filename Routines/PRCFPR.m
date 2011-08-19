PRCFPR ;WISC/LDB-FISCAL REPORTS ; 3/5/96  11:39 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EN ;Called from PRCHQUE to save (stack) Fiscal documents in file 421.8
 ;Input variables- PRCHXXDO (DO for print),PRDCHXXD1 (D1 for prints)
 ;PRCHREPR,PRCHFPT,PRC("SITE"),X(PRINTER)
 N DA,DIC,DIE,DR,X,Y
 Q:'$D(PRCHQ)!'$D(PRCHXXD0)  S TYPE=$S($D(PRCHFPT):2,PRCHQ["^PRCE58P2":3,PRCHQ["^PRCSP12":4,1:1)
 ;   quit if purchase card order has been printed
 Q:$P($G(^PRC(442,PRCHXXD0,0)),"^",2)=25
 S DIC="^PRC(421.8,",DLAYGO=421.8,DIC(0)="L",X=""""_D0_"""" D ^DIC K DLAYGO G:Y<0 EXIT K DIC
 S DA=+Y,DIE="^PRC(421.8," K DIC D NOW^%DTC S DATE=$E(%,1,12)
 S DR="1////^S X=TYPE;2////^S X=$TR(PRCHQ,""^"",""*"");5////^S X=DATE;6////^S X=$P($S($D(^PRC(442,PRCHXXD0,0))&(TYPE'=3):^(0),$D(^PRCS(410,PRCHXXD0,0))&((TYPE=3)!(TYPE=4)):^(0),1:""""),U);7////^S X=IOP"
 S DR=DR_";9////^S X=$S($D(PRC(""SITE"")):PRC(""SITE""),1:$O(^PRC(411,0)))"
 D ^DIE
 K IOP
 S:$D(PRCHXXD0) D0=PRCHXXD0 S:$D(PRCHXXD1) D1=PRCHXXD1
 N DLAYGO S DA(1)=DA,DIC="^PRC(421.8,DA,1,",DLAYGO=421.8,DIC(0)="L",^PRC(421.8,DA,1,0)="^421.84^^" F PRCVAR="PRCHXXD0","PRCHXXD1","PRCHFPT","PRCHQ(""DEST"")","DEST","PRC(""SITE"")","PRCHREPR","D0","D1","DUZ" D
 .I $D(@PRCVAR) S X=PRCVAR K DD,D0 D FILE^DICN S $P(^PRC(421.8,DA(1),1,+Y,0),U,2)=@PRCVAR
EXIT K %,DATE,DD,D0,PRCHQ,PRCVAR,TYPE Q
 ;
 ;
