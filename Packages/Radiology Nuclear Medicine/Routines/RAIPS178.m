RAIPS178 ;;WOIFO/KLM-PostInit 178; Jan 21, 2021@10:57:38
 ;;5.0;Radiology/Nuclear Medicine;**178**;Mar 16, 1998;Build 2
 ;
 ;This post-init routine will index the "ACM" cross reference
 ;on the CREDIT METHOD (#21) field of the IMAGING LOCATIONS (#79.1) file.
 ;
EN ;Entry point
 N DIK
 K ^RA(79.1,"ACM") ;Kill it first for kicks
 S DIK="^RA(79.1,"
 S DIK(1)="21^ACM" ;CREDIT METHOD "ACM" new xref
 D ENALL^DIK
 Q
