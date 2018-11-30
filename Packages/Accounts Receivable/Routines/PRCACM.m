PRCACM ;WASH-ISC@ALTOONA,PA/RGY-COMMENT ADJUSTMENT TRANSACTION ;6/2/95  2:41 PM
 ;;4.5;Accounts Receivable;**8,67,125,169,254**;Mar 20, 1995;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; DBIA 3820-A used for direct global read into file 399.
 ;
 ;This is a routine for adjustment transaction.
 NEW PRCABN,PRCAEN,PRCAA1,DR,DIE,DA,D0,PRCAD,RCASK,PRCAA2,DIROUT,DIRUT,DIR,DUOUT,PRCA,PRCATY
ADJUST D BEGIN G:('$D(PRCABN))!('$D(PRCAEN)) Q
 S PRCAA1=$S($D(^PRCA(433,PRCAEN,4,0)):+$P(^(0),U,4),1:0) G Q:PRCAA1'>0 S PRCAA2=$P(^(0),U,3) W !
DIE S DR="[PRCA COMMENT]",DIE="^PRCA(433,",DA=PRCAEN D ^DIE K DIE,DR,DA
 I $P($G(^PRCA(433,PRCAEN,5)),"^",2)=""!'$P(^PRCA(433,PRCAEN,1),"^") S PRCACOMM="TRANSACTION INCOMPLETE" D DELETE^PRCAWO1 K PRCACOMM G:$D(DTOUT) Q G ADJUST
 W ! W:$D(IOF) @IOF S D0=PRCAEN K DXS D ^PRCATO4 K DXS
 I $P($G(^PRCA(433,PRCAEN,1)),"^")>$P($G(^(5)),"^",3),$P($G(^(5)),"^",3) W !!,*7,"You entered a date of follow-up before the date of contact!" S PRCACOMM="INVALID FOLLOW-UP DATE" D DELETE^PRCAWO1 K PRCACOMM G ADJUST
ASK S %=2 W !!,"Is this correct" D YN^DICN I %=0 W !,"Answer 'Y' or 'YES' if this data is correct, answer 'N' or 'NO' if not",! G ASK
 I (%<0)!(%=2) S PRCACOMM="USER CANCELED" D DELETE^PRCAWO1 K PRCACOMM G ADJUST
DONE I '$D(PRCAD("DELETE")) S RCASK=1 D TRANUP^PRCAUTL,UPPRIN^PRCADJ
 I $P($G(^RCD(340,+$P(^PRCA(430,PRCABN,0),"^",9),0)),"^")[";DPT(" D
 .S $P(^PRCA(433,PRCAEN,0),"^",10)=1
 .S DIR(0)="Y",DIR("A")="Should the BRIEF COMMENT print on the patient statement",DIR("B")="NO" D ^DIR K DIR
 .I Y=1 S DIR(0)="Y",DIR("A")="Are you SURE this BRIEF COMMENT should appear on the patient statement",DIR("B")="NO" D ^DIR K DIR I Y=1 D
 ..W !!,*7,"*** OK, This comment will appear on the patient's statement! ***",!,"(If you change your mind, use the option Remove/Add Comment From Patient Statement)",!
 ..S $P(^PRCA(433,PRCAEN,0),"^",10)=""
 ..Q
 .Q
 G ADJUST
Q Q
EN1 Q:'$D(PRCABN)
 NEW X
 F X=0:0 S X=$O(^PRCA(433,"C",PRCABN,X)) Q:'X  I $P($G(^PRCA(433,X,1)),"^",4) I $P(^(1),"^",2)=1!($P(^(1),"^",2)=35) S PRCAQNM=$P(^(1),"^",4)+1
 Q
ASK1 ;ASK FOR STATUS
 NEW DTOUT,DUOUT,DIRUT,DIR,DIROUT
 S DIR("A")="Change 'BILL' status to?",DIR("B")="CANCELLED",DIR(0)="SB^1:CANCELLED;2:COLLECTED/CLOSED;" D ^DIR K DIR
 I Y=2 S PRCA("STATUS")=$O(^PRCA(430.3,"AC",108,0))
 Q
RPT ;
 NEW %DT,BEG,END,DIC,L,FR,TO,FLDS,PRCACM,POP,PRCADEV
ST W !! S %DT="AEX",%DT("A")="Follow-up Date(s) From: " D ^%DT G:Y<0 REPQ S BEG=Y
 S %DT="AEX",%DT("A")="Follow-up Date(s)   To: " D ^%DT G:Y<0 REPQ S END=Y
 I BEG>END W !!,*7,"  (Ending date must be greater than Start date.)" G ST
 S %ZIS="MQ" D ^%ZIS G:POP REPQ S PRCADEV=ION_";"_IOST_";"_IOM_";"_IOSL_";"_$G(IO("DOC"))
 I $D(IO("Q")) S Y=$$TI() G:Y<0 REPQ F PRCACM=1,2 S ZTDTH=$H,ZTRTN="DQ"_PRCACM_"^PRCACM",ZTSAVE("BEG")="",ZTSAVE("PRCADEV")="",ZTSAVE("END")="",ZTDESC="Comment Follow-up List" D ^%ZTLOAD G REPQ:PRCACM=2
 D DQ1,DQ2:'$D(DTOUT)
REPQ Q
DQ1 ;
 S IOP=PRCADEV,DIC="^PRCA(433,",L=0,BY="[PRCA FOLLOW-UP]",FLDS="[PRCA FOLLOW-UP]",FR=BEG,TO=END D EN1^DIP
 D ^%ZISC K IOP
 I $E(IOST)="C" W !,*7,"OK, first part of report complete...",!,"press return to continue: " R X:DTIME W @IOF S:X["^"!'$T DTOUT=1
 Q
DQ2 ;
 S IOP=PRCADEV D ^%ZIS
 I 'POP S IOP=PRCADEV,DIC="^RC(341,",L=0,BY="[RCAM COMMENT]",FLDS="[RCAM COMMENT]",FR=BEG,TO=END D EN1^DIP
 D ^%ZISC K IOP
 Q
TI() ;
 N %DT D NOW^%DTC S %DT("A")="Request Time to Queue? ",%DT("B")="NOW"
 S %DT="AERX",%DT(0)=% D ^%DT
 Q Y
BEGIN K PRCATERM,PRCABN,PRCAEN,PRCA("CKSITE"),PRCAIBS D BILL^PRCAUTL Q:('$D(PRCABN))
 S PRCAIBS=$P($G(^DGCR(399,PRCABN,0)),U,13)        ; IB claim status - DBIA3820-A
 I PRCAIBS=1 W !!,"**  You cannot add AR Comments to an Entered/Not Reviewed claim.  **",!,*7 G BEGIN
 I PRCAIBS=2 W !!,"**  You cannot add AR Comments to an MRA Request claim.  **",!,*7 G BEGIN
 I '$D(^PRCA(430,PRCABN,2,0)),PRCAIBS=7 W !!,"**  You cannot add AR Comments to a claim Cancelled/not passed to AR.  **",!,*7 G BEGIN
 I $P($G(^PRCA(430,PRCABN,0)),"^",8)=49 W !!,"**  Comments CANNOT be entered on an ARCHIVED bill.  **",!,*7 G BEGIN
 D SETTR^PRCAUTL,PATTR^PRCAUTL S DIC="^PRCA(433," K PRCAMT,PRCAD("DELETE") Q
