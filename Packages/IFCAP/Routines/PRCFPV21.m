PRCFPV21 ;WISC/LEM-FMS PV4, PV5 SEGMENTS ;2/2/94  8:57 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
PV4 ;BUILD 'PV4' SEGMENT
 N SEG
 S SEG="^^^^^^^^^^^"
 S ^TMP($J,"PRCPV",3)="PV4^"_SEG_"^~"
 Q
PV5 ;BUILD 'PV5' SEGMENT
 N SEG
 S SEG="^"
 S ^TMP($J,"PRCPV",4)="PV5^"_SEG_"^~"
 Q
