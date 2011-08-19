ECXNUTDP ;ALB/JRC - Nut Division Worksheet Print ; 2/18/09 1:47pm
 ;;3.0;DSS EXTRACTS;**92,104,119**;Dec 22, 1997;Build 19
 ;
EN ;entry point from option
 ;Queue Report
 N ZTDESC,ZTIO,ZTSAVE
 S ZTIO=""
 S ZTDESC="Nutrition Division Worksheet for DSS"
 D EN^XUTMDEVQ("EN1^ECXNUTDP",ZTDESC,.ZTSAVE)
 Q
EN1 ;Tasked entry point
 ;Declare variables
 N STOP,PAGENUM,LN,LTYPE
 S (STOP,PAGENUM,LTYPE)=0,LN=""
 K ^TMP($J)
 F LTYPE="119.71","119.72" D  I STOP D EXIT Q
 .D HEADER I STOP D EXIT Q
 .D GETDATA
 .I '$D(^TMP($J,"ECX",LTYPE)) D  Q
 ..W !
 ..W !,"***********************************************"
 ..W !,"*  NOTHING TO REPORT FOR "_$S(LTYPE=119.71:"PRODUCTION LOCATIONS",LTYPE=119.72:"DELIVERY LOCATIONS  ",1:"")_" *"
 ..W !,"***********************************************"
 ..D WAIT
 .D DETAIL I STOP D EXIT Q
 .D FOOTER I STOP D EXIT Q
 .D WAIT Q:STOP
 .K ^TMP($J)
EXIT K ^TMP("ECXDSS",$J)
 Q
GETDATA ;Get data
 ;Init variables
 N DIV,IEN,PLIEN,IENS,LOCATION,CNT,PDIV,FILE
 S (DIV,LOCATION,PDIV)="",(IEN,PLIEN,IENS,CNT)=0
 S DIV="" F  S DIV=$O(^ECX(728.46,"B",DIV)) Q:DIV=""  D
 . ;Q:LTYPE'=$E(DIV,6,11)
 . Q:LTYPE'=$E($P(DIV,"(",2),1,6)
 . S IEN=$O(^ECX(728.46,"B",DIV,0)) Q:'IEN  D
 .. ;S PLIEN=$P(DIV,";",1),FILE=$E(DIV,6,11),CNT=$G(CNT)+1
 .. S PLIEN=$P(DIV,";",1),FILE=$E($P(DIV,"(",2),1,6),CNT=$G(CNT)+1
 .. I FILE'=LTYPE Q
 .. S IENS=""_PLIEN_","_""
 .. S LOCATION=$$GET1^DIQ(FILE,""_IENS_","_"",.01,"E")
 .. S PDIV=$$GET1^DIQ(728.46,IEN,1,"I")
 .. S PDIV=$$RADDIV^ECXDEPT(PDIV)
 .. S ^TMP($J,"ECX",FILE)="1"
 .. S ^TMP($J,"ECX",FILE,PLIEN)=PLIEN_U_LOCATION_U_PDIV
 Q
HEADER ;print header
 N TYPE
 S PAGENUM=$G(PAGENUM)+1
 S $P(LN,"=",9)="",TYPE=$S(LTYPE=119.71:"PRODUCTION",LTYPE=119.72:"DELIVERY",1:"")
 W @IOF
 W ?1,"RUN DATE: ",$$FMTE^XLFDT(DT,"5H"),?70,"PAGE ",PAGENUM
 W !,?23,"NUTRITION DIVISION WORKSHEET"
 W !!,?27,TYPE_" LOCATIONS"
 W:TYPE="DELIVERY" !!,?2,TYPE
 W:TYPE="PRODUCTION" !!,?1,TYPE
 W ?26,TYPE,?50,"ASSIGNED"
 W !,?1,"LOCATION #",?26,"LOCATIONS",?50,"DIVISION"
 W !,?1,LN_"===",?26,LN,LN,?47,LN,LN
 Q
 ;
DETAIL ;Print detailed line
 ;Input  :  ^TMP("ECXDSS",$J) full global reference
 ;                    PLIEN    - File 119.71 or 119.72 IEN
 ;                    LOCATION - File 119.71 or 119.72 NAME
 ;                    DIVISION - Assigned production division
 ;Output  : None
 N TYPE,FILE,NODE,PIEN,CNT,X1,X2
 S TYPE=$S(LTYPE=119.71:"PRODUCTION",1:"DELIVERY LOCATIONS")
 S FILE=0 F  S FILE=$O(^TMP($J,"ECX",FILE)) Q:'FILE!STOP  D
 .S PIEN=0 F  S PIEN=$O(^TMP($J,"ECX",FILE,PIEN)) Q:'PIEN!STOP  D
 ..S NODE=^TMP($J,"ECX",FILE,PIEN)
 ..W !?3,$$RJ^XLFSTR($P(NODE,U),U,6),?26,$P(NODE,U,2),?50,$$RJ^XLFSTR($P(NODE,U,3),U,6)
 ..I $Y>(IOSL-5) D WAIT Q:STOP  D HEADER
 ..Q
 S CNT=0
 W !!,"The following "_TYPE_" are missing in the DSS Worksheets"
 W !!?3,TYPE,?26,"INACTIVE FLAG",!?3,"----",?26,"-------------",!
 F IEN=0:0 S IEN=$O(^FH(LTYPE,IEN)) Q:'IEN  D
 . I '$D(^ECX(728.46,"B",IEN_";FH("_LTYPE_",")) D
 .. S X1=$$GET1^DIQ(LTYPE,""_IEN_","_"",.01,"E")
 .. S X2=$$GET1^DIQ(LTYPE,IEN,99,"E")
 .. W !?3,X1,?26,X2 S CNT=CNT+1
 I CNT=0 W !!?3,"NOTHING TO REPORT... YOUR FILES ARE CLEAN!"
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
FOOTER ;Print footer
 N DIV,IEN
 S DIV="",IEN=0
 W !!!,?1,"INSTITUTION",!,"FILE/DIVISIONS",!,LN,LN
 F  S DIV=$O(^DG(40.8,"B",DIV)) Q:DIV=""!STOP  D
 .F  S IEN=$O(^DG(40.8,"B",DIV,IEN)) Q:'IEN!STOP  D  Q:STOP
 ..W !,?3,$$RJ^XLFSTR($$GETDIV^ECXDEPT(IEN),U,8)
 ..I $Y>(IOSL-5) D WAIT Q:STOP  D HEADER,FHEADER
 Q
FHEADER ;Footer header
 W !!!,?1,"INSTITUTION",!,"FILE/DIVISIONS",!,LN,LN
 Q
