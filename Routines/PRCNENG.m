PRCNENG ;SSI/SEB-Engineering display/entry ;[ 07/19/96  2:33 PM ]
 ;;1.0;Equipment/Turn-In Request;;Sep 13, 1996
REV ; Review equipment requests
 S DIC("S")="I $P(^(0),U,7)=8!($P(^(0),U,7)=26)!($P(^(0),U,7)=30)"
 S DIC="^PRCN(413,",DIC(0)="AEQZ" D ^DIC K DIC("S") G EXIT1:Y<0
 S DIE("NO^")="BACKOUTOK"
 S (IN,DA)=+Y,PRCNUSR=2,DIE=DIC,DIE("NO^")="OUTOK",DR="[PRCNENG]",SP=$G(^PRCN(413,DA,2))
 D SETUP^PRCNPRNT,ROOM:$P(SP,U,10)="Y"&($P(SP,U,19)="")
 S %=1 W !!,"Do you wish to edit this transaction" D YN^DICN S PRCNEA=%
 S STAT=$P(^PRCN(413,IN,0),U,7)
 I STAT=30,PRCNEA=2 D ESIG G EXIT
 I PRCNEA=1 D ^DIE
EXIT K DIC,DIE,DA,DR,IN,PRCNUSR,SP,Y,%,D,D0,FAIL,STAT,C,CON,PROJ,J,%,PRCNEA
 G REV
EXIT1 K DIC
 Q
ROOM ; Inform engineer if space available and room not in space file
 W $C(7),!!,"LOCATION: ",$P(SP,U,11)," is not in the Space File..."
 Q
ESIG ;  Electronic signature
 D ES^PRCNUTL
 I $G(FAIL)<1 K FAIL Q
 S DR="6////^S X=27;7////^S X=DT" D ^DIE
 W !!,"Transaction returned to PPM"
 Q
VEN ;  Get and display vendor
 S VEN=$P($G(^PRCN(413,D0,7)),U,16) S:VEN'="" VEN=$P(^PRC(440,VEN,0),U)
 S VEN=$S($G(VEN)="":$P($G(^PRCN(413,D0,7)),U,4),1:VEN)
 Q
LOC ;  Get and display location
 S LOC=$P($G(^PRCN(413,D0,2)),U,19) S:LOC'="" LOC=$P(^ENG("SP",LOC,0),U)
 S LOC=$S($G(LOC)="":$P($G(^PRCN(413,D0,2)),U,11),1:LOC)
 Q
