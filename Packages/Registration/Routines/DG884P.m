DG884P ;PD-REMOTE/DDA,KCL,FT - DG*5.3*884 INSTALL UTILITIES ;6/18/15 3:34pm
 ;;5.3;Registration;**884**;Aug 13, 1993;Build 31
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ; XLFDT APIs - #10103
 ; XPDUTL APIs- #10141
 ; %ZTLOAD - #10063
 ; ^DIC(4.2) - #3779
 ; XMBGRP APIs - #1146
 ; ^XMB(3.8) - #6202
 ; ICD globals - #6204
 ; VASITE APIs - #10112
 ; XMD APIs - #10070
 ; XUPROD APIs - #4440 
 ;
 ;--------------------------------------------------
 ;Patch DG*5.3*884: Environment, Pre-Install, and
 ;Post-Install entry points.
 ;--------------------------------------------------
 ;
ENV ;Main entry point for Environment check items
 ;Per KIDS documentation: During the environment check routine,
 ;use of direct WRITEs must be used for output messages.
 ;
 ;KIDS variable to indicate if install should abort
 ;if SET = 2, then abort entire installation
 S XPDABORT=""
 ;
 ;check programmer variables
 W !!,">>> Check programmer variables..."
 D PROGCHK(.XPDABORT)
 Q:XPDABORT=2
 W "Successful"
 ;
 D ICDCHK ;check if ICD*18*64 installed needed entries.
 ;If not, send message to customer support group on FORUM.
 ;Do not abort install.
 ;
 ;Make certain Q-PTI.DOMAIN.EXT entry exists in DOMAIN (#4.2) file
 W !!,">>> Checking for 'Q-PTI.DOMAIN.EXT entry in DOMAIN (#4.2)..."
 N DGQPTI
 S DGQPTI=+$O(^DIC(4.2,"B","Q-PTI.DOMAIN.EXT",0))
 I 'DGQPTI D
 .W !,"There is no 'Q-PTI.DOMAIN.EXT' entry in the DOMAIN (#4.2) file."
 .W !,"Please see patch XM*999*179 to create this entry and start"
 .W !,"this installation again.",!
 .S XPDABORT=2
 Q:XPDABORT=2
 W "Successful"
 ;success
 I XPDABORT="" K XPDABORT
 Q
ICDCHK ;Check entry count in some DRG files
 N DGCNT,DGI,DGFLAG,DGICD,DGL,DGLOBAL,DGLOOP,DGMSG,DGTEXT
 N XMDUZ,XMSUB,XMTEXT,XMY
 I $D(XPDENV) D  ;use WRITE in ENV check and use MES/BMES^XPDUTL in pre-init
 .W !!,">>> Checking number of entries in some DRG files..."
 I '$D(XPDENV) D
 .S DGTEXT(1)=" "
 .S DGTEXT(2)=" "
 .S DGTEXT(3)=">>> Checking number of entries in some DRG files..."
 .D BMES^XPDUTL(.DGTEXT)
 S DGICD(80.5)="DRG SURGICAL HIERARCHY"_U_1_U_"ICDRS"
 S DGICD(80.6)="DRG HAC"_U_1_U_"ICDHAC"
 S DGICD(82)="DRG DIAGNOSIS HIERARCHY CODES"_U_265_U_"ICDID"
 S DGICD(82.1)="DRG PROCEDURE IDENTIFIER CODES"_U_214_U_"ICDIP"
 S DGICD(82.11)="DRG PROCEDURE CODE COMBINATIONS"_U_33_U_"ICDIDP"
 S DGICD(82.12)="DRG DIAGNOSIS CODE COMBINATIONS"_U_2_U_"ICDIDD"
 S DGICD(82.13)="DRG CC EXCLUSIONS"_U_1491_U_"ICDCCEX"
 S DGLOOP=0,DGL=2
 F  S DGLOOP=$O(DGICD(DGLOOP)) Q:'DGLOOP  S DGLOBAL=$P(DGICD(DGLOOP),U,3) D:DGLOBAL'="" COUNT
 ;S DGLOOP=0 F  S DGLOOP=$O(DGICD(DGLOOP)) Q:'DGLOOP  S $P(DGICD(DGLOOP),U,4)=0 ;for testing only - FT 6/18/15
 S (DGFLAG,DGLOOP)=0 ;compare their counts with ours
 F  S DGLOOP=$O(DGICD(DGLOOP)) Q:'DGLOOP  D
 .I $P($G(DGICD(DGLOOP)),U,2)'=$P(DGICD(DGLOOP),U,4) D
 ..I $D(XPDENV) D
 ...W !,"There is a discrepancy in the number of entries you have"
 ...W !,"for the "_$P(DGICD(DGLOOP),U,1)_" (#"_DGLOOP_") file."
 ..I '$D(XPDENV) D
 ...K DGTEXT
 ...S DGTEXT(1)="There is a discrepancy in the number of entries you have"
 ...S DGTEXT(2)="for the "_$P(DGICD(DGLOOP),U,1)_" (#"_DGLOOP_") file."
 ...D BMES^XPDUTL(.DGTEXT)
 ..S DGFLAG=1,DGL=DGL+1,DGMSG(DGL)=$P(DGICD(DGLOOP),U,1)_" (#"_DGLOOP_")"
 K DGTEXT
 I DGFLAG=0 D  Q  ;file counts are ok, so quit
 .W:$D(XPDENV) !,"    No discrepancies found.",!
 .D:'$D(XPDENV) MES^XPDUTL("    No discrepancies found.")
 I DGFLAG=1 D  ;counts don't match
 .W:$D(XPDENV) !,"    Please log a Remedy ticket.",!
 .D:'$D(XPDENV) MES^XPDUTL("    Please log a Remedy ticket.")
 Q:$$PROD^XUPROD()=0  ;not a production account. Don't send email.
MAIL ;send MailMan message if file counts don't match
 N DIFROM ;per KIDS manual, NEW DIFROM before calling MailMan in env/pre/post routine
 S XMDUZ=$S($G(DUZ)>0:DUZ,1:.5)
 S XMSUB="DG*5.3*884 - Station "_$P($$SITE^VASITE(),U,3)_" file count issue"
 S DGMSG(1)="DG*5.3*884 was installed and found a difference in the number"
 S DGMSG(2)="of entries for the following files:"
 S XMTEXT="DGMSG("
 S XMY("G.CSADMIN1@DOMAIN.EXT")="",XMY("FRANK.TRAXLER@DOMAIN.EXT")=""
 D ^XMD
 Q
COUNT ;count the number entries in the file, put in 4th piece
 S (DGCNT,DGI)=0,DGLOBAL="^"_DGLOBAL
 F  S DGI=$O(@DGLOBAL@(DGI)) Q:'DGI  S DGCNT=DGCNT+1
 S $P(DGICD(DGLOOP),U,4)=DGCNT
 Q
 ;
PRE ;Main entry point for Pre-init items
 ;
 ;Item 1 - Remove the "AO" cross-references from 5 original OPERATION CODE fields.
 D BMES^XPDUTL(">>> Start removal of PTF Operation Code ""AO"" cross-reference...")
 ;EX. where 45.01=401 sub-file#, 8=OPERATION CODE 1 field#, 1=ien of the XREF in ^DD(45.01,8,1,1,0)="45.01^AO"
 D DELIX^DDMOD(45.01,8,1,,"DGAO")
 D DELIX^DDMOD(45.01,9,1,,"DGAO")
 D DELIX^DDMOD(45.01,10,1,,"DGAO")
 D DELIX^DDMOD(45.01,11,1,,"DGAO")
 D DELIX^DDMOD(45.01,12,1,,"DGAO")
 W !
 ;
 D MES^XPDUTL("    ""AO"" removal completed.")
 ;
 D ICDCHK
 ;
 D NEWMG ;create new PTI mail group
 ;
PTF125 ;Item 2 - Update PTF125 entry in TRANSMISSION ROUTER (#407.7)
 ;Make certain Q.PTI.DOMAIN.EXT exists in DOMAIN (#4.2)
 ;Make certain PTF125 entry exists in TRANSMISSION ROUTERS (#407.7).
 ;Create PTF125 entry, if necessary.
 ;In PTF125 entry, set TRANSMIT=NO for Q-PTT.DOMAIN.EXT (old queue)
 ;In PTF125 entry, set TRANSMIT=YES for Q-PTI.DOMAIN.EXT (new queue)
 N DGARRAY,DGFDA,DGERROR,DGFLAG,DGIEN,DGLOOP,DGLOOP1,DGQPTI,DGTEXT
 S DGTEXT(1)=">>> Updating PTF125 entry in TRANSMISSION ROUTER (#407.7) file."
 S DGTEXT(2)="    Setting TRANSMIT=NO for (existing) receiving user@Q-PTT.DOMAIN.EXT."
 S DGTEXT(3)="    Creating new receiving user@Q-PTI.DOMAIN.EXT."
 D BMES^XPDUTL(.DGTEXT)
 K DGTEXT
 S DGQPTI=+$O(^DIC(4.2,"B","Q-PTI.DOMAIN.EXT",0))
 I 'DGQPTI D
 .S DGTEXT(1)="There is no 'Q-PTI.DOMAIN.EXT' entry in the DOMAIN (#4.2) file."
 .S DGTEXT(2)="Please see patch XM*999*179 to create this entry and start"
 .S DGTEXT(3)="the installation again."
 .D STOP
 Q:$G(XPDABORT)=1
 S DGIEN=$O(^VAT(407.7,"B","PTF125",0))
 I 'DGIEN D CREATE ;create PTF125 entry if it doesn't exist
 S DGIEN=$O(^VAT(407.7,"B","PTF125",0))
 I 'DGIEN D
 .S DGTEXT(1)="There is no 'PTF125' entry in the TRANSMISSION ROUTERS (#407.7) file."
 .S DGTEXT(2)="Stopping installation. Log a ticket ASAP."
 .D STOP
 Q:$G(XPDABORT)=1
 D GETS^DIQ(407.7,DGIEN_",","**","EI","DGARRAY","DGERROR")
 I $D(DGERROR) D
 .S DGTEXT(1)="Cannot retrieve the 'PTF125' values from the TRANSMISSION ROUTERS"
 .S DGTEXT(2)="(#407.7) file. Stopping installation. Log a ticket ASAP."
 .D STOP
 Q:$G(XPDABORT)=1
 S DGLOOP=""
 S DGLOOP=$O(DGARRAY(407.7,DGLOOP))
 I DGLOOP="" D
 .S DGTEXT(1)="Cannot find the 'PTF125' entry in the TRANSMISSION ROUTERS"
 .S DGTEXT(2)="(#407.7) file. Stopping installation. Log a ticket ASAP."
 .D STOP
 Q:$G(XPDABORT)=1 
 I $G(DGARRAY(407.7,DGLOOP,.01,"E"))'="PTF125" D
 .S DGTEXT(1)="Cannot find the 'PTF125' entry in the TRANSMISSION ROUTERS"
 .S DGTEXT(2)="(#407.7) file. Stopping installation. Log a ticket ASAP."
 .D STOP
 Q:$G(XPDABORT)=1 
 S DGLOOP1=""
 F  S DGLOOP1=$O(DGARRAY(407.71,DGLOOP1)) Q:DGLOOP1=""  D
 .I $G(DGARRAY(407.71,DGLOOP1,1,"E"))'="Q-PTT.DOMAIN.EXT" Q
 .I $G(DGARRAY(407.71,DGLOOP1,2,"E"))="NO" Q
 .D TURNOFF ;turn off transmit to Q-PTT
 .I $D(DGERROR) D
 ..S DGTEXT(1)="Could not set TRANSMIT='NO' for Q-PTT.DOMAIN.EXT."
 ..S DGTEXT(2)="Stopping installation. Log a ticket ASAP."
 ..D STOP
 Q:$G(XPDABORT)=1
 S DGLOOP1="",DGFLAG=0
 F  S DGLOOP1=$O(DGARRAY(407.71,DGLOOP1)) Q:DGLOOP1=""  D
 .I $G(DGARRAY(407.71,DGLOOP1,1,"E"))'="Q-PTI.DOMAIN.EXT" Q
 .I $G(DGARRAY(407.71,DGLOOP1,2,"E"))="YES" S DGFLAG=1 Q
 .D TURNON ;turn on transmit to Q-PTI
 .I $D(DGERROR) D
 ..S DGTEXT(1)="Could not set TRANSMIT='YES' for Q-PTI.DOMAIN.EXT."
 ..S DGTEXT(2)="Stopping installation. Log a ticket ASAP."
 ..D STOP
 Q:$G(XPDABORT)=1
 Q:DGFLAG
 D NEWRU ;create new RECEIVING USER (multiple)
 I $D(DGERROR) D
 .S DGTEXT(1)="Could not create a new RECEIVING USER for Q-PTI.DOMAIN.EXT."
 .S DGTEXT(2)="Stopping installation. Log a ticket ASAP."
 .D STOP
 Q:$G(XPDABORT)=1
 Q
TURNOFF ;set TRANSMIT field (FILE 407.71, Field 2) to NO
 ;for Q-PTT.DOMAIN.EXT (old transmission queue)
 K DGFDA,DGERROR
 S DGFDA(407.71,DGLOOP1,2)=0
 D UPDATE^DIE("","DGFDA",,"DGERROR")
 Q
TURNON ;set TRANSMIT field (FILE 407.71, Field 2) to YES
 ;for Q-PTI.DOMAIN.EXT (new transmission queue
 K DGFDA,DGERROR
 S DGFDA(407.71,DGLOOP1,2)=1
 D UPDATE^DIE("","DGFDA",,"DGERROR")
 S DGFLAG=1
 Q
NEWRU ;Create new RECEIVING USER
 K DGFDA,DGERROR
 S DGFDA(407.71,"+1,"_DGIEN_",",.01)="XXX" ;generic user
 S DGFDA(407.71,"+1,"_DGIEN_",",1)=DGQPTI  ;ien of Q-PTI.DOMAIN.EXT
 S DGFDA(407.71,"+1,"_DGIEN_",",2)=1       ;1=YES
 D UPDATE^DIE("","DGFDA",,"DGERROR")
 Q
CREATE ;create a PTF125 entry in FILE 407.7
 K DGFDA,DGERROR
 S DGFDA(407.7,"+1,",.01)="PTF125"
 S DGFDA(407.7,"+1,",.02)=100
 S DGFDA(407.7,"+1,",.03)=50
 D UPDATE^DIE("","DGFDA",,"DGERROR")
 Q
STOP ;display message and set XPDABORT=1 (stop patch install)
 D BMES^XPDUTL(.DGTEXT)
 S XPDABORT=1
 Q
 ;
NEWMG ;Create new 'PTI' mail group in FILE #3.8. Add PTT members to PTI.
 ;  Input: None
 ; Output: None
 ;
 N DGIEN ;ien of record in Mail Group (#3.8) file
 N DGGNM ;name of mail group
 N DGTXT ;array of text to put in description field of mail group
 N DGXMY ;array of local users to add to the mail group
 N DGFLAG ;indicator if any PTT members exist
 S DGGNM="PTI",DGFLAG="Y"
 ;
 D BMES^XPDUTL(">>> Creating new 'PTI' mail group...")
 ;
 ;short circuit if mail group already exists
 I $$FIND1^DIC(3.8,"","X",DGGNM,"B") D  Q
 . D MES^XPDUTL("     WARNING: Mail Group "_DGGNM_" already exists.")
 . D MES^XPDUTL("     Since the mail group exists, no action is required.")
 ;
 ;create new mail group and add installer as a member if no PTT members
 D MEMBER
 I '$O(DGXMY(0)) S DGXMY($G(DUZ))="",DGFLAG="N" ;want at least one member
 S DGTXT(1)="This mail group will receive confirmation mail messages from the"
 S DGTXT(2)="Austin Information Technology Center (AITC) postmaster for PTF"
 S DGTXT(3)="transaction messages sent to the Domain Q-PTI.DOMAIN.EXT."
 S DGTXT(4)="This mail group supports the interface between PTF and the"
 S DGTXT(5)="AITC."
 ;
 I $$MG^XMBGRP(DGGNM,0,$G(DUZ),0,.DGXMY,.DGTXT,1) D
 . D MES^XPDUTL("     Mail Group "_DGGNM_" was successfully created.")
 . D MES^XPDUTL("     This mail group will receive confirmation mail messages")
 . D MES^XPDUTL("     from the Austin Information Technology Center (AITC)")
 . D MES^XPDUTL("     postmaster for PTF transaction messages sent to the")
 . D MES^XPDUTL("     Domain Q-PTI.DOMAIN.EXT.")
 . D MES^XPDUTL("")
 . D:DGFLAG="N" MES^XPDUTL("     You have been added as the sole member of this mail group.")
 . D:DGFLAG="N" MES^XPDUTL("     Please enter other members as appropriate.")
 . D:DGFLAG="Y" MES^XPDUTL("     PTT mail group members have been added to this mail group.")
 E  D
 . D MES^XPDUTL("     ERROR: Mail Group was not created!")
 . D MES^XPDUTL("     Please enter a support ticket for assistance.")
 Q
MEMBER ;find MAIL GROUP (3.8) MEMBERs and set DGXMY array
 N DGARRAY,DGDUZ,DGERROR,DGLOOP,DGMG
 S DGMG=$O(^XMB(3.8,"B","PTT",0))
 Q:'DGMG
 D GETS^DIQ(3.8,DGMG_",","**","EI","DGARRAY","DGERROR")
 Q:'$D(DGARRAY(3.81))  ;no MEMBERs
 S DGLOOP=""
 F  S DGLOOP=$O(DGARRAY(3.81,DGLOOP)) Q:DGLOOP=""  D
 .S DGDUZ=$G(DGARRAY(3.81,DGLOOP,.01,"I"))
 .S:DGDUZ>0 DGXMY(DGDUZ)=""
 Q
 ;
POST ;Main entry point for Post-init items
 ;
 ;Item 1 - Rebuild PTF portion of the Clinical Reminders Global Index ^PXRMINDX(45).
 D REINDEX
 ;
 ;Item 2 - Re-compile input templates
 D RECOMP
 ;
 Q
 ;
PROGCHK(XPDABORT) ;
 ;Check for required programmer variables
 ;This procedure will determine if the installers programmer variables are set up.
 ;Per KIDS documentation: During the environment check routine, use of direct
 ;WRITEs must be used for output messages.
 ;
 ;  Input: 
 ;   XPDABORT - KIDS var to indicate if install should
 ;              abort, passed by reference
 ;
 ; Output:
 ;   XPDABORT - if = 2, then abort entire installation
 ;
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") D
 . W !!,"    **********"
 . W !,"      ERROR: Environment check failed!"
 . W !,"      Your programming variables are not set up properly. Once"
 . W !,"      your programming variables are set up correctly, re-install"
 . W !,"      this patch DG*5.3*884."
 . W !,"    **********"
 . ;tell KIDS to abort the entire installation of the distribution
 . S XPDABORT=2
 Q
 ;
REINDEX ;Rebuild the PTF portion of the Clinical Reminders Global Index
 N DGINSTDT,DGRSLT,DGTEXT,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSK
 ;
 D BMES^XPDUTL(">>> Rebuild PTF portion of the Clinical Reminders Global Index...")
 ;
 ;if patch 884 has already been installed and index rebuilt, skip another rebuild
 I $$INSTALDT^XPDUTL("DG*5.3*884",.DGRSLT) D
 . S DGINSTDT=+$O(DGRSLT(0)) ;get first install date
 . ;if index was built after first install then skip rebuild
 . I $G(^PXRMINDX(45,"DATE BUILT"))>DGINSTDT D
 . . S DGTEXT(1)="    The DG*5.3*884 patch has previously been installed."
 . . S DGTEXT(2)="    Skipping another rebuild of the PTF portion of the index."
 ;quit if a rebuild is not needed
 I $D(DGTEXT(1)) D BMES^XPDUTL(.DGTEXT) Q
 ;
 ;queue off PTF Clinical Reminders Global Index rebuild
 S ZTRTN="INDEX^DGPTDDCR"
 S ZTDESC="DG*5.3*884 PTF Clinical Reminders Global Index rebuild"
 S ZTDTH=$$NOW^XLFDT
 S ZTIO=""
 D ^%ZTLOAD
 S DGTEXT(1)="    PTF Clinical Reminders Global Index rebuild queued."
 S DGTEXT(2)="    The task number is "_$G(ZTSK)_"."
 D MES^XPDUTL(.DGTEXT)
 Q
 ;
RECOMP ;Recompile input templates
 ;Recompile all compiled input templates that contain specific fields.
 ;This is needed because the data dictionary definition of these fields
 ;has changed and they are being exported via KIDS.
 ;
 ; Supported ICR #3352:  This ICR provides the use of DIEZ^DIKCUTL3 to recompile
 ;                       all compiled input templates that contain specific fields.
 ;
 N DGFLD
 ;
 D BMES^XPDUTL(">>> Re-compiling input templates...")
 ;
 ;build array of file and field numbers for top-level (#45) file fields being exported
 ;array format: DGFLD(file#,field)="" 
 F DGFLD=79,79.16,79.17,79.18,79.19,79.201,79.21,79.22,79.23,79.24,79.241,79.242,79.243,79.244 S DGFLD(45,DGFLD)=""
 F DGFLD=79.245,79.246,79.247,79.248,79.249,79.2491,79.24911,79.24912,79.24913,79.24914,79.24915 S DGFLD(45,DGFLD)=""
 F DGFLD=82.01,82.02,82.03,82.04,82.05,82.06,82.07,82.08,82.09,82.1,82.11,82.12,82.13 S DGFLD(45,DGFLD)=""
 F DGFLD=82.14,82.15,82.16,82.17,82.18,82.19,82.2,82.21,82.22,82.23,82.24,82.25 S DGFLD(45,DGFLD)=""
 ;
 ;build array of file and field numbers for 401 (#45.01) sub-file fields being exported
 ;array format: DGFLD(sub-file#,field)=""
 F DGFLD=8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32 S DGFLD(45.01,DGFLD)=""
 ;
 ;build array of file and field numbers for 501 (#45.02) sub-file fields being exported
 ;array format: DGFLD(sub-file#,field)=""
 F DGFLD=5,6,7,8,9,11,12,13,14,15,81.01,81.02,81.03,81.04,81.05,81.06,81.07,81.08,81.09 S DGFLD(45.02,DGFLD)=""
 F DGFLD=81.1,81.11,81.12,81.13,81.14,81.15,82.01,82.02,82.03,82.04,82.05,82.06,82.07,82.08,82.09,82.1 S DGFLD(45.02,DGFLD)=""
 F DGFLD=82.11,82.12,82.13,82.14,82.15,82.16,82.17,82.18,82.19,82.2,82.21,82.22,82.23,82.24,82.25 S DGFLD(45.02,DGFLD)=""
 ;
 ;build array of file and field numbers for 601 (#45.05) sub-file fields being exported
 ;array format: DGFLD(sub-file#,field)=""
 F DGFLD=4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28 S DGFLD(45.05,DGFLD)=""
 ;
 ;recompile all compiled input templates that contain the fields in the DGLFD array passed by reference
 D DIEZ^DIKCUTL3(45,.DGFLD)
 K DGFLD
 ;
 D BMES^XPDUTL("    Re-compile completed.")
 Q
