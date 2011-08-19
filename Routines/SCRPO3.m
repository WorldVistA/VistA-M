SCRPO3 ;BP-CIOFO/KEITH - Historical Provider Position Assignment Listing ; 9/14/99 10:06am
 ;;5.3;Scheduling;**177**;AUG 13, 1993
 ;
EN ;Queue report
 N LIST,SORT,RTN,DESC,SCSP
 S LIST="DIV,TEAM,POS,ASPR,CLINIC",SORT="DV,TM,TP,PR,EC",SCSP="PR"
 S RTN="RUN^SCRPO3"
 S DESC="Historical Provider Position Assignment Listing"
 D PROMPT^SCRPO1(LIST,SORT,SCSP,RTN,DESC) Q
 ;
RUN ;Print report
 N SCFMT,SCTITL,SCTITL2,SCLINE,SCPAGE,SCOUT,SCFF,SCX,SCPNOW,SCFD
 N SC1,SC2,SC3,SC4,SC5,SC6,SCN,SCI,SCPNOW,SCY,SCFF,SCLINE,SCPAGE
 S SCFMT=$E(^TMP("SC",$J,"FMT")),(SCFF,SCOUT)=0
 D BUILD(SCFMT) Q:SCOUT  S SCI=0
 D HINI D:$E(IOST)="C" DISP0^SCRPW23
 ;print report parameters
 S SCTITL(2)=$$HDRX("P") D HDR^SCRPO(.SCTITL,132) Q:SCOUT  S SCOUT=$$PPAR^SCRPO(.SC,,.SCTITL)=0
 Q:SCOUT
 ;print negative report
 I '$D(^TMP("SCRPT",$J,0)) D  G EXIT
 .K SCTITL(2) D HDR^SCRPO(.SCTITL,132) Q:SCOUT
 .S SCX="No provider position assignments found within selected report parameters!"
 .W !!?(132-$L(SCX)\2),SCX
 .Q
 S SCPAGE=1
 ;print detailed report
 I SCFMT="D" S SCTITL(2)=$$HDRX("D") D HDR^SCRPO(.SCTITL,132),SHDR("D") Q:SCOUT  D
 .S SC1=""
 .F  S SC1=$O(^TMP("SCRPT",$J,1,SC1)) Q:SC1=""!SCOUT  D
 ..S SC2=""
 ..F  S SC2=$O(^TMP("SCRPT",$J,1,SC1,SC2)) Q:SC2=""!SCOUT  D
 ...S SC3=""
 ...F  S SC3=$O(^TMP("SCRPT",$J,1,SC1,SC2,SC3)) Q:SC3=""!SCOUT  D
 ....S SCN=^TMP("SCRPT",$J,1,SC1,SC2,SC3),SC4=""
 ....F  S SC4=$O(^TMP("SCRPT",$J,2,SCN,SC4)) Q:SC4=""!SCOUT  D
 .....S SC5=""
 .....F  S SC5=$O(^TMP("SCRPT",$J,2,SCN,SC4,SC5)) Q:SC5=""!SCOUT  D
 ......S SC6=""
 ......F  S SC6=$O(^TMP("SCRPT",$J,2,SCN,SC4,SC5,SC6)) Q:SC6=""!SCOUT  D
 .......S SCX=^TMP("SCRPT",$J,2,SCN,SC4,SC5,SC6)
 .......I $Y>(IOSL-11) D FOOT1,HDR^SCRPO(.SCTITL,132),SHDR("D") Q:SCOUT
 .......S SCY="0^21^41^46^67^86^94^102^110^118^126" W !
 .......F SCI=1:1:5 W ?($P(SCY,U,SCI)),$P(SCX,U,SCI)
 .......F SCI=6:1:11 W ?($P(SCY,U,SCI)),$J($P(SCX,U,SCI),6,0)
 ......Q
 .....Q
 ....Q
 ...Q
 ..Q
 .D:'SCOUT FOOT1
 .Q
 G:SCOUT EXIT
 ;print summary report
 S SCTITL(2)=$$HDRX("S") D HDR^SCRPO(.SCTITL,132),SHDR("S") G:SCOUT EXIT
 S (SCFD,SCDIV)=0
 F  S SCDIV=$O(^TMP("SCRPT",$J,0,SCDIV)) Q:SCDIV=""!SCOUT  D
 .S SCPC=$S($D(^TMP("SCRPT",$J,0,SCDIV,"PC")):"YES",1:"NO")
 .S SCX=^TMP("SCRPT",$J,0,SCDIV)
 .D:$Y>(IOSL-11) FOOT2,HDR^SCRPO(.SCTITL,132),SHDR("S") Q:SCOUT
 .W:SCFD ! D SLINE(SCDIV,SCPC,SCX) S SCTEAM="",SCFD=1
 .F  S SCTEAM=$O(^TMP("SCRPT",$J,0,SCDIV,1,SCTEAM)) Q:SCTEAM=""!SCOUT  D
 ..S SCPC=$S($D(^TMP("SCRPT",$J,0,SCDIV,1,SCTEAM,"PC")):"YES",1:"NO")
 ..S SCX=^TMP("SCRPT",$J,0,SCDIV,1,SCTEAM)
 ..D:$Y>(IOSL-10) FOOT2,HDR^SCRPO(.SCTITL,132),SHDR("S") Q:SCOUT
 ..D SLINE("  "_SCTEAM,SCPC,SCX)
 ..Q
 .Q
 G:SCOUT EXIT
 ;bp/djb Stop displaying PC? on Total line
 ;Old code begin
 ;S SCPC=$S($D(^TMP("SCRPT",$J,0,0,"PC")):"YES",1:"NO")
 ;Old code end
 ;New code begin
 S SCPC=""
 ;New code end
 S SCX=^TMP("SCRPT",$J,0,0)
 W ! D SLINE("REPORT TOTAL:",SCPC,SCX)
 D FOOT2
 ;
EXIT I $E(IOST)="C",'$G(SCOUT) W ! N DIR S DIR(0)="E" D ^DIR
 F SCI="SC","SCARR","SCRPT" K ^TMP(SCI,$J)
 K SC D END^SCRPW50 Q
 ;
SLINE(SCNAME,SCPC,SCX) ;Print report summary line
 ;Input: SCNAME=division or team name to print
 ;Input: SCPC=primary care y/n
 ;Input: SCX=slot/assignment data
 ;
 W !?22,$P(SCNAME,U),?56,SCPC
 F SCI=1:1:6 W ?(53+(8*SCI)),$J($P(SCX,U,SCI),6,0)
 Q
 ;
HINI ;Initialize header variables
 N Y
 S SCTITL(1)="<*>  HISTORICAL PROVIDER POSITION ASSIGNMENT LISTING  <*>"
 S SCLINE="",$P(SCLINE,"-",133)="",SCPAGE=1
 S Y=$$NOW^XLFDT() X ^DD("DD") S SCPNOW=$P(Y,":",1,2)
 Q
 ;
SHDR(SCX) ;Print report subheader
 ;Input: SCX='D' for detail, 'S' for summary
 Q:SCOUT
 I SCX="S" D  Q
 .W !?63,"Max.",?69,"---Assigned---",?93,"---Precepted--"
 .W !?22,"Division",?63,"Pts.",?69,"---Patients---",?87,"Open"
 .W ?93,"---Patients---",!?24,"Team",?56,"PC?  Allow.  PC"
 .W ?77,"Non-PC   Slots  PC      Non-PC"
 .W !?22,"--------------------------------  ---  ------  ------  ------  ------  ------  ------"
 .Q
 W !?88,"Max.  ---Assigned---",?118,"---Precepted--",!
 W ?88,"Pts.  ---Patients---    Open  ---Patients---",!,"Provider Name"
 W ?21,"Position",?41,"PC?  Team",?67,"Associated Clinic"
 W ?86,"Allow.  PC      Non-PC   Slots  PC      Non-PC"
 W !,"-------------------  ------------------  ---  -------------------  -----------------  ------  ------  ------  ------  ------  ------"
 Q
 ;
HDRX(SCX) ;extra header line
 ;Input: SCX='P' for parameters, 'D' for detail, 'S' for summary
 Q:SCX="P" "Selected Report Parameters"
 Q $S(SCX="D":"Detail",1:"Summary")_" for Provider Position Assignments Effective: "_^TMP("SC",$J,"DTR","PBDT")_" to "_^TMP("SC",$J,"DTR","PEDT")
 ;
STOP ;Check for stop task request
 S:$D(ZTQUEUED) (SCOUT,ZTSTOP)=$S($$S^%ZTLOAD:1,1:0) Q
 ;
BUILD(SCFMT) ;Build report data
 ;Input: SCFMT=report format (detail or summary)
 N SCTM,SCTP,SCPR,SCARR,ERR,SCI
 ;Build from provider list
 I $O(^TMP("SC",$J,"ASPR",0)) S SCPR=0 D  Q
 .F  S SCTP=$O(^TMP("SC",$J,"ASPR",SCPR)) Q:'SCPR!SCOUT  D
 ..D STOP Q:SCOUT
 ..M SCDT=^TMP("SC",$J,"DTR") S SCDT="SCDT"
 ..S SCARR="^TMP(""SCARR"",$J,1)" K @SCARR
 ..S SCI=$$TPPR^SCAPMC(SCPR,.SCDT,,,SCARR,"ERR")
 ..S SCTM=0 F  S SCTM=$O(^TMP("SCARR",$J,1,"SCTP",SCTM)) Q:'SCTM  D
 ...S SCTP=0 F  S SCTP=$O(^TMP("SCARR",$J,1,"SCTP",SCTM,SCTP)) Q:'SCTP  D
 ....S ^TMP("SCARR",$J,0,SCTP)=""
 ....Q
 ...Q
 ..Q
 .S SCTP=0 F  S SCTP=$O(^TMP("SCARR",$J,0,SCTP)) Q:'SCTP!SCOUT  D
 ..D CKPOS(SCTP,SCFMT),STOP
 ..Q
 .Q
 ;Build from position list
 I $O(^TMP("SC",$J,"POS",0)) S SCTP=0 D  Q
 .F  S SCTP=$O(^TMP("SC",$J,"POS",SCTP)) Q:'SCTP!SCOUT  D
 ..D CKPOS(SCTP,SCFMT),STOP
 ..Q
 .Q
 ;Build from all positions
 S SCTP=0 F  S SCTP=$O(^SCTM(404.57,SCTP)) Q:'SCTP!SCOUT  D
 .D CKPOS(SCTP,SCFMT),STOP
 .Q
 Q
 ;
CKPOS(SCTP,SCFMT) ;Check team position
 ;Input: SCTP=TEAM POSITION ifn
 ;Input: SCFMT=report format (detail or summary)
 ;
 N SCDIV,SCTEAM,SCPOS,SCLINIC,SCTP0,SCX
 S SCTP0=$G(^SCTM(404.57,+SCTP,0)) Q:'$L(SCTP0)
 S SCX=$P(SCTP0,U) Q:'$L(SCX)
 S SCPOS=SCX_U_SCTP
 S SCTEAM=$P(SCTP0,U,2) Q:'$$TMDV^SCRPO1(.SCTEAM,.SCDIV)
 S SCLINIC=$P(SCTP0,U,9) Q:'$$TPCL^SCRPO1(.SCLINIC)
 D BTPOS(SCTP,SCDIV,SCTEAM,SCPOS,SCLINIC,SCFMT)
 Q
 ;
BTPOS(SCTP,SCDIV,SCTEAM,SCPOS,SCLINIC,SCFMT) ;Build from team position
 ;Input: SCTP=team position ifn
 ;Input: SCDIV=division^ifn
 ;Input: SCTEAM=team^ifn
 ;Input: SCPOS=team position^ifn
 ;Input: SCLINIC=associated clinic^ifn (if one exists)
 ;Input: SCFMT=report format (detail or summary)
 ;
 N SCARR,SCDT,SCI,SCPASS,ERR
 S SCARR="^TMP(""SCARR"",$J,1)" K @SCARR
 M SCDT=^TMP("SC",$J,"DTR") S SCDT="SCDT"
 S SCI=$$PRTP^SCAPMC(SCTP,.SCDT,SCARR,"ERR",0,0),SCI=0
 F  S SCI=$O(^TMP("SCARR",$J,1,SCI)) Q:'SCI  D
 .S SCPASS=^TMP("SCARR",$J,1,SCI)
 .D BPRPA^SCRPO4(SCPASS,SCDIV,SCTEAM,SCPOS,SCLINIC,SCFMT)
 .Q
 Q
 ;
FOOT1 ;Detail report footer
 N SCI
 F SCI=1:1:80 W ! Q:$Y>(IOSL-9)
 W !,SCLINE
 W !,"NOTE: This report reflects a count of all unique patients assigned to Primary Care and non-Primary Care within the date range"
 W !?6,"selected.  If a date range larger than one day has been selected, the total patients assigned to a provider may be greater"
 W !?6,"than the maximum defined for the position.  However, this does not imply that the provider had more than their maximum"
 W !?6,"number of patients on any single date."
 W !,SCLINE
 Q
 ;
FOOT2 ;Summary report footer
 N SCI
 F SCI=1:1:80 W ! Q:$Y>(IOSL-8)
 W !,SCLINE
 W !,"NOTE: Although presented by division and team, the maximum patients allowed, assigned patients, open slots and precepted patients"
 W !?6,"reflected in this summary represent a sum of those categories for the provider position assignments identified within the"
 W !?6,"user specified parameters of this report and may not match the maximum patients, etc. defined for the team as a whole."
 W !,SCLINE
 Q
