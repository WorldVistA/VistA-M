SCRPTM2 ;ALB/CMM - List of Team's Members Report Continued;01/29/96 ; 29 Jun 99  04:11PM
 ;;5.3;Scheduling;**41,140,177,520**;AUG 13, 1993;Build 26
 ;
 ;List of Team's Members Report
 ;
PULL(TIEN,PLIST) ;
 ;TIEN - team file ien
 ;PLIST - array of positions and their practitioners
 ;
 N PNAME,TPIEN,ACT,INACT,RNAME,UNAME,CNT,NODE,TNODE,PCLIN,TNAME,SCI
 N TPHONE,TPC,INS,INAME,PRIEN,PRNAME,OPH,ROOM,SERV,TPNODE,PRCP,PCLASS
 ;
 S CNT=0
 F  S CNT=$O(@PLIST@(CNT)) Q:CNT=""!(CNT'?.N)  D
 .;get each practitioner/position
 .S NODE=$G(@PLIST@(CNT))
 .S TPIEN=+$P(NODE,"^",3) ;team position ien
 .S PNAME=$P(NODE,"^",4) ;position name
 .S ACT=$P(NODE,"^",9) ;active date (fm)
 .I ACT'=""&(ACT'=0) S ACT=$TR($$FMTE^XLFDT(ACT,"5DF")," ","0")
 .S INACT=$P(NODE,"^",10) ;inactive date (fm)
 .I INACT'=""&(INACT'=0) S INACT=$TR($$FMTE^XLFDT(INACT,"5DF")," ","0")
 .S RNAME=$P(NODE,"^",8) ;standard role name
 .S UNAME=$P(NODE,"^",6) ;user class name
 .S PRIEN=+$P(NODE,"^") ;practitioner ien
 .S PRNAME=$P(NODE,"^",2) ;practitioner name
 .;
 .;Get person class information
 .S PCLASS=$$GET^XUA4A72(PRIEN)
 .F SCI=1,2,3 S PCLASS(SCI)=$P(PCLASS,U,(SCI+1))
 .;
 .S TPNODE=$G(^SCTM(404.57,+TPIEN,0))
 .D SETASCL^SCRPRAC2(TPIEN,.PCLIN)
 .S PCLIN=$G(PCLIN(0))
 .;S PCLIN=+$P(TPNODE,"^",9) ;associated clinic ien
 .;S PCLIN=$P($G(^SC(PCLIN,0)),"^") ;associated clinic name
 .;
 .;Get preceptor
 .S PRCP=$P($$OKPREC2^SCMCLK(TPIEN,DT),U,2)
 .;
 .S TNODE=$G(^SCTM(404.51,TIEN,0)) ;team node
 .S TNAME=$P(TNODE,"^") ;team name
 .S TPHONE=$P(TNODE,"^",2) ;team phone
 .S TPC=$S($P(TNODE,"^",5)=1:"YES",1:"NO") ;primary care?
 .S INS=+$P(TNODE,"^",7) ;team division ien
 .S INAME=$P($G(^DIC(4,INS,0)),"^") ;team division name
 .D KTEAM(TNAME,TPHONE,TPC,INAME,TIEN,INS)
 .;
 .S OPH=$P($G(^VA(200,PRIEN,.13)),"^",2) ;office phone
 .S ROOM=$P($G(^VA(200,PRIEN,.14)),"^") ;room
 .S SERV=+$P($G(^VA(200,PRIEN,5)),"^") ;service/section ien
 .S SERV=$P($G(^DIC(49,SERV,0)),"^") ;service/section name
 .;
 .D FORMAT(PNAME,TPIEN,PCLIN,RNAME,UNAME,ACT,INACT,PRIEN,PRNAME,OPH,ROOM,SERV,INS,TIEN,PRCP,.PCLASS)
 .N SCAC
 .S SCAC=0
 .F  S SCAC=$O(PCLIN(SCAC)) Q:SCAC=""  D FORMATAC(INS,TIEN,PRIEN,TPIEN,PCLIN(SCAC))
 Q
 ;
KTEAM(TNAME,TPHONE,TPC,TDIV,TIEN,IEND) ;
 ;store team information
 I TDIV="" S TDIV="[BAD DATA]"
 I TNAME="" S TNAME="[BDA DATA]"
 S @STORE@("I",TDIV,IEND)=""
 S @STORE@("T",IEND,TNAME,TIEN)=""
 S @STORE@(IEND)="Division: "_TDIV
 S @STORE@(IEND,TIEN,"H1")="Team Name: "_TNAME
 S $E(@STORE@(IEND,TIEN,"H1"),40)="Team Phone: "_TPHONE
 S @STORE@(IEND,TIEN,"H2")="Primary Care Team: "_TPC
 S @STORE@(IEND,TIEN,"H3")=""
 S @STORE@(IEND,TIEN,"H4")="Members:"
 Q
 ;
FORMAT(POS,TPIEN,PCLIN,SPOS,UCLASS,BEG,END,PIEN,PRACT,OPH,ROOM,SERV,DIV,TEM,PRCP,PCLASS) ;
 ;POS - position name
 ;TPIEN - position ien
 ;PCLIN - associated clinic
 ;SPOS - standard  position
 ;UCLASS - user class
 ;BEG - begin date
 ;END - end date
 ;PIEN - ien of new person file
 ;PRACT - practitioner name
 ;OPH - office number
 ;ROOM - room
 ;SERV - service
 ;DIV - ien of division
 ;TEM - ien of team
 ;PRCP - preceptor
 ;PCLASS - person class
 ;
 N SCI
 I PRACT="" S PRACT="[BAD DATA]"
 S @STORE@("PN",DIV,TEM,PRACT,PIEN,TPIEN)=""
 S @STORE@(DIV,TEM,PIEN,TPIEN,1)=PRACT
 S $E(@STORE@(DIV,TEM,PIEN,TPIEN,1),35)="Position: "_POS
 S @STORE@(DIV,TEM,PIEN,TPIEN,2)="Standard Role: "_SPOS
 S @STORE@(DIV,TEM,PIEN,TPIEN,3)="User Class: "_UCLASS
 S @STORE@(DIV,TEM,PIEN,TPIEN,4)=SERV
 S $E(@STORE@(DIV,TEM,PIEN,TPIEN,4),35)="Assoc Clinic: "_PCLIN
 S @STORE@(DIV,TEM,PIEN,TPIEN,5)="Office Phone: "_OPH
 S $E(@STORE@(DIV,TEM,PIEN,TPIEN,5),35)="Room: "_ROOM
 S @STORE@(DIV,TEM,PIEN,TPIEN,6)="Begin Date: "_BEG
 S $E(@STORE@(DIV,TEM,PIEN,TPIEN,6),35)="End Date: "_END
 S SCI=7
 I $L(PRCP) S @STORE@(DIV,TEM,PIEN,TPIEN,SCI)="Preceptor: "_PRCP,SCI=8
 I $L(PCLASS(1)) S @STORE@(DIV,TEM,PIEN,TPIEN,SCI)="Person Class: "_PCLASS(1),SCI=SCI+1
 I $L(PCLASS(2)) S @STORE@(DIV,TEM,PIEN,TPIEN,SCI)="                 "_PCLASS(2),SCI=SCI+1
 I $L(PCLASS(3)) S @STORE@(DIV,TEM,PIEN,TPIEN,SCI)="                    "_PCLASS(3)
 Q
 ;
FORMATAC(DIV,TEM,PIEN,TPIEN,PCLIN) ;
 S $E(@STORE@(DIV,TEM,PIEN,TPIEN,4,SCAC),49)=$E(PCLIN,1,30)
 Q
 ;
NEWP(INST,TEM,TITL,PAGE,HEAD) ;
 ;new page
 D NEWP1^SCRPU3(.PAGE,TITL)
 D HEAD1(INST,TEM,.HEAD)
 Q
 ;
HEAD1(INST,TEM,HEAD) ;
 ;write headings
 W !,$G(@STORE@(INST))
 N NXT
 S NXT="H"
 F  S NXT=$O(@STORE@(INST,TEM,NXT)) Q:NXT'?1"H".E  D
 .W !,$G(@STORE@(INST,TEM,NXT))
 W ! ;extra line between MEMBERS and practitioner list
 S HEAD=1
 Q
HOLD1(PAGE,TITL,INST,TEM,HEAD) ;
 ;device is home, reached end of page
 D HOLD^SCRPU3(.PAGE,TITL)
 I STOP Q
 D HEAD1(INST,TEM,.HEAD)
 Q
