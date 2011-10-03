PSO293PI ;BIR/MFR-EXPIRATION DATE CLEAN UP ;05/03/07
 ;;7.0;OUTPATIENT PHARMACY;**293**;DEC 1997;Build 22
 ;External references ^DPT supported by DBIA 10035
 ;External reference to STATUS^ORQOR2 is supported by DBIA 3458
 ;External reference to ^PS(59.7 is supported by DBIA 694
 N NMSP,JOBSTS,DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,Y,ACTION,EXPJOBDT,PSODUZ
 S NMSP="PSO293PI"
 ;
 S JOBSTS=$$JOBSTS^PSO293P1()
 ;
 W !?5,"Expiration Date clean up job for Outpatient Pharamcy prescriptions"
 W !?5,"=================================================================="
 W !?5,"Current status: "
 W:JOBSTS="N" "NEVER RUN"
 W:JOBSTS="S" "STOPPED ON "_$$FMTE^XLFDT($G(^XTMP(NMSP,"STOPPED")))
 W:JOBSTS="R" "RUNNING"
 W:JOBSTS="C" "COMPLETED ON "_$$FMTE^XLFDT($G(^XTMP(NMSP,"COMPLETED")))
 W:JOBSTS="U" "UNKNOWN"
 W:$G(^XTMP(NMSP,"LASTRX")) " (Last Rx IEN: "_+$G(^XTMP(NMSP,"LASTRX"))_")"
 ;
 S DIR(0)="SO^",DIR("A")=""
 I JOBSTS="N" D
 .S DIR(0)=DIR(0)_"ST:START CLEAN UP JOB;",DIR("A")=DIR("A")_"(ST)Start,",DIR("B")="START"
 I JOBSTS="S" D
 . S DIR(0)=DIR(0)_"RE:RESUME CLEAN UP JOB;",DIR("A")=DIR("A")_"(RE)Resume,"
 I JOBSTS="R" D
 . S DIR(0)=DIR(0)_"SP:STOP CLEAN UP JOB;",DIR("A")=DIR("A")_"(SP)Stop,"
 I JOBSTS="C" D
 . S DIR(0)=DIR(0)_"RR:RE-RUN CLEAN UP JOB;",DIR("A")=DIR("A")_"(RR)Re-run,"
 S DIR(0)=DIR(0)_"VW:VIEW "_$S(JOBSTS'="C":"PARTIAL ",1:"")_"CLEAN UP JOB RESULTS;"
 S DIR("A")=DIR("A")_"(VW)View,",DIR("B")="VIEW"
 S DIR(0)=DIR(0)_"QT:QUIT",DIR("A")=DIR("A")_"(QT)Quit"
 D ^DIR I $D(DIRUT)!$D(DIROUT)!$D(DTOUT)!$D(DUOUT) G QUIT
 S ACTION=Y
 ;
 I ACTION="SP" W !!,"This may take a few minutes, please wait..." D  G QUIT
 . N TIME,UNABLE
 . S ^XTMP(NMSP,"STOP")=1,(TIME,UNABLE)=0
 . F  Q:$D(^XTMP(NMSP,"STOPPED"))  D  Q:UNABLE
 . . H 1 S TIME=TIME+1
 . . I '$D(^XTMP(NMSP,"STOPPED")) D
 . . . I $D(^XTMP(NMSP,"COMPLETED"))!($$JOBSTS^PSO293P1()'="R")!(TIME>600) S UNABLE=1
 ;
 I ACTION="QT" G QUIT
 I ACTION="VW" D DISPLAY^PSO293P1 G QUIT
 ;
 D JOB^PSO293P1()
 Q
 ;
PI ; Post-Install entry point
 N EXPJOBDT,NMSP
 S NMSP="PSO293PI"
 D LOG^PSO293P1("PATCH INSTALLATION")
 S EXPJOBDT=$$GET1^DIQ(59.7,1,49.95,"I")
 I 'EXPJOBDT D
 . S EXPJOBDT=$$FMADD^XLFDT($$DT^XLFDT(),-2)
 . S $P(^PS(59.7,1,49.99),"^",8)=EXPJOBDT
 . D LOG^PSO293P1("DATE AUTO-EXPIRE set: "_$$FMTE^XLFDT(EXPJOBDT,2))
 S ^XTMP(NMSP,"EXPJOBDT")=EXPJOBDT
 ;
 D JOB^PSO293P1($$NOW^XLFDT())
 Q
 ;
EN ;
 N NMSP,PSOINST,CUTOFF,PSOACT,RXP,STOP,PSOINACT,PATIENT,COUNTER,RXP,DRUG,STATUS
 N ISSUEDT,EXPIRDT,BADRXCNT,DAYSSUP,NUMREFS,PSOPROD,LASTCNT,I
 ;
 S NMSP="PSO293PI" I '$G(PSODUZ) S PSODUZ=+$G(DUZ)
 ;
 ; - If can't get Lock, then already running.
 L +^XTMP(NMSP):5 I '$T D LOG^PSO293P1("UNSUCCESSFUL (LOCKED)") G QUIT
 ;
 D SETXTMP
 ;
 I '$G(DT) S DT=$$DT^XLFDT
 S PSOPROD=$$PROD^XUPROD()
 ;
 S PSOINST=$P($$SITE^VASITE(),"^",2)_" ("_+$$SITE^VASITE()_")"
 S CUTOFF=$$GET1^DIQ(59.7,1,49.95,"I") I 'CUTOFF S CUTOFF=$$FMADD^XLFDT(DT,-2)
 S PSOINACT=",11,12,13,14,15,"
 S RXP=+$G(^XTMP(NMSP,"LASTRX"))
 I $G(ACTION)="RE" D
 . F I=2:1:12,14 S BADRXCNT(14)=+$G(^XTMP(NMSP,I))
 S LASTCNT=+$G(BADRXCNT(14)),STOP=0
 F COUNTER=LASTCNT:1 S RXP=$O(^PSRX(RXP)) Q:'RXP  D  Q:STOP
 . S:'(COUNTER#10000) DT=$$DT^XLFDT()
 . S PATIENT=$P($G(^PSRX(RXP,0)),"^",2)
 . S DRUG=$P($G(^PSRX(RXP,0)),"^",6)
 . S STATUS=$P($G(^PSRX(RXP,"STA")),"^")
 . S ISSUEDT=$P($G(^PSRX(RXP,0)),"^",13)
 . S DAYSSUP=$P($G(^PSRX(RXP,0)),"^",8)
 . S NUMREFS=$P($G(^PSRX(RXP,0)),"^",9)
 . S EXPIRDT=$P($G(^PSRX(RXP,2)),"^",6)
 . S BADRXCNT(14)=$G(BADRXCNT(14))+1
 . S BADRXCNT("LASTRX")=RXP_"^"_COUNTER
 . ;--- SKIP bad Rx's
 . I ('PATIENT!'DRUG) Q
 . I '$D(^DPT(PATIENT))!('$D(^PSDRUG(DRUG))) Q
 . I 'ISSUEDT Q
 . ;--- 
 . D SET
 . ;---
 . I '(COUNTER#5000) D
 . . M ^XTMP(NMSP)=BADRXCNT
 . . I $G(^XTMP(NMSP,"STOP")) S STOP=1
 ;
 I STOP D STOP G QUIT
 ;
 M ^XTMP(NMSP)=BADRXCNT
 S ^XTMP(NMSP,"COMPLETED")=$$NOW^XLFDT()
 K ^XTMP(NMSP,"LASTRX")
 D LOG^PSO293P1("COMPLETED")
 D MAIL^PSO293P1
 ;
QUIT ;
 L -^XTMP(NMSP)
 Q
 ;
STOP ;
 K ^XTMP(NMSP,"STOP")
 S ^XTMP(NMSP,"STOPPED")=$$NOW^XLFDT()
 D LOG^PSO293P1("STOPPED")
 D MAIL^PSO293P1
 Q
 ;
SET ;
 N CPRSDC,CPRSTA,NEWEXPDT,DA,DIE,ORN,DR
 S CPRSDC=",1,7,12,13,"
 ;
 ; --- No expiration date on PRESCRIPTION file (#52)
 I EXPIRDT="" D  Q
 . S ORN=$$CPRSNUM(RXP),CPRSTA=$P(ORN,"^",2),ORN=+ORN
 . D SETEXP^PSO293P1 I '$G(EXPIRDT) Q
 . I EXPIRDT>CUTOFF D  Q                 ; Expiration Date past Cutoff (will be exp. by auto exp. job), Quit
 . . S BADRXCNT(2)=$G(BADRXCNT(2))+1,^XTMP(NMSP,2,RXP)=""
 . . D SENDHDR
 . I PSOINACT'[(","_STATUS_",") D        ; Foce expiration of Rx (Past Exp. Date)
 . . S DA=RXP,DIE=52,DR="100///11",STATUS=11
 . . D ^DIE K DIE,DR
 . . D RXACT^PSOBPSU2(RXP,0,"Rx status set to EXPIRED by PSO*7*293","E",PSODUZ)
 . I ORN D  Q                            ; Rx is expired in CPRS (Update HDR with Exp. Date), Quit 
 . . I CPRSDC'[(","_CPRSTA_","),'$D(^PS(52.41,"AQ",RXP)) D  Q
 . . . S BADRXCNT(3)=$G(BADRXCNT(3))+1,^XTMP(NMSP,3,RXP)=""
 . . . D SENDCPRS()
 . . S BADRXCNT(4)=$G(BADRXCNT(4))+1,^XTMP(NMSP,4,RXP)=""
 . . D SENDHDR
 . I 'ORN D                              ; No CPRS Order # (Update HDR with Exp. Date)
 . . S BADRXCNT(5)=$G(BADRXCNT(5))+1,^XTMP(NMSP,5,RXP)=""
 . . D SENDHDR
 ;
 ; --- Rx is expired. Update CPRS and HDR if necessary
 I STATUS=11 D  Q
 . S ORN=$$CPRSNUM(RXP),CPRSTA=$P(ORN,"^",2),ORN=+ORN
 . S NEWEXPDT=0
 . I $$FMDIFF^XLFDT(EXPIRDT,ISSUEDT,1)>366 D  ; Expiration Date is > 366, Recalculate new Date
 . . S NEWEXPDT=1 D SETEXP^PSO293P1
 . I ORN,CPRSDC'[(","_CPRSTA_","),'$D(^PS(52.41,"AQ",RXP)) D  ; Rx is not expired in CPRS (Update CPRS/HDR with Exp. Date), Quit
 . . I 'NEWEXPDT S BADRXCNT(6)=$G(BADRXCNT(6))+1,^XTMP(NMSP,6,RXP)=""
 . . I NEWEXPDT S BADRXCNT(7)=$G(BADRXCNT(7))+1,^XTMP(NMSP,7,RXP)=""
 . . D SENDCPRS()
 . I 'NEWEXPDT Q                              ; Expiration Date was not recalculated, don't send to HDR
 . S BADRXCNT(8)=$G(BADRXCNT(8))+1,^XTMP(NMSP,8,RXP)=""
 . D SENDHDR
 ;
 I EXPIRDT<CUTOFF,(PSOINACT'[(","_STATUS_",")) D  ; Rx is past exp. date but is still on a non-Expired/DC'd status
 . S DA=RXP                                       ; Note: Rx's expiring on or after the CUTOFF will be picked up
 . S DIE=52,DR="100///11",STATUS=11               ;       by the Auto Expiration Job.
 . D ^DIE K DIE,DR
 . D RXACT^PSOBPSU2(RXP,0,"Rx status set to EXPIRED by PSO*7*293","E",PSODUZ)
 . S ORN=$$CPRSNUM(RXP),CPRSTA=$P(ORN,"^",2),ORN=+ORN
 . I ORN,CPRSDC'[(","_CPRSTA_",") D  Q            ; Update CPRS if necessary, this will also call HDR
 . . S BADRXCNT(9)=$G(BADRXCNT(9))+1,^XTMP(NMSP,9,RXP)=""
 . . D SENDCPRS()
 . I ORN D  Q                                     ; If CPRS was not updated, call HDR if there is an Order #
 . . S BADRXCNT(10)=$G(BADRXCNT(10))+1,^XTMP(NMSP,10,RXP)=""
 . . D SENDHDR
 . I 'ORN D                                       ; If no CPRS Order #, just report (no updates to CPRS/HDR)
 . . S BADRXCNT(11)=$G(BADRXCNT(11))+1
 . . S ^XTMP(NMSP,11,RXP)=""
 ;
 I STATUS=13 D  Q
 . S ORN=+$$CPRSNUM(RXP)
 . I 'ORN D
 . . S BADRXCNT(12)=$G(BADRXCNT(12))+1,^XTMP(NMSP,12,RXP)=""
 . . D SENDHDR
 Q
 ;
CPRSNUM(RXP) ;
 N ORN,STA
 S ORN=$P($G(^PSRX(RXP,"OR1")),"^",2),STA=""
 I ORN S STA=+$$STATUS^ORQOR2(ORN) I STA=0 S ORN=""
 Q (ORN_"^"_STA)
 ;
SETXTMP ; - Initialize the XTMP global
 I $D(^XTMP(NMSP,"STARTED")) D
 . S ^XTMP(NMSP,"RE-STARTED")=$$NOW^XLFDT() D LOG^PSO293P1("RESUMED")
 I '$D(^XTMP(NMSP,"STARTED")) D
 . S ^XTMP(NMSP,"STARTED")=$$NOW^XLFDT() D LOG^PSO293P1("STARTED")
 K ^XTMP(NMSP,"STOP"),^XTMP(NMSP,"STOPPED")
 S ^XTMP(NMSP,0)=$$FMADD^XLFDT($$NOW^XLFDT(),730)_"^"_$$NOW^XLFDT()_"^PSO*7*293 - RX EXPIRATION DATE CLEAN UP"
 Q
 ;
SENDCPRS(CPRSONLY) ; Update CPRS/HDR
 N PSOSSMES,TYPE,STS,STSCOM
 S:$G(CPRSONLY) PSOSSMES="CPRSUP"
 ;
 S TYPE="SC",STS="DC",STSCOM="Discontinued"
 I STATUS=11 S $P(^PSRX(RXP,0),"^",19)=1,STS="ZE",STSCOM="Expired"
 I STATUS=13 S TYPE="OC",STS="",STSCOM="Deleted"
 I STATUS=14 S TYPE="OD",STS="RP",STSCOM="Discontinued/Edited"
 D EN^PSOHLSN1(RXP,TYPE,STS,"Prescription is "_STSCOM_".")
 Q
 ;
SENDHDR ; Update HDR only
 D:$G(PSOPROD) EN^PSOHDR("PRES",RXP)
 Q
