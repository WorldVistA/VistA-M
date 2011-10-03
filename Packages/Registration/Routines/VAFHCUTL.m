VAFHCUTL ;ALB/CM OUTPATIENT UTILITIES ;05/01/95
 ;;5.3;Registration;**91**;Jun 06, 1996
 ;
GETPTR(TYPE) ;
 ;gets pointer pivot entry for outpatient encounter file
 ;while in outpatient event driver
 ;
 ;returns OUTPATIENT ENCOUNTER PTR
 ;
 N OUT
 S OUT=$O(^TMP("SDEVT",$J,SDHDL,TYPE,"SDOE","")) ;outpt encounter ptr
 Q OUT
