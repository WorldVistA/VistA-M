SCRPO6 ;BP-CIOFO/KEITH - Historical Team Assignment Summary ; 9/14/99 10:07am
 ;;5.3;Scheduling;**177,297**;AUG 13, 1993
 ;
EN ;Queue report
 N LIST,RTN,DESC
 S SUMON=0
 W !,"Print Final Summary Only" S %=2 D YN^DICN I %=1 S SUMON=1
 S LIST="DIV,TEAM"
 S RTN="RUN^SCRPO6"
 S DESC="Historical Team Assignment Summary"
 D PROMPT(LIST,RTN,DESC) Q
 ;
PROMPT(LIST,SCRTN,SCDESC) ;Prompt for report parameters, queue report
 ;Input: LIST=comma delimited string of list subscripts to prompt for
 ;Input: SCRTN=report routine entry point
 ;Input: SCDESC=tasked job description
 ;
 N SCDIV,SCBDT,SCEDT,SC,SCI,SCX,SCOUT,SCT
 S SC="^TMP(""SC"",$J)" K @SC S SCOUT=0
 D TITL^SCRPW50(SCDESC)
 D SUBT^SCRPW50("**** Date Range Selection ****")
 S (SCBDT("B"),SCEDT("B"))="TODAY"
 G:'$$DTR^SCRPO(.SC,.SCBDT,.SCEDT) END
 D SUBT^SCRPW50("**** Report Parameter Selection ****")
 F SCI=1:1:$L(LIST,",") S SCX=$P(LIST,",",SCI) D  Q:SCOUT
 .S SCOUT='$$LIST^SCRPO(.SC,SCX,1)
 .Q
 G:SCOUT END
 S SCT(1)="**** Report Parameters Selected ****" D SUBT^SCRPW50(SCT(1))
 G:'$$PPAR^SCRPO(.SC,1,.SCT) END
 W !!,"This report requires 132 column output!"
 W ! N ZTSAVE S ZTSAVE("^TMP(""SC"",$J,")="",ZTSAVE("SC")="",ZTSAVE("SUMON")=""
 D EN^XUTMDEVQ(SCRTN,SCDESC,.ZTSAVE)
END K ^TMP("SC",$J) D DISP0^SCRPW23,END^SCRPW50 Q
 ;
STOP ;Check for stop task request
 S:$D(ZTQUEUED) (SCOUT,ZTSTOP)=$S($$S^%ZTLOAD:1,1:0) Q
 ;
RUN ;Print report
 N SCI,SCOUT
 K ^TMP("SCRPT",$J)
 S SCOUT=0
 D BUILD Q:SCOUT  D COUNT^SCRPO7 D STOP Q:SCOUT
 D PRINT
 K ^TMP("SCRPT",$J),^TMP("SCRATCH",$J) Q
 ;
BUILD ;gather report information
 N SCTM
 ;build from list of teams
 I $O(^TMP("SC",$J,"TEAM",0)) S SCTM=0 D  Q
 .F  S SCTM=$O(^TMP("SC",$J,"TEAM",SCTM)) Q:'SCTM!SCOUT  D
 ..D CKTEAM^SCRPO7(SCTM),STOP
 ..Q
 .Q
 ;build from all teams
 S SCTM=0 F  S SCTM=$O(^SCTM(404.51,SCTM)) Q:'SCTM!SCOUT  D
 .D CKTEAM^SCRPO7(SCTM),STOP
 .Q
 Q
 ;
PRINT ;Print report
 N SCLF,SCFF,SCLINE,SCPAGE,SCPNOW,SCTITL
 S (SCLF,SCFF)=0
 D HINI D:$E(IOST)="C" DISP0^SCRPW23
 S SCTITL(2)=$$HDRX("P") D HDR^SCRPO(.SCTITL,132) Q:SCOUT  S SCOUT=$$PPAR^SCRPO(.SC,,.SCTITL)=0
 Q:SCOUT
 I '$D(^TMP("SCRPT",$J,0)) D  Q
 .K SCTITL(2) D HDR^SCRPO(.SCTITL,132) Q:SCOUT
 .S SCX="No team or team position assignments found within selected report parameters!"
 .W !!?(132-$L(SCX)\2),SCX
 .Q
 S SCPAGE=1
 S SCTITL(2)=$$HDRX("S") D HDR^SCRPO(.SCTITL,132),SHDR("S") Q:SCOUT
 S SCDIV="" F  S SCDIV=$O(^TMP("SCRPT",$J,1,SCDIV)) Q:SCDIV=""!SCOUT  D
 .S SCX=^TMP("SCRPT",$J,1,SCDIV) D SLINE(SCDIV,SCX,12,.SCLF) S SCTEAM=""
 .F  S SCTEAM=$O(^TMP("SCRPT",$J,1,SCDIV,"TEAM",SCTEAM)) Q:SCTEAM=""!SCOUT  D
 ..S SCX=^TMP("SCRPT",$J,1,SCDIV,"TEAM",SCTEAM)
 ..D SLINE("  "_SCTEAM,SCX,10,.SCLF)
 ..Q
 .Q
 Q:SCOUT
 S SCX=^TMP("SCRPT",$J,0,0) D SLINE("REPORT TOTAL:",SCX,12,.SCLF)
 Q:SCOUT  D FOOT^SCRPO7
 Q:$G(SUMON)
 I $D(^TMP("SCRPT",$J,0,0,"TLIST")) D
 .S SCTITL(2)=$$HDRX("T") D HDR^SCRPO(.SCTITL,132),SHDR("T") Q:SCOUT
 .S SCDIV=""
 .F  S SCDIV=$O(^TMP("SCRPT",$J,0,0,"TLIST",SCDIV)) Q:SCDIV=""!SCOUT  D
 ..S SCTEAM=""
 ..F  S SCTEAM=$O(^TMP("SCRPT",$J,0,0,"TLIST",SCDIV,SCTEAM)) Q:SCTEAM=""!SCOUT  D
 ...S SCPNAM=""
 ...F  S SCPNAM=$O(^TMP("SCRPT",$J,0,0,"TLIST",SCDIV,SCTEAM,SCPNAM)) Q:SCPNAM=""!SCOUT  D
 ....S SCI=0
 ....F  S SCI=$O(^TMP("SCRPT",$J,0,0,"TLIST",SCDIV,SCTEAM,SCPNAM,SCI)) Q:'SCI!SCOUT  D
 .....S SCX=^TMP("SCRPT",$J,0,0,"TLIST",SCDIV,SCTEAM,SCPNAM,SCI)
 .....D TLINE(SCDIV,SCTEAM,SCPNAM,SCX)
 .....Q
 ....Q
 ...Q
 ..Q
 .Q
 Q:SCOUT  I $D(^TMP("SCRPT",$J,0,0,"PLIST")) D
 .S SCTITL(2)=$$HDRX("TP") D HDR^SCRPO(.SCTITL,132),SHDR("P") Q:SCOUT
 .S SCDIV=""
 .F  S SCDIV=$O(^TMP("SCRPT",$J,0,0,"PLIST",SCDIV)) Q:SCDIV=""!SCOUT  D
 ..S SCTEAM=""
 ..F  S SCTEAM=$O(^TMP("SCRPT",$J,0,0,"PLIST",SCDIV,SCTEAM)) Q:SCTEAM=""!SCOUT  D
 ...S SCPNAM=""
 ...F  S SCPNAM=$O(^TMP("SCRPT",$J,0,0,"PLIST",SCDIV,SCTEAM,SCPNAM)) Q:SCPNAM=""!SCOUT  D
 ....S SCI=0
 ....F  S SCI=$O(^TMP("SCRPT",$J,0,0,"PLIST",SCDIV,SCTEAM,SCPNAM,SCI)) Q:'SCI!SCOUT  D
 .....S SCX=^TMP("SCRPT",$J,0,0,"PLIST",SCDIV,SCTEAM,SCPNAM,SCI)
 .....D PLINE(SCDIV,SCTEAM,SCPNAM,SCX)
 .....Q
 ....Q
 ...Q
 ..Q
 .Q
 I 'SCOUT,$E(IOST)="C" N DIR S DIR(0)="E" W ! D ^DIR
 Q
 ;
SLINE(SCN,SCX,SCPF,SCLF) ;Print summary line
 ;Input: SCN=name of item to print
 ;Input: SCX=string of item values
 ;Input: SCPF=minimum lines without page feed
 ;Input: SCLF=extra line feed flag
 ;
 N SCI,SCY
 S SCY="2^3^7^5^4^9^8^10^6^11^12"
 I $Y>(IOSL-SCPF) D FOOT^SCRPO7,HDR^SCRPO(.SCTITL,132),SHDR("S") S SCLF=0
 Q:SCOUT  W:SCPF>10&SCLF !
 ;bp/djb Omit PC? column from REPORT TOTAL line.
 ;Old code start
 ;W !,$E($P(SCN,U),1,28),?30,$S($P(SCX,U)="":"NO",1:$P(SCX,U))
 ;Old code end
 ;New code start
 I SCN["REPORT TOTAL" W !,$E($P(SCN,U),1,28)
 E  W !,$E($P(SCN,U),1,28),?30,$S($P(SCX,U)="":"NO",1:$P(SCX,U))
 ;New code end
 F SCI=1:1:11 W ?(27+(9*SCI)),$J(+$P(SCX,U,$P(SCY,U,SCI)),6,0)
 S SCLF=1
 Q
 ;
TLINE(SCDIV,SCTEAM,SCPNAM,SCX) ;Print broken team assignment line
 ;Input: SCDIV=division
 ;Input: SCTEAM=team
 ;Input: SCPNAM=patient name
 ;Input: SCX=string of patient assignment data
 ;
 N SCI,Y
 F SCI=3,4 S Y=$P($P(SCX,U,SCI),".") X ^DD("DD") S $P(SCX,U,SCI)=Y
 I $Y>(IOSL-4) D HDR^SCRPO(.SCTITL,132),SHDR("T") Q:SCOUT
 W !,$P(SCDIV,U),?32,$P(SCTEAM,U),?64,SCPNAM
 W ?96,$TR($P(SCX,U,2),"-",""),?108,$P(SCX,U,3),?121,$P(SCX,U,4)
 Q
 ;
PLINE(SCDIV,SCTEAM,SCPNAM,SCX) ;Print broken team assignment line
 ;Input: SCDIV=division
 ;Input: SCTEAM=team
 ;Input: SCPNAM=patient name
 ;Input: SCX=string of patient assignment data
 ;
 N SCI,Y
 F SCI=3,4 S Y=$P($P(SCX,U,SCI),".") X ^DD("DD") S $P(SCX,U,SCI)=Y
 I $Y>(IOSL-4) D HDR^SCRPO(.SCTITL,132),SHDR("P") Q:SCOUT
 W !,$P(SCDIV,U),?24,$P(SCTEAM,U),?48,SCPNAM,?72,$TR($P(SCX,U,2),"-","")
 W ?84,$P(SCX,U,5),?108,$P(SCX,U,3),?121,$P(SCX,U,4)
 Q
 ;
HDRX(SCX) ;extra header line
 ;Input: SCX='P' for parameters, 'S' for summary, 'T' for broken team
 ;            assignments, 'TP' for broken team position assignments
 ;
 Q:SCX="P" "Selected Report Parameters"
 Q:SCX="S" "Summary of Team and Team Position Assignments Effective: "_^TMP("SC",$J,"DTR","PBDT")_" to "_^TMP("SC",$J,"DTR","PEDT")
 Q:SCX="T" "Team Assignments Without Active Position Assignments Effective: "_^TMP("SC",$J,"DTR","PBDT")_" to "_^TMP("SC",$J,"DTR","PEDT")
 Q:SCX="TP" "Position Assignments Without Active Team Assignments Effective: "_^TMP("SC",$J,"DTR","PBDT")_" to "_^TMP("SC",$J,"DTR","PEDT")
 Q:"" 
 ;
HINI ;Initialize header variables
 N Y
 S SCTITL(1)="<*>  HISTORICAL TEAM ASSIGNMENT SUMMARY  <*>"
 S SCLINE="",$P(SCLINE,"-",133)="",SCPAGE=1
 S Y=$$NOW^XLFDT() X ^DD("DD") S SCPNOW=$P(Y,":",1,2)
 Q
 ;
SHDR(X) ;Print subheader
 Q:SCOUT
 N SCI
 I X="S" D  Q
 .W !?56,"Team  --Team Position-  --Team Position-    Total",?116,"Pts w/o  Pts w/o"
 .W !,"Division",?38,"Max.     Team  Assign.  ---Assignments--  ---Unique Pts.--   Unique     Open     Pos.     Team"
 .W !?2,"Team",?30,"PC?     Pts.  Assign.  Uniques  PC",?72,"Non-PC  PC",?90,"Non-PC     Pts.    Slots  Assign.  Assign."
 .W !,$E(SCLINE,1,28),"  ---" F SCI=0:1:10 W ?(35+(9*SCI)),"-------"
 .Q
 I X="T" D  Q
 .W !,"Division",?32,"Team",?64,"Patient Name",?96,"SSN",?108,"Active Date",?121,"Inact. Date"
 .W ! F SCI=1:1:3 W $E(SCLINE,1,30),"  "
 .W "----------  -----------  -----------"
 .Q
 I X="P" D  Q
 .W !,"Division",?24,"Team",?48,"Patient Name",?72,"SSN",?84,"Team Position",?108,"Active Date",?121,"Inact. Date"
 .W ! F SCI=1:1:3 W $E(SCLINE,1,22),"  "
 .W "----------  ",$E(SCLINE,1,22),"  -----------  -----------"
 .Q
 Q
