XPDIJ1 ;SFISC/RSD - Cont. of Install Job ;05/11/2001  09:07
 ;;8.0;KERNEL;**41,68,108,200,559**;Jul 10, 1995;Build 4
 ;Per VHA Directive  2004-038, this routine should not be modified.
IN ;install XPDA
 ;XPDA=ien of file 9.7, XPDNM=package name
 Q:'$D(^XTMP("XPDI",XPDA))!'$D(^XPD(9.7,XPDA,0))
 ;check if already installed
 I $P($G(^XPD(9.7,XPDA,1)),U,3) D BMES^XPDUTL(" "_XPDNM_" Already Installed ") Q
 N DIFROM,XPD,XPD0,XPDBLD,XPDCHECK,XPDCP,XPDI,XPDGREF,XPDIST,XPDIDTOT,XPDIDCNT,XPDIDMOD,XPDRTN
 ;XPDBLD subscript for build entry i.e. ^XTMP("XPDI",XPDA,"BLD",XPDBLD
 S DIFROM=$$VER^XPDUTL(XPDNM),XPDBLD=$O(^XTMP("XPDI",XPDA,"BLD",0)),XPDGREF="^XTMP(""XPDI"","_XPDA_",""TEMP"")"
 D TITLE^XPDID(XPDNM)
 ;^XTMP("XPDI",XPDA,"BLD",XPDBLD,6) is set when the msg is loaded.  Forum adds this as the last line of the msg.
 ;add Package file entry if sent, set TEST # & SEQ #
 S Y=$$PKGADD^XPDIP,XPD0=^XTMP("XPDI",XPDA,"BLD",XPDBLD,0),Y=$G(^(6)),XPDNM("TST")=$P(Y,U),XPDNM("SEQ")=$P(Y,U,2)
 I '$$CHK(11) D
 .D BMES^XPDUTL(" Install Started for "_XPDNM_" : "),STMP(11)
 .;update status, installed by fields and distribution date
 .S XPD(9.7,XPDA_",",.02)=2,XPD(9.7,XPDA_",",9)=DUZ,XPD(9.7,XPDA_",",51)=$P(XPD0,U,4)
 .D FILE^DIE("","XPD")
 E  D BMES^XPDUTL(" Install Restarted for "_XPDNM_" at "_$$HTE^XLFDT($H))
 D BMES^XPDUTL("Build Distribution Date: "_$$FMTE^XLFDT($P(XPD0,U,4)))
 D RTN Q:$D(XPDABORT)
 D PRE Q:$D(XPDABORT)
 D FMDATA Q:$D(XPDABORT)
 D COMP Q:$D(XPDABORT)
 D POST:$G(XPDT("MASTER"))'=XPDA
 Q  ;Finshed
 ;
RTN I '$$CHK(12) D
 .D BMES^XPDUTL(" Installing Routines:"),SETTOT^XPDID(9.8),RTN^XPDIJ(XPDA),STMP(12)
 E  D BMES^XPDUTL(" Routines already installed.")
 Q
 ;
PRE S XPDCP="INI"
 ;check if pre-install has completed
 I '$$VERCP^XPDUTL("XPD PREINSTALL COMPLETED") D  Q:$D(XPDABORT)
 .;setup XPDQUES array with pre-install questions/answers
 .D QUES^XPDIQ("PRE")
 .;XPDCHECK=ien of current checkpoint, (0)=name of checkpoint
 .;XPDCP="INI"-pre install or "INIT"-post install
 .;loop thru check points starting with INSTALL STARTED
 .S XPDCHECK=1
 .F  S XPDCHECK=$O(^XPD(9.7,XPDA,"INI",XPDCHECK)) Q:'XPDCHECK  S XPD=^(XPDCHECK,0) D  Q:$D(XPDABORT)
 ..;if there is no call back, quit
 ..Q:$G(^XPD(9.7,XPDA,"INI",XPDCHECK,1))=""  S XPDRTN=^(1)
 ..;check if checkpoint has been completed
 ..Q:$P(XPD,U,2)
 ..I XPDCHECK=2 D BMES^XPDUTL(" Running Pre-Install Routine: "_XPDRTN)
 ..;zero the progress bar
 ..I $D(XPDIDVT) S XPDIDTOT=0 D UPDATE^XPDID(0)
 ..D @XPDRTN
 ..;write message and abort if developer wants
 ..I $D(XPDABORT) D BMES^XPDUTL("Install ** ABORTED ** in Pre-Install program") Q
 ..S %=$$COMCP^XPDUTL(XPDCHECK)
 .Q:$D(XPDABORT)
 .;complete pre-init check point
 .S %=$$COMCP^XPDUTL("XPD PREINSTALL COMPLETED")
 E  D BMES^XPDUTL(" Pre-Install already finished.")
 Q
 ;
FMDATA ;build XPDQUES arrays for all of the FM Files
 D QUES^XPDIQ("XPF")
 ;check the last file and see if it's already installed
 S XPD=$G(^(+$O(^XPD(9.7,XPDA,4,"A"),-1),0))
 I '$P(XPD,U,2) D:$D(^XTMP("XPDI",XPDA,"FIA"))
 .D BMES^XPDUTL(" Installing Data Dictionaries: "),SETTOT^XPDID(4),FIA^XPDIK,MES^XPDUTL("               "_$$HTE^XLFDT($H))
 E  D BMES^XPDUTL(" Data Dictionaries already installed.")
 S %=+$O(^XTMP("XPDI",XPDA,"DATA",""),-1),XPD=$G(^XPD(9.7,XPDA,4,%,0))
 I '$P(XPD,U,3) D:%
 .D BMES^XPDUTL(" Installing Data: "),DAT^XPDIK,MES^XPDUTL("               "_$$HTE^XLFDT($H))
 E  D BMES^XPDUTL(" Data already installed.")
 Q
 ;
COMP S (%,XPD)=""
 F  S %=+$O(^XPD(9.7,XPDA,"KRN",%)) Q:'%  S XPD=$G(^(%,0)) Q:'$P(XPD,U,2)
 I '$P(XPD,U,2) D:$D(^XTMP("XPDI",XPDA,"KRN"))
 .D BMES^XPDUTL(" Installing PACKAGE COMPONENTS: "),KRN^XPDIK,MES^XPDUTL("               "_$$HTE^XLFDT($H))
 E  D BMES^XPDUTL(" PACKAGE COMPONENTS already installed.")
 Q
 ;
POST S XPDCP="INIT"
 ;check if post-install has completed
 I '$$VERCP^XPDUTL("XPD POSTINSTALL COMPLETED") D  Q:$D(XPDABORT)
 .;setup XPDQUES array with post-install questions/answers
 .D QUES^XPDIQ("POS")
 .;loop thru check points starting with INSTALL STARTED
 .S XPDCHECK=1
 .F  S XPDCHECK=$O(^XPD(9.7,XPDA,"INIT",XPDCHECK)) Q:'XPDCHECK  S XPD=^(XPDCHECK,0) D  Q:$D(XPDABORT)
 ..;if there is no call back, quit
 ..Q:$G(^XPD(9.7,XPDA,"INIT",XPDCHECK,1))=""  S XPDRTN=^(1)
 ..;quit if checkpoint has completed time
 ..Q:$P(XPD,U,2)
 ..I XPDCHECK=2 D BMES^XPDUTL(" Running Post-Install Routine: "_XPDRTN)
 ..;zero the progress bar
 ..I $D(XPDIDVT) S XPDIDTOT=0 D UPDATE^XPDID(0)
 ..D @XPDRTN
 ..;write message and abort if developer wants
 ..I $D(XPDABORT) D BMES^XPDUTL("Install ** ABORTED ** in Post-Install program") Q
 ..S %=$$COMCP^XPDUTL(XPDCHECK)
 .Q:$D(XPDABORT)
 .;complete post-init check point
 .S %=$$COMCP^XPDUTL("XPD POSTINSTALL COMPLETED")
 E  D BMES^XPDUTL(" Post-Install already finished.")
 ;move routines to install file & Routine file
 D BMES^XPDUTL(" Updating Routine file..."),SETTOT^XPDID(9.8),RTN^XPDIP
 ;XPDIST is flag for site tracking^A/B install message, it is set in PKG^XPDIP
 ;install Package file, OERR parameter multiple, and Build file
 S XPDIST="" D BMES^XPDUTL(" Updating KIDS files..."),PKG^XPDIP
 D BMES^XPDUTL(" "_XPDNM_" Installed. "),STMP(17)
 ;sends install messages local/forum
 S %=$$EN^XPDIST(XPDA,XPDIST) D BMES^XPDUTL(" "_$P("NO ",U,'$P(%,"#",2))_"Install Message sent "_%)
 Q
CHK(X) ;check checkpoints in file 9.7, X=field #, returns 1=completed, 0=not completed
 Q $$GET1^DIQ(9.7,XPDA_",",X,"I")]""
 ;
STMP(X) ;timestamp checkpoints in file 9.7, X=field #
 N XPD,%
 S %=$$NOW^XLFDT,XPD(9.7,XPDA_",",X)=%
 D MES^XPDUTL("               "_$$FMTE^XLFDT(%)),FILE^DIE("","XPD")
 Q
 ;
INHIBIT(SET) ;Set/Clear the Inhibit logon field.
 N VOL,IEN
 F IEN=0:0 S IEN=$O(^%ZIS(14.5,IEN)) Q:IEN'>0  D
 . I $P(^%ZIS(14.5,IEN,0),U,11)=1 S VOL(14.5,IEN_",",1)=SET
 . Q
 D FILE^DIE("","VOL")
 Q
