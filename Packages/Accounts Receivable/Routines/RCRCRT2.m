RCRCRT2 ;ALB-ISC/CMS - RC AND DOJ TRANSACTION ROU 2 ;8/15/97
V ;;4.5;Accounts Receivable;**63**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
CAN ;Called from RCRCRT1 ask to Cancel
 N DA,DIC,DIE,DR,PRCAEN,D0,X,Y,%
 W !!
 S %=2 W !,"Do you want to CANCEL this referral to RC/DOJ " D YN^DICN
 I %'=1 W !,"NOTHING CHANGED !",! G CANQ
 S DA=PRCABN,DIE="^PRCA(430,"
 S DR="64///@;65///@;66///@" D ^DIE
 W !,"Bill is no longer Referred! ",!
 S %=2 W !,"Do you want to add a Bill Comment Log entry " D YN^DICN
 I %'=1 W !,"No Bill Comment Log entry added !",! G CANQ
 ;
 D SETTR^PRCAUTL,PATTR^PRCAUTL S DIC="^PRCA(433," K PRCAMT,PRCAD("DELETE")
 S DA=PRCAEN,DR="[PRCA COMMENT]",DIE="^PRCA(433," D ^DIE
 S DR="4////^S X=2" D ^DIE
 W !,"Bill Comment Added!",!
 ;
CANQ Q
 ;
WRDATA ;display the input data in 433 from RCRCRT1
 W !!," Transaction Information for AR Bill No. ",$P(PRCABN0,U,1),"  Tran.No: ",PRCAEN
 W !!," Type: ",PRCAKTY,"        Date: ",PRCAKDT,"      Amount: ",$J(PRCATOT,0,2)
 W !!,"PRIN.BAL.",?13,"INT.BAL.",?27,"ADMIN.BAL.",?42,"MARSHAL FEE",?57,"COURT COST"
 W !,$J(PRCAPB,0,2),?15,$J(PRCAIB,0,2),?28,$J(PRCAAB,0,2),?43,$J(PRCAMF,0,2),?58,$J(PRCACC,0,2),!
 I $P($G(^PRCA(433,PRCAEN,7,0)),U,4)="" G WRDATAQ
 W !,"Transaction Comment: "
 S X=0 F  S X=$O(^PRCA(433,PRCAEN,7,X)) Q:'X  D
 . W !,$G(^PRCA(433,PRCAEN,7,X,0))
 W !
WRDATAQ Q
 ;
WRREF ;Display the current Bill Referral Information called from RCRCRT1
 N REF,REREF,RET,X,Y,%
 W !!,"Current Bill Referral Information:"
 S Y=+PRCADT D D^DIQ S REF=Y
 S Y=+$P(PRCABN6,U,10) D D^DIQ S REREF=Y
 S Y=+$P(PRCABN6,U,11) D D^DIQ S RET=Y
 I REF=0,REREF=0,RET=0 W "   <No Bill Referral Information>",! G WRREFA
 W !!,"Referred to: ",PRCACODE,"   Referral Date: ",$S(REF=0:"",1:REF),"   Referral Amount: $",PRCARAMT
 I REREF'=0 W !,"  Bill was Re-Referred on: ",REREF
 I RET'=0 W !,"  Bill was Returned from RC/DOJ on: ",RET
WRREFA ;
 S %=1 W !!,"Do you want to Continue " D YN^DICN
 I %=2 S RCOUT=1
WRREFQ Q
 ;RCRCRT2
