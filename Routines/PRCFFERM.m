PRCFFERM ;WISC/SJG-OBLIGATION ERROR PROCESSING MESSAGES ;7/24/00  23:19
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT
 ; No top level entry
 ;
MSG1 ; Message Processing
 W !!,"This document is not a Miscellaneous Order (MO) or a Service Order (SO).",!,"Error processing cannot continue using this routine.",!!
 Q
MSG2 W !!,"This Purchase Order or 1358 source document is not found.  Error processing",!,"cannot continue."
 Q
MSG3 W !!,"The Method of Processing is missing.  Error processing cannot continue.",!!
 Q
MSG4 W !!,"No further action taken on this rejected document.",!!
 Q
MSG5 K MSG N TYPE
 S TYPE=$S(MOP=1:"a Purchase Order.",MOP=2:"a Certified Invoice.",MOP=3:"a Payment in Advance.",MOP=4:"a Guaranteed Delivery.",MOP=7:"an Imprest Fund.",MOP=8:"a Requistion.",MOP=26:"a Direct Delivery.",21:"a 1358 Miscellaneous Obligation.")
 S MSG(1)="This FMS Document is "_TYPE
 I ("^1^2^3^4^7^8^26^"[("^"_MOP_"^")) S MSG(2)="Use the option to process MOs and SOs."
 I MOP=21 S MSG(2)="Use the option to process SOs."
 D EN^DDIOL(.MSG) K MSG
 Q
