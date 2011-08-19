PSOCPBK2 ;BIR/EJW,GN-Tally Automated-release refill copay cont. ;8/10/05 12:03pm
 ;;7.0;OUTPATIENT PHARMACY;**215,303**;DEC 1997;Build 19
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External reference to ^IBAM(354.7 supported by DBIA 3877
 ;External reference to $$PROD^XUPROD(1) supported by DBIA 4440
 ;
TALLY ;
 ; IF NO IB NUMBER FOR THIS FILL, SET UP VARIABLES AND TALLY
 N PSOCAP,PSODIV,PSODV,PSOFILL,PSOLOG,PSOOUT,PSOPAR,PSOPATID,PSOSITE
 N PSOSITE7,PSOSQ,PSOTOT,PSOYEAR,PSOYR,SSN
 S PSODFN=0
 F QQ=1:1 S PSODFN=$O(^XTMP(NAMSP,PSODFN)) Q:'PSODFN  D  Q:STOP
 .I QQ#100=0,$D(^XTMP(NAMSP,0,"STOP")) K ^XTMP(NAMSP) S STOP=1
 .S (PSOCAP(304),PSOCAP(305))=0 ; INITIAL ANNUAL CAP FOR 2004 & 2005
 .F RXP=0:0 S RXP=$O(^XTMP(NAMSP,PSODFN,RXP)) Q:'RXP  D
 ..F YY=0:0 S YY=$O(^XTMP(NAMSP,PSODFN,RXP,YY)) Q:YY=""  D
 ...S PSOREL=$G(^XTMP(NAMSP,PSODFN,RXP,YY))
 ...I PSOCAP($E(PSOREL,1,3)) Q  ; MET ANNUAL CAP FOR 2004 OR 2005
 ...I $P($G(^PSRX(RXP,1,YY,"IB")),"^",1)="" D  ; REFILL LEVEL
 ....D SITE
 ....D CP
 Q
 ;
CP ; Entry point to Check if COPAY  -   Requires RXP,PSOSITE7
 I '$D(PSOPAR) D ^PSOLSET G CP
 K PSOCP
 S PSOCPN=$P(^PSRX(RXP,0),"^",2) ; Set COPAY dfn PTR TO PATIENT
 S PSOCP=$P($G(^PSRX(RXP,"IB")),"^") ; IB action type
 S PSOSAVE=$S(PSOCP:1,1:"") ; save current copay status
 ;         Set x=service^dfn^actiontype^user duz
 I +$G(PSOSITE7)'>0 S PSOSITE7=$P(^PS(59,PSOSITE,"IB"),"^")
 S X=PSOSITE7_"^"_PSOCPN_"^"_PSOCP_"^"_$P(^PSRX(RXP,0),"^",16)
 ;
RX ;         Determine Original or Refill for RX
 N PSOIB
 S PSOIB=0
 S PSOREF=0
 ;set refill number if this is a refill
 I $G(^PSRX(RXP,1,+$G(YY),0))]"" S PSOREF=YY
 ;
 ;Orig fill -check if bill # already exists
 I 'PSOREF,+$P($G(^PSRX(RXP,"IB")),"^",2)>0 D CHKIB^PSOCP1
 I PSOIB G QUIT
 ;already attempted to bill, but exceeded Anuual Cap
 I 'PSOREF,+$P($G(^PSRX(RXP,"IB")),"^",4)>0 G QUIT
 ;
 ;Refill -check if bill # already exists
 I PSOREF,+$G(^PSRX(RXP,1,PSOREF,"IB")) D CHKIB^PSOCP1
 I PSOIB G QUIT
 ;already attempted to bill, but exceeded Anuual Cap
 I PSOREF,+$P($G(^PSRX(RXP,1,PSOREF,"IB")),"^",2) G QUIT
 ;
 ;set temporary variable to copay and then look for exceptions
 S PSOCHG=1
 D COPAYREL
 I 'PSOCHG G QUIT            ;not billable
 I PSOCHG=2 I 'PSOCP G QUIT
 ;  Units for COPAY
 ;calc number of 30-day units eligible to bill
 S PSOCPUN=($P(^PSRX(RXP,0),"^",8)+29)\30
 D ACCUM
QUIT ;
 K Y,PSOCP1,PSOCP2,PSOCPN,X,PSOCPUN,PSOREF,PSOCHG,PSOSAVE,PREA,PSORSN
 Q
 ;
COPAYREL ; Recheck copay status at release
 ;
 ; check Rx patient status
 I $P(^PSRX(RXP,0),"^",3)'="",$P($G(^PS(53,$P(^PSRX(RXP,0),"^",3),0)),"^",7)=1 S PSOCHG=0 Q
 ; see if drug is nutritional supplement, investigational or supply
 N DRG,DRGTYP
 S DRG=+$P(^PSRX(RXP,0),"^",6),DRGTYP=$P($G(^PSDRUG(DRG,0)),"^",3)
 I DRGTYP["I"!(DRGTYP["S")!(DRGTYP["N") S PSOCHG=0 Q
 K PSOTG,CHKXTYPE
 I +$G(^PSRX(RXP,"IBQ")) D XTYPE1^PSOCP1
 I $G(^PSRX(RXP,"IBQ"))["1" S PSOCHG=0 Q
 Q
 ;
ACCUM ; ACCUMULATE TOTALS AND SEE IF PATIENT MET ANNUAL CAP
 S PSOYR=$E(PSOREL,1,3) I PSOYR="" Q
 S PSOYEAR=$S(PSOYR="304":"YR2004",PSOYR="305":"YR2005",1:"")
 Q:PSOYEAR=""
 ;
 ;get Xtmp billing amt which would be IBAM tot + any previous refills
 S PSOTOT=$G(^XTMP(NAMSP,PSODFN,PSOYEAR))
 ;
 ;if none yegt then init to the IBAM total for the year
 I 'PSOTOT D
 .F PSOSQ=0:0 S PSOSQ=$O(^IBAM(354.7,PSODFN,1,PSOSQ)) Q:'PSOSQ  D
 ..S PSOLOG=$G(^IBAM(354.7,PSODFN,1,PSOSQ,0))
 ..I $E(PSOLOG,1,3)=PSOYR S PSOTOT=PSOTOT+$P(PSOLOG,"^",2)
 ;
 ;see if current refill added to tot exceeds annual cap and quit
 I PSOTOT+(7*PSOCPUN)>840 S PSOCAP(PSOYR)=1 Q
 ;
 ;update Xtmp tot nodes with current refill amounts
 S ^XTMP(NAMSP,PSODFN,PSOYEAR)=PSOTOT+(PSOCPUN*7)
 S ^XTMP(NAMSP,PSODFN,PSOYEAR,PSOCPUN)=$G(^XTMP(NAMSP,PSODFN,PSOYEAR,PSOCPUN))+1
 ;
 ;indicate this refill would be billable by adding to Xtmp "BILLED"
 N PSONAM
 S PSONAM=$P($G(^DPT(PSODFN,0)),"^"),PSONAM=$P(PSONAM,",")
 S PSONAM=$E(PSONAM,1,6)
 S ^XTMP(NAMSP,"BILLED",PSONAM,PSODFN,RXP,PSOREF)=PSOREL
 Q
 ;
SITE ; SET UP VARIABLES NEEDED BY BILLING
 S PSOSITE=$S(YY=0:$P(^PSRX(RXP,2),"^",9),1:$P($G(^PSRX(RXP,1,YY,0)),"^",9))
 Q:PSOSITE=""
 S PSOPAR=$G(^PS(59,PSOSITE,1))
 S PSOSITE7=$P($G(^PS(59,PSOSITE,"IB")),"^")
 Q
 ;
RPT ;
 N NAMSP S NAMSP=$$NAMSP^PSOCPBK1
 L +^XTMP(NAMSP):0 I '$T D  Q
 . W !,"Copay Tally job for PSO*7*215 is still running.  Halting..."
 L -^XTMP(NAMSP)
 W !!,"This report shows the patient name and prescription information for refills"
 W !,"that were indentified as billable by the tally patch PSO*7*215"
 W !!,"You may queue the report to print, if you wish.",!
 ;
DVC K %ZIS,POP,IOP S %ZIS="QM" D ^%ZIS I $G(POP) W !!,"Nothing queued to print.",! G DONE
QUEUE I $D(IO("Q")) S ZTRTN="START^PSOCPBK2",ZTDESC="Potential Billable copay report" D ^%ZTLOAD K %ZSI W !,"Report queued to print.",! G DONE
START ;
 U IO
 N NAMSP S NAMSP=$$NAMSP^PSOCPBK1
 S PSOOUT=0,PSODV=$S($E(IOST)="C":"C",1:"P")
 S PSOPGCT=0,PSOPGLN=IOSL-7,PSOPGCT=1
 D TITLE
 S PSONAM=""
 F  S PSONAM=$O(^XTMP(NAMSP,"BILLED",PSONAM)) Q:PSONAM=""  D
 .S PSODFN=""
 .F  S PSODFN=$O(^XTMP(NAMSP,"BILLED",PSONAM,PSODFN)) Q:PSODFN=""  D
 ..S RXP=""
 ..F  S RXP=$O(^XTMP(NAMSP,"BILLED",PSONAM,PSODFN,RXP)) Q:RXP=""  D
 ...S PSOFILL=""
 ...F  S PSOFILL=$O(^XTMP(NAMSP,"BILLED",PSONAM,PSODFN,RXP,PSOFILL)) Q:PSOFILL=""  D
 ....N XX,PSONAME
 ....S XX=$G(^XTMP(NAMSP,"BILLED",PSONAM,PSODFN,RXP,PSOFILL)) D
 .....D FULL Q:$G(PSOOUT)  S PSONAME=$P($G(^DPT(PSODFN,0)),"^")
 .....W !,$E(PSONAME,1,14) D PRTSSN
 .....W ?46," ",RXP," (",PSOFILL,")" D
 ......S Y=XX I Y>0 X ^DD("DD")
 ......W ?65," ",Y
 G END
 ;
FULL ;
 I ($Y+7)>IOSL&('$G(PSOOUT)) D TITLE
 Q
 ;
TITLE ;
 I $G(PSODV)="C",$G(PSOPGCT)'=1 W ! K DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSOOUT=1 Q
 ;
 W @IOF D
 . W !,"Patch PSO*7*215 -COPAY PRESCRIPTION REFILLS BILLABLE"
 S Y=DT X ^DD("DD") W !,"Date printed: ",Y,?70,"Page: ",PSOPGCT,!
 F MJT=1:1:79 W "="
 W !,"PATIENT NAME     (SSN)       DIV",?48,"RX# (FILL)",?66,"RELEASE DATE"
 W !,"--------------  -------  ----------------",?47,"------------"
 W ?66,"------------"
 S PSOPGCT=PSOPGCT+1
 Q
END ;
 I '$G(PSOOUT),$G(PSODV)="C" W !!,"** End of Report **" K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 I $G(PSODV)="C" W !
 E  W @IOF
DONE ;
 K MJT,PSOPGCT,PSOPGLN,Y,DIR,X,IOP,POP,IO("Q"),DIRUT,DUOUT,DTOUT
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
PRTSSN ;
 S SSN=$P(^DPT(PSODFN,0),"^",9),SSN=$E(SSN,$L(SSN)-3,$L(SSN))
 S PSOPATID=$E(PSONAM,1)_SSN
 S PSODIV=$P($G(^PSRX(RXP,2)),"^",9)
 S:PSODIV'="" PSODIV=$P($G(^PS(59,PSODIV,0)),"^",1)
 W "  ("_PSOPATID_")"_"  "_PSODIV
 Q
 ;
ETIME(SECTIME) ;convert seconds to day:hr:min:sec
 N DAY,HR,MIN,SEC,ETIM
 S (DAY,HR,MIN,SEC)=""
 I SECTIME>86400 S DAY=SECTIME\86400,SECTIME=SECTIME#86400
 I SECTIME>3600 S HR=SECTIME\3600,SECTIME=SECTIME#3600
 I SECTIME>60 S MIN=SECTIME\60,SECTIME=SECTIME#60
 S SEC=SECTIME
 S ETIM=""
 S:$L(HR)=1 HR=0_HR S:$L(MIN)=1 MIN=0_MIN S:$L(SEC)=1 SEC=0_SEC
 S:DAY ETIM=DAY_" Day " S:HR ETIM=ETIM_HR_":" S:MIN ETIM=ETIM_MIN
 S ETIM=ETIM_":"_SEC
 Q ETIM
 ;
MAIL3(MSG) ;
 S PSOINST=$P($G(^DIC(4,+$P($G(^XMB(1,1,"XUS")),"^",17),99)),"^")
 D NOW^%DTC S Y=% D DD^%DT S PSOEND=Y
 K PSOTEXT
 S XMY(DUZ)=""
 S XMY("NAPOLIELLO.GREG@FORUM.VA.GOV")=""
 S XMY("WHITE.ELAINE@FORUM.VA.GOV")=""
 S:$$PROD^XUPROD(1) XMY("WILLIAMSON.ERIC@FORUM.VA.GOV")=""
 S XMDUZ="PSO*7*215 TALLY"
 S XMSUB="STATION "_$G(PSOINST)
 S XMSUB=XMSUB_$S($$PROD^XUPROD(1):"(Prod)",1:"(Test)")
 S XMSUB=XMSUB_" UNBILLED COPAYS FOR PRESCRIPTION REFILLS"
 S PSOTEXT(1)=""
 S PSOTEXT(2)="Started "_PSOSTART
 S PSOTEXT(3)=""
 S PSOTEXT(4)="   "_MSG
 S XMTEXT="PSOTEXT(" N DIFROM D ^XMD K XMDUZ,XMTEXT,XMSUB
 Q
