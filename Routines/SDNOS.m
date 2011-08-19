SDNOS ;ALB/LDB - NO SHOW REPORT ; 18 May 99  8:43 AM
 ;;5.3;Scheduling;**22,28,32,79,194,410**;Aug 13, 1993
 D END,LO^DGUTL
 S (SDCL,X)="" S SDDIV=$$PRIM^VASITE() S SDIO=IO(0),(SDA,SDB1,SDC,SDV1,SDEND,SDSL,SDT,SDTIM)=0
DIV I $D(^DG(43,1,"GL")),$P(^("GL"),"^",2) S DIC("A")="NO SHOW REPORT FOR WHICH DIVISION: " D ASK^SDDIV S SDV1=1,SDDIV=$S($D(DIV):DIV,1:SDDIV) D MDIV Q:'$D(Y)
SEL F SDSL=1:1 D READ D:(X="^")!SDTIM END Q:'$D(X)  Q:((X="")&(SDSL>1))  Q:SDA  D  Q:X=""&(SDSL=1)
 .W:(Y'>0&'SDB1&'SDT&'SDC) !,"No such clinic"
 .W:SDV1&'SDB1&SDDIV&(Y'>0)&'SDT&'SDC " associated with this division."
 .S:Y'>0 SDSL=SDSL-1 S (SDB1,SDC,SDT)=0
 .Q
 Q:'$D(X)  S:X=""&(SDSL=1) SDCL="A"
 I SDTIM=1 D END Q
 I 'SDA,(X="^")!(SDCL(1)']"")&(Y=-1) D END Q
FMT ;Select Format
 S DIR(0)="S^1:No Shows ONLY;2:Both No Shows & No Action Taken"
 S DIR("?")="Select format for printed report"
 S DIR("B")="No Shows ONLY"
 D ^DIR K DIR S SDFMT=Y
DATE W !!,"You may enter only a beginning date if you would like",!,"to see a report of No-Shows for only one date."
 S SDT00="AEP",%DT(0)="-NOW" D DATE^SDUTL I ('$D(SDBD))&((X="^")!(X="")) D END Q
 I '$D(SDED)&(X="^") D END Q
 N DIR,SDABB S DIR(0)="Y",DIR("A")="Print report totals only",DIR("B")="YES"
 S DIR("?")="Answer 'no' to obtain a detailed report, 'yes' to print just clinic totals"
 W ! D ^DIR G:$D(DTOUT)!$D(DUOUT) END S SDABB=Y
ZIS W !! S DGPGM="^SDNOS0",DGVAR="SDCL#^SDDIV"_$S($D(SDBD):"^SDBD",1:"")_$S($D(SDED):"^SDED",1:"")_"^SDIO^SDABB^SDFMT"
 D ZIS^DGUTQ G:POP END U IO D ^SDNOS0
 D END,CLOSE^DGUTQ Q
 ;
READ ;Select clinics
 W !,"Select Clinic(s):"_$S(SDSL<2:" ALL// ",1:" ") R X:DTIME S:'$T SDTIM=1 Q:'$T!(X="^")!('$D(SDCL(2))&(SDSL>1)&(X=""))  I X["?" D HELP
VALID S X=$$UP^XLFSTR(X) I ((X="")&(SDSL<2))!(X="ALL")&(SDSL<2) S SDCL(1)="ALL",SDA=1 Q
 I X=""&(SDSL>1) Q
 S SDM="$S(SDDIV'=""A""&$P(^(0),""^"",15):$P(^(0),""^"",15)=SDDIV,1:$P(^(0),""^"",15)="""")"
 S DIC=44,DIC(0)="EQ",DIC("S")="I $P(^(0),""^"",3)=""C"",'$G(^(""OOS""))"
 S DIC("S")=$S(SDDIV'="A"&SDV1:DIC("S")_","_SDM,1:DIC("S"))
 I X?1"*".E S SDT=X,X=$E(X,2,$L(X)) D ^DIC Q:Y'>0  D INAC Q:Y'>0  S SDCL(SDSL)=+Y_$E(SDT,1)_$E(SDT,$F(SDT,"*"),$L(SDT)) Q
 D ^DIC Q:Y'>0
 S SDB1=0 I $D(SDCL)#10 F SDSB=0:0 S SDSB=$O(SDCL(SDSB)) Q:SDSB'>0  I SDCL(SDSB)=+Y W !,*7,"This clinic has all ready been selected",! S Y=-1,SDB1=1 Q
 I 'SDB1 D INAC Q:Y'>0  S SDCL(SDSL)=+Y Q
 Q
 ;
HELP W !!,"Enter the clinic name here. Press return when you are finished choosing clinics.",!,"You may ask for a range of clinics by preceding the clinic or"
 W !,"letter(s) that begin the clinic name with an asterisk. For example,"
 W !,"if you would like to see all clinics that begin with MED, you could enter ",!,"*MED or *CT for all clinics that begin with CT."
 W !,"You will then be asked to choose which actual clinic will begin the range.",!,"When you have chosen one, all clinics that contain the initial response for "
 W !,"range and follow your choice in alphabetic order will be included in the report.",!
 Q
 ;
INAC ;Determine if clinic is inactive
 S SDC=+Y,X="T" D ^%DT S DT=Y
 I $D(^SC(SDC,"I")),$P(^("I"),U),$P(^("I"),U)'>DT W *7,!,"Clinic ",$S('$P(^("I"),U,2):"is",1:"was")," inactive ",$S('$P(^("I"),U,2):"as of ",1:"from ") S Y=$P(^("I"),U) D D^DIQ W Y
 I  I $P(^SC(SDC,"I"),U,2) S Y=$P(^("I"),U,2) D D^DIQ W " to ",Y,! D ASK Q
 I $D(^SC(SDC,"I")),$P(^("I"),U),$P(^("I"),U)'>DT,'$P(^("I"),U,2) S Y=+SDC W ! D ASK Q
 S Y=+SDC Q
ASK S %=2 S Y=+SDC W !,"Do you wish to include this clinic in the report" D YN^DICN I %=1 W ! S Y=+SDC Q
 I %=-1!(%=2) S Y=-1 W ! Q
 I '% W !,"Enter 'Yes' to include clinic in this report or 'No' to exclude from the report." G ASK
 ;
END K %DT,ALL,BEGDATE,C,C1,C2,C3,C4,C5,C6,DGPGM,DGTCH,DGVAR,DIC,DIV
 K ENDDATE,P1,POP,Q,SD,SD1,SD10,SD12,SD14,SD2,SDA,SDAPP,SDB1,SDBD
 K SDBEG,SDBEG1,SDBG,SDC,SDCHK,SDCL,SDCL1,SDCT,SDCXX,SDDIV,SDV1
 K SDDIV2,SDDIVO,SDED,SDEF,SDEN,SDEND,SDHD,SDIN,SDI1,SDABB,SDT00
 K %I,%Y,%T,SDIO,SDIX,SDLAB,SDM,SDNM,SDNM1,SDNMS,SDNO,SDOK,SDOW
 K SDPAT,SDPR,SDPR1,SDPT,SDR,SDR1,SDRB,SDREST,SDSL,SDSUB,SDSB
 K SDT1,SDT2,SDT3,SDT4,SDT5,SDT6,SDT,SDTIM,SDTOT,SDTOT1,SDX,SDXX
 K SDY,SDZ,SDZ1,SDZZ3,X,X1,Y,Y1,Y2,Y3,%,^UTILITY($J,"DGTC"),SDFMT
END1 K DTOUT,DUOUT,^UTILITY($J,"SDNO") Q
 ;
MDIV I Y'>0 D END,CLOSE^DGUTQ Q
 I $D(ALL),ALL S SDDIV="A" Q
 Q
