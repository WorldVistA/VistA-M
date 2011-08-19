ENARG ;(WCIOFO)/JED,SAB-GATHER ARCHIVAL RECORDS ;10/12/1999
 ;;7.0;ENGINEERING;**40,50,63**;Aug 17, 1993
 ;CALLED BY ENAR1 ;CALLS ENARG1
 Q
G ;GET SORT PARAMS
 D STA G:ENERR'=0 OUT D @ENRT D:ENERR=0 MSG I ENERR'=0 G OUT
G1 W !!,*7,"IS IT O.K. TO PROCEED" S %=2 D YN^DICN G:%<0 G1
 I %=0 W !,"Proceeding will build a list of all records meeting the above criteria,",!,"and give you a count. This may take a considerable amount of time." G G1
 I %'=1 S ENERR="UNCONFIRMED PROCEED" G OUT
 D G^ENARG1,OUT Q
 ;;
1 ;  WORK ORDERS
 D I Q:ENERR'=0
 S DIR(0)="Y",DIR("A")="Include all shops",DIR("B")="YES"
 S DIR("?",1)="You may archive for all shops, for selected shops, or for all shops except"
 S DIR("?")="selected shops."
 D ^DIR K DIR I $D(DIRUT) S ENERR="Shop Selection Failure" Q
 I Y S ENSHOP("ALL")=1,ENPARAM="ALL SHOPS" Q
 S DIR(0)="SM^I:Include selected shops;E:Exclude selected shops"
 S DIR("A",1)="You will next be asked to select one or more shops. Do you wish to archive"
 S DIR("A",2)="work orders for these shops (Include) or to archive work orders for all shops"
 S DIR("A")="except those selected (Exclude)",DIR("B")="Include"
 D ^DIR K DIR I $D(DIRUT)!("^I^E^"'[(U_Y_U)) S ENERR="Shop Selection Failure" Q
 I Y="I" S ENSHOP("INC")=1,ENSHOP("EXC")=0,ENPARAM="INCLUDE SELECTED SHOPS"
 E  S ENSHOP("INC")=0,ENSHOP("EXC")=1,ENPARAM="EXCLUDE SELECTED SHOPS"
 W ! S DIC="^DIC(6922,",DIC(0)="AEQM",DIC("A")=$S(ENSHOP("INC"):"Shop to be INCLUDED in archiving: ",ENSHOP("EXC"):"Shop to be EXCLUDED from archiving: ",1:"") I DIC("A")="" S ENERR="Shop Selection Failure" Q
 F  D ^DIC Q:Y'>0  S ENSHOP(+Y)=$P(Y,U,2)
 I $O(ENSHOP(0))'?1.N S ENERR="Shop Selection Failure" Q
 Q
 ;
2 ;  2162 ACCIDENT REPORTS
 D I S ENPARAM="NONE" Q
3 ;EQUIPMENT INV.
 S X=$$FMADD^XLFDT(DT,-365)
 S DIR(0)="D^:"_X_":EXP"
 S DIR("B")=$$FMTE^XLFDT(X)
 S DIR("A")="Archive Equipment dispositioned as of"
 D ^DIR K DIR I $D(DIRUT) S ENERR="DISPOSITION DATE SELECT" Q
 S ENTO=Y
 S DIR(0)="Y",DIR("A")="Include Accountable NX equipment",DIR("B")="YES"
 S DIR("?",1)="Answer NO to keep Accountable NX equipment from being"
 S DIR("?",2)="archived. Accountable NX equipment is equipment that"
 S DIR("?",3)="has its INVESTMENT CATEGORY field equal to either"
 S DIR("?",3)="CAPITALIZED/ACCOUNTABLE or NOT CAPITALIZED/ACCOUNTABLE."
 S DIR("?",6)=" "
 S DIR("?")="Enter YES or NO"
 D ^DIR K DIR I $D(DIRUT) S ENERR="ACCOUNTABLE NX SELECT" Q
 S ENEQ("A")=Y
 S DIR(0)="Y",DIR("A")="Include JCAHO Inventory equipment",DIR("B")="YES"
 S DIR("?",1)="Answer NO to keep JCAHO Inventory equipment from being"
 S DIR("?",2)="archived. JCAHO Inventory equipment is equipment whose"
 S DIR("?",3)="JCAHO field equals YES."
 S DIR("?",4)=" "
 S DIR("?")="Enter YES or NO"
 D ^DIR K DIR I $D(DIRUT) S ENERR="JCAHO INVENTORY SELECT" Q
 S ENEQ("J")=Y
 S ENPARAM=$S(ENEQ("A"):"INCL",1:"EXCL")_" ACCT NX, "
 S ENPARAM=ENPARAM_$S(ENEQ("J"):"INCL",1:"EXCL")_" JCAHO"
 S ENFR=""
 Q
4 ;  PROJECTS
 S ENERR="Project Archiving is not supported."
 Q
5 ;  CONTROL POINT TRANSACTIONS
 S ENERR="Control Point Activity transactions may be archived only thru IFCAP."
 Q
 ;
STA ;PICK STATION
 I $D(^DIC(6910,1,0)),$P(^(0),"^",2)'="",$P(^(0),"^",1)'="" S ENSTA=$P(^(0),"^",2),ENSTAN=$P(^(0),"^",1) W !,"Station Number: ",ENSTA,!,"Is this correct" S %=1 D YN^DICN Q:%=1  G STA:%=0,P1:%=2 S ENERR="STATION NUMBER" Q
P1 S DIC="^DIC(4,",DIC(0)="AEQN",DIC("A")="Select STATION NUMBER: ",D="B" D IX^DIC S:Y<0 ENERR="STATION NUMBER" K DIC("A") Q:ENERR'=0  S ENSTA=+Y,ENSTAN=$P(Y,"^",2) Q
 ;
I ;INTERVAL SELECTION
 W !,"Do you wish to archive by fiscal YEAR or QUARTER (Y or Q) Y// " R ENR:DTIME S:ENR="" ENR="Y" S ENR=$E(ENR)
 G:"YQyq"[ENR I1 I ENR="?" D  G I
 . W !!,"  Please enter 'Y' for YEAR or 'Q' for QUARTER (or '^' to abort)...",!
 S ENERR="INTERVAL SELECTION"
 Q
 ;
I1 K ENFY,ENQT,ENFR,ENTO
 I "Yy"[ENR D  ; by fiscal year
 . D FY Q:ENERR'=0
 . S ENFR=(ENFY-1700-1)_"1000",ENTO=(ENFY-1700)_"0930"
 I "Qq"[ENR D  ; by quarter
 . D FY Q:ENERR'=0
 . D QTR Q:ENERR'=0
 . I ENQT=1 S ENFR=(ENFY-1700-1)_"1000",ENTO=$E(ENFR,1,3)_"1231"
 . I ENQT=2 S ENFR=(ENFY-1700)_"0100",ENTO=$E(ENFR,1,3)_"0331"
 . I ENQT=3 S ENFR=(ENFY-1700)_"0400",ENTO=$E(ENFR,1,3)_"0630"
 . I ENQT=4 S ENFR=(ENFY-1700)_"0700",ENTO=$E(ENFR,1,3)_"0930"
 Q
 ;
FY ; ask fiscal year
 ; return ENFY or ENERR'=0
 N ENFYT
 S ENFYT=$E(DT,1,3)+1700+$E(DT,4) ; default fiscal year
FY1 W !,"SELECT FISCAL YEAR (4 digits): ",ENFYT,"//"
 R ENFY:DTIME S:'$T ENFY="^" I $E(ENFY)="^" S ENERR="FISCAL YEAR" Q
 S:ENFY="" ENFY=ENFYT
 I ENFY'?4N!(ENFY<1900) D  G FY1
 . W $C(7),!!,"  Please enter the FISCAL YEAR (Oct 1 thru Sep 30) in"
 . W !,"  four digit format. Work orders whose DATE COMPLETE is within"
 . W !,"  this FISCAL YEAR will be archived.",!
 Q
 ;
QTR ; ask quarter
 ; return ENQT or ENERR'=0
 N ENQTT
 S ENQTT=$P("2^2^2^3^3^3^4^4^4^1^1^1",U,$E(DT,4,5)) ; default quarter
QTR1 W !,"SELECT QUARTER (1, 2, 3, or 4): ",ENQTT,"//"
 R ENQT:DTIME S:'$T ENQT="^" I $E(ENQT)="^" S ENERR="FISCAL QUARTER" Q
 S:ENQT="" ENQT=ENQTT
 I ENQT'?1N!(ENQT<1)!(ENQT>4) D  G QTR1
 . W $C(7),!!,"  Answer must be 1, 2, 3, or 4!",!
 Q
 ;
MSG W !!,*7,"You have requested to locate all " S ENMSG="MSG"_ENRT D @ENMSG
 Q
 ;
MSG1 W "work orders completed for " I $G(ENSHOP("ALL")) W "all shops " D MSGA Q
 S X=$S(ENSHOP("INC"):"the following shops:",1:"all shops EXCEPT:") W X
 S I=0 F  S I=$O(ENSHOP(I)) Q:I'?1.N  W !,?5,I,?10,ENSHOP(I)
 W ! D MSGA
 Q
 ;
MSG2 W !,"2162 accident reports, whose occurrence date was" D MSGA
 Q
 ;
MSG3 W "equipment records with a DISPOSITION DATE"
 W !,"prior to ",$$FMTE^XLFDT(ENTO),", "
 W $S(ENEQ("A"):"including",1:"excluding")," Accountable NX equipment and ",$S(ENEQ("J"):"including",1:"excluding")
 W !,"JCAHO Inventory equipment."
 Q
 ;
MSGA W:$X>50 ! W "in Fiscal Year ",ENFY W:$D(ENQT) ", ",ENQT,$S(ENQT=1:"st",ENQT=2:"nd",ENQT=3:"rd",ENQT=4:"th",1:"error")," Quarter" W "." Q
OUT K D,DIC,ENA,ENEQ,ENFR,ENFY,ENFYT,ENMSG,ENPARAM,ENSHOP,ENQT,ENQTT,ENR,ENSH,ENSTA,ENSTAN,ENTO,I,Y Q
 ;ENARG
