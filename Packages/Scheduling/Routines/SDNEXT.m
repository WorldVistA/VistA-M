SDNEXT ;ALB/TMP - FIND NEXT AVAILABLE APPOINTMENT FOR A CLINIC ; 18 APR 86
 ;;5.3;Scheduling;**41,45,165,549**;AUG 13, 1993;Build 2
 ;
 S IOP=$S($D(ION):ION,1:"HOME") D ^%ZIS K IOP
1 S SDNEXT="",SDCT=0 G RD^SDMULT
DT S FND=0,%DT(0)=-SDMAX,%DT="AEF",%DT("A")="  START SEARCH FOR NEXT AVAILABLE FROM WHAT DATE: " D ^%DT K %DT G:"^"[X 1:$S('$D(SDNEXT):1,'SDNEXT:1,1:0),END^SDMULT0 G:Y<0 DT S SDSTRTDT=+Y
LIM W !,"  ENTER LATEST DATE TO CHECK FOR 1ST AVAILABLE SLOT: " S Y=SDMAX D DT^DIQ R "// ",X:DTIME G:X["^"!'($T) END^SDMULT0 I X']"" G OVR^SDMULT0
 I X?.E1"?" W !,"  The latest date for future bookings for ",$P(SDC(1),"^",2)," is: " S Y=SDMAX D DTS^SDUTL W Y,!,"  If you enter a date here, it must be less than this date to further limit the",!,"  search" G LIM
 S %DT="EF",%DT(0)=-SDMAX D ^%DT K %DT G:Y<0!(Y<SDSTRTDT) LIM S:Y>0 SDMAX=+Y
 G OVR^SDMULT0
 ;
NEW ;entry point to be use for next available appt. 3/29/96
 K VAUTT,VAUTC,SCUP
 N SCOKNULL
 S SCOKNULL=1
 S IOP=$S($D(ION):ION,1:"HOME") D ^%ZIS K IOP
 S SDNEXT="",SDCT=0
 S VAUTNA="" ;don't allow all to be selected
 S VAUTCA="" ;allow any clinic to be selected
 S VAUTD=1 ;all divisions
 D CLINIC^SCRPU1 ;prompt for clinics (none,one,many)
 Q:$D(SCUP)  ; "^" SELECTED
 D PRMTT^SCRPU1 ;prompt for team (none,one,many)
 Q:('$D(VAUTT))&('$D(VAUTC))
 Q:$D(SCUP)  ; "^" SELECTED
 S APPTL=$$LENGTH()
 Q:APPTL<0
 S FIRST="First date to check for 1st available appointments: "
 S SECOND="Latest date to check for available appointments: "
 S RANG=$$DTRANG^SCRPU2(FIRST,SECOND)
 I RANG=-1 D CLEAN,EXIT Q
 I $D(VAUTT) D GETCLN(.VAUTT,.VAUTC)
 ;all clinics selected & position assoc clinics in VAUTC(ien)=clinic name
 D DRIVE(.VAUTC,APPTL,RANG)
 D CLEAN,EXIT
 Q
EXIT ;
 K VAUTD,VAUTNA,VAUTT,VAUTC,FIRST,SECOND,RANG,APPTL,SCPCMM,SDNEXT,SDCT
 K VAUTCA,SCUP
 Q
 ;
LENGTH() ;
 ;prompt for appointment length
 N LEN
ST S DIR(0)="N"
 S DIR("A")="Appointment Length Needed "
 D ^DIR
 I Y=""!(X="^")!(X="") S LEN=-1 G EX
 S LEN=X
EX K DIR,Y,X
 Q LEN
 ;
GETCLN(TEAM,CLINIC) ;add assoc. clinics for teams to clinic array
 ;TEAM - team array
 ;CLINIC - clinic array
 ;
 N TM,LIST,ERR,OKAY
 S TM=0,LIST="TPLIST",ERR="ERR1"
 F  S TM=$O(TEAM(TM)) Q:TM=""!(TM'?.N)  D
 .K @LIST,@ERR
 .S OKAY=$$TPTM^SCAPMC24(TM,"","","",LIST,ERR)
 .;@LIST contains all positions for team TM
 .I $G(@LIST@(0))>0 D ADDCL(.CLINIC,LIST)
 Q
 ;
ADDCL(CLINIC,PTLIST) ;add team's associated clinics to clinic list
 ;CLINIC - array of selected clinics
 ;PTLIST - array of all positions for a selected team
 N CNAME,CIEN,TPNODE,TPIEN,NODE,EN
 S EN=0
 F  S EN=$O(@PTLIST@(EN)) Q:EN=""!(EN'?.N)  D
 .S NODE=$G(@PTLIST@(EN))
 .S TPIEN=+$P(NODE,"^") ;team position ien
 .S TPNODE=$G(^SCTM(404.57,TPIEN,0))
 .Q:TPNODE=""
 .Q:'$D(^SCTM(404.57,TPIEN,5,0))  ;no associated clinics
 .S SDA=0  ;SD/549 change logic to pull from new multiple field
 .F  S SDA=$O(^SCTM(404.57,TPIEN,5,SDA)) Q:'SDA  D
 ..Q:'$D(^SCTM(404.57,TPIEN,5,SDA,0))
 ..S CIEN=+$G(^SCTM(404.57,TPIEN,5,SDA,0))
 ..Q:CIEN=0  ;no associated clinic
 ..S CNAME=$P($G(^SC(CIEN,0)),"^")  ;clinic name
 ..S CLINIC(CIEN)=CNAME
 K SDA
 Q
 ;
DRIVE(CLINICA,LEN,BEGEND) ;driver
 ;CLINICA - clinic array
 ;LEN - appt. length wanted
 ;BEGEND - begin date ^ end date
 ;
 N CIEN,COUNT,CONT,FND
 S SDNEXT="",SDCT=1
 S CIEN=0,STOP=0,COUNT=1
 F  S CIEN=$O(CLINICA(CIEN)) Q:CIEN=""!(CIEN'?.N)!(STOP)  D
 .S SDNEXT=""
 .S SDSTRTDT=$P(BEGEND,"^")
 .S SDMAX=$P(BEGEND,"^",2)
 .S SDC(COUNT)=CIEN,SDC1(CIEN)=$G(CLINICA(CIEN))_"^"_LEN
 .S SDCT=COUNT,SC=CIEN,FND=0
 .D OVR^SDMULT0 S CONT=$$CONMA(CIEN,$S($O(CLINICA(CIEN)):0,1:1))
 .K SDC(COUNT),SDC1(CIEN)
 .;S CONT=$$CONMA(CIEN)
 .Q:STOP
 I $G(CONT)="M" D CLEAN S:$$ONE(.CLINICA) SDCLN=$O(CLINICA(0)) G ^SDM
 Q
CLEAN ;
 D END^SDMULT0
 K SDSTRTDT,SDNEXT,SDMAX,SDC,SDCT,SDC1,SDL,STOP,SDAPP,SDPCMM,SDCLN,FND
 K SCPCC,SDPCM1,SC
 Q
 ;
ONE(CLNA) ;one clinic selected? 1 or 0
 N CNT,FIRST,RET,STP
 S (CNT,STP)=0,RET=1
 F  S CNT=$O(CLNA(CNT)) Q:CNT=""!(STP)  D
 .I $D(FIRST) S STOP=1,RET=0
 .I '$D(FIRST) S FIRST=1
 Q RET
 ;
CONMA(CIEN,CONT) ;continue to view, exit or make appointment
 ;
PRT ;
 S CONT=$G(CONT)
 I $G(SDPCMM(CIEN))'>0&('CONT) Q -1
 W !,"'^' TO EXIT"_$S('CONT:", 'C' TO CONTINUE",1:"")_" OR 'M' TO GOTO MAKE APPOINTMENT: "_$S(CONT:"^",1:"CONTINUE")_"//" R X:DTIME
 I '$T!(X="^") S STOP=1,X=-1 G EX2
 I (X'="^")&(X'="C")&(X'="M")&(X'="") G PRT
 I CONT&(X="C") G PRT
 I X="M" S STOP=1
 I X="" S X="C"
EX2 Q X
