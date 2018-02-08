PSNPPSNV ;HP/MJE-PPSN update NDF data additional update code ; 05 Mar 2014  1:20 PM
 ;;4.0;NATIONAL DRUG FILE;**513**; 30 Oct 98;Build 53
 ;Reference to ^PS(59.7 supported by DBIA #2613
 ;
 Q
DATA ;Process DATA transactions
 K FDA
 S FDA(57.231,CTRLXIEN_","_CTRLIEN_",",6)="DATA"
 D UPDATE^DIE("","FDA","CTRLIEN")
 K FDA
 I '$D(^TMP("PSN PPSN PARSED",$J,"DATA")) Q
 N DA,I,J,K,LINE,PSN,ROOT,X
 S ROOT=$NA(^TMP("PSN PPSN PARSED",$J,"DATA")),J=0
 F  S J=$O(@ROOT@(J)) Q:'J  S LINE=^(J),K=$L(LINE,"|")-1 F I=1:1:K S X=$P(LINE,"|",I),^TMP($J,$P(X,"^"))=$P(X,"^",2,4)
 S DA=0 F  S DA=$O(^PSNDF(50.68,DA)) Q:'DA  S X=$P($G(^(DA,1)),"^",1,4) S:$D(^TMP($J,DA)) X=X_"^"_^(DA) S ^PSNDF(50.68,DA,1)=X
 K ^TMP($J)
 K DA,I,J,K,LINE,PSN,ROOT,X
 Q
 ;
PMIUPDT ;Get PMI data and completly replace all globals 50.621-627
 N FDA,DA,I,J,K,LINE,PSN,ROOT,X
 S FDA(57.231,CTRLXIEN_","_CTRLIEN_",",6)="PMIDATA"
 D UPDATE^DIE("","FDA","CTRLIEN")
 N FDA,DA,I,J,K,LINE,PSN,X
 I $D(^TMP("PSN PPSN PARSED",$J,"PMIDATA")) F PSN=50.621:.001:50.627 K ^PS(PSN)
 S ROOT=$NA(^TMP("PSN PPSN PARSED",$J,"DATA")),J=0
 K ^TMP($J)
 F  S J=$O(@ROOT@(J)) Q:'J  S LINE=^(J),K=$L(LINE,"|")-1 F I=1:1:K S X=$P(LINE,"|",I),^TMP($J,$P(X,"^"))=$P(X,"^",2,4)
 S DA=0 F  S DA=$O(^PSNDF(50.68,DA)) Q:'DA  S X=$P($G(^(DA,1)),"^",1,4) S:$D(^TMP($J,DA)) X=X_"^"_^(DA) S ^PSNDF(50.68,DA,1)=X
 K ^TMP($J)
 I $D(^TMP("PSN PPSN PARSED",$J,"PMIDATA")) F PSN=50.621:.001:50.627 M ^PS(PSN)=^TMP("PSN PPSN PARSED",$J,"PMIDATA",PSN)
 K DA,I,J,K,LINE,PSN,ROOT,X
 Q
 ;
TASKIT(FREQ,START) ; create/update PSNTUPDT option start time and frequency
 ; Input:
 ;   FREQ  - Optional
 ;  START  - Optional
 ;
 K PSERROR
 D NOW^%DTC S %DT(0)=%,%DT="EFATX",%DT("A")="Enter date/time: " D ^%DT
 S START=$$FMADD^XLFDT(Y,0,0,5)
 K DIRUT,DUOUT,DIR,X,Y S DIR(0)="Y",DIR("?")="Please enter Y or N."
 S DIR("A")="Should this NDF update install be re-scheduled at the same time weekly" W !!
 S DIR("B")="NO"
 D ^DIR
 I Y S FREQ="7D" G END
 K DIRUT,DUOUT,DIR,X,Y S DIR(0)="Y",DIR("?")="Please enter Y or N."
 S DIR("A")="Should this NDF update install be re-scheduled at the same time daily" W !!
 S DIR("B")="NO"
 D ^DIR
 I Y S FREQ="1D" G END
 I 'Y D
 .W !!,"Warning! The NDF update install you have scheduled will occur only once."
 .S FREQ=""
END ;
 W !,"Your start time is:"
 D RESCH^XUTMOPT("PSN TASK SCHEDULED INSTALL",START,"",FREQ,"L",.PSERROR)
 I +FREQ=1 W !!,"The NDF update install will automatically be re-scheduled Daily",!
 I +FREQ=7 W !!,"The NDF update install will automatically be re-scheduled Weekly",!
 I FREQ="" W !!,"The NDF update install will NOT automatically be re-scheduled",!
 K DIR S DIR(0)="E",DIR("A")=" Press ENTER to Continue" D ^DIR K DIR
 Q
 ;
SCHDOPT ; edit option PSNTUPDT/PSN TASK SCHEDULE INSTALL to create and/or edit the scheduling date/time
 ; Called from "PSN PPS SCHEDULE INSTALL" option to create and/or edit the scheduling
 N PSNLEGF
 I '$D(^XUSEC("PSN PPS ADMIN",DUZ)) D
 .W !!,"You do not have the appropriate security key to use this option"
 .W !,"please contact your ADPAC to resolve this issue.",!
 .S DIR(0)="E",DIR("A")=" Press ENTER to Continue" D ^DIR K DIR
 I '$D(^XUSEC("PSN PPS ADMIN",DUZ)) Q
 S PSNLEGF="",PSNLEGF=$$LEGACY^PSNPPSDL() I PSNLEGF Q
 W !!!,"This option allows you to schedule a recurring TaskMan job to perform the NDF"
 W !,"update installation from PPS-N."
 W !!,"Warning! This NDF update install should be scheduled during non-peak hours."
 W !!,"You will need to select a date/time and how often this update should reoccur."
 ;
 D SCHCK^PSNPPSDL("PSN TASK SCHEDULED INSTALL","I") ; print scheduled tasks
 ;
 K DIRUT,DUOUT,DIR,X,Y S DIR(0)="Y",DIR("?")="Please enter Y or N."
 S DIR("A")="Do you want to schedule an automatic NDF update install in TaskMan" W !!
 S DIR("B")="NO"
 D ^DIR
 I 'Y Q 
 N PSSROOT
 D TASKIT(15)
 Q
 ;
PROMPT ;
 W @IOF I '$D(^XUSEC("PSN PPS ADMIN",DUZ)) D
 .W !!,"You do not have the appropriate security key to use this option"
 .W !,"please contact your ADPAC to resolve this issue.",!
 .S DIR(0)="E",DIR("A")=" Press ENTER to Continue" D ^DIR K DIR
 I '$D(^XUSEC("PSN PPS ADMIN",DUZ)) Q
 W !!,"This option allows a user to setup the following PPS-N configuration settings:"
 W !!,"1) The Cache host disk directory path that will be used for location of the"
 W !,"   PPS-N weekly NDF update file/s."
 W !!,"2) The last successful INSTALL version number of the PPS-N update file."
 W !,"   This is the UPDT option version number."
 W !!,"3) The last successful DOWNLOAD version number of the PPS-N update file."
 W !,"   This is the DNLD option version number."
 W !!,"4) The Exchange email Group or Individual email address that the PPS-N national"
 W !,"   and locally generated reports will be sent to."
 W !!,"5) The PPS-N mail group for the PPSN NATIONAL TEST SQA email status."
 W !!,"6) The Scheduled Options, Menu Options, and Protocols that should be paused"
 W !,"   while the PPS-n update file is processed."
 W !!,"7) The PPS-N NATIONAL SQA ACCOUNT (Q)A, (P)roduction, Product (S)upport"
 W !,"    or (T)est."
 W !
 W ! K DIR S DIR(0)="E",DIR("A")=" Press ENTER to Continue" D ^DIR K DIR
 Q:Y="^"!(Y=0)
 W @IOF,!!
 W !,"At the prompt please enter the specific VMS or Linux directory path name"
 W !,"where the PPS-N update file/s will be located. If you are not familiar with"
 W !,"the required information please consult your ADPAC."
 K DIRUT,DUOUT,DIR,X,Y S DIR(0)="Y",DIR("?")="Please enter Y or N."
 S DIR("A")="Do you want to change the disk directory path for PPS-N Update files" W !
 S DIR("B")="NO"
 D ^DIR
 Q:Y="^"
 I Y D PATH
 ;
UPDT ;
 W @IOF,!!!,"At the prompt you can change the last successful update version number"
 W !,"of the PPS-N update file.  This is for the UPDT option."
 K DIRUT,DUOUT,DIR,X,Y S DIR(0)="Y",DIR("?")="Please enter Y or N."
 S DIR("A")="Do you want to change the version number of the PPS-N Update files" W !
 S DIR("B")="NO"
 D ^DIR
 Q:Y="^"
 I Y D INSTV
 K DIRUT,DUOUT,DIR,X,Y
DNLD ;
 W @IOF,!!!,"At the prompt you can change the last successful DOWNLOAD version number"
 W !,"of the PPS-N update file.  This is for the DNLD option."
 K DIRUT,DUOUT,DIR,X,Y S DIR(0)="Y",DIR("?")="Please enter Y or N."
 S DIR("A")="Do you want to change the DOWNLOAD version number of the PPS-N files" W !
 S DIR("B")="NO"
 D ^DIR
 Q:Y="^"
 I Y D DNLDV
 K DIRUT,DUOUT,DIR,X,Y
DEMAIL ;
 W @IOF,!!!,"At the prompt you can change the Exchange email Group or Individual"
 W !,"email address that the PPS-N national and locally generated reports"
 W !,"will be sent to."
 K DIRUT,DUOUT,DIR,X,Y S DIR(0)="Y",DIR("?")="Please enter Y or N."
 S DIR("A")="Do you want to change the email address for the PPS-N update reports" W !
 S DIR("B")="NO"
 D ^DIR
 Q:Y="^"
 I Y D EMAIL
 K DIRUT,DUOUT,DIR,X,Y
 ;
 W @IOF,!!!,"At the prompt you can change the Exchange email Group or Individual"
 W !,"email address that the PPS-N PPSN NATIONAL TEST SQA emails will be sent to."
 K DIRUT,DUOUT,DIR,X,Y S DIR(0)="Y",DIR("?")="Please enter Y or N."
 S DIR("A")="Change the email address for the PPS-N PPSN NATIONAL TEST SQA emails" W !
 S DIR("B")="NO"
 D ^DIR
 Q:Y="^"
 I Y D SQAMAIL
 K DIRUT,DUOUT,DIR,X,Y
 ;
 D DISOPTS^PSNPPSNR
 K DIRUT,DUOUT,DIR,X,Y
TYPE ;
 W @IOF,!!!,"At the prompt you can change the PPS-N NATIONAL SQA ACCOUNT"
 K DIRUT,DUOUT,DTOUT,DIR,X,Y S DIR(0)="Y",DIR("?")="Please enter Y or N."
 S DIR("A")="Do you want to change the PPS-N PPSN NATIONAL TEST SQA" W !
 S DIR("B")="NO"
 D ^DIR
 Q:Y="^"!('Y)
TYPE2 ;
 N TYPE
 S TYPE="",TYPE=$P($G(^PS(59.7,1,10)),"^",12)
 W !!,"Your current PPS-N NATIONAL SQA ACCOUNT is set to: " W TYPE_" "_$S(TYPE="Q":"for National SQA Testing",TYPE="P":"for Production",TYPE="T":"for Test Account",TYPE="S":"for Product Support",1:"")
 ;W !!,"Please enter PPS-N NATIONAL SQA ACCOUNT"
TYPE3 ;
 W !,"P = Production",?40,"T = Test Account"
 W !,"S = Product Support",?40,"Q = QA National Testing"
 W !,"N = QA NDFMS",!
 R !,"Enter selection: ",X:$S($D(DTIME):DTIME,1:300) I '$T S DTOUT=1
 I X["?" D  G TYPE2
 .W !!?5,"This parameter determines if the system is SQA National Testing site,"
 .W !?5,"Testing Account, Product Support or a Production site. Enter P for"
 .W !,?5,"Production, T for Test Account, S for Product Support, Q for SQA"
 .W !,?5,"National Testing or N for QA NDFMS account.",!
 .W !!?5,"Local sites should define this parameter as P for Production or T for"
 .W !?5,"their Test Account. Product support should use S. SQA National Testing"
 .W !?5,"should team should have one account defined Q for QA, a different"
 .w !?5,"account for P for Production, and another for N for QA NDFMS."
 Q:X="^"
 I ",S,Q,T,P,N,"'[(","_X_",") W !!,"You must enter P, T, S, Q or N",! G TYPE2
 I X'=""&(X'="^")&($L(X)'=0) D
 .S $P(^PS(59.7,1,10),"^",12)=X
 .W !!,"You changed the PPS-N NATIONAL SQA ACCOUNT to: " W X
 .W ! K DIR S DIR(0)="E",DIR("A")=" Press ENTER to Continue" D ^DIR K DIR
 K DIRUT,DUOUT,DIR,X,Y
 Q
 ;
PATH ;
 W !!,"Your current update file path is set to: ",$$GETD^PSNFTP()
 W !!,"Please enter the complete directory path: " R X:$S($D(DTIME):DTIME,1:300) I '$T S DTOUT=1
 I X["?" D  G PATH
 .W !!?5,"Enter the operating system full directory path where the PPS-N Update",!?5,"file(s) will be stored."
 .W "  Refer to the NDF Technical manual and/or",!?5,"contact your IRM for more information."
 .W !?10,"Example:  ABC$:[USER.PPSN]"
 I X'=""&(X'="^")&(X'="?") D
 .D SETD(X)
 .W !!,"You changed the directory path to: " W X
 .W ! K DIR S DIR(0)="E",DIR("A")=" Press ENTER to Continue" D ^DIR K DIR
 Q
 ;
INSTV ;
 W !!,"Your current PPS-N INSTALL file version number is set to: " W:$D(^PS(57.23,1,0)) $P(^PS(57.23,1,0),"^",3) W !
 W !,"Please enter the current PPS-N update file version number: " R X:$S($D(DTIME):DTIME,1:300) I '$T S DTOUT=1
 I X["?" D  G INSTV
 .W !!?5,"Enter the last file version installed on the system. If the last file"
 .W !?5,"name installed was PPS_15PRV_16NEW.DAT, the last file version would be 16."
 I X'=""&(X'="^")&($L(X)'=0)&(X'="?") D
 .S $P(^PS(57.23,1,0),"^",3)=X
 .W !!,"You changed the INSTALL file version number to: " W X
 .W ! K DIR S DIR(0)="E",DIR("A")=" Press ENTER to Continue" D ^DIR K DIR
 Q
 ;
DNLDV ;
 W !!,"Your current PPS-N DOWNLOAD file version number is set to: " W:$D(^PS(57.23,1,0)) $P(^PS(57.23,1,0),"^",7) W !
 W !,"Please enter the current PPS-N DOWNLOAD file version number: " R X:$S($D(DTIME):DTIME,1:300) I '$T S DTOUT=1
 I X["?" D  G DNLDV
 .W !!?5,"Enter the last file version downloaded to the system. If the last file"
 .W !?5,"name downloaded was PPS_15PRV_16NEW.DAT, the last file version would be 16."
 I X'=""&(X'="^")&($L(X)'=0)&(X'="?") D
 .S $P(^PS(57.23,1,0),"^",7)=X
 .W !!,"You changed the DOWNLOAD file version number to: " W X
 .W ! K DIR S DIR(0)="E",DIR("A")=" Press ENTER to Continue" D ^DIR K DIR
 Q
 ;
EMAIL ;
 W !!,"Your current email address is set to: " W:$D(^PS(57.23,1,0)) $P($G(^PS(57.23,1,0)),"^",6) W !
 W !,"Please enter the email address: " R X:$S($D(DTIME):DTIME,1:300) I '$T S DTOUT=1
 I X["?" D  G EMAIL
 .W !!?5,"Enter an email address for receiving PPS-N download, install and error"
 .W !?5,"messages.  This is typically an MS Outlook email address since holders "
 .W !?5,"of the PSN PPS ADMIN key will continue to receive the NDF update messages."
 .W !?5,"These messages include success, completion, error, and the report"
 .W !?5,"messages like DATA UPDATE FROM NDF, etc."
 I X'=""&(X'="^")&($L(X)'=0)&(X'="?") D
 .S $P(^PS(57.23,1,0),"^",6)=X
 .W !!,"You changed the email address to: " W X
 .W ! K DIR S DIR(0)="E",DIR("A")=" Press ENTER to Continue" D ^DIR K DIR
 Q
 ;
SQAMAIL ;
 W !!,"Your current email address is set to: " W:$D(^PS(57.23,1,1)) $P($G(^PS(57.23,1,1)),"^",1) W !
 W !,"Please enter the email address: " R X:$S($D(DTIME):DTIME,1:300) I '$T S DTOUT=1
 I X["?" D  G SQAMAIL
 .W !!?5,"Enter an email address for receiving PPS-N download, install and error"
 .W !?5,"messages.  This is used by SQA for a secondary email group if needed."
 .W !?5,"Typically an MS Outlook email address is defined since holders of the"
 .W !?5,"PSN PPS ADMIN key will continue to receive the NDF update messages.  These"
 .W !?5,"messages include success, completion, error, and the report messages like"
 .W !?5," DATA UPDATE FROM NDF, etc."
 I X'=""&(X'="^")&($L(X)'=0)&(X'="?") D
 .S $P(^PS(57.23,1,1),"^",1)=X
 .W !!,"You changed the email address to: " W X
 .W ! K DIR S DIR(0)="E",DIR("A")=" Press ENTER to Continue" D ^DIR K DIR
 Q
 ;
LOAD ;GET DOSE STUFF
 N DA1
 S J=2,X=$G(^PSDRUG(DA,"DOS")) I $P(X,"^"),$D(^PS(50.607,+$P(X,"^",2),0)) S ^TMP($J,INDX,NA_"^"_DA_"^"_IN,J)="    STRENGTH: "_+X_"UNITS: "_$P(^PS(50.607,+$P(X,"^",2),0),"^"),J=J+1
 I $O(^PSDRUG(DA,"DOS1",0)) S ^TMP($J,INDX,NA_"^"_DA_"^"_IN,J)="    POSSIBLE DOSES",^(J+1)="    DISP UNITS/DOSE     DOSE    PACKAGE   BCMA UNITS/DOSE",DA1=0,J=J+2 D
 .F  S DA1=$O(^PSDRUG(DA,"DOS1",DA1)) Q:'DA1  S X=^(DA1,0),^TMP($J,INDX,NA_"^"_DA_"^"_IN,J)="    "_$J($P(X,"^"),4),$E(^(J),25)=$J($P(X,"^",2),4),$E(^(J),35)=$P(X,"^",3),$E(^(J),43)=$P(X,"^",4),J=J+1
 I $O(^PSDRUG(DA,"DOS2",0)) S ^TMP($J,INDX,NA_"^"_DA_"^"_IN,J)="    LOCAL POSSIBLE DOSES",^(J+1)="    DOSE                                            PACKAGE   BCMA UNITS/DOSE",DA1=0,J=J+2 D
 .F  S DA1=$O(^PSDRUG(DA,"DOS2",DA1)) Q:'DA1  S X=^(DA1,0),^TMP($J,INDX,NA_"^"_DA_"^"_IN,J)="    "_$P(X,"^"),$E(^(J),55)=$P(X,"^",2),$E(^(J),71)=$P(X,"^",3),J=J+1
 Q
 ;
SETD(X) ;
 N PSOSX
 S PSOSX=$$GETOS^PSNFTP()
 I PSOSX["VMS" S $P(^PS(57.23,1,0),U,2)=X Q
 I PSOSX["LINUX" S $P(^PS(57.23,1,0),U,4)=X Q
 Q
