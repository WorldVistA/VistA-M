SCMCTPU3 ;ALB/MJK - Team Position Utility ; 1 SEP 98
 ;;5.3;Scheduling;**148**;AUG 13,1993
 ;
EN ; -- main entry point to find pat position assignments w/o team assignment
 N SCMODE,SCTMLST,SCTSK
 ;
 ; -- ask user which mode (diagnosis vs. fix)
 S SCMODE=$$MODE()
 IF 'SCMODE G ENQ
 ;
 ; -- ask user for teams
 IF '$$TEAM() G ENQ
 ;
 ; -- queue job to run
 S SCTSK=$$QUE()
 IF SCTSK'="" D
 . W !!,">>> Task#: ",SCTSK
 . W !!,"    This task will send a MailMan message to you containing"
 . W !,"    the results of the position assignment review.",!
 D PAUSE
ENQ Q
 ;
MODE() ; -- get mode from user (1 - diagnostic  2 - fix  0 - abort)
 Q 1  ; -- fix mode (2) is a future
 ;
TEAM() ; -- get teams from user
 N Y,DIC,VAUTVB,VAUTSTR,VAUTINI
 S VAUTVB="SCTMLST"
 S VAUTSTR="Team"
 S VAUTNI=2
 S DIC="^SCTM(404.51,"
 D FIRST^VAUTOMA
 Q $S(Y=-1:0,1:1)
 ;
QUE() ; -- setup task and queue job to run
 ;D START Q 99999 ; -- for interactive testing
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSAVE,ZTSK
 S ZTRTN="START^SCMCTPU3"
 S ZTDESC="Patient Team Position Assignment Review"
 S ZTDTH=$H
 S ZTIO=""
 F X="SCTMLST(","SCTMLST","SCMODE" S ZTSAVE(X)=""
 D ^%ZTLOAD
 Q $G(ZTSK)
 ;
START ; -- entry point for queued job
 ;
 N SCSTOP,SCER,SCERTMP,SCNT
 N SCTP,SCTP0,SCTPNM
 N SCTM,SCTM0,SCTMNM
 N SCPT,SCPT0,SCPTNM,SCPTID
 N SCTPA,SCTPA0,SCTPASDT,SCTPUNDT
 N SCTMA,SCTMA0,SCTMASDT,SCTMUNDT
 ;
 S SCERTMP=$NA(^TMP("SCTP DANGLERS",$J))
 K @SCERTMP
 ;
 ; -- is 'all' teams selected build array
 IF SCTMLST=1 D
 . S SCTM=0
 . F  S SCTM=$O(^SCTM(404.51,SCTM)) Q:'SCTM  S X=$G(^SCTM(404.51,SCTM,0))  S SCTMLST(SCTM)=$P(X,U)
 ;
 ; -- loop through entire team position assignment file
 S (SCSTOP,SCTPA)=0
 F  S SCTPA=$O(^SCPT(404.43,SCTPA)) Q:'SCTPA  D  Q:SCSTOP
 . IF $$S^%ZTLOAD() S (SCSTOP,ZTSTOP)=1 Q
 . N SCERAR
 . ;
 . ; -- get data
 . D DATA(SCTPA)
 . ;
 . ; -- quit if team not selected by user
 . IF '$D(SCTMLST(SCTM)) Q
 . ;
 . D CNT("TOTAL")
 . ;
 . ; -- if postion assigned date    >= team assigned date
 . ;                    and
 . ;       position unassigned date <= team unassigned date
 . ;    then entry is good
 . ;
 . ;    else
 . ;        process error 
 . ;
 . IF SCTPASDT>SCTMASDT!(SCTPASDT=SCTMASDT) D
 . . IF SCTPUNDT<SCTMUNDT!(SCTPUNDT=SCTMUNDT) D
 . . . D CNT("OK")
 . . . Q
 . . ; -- position unassign date > team unassign date
 . . ELSE  D
 . . . D ERR(2)
 . . . Q
 . . Q
 . ; -- position assign date < team assign date
 . ELSE  D 
 . . D ERR(1)
 . . Q
 . ;
 . IF $O(SCERAR(0)) D CNT("BAD"),SET
 . ; -- check if user asked job to stop
 . Q
 ;
 IF 'SCSTOP D BULL^SCMCTPU4
 ;
 K @SCERTMP
 Q
 ;
CNT(TYPE) ; -- set counter
 S SCNT(TYPE)=$G(SCNT(TYPE))+1
 Q
 ;
ERR(NUMBER) ; -- set error array
 S SCERAR(NUMBER)=""
 Q
 ;
SET ; -- set tmp for report
 N SCER
 S SCER=0
 F  S SCER=$O(SCERAR(SCER)) Q:'SCER  D
 . S @SCERTMP@(SCTMNM_SCTM,SCTPNM_SCTP,SCPTNM_SCPT,SCTPASDT,SCTPA,SCER)=""
 Q
 ;
DATA(SCTPA) ; -- get team, position, tm pos assign, tm assignment & patient data
 ; input: SCPTA := ien to patient team position assignment (404.43)
 ;
 ; -- Team Position Assignment (TPA) data
 S SCTPA0=$G(^SCPT(404.43,SCTPA,0))
 S SCTPASDT=+$P(SCTPA0,U,3)
 S SCTPUNDT=$S($P(SCTPA0,U,4):$P(SCTPA0,U,4),1:9999999)
 ;
 ; -- Team Position (TP) data
 S SCTP=+$P(SCTPA0,U,2)
 S SCTP0=$G(^SCTM(404.57,SCTP,0))
 S SCTPNM=$P(SCTP0,U)
 ;
 ; -- TeaM Assignment (TMA) data
 S SCTMA=+SCTPA0
 S SCTMA0=$G(^SCPT(404.42,SCTMA,0))
 S SCTMASDT=+$P(SCTMA0,U,2)
 S SCTMUNDT=$S($P(SCTMA0,U,9):$P(SCTMA0,U,9),1:9999999)
 ;
 ; -- TeaM (TM) data
 S SCTM=+$P(SCTMA0,U,3)
 S SCTM0=$G(^SCTM(404.51,SCTM,0))
 S SCTMNM=$P(SCTM0,U)
 ;
 ; -- PaTient (PT) data
 S SCPT=+SCTMA0
 S SCPT0=$G(^DPT(SCPT,0))
 S SCPTNM=$P(SCPT0,U)
 N DFN,VA
 S DFN=SCPT D PID^VADPT6
 S SCPTID=VA("BID")
 Q
 ;
PAUSE ; -- pause
 N DIR,Y
 S DIR(0)="EA"
 S DIR("A")=">>> Press RETURN to continue: "
 D ^DIR
 Q
