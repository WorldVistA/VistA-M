PRCFFUA3 ;WISC/SJG-ROUTINE TO PROCESS OBLIGATIONS CONT ;6/13/94  14:34
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ; Allows Fiscal to edit BOCs prior to PO amendment obligation
 ; only the BOCs on the amendment can be edited
 ; Message processing routine
 ;
MSG1 K MSG W !! S MSG="...now recalculating FMS accounting lines..." D EN^DDIOL(MSG) K MSG W !
 Q
MSG2 K MSG W !! S MSG(1)="...Cost Center is missing - cannot continue..."
MSG21 S MSG(2)=" ",MSG(3)="No further action is being taken on this obligation."
 D EN^DDIOL(.MSG) K MSG W !
 Q
MSG3 K MSG W !! S MSG(1)="BOC '"_SA_"' is not valid with Cost Center "_$P(PO(0),U,5)_".",MSG(2)="Please ensure that this BOC is properly linked with the Cost Center."
 D EN^DDIOL(.MSG) K MSG W !
 Q
MSG4 W !! S DIR(0)="Y",DIR("A",1)="I will now enter BOC '"_SA_"' on all line items.",DIR("A")="Is this OK",DIR("B")="YES"
 D ^DIR K DIR
 Q
MSG5 K MSG W !! S MSG="...now changing the BOCs on all line items..."
 D EN^DDIOL(MSG) K MSG W !
 Q
MSG6 I (BOCEDIT=1)!(ESHEDIT=1) Q
 K MSG W !
 S:BOCEDIT=0 MSG(1)="BOC has not changed.",MSG(2)=" "
 S MSG(3)="No further editing is being done on this obligation.",MSG(4)=" "
 S MSG(5)="...returning to the Amendment Obligation processing..."
 D EN^DDIOL(.MSG) K MSG W !
 Q
MSG7 K MSG W !! S MSG(1)="BOCs cannot be edited for Supply Fund orders."
 S MSG(2)=" "
 S MSG(3)="...returning to the Amendment Obligation processing..."
 D EN^DDIOL(.MSG) K MSG
 Q
MSG8 K MSG W !!
 S MSG(1)="For Purchase Order amendments, only the BOCs for the amended items"
 S MSG(2)="can be edited at this time.  To edit the Cost Center or BOCs on other"
 S MSG(3)="items requires that the amendment be returned to Supply for these"
 S MSG(4)="changes to be made."
 D EN^DDIOL(.MSG) K MSG
 Q
MSG9 W ! D EN^DDIOL("...returning to the Amendment Obligation processing...") W !
 Q
MSG10 K MSG W !!
 S MSG(1)="A BOC for Estimated Shipping and/or Handling already exists and may have been"
 S MSG(2)="established in FMS under the original Purchase Order obligation or a previous"
 S MSG(3)="Purchase Order amendment.  According to FMS, once established, the BOC for"
 S MSG(4)="Estimated Shipping and/or Handling cannot be changed.",MSG(4.5)=" "
 S MSG(5)="Changing the Estimated Shipping and/or Handling BOC on an amendment"
 S MSG(6)="will cause this document to reject."
 D EN^DDIOL(.MSG) W ! K MSG
 Q
MSG11 K MSG W !!
 S MSG(1)="Estimated Shipping BOC on original Purchase Order:"
 S MSG(2)="    "_OESHBOC
 S MSG(3)="Estimated Shipping BOC for this amendment on Purchase Order:"
 S MSG(4)="    "_AESHBOC,MSG(4.5)="  "
 S MSG(5)="Since the Estimated Shipping BOCs are different, further processing"
 S MSG(6)="of the amendment for this Purchase Order cannot continue!",MSG(6.5)="  "
 S MSG(7)="The amendment must be returned to Supply!"
 D EN^DDIOL(.MSG) K MSG W !
 Q
