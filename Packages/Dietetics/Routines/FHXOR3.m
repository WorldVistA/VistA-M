FHXOR3 ; HISC/NCA - Order Entry Post-Init ;6/17/96  15:36
 ;;5.5;DIETETICS;;Jan 28, 2005
 Q:'$D(^ORD(101,0))
 ; Add OE/RR protocols
 S FHX=$O(^ORD(101,"B","FH EVSEND OR",0)) I 'FHX S NAM="FH EVSEND OR",TXT="Dietetics Send Event Message To OR",TXT1="This protocol is used to send HL7 message to Order Entry 3 or higher from Dietetics." D PKG,AD
 S FHX=$O(^ORD(101,"B","FH RECEIVE",0)) I 'FHX S NAM="FH RECEIVE",TXT="Dietetics Receive OR Event",ACT="D EN^FHWOR(.XQORMSG)",TXT1="This protocol is used to receive HL7 message from Order Entry 3 or higher." D PKG,AD1
 S FHX=$O(^ORD(101,"B","FH ORDERABLE ITEM UPDATE",0))
 I 'FHX S NAM="FH ORDERABLE ITEM UPDATE",TXT="Dietetics Send Orderable Item Update To OR",TXT1="This protocol is used to send orderable item updates HL7 messages to Order Entry 3 or higher from Dietetics." D PKG,AD
 S X=" ;;FH EVSEND OR;OR RECEIVE" D AD2
 S X=" ;;FH ORDERABLE ITEM UPDATE;OR ITEM RECEIVE" D AD2
 S X=" ;;OR EVSEND FH;FH RECEIVE" D AD2
KIL K ACT,DA,DIC,DIE,DIK,DLAYGO,DR,FHX,FHXA,LL,NAM,PKG,TXT,TXT1,TYP,X,Y
 Q
PKG S PKG=$O(^DIC(9.4,"C","FH",0)) Q
AD ; Add extended protocols
 W !?2,"Filing protocol ",NAM
 K DIC S DIC="^ORD(101,",DIC(0)="L",DLAYGO=101,DIC("DR")="1///^S X=TXT;3.5///^S X=TXT1;4///X;12////^S X=PKG",X=NAM D ^DIC K DA,DIC,DLAYGO,X
 Q
AD1 ; Filing the Dietetics Protocols
 W !?2,"Filing protocol ",NAM
 K DIC S DIC="^ORD(101,",DIC(0)="L",DLAYGO=101,DIC("DR")="1///^S X=TXT;3.5///^S X=TXT1;4///A;12////^S X=PKG;20////^S X=ACT",X=NAM D ^DIC K DA,DIC,DLAYGO,X
 Q
AD2 ; Add Dietetic protocol to Order Entry 3
 S DA(1)=$O(^ORD(101,"B",$P(X,";",3),0)) I 'DA(1) K DA Q
 K DIC S:'$D(^ORD(101,DA(1),10,0)) ^(0)="^101.01PA^^"
 S FHX=$O(^ORD(101,"B",$P(X,";",4),0)) I 'FHX Q
 S FHXA=$O(^ORD(101,DA(1),10,"B",FHX,0)) I FHXA Q
 S DIC("DR")="3///1"
 S DIC="^ORD(101,"_DA(1)_",10,",DIC(0)="L",DLAYGO=101,X=$P(X,";",4) D ^DIC
 K DA,DIC
 Q
