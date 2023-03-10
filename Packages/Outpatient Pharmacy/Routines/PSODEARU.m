PSODEARU ;WILM/BDB - EPCS Utilities and Reports; [5/7/02 5:53am] ;10/5/21  14:50
 ;;7.0;OUTPATIENT PHARMACY;**667**;DEC 1997;Build 18
 ;External reference to DEA NUMBERS file (#8991.9) is supported by DBIA 7002
 ;External reference to XUEPCS DATA file (#8991.6) is supported by DBIA 7015
 ;External reference to XUEPCS PSDRPH AUDIT file (#8991.7) is supported by DBIA 7016
 ;External reference to KEYS sub-file (#200.051) is supported by DBIA 7054
 ;
 Q
 ;
OENDL(PSONS,BDT,EDT,FN) ;
 I '+$G(GUIFLAG) K IOP,%ZIS S PSOION=ION,%ZIS="M" D ^%ZIS I POP S IOP=PSOION D ^%ZIS Q
 N PAGE,LINE,LEN,XTV,ARR,I,J,RHD,HCL,FSP,RDT,DV,DVS,FE
 N HEADER,DIVDA,PSODIV,START,DA,DATA,IEN K DIRUT
 N PROVNAME,EDITOR,FLDNAME,OLDVAL,NEWVAL,EDITDATE,DEA
 K ^XTMP(PSONS,$J),^TMP($J,"EPCSRPT")
 S LD=BDT F  S LD=$O(^XTV(FN,"DT",LD))  Q:'LD!(LD>EDT)  D
 . S ND=0 F  S ND=$O(^XTV(FN,"DT",LD,ND)) Q:'ND  D
 .. Q:'$D(^XTV(FN,ND,0))
 .. S DAT=^XTV(FN,ND,0)
 .. S IEN=$P(DAT,"^")
 .. S (DV,DVS)=0 F  S DV=$O(^VA(200,IEN,2,DV)) Q:('DV)&(DVS>0)  S:'DV DV=999999 D
 ... S DVS=DVS+1
 ... S ^XTMP(PSONS,$J,DV,LD,ND)=""
 I '$D(^XTMP(PSONS,$J)) D  Q
 . U IO W !,"          ***************  NO MATCHING DATA  ***************",!!
 S HEADER="Division^Provider Name^Edited by Name^Field Name^Original Data^Edited Data^Date Edited^"
 I +$G(GUIFLAG) S ROW=1 S ^TMP($J,"EPCSRPT",ROW)=HEADER
 I '+$G(GUIFLAG) U IO W !,$TR(HEADER,"^","|")
 S DIVDA="" F  S DIVDA=$O(^XTMP(PSONS,$J,DIVDA)) Q:'DIVDA  D
 . S PSODIV=$S(DIVDA=999999:"NO DIVISION",1:$$GET1^DIQ(4,DIVDA,.01))
 . S START=0 F  S START=$O(^XTMP(PSONS,$J,DIVDA,START)) Q:'START  D  Q:$D(DIRUT)
 .. S DA=0 F  S DA=$O(^XTMP(PSONS,$J,DIVDA,START,DA)) Q:'DA  D  Q:$D(DIRUT)
 ... S DATA=^XTV(FN,DA,0),IEN=$P(DATA,"^"),FE=$P(DATA,"^",3)
 ... D GETS^DIQ(FN,DA,".01;.02;.03;.04;.05;.06;.08","E","XTV")
 ... S PROVNAME=$G(XTV(FN,DA_",",.01,"E"))
 ... S EDITOR=$G(XTV(FN,DA_",",.02,"E"))
 ... S FLDNAME=$P($G(^DD($S(FE>50:200,1:8991.9),FE,0)),U)
 ... I FE=.04 D
 .... S Y=$P(DATA,"^",4) X ^DD("DD") S OLDVAL=Y
 .... S Y=$P(DATA,"^",5) X ^DD("DD") S NEWVAL=Y
 ... I FE'=.04 D
 .... S OLDVAL=$S($G(XTV(FN,DA_",",.04,"E"))="True":1,$G(XTV(FN,DA_",",.04,"E"))="False":0,1:$G(XTV(FN,DA_",",.04,"E")))
 .... S NEWVAL=$S($G(XTV(FN,DA_",",.05,"E"))="True":1,$G(XTV(FN,DA_",",.05,"E"))="False":0,1:$G(XTV(FN,DA_",",.05,"E")))
 ... S Y=$P($P(DATA,"^",6),".",1) X ^DD("DD") S EDITDATE=Y
 ... S DEA=$P(DATA,"^",8)
 ... S RECORD=PSODIV_U_PROVNAME_U_EDITOR_U_FLDNAME_U_OLDVAL_U_NEWVAL_U_EDITDATE_U_DEA
 ... I +$G(GUIFLAG) S ROW=ROW+1 S ^TMP($J,"EPCSRPT",ROW)=RECORD
 ... I '+$G(GUIFLAG) W !,$TR(RECORD,"^","|")
 I '+$G(GUIFLAG) W !!,"End of Report.  If 'Logging', please turn off 'Logging'.",! K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 Q
EXPORT(PSONS,BDT,EDT,FN) ;Put in delimited format for exporting to Excel
 N GUIFLAG,ROW
 S GUIFLAG=1
 D OENDL^PSODEARU(PSONS,BDT,EDT,FN)
 Q
TYPE ;Prompt for report format or delimited list
 W ! K DIR,Y S DIR(0)="SA^P:Print List;D:Delimited File"
 S DIR("?",1)="Enter 'P' to see the output in a report format,"
 S DIR("?")="enter 'D' for a delimited list that can be exported to excel."
 S DIR("A")="Select (P)rint Report or (D)elimited File: "
 D ^DIR K DIR I $D(DIRUT) S PSOOUT=1 Q
 S PSOTYP=Y
 Q
 ;
DL ;Delimited File message
 ;
 W !!,"You have selected the delimited file output." D YN Q:$G(PSOOUT)
 W @IOF
 W !,"The report output will be displayed on the screen in a delimited format, so"
 W !,"it can be captured and exported.  If you are using Reflections, you can turn"
 W !,"logging on by selecting 'Tools' on the top of the screen, then"
 W !,"select 'Logging' and capture to your desired location.  To avoid undesired"
 W !,"wrapping, you may need to set your terminal session display settings to"
 W !,"180 columns.  Please enter '0;180;9999' at the 'DEVICE:' prompt.  Lines"
 W !,"may need to be deleted at the top and bottom of the logged file before"
 W !,"importing."
 W !!,"The format of the output is as follows, using '|' as the delimiter:"
 W !,"Division|Provider Name|Edited by Name|Field Name|Original Data|Edited Data"
 W !,"|Date Edited"
 D YN
 Q
 ;
YN ;yes or no prompt if no audited fields found for a file
 W ! K DIR,Y,PSOOUT S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 I $D(DTOUT)!($D(DUOUT))!('Y) S PSOOUT=1
 Q
 ;
