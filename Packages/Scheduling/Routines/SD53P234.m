SD53P234 ;ALB/RBS - Patch SD*5.3*234 Install Utility Routine ; 3/12/01 1:03pm
 ;;5.3;Scheduling;**234**;AUG 13, 1993
 ;
 ; * Note:  Patch SD*5.3*212 - Baseline Seeding must have been Run *
 ;
 ; This routine will search the PCMM HL7 TRANSMISSION (#404.471) file
 ;  for 'A'ccepted Status HL7's whose Transmission Date/Time fall
 ;   within the dates of Oct. 23, 2000 through Oct. 31, 2000.
 ; These HL7's will then have their Status changed to:
 ;  'M' (MARKED FOR RE-TRANSMIT) in the #404.471 file.
 ;
 ; The following criteria must be true:
 ;  1.  Must have a Baseline Run Date...
 ;      *** AND ***
 ;  1a. Baseline Run Date NOT GREATER THAN Oct. 31, 2000.
 ;  2.  BEGIN Date equals:  Oct. 22, 2000@23:59 = 3001022.2359
 ;                          *** OR ***
 ;                          the Baseline Run Date (whichever greater)
 ;  3.  END Date equals:    Nov.  1, 2000@00:00 = 3001101
 ;  4.  STATUS equals ACCEPTED
 ;      *** AND ***
 ;  4a. TRANSMISSION DATE/TIME is between the BEGIN & END dates
 ;
 ;
ENV ;Main entry point for Environment check point.
 S XPDABORT=""
 D PROGCHK(.XPDABORT) ;checks programmer variables
 D PARMCHK(.XPDABORT) ;checks param file ien exists
 ;
 N SCX
 I $D(^XTMP("SD53P234")) D  Q
 .S SCX=$G(^XTMP("SD53P234",0))
 .D BMES^XPDUTL("*****")
 .D MES^XPDUTL("The PCMM HL7 Missing Message Re-queue has already run on:  "_$$FMTE^XLFDT($P(SCX,U,2)))
 .D MES^XPDUTL("Transport global will be removed.  Install will Abort.")
 .D MES^XPDUTL("*****")
 .S XPDABORT=1  ;abort install & kill all transport globals
 I XPDABORT="" K XPDABORT
 ;
 Q
 ;
PRE ;Main entry point for Pre-init items.
 ;
 Q
 ;
POST ;Main entry point for Post-init items.
 ;
 Q:$D(^XTMP("SD53P234"))
 D SETUP       ;Setup ^XTMP audit global
 D POST1       ;Update Client/Server files
 D POST2       ;Search & MARK HL7's to be RE-TRANSMITTED
 Q
 ;
PROGCHK(XPDABORT) ;checks for necessary programmer variables
 ;
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") D
 .D BMES^XPDUTL("*****")
 .D MES^XPDUTL("Your programming variables are not set up properly.")
 .D MES^XPDUTL("Installation aborted.")
 .D MES^XPDUTL("*****")
 .S XPDABORT=2
 Q
 ;
PARMCHK(XPDABORT) ;checks for proper param file ien
 ;
 I '$D(^SCTM(404.44,1)) D
 .D BMES^XPDUTL("*****")
 .D MES^XPDUTL("PCMM Parameter file does not have proper IEN (1).")
 .D MES^XPDUTL("Installation aborted.")
 .D MES^XPDUTL("*****")
 .S XPDABORT=2
 Q
 ;
POST1 ;Update client/server files.
 ;
 I $$UPCLNLST^SCMCUT("SD*5.3*234^NullClient^1^0^0") D  Q
 .D MES^XPDUTL("Client/Server files updated.")
 ;
 D MES^XPDUTL("Client/Server files NOT updated.")
 Q
 ;
POST2 ;Loop (#404.471)-PCMM HL7 TRANSMISSION LOG file
 ; Search for HL7's with 'A'ccepted Status and Transmission D/T within
 ;  the Beginning and Ending date's.
 ;
 ; begin date, end date, Baseline Run date, message variables, totals
 N SCBDATE,SCEDATE,SCP212,SC1,SC2,SC3,SCTOT,SCTOTAL
 S (SC1,SC2,SC3)="",(SCP212,SCTOT,SCTOTAL)=0
 ;
 ; begin/end search dates - October 23, 2000 through October 31, 2000
 S SCBDATE=3001022.2359,SCEDATE=3001031.2359
 ;
 ; check for Baseline Run date
 D CHECK(.SCP212)
 Q:'SCP212
 ;
 ; search for messages to mark for retransmission
 D LOOP
 ; total up all HL7's
 D CNTZPC
 ; send user e-mail message...
 D MSG(SCTOT,SCTOTAL,"")
 ; setup ^XTMP totals
 N SCX
 S SCX=$G(^XTMP("SD53P234",0))    ;temp AUDIT global
 S $P(SCX,U,6)=SCTOT              ;log total HL7's retransmitted
 S $P(SCX,U,7)=SCTOTAL            ;Total HL7's since Baseline
 S ^XTMP("SD53P234",0)=SCX
 ;
 K ^TMP($J,"SD53P234")            ;clean up
 Q
 ; *** END OF PROCESSING ***
 ;
CNTZPC ; Total Number HL7's since Baseline Seeding to current date
 ; Output;  SCTOTAL = total HL7's since Baseline seeding
 ; 
 Q:'$D(^TMP($J,"SD53P234"))
 N SCSEQ
 S SCSEQ="" F  S SCSEQ=$O(^TMP($J,"SD53P234",SCSEQ)) Q:SCSEQ=""  S SCTOTAL=SCTOTAL+1
 Q
 ;
LOOP ;Loop thru PCMM HL7 TRANSMISSION LOG file and find every entry
 ; with STATUS="A", and re-transmit.
 ; Output;  SCTOT = total marked counter
 ;
 N SCARR,SCERR,SCTRANI,SCTRANDT,SCX
 S SCTRANI=0
 F  S SCTRANI=$O(^SCPT(404.471,"ASTAT","A",SCTRANI)) Q:SCTRANI=""  D
 .K SCARR,SCERR
 .S SCX=SCTRANI_","
 .D GETS^DIQ(404.471,SCX,".01;.02;.03;.04;.05","I","SCARR","SCERR")
 .Q:$D(SCERR)                             ;error
 .Q:$G(SCARR(404.471,SCX,.01,"I"))=""     ;message control ID null
 .Q:$G(SCARR(404.471,SCX,.02,"I"))=""     ;patient DFN null
 .Q:$G(SCARR(404.471,SCX,.03,"I"))=""     ;transmission date/time null
 .Q:$G(SCARR(404.471,SCX,.04,"I"))'="A"   ;status not equal "A"ccepted
 .Q:$G(SCARR(404.471,SCX,.05,"I"))=""     ;ACK received date/time null
 .S SCTRANDT=$G(SCARR(404.471,SCX,.03,"I"))
 .; count actual number of 404.49 ZPC unique Provider ID's
 .I SCTRANDT'<SCP212 D ZPC(SCTRANI)       ;count all HL7's fm Baseline
 .Q:SCTRANDT<SCBDATE                      ;begin date
 .Q:SCTRANDT>SCEDATE                      ;end date
 .;
 .D STATUS^SCMCHLRR(SCTRANI,"M")          ;change status to 'M'arked
 .S SCTOT=SCTOT+1                         ;total status changes
 Q
 ;
ZPC(TRANI) ; count number of (#404.49,ien) pointers to Provider ID's
 ;
 N SCSEQ,SCSEQI,SCZPCID
 S (SCSEQ,SCSEQI,SCZPCID)=""
 F  S SCSEQ=$O(^SCPT(404.471,TRANI,"ZPC","B",SCSEQ)) Q:SCSEQ=""  D
 .F  S SCSEQI=$O(^SCPT(404.471,TRANI,"ZPC","B",SCSEQ,SCSEQI)) Q:SCSEQI=""  D
 ..S SCZPCID=$P($G(^SCPT(404.471,TRANI,"ZPC",SCSEQI,0)),"^",2)
 ..Q:'$D(^SCPT(404.49,SCZPCID))
 ..S ^TMP($J,"SD53P234",SCZPCID)=""
 Q
 ;
MSG(SCTOT,SCTOTAL,SCXERR) ; send e-mail to user's
 ;
 N DIFROM,SCX,SCXSITE,SCSTIME,SCETIME,SCTEXT,XMY,XMDUZ,XMSUB,XMTEXT,XMDUN,XMZ
 S SCXSITE=$$SITE^VASITE
 S SCX=$G(^XTMP("SD53P234",0)),SCSTIME=$P(SCX,U,3)   ;start date/time
 S SCETIME=$$NOW^XLFDT(),$P(SCX,U,4)=SCETIME      ;end date/time
 S XMDUZ=.5,XMY(XMDUZ)="",XMY(DUZ)="",XMTEXT="SCTEXT("
 S XMY("G.PCMM TESTING@DOMAIN.EXT")=""  ;e-mail all sites totals to
 S XMSUB="Patch SD*5.3*234 PCMM DATA NOT LOADED TO NPCD ("_$P(SCXSITE,U,3)_")"
 ;
 S SCTEXT(1)=""
 S SCTEXT(2)="          Facility Name:  "_$P(SCXSITE,"^",2)
 S SCTEXT(3)="         Station Number:  "_$P(SCXSITE,"^",3)
 S SCTEXT(4)=""
 S SCTEXT(5)="  Date/Time job started:  "_$$FMTE^XLFDT(SCSTIME)
 S SCTEXT(6)="  Date/Time job stopped:  "_$$FMTE^XLFDT(SCETIME)
 S SCTEXT(7)=""
 S SCTEXT(8)="Total HL7 messages Marked for Transmission to the AAC: "_SCTOT
 S SCTEXT(9)="Total Provider ID records created since Baseline Run Date("_$$FMTE^XLFDT(SCP212)_"): "_SCTOTAL
 I SCXERR]"" D
 .S SCTEXT(10)=""
 .S SCTEXT(11)="               * * * * E R R O R    E N C O U N T E R E D * * * *"
 .S SCTEXT(12)=""
 .S SCTEXT(13)=SC1
 .S SCTEXT(14)=SC2
 .S SCTEXT(15)=""
 D ^XMD
 S ^XTMP("SD53P234",0)=SCX    ;end date/time - temp audit global
 Q
 ;
CHECK(SCP212) ; Determine whether or not the Baseline has run.
 ; Input: None
 ; Output:
 ;   Function Value: Return date Baseline was run
 ;
 N SCX
 ; setup first line of error msg.
 S SC1="The PCMM HL7 Missing Message Re-queue Job was Aborted because:"
 I '$D(^SCTM(404.44,1)) D  Q
 .S SC2="  Missing PCMM Parameter file entry."
 .D MSG(0,0,1)
 ;
 K ^TMP($J,"SD53P234")
 S SCX=$$GET1^DIQ(404.44,"1,",17,"I","","^TMP($J,""SD53P234"")")
 I $D(^TMP($J,"SD53P234")) D  Q
 .S SC2="  FileMan Error retrieving data from PCMM Parameter file."
 .D MSG(0,0,1)
 .K ^TMP($J,"SD53P234")
 ;
 I SCX="" D  Q
 .S SC2="  No PCMM Baseline Run Date found in the PCMM Parameter file."
 .D MSG(0,0,1)
 ;
 ; If Baseline Run date Greater the End search date, Quit
 I SCX>SCEDATE D  Q
 .S SC2="  No PCMM HL7 Missing Message Retransmits required for your site."
 .S SCP212=SCX D MSG(0,0,1) S SCP212=0
 ;
 ; If Baseline Run date Greater than Begin Search date,
 ;  then use Baseline date
 I SCX>SCBDATE S SCBDATE=SCX
 ;
 S SCP212=SCX        ;Baseline Run Date
 Q
 ;
SETUP ; setup start processing time
 ; The ^XTMP global will be used as an audit trail for 30 days to
 ;  prevent this process from running more than once.
 ;  ^XTMP("SD53P234",0)=STRING
 ;  STRING = 7 fields of data delimited by "^" up-arrow
 ;       1 = purge date = date ^XTMP global will be purged
 ;       2 = run date   = date routine was run
 ;       3 = start d/t  = start date & time of processing
 ;       4 = stop d/t   = stop date & time of processing
 ;       5 = DUZ of User= ID # of user running process
 ;       6 = HL7 count  = Total number or HL7's marked for retransmit
 ;       7 = TOTAL HL7'S that should be loaded from original Baseline.
 ;
 N SCX
 S $P(SCX,U)=$$HTFM^XLFDT(+$H+30),$P(SCX,U,2)=$$DT^XLFDT()
 S $P(SCX,U,3)=$$NOW^XLFDT(),$P(SCX,U,5)=DUZ,$P(SCX,U,6)=0,$P(SCX,U,7)=0
 S ^XTMP("SD53P234",0)=SCX
 Q
