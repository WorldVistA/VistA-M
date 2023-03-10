DG1043P ;MNT/BJR - REMOVE DGRU INPT PROTOCOL ; Feb 03, 2021@10:43:40
 ;;5.3;Registration;**1043**;Aug 13, 1993;Build 10
 ;
 Q
 ;References to DEL^XPDPROT supported by ICR #5567
 ;References to OUT^XPDPROT supported by ICR #5567
 ;References to BMES^XPDUTL supported by ICR #10141
 ;References to XREF^XQORM supported by ICR #10140
 ;References to GET1^DIQ supported by ICR #2056
 ;References to GOTLOCAL^XMXAPIG supported by ICR #3006
 ;References to SENDMSG^XMXAPI supported by ICR #2729
 ;
 ;
EN ;Entry point for DG*5.3*1043 Post Install routine
 D DELPROT
 D DISPROT
 D FNDEWL
 Q
DELPROT ;Delete Protocol from List Protocol
 N DGOM,DGMN,DGPROT,DGCHK,DGOP,DGTEXT,XQORM
 F DGOM=1:1 S DGMN=$P($TEXT(MENLST+DGOM),";;",2) Q:DGMN="$$END"  D
 .F DGOP=1:1 S DGPROT=$P($TEXT(PROLST+DGOP),";;",2) Q:DGPROT="$$END"  D
 ..S DGCHK=$$DELETE^XPDPROT(DGMN,DGPROT)
 ..I DGCHK S DGTEXT="The "_DGPROT_" protocol has been deleted from the "_DGMN_" protocol menu." D BMES^XPDUTL(DGTEXT)
 ..I 'DGCHK S DGTEXT="The "_DGPROT_" protocol could not be deleted from the "_DGMN_" protocol menu. It may have already been removed." D BMES^XPDUTL(DGTEXT)
 S XQORM=$O(^ORD(101,"B","DGPM MOVEMENT EVENTS",0))_";ORD(101,"
 D XREF^XQORM ;Force protocol recompile.
 Q
 ;
DISPROT ;Disable Protocols
 N DGPRTL,DGPR,DGTEXT
 F DGPR=1:1 S DGPRTL=$P($TEXT(DISLST+DGPR),";;",2) Q:DGPRTL="$$END"  D
 .D OUT^XPDPROT(DGPRTL,"DO NOT USE!! - DG*5.3*1043")
 .S DGTEXT="The "_DGPRTL_" protocol has been disabled." D BMES^XPDUTL(DGTEXT)
 Q
MENLST ;Protocol list
 ;;DGPM MOVEMENT EVENTS
 ;;$$END
 ;
PROLST ;Protocol List
 ;;DGRU INPATIENT CAPTURE
 ;;$$END
 ;
DISLST ;Protocols to Disable
 ;;DGRU INPATIENT CAPTURE
 ;;$$END
 ;
FNDEWL ;Identify appt request statuses with EWL and send list to SD EWL BACKGROUND UPDATE mail group
 N DGDFN,XMSUB,XMY,XMTEXT,DGTEXT,DGDTE,DGPT,XMDUZ,DGPARAM,DGIEN,DGLN
 S XMSUB="DG*5.3*1043 Post-Install Job Results" ;msg subject
 I $$GOTLOCAL^XMXAPIG("SD EWL BACKGROUND UPDATE") S XMY("G.SD EWL BACKGROUND UPDATE")="" ;send message to mail group
 I '$$GOTLOCAL^XMXAPIG("SD EWL BACKGROUND UPDATE") S XMY($G(DUZ))="" ;msg addressee array
 S XMDUZ=$G(DUZ),DGPARAM("FROM")="DG*5.3*1043 Post-Install"
 S XMTEXT="DGTEXT" ;array containing the text of msg
 S DGLN=1 ;msg line #
 S DGTEXT(DGLN)="DG*5.3*1043 post-install job results."
 S DGLN=2
 S DGTEXT(DGLN)="The Following Wait List Entries need to be scheduled for the following patients.",DGLN=DGLN+1
 S DGTEXT(DGLN)="PATIENT                        STATUS LAST EDITED",DGLN=DGLN+1
 S DGTEXT(DGLN)="----------------------------------------------------------",DGLN=DGLN+1
 S DGDFN=0 F  S DGDFN=$O(^DPT(DGDFN)) Q:'DGDFN  I $P($G(^DPT(DGDFN,1010.16)),U)="E" D
 .S DGIEN=DGDFN+",",DGPT=$$GET1^DIQ(2,DGIEN,.01)
 .S DGPT=DGPT_"                               ",DGPT=$E(DGPT,1,31)
 .S DGDTE=$$GET1^DIQ(2,DGIEN,1010.162)
 .S DGLN=DGLN+1,DGTEXT(DGLN)=DGPT_DGDTE
 D SENDMSG^XMXAPI(XMDUZ,XMSUB,XMTEXT,.XMY,.DGPARAM,"","")
 Q
