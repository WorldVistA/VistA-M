PSURT1 ;BIR/RDC - PATIENT DEMOGRAPHIC RETRANSMITION; APR 2, 2007 ; 4/2/07 11:01am
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;**12**;MARCH, 2005;Build 19
 ;
 ; THIS PROGRAM WILL ALLOW THE RETRANSMITION OF THE PATIENT
 ; DEMOGRAPHIC DATA FOR THE PBM EXTRACT USING THE DATA
 ; FROM ^PSUDEM (59.9) FOR RUN TIME OPTIMIZATION
 ;
EN ; ENTRY POINT
 NEW P,SDT,EDT,WHEN,NOGOOD,TMON,RMONTH,PMON,SMON,EMON,RTYPE,SRANGE,ERANGE
 S P=""
 ; move call to CLEANUP^PSUHL to routine PSUCP (PSU*4*12) 
 S SDT=$O(^PSUDEM("B",P))
 I 'SDT W !,"NO DATA AVAILABLE - NOTIFY YOUR SUPERVISOR" Q
 S EDT=$O(^PSUDEM("B",P),-1)
 S Y=SDT X ^DD("DD") S START=Y
 S Y=EDT-1 X ^DD("DD") S STOP=Y
 W !,"This option will allow the retransmission of Patient Demographic and Outpatient Visit data stored in the PBM PATIENT DEMOGRAPHICS FILE. Statistical data starting from "
 W START
 W " through "
 W STOP
 W " is available for retransmission."
 W !
 ;
 ; let fileman get response
 S DIR("A")="Is this a monthly report",DIR(0)="YO"
 D ^DIR K DIR
 ;
 S NOGOOD=1
 I Y=1 S NOGOOD=0 D MONTH
 I Y=0 S NOGOOD=0 D RANGE
 Q:NOGOOD
 D PROCESS        ; *** process the extract ***
 Q
 ;
MONTH ;      *** allow only whole months to be processed ***
 W !
 S TMON=$E(DT,4,5)
 S DIR("A")="Select Month/Year",DIR(0)="F" D ^DIR
 K DIR,DIR("A")
 I $D(DIRUT) S NOGOOD=1 Q
 S %DT="MP" D ^%DT K %DT
 I Y=-1 W !!,"Invalid Month/Year.  Please Reenter a month and year." G MONTH
 S RMONTH=$$FMTE^XLFDT(Y) W " ("_RMONTH_")"
 ; S %DT(0)=SDT,%DT="MP"
 ; S X=Y
 ; D ^%DT K %DT
 I $E(Y,4,5)=TMON S Y=-1
 I Y=-1 W !!,"Data for the entire month of "_RMONTH_" is not available.  Please reenter a month/year." G MONTH
 I Y>DT W !!,"You may not select a date from the future.  Please reenter a month/year within the valid parameters." G MONTH
 ;
 S PSURMON=Y
 S SMON=$E(PSURMON,1,5)_"00"
 S EMON=$E(PSURMON,1,5)_"99"
 S RTYPE="M"
 Q
 ;
RANGE ;             *** process a range of dates from within file #59.9 ***
 S %DT(0)=SDT
 ;
BGNRNG ;
 W !
 S %DT="PAE",%DT("A")="Select start date: " D ^%DT K %DT,%DT("A")
 I X="^"!($G(DTOUT)) S NOGOOD=1 Q
 I Y=-1 W !!,"Invalid date.  Please reenter a start date." G BGNRNG
 I Y=DT W !!,"Today is not a valid start date.  Please reenter a start date." G BGNRNG
 ;
 I Y>DT W !!,"You may not select a date in the future.  Please reenter a start date." G BGNRNG
 ;
 S SRANGE=Y          ;  *  start with this date  ***
 ;
ENDRNG ;
 W !
 S %DT="PAE",%DT("A")="Select stop date: " D ^%DT K %DT,%DT("A")
 I X="^"!($G(DTOUT)) S NOGOOD=1 Q
 I Y=-1 W !!,"Invalid date.  Please reenter a stop date." G ENDRNG
 I Y=DT W !!,"Statistical data has not been compiled for current date.  Please reenter a stop date." G ENDRNG
 ;
 I Y<SRANGE W !!,"You need to select a stop date greater than your start date.  Please reenter your start/stop dates." G BGNRNG
 ;
 I Y>DT W !!,"You may not select a date in the future.  Please reenter a stop date." G ENDRNG
 ;
 S ERANGE=Y                ; *  end at this date  ***
 ;
 S RTYPE="R"
 K %DT(0)
 ;
 Q
PROCESS ;
 I RTYPE="R" S (START,PSUSRNG)=SRANGE,(LAST,PSUERNG)=ERANGE
 I RTYPE="M" S START=SMON,LAST=EMON
 ;
 S PSUSMRY=0
 W !!
 S DIR("A")="Do you want a copy of this report sent to you in a MailMan message?"
 S DIR(0)="YO"
 S DIR("B")="NO"
 D ^DIR K DIR,DIR(0)
 I Y="^" Q
 I Y=1 S PSUMME=1,PSUDUZ=DUZ
 ;
 I RTYPE="M" D
 . W !!
 . S DIR("A")="Send this to the PBM section for addition to the master file?"
 . S DIR(0)="YO"
 . S DIR("B")="NO"
 . D ^DIR K DIR,DIR(0)
 . I Y=1 S PSUMSTR=1
 ;
 I Y="^" Q
 S PSUSTART=START,PSULAST=LAST
 K %DT,PSUWHEN
 D NOW^%DTC S %DT="REAX",%DT(0)="A",%DT("B")="NOW",%DT("A")="Queue to run at what time: " D ^%DT
 S PSUWHEN=Y
 S ZTRTN="EN^PSURT2",ZTIO="",ZTDESC="RETRASMISSION OF PT DEMOGRAPHICS",ZTDTH=PSUWHEN
 S ZTSAVE("PSUSTART")=""
 S ZTSAVE("PSULAST")=""
 S ZTSAVE("PSUMME")=""
 S ZTSAVE("PSUMSTR")=""
 S ZTSAVE("PSURMON")=""
 S ZTSAVE("PSUSRNG")=""
 S ZTSAVE("PSUERNG")=""
 S ZTSAVE("PSUDUZ")=""
 S ZTSAVE("PSUSMRY")=""
 ;
 ; D ^PSURT2
 ; Q
 ;
 D ^%ZTLOAD
 Q
 ;
