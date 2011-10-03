SCRPSLT ;ALB/CMM - Summary Listing of Teams ; 29 Jun 99  04:11PM
 ;;5.3;Scheduling;**41,52,177,231,520**;AUG 13, 1993;Build 26
 ;
 ;Summary Listing of Teams Report
 ;
PROMPTS ;
 ;Prompt for Institution, Team, Role and Print device
 ;
 N VAUTD,VAUTT,VAUTR,QTIME,PRNT,NUMBER
 K VAUTD,VAUTT,VAUTR,SCUP
 S QTIME=""
 W ! D INST^SCRPU1 I Y=-1 G ERR
 W ! K Y D PRMTT^SCRPU1 I '$D(VAUTT) G ERR
 W ! K Y D ROLE^SCRPU1 I '$D(VAUTR) G ERR
 W !!,"This report requires 132 column output!"
 D QUE(.VAUTD,.VAUTT,.VAUTR) Q
 ;
QUE(INST,TEAM,ROLE) ;queue report
 ;Input Parameters: 
 ;INST - institutions selected (variable and array) 
 ;TEAM - teams selected (variable and array) 
 ;ROLE - roles selected (variable and array)
 N ZTSAVE,II
 F II="INST","TEAM","ROLE","INST(","TEAM(","ROLE(" S ZTSAVE(II)=""
 W ! D EN^XUTMDEVQ("QENTRY^SCRPSLT","Summary Listing of Teams",.ZTSAVE)
 Q
 ;
ENTRY2(INST,TEAM,ROLE,IOP,ZTDTH) ;
 ;Second entry point for GUI to use
 ;Input Parameters:
 ;INST - institutions selected (variable and array)
 ;TEAM - teams selected (variable and array)
 ;ROLE - roles selected (variable and array)
 ;IOP - print device
 ;ZTDTH - queue time (optional)
 ;
 ;validate parameters
 I '$D(INST)!'$D(TEAM)!'$D(ROLE)!'$D(IOP)!(IOP="") Q
 ;
 N NUMBER
 S IOST=$P(IOP,"^",2),IOP=$P(IOP,"^")
 I IOP?1"Q;".E S IOP=$P(IOP,"Q;",2)
 I IOST?1"C-".E D QENTRY G RET
 I ZTDTH="" S ZTDTH=$H
 S ZTRTN="QENTRY^SCRPSLT"
 S ZTDESC="Summary Listing Of Teams",ZTIO=IOP
 N II
 F II="INST","TEAM","ROLE","INST(","TEAM(","ROLE(","IOP" S ZTSAVE(II)=""
 D ^%ZTLOAD
RET S NUMBER=0
 I $D(ZTSK) S NUMBER=ZTSK
 D EXIT1
 Q NUMBER
 ;
QENTRY ;
 ;driver entry point
 S TITL="Summary Listing of Teams"
 S STORE="^TMP("_$J_",""SCRPSLT"")"
 K @STORE
 S @STORE=0
 I TEAM=1 D TALL^SCRPPAT3 S TEAM=0
 D FIND
 I $O(@STORE@(0))="" S NODATA=$$NODATA^SCRPU3(TITL)
 I '$D(NODATA) D PRINTIT(STORE,TITL)
 D EXIT2
 Q
 ;
ERR ;
EXIT1 ;
 K ZTDTH,ZTRTN,ZTDESC,ZTSK,ZTIO,ZTSAVE,SCUP
 Q
 ;
EXIT2 ;
 K @STORE
 K STOP,STORE,TITL,IOP,TEAM,INST,ROLE,NODATA
 Q
 ;
FIND ;
 N TM,EN2,EN,ROL,NODE,TEND,ACT,INA,TPASS,TPCN,TMAX,TMP,TOA,TNPC
 S TM=""
 F  S TM=$O(^SCTM(404.57,"C",TM)) Q:TM=""  D
 .;$O through team position file
 .I '$D(TEAM(TM))&(TEAM'=1) Q
 .;Q above, not a selected team
 .;selected team
 .S EN=""
 .S TPASS(TM)=0,TMAX(TM)=0,TPCN(TM)=0
 .F  S EN=$O(^SCTM(404.57,"C",TM,EN)) Q:EN=""  D
 ..I '$D(^SCTM(404.57,EN,0)) Q
 ..S NODE=$G(^SCTM(404.57,EN,0))
 ..Q:NODE=""
 ..S ROL=+$P(NODE,"^",3) ;role ien
 ..I '$D(ROLE(ROL))&(ROLE'=1) Q
 ..;Q above not a selected role
 ..;find active position during date range
 ..S TMP=$$DATES^SCAPMCU1(404.52,EN,DT)
 ..I +TMP=0 Q
 ..S EN2=+$P(TMP,"^",4)
 ..D KEEP^SCRPSLT2(NODE,EN,EN2,ROL,TM,.TPCN,.TNPC)
 ..S TPASS(TM)=$$TEAMCNT^SCAPMCU1(TM,DT)
 ..S TMAX(TM)=+$P($G(^SCTM(404.51,+TM,0)),U,8)
 ..S TOA(TM)=TMAX(TM)-TPASS(TM) S:TOA(TM)<0 TOA(TM)=0
 ..D TEAMT^SCRPSLT2(TM,.TPASS,.TMAX,.TPCN,.TOA,.TNPC)
 Q
 ;
PRINTIT(STORE,TITL) ;
 N INST,EINST,ETEAM,TEM,EPRACT,PRACT,NXT,PAGE,NPAGE,NEW,POS,SCAC
 S (INST,EINST)="",(NPAGE,STOP)=0,PAGE=1 W:$E(IOST)="C" @IOF
 D TITLE^SCRPU3(.PAGE,TITL)
 D FORHEAD^SCRPSLT2
 F  S EINST=$O(@STORE@("I",EINST)) Q:EINST=""!(STOP)  D
 .S INST=$O(@STORE@("I",EINST,""))
 .I INST="" Q
 .S (TEM,ETEAM)=""
 .F  S ETEAM=$O(@STORE@("T",INST,ETEAM)) Q:ETEAM=""!(STOP)  D
 ..S TEM=$O(@STORE@("T",INST,ETEAM,""))
 ..I TEM="" Q
 ..K NEW
 ..I NPAGE,(IOST'?1"C-".E) D NEWP^SCRPSLT2(INST,TEM,TITL,.PAGE) S NEW=""
 ..I NPAGE,(IOST?1"C-".E) D HOLD1^SCRPSLT2(.PAGE,TITL,INST,TEM) S NEW=""
 ..S NPAGE=1 I STOP Q
 ..I IOST'?1"C-".E,$Y>(IOSL-8) D NEWP^SCRPSLT2(INST,TEM,TITL,.PAGE) S NEW=""
 ..I IOST?1"C-".E,$Y>(IOSL-8) D HOLD1^SCRPSLT2(.PAGE,TITL,INST,TEM) S NEW=""
 ..I STOP Q
 ..I '$D(NEW) D HEADER^SCRPSLT2(INST,TEM)
 ..S (PRACT,EPRACT)=""
 ..F  S EPRACT=$O(@STORE@("PN",INST,TEM,EPRACT)) Q:EPRACT=""!(STOP)  D
 ...S PRACT=$O(@STORE@("PN",INST,TEM,EPRACT,""))
 ...I PRACT="" Q
 ...S POS=""
 ...F  S POS=$O(@STORE@(INST,TEM,PRACT,POS)) Q:POS=""!(STOP)  D
 ....W !,$G(@STORE@(INST,TEM,PRACT,POS))
 ....S SCAC=""
 ....F  S SCAC=$O(@STORE@(INST,TEM,PRACT,POS,SCAC)) Q:SCAC=""!(STOP)  D
 .....W !,$G(@STORE@(INST,TEM,PRACT,POS,SCAC))
 .....I IOST'?1"C-".E,$Y>(IOSL-4) D NEWP^SCRPSLT2(INST,TEM,TITL,.PAGE)
 .....I IOST?1"C-".E,$Y>(IOSL-4) D HOLD1^SCRPSLT2(.PAGE,TITL,INST,TEM)
 .....I STOP Q
 ....;W !,$G(@STORE@(INST,TEM,PRACT,POS)) ;writes info
 ..Q:STOP
 ..I IOST'?1"C-".E,$Y>(IOSL-8) D NEWP^SCRPSLT2(INST,TEM,TITL,.PAGE,1)
 ..I IOST?1"C-".E,$Y>(IOSL-8) D HOLD1^SCRPSLT2(.PAGE,TITL,INST,TEM,1)
 ..D TOTAL^SCRPSLT2(INST,TEM)
 .I STOP Q
 .S NPAGE=1
 I 'STOP,$E(IOST)="C" N DIR S DIR(0)="E" D ^DIR
 Q
