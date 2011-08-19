XQT1 ;SEA/MJM - Menu Template Processor ;04/07/99  12:13
 ;;8.0;KERNEL;**59,37**;Jul 10, 1995
 ;This routine should be a mirror image of XQ1
 ;
 S (XQPT,^XUTL("XQT",$J,0))=XQUR,^(XQPT,"T")=0
 ;
KILL K D,D0,D1,DA,DIC,DIE,DIR,DIS,DR,XQI,XQV,XQW,XQZ
 ;
NXT ;Process the next option, entry/exit actions,start list over, or quit
 I $D(^(^XUTL("XQT",$J,XQPT,"T"),"X")) X ^("X")
 I '$D(DT)!('$D(DTIME))!('$D(DUZ))!('$D(DUZ(0))) D DVARS^XQ12
 S:'$D(XQPT)#2 XQPT=^XUTL("XQT",$J,0) S ^("T")=^XUTL("XQT",$J,XQPT,"T")+1
ASK I '$D(^(^XUTL("XQT",$J,XQPT,"T"))) G:'^("RPT") OUT S ^("T")=1 W !!,"Again? Y// " R %:DTIME S:'$T %=U S:%="" %="Y" G:%=U!("Nn"[%) OUT D:%["??" HELP I "Yy"'[% W !!,"Please type 'Y' or 'N', '^' to quit, or '??' for help." G ASK
 S:'$D(XQPT)#2 XQPT=^XUTL("XQT",$J,0) S %=^(^XUTL("XQT",$J,XQPT,"T")),XQY=+%,XQDIC=$P(%,U,2),XQY0=$P(%,U,3,99)
 I $D(^(^XUTL("XQT",$J,XQPT,"T"),"H")) X ^("H")
 I $D(^(^XUTL("XQT",$J,XQPT,"T"),"E")),$P(XQY0,U,4)'="A" X ^("E") I $D(XQUIT) D T^XQUIT I $D(XQUIT) K XQUIT W !!,"XQUIT encountered at option ",$P(XQY0,U,2),!,?5,"template ",XQPT," halted by this encounter.  Sorry." G OUT
 W !?5,"Executing: ",$P(XQY0,U,2)
 S XQT=$P(XQY0,U,4) I "M"'[XQT G @XQT
 G NXT
 ;
OUT ;End of the line for this puppy: return to regular menu system
 I $D(XQXFLG("ZEBRA")) L ^XWB("SESSION",XQXFLG("ZEBRA")) ;Clear by setting new lock
 E  L  ;Clear the lock table
 ;
 K ^XUTL("XQT",$J,0),^(XQPT,"T"),XQPT
 S %=^XUTL("XQ",$J,"S"),XQY=+%,XQDIC=$P(%,U,2),XQY0=$P(%,U,3,99),XQT=$P(XQY0,U,4)
 K D0,D1,DA,DIC,DIE,DR,XQUIT,XQI,XQV,XQW,XQZ
 G NOFIND^XQ
 ;
HELP ;Call the help screen
 S XQH="XQTREPEAT" D EN^XQH
 Q
 ;
A ;ACTION type option entry point
 X:$D(^DIC(19,+XQY,20)) ^(20)
 I $D(XQUIT) D T^XQUIT I $D(XQUIT) K XQUIT W !!,"XQUIT encountered at option ",$P(XQY0,U,2),!,?5,"template ",XQPT," halted by this encounter.  Sorry." G OUT
 I $P(XQY0,U,17),$D(^DIC(19,XQY,26)),$L(^(26)) X ^(26)
 G NXT
 ;
B ;Broker type option.  Not allowed in templates.
 G NXT
 ;
C ;SCREEN type option entry point
 D DIC G:DA=-1 KILL S XQZ="DR,DDSFILE,DDSFILE(1)",XQW=39 D SET
 S DDSPAGE=$P($G(^DIC(19,+XQY,43)),U) K:DDSPAGE="" DDSPAGE
 S DDSPARM=$P($G(^DIC(19,+XQY,43)),U,2) K:DDSPARM="" DDSPARM
 I DDSFILE["(",DDSFILE'[U S DDSFILE=U_DDSFILE
 I $D(DDSFILE(1)),DDSFILE(1)["(",DDSFILE(1)'[U S DDSFILE(1)=U_DDSFILE(1)
 D ^DDS K DDSFILE G C
 ;
P ;PRINT type option entry point
 S XQZ="DIC,PG,L,FLDS,BY,FR,TO,DHD,DCOPIES,DIS(0),IOP,DHIT,DIOBEG,DIOEND",XQW=59 D SET
 I $D(DIS(0))#2 F XQI=1:1:3 Q:'$D(^DIC(19,+XQY,69+(XQI/10)))  Q:^(69+(XQI/10))=""  S DIS(XQI)=^(69+(XQI/10))
 S:$D(XQIOP) IOP=XQIOP
 S XQI=$G(^DIC(19,XQY,79)) S:XQI>0 DIASKHD="" S:$P(XQI,U,2) DISUPNO=1 S:$P(XQI,U,3) DIPCRIT=1
 D D1,EN1^DIP K IOP,DIOBERG,DIS,DP
 G NXT
 ;
I ;INQUIRE type option entry point
I1 D DIC G KILL:DA=-1 S DI=DIC,XQZ="DIC,DR,DIQ(0)",XQW=79 D SET,D1 S:$D(DIC)[0 DIC=DI
 I $D(^DIC(19,+XQY,63)),$L(^(63)) S FLDS=^(63)
 E  S FLDS="[CAPTIONED]"
 I $G(^DIC(19,+XQY,83))["Y" S IOP="HOME"
 ;S:DUZ(0)'="@" DICS="I 1 Q:'$D(^(8))  F DW=1:1:$L(^(8)) I DUZ(0)[$E(^(8),DW) Q"
 ;W:$D(IOF) @IOF D EN^DIQ S Y=XQY G I1
I2 ;
 W ! S XQZ="DHD",XQW=66 D SET K ^UTILITY($J),^(U,$J) S ^($J,1,DA)="",@("L=+$P("_DI_"0),U,2)"),DPP(1)=L_"^^^@",L=0,C=",",Q="""",DPP=1,DPP(1,"IX")="^UTILITY(U,$J,"_DI_"^2" D N^DIP1 S Y=XQY G I1
 ;
E ;EDIT type option entry point
E1 D DIC G KILL:DA=-1 K DIE,DIC S XQZ="DIE,DR",XQW=49 D SET S XQZ="DIE(""W"")",XQW=53 D SET
 I $D(^DIC(19,XQY,53)),$L(^(53)) S %=^(53),DIE("NO^")=$S(%="N":"",1:%)
 S:DIE["(" DIE=U_DIE D ^DIE S Y=XQY G E1
 ;
DIC ;Get FileMan parameters from Option File and do look up
 W ! K DIC S XQZ="DIC,DIC(0),DIC(""A""),DIC(""B""),DIC(""S""),DIC(""W""),D",XQW=29 D SET,D1
 I '$D(D) D ^DIC
 I $D(D) S:D="" D="B" D IX^DIC
 S DA=+Y,Y=XQY
 Q
 ;
D1 S:DIC["(" DIC=U_DIC Q
 ;
SET F XQI=1:1 S XQV=$P(XQZ,",",XQI) Q:XQV=""  K @XQV I $D(^DIC(19,+XQY,XQW+XQI)),^(XQW+XQI)]"" S @XQV=^(XQW+XQI)
 I $D(DIC("A")),DIC("A")]"" S DIC("A")=DIC("A")_" "
 K XQI,J
 Q
 ;
R ;RUN ROUTINE type option entry point
 G:'$D(^DIC(19,XQY,25)) NXT S XQZ=^(25) G:'$L(XQZ) NXT S:XQZ'[U XQZ=U_XQZ I XQZ["[" D DO^%XUCI G NXT
 D @XQZ
 G NXT
 ;
L ;OE/RR Limited Option type
O ;OE/RR Protocol (orderables) type option entry point
X ;OE/RR Extended Action type option (Subset of Protocol type)
Q ;OE/RR Protocol Menu type option entry point
 S XQOR=+XQY,XQOR(1)=XQT D XQ^XQOR K XQOR
 G NXT
 Q
