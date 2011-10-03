ALPBIND ;OIFO-DALLAS/SED/KC/MW  BCMA-BCBU INPT TO HL7 INIT ;5/2/2002
 ;;3.0;BAR CODE MED ADMIN;**8**;Mar 2004
 ;
 ; Reference/IA
 ; DPT/10035
 ; DIC(42/10039
 ; DIC(42/2440
 ; EN^PSJBCBU/3876
 Q
OPT ;Entry point for the option
 ;Select Workstations assigned to Default.
DFT K ALPHLL,DIR,ALPDIV,DTOUT,DUOUT,DIRUT,DIROUT
 D GET^ALPBPARM(.ALPHLL,"")
 I '$D(ALPHLL) W !,"No workstations defined for default " G EXIT
 D ALLWKS
 ;D:'$D(DIRUT) QUE
 D QUE
 G EXIT
 ;
ALLWKS ;If no then set allow the user to select the workstation
 K DTOUT,DUOUT,DIRUT,DIROUT,DIR
 S DIR(0)="Y",DIR("B")="YES"
 S DIR("A")="Enter Yes or No"
 S DIR("A",1)="Include all workstations"
 D ^DIR
 I $D(DIRUT) Q
 S ALPWKS=+Y
 I +ALPWKS>0 Q
 ;
WRKSTN ;Now select which workstations to be initialized
 K ALPSCRN,ALPBANS
 ;Set up screen
 S ALP=0 F  S ALP=$O(ALPHLL("LINKS",ALP))  Q:+ALP'>0  D
 . S ALPSCRN($P(ALPHLL("LINKS",ALP),U,2),ALP)=ALPHLL("LINKS",ALP)
 K ALPHLL
 F  D LP Q:$D(DIRUT)
 ;I $D(DIRUT)&($D(ALPHLL)) W !!,"No Selected Workstations" G ALLWKS
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
 S ZTRTN="EN^ALPBIND"
 S ZTDESC="PSB - Initialize Default Contingency Workstation"
 S ZTIO="",ZTSAVE("ALPWKS")=""
 I $D(ALPHLL) S ZTSAVE("ALPHLL(")=""
 D ^%ZTLOAD
 W:$D(ZTSK) !,ZTSK
 K ZTIO,ZTDESC,ZTRTN,ZTSK
 Q
EN ;Loop through the inpatient list.
 Q:'$D(ALPHLL)
 S ALPDTS=$$FMTE^XLFDT($$NOW^XLFDT)
 K ALPSCR
 S ALPSTOP=0,ALPOK=1
 S ALPCN=""
 F  S ALPCN=$O(^DPT("CN",ALPCN)) Q:ALPCN=""!(ALPSTOP)  D
 . ;DIVISION SCREEN HERE
 . S ALPCNI=$O(^DIC(42,"B",ALPCN,0))
 . Q:+ALPCNI'>0  ;Quit if I can't decifer the Ward Location
 . S ALPDIV=$P($G(^DIC(42,ALPCNI,0)),U,11)
 . ;Check to see is the Division has Machines defined to it.
 . ;if it does then it is not to go to default
 . K ALPTEST
 . D GET^ALPBPARM(.ALPTEST,ALPDIV,1)
 . Q:$D(ALPTEST)
 . S ALPSTOP=$$S^%ZTLOAD()
 . S ALDFN=0
 . F  S ALDFN=$O(^DPT("CN",ALPCN,ALDFN)) Q:+ALDFN'>0!(ALPSTOP)  D PAT
 K XQA,XQAMSG
 S ALPDTE=$$FMTE^XLFDT($$NOW^XLFDT)
 S XQA(DUZ)=""
 S XQAMSG="BCBU WORKSTATION INIT Started "_ALPDTS_" and finished "_ALPDTE_". "
 ;_ALPBK_" entries sent."
 D SETUP^XQALERT
EXIT ;
 K ALPDTS,ALPDTE,ALPCNT
 K ALPB,ALPBI,ALPBJ,ALPCN,ALDFN,ALPMDT,ALPML,ALPORDR,MSCTR,MSH,ORC
 K PID,PV1,ALPHLL,ALPALL,DIR,Y,DTOUT,DUOUT,DIRUT,DIROUT,ALPDIV
 K ALPTST,ALPSTOP,ALPOK,ZTSAVE,ALPCNI,ALPCNT,ALP,ALPDVN,ALPSLT,ALPWKS
 K PID,PV1,^TMP("PSJ",$J),^TMP("PSJBU",$J)
 ;
 Q
MLOG ;Need to loop though the Med log file to get all med logs
 ;associated with the order
 Q:'$D(^PSB(53.79,"AORDX",ALDFN,ALPORDR))
 S X=+$$GET^XPAR("PKG.BAR CODE MED ADMIN","PSB BKUP MEDLG",1,"Q")
 S X=$S(X>0:"T-"_X,1:"T-30")
 D ^%DT
 Q:+Y'>0  ;Cannot get a valid date
 S ALPMDT=Y
 F  S ALPMDT=$O(^PSB(53.79,"AORDX",ALDFN,ALPORDR,ALPMDT)) Q:+ALPMDT'>0  D
 . S ALPML=0
 . F  S ALPML=$O(^PSB(53.79,"AORDX",ALDFN,ALPORDR,ALPMDT,ALPML)) Q:+ALPML'>0  D
 . . Q:+$P($G(^PSB(53.79,ALPML,0)),U,1)'>0  ; Bad Med-log
 . . ;W !,ALPML
 . . S ALPRSLT=$$MEDL^ALPBINP(ALPML)
 Q
MESS ;BUILD AND SEND MESSAGE
 K ALPB
 D EN^PSJBCBU(ALDFN,ALPORDR,.ALPB)
 S ALPBI=0
 F  S ALPBI=$O(ALPB(ALPBI)) Q:ALPBI'>0  D
 . I $E(ALPB(ALPBI),1,3)="MSH" S MSH=ALPBI
 . I $E(ALPB(ALPBI),1,3)="PID" S PID=ALPBI
 . I $E(ALPB(ALPBI),1,3)="PV1" S PV1=ALPBI
 . I $E(ALPB(ALPBI),1,3)="ORC" S ORC=ALPBI
 I +MSH'>0 Q   ;MISSING MSH SEGMENT BAD MESSAGE
 S MSCTR=$E(ALPB(MSH),4,8),ALPORD=ALPORDR
 S X=$$INI^ALPBINP()
 Q
SNDPT ;Send a Single Patient
 K DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="PO^2:EM",DIR("A")="Select Patient "
 D ^DIR
 Q:$D(DIRUT)
 Q:+Y'>0
 ;S ALDFN=10748
 S ALDFN=+Y
 W !!,"Please Hold On While I send the orders",!!
 ;
PAT ;
 K ^TMP("PSJBU",$J)
 S X=+$$GET^XPAR("PKG.BAR CODE MED ADMIN","PSB BKUP IPH",1,"Q")
 S X=$S(X>0:"T-"_X,1:"T-15")
 D ^%DT
 Q:+Y'>0  ;Cannot get a valid date
 D EN2^PSJBCBU(ALDFN,Y)
 Q:'$D(^TMP("PSJBU",$J))  ; NO DATA
 S ALPBJ=0
 F  S ALPBJ=$O(^TMP("PSJBU",$J,ALPBJ)) Q:+ALPBJ'>0  D
 . Q:'$D(^TMP("PSJBU",$J,ALPBJ,0))
 . S ALPORDR=$P(^TMP("PSJBU",$J,ALPBJ,0),U,3)
 . Q:+ALPORDR'>0
 . D MESS
 . Q:ALPORDR["P"  ;If not pending do Med-Log
 . D MLOG
 S ALPSTOP=$$S^%ZTLOAD()
 Q
