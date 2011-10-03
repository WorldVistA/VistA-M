PSOTALK3 ;BIR/EJW - SCRIPTALK UTILITIES ;02 Oct 2003  7:31 AM
 ;;7.0;OUTPATIENT PHARMACY;**135,200,268**;DEC 1997;Build 9
 ;External reference to ^PS(59.7 controlled subscription by DBIA 694
TTRANS ;RE-INITIALIZE SCRIPTALK PRINTER
 D:'$D(PSOPAR) ^PSOLSET I '$D(PSOPAR) W $C(7),!!,"Pharmacy Division Must be Selected!",! Q
 S ZTIO="`"_$P($G(^PS(59,PSOSITE,"STALK")),U)
 I ZTIO="`" W !,"No ScripTalk printer defined for division." Q
 S ZTDTH=$$NOW^XLFDT,ZTDESC="Scriptalk Printer Re-initialize"
 S ZTRTN="TINIT^PSOTALK3",ZTSAVE("*")=""
 D ^%ZTLOAD K ZTDTH,ZTRTN,ZTIO,ZTDESC
 W:$D(ZTSK)&('$D(ZTQUEUED)) !!,"Task Queued !",!
 Q
 ;
TINIT ;
 W !,"^XA ^MD30 ^XZ"
 W !,"^XA ^MD30 ^XZ"
 W !,"^XA ~SD30 ^XZ"
 W !,"^XA ^MFF,F ^XZ"
 W !,"^XA ^LT20 ^XZ"
 W !,"^XA ^MTT ^XZ"
 W !,"^XA ^JUS ^XZ"
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
TEST ;
 I $G(PSOTEST)?."?" R !,"Enter a Zebra Print Language test command to be sent",!,"to the ScripTalk printer: ",PSOTEST:DTIME
 I $G(PSOTEST)="" Q
 D:'$D(PSOPAR) ^PSOLSET I '$D(PSOPAR) W $C(7),!!,"Pharmacy Division Must be Selected!",! Q
 S ZTIO="`"_$P($G(^PS(59,PSOSITE,"STALK")),U),ZTDTH=$$NOW^XLFDT,ZTDESC="Scriptalk Interface Test"
 I ZTIO="`" W !,"No ScripTalk printer defined for division." Q
 S ZTRTN="TPUT^PSOTALK3",ZTSAVE("*")=""
 D ^%ZTLOAD K ZTDTH,ZTRTN,ZTIO,ZTDESC
 W:$D(ZTSK)&('$D(ZTQUEUED)) !!,"Task Queued !",!
 K PSOTEST
 Q
TPUT ;SET VARIABLE 'PSOTEST' TO OUTPUT STRING
 W !,PSOTEST
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
TESTLAB ;
 D:'$D(PSOPAR) ^PSOLSET I '$D(PSOPAR) W $C(7),!!,"Pharmacy Division Must be Selected!",! Q
 S ZTIO="`"_$P($G(^PS(59,PSOSITE,"STALK")),U),ZTDTH=$$NOW^XLFDT,ZTDESC="Scriptalk Sample Label"
 I ZTIO="`" W !,"No ScripTalk printer defined for division." Q
 S ZTRTN="TLABEL^PSOTALK3",ZTSAVE("*")=""
 W !,"The following test data will be sent to the ScripTalk printer:",! D TLABEL W !
 D ^%ZTLOAD K ZTDTH,ZTRTN,ZTIO,ZTDESC
 W:$D(ZTSK)&('$D(ZTQUEUED)) !!,"Task Queued !",!
 Q
TLABEL ;
 W !,"^XA"
 W !,"^FO250,700^XGE:RX.GRF^FS"
 W !,"^FO250,700^XGE:RX.GRF^FS"
 W !,"^AFR,20,10^FO531,50^FR^CI0^FD7305 N. MILITARY TRL  Exp: January 01,2002^FS"
 W !,"^AFR,20,10^FO503,50^FR^CI0^FDRX#82382787 January 01,2001  Fill 01 OF 01^FS"
 W !,"^AFR,20,10^FO475,50^FR^CI0^FDJOE VETERAN^FS"
 W !,"^AFR,20,10^FO447,50^FR^CI0^FDTAKE 1 CAPSULE THREE TIMES DAILY^FS"
 W !,"^AFR,20,10^FO419,50^FR^CI0^FD^FS"
 W !,"^AFR,20,10^FO391,50^FR^CI0^FD^FS"
 W !,"^AFR,20,10^FO363,50^FR^CI0^FD^FS"
 W !,"^AFR,20,10^FO335,50^FR^CI0^FDDr. BEN CASEY MD^FS"
 W !,"^AFR,20,10^FO279,50^FR^CI0^FDQTY: 24 TABS^FS"
 W !,"^AFR,20,10^FO251,50^FR^CI0^FDAMOXICILLIN 500MG CAP^FS"
 W !,"^RX01,JOE VETERAN^FS"
 W !,"^RX02,AMOXICILLIN 500MG CAP^FS"
 W !,"^RX03,TAKE 1 CAPSULE THREE TIMES DAILY ^FS"
 W !,"^RX04,010101^FS"
 W !,"^RX05,00^FS"
 W !,"^RX06,020000^FS"
 W !,"^RX07,BEN CASEY^FS"
 W !,"^RX08,2928993888^FS"
 W !,"^RX09,82382787^FS"
 W !,"^RX10, ^FS"
 W !,"^PQ1,0,1,Y"
 W !,"^XZ"
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
STDEV ;Define ScripTalk printer for a Division or map another print device to the ScripTalk Printer
 N PSOSITE,PSOTYPE
STDEV1 ;
 W !!!
 K DIC,DIR,DIE,DA,DR
 S DIR(0)="SBO^D:Division;P:Printer",DIR("A")="Define ScripTalk Printer by (D)ivision or (P)rinter mapping?"
 S DIR("?")=" "
 S DIR("?",1)="Enter D to define ScripTalk printer by Division or enter P to tie a ScripTalk"
 S DIR("?",2)="printer to regular Pharmacy label printer(s) to control where the ScripTalk"
 S DIR("?",3)="labels print for multi-divisions."
 S PSOSITE=""
 D ^DIR G:$D(DIRUT)!(Y<0) STDEVQ S PSOTYPE=Y
 D STDEVM:PSOTYPE="P"
 D STDEVD:PSOTYPE="D"
 G STDEV1
STDEVQ ;
 K DIC,DIR,DIE,DA,DR,DIRUT,Y
 Q
 ;
STDEVD ;Define ScripTalk device by division
 W ! S DIC("A")="Division: ",DIC=59,DIC(0)="AEMQ"
 S:$G(PSOVEX)'=1 DIC("S")="I $S('$D(^PS(59,+Y,""I"")):1,'^(""I""):1,DT'>^(""I""):1,1:0)"
 D ^DIC K DIC Q:$D(DIRUT)!(Y<0)
 Q:+Y<0
 S PSOSITE=+Y
 S DIE="^PS(59,",DA=PSOSITE,DR="107;107.1" D ^DIE
 Q
 ;
STDEVM ;Map a printer to a ScripTalk printer
 S DIE="^PS(59.7,",DA=1,DR="47" L +^PS(59.7,1,47):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) D  I $T D ^DIE L -^PS(59.7,1,47)
 . I '$T W !?5,"Another user is editing this entry."
 Q
 ;
