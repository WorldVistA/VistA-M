SCRPPAT3 ;ALB/CMM - Practitioner's Patients ; 8/30/99 3:14pm
 ;;5.3;Scheduling;**41,52,148,174,181,177,297,526,520,535**;AUG 13, 1993;Build 3
 ;
 ;Listing of Practitioner's Patients
 ;
PAT(INS,SEC,TRD,SEC3,ST3,ST4,POS) ;
 ;writes patients for position/practitioner
 N PTN,PT,FIRST
 S PTN="",FIRST=1
 I SUMM D TOTAL1^SCRPPAT3(INS,SEC,TRD,POS) Q  ;Summary only
 F  S PTN=$O(@STORE@("PT",INS,SEC,TRD,POS,PTN)) Q:PTN=""!(STOP)  D
 .S PT=0
 .F  S PT=$O(@STORE@("PT",INS,SEC,TRD,POS,PTN,PT)) Q:'PT!(STOP)  D
 ..I FIRST D HEADER S FIRST=0
 ..W !,$G(@STORE@(INS,SEC,TRD,POS,PT)) ;print patient detail line
 ..N SCCN
 ..S SCCN=""
 ..F  S SCCN=$O(@STORE@(INS,SEC,TRD,POS,PT,SCCN)) Q:SCCN=""  D
 ...W !,$G(@STORE@(INS,SEC,TRD,POS,PT,SCCN)) ;print patient detail line
 ...Q:STOP
 ..Q
 .I (IOST'?1"C-".E),$Y>(IOSL-5) S MORE=0 D NEWP1^SCRPU3(.PAGE,TITL) D:'STOP HEAD2(INS,SEC,TRD,SEC3,ST3,ST4,POS) D:(('FIRST&'STOP)!($G(SORT)=3)) HEADER
 .I (IOST?1"C-".E),$Y>(IOSL-5) S MORE=0 D HOLD^SCRPU3(.PAGE,TITL) D:'STOP HEAD2(INS,SEC,TRD,SEC3,ST3,ST4,POS) D:'FIRST&'STOP HEADER
 .Q
 Q
 ;
SPRINT(STORE,IOP,TITL,SORT) ; Summary Print Only
 ;STORE - global location of data
 ;IOP - device to print to
 ;TITL - title of report
 ;SORT - sort order 1-div,team,pract/2-div,pract,team
 ;
 N PAGE
 S PAGE=1,STOP=0
 D OPEN^SCRPU3
 Q:$G(POP)
 D TITLE^SCRPU3(.PAGE,TITL)
 D CLOSE^SCRPU3
 Q
 ;
TOTAL1(INS,SEC,TRD,POS) ;
 ;print team/practitioner total
 N TEM,PRC
 I SORT=1 S TEM=SEC,PRC=TRD
 I SORT=2!(SORT=3) S TEM=TRD,PRC=SEC
 W !!,$G(@STORE@("TH",INS,PRC,TEM,POS)),$G(@STORE@("TOTAL",INS,PRC,TEM,POS))
 Q
 ;
HEAD2(INS,SEC,TRD,SEC3,ST3,ST4,POS) ;
 I (SEC3="""TN""")&($D(@ST4@(INS,TRD,SEC))) D
 .W !,$G(@ST3@(INS,SEC)) ;write team (sort 1)
 .W !,$G(@STORE@(INS))
 .W !,$G(@ST4@(INS,TRD,SEC,POS)) ;write practitioner (sort 2)
 .I $L($G(@STORE@("PN",INS,TRD,SEC,POS,"PRCP"))) W !,@STORE@("PN",INS,TRD,SEC,POS,"PRCP")
 .W !
 I (SEC3="""PN""")&($D(@ST3@(INS,SEC,TRD))) D
 .W !,$G(@ST3@(INS,SEC,TRD,POS)) ;write practitioner (sort 1)
 .I $G(SORT)'=3 I $L($G(@STORE@("PN",INS,SEC,TRD,POS,"PRCP"))) W !,@STORE@("PN",INS,SEC,TRD,POS,"PRCP")
 .I $G(SORT)'=3 W !,$G(@ST4@(INS,TRD)) ;write team (sort 2)
 .W !,$G(@STORE@(INS))
 Q
 ;
HEADER ;
 Q:$G(MORE)
 I SORT=3 S MORE=1
 N NXT
 F NXT="H1","H2","H3" W !,$G(@STORE@(NXT))
 W !
 Q
 ;
SHEAD ;
 S @STORE@("H2")="Pt Name"
 S $E(@STORE@("H2"),15)="Pt ID"
 S $E(@STORE@("H1"),25)="M.T."
 S $E(@STORE@("H2"),25)="Stat"
 S $E(@STORE@("H1"),31)="Prim"
 S $E(@STORE@("H2"),31)="Elig"
 ;Removed by patch 174
 ;S $E(@STORE@("H1"),39)="Pat"
 ;S $E(@STORE@("H2"),39)="Stat"
 S $E(@STORE@("H1"),42)="Last"
 S $E(@STORE@("H2"),42)="Appt"
 S $E(@STORE@("H1"),54)="Next"
 S $E(@STORE@("H2"),54)="Appt"
 S $E(@STORE@("H2"),66)="Clinic"
 S $P(@STORE@("H3"),"=",81)=""
 Q
ALL ;
 ;get all practitioners for all teams selected
 I TEAM=1 D TALL ;all teams selected
 N TIEN,OKAY,XLIST,YLIST,SCTP,SCI,SCDT
 S TIEN=""
 F  S TIEN=$O(TEAM(TIEN)) Q:TIEN=""!(TIEN'?.N)  D
 .I $D(TEAM(TIEN)) D
 ..K XLIST
 ..S OKAY=$$TPTM^SCAPMC(TIEN,"","","","XLIST","ERROR")
 ..S SCTP=0 F  S SCTP=$O(XLIST("SCTP",TIEN,SCTP)) Q:'SCTP  D
 ...K YLIST S SCDT="SCDT",(SCDT("BEGIN"),SCDT("END"))=DT,SCDT("INCL")=0
 ...S OKAY=$$PRTP^SCAPMC(SCTP,.SCDT,"YLIST","ERROR",1,0)
 ...S SCI=0 F  S SCI=$O(YLIST(SCI)) Q:'SCI  D
 ....S @TPRC@(0)=$G(@TPRC@(0))+1
 ....S @TPRC@(@TPRC@(0))=YLIST(SCI)
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
SETUP(IIEN,INAME,TIEN,TNAME,PRAC,PNAME,POSN,TPI,PRCP) ;
 ;setup data
 S IIEN=+$P($G(^SCTM(404.51,TIEN,0)),"^",7) ;institution ien
 S INAME=$P($G(^DIC(4,IIEN,0)),"^") ;institution name
 I INAME="" S INAME="[BAD DATA]"
 ;
 I PNAME="" S PNAME="[BAD DATA]"
 I TNAME="" S TNAME="[BAD DATA]"
 I $G(SORT)=3 S IIEN=1,TIEN=1
 I '$D(@STORE@("PN",IIEN,PRAC,TIEN,TPI)) S @STORE@("PN",IIEN,PRAC,TIEN,TPI)="Practitioner: "_PNAME_$S(SORT=3:"",1:" ("_POSN_")")
 I $L(PRCP) S @STORE@("PN",IIEN,PRAC,TIEN,TPI,"PRCP")="   Preceptor: "_PRCP
 I '$D(@STORE@("TN",IIEN,$S($G(SORT)=3:1,1:TIEN))) S @STORE@("TN",IIEN,$S($G(SORT)=3:1,1:TIEN))="        Team: "_TNAME
 ;
 I '$D(@STORE@("I",$S($G(SORT)=3:"S3",1:INAME),IIEN)) S @STORE@("I",$S($G(SORT)=3:"S3",1:INAME),IIEN)="",@STORE@(IIEN)=$S(SORT=3:"",1:"    Division: "_INAME)
 S @STORE@("T",IIEN,$S($G(SORT)=3:"T3",1:TNAME),$S($G(SORT)=3:1,1:TIEN))=""
 I '$D(@STORE@("P",IIEN,PNAME,PRAC,TPI)) S @STORE@("P",IIEN,PNAME,PRAC,TPI)=""
 I '$D(@STORE@("TOTAL",IIEN,PRAC,0)) S @STORE@("TOTAL",IIEN,PRAC,0)=0
 I '$D(@STORE@("TOTAL",IIEN,PRAC,TIEN)) S @STORE@("TOTAL",IIEN,PRAC,TIEN)=0
 ;
 S @STORE@("TH",IIEN,PRAC)="Patient Count for "_PNAME_": "
 S @STORE@("TH",IIEN,PRAC,TIEN,TPI)="Patient Count for "_PNAME_": "
 N SCX
 S SCX=$E(PNAME,1,22),$E(SCX,25)=$E(POSN,1,22),$E(SCX,49)=$E(TNAME,1,22)
 S @STORE@("SUM0",IIEN,PRAC,TIEN,TPI)=SCX
 ;
 S @STORE@("TH",IIEN)="** Note: Patient Panel Count is a count of unique patients for each practitioner"
 Q 0
