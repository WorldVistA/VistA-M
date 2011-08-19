PRCPEITF ;WISC/RFJ-enter/edit inventory items                       ;01 Dec 93
V ;;5.1;IFCAP;**1**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
DESCRIP(PRCPINPT,ITEMDA,PRCPQUIT) ;  edit item description
 ;
 ; PRCPINPT = inventory point
 ; ITEMDA = item ien
 ; PRCPQUIT = flag if user aborts/times-out
 ;
 N PRCPNM
 ; because this is sometimes called from templates, new FileMan variables
 N D,D0,D1,D2,D3,D4,D5,D6,DA,DB,DC,DD,DE,DG,DH,DI,DIA,DIADD,DIC,DICR,DIE
 N DIEC,DIEL,DIFLD,DIK,DIOV,DIR,DK,DL,DLAYGO,DM,DO,DOV,DP,DR,DQ,DU,DV,DW
 N I,J,X,Y
 I '$D(^PRCP(445,PRCPINPT,1,ITEMDA)) Q
 S PRCPNM=$P(^PRCP(445,PRCPINPT,0),"^",1)
 D  I $D(DUOUT)!$D(DTOUT) Q
 . N VALUE
 . S DIR(0)="445.01,.7^^",DA(1)=PRCPINPT,DA=ITEMDA
 . D ^DIR K DIR
 . S VALUE=Y
 . I $D(DTOUT)!$D(DUOUT) S PRCPQUIT=1 Q
 . S DA=ITEMDA,DIE="^PRCP(445,"_PRCPINPT_",1,",DR=".7///^S X=VALUE",PRCPPRIV=1
 . D ^DIE K PRCPPRIV,DIE
 . S VALUE=$P($G(^PRCP(445,PRCPINPT,1,ITEMDA,6)),"^",1)
 . I $P(^PRCP(445,PRCPINPT,0),"^",3)="P",PRCPNM]"",VALUE]"",PRCPNM'=VALUE D
 . . D POPDESC(PRCPINPT,ITEMDA)
 Q
 ;
 ;
DESDEF(PRCPINPT,ITEMDA) ; get default for item description
 ; ITEMDA   = item number requiring the default description
 ; PRCPINPT = inventory point
 ; returns name to use for default
 ;
 ; Note: The inventory point must be locked at least at
 ;       the item level prior to calling this routine
 ;
 N DES,PRCPPRIM,PRCPTYPE
 S DES=""
 S PRCPTYPE=$P($G(^PRCP(445,PRCPINPT,0)),"^",3)
 I PRCPTYPE'="S" D
 . S DES=$P($G(^PRC(441,ITEMDA,0)),"^",2)
 . S $P(^PRCP(445,PRCPINPT,1,ITEMDA,6),"^")=DES
 . W !!?5,"...item description set to short description in item master file."
 I PRCPTYPE="S" D
 . S PRCPPRIM=0
 . S PRCPPRIM=$O(^PRCP(445,"AB",+PRCPINPT,PRCPPRIM))
 . S DES=$P($G(^PRCP(445,PRCPPRIM,1,ITEMDA,6)),"^",1)
 . S $P(^PRCP(445,PRCPINPT,1,ITEMDA,6),"^")=DES
 . W !!?5,"...item description set to short description in primary."
 Q (DES)
 ;
 ;
POPDESC(PRCPINPT,ITEMDA) ; ask user if item description should be used in secondaries
 ; ITEMDA   = item number requiring the default description
 ; PRCPINPT = inventory point
 ;
 N DES,PRCPRNM,SEC
 S PRCPPRNM=$P(^PRCP(445,PRCPINPT,0),"^",1)
 ;ASK USER IF THEY WISH TO UPDATE ALL SECONDARIES
 S XP="  Do you want to update the DESCRIPTION for ALL distribution"
 S XP(1)="  points stocked by "_PRCPPRNM
 S XH="  Enter 'YES' only if you want to change the DESCRIPTION at ALL"
 S XH(1)="  DISTRIBUTION points to be the same as for the "_PRCPPRNM
 S XH(2)="  procurement source."
 I $$YN^PRCPUYN("")'=1 Q
 ; IF YES DO
 W !!,"updating DESCRIPTION for distribution points....."
 S DES=$P(^PRCP(445,PRCPINPT,1,ITEMDA,6),"^",1)
 ; LOOK AT NODE 2 OF PRIMARY
 S SEC=0 F  S SEC=$O(^PRCP(445,PRCPINPT,2,SEC)) Q:'+SEC  D
 . N DA,DIE,DR
 . ; IF ITEM IS ON THAT SECONDARY, LOCK & UPDATE NAME
 . I $D(^PRCP(445,SEC,1,ITEMDA)) D
 . . L +^PRCP(445,SEC,1,ITEMDA):2
 . . W !,$J($P(^PRCP(445,SEC,0),"^",1),35)
 . . I '$T W "  In use, could not update." Q
 . . S DIE="^PRCP(445,"_SEC_",1,"
 . . S DA=ITEMDA
 . . S DR=".7////^S X=DES"
 . . D ^DIE K DIE
 . . W "  DESCRIPTION updated"
 . . D BLDSEG^PRCPHLFM(3,ITEMDA,SEC) ; notify supply station of update
 . . L -^PRCP(445,SEC,1,ITEMDA)
 Q
