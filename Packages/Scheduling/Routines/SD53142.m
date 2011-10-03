SD53142 ;BP/JRP - POST INIT FOR PATCH SD*5.3*142;9-APR-1998
 ;;5.3;Scheduling;**142**;AUG 13, 1993
 ;
 ;Portions of this routine were copied from SD5370PT (ALB/ABR)
 ; and SCMSP66 (ALB/JLU)
 ;
PRE ;Main entry point for pre init
 ;Remove ERROR CODE DESCRIPTION (field #11) as an identifier of the
 ; TRANSMITTED OUTPATIENT ENCOUNTER ERROR CODE file (#409.76)
 ; (this causes problems when installing error codes)
 I ($D(^DD(409.76,0,"ID",11))) D
 .N TMP
 .K ^DD(409.76,0,"ID",11)
 .Q:($D(^DD(409.76,0,"ID")))
 .S TMP=$P(^SD(409.76,0),U,2)
 .S TMP=$TR(TMP,"I","")
 .S $P(^SD(409.76,0),U,2)=TMP
 .Q
 Q
 ;
POST ;Main entry point for post init
 ;Make ERROR CODE DESCRIPTION (field #11) an identifier of the
 ; TRANSMITTED OUTPATIENT ENCOUNTER ERROR CODE file (#409.76)
 ; (this was removed by the pre init routine)
 I ('$D(^DD(409.76,0,"ID",11))) D
 .N TMP
 .S ^DD(409.76,0,"ID",11)="D EN^DDIOL($P(^(1),U,1))"
 .S TMP=$P(^SD(409.76,0),U,2)
 .S TMP=$TR(TMP,"I","")
 .S $P(^SD(409.76,0),U,2)=TMP_"I"
 ;Change status of HL7 messages
 D HLM
 ;Change HL7 application name
 D HLAPP
 Q
 ;
HLM ;Change status of HL7 messages to '3' (SUCCESSFULLY COMPLETED)
 ; to enable purging of message
 N DA,DIC,DIE,DR,X,Y,SDAPP,HLMID,XPDIDTOT,HLPTR,COUNT,TEXT
 S X=$$NOW^XLFDT()
 S Y=$$FMTE^XLFDT(X)
 S TEXT=">> Beginning HL7 Message Text file (#772) update on "
 S TEXT=TEXT_$P(Y,"@",1)_" @ "_$P(Y,"@",2)
 D BMES^XPDUTL(TEXT)
 S XPDIDTOT=+$O(^HL(772,"A"),-1)
 S DIC="^HL(771,"
 S DIC(0)="M"
 S X="AMBCARE-DH70"
 D ^DIC
 I (Y<0) D  Q
 .D BMES^XPDUTL("   *** AMBCARE-DH70 application not found ***")
 S SDAPP=+Y
 S HLMID=""
 S COUNT=0
 F  S HLMID=$O(^HL(772,"AH",SDAPP,HLMID)) Q:(HLMID="")  D
 .S HLPTR=0
 .F  S HLPTR=+$O(^HL(772,"AH",SDAPP,HLMID,HLPTR)) Q:('HLPTR)  D
 ..D UPDATE^XPDID(HLPTR)
 ..S DIE="^HL(772,"
 ..S DA=HLPTR
 ..S DR="20////3"
 ..D ^DIE
 ..S COUNT=COUNT+1
 D UPDATE^XPDID(XPDIDTOT)
 S X=$$NOW^XLFDT()
 S Y=$$FMTE^XLFDT(X)
 S TEXT="   Updating of HL7 Message Text file completed on "
 S TEXT=TEXT_$P(Y,"@",1)_" @ "_$P(Y,"@",2)
 D MES^XPDUTL(TEXT)
 S TEXT="   "_COUNT_" entries were updated"
 D MES^XPDUTL(TEXT)
 Q
 ;
HLAPP ;Change HL7 application name from AMBCARE-DH70 to AMBCARE-DH142
 N DIE,DIC,DA,DR,X,Y
 D BMES^XPDUTL(">> Changing HL7 Application name from AMBCARE-DH70 to AMBCARE-DH142")
 S DIC="^HL(771,"
 S DIC(0)="X"
 S X="AMBCARE-DH70"
 D ^DIC
 I (Y<0) D  Q
 .D BMES^XPDUTL("   *** AMBCARE-DH70 application not found ***")
 S DIE=DIC
 S DA=+Y
 S DR=".01///AMBCARE-DH142"
 D ^DIE
 D MES^XPDUTL("   HL7 application name successfully changed to AMBCARE-DH142")
 Q
 ;
 ;
DEL6050 ;Delete entries in Transmitted Outpatient Encounter file (#409.73)
 ;that are Lab stops to an OOS clinic and don't have any CPTs.  Net
 ;result is removal of 6050 errors from error listing.
 ;
 N IOP
 S IOP="Q"
 D EN^XUTMDEVQ("TASK6050^SD53142","DELETE ACRP 6050 ERRORS")
 D HOME^%ZIS
 Q
TASK6050 ;Entry point for tasking
 ;Declare variables
 N L,DIC,FLDS,BY,FR,TO,DHD,DHIT,IOP,SD53142
 ;Sort through Transmitted Outpatient Encounter Error file (#409.75)
 S L=""
 S DIC="^SD(409.75,"
 ;Find entries that match the following criteria:
 ;  (1) Error code is 6050
 ;  (2) Related Visit file entry is a Lab stop
 ;  (3) Related Visit file entry is at an OOS clinic
 S BY="@.02,@.01:.02:.05:.08:1,@.01:.02:.05:.22:50.01"
 S FR(1)="6050"
 S TO(1)="6050"
 S FR(2)="108"
 S TO(2)="108"
 S FR(3)="YES"
 S TO(3)="YES"
 ;Print basic information about the entry
 S FLDS="INTERNAL(#.01);""XMITPTR"""
 S FLDS(1)=".01:.02:INTERNAL(NUMBER);""ENCPTR"""
 S FLDS(2)=".01:.02:.05:INTERNAL(NUMBER);""VSITPTR"""
 S FLDS(3)=".01:.02:.05:NUMDATE(#.01);""DATE"""
 S FLDS(4)=".01:.02:.05:15001;L10;""VISIT ID"""
 S FLDS(5)=".01:.02:.05:.08:1;L4;""AMIS"""
 S FLDS(6)=".01:.02:.05:.22;L16;""CLINIC"""
 ;Delete entry from Transmitted Outpatient Encounter file
 S DHIT="S ZJRP=$$DELXMIT^SCDXFU03(+$G(^SD(409.75,D0,0)),0) K ZJRP"
 ;Send output to current device
 S IOP=IO
 ;Remember IO("S")
 S SD53142=+$G(IO("S"))
 ;Call FileMan
 S DHD="6050 ERRORS DELETED FROM ACRP FILES"
 D EN1^DIP
 ;Reset IO("S")
 S:(SD53142) IO("S")=SD53142
 ;Done
 S:($D(ZTQUEUED)) ZTREQ="@"
 Q
