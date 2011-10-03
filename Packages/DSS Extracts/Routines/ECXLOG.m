ECXLOG ;ALB/GTS - Extract Log Report for DSS ; 11/2/06 8:38am
 ;;3.0;DSS EXTRACTS;**84,95,92**;Dec 22, 1997;Build 30
 ;
EN ;entry point from option
 ;Initialize variables
 N DIR,ECSD1,ECED,X,Y
 ;Prompt for start date
 S DIR(0)="D^::EX"
 S DIR("A")="Enter Report Start Date"
 D ^DIR
 I $D(DIRUT) Q
 S ECSD1=Y
 ;Prompt for end date
 K DIR,X,Y
 S DIR(0)="D^"_ECSD1_":"_DT_":EX"
 S DIR("A")="Enter Report Ending Date"
 D ^DIR
 I $D(DIRUT) Q
 S ECED=Y
 ;Queue Report
 W !!,"** REPORT REQUIRES 132 COLUMNS TO PRINT CORRECTLY **",!!
 N ZTDESC,ZTIO,ZTSAVE,I
 S ZTIO=""
 S ZTDESC="DSS EXTRACT LOG STATISTICS"
 F I="ECSD1","ECED","ECXNUM","ECXPKG","ECXSET","ECXTXDT","ECXPURGE","ECXTRACT","ECXMONTH","ECXUCONF" D
 .S ZTSAVE(I)=""
 D EN^XUTMDEVQ("EN1^ECXLOG",ZTDESC,.ZTSAVE)
 Q
 ;
EN1 ;Tasked entry point
 ;Input : ECSD1  -  FM format report start date
 ;        ECED   -  FM format report end date
 ;
 ;Output : None
 ;
 ;Declare variables
 N LN,PAGENUM,STOP,ECXCT,ECXDACT,ECXNUM,ECXPKG,ECXSET,ECXCOUNT,ECXTXDT
 N ECXPURGE,ECXTRACT,ECXUMSG,ECXUSER,ECXMONTH,MSGNUM,COUNT,DIC,ECX0,X
 N ECX1,ECXED1,QFLG
 S ECXED1=ECED+.9999,ECXCT=ECSD1-.0001,(QFLG,PAGENUM,STOP)=0
 D HEADER I STOP D EXIT Q
 D GETDATA
 I $O(^TMP("ECXDSS",$J,""))="" D  Q
 .W !
 .W !,"***********************************************"
 .W !,"*  NOTHING TO REPORT FOR SELECTED TIME FRAME  *"
 .W !,"***********************************************"
 .D WAIT
 D DETAIL I STOP D EXIT Q
 K ^TMP("ECXDSS",$J)
 Q
 ;
GETDATA ;Get data
 F  S ECXCT=$O(^ECX(727,"AE",ECXCT)) Q:(ECXCT>ECXED1)!('ECXCT)!(QFLG=1)  D
 .S ECXDACT=0
 .F  S ECXDACT=$O(^ECX(727,"AE",ECXCT,ECXDACT)) Q:('ECXDACT)!(QFLG=1)  D
 ..;Get data nodes
 ..S ECX0=$G(^ECX(727,ECXDACT,0)),ECX1=$G(^(1))
 ..Q:ECX0=""
 ..S ECXNUM=$P(ECX0,U,1),ECXPKG=$E($P(ECX0,U,3),1,13),ECXSET=$E($P(ECX0,U,4),2,7)_"-"_$E($P(ECX0,U,5),2,7),ECXCOUNT=$P(ECX0,U,6),ECXTXDT=$G(^ECX(727,ECXDACT,"TR")),ECXPURGE=$G(^ECX(727,ECXDACT,"PURG")),ECXTRACT=$P(ECX0,U,2),ECXUSER=$P(ECX0,U,7)
 ..S ECXMONTH=$P($$FMTE^XLFDT($P(ECX0,U,4),"D")," ",1)_" "_$P($$FMTE^XLFDT($P(ECX0,U,4),"D")," ",3)
 ..;Resolve external values for ECXUSER
 ..K DIC S DIC="^VA(200,",DIC(0)="NZ",X=ECXUSER D ^DIC
 ..S ECXUSER=$P($G(Y(0)),U,1)
 ..;Count number of UNCONF messages in Message number multiple
 ..S (MSGNUM,COUNT)=0 F  S MSGNUM=$O(^ECX(727,ECXDACT,1,MSGNUM)) Q:MSGNUM'>0  D
 ...S COUNT=COUNT+1
 ..S ECXUMSG=$G(COUNT)
 ..;Save for later
 ..S ^TMP("ECXDSS",$J,ECXPKG,ECXNUM)=ECXNUM_U_ECXPKG_U_ECXSET_U_ECXCOUNT_U_ECXTXDT_U_ECXPURGE_U_ECXTRACT_U_ECXMONTH_U_ECXUMSG_U_ECXUSER
 ..Q
 .Q
 Q
 ;
HEADER ;print header
 S PAGENUM=$G(PAGENUM)+1
 S $P(LN,"-",132)=""
 W @IOF
 W !,?1,"DSS EXTRACT LOG STATISTICS",?120,"Page: ",PAGENUM
 W !!,?1,"EXTRACT NUMBER",?20,"VISTA PACKAGE",?39,"DATA SET DATES",?59,"RECORD COUNT",?75,"DATE TRANSMITTED",?98,"DATE PURGED"
 W !,?3,"DATE EXTRACTED",?25,"DATA MONTH",?40,"MSG UNCONF"
 W ?60,"REQUESTOR"
 W !?1,LN
 Q
 ;
DETAIL ;Print detailed line
 ;Input  :  ^TMP("ECXDSS",$J) full global reference
 ;          ECXNUM    -   Extract Number
 ;          ECXPKG    -   VistA Package
 ;          ECXDATA   -   Data Set
 ;          ECXCOUNT  -   Record Count
 ;          ECXTXDT   -   Transmission Date
 ;          ECXPURGE  -   Extract Purge Date
 ;          ECXTRACT  -   Extract Date
 ;          ECXMONTH  -   Data Month and Year
 ;          ECXUCONF  -   Unconfirmed Messages
 ;          ECXUSER   -   Requestor
 ;Output  : None
 ;
 N NODE,PACKAGE,NUMBER
 S PACKAGE="" F  S PACKAGE=$O(^TMP("ECXDSS",$J,PACKAGE)) Q:PACKAGE=""!(STOP)  D  Q:STOP
 .S NUMBER=0 F  S NUMBER=$O(^TMP("ECXDSS",$J,PACKAGE,NUMBER)) Q:'NUMBER!(STOP)  D  Q:STOP
 ..S NODE=^TMP("ECXDSS",$J,PACKAGE,NUMBER)
 ..W !!,?1,$P(NODE,U,1),?20,$P(NODE,U,2),?39,$P(NODE,U,3),?59,$P(NODE,U,4),?75,$$FMTE^XLFDT($P(NODE,U,5),"D"),?98,$$FMTE^XLFDT($P(NODE,U,6),"D")
 ..W !,?3,$$FMTE^XLFDT($P(NODE,U,7),"D"),?25,$P(NODE,U,8),?40,$P(NODE,U,9),?60,$P(NODE,U,10)
 ..I $Y>(IOSL-5) D WAIT Q:STOP  D HEADER
 ..Q
 Q
 ;
WAIT ;End of page logic
 ;Input   ; None
 ;Output  ; STOP - Flag indicating if printing should continue
 ;                 1 = Stop     0 = Continue
 ;
 S STOP=0
 ;CRT - Prompt for continue
 I $E(IOST,1,2)="C-"&(IOSL'>24) D  Q
 .F  Q:$Y>(IOSL-3)  W !
 .N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 .S DIR(0)="E"
 .D ^DIR
 .S STOP=$S(Y'=1:1,1:0)
 ;Background task - check taskman
 S STOP=$$S^%ZTLOAD()
 I STOP D
 .W !,"*********************************************"
 .W !,"*  PRINTING OF REPORT STOPPED AS REQUESTED  *"
 .W !,"*********************************************"
 Q
EXIT ;Kill temp global
 K ^TMP("ECXDSS",$J)
 Q
