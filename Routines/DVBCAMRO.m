DVBCAMRO ;ALB ISC/THM-REGIONAL OFFICE 2507 AMIS REPORT ; 9/28/91  6:39 AM
 ;;2.7;AMIE;**17,149**;Apr 10, 1995;Build 16
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
SETUP ;
 N DVBAPRTY,DVBAEXMP,DVBAP,DTOUT,DUOUT
 S UPDATE="N",PREVMO=$P(^DVB(396.1,1,0),U,11),HD="REGIONAL OFFICE 2507 AMIS REPORT" I '$D(DT) S X="T" D ^%DT S DT=Y
 S DVBCDT(0)=$$FMTE^XLFDT(DT,"5DZ")
 D HOME^%ZIS S FF=IOF
 ;prompt for priority of exam
 S DVBAPRTY=$$EXMPRTY^DVBCIUTL("Select the Priority of Exam for the 2507 AMIS Report")
 G:('(DVBAPRTY?.A)!(DVBAPRTY']"")) EXIT  ;quit if no priority of exam selected
 ;
INIT ;initialize counter arrys
 S DVBAEXMP=$S($G(DVBAPRTY)["BDD":"BDD,QS",($G(DVBAPRTY)["DES"):"DCS,DFD",($G(DVBAPRTY)["AO"):"AO",1:"ALL")
 F JI="3DAYSCH","30DAYEX","PENDADJ" D
 .F DVBAP=1:1:$L(DVBAEXMP,",") S TOT($P(DVBAEXMP,",",DVBAP),JI)=0
 F JI="INSUFF","SENT","INCOMPLETE","DAYS","COMPLETED" D
 .F DVBAP=1:1:$L(DVBAEXMP,",") S TOT($P(DVBAEXMP,",",DVBAP),JI)=0
 F JI="P90","P121","P151","P181","P365","P366" D
 .F DVBAP=1:1:$L(DVBAEXMP,",") S TOT($P(DVBAEXMP,",",DVBAP),JI)=0
 ;
EN W @IOF,!?(IOM-$L(HD)\2),HD,!!!
 S %DT(0)=-DT,%DT="AE",%DT("A")="Enter STARTING DATE: " D ^%DT G:Y<0 EXIT S BDATE1=Y,BDATE=Y-.1
 S %DT="AE",%DT("A")="    and ENDING DATE: " D ^%DT G:Y<0 EN S EDATE1=Y,EDATE=Y+.5
 I EDATE1<BDATE1 W *7,!!,"Invalid date sequence - ending date is before starting date.",!! H 3 G EN
 W !!,"When selecting regional offices you may enter an individual station name,",!,"station number or nothing if all regional offices should be searched.",!!
 S DIC("A")="Select REGIONAL OFFICE NUMBER: ",DIC(0)="AEQM",DIC="^DIC(4," D ^DIC G:($D(DTOUT)!($D(DUOUT))) EXIT
 I +Y>0 S DA=+Y,RONUM=$S($D(^DIC(4,DA,99)):$P(^(99),U,1),1:"000"),RONAME=$P(Y,U,2)
 I +Y<0 S (RONUM,RONAME)="ALL"
 ;
ASK K %DT S SBULL="Y" W !!!,"Want to send a bulletin when processing is done" S %=1 D YN^DICN G:$D(DTOUT)!(%<0) EXIT
 I $D(%Y) I %Y["?" W !!,"Enter Y to send the bulletin to selected recipients or N not to send it at all.",!! G ASK
 I %'=1 S SBULL="N"
 I SBULL="Y" D BULL^DVBCAMR2
 W ! S %ZIS="AEQ",%ZIS("B")="0;P-OTHER",%ZIS("A")="Output device: " D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN="GO^DVBCAMR2",ZTDESC="2507 Amis Report",ZTIO=ION F I="UPDATE","RO*","PREVMO","BDATE*","TOT*","EDATE*","SBULL","DUZ","DVBCDT(0)","XM*","DVBAPRTY" S ZTSAVE(I)=""
 I $D(IO("Q")) D ^%ZTLOAD W:$D(ZTSK) !!,"Request queued",!! H 1 K ZTSK G EXIT
 G GO^DVBCAMR2
 ;
EXIT K PREVMO,UPDATE G KILL^DVBCUTIL
