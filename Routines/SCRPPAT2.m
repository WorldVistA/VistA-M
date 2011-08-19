SCRPPAT2 ;ALB/CMM - Practitioner's Patients ; 12/12/00 3:46pm
 ;;5.3;Scheduling;**41,48,174,181,177,231,433,297,526,520**;AUG 13, 1993;Build 26
 ;
 ;Listing of Practitioner's Patients
 ;
DRIVE ;
 ;driver module
 N PRAC,INF,ARRY,ERROR,NXT,OKAY,PIEN,TPRC
 S ARRY="^TMP(""SCARRAY"","_$J_")",ERROR="ERR"
 S TPRC="^TMP(""SCRP"",$J,""PRACT"")" M @TPRC=PRACT
 K @ARRY,@ERROR,PRACT
 I @TPRC=1 D ALL^SCRPPAT3 ;all practitioners selected
 S NXT=0
 F  S NXT=$O(@TPRC@(NXT)) Q:NXT=""!(NXT'?.N)  D
 .I @TPRC=0 S PIEN=NXT
 .I @TPRC=1 S PIEN=$P(@TPRC@(NXT),"^")
 .K @ARRY,@ERROR
 .S OKAY=$$PTPR^SCAPMC14(PIEN,"","","",ARRY,ERROR) ;patients for practitioner
 .I '+OKAY Q
 .D LOOPPT(ARRY,PIEN) ;loop through patients for practitioner
 K @ARRY,@ERROR,@TPRC
 K:SUMM @STORE@("PT")
 Q
 ;
LOOPPT(ARY,PRAC) ;loop through patients for practitioner
 ;ARY - array of patients for selected practitioner
 ;PRAC - practitioner ien
 N NXT,PIEN,TPIEN,PNAME,TPIEN,NODE,PTP,TPI,TPN,CLIEN,PTA,PTAN,TIEN
 N PC,TNODE,TNAME,PINF,POSN,PRCP,CNAME
 S NXT=0
 F  S NXT=$O(@ARY@(NXT)) Q:NXT=""!(NXT'?.N)  D
 .S NODE=$G(@ARY@(NXT))
 .Q:NODE=""
 .S PIEN=+$P(NODE,"^") ;ien of patient file entry
 .S TPIEN=+$P(NODE,"^",3) ;ien of patient team position assignment
 .S PTP=$G(^SCPT(404.43,TPIEN,0))
 .Q:PTP=""
 .S PTA=+$P(PTP,"^") ;patient team assignment ien (404.42)
 .S PTAN=$G(^SCPT(404.42,PTA,0))
 .Q:PTAN=""
 .S TIEN=+$P(PTAN,"^",3) ;team file ien (404.51)
 .I $G(TEAM)'=1,'$D(TEAM(TIEN)) Q  ;not a selected team
 .S TNODE=$G(^SCTM(404.51,TIEN,0))
 .Q:TNODE=""  I $G(INST)'=1,'$D(INST(+$P(TNODE,U,7))) Q
 .S TNAME=$P(TNODE,"^") ;team name
 .S TPI=+$P(PTP,"^",2) ;Team Position file ien (404.57)
 .S TPN=$G(^SCTM(404.57,TPI,0))
 .Q:TPN=""
 .I $G(ROLE)'=1,'$D(ROLE(+$P(TPN,U,3))) Q  ;not a selected role
 .S POSN=$P(TPN,"^") ;position name
 .D SETASCL^SCRPRAC2(TPI,.CNAME,.CLIEN)  ;get clinics from multiple
 .;S CLIEN=+$P(TPN,"^",9) ;associated clinic ien
 .;commented next line off - clinic enrollment no longer needed SD*5.3*433
 .;D CECHK(CLIEN,.CNAME,PIEN) ;is patient enrolled in associated clinic?
 .;S CNAME=$P($G(^SC(CLIEN,0)),"^")  ; SD*5.3*433 remove enroll check
 .S PC=$S($P(PTP,"^",5)=0:0,1:1) ;primary care position 1or2-yes/0-no
 .S PNAME=$P($G(^VA(200,+PRAC,0)),"^") ;practitioner name
 .Q:PNAME=""
 .S PRCP=$P($$OKPREC2^SCMCLK(TPI,DT),U,2)
 .D GETPINF(PIEN,.CLIEN,.PINF)  ;get patient information and appointments
 .S CNAME=$G(CNAME(0))  ;first line will capture position information
 .S PINF=$G(PINF(0))
 .I PINF=""  D 
 ..S PINF=PIEN_"^"_$$PDATA^SCRPEC(PIEN,CNAME,CNAME,1)
 .D FORMAT(CNAME,PINF,PC,TIEN,TNAME,PRAC,PNAME,POSN,TPI,PRCP)
 .D SETFORM(PIEN,.CNAME,.PINF)
SETFORM(PIEN,CNAME,PINF)  ;Format for clinic info only for multiples
 N SCCNT
 S SCCNT=0 F  S SCCNT=$O(PINF(SCCNT)) Q:SCCNT=""  D FORMATAC(CNAME(SCCNT),PINF(SCCNT),PC,TIEN,TNAME,PRAC,PNAME,POSN,TPI,PRCP)
 Q
GETPINF(PIEN,CLIEN,PINF)  ;get patient info 
 N SCCNT
 S SCCNT="" F  S SCCNT=$O(CLIEN(SCCNT)) Q:SCCNT=""  D 
 .S PINF(SCCNT)=PIEN_"^"_$$PDATA^SCRPEC(PIEN,CLIEN(SCCNT),CNAME(SCCNT),1)
 Q
 ;
CECHK(CLIEN,CNAME,PIEN) ;should no longer be used as of patch SD*5.3*433
 ;CLIEN - clinic ien
 ;CNAME - clinic name returned if patient is enrolled in clien clinic
 ;PIEN - patien ien
 ;
 N EN,NODE
 S CNAME=""
 I $D(^DPT(PIEN,"DE","B",CLIEN)) D
 .;enrolled at one time, check if discharged
 .S EN=$O(^DPT(PIEN,"DE","B",CLIEN,""))
 .S NODE=$G(^DPT(PIEN,"DE",EN,0))
 .Q:NODE=""
 .I $P(NODE,"^",3)="" S CNAME=$P($G(^SC(CLIEN,0)),"^") ;clinic name
 .I $P(NODE,"^",3)'="",$P(NODE,"^",3)>DT S CNAME=$P($G(^SC(CLIEN,0)),"^") ;clinic name
 Q
 ;
FORMAT(CNAME,PINF,PC,TIEN,TNAME,PRAC,PNAME,POSN,TPI,PRCP) ; format data for display
 ;CNAME - clinic name
 ;PINF - patient/clinic data
 ;PC - primary care 1/0
 ;TIEN - team file ien (#404.51)
 ;TNAME - team name
 ;PRAC - practitioner ien (#200)
 ;PNAME - practitioner name
 ;POSN - position name
 ;TPI - team position ien (#404.57)
 ;PRCP - preceptor name
 ;
 N IIEN,INAME,ERR
 S ERR=$$SETUP^SCRPPAT3(.IIEN,.INAME,TIEN,TNAME,PRAC,PNAME,POSN,TPI,PRCP)
 I ERR Q
 ;
 I SORT=1 D STOR(IIEN,TIEN,PRAC,PINF,PNAME,TNAME,TPI) ;sort division,team,practitioner
 I SORT=2 D STOR(IIEN,PRAC,TIEN,PINF,PNAME,TNAME,TPI) ;sort division,practitioner,team
 I SORT=3 D STOR(1,PRAC,1,PINF,PNAME,"T3",TPI)
 Q
 ;
FORMATAC(CNAME,PINF,PC,TIEN,TNAME,PRAC,PNAME,POSN,TPI,PRCP) ; format data for display
 ;CNAME - clinic name
 ;PINF - patient/clinic data
 ;PC - primary care 1/0
 ;TIEN - team file ien (#404.51)
 ;TNAME - team name
 ;PRAC - practitioner ien (#200)
 ;PNAME - practitioner name
 ;POSN - position name
 ;TPI - team position ien (#404.57)
 ;PRCP - preceptor name
 ;
 N IIEN,INAME,ERR
 S ERR=$$SETUP^SCRPPAT3(.IIEN,.INAME,TIEN,TNAME,PRAC,PNAME,POSN,TPI,PRCP)
 I ERR Q
 ;
 I SORT=1 D STORA(IIEN,TIEN,PRAC,PINF,PNAME,TNAME,TPI,SCCNT) ;sort division,team,practitioner
 I SORT=2 D STORA(IIEN,PRAC,TIEN,PINF,PNAME,TNAME,TPI,SCCNT) ;sort division,practitioner,team
 I SORT=3 D STORA(1,PRAC,1,PINF,PNAME,"T3",TPI,SCCNT)
 Q
 ;
STOR(IIEN,SEC,TRD,PINF,PNAME,TNAME,TPI,SCCNT) ;
 ;IIEN - ien institution
 ;SEC - second sort subscript, IEN team or IEN practitioner
 ;TRD - third sort subscript, IEN team or IEN practitioner
 ;PINF - patient/clinic info
 ;PNAME - practitioner name
 ;TNAME - team name
 ;TPI - team position ien
 ;
 N PIEN,PTNAME,PID
 S PIEN=+$P(PINF,"^") ;patient ien 
 S PTNAME=$E($P(PINF,"^",2),1,10) ;patient name
 Q:$D(@STORE@("PT",IIEN,SEC,TRD,TPI,PTNAME,PIEN))
 S @STORE@("PT",IIEN,SEC,TRD,TPI,PTNAME,PIEN)=""
 I 'SUMM,'$D(@STORE@("PTOT",IIEN,SEC,TRD,PIEN)) D
 .;count each unique patient for any given practitioner for grand total
 .S @STORE@("PTOT",IIEN,SEC,TRD,PIEN)=""
 .S @STORE@("TOTAL",IIEN,PRAC,0)=$G(@STORE@("TOTAL",IIEN,PRAC,0))+1 ;patient count by practitioner
 ;
 S @STORE@("TOTAL",IIEN,PRAC,$S(SORT=3:1,1:TIEN),TPI)=$G(@STORE@("TOTAL",IIEN,PRAC,$S(SORT=3:1,1:TIEN),TPI))+1 ;patient count by practitioner and team
 Q:SUMM
 ;
 S @STORE@(IIEN,SEC,TRD,TPI,PIEN)=PTNAME
 S PID=$P(PINF,"^",3),PID=$TR(PID,"-","")
 S $E(@STORE@(IIEN,SEC,TRD,TPI,PIEN),13)=PID ;ssn
 S $E(@STORE@(IIEN,SEC,TRD,TPI,PIEN),25)=$P(PINF,"^",4) ;means test status
 S $E(@STORE@(IIEN,SEC,TRD,TPI,PIEN),31)=$P(PINF,"^",5) ;eligibility
 ;Removed by patch 174
 ;S $E(@STORE@(IIEN,SEC,TRD,TPI,PIEN),40)=$P(PINF,"^",6) ;patient status
 S $E(@STORE@(IIEN,SEC,TRD,TPI,PIEN),42)=$P(PINF,"^",8) ;last appt
 S $E(@STORE@(IIEN,SEC,TRD,TPI,PIEN),54)=$P(PINF,"^",9) ;nxt appt
 S $E(@STORE@(IIEN,SEC,TRD,TPI,PIEN),66)=$E(CNAME,1,15) ;clinic
 Q
STORA(IIEN,SEC,TRD,PINF,PNAME,TNAME,TPI,SCCNT) ;
 I '$D(@STORE@(IIEN,SEC,TRD,TPI,PIEN,SCCNT))  D
 .S $E(@STORE@(IIEN,SEC,TRD,TPI,PIEN,SCCNT),42)=$P(PINF,"^",8) ;last appt
 .S $E(@STORE@(IIEN,SEC,TRD,TPI,PIEN,SCCNT),54)=$P(PINF,"^",9) ;nxt appt
 .S $E(@STORE@(IIEN,SEC,TRD,TPI,PIEN,SCCNT),66)=$E(CNAME,1,15) ;clinic
 .Q
 Q 
