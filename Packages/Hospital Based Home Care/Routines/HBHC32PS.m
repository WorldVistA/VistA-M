HBHC32PS ;HPS/DSK - HBH*1.0*32 Post-Install Routine; May 01, 2021@17:43
 ;;1.0;HOSPITAL BASED HOME CARE;**32**;NOV 01, 1993;Build 58
 ;
 ;OUT^XPDMENU - IA #1157  (supported)
 ;BMES^XPDUTL - IA #10141 (supported)
 ;
 Q
EN ;
 ;Place option "HBPC Provider File Report (132)" out of order.
 N HBHCOPT
 S HBHCOPT="HBHCRP8"
 D OUT^XPDMENU(HBHCOPT,"(per patch HBH*1.0*32)")
 D BMES^XPDUTL("Option ""HBPC Provider File Report (132)"" placed ""Out of Order"".")
 Q
