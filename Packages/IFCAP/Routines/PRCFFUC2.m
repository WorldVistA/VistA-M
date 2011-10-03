PRCFFUC2 ;WISC/SJG-UTILITY ROUTINE FOR HOLD FUNCTIONALITY ;7/24/00  23:13
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Edit checking accounting period, obligation processing date, etc.
CHK1    ; Check for earlier accounting periods
 N CUR,NEW
 S CUR=$P(PRCFA("CURRENT"),U,3),NEW=$P(PRCFA("ACCPD"),U,3)
 Q:CUR=NEW  Q:CUR<NEW
 I CUR>NEW D M1
 Q
CHK2    ; Check for accounting period/obligation processing
 N APCK,NEW
 S APCK=$P(PRCFA("ACCPDCK"),U,3),NEW=$P(PRCFA("ACCPD"),U,3)
 Q:APCK=NEW
 I APCK>NEW!(APCK<NEW) D M2
 Q
M ; Message Processing
M1 D LN K MSG
 S MSG(1)="WARNING:  The Accounting Period selected is earlier than the current"
 S MSG(2)="the Accounting Period!  Sending this document to FMS with this Accounting"
 S MSG(3)="Period may cause the document to reject with a Closed Accounting Period error!"
 D EN^DDIOL(.MSG) K MSG D LN
 Q
M2 ;
 N YY S YY=$$DATE^PRC0C(PRCFA("OBLDATE"),"I"),YY=$$TRANS^PRCFFUC(YY)
 W ! K MSG D LN
 S MSG(1)="WARNING:  There may be an Obligation Processing Date/Accounting Period"
 S MSG(2)="mismatch!  The Obligation Processing Date ("_YY_") does not fall into"
 S MSG(3)="the selected Accounting Period ("_$P(PRCFA("ACCPD"),U)_") for "_$P(PRCFA("ACCPD"),U,2)_"."
 S MSG(4)="  "
 S:APCK>NEW MM="precedes" S:APCK<NEW MM="follows"
 S MSG(5)="The Accounting Period "_MM_" the Obligation Processing Date."
 S MSG(6)="  ",MSG(7)="Please be sure that the appropriate Accounting Period has been"
 S MSG(8)="chosen for this transaction before proceeding with this obligation."
 D EN^DDIOL(.MSG) K MSG D LN
 D TABLE I Y D H2^PRCFFUC1 W !
 Q
TABLE ; Set up call to display help table
 N DIR S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="the calendar month and its fiscal month"
 S DIR("A",1)="Do you wish to display a table showing the relationship between"
 W ! D ^DIR K DIR
 Q
LN ; Write out a line of asterisks
 W ! S $P(LN,"*",80)="" W LN Q
