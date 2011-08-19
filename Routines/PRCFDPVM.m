PRCFDPVM ;WISC/LEM-PAYMENT ERROR PROCESSING MESSAGES ;6/9/94  3:05 PM
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
V ;
 QUIT
 ; No top level entry
 ;
MSG1 ; Message Processing
 W !!,"This document is not a Payment Voucher (PV), Miscellaneous Order (MO) or a",!,"Service Order (SO).  Error processing cannot continue using this routine.",!!
 Q
MSG2 W !!,"This Payment Voucher or 1358 source document was not found.  Error processing",!,"cannot continue."
 Q
MSG3 W !!,"The Method of Processing is missing.  Error processing cannot continue.",!!
 Q
MSG4 W !!,"No further action taken on this rejected document.",!!
 Q
