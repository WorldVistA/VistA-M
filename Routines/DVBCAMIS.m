DVBCAMIS ;ALB/GTS-557/THM-2507 AMIS REPORT ;21 MAY 89@0822 ; 5/23/91  1:30 PM
 ;;2.7;AMIE;**17,149**;Apr 10, 1995;Build 16
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
SETUP ;
 N DVBAPRTY,DVBAEXMP,DVBAP
 S UPDATE="N",HD="AMIS 290 REPORT" I '$D(DT) S X="T" D ^%DT S DT=Y
 S DVBCDT(0)=$$FMTE^XLFDT(DT,"5DZ")
 D HOME^%ZIS S FF=IOF
 ;prompt for priority of exam
 S DVBAPRTY=$$EXMPRTY^DVBCIUTL("Select the Priority of Exam for the AMIS 290 Report")
 G:('(DVBAPRTY?.A)!(DVBAPRTY']"")) EXIT  ;quit if no priority of exam selected 
 ;
INIT ;initialize counter arrays
 S DVBAEXMP=$S($G(DVBAPRTY)["BDD":"BDD,QS",($G(DVBAPRTY)["DES"):"DCS,DFD",($G(DVBAPRTY)["AO"):"AO",1:"ALL")
 F JI="3DAYSCH","30DAYEX","PENDADJ","TRANSIN","TRNRETTO","TRNPNDTO","TRANSOUT","TRNRETFR","TRNPNDFR","INSUFF" D
 .F DVBAP=1:1:$L(DVBAEXMP,",") S TOT($P(DVBAEXMP,",",DVBAP),JI)=0
 F JI="RECEIVED","INCOMPLETE","DAYS","COMPLETED" D
 .F DVBAP=1:1:$L(DVBAEXMP,",") S TOT($P(DVBAEXMP,",",DVBAP),JI)=0
 F JI="P90","P121","P151","P181","P365","P366" D
 .F DVBAP=1:1:$L(DVBAEXMP,",") S TOT($P(DVBAEXMP,",",DVBAP),JI)=0
 ;
EN W @IOF,!?(IOM-$L(HD)\2),HD,!!!
 S %DT(0)=-DT,%DT="AE",%DT("A")="Enter STARTING DATE: " D ^%DT G:Y<0 EXIT S BDATE1=Y,BDATE=Y-.1
 S %DT="AE",%DT("A")="    and ENDING DATE: " D ^%DT G:Y<0 EN S EDATE1=Y,EDATE=Y+.5
 I EDATE1<BDATE1 W *7,!!,"Invalid date sequence - ending date is before starting date.",!! H 3 G EN
ASK0 ;prompt for previous month pending count
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,DVBATXT
 S DIR(0)="N^0:9999:0"
 S DIR("?",1)="Enter the totals for the month previous to the one you are processing."
 S DIR("?")="Must be a number from 0 to 9999."
 S DIR("T")=DTIME  ;time-out value specified by system
 W !!
 ;get previous month pending count for each priority of exam to run
 F DVBAP=1:1:$L(DVBAEXMP,",") Q:($G(DIRUT)!($G(DIROUT)))  D
 .S DVBATXT=$$GPTYPE($P(DVBAEXMP,",",DVBAP))
 .S DIR("A",1)="Please enter the total pending, "_DVBATXT
 .S DIR("A")=" exam priorities, from the previous month"
 .D ^DIR
 .S:$L(DVBAEXMP,",")=1 PREVMO=$G(Y)
 .S:$L(DVBAEXMP,",")>1 PREVMO($P(DVBAEXMP,",",DVBAP))=$G(Y)
 G:($G(DIRUT)!($G(DIROUT))) EXIT  ;user timed/exited out
 ;
ASK K %DT S SBULL="Y"
 W !!!,"Do you want to send a bulletin when processing is done"
 S %=1 D YN^DICN G:$D(DTOUT)!(%<0) EXIT
 I %=0 W !!,"Enter Y to send a bulletin to selected recipients or N not to send it at all.",!! G ASK
 I %'=1 S SBULL="N"
 I SBULL="Y" D BULL^DVBCAMI3
 W ! S %ZIS="AEQ",%ZIS("A")="Output device: " D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN="GO^DVBCAMI2",ZTDESC="2507 Amis Report",ZTIO=ION F I="PREVMO*","RO*","BDATE*","TOT*","EDATE*","SBULL","DUZ","DVBCDT(0)","XM*","DVBAPRTY" S ZTSAVE(I)=""
 I $D(IO("Q")) D ^%ZTLOAD W:$D(ZTSK) !!,"Request queued",!! H 1 K ZTSK G EXIT
 G GO^DVBCAMI2
 ;
EXIT K PREVMO,UPDATE G KILL^DVBCUTIL
 ;
 ;
 ;Input : DVBACDE - Code to get description for
 ;           [BDD,QS,DCS,DFD,AO]
 ;Ouput : Corresponding description for code
GPTYPE(DVBACDE) ;get exam priority desc
 N DVBATXT
 Q:($G(DVBACDE)']"") ""
 S DVBATXT=$S(DVBACDE="BDD":"'Benefits Delivery at Discharge ("_DVBACDE_")'",1:"")
 S:(DVBATXT']"") DVBATXT=$S(DVBACDE="QS":"'Quick Start ("_DVBACDE_")'",1:"")
 S:(DVBATXT']"") DVBATXT=$S(DVBACDE="DCS":"'DES Claimed Condition by Service Member ("_DVBACDE_")'",1:"")
 S:(DVBATXT']"") DVBATXT=$S(DVBACDE="DFD":"'DES Fit for Duty ("_DVBACDE_")'",1:"")
 S:(DVBATXT']"") DVBATXT=$S(DVBACDE="AO":"'Agent Orange ("_DVBACDE_")'",1:"")
 S:(DVBATXT']"") DVBATXT=$S(DVBACDE="ALL":"excluding BDD,QS,DCS,DFD and AO",1:"")
 Q DVBATXT
