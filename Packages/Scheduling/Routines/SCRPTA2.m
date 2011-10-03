SCRPTA2 ;ALB/CMM - Patient Listing w/Team Assignment Data ; 30 Jun 99  1:33 PM
 ;;5.3;Scheduling;**41,88,140,148,174,181,177,526**;AUG 13, 1993;Build 8
 ;
 ;Patient Listing w/Team Assignment Data Report continued
 ;
CHK(PTIEN,PIEN) ;assigned to a position
 ;PTIEN - ien of 404.42 Patient Team Assignment file
 ;PIEN - ien of patient file #2
 ;
 N NODE,START,TPIEN,TPNODE,ROL,PRAC,ROLN,PCAP,PRCN
 S START=""
 Q:'$D(^SCPT(404.43,"B",PTIEN))&(PRACT'="")
 I '$D(^SCPT(404.43,"B",PTIEN))&(PRACT="") D NOTA(PTIEN,PIEN) Q
 F  S START=$O(^SCPT(404.43,"B",PTIEN,START)) Q:START=""  D
 .S NODE=$G(^SCPT(404.43,START,0))
 .Q:NODE=""
 .Q:($P(NODE,"^",4)'="")&($P(NODE,"^",4)<DT)
 .; ^ not assigned currently
 .S PCAP=+$P(NODE,U,5)
 .S TPIEN=+$P(NODE,"^",2) ;team position ien (404.57)
 .I '$D(^SCTM(404.57,TPIEN,0)) D NOTA(PTIEN,PIEN) Q
 .S TPNODE=$G(^SCTM(404.57,TPIEN,0))
 .I TPNODE="" D NOTA(PTIEN,PIEN) Q
 .S PCAP=$S('PCAP:"NPC",+$$OKPREC3^SCMCLK(TPIEN,DT)>0:" AP",1:"PCP") ; PC?
 .S PRCN=$P($$OKPREC2^SCMCLK(TPIEN,DT),U,2)  ;preceptor name
 .;
 .S ROL=+$P(TPNODE,"^",3) ;role for position (ien)
 .Q:'$D(ROLE(ROL))&(ROLE'=1)  ;not a selected role
 .S ROLN=$P($G(^SD(403.46,ROL,0)),U) ;role name
 .;
 .S PRAC=$$PRACI(TPIEN) ;practitioner information
 .I +PRAC=-1 D NOTA(PTIEN,PIEN) Q
 .I (PRACT'=1)&('$D(PRACT(+PRAC)))&(+PRAC'=0) Q
 .; ^ not a selected practitioner
 .;
 .S POS=$P($G(^SCTM(404.57,TPIEN,0)),"^")
 .D FOUND2(START,NODE,TPIEN,POS,TPNODE,PRAC,PIEN,ROLN,PCAP,PRCN)
 Q
PRACI(TPIEN) ;
 ;TPIEN - team position ien (404.57)
 ;
 N EN,TPLIST,TPERR,NAME,POS,ERR,NPIEN,NODE,POSIEN
 S TPLIST="TPLST",TPERR="ERR2"
 K @TPLIST,@TPERR
 S ERR=$$PRTP^SCAPMC8(TPIEN,,.TPLIST,.TPERR)
 Q:ERR=0!($D(@TPERR)) -1
 S NODE=$G(@TPLIST@(1))
 Q:NODE="" "0^[Not Assigned]"
 S NAME=$P(NODE,"^",2) ;practitioner name
 S NPIEN=+$P(NODE,"^") ;practitioner ien
 S POS=$P(NODE,"^",4) ;position name
 S POSIEN=+$P(NODE,"^",3) ;position ien
 I POS="" S POS="[Not Assigned]",POSIEN=0
 I NAME="" S NAME="[Not Assigned]",NPIEN=0
 K @TPLIST,@TPERR
 Q NPIEN_"^"_NAME_"^"_POS_"^"_POSIEN
 ;
FOUND2(START,NODE,TPIEN,POS,TPNODE,PRAC,PIEN,ROLN,PCAP,PRCN) ;
 ;START - patient team assignment position ien
 ;NODE - patient team position assignment node
 ;TPIEN - team position ien (404.57)
 ;POS - team position
 ;TPNODE - team position node (404.57)
 ;PRAC - practitioner info. NAME IEN^NAME^POS^POSIEN
 ;ROLN - role name 
 ;PCAP - PC/AP/NPC assignment?
 ;PRCN - preceptor name
 ;
 N PTNAME,PID,ADATE
 S PTNAME=$P($G(^DPT(PIEN,0)),"^") ;patient name
 S PID=$P($G(^DPT(PIEN,.36)),"^",3),PID=$TR(PID,"-","")
 ;9 digit ssn SD*5.3*526 - dmr
 ;S PID=$E(PID,6,10) ;last four pid include 5th for pseudo notation
 ;
 S ADATE=$P(NODE,"^",3) ;position assignment date - fm format
 ;convert to external format
 I ADATE'="" S ADATE=$TR($$FMTE^XLFDT(ADATE,"5DF")," ","0")
 ;
 S PNAME=$P(PRAC,"^",2) ;practitioner name
 S PNIEN=$P(PRAC,"^") ;practitioner ien
 ;
 S TIEN=+$P(TPNODE,"^",2) ;ien team file 404.51
 S TMN=$G(^SCTM(404.51,TIEN,0))
 Q:TMN=""
 S TNAME=$P(TMN,"^") ;team name
 S PC=$P(TMN,"^",5) ;primary care team 1/0
 S IIEN=+$P(TMN,"^",7) ;institution ien
 S INAME=$P($G(^DIC(4,IIEN,0)),"^") ;institution
 ;
 D FORMAT(IIEN,INAME,TNAME,TIEN,PC,PTNAME,PID,PNAME,PNIEN,POS,TPIEN,ADATE,PIEN,ROLN,PCAP,PRCN)
 Q
 ;
FORMAT(IIEN,INAME,TNAME,TIEN,PC,PTNAME,PID,PNAME,PIEN,POS,TPIEN,ADATE,PTIEN,ROLN,PCAP,PRCN) ;
 ;IIEN - institution ien
 ;INAME - institution name
 ;TNAME - team name
 ;TIEN - team ien
 ;PC - primary care 1/0
 ;PTNAME - patient name
 ;PID - last 4 pid plus 5th pseudo
 ;PNAME - practitioner name
 ;PIEN - practitioner ien
 ;POS - position name
 ;TPIEN - position ien
 ;ADATE - assignment date
 ;PTIEN - patient ien
 ;ROLN - role name 
 ;PCAP - PC/AP/NPC assignment? 
 ;PRCN - preceptor name
 ;
 I INAME="" S INAME="[BAD DATA]"
 I TNAME="" S TNAME="[BAD DATA]"
 I PNAME="" S PNAME="[BAD DATA]"
 I '$D(@STORE@("I",INAME,IIEN)) S @STORE@("I",INAME,IIEN)=""
 I '$D(@STORE@("T",IIEN,TNAME,TIEN)) S @STORE@("T",IIEN,TNAME,TIEN)=""
 I '$D(@STORE@("P",IIEN,TIEN,PNAME,PIEN,TPIEN)) S @STORE@("P",IIEN,TIEN,PNAME,PIEN,TPIEN)=""
 S @STORE@(IIEN)="Division: "_INAME
 S @STORE@(IIEN,TIEN)="Team:  "_TNAME
 S $E(@STORE@(IIEN,TIEN),40)="Primary Care Team: "_$S(PC=1:"YES",1:"NO")
 ;
 S @STORE@(IIEN,TIEN,PIEN,TPIEN,PTNAME,PTIEN)=$E(PTNAME,1,17)
 S $E(@STORE@(IIEN,TIEN,PIEN,TPIEN,PTNAME,PTIEN),19)=PID
 S $E(@STORE@(IIEN,TIEN,PIEN,TPIEN,PTNAME,PTIEN),31)=ADATE
 S $E(@STORE@(IIEN,TIEN,PIEN,TPIEN,PTNAME,PTIEN),43)=PCAP
 S $E(@STORE@(IIEN,TIEN,PIEN,TPIEN,PTNAME,PTIEN),49)=$E(PNAME,1,21)
 S $E(@STORE@(IIEN,TIEN,PIEN,TPIEN,PTNAME,PTIEN),70)=$E(POS,1,20)
 S $E(@STORE@(IIEN,TIEN,PIEN,TPIEN,PTNAME,PTIEN),92)=$E(ROLN,1,20)
 S $E(@STORE@(IIEN,TIEN,PIEN,TPIEN,PTNAME,PTIEN),113)=$E(PRCN,1,20)
 Q
 ;
NOTA(PTIEN,PIEN) ;
 ;PTIEN - patient team assignment (#404.42)
 ;PIEN - patient ien
 N IIEN,INAME,TNAME,TIEN,PC,PTNAME,PID,PNAME,PNIEN,POSIEN,POS,TPIEN
 N ROLN,PCAP,PRCN,ADATE
 S POS="[Not Assigned]",POSIEN=0
 S PNAME="[Not Assigned]",PNIEN=0
 S (ROLN,PCAP,PRCN,ADATE)=""
 ;
 S PTNAME=$E($P($G(^DPT(PIEN,0)),"^"),1,20) ;patient name
 S PID=$P($G(^DPT(PIEN,.36)),"^",3),PID=$TR(PID,"-","")
 ;S PID=$E(PID,6,10) ;9 digit ssn patch 526
 ;
 S TIEN=+$P($G(^SCPT(404.42,PTIEN,0)),"^",3) ;team ien
 S TMN=$G(^SCTM(404.51,TIEN,0))
 Q:TMN=""
 S TNAME=$P(TMN,"^") ;team name
 S PC=$P(TMN,"^",5) ;primary care team 1/0
 S IIEN=+$P(TMN,"^",7) ;institution ien
 S INAME=$P($G(^DIC(4,IIEN,0)),"^") ;institution name
 ;
 D FORMAT(IIEN,INAME,TNAME,TIEN,PC,PTNAME,PID,PNAME,PNIEN,POS,POSIEN,ADATE,PIEN,ROLN,PCAP,PRCN)
 Q
