ECXUTLA ;ALB/JAP - Utilities for Audit Reports ; 4/16/08 4:04pm
 ;;3.0;DSS EXTRACTS;**8,14,112**;Dec 22, 1997;Build 26
 ;
AUDIT(ECXHEAD,ECXERR,ECXARRAY,ECXAUD) ;set audit report parameters
 ;   input
 ;   ECXHEAD  = extract HEADER CODE (required)
 ;              (from file #727.1, field #7)
 ;   ECXERR   = passed-by-reference variable (required)
 ;   ECXARRAY = passed-by-reference array (required)
 ;   ECXAUD   = 0/1 (optional)
 ;              0 --> extract audit (default)
 ;              1 --> SAS audit
 ;   output
 ;   ECXARRAY = array of audit parameters
 ;              ECXARRAY("DEF")     = ien of extract type in file #727.1
 ;              ECXARRAY("TYPE")    = print name for extract; field #7 in file #727.1
 ;              ECXARRAY("EXTRACT") = ien of extract in file #727
 ;              ECXARRAY("START")   = start date for extract audit
 ;              ECXARRAY("END")     = end date for extract audit
 ;              ECXARRAY("ERUN")    = date on which extract was generated
 ;              ECXARRAY("DIV")     = ien of station if file #4
 ;   error CODE
 ;   ECXERR   = 1, if input problem occurs
 ;              0, otherwise
 ;
 N X,Y,N,DA,DIC,DIQ,DIR,DTOUT,DUOUT,DIRUT,ECXDA,ECXTYPE,ECXSTART,ECXEND,ECXARR
 S ECXERR=0
 S N=$O(^ECX(727.1,"C",ECXHEAD,"")) S:N="" ECXERR=1
 Q:ECXERR
 S DIC="^ECX(727.1,",DIC(0)="NZ",X=N
 D ^DIC I Y=-1 S ECXERR=1 Q
 S ECXTYPE=$P(Y(0),U,7)_U_+Y K X,Y,DIC
 I $G(ECXAUD)=1,ECXHEAD'="DEN",ECXHEAD'="PRE",ECXHEAD'="RAD",ECXHEAD'="SUR" S ECXERR=1
 Q:ECXERR
 S DIC="^ECX(727,",DIC(0)="AEMQ",DIC("S")="I $P(^(0),U,3)=$P(ECXTYPE,U),'$D(^(""PURG""))"
 D ^DIC
 I Y=-1!($G(DUOUT))!($G(DTOUT)) S ECXERR=1 Q
 S DIC="^ECX(727,",(DA,ECXDA)=+Y,DR=".01;1;2;3;4;5;15;300",DIQ="ECXARR",DIQ(0)="IE"
 D EN^DIQ1
 W !!,?5,"Extract:      ",ECXARR(727,ECXDA,2,"E")," #",ECXDA
 W !!,?5,"Start date:   ",ECXARR(727,ECXDA,3,"E")
 W !,?5,"End date:     ",ECXARR(727,ECXDA,4,"E")
 W !,?5,"# of Records: ",ECXARR(727,ECXDA,5,"E")
 I ECXHEAD="PRO" W !,?5,"Station:      ",ECXARR(727,ECXDA,15,"E")
 ;if transmit date exists, then ask user if audit still needed
 I $L(ECXARR(727,ECXDA,300,"E"))>0 D
 .W !!,?5,"The extract which you have chosen to audit"
 .W !,?5,"was transmitted to Austin/DSS on ",ECXARR(727,ECXDA,300,"E"),".",!
 .S DIR(0)="Y",DIR("A")="Do you want to continue with this audit report",DIR("B")="NO" D ^DIR
 .S:$G(DIRUT) ECXERR=1 S:Y=0 ECXERR=1
 Q:ECXERR
 ;setup the return array
 S ECXARRAY("EXTRACT")=ECXARR(727,ECXDA,.01,"E"),ECXARRAY("DIV")=ECXARR(727,ECXDA,15,"I"),ECXARRAY("TYPE")=$P(ECXTYPE,U),ECXARRAY("DEF")=$P(ECXTYPE,U,2)
 S ECXARRAY("START")=ECXARR(727,ECXDA,3,"E"),ECXARRAY("END")=ECXARR(727,ECXDA,4,"E"),ECXARRAY("ERUN")=ECXARR(727,ECXDA,1,"E")
 ;determine date range only for extract audit reports
 I $G(ECXAUD)=0 D
 .S ECXSTART=ECXARRAY("START"),ECXEND=ECXARRAY("END") D RANGE^ECXUTLA(.ECXSTART,.ECXEND,.ECXERR)
 .I ECXERR K ECXARRAY
 .Q:ECXERR
 .S ECXARRAY("START")=ECXSTART,ECXARRAY("END")=ECXEND
 Q
 ;
RANGE(ECXSTART,ECXEND,ECXERR) ;determine date range for extract audit report
 ;   input
 ;   ECXSTART = start date of extract in file #727 (required)
 ;              passed by reference
 ;   ECXEND   = end date of extract in file #727 (required)
 ;              passed by reference
 ;   ECXERR   = passed by reference (required)
 ;   output
 ;   ECXSTART = user selected start date
 ;   ECXEND   = user selected end date
 ;   error CODE
 ;   ECXERR   = 1, if input problem occurs
 ;              0, otherwise
 ;
 ;
 ;convert dates to internal format
 N DATEA,DATEB,X,Y,%DT,DTOUT,OUT
 S (ECXERR,OUT)=0
 S X=ECXSTART D ^%DT S DATEA=Y
 S X=ECXEND D ^%DT S DATEB=Y
 ;allow user to select start date
 ;can't be less than ecxstart or greater than ecxend
 W !!,?5,"You can narrow the date range, if you wish.",!
 W !,?5,"The Start Date can't be earlier than ",ECXSTART,","
 W !,?5,"or later than ",ECXEND,".",!
 F  Q:OUT!ECXERR  D
 .S %DT="AEX",%DT("A")="Select Start Date: ",%DT("B")=ECXSTART,%DT(0)=DATEA
 .D ^%DT S:Y=-1 ECXERR=1 S:$G(DTOUT) ECXERR=1
 .Q:ECXERR
 .I Y>DATEB D  Q
 ..W !,?5,"But that's later than ",ECXEND,"...try again.",!
 .S DATEA=Y,OUT=1
 I ECXERR K ECXSTART,ECXEND
 Q:ECXERR
 S Y=DATEA D DD^%DT S ECXSTART=Y
 ;allow user to select end date
 ;can't be less than ecxstart or greater than ecxend
 W !!,?5,"The End Date can't be earlier than ",ECXSTART
 W !,?5,"(the Start Date you selected), or later than ",ECXEND,".",!
 S OUT=0
 F  Q:OUT!ECXERR  D
 .S %DT="AEX",%DT("A")="Select End Date: ",%DT("B")=ECXEND,%DT(0)=-DATEB
 .D ^%DT S:Y=-1 ECXERR=1 S:$G(DTOUT) ECXERR=1
 .Q:ECXERR
 .I Y<DATEA D  Q
 ..W !,?5,"But that's earlier than ",ECXSTART,"...try again.",!
 .S DATEB=Y,OUT=1
 I ECXERR K ECXSTART,ECXEND
 Q:ECXERR
 S Y=DATEB D DD^%DT S ECXEND=Y
 Q
 ;
DEVICE(ZTRTN,ZTDESC,ZTSAVE) ;get print device and optionally task to background
 ;   input
 ;   ZTRTN  = line^routine; task entry point (required)
 ;            variable for %ZTLOAD
 ;   ZTDESC = task description (required)
 ;            variable for %ZTLOAD
 ;   ZTSAVE = array; passed by reference (required)
 ;            variables for %ZTLOAD
 ;   output
 ;   ZTSAVE = returns ZTSAVE("POP"),ZTSAVE("ZTSK")
 ;
 N POP,ZTSK
 S ZTSAVE("POP")=0,ZTSAVE("ZTSK")=0
 ;return ztsave("pop")=1 and quit if required input not available
 I '$L(ZTRTN)!('$L(ZTDESC))!('$D(ZTSAVE)) S ZTSAVE("POP")=1 Q
 ;get print device
 K IO("Q") S %ZIS="QM" D ^%ZIS
 S ZTSAVE("POP")=POP
 I POP D
 .W !,"No device selected...exiting.",!
 Q:POP
 I $D(IO("Q")) D
 .S ZTSAVE("ZTREQ")="@"
 .D ^%ZTLOAD
 .I $G(ZTSK)>0 D
 ..W !,"Request queued as Task #",ZTSK,".",!
 ..S ZTSAVE("ZTSK")=ZTSK
 ..S ZTSAVE("POP")=0
 .I '$G(ZTSK) D
 ..W !,"Request to queue cancelled...exiting.",!
 ..S ZTSAVE("ZTSK")=0
 ..S ZTSAVE("POP")=1
 Q
 ;
WARDS(ECXALL,ECXDIV) ;get wards for selected divisions
 ;   input
 ;   ECXALL = 1/0 (optional)
 ;            1==> user selected all divisions OR
 ;                 facility is non-divisional
 ;            0==> user selected some divisions
 ;            if ECXALL not defined, then assume 1
 ;   ECXDIV = array of divisions selected (optional)
 ;            passed by reference array containing
 ;            selected divisions;
 ;            if ECXALL=1, then ECXDIV array isn't
 ;            required; information for all wards will be obtained
 ;            if ECXALL=0, then only wards for divisions in ECXDIV
 ;   output
 ;   ^TMP($J,"ECXWARD", contains ward name, division, g&l order
 ;   ^TMP($J,"ECXORDER", contains ward grouping info
 ;
 N IEN,WARD,ORDX,NAME,NM,ORDER,DIV,HIEN,GROUP,DATA,DEPT,NAMEDEPT
 K ^TMP($J,"ECXWARD"),^TMP($J,"ECXORDER")
 ;if ecxall not here, then set ecxall=1
 S:'$D(ECXALL) ECXALL=1 S:ECXALL="" ECXALL=1
 S ORDX=0,NM=""
 F  S NM=$O(^DIC(42,"B",NM)) Q:NM=""  S IEN=0 F  S IEN=$O(^DIC(42,"B",NM,IEN)) Q:IEN=""  D
 .S DIV=+$P(^DIC(42,IEN,0),U,11) Q:DIV=0
 .I ECXALL=0,'$D(ECXDIV(DIV)) Q
 .S (NAME,ORDER,DEPT)="",NAME=$P(^DIC(42,IEN,0),U,1),ORDER=+$P($G(^DIC(42,IEN,"ORDER")),U,1),DEPT=$P($G(^ECX(727.4,IEN,0)),U,2)
 .;'unordered' ward is probably inactive, but get basic data anyway
 .I ORDER=0 S ORDX=ORDX+1,ORDER="99999"_ORDX,ORDER=+ORDER
 .;get this ward's ien in file #44; file #727.802 & #727.808 use pointers to file #44
 .S HIEN=+$P($G(^DIC(42,IEN,44)),U,1) Q:HIEN=0
 .;if this is last ward in group, then get the group name
 .K GROUP I $D(^DIC(42,IEN,1,1,0)) S GROUP=$P(^DIC(42,IEN,1,1,0),U,1) I GROUP="" K GROUP
 .S ^TMP($J,"ECXWARD",HIEN)=ORDER_U_NAME_U_DIV_U_IEN_U_DEPT
 .I $D(GROUP) S ^TMP($J,"ECXWARD",HIEN,1)=GROUP
 ;after all wards in file #42 are processed, arrange by g&l order
 S HIEN=0
 F  S HIEN=$O(^TMP($J,"ECXWARD",HIEN)) Q:HIEN=""  S DATA=^TMP($J,"ECXWARD",HIEN) D
 .S ORDER=$P(DATA,U,1),NAME=$P(DATA,U,2),DIV=$P(DATA,U,3),DEPT=$P(DATA,U,5)
 .S NAMEDEPT=NAME S:DEPT]"" NAMEDEPT=NAME_" <"_DEPT_">"
 .S ^TMP($J,"ECXORDER",DIV,ORDER)=HIEN_U_NAMEDEPT_U
 .I $D(^TMP($J,"ECXWARD",HIEN,1)) S GROUP=^(1),^TMP($J,"ECXORDER",DIV,ORDER,1)=1_U_GROUP_U
 Q
 ;
SASHEAD(ECXFL,ECXHEAD,ECXDIV,ECXARRAY,ECXPG,ECXTAB) ;header and page control
 ;
 ;   ECXFL   = feeder location (division) (required)
 ;   ECXHEAD = extract header from file #727.1 (required)               
 ;   ECXDIV  = array of divisions selected (required)
 ;   ECXPG   = page number (required)
 ;   ECXTAB  = tab location;
 ;             allows for proper spacing in sub-header line (optional)
 ;
 N JJ,SS,LN
 S $P(LN,"-",80)=""
 I $G(ECXTAB)="" S ECXTAB=40
 I $E(IOST)="C" D
 .S SS=22-$Y F JJ=1:1:SS W !
 .I PG>0 S DIR(0)="E" W ! D ^DIR K DIR S:'Y QFLG=1
 Q:QFLG
 W:$Y!($E(IOST)="C") @IOF S ECXPG=ECXPG+1
 W !,"SAS Audit Report for "_ECXARRAY("TYPE")_" ("_ECXHEAD_") Extract"
 W !,"DSS Extract Log #:    "_ECXARRAY("EXTRACT")
 W !,"Date Range of Audit:  "_ECXARRAY("START")_" to "_ECXARRAY("END")
 W !,"Report Run Date/Time: "_ECXRUN
 I $D(ECXDIV(ECXFL)) W !,"Division/Site:        "_$P(ECXDIV(ECXFL),U,2)_" ("_ECXFL_")",?68,"Page: "_ECXPG
 I '$D(ECXDIV(ECXFL)) W !,"Division/Site:        "_"Unknown",?68,"Page: "_ECXPG
 W !!,"Feeder Location",?ECXTAB,"Feeder Key",?68,"Quantity"
 W !,LN,!
 Q
