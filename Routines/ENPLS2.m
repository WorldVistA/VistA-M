ENPLS2 ;WISC/SAB - Select Items from List ;12/4/07  13:24
 ;;7.0;ENGINEERING;**23,87**;Aug 17, 1993;Build 16
EN ; entry point
 ; input global
 ;   ^TMP($J,"SCR)=number of entries in list^screen title
 ;   ^TMP($J,"SCR",0)=col 1 x pos;col 1 hdr^...^col n x pos;col n hdr
 ;   ^TMP($J,"SCR",id)=col 1 value^col 2 value^...^col n value
 ; output
 ;    optional ENACL( selected items
 ;
 ; initialize variables
 N ENI,ENID,ENF,ENI,ENS,ENX,ENY
 K ENACL
 S $P(ENF("DASH"),"-",80)=""
 ; get screen info
 S ENX=^TMP($J,"SCR")
 S ENF("IDM")=$P(ENX,U)
 S ENF("HD")=$P(ENX,U,2)
 ; get column info
 S ENX=^TMP($J,"SCR",0),ENF("CM")=0
 F ENI=1:1 S ENY=$P(ENX,U,ENI) Q:ENY=""  D
 . S ENF("CM")=ENF("CM")+1
 . S ENF("C"_ENI,"X")=$P(ENY,";",1)
 . S ENF("C"_ENI,"L")=$P(ENY,";",2)
 . S ENF("C"_ENI,"HD")=$P(ENY,";",3)
 S ENF("SM")=(ENF("IDM")-1)\15+1
 S ENF("S")=1
BLD ; build screen
 K ENS
 S ENS("IDL")=1+(ENF("S")-1*15)
 S ENS("IDM")=$S(15+(ENF("S")-1*15)>ENF("IDM"):ENF("IDM"),1:15+(ENF("S")-1*15))
 ; display screen
 D SHD
 F ENID=ENS("IDL"):1:ENS("IDM") D  W !
 . S ENX=^TMP($J,"SCR",ENID)
 . W $J(ENID,3)
 . F ENI=1:1:ENF("CM") W ?ENF("C"_ENI,"X"),$P(ENX,U,ENI)
ACT ; prompt for selection
 W !
 S DIR("A")="Enter a list or range to select (1-"_ENF("IDM")_"): "_$S(ENF("S")<ENF("SM"):"Next Screen",1:"Quit")_"//"
 S DIR(0)="LOA^1:"_ENF("IDM")
 D ^DIR K DIR G:$D(DTOUT)!$D(DUOUT) EXIT
 I X="",ENF("S")<ENF("SM") S ENF("S")=ENF("S")+1 G BLD
 K ENACL S ENI="" F  S ENI=$O(Y(ENI)) Q:ENI=""  S ENACL(ENI)=Y(ENI)
EXIT ;
 W:'$G(ENGNOFF) @IOF
 K DX,DY
 Q
EN2(ENGNOFF) ;Entry point to suppress Form Feed at end
 G EN
SHD ; Screen Header
 W @IOF
 W ENF("HD"),?65,"Screen ",ENF("S")," of ",ENF("SM"),!!
 W "ID#"
 F ENI=1:1:ENF("CM") W ?ENF("C"_ENI,"X"),ENF("C"_ENI,"HD")
 W !
 W "---"
 F ENI=1:1:ENF("CM") W ?ENF("C"_ENI,"X"),$E(ENF("DASH"),1,ENF("C"_ENI,"L"))
 W !
 Q
PYLIST ; Progam and Year list of project applications
 N ENACL,ENC,ENDA,ENI,ENIDX,ENJ,ENK,ENPN,ENPR,ENY,ENY0,ENYR
 K ^TMP($J,"R")
 S DIR(0)="S^MA:MAJOR;MI:MINOR;MM:MINOR MISC;NR:NRM"
 S DIR("?")="Enter program that listed projects must match."
 D ^DIR K DIR Q:$D(DIRUT)
 S ENPR=Y
 S DIR(0)="N^1993:2099:0",DIR("A")="YEAR"
 S DIR("?",1)="Enter a 4-digit year that listed projects must have as"
 S DIR("?")="the A/E or Construction funding year."
 S DIR("B")=$E(17000000+DT,1,4)+$S($E(DT,4,7)>0600:2,1:1)
 D ^DIR K DIR Q:$D(DIRUT)
 S ENYR=Y
 F ENIDX="F","G" D
 . S ENDA=0 F  S ENDA=$O(^ENG("PROJ",ENIDX,ENYR,ENDA)) Q:'ENDA  D
 . . S ENY0=$G(^ENG("PROJ",ENDA,0)) Q:$P(ENY0,U)=""!($P(ENY0,U,6)'=ENPR)
 . . S ^TMP($J,"R",$P(ENY0,U))=$P(ENY0,U)_U_$P(ENY0,U,3)_U_ENDA
 I '$D(^TMP($J,"R")) W !!,"No Projects matched selection criteria!",! Q
 S ENI=0,ENPN="" F  S ENPN=$O(^TMP($J,"R",ENPN)) Q:ENPN=""  S ENI=ENI+1,^TMP($J,"SCR",ENI)=^(ENPN)
 S ^TMP($J,"SCR")=ENI_U_"PROGRAM ("_ENPR_") PROJECTS WITH FUNDING YEAR "_ENYR
 S ^TMP($J,"SCR",0)="5;11;PROJECT #^19;50;TITLE"
 D ^ENPLS2
 ; save selected projects (if any)
 S ENC=0,ENJ="" F  S ENJ=$O(ENACL(ENJ)) Q:ENJ=""  D
 . F ENK=1:1 S ENI=$P(ENACL(ENJ),",",ENK) Q:ENI=""  D
 . . S ENY=^TMP($J,"SCR",ENI),^TMP($J,"L",$P(ENY,U))=$P(ENY,U,3),ENC=ENC+1
 S:ENC ^TMP($J,"L")=ENC_$S(ENTY="F":U_ENFY,1:"")
 K ^TMP($J,"R"),^TMP($J,"SCR")
 Q
 ;ENPLS2
