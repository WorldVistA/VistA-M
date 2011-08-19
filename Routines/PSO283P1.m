PSO283P1 ;BIR/MFR-EXPIRATION DATE PROBLEM TALLY (Cont.) ;05/03/07
 ;;7.0;OUTPATIENT PHARMACY;**283**;DEC 1997;Build 28
 ;External reference to ^PS(59.7 is supported by DBIA 694
 ;
MAIL ;
 N PSOTX,XMY,XMDUZ,XMSUB,XMTEXT,DIFROM
 S XMY($S($G(PSODUZ):PSODUZ,1:+$G(DUZ)))=""
 S XMDUZ=.5
 S XMSUB="Patch PSO*7*283 - Rx EXPIRATION DATE PROBLEM TALLY"
 S XMY("RUZBACKI.RON@FORUM.VA.GOV")=""
 S XMY("ANWER.MOHAMED@FORUM.VA.GOV")=""
 S XMY("WILLIAMSON.ERIC@FORUM.VA.GOV")=""
 S XMY("WILLETTE.CANDY@FORUM.VA.GOV")=""
 S XMY("ROCHA.MARCELO@FORUM.VA.GOV")=""
 S XMY("BARRON.LUANNE@FORUM.VA.GOV")=""
 S XMY("JONES.TRES@FORUM.VA.GOV")=""
 D SETTXT
 ;
 S XMTEXT="PSOTX(" D ^XMD
 Q
 ;
DISPLAY ; Displays the current results
 N PSOINST,J,DIR,PSOTX,DIR
 S PSOINST=$P($$SITE^VASITE(),"^",2)_" ("_+$$SITE^VASITE()_")"
 D SETTXT W !
 F J=1:1 Q:'$D(PSOTX(J))  D
 . W !,PSOTX(J)
 . I '(J#19) K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR
 Q
 ;
SETTXT ; Set the PSOTXT array with the Mailman message or screen display
 N EXCEL,J,Z,LINE,JOBSTS,STS,LOGLN,NMSP
 S LINE=0,NMSP="PSO283PI"
 D SETLN("Expiration Date problem tally patch for Outpatient Pharmacy prescriptions")
 D SETLN("=========================================================================")
 S JOBSTS=$$JOBSTS()
 S:JOBSTS="N" STS="NEVER RUN"
 S:JOBSTS="S" STS="STOPPED ON "_$$FMTE^XLFDT($G(^XTMP(NMSP,"STOPPED")))
 S:JOBSTS="R" STS="RUNNING"
 S:JOBSTS="C" STS="COMPLETED ON "_$$FMTE^XLFDT($G(^XTMP(NMSP,"COMPLETED")))
 S:$G(^XTMP(NMSP,"LASTRX")) STS=STS_" (Last Rx IEN: "_$G(^XTMP(NMSP,"LASTRX"))_")"
 D SETLN("Current status: "_STS)
 D SETLN(" ")
 D SETLN("1. Institution   : "_PSOINST)
 D SETLN("                                                                 PATIENTS")
 D SETLN("Group 1: RX'S WITH NO EXPIRATION DATE                     WITH ICN#   W/NO ICN#")
 D SETLN("-------------------------------------                    ----------  ----------")
 D SETLN("2.  Calc exp date > CUTOFF (update HDR)                  "_$$TOT(2)_"  "_$$TOT(102))
 D SETLN("3.  Calc exp date < CUTOFF,CPRS active (update HDR/CPRS) "_$$TOT(3)_"  "_$$TOT(103))
 D SETLN("4.  Calc exp date < CUTOFF,CPRS non-active (update HDR)  "_$$TOT(4)_"  "_$$TOT(104))
 D SETLN("5.  No CPRS order# (Update HDR)                          "_$$TOT(5)_"  "_$$TOT(105))
 D SETLN(" ")
 D SETLN("Group 2: RX'S IN EXPIRED STATUS")
 D SETLN("-------------------------------")
 D SETLN("6.  CPRS active (update CPRS/HDR)                        "_$$TOT(6)_"  "_$$TOT(106))
 D SETLN("7.  Exp>366 days,reset date,CPRS order# (update CPRS/HDR)"_$$TOT(7)_"  "_$$TOT(107))
 D SETLN("8.  Exp>366 days,reset date,no CPRS order# (update HDR)  "_$$TOT(8)_"  "_$$TOT(108))
 D SETLN(" ")
 D SETLN("Group 3: RX'S PAST EXPIRATION DATE BUT STILL ACTIVE")
 D SETLN("---------------------------------------------------")
 D SETLN("9.  CPRS active (update CPRS/HDR)                        "_$$TOT(9)_"  "_$$TOT(109))
 D SETLN("10. CPRS DC'd or expired (update HDR)                    "_$$TOT(10)_"  "_$$TOT(110))
 D SETLN("11. No CPRS order# (HDR will run own update)             "_$$TOT(11)_"  "_$$TOT(111))
 D SETLN(" ")
 D SETLN("Group 4: RX's IN DELETED STATUS")
 D SETLN("-------------------------------")
 D SETLN("12. No CPRS order# (update HDR)                          "_$$TOT(12)_"  "_$$TOT(112))
 D SETLN(" ")
 D SETLN("OTHER")
 D SETLN("-----")
 D SETLN("13. BAD RX's: NO PATIENT,DRUG or ISSUE DT (NO UPDATES):         "_$$TOT(13))
 D SETLN(" ")
 D SETLN("14. TOTAL NUMBER OF PRESCRIPTIONS ANALYZED: "_$$TOT(14))
 D SETLN(" ")
 D SETLN("Up-arrow ('^') separated values (patients WITH ICN#):")
 S EXCEL=PSOINST F J=2:1:14 S EXCEL=EXCEL_"^"_+$G(^XTMP(NMSP,J))
 D SETLN(EXCEL)
 D SETLN(" ")
 D SETLN("Up-arrow ('^') separated values (patients WITHOUT ICN#):")
 S EXCEL=PSOINST F J=102:1:112 S EXCEL=EXCEL_"^"_+$G(^XTMP(NMSP,J))
 D SETLN(EXCEL_"^"_+$G(^XTMP(NMSP,13))_"^"_+$G(^XTMP(NMSP,14)))
 D SETLN(" ")
 D SETLN("Run Log:")
 D SETLN("------------------------------------------------------------------------------")
 D SETLN("SEQ DATE/TIME         INITIATOR                  ACTION")
 D SETLN("------------------------------------------------------------------------------")
 I '$D(^XTMP(NMSP,"LOG")) D SETLN("No entries.")
 F J=1:1 Q:'$D(^XTMP(NMSP,"LOG",J))  D
 . S Z=^XTMP(NMSP,"LOG",J)
 . S LOGLN=$J(J,3),$E(LOGLN,5)=$$FMTE^XLFDT(+Z,2)
 . S $E(LOGLN,23)=$E($$GET1^DIQ(200,$P(Z,"^",2),.01),1,25),$E(LOGLN,50)=$P(Z,"^",3)
 . D SETLN(LOGLN)
 D SETLN("<END>")
 Q
 ;
SETLN(TEXT) ; Add a new line to the mailman message text
 S LINE=$G(LINE)+1,PSOTX(LINE)=TEXT
 Q
 ;
TOT(FLD) ; returns the field to be displayed
 Q $J($FNUMBER(+$G(^XTMP(NMSP,FLD)),","),10)
 ;
JOB(ZTDTH) ; Queue the job to run
 N ZTRTN,ZTIO,ZTDESC,ZTSK,PSODUZ,ZTSAVE
 S ZTRTN="EN^PSO283PI",ZTIO=""
 S ZTDESC="Patch PSO*7*283 - Rx Expiration Date problem tally job (run >D ^PSO283PI)"
 L -^XTMP(NMSP)
 S PSODUZ=DUZ,ZTSAVE("PSODUZ")=""
 D ^%ZTLOAD
 I $D(ZTSK) D
 . D LOG("QUEUED")
 . H 2 D MES^XPDUTL("*** Task #"_ZTSK_" Queued! ***")
 . D BMES^XPDUTL("")
 . H 1
 K XPDQUES
 Q
 ;
JOBSTS() ; Returns the current job status
 L +^XTMP(NMSP):0 E  Q "R"
 L -^XTMP(NMSP)
 I '$D(^XTMP(NMSP,"STARTED")) Q "N"
 I $G(^XTMP(NMSP,"COMPLETED")) Q "C"
 Q "S"
 ;
CALCEXP ; CALCULATE THE EXPIRATION DATE
 N X,%DT,X1,X2,PSOARR,PSDEA,PSOCS,DA,QQ
 K PSOARR D GETS^DIQ(50,DRUG_",","3","I","PSOARR")
 S PSDEA=$G(PSOARR(50,DRUG_",",3,"I"))
 S X1=ISSUEDT,X2=DAYSSUP*(NUMREFS+1)\1
 S PSOCS=0
 F QQ=1:1 Q:$E(PSDEA,QQ)=""  I $E(+PSDEA,QQ)>1,$E(+PSDEA,QQ)<6 D  I PSOCS Q
 . S PSOCS=1
 S X2=$S(DAYSSUP=X2:X2,+$G(PSOCS):184,1:366)
 D C^%DTC S EXPIRDT=$P(X,".")
 Q
 ;
LOG(COMMENT) ;  Running Log
 N LOGCNT
 S LOGCNT=+$O(^XTMP(NMSP,"LOG",""),-1)+1
 S ^XTMP(NMSP,"LOG",LOGCNT)=$$NOW^XLFDT()_"^"_$S($G(PSODUZ):PSODUZ,1:+$G(DUZ))_"^"_COMMENT
 Q
