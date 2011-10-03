PRCAPAT1 ;SF-ISC/YJK-SUBROUTINE - ASSIGN PAT REF# ,ALD CODE AND CALM CODE SHEET ;12/27/93  11:14 AM
V ;;4.5;Accounts Receivable;**64**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;Assign pat ref # and generate CALM code sheet for new accounts rec.
 ;this is for accounting technician.
 ;Called by ^PRCAPAT
UP442 S DA=PRCHPO,DIE="^PRC(442,",DR=".1///"_DT_";5.1///"_PRCA("DEBTOR")_"" D ^DIE
 Q
DT S %DT="",X="T" D ^%DT S DT=+Y K %DT
 Q
SETAMIS ;set AMIS data for new accounts receivable.
 S PRCAKCAT=$P(^PRCA(430,PRCABN,0),U,2) I PRCAKCAT'=$O(^PRCA(430.2,"AC",21,0)) Q:$P(^PRCA(430.2,PRCAKCAT,0),U,3)<240
 D:'$D(DT) DT S:DT["." DT=$P(DT,".",1) S DIE="^PRCA(430,",DA=PRCABN,DR="16////"_DT_"" D ^DIE K DIE,DA,DR,PRCAKCAT S PRCAMIS=1 Q
DISPL W:$D(IOF) @IOF K DXS D ^PRCATO8 K DXS Q
EDGL ;S DIE="^PRCA(430,",DR="4",DA=PRCABN D ^DIE K DIE,DR,DA Q:$D(Y)
 I '$D(PRCA("SITE")) S PRCA("SITE")=$S($G(PRCABN):$P($P($G(^PRCA(430,PRCABN,0)),"^"),"-"),1:$$SITE^RCMSITE)
 D CP^PRCABIL1
 S DIC="^PRCA(430,"_PRCABN_",2,",DIC(0)="AEQ" D ^DIC Q:+Y'>0  S DA=+Y
 S DIE=DIC,DA(1)=PRCABN,DR="3" D ^DIE K DIE,DR,DA,DIC Q
