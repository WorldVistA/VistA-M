DVBALD ;ALB/JLU;List Man created routine ; 01-AUG-1994
 ;;2.7;AMIE;;Apr 10, 1995
EN ; -- main entry point for DVBA DISCHARGE TYPES
 D EN^VALM("DVBA DISCHARGE TYPES")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="This is a list of the default discharge types."
 S VALMHDR(2)="Some of these types may not be active at this site."
 Q
 ;
INIT ; -- init variables and list array
 N DVBX,DVBY
 K ^TMP("AMIE",$J),^TMP("DVBA",$J)
 S VALMCNT=0
 F DVBX=1:1 S DVBY=$T(TEXT+DVBX) S DVBY=$P(DVBY,";;",2) Q:DVBY="END"  D SETARAY^DVBALD1(DVBY)
 Q
 ;
TEXT ;these are the default discharge types
 ;;10^TRANSFER OUT
 ;;18^READMISSION TO NHCU/DOMICILIARY
 ;;31^TO NHCU FROM HOSP
 ;;32^TO DOM FROM HOSP
 ;;33^TO NHCU FROM DOM
 ;;34^DISCHARGE TO CNH
 ;;35^VA NHCU TO CNH
 ;;40^TO ASIH
 ;;41^FROM ASIH
 ;;43^TO ASIH (OTHER FACILITY)
 ;;END
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 D CLEAR^VALM1
 K ^TMP("AMIE",$J),DVBAQUIT,VALMCK,VALMNOD
 Q
 ;
EXPND ; -- expand code
 Q
 ;
ADD ;this is the code for the ADD action in the discharge List Man
 D FULL^VALM1
 D ADD^DVBALD1("AD")
 S VALMBCK="R"
 Q
 ;
DELETE ;this is the code for the DELETE action in the discharge List Man
 D FULL^VALM1
 D DELETE^DVBALD1
 S VALMBCK="R"
 Q
 ;
CREATE ;this is the code for the CREATE action in the discharge List Man
 D FULL^VALM1
 K ^TMP("AMIE",$J),^TMP("DVBA",$J)
 S VALMCNT=0
 D ADD^DVBALD1("CL")
 I '$D(@VALMAR@(1)) DO
 .S VAR(1,0)="0,0,0,2,0^No new discharge types were selected."
 .S VAR(2,0)="0,0,0,1,0^I will go back to the default list."
 .D WR^DVBAUTL4("VAR")
 .K VAR
 .D PAUSE^VALM1
 .D INIT
 .Q
 S VALMBCK="R"
 Q
 ;
ACCEPT ;this line tag is for the acceptance of the discharge list.
 S DVBACEPT=1
 S VALMCK="Q"
 Q
 ;
