SD53771P ;MNT/BJR - MARK EWL OPT/PROT OOO ;NOV 06, 2020@12:02
 ;;5.3;Scheduling;**771**;Aug 13, 1993;Build 2
 ;
 Q
 ;References to DEL^XPDPROT supported by DBIA #5567
 ;References to OUT^XPDPROT supported by DBIA #5567
 ;References to BMES^XPDUTL supported by DBIA #10141
 ;
 ;Post-init routine to add new option to primary menu
 ;
 ;
EN ;Entry point for SD*5.3*769 Post Install routine
 D DELPROT
 D DISPROT
 D DISOPT
 Q
DELPROT ;Delete Protocol from List Protocol
 N SDOM,SDMN,SDPROT,SDCHK,SDOP,SDTEXT
 F SDOM=1:1 S SDMN=$P($TEXT(MENLST+SDOM),";;",2) Q:SDMN="$$END"  D
 .F SDOP=1:1 S SDPROT=$P($TEXT(PROLST+SDOP),";;",2) Q:SDPROT="$$END"  D
 ..S SDCHK=$$DELETE^XPDPROT(SDMN,SDPROT)
 ..I SDCHK S SDTEXT="The "_SDPROT_" protocol has been deleted from the "_SDMN_" protocol menu." D BMES^XPDUTL(SDTEXT)
 ..I 'SDCHK S SDTEXT="The "_SDPROT_" protocol could not be deleted from the "_SDMN_" protocol menu. It may have already been removed." D BMES^XPDUTL(SDTEXT)
 Q
 ;
DISPROT ;Disable Protocols
 N SDPRTL,SDPR,SDTEXT
 F SDPR=1:1 S SDPRTL=$P($TEXT(DISLST+SDPR),";;",2) Q:SDPRTL="$$END"  D
 .D OUT^XPDPROT(SDPRTL,"DO NOT USE!! - EWL DECOM - SD*5.3*771")
 .S SDTEXT="The "_SDPRTL_" protocol has been disabled." D BMES^XPDUTL(SDTEXT)
 Q
DISOPT ;Disable Options
 N SDOM,SDMN,SDTEXT
 F SDOM=1:1 S SDMN=$P($TEXT(OPTLST+SDOM),";;",2) Q:SDMN="$$END"  D
 .D OUT^XPDMENU(SDMN,"DO NOT USE!! EWL DECOM - SD*5.3*771")
 .S SDTEXT="The "_SDMN_" menu option has been disabled." D BMES^XPDUTL(SDTEXT)
 Q
MENLST ;Options list
 ;;SDAM MENU
 ;;$$END
 ;
PROLST ;Protocol List
 ;;SD WAIT LIST ENTRY
 ;;$$END
 ;
DISLST ;Protocols to Disable
 ;;SD WAIT LIST ENTRY
 ;;$$END
 ;
OPTLST ;Options to Disable
 ;;SD WAIT LIST ENTER/EDIT
 ;;$$END
