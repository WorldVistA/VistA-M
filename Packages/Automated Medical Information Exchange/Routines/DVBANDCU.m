DVBANDCU ;ALB/GTS - Clean-up routine 7131 ASIH notice of discharges; 12 Mar 96 @ 14:00pm [3/12/96 1:45pm]
 ;;2/7;AMIE;**5**;Mar 12, 1996
 ;
TEXT ;;
 ;;This routine will walk through the FORM 7131 file (#396) and cleanup
 ;;any ASIH admission dates.
 ;;
 ;;Once the process has completed, a MailMan message will be
 ;;delivered to the person installing the patch.  The message
 ;;will list 7131 requests that were cleaned up and Notices of
 ;;Discharge generated.  If Notices of Discharge were generated,
 ;;it is recommended you forward this message to those Regional
 ;;Office AMIE users so they will be aware of the changes to the
 ;;data in the AMIE system.
 ;;
 ;;
 ;;QUIT
 ;
STARTPT ;
 S (LNI,LNX)=""
 D MES^XPDUTL(" "),MES^XPDUTL(" ")
 F LNI=1:1 S LNX=$P($T(TEXT+LNI),";;",2) Q:(LNX="QUIT")  DO
 .S:LNX="" LNX=" "
 .D MES^XPDUTL(LNX)
 D CLN7131
 K LNI,LNX
 Q
 ;
CLN7131 ;** Init process, call correction tag and send mail msg
 S VAFEDXCT=0
 D LINE("Results of AMIE 7131 ASIH clean-up at station "_$$SITE^VASITE())
 D LINE("")
 D LINE("Start time:  "_$$NOW^XLFDT()),LINE("Job Number:  "_$J)
 D LINE(""),LINE("")
 D LINE("This message was generated as part of the clean up performed with")
 D LINE(" the installation of patch DVBA*2.7*5.")
 D LINE("")
 D LINE("IRM STAFF INFORMATION FOLLOWS: ")
 D LINE("The following is a list of 7131 requests entered for an ASIH")
 D LINE(" Admission date.  The Admission Date field (#3) was changed so")
 D LINE(" the time stamp no longer indicates ASIH."),LINE("")
 D LINE("Only Regional Office Staff need be concerned with this.")
 D LINE("")
 D LINE("REGIONAL OFFICE STAFF INFORMATION FOLLOWS: ")
 D LINE("R/O Staff, If you are adjudicating the claim of a veteran listed here,")
 D LINE(" be aware that Notices of Discharge generated for the admission date noted")
 D LINE(" may indicate discharge to another VA Facility.")
 D LINE("Check the veteran's claim folder for determination of action necessary.")
 D LINE(""),LINE("")
 D CORRECT ;** Correct 7131 ASIH records
 D LINE("")
 D LINE("End time:  "_$$NOW^XLFDT())
 D MAIL ; mail results
 Q
 ;
CORRECT ;** Walk 7131s, correct ASIH admit dts and gen 7132s
 N CT,J,DVBARQDT,DVBAASIH,DVBAPAT,DVBADFN,DGPMDA,DGDT,TDIS
 D SETXRO ;* Set RO station # array
 S CT=0
 S (J,DVBARQDT)=""
 F  S DVBARQDT=$O(^DVB(396,"G",DVBARQDT)) Q:(DVBARQDT="")  DO
 .F  S J=$O(^DVB(396,"G",DVBARQDT,J)) Q:J=""  DO
 ..I $D(^DVB(396,J,0)),($D(^DVB(396,J,2))) DO
 ...S DVBAASIH=$P(DVBARQDT,".",2)
 ...I ($L(DVBAASIH)>6)&($P(^DVB(396,J,2),"^",10)="A") DO
 ....S DVBADFN=$P(^DVB(396,J,0),"^",1)
 ....S DVBAPAT=$P($G(^DPT(DVBADFN,0)),"^",1)
 ....S:DVBAPAT="" DVBAPAT="(IRM NOTE: Bad patient name for DFN "_DVBADFN_")"
 ....S DFN=DVBADFN
 ....S VAIP("D")=DVBARQDT
 ....S VAIP("M")=0
 ....D IN5^VADPT
 ....S DGPMDA=VAIP(1)
 ....S DGDT=0
 ....S DGDT=VAIP(17)
 ....S TDIS=$P(VAIP(17,3),"^",2)
 ....K VAIP,DFN
 ....S DVBARQDT=+$E(DVBARQDT,1,14)
 ....S DA=J,DIE="^DVB(396,",DR="3////^S X=DVBARQDT"
 ....D ^DIE
 ....K DIE,DR,X,DA
 ....S Y=DVBARQDT
 ....X ^DD("DD")
 ....D LINE("  "_DVBAPAT_" 7131 for ASIH Admission Date "_Y_" corrected.")
 ....K Y
 ....D:DGDT GEN7132(DVBADFN,J,DVBARQDT,DGPMDA,TDIS)
 ....S CT=CT+1
 D:+CT'>0 LINE("No ASIH Admission 7131s were found for your Medical Center.")
 D LINE(""),LINE("")
 D LINE("The number of records corrected was "_CT)
 D LINE(""),LINE("")
 D:+CT>0 LINE("IRM PERSONNEL: ")
 D:+CT>0 LINE("Please forward this message to Regional Office personnel who use your system.")
 K XRO
 Q
 ;
SETXRO ;* Set up regional office station numbers array
 N I,J
 F I=0:0 S I=$O(^DVB(396.1,1,1,I)) Q:I=""!(+I=0)  S J=$P(^(I,0),U,1),J=$S($D(^DIC(4,+J,99)):$P(^(99),U),1:"") I J]"" S XRO(J)=""
 Q
 ;
GEN7132(DFN,DVBADA,ADMDT,DGPMDA,TDIS) ;* Gen Notice of Discharge (file 396.2)
 ;**NOTE: XRO(n) Array must be defined with N being the RO station #s
 N CFLOC
 S CFLOC=$P($G(^DPT(DFN,.31)),"^",4)
 S:CFLOC'="" CFLOC=$S($D(^DIC(4,CFLOC,99)):$P(^DIC(4,CFLOC,99),"^",1),1:"")
 Q:CFLOC=""  ;QUIT:no CFLOC
 I '$D(XRO(CFLOC))&(CFLOC'=376) Q  ;**QUIT if RO not user at site
 I CFLOC=376,TDIS["DEATH" S CFLOC=$O(XRO(0)) Q:CFLOC=""  ;QUIT:no RO'S
 Q:$D(^DVB(396.2,"D",ADMDT,DFN))  ;**QUIT if 7132 exists
 I ($P(^DVB(396,DVBADA,0),U,5)="YES")&($P(^(0),U,9)="P") DO
 .S SSN=$P($G(^DPT(DFN,0)),"^",9)
 .S (DIC,DIE)="^DVB(396.2,"
 .S DR="3.5///"_CFLOC_";1///"_ADMDT_";2///"_DGPMDA_";3///R"
 .S DLAYGO=396.2,DIC(0)="QLM",X=""""_SSN_""""
 .D ^DIC
 .I +Y>0 DO
 ..S DA=+Y
 ..D ^DIE
 ..D LINE("    .....Notice of Discharge has been generated!")
 ..D LINE(""),LINE("")
 .K DR,DLAYGO,DIC,DIE,X,Y,SSN
 Q
 ;
MAIL ;** Mail Cleanup msg
 N DIFROM
 K XMY
 S XMSUB="AMIE 7131 ASIH clean up"
 S XMN=0
 S XMTEXT="^TMP(""DVBA ASIH CLEANUP"",$J,"
 S XMDUZ=.5,XMY(DUZ)=""
 D ^XMD
 D MES^XPDUTL(" "),MES^XPDUTL(" ")
 D MES^XPDUTL("  ...Message has been delivered to installer!")
 K VAFEDXCT,XMDUZ,XMN,XMSUB,XMTEXT,XMY,^TMP("DVBA ASIH CLEANUP",$J)
 Q
 ;
LINE(TEXT) ; add line to array for e-mail
 S VAFEDXCT=VAFEDXCT+1,^TMP("DVBA ASIH CLEANUP",$J,VAFEDXCT)=TEXT
 Q
