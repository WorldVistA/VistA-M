PSNPPSDL ;HP/ART - National Drug File Updates File Download ;09/23/2015
 ;;4.0;NATIONAL DRUG FILE;**513**; 30 Oct 98;Build 53
 ;
 ;Reference to ^XUSEC( supported by IA #10076
 ;
 Q
 ;
DOWNLOAD ;Entry point for menu option PSN DOWNLOAD NDF UPDATES for immediate PPS-N update file download
 N PSENTER,PSNLEGF
 I $$GET1^DIQ(57.23,1,9,"I")="Y" D  Q
 .W !!,"The PPS-N/NDF file download is already in progress.  Please try again later."
 .R !!,"Press enter to continue...",PSENTER:120
 N DIRUT,DUOUT,DIR,X,Y
 I '$D(^XUSEC("PSN PPS ADMIN",DUZ)) D  Q
 . W !!,"You do not have the appropriate security key to use this option"
 . W !,"please contact your ADPAC to resolve this issue.",!
 . S DIR(0)="E",DIR("A")=" Press ENTER to Continue"
 . D ^DIR
 ;
 S PSNLEGF="",PSNLEGF=$$LEGACY() I PSNLEGF Q
 D CHKD ;update Unix directory if needed and create it if entry does not exist.
 ;
 W !!!,"Warning: This download should only be done during off peak hours!"
 ;
 N DIRUT,DUOUT,DIR,X,Y
 W ! S DIR(0)="Y",DIR("?")="Please enter Y or N."
 S DIR("A")="Are you sure you want to immediately start an NDF update download"
 S DIR("B")="NO" D ^DIR I 'Y Q
 W !,"Please stand-by NDF update download may take up to 30 minutes...",!
 ;
RUNIT ; Entry point for tasked menu option "PSN TASK SCHEDULED DOWNLOAD"
 N PSNSCJOB S PSNSCJOB=1 D EN^PSNFTP
 Q
 ;
SCHDOPT ; Entry point for menu option "PSN TASK SCHEDULE DOWNLOAD" to create and/or edit the scheduling date/time
 N DIRUT,DUOUT,DIR,X,Y,PSSTART,PSFREQ,PSERROR,PSNLEGF
 I '$D(^XUSEC("PSN PPS ADMIN",DUZ)) D  Q
 . W !!,"You do not have the appropriate security key to use this option"
 . W !,"please contact your ADPAC to resolve this issue.",!
 . S DIR(0)="E",DIR("A")=" Press ENTER to Continue"
 . D ^DIR
 ;
 S PSNLEGF="",PSNLEGF=$$LEGACY() I PSNLEGF Q
 D CHKD ;update Unix directory if needed and create it if entry does not exist.
 ;
 W !!!,"This option allows you to schedule a recurring TasKMan job to"
 W !,"perform the NDF update file download from PPS-N."
 W !!,"Warning! This download should be scheduled during non-peak hours."
 W !!,"You will need to select a date/time and how often this download should reoccur."
 ;
 N DIRUT,DUOUT,DIR,X,Y
 ;W !!
 D SCHCK("PSN TASK SCHEDULED DOWNLOAD","D") ;print scheduled tasks
 ;
 S DIR(0)="Y",DIR("?")="Please enter Y or N."
 S DIR("A")="Do you want to schedule an automatic NDF download in TaskMan",DIR("B")="NO"
 D ^DIR I 'Y Q
 ;
 N %DT,Y
 D NOW^%DTC
 S %DT(0)=%,%DT="EFATX",%DT("A")="Enter date/time: " D ^%DT
 S PSSTART=$$FMADD^XLFDT(Y,0,0,5)
 ;
 N DIRUT,DUOUT,DIR,X,Y
 W !!
 S DIR(0)="Y",DIR("?")="Please enter Y or N."
 S DIR("A")="Should this download be re-scheduled at the same time weekly"
 S DIR("B")="NO" D ^DIR I Y S PSFREQ="7D" G END
 ;
 N DIRUT,DUOUT,DIR,X,Y
 W !!
 S DIR(0)="Y",DIR("?")="Please enter Y or N."
 S DIR("A")="Should this download be re-scheduled at the same time daily"
 S DIR("B")="NO" D ^DIR
 I Y S PSFREQ="1D" G END
 I 'Y D
 . W !!,"Warning! The download you have scheduled will occur only once."
 . S PSFREQ=""
 ;
END ;
 N DIRUT,DUOUT,DIR,X,Y
 W !,"Your start time is:"
 D RESCH^XUTMOPT("PSN TASK SCHEDULED DOWNLOAD",PSSTART,"",PSFREQ,"L",.PSERROR)
 I +PSFREQ=1 W !!,"The download will automatically be re-scheduled Daily",!
 I +PSFREQ=7 W !!,"The download will automatically be re-scheduled Weekly",!
 I PSFREQ="" W !!,"The download will NOT automatically be re-scheduled",!
 S DIR(0)="E",DIR("A")=" Press ENTER to Continue"
 D ^DIR
 Q
 ;
SCHCK(OPTION,TYPE) ; check PPS-N scheduled Download or Install tasks
 ;  input - OPTION as name of option
 ;          TYPE as task type (D-Download/I-Install)
 ;  output - print future queued tasked (external format)
 ;
 N I,II,PSIEN,XX,NODE,NODE1,PSNROOT
 ; check to see if the option is defined in option scheduler file and it is tasked.
 D OPTSTAT^XUTMOPT(OPTION,.PSNROOT) I '+$G(PSNROOT(1)) Q
 S (I,II)=0
 F  S I=$O(PSNROOT(I)) Q:'I  S II=II+1 D
 .I II=1 W !!!,"Scheduled "_$S(TYPE="D":"Downloads",TYPE="I":"Installs",1:"")_" are:",!,"-----------------------"
 .W !,$P(PSNROOT(I),"^")_"  "_$$DATE($P(PSNROOT(I),"^",2),1),"  ",$P(PSNROOT(I),"^",3),!
 I II=0 W !,"*** Currently NO scheduled "_$S(TYPE="D":"Downloads",TYPE="I":"Installs",1:"")," tasks.",!
 Q
 ;
DATE(NODE,PIECE) ; return appropriate date
 ;  input - NODE as node of data
 ;          PIECE as piece of node to convert
 ; output - date in external format
 ;
 Q $$UP^XLFSTR($$FMTE^XLFDT($P(NODE,"^",PIECE)))
 ;
LEGACY() ;check legacy update file processing parameter
 N PSNLEG,PSNF,PSENTER
 S (PSNF,PSNLEG)="",PSNLEG=$$GET1^DIQ(57.23,1,45)   ;legacy update
 I PSNLEG="YES" S PSNF=1 D
 .W !!,"This option may not be utilized because the Legacy Update Processing"
 .W !,"site parameter is defined as YES.  You may only install FORUM NDF patch updates.",!
 .R !!,"Press enter to continue...",PSENTER:120
 Q PSNF
 ;
CHKD ; check Unix dir and update it if contains control char and other special characters
 I $$OS^%ZOSV()'="UNIX" Q
 N UNXLD,UNXLD1 S (UNXLD,UNXLD1)=""
 D UPDT
 S UNXLD=$$GETD^PSNFTP()
 I '$$DIREXIST^PSNFTP2(UNXLD) D MAKEDIR^PSNFTP2(UNXLD)
 Q
 ;
UPDT ; update unix/linux directory, called by PSNPPSDL 
 N DA,DIE,DR
 S UNXLD=$P($G(^PS(57.23,1,0)),"^",4) I UNXLD]"" D
 .S UNXLD1=$$STRIP^PSNPARM(UNXLD) I UNXLD]"",(UNXLD'=UNXLD1) S DIE="^PS(57.23,",DA=1,DR="3////"_UNXLD D ^DIE K DIE,DA,DR
 Q
 ;
