PRCIREC ;WISC/SWS-PRCIREC continued ;9/7/06  14:22
V ;;5.1;IFCAP;**113,149**;Oct 20, 2000;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;This routine serves as the input transform for the field Final Charge in File ^PRCH(440.6
 ;PRC*5.1*149 checks the 'PO' index in file 440.6 as the check for order number in 'C' x-ref was not valid order number, but charge returned order info
 Q
START S MYIEN=$P($G(^PRCH(440.6,DA,1)),U) S:'MYIEN MYIEN=$G(PRCRI(442))
 I '$G(MYIEN) Q
 S VALUE2=MYIEN,VALUE3=0,BFLAG=0
 F  S VALUE3=$O(^PRCH(440.6,"PO",VALUE2,VALUE3)) Q:'VALUE3!(BFLAG=1)  D
 .I VALUE3'=DA D
 ..I $P($G(^PRCH(440.6,VALUE3,1)),U,4)="Y" D
 ...S BFLAG=1
 ...K MSG
 ...S MSG(1)="Sorry, there is already a final charge for this PC Order."
 ...S MSG(2)="You need to edit or remove the first final charge to continue."
 ...S MSG(2,"F")="!"
 ...S MSG(3)=""
 ...S MSG(3,"F")="!"
 ...D EN^DDIOL(.MSG)
 ...K MSG,X
 ...S BFLAG=1
 K BFLAG
 Q
