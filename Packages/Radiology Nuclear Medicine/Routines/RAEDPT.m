RAEDPT ;HISC/FPT,GJC,SS AISC/MJK,RMO-Edit Exams by Patient ;4/21/97  10:47
 ;;5.0;Radiology/Nuclear Medicine;**10,18,28,45**;Mar 16, 1998
 ;last modification by SS JUNE 19,2000
CASE D SET^RAPSET1 I $D(XQUIT) K XQUIT,POP Q
 S RAXIT=0,DIC(0)="AEMQ" D ^RADPA G Q:Y<0
 S RADFN=+Y,RAHEAD="**** Edit Exams By Patient ****"
 D ^RAPTLU G CASE:"^"[X
 W !!,"Case No.:",RACN,?15,"Procedure:",$E(RAPRC,1,30),?57,"Date:",RADATE
 N RADISPLY
 S RADISPLY=$G(^RAMIS(71,+$P($G(^RADPT(+RADFN,"DT",+RADTI,"P",+RACNI,0)),U,2),0)) ; set $ZR to 71 for prccpt^radd1, not call raprod since diff col
 S RADISPLY=$$PRCCPT^RADD1()
 W !,?25,RADISPLY
 I $D(^RA(72,"AA",RAIMGTY,9,+RAST)),'$D(^XUSEC("RA MGR",DUZ)) W !!?3,$C(7),"You do not have the appropriate access privilege to edit completed exams.",! G CASE
 I $D(^RA(72,"AA",RAIMGTY,0,+RAST)) W !!?3,$C(7),"Exam has been 'cancelled' therefore it cannot be edited." G CASE
 S RAQUICK=0,DA=RADFN,DIE("NO^")="OUTOK"
 S RADADA=RADTI ; RADTI defined in ^RAPTLU
 S DIE="^RADPT(",DR="[RA EXAM EDIT]"
 S RADIE="^RADPT("_RADFN_",""DT"","
 S RAXIT=$$LOCK^RAUTL12(RADIE,RADADA) I RAXIT G CASE
 N RAREM,RANUZD1,RAPSDRUG,RA00,RADIOPH,RALOW,RAHI,RADRAWN,RAASK,RADOSE,RASKMEDS,RAWHICH ;these are used by the edit template
 ;
 ;save 'before' CM data value to compare against the possible 'after'
 ;value
 D TRK70CMB^RAMAINU(RADFN,RADTI,RACNI,.RATRKCMB) ;RA*5*45
 ;
 D SVBEFOR^RAO7XX(RADFN,RADTI,RACNI) ;P18 save before edit to compare later in RAUTL1
 D ^DIE K DE,DQ,DIE,DR,RAZCM
 S:$D(RAPRI) RAPRIT=RAPRI D UP1^RAUTL1
 ;
 ;1) check data consistency between 'CONTRAST MEDIA USED' & 'CONTRAST
 ;MEDIA'
 ;2) check 'before' CM data against 'after' CM data, file in audit log
 ;if necessary. Remember, contrast media asked when in input template:
 ;RA EXAM EDIT (RA*5*45)
 S RACMDA=RACNI,RACMDA(1)=RADTI,RACMDA(2)=RADFN
 D XCMINTEG^RAMAINU1(.RACMDA) ;1
 D TRK70CMA^RAMAINU(RADFN,RADTI,RACNI,RATRKCMB) ;2
 K RACMDA
 ;
 D UNLOCK^RAUTL12(RADIE,RADADA) ;modif P18 by SS
 K RATRKCMB,RADADA,RADIE,RADUZ W ! G CASE ;modif P18 by SS
 ;
Q K %,%DT,%Y,A,C,D0,D1,D2,DA,DIC,I,RACN,RACNI,RACNT,RACT,RADADA,RADATE,RADATI,RADFN,RADIE,RADTE,RADTI,RAHEAD,RAMES,RANME,RAOR,RAORDIFN,RAPOP,RAPRC,RAPRI,RAQUICK,RARPT,RASN,RASSN,RAST,RASTI,RAXIT,XQUIT,VAINDT,VADMVT,X,Y
 K ^TMP($J,"RAEX")
 K %W,%Y1,D,D3,DDER,DI,DK,DL,POP,DISYS,DUOUT,RAI
 Q
