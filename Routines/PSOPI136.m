PSOPI136 ;BHM/MFR,BI - Patient Merge Clean-up ;07/10/03
 ;;7.0;OUTPATIENT PHARMACY;**136**;DEC 1997
 ;
 ;External reference to ^OR(100 supported by DBIA 3582
 ;External reference to ^OR(100 supported by DBIA 3463
 ;External reference to ^PS(55 supported by DBIA 2228
 ;External reference to GET1^DIQ supported by DBIA 2056
 ;External reference to DPT(OLDDFN,-9) supported by DBIA 2762
 ;External reference to ^XMD supported by DBIA 10070
 ;
 I $G(XPDENV)'=1 W !,"The Environment Check Routine is designed",!,"to run during the installation step only.",! Q
 W !,"This patch queues a job to perform Patient Merge Clean-up",!
REPEAT W "It should be queued to run when there are no users processing outpatient prescriptions."
 S %DT="AR",%DT("A")="ENTER QUEUE DATE@TIME: ",%DT("B")="T@2000" D ^%DT
 I $G(DTOUT) S XPDQUIT=2 W !,"The program did not run, the patch will not install.",! G OUT
 I Y=-1 S XPDQUIT=2 W !,"The program did not run, the patch will not install..",! G OUT
 D NOW^%DTC I Y'>% W !,"MUST BE IN THE FUTURE",! H 3 G REPEAT
 S X=Y D H^%DTC S Y=%H_","_%T
 W ! S ZTDTH=Y S ZTRTN="EN^PSOPI136",ZTDESC="Pharmacy Patient Merge Clean-up",ZTIO="",ZTSAVE("XPDQUIT")="" D ^%ZTLOAD
 W !!,"JOB QUEUED AS ",$G(ZTSK),".",!
OUT K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR
 K X,Y,%DT
 Q
 ;
EN N OLDDFN,NEWDFN,RXCNT,STCNT,%,X1,X2,X,RUNCNT
 ;
 L +^XTMP("PSOPI136"):0 I '$T W "Job is already running",! G END
 ;
 S X1=DT,X2=90 D C^%DTC S ^XTMP("PSOPI136",0)=$G(X)_"^"_DT_"^Pharmacy Patient Merge Clean-up, Run by DUZ: "_DUZ
 S ^XTMP("PSOPI136",0,0)=$G(^XTMP("PSOPI136",0,0))+1,RUNCNT=^XTMP("PSOPI136",0,0)
 ;                                                    
 D NOW^%DTC S ^XTMP("PSOPI136",RUNCNT,"START")=%
 S (RXCNT,STCNT)=0
 S OLDDFN=0 F  S OLDDFN=$O(^DPT(OLDDFN)) Q:'OLDDFN  D
 . I '$D(^DPT(OLDDFN,-9)) Q                          ;Patient not merged
 . S NEWDFN=+^DPT(OLDDFN,-9) I '$D(^DPT(NEWDFN,0)) Q
 . D FIX(OLDDFN,NEWDFN)
 D NOW^%DTC S ^XTMP("PSOPI136",RUNCNT,"FINISH")=%
 D MAIL
 ;
 L -^XTMP("PSOPI136")
 ;
END Q
 ;
FIX(OLDDFN,NEWDFN) ; Fix problems caused by Patient Merge
 N DIE,DA,DR,EXPDT,RXIEN,ORIEN,RXST,ORST,RXSTN,ORSTN,COMM
 ;
 S EXPDT=0 F  S EXPDT=$O(^PS(55,NEWDFN,"P","A",EXPDT)) Q:'EXPDT  D
 . S RXIEN=0 F  S RXIEN=$O(^PS(55,NEWDFN,"P","A",EXPDT,RXIEN)) Q:'RXIEN  D
 . . I '$D(^PSRX(RXIEN,0)) Q
 . . I $P($G(^PSRX(RXIEN,0)),"^",2)=NEWDFN Q
 . . S DIE=52,DA=RXIEN,DR="2///"_NEWDFN D ^DIE S RXCNT=$G(RXCNT)+1
 . . S ORIEN=$P($G(^PSRX(RXIEN,"OR1")),"^",2) Q:'ORIEN
 . . S RXST=+$G(^PSRX(RXIEN,"STA"))
 . . S RXSTN=$$GET1^DIQ(52,RXIEN,100),ORSTN=$$GET1^DIQ(100,ORIEN,5)
 . . I '$D(^XTMP("PSOPI136",RUNCNT,RXIEN)) D
 . . . S ^XTMP("PSOPI136",RUNCNT,RXIEN)=OLDDFN_"^"_NEWDFN_"^"_RXSTN_"^"_ORSTN_"^^"_$H
 . . I $E(RXSTN,1,10)=$E(ORSTN,1,10) Q
 . . I RXST'=11,RXST'=12,RXST'=14,RXST'=15 Q
 . . S STCNT=$G(STCNT)+1
 . . I RXST=11 D EXP S $P(^XTMP("PSOPI136",RUNCNT,RXIEN),"^",5)="EXPIRED" Q
 . . D DSC S $P(^XTMP("PSOPI136",RUNCNT,RXIEN),"^",5)="DISCONTINUED"
 ;
 Q
 ;
EXP ; Sets CPRS order status to EXPIRED
 I $P(^PSRX(RXIEN,0),"^",19)=2 S $P(^PSRX(RXIEN,0),"^",19)=1
 S COMM="Prescription past expiration date"
 D EN^PSOHLSN1(RXIEN,"SC","ZE",COMM)
 I $D(^OR(100,ORIEN,3)) S $P(^OR(100,ORIEN,3),"^")=EXPDT
 Q
 ;
DSC ; Sets CPRS order status to DISCONTINUED
 N ACTLOG,LSTACT,PHARM,ACTDT,RSN,ACT0,ACTCOM,SAVEDUZ,NACT
 ;
 S (ACTLOG,LSTACT,PHARM,ACTDT)=0
 F  S ACTLOG=$O(^PSRX(RXIEN,"A",ACTLOG)) Q:'ACTLOG  D
 . S RSN=$P($G(^PSRX(RXIEN,"A",ACTLOG,0)),"^",2)
 . I RSN="C"!(RSN="L") S LSTACT=ACTLOG
 I 'LSTACT S COMM="Discontinued by Pharmacy",NACT=""
 I LSTACT S ACT0=$G(^PSRX(RXIEN,"A",LSTACT,0)) D
 . S PHARM=$P(ACT0,"^",3),ACTCOM=$P(ACT0,"^",5)
 . S ACTDT=$P(ACT0,"^"),(NACT,COMM)=""
 . I ACTCOM["Renewed" D
 . . S COMM="Renewed by Pharmacy"
 . I ACTCOM["Auto Discontinued" D
 . . S PHARM="",NACT="A",COMM=$E($P(ACTCOM,".",2),2,99)
 . . S:COMM="" COMM=ACTCOM
 . I ACTCOM["Discontinued During" D
 . . S COMM="Discontinued by Pharmacy"
 S SAVEDUZ=$G(DUZ) S:$G(PHARM) DUZ=PHARM
 D EN^PSOHLSN1(RXIEN,"OD",$S(RXST=15:"RP",1:""),COMM,NACT)
 S DUZ=SAVEDUZ W "."
 I '$G(ACTDT) S ACTDT=DT_".2200"
 I $D(^OR(100,ORIEN,3)) S $P(^OR(100,ORIEN,3),"^")=$E(ACTDT,1,12)
 I $D(^OR(100,ORIEN,6)) S $P(^OR(100,ORIEN,6),"^",3)=$E(ACTDT,1,12)
 ;
 Q
MAIL ; Send mail about the Clean-up
 N CNT,DASH,START,FINISH,%,X,Y,XMDUZ,XMSUB,XMTEXT,DIFROM
 ;
 K ^TMP("PSO",$J)
 S Y=$G(^XTMP("PSOPI136",RUNCNT,"START")) D DD^%DT S START=Y
 S Y=$G(^XTMP("PSOPI136",RUNCNT,"FINISH")) D DD^%DT S FINISH=Y
 S XMDUZ="Patch PSO*7*136",XMY(DUZ)=""
 S XMSUB="PSO*7*136 PRESCRIPTION file (#52) - Patient Merge clean up"
 S CNT=0,$P(DASH,"-",79)=""
 S CNT=CNT+1,^TMP("PSO",$J,CNT)="Patch PSO*7*136 PRESCRIPTION file (#52) clean-up is complete."
 S CNT=CNT+1,^TMP("PSO",$J,CNT)="It started on "_$G(START)_"."
 S CNT=CNT+1,^TMP("PSO",$J,CNT)="It ended on "_$G(FINISH)_"."
 S CNT=CNT+1,^TMP("PSO",$J,CNT)=" "
 S CNT=CNT+1,^TMP("PSO",$J,CNT)=DASH
 S CNT=CNT+1,^TMP("PSO",$J,CNT)=DASH
 S CNT=CNT+1,^TMP("PSO",$J,CNT)="NEW PATIENT NAME"
 S X="RX",$E(X,14)="OLD PATIENT",$E(X,27)="NEW PATIENT"
 S $E(X,40)="PHARM STATUS",$E(X,54)="CPRS STATUS"
 S $E(X,68)="NEW CPRS ST"
 S CNT=CNT+1,^TMP("PSO",$J,CNT)=X
 S CNT=CNT+1,^TMP("PSO",$J,CNT)=DASH
 S DA=0 F  S DA=$O(^XTMP("PSOPI136",RUNCNT,DA)) Q:'DA  D
 . S Z=$G(^XTMP("PSOPI136",RUNCNT,DA))
 . S CNT=CNT+1,^TMP("PSO",$J,CNT)=$$GET1^DIQ(2,$P(Z,"^",2)_",",.01)
 . S X=$P($G(^PSRX(DA,0)),"^"),$E(X,14)=$J($P(Z,"^"),11)
 . S $E(X,27)=$J($P(Z,"^",2),11),$E(X,40)=$E($P(Z,"^",3),1,12)
 . S $E(X,54)=$E($P(Z,"^",4),1,12),$E(X,68)=$E($P(Z,"^",5),1,11)
 . S CNT=CNT+1,^TMP("PSO",$J,CNT)=X
 . S CNT=CNT+1,^TMP("PSO",$J,CNT)=DASH
 S CNT=CNT+1,^TMP("PSO",$J,CNT)=" "
 S CNT=CNT+1,^TMP("PSO",$J,CNT)=+$G(RXCNT)_" prescriptions had the wrong Patient IEN and have been fixed."
 S CNT=CNT+1,^TMP("PSO",$J,CNT)=+$G(STCNT)_" prescriptions had their status in CPRS adjusted to match Pharmacy."
 S ^TMP("PSO",$J,CNT+1)=" "
 S XMTEXT="^TMP(""PSO"",$J," D ^XMD
 K ^TMP("PSO",$J)
 Q
