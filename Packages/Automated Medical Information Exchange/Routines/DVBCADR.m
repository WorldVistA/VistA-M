DVBCADR ;ALB/JLU-editing the address ;1/28/93
 ;;2.7;AMIE;**19**;Apr 10, 1995
 ;
EN ;driver of the program
 S DVBCSTP=0
 F  DO  Q:DVBCSTP
 .D PAT Q:DVBCSTP
 .D INIT Q:DVBCSTP
 .F  D GUTS Q:DVBCSTP1
 .I DVBCMAL D MAIL
 D EXIT
 Q
 ;
GUTS ;this is the interloop or guts of the driver
 D DISPL
 D ASK
 I 'Y S DVBCSTP1=1 Q
 D QUES^DGRPU1(DVBCDFN,"ADD1")
 I DGERR D ERROR Q
 I DGCHANGE S DVBCMAL=1
 D VDPTP
 Q
 ;
EXIT ;cleans variables
 K %H,DFN,DGCHANGE,DGERR,DIC,DIR,DVBC,DVBCDATE,DVBCDFN,DVBCLINE,DVBCMAL,DVBCPATN,DVBCSSN,DVBCSTP,DVBCSTP1,VAERR,VAPA,Y,XMTEXT,XMY,XMB,XMDUZ,XMSUB,DVBCX,DVBCML,DVBCSP,DVBCSP1,ER,J,C,PNAM,SSN,DVBCSSNO
 K DVBTMP,XMBTEXT
 Q
 ;
ERROR ;this is an erro printing subroutine
 I DGERR W !,*7
 Q
 ;
INIT ;initialize variables
 I '$D(IOF) D HOME^%ZIS
 K VAPA,DVBTMP,DVBC
 S %H=$H
 D YX^%DTC
 S DVBCDATE=$P(Y,"@",1)
 S $P(DVBCLINE,"_",80)=""
 S SSN=$P(^DPT(DVBCDFN,0),U,9)
 D SSNOUT^DVBCUTIL
 S DVBCSSN=DVBCSSNO
 D VDPTTMP
 I VAERR S DVBCSTP=1 Q
 I +VAPA(9) DO
 .D STORTMP
 .K VAPA
 .D VDPTP
 I VAERR S DVBCSTP=1 Q
 D STORE
 S (DVBCSTP1,DVBCMAL)=0
 Q
 ;
PAT ;get the patient
 S DIC="^DPT(",DIC(0)="AEMQ"
 D ^DIC
 I Y<0 S DVBCSTP=1 Q
 S DVBCDFN=+Y,(PNAM,DVBCPATN)=$P(Y,U,2)
 Q
 ;
DISPL ;the display subroutine
 W @IOF
 W "Edit Address Information",?35,$$SITE^DVBCUTL4,?67,DVBCDATE
 W !,"Name: ",DVBCPATN,?54,"SSN: ",DVBCSSN
 W !,DVBCLINE
 W !,?9,"Permanent"
 I $D(DVBTMP) DO
 .W ?40,"Temporary:  ",$P(DVBTMP(9),U,2)
 .I $P(DVBTMP(10),U,2)]"" W " to ",$P(DVBTMP(10),U,2)
 W !,"Address: ",$E(VAPA(1),1,29)
 I $D(DVBTMP) W ?40,$E(DVBTMP(1),1,29)
 W !,?9,$E(VAPA(2),1,29)
 I $D(DVBTMP) W ?40,$E(DVBTMP(2),1,29)
 W !,?9,$E(VAPA(3),1,29)
 I $D(DVBTMP) W ?40,$E(DVBTMP(3),1,29)
 W !,"City:",?9,VAPA(4)
 I $D(DVBTMP) W ?40,DVBTMP(4)
 W !,"State:",?9,$P(VAPA(5),U,2)
 I $D(DVBTMP) W ?40,$P(DVBTMP(5),U,2)
 W !,"Zip+4:",?9,$S($D(VAPA(11)):$P(VAPA(11),"^",2),1:"")
 I $D(DVBTMP) W ?40,DVBTMP(11)
 W !,"County:",?9,$P(VAPA(7),U,2)
 I $D(DVBTMP) W ?40,$P(DVBTMP(7),U,2)
 W !,"Phone:",?9,VAPA(8)
 I $D(DVBTMP) W ?40,DVBTMP(8)
 W !,"Office:",?9,VAPA(9999)
 W !,DVBCLINE
 Q
 ;
ASK ;ask if yes or no
 S DIR(0)="Y",DIR("A")="Do you wish to edit this address:",DIR("B")="YES"
 D ^DIR
 Q
 ;
STORE ;store original address fro possible bulletin
 S DVBC(1)=VAPA(1),DVBC(2)=VAPA(2),DVBC(3)=VAPA(3)
 S DVBC(4)=VAPA(4),DVBC(5)=$P(VAPA(5),U,2)
 S DVBC(11)=$S($D(VAPA(11)):$P(VAPA(11),"^",2),1:"")
 S DVBC(7)=$P(VAPA(7),U,2),DVBC(8)=VAPA(8)
 S DVBC(9999)=VAPA(9999)
 Q
 ;
VDPTP ;gets the permanent address
 S VAPA("P")=""
VDPTTMP ;gets the temporary address if one
 S DFN=DVBCDFN
 D ADD^VADPT
 S VAPA(9999)=$S($D(^DPT(DFN,.13)):$P(^(.13),U,2),1:"")
 Q
 ;
STORTMP ;saves the active temporary address
 S DVBTMP(1)=VAPA(1),DVBTMP(2)=VAPA(2),DVBTMP(3)=VAPA(3),DVBTMP(4)=VAPA(4)
 S DVBTMP(5)=VAPA(5),DVBTMP(11)=$S($D(VAPA(11)):$P(VAPA(11),"^",2),1:"")
 S DVBTMP(7)=VAPA(7),DVBTMP(8)=VAPA(8)
 S DVBTMP(9)=VAPA(9),DVBTMP(10)=VAPA(10)
 Q
 ;
MAIL ;to fire a bulletin if necessary
 S XMDUZ="AMIE Package",XMSUB="Edit of patient address"
 S XMB(1)=DVBCPATN_"   SSN: "_DVBCSSN,XMB(2)=DVBCDATE,XMB(3)=$P(^VA(200,DUZ,0),U,1)
 S XMB="DVBA C EDIT ADDRESS"
 D XMT
 S XMTEXT="DVBCML("
 D ^XMB
 K XMBTEXT,XMTEXT,XMB,XMSUB
 W !!,"A bulletin has been sent to the appropriate mail group regarding this",!,"address change!"
 Q
 ;
XMT ;make the text of the bulletin
 S DVBCX=1 D LIN
 S DVBCML(1)="ADDR.:  "_DVBC(1)_DVBCSP_VAPA(1)
 S DVBCX=2 D LIN
 S DVBCML(2)="        "_DVBC(2)_DVBCSP_VAPA(2)
 S DVBCX=3 D LIN
 S DVBCML(3)="        "_DVBC(3)_DVBCSP_VAPA(3)
 S DVBCX=4 D LIN
 S DVBCML(4)="City:   "_DVBC(4)_DVBCSP_VAPA(4)
 S DVBCX=5 D LIN
 S DVBCML(5)="State:  "_DVBC(5)_DVBCSP_$P(VAPA(5),U,2)
 S DVBCX=11 D LIN
 S DVBCML(6)="Zip+4:  "_DVBC(11)_DVBCSP_$S($D(VAPA(11)):$P(VAPA(11),"^",2),1:"")
 S DVBCX=7 D LIN
 S DVBCML(7)="County: "_DVBC(7)_DVBCSP_$P(VAPA(7),U,2)
 S DVBCX=8 D LIN
 S DVBCML(8)="Phone:  "_DVBC(8)_DVBCSP_VAPA(8)
 S DVBCX=9999 D LIN
 S DVBCML(9)="Office: "_DVBC(9999)_DVBCSP_VAPA(9999)
 Q
 ;
LIN ;makes spaces
 K DVBCSP,DVBCSP1
 S DVBCSP1=37-$L(DVBC(DVBCX))
 S $P(DVBCSP," ",DVBCSP1)=""
 Q
