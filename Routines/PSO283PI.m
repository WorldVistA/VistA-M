PSO283PI ;BIR/MFR-EXPIRATION DATE PROBLEM TALLY ;05/03/07
 ;;7.0;OUTPATIENT PHARMACY;**283**;DEC 1997;Build 28
 ;External references ^DPT supported by DBIA 10035
 ;External reference to STATUS^ORQOR2 is supported by DBIA 3458
 ;External reference to ^PS(59.7 is supported by DBIA 694
 N NMSP,JOBSTS,DIR,DIRUT,DIROUT,DTOUT,DUOUT,Y,ACTION,EXPJOBDT,PSODUZ
 S NMSP="PSO283PI"
 ;
 S JOBSTS=$$JOBSTS^PSO283P1()
 ;
 W !?5,"Expiration Date problem tally patch for Outpatient Pharmacy prescriptions"
 W !?5,"========================================================================="
 W !?5,"Current status: "
 W:JOBSTS="N" "NEVER RUN"
 W:JOBSTS="S" "STOPPED ON "_$$FMTE^XLFDT($G(^XTMP(NMSP,"STOPPED")))
 W:JOBSTS="R" "RUNNING"
 W:JOBSTS="C" "COMPLETED ON "_$$FMTE^XLFDT($G(^XTMP(NMSP,"COMPLETED")))
 W:$G(^XTMP(NMSP,"LASTRX")) " (Last Rx IEN: "_$G(^XTMP(NMSP,"LASTRX"))_")"
 ;
 S DIR(0)="SO^",DIR("A")=""
 I JOBSTS="N" D
 .S DIR(0)=DIR(0)_"ST:START TALLY JOB;",DIR("A")=DIR("A")_"(ST)Start,",DIR("B")="START"
 I JOBSTS="S" D
 . S DIR(0)=DIR(0)_"RE:RESUME TALLY JOB;",DIR("A")=DIR("A")_"(RE)Resume,"
 I JOBSTS="R" D
 . S DIR(0)=DIR(0)_"SP:STOP TALLY JOB;",DIR("A")=DIR("A")_"(SP)Stop,"
 I JOBSTS="C" D
 . S DIR(0)=DIR(0)_"RR:RE-RUN TALLY JOB;",DIR("A")=DIR("A")_"(RR)Re-run,"
 S DIR(0)=DIR(0)_"VW:VIEW "_$S(JOBSTS'="C":"PARTIAL ",1:"")_"TALLY JOB RESULTS;"
 S DIR("A")=DIR("A")_"(VW)View,",DIR("B")="VIEW"
 S DIR(0)=DIR(0)_"QT:QUIT",DIR("A")=DIR("A")_"(QT)Quit"
 D ^DIR I $D(DIRUT)!$D(DIROUT)!$D(DTOUT)!$D(DUOUT) G QUIT
 S ACTION=Y
 ;
 I ACTION="SP" W !!,"Stopping..." D  G QUIT
 . N TIME,UNABLE
 . S ^XTMP(NMSP,"STOP")=1,(TIME,UNABLE)=0
 . F  Q:$D(^XTMP(NMSP,"STOPPED"))  D  Q:UNABLE
 . . H 1 S TIME=TIME+1 I $D(^XTMP(NMSP,"COMPLETED"))!($$JOBSTS^PSO283P1()'="R")!(TIME>30) S UNABLE=1
 . W $S(UNABLE:"NOT OK (may no longer be running)",1:"OK")
 . K ^XTMP(NMSP,"STOP")
 ;
 I ACTION="QT" G QUIT
 I ACTION="VW" D DISPLAY^PSO283P1 G QUIT
 I ACTION="RR" K ^XTMP(NMSP)
 ;
 D JOB^PSO283P1()
 Q
 ;
PI ; Post-Install entry point
 N EXPJOBDT,NMSP
 S NMSP="PSO283PI" K ^XTMP(NMSP)
 D LOG^PSO283P1("PATCH INSTALLATION")
 D JOB^PSO283P1($$NOW^XLFDT())
 Q
 ;
EN ;
 N NMSP,PSOINST,CUTOFF,PSOACT,RXP,STOP,PSOINACT,PATIENT,COUNTER,RXP,PATICN,DRUG,STATUS
 N ISSUEDT,EXPIRDT,BADRXCNT,DAYSSUP,NUMREFS
 ;
 S NMSP="PSO283PI" I '$G(PSODUZ) S PSODUZ=+$G(DUZ)
 ;
 ; - If can't get Lock, then already running.
 L +^XTMP(NMSP):5 I '$T D LOG^PSO283P1("UNSUCCESSFUL (LOCKED)") G QUIT
 ;
 D SETXTMP
 ;
 I '$G(DT) S DT=$$DT^XLFDT
 ;
 S PSOINST=$P($$SITE^VASITE(),"^",2)_" ("_+$$SITE^VASITE()_")"
 S CUTOFF=$$FMADD^XLFDT(DT,-2)
 S PSOINACT=",11,12,13,14,15,"
 S RXP=+$G(^XTMP(NMSP,0,"LASTRX")),STOP=0
 F COUNTER=1:1 S RXP=$O(^PSRX(RXP)) Q:'RXP  D  Q:STOP
 . S:'(COUNTER#100000) DT=$$DT^XLFDT()
 . S PATIENT=$P($G(^PSRX(RXP,0)),"^",2)
 . S PATICN=$P($$GETICN^MPIF001(PATIENT),"^")
 . S DRUG=$P($G(^PSRX(RXP,0)),"^",6)
 . S STATUS=$P($G(^PSRX(RXP,"STA")),"^")
 . S ISSUEDT=$P($G(^PSRX(RXP,0)),"^",13)
 . S DAYSSUP=$P($G(^PSRX(RXP,0)),"^",8)
 . S NUMREFS=$P($G(^PSRX(RXP,0)),"^",9)
 . S EXPIRDT=$P($G(^PSRX(RXP,2)),"^",6)
 . S BADRXCNT(14)=$G(BADRXCNT(14))+1
 . S BADRXCNT("LASTRX")=RXP
 . ;--- eliminate bad Rx's
 . I ('PATIENT!'DRUG) S BADRXCNT(13)=$G(BADRXCNT(13))+1 Q
 . I '$D(^DPT(PATIENT))!('$D(^PSDRUG(DRUG))) S BADRXCNT(13)=$G(BADRXCNT(13))+1 Q
 . I 'ISSUEDT S BADRXCNT(13)=$G(BADRXCNT(13))+1 Q
 . ;--- 
 . D SET
 . ;---
 . I '(COUNTER#10000) D
 . . M ^XTMP(NMSP)=BADRXCNT
 . . I $G(^XTMP(NMSP,"STOP")) S STOP=1
 ;
 I STOP D STOP G QUIT
 ;
 M ^XTMP(NMSP)=BADRXCNT
 S ^XTMP(NMSP,"COMPLETED")=$$NOW^XLFDT()
 K ^XTMP(NMSP,"LASTRX")
 D LOG^PSO283P1("COMPLETED")
 D MAIL^PSO283P1
 ;
QUIT ;
 L -^XTMP(NMSP)
 Q
 ;
STOP ;
 K ^XTMP(NMSP,"STOP")
 S ^XTMP(NMSP,"STOPPED")=$$NOW^XLFDT()
 D LOG^PSO283P1("STOPPED")
 D MAIL^PSO283P1
 Q
 ;
SET ;
 N CPRSDC,CPRSTA,NEWEXPDT,DA,DIE,ORN,DR
 S CPRSDC=",1,7,12,13,"
 ;
 ; --- No expiration date on PRESCRIPTION file (#52)
 I EXPIRDT="" D  Q
 . S ORN=$$CPRSNUM(RXP),CPRSTA=$P(ORN,"^",2),ORN=+ORN
 . D CALCEXP^PSO283P1 I '$G(EXPIRDT) Q
 . I EXPIRDT>CUTOFF D  Q                 ; Expiration Date past Cutoff (will be exp. by auto exp. job), Quit
 . . I PATICN=-1 D  Q                    ; NO ICN# - DO NOT send it to HDR
 . . . S BADRXCNT(102)=$G(BADRXCNT(102))+1
 . . . S ^XTMP(NMSP,102,RXP,"HDR")=""
 . . S BADRXCNT(2)=$G(BADRXCNT(2))+1,^XTMP(NMSP,2,RXP)=""
 . I ORN D  Q                            ; Rx is expired in CPRS (Update HDR with Exp. Date), Quit 
 . . I PATICN=-1 D  Q                    ; NO ICN# - DO NOT send it to HDR
 . . . I CPRSDC'[(","_CPRSTA_",") D
 . . . . S ^XTMP(NMSP,103,RXP,"HDR")="",BADRXCNT(103)=$G(BADRXCNT(103))+1
 . . . I CPRSDC[(","_CPRSTA_",") D
 . . . . S ^XTMP(NMSP,104,RXP,"HDR")="",BADRXCNT(104)=$G(BADRXCNT(104))+1
 . . I CPRSDC'[(","_CPRSTA_",") D  Q
 . . . S BADRXCNT(3)=$G(BADRXCNT(3))+1,^XTMP(NMSP,3,RXP)=""
 . . S BADRXCNT(4)=$G(BADRXCNT(4))+1,^XTMP(NMSP,4,RXP)=""
 . I 'ORN D                              ; No CPRS Order # (Update HDR with Exp. Date)
 . . I PATICN=-1 D  Q                    ; NO ICN# - DO NOT send it to HDR
 . . . S BADRXCNT(105)=$G(BADRXCNT(105))+1
 . . . S ^XTMP(NMSP,105,RXP,"HDR")=""
 . . S BADRXCNT(5)=$G(BADRXCNT(5))+1,^XTMP(NMSP,5,RXP)=""
 ;
 ; --- Rx is expired. Update CPRS and HDR if necessary
 I STATUS=11 D  Q
 . S ORN=$$CPRSNUM(RXP),CPRSTA=$P(ORN,"^",2),ORN=+ORN
 . S NEWEXPDT=0
 . I $$FMDIFF^XLFDT(EXPIRDT,ISSUEDT,1)>366 D  ; Expiration Date is > 366, Recalculate new Date
 . . S NEWEXPDT=1 D CALCEXP^PSO283P1
 . I ORN,CPRSDC'[(","_CPRSTA_",") D           ; Rx is not expired in CPRS (Update CPRS/HDR with Exp. Date), Quit
 . . I PATICN=-1 D  Q                         ; NO ICN# - DO NOT send it to CPRS
 . . . I 'NEWEXPDT S BADRXCNT(106)=$G(BADRXCNT(106))+1,^XTMP(NMSP,106,RXP,"HDR")=""
 . . . I NEWEXPDT S BADRXCNT(107)=$G(BADRXCNT(107))+1,^XTMP(NMSP,107,RXP,"HDR")=""
 . . I 'NEWEXPDT S BADRXCNT(6)=$G(BADRXCNT(6))+1,^XTMP(NMSP,6,RXP)=""
 . . I NEWEXPDT S BADRXCNT(7)=$G(BADRXCNT(7))+1,^XTMP(NMSP,7,RXP)=""
 . I 'NEWEXPDT Q                              ; Expiration Date was not recalculated, don't send to HDR
 . I PATICN=-1 D  Q                           ; NO ICN# - DO NOT send it to HDR
 . . S BADRXCNT(108)=$G(BADRXCNT(108))+1
 . . S ^XTMP(NMSP,108,RXP,"HDR")=""
 . S BADRXCNT(8)=$G(BADRXCNT(8))+1,^XTMP(NMSP,8,RXP)=""
 ;
 I EXPIRDT<CUTOFF,(PSOINACT'[(","_STATUS_",")) D  ; Rx is past exp. date but is still on a non-Expired/DC'd status
 . S ORN=$$CPRSNUM(RXP),CPRSTA=$P(ORN,"^",2),ORN=+ORN
 . I ORN,CPRSDC'[(","_CPRSTA_",") D  Q            ; Update CPRS if necessary, this will also call HDR
 . . I PATICN=-1 D  Q                             ; NO ICN# - Send it to CPRS but not to HDR 
 . . . S BADRXCNT(109)=$G(BADRXCNT(109))+1
 . . . S ^XTMP(NMSP,109,RXP,"HDR")=""
 . . S BADRXCNT(9)=$G(BADRXCNT(9))+1,^XTMP(NMSP,9,RXP)=""
 . I ORN D  Q                                     ; If CPRS was not updated, call HDR if there is an Order #
 . . I PATICN=-1 D  Q                             ; NO ICN# - DO NOT send it to HDR
 . . . S BADRXCNT(110)=$G(BADRXCNT(110))+1
 . . . S ^XTMP(NMSP,110,RXP,"HDR")=""
 . . S BADRXCNT(10)=$G(BADRXCNT(10))+1,^XTMP(NMSP,10,RXP)=""
 . I 'ORN D                                       ; If no CPRS Order #, just report (no updates to CPRS/HDR)
 . . I PATICN=-1 D  Q                             ; NO ICN# - DO NOT send it to HDR
 . . . S BADRXCNT(111)=$G(BADRXCNT(111))+1
 . . . S ^XTMP(NMSP,111,RXP,"HDR")=""
 . . S BADRXCNT(11)=$G(BADRXCNT(11))+1
 . . S ^XTMP(NMSP,11,RXP)=""
 ;
 I STATUS=13 D  Q
 . S ORN=+$$CPRSNUM(RXP)
 . I 'ORN D
 . . I PATICN=-1 D  Q                             ; NO ICN# - DO NOT send it to HDR
 . . . S BADRXCNT(112)=$G(BADRXCNT(112))+1
 . . . S ^XTMP(NMSP,112,RXP,"HDR")=""
 . . S BADRXCNT(12)=$G(BADRXCNT(12))+1,^XTMP(NMSP,12,RXP)=""
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
 . S ^XTMP(NMSP,"RE-STARTED")=$$NOW^XLFDT() D LOG^PSO283P1("RE-STARTED")
 I '$D(^XTMP(NMSP,"STARTED")) D
 . S ^XTMP(NMSP,"STARTED")=$$NOW^XLFDT() D LOG^PSO283P1("STARTED")
 K ^XTMP(NMSP,"STOP"),^XTMP(NMSP,"STOPPED")
 S ^XTMP(NMSP,0)=$$FMADD^XLFDT($$NOW^XLFDT(),730)_"^"_$$NOW^XLFDT()_"^PSO*7*283 - RX EXPIRATION DATE PROBLEM TALLY"
 Q
