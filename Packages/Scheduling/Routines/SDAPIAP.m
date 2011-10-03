SDAPIAP ;ALB/MJK - Outpatient API/Appointments ; 22 FEB 1994 11:30 am
 ;;5.3;Scheduling;**27,132**;08/13/93
 ;
EN(DFN,SDT,SDCL,SDUZ,SDMODE,SDVIEN) ; -- check api for appts
 N SDDA,SDOE
 S SDOE=0
 ; -- verify that check-out can occur
 D CHECK(DFN,SDT,SDCL,.SDDA) I $$ERRCHK^SDAPIER() G ENQ
 ;
 ; -- file check-out data ; get encount ien
 S SDOE=$$FILE(DFN,SDT,SDCL,SDUZ,SDDA,SDMODE,$G(SDVIEN))
 ;
ENQ Q SDOE
 ;
CHECK(DFN,SDT,SDCL,SDDA) ; -- check if event can occur/allowed
 N SDATA,STATUS
 ; -- error if appt node doesn't exist
 S SDATA=$G(^DPT(DFN,"S",SDT,0))
 I SDATA="" D ERRFILE^SDAPIER(100,SDT_U_DFN) G CHECKQ
 ;
 ; -- error if different clinic
 I +SDATA'=SDCL D ERRFILE^SDAPIER(101,+SDATA_U_SDCL) G CHECKQ
 ;
 ; -- error if no slot for appt
 S SDDA=$$FIND^SDAM2(DFN,SDT,SDCL) I 'SDDA D ERRFILE^SDAPIER(102,SDT_U_SDCL) G CHECKQ
 ;
 ; -- get appt status data 
 S STATUS=$$STATUS^SDAM1(DFN,SDT,SDCL,SDATA,SDDA)
 ;
 ; -- error if current status won't allow checking-out
 I '$D(^SD(409.63,"ACO",1,+STATUS)) D ERRFILE^SDAPIER(103,$P(STATUS,";",2)) G CHECKQ
 ;
 ; -- warning if already checked-out
 I $P(STATUS,";",2)="CHECKED OUT" D ERRFILE^SDAPIER(1100)
 ;
 ; -- error if appt date if after today
 I SDT>(DT+.2359) D ERRFILE^SDAPIER(104,SDT) G CHECKQ
CHECKQ Q
 ;
FILE(DFN,SDT,SDCL,SDUZ,SDDA,SDMODE,SDVIEN) ; -- file data
 N SDATA,SDHDL,SDOE,SDCOMPF,SDLOG
 S SDOE=""
 ;
 ; -- setup event driver data
 D BEFORE^SDCO1(.SDATA,DFN,SDT,SDCL,SDDA,.SDHDL)
 ;
 ; -- set elig for appt
 D ELIG^SDCO1(DFN,SDT,SDCL,SDDA) ; may need to expand
 ;
 ; -- get encounter ien ; error if none returned
 S SDOE=$$GETAPT^SDVSIT2(DFN,SDT,SDCL,$G(SDVIEN))
 I 'SDOE D ERRFILE^SDAPIER(110) G FILEQ
 ;
 ; -- time stamp check-out and log data
 D DT(DFN,SDT,SDCL,SDDA,$G(@SDROOT@("DATE/TIME")))
 D LOGDATA(SDOE)
 ;
 ; -- process data
 D FILE^SDAPICO(SDOE,SDUZ)
 ;
 ; -- update check-out completion
 D EN^SDCOM(SDOE,SDMODE,SDHDL,.SDCOMPF)
 ;
 ; -- set visit change flag for event driver
 D CHANGE^SDAMEVT4(.SDHDL,$P($G(^SCE(SDOE,0)),U,8),$G(@SDROOT@("VISIT CHANGE FLAGS")))
 ;
 ; -- get after values and invoke event driver
 D AFTER^SDAMEVT(.SDATA,DFN,SDT,SDCL,SDDA,SDHDL)
 D EVT^SDAMEVT(.SDATA,5,SDMODE,SDHDL)
 ;
 ; -- cleanup event driver vars
 D CLEAN^SDAMEVT(SDHDL)
 ;
FILEQ Q SDOE
 ;
DT(DFN,SDT,SDCL,SDDA,SDCODT) ; -- time stamp check out date
 ; -- NOTE: this code duplicates at DT^SDCO1 but silent
 N %DT,DR,SDCIDT,X,DIE,DA
 S:'$D(^SC(SDCL,"S",0)) ^(0)="^44.001DA^^"
 S X=$G(^SC(SDCL,"S",SDT,1,SDDA,"C")),SDCIDT=+X
 ;IF $P(X,U,3) G DTQ
 S DR="" IF $G(SDCODT) S DR="303R////"_$S(SDCODT<SDCIDT:SDCIDT,1:SDCODT)
 IF DR]"" D DIE^SDCO1(SDCL,SDT,SDDA,DR)
DTQ Q
 ;
LOGDATA(SDOE,SDLOG) ; -- log user, date/time and other data
 N DIE,DA,DR,Y,X
 S SDLOG("USER")=$S(+$G(SDUZ):+SDUZ,1:$G(DUZ)) ; -- editing user
 S SDLOG("DATE/TIME")=$$NOW^XLFDT()            ; -- last edited 
 S DIE="^SCE(",DA=SDOE,DR="[SD ENCOUNTER LOG]" D ^DIE
 Q
 ;
