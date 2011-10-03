ENWOLD ;(WIRMFO)/DH-Delete Old Incomplete PM Work Orders ;12/1/1999
 ;;7.0;ENGINEERING;**35,64**;Aug 17,1993
 ;
 ;  Check for old incomplete PM work orders
 ;    If count>500 user may schedule automatic deletion
 ;
 ;  Sets global node if appropriate
 ;  User prompted for cut-off date and execution time
 ;  Cut-off date may not be more recent than T-365
EN ;
 I $P($G(^ENG(6920,0)),U,4)'>300 G EXIT ;Why bother?
 N DA,SHOP,COUNT,LINE
 D HOME^%ZIS
 S Y=$$FMADD^XLFDT(DT,-365) S %DT(0)=-Y X ^DD("DD") S %DT("B")=Y
 W !!,"NOTE: Creation Dates more recent than "_%DT("B")_" will not be",!,"      accepted.",!,*7
 S %DT="AEP" S %DT("A")="Delete Incomplete PM Work Orders created prior to: "
 D ^%DT I X=U!($D(DTOUT)) G EXIT
 G:Y'>0 EN ;Shouldn't happen
 S ENSTART=+Y ;Inverse start date (counting backwards)
 X ^DD("DD") S ENSTART("E")=Y
 S DA=$O(^ENG(6920,9999999999),-1),COUNT("TOT")=0,ENX=1
 W !,"Counting."
 F  S DA=DA-50 Q:DA'>0  S X=$P($G(^ENG(6920,DA,0)),U,2) I X]"",X<ENSTART Q
 F  Q:$P($G(^ENG(6920,DA+1,0)),U,2)>(ENSTART-1)  S DA=DA+1
 S ENDA("START")=DA ;Starting point for 'AINC' x-ref, inverse chronology
 S SHOP=0 F  S SHOP=$O(^ENG(6920,"AINC",SHOP)) Q:'SHOP  D
 . S ENDA=9999999999-ENDA("START"),COUNT(SHOP)=0
 . F  S ENDA=$O(^ENG(6920,"AINC",SHOP,ENDA)) Q:'ENDA  D
 .. S DA=9999999999-ENDA
 .. I $E($P($G(^ENG(6920,DA,0)),U),1,3)="PM-" S COUNT("TOT")=COUNT("TOT")+1,COUNT(SHOP)=COUNT(SHOP)+1
 .. I '(DA#100) W "." S ENX=ENX+1 I ENX>IOM W !
 I COUNT("TOT")>500 D  G EXIT
 . S Y=ENSTART X ^DD("DD")
 . W @IOF,"There are about "_COUNT("TOT")_" incomplete PM work orders on your system that were"
 . W !,"created prior to "_ENSTART("E")_". The following is a breakout by shop:"
 . K X S $P(X,"-",79)="-" W !,X S LINE=4
 . S SHOP=0 F  S SHOP=$O(COUNT(SHOP)) Q:'SHOP  D:COUNT(SHOP)>0
 .. S ENSHOP(SHOP)=COUNT(SHOP)
 .. I $D(^DIC(6922,SHOP,0)) W !,$P(^(0),U),?30,COUNT(SHOP) S LINE=LINE+1
 .. I (IOSL-LINE)'>2 R !,"Press <RETURN> to continue...",X:DTIME S LINE=2
 . K DIR S DIR(0)="Y",DIR("A")="Would you like to schedule a task to delete these work orders",DIR("B")="YES"
 . D ^DIR K DIR Q:$D(DIRUT)!('Y)
 . S ZTRTN="DEQUE^ENWOLD",ZTDESC="Delete old incomplete PM work orders"
 . S ZTSAVE("EN*")="",ZTIO="" D ^%ZTLOAD K ZTSK
 W !!,"Fewer than 500 existing incomplete PM work orders were created prior to ",!,ENSTART("E")_". No need to continue."
 R !!,"Press <RETURN> to continue...",X:DTIME
EXIT K %DT,ENDA,ENSTART,ENSHOP,ENX
 Q
 ;
DEQUE N EN,SHOP,DA,DIK,COUNT S COUNT=0
 S DIK="^ENG(6920,",SHOP=0
 F  S SHOP=$O(ENSHOP(SHOP)) Q:'SHOP  D
 . S ENDA=9999999999-ENDA("START")
 . F  S ENDA=$O(^ENG(6920,"AINC",SHOP,ENDA)) Q:'ENDA  D
 .. S DA=9999999999-ENDA
 .. I $E($P($G(^ENG(6920,DA,0)),U),1,3)="PM-" S COUNT=COUNT+1 D ^DIK
MSG ;
 S XMY(DUZ)="",XMDUZ=.5,XMSUB="Deletion of Old Incomplete PM Work Orders"
 S EN(1)=COUNT_" old incomplete PM work orders were just deleted."
 S XMTEXT="EN("
 D ^XMD
 K XMY,XMDUZ,XMTEXT,XMSUB,ENDA,ENSTART,ENSHOP
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;ENWOLD
