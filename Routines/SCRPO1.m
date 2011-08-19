SCRPO1 ;BP-CIOFO/KEITH - Historical Patient Position Assignment Listing ; 20 Aug 99  7:49 AM
 ;;5.3;Scheduling;**177**;AUG 13, 1993
 ;
EN ;Queue report
 N LIST,SORT,SCSP,RTN,DESC
 S LIST="DIV,TEAM,POS,PCP,ASPR,CLINIC",SORT="DV,TM,TP,PR,EC,PA"
 S SCSP="PA",RTN="RUN^SCRPO1"
 S DESC="Historical Patient Position Assignment Listing"
 D PROMPT(LIST,SORT,SCSP,RTN,DESC) Q
 ;
PROMPT(LIST,SORT,SCSP,SCRTN,SCDESC) ;Prompt for report parameters, queue report
 ;Input: LIST=comma delimited string of list subscripts to prompt for
 ;Input: SORT=comma delimited string of sort acronyms to prompt for
 ;Input: SCSP=acronym of last sort to add if not selected (optional)
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
 G:'$$ATYPE^SCRPO(.SC) END
 G:'$$DSUM^SCRPO(.SC) END
 F SCI=1:1:$L(LIST,",") S SCX=$P(LIST,",",SCI) D  Q:SCOUT
 .S SCOUT='$$LIST^SCRPO(.SC,SCX,1)
 .Q
 G:SCOUT END
 D SUBT^SCRPW50("**** Output sort order (optional) ****")
 G:'$$SORT^SCRPO(.SC,SORT,SCSP) END
 S SCT(1)="**** Report Parameters Selected ****" D SUBT^SCRPW50(SCT(1))
 G:'$$PPAR^SCRPO(.SC,1,.SCT) END
 W !!,"This report requires 132 column output!"
 W ! N ZTSAVE S ZTSAVE("^TMP(""SC"",$J,")="",ZTSAVE("SC")=""
 D EN^XUTMDEVQ(SCRTN,SCDESC,.ZTSAVE)
END K ^TMP("SC",$J) D DISP0^SCRPW23,END^SCRPW50 Q
 ;
RUN ;Print report
 N SCFMT,SCTITL,SCTITL2,SCLINE,SCPAGE,SCOUT,SCFF,SCX,SCFF,SCLINE,SCPAGE
 N SC1,SC2,SC3,SC4,SC5,SC6,SC7,SCN,SCASP,SCUNP,SCI,SCPNOW
 S SCFMT=$E(^TMP("SC",$J,"FMT")),(SCFF,SCOUT,SCUNP)=0
 D BUILD(SCFMT) Q:SCOUT  S SCI=0
 F  S SCI=$O(^TMP("SCRPT",$J,0,"UNIQUES",SCI)) Q:'SCI  S SCUNP=SCUNP+1
 D HINI D:$E(IOST)="C" DISP0^SCRPW23
 S SCTITL(2)=$$HDRX("P") D HDR^SCRPO(.SCTITL,132) Q:SCOUT  S SCOUT=$$PPAR^SCRPO(.SC,,.SCTITL)=0
 Q:SCOUT
 I '$D(^TMP("SCRPT",$J,0)) D  G EXIT
 .K SCTITL(2) D HDR^SCRPO(.SCTITL,132) Q:SCOUT
 .S SCX="No patient position assignments found within selected report parameters!"
 .W !!?(132-$L(SCX)\2),SCX
 .Q
 S SCPAGE=1
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
 .......S SC7=""
 .......F  S SC7=$O(^TMP("SCRPT",$J,2,SCN,SC4,SC5,SC6,SC7)) Q:SC7=""!SCOUT  D
 ........S SCX=^TMP("SCRPT",$J,2,SCN,SC4,SC5,SC6,SC7)
 ........I $Y>(IOSL-9) D FOOT1,HDR^SCRPO(.SCTITL,132),SHDR("D") Q:SCOUT
 ........S SCY="0^20^27^39^43^57^73^89^94^110^122" W !
 ........F SCI=1:1:11 W ?($P(SCY,U,SCI)),$P(SCX,U,SCI)
 .......Q
 ......Q
 .....Q
 ....Q
 ...Q
 ..Q
 .D:'SCOUT FOOT1
 .Q
 G:SCOUT EXIT
 S SCTITL(2)=$$HDRX("S") D HDR^SCRPO(.SCTITL,132),SHDR("S") G:SCOUT EXIT
 S SCASP=^TMP("SCRPT",$J,0,"ASSIGNMENTS")
 F SCI="PRIMARY ELIGIBILITY","MEANS TEST CATEGORY","GENDER","AGE GROUP","NATIONAL ENROLLMENT PRIORITY","TEAM","PRIMARY CARE","ASSIGNED PROVIDER","PRECEPTOR PROVIDER","DIVISION" D  Q:SCOUT
 .Q:'$D(^TMP("SCRPT",$J,0,SCI))
 .D:$Y>(IOSL-9) FOOT2,HDR^SCRPO(.SCTITL,132),SHDR("S") Q:SCOUT
 .W ! D SLINE("--"_SCI_"--") S SCX=""
 .F  S SCX=$O(^TMP("SCRPT",$J,0,SCI,SCX)) Q:SCX=""!SCOUT  D
 ..S SCY=^TMP("SCRPT",$J,0,SCI,SCX)
 ..S SCZ=SCY*100/SCASP
 ..D:$Y>(IOSL-5) HDR^SCRPO(.SCTITL,132),SHDR("S") Q:SCOUT
 ..D SLINE(SCX,SCY,SCZ)
 ..Q
 .Q
 G:SCOUT EXIT
 W ! D SLINE("Total assignments that meet the parameters of this report:",SCASP,100)
 D SLINE("Total unique patients that meet the parameters of this report:",SCUNP,100)
 D FOOT2
 ;
EXIT I $E(IOST)="C",'$G(SCOUT) N DIR S DIR(0)="E" D ^DIR
 F SCI="SC","SCARR","SCRPT" K ^TMP(SCI,$J)
 K SC D END^SCRPW50 Q
 ;
SLINE(SCX,SCY,SCZ) ;Print summary line
 ;Input: SCX=element
 ;Input: SCY=count
 ;Input: SCZ=percent
 ;
 W !,$J($P(SCX,U),70) I $L($G(SCY)) W ?71,$J(SCY,10),?81,$J(SCZ,10,2)
 Q
 ;
SHDR(SCX) ;Print report subheader
 ;Input: SCX='D' for detail, 'S' for summary
 Q:SCOUT
 I SCX="S" D  Q
 .W !!?62,"Category",?76,"Count",?84,"Percent"
 .W !?30,$E(SCLINE,1,40),"   --------  --------"
 .Q
 W !?20,"Pat.",?27,"Primary",?38,"MT",?94,"Enrolled",!,"Patient Name"
 W ?20,"Id.",?27,"Elig.",?38,"Cat",?43,"Team",?57,"Provider"
 W ?73,"Team Position",?89,"PC?",?94,"Clinic",?110,"Act. Date"
 W ?122,"Inac. Date",!
 W "------------------  -----  ---------  ---  ------------  --------------  --------------  ---  --------------  ----------  ----------"
 Q
 ;
HDRX(SCX) ;extra header line
 ;Input: SCX='P' for parameters, 'D' for detail, 'S' for summary
 Q:SCX="P" "Selected Report Parameters"
 Q $S(SCX="D":"Detail",1:"Summary")_" for Patient Position Assignments Effective: "_^TMP("SC",$J,"DTR","PBDT")_" to "_^TMP("SC",$J,"DTR","PEDT")
 ;
HINI ;Initialize header variables
 N Y
 S SCTITL(1)="<*>  HISTORICAL PATIENT POSITION ASSIGNMENT LISTING  <*>"
 S SCLINE="",$P(SCLINE,"-",133)="",SCPAGE=1
 S Y=$$NOW^XLFDT() X ^DD("DD") S SCPNOW=$P(Y,":",1,2)
 Q
 ;
STOP ;Check for stop task request
 S:$D(ZTQUEUED) (SCOUT,ZTSTOP)=$S($$S^%ZTLOAD:1,1:0) Q
 ;
BUILD(SCFMT) ;Build report data
 ;Input: SCFMT=report format (detail or summary)
 N SCTM,SCTP
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
 S SCTEAM=$P(SCTP0,U,2) Q:'$$TMDV(.SCTEAM,.SCDIV)
 S SCLINIC=$P(SCTP0,U,9) Q:'$$TPCL(.SCLINIC)
 D BTPOS(SCTP,SCDIV,SCTEAM,SCPOS,SCLINIC,SCFMT)
 Q
 ;
TPCL(SCLINIC) ;Get team position associated clinic
 ;Input: SCLINIC=associated clinic pointer from team position
 ;               (returned as name^ifn, if successful and one exists)
 ;Output: '1' if success, '0' otherwise
 ;
 I $O(^TMP("SC",$J,"CLINIC",0)),'$D(^TMP("SC",$J,"CLINIC",+SCLINIC)) Q 0
 Q:SCLINIC<1 1
 S SCLINIC=$P($G(^SC(SCLINIC,0)),U)_U_SCLINIC
 Q 1
 ;
TMDV(SCTEAM,SCDIV) ;Get team and division
 ;Input: SCTEAM=team ifn (returned as name^ifn, if successful)
 ;Input: SCDIV=variable to return division as name^ifn
 ;Output: '1' if success, '0' otherwise
 N SCTM0,SCX
 Q:SCTEAM<1 0
 I $O(^TMP("SC",$J,"TEAM",0)),'$D(^TMP("SC",$J,"TEAM",SCTEAM)) Q 0
 S SCTM0=$G(^SCTM(404.51,SCTEAM,0)) Q:'$L(SCTM0) 0
 S SCX=$P(SCTM0,U) Q:'$L(SCX) 0
 S SCTEAM=SCX_U_SCTEAM
 S SCDIV=$P(SCTM0,U,7) Q:SCDIV<1 0
 I $O(^TMP("SC",$J,"DIV",0)),'$D(^TMP("SC",$J,"DIV",SCDIV)) Q 0
 S SCX=$P($G(^DIC(4,SCDIV,0)),U) Q:'$L(SCX) 0
 S SCDIV=SCX_U_SCDIV
 Q 1
 ;
BTPOS(SCTP,SCDIV,SCTEAM,SCPOS,SCLINIC,SCFMT) ;Build list of patients for a position
 ;Input: SCTP=team position ifn
 ;Input: SCDIV=division^ifn
 ;Input: SCTEAM=team^ifn
 ;Input: SCPOS=team position^ifn
 ;Input: SCLINIC=associated clinic^ifn (if one exists)
 ;Input: SCFMT=report format (detail or summary)
 ;
 N SCARR,SCDT,SCI,SCPASS
 S SCARR="^TMP(""SCARR"",$J,1)" K @SCARR
 M SCDT=^TMP("SC",$J,"DTR") S SCDT="SCDT"
 S SCI=$$PTTP^SCAPMC(SCTP,.SCDT,SCARR),SCI=0
 F  S SCI=$O(^TMP("SCARR",$J,1,SCI)) Q:'SCI  D
 .S SCPASS=^TMP("SCARR",$J,1,SCI)
 .D BPTPA^SCRPO2(SCPASS,SCDIV,SCTEAM,SCPOS,SCLINIC,SCFMT)
 .Q
 Q
 ;
FOOT1 ;Detail report footer
 N SCI
 F SCI=1:1:80 W ! Q:$Y>(IOSL-7)
 W !,SCLINE
 W !,"NOTE: More than one provider may be associated with a single patient position assignment.  This output returns a separate output"
 W !?6,"line for each related provider during the date range selected."
 W !!?6,"'PC?' represents provider type:  AP = Associate provider, PCP = Primary Care Provider, NPC = Non-Primary Care Provider."
 W !,SCLINE
 Q
 ;
FOOT2 ;Summary report footer
 N SCI
 F SCI=1:1:80 W ! Q:$Y>(IOSL-7)
 W !,SCLINE
 W !,"NOTE: More than one provider may be associated with a single patient position assignment.  The sum of assignments related to"
 W !?6,"providers detailed in this summary is likely to be greater than the actual number of patient position assignments"
 W !?6,"returned by this report."
 W !,SCLINE
 Q
