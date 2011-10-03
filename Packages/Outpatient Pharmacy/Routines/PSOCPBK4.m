PSOCPBK4 ;BIR/GN-Copay Back Bill for Automated-release refills cont. ;10/12/05 9:55am
 ;;7.0;OUTPATIENT PHARMACY;**217,303**;DEC 1997;Build 19
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External reference to ^IBAM(354.7 supported by DBIA 3877
 ;External reference to $$PROD^XUPROD(1) supported by DBIA 4440
 ;External reference to $$PTCOV^IBCNSU3 supported by DBIA 4115
 ;External reference to ^IBARX supported by DBIA 125
 ;
 Q
 ;
ADDBILL ;add to billable ^XTMP if ok, quit if not
 S PSOTRF=PSOTRF+1
 S PSOREL=$P($G(^PSRX(RXP,1,YY,0)),"^",18)
 Q:'PSOREL                                   ;not released
 Q:'YY                                       ;orig fill
 Q:+$$RXST^IBARXEU(PSODFN,$P(PSOREL,"."))    ;Exempt on Rel dte
 ;check refill
 Q:$P($G(^PSRX(RXP,1,YY,"IB")),"^",1)'=""    ;already billed
 Q:$P($G(^PSRX(RXP,1,YY,"IB")),"^",2)'=""    ;exceeded ann. cap
 ;
 ;look for Activity log entry per refill # with the below text
 S FOUND=0
 F XX=999:0 S XX=$O(^PSRX(RXP,"A",XX),-1) Q:'XX  D  Q:FOUND
 .Q:$P(^PSRX(RXP,"A",XX,0),"^",4)'=YY
 .Q:^PSRX(RXP,"A",XX,0)'["External Interface Dispensing is Complete"
 .S FOUND=1
 Q:'FOUND
 ;
 S ^XTMP(NAMSP,PSODFN,RXP,YY)=$P(PSOREL,".")  ;add to XTMP to be bill
 Q
 ;
XTYPE ;
 N Y,VADM,I,J,X,SAVY,DFN
 S DFN=PSODFN D DEM^VADPT I +$G(VADM(6)) S PSOSCMX="" Q  ; DECEASED
 S (X,PSOSCMX,SAVY)=""
 S J=0 F  S J=$O(^PS(59,J)) Q:'J  I +$G(^(J,"IB")) S X=+^("IB") Q
 I 'X Q
 S X=X_"^"_PSODFN D XTYPE^IBARX
 I $G(Y)'=1 Q
 S J="" F  S J=$O(Y(J)) Q:'J  S I="" F  S SAVY=I,I=$O(Y(J,I)) Q:I=""  S:I>0 PSOSCMX=I
 I PSOSCMX="",SAVY=0 Q  ; INCOME EXEMPT OR SERVICE-CONNECTED
 I PSOSCMX=2 Q  ; NEED TO ASK SC QUESTION
 Q
 ;
TOTAL ;
 N COUNT,COUNTED
 I '$D(PSOVETS) S PSOVETS=0
 N I,J
 F I=1:1:3 S (PSOCNT("YR2004",I),PSOCNT("YR2005",I))=0
 S PSODFN=0 F  S PSODFN=$O(^XTMP(NAMSP,PSODFN)) Q:'PSODFN  D
 .S COUNTED=0
 .F J="YR2004","YR2005" F I=1:1:3 S COUNT=$G(^XTMP(NAMSP,PSODFN,J,I)) I COUNT>0 S:'$G(COUNTED) COUNTED=1,PSOVETS=PSOVETS+1 S PSOCNT(J,I)=PSOCNT(J,I)+COUNT
 F I=1:1:3 S PSOCNT=PSOCNT+PSOCNT("YR2004",I)+PSOCNT("YR2005",I)
 Q
 ;
BILLIT ;
 ; IF NO IB NUMBER FOR THIS FILL, SET UP VARIABLES AND TALLY
 N PSOCAP,PSODIV,PSODV,PSOFILL,PSOLOG,PSOOUT,PSOPAR,PSOPATID,PSOSITE
 N PSOSITE7,PSOSQ,PSOTOT,PSOYEAR,PSOYR,SSN,SAVCPUN,SAVREF
 S PSODFN=0
 F CC=1:1 S PSODFN=$O(^XTMP(NAMSP,PSODFN)) Q:'PSODFN  D  Q:STOP
 .I CC#100=0,$D(^XTMP(NAMSP,0,"STOP")) D  Q
 ..S $P(^XTMP(NAMSP,0,"LAST"),"^",1,2)="STOP^"_$$NOW^XLFDT,STOP=1
 .S (PSOCAP(304),PSOCAP(305))=0 ; INITIAL ANNUAL CAP FOR 2004 & 2005
 .F RXP=0:0 S RXP=$O(^XTMP(NAMSP,PSODFN,RXP)) Q:'RXP  D
 ..;calc number of 30-day units eligible to bill
 ..S (SAVCPUN,PSOCPUN)=($P(^PSRX(RXP,0),"^",8)+29)\30
 ..F YY=0:0 S YY=$O(^XTMP(NAMSP,PSODFN,RXP,YY)) Q:YY=""  D
 ...S (SAVREF,PSOREF)=YY
 ...S PSOREL=$G(^XTMP(NAMSP,PSODFN,RXP,YY))
 ...I PSOCAP($E(PSOREL,1,3)) Q  ; MET ANNUAL CAP FOR 2004 OR 2005
 ...I $P($G(^PSRX(RXP,1,YY,"IB")),"^",1)="" D  ; REFILL LEVEL
 ....D SITE
 ....D CP^PSOCP                                     ;call back billing
 ....S PSOCPUN=SAVCPUN,PSOREF=SAVREF
 ....I $P($G(^PSRX(RXP,1,YY,"IB")),"^",1) D ACCUM   ;Do if was billed?
 ....D CP I +$G(PSOREF) D ACCUM
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
 I PSOIB D QUIT Q
 ;already attempted to bill, but exceeded Anuual Cap
 I 'PSOREF,+$P($G(^PSRX(RXP,"IB")),"^",4)>0 D QUIT Q
 ;
 ;Refill -check if bill # already exists
 I PSOREF,+$G(^PSRX(RXP,1,PSOREF,"IB")) D CHKIB^PSOCP1
 I PSOIB D QUIT Q
 ;already attempted to bill, but exceeded Anuual Cap
 I PSOREF,+$P($G(^PSRX(RXP,1,PSOREF,"IB")),"^",2) G QUIT
 ;
 ;set temporary variable to copay and then look for exceptions
 S PSOCHG=1
 D COPAYREL
 I 'PSOCHG D QUIT Q           ;not billable
 I PSOCHG=2,'PSOCP D QUIT
 Q
QUIT ;
 K Y,PSOCP1,PSOREF,PSOCPUN,PSOCP2,PSOCPN,X,PSOCHG,PSOSAVE,PREA,PSORSN
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
 ;if none yet then init to the IBAM total for the year
 I 'PSOTOT D
 .F PSOSQ=0:0 S PSOSQ=$O(^IBAM(354.7,PSODFN,1,PSOSQ)) Q:'PSOSQ  D
 ..S PSOLOG=$G(^IBAM(354.7,PSODFN,1,PSOSQ,0))
 ..I $E(PSOLOG,1,3)=PSOYR S PSOTOT=PSOTOT+$P(PSOLOG,"^",2)
 ;
 ;update Xtmp tot nodes with current refill amounts
 S ^XTMP(NAMSP,PSODFN,PSOYEAR)=PSOTOT+(PSOCPUN*7)
 S ^XTMP(NAMSP,PSODFN,PSOYEAR,PSOCPUN)=$G(^XTMP(NAMSP,PSODFN,PSOYEAR,PSOCPUN))+1
 ;
 ;indicate this refill may be billable or (was billed, if BILLING run)
 ;by adding to Xtmp "BILLED"
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
 N JOBN,NAMSP,ZTDESC,ZTRTN
 S NAMSP=$$NAMSP^PSOCPBK3
 S JOBN=$S(^XTMP(NAMSP,0)["BACK":"Back Billing",1:"Tally")
 L +^XTMP(NAMSP):0 I '$T D  Q
 .W !,JOBN_" job for PSO*7*217 is still running.  Halting..."
 L -^XTMP(NAMSP)
 W !!,"This report shows the patient name and prescription information for refills"
 W:JOBN["Tally" !,"that were identified as billable by the patch PSO*7*217"
 W:JOBN["Back" !,"that were back-billed by the patch PSO*7*217"
 W !!,"You may queue the report to print, if you wish.",!
 ;
DVC K %ZIS,POP,IOP S %ZIS="QM" D ^%ZIS I $G(POP) W !!,"Nothing queued to print.",! G DONE
QUEUE I $D(IO("Q")) S ZTRTN="START^PSOCPBK4",ZTDESC=JOBN_" copay report" D ^%ZTLOAD K %ZSI W !,"Report queued to print.",! G DONE
START ;
 U IO
 N BLDT,RXO,NAMSP,PSOFILL,PSODFN,PSONAM,PSOOUT,PSODV,RXP,SSN,PSODIV
 N JOBN,PSOPATID
 S NAMSP=$$NAMSP^PSOCPBK3
 S JOBN=$S(^XTMP(NAMSP,0)["BACK":"Back Billing",1:"Tally")
 S PSOOUT=0,PSODV=$S($E(IOST)="C":"C",1:"P")
 S PSOPGCT=0,PSOPGLN=IOSL-7,PSOPGCT=1
 S BLDT=$P($G(^XTMP(NAMSP,0,"LAST")),"^",2)
 D TITLE
 S PSONAM=""
 F  S PSONAM=$O(^XTMP(NAMSP,"BILLED",PSONAM)) Q:PSONAM=""  D
 .S PSODFN=""
 .F  S PSODFN=$O(^XTMP(NAMSP,"BILLED",PSONAM,PSODFN)) Q:PSODFN=""  D
 ..S RXP=""
 ..F  S RXP=$O(^XTMP(NAMSP,"BILLED",PSONAM,PSODFN,RXP)) Q:RXP=""  D
 ...S PSOFILL=""
 ...F  S PSOFILL=$O(^XTMP(NAMSP,"BILLED",PSONAM,PSODFN,RXP,PSOFILL)) Q:PSOFILL=""  D
 ....N XX,RXO,Y,PSONAME
 ....S XX=$G(^XTMP(NAMSP,"BILLED",PSONAM,PSODFN,RXP,PSOFILL)) D
 .....D FULL Q:$G(PSOOUT)  S PSONAME=$P($G(^DPT(PSODFN,0)),"^")
 .....W !,$E(PSONAME,1,14)
 .....D PRTSSN
 .....S RXO=$P($G(^PSRX(RXP,0)),"^")
 .....W ?42," ",RXO," (",PSOFILL,")"
 .....S Y=XX I Y>0 X ^DD("DD")
 .....W ?55," ",Y
 .....W ?69,$S($$PTCOV^IBCNSU3(PSODFN,XX,"PHARMACY"):"YES",1:" NO")
 .....W ?75,$S($$PTCOV^IBCNSU3(PSODFN,BLDT,"PHARMACY"):"YES",1:" NO")
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
 . W !,"Patch PSO*7*217 -COPAY PRESCRIPTION REFILLS "_JOBN
 S Y=DT X ^DD("DD") W !,"Date printed: ",Y,?70,"Page: ",PSOPGCT,!
 F MJT=1:1:79 W "="
 W !,?69,"INS ON DTE"
 W !,"PATIENT NAME     (SSN)       DIV",?43,"RX# (FILL)",?55,"RELEASE DATE",?69,"REL   BILL"
 W !,"--------------  -------  ----------------",?42,"------------"
 W ?55,"------------",?69,"---- -----"
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
 W ?16,"("_PSOPATID_")"_"  "_PSODIV
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
