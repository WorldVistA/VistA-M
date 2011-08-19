PSNCMOP ;BIR/DMA&WRT-print products marked for CMOP ; 12/07/98 14:33
 ;;4.0; NATIONAL DRUG FILE;**3**; 30 Oct 98
PRELIM W !,"This report will print out all VA Product Names marked for CMOP transmission.",!,"You may either sort by VA Product Name or by VA Identifier.",!
 W "This information comes from the VA Products file (NATIONALLY MARKED).",!,?15,"*** This is a long report ***",!,"You may queue the report to print, if you wish.",!!
 K DIR S DIR(0)="SA^I:IDENTIFIER;N:NAME",DIR("A")="Sort by VA Identifier (I) or VA Product Name (N)? " D ^DIR G END:$D(DIRUT) S S=Y
 S ZTSAVE("S")="" D EN^XUTMDEVQ("GO^PSNCMOP","PRINT DRUGS MARKED FOR CMOP",.ZTSAVE) I POP W !,"No device selected",!
END K DIR,S,X,Y,ZTSAVE,^TMP($J,"PSN") Q
 ;
GO ;ENTRY POINT
 K ^TMP($J,"PSN") D @S
 S:$D(ZTQUEUED) ZTREQ="@" K DA,DIR,ID,LINE,NA,PG,PR,S,TD,UN,X0,X1,Y,^TMP($J) D ^%ZISC Q
 ;
I ;SORT BY ID
 S DA=0 F  S DA=$O(^PSNDF(50.68,DA)) Q:'DA  S X0=^(DA,0),X1=^(1) I $P(X1,"^",3) S ID=$P(X1,"^",2),NA=$P(X0,"^",1),UN=$P(X1,"^",4),UN=$P($G(^PSNDF(50.64,+UN,0)),"^"),^TMP($J,"PSN",ID,NA,UN)=""
 S PG=1,TD=$TR($$HTE^XLFDT($H),"@"," "),$P(LINE,"-",IOM-1)="" D HEADID
 S ID="" F  S ID=$O(^TMP($J,"PSN",ID)),NA="" Q:ID=""  F  S NA=$O(^TMP($J,"PSN",ID,NA)),UN="" Q:NA=""  F  S UN=$O(^TMP($J,"PSN",ID,NA,UN)) Q:UN=""  W !,ID,?10,NA,?60,UN I $Y+4>IOSL D HEADID
 Q
 ;
HEADID W:$Y @IOF W !,?12,"VA PRODUCT LIST",?IOM-35," ",TD," PAGE ",PG,!,"ID#",?10,"VA PRINT NAME",?55,"VA DISP UNIT",!,LINE,! S PG=PG+1 Q
 ;
 ;
N ;SORT BY NAME
 S DA=0 F  S DA=$O(^PSNDF(50.68,DA)) Q:'DA  S X0=^(DA,0),X1=^(1) I $P(X1,"^",3)]"" S NA=$P(X0,"^"),PR=$P(X1,"^"),UN=$P(X1,"^",4),UN=$P($G(^PSNDF(50.64,+UN,0)),"^"),ID=$P(X1,"^",2),^TMP($J,"PSN",NA,PR,UN,ID)=""
 S PG=1,TD=$TR($$HTE^XLFDT($H),"@"," "),$P(LINE,"-",IOM-1)="" D HEADNA
 S NA="" F  S NA=$O(^TMP($J,"PSN",NA)),PR="" Q:NA=""  F  S PR=$O(^TMP($J,"PSN",NA,PR)),UN="" Q:PR=""  F  S UN=$O(^TMP($J,"PSN",NA,PR,UN)),ID="" Q:UN=""  F  S ID=$O(^TMP($J,"PSN",NA,PR,UN,ID)) Q:ID=""  D
 .W !,NA,!,?7,PR,?60,UN,?70,ID I $Y+4>IOSL D HEADNA
 Q
 ;
HEADNA W:$Y @IOF W !,?12,"VA PRODUCT LIST",?IOM-35," ",TD," PAGE ",PG,!,"VA PRODUCT NAME",!,?5,"VA PRINT NAME",?55,"VA DISP UNIT",?70,"ID#",!,LINE,! S PG=PG+1 Q
