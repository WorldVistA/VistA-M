SD53108P ;ALB/SWO CHECK OPTION SDACS CGATLIST;3.12.97
 ;;5.3;Scheduling,**108**;MAR 26,1997
EN ;FIND OPTION "SDACS CGATLIST"
 D BMES^XPDUTL("Beginning cleanup of Option text")
 S U="^",A1=$O(^DIC(19,"B","SDACS CGATLIST","")) I A1="" D  G EX
 . D BMES^XPDUTL("Option NOT found - no action necessary")
 S A2=$G(^DIC(19,A1,0)) G:A2="" EX
 S A3="capture stop code workload.  Refer to the User manual, Volume II,",A4="Appendix, for further documentation."
 I A3=$G(^DIC(19,A1,1,6,0))&(A4=$G(^DIC(19,A1,1,7,0))) D
 . D BMES^XPDUTL("Correcting text in option: SDACS CGATLIST")
 . S $P(^DIC(19,A1,1,0),U,3)=6,$P(^(0),U,4)=6
 . S ^DIC(19,A1,1,6,0)=$E(A3,1,27)
 . K ^DIC(19,A1,1,7,0)
 E  D
 . D BMES^XPDUTL("Text previously modified.  Site will need to update description manually.")
EX ;CLEAN UP
 K A1,A2,A3,A4,U
 Q
