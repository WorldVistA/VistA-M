MCENV00 ;WISC/DAD-ENVIRONMENT CHECK ROUTINE ;9/9/96  07:38
 ;;2.3;Medicine;;09/13/1996
 ;
 S ^XTMP("MC",0)=$$FMADD^XLFDT(DT,30)_U_DT_U_"Medicine 2.3 Installation"
 S XPDNOQUE=1 ; *** Prevent user from queing the installation ***
 D GETVER
 D FILCHK
 D PCHCHK
 I $G(XPDENV)=1 D
 . D ASKDEL
 . D ASKDEV
 . Q
 Q
 ;
GETVER ; Get version of Medicine package installed
 N VERSION
 W !!,"Checking for previous version of the medicine package."
 S VERSION=$P($T(MCARE+1^MCARE),";",3)
 I VERSION["VERSION" S VERSION=$P(VERSION,"VERSION ",2)
 S ^XTMP("MC","VER")=VERSION
 I VERSION]"" D
 . W !!,"Found Medicine package version ",VERSION,"."
 . I VERSION<2 D
 .. W !!,"You are running a version of the Medicine package less"
 .. W !,"than 2.0.  Medicine 2.3 can only install over top of"
 .. W !,"version 2.0, 2.2, or in a virgin account."
 .. Q
 . Q
 E  D
 . W !!,"Medicine package not found."
 . Q
 Q
 ;
ASKDEL ; Ask about deletion of Medicine if version is < 2.0
 N VERSION
 S VERSION=^XTMP("MC","VER"),^XTMP("MC","DEL")=0
 I VERSION]"",VERSION<2 D
 . N DIR
 . S DIR(0)="Y"
 . S DIR("A",1)="Cannot install over version "_VERSION_"."
 . S DIR("A")="Delete old Medicine files and data"
 . S DIR("B")="No"
 . S DIR("?")="Please answer YES or NO"
 . S DIR("?",1)="You are running a version of the Medicine package less"
 . S DIR("?",2)="than 2.0.  Medicine 2.3 can only install over top of"
 . S DIR("?",3)="version 2.0, 2.2, or in a virgin account.  If you"
 . S DIR("?",4)="answer YES to this question, ALL MEDICINE FILES AND"
 . S DIR("?",5)="DATA WILL BE DELETED.  If you answer NO, the"
 . S DIR("?",6)="installation will abort."
 . W ! D ^DIR I Y'=1 S XPDABORT=2 Q
 . K DIR
 . S DIR(0)="Y"
 . S DIR("A",1)="All Medicine files and data will be deleted!"
 . S DIR("A")="Are you sure"
 . S DIR("B")="No"
 . S DIR("?")="Please answer YES or NO"
 . S DIR("?",1)="Answering YES to this question will cause the deletion"
 . S DIR("?",2)="of all Medicine files and data."
 . S DIR("?",3)=""
 . W ! D ^DIR I Y'=1 S XPDABORT=2 Q
 . S ^XTMP("MC","DEL")=1
 . Q
 Q
 ;
FILCHK ; Check to see if required files are present
 N CHECK,FILENAME,FILENUM,INSVER,LOOP,PACKAGE,REQVER,ABORT
 W !!,"Checking for minimum required package versions." S ABORT=0
 F LOOP=1:1 S CHECK=$P($T(REQFILE+LOOP),";;",2) Q:CHECK=""  D
 . S FILENUM=$P(CHECK,U,1),FILENAME=$$GET1^DID(FILENUM,"","","NAME")
 . S PACKAGE=$P(CHECK,U,2),REQVER=$P(CHECK,U,3)
 . S INSVER=+$$GET1^DID(FILENUM,"","","VERSION")
 . I INSVER'>0 S INSVER=$$VERSION^XPDUTL($P(CHECK,U,4))
 . I ($$VFILE^DILFD(FILENUM)=0)!(INSVER<REQVER) D
 .. S ABORT=1
 .. W !!,"The Medicine Package requires the "_FILENAME
 .. W !,"file (#"_FILENUM_") from the "_PACKAGE
 .. W !,"package, minimum version "_REQVER_"."
 .. Q
 . Q
 I ABORT D
 . S XPDABORT=2
 . W !!,"Missing or insufficient version of"
 . W "file(s), aborting installation."
 . Q
 E  D
 . W !!,"All required files found."
 . Q
 Q
 ;
PCHCHK ; Check for patch DI*21*25
 W !!,"Checking for patch DI*21*25."
 I $$PATCH^XPDUTL("DI*21.0*25")'>0 D
 . W !,"Patch not found, aborting installation."
 . S XPDABORT=2
 . Q
 E  D
 . W !,"Patch found."
 . Q
 Q
 ;
ASKDEV ; Ask device to print conversion reports to
 N VERSION
 S VERSION=+^XTMP("MC","VER"),^XTMP("MC","DEV")=""
 I VERSION'=2 Q
 N %ZIS,IOP,MC,POP
 F MC=1:1:2 D  Q:'POP
 . K %ZIS,IOP,POP
 . S %ZIS="NQ",%ZIS("A")="Device for conversion reports (required): "
 . S %ZIS("B")=""
 . S %ZIS("S")="I $$GET1^DIQ(3.2,+$P($G(^%ZIS(1,+Y,""SUBTYPE"")),U),.01)?1""P-"".E"
 . W ! D ^%ZIS
 . I POP,MC=1 W !!,"You must enter a device name!"
 . Q
 I POP D
 . S XPDABORT=2
 . W !!,"No device selected, aborting installation."
 . Q
 E  D
 . S ^XTMP("MC","DEV")="Q;"_ION_";"_IOST_";"_IOM_";"_IOSL
 . Q
 Q
 ;
REQFILE ; File# ^ Package_Name ^ Minimum_Required_Version
 ;;2^PIMS^5.3^DPT
 ;;50^OUTPATIENT PHARMACY^2.2^PSO
 ;;55^OUTPATIENT PHARMACY^2.2^PSO
 ;;61^LAB SERVICE^5.1^LA
 ;;61.1^LAB SERVICE^5.1^LA
 ;;61.3^LAB SERVICE^5.1^LA
 ;;61.5^LAB SERVICE^5.1^LA
 ;;80^DRG GROUPER^5.3^ICD
 ;;100^ORDER ENTRY/RESULTS REPORTING^2.5^OR
 ;;101^ORDER ENTRY/RESULTS REPORTING^2.5^OR
 ;;120.8^ADVERSE REACTION TRACKING^2.2^GMRA
 ;;123^CONSULT/REQUEST TRACKING^2.5^GMRC
 ;;
