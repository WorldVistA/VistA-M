PRCFFU15 ;WISC/SJG-1358 & PO OBLIGATION UTILITY, CONT ;8/15/94  17:47
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; No top level entry
 QUIT
 ;
VENCONO(IEN) ; Display vendor and contract information on org entry
 ; IEN - Internal entry number from 410
 K PRCTMP N VENDOR
DISP S (VENDOR,CONT,CONTEND,VENCONT,CONTIEN)=""
 D GENDIQ^PRCFFU7(410,IEN,"11;12;13;52","IEN","")
 S VENDOR=$G(PRCTMP(410,IEN,11,"E"))
 I VENDOR]"" W !,IOINLOW,"VENDOR: ",IOINHI,VENDOR,IOINORM,!
 S CONT=$G(PRCTMP(410,IEN,13,"E")) Q:CONT=""
 I CONT]"" D CONTNUM Q:CONTEND=""
 I CONTEND]"" D
 .W IOINLOW,"CONTRACT: ",IOINHI,CONT,IOINORM,!
 .W IOINLOW,"CONTRACT ENDING DATE: ",IOINHI,CONTEND,IOINORM,!
 Q
VENCONM(IEN) ; Display vendor and contract information on adjustment
 ; IEN - Internal entry number from 442
 K PRCTMP N VENDOR,PRRQST
 D GENDIQ^PRCFFU7(442,+PO,.07,"I","")
 S PRRQST=$G(PRCTMP(442,+IEN,.07,"I"))
 Q:PRRQST=""
 I PRRQST]"" S POIEN=IEN,IEN=PRRQST D DISP
 Q
POVENO(IEN) ; Display vendor and contract information
 ; IEN - Internal entry number from 442
 K PRCTMP N VENNM,VENIEN
 D GENDIQ^PRCFFU7(442,IEN,5,"IEN","")
 S VENNM=$G(PRCTMP(442,IEN,5,"E")),VENIEN=$G(PRCTMP(442,IEN,5,"I"))
 I VENNM]"" W !,"VENDOR: ",VENNM,!
 I '$D(^PRC(442,+IEN,2,"AC")) W "CONTRACT:  ** NONE ON THIS ORDER **",!
PO1 I $D(^PRC(442,+IEN,2,"AC")) D  W !
 .S (PRCFMOD,NEWADD)=0
 .W ! K MSG S MSG(1)="One or more of the following contracts are associated with the line items"
 .S MSG(2)="on this Purchase Order for Services for this Vendor: "
 .D EN^DDIOL(.MSG) K MSG
 .S CONT="" F  S CONT=$O(^PRC(442,+IEN,2,"AC",CONT)) Q:CONT=""  D ADDCONT
 .K PRCFMOD,NEWADD
 .Q
PO2 I $D(^PRC(443.6,+IEN,2,"AC")),$P(PRCFA("MOD"),U)="M" D  W !
 .S PRCFMOD=1,NEWADD=0
 .W ! K MSG S MSG(1)="The Amendment has added line items which contain one or more of the following"
 .S MSG(2)="contracts to this Purchase Order for Services:"
 .D EN^DDIOL(.MSG) K MSG
 .S CONT="" F  S CONT=$O(^PRC(443.6,+IEN,2,"AC",CONT)) Q:CONT=""  D ADDCONT
 .D:NEWADD=0 EN^DDIOL("  ** NO NEW CONTRACTS ADDED THROUGH THE AMENDMENT  **")
 .K PRCFMOD,NEWADD
 .Q
 Q
ADDCONT ;
 S DIC="^PRC(440,"_VENIEN_",4,",DIC(0)="MNZ",X=CONT D ^DIC K DIC Q:Y<0
 I Y>0 D
 .N DA,CONTIEN,CONTEND S CONTIEN=+Y
 .S DIC=440,DR=6,DA=VENIEN,DIQ="PRCTMP(",DIQ(0)="IEN",DR(440.03)=".5;1",DA(440.03)=CONTIEN D EN^DIQ1 K DIC,DIQ,DR
 .S CONTENDE=$G(PRCTMP(440.03,CONTIEN,1,"E")),CONTENDI=$G(PRCTMP(440.03,CONTIEN,1,"I"))
 .I PRCFMOD=1 Q:$D(CONTENDA(9999999-CONTENDI))  S NEWADD=1
 .S CONTENDA(9999999-CONTENDI)=CONTENDE_U_CONTENDI
 .W !?2,"CONTRACT: ",CONT,?33,"END DATE: ",CONTENDE,?56,"START DATE: ",$G(PRCTMP(440.03,CONTIEN,.5,"E")) W:$G(PRCTMP(440.03,CONTIEN,.5,"E"))="" "NONE LISTED"
 .Q
 Q
MSG1 ; Display current auto accrual information for PO
 K MSG W ! N FIL S FIL=$$FILE^PRCFFU16
 S MSG(1)="CURRENT VALUES FOR AUTO ACCRUAL FOR P.O. SERVICE ORDER:"
 S MSG(2)="  ENDING DATE FOR SERVICE: "_$G(PRCTMP(FIL,+OB,29,"E"))
 S MSG(3)="  AUTO ACCRUAL FLAG: "_$G(PRCTMP(FIL,+OB,30,"E"))
 D EN^DDIOL(.MSG) K MSG
 Q
MSG2 ; Prompt for change if needed
 N TAG S TAG=$$LABEL
 K MSG W !! S MSG(1)="The Ending Date and the Auto Accrual Flag must now be entered for"
 S MSG(2)="this obligation.  The system will default to the Ending Date on the Vendor"
 S MSG(3)="Contract from the "_TAG_", if available.  Otherwise, the default Ending"
 S MSG(4)="Date is the last date of the current month.",MSG(5)="  "
 S MSG(6)="The Auto Accrual Flag tells FMS whether the "_TAG_" should be accrued."
 S MSG(7)="The default value will be 'NO' if the Ending Date is within the same month."
 S MSG(8)="To accrue the "_TAG_", change the flag to 'YES'."
 D EN^DDIOL(.MSG) K MSG
 Q
CONTNUM ; Determine contract number
 I $G(PRCTMP(410,IEN,11,"E"))="" Q
 I $G(PRCTMP(410,IEN,13,"I"))]"" D
 .S VENID=$G(PRCTMP(410,IEN,12,"I")) Q:VENID=""
 .S VENCONT=$G(PRCTMP(410,IEN,13,"I"))
 .S DIC="^PRC(440,"_VENID_",4,",DIC(0)="MNZ",X=VENCONT D ^DIC K DIC
 .Q:Y<0  I Y>0 D
 ..N DA S CONTIEN=+Y
 ..S DIC=440,DR=6,DA=+VENID,DIQ="PRCTMP(",DIQ(0)="IEN",DR(440.03)=".5;1",DA(440.03)=CONTIEN D EN^DIQ1 K DIC,DIQ,DR
 ..S CONTEND=$G(PRCTMP(440.03,CONTIEN,1,"E"))
 ..Q
 .Q
 Q
 ;
MSG5 ; Exit message
 W ! D EN^DDIOL("Returning to Obligation processing...") W !
 Q
LABEL() ; Determine label for messages
 S LABEL=""
 I '$D(PRCFA("MP")) S LABEL=""
 I $D(TRNODE(0)) I $P(TRNODE(0),U,2)="O"!($P(TRNODE(0),U,2)="A") S LABEL="1358"
 I $D(PRCFA("MP")),PRCFA("MP")=21 S LABEL="1358"
 I $D(PRCFA("MP")),PRCFA("MP")=2 S LABEL="Purchase Order"
 Q LABEL
