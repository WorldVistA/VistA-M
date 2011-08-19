SCRPTA ;ALB/CMM - Patient Listing w/Team Assignment Data ; 29 Jun 99  04:11PM
 ;;5.3;Scheduling;**41,48,52,114,174,181,177,526**;AUG 13, 1993;Build 8
 ;
 ;Patient Listing w/Team Assignment Data Report
 ;
PROMPTS ;
 ;Prompt for Institution, Team, Role, Practitioner and Print device
 ;
 N PRNT,QTIME,NUMBER
 K VAUTD,VAUTT,VAUTR,VAUTP,VAUTPP,SCUP
 S QTIME=""
 W ! D INST^SCRPU1 I Y=-1 G ERR
 W ! K Y D PRMTT^SCRPU1 I '$D(VAUTT) G ERR
 W ! K Y D ROLE^SCRPU1 I '$D(VAUTR) G ERR
 W ! K Y S VAUTPP="" D PRACT^SCRPU1 K VAUTPP I '$D(VAUTP) G ERR
 W !!,"This report requires 132 column output!"
 D QUE(.VAUTD,.VAUTT,.VAUTR,.VAUTP) Q 
 ;
QUE(INST,TEAM,ROLE,PRACT) ; 
 ;Input Parameters: 
 ;INST - institutions selected (variable and array) 
 ;TEAM - teams selected (variable and array) 
 ;ROLE - roles selected (variable and array) 
 ;PRACT - practitioners selected (variable and array) 
 N ZTSAVE,II
 F II="INST","TEAM","ROLE","INST(","TEAM(","PRACT","PRACT(","ROLE(" S ZTSAVE(II)=""
 W ! D EN^XUTMDEVQ("QENTRY^SCRPTA","Patient Listing for Team Assignments",.ZTSAVE)
 Q
 ;
ENTRY2(INST,TEAM,ROLE,PRACT,IOP,ZTDTH) ;
 ;Second entry point for GUI to use
 ;Input Parameters:
 ;INST - institutions selected (variable and array)
 ;TEAM - teams selected (variable and array)
 ;ROLE - roles selected (variable and array)
 ;PRACT - practitioners selected (variable and array)
 ;IOP - print device
 ;ZTDTH - queue time (optional)
 ;
 ;validate parameters
 I '$D(INST)!'$D(TEAM)!'$D(ROLE)!'$D(PRACT)!'$D(IOP)!(IOP="") Q
 ;
 N NUMBER
 S IOST=$P(IOP,"^",2),IOP=$P(IOP,"^")
 I IOP?1"Q;".E S IOP=$P(IOP,"Q;",2)
 I IOST?1"C-".E D QENTRY G RET
 I ZTDTH="" S ZTDTH=$H
 S ZTRTN="QENTRY^SCRPTA"
 S ZTDESC="Patient Listing w/Team Assignment",ZTIO=IOP
 N II
 F II="INST","TEAM","ROLE","INST(","TEAM(","PRACT","PRACT(","ROLE(","IOP" S ZTSAVE(II)=""
 D ^%ZTLOAD
RET S NUMBER=0
 I $D(ZTSK) S NUMBER=ZTSK
 D EXIT1
 Q NUMBER
 ;
QENTRY ;
 ;driver entry point
 S TITL="Patient Listing For Team Assignments"
 S STORE="^TMP("_$J_",""SCRPTA"")"
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
 K ZTDTH,ZTRTN,ZTDESC,ZTSK,ZTIO,ZTSAVE,Y,SCUP
 Q
 ;
EXIT2 ;
 K @STORE
 K STOP,STORE,TITL,IOP,TEAM,INST,ROLE,NODATA,PRACT
 Q
 ;
FIND ;
 N NXT,TLIST,TERR,CNT,ERR1,TNODE,NODE1,PIEN,PTAIEN
 S NXT=0,TLIST="^TMP("_$J_",""SCRPTA"",""LIST1"")",TERR="ERR1"
 K @TLIST,@TERR
 F  S NXT=$O(TEAM(NXT)) Q:NXT=""!(NXT'?.N)  D
 .S ERR1=$$PTTM^SCAPMC2(NXT,,.TLIST,.TERR) ;Patients assigned to team NXT
 .Q:ERR1=0
 .S CNT=0
 .F  S CNT=$O(@TLIST@(CNT)) Q:CNT=""!(CNT'?.N)  D
 ..S TNODE=$G(@TLIST@(CNT))
 ..Q:TNODE=""
 ..S PIEN=+$P(TNODE,"^") ;patient ien
 ..S PTAIEN=+$P(TNODE,"^",3) ;ien Patient Team Assignment #404.42
 ..D CHK^SCRPTA2(PTAIEN,PIEN)
 .K @TLIST,@TERR
 K @TLIST,@TERR
 Q
 ;
PRINTIT(STORE,TITL) ;
 N NXT,PAGE,NPAGE,INTN,TMN,INT,TM,PRN,PR,POS
 S (NPAGE,STOP,PAGE)=0,INTN="" W:$E(IOST)="C" @IOF
 D SHEAD ;setup headers
 F  S INTN=$O(@STORE@("I",INTN)) Q:INTN=""!(STOP)  D
 .S INT=$O(@STORE@("I",INTN,"")) ;institution
 .Q:INT=""
 .S TMN=""
 .F  S TMN=$O(@STORE@("T",INT,TMN)) Q:TMN=""!(STOP)  D
 ..S TM=$O(@STORE@("T",INT,TMN,"")) ;team
 ..Q:TM=""
 ..D NEWP1^SCRPU3(.PAGE,TITL,132) W !,$G(@STORE@(INT)),!!,$G(@STORE@(INT,TM))
 ..Q:STOP
 ..S PRN=""
 ..D HEADER
 ..F  S PRN=$O(@STORE@("P",INT,TM,PRN)) Q:PRN=""!(STOP)  D
 ...S PR=$O(@STORE@("P",INT,TM,PRN,"")) ;practitioner
 ...Q:PR=""
 ...S POS=""
 ...F  S POS=$O(@STORE@("P",INT,TM,PRN,PR,POS)) Q:POS=""!(STOP)  D
 ....D PRNT(INT,TM,PR,POS)
 I 'STOP,$E(IOST)="C" N DIR S DIR(0)="E" W ! D ^DIR
 Q
 ;
PRNT(INT,TM,PR,POS) ;
 ;INT - institution ien
 ;TM - team ien
 ;PR - practitioner ien
 ;POS - position ien
 ;
 N PTIEN,PTNAME
 S PTNAME=""
 F  S PTNAME=$O(@STORE@(INT,TM,PR,POS,PTNAME)) Q:PTNAME=""!(STOP)  D
 .S PTIEN=""
 .F  S PTIEN=$O(@STORE@(INT,TM,PR,POS,PTNAME,PTIEN)) Q:PTIEN=""!(STOP)  D
 ..I (IOST'?1"C-".E),$Y>(IOSL-4) D NEWP1^SCRPU3(.PAGE,TITL,132) W:'STOP !,$G(@STORE@(INT)),!!,$G(@STORE@(INT,TM)) D:'STOP HEADER
 ..I (IOST?1"C-".E),$Y>(IOSL-4) D HOLD^SCRPU3(.PAGE,TITL,132) W:'STOP !,$G(@STORE@(INT)),!!,$G(@STORE@(INT,TM)) D:'STOP HEADER
 ..Q:STOP
 ..W !,$G(@STORE@(INT,TM,PR,POS,PTNAME,PTIEN))
 .Q
 Q
 ;
HEADER ;
 ;write column headers
 N EN
 W !
 F EN="H1","H2","H3" D
 .W !,$G(@STORE@(EN))
 Q
SHEAD ;
 ;setup column headers
 S @STORE@("H2")="Patient Name"
 S $E(@STORE@("H2"),19)="Pt ID"
 S $E(@STORE@("H1"),31)="Date"
 S $E(@STORE@("H2"),31)="Assigned"
 S $E(@STORE@("H2"),43)="PC?"
 S $E(@STORE@("H2"),49)="Practitioner"
 S $E(@STORE@("H2"),70)="Position"
 S $E(@STORE@("H2"),92)="Standard Role"
 S $E(@STORE@("H2"),113)="Preceptor"
 S $P(@STORE@("H3"),"=",133)=""
 Q
