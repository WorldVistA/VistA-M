SCRPTM ;ALB/CMM - List of Team's Members Report ; 29 Jun 99  04:11PM
 ;;5.3;Scheduling;**41,48,52,181,177,520**;AUG 13, 1993;Build 26
 ;
 ;List of Team's Members Report
 ;
PROMPTS ;
 ;Prompt for Institution, Team, Date Range, User Class, Role
 ;and Print device
 ;
 N VAUTD,VAUTT,VAUTUC,VAUTR,QTIME,RANG,PRNT,NUMBER
 K VAUTD,VAUTT,VAUTUC,VAUTR,SCUP
 S QTIME=""
 W ! D INST^SCRPU1 I Y=-1 G ERR
 W ! K Y D PRMTT^SCRPU1 I '$D(VAUTT) G ERR
 W ! K Y S RANG=$$DTRANG^SCRPU2() I +RANG=-1 G ERR
 W ! K Y D USER^SCRPU1 I '$D(VAUTUC)&($P($G(^SD(404.91,1,"PCMM")),"^")=1) G ERR
 W ! K Y D ROLE^SCRPU1 I '$D(VAUTR) G ERR
 D QUE(.VAUTD,.VAUTT,.VAUTUC,.VAUTR,RANG) Q
 ;
QUE(INST,TEAM,USERC,ROLE,RANGE) ;queue report
 ;Input Parameters: 
 ;INST - institutions selected (variable and array) 
 ;TEAM - teams selected (variable and array) 
 ;USERC - user classes selected (variable and array) 
 ;ROLE - roles selected (variable and array) 
 ;RANGE - date range selected (begin date ^ end date)
 N ZTSAVE,II
 F II="INST","TEAM","USERC","ROLE","INST(","TEAM(","USERC(","ROLE(","RANGE" S ZTSAVE(II)=""
 W ! D EN^XUTMDEVQ("QENTRY^SCRPTM","Team Member Listing",.ZTSAVE)
 Q
 ;
ENTRY2(INST,TEAM,USERC,ROLE,RANGE,IOP,ZTDTH) ;
 ;Second entry point for GUI to use
 ;Input Parameters:
 ;INST - institutions selected (variable and array)
 ;TEAM - teams selected (variable and array)
 ;USERC - user classes selected (variable and array)
 ;ROLE - roles selected (variable and array)
 ;RANGE - date range selected (begin date ^ end date)
 ;IOP - print device
 ;ZTDTH - queue time (optional)
 ;
 ;validate parameters
 I '$D(INST)!'$D(TEAM)!'$D(ROLE)!'$D(RANGE)!'$D(IOP)!(IOP="") Q
 ;
 N NUMBER
 S IOST=$P(IOP,"^",2),IOP=$P(IOP,"^")
 I IOP?1"Q;".E S IOP=$P(IOP,"Q;",2)
 I IOST?1"C-".E D QENTRY G RET
 I ZTDTH="" S ZTDTH=$H
 S ZTRTN="QENTRY^SCRPTM"
 S ZTDESC="List of Team's Members",ZTIO=IOP
 N II
 F II="INST","TEAM","USERC","ROLE","INST(","TEAM(","USERC(","ROLE(","RANGE","IOP" S ZTSAVE(II)=""
 D ^%ZTLOAD
RET S NUMBER=0
 I $D(ZTSK) S NUMBER=ZTSK
 D EXIT1
 Q NUMBER
 ;
QENTRY ;
 ;driver entry point
 S TITL="Team Member Listing"
 S STORE="^TMP("_$J_",""SCRPTM"")"
 K @STORE
 S @STORE=0
 D BUILD
 I $O(@STORE@(0))="" S NODATA=$$NODATA^SCRPU3(TITL)
 I '$D(NODATA) D PRINTIT(STORE,TITL)
 D EXIT2
 Q
 ;
ERR ;
EXIT1 ;
 K ZTDTH,ZTRTN,ZTDESC,ZTSK,ZTIO,ZTSAVE,SCUP
 Q
EXIT2 ;
 K @STORE
 K STOP,STORE,TITL,IOP,TEAM,INST,NODATA,RANGE,ROLE,USERC
 Q
 ;
BUILD ;get report data
 ;get all practitioners for all teams selected
 I TEAM=1 D TALL ;all teams selected
 N TIEN,OKAY,XLIST,YLIST,SCTP,SCI,SCDT,PLIST
 S SCDT("BEGIN")=$P(RANGE,U),SCDT("END")=$P(RANGE,U,2)
 S SCDT("INCL")=0,SCDT="SCDT"
 S TIEN="",PLIST="^TMP(""SCRP"",$J,""LIST"")"
 F  S TIEN=$O(TEAM(TIEN)) Q:TIEN=""!(TIEN'?.N)  D
 .K XLIST,@PLIST
 .S OKAY=$$TPTM^SCAPMC(TIEN,.SCDT,"","","XLIST","ERROR")
 .S SCTP=0 F  S SCTP=$O(XLIST("SCTP",TIEN,SCTP)) Q:'SCTP  D
 ..S SCTP0=$G(^SCTM(404.57,SCTP,0)) Q:'$L(SCTP0)
 ..I ROLE'=1,'$D(ROLE(+$P(SCTP0,U,3))) Q  ;not a selected role
 ..I $D(USERC),USERC'=1,'$D(USERC(+$P(SCTP0,U,13))) Q  ;not a selected user class
 ..K YLIST
 ..S OKAY=$$PRTP^SCAPMC(SCTP,.SCDT,"YLIST","ERROR",1,0)
 ..S SCI=0 F  S SCI=$O(YLIST(SCI)) Q:'SCI  D
 ...S @PLIST@(0)=$G(@PLIST@(0))+1
 ...S @PLIST@(@PLIST@(0))=YLIST(SCI)
 ...Q
 ..Q
 .I OKAY D PULL^SCRPTM2(TIEN,.PLIST)
 .Q
 Q
 ;
TALL ;
 ;get all active team for divisions selected
 N NXT,IIEN,NODE
 S NXT=0,IIEN=""
 ;$O through team file and find all active teams for selected divisions
 F  S IIEN=$O(^SCTM(404.51,"AINST",IIEN)) Q:IIEN=""  D
 .I INST=1!$D(INST(IIEN)) D
 ..S TIEN=0
 ..F  S TIEN=$O(^SCTM(404.51,"AINST",IIEN,TIEN)) Q:TIEN=""  D
 ...I $$ACTTM^SCMCTMU(TIEN) S TEAM(TIEN)=""
 Q
 ;
PRINTIT(STORE,TITL) ;
 N INST,EINST,ETEAM,TEM,EPRACT,PRACT,PAGE,NXT,NPAGE,CNT,HEAD,POS
 S EINST="",(NPAGE,STOP,HEAD)=0,PAGE=1 W:$E(IOST)="C" @IOF
 D TITLE^SCRPU3(.PAGE,TITL)
 F  S EINST=$O(@STORE@("I",EINST)) Q:EINST=""!(STOP)  D
 .S INST=$O(@STORE@("I",EINST,""))
 .Q:INST=""
 .I 'NPAGE W !,$G(@STORE@(INST)) ;write institution line
 .S (ETEAM,TEM)=""
 .F  S ETEAM=$O(@STORE@("T",INST,ETEAM)) Q:ETEAM=""!(STOP)  D
 ..S TEM=$O(@STORE@("T",INST,ETEAM,0))
 ..I TEM="" Q
 ..S NXT="H"
 ..I NPAGE,(IOST'?1"C-".E) D NEWP^SCRPTM2(INST,TEM,TITL,.PAGE,.HEAD) S NPAGE=0
 ..I NPAGE,(IOST?1"C-".E) D HOLD1^SCRPTM2(.PAGE,TITL,INST,TEM,.HEAD) S NPAGE=0
 ..I STOP Q
 ..I IOST'?1"C-".E,$Y>(IOSL-5) D NEWP^SCRPTM2(INST,TEM,TITL,.PAGE,.HEAD)
 ..I IOST?1"C-".E,$Y>(IOSL-5) D HOLD1^SCRPTM2(.PAGE,TITL,INST,TEM,.HEAD)
 ..I STOP Q
 ..F  S NXT=$O(@STORE@(INST,TEM,NXT)) Q:NXT'?1"H".E!(STOP)  D
 ...I 'HEAD W !,$G(@STORE@(INST,TEM,NXT)) S HEAD=0 ;writes team info
 ..S (EPRACT,PRACT)=""
 ..W ! ;extra line between members and practioner list
 ..F  S EPRACT=$O(@STORE@("PN",INST,TEM,EPRACT)) Q:EPRACT=""!(STOP)  D
 ...F  S PRACT=$O(@STORE@("PN",INST,TEM,EPRACT,PRACT)) Q:PRACT=""!(STOP)  D
 ....I PRACT="" Q
 ....S POS=""
 ....F  S POS=$O(@STORE@("PN",INST,TEM,EPRACT,PRACT,POS)) Q:POS=""!(STOP)  D
 .....D PRNTD(INST,TEM,PRACT,POS,TITL,.PAGE,.HEAD)
 .....W ! ;seperated positions
 ....W ! ;separates practitioners
 .S NPAGE=1
 I 'STOP,$E(IOST)="C" N DIR S DIR(0)="E" W ! D ^DIR
 Q
 ;
PRNTD(INST,TEM,PRACT,POS,TITL,PAGE,HEAD) ;
 ;
 N CNT,SCAC
 S CNT=""
 I IOST'?1"C-".E,$Y>(IOSL-11) D NEWP^SCRPTM2(INST,TEM,TITL,.PAGE,.HEAD)
 I IOST?1"C-".E,$Y>(IOSL-11) D HOLD1^SCRPTM2(.PAGE,TITL,INST,TEM,.HEAD)
 I STOP Q
 F  S CNT=$O(@STORE@(INST,TEM,PRACT,POS,CNT)) Q:CNT=""!(STOP)  D
 .W !,$G(@STORE@(INST,TEM,PRACT,POS,CNT))
 .S SCAC="" I CNT=4  D
 ..F  S SCAC=$O(@STORE@(INST,TEM,PRACT,POS,4,SCAC)) Q:SCAC=""!(STOP)  D
 ...W !,$G(@STORE@(INST,TEM,PRACT,POS,4,SCAC))
 Q
