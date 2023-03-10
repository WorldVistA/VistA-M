PREAPO3 ;BIR/RTR - Identify AMPL users for patch PREA*1*3; OCT 16, 2020
 ;;1.0;ADVANCED MEDICATION PLATFORM;**3**;9/1/20;Build 19
 ; Reference to ^VA(200 in ICR #7209
 ;
EN ;Identify AMPL Users - called from the PREA AMPL GUI ACCESS option
 N PREAPROD,PREARUN,PREAPRG,PREAFNL,PREAWHO,PREAWHO1,PREAWHO2,PREAPIN1,PREAPIN2,PREAPIN3,X,X1,X2,DIR,Y,DTOUT,DUOUT,DIRUT,DIROUT
 I $D(^XTMP("PREAUSID","RUNNING")) D  Q
 .S PREAWHO=+^XTMP("PREAUSID","RUNNING")_","
 .D GETS^DIQ(200,PREAWHO,".01","E","PREAWHO2")
 .S PREAWHO1=$G(PREAWHO2(200,PREAWHO,.01,"E"))
 .W !!,"This job is currently running or tasked from another process by:",!
 .W $S($G(PREAWHO1)'="":"   "_PREAWHO1,1:"   Unknown User."),!
 .S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR W !
 S PREAPIN1=DUZ_","
 D GETS^DIQ(200,PREAPIN1,"205.5","E","PREAPIN2")
 S PREAPIN3=$G(PREAPIN2(200,PREAPIN1,205.5,"E"))
 I PREAPIN3="" D  Q
 .W !!,"You must have data in the ADUPN Field (#205.5) of the NEW PERSON File (#200)",!,"to run this option.",!
 .S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR W !
 D CLEAN
 I '$G(DT) S DT=$$DT^XLFDT
 S X1=DT,X2=30 D C^%DTC S PREAPRG=$G(X)
 S ^XTMP("PREAUSID",0)=PREAPRG_"^"_DT_"^"_"Identify AMPL users for patch PREA*1*3."
 S ^XTMP("PREAUSID","RUNNING")=$G(DUZ)
 S PREAPROD=+$$PROD^XUPROD,(PREARUN,PREAFNL)=0
 D ASK
 I 'PREARUN W !,"Nothing run, exiting option.",! D CLEAN Q
 D TASK
 Q
 ;
 ;
RUN ;Run job
 I PREAFNL D OUT^XPDMENU("PREA AMPL GUI ACCESS","Out of order, AMPL access already submitted.")
 N PREASITE,PREASTRT,PREASTOP
 S PREASTRT=$$DATE
 S PREASITE=$$SITE^VASITE
 D USER,MAIL I PREAFNL D MAILF
 D CLEAN
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
 ;
TASK ;Task Job
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTUCI,ZTCPU,ZTPRI,ZTSAVE,ZTKILL,ZTSYNC
 S ZTRTN="RUN^PREAPO3"
 S ZTDESC="Identify AMPL Users for access."
 S ZTSAVE("PREAPROD")="",ZTSAVE("PREAFNL")="",ZTSAVE("PREAPIN3")=""
 S ZTIO=""
 D ^%ZTLOAD
 I $D(ZTSK)[0 W !!,"Job not tasked to run.",! D CLEAN
 E  W !!,"Job tasked to run.",!
 D HOME^%ZIS
 Q
 ;
 ;
CLEAN ;Kill TMP Globals
 K ^TMP($J,"PREACHK"),^TMP($J,"PREAUSER"),^TMP($J,"PREANONM"),^TMP($J,"PREANET"),^XTMP("PREAUSID")
 Q
 ;
 ;
ASK ;User prompts
 N DIR,X,Y,DTOUT,DUOUT,DIRUT
 W !!,"This option generates the initial list of users that will be submitted for"
 w !,"Advanced Medication Platform (AMPL) access, based on Security Keys and"
 W !,"Person Class. Individual access can subsequently be granted or taken away by"
 W !,"following the procedures outlined in Appendix A of the PREA Technical Manual.",!
 ;
 I 'PREAPROD D TEST Q
 ;
 W !,"Since this is a production account, you can elect to:"
 W !,"   1. Only send this list to your Outlook and VistA emails, the"
 W !,"   list will not be submitted to grant AMPL access."
 W !,"   2. At the request of the Implementation Manager, send the list to"
 W !,"   yourself and the people who will submit AMPL access requests for"
 W !,"   all users on the list. If you elect to send the list to the team"
 W !,"   who submits AMPL access requests, the option will then be disabled."
 W !!,"           ********************NOTE********************"
 W !,"   Option 2 should only be done when requested by the Implementation"
 W !,"   Manager, AMPL will be a phased rollout.",!
 K DIR,Y S DIR(0)="Y",DIR("B")="Y",DIR("A")="Only send list to my Outlook and Vista emails"
 S DIR("?")=" ",DIR("?",1)="Enter 'Y' to only send the AMPL access user request list to yourself in"
 S DIR("?",2)="Outlook and VistA emails. Enter 'N' to submit the list for access granting."
 s DIR("?",3)="Enter '^' to exit." D ^DIR K DIR W !
 I $D(DTOUT)!($D(DUOUT)) Q
 I 'Y D  I $D(DTOUT)!($D(DUOUT)) Q
 .K DIR,Y S DIR(0)="Y",DIR("B")="N",DIR("A")="Are you sure you want to submit the final AMPL User request list"
 .S DIR("?")=" ",DIR("?",1)="Enter 'Y' to officially submit the AMPL access user request list."
 .S DIR("?",2)="Doing so will disable this option, since the list can be sent only once."
 .S DIR("?",3)="Enter '^' to exit." D ^DIR K DIR W !
 .I Y S PREAFNL=1
 S PREARUN=1
 Q
 ;
 ;
TEST ;Test account
 W !,"Since this is a test account, the list will only be sent to you at your Outlook"
 W !,"and VistA emails and will not be submitted to grant AMPL access. Submitting"
 W !,"for AMPL access can only happen when running this option in production.",!
 K DIR,Y S DIR(0)="Y",DIR("B")="Y",DIR("A")="Generate AMPL access user list"
 S DIR("?")=" ",DIR("?",1)="Enter 'Y' to generate the AMPL access user request list. This"
 S DIR("?",2)="list will only be sent to you at your Outlook and VistA emails." D ^DIR K DIR W !
 I Y'=1!($D(DTOUT))!($D(DUOUT)) Q
 S PREARUN=1
 Q
 ;
 ;
MAIL ;Send mail message
 N XMTEXT,XMY,XMSUB,XMDUZ,XMMG,XMSTRIP,XMROU,XMYBLOB,XMZ
 K ^TMP($J,"PREATEXT")
 S XMDUZ="PREA*1*3 AMPL User Identification"
 S XMSUB="AMPL access list-PREA*1*3 "_$P(PREASITE,"^",2)_" "_$P(PREASITE,"^",3)
 D SETTMP
 S XMTEXT="^TMP($J,""PREATEXT"","
 S XMY(DUZ)=""
 S XMY(PREAPIN3)=""
 N DIFROM,DUZ D ^XMD
 K ^TMP($J,"PREATEXT")
 Q
 ;
 ;
SETTMP ;Set TMP global data
 N PREALP1,PREALP2,PREALP3,PREALP4,PREALP5
 S PREALP1="",PREALP3=3
 F  S PREALP1=$O(^TMP($J,"PREAUSER",PREALP1)) Q:PREALP1=""  D
 .F PREALP2=0:0 S PREALP2=$O(^TMP($J,"PREAUSER",PREALP1,PREALP2)) Q:'PREALP2  D
 ..S ^TMP($J,"PREATEXT",PREALP3)=PREALP1,PREALP3=PREALP3+1
 S PREALP4=PREALP3-3
 S ^TMP($J,"PREATEXT",2)="Name ("_$S($G(PREAPROD):"PRODUCTION ACCOUNT",1:"TEST ACCOUNT")_")    Total: "_PREALP4
 S ^TMP($J,"PREATEXT",PREALP3)="",PREALP3=PREALP3+1
 S PREALP4=PREALP3,PREALP1="",PREALP3=PREALP3+1,PREALP5=0
 F  S PREALP1=$O(^TMP($J,"PREANONM",PREALP1)) Q:PREALP1=""  D
 .F PREALP2=0:0 S PREALP2=$O(^TMP($J,"PREANONM",PREALP1,PREALP2)) Q:'PREALP2  D
 ..S ^TMP($J,"PREATEXT",PREALP3)=PREALP1,PREALP3=PREALP3+1,PREALP5=PREALP5+1
 S ^TMP($J,"PREATEXT",PREALP4)="Users Missing Network UserName    Total: "_PREALP5
 I 'PREALP5 D
 .S PREALP3=PREALP3+1,^TMP($J,"PREATEXT",PREALP3)=""
 .S PREALP3=PREALP3+1,^TMP($J,"PREATEXT",PREALP3)="No entries found."
 S PREASTOP=$$DATE
 S ^TMP($J,"PREATEXT",1)="AMPL User ID job began: "_PREASTRT_"  ended: "_PREASTOP
 Q
 ;
 ;
USER ;Find users to get AMPL access
 ;^TMP($J,"PREACHK",DUZ)="" - User already identified as an AMPL user with/without vausername or uneligible
 ;^TMP($J,"PREAUSER",NAME,DUZ)=vausername - User identified as an AMPL User with vausername
 ;^TMP($J,"PREANONM",NAME,DUZ)="" - User identified as an AMPL User without vausername
 N PREAKEY,PREAVAUS,PREANAME,PREADATA,PREAVALU,PREADUZ
 F PREAKEY="PSORPH","PSO TECH ADV","PSD TECH","PSD TECH ADV","PSDRPH","PSDMGR","PSJ PHARM TECH","PSJ RPHARM","PSJI MGR","PSJI PHARM TECH","PSJU MGR","PSJU RPH" D
 .F PREADUZ=0:0 S PREADUZ=$O(^XUSEC(PREAKEY,PREADUZ)) Q:'PREADUZ  D
 ..I $D(^TMP($J,"PREACHK",PREADUZ)) Q
 ..S ^TMP($J,"PREACHK",PREADUZ)=""
 ..I $$ACTIVE(PREADUZ) D ADD(PREADUZ)
 ;Must loop through File 200 since there are no cross-references that gives all person of a Person Class:
 F PREADUZ=0:0 S PREADUZ=$O(^VA(200,PREADUZ)) Q:'PREADUZ  D
 .I $D(^TMP($J,"PREACHK",PREADUZ)) Q
 .I $$ACTIVE(PREADUZ),$$PER(PREADUZ) D ADD(PREADUZ)
 Q
 ;
 ;
ADD(PREAUSE1) ;User gets access, add to TMP global
 S PREAVALU=PREAUSE1_","
 D GETS^DIQ(200,PREAVALU,".01;501.1","E","PREADATA")
 S PREANAME=$G(PREADATA(200,PREAVALU,.01,"E")) I PREANAME="" Q
 S PREAVAUS=$G(PREADATA(200,PREAVALU,501.1,"E"))
 I PREAVAUS'="" S ^TMP($J,"PREAUSER",PREANAME,PREAUSE1)="" D:PREAFNL  Q
 .S ^TMP($J,"PREANET",PREAVAUS)=""
 S ^TMP($J,"PREANONM",PREANAME,PREAUSE1)=""
 Q
 ;
 ;
ACTIVE(PREAINAC) ;Check if user is inactive
 Q $$ACTIVE^XUSER(PREAINAC)
 ;
 ;
PER(PREAUSE2) ;Person Class check
 N PREAPCLS
 S PREAPCLS=$$GET^XUA4A72(PREAUSE2) I PREAPCLS'>0 Q 0
 I $$UP^XLFSTR($P(PREAPCLS,"^",2,3))'["PHARM" Q 0
 Q 1
 ;
 ;
MAILF ;Send final mail message
 N XMTEXT,XMY,XMSUB,XMDUZ,XMMG,XMSTRIP,XMROU,XMYBLOB,XMZ,PREANT,PREANTC
 K ^TMP($J,"PREATEXT") S PREANTC=1
 S XMDUZ="PREA*1*3 AMPL User Identification"
 S XMSUB="AMPL access list-PREA*1*3 "_$P(PREASITE,"^",2)_" "_$P(PREASITE,"^",3)
 S PREANT="" F  S PREANT=$O(^TMP($J,"PREANET",PREANT)) Q:PREANT=""  D
 .S ^TMP($J,"PREATEXT",PREANTC)=PREANT,PREANTC=PREANTC+1
 I PREANTC=1 S ^TMP($J,"PREATEXT",1)="No users found."
 S XMTEXT="^TMP($J,""PREATEXT"","
 S XMY("VAITEPMOEPMDPREPHARMGUISSOI@domain.ext")=""
 S XMY(PREAPIN3)=""
 N DIFROM,DUZ D ^XMD
 K ^TMP($J,"PREATEXT")
 Q
 ;
 ;
DATE() ;Returns Date/Time
 N X,Y,%,%H,%I,PREADATE
 D NOW^%DTC
 D YX^%DTC S PREADATE=Y
 Q PREADATE
