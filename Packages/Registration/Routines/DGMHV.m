DGMHV ;ALB/JCH - Display Pre-Registration MHV Enrollment/Registration ; 12/9/03 3:22pm
 ;;5.3;Registration;**903**;Aug 13, 1993;Build 82
 ;
 ; Submitted to OSEHRA 04/02/2015 by HP
 ; All entry points authored by James Harris 2014-2015
 ;
 Q
EN(DFN) ; Entry Point for Alert, Socialization, and MHV Enrollment/Registration field editing 'Screen'
 ;This functionality will only be executed if "Enable MyHealtheVet Prompts?" (#1100.07  
 ;field in MAS PARAMETERS (43) file is set to YES (internal value 1)
 D:$$MHVENABL^DGMHVUTL() MAIN^DGMHV(DFN)
 Q
MAIN(DFN) ; Main Entry Point for MHV socialization text/action
 ; Do not display MHV enrollment/registration 'screen' if socialization Action entered 
 ; (DGMHVOUT="A"), meaning MHV enrollment/registration is in progress, not a firm YES or NO
 ; Do not display socialization text/action if MHV ENROLLED/REGISTERED field is not null (DGMHVOUT="R")
 N DGMHVNOS,DGRSPNS,DGENTRY,DGACTS,DGMHAC,DGMHSEL,DGDPTSOC,DGMHVOUT,DGMHVNOS,DIR
 D CLEAR,ALERT,DSPLACT(DFN) I $G(DGMHVOUT)="" W !!! D CONT
 D CLEAR
 I $G(DGMHVOUT)="R" D EN^DGMHVAC(DFN) Q
 I $G(DGMHVOUT)="A" D  Q
 .N DGDPTSOC S DGDPTSOC=+$O(^DPT(DFN,1,"A"),-1)+1 D ACTIONS^DGMHV(.DGMHAC,.DGMHSEL,DGDPTSOC,"S")
 .Q:$G(DGMHVOUT)!$G(DGMHVNOS)
 .D EN^DGMHVAC(DFN)
 D SOCIAL^DGMHV Q:$G(DGMHVOUT)
 Q:$G(DGMHVNOS)
 D EN^DGMHVAC(DFN)
 Q
SOCIAL ; MHV Enrollment/Registration talking point/socialization text action
 ; Display MHV socialization canned text, prompt for patient response, display and prompt for clerk action
 I $P($G(^DPT(DFN,2)),"^") Q
 N DGSODONE
 F  Q:$G(DGSODONE)!$G(DGMHVOUT)  D SLOOP
 Q
SLOOP ; Allow user to go back and enter a different patient response in case the patient changes their mind
 N DGMHV,I,DGDIR0,DGDPTSOC,DGTAB,DGREADTX,DGMHVMOD S DGDPTSOC="",DGMHVMOD="S"
 K DIRUT
 S DGREADTX="Please read the following to the patient"
 D GTSOCODS(.DGDIR0) S DGDIR0="SO^",I="" F  S I=$O(DGDIR0(I)) Q:'I  S DGDIR0=DGDIR0_I_":"_DGDIR0(I)_";"
 F  Q:$G(DGMHVOUT)!$G(DGMHV("SOCIAL"))  D
 .D CLEAR W !!,DGREADTX
 .K DIR W !!?8,"""Has a health care team member encouraged you"
 .W !?9,"to register online for My HealtheVet?"""
 .S DIR("A")="Patient response"
 .S DIR(0)=DGDIR0
 .S DIR("??")="D CLEAR" D ^DIR I $E($G(Y))="^" S DGMHVOUT=1 Q
 .I Y="" W !!,"My HealtheVet registration information is required to continue with this patient",!! D CONT Q
 .S DGMHV("SOCIAL")=$G(DGDIR0(Y,"IEN"))
 Q:$G(DGMHVOUT)
 D FILSOC(DFN,+DGMHV("SOCIAL"),$$NOW^XLFDT,.DGDPTSOC)
 I DGMHV("SOCIAL")=1 D
 .N DGOLDEN S DGOLDEN=$P($G(^DPT(DFN,2)),"^")
 .N DIE,DR,DA S DIE="^DPT(",DR="537027////1;537030////"_$$NOW^XLFDT,DA=DFN D ^DIE
 .Q:DGOLDEN=1
 .N DGFLD F DGFLD=537033,537036 D FILRNA^DGMHVAC(DFN,DGFLD,"@")
 .N MHVND S MHVND=$G(^DPT(+DFN,2))
 .I $P(MHVND,"^",2)=0 F DGFLD=537028,537031,537034,537037 D FILRNA^DGMHVAC(DFN,DGFLD,"@")
 .I $P(MHVND,"^",3)=0 F DGFLD=537029,537032,537035,537038 D FILRNA^DGMHVAC(DFN,DGFLD,"@")
 Q:'$G(DGMHV("SOCIAL"))  D CLEAR W !!,DGREADTX W !! D CANNED(DGMHV("SOCIAL")) D CONT I (DGMHV("SOCIAL")>1) I $G(DIRUT)&($G(X)="^") S DGSODONE=0 Q
 N FLWUP,RTST S DGAR1=DGDPTSOC S FLWUP=$G(^DGMHV(390.01,DGMHV("SOCIAL"),4)) S RTST=$P(FLWUP,"^",2),RTST=$P(RTST,"(") I RTST]"" I $T(@RTST)]"" X FLWUP
 S DGSODONE=1
 Q
ALERT ; Displays the 'MHV Enrollment/Registration Information Missing' message
 Q:'$D(XQY0)
 N X,Y,IORVON,IORVOFF,DIR,DIRUT
 S X="IORVON;IORVOFF"
 D ENDR^%ZISS
 W !!!!?4,$CHAR(7) W:$D(IORVON) IORVON W "** PATIENT NEEDS TO ANSWER MY HEALTHEVET REGISTRATION QUESTIONS **" W:$D(IORVOFF) IORVOFF
 W !?4,"Patient is missing required My HealtheVet Registration information",!
 Q
FILSOC(DFN,RSPNT,RSPDT,DGDPTSOC) ; File MHV Socialization Information to PATIENT (#2) file
 ;    DFN = PATIENT IEN
 ;  RSPNT = RESPONSE POINTER TO FILE 390.01
 ;  RPSDT = RESPONSE DATE/TIME
 N DINUM,DIE,DA,DR,DO,DGMHVND K DIE,DA,DR,DO
 S DIC(0)="EZ",DIC="^DPT(DFN,1,",DA(2)=DFN,DA(1)=+$O(^DPT(DFN,1,"A"),-1)+1,DGDPTSOC=DA(1)
 S DGMHVND=DA(1),DINUM=DA(1),X=RSPDT,DIC("DR")=".01////"_RSPDT_";1////"_RSPNT D FILE^DICN
 K DIE,DIC,DA S DIE="^DPT(DFN,1,",DA(1)=DFN,DA=DGMHVND
 S DR=".01////"_RSPDT_";1////"_RSPNT D ^DIE
 Q
CANNED(SCRIPT) ; Display canned text from PATIENT TEXT (#2) field in the MHV SOCIALIZATION (#390.01) file
 Q:'$G(SCRIPT)
 N DGMHVLIN,DGLINCNT,DGMHVOUT S DGMHVLIN=$P($G(^DGMHV(390.01,SCRIPT,2,0)),"^",3),DGMHVOUT=0
 S DGLINCNT=0 F  S DGLINCNT=$O(^DGMHV(390.01,SCRIPT,2,DGLINCNT)) Q:'DGLINCNT!(DGLINCNT>DGMHVLIN)  D
 .W !?2 W:DGLINCNT=1 """" W ^DGMHV(390.01,SCRIPT,2,DGLINCNT,0) S DGMHVOUT=1
 W:$G(DGMHVOUT) """" W !
 Q
GTSOCODS(DGSOCCOD) ; Get array of socialization codes and display sequences from MHV SOCIALIZATION (#390.01) file
 K DGSOCCOD,DGSOCIEN,DGSOCSEQ S DGSOCSEQ="",DGSOCCOD="",DGSOCIEN="" N I,TEXT S I=0,TEXT=""
 F  S DGSOCSEQ=$O(^DGMHV(390.01,"C",DGSOCSEQ)) Q:'DGSOCSEQ  D
 .S DGSOCIEN="" F  S DGSOCIEN=$O(^DGMHV(390.01,"C",DGSOCSEQ,DGSOCIEN)) Q:DGSOCIEN=""  D
 ..N TEXT D FIND^DIC(390.01,"","@;.01","A",DGSOCIEN,1,"","","","TEXT")
 ..S I=I+1 S DGSOCCOD(I)=TEXT("DILIST","ID",1,".01"),DGSOCCOD(I,"IEN")=DGSOCIEN
 Q
NOFLW(DGSOCCOD) ; Perform followup dialog for patient that does not wish to enroll/register
 N DIR,DIC,DA,DGAR1,DGAR2 S DGAR1="",DGAR2=""
 W !! S DIR("A",1)="   How does the patient feel now about registering in My HealtheVet?"
 S DIR("A",2)=" ",DIR("A",3)="          1) Patient is not interested."
 S DIR("A",4)="          2) Patient is interested.",DIR("A",5)=" "
 S DIR(0)="SA^1:Patient is not interested;2:Patient is interested",DIR("A")="Select a response: "
 D ^DIR I $G(Y)'="1"  D ACTIONS(.DGAR1,DGAR2,$G(DGDPTSOC),"S") Q
 ; If patient isn't interested to be enrolled/register in MHV then update Enroll/Register,
 ; Authenticated, and Secure Message fields to "NO"
 N DIE,DR,DA,DGMHVNOW S DA=DFN,DGMHVNOW=$$NOW^XLFDT
 S DIE="^DPT(",DR="537027////0;537030////"_DGMHVNOW_";537028////0;537029////0;537031////"_DGMHVNOW_";537032////"_DGMHVNOW
 D ^DIE
 F DGRPFLD=537036:1:537038 D FILRNA^DGMHVAC(DFN,DGRPFLD,+$O(^DGMHV(390.03,"B","I am not interested.","")))
 Q
ACTIONS(DGMSACT,ACTSEL,DGENRQ,DGMHVMOD) ; Display MHV Socialization actions, allow selection, return selected actions in ACTSEL
 ; Input:
 ;   DGMSACT  - Array of selectable actions from MHV SOCIALIZATION ACTIONS (#390.02) file
 ;   ACTSEL   - Array of action(s) currently selected by clerk
 ;   DGENRQ   - Internal Entry Number (IEN) of the prospective MHV SOCIALIZATION (#537026) multiple in the PATIENT (#2) file into which
 ;              the selected actions in ACTSEL will be stored.
 ;   DGMHVMOD - Mode; the section of MHV functionality from which this is invoked. Used to screen selectable actions.
 ;                    "R" - Enrollment/Registration "S" - Socialization, "A" - Authentication field, "M" - Secure Messaging field
 K DIR,DGMSACT D CLEAR
 N DINUM,DIR,ACTCNT,DGACDONE,DGSTAY,DGACSAVE,DGACCNT S DGACDONE=0,DGACSAVE=0
 D GETACTS(.DGMSACT,$G(DGMHVMOD)) S DGACCNT=+$O(DGMSACT(""),-1)
 S DIR(0)="SA^" S ACTCNT=0 F  S ACTCNT=$O(DGMSACT(ACTCNT)) Q:'ACTCNT  S DIR(0)=DIR(0)_ACTCNT_":"_DGMSACT(ACTCNT)_";"
 S $P(DIR(0),"^",3)="D ACTRNSFM^DGMHV"
 F  Q:$G(DGACDONE)  D ACTLOOP(.DIR,.DGMSACT,.ACTSEL)
 I $G(DGACSAVE),$D(ACTSEL)>1 D  S DGMHVNOS=1 Q
 .I $G(DGENRQ),'$G(DGDPTSOC) S DGDPTSOC=DGENRQ
 .N DGSEL,DGAIEN,DGMHVND,DGPLURAL S DGSEL=0 F DGPLURAL=1:1 S DGSEL=$O(ACTSEL(DGSEL)) Q:'DGSEL  D
 ..N DIE,DA,DIC S DGAIEN=$G(ACTSEL(DGSEL,"IEN")),DIC(0)="EZ",DIC="^DPT("_DFN_",1,"_DGDPTSOC_",1,",DA(3)=DFN,DA(2)=DGDPTSOC
 ..S DA(1)=$O(^DPT(DFN,1,DA(2),1,"A"),-1)+1,DINUM=DA(1),X=DGAIEN,DGMHVND=DA(1),DIC("DR")=".01////"_DGAIEN D FILE^DICN I $G(DGENRQ) D
 ...N DA,DIE,DIC,RSPDT S RSPDT=$$NOW^XLFDT S DIE="^DPT(DFN,1,",DA(1)=DFN,DA=DGENRQ S DR=".01////"_RSPDT D ^DIE
 ..N DA,DIE,DIC K DIE,DIC,DA S DIE="^DPT("_DFN_",1,"_DGDPTSOC_",1,",DA(2)=DFN,DA(1)=DGDPTSOC,DA=$O(^DPT(DFN,1,DGDPTSOC,1,"A"),-1)
 ..S DR=".01////"_DGAIEN D ^DIE
 .W !,$S($G(DGPLURAL)=1:"Action",1:"Actions")," Filed...",! H .5
 S DGMHVOUT=1
 Q
ACTLOOP(DIR,DGMSACT,ACTSEL) ; Redisplay and reprompt user for action(s) until they're filed, or user aborts
 D CLEAR
 S DGSTAY=1
 W !?2,"Action(s) taken today to assist patient with My HealtheVet registration."
 W !?2,"-----------------------------------------------------------------------"
 D ^DIR
 I Y="^"!$G(DIRUT) W !! N DGREALQ S DGREALQ=1 D  Q
 .N DIR,Y S DIR(0)="Y",DIR("A",1)="My HealtheVet registration questions are required to continue with this patient."
 .S DIR("A")="Are you sure you want to quit " D ^DIR I $G(Y) S DGMHVOUT=1,DGACDONE=1,DGACSAVE=0,DGSTAY=0 Q
 .S DGSTAY=1
 I $G(Y)>0 N DGSELL F DGSELL=1:1:$L(Y,",") N DGSELIT S DGSELIT=$P(Y,",",DGSELL) I DGSELIT]"" M ACTSEL(DGSELIT)=DGMSACT(DGSELIT)
 F  Q:'$G(DGSTAY)  D
 .D CLEAR N DIR,SELAC,DGCNT,DGII S DGCNT=1,DGSTAY=0
 .S DIR("A",DGCNT)="",DGCNT=DGCNT+1
 .S DIR("A",DGCNT)="Actions Selected:"
 .S DGCNT=DGCNT+1,DIR("A",DGCNT)=" " ;"-----------------------------------------------------------------------"
 .S SELAC="" F DGII=1:1 S SELAC=$O(ACTSEL(SELAC)) Q:'SELAC  D
 ..N SELACSUB,MARX S SELACSUB=0 D TXT(ACTSEL(SELAC),65) F  S SELACSUB=$O(MARX(SELACSUB)) Q:'SELACSUB  D
 ...S DGCNT=DGCNT+1 S DIR("A",DGCNT)=" "_$S(SELACSUB=1:SELAC_" - ",1:"    ")_" "_MARX(SELACSUB)
 .S DGCNT=DGCNT+1 S DIR("A",DGCNT)=""
 .S DIR("A")="  (A)dd another, (D)elete an action, or <RET> to save and exit: ",DIR(0)="SAO^A:Add an Action;D:Delete an Action" D ^DIR W !
 .Q:Y="A"
 .I Y="D" S DGSTAY=1 D DELETE(.ACTSEL) Q
 .I Y="^" W !! N DGREALQ S DGREALQ=1 D  Q
 ..N DIR,Y S DIR(0)="Y",DIR("A",1)="My HealtheVet registration information is required to continue with this patient."
 ..S DIR("A")="Are you sure you want to quit " D ^DIR I $G(Y) S DGMHVOUT=1,DGACDONE=1,DGACSAVE=0,DGSTAY=0 Q
 ..S DGSTAY=1
 .S DGACDONE=1,DGACSAVE=1
 Q
GETACTS(DGMSACT,DGMHVMOD) ; Get actions from the MHV SOCIALIZATION ACTIONS (#390.02) file; screen by mode (DGMHVMOD)
 ; Input: DGMHVMOD - Mode; MHV functionality from which this is invoked. Used to screen selectable Actions.
 ; DGMSACT - Array containing appropriate MHV actions, after screening based on mode (DGMHVMOD).
 N ACTIEN,ACTCNT,ACTTXT,SELCNT,DGMHVSAT S ACTCNT=0,SELCNT=0
 S ACTIEN=0 F  S ACTIEN=$O(^DGMHV(390.02,ACTIEN)) Q:'ACTIEN  S ACTTXT=$P($G(^DGMHV(390.02,ACTIEN,3,1,0)),"^") I ACTTXT]"" D
 .N TXTND S TXTND=1 F  S TXTND=$O(^DGMHV(390.02,ACTIEN,3,TXTND)) Q:'TXTND  S ACTTXT=ACTTXT_" "_^DGMHV(390.02,ACTIEN,3,TXTND,0)
 .N ACTLLIST D ACTSCRN^DGMHVUTL(ACTIEN,.ACTLLIST) I ($G(DGMHVMOD)]"") Q:'$D(ACTLLIST(DGMHVMOD))
 .S ACTCNT=ACTCNT+1,SELCNT=SELCNT+1,DGMSACT(ACTCNT)=ACTTXT,DGMSACT(ACTCNT,"IEN")=ACTIEN
 .N MARX,ACTLINE D TXT(ACTTXT,65) S ACTLINE=0 F  S ACTLINE=$O(MARX(ACTLINE)) Q:'ACTLINE  D
 ..N DGDASH S DGDASH=$S(ACTLINE=1&(ACTCNT<10):ACTCNT_" -  ",(ACTLINE=1&(ACTCNT>9)):ACTCNT_" - ",1:"     ")
 ..S DIR("A",SELCNT)="  "_DGDASH_" "_MARX(ACTLINE) S SELCNT=SELCNT+1
  S DIR("A",SELCNT+1)=" "
 S DIR("A")=" Select an action or '^' to exit: "
 Q
DELETE(DGACTD) ; Delete one previously selected action
 ; Input : DGACTD - Array of MHV actions selected by clerk.
 K DGDELDIR,DIR N DGDELAR,II,DGCNT,ZZ S DGCNT=0
 M DGDELAR=DGACTD
 ;
 K DGACTD M DGACTD=DGDELAR
 S DIR(0)="SAO^" S ZZ=0 F II=1:1 S ZZ=$O(DGDELAR(ZZ)) Q:'ZZ  S DIR(0)=DIR(0)_ZZ_":"_DGDELAR(ZZ)_";"
 S DIR("A")="Select an action to delete: " D ^DIR I $G(Y)>0,$D(DGACTD(+Y)) K DGACTD(Y)
 W ! D CONT I '$D(DGACTD) S DGSTAY=0 D CLEAR
 Q
REVERSE(PAD,DGREVTXT) ; Display DGREVTXT in reverse video
 N X,Y,IORVON,IORVOFF,DIR,DIRUT
 S X="IORVON;IORVOFF" S PAD=+$G(PAD)
 D ENDR^%ZISS
 W $CHAR(7) W ?PAD W:$D(IORVON) IORVON W DGREVTXT W:$D(IORVOFF) IORVOFF
 Q
TXT(TXT,LEN) ; Split string into multiple LEN length lines
 ;* Input: TXT = TXT string
 ;*        LEN = format length
 ;* Output: MARX array.
 N OLD,X1,Y D SPLIT K MARX
 S X=0,X1=1,Y="" F  S X=$O(OLD(X)) Q:'X  D
 . I $L(Y_OLD(X))>LEN S MARX(X1)=Y,X1=X1+1,Y="" D
 .. I $E(MARX(X1-1),$L(MARX(X1-1)))'=" " Q
 .. S MARX(X1-1)=$E(MARX(X1-1),1,$L(MARX(X1-1))-1)
 . S Y=Y_OLD(X)
 S:Y]"" MARX(X1)=Y
 S MARX=X1
 Q
SPLIT ; * Split a word string into individual words.
 ;* Input: TXT  - Line of text
 ;* Input: LEN  - Maximum length one line of text will be limited to
 ;* Output: OLD(X)
 N BSD,NEWSTR,X,X1,Y
 S OLD(1)=TXT Q:$L(TXT)<LEN
 F BSD=" ","/","-" S:'$O(OLD(0)) OLD(1)=TXT D:TXT[BSD DELIM(BSD)
 I '$O(OLD(1)),($L(TXT)>LEN) D LEN(1,TXT) K OLD D
 . F X=0:0 S X=$O(NEWSTR(X)) Q:'X  S OLD(X)=NEWSTR(X)
 Q
LEN(X1,OLD) ;* Wrap word to next line if it doesn't fit the display length
 N X
 Q:$L(OLD)'>LEN
 S X=$E(OLD,1,($L(OLD)-1)) I X["/"!(X["-") Q
 I $L(OLD)>LEN F X=1:1 S NEWSTR(X1)=$E(OLD,((LEN*X)-LEN+1),(LEN*X)),X1=X1+1 Q:($L(OLD)'>(LEN*X))
 Q
DELIM(BSD) ; Split a string into individual words
 ; Input:  BSD - Characters considered delimiters between words (i.e., for identifying/splitting-up-and/or-separating words)
 ; Input:  OLD(n) - Text array containing  
 ; Output: OLD(n) - Array containing pdated 
 K NEWSTR
 S X=0,X1=0 F  S X=$O(OLD(X)) Q:'X  F Y=1:1:$L(OLD(X),BSD) D
 . S X1=X1+1
 . S NEWSTR(X1)=$P(OLD(X),BSD,Y)
 . I $L(OLD(X),BSD)>1,(Y<$L(OLD(X),BSD)) S NEWSTR(X1)=NEWSTR(X1)_BSD
 . D LEN(.X1,NEWSTR(X1))
 K OLD F X=0:0 S X=$O(NEWSTR(X)) Q:'X  S OLD(X)=NEWSTR(X)
 Q
CLEAR ; Clear the display
 D CLEAR^VALM1
 D FULL^VALM1
 S VALMBCK="R"
 Q
CONT ; Prompt to Continue
 N DIR S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR
 Q
ACTRNSFM ; Transform action prompt input
 Q
DSPLACT(DFN) ; Display all MHV actions associated with last 5 date/time stamps. If last action is one of the 
 ;             MHV Socialization actions, ask additional question about whether the patient was successfully enrolled/registered
 N TMPDT,LASTDT,DGACTDT,NXT1,NXT2,I,J,DGLACTS,DIC,DA,DGFLDAR S DGLACTS=""
 D GETLACT^DGMHVUTL(DFN,.DGLACTS)
 W !,"         Recent My HealtheVet actions taken by VistA Clerks "
 W !,"--------------------------------------------------------------------"
 D GETFLDS^DGMHVUTL(DFN,.DGFLDAR) I $O(DGFLDAR(0)) M DGLACTS=DGFLDAR
 I '$O(DGLACTS(0)) W !?8," - NONE - ",!! Q
 S LASTDT="" F  S LASTDT=$O(DGLACTS(LASTDT)) Q:'LASTDT  D
 .S DGACTDT=$$FMTE^XLFDT($P(LASTDT,"."),2) I ($L(DGACTDT)<8) D
 ..N NEWDT,IDT,DTPC F IDT=1:1:$L(DGACTDT,"/") D
 ...S DTPC=$P(DGACTDT,"/",IDT),DTPC=$TR($J(DTPC,2)," ",0),NEWDT=$G(NEWDT)_$S(IDT=1:"",1:"/")_DTPC
 ..I NEWDT?2N1"/"2N1"/"2N S DGACTDT=NEWDT
 .S NXT1=0 F I=1:1 S NXT1=$O(DGLACTS(LASTDT,NXT1)) Q:'NXT1  D
 ..S NXT2="" F J=1:1 S NXT2=$O(DGLACTS(LASTDT,NXT1,"TXT",NXT2)) Q:'NXT2  W ! D
 ...N DGSP S DGSP=$S($L($G(DGLACTS(LASTDT,NXT1,"IEN")))>1:" ",1:" ")
 ...W $S($G(TMPDT)'=LASTDT:DGACTDT,1:"       ") W $S((J=1):DGSP_" ",1:"   "),$G(DGLACTS(LASTDT,NXT1,"TXT",NXT2))
 ...S TMPDT=LASTDT
 D QUESUC^DGMHVUTL(DFN,.DGMHVOUT) Q:($G(DGMHVOUT)]"")
 Q
ACTHLP ; Help at action prompt
 W !?5,"Please select one of the listed actions that most closely describes"
 W !?5,"the actions taken today to help this patient register in My HealtheVet."
 Q
