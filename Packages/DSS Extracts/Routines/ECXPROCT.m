ECXPROCT ;ALB/GTS - ProstheticS Cost by PSAS HCPC Report DSS ;4/15/15  16:09
 ;;3.0;DSS EXTRACTS;**71,100,144,154**;Dec 22, 1997;Build 13
 ;
EN ;entry point from option
 ;Initialize varables
 N DIR,ECSD1,ECED,X,Y,ECXPORT,I ;144
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
 S ECXPORT=$$EXPORT^ECXUTL1 Q:ECXPORT=-1  I ECXPORT D  Q  ;144
 .K ^TMP($J,"ECXPORT") ;144
 .S ^TMP($J,"ECXPORT",0)="PSAS HCPC^DESCRIPTION^FORM^FORM DESCRIPTION^QTY^UNIT OF ISSUE^COST" ;144,154
 .D EN1 ;144
 .M ^TMP($J,"ECXPORT")=^TMP("ECXDSS",$J) ;144 Move results to export display global
 .D EXPDISP^ECXUTL1 ;144
 ;Queue Report
 W !!,"** REPORT REQUIRES 132 COLUMNS TO PRINT CORRECTLY **",!!
 N ZTDESC,ZTIO,ZTSAVE
 S ZTIO=""
 S ZTDESC="Prosthetic Cost by PSAS HCPC Report for DSS"
 F I="ECSD1","ECED","ECXPHCPC","ECXPHDESC","ECXHCPC","ECXQTY","ECXUOFI","ECXCOST","ECXTCOST" D
 .S ZTSAVE(I)=""
 D EN^XUTMDEVQ("EN1^ECXPROCT",ZTDESC,.ZTSAVE)
 Q
 ;
EN1 ;Tasked entry point
 ;Input : ECSD1  -  FM format report start date
 ;        ECED   -  FM format report end date
 ;
 ;Output : None
 ;
 ;Declare variables
 N ECXPHCPC,ECHCDES,ECXHCPC,ECXQTY,ECXUOFI,ECXCOST,ECXTCOST,PAGENUM ;144
 N ECXLNE,ECXCT,ECXDACT,ECX0,ECX1,ECXED1,ECINSTSV,ECXLNSTR,ECXP
 N DIC,DR,DA,DIQ,CNT,STOP,QFLG,ECXDIV,ECXDFN,ECXFORM ;144
 S ECXED1=ECED+.9999,ECXCT=ECSD1-.1,(CNT,QFLG,PAGENUM,ECXTCOST,ECXQTY,STOP)=0 ;154 Changed start date to begin before selected date so records on the date are found
 I '$G(ECXPORT) D HEADER I STOP D EXIT Q  ;144
 D GETDATA I $G(ECXPORT) Q  ;144 Have data, no need to print.
 I '$D(^TMP("ECXDSS",$J)) D  Q
 .W !
 .W !,"***********************************************"
 .W !,"*  NOTHING TO REPORT FOR SELECTED TIME FRAME  *"
 .W !,"***********************************************"
 .D WAIT
 D DETAIL I STOP D EXIT Q
 D TOTAL
 D FOOTER ;154
 K ^TMP("ECXDSS",$J)
 Q
 ;
GETDATA ;Get data
 F  S ECXCT=$O(^RMPR(660,"CT",ECXCT)),CNT=CNT+1 Q:(ECXCT>ECXED1)!('ECXCT)!(QFLG=1)  D
 .S ECXDACT=0
 .F  S ECXDACT=$O(^RMPR(660,"CT",ECXCT,ECXDACT)) Q:('ECXDACT)!(QFLG=1)  D
 ..;Get data nodes and icrement conunter
 ..S CNT=CNT+1
 ..S ECX0=$G(^RMPR(660,ECXDACT,0)),ECX1=$G(^(1))
 ..Q:'$D(^RMPR(660,ECXDACT,0))
 ..S ECXPHCPC=$P(ECX1,U,4),ECHCDES=$P(ECX1,U,2),ECXHCPC=$P(ECX0,U,22)
 ..S ECXQTY=$P(ECX0,U,7),ECXUOFI=$P(ECX0,U,8),ECXCOST=$P(ECX0,U,16)
 ..;Resolve external values for PSAS HCPC
 ..K DIC S DIC="^RMPR(661.1,",DIC(0)="NZ",X=ECXPHCPC D ^DIC
 ..;S ECXPHCPC=$P($G(Y(0)),U,1)
 ..S ECXPHCPC=$E($P($G(Y(0)),U,1),1,5)
 ..;Resolve external values for HCPC
 ..K DIC S DIC="^ICPT(",DIC(0)="NZ",X=ECXHCPC D ^DIC
 ..S ECXHCPC=$P($G(Y(0)),U,1)
 ..;Resolve external value for unit of issue
 ..K DIC S DIC="^PRCD(420.5,",DIC(0)="NZ",X=ECXUOFI D ^DIC
 ..S ECXUOFI=$P($G(Y(0)),U,2)
 ..S ECXTCOST=ECXCOST+ECXTCOST
 ..S ECXDIV=$$GET1^DIQ(660,ECXDACT,8,"I")
 ..D GETS^DIQ(660,ECXDACT_",",".02;11","IE","ECXP") ;154
 ..S ECXDFN=$G(ECXP(660,ECXDACT_",",.02,"I")) ;154
 ..S ECXFORM=$G(ECXP(660,ECXDACT_",",11,"E"))_U_$G(ECXP(660,ECXDACT_",",11,"I")) ;154
 ..;Save for later
 ..S ^TMP("ECXDSS",$J,CNT)=ECXPHCPC_U_ECHCDES_U_$P(ECXFORM,U,2)_$S($G(ECXPORT):(U_$P(ECXFORM,U)),1:"")_U_ECXQTY_U_ECXUOFI_U_ECXCOST ;154 Replaced HCPC with FORM data
 ..Q
 .Q
 Q
HEADER ;print header
 N LN ;144
 S PAGENUM=PAGENUM+1
 S $P(LN,"-",132)=""
 W @IOF
 W !,"Cost by PSAS HCPC REPORT for "_$P($$SITE^VASITE,U,2)_" station "_$P($$SITE^VASITE,U,3),?120,"Page: ",PAGENUM
 W !!,"Report for ",$$FMTE^XLFDT(ECSD1)," thru ",$$FMTE^XLFDT(ECED)
 W !,?1,"PSAS HCPC",?15,"DESCRIPTION",?89,"FORM",?98,"QTY",?104,"Unit of Issue",?126,"Cost" ;154 Replaced HCPC with FORM
 W !?1,LN
 Q
 ;
DETAIL ;Print detailed line
 ;Input  :  ^TMP("ECXDSS",$J) full global reference
 ;          ECXPHCPC  -   PSAS HCPCS
 ;          ECXPHDESC -   PSAS HCPC Description
 ;          ECXHCPC   -   HCPCS ;154 No longer on report
 ;          ECXQTY    -   Quantity
 ;          ECXUOFI   -   Unit of issue
 ;          ECXCOST   -   Total cost
 ;          ECXFORM   -   Form requested on
 ;Output  : None
 N RECORD,NODE ;144
 S RECORD=0 F  S RECORD=$O(^TMP("ECXDSS",$J,RECORD)) Q:'RECORD!(STOP)  D
 .S NODE=^TMP("ECXDSS",$J,RECORD)
 .W !?1,$$RJ^XLFSTR($P(NODE,U,1),6),?15,$P(NODE,U,2),?89,$P(NODE,U,3),?99,$$RJ^XLFSTR($P(NODE,U,4),U,6),?107,$P(NODE,U,5) ;154
 .W ?122,"$"_$$RJ^XLFSTR($P($P(NODE,U,6),".",1),6)_"."_$$LJ^XLFSTR($P($P(NODE,U,6),".",2),2,0)
 .I $Y>(IOSL-5) D WAIT Q:STOP  D HEADER
 .Q
 Q
 ;
TOTAL ;Report totals
 N DASH
 S $P(DASH,"=",15)=""
 W !!,?118,DASH
 W !?90,"Grand Total: ",?118,"$ "_$$RJ^XLFSTR($FNUMBER(ECXTCOST,",",2),11)
 Q
 ;
WAIT ;End of page logic
 ;Input   ; None
 ;Output  ; STOP - Flag inidcating if printing should continue
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
 ;
FOOTER ;154 Section added to print the form requested on key at the end of the report
 W !,"FORM:"
 W !,"1:PSC",?10,"2:2421",?18,"3:2237",?34,"4:2529-3",?54,"5:2529-7",?74,"6:2472",?83,"7:2431",?99,"8:2914"
 W !,"9:OTHER",?9,"10:2520",?17,"11:STOCK ISSUE",?33,"12:INVENTORY ISSUE",?53,"13:HISTORICAL DATA",?73,"14:VISA",?82,"15:LAB ISSUE-3",?98,"16:DALC"
 Q
