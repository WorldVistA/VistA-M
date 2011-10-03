RMPREOS ;HINES-CIOFO/HNC -Suspense Processing ; 2/25/04 10:26am
 ;;3.0;PROSTHETICS;**45,50,52,55,57,62,80,85,97,135**;Feb 09, 1996;Build 12
 ;
 ;  HNC - patch 52 - 9/22/00 Modify EN2 not to check for RMPRFLAG
 ;                           RMPRCLOS, or FLAG.
 ;
 ;  HNC - patch 55 - 3/12/01 allow other note without initial
 ;
 ;  HNC - patch 57 - 5/8/01  close out note message
 ;
 ;  RVD - patch 62 - 8/13/01 link suspense to 2319 records.
 ;
 ;  HNC - patch 80 - 8/28/03 Type to allow Editing, CLOSE SUSPENSE NOT 
 ;                           CLOSED Screen Service for Consult Tracking 
 ;                           (per Jerry)
 ;
 ;  TH  - patch 85 - 2/20/04 Fix bug-overwrite Initial Action Date, 
 ;                           Note, and DUZ problem.
 ;
 ;  KAM - patch 85 - 3/16/04 Allow forwarding of a consult to a "Tracker
 ;                           Only" service
 ;  KAM - patch 97 - 8/19/04 Stop canceling the original consult when
 ;                           canceling the clone (in file 123)
 ;  
 ;Patch 80 -Read File 123.5 DBIA 3861
 ;
EN ;Add Manual Suspense
 ;
 D NOW^%DTC S X=%
 S DIC="^RMPR(668,",DIC(0)="AEQLM",DLAYGO=668
 S DIC("DR")="1////^S X=RMPRDFN;22R;14////^S X=""O"";8////^S X=DUZ;9////^S X=5;3////^S X=9;2////^S X=RMPR(""STA"")"
 K DINUM,D0,DD,DO D FILE^DICN K DLAYGO G:Y'>0 EX S (RDA,DA)=+Y
 S DIE="^RMPR(668,",DR="13;4"
 L +^RMPR(668,RDA,0):1 I $T=0 W $C(7),?5,!,"Someone else is editing this record" G EX
 D ^DIE L -^RMPR(668,RDA,0)
 I '$P(^RMPR(668,RDA,0),U,3) S DA=RDA,DIK="^RMPR(668," D ^DIK W !,$C(7),?5,"Deleted..."
EX K X,DIC,DIE,DR,Y
 Q
 ;
EN2 ;edit MANUAL suspense record
 ;DA must be defined
 ;
 I $P(^RMPR(668,DA,0),U,8)'>4 W !!!,"Can Not Edit This Suspense Record!",!! H 2 Q
PROC L +^RMPR(668,DA):1 I $T=0 W !,?5,$C(7),"Someone else is Editing this entry!" Q
 S RO=$G(^RMPR(668,DA,0)),Y=$P(^(0),U,1) X ^DD("DD")
 W "   ",Y,"  ",$E($P(^DPT($P(RO,U,2),0),U,1),1,20)
 ;
 S RZ="S RX=$P(RO,U,3),RR=$S(RX=1:""PSC"",RX=2:""2421"",RX=3:""2237"",RX=4:""2529-3"",RX=5:""2529-7"",RX=6:""2474"",RX=7:""2431"",RX=8:""2914"",RX=9:""OTHER"",RX=10:""2520"",RX=11:""STOCK ISSUE"",1:""NONE"")"
 X RZ
 W "  ",RR,"  ",$S($P(RO,U,5)?7N.N:"CLOSED",1:"OPEN")
 S DIE="^RMPR(668,"
 ;Q:$D(RMPRFLAG)!$D(RMPRCLOS)!$D(FLAG)
 S DR="2R;22R;3;13;4"
 D ^DIE
 L -^RMPR(668,DA)
 Q
ENIA ;initial action note
 ;
 I $D(^RMPR(668,DA,3)) W !!!,"Initial Action Note Already Posted!",!! H 2 Q
 L +^RMPR(668,DA):1 I $T=0 W !,?5,$C(7),"Someone else is Editing this entry!" Q
 D NOW^%DTC S RMPREODT=%
 ;link suspense to 2319 record, patch #62
 I $D(^TMP($J,"RMPRPCE",660)) S ^TMP($J,"RMPRPCE",668,DA)="" D SEL60^RMPRPCEL
 S DIE="^RMPR(668,"
 S DR="7"
 D ^DIE
 I $D(^RMPR(668,DA,3)) S DR="10////^S X=RMPREODT;16////^S X=DUZ;14///^S X=""P""" D ^DIE
 L -^RMPR(668,DA)
 ;check for a note here
 I '$D(^RMPR(668,DA,3)) Q
 ;consult ien
 S GMRCO=$P(^RMPR(668,DA,0),U,15) Q:GMRCO=""
 ;note in array
 S RMPRCMT=0,GMRCMT=1
 F  S RMPRCMT=$O(^RMPR(668,DA,3,RMPRCMT)) Q:RMPRCMT=""  D
 .S GMRCMT(RMPRCMT)=^RMPR(668,DA,3,RMPRCMT,0)
 I $G(GMRCMT(1))="" S GMRCMT(1)="nothing noted"
 ;call api
 D CMT^GMRCGUIB(GMRCO,.GMRCMT,DUZ,RMPREODT,DUZ)
 K RMPREODT,GMRCO,RMGMRCO,GMRCMT,RMPRCMT
 Q
FORW ;forward consult
 I $P(^RMPR(668,DA,0),U,8)>4 W !!!,"Can Not Forward.",!! H 2 Q
 I $D(^RMPR(668,DA,4,1,0)) W !!!,"Completion Note Already Posted!",!! H 2 Q
 D NOW^%DTC S RMPREODT=%,GMRCAD=%
 ;lookup service to forward consult
 ;S DIC("S")="I '$P(^(0),U,2),'+$G(^GMR(123.5,+Y,""IFC""))" ;*85
 S DIC("S")="I $$SCR^RMPREOS(+Y,DUZ)"                       ;*85
 S DIC="^GMR(123.5,",DIC(0)="AEQ"
 S DIC("A")="Select Service To Forward Consult: "
 D ^DIC
 I (+Y'>0)!($D(DTOUT))!$D(DUOUT) W !!,"Not Forwarded! No Service Selected ." H 2 K DIC Q
 S GMRCSS=+Y
 L +^RMPR(668,DA):1 I $T=0 W !,?5,$C(7),"Someone else is Editing this entry!"
 S DIE="^RMPR(668,"
 ;stuff Consult forward service
 S DR="23////^S X=GMRCSS"
 D ^DIE
 Q:'$P($G(^RMPR(668,DA,8)),U,6)
 S DR="12"
 D ^DIE
 I $D(^RMPR(668,DA,4,1,0)) S DR="5////^S X=RMPREODT;6////^S X=DUZ;14///^S X=""C""" D ^DIE
 ;must have a note
 I '$D(^RMPR(668,DA,4,1,0)) W !!,"Must Have Note to Forward. Consult Not Forwarded." S $P(^RMPR(668,DA,8),U,6)="" H 2 Q
 ;
 ; set initial action note if null
 ;I '$P(^RMPR(668,DA,0),U,10) D
 ;
 ; Check if Initial Action Date is null
 I $P(^RMPR(668,DA,0),U,9)="" D
 .S DIE="^RMPR(668,"
 .; Set Initial Action Note
 .S DR="7///^S X=""See Completion Note, this was forwarded to another service."""
 .D ^DIE
 .; Set Initial Action Date and Initial Action By 
 .;S DR="10////^S X=RMPREODT;16////^S X=DUZ;24////^S X=DUZ" D ^DIE
 .S DR="10////^S X=RMPREODT;16////^S X=DUZ" D ^DIE
 ;
 ; Set Forwarded By
 S DR="24////^S X=DUZ" D ^DIE
 ;
 L -^RMPR(668,DA)
 K RMPREODT
 S GMRCO=$P(^RMPR(668,DA,0),U,15)
 Q:GMRCO=""
 ;note in array
 S RMPRCOM=0
 F  S RMPRCOM=$O(^RMPR(668,DA,4,RMPRCOM)) Q:RMPRCOM=""  D
 .S GMRCOM(RMPRCOM)=^RMPR(668,DA,4,RMPRCOM,0)
 I $G(GMRCOM)="" S GMRCOM="not noted"
 S GMRCORNP=DUZ
 S GMRCURGI=""
 S GMRCATTN=""
 S BDC=$$FR^GMRCGUIA(.GMRCO,.GMRCSS,.GMRCORNP,.GMRCATTN,.GMRCURGI,.GMRCOM,.GMRCAD)
 I +BDC=1 W !!,"ERROR, DID NOT FORWARD!" H 2
 W !!,"Consult Forwarded." H 2
 K GMRCO,GMRCSS,GMRCORNP,GMRCATTN,GMRCURGI,GMRCOM,GMRCAD
 Q
CLNT ;post closed note
 ;
 I $P(^RMPR(668,DA,0),U,10)="C" W !!!,"Completion Note Already Posted!",!! H 2 Q
 L +^RMPR(668,DA):1 I $T=0 W !,?5,$C(7),"Someone else is Editing this entry!" Q
 D NOW^%DTC S RMPREODT=%,GMRCAD=%
 ;link suspense to 2319 record, patch #62
 I $D(^TMP($J,"RMPRPCE",660)) S ^TMP($J,"RMPRPCE",668,DA)="" D SEL60^RMPRPCEL
 S DIE="^RMPR(668,"
 S DR="12"
 D ^DIE
 I '$D(^RMPR(668,DA,4)) Q
 I $D(^RMPR(668,DA,4)) S DR="5////^S X=RMPREODT;6////^S X=DUZ;14///^S X=""C""" D ^DIE
 ;set initial action note if null
 I '$P(^RMPR(668,DA,0),U,9) D
 .S DIE="^RMPR(668,"
 .S DR="7///^S X=""See Completion Note for Initial Action Taken."""
 .D ^DIE
 .S DR="10////^S X=RMPREODT;16////^S X=DUZ" D ^DIE
 ;added by #62.  Once closed, update all 2319 record for initial and
 ;completion date
 D ICDT^RMPRPCEL(DA)
 ;
 L -^RMPR(668,DA)
 K RMPREODT
 S GMRCO=$P(^RMPR(668,DA,0),U,15)
 Q:GMRCO=""
 ;note in array
 S RMPRCOM=0
 F  S RMPRCOM=$O(^RMPR(668,DA,4,RMPRCOM)) Q:RMPRCOM=""  D
 .S GMRCOM(RMPRCOM)=^RMPR(668,DA,4,RMPRCOM,0)
 I $G(GMRCOM)="" S GMRCOM="not noted"
 S GMRCSF="U"
 S GMRCA=10
 S GMRCALF="N"
 S GMRCATO=""
 S (GMRCORNP,GMRCDUZ)=DUZ
 S BDC=$$SFILE^GMRCGUIB(.GMRCO,.GMRCA,.GMRCSF,.GMRCORNP,.GMRCDUZ,.GMRCOM,.GMRCALF,.GMRCATO,.GMRCAD)
 I +BDC=1 W !!,$P(BDC,U,2) H 2
 K GMRCO,GMRCA,GMRCSF,GMRCORNP,GMRCDUZ,GMRCOM,GMRCALF,GMRCATO,GMRCAD
 Q
OACT ;other notes - no initial needed 3/12/01
 ;stuff date/time in.01
 ;delete if no note
 ;I '$D(^RMPR(668,DA,3,1,0)) W !!!,"No Initial Action Taken... ",!! H 2 Q
 ;
 L +^RMPR(668,DA):1 I $T=0 W !,?5,$C(7),"Someone else is Editing this entry!" Q
 ;link suspense to 2319 record, patch #62
 I $D(^TMP($J,"RMPRPCE",660)) S ^TMP($J,"RMPRPCE",668,DA)="" D SEL60^RMPRPCEL
 S DA(1)=DA,RMPRDA1=DA
 S DIC="^RMPR(668,"_DA(1)_",1,"
 S DIC(0)="CQL"
 S DIC("P")=$P(^DD(668,11,0),U,2)
 D NOW^%DTC S X=%,GMRCWHN=%
 S DLAYGO=688
 D ^DIC
 I Y=-1 K DIC,DA Q
 S DIE=DIC K DIC
 S (DA,RMPRDA2)=+Y
 S DR="1" D ^DIE
 K DIE,DR,Y
 I '$D(^RMPR(668,RMPRDA1,1,RMPRDA2,1,0)) D  Q
 .;delete the record if no note
 .S DIK="^RMPR(668,RMPRDA1,1,"
 .S DA=RMPRDA2
 .D ^DIK
 .K DA,DIA,RMPRDA1,RMPRDA2,GMRCWHN
 ;send data to consults if note
 S GMRCO=$P(^RMPR(668,RMPRDA1,0),U,15)
 I GMRCO="" Q
 ;GMRCOM is comment array
 S RMPRCOM=0
 F  S RMPRCOM=$O(^RMPR(668,RMPRDA1,1,RMPRDA2,1,RMPRCOM)) Q:RMPRCOM=""  D
 .S GMRCOM(RMPRCOM)=^RMPR(668,RMPRDA1,1,RMPRDA2,1,RMPRCOM,0)
 ;
 L -^RMPR(668,RMPRDA1)
 ;GMRCWHN was set to date/time
 D CMT^GMRCGUIB(.GMRCO,.GMRCOM,"",.GMRCWHN,DUZ)
 ;check ok
 K DA,DIK,RMPRDA1,RMPRDA2,RMPRCOM,GMRCOM,GMRCO,GMRCWHN
 Q
CANCEL ;cancel suspense
 ;set status to X and cancelled by to duz, date/time.
 ;start
 ;
 I $P(^RMPR(668,DA,0),U,5)'="" W !!!,"This has already been completed, cannot cancel!",!! H 2  Q
 L +^RMPR(668,DA):1 I $T=0 W !,?5,$C(7),"Someone else is Editing this entry!" Q
 K Y
 S DIR(0)="Y",DIR("B")="N"
 W !!!,"This will CANCEL/DELETE this Suspense Request."
 S DIR("A")="Are you sure you want to CANCEL/DELETE this Suspense Request? (Y/N) "
 D ^DIR I $D(DTOUT)!$D(DUOUT)!(Y="^")!(Y=0) W !!,"Suspense Not Cancelled!" H 2  Q
 D NOW^%DTC S RMPREODT=%
 S DIE="^RMPR(668,"
 S DR="14///^S X=""X"";17////^S X=DUZ;18////^S X=RMPREODT;9"
 D ^DIE
 W !!,?5,"DELETED/CANCELLED!" H 2
 L -^RMPR(668,DA)
 ;consult ien
 S GMRCO=$P(^RMPR(668,DA,0),U,15) Q:GMRCO=""
 ;note in array
 S RMPRCMT=0
 F  S RMPRCMT=$O(^RMPR(668,DA,9,RMPRCMT)) Q:RMPRCMT=""  D
 .S GMRCMT(RMPRCMT)=^RMPR(668,DA,9,RMPRCMT,0)
 I $G(GMRCMT)="" S GMRCMT="nothing noted"
 ;call api
 ;DY for cancelled, deny
 S GMRCACTM="DY"
 ; PATCH RMPR*3*97 if canceling a clone do not update file 123 7=clone
 I $P(^RMPR(668,DA,0),U,8)'=7 D
 . S RMGMRCO=$$DC^GMRCGUIA(.GMRCO,DUZ,RMPREODT,.GMRCACTM,.GMRCMT)
 K RMPREODT,GMRCMT,RMPRCMT,GMRCACTM
 Q
 ;
LINK60 ;link suspense to 2319 records
 S RMSERR=0
 F RMSI=0:0 S RMSI=$O(^TMP($J,"RMPRPCE",660,RMSI)) Q:RMSI'>0  D
 .S RMSAMIS=$G(^TMP($J,"RMPRPCE",660,RMSI))
 .;call update 668
 .S RMSERR=$$UP68^RMPRPCE1(RMSI,DA,+RMSAMIS)
 Q:RMSERR=1
 S ^TMP($J,"RMPRPCE",668,DA)=""
 Q
 ;end
SCR(SERV,USR) ; SCREEN SERVICES THAT CAN BE FORWARDED TO ,RMPR*3*85
 N USAGE
 S USAGE=$P(^GMR(123.5,SERV,0),U,2)
 I USAGE=9!(USAGE=1) Q 0  ;disabled or grouper service
 I USAGE=2 Q $$VALIDU^GMRCAU(SERV,USR)  ;tracking and check update user
 Q 1  ;service usage must be null = O
