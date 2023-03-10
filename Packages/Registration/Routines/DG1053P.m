DG1053P ;MNT/BJR - REINSTATE DGRU INPT PROTOCOL ; Apr 12, 2021@15:56
 ;;5.3;Registration;**1053**;Aug 13, 1993;Build 4
 ;
 Q
 ;References to $$ADD^XPDPROT supported by ICR #5567
 ;References to OUT^XPDPROT supported by ICR #5567
 ;References to BMES^XPDUTL supported by ICR #10141
 ;
 ;
EN ;Entry point for DG*5.3*1053 Post Install routine
 D ENPROT
 D ADDPROT
 Q
ADDPROT ;Delete Protocol from List Protocol
 N DGOM,DGMN,DGPROT,DGCHK,DGOP,DGTEXT,XQORM
 F DGOM=1:1 S DGMN=$P($TEXT(MENLST+DGOM),";;",2) Q:DGMN="$$END"  D
 .F DGOP=1:1 S DGPROT=$P($TEXT(PROLST+DGOP),";;",2) Q:DGPROT="$$END"  D
 ..S DGCHK=$$ADD^XPDPROT(DGMN,DGPROT,,5)
 ..I DGCHK S DGTEXT="The "_DGPROT_" protocol has been added to the "_DGMN_" protocol menu." D BMES^XPDUTL(DGTEXT)
 ..I 'DGCHK S DGTEXT="The "_DGPROT_" protocol could not be added the "_DGMN_" protocol menu." D BMES^XPDUTL(DGTEXT)
 Q
 ;
ENPROT ;Enable Protocols
 N DGPRTL,DGPR,DGTEXT
 F DGPR=1:1 S DGPRTL=$P($TEXT(ADDLST+DGPR),";;",2) Q:DGPRTL="$$END"  D
 .D OUT^XPDPROT(DGPRTL,"@")
 .S DGTEXT="The "_DGPRTL_" protocol has been enabled." D BMES^XPDUTL(DGTEXT)
 Q
MENLST ;Protocol list
 ;;DGPM MOVEMENT EVENTS
 ;;$$END
 ;
PROLST ;Protocol List
 ;;DGRU INPATIENT CAPTURE
 ;;$$END
 ;
ADDLST ;Protocols to Disable
 ;;DGRU INPATIENT CAPTURE
 ;;$$END
 ;
