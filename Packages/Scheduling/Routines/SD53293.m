SD53293 ;BPFO/JRP - PRE/POST INIT ROUTINE;5/29/2001
 ;;5.3;Scheduling;**293**;Aug 13, 1993
 ;
 ;This routine was copied from routine SD53239P
 ;
PRE ;Main entry point for pre init
 ;Remove ERROR CODE DESCRIPTION (field #11) as an identifier of the
 ; TRANSMITTED OUTPATIENT ENCOUNTER ERROR CODE file (#409.76)
 ; (this causes problems when installing error codes)
 I ($D(^DD(409.76,0,"ID",11))) D
 .N TMP,X
 .S X(1)=" "
 .S X(2)="Removing ERROR CODE DESCRIPTION (field #11) as an identifier"
 .S X(3)="of the TRANSMITTED OUTPATIENT ENCOUNTER ERROR CODE file"
 .S X(4)="(#409.76) as it causes problems when installing error codes."
 .S X(5)=" "
 .D MES^XPDUTL(.X) K X
 .K ^DD(409.76,0,"ID",11)
 .Q:($D(^DD(409.76,0,"ID")))
 .S TMP=$P(^SD(409.76,0),U,2)
 .S TMP=$TR(TMP,"I","")
 .S $P(^SD(409.76,0),U,2)=TMP
 .Q
 Q
 ;
POST ;Main entry point of post init
 N X,ZTRTN,ZTSK,ZTDESC,ZTDTH,ZTIO,ZTSK
 ;Make ERROR CODE DESCRIPTION (field #11) an identifier of the
 ; TRANSMITTED OUTPATIENT ENCOUNTER ERROR CODE file (#409.76)
 ; (this was removed by the pre init routine)
 I ('$D(^DD(409.76,0,"ID",11))) D
 .N TMP
 .S X(1)=" "
 .S X(2)="Restoring ERROR CODE DESCRIPTION (field #11) as an identifier"
 .S X(3)="of the TRANSMITTED OUTPATIENT ENCOUNTER ERROR CODE file"
 .S X(4)="(#409.76) as it was removed by the pre init."
 .S X(5)=" "
 .D MES^XPDUTL(.X) K X
 .S ^DD(409.76,0,"ID",11)="D EN^DDIOL($P(^(1),U,1))"
 .S TMP=$P(^SD(409.76,0),U,2)
 .S TMP=$TR(TMP,"I","")
 .S $P(^SD(409.76,0),U,2)=TMP_"I"
 ;Change HL7 application name
 D HLAPP("AMBCARE-DH239","AMBCARE-DH293")
 D HLAPP("PCMM-213","PCMM-293")
 ;Queue changing of HL7 message statuses
 S ZTRTN="QHLM^SD53293"
 S ZTDESC="Change status of unacked AmbCare messages to SUCCESSFULLY COMPLETED"
 S ZTIO=""
 S ZTDTH=$H
 D ^%ZTLOAD
 K X
 S X(1)=" "
 S X(2)="Updating status of AmbCare messages that have not been acknowledged"
 S X(3)="queued as task number "_$G(ZTSK)
 S X(4)=" "
 I '$G(ZTSK) D
 .S X(1)=" "
 .S X(2)="***** Updating status of AmbCare messages that have not been"
 .S X(3)="***** acknowledged was not queued.  This process must be done"
 .S X(4)="***** in order for these messages to be properly purged."
 .S X(5)="***** Use entry point QHLM^SD53293 to do this process."
 .S X(6)=" "
 D MES^XPDUTL(.X) K X
 Q
 ;
HLAPP(OLDNAME,NEWNAME) ;Change HL7 application name
 ;Input  : OLDNAME - Name of HL7 application to change
 ;         NEWNAME - New name for HL7 application
 ;Output : None
 ;Notes  : Call designed to be used as a KIDS pre/post init
 S OLDNAME=$G(OLDNAME) Q:OLDNAME=""
 S NEWNAME=$G(NEWNAME) Q:NEWNAME=""
 N DIE,DIC,DA,DR,X,Y
 D BMES^XPDUTL("Changing HL7 Application name from "_OLDNAME_" to "_NEWNAME)
 S DIC="^HL(771,"
 S DIC(0)="X"
 S X=OLDNAME
 D ^DIC
 I (Y<0) D  Q
 .D BMES^XPDUTL("   *** "_OLDNAME_" application not found ***")
 S DIE=DIC
 S DA=+Y
 S DR=".01///^S X=NEWNAME"
 D ^DIE
 D MES^XPDUTL("HL7 application name successfully changed to "_NEWNAME)
 Q
 ;
QHLM ;Entry point for queued changing of HL7 messages
 D HLM("AMBCARE-DH293")
 D HLM("PCMM-293")
 Q
HLM(APPNAME) ;Change status of HL7 messages to '3' (SUCCESSFULLY COMPLETED)
 ; to enable purging of message
 ;Input  : APPNAME - Name of application generating message
 ;Output : None
 ;Notes  : Call must be used within KIDS (updates progress bar)
 S APPNAME=$G(APPNAME) Q:APPNAME=""
 N DA,DIC,DIE,DR,X,Y,SDAPP,HLMID,XPDIDTOT,HLPTR,COUNT,TEXT
 N XMDUZ,XMSUB,XMTEXT,XMY,XMZ
 K ^TMP("SD53293",$J)
 S X=$$NOW^XLFDT()
 S Y=$$FMTE^XLFDT(X)
 S TEXT="Updating of HL7 Message Text file (#772) began on "
 S TEXT=TEXT_$P(Y,"@",1)_" @ "_$P(Y,"@",2)
 S ^TMP("SD53293",$J,1,0)=TEXT
 S DIC="^HL(771,"
 S DIC(0)="M"
 S X=APPNAME
 D ^DIC
 I (Y<0) D  G HLMQ
 .S ^TMP("SD53293",$J,2,0)="   *** "_APPNAME_" application not found"
 .S ^TMP("SD53293",$J,3,0)="   *** Process aborted"
 S SDAPP=+Y
 S HLMID=""
 S COUNT=0
 F  S HLMID=$O(^HL(772,"AH",SDAPP,HLMID)) Q:(HLMID="")  D
 .S HLPTR=0
 .F  S HLPTR=+$O(^HL(772,"AH",SDAPP,HLMID,HLPTR)) Q:('HLPTR)  D
 ..S DIE="^HL(772,"
 ..S DA=HLPTR
 ..S DR="20////3"
 ..D ^DIE
 ..S COUNT=COUNT+1
 S X=$$NOW^XLFDT()
 S Y=$$FMTE^XLFDT(X)
 S TEXT="Updating of HL7 Message Text file completed on "
 S TEXT=TEXT_$P(Y,"@",1)_" @ "_$P(Y,"@",2)
 S ^TMP("SD53293",$J,2,0)=TEXT
 S ^TMP("SD53293",$J,3,0)=COUNT_" entries were updated"
HLMQ S XMDUZ="Patch SD*5.3*293"
 S XMSUB="Updating of HL7 Message Text file"
 S XMTEXT="^TMP(""SD53293"",$J,"
 S XMY(DUZ)=""
 D ^XMD
 S ZTREQ="@"
 Q
