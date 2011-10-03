RMPR29S ;PHX/JLT-ASSIGN WORK ORDER[ 09/30/94  3:55 PM ]
 ;;3.0;PROSTHETICS;**50**;Feb 09, 1996
 ;
 ;ODJ - Patch 50 - 7/13/00 - put in call to set patient vars. to
 ;                           prevent undef errs. cf nois MIW-1098-41197
 ;
ASK ;ASK FOR MUTLIPLE ASSGIN
 D DIV4^RMPRSIT G:$D(X) EXIT
 S DIR(0)="Y",DIR("A")="Would you like assign Multiple 2529-3's",DIR("B")="YES" D ^DIR G:$D(DIRUT)!($D(DTOUT)) EXIT I +Y=1 S PCOUNT=0 G MUL
APP ;ASSIGN SINGLE 2529-3 TO TECHNICIAN
 S DIC="^RMPR(664.1,",DIC(0)="AEQM",DIC("S")="I $P(^(0),U,3)=RMPR(""STA""),'$P(^(0),U,20),($P(^(0),U,17)=""P""!($P(^(0),U,17)=""A""))",DIC("W")="D EN3^RMPRD1" D ^DIC G:+Y'>0 EXIT
 S RMPRDA=+Y,PASS=1
ASM ;check/lock record
 ;S RMPRDA=+Y
 Q:$G(RMPRDA)<1
 L +^RMPR(664.1,RMPRDA,0):1 I '$T W !!,$C(7),?5,"Someone else is editing this entry" G EXIT
 S RMPRWO=$P(^RMPR(664.1,RMPRDA,0),U,13) G DISP^RMPR29D
ATCH ;attach technician/status to record
 ;CALLED BY RMPR29T
 ;VARIABLE REQUIRED: RMPRDA - ENTRY NUMBER IN FILE 664.1
 ;                   RMPR ARRAY - MISCELLANEOUS SITE DATASET BY
 ;                                A CALL TO DIV4^RMPRSIT
 ;                   RMPR("L") - A LINE OF DIRECTIONS
 K DIC,Y S DIC("B")=$S($P(^RMPR(664.1,+RMPRDA,0),U,16):$$EMP^RMPR31U($P(^(0),U,16)),1:""),DIC="^VA(200,",DIC(0)="AEQMZ",DIC("A")="LAB TECHNICIAN: " D ^DIC G:+Y'>0 EXIT S PEMP=+Y D ST^RMPR29U
 S DIE="^RMPR(664.1,",DR=$S($P($G(^RMPR(664.1,RMPRDA,7)),U):"19R",1:"19R///^S X=DT"),DA=RMPRDA D ^DIE G:$D(DTOUT)!($D(Y)) EXIT
 G DISP^RMPR29D
EXIT ;common exit point
 ;CALLED BY RMPR29T
 L -^RMPR(664.1,+$G(RMPRDA),0)
 K DIC,DIE,DIR,DA,DIRUT,DR,DTOUT,PEMP,PREV,PSM,RMPRDA,RMPRDFN,RMPRWO,RI
 K PASS,PCOUNT Q
MUL ;MULTIPLE ASSIGN
 S RMPRBAC1=1
 K PDCA F RI=0:0 S RI=$O(^RMPR(664.1,"E","P",RI)) Q:+RI'>0  I +RI,$P($G(^RMPR(664.1,RI,0)),U,3)=RMPR("STA") S PDCA(RI)="",PREV(-RI)=""
 I '$D(PDCA) D MESS G EXIT
 S PCOUNT=$O(PDCA(PCOUNT)) G:$G(PCOUNT)<1 EXIT
 I +PCOUNT S Y=PCOUNT,RMPRDA=Y,PSM=1
 D ASM
 Q
NEXT ;LOOK THRU EXITING 2529-3's
 ;CALLED BY RMPR29T
 ;VARIABLES REQUIRED: PDCA - AN ARRAY
 ;                    RMPRDA - ENTRY IN FILE 664
 ;                    PCOUNT - AN INDEX
 ;                    RMPR ARRAY - MISCELLANEOUS SET BY
 ;                                 A CALL TO DIV4^RMPRSIT
 ;I +$O(PDCA(RMPRDA))=0 W $C(7) S Y=RMPRDA G ASM
 ;S PCOUNT=$O(PDCA(PCOUNT)) I +PCOUNT S Y=PCOUNT G ASM
 I +$O(PDCA(RMPRDA))=0 W $C(7),!!,"There are no more 'next' jobs to assign." H 2 Q  ;G ASM 
 S RMPRDA=$O(PDCA(RMPRDA)) I $G(RMPRDA)>0 G ASM
 Q
PREV ;previous record
 ;CALLED BY RMPR29T
 ;VARIABLE REQUIRED: RMPRDA - SUPSCRIPT IN PREV ARRAY
 ;                   PREV - AN ARRAY
 I +$O(PREV(-RMPRDA))=0 W $C(7) S Y=RMPRDA G ASM
 S Y=$O(PREV(-RMPRDA)) I $G(Y)'="" S (PCOUNT,Y)=Y*-1,PSM=1,RMPRDA=Y G ASM
 Q
MESS ;message/pause
 W !!,$C(7),?5,"No Lab 2529-3's need to be assigned" H 3
 Q
PRC ;entry point from option RMPR PROCESS 2529-3 JOB
 ;PROCESS 2529-3 TO CREATE WORK ORDER
 ;CALLED BY RMPR29A
 ;VARIABLES REQUIRED: NONE
 D KVAR^VADPT,HOME^%ZIS K X,Y,DIC
 D DIV4^RMPRSIT G:$D(X) EXIT
 S DIC="^RMPR(664.1,",DIC(0)="AEQM"
 ;screen
 ;if STATION = site selected
 ;if WORK ORDER NUMBER not null
 ;if NO LAB COUNT null
 ;if STATUS "A" Assigned to tech
 S DIC("S")="I $P(^(0),U,3)=RMPR(""STA""),$P(^(0),U,13)'="""",'$P(^(0),U,20),($P(^(0),U,17)=""A"""
 S DIC("W")="D EN3^RMPRD1"
 ;change to screen
 ;if supervisor key, add to screen
 ;if STATUS = "R"  returned to tech
 ;if STATUS = "PC" pending completion
 ;if STATUS = "P"  pending assignment
 ;or if not supervisor key, add to screen
 ;if STATUS = "R"
 S DIC("S")=$S($D(^XUSEC("RMPR LAB SUPERVISOR",DUZ)):DIC("S")_"!($P(^(0),U,17)=""R"")!($P(^(0),U,17)=""PC"")!($P(^(0),U,17)=""P""))",1:DIC("S")_"!($P(^(0),U,17)=""R""))")
 D ^DIC S:+Y RMPRDA=+Y K DIC G:+Y'>0 EXIT
 ;
 L +^RMPR(664.1,+Y,0):1 I '$T W !!,?5,$C(7),"Someone is already editing this entry" G EXIT
 S RMPRDFN=$P(^RMPR(664.1,+Y,0),U,2) I '$P(^(0),U,16) S RMPRWO=$P(^(0),U,13)
 D  ;preserve value of $T
 . D DPTVARS(RMPRDFN) ; set patient vars. required for display later on
 . Q
 I  S DIR(0)="Y",DIR("A")="You are self Assigning WORK ORDER #: "_RMPRWO_" ",DIR("B")="YES"
 ;if TECHNICIAN null
 I  W !! D ^DIR G:$D(DIRUT)!($D(DTOUT))!(+Y=0) EXIT I +Y=1 D EN4^RMPR29U(RMPRDA) S PEMP=DUZ S DIE="^RMPR(664.1,",DA=RMPRDA,DR="19///^S X=DT" D ^DIE D ST^RMPR29U G DISP^RMPR29D
 D EN4^RMPR29U(RMPRDA) G DISP^RMPR29D
 ;exit from RMPR29D
 ;
 ; Get patient vars using same code as in RMPRUTIL
DPTVARS(DFN) ;
 N VADM,VAEL
 D DEM^VADPT
 D ELIG^VADPT
 ;set prosthetic variables
 ;rmprssn is number nnnnnnnnn
 ;rmprssne is external format of ssn nnn-nn-nnnn
 S RMPRNAM=$P(VADM(1),U),RMPRSSN=$P(VADM(2),U)
 S RMPRDOB=$P(VADM(3),U),RMPRSSNE=VA("PID")
 S RMPRCNUM=VAEL(7)
 Q
