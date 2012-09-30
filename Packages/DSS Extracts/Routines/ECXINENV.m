ECXINENV ;ALB/JAP - Environment Check for DSS Install ;Nov 03, 1997
 ;;3.0;DSS EXTRACTS;;Dec 22, 1997
EN ;entry point
 N Y,J,JJ,DIR,DTOUT,DUOUT,DIRUT,ECX,MSG,MSG1,MSG2,MSG2B,MSG3,FILE,FILENM,TEXT
 K XPDQUIT,XPDABORT
 F J=1:1:12 S TEXT=$P($T(MSG1+J),";",3),MSG1(J)=TEXT
 F J=1:1:4 S TEXT=$P($T(MSG2+J),";",3),MSG2(J)=TEXT
 F J=1:1:8 S TEXT=$P($T(MSG2B+J),";",3),MSG2B(J)=TEXT
 F J=1:1:8 S TEXT=$P($T(MSG3+J),";",3),MSG3(J)=TEXT
 ;is this is not a first time install provide user warning
 I $O(^ECX(728,0)) D MES^XPDUTL(.MSG1) D
 .W ! S DIR(0)="Y",DIR("A")="Continue with the installation",DIR("B")="NO",DIR("?")="Answer YES to install DSS EXTRACTS v3.0 or NO to stop."
 .D ^DIR
 .I Y=0!($G(DIRUT)) S XPDQUIT=1 D MES^XPDUTL("Installation aborted...")
 .K DIR,DIRUT,DTOUT,DUOUT W !
 Q:$G(XPDQUIT)
 D MES^XPDUTL(">>> Checking Environment --")
 D MES^XPDUTL(" ")
 I +$G(DUZ)'>0!($G(DUZ(0))'="@")!($G(U)'="^")!('$D(DT))!('$D(IOSL)) D
 .S XPDQUIT=2
 .D MES^XPDUTL("You must first initialize Programmer Environment by running ^XUP.")
 .D MES^XPDUTL(.MSG2)
 .D MES^XPDUTL(" ") S DIR(0)="E" D ^DIR K DIR
 Q:$G(XPDQUIT)
 ;don't bother checking files if this is first-time install of dss
 Q:'$O(^ECX(728,0))
 ;if this is a re-install of v3.0, don't insist that data in files be deleted
 D FILE^DID(728,,"VERSION","ECX")
 ;only do this check if version is 2
 ;see if there's any extract data still in files from v2.0t11
 I ECX("VERSION")'["3.0" D
 .F J=1:1:20 S FILE=$P($T(FILES+J),";",3),FILENM=$P($T(FILES+J),";",4) D
 ..S JJ=$O(^ECX(FILE,0)) I +JJ>0 D
 ...S MSG="   Data still exists in file "_FILENM_" (#"_FILE_")."
 ...D:($Y+3>IOSL) PAUSE
 ...D MES^XPDUTL(MSG) S XPDQUIT=2
 I $G(XPDQUIT) D  Q
 .D:($Y+8>IOSL) PAUSE
 .D MES^XPDUTL(.MSG2B)
 .F J=1:1:20 S FILE=$P($T(FILES+J),";",3),FILENM=$P($T(FILES+J),";",4) D
 ..S JJ=$O(^ECX(FILE,0)) I +JJ>0 D
 ...S MSG="   "_FILENM_" (#"_FILE_")"
 ...D:($Y+3>IOSL) PAUSE
 ...D MES^XPDUTL(MSG)
 .D:($Y+5>IOSL) PAUSE
 .D MES^XPDUTL(.MSG2)
 .D:($Y+12>IOSL) PAUSE
 .D MES^XPDUTL(.MSG3)
 D MES^XPDUTL("Environment check completed... OK.")
 Q
 ;
PAUSE ;screen pause
 N Y,JJ,SS
 I $E(IOST)="C" D
 .S SS=22-$Y F JJ=1:1:SS W !
 .D MES^XPDUTL(" ") S DIR(0)="E" D ^DIR K DIR
 W:$Y!($E(IOST)="C") @IOF
 Q
 ;
CLEAN ;allow site to cleanup old extract records
 N FF,J,JJ,JJJ,DIC,DR,DA,DIQ,FILE,EXTRACT,ECX,TYPE,START,PURGE,ABORT,OUT,DATA,CLEAN1,CLEAN2,REM,MSG
 F J=1:1:8 S TEXT=$P($T(CLEAN1+J),";",3),CLEAN1(J)=TEXT
 F J=1:1:6 S TEXT=$P($T(CLEAN2+J),";",3),CLEAN2(J)=TEXT
 W !!
 D FILE^DID(728,,"VERSION","ECX")
 I ECX("VERSION")["3.0" D  Q
 .D:($Y+3>IOSL) PAUSE D MES^XPDUTL(.CLEAN1)
 ;if v3 not installed then continue
 S ABORT=0,DATA=0
 F FF=1:1:20 S FILE=$P($T(FILES+FF),";",3),FILENM=$P($T(FILES+FF),";",4),JJ=0 D  Q:ABORT=1
 .F  S JJ=$O(^ECX(FILE,JJ)) Q:+JJ<1  I +JJ>0 D  Q:ABORT=1
 ..S OUT=0
 ..S EXTRACT=$P(^ECX(FILE,JJ,0),"^",3),DIC=727,DR="2;3;9",DIQ(0)="I",DIQ="ECX"
 ..K ECX S DA=EXTRACT D EN^DIQ1
 ..S TYPE=$G(ECX(727,DA,2,"I")),START=$G(ECX(727,DA,3,"I")),PURGE=$G(ECX(727,DA,9,"I"))
 ..;if this extract was not previously purged, don't proceed
 ..I PURGE="" D  Q
 ...S ABORT=1
 ...D:($Y+3>IOSL) PAUSE D MES^XPDUTL(.CLEAN2)
 ..S REM(1)="   Data will now be deleted from:"
 ..S REM(2)="   File #"_FILE_" - Extract #"_EXTRACT
 ..S DATA=1
 ..D:($Y+3>IOSL) PAUSE D MES^XPDUTL(.REM)
 ..S JJJ=JJ-1
 ..F  S JJJ=$O(^ECX(FILE,JJJ)) Q:+JJJ<1  I +JJJ>0 D  Q:OUT=1
 ...S EXTRX=$P(^ECX(FILE,JJJ,0),"^",3)
 ...I EXTRX'=EXTRACT S OUT=1
 ...Q:OUT=1
 ...S DIK="^ECX("_FILE_",",DA=JJJ D ^DIK
 ...S MSG="      Record #"_JJJ_" in File #"_FILE_" deleted."
 ...D:($Y+3>IOSL) PAUSE D MES^XPDUTL(MSG)
 ..W !!
 I ABORT=0,DATA=1 D
 .S MSG="   Clean-up of old extract data complete."
 .D:($Y+3>IOSL) PAUSE D MES^XPDUTL(MSG)
 I ABORT=0,DATA=0 D
 .S MSG="   There are no old extract records which can be deleted."
 .D:($Y+3>IOSL) PAUSE D MES^XPDUTL(MSG)
 W !!
 Q
 ;
FILES ;files to be checked for existing data
 ;;727.802;ADMISSION EXTRACT
 ;;727.803;CLINIC EXTRACT
 ;;727.804;CLINIC NOSHOW EXTRACT
 ;;727.805;NURSING EXTRACT
 ;;727.806;DENTAL EXTRACT
 ;;727.808;PHYSICAL MOVEMENT EXTRACT
 ;;727.809;UNIT DOSE LOCAL EXTRACT
 ;;727.81;PRESCRIPTION EXTRACT
 ;;727.811;SURGERY EXTRACT
 ;;727.813;LABORATORY EXTRACT
 ;;727.814;RADIOLOGY EXTRACT
 ;;727.815;EVENT CAPTURE LOCAL EXTRACT
 ;;727.817;TREATING SPECIALTY CHANGE EXTRACT
 ;;727.819;IV DETAIL EXTRACT
 ;;727.82;ADMISSION SETUP EXTRACT
 ;;727.821;PHYSICAL MOVEMENT SETUP EXTRACT
 ;;727.822;TREATING SPECIALTY CHANGE SETUP EXTRACT
 ;;727.823;PAI EXTRACT
 ;;727.824;LAB RESULTS EXTRACT
 ;;727.825;QUASAR EXTRACT
 ;
MSG1 ;
 ;;  
 ;;          ********** WARNING **********
 ;;  
 ;;DO NOT INSTALL DSS EXTRACTS V3.0 unless your site has
 ;;extracted, transmitted, and received transmission
 ;;confirmation from the Austin Automation Center for ALL 
 ;;FY97 data.  Prior approval for this installation should
 ;;have been received from the local DSS Site Manager.
 ;;  
 ;;   Answer YES to install DSS EXTRACTS v3.0.
 ;;   Answer NO to stop the installation process now.
 ;;  
MSG2 ;post abort message
 ;;   
 ;;  
 ;;Installation aborted...
 ;;  
MSG2B ;more post abort info if data in files
 ;;  
 ;;Before continuing with this installation, you should verify with
 ;;the DSS Site Manager that all FY97 data has been transmitted and
 ;;transmission confirmation has been received from the Austin 
 ;;Automation Center.  Then data from the following files should be
 ;;purged by the DSS Site Manager using the Purge Data from Extract
 ;;Files [ECXPURG] option:
 ;;   
MSG3 ;;restart info
 ;;  
 ;;When you wish to continue with this installation, simply select
 ;;the Install Package(s) [XPD INSTALL BUILD] option from the Kernel
 ;;Installation & Distribution System menu.  You do not need to 
 ;;reload the KIDS distribution file.  (The package build has not
 ;;been deleted from the ^XTMP global.)
 ;;  
 ;;  
CLEAN1 ;;can't cleanup global if v3 installed
 ;;
 ;;DSS EXTRACTS v3.0 has already been installed on this system.
 ;;This file clean-up cannot be performed after installation of
 ;;the new version.
 ;;  
 ;;If you are having difficulty, please contact the Customer Support
 ;;Help Desk.
 ;;
CLEAN2 ;;unpurged extract file
 ;;  
 ;;Cannot continue -- an unpurged extract file has been found.
 ;;   
 ;;Please advise the DSS Site Manager to complete purging of all
 ;;previously extracted data from files #727.802 through #727.825 
 ;;by using the DSS option Purge Data from Extract Files [ECXPURG].
 ;;  
