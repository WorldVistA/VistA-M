ENPL5 ;(WASH ISC)/LKG,SAB-FYFP REPORT ;8/17/95
 ;;7.0;ENGINEERING;**11,23**;Aug 17, 1993
IN ;Entry point to print 5-Yr Plan report
 S DIR(0)="N^1993:2099:0",DIR("A")="Budget Year of 5-Yr Plan"
 S DIR("?")="Enter the 4-digit Budget Year of the Plan"
 S DIR("B")=$E(17000000+DT,1,4)+$S($E(DT,4,7)>0600:2,1:1)
 D ^DIR K DIR G:$D(DIRUT) EX S ENFY=Y-1
ST ; get station
 S EN6910Y0=$G(^DIC(6910,1,0))
 S DIC("B")=$P(EN6910Y0,U,2)
 S DIC="^DIC(4,",DIC(0)="AEMQ" D ^DIC K DIC G:Y<1 EX S ENI=+Y_","
 S ENSN=$E($$GET1^DIQ(4,ENI,99),1,3)
 S ENPN=$O(^ENG("PROJ","B",ENSN_"-"))
 I $P(ENPN,"-")'=ENSN W !,$C(7)_"No Projects on file for this Site" G ST
 S ENX="VAMC: "_$$GET1^DIQ(4,ENI,"1.03")_", "
 S ENX=ENX_$$GET1^DIQ(4,ENI,".02:1")_" ("_ENSN_")"
 S:$P(EN6910Y0,U,7)]"" ENX=ENX_"   Region: "_$P(EN6910Y0,U,7)
 S:$P(EN6910Y0,U,11)]"" ENX=ENX_"   VISN: "_$P(EN6910Y0,U,11)
 S:$P(EN6910Y0,U,12)]"" ENX=ENX_"   Network: "_$P(EN6910Y0,U,12)
 S ENPGH=ENX
 K EN6910Y0,ENI
 ;
 S ENMDA=0,ENDV="*"
 I $P($G(^DIC(6910,1,0)),U,10) D  G:$D(DTOUT)!$D(DUOUT) EX
 . W !,"Select Division to be included in report or leave blank for all"
 . S DIC="^ENG(6910.3,",DIC(0)="AQEM" D ^DIC Q:$D(DTOUT)!$D(DUOUT)
 . I Y'<1 S ENDV=+Y
 . I Y<1 S ENMDA=1
 S:ENDV'="*" ENPGH=ENPGH_"   Div: "_$$GET1^DIQ(6910.3,ENDV_",",.01)
 ;
 K DIR S DIR("A")="Start with year: ",DIR("B")=ENFY
 S DIR(0)="SA^"_ENFY_":CURRENT YR;"_(ENFY+1)_":BUDGET YR;"_(ENFY+2)_":BUDGET YR+1;"_(ENFY+3)_":BUDGET YR+2;"_(ENFY+4)_":BUDGET YR+3;"_(ENFY+5)_":BUDGET YR+4;FUTURE:FUTURE YEARS"
 S DIR("?")="Enter a 4 digit year from "_ENFY_" to "_(ENFY+5)_" or FUTURE"
 D ^DIR K DIR G:$D(DIRUT) EX S ENFYB=$S(Y="FUTURE":"F",1:Y-ENFY)
 ;
 S DIR("A")="Go to year: ",DIR("B")="FUTURE",DIR(0)="SA^"
 I ENFYB'="F" F ENI=ENFYB:1:5 S DIR(0)=DIR(0)_(ENFY+ENI)_$S(ENI:":BUDGET YR",1:":CURRENT YR")_$S(ENI>1:"+"_(ENI-1)_";",1:";")
 S DIR(0)=DIR(0)_"FUTURE:FUTURE YEARS" K ENI
 S DIR("?")="Enter FUTURE"_$S(ENFYB'="F":" or a four digit year from "_(ENFY+ENFYB)_" to "_(ENFY+5),1:"")
 D ^DIR K DIR G:$D(DIRUT) EX S ENFYE=$S(Y="FUTURE":"F",1:Y-ENFY)
 ;
 S DIR("A")="Level of detail: ",DIR("B")="DEFAULT"
 S DIR(0)="SA^L:LOWEST;S:SUMMARY;E:EQUIPMENT;D:DEFAULT;H:HIGHEST"
 S DIR("?")="Enter a code (L, S, E, D, or H)"
 S DIR("?",1)="L (LOWEST)    Prints only project list pages."
 S DIR("?",2)="S (SUMMARY)   Prints project list and final summary pages."
 S DIR("?",3)="E (EQUIPMENT) Prints equipment page only."
 S DIR("?",4)="D (DEFAULT)   Prints project list, final summary,"
 S DIR("?",5)="                and equipment list pages. Prints detail"
 S DIR("?",6)="                pages for BUDGET and BUDGET+1 years."
 S DIR("?",7)="H (HIGHEST)   Prints project list, final summary,"
 S DIR("?",8)="                and equipment list pages. Prints detail"
 S DIR("?",9)="                pages for BUDGET through BUDGET+4 years."
 D ^DIR K DIR G:$D(DIRUT) EX S ENDETAIL=Y
DEV ; device
 S %ZIS="PQ" D ^%ZIS G:POP EX I IOM<132 K IO("Q") D:IO'=IO(0) ^%ZISC W *7,"* Must Support 132 Character Display" G DEV
 I $D(IO("Q")) D  G EX
 . S ZTRTN="QEN^ENPL5",ZTDESC="Five Year Facility Plan Report"
 . F ENX="ENSN","ENDV","ENPGH","ENMDA","ENFY","ENFYB","ENFYE","ENDETAIL" S ZTSAVE(ENX)=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
QEN ; queued entry point
 U IO K ENT S (END,ENPG)=0 D NOW^%DTC S Y=% D DD^%DT S ENRDT=Y
 S ENPGHC=125-$L(ENPGH)\2+5
 ; get projects and leases
 S ENX="Y"_$S("EDH"[ENDETAIL:"E",1:"")_$S("DH"[ENDETAIL:"L",1:"")
 D FYFP^ENPLS1(ENSN,ENFY,ENFYB,ENFYE,ENDV,ENX)
 ; generate current and/or plan year summary pages
 I "LSDH"[ENDETAIL,ENFYB'="F" F ENYR=ENFY+ENFYB:1:ENFY+$S(ENFYE="F":5,1:ENFYE) D YS^ENPL5A Q:END
 ; generate future year summary pages
 I "LSDH"[ENDETAIL,ENFYE="F",'END S ENYR="F" D YS^ENPL5A
 ; generate equipment pages
 I "EDH"[ENDETAIL,'END D EQP^ENPL5C
 ; generate detail pages
 I "DH"[ENDETAIL,'END D
 . S ENFYMX=$S(ENDETAIL["D":ENFY+2,ENDETAIL["H":ENFY+5,1:0) ; max year
 . S ENPN=""
 . F  S ENPN=$O(^TMP($J,"L",ENPN)) Q:ENPN=""  D  Q:END
 . . S ENDA=$P(^TMP($J,"L",ENPN),U),ENY0=$G(^ENG("PROJ",ENDA,0))
 . . S ENPR=$P(ENY0,U,6)
 . . I "^MA^MI^MM^NR^"[(U_ENPR_U) D
 . . . S ENFYAE=$P($G(^ENG("PROJ",ENDA,5)),U,7)
 . . . S ENFYCO=$P(ENY0,U,7)
 . . . I (ENFYAE>ENFY&(ENFYAE'>ENFYMX))!(ENFYCO>ENFY&(ENFYCO'>ENFYMX)) D PD^ENPL5B
 . . I "^LE^"[(U_ENPR_U) D
 . . . S ENFYRE=$P($G(^ENG("PROJ",ENDA,55)),U,3)
 . . . I ENFYRE>ENFY,ENFYRE'>ENFYMX D PD^ENPL5B
 . K ENFYMX,ENFYAE,ENFYCO,ENFYRE,ENY0
 ; generate plan summary page
 I "SDH"[ENDETAIL,'END D PS^ENPL5D
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
EX ; exit
 K ^TMP($J)
 K EN6910Y0,END,ENDA,ENDETAIL,ENDV,ENFY,ENFYB,ENFYE,ENI,ENMDA
 K ENPG,ENPGH,ENPGHC,ENPN,ENPR,ENRDT,ENSN,ENT,ENX,ENYR
 K DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 Q
 ;ENPL5
