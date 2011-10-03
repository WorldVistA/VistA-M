ALPBIN ;OIFO-DALLAS/SED/KC/MW  BCMA-BCBU INPT TO HL7 INIT ;5/2/2002
 ;;3.0;BAR CODE MED ADMIN;**8**;Mar 2004
 ;
 ; Reference/IA
 ; DPT/10035
 ; DIC(42/10039
 ; DIC(42/2440
 Q
OPT ;Entry point for the option
 ;Select all or by Division
ALL ;Ask if the user want to send to all divisions
 K DTOUT,DUOUT,DIRUT,DIROUT,DIR,ALPALL,ALPWKS,ALPDIV,ALPBDVN
 S DIR(0)="Y",DIR("B")="YES"
 S DIR("A")="Enter Yes or No"
 S DIR("A",1)="Include all Divisions"
 D ^DIR
 I $D(DIRUT) G EXIT
 S ALPALL=+Y
 ;I +ALPALL>0 D QUE
 I ALPALL'>0 D DIV
 ;I +ALPALL'>0!(+ALPWKS>0) D QUE
 D QUE
 ;
EXIT ;
 K ALPB,ALPBI,ALPBJ,ALPCN,ALDFN,ALPMDT,ALPML,ALPORDR,MSCTR,MSH,ORC
 K PID,PV1,ALPHLL,ALPALL,DIR,Y,DTOUT,DUOUT,DIRUT,DIROUT,ALPDIV
 K ALPTST,ALPSTOP,ALPOK,ZTSAVE,ALPCNI,ALPCNT,ALP,ALPDVN
 Q
 ;
DIV K ALPHLL,DIR,ALPDIV,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="PO^40.8:EMZ"
 S DIR("A",1)="Enter the division that you would like to"
 S DIR("A",2)="initialize"
 D ^DIR
 I $D(DIRUT)!(+Y'>0) S ALPDIV="" Q
 S ALPDIV=$P(Y,U,1),ALPDVN=$P(Y,U,2)
 D GET^ALPBPARM(.ALPHLL,ALPDIV)
 I '$D(ALPHLL) W !,"No workstations defined with "_ALPDVN G DIV
ALLWKS ;If no then set allow the user to select the workstation
 K DTOUT,DUOUT,DIRUT,DIROUT,DIR
 S DIR(0)="Y",DIR("B")="YES"
 S DIR("A")="Enter Yes or No"
 S DIR("A",1)="Include all workstations for the "_ALPDVN_" Division"
 D ^DIR
 I $D(DIRUT) G DIV
 S ALPWKS=+Y
 I +ALPWKS>0 Q
 ;
WRKSTN ;Now select which workstations for the division to be initialized
 K ALPSCRN,ALPBANS
 ;Set up screen
 S ALP=0 F  S ALP=$O(ALPHLL("LINKS",ALP))  Q:+ALP'>0  D
 . S ALPSCRN($P(ALPHLL("LINKS",ALP),U,2),ALP)=ALPHLL("LINKS",ALP)
 K ALPHLL
 F  D LP Q:$D(DIRUT)
 ;I  $D(DIRUT)!$D(ALPHLL) W !!,"No Selected Workstations" G ALLWKS
 I '$D(ALPBANS)!$D(ALPHLL) W !!,"No Selected Workstations" G ALLWKS
 Q:'$D(ALPBANS)
 S ALP="",ALPCNT=1
 F  S ALP=$O(ALPBANS(ALP)) Q:ALP=""  D
 . S ALPHLL("LINKS",ALPCNT)=ALPSCRN(ALP,$O(ALPSCRN(ALP,0)))
 . S ALPCNT=ALPCNT+1
 K ALPSCRN,ALPBANS
 Q
 ;
LP ;Multiple entries
 K DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="PO^870:EMZ",DIR("A")="Select WorkStation Link "
 S DIR("?")="Answer with WorkStation Link to update "
 S DIR("S")="I $D(ALPSCRN($P(^HLCS(870,+Y,0),U,1)))"
 D ^DIR
 Q:$D(DIRUT)
 S ALPBANS($P(Y,U,2),+Y)=""
 W #,!!,"Selected Workstations",!!
 S ALPB=""
 F ALP=1:1 S ALPB=$O(ALPBANS(ALPB)) Q:ALPB=""  D
 .W ?$S(ALP#2:1,1:40),ALPB
 .W:ALP#2'>0 !
 Q
 ;
QUE ;Que the job
 ;W !,"QUE"
 S ZTRTN="EN^ALPBIN"
 S ZTDESC="PSB - Initialize the Contingency Workstation"
 S ZTIO="",ZTSAVE("ALPWKS")="",ZTSAVE("ALPDIV")=""
 I $D(ALPHLL) S ZTSAVE("ALPHLL(")=""
 D ^%ZTLOAD
 W:$D(ZTSK) !,ZTSK
 K ZTIO,ZTDESC,ZTRTN,ZTSK
 Q
EN ;Loop through the inpatient list.
 S ALPDTS=$$FMTE^XLFDT($$NOW^XLFDT)
 I +$G(ALPDIV)'>0 S ALPDIV=0
 S ALPSTOP=0,ALPOK=1
 S ALPCN=""
 F  S ALPCN=$O(^DPT("CN",ALPCN)) Q:ALPCN=""!(ALPSTOP)  D
 . ;DIVISION SCREEN HERE
 . S ALPCNI=$O(^DIC(42,"B",ALPCN,0))
 . Q:+ALPCNI'>0  ;Quit if I can't decifer the Ward Location
 . S ALPTST=$P($G(^DIC(42,ALPCNI,0)),U,11)
 . I +ALPDIV&(ALPDIV'=ALPTST) Q
 . S ALPSTOP=$$S^%ZTLOAD()
 . Q:ALPSTOP
 . S ALDFN=0
 . F  S ALDFN=$O(^DPT("CN",ALPCN,ALDFN)) Q:+ALDFN'>0!(ALPSTOP)  D PAT^ALPBIND
 ;
 K XQA,XQAMSG
 S ALPDTE=$$FMTE^XLFDT($$NOW^XLFDT)
 S XQA(DUZ)=""
 S XQAMSG="BCBU WORKSTATION INIT Started "_ALPDTS_" and finished "_ALPDTE_". "
 ;_ALPBK_" entries sent."
 D SETUP^XQALERT
 K ALPDTS,ALPDTE,ALPCNT
 D EXIT
 Q
