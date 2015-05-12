PRCHNPOC ;RB-MNTFW-CONT. OF EDIT PO ;8/7/14  19:48
V ;;5.1;IFCAP;**189**;Oct 20, 2000;Build 1
 ;Per VA Directive 6402, this routine should not be modified
 ;
 ;PRC*5.1*189 Prompt Pay call made from PRCHNPO1 to insure
 ;            ONLY one entry is added/edited with the PP
 ;            field defined as multiple.
 ;
PPEDIT ;Prompt payment edit
 N DIC,DIE,DA,DR,Y,PRCHX,PRCHXX,PRCHVAL,PRCHDA,%X,%Y,PRCHPP
 S PRCHPP=$O(^PRC(442,PRCHPO,5,0)) D:PRCHPP
 . S (PRCHDA,DA)=PRCHPP
 . S DR=".01//^S X=""NET"";1//^S X=30"
 . S DA(1)=PRCHPO,DIE="^PRC(442,"_DA(1)_",5," D ^DIE
 I 'PRCHPP S DA(1)=PRCHPO,DIC="^PRC(442,"_DA(1)_",5,",DIC(0)="AELQZ",DIC("B")="NET" D ^DIC Q:Y<0  S (PRCHDA,DA)=+Y D
 . S $P(^PRC(442,PRCHPO,5,0),U,2)=$P(^DD(442,9.2,0),U,2)
 . S DA(1)=PRCHPO,DIE="^PRC(442,"_DA(1)_",5,"
 . S DR=".01//^S X=""NET"";1//^S X=30"
 . D ^DIE
 QUIT
