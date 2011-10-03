FBAABDL ;AISC/DMK-DELETE A BATCH ;23JUL93
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;This routine allows the deletion of a batch that has no line
 ;items associated with it.  Access is restricted to the user
 ;who opened the batch or the holder of the 'FBAASUPERVISOR'
 ;security key.
BT ;select batch
 S FBNO=1
 W ! S DIC="^FBAA(161.7,",DIC(0)="AEQZ",DIC("S")=$S($D(^XUSEC("FBAASUPERVISOR",DUZ)):"",1:"I $P(^(0),U,5)=DUZ")
 D ^DIC K DIC G END:X=""!(X="^") G BT:Y<0 S FBBAT=+Y,FBBAT(0)=Y(0)
 ;
 ;reset batch line count and total dollars first
 I $G(FBBAT) N FBTOTAL,FBLCNT D
 .  D CNTTOT^FBAARB(FBBAT) S DA=FBBAT,DIE="^FBAA(161.7,",DR="10////^S X=FBLCNT;8////^S X=FBTOTAL;S:FBLCNT!(FBTOTAL) Y="""";9///@" D ^DIE K DIE,DR,DA D
 ..S:FBTOTAL=0 $P(^FBAA(161.7,+FBBAT,0),U,9)=""
 ..S:FBLCNT=0 $P(^FBAA(161.7,+FBBAT,0),U,11)=""
 . S FBBAT(0)=^FBAA(161.7,+FBBAT,0)
 ;
 ;check to see if batch meets criteria for deletion
 ;Total Dollars '>0        Invoice Count '>0
 ;Payment Line Count '>0        Rejects Pending flag '= "Y"
 ;
 F I=9,10,11 I $P(FBBAT(0),U,I)>0 W !!?5,$P($T(NOGO+(I-8)),";;",2) S FBNO=0 D END G BT
 ;check to see if any invoices point to batch
 S FBTYPE=$P(^FBAA(161.7,FBBAT,0),"^",3) I $S(FBTYPE="B3":$D(^FBAAC("AC",FBBAT)),FBTYPE="B5":$D(^FBAA(162.1,"AE",FBBAT)),FBTYPE="B9":$D(^FBAAI("AC",FBBAT)),FBTYPE="B2":$D(^FBAAC("AD",FBBAT)),1:0) D  D END G BT
 .W !!?5,$P($T(NOGO+5),";;",2)
 I $P(FBBAT(0),U,17)="Y" W !!?5,$P($T(NOGO+4),";;",2) S FBNO=0 D END G BT
 ;display batch and ask if sure want to delete
 W !! S DIC="^FBAA(161.7,",DA=FBBAT,DR="0;ST" D EN^DIQ K DIC,DR,DA
 ;
 S DIR(0)="Y",DIR("B")="No",DIR("A")="Sure you want to DELETE this batch" D ^DIR K DIR S:'Y FBNO=0
 I $D(DIRUT)!('Y) D END G BT
 ;
 ;delete batch
 I $G(FBNO) S DA=FBBAT,DIK="^FBAA(161.7," D ^DIK K DIK
 W !!?5,*7,"Batch Deleted.",!
 D END G BT
 ;
END K DA,I,FBBAT,FBNO,X,Y,FBTYPE Q
 ;
NOGO ;reasons why batch cannot be deleted
 ;;TOTAL DOLLARS in batch is greater than zero.
 ;;INVOICE COUNT in batch is greater than zero.
 ;;PAYMENT LINE COUNT in batch is greater than zero.
 ;;REJECTS PENDING flag in batch is set to 'YES'.
 ;;Batch has INVOICES associated with it.
