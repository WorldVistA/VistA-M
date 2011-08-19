KMPDUT1 ;OAK/RAK - Test Lab Utility ;6/21/05  10:17
 ;;2.0;CAPACITY MANAGEMENT TOOLS;**4**;Mar 22, 2002
 ;
TL ;-entry point for setting up database as a test lab
 ;
 ; patch "KMPR*2.0*2" must be installed
 I '$$PATCH^XPDUTL("KMPR*2.0*2") D  Q
 .W !?3,"Patch 'KMPR*2.0*2' must be installed to run this routine!",!!
 ;
 N DIR,ERROR,IEN,FDA,ROUTINE,X,Y,Z
 S DIR(0)="YO",DIR("B")="N"
 S DIR("A")="Do you want to set this up as a Test Lab database for Capacity Planning"
 W ! D ^DIR
 I 'Y W !!?3,$C(7),"No action taken!" Q
 ;
 W !!?3,"Setting up database..."
 S ^KMPD(8973,"TEST LAB")=1
 W "done"
 S IEN=$O(^KMPD(8973,0)) Q:'IEN
 W !
 W !?3,"Updating RUM Weeks to Keep Data = 99 ..."
 W !?3,"         HL7 Weeks to Keep Data = 99 ..."
 W !?3,"         Timing Weeks to Keep Data = 99 ..."
 S FDA($J,8973,IEN_",",2.11)=99
 S FDA($J,8973,IEN_",",3.11)=99
 S FDA($J,8973,IEN_",",4.11)=99
 D FILE^DIE("","FDA($J)","ERROR")
 I $D(ERROR) D MSG^DIALOG("W","",60,10,"ERROR")
 W "done"
 W !
 W !?3,"Saving ZOSVKRT as %ZOSVKR ..."
 D ROUINQ^KMPDU2(.ROUTINE,"ZOSVKRT")
 D:$D(ROUTINE) ROUSAVE^KMPDU3(.Z,"%ZOSVKR",.ROUTINE)
 W "done"
 W !
 W !?3,"Deleting old ^KMPTMP(""KMPR"" data..."
 K ^KMPTMP("KMPR")
 W "done"
 S IEN=$O(^DIC(4.2,"B","FO-ALBANY.MED.VA.GOV",0))
 I IEN D 
 .K FDA,ERROR
 .W !!?3,"Setting FLAGS to SEND for domain FO-ALBANY.MED.VA.GOV..."
 .S FDA($J,4.2,IEN_",",1)="S"
 .D FILE^DIE("","FDA($J)","ERROR")
 .D:$D(ROUTINE) ROUSAVE^KMPDU3(.Z,"%ZOSVKR",.ROUTINE)
 .W "done"
 ;
 W !!?3,"*** This is now a Capacity Planning Test Lab database ***"
 ;
 Q
 ;
TESTLAB() ;-extrinsic - test for test lab database
 ;-----------------------------------------------------------------------------
 ; return: "0" - not a test lab database
 ;         "1^TESTLAB-" - it is a test lab database 
 ;-----------------------------------------------------------------------------
 N TL
 S TL=+$G(^KMPD(8973,"TEST LAB"))
 Q $S('TL:0,1:"1^TESTLAB-")
