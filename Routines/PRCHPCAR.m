PRCHPCAR ;WISC/AKS-Front End questions for Purchase Card processes ;6/9/96  21:40
 ;;5.1;IFCAP;**113**;Oct 20, 2000;Build 4
 ;Per VHA Directive 2004-038, this routine should not be modified.
ASKPO ;Ask If they are processing a purchase or a requisition
 N DIR,Y,PRCHPR,PRCHNE
 S DIR(0)="SO^P:PURCHASE ORDER;R:REQUISITION"
 S DIR("A")="Select THE TYPE OF ORDER"
 D ^DIR Q:Y']""!(Y["^")  S PRCHPR=Y
ENTED ;Ask if they are entering or editting
 S DIR(0)="SO^N:NEW;E:EDIT AN EXISTING ORDER"
 S DIR("A")="Select TYPE OF PROCESSING"
 D ^DIR G:Y']"" ASKPO Q:Y["^"  S PRCHNE=Y
 I $G(PRCHPR)="P"&(PRCHNE="N") D EN5^PRCHE Q
 I $G(PRCHPR)="P"&(PRCHNE="E") D EN6^PRCHE Q
 I $G(PRCHPR)="R"&(PRCHNE="N") D EN3^PRCHEA Q
 I $G(PRCHPR)="R"&(PRCHNE="E") D EN4^PRCHEA Q
 I '$D(PRCHPR)&(PRCHNE="N") D EN5^PRCHE Q
 I '$D(PRCHPR)&(PRCHNE="E") D EN6^PRCHE Q
 QUIT
AMPO ;ask if they are amending a po or a requisition
 N DIR,Y
 S DIR(0)="SO^P:AMEND A PURCHASE ORDER;R:AMEND A REQUISITION"
 S DIR("A")="Select THE TYPE OF ORDER"
 D ^DIR
 I Y="P" D PO^PRCHMA Q
 I Y="R" D REQ^PRCHMA Q
 QUIT
ADJPO ;ask if they are adjusting a po or requisition
 N DIR,Y
 S DIR(0)="SO^P:Adjustment Voucher to a PO;R:Adjustment Voucher to a Requisition"
 S DIR("A")="Select THE TYPE OF ORDER"
 D ^DIR
 I Y="P" D EN14^PRCHE Q
 I Y="R" D EN2^PRCHEB Q
 QUIT
DIRPO ;Ask type of amendments for purchase card and delivery orders
 ;
 N PRCHTYPE,DIR
 S PRCHTYPE=$P($G(^PRC(442,PRCHPO,23)),U,11)
 Q:PRCHTYPE=""
 S:PRCHTYPE="S" DIR(0)="SO^1:F.C.P. Edit;2:Change VENDOR;3:AUTHORITY Edit;4:LINE ITEM Edit"
 S:PRCHTYPE="P" DIR(0)="SO^1:F.C.P. Edit;2:Change VENDOR;3:AUTHORITY Edit;4:LINE ITEM Add;5:LINE ITEM Delete;6:LINE ITEM Edit;7:F.O.B. Point"
 S:PRCHTYPE="D" DIR(0)="SO^1:Change VENDOR;2:AUTHORITY Edit;3:LINE ITEM Add;4:LINE ITEM Delete;5:LINE ITEM Edit;6:F.O.B. Point;7:SHIP TO Edit;8:Edit MAIL INVOICE TO;9:EST. SHIPPING Edit;10:PROMPT PAYMENT Edit"
 S DIR("A")="Select TYPE OF AMENDMENT NUMBER"
 D ^DIR
 I PRCHTYPE="S" S:$G(Y)=4 Y=6
 I PRCHTYPE="D",$G(Y) S Y=Y+1
 S Y=$S(Y=1:30,Y=2:31,Y=3:34,Y=4:21,Y=5:22,Y=6:23,Y=7:35,Y=8:20,Y=9:25,Y=10:29,Y=11:33,1:-1)
 QUIT
DIRREQ ;Ask type of amendments for purchase card and delivery orders
 ;
 N PRCHTYPE,DIR
 S PRCHTYPE=$P($G(^PRC(442,PRCHPO,23)),U,11)
 Q:PRCHTYPE=""
 S:PRCHTYPE="S" DIR(0)="SO^1:F.C.P. Edit;2:Change FEDERAL VENDOR"
 S:PRCHTYPE="P" DIR(0)="SO^1:F.C.P. Edit;2:Change FEDERAL VENDOR;3:LINE ITEM Add;4:LINE ITEM Delete;5:LINE ITEM Edit"
 S:PRCHTYPE="D" DIR(0)="SO^1:Change FEDERAL VENDOR;2:LINE ITEM Add;3:LINE ITEM Delete;4:LINE ITEM Edit;5:SHIP TO Edit;6:Edit MAIL INVOICE TO;7:EST. SHIPPING Edit"
 S DIR("A")="Select TYPE OF AMENDMENT NUMBER"
 D ^DIR
 I PRCHTYPE="D",$G(Y) S Y=Y+1
 S Y=$S(Y=1:30,Y=2:31,Y=3:21,Y=4:22,Y=5:23,Y=6:20,Y=7:25,Y=8:29,1:-1)
 QUIT
CANPC ;Cancel a purchase card order
 W ! S DIC="^PRC(442,",DIC(0)="AEQM"
 S DIC("A")="Select PURCHASE CARD ORDER NUMBER: "
 S DIC("S")="I $P($G(^(7)),U,2)<9,$P($G(^(1)),U,10)=DUZ,$P($G(^(0)),U,2)=25,($P($G(^(23)),U,11)=""P""!($P($G(^(23)),U,11)=""S""))"
 D ^DIC Q:+Y<0  K DIC
 S %A="Are sure you want to cancel this order",%B="",%=2
 D ^PRCFYN I %<1!(%=2) K %A,%B,% Q
 S DA=+Y,DIE="^PRC(442,",DR=".5///^S X=45" D ^DIE K DIE,DR
 D C2237^PRCH442A
 K DA,%A,%B,%
 QUIT
CANDO ;Cancel a delivery order
 W ! S DIC="^PRC(442,",DIC(0)="AEQM"
 S DIC("A")="Select DELIVERY ORDER NUMBER: "
 S DIC("S")="I $P($G(^(7)),U,2)<9,$P($G(^(23)),U,11)=""D"""
 D ^DIC Q:+Y<0  K DIC
 S %A="Are sure you want to cancel this order",%B="",%=2
 D ^PRCFYN I %<1!(%=2) K %A,%B,% Q
 S DA=+Y,DIE="^PRC(442,",DR=".5///^S X=45" D ^DIE K DIE,DR
 D C2237^PRCH442A
 K DA,%A,%B,%
 QUIT
AOCANPC ;Approving Official Cancel a purchase card order
 N DIC,Y,NREC,X
 W ! S DIC="^PRC(442,",DIC(0)="AEQM"
 S DIC("A")="Select PURCHASE CARD ORDER NUMBER: "
 S DIC("S")="I $P($G(^(7)),U,2)<9,$P($G(^(0)),U,2)=25,($P($G(^(23)),U,11)=""P""!($P($G(^(23)),U,11)=""S""))"
 D ^DIC Q:+Y<0  K DIC
 S %A="Are sure you want to cancel this order",%B="",%=2
 D ^PRCFYN I %<1!(%=2) K %A,%B,% Q
 S DA=+Y,DIE="^PRC(442,",DR=".5///^S X=45" D ^DIE K DIE,DR
 D C2237^PRCH442A
 K DA,%A,%B,%
 QUIT
