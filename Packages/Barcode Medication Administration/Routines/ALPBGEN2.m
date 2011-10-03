ALPBGEN2 ;SFVAMC/JC - Init New Person Data on Workstations ;05/12/2003  07:40
 ;;3.0;BAR CODE MED ADMIN;**8**;Mar 2004
 ;
 ; Reference/IA
 ; DEQUE^XUSERP/4511
 ; 
INIT ;Initial Load
 N DIR,DTOUT,DUOUT,X,Y,ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK
 ;Populate workstations with Vista New Person data
 W !,"This option searches for users that hold the option, 'PSB GUI CONTEXT - USER'"
 W !,"and if they are active users, transmits the information to your BCMA Backup Workstations."
 W !,"NOTE that you must have completed the step of assigning workstations to either a"
 W !,"single default group or by division."
 W !!,"Do you wish to continue?" S DIR(0)="YA",DIR("B")="YES" D ^DIR
 Q:Y<1!($D(DTOUT))!($D(DUOUT))
 W !!,"Do you wish to queue this init?" S DIR(0)="YA",DIR("B")="YES" D ^DIR
 Q:($D(DTOUT))!($D(DUOUT))
 I Y D  Q
 . S ZTRTN="Q^ALPBGEN2",ZTDESC="BCBU New Person Init",ZTSAVE("*")="",ZTIO=""
 . D ^%ZTLOAD I $D(ZTSK) W !,"TASK #: ",ZTSK
Q ;
 N ALPBI,ALPBJ,ALPBK
 S DTS=$$FMTE^XLFDT($$NOW^XLFDT)
 S (ALPBK)=0,ALPBJ="" F  S ALPBJ=$O(^VA(200,ALPBJ)) Q:ALPBJ=""  D
 . Q:+ALPBJ<1
 . I $$ISBCMA(ALPBJ)>0 D
 . . I '$D(ZTSK) W !,ALPBJ_" "_$P(^VA(200,ALPBJ,0),U)
 . . D DEQUE^XUSERP(ALPBJ,1)
 . . K HLA,HL
 . . S ALPBK=$G(ALPBK)+1
 K XQA,XQAMSG
 S DTE=$$FMTE^XLFDT($$NOW^XLFDT)
 S XQA(DUZ)=""
 S XQAMSG="BCBU INIT Start:"_DTS_" Finish:"_DTE_". "_ALPBK_" users sent."
 D SETUP^XQALERT
 K DTS,DTE,ALPBK
 Q
ISBCMA(USER) ;Does this person have BCMA access?
 ;Returns 0 if no such user
 ;user terminated or no access code
 ;no option in file
 ;no access due to locks
 ;Returns 1 if user has the PSB GUI CONTEXT - USER option
 N OPT
 S DIC="^DIC(19,",DIC(0)="MX",X="PSB GUI CONTEXT - USER"
 D ^DIC K DIC,DA,DR
 I +Y<1 Q 0
 S OPT=+Y
 Q $$ACCESS^XQCHK(USER,OPT)
