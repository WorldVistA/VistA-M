ABSVM ;OAKLANDFO/DPC - VSS MIGRATION;8/23/2002
 ;;4.0;VOLUNTARY TIMEKEEPING;**31,33**;Jul 1994
 ;
 ;
PREP ;
 ;Entry  point for the Prepare For Transition option.
 ;Accomplishes the initial setup.
 N ABSSITE,SITENUM,DIR,I,DIERR,ABSFDA,ABSIEN
 N ABSSITES ;This array is created in BLDVOLLT^ABSVMUT1.
 W @IOF
 ;Check for existing entries.
 D LIST^DIC(503339.5)
 I ^TMP("DILIST",$J,0) D  Q
 . W !!,"This option has already been run.  The Migration Process is started."
 . W !,"Continue the Migration process with another option."
 . W !,"Contact the System Implementation team if you need additional instructions."
 . Q
 ;
 W "You are starting the process that will move "
 W !,"Voluntary Timekeeping data to the new "
 W !,"Voluntary Service System application."
 W !!,"First, information about your site will be collected."
 ;this get the Station Number from Institution file
 S ABSSITE=$P($G(^DIC(4,+$$KSP^XUPARAM("INST"),99)),U)
 I ABSSITE="" W !!,"There is no Station Number for your site, Contact System Implementation team!!!" Q
 W !,"Your Volunteer Daily Time file will be scanned to find "
 W !,"all sites referenced.  This will take some time.",!
 D BLDVOLLT^ABSVMUT1("S")
 W !,"Done."
 W !!,"Your primary site number is "_ABSSITE_"."
 W !,"Volunteer Hours are recorded for the following sites:"
 S SITENUM=0
 F I=0:1 S SITENUM=$O(ABSSITES(SITENUM)) Q:SITENUM=""  W !,?20,SITENUM
 W !!,"The next section will allow you to designate which of the above sites",!,"you want data sent from.  Your primary site will default to 'YES' ",!
 I I W "Any Games site,(700, 701, 702, or 575W), will default to 'NO'.",!
 S DIR(0)="Y"
 S DIR("A")="Do you want to continue"
 S DIR("??")="If the information is not correct, answer NO. The preparation process will be stopped for now."
 D ^DIR
 W !!
 I 'Y W "CONTACT THE IMPLEMENTATION TEAM. PROCESS STOPPED FOR NOW." Q
 W "Making an entry in the Voluntary Migration Log file."
 S ABSFDA(503339.5,"+1,",.01)=ABSSITE,SITENUM=0
 F I=2:1 S SITENUM=$O(ABSSITES(SITENUM)) Q:SITENUM=""  D
 . S ABSFDA(503339.51,"+"_I_",+1,",.01)=SITENUM
 . ;setup games site for no sending of data
 . S:"^700^701^702^575W^"[(U_SITENUM_U) ABSFDA(503339.51,"+"_I_",+1,",.02)="N"
 D UPDATE^DIE("E","ABSFDA","ABSIEN")
 I $D(DIERR) W ! D MSG^DIALOG() Q
 D SITEINFO(ABSIEN(1))
 W !
 D SENDMSG(ABSIEN(1))
 Q
 ;
SITEINFO(ABSIEN) ;
 ;User Inputs data for sites
 N ABSROOT,I,DIE,DA,DR,DIERR,SITENUM
 D LIST^DIC(503339.51,","_ABSIEN_",",1,,,,,,,,"ABSROOT")
 I $D(DIERR) W ! D MSG^DIALOG() Q
 F I=1:1:+ABSROOT("DILIST",0) D
 . S DIE="^ABS(503339.5,"_ABSIEN_",1,",SITENUM=ABSROOT("DILIST",1,I)
 . S DA=ABSROOT("DILIST",2,I),DA(1)=ABSIEN
 . D
 .. ;check for primary or games site
 .. I SITENUM=ABSSITE S DR="W ""Send this Station's Data?: YES"";.02///YES;1:11" Q
 .. I "^700^701^702^575W^"[(U_SITENUM_U) S DR="W ""Send this Station's Data?: NO"";.02///NO" Q
 .. S DR=".02//YES;S:X=""N"" Y=0;1:11"
 .. Q
 . S DIE("NO^")="BACK"
 . W !!,?20,"Add information for Station Number "_SITENUM,!
 . D ^DIE
 . Q
 ;save codes
 W !!,"Saving information...",!
 D SAVE^ABSVMLC1,SAVE^ABSVMLC2
 Q
 ;
SENDMSG(NEWIEN) ;
 N ABSMSG,OUT,ABSRECIP,DIR,DIRUT,X,Y
 N MSGNUM,ABSSUBJ,ABSMSG,ABSRECIP
 S OUT=0
 W !,"Sending a message containing information about your site."
 F  Q:OUT  D
 . S DIR(0)="FAO"
 . S DIR("A")="Enter a Recipient of the Institution Creation message: "
 . S DIR("?")="See the Install Instructions for the recipients e-mail address."
 . S DIR("?",1)="Network e-mail addresses must contain '@'."
 . D ^DIR
 . I $G(DIRUT) D
 . . I $D(ABSRECIP) S OUT=1 Q  ;At least 1 recipient selected.
 . . N DIR,X,Y,DIRUT,DIK,DA
 . . W !!,"You must enter at least one recipient of the message."
 . . W !,"If you do not, you will need to run the Preparation option again"
 . . W !,"and re-enter all information.",!
 . . S DIR(0)="Y"
 . . S DIR("A")="Do you want to exit the Preparation option and run it again later"
 . . S DIR("B")="No"
 . . D ^DIR
 . . I Y D
 . . . W !!,"Rerun Preparation later. BYE."
 . . . ;Delete entry in Migration Log.
 . . . S DIK="^ABS(503339.5,",DA=NEWIEN
 . . . D ^DIK
 . . . S OUT=1
 . . . Q
 . . Q
 . E  S ABSRECIP(X)=""
 . Q
 I '$D(ABSRECIP) Q  ;No recipients selected.
 S ABSSUBJ="VSS: Institution Creation Message from: "_$P($G(^DIC(4,+$$KSP^XUPARAM("INST"),99)),U)
 D BLDMSG(.ABSMSG,NEWIEN)
 D SENDMSG^XMXAPI(DUZ,ABSSUBJ,"ABSMSG",.ABSRECIP,,.MSGNUM)
 W !,"Message sent.  Message number: "_MSGNUM
 Q
 ;
BLDMSG(MSGBODY,NEWIEN) ;
 N I,LNCNT,TEXT
 S LNCNT=0
 S TEXT="This is a VSS migration message."
 D ADDLN(TEXT,.MSGBODY,.LNCNT)
 S TEXT="It contains information needed to create an entry in the VtkInstitutions table."
 D ADDLN(TEXT,.MSGBODY,.LNCNT,1)
 S TEXT="The message is sent from Station Number: "_$P($G(^DIC(4,+$$KSP^XUPARAM("INST"),99)),U)_"."
 D ADDLN(TEXT,.MSGBODY,.LNCNT,1)
 S TEXT="The sender is "_$$GET1^DIQ(200,DUZ_",",.01)_" (DUZ= "_DUZ_")."
 D ADDLN(TEXT,.MSGBODY,.LNCNT)
 ;GET the list of station numbers.
 N FLDNUM,ABSIEN,VALUE,FIELD
 D LIST^DIC(503339.51,","_NEWIEN_",",1,,,"X",,"SN",,,"ABSROOT")
 I $D(DIERR) W ! D MSG^DIALOG() Q
 ;Assemble the message for each site.
 F I=1:1:+ABSROOT("DILIST",0) D
 . S TEXT="          INFORMATION FOR STATION NUMBER: "_ABSROOT("DILIST","ID",I,.01)
 . D ADDLN(TEXT,.MSGBODY,.LNCNT,1)
 . S ABSIEN=ABSROOT("DILIST",2,I)_","_NEWIEN_","
 . ;Fieldnames and values are obtained for Voluntary Migration Log.
 . ;Note changes to the DD will require changes to this code.
 . F FLDNUM=1:1:11 D
 . . S FIELD=$$GET1^DID(503339.51,FLDNUM,,"LABEL")
 . . S VALUE=$$GET1^DIQ(503339.51,ABSIEN,FLDNUM)
 . . S TEXT=FIELD_":  "_VALUE
 . . D ADDLN(TEXT,.MSGBODY,.LNCNT,1)
 . . Q
 . Q
 Q
 ;
ADDLN(LINE,BODY,COUNT,SKIP) ;
 I $G(SKIP) S COUNT=COUNT+1,BODY(COUNT)=" "
 S COUNT=COUNT+1
 S BODY(COUNT)=LINE
 Q
 ;
VAL ;
 ;Entry point for Validate Existing Data Option
 ;Checks all data that will be migrated and creates log entries 
 ;containing entries with problems.
 ;Optionally, you can print results.
 N DIR,Y,ABSRES,ABSRESDA,ABSIEN,EXSITES
 W @IOF
 ;Check to assure entry exists in Migration Log file.
 D ABSIEN^ABSVMUT1 Q:'ABSIEN
 W "Data that will be moved to the new Voluntary Service System database"
 W !," will now be checked for consistency."
 W !!,"The result will be recorded in the Voluntary Migration Log File."
 W !,"You will have the opportunity to print these results."
 W !!
 ;
 S DIR(0)="Y"
 S DIR("A")="Do you want to proceed"
 S DIR("??")="If you answer NO, you can check the data at a later time."
 D ^DIR
 I 'Y W !!,"Data checking can be done at a later time.  Bye." Q
 ;
 W !!,"Creating list of all Volunteers with hours after Sept. 30, 1996."
 D EXSITES^ABSVMUT1
 D BLDVOLLT^ABSVMUT1()
 W !,"Done."
 ;
 W !!,"Creating lists of valid Organization, Service, Schedule, and Award Codes."
 D LDCDS^ABSVMUT1
 W !,"Done."
 ;
 W !!,"Validating entries in the Volunteer Organization Codes File."
 D ORGVAL^ABSVMRV1(,.ABSRES)
 W !,"Errors Found in Organization Codes: "_ABSRES("ERRCNT")
 S ABSRESDA(ABSRES("DA"))=""
 ;
 W !!,"Validating entries in the Service Assignment Codes File."
 D SRVVAL^ABSVMRV1(,.ABSRES)
 W !,"Errors found in Service Assignment Codes: "_ABSRES("ERRCNT")
 S ABSRESDA(ABSRES("DA"))=""
 ;
 W !!,"Validating Occasional Hours."
 D OHRSVAL^ABSVMHV1(,.ABSRES)
 W !,"Errors found in Occasional Hours: "_ABSRES("ERRCNT")
 S ABSRESDA(ABSRES("DA"))=""
 ;
 W !!,"Validating Regular Hours."
 W !,"THIS WILL TAKE SOME TIME."
 D RHRSVAL^ABSVMHV1(,.ABSRES)
 W !,"Errors found in Regular Hours: "_ABSRES("ERRCNT")
 S ABSRESDA(ABSRES("DA"))=""
 ;
 W !!,"Validating Volunteer data."
 W !,"THIS WILL TAKE SOME TIME."
 D VALVOL^ABSVMVV1(,.ABSRES)
 W !,"Errors found in Volunteer data: "_ABSRES("ERRCNT")
 S ABSRESDA(ABSRES("DA"))=""
 ;
 W !!,"The data checking on your system is complete!"
 D CLEANCDS^ABSVMUT1 ;Kills arrays of National Codes
 ;
 W !!
 S DIR(0)="Y"
 S DIR("A")="Do you want to print the results now"
 S DIR("??")="If you answer NO, you can print the results later."
 D ^DIR
 I Y D PRINTRES(.ABSRESDA,ABSIEN)
 Q
 ;
PRINT ;
 ;Prints entries from the VALIDATION RESULTS multiple of Voluntary Migration Log file.
 N DIC,Y,DA
 N ABSI,ABSVDA,DIR,ABSIEN
 N OUT S OUT=0
 W @IOF
 ;Check to assure entry exists in Migration Log file.
 D ABSIEN^ABSVMUT1 Q:'ABSIEN
 W "You can print results of the Examination of Existing Data "
 W !,"by selecting the date/time that the examination was done."
 W !
 F ABSI=1:1 D  Q:OUT
 . S DIC="^ABS(503339.5,"_ABSIEN_",2,"
 . S DIC(0)="AE"
 . D ^DIC
 . I Y=-1 S OUT=1 Q
 . S ABSVDA(+Y)=""
 . W !
 . S DIR(0)="Y"
 . S DIR("A")="Do you want to select another result to print"
 . D ^DIR
 . I 'Y S OUT=1 Q
 . W !
 . Q
 I $D(ABSVDA) D PRINTRES(.ABSVDA,ABSIEN)
 Q
 ;
PRINTRES(ABSVMDA,ABSMIEN) ;
 ;Prints preselected subentries in the VALIDATION RESULTS multiple
 ;passed in by the input parameter (passed by reference).
 N ABSI,POP,DA,DIC
 D ^%ZIS
 Q:$G(POP)
 U IO
 S ABSI=0
 F  S ABSI=$O(ABSVMDA(ABSI)) Q:ABSI=""  D
 . W @IOF
 . W "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
 . S DIC="^ABS(503339.5,"_ABSMIEN_",2,"
 . S DA(1)=1
 . S DA=ABSI
 . D EN^DIQ
 . Q
 D ^%ZISC
 Q
 ;
