HLP14PRE ;SFIRMFO/JC - HL7 PATCH 14 PRE-INIT ;03/05/98  11:44
 ;;1.6;HEALTH LEVEL SEVEN;**14**;Oct 13, 1995
PRE ;
 K ^DD(779.001,0,"ID")
 K ^DD(771.2,0,"ID")
 Q
POST ;
 S ^DD(779.001,0,"ID",2)="W "_""""_"   "_""""_",$P(^(0),U,2)"
 S ^DD(771.2,0,"ID",2)="W "_""""_"   "_""""_",$P(^(0),U,2)"
 Q
