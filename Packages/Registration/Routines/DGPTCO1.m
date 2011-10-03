DGPTCO1 ;ALB/MJK - Census Status Report ; 5/2/05 2:41pm
 ;;5.3;Registration;**136,383,432,696,729,839**;Aug 13, 1993;Build 3
 ;
EN D CHKCUR W ! D DATE
 S DIC("A")="Generate PTF Census Status Report for Census date: ",DIC="^DG(45.86,",DIC(0)="AEMQ" S:Y]"" DIC("B")=Y
 D ^DIC K DIC G ENQ:Y<0
 S DGCN=+Y,DGCDT=+$P(Y,U,2)_".9" K DGCHOICE
 D DIV^DGPTCO2 G ENQ:'$D(DGCHOICE("DIV"))
 D STATUS^DGPTCO2 G ENQ:'$D(DGCHOICE("STATUS"))
 S %ZIS="NQ" D ^%ZIS K %ZIS G ENQ:POP D DOQ G ENQ:POP S DGIOP=ION_";"_IOM_";"_IOSL
 I 'DGQ D START G ENQ
 S ZTRTN="START^DGPTCO1",ZTIO=DGIOP,ZTDESC="Census Status Report"
 F X="DGCHOICE(","DGCDT","DGCN","DGIOP" S ZTSAVE(X)=""
 D ^%ZTLOAD D ^%ZISC
ENQ K DGQ,DHIT,DIOEND,DGC,DGCN,DGCDT,DGIOP,DGCHOICE,DIS
 Q
 ;
START ; -- produce report
 ;Lock global to prevent duplicate entries in Census Workfile
 L +^DG(45.85,"DGPT CENSUS REGEN WORKFILE"):5 I '$T D   Q
 .N DGPTMSG
 .D BLDMSG^DGPTCR
 .I $E(IOST,1,2)'="C-" D SNDMSG^DGPTCR,ENQ Q
 .N DGPTLINE
 .S DGPTLINE=0
 .F  S DGPTLINE=$O(DGPTMSG(DGPTLINE)) Q:'DGPTLINE  W !,?5,DGPTMSG(DGPTLINE,0)
 .Q
 I '$D(^DG(45.85,"ACENSUS",DGCN)) D REGEN^DGPTCR
 S DIC="^DG(45.85,",(BY,FLDS)="[DGPT WORKFILE]",L=0,FR=DGCN_",,@",TO=DGCN_",,"
 I DGCHOICE("STATUS")'="All" S (FR,TO)=DGCN_",,"_DGCHOICE("STATUS")
 S DIS(0)="D DIS^DGPTCO1",DHIT="D DHIT^DGPTCO1",DIOEND="D DIOEND^DGPTCO1"
 S Y=$P(DGCDT,".") X ^DD("DD") S DHD="Census Status Report for "_Y
 S IOP=DGIOP K DGC
 D EN1^DIP,ENQ
 L -^DG(45.85,"DGPT CENSUS REGEN WORKFILE")
END Q
 ;
DIOEND ; -- logic called at end of rpt for totals
 I $E(IOST)="C" S DIR(0)="E" D ^DIR K DIR G DIOENDQ:X="^"
 N D,S,Z S D="",Z="zzzz",$P(DGLN,"-",81)="" D NOW^%DTC S Y=% X ^DD("DD")
 W @IOF,?30,"Census Status Report",?59,Y,!!?26,"Division Summary Statistics",!
 ;
 F I=0:0 S D=$O(DGC(D)) Q:D=""  D DIV S S="" F J=0:0 S S=$O(DGC(D,S)) Q:S=""  S C=DGC(D,S) D PRT I $O(DGC(D,S))=Z D TOT Q
 W !,DGLN,!
 I $E(IOST)="C" S DIR(0)="E" D ^DIR K DIR
DIOENDQ K C,DGLN Q
 ;
DIV ;
 W !,DGLN
 I D="TOT" W !!?5,"OVERALL STATISTICS:" Q
 W:$D(^DG(40.8,+D,0)) !?5,$P(^(0),U),":"
 Q
 ;
TOT ;
 W !?10,$S(D="TOT":"Grand Total: ",1:"Division Total: "),?30,$J(DGC(D,Z),4)
 Q
 ;
PRT ;
 W !?10,S,": ",?30,$J(C,4)
 S:D'="TOT" DGC("TOT",S)=$S($D(DGC("TOT",S)):DGC("TOT",S),1:0)+C,DGC("TOT",Z)=$S($D(DGC("TOT",Z)):DGC("TOT",Z),1:0)+C
 Q
 ;
DIS ; -- $T logic for each entry
 N X S X=^DG(45.85,D0,0)
 I DGCHOICE("DIV")=1 G DISQ
 I $D(DGCHOICE("DIV",$S($D(^DIC(42,+$P(X,U,6),0)):+$P(^(0),U,11),1:0)))
DISQ Q
 ;
DHIT ; -- logic called for each entry printed cum stats; DGC(div,status)
 N D,S,Z S Z="zzzz" D STATUS
 S S=X,D=$S($D(^DIC(42,+$P(^DG(45.85,D0,0),U,6),0)):+$P(^(0),U,11),1:0)
 S DGC(D,S)=$S($D(DGC(D,S)):DGC(D,S),1:0)+1,DGC(D,Z)=$S($D(DGC(D,Z)):DGC(D,Z),1:0)+1
 Q
 ;
FIND ; -- find CENSUS rec#
 ;  input: D0 := ifn of 45.85
 ; output: X  := status ; DGCI := census ifn ; PTF := ptf ifn
 ;
 S DGCI="",X=0,Y=$S($D(^DG(45.85,D0,0)):^(0),1:"")
 G FINDQ:'Y S PTF=+$P(Y,U,12)
 F DGCI=0:0 S DGCI=$O(^DGPT("ACENSUS",PTF,DGCI)) Q:'DGCI  I $D(^DGPT(DGCI,0)),$P(^(0),U,13)=+$P(Y,U,4) S X=+$P(^(0),U,6) Q
FINDQ Q
 ;
STATUS ; -- compute CENSUS status
 D FIND S X=$P($P($P(^DD(45,6,0),U,3),X_":",2),";")
 K DGCI,PTF,Y Q
 ;
CREC ; -- compute CENSUS rec#
 D FIND S X=DGCI
 K DGCI,PTF,Y Q
 ;
DATE ; -- calculate default census date
 S Y=$S($D(^DG(45.86,+$O(^DG(45.86,"AC",1,0)),0)):+^(0),1:"")
 X:Y]"" ^DD("DD")
 Q
DOQ ;-- check if output device is queued. if not ask 
 S DGQ=0
 I $D(IO("Q")) S DGQ=1 G DOQT
 I IO=IO(0) G DOQT
 S DIR(0)="Y",DIR("A")="DO YOU WANT YOUR OUTPUT QUEUED",DIR("B")="YES"
 D ^DIR
 I Y S DGQ=1
DOQT ;
 K Y,DIR
 Q
CHKCUR ; -- checks if new PTF Census Date record is needed
 N DGIEN,DGCLOSE,DGACT,ERR
 S DGIEN=$S($D(^DG(45.86,+$O(^DG(45.86,"AC",1,0)),0)):+^(0),1:"")
 S DGIEN=$O(^DG(45.86,"B",+$G(DGIEN),0))
 S ERR=0
 I 'DGIEN S ERR=1 D ERR Q
 ; look at last census closeout date
 S DGCLOSE=$P($G(^DG(45.86,DGIEN,0)),U,2)
 I 'DGCLOSE S ERR=1 D ERR Q
 I $P($G(^DG(45.86,DGIEN,0)),U)<3070930 D
 . I $E(DGCLOSE,6,7)'=19 S ERR=1
 I $P($G(^DG(45.86,DGIEN,0)),U)>3070930&($P($G(^DG(45.86,DGIEN,0)),U)<=3101231) D
 . I $E(DGCLOSE,6,7)'=14 S ERR=1
 I $P($G(^DG(45.86,DGIEN,0)),U)>3101231 D
 . I $E(DGCLOSE,6,7)'="07" S ERR=1
 S DGACT=$P($G(^DG(45.86,DGIEN,0)),U,4)
 I 'DGACT S ERR=1
 I ERR D ERR Q
 I DT>DGCLOSE D ADDREC
 Q
ADDREC ; -- add new record
 N DA,DIE,DR,DGYR,DGMONTH,DGSTRT,DGENDT,ERR,FDA,IEN696,ERR696
 ; first inactivate last record
 S DA=DGIEN,DIE="^DG(45.86,",DR=".04////0" D ^DIE
 S DGYR=$E(DGCLOSE,1,3)
 ; create new record depending on last closeout date (month)
 S DGMONTH=$E(DGCLOSE,4,5)
 I DGMONTH>"00",DGMONTH<"04" S DGSTRT=DGYR_"0101",DGENDT=DGYR_"0331",DGCLOSE=DGYR_"0407"
 I DGMONTH>"03",DGMONTH<"07" S DGSTRT=DGYR_"0401",DGENDT=DGYR_"0630",DGCLOSE=DGYR_"0707"
 I DGMONTH>"06",DGMONTH<"10" S DGSTRT=DGYR_"0701",DGENDT=DGYR_"0930",DGCLOSE=DGYR_"1007"
 I DGMONTH>"09",DGMONTH<"13" S DGSTRT=DGYR_"1001",DGENDT=DGYR_"1231",DGYR=DGYR+1,DGCLOSE=DGYR_"0107"
 S FDA(696,45.86,"?+1,",.01)=DGENDT
 S FDA(696,45.86,"?+1,",.02)=DGCLOSE
 S FDA(696,45.86,"?+1,",.03)=2970331
 S FDA(696,45.86,"?+1,",.04)=1
 S FDA(696,45.86,"?+1,",.05)=DGSTRT
 D UPDATE^DIE("","FDA(696)","IEN696","ERR696")
 I $D(ERR696) S ERR=1 D ERR
 Q
ERR ;
 D BMES^XPDUTL("Problem with PTF CENSUS DATE File (#45.86).")
 D BMES^XPDUTL("Please notify your Supervisor !!.")
 Q
 ;
