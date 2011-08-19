BPSOS ;BHAM ISC/FCS/DRS - Table of Contents, etc ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5**;JUN 2004;Build 45
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
TOC N I,X F I=0:1 S X=$P($T(TOC1+I),";",2,9) Q:X="*"  D
 . W X,!
 Q
TOC1 ; Directory of BPSEC* and BPSOS*
 ; BPSECA* - Build formatted claim packets
 ; BPSECFM - Formatting (signed numeric overpunch, etc.)
 ; BPSECM* - Parse Response packets
 ; BPSECX* - Low-level BPS Claims routines, descendant from BPSOSQ2
 ; BPSMHDR - Menu header
 ; BPSNCP* - Callable API to initiate an ECME claim
 ; BPSOS0* - Some fetch utilities for BPS Claims and BPS Responses
 ; BPSOS2x - Statistics Screen
 ; BPSOS57 - Utilities for BPS Log of Transactions
 ; BPSOS6M - Developer Log
 ; BPSOSC2 - Certification utilities (sporadic development use only)
 ; BPSOSCx - Building BPS Claims (BPSOSQ2->QG->CA->C*)
 ; BPSOSH* - Support utilities for packet building
 ; BPSOSI* - BPS Transaction creation
 ; BPSOSK* - Winnowing old data
 ; BPSOSL* - Log file utilities
 ; BPSOSO* - Override NCPDP Data Dictionary values
 ; BPSOSQ* - Claim processing through the queues
 ; BPSOSR* - Queue Processing
 ; BPSOSS* - Setup POS
 ; BPSOSU* - Utilities
 ;*
RXDEL(RXI,RXR) ; EP - $$ is RX deleted?
 ; For refills:  if the refill multiple is gone, it's been "deleted"
 I $G(RXR),$$RXSUBF1^BPSUTIL1(RXI,52,52.1,RXR,.01,"I")="" Q 1
 ; For first fill: look at the STATUS flag
 I $$RXAPI1^BPSUTIL1(RXI,.01,"E")="" Q 1 ; shouldn't be missing but is
 N X S X=$$RXAPI1^BPSUTIL1(RXI,100,"I")
 Q X=13 ; if status is DELETED
ZWRITE(%,VARA,VARB,VARC,VARD,VARE) ;EP - from many, many places
 I %="%"!(%?1"VAR"1U) D  Q
 . D IMPOSS^BPSOSUE("P","TI","Conflict in var names",%,"ZWRITE",$T(+0))
 I '$D(@%) W %," is undefined",! Q
 I $D(@%)#10 W %,"=",@%,!
 F  S %=$Q(@%) Q:%=""  W %,"=",@%,!
 I $D(VARA) D ZWRITE(VARA)
 I $D(VARB) D ZWRITE(VARB)
 I $D(VARC) D ZWRITE(VARC)
 I $D(VARD) D ZWRITE(VARD)
 I $D(VARE) D ZWRITE(VARE)
 Q
