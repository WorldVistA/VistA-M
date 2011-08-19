RMPRS ;PHX/HNC/RFM,RVD-ADD SUSPENSE RECORD ;8/29/1994
 ;;3.0;PROSTHETICS;**26,28,30,45,52,62,120**;Feb 09, 1996
 ;
 ;  HNC - patch 52 - 9/22/00 Modify INQ - sub.
 ;                           Add KILL^XUSCLEAN on exit to kill
 ;                           all variables.
 ;  HNC - patch 52 - 10/5/00 New RMPR,RMPRNAM,RMPRDOB,RMPRSSN,RMPRSSNE
 ;                           RMPRCNUM before appt mgt
 ;  RVD - patch 62 - 10/13/01 remove link to Patient Management
 ;                            call rotine RMPREOL
 ;                            suspense print message
 ;
EN ;ADD SUSPENSE RECORD
 D DIV4^RMPRSIT G:$D(X) EXIT
 S DIC="^DPT(",DIC(0)="AEQM" D ^DIC G:Y'>0 EXIT S RMPRDFN=+Y
 S X=DT,DIC="^RMPR(668,",DIC(0)="AEQLM",DLAYGO=668,DIC("DR")="1////^S X=RMPRDFN;8////^S X=DUZ;2////^S X=RMPR(""STA"")" K DINUM,D0,DD,DO D FILE^DICN K DLAYGO G:Y'>0 EX S (RDA,DA)=+Y
 S DIE="^RMPR(668,",DR="3;4"
 L +^RMPR(668,RDA,0):1 I $T=0 W $C(7),?5,!,"Someone else is editing this record" G EX
 D ^DIE L -^RMPR(668,RDA,0)
 I '$P(^RMPR(668,RDA,0),U,3) S DA=RDA,DIK="^RMPR(668," D ^DIK W !,$C(7),?5,"Deleted..."
EX K X,DIC,DIE,DR,Y,RMPRDFN G EN
CL ;CLOSE OUT SUSPENSE RECORD
 D DIV4^RMPRSIT G:$D(X) EXIT
 K DIE,DR,Y,DA,RMPRA,^TMP("RMSU",$J)
 S RMPRCLOS=1 D DICDPT S (I,RMTOI)=0 G:Y<0!($D(DTOUT))!(Y="^") EXIT
 F  S I=$O(^RMPR(668,"C",+Y,I)) Q:I'>0  I $D(^RMPR(668,I,0)) S:'$P(^(0),U,5) ^TMP("RMSU",$J,9999999-$P($G(^RMPR(668,I,0)),"^",1),I)=I,RMTOI=RMTOI+1
 D ENT G:'IEN EXIT  L +^RMPR(668,IEN,0):1 I $T=0 W !,?5,$C(7),"Someone else is Editing this entry!" G EXIT
 S RMPRA=IEN,DR="2;4;7",DA=IEN,DIE=DIC D ^DIE G:$D(Y) EX1
 S DR="5//^S X=DT;6////^S X=DUZ",DA=RMPRA D ^DIE L -^RMPR(668,RMPRA,0)
EX1 I '$P(^RMPR(668,RMPRA,0),U,5) W !!,"SUSPENSE RECORD WAS NOT CLOSED OUT",$C(7) S $P(^(0),U,6)=""
 W ! G CL
EXIT W:$D(FL1) @IOF K %,RMPRCLOS,DIC,DIE,DR,CITN,IEN,Y,DA,RDA,FL1,RB,RD,RT,RIE,RO,RP,RR,RZ,RX,RMPRFLAG,^TMP("RMSU",$J),RMI,RMIEN,RML,RMTOI,I,J,RMDES,RMQUIT,RMSEL Q
EN2 ;EDIT SUSPENSE RECORD
 D DIV4^RMPRSIT G:$D(X) EXIT
 D DICDPT G:Y<0!($D(DTOUT))!(Y="^") EXIT
 ;
 ;
REV ;reverse look-up.--HNC--change to $O(^RMPR(668,"C",ien,n),-1)
ENT ;sort/display
 S (RMI,RML,RMTOI,RMQUIT,IEN,RMSEL,OUT)=0
 W !,"CHOOSE FROM:"
 S RMPRJ=""
 F  S RMPRJ=$O(^RMPR(668,"C",RMPRDFN,RMPRJ),-1) Q:RMPRJ=""  Q:OUT=1  Q:IEN>0  D
 .S RMTOI=RMTOI+1
 .S RMI=RMI+1
 .;S RML=RML+1
 .S ^TMP("RMSU",$J,RMI)=RMPRDFN_U_RMPRJ
 .I $Y>20 D DIS W @IOF Q
 .D WRI
 .Q:(RMQUIT)!(IEN)!(RMSEL)
 G:RMSEL ENT
 G:IEN PROC
 I 'RMI W !!,"***** PATIENT HAS NO SUSPENSE RECORD!!!!" Q
 ;I RMQUIT W !!,"***** NO SELECTION MADE!!!" Q
 D DIS
 ;W !!,"[<return> or '^' to Quit] or Choose Number 1-",RMI W ": " R X:DTIME I '$T Q
 ;I X=""!(X="^")!('$D(X)) W !!,"***** NO SELECTION MADE!!!" Q
 ;I '$D(^TMP("RMSU",$J,+X)) W !,$C(7),"****INVALID RESPONSE, Please choose a NUMBER within the range!!!!" G ENT
 ;S IEN=$P(^TMP("RMSU",$J,+X),U,2)
 Q
 ;
PROC ;
 L +^RMPR(668,IEN,0):1 I $T=0 W !,?5,$C(7),"Someone else is Editing this entry!" Q
 ;
 S Y=""
 S RO=$G(^RMPR(668,+IEN,0)),Y=$P(^(0),U,1)
 W "   ",$$DAT1^RMPRUTL1(Y)
 S DFN=RMPRDFN D DEM^VADPT
 W "  ",VADM(1)
 W "  ",$$STATUS^RMPREOU(+IEN)
 S Y=+IEN
 S DIC="^RMPR(668,"
 Q:$D(RMPRFLAG)!$D(RMPRCLOS)!$D(FLAG)
 S DIE=DIC,DA=Y,DR=".01;2R;1R;3;5;I $P(^RMPR(668,DA,0),U,5),'$P(^(0),U,6) S $P(^(0),U,6)=DUZ;4;7" D ^DIE I $D(DA),$P(^RMPR(668,DA,0),U,5)="" S $P(^(0),U,6)=""
 L -^RMPR(668,IEN,0) G EN2
 ;
INQ ;Inquire to Suspense entry point
 ;
 W @IOF
 D DIV4^RMPRSIT G:$D(X) EXIT
 D HOME^%ZIS
 S RMPRFLAG=1
 ;get patient dfn
 D DICDPT I Y'>0!($D(DTOUT))!(Y="^") K RMPRDFN G EXIT
 S RMPRDFN=+Y
 D REV I 'IEN K RMPRDFN G EXIT
 ;call new suspense processing
 N RMPREOY,DA
 S (RMPREOY,DA)=IEN D VIEWCP^RMPREO23
 ;clean up - patch 52
 D KILL^XUSCLEAN
 Q
 ;
EXT S RO=0 F  S RO=$O(^RMPR(668,IEN,2,RO)) Q:RO'>0  W !,^RMPR(668,IEN,2,RO,0)
 Q
 ;
ACT W !!,"ACTION TAKEN: "
 I $D(^RMPR(668,IEN,3,0)) S RO=0 F  S RO=$O(^RMPR(668,IEN,3,RO)) Q:RO'>0  W !,^RMPR(668,IEN,3,RO,0)
 E  W "NONE RECORDED"
 W ! Q
LINK ;CLOSE OUT SUSPENSE ENTRY FOR SELECTED PATIENT
 ;call routine RMPREOL if PCE link to suspense, patch #62.
SUSP I $D(^TMP($J,"RMPRPCE",660)) D EN^RMPREOL,FULL^VALM1 Q
 I '$D(^TMP($J,"RMPRPCE",660)) D EN^RMPREO
 D FULL^VALM1
 Q
 ;add new module HNC 3-2-00
 N Y,RO,RR,RT,RX,RZ,J,RB,RIE,RD,RI,FLAG K ^TMP("RMSU",$J)
 Q:'$D(RMPRDFN)  Q:'$D(^RMPR(668,"C",RMPRDFN))
 S RZ="S RX=$P(RO,U,3),RR=$S(RX=1:""PSC"",RX=2:""2421"",RX=3:""2237"",RX=4:""2529-3"",RX=5:""2529-7"",RX=6:""2474"",RX=7:""2431"",RX=8:""2914"",RX=9:""OTHER"",RX=10:""2520"",RX=11:""STOCK ISSUE"",1:""NONE"")"
 S (RD,RI)=0 F  S RD=$O(^RMPR(668,"C",RMPRDFN,RD)) Q:RD'>0  I $P(^RMPR(668,RD,0),U,5)="" S FLAG=1
 Q:'$D(FLAG)
 S %=1 W $C(7),!,"Suspense Records exist on this Patient.  Do you wish to View/Edit them" D YN^DICN G:%=-1!(%=2)!($D(DTOUT)) EXIT I %=0 W !,"Answer `YES` or `NO`" G LINK
 S Y=RMPRDFN,(I,RMTOI)=0 F  S I=$O(^RMPR(668,"C",+Y,I)) Q:I'>0  I $D(^RMPR(668,I,0)) S:'$P(^(0),U,5) ^TMP("RMSU",$J,9999999-$P($G(^RMPR(668,I,0)),"^",1),I)=I,RMTOI=RMTOI+1
 D ENT G:'IEN EXIT S DIE="^RMPR(668,",DA=IEN,DR="2R;5R;4;7" D ^DIE I $P(^RMPR(668,IEN,0),U,5) S $P(^(0),U,6)=DUZ
 I $D(DTOUT)!($D(DUOUT)) G EXIT
 G LINK
 ;
WRI ;write
 ;called from ENT, rmprdfn, rmprj defined
 N RMPR668
 S RO=$G(^RMPR(668,RMPRJ,0)),RMPR668=RMPRJ,Y=$P(^(0),U,1)
 W !,RMI,".",?5,$$DAT1^RMPRUTL1(Y)
 S DFN=$P(RO,U,2) D DEM^VADPT
 W ?16,$E(VADM(1),1,19)
 W ?37,$$STATUS^RMPREOU(RMPR668,9)
 ;display first part of description
 I $D(^RMPR(668,RMPR668,2,1,0)) W ?48,$E(^RMPR(668,RMPR668,2,1,0),1,31)
 Q
DIS ;continue
 K DIR S DIR(0)="NO^1:"_RMI_":0" D ^DIR
 I $D(DUOUT) S OUT=1 Q
 I Y>0 S IEN=$P(^TMP("RMSU",$J,+Y),U,2)
 Q
 ;
DICDPT ;ask patient from file #2
 ;
 K DIC,^TMP("RMSU",$J)
 S DIC="^DPT(",DIC(0)="AEQMZ"
 S DIC("A")="Select PATIENT: " D ^DIC Q
 ;
 ;added in patch #62
SMESS ;print message for mandatory suspense entry.
 ;W !!,"*********************************************************"
 ;W !,"** No suspense record has been selected for this       **"
 ;W !,"** transaction.  You must POST INITIAL ACTION, POST    **"
 ;W !,"** OTHER ACTION or POST COMPLETE suspense in order to  **"
 ;W !,"** complete this transaction, otherwise transaction    **"
 ;W !,"** will not be linked to SUSPENSE..................    **"
 ;W !,"*********************************************************"
 ;W !!
 ;K DIR
 ;S DIR(0)="SBO^L:LINK Suspense to Patient Record;E:EXIT without linking to Suspense"
 ;S DIR("A")="Would you like to LINK Suspense or EXIT without linking"
 ;S DIR("B")="L"
 ;S DIR("?")="Answer `L` to Link to suspense, 'E' to exit without link to suspense"
 ;D ^DIR S RMENTSUS=Y
 ;I $D(DIRUT)!$D(DUOUT)!$D(DTOUT) S RMENTSUS="E"
 ;W !! K DIR
 ;Q
