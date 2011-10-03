SCRPRAC2 ;ALB/CMM - Practitioner Demographics continued ; 29 Jun 99  04:11PM
 ;;5.3;Scheduling;**41,177,520**;AUG 13, 1993;Build 26
 ;
 ;Practitioner Demographics Report
 ;
GATHER(PARRAY,PRAC) ;
 ;get practitioner data
 N ANODE,TIEN,PNAME,POS,STROL,USCL,TNAME,MAX,PHONE,ASSIGN,ROOM,SERV
 N NODE,PIEN,CNAME,PCLASS,PRCP,PRCPCNT,SCLN,SCI,NXT,PRCPCT,PRCPOS
 N PRCPTE,SCDT,SCRATCH
 S NXT=0
 F  S NXT=$O(@PARRAY@(NXT)) Q:NXT=""!(NXT'?.N)  D
 .S (PNAME,PHONE,SERV,ROOM)=""
 .D PINFO(PRAC,.PNAME,.PHONE,.ROOM,.SERV)
 .;get provider name, office phone, room, service/section, person class
 .;
 .S ANODE=$G(@PARRAY@(NXT))
 .Q:ANODE=""
 .S PIEN=+$P(ANODE,"^") ;position ien
 .;
 .;Get precepted provider information
 .S PRCPCNT=0
 .S SCDT="SCDT",(SCDT("BEGIN"),SCDT("END"))="DT",SCDT("INCL")=0
 .K ^TMP("SCRATCH",$J),^TMP("SCRATCH1",$J) S SCI="^TMP(""SCRATCH1"",$J)"
 .S SCI=$$PRECHIS^SCMCLK(PIEN,.SCDT,SCI),SCI=0
 .F  S SCI=$O(^TMP("SCRATCH1",$J,SCI)) Q:'SCI  D
 ..N SCPRCD,SCTP
 ..S SCPRCD=^TMP("SCRATCH1",$J,SCI),SCTP=$P(SCPRCD,U,3)
 ..S PRCPTE=$P(SCPRCD,U,2) S:'$L(PRCPTE) PRCPTE="[unknown]"
 ..S PRCPOS=$P($G(SCRATCH(1)),U,4)
 ..S PRCPCT=$$PCPOSCNT^SCAPMCU1(SCTP,DT,0)
 ..S PRCPCNT=PRCPCNT+PRCPCT
 ..S ^TMP("SCRATCH",$J,PRCPTE,SCTP)=PRCPOS_U_PRCPCT
 ..Q
 .;
 .S POS=$P(ANODE,"^",2) ;position name
 .S STROL=$P(ANODE,"^",8) ;standard role name
 .S USCL=$P(ANODE,"^",10) ;user class name
 .S NODE=$G(^SCTM(404.57,PIEN,0))
 .S MAX=$P(NODE,"^",8) ;max patient assignments to position
 .S ASSIGN=+$$PCPOSCNT^SCAPMCU1(PIEN,DT,0) ;assigned patients
 .N CNAME,SCCLIEN
 .D SETASCL(PIEN,.CNAME,.SCCLIEN) ;associated clinics
 .;
 .;Get preceptor
 .S PRCP=$P($$OKPREC2^SCMCLK(PIEN,DT),U,2)
 .;
 .S TIEN=+$P(ANODE,"^",3) ;team ien
 .S TNAME=$P($G(^SCTM(404.51,TIEN,0)),"^") ;team name
 .;
 .;Set array for output
 .S SCLN=0
 .D SET1("Name",PNAME),SET2("Serv./Sect.",SERV)
 .D SET1("Team",TNAME),SET2("Position",POS)
 .D SET1("Role",STROL),SET2("User Class",USCL)
 .D SET1("Room",ROOM),SET2("Pts. Allowed",MAX)
 .D SET1("Phone",PHONE),SET2("Pts. Assigned",ASSIGN)
 .I $L($G(PRCP)) D SET3(1,"Preceptor: "_PRCP)
 .D SET3(4,"Assoc. Clinic: ")
 .D SETCNAME(.CNAME)
 .I $L(PCLASS(1)) D
 ..D SET3(4,"Person"),SET3(5,"Class: "_PCLASS(1)) D
 ..I $L(PCLASS(2)) D SET3(15,PCLASS(2)) D
 ...I $L(PCLASS(3)) D SET3(18,PCLASS(3))
 ...Q
 ..Q
 .Q:'$D(^TMP("SCRATCH",$J))
 .D SET3(1,"")
 .D SET4("Precepted Provider","Precepted Position","Pts. Precepted")
 .S SCI="",$P(SCI,"-",31)="" D SET4(SCI,SCI,$E(SCI,1,14))
 .S PRCPTE="" F  S PRCPTE=$O(^TMP("SCRATCH",$J,PRCPTE)) Q:PRCPTE=""  D
 ..S SCTP=0 F  S SCTP=$O(^TMP("SCRATCH",$J,PRCPTE,SCTP)) Q:'SCTP  D
 ...S PRCPOS=^TMP("SCRATCH",$J,PRCPTE,SCTP)
 ...S PRCPCT=+$P(PRCPOS,U,2),PRCPOS=$P(PRCPOS,U)
 ...D SET4(PRCPTE,PRCPOS,PRCPCT_"  ")
 ...Q
 ..Q
 .D SET3(1,"") S SCI="  Total precepted patients: "_PRCPCNT
 .S $E(SCI,37)=$J(("Total assigned/precepted patients: "_(PRCPCNT+ASSIGN)),42)
 .D SET3(1,SCI)
 .K ^TMP("SCRATCH",$J),^TMP("SCRATCH1",$J)
 .Q
 Q
 ;
SETASCL(PIEN,CNAME,SCCLIEN) ;SET ASSOCIATED CLINICS
 N I,CNT1
 S CNT1=0,I=0
 F  S I=$O(^SCTM(404.57,PIEN,5,I)) Q:'I  D
 .S SCCLIEN(CNT1)=I,CNAME(CNT1)=$P($G(^SC(I,0)),U),CNT1=CNT1+1
 Q
SET1(LABEL,VALUE) ;Set output line
 S SCLN=SCLN+1
 S @STORE@(PNAME,PIEN,SCLN)=$J(LABEL,9)_": "_$E(VALUE,1,26)
 Q
 ;
SET2(LABEL,VALUE) ;Set second column of output line
 S $E(@STORE@(PNAME,PIEN,SCLN),40)=$J(LABEL,13)_": "_$E(VALUE,1,26)
 Q
 ;
SET3(COL,VALUE) ;Set output line
 N SCX
 S SCLN=SCLN+1,SCX="",$E(SCX,COL)=$E(VALUE,1,(80-(COL-1)))
 S @STORE@(PNAME,PIEN,SCLN)=SCX
 Q
 ;
SET4(V1,V2,V3) ;Set output line
 S SCLN=SCLN+1,V1="  "_V1,$E(V1,35)=V2,$E(V1,67)=$J(V3,14)
 S @STORE@(PNAME,PIEN,SCLN)=V1
 Q
 ;
SETCNAME(CNAME) ;associated clinics 
 N A
 S A="" F  S A=$O(CNAME(A)) Q:A=""  D SET3(12,CNAME(A))
 Q
 ;
PINFO(VAE,PRACT,OPH,ROOM,SERV) ;
 ;practitioner information from new person file
 S PRACT=$P($G(^VA(200,VAE,0)),"^") ;practitioner name
 S OPH=$P($G(^VA(200,VAE,.13)),"^",2) ;office phone
 S ROOM=$P($G(^VA(200,VAE,.14)),"^") ;room
 S SERV=$P($G(^VA(200,VAE,5)),"^") ;service/section ien
 S SERV=$P($G(^DIC(49,+SERV,0)),"^") ;service/section name
 S PCLASS=$$GET^XUA4A72(VAE) ;Person class
 N SCI F SCI=1,2,3 S PCLASS(SCI)=$P(PCLASS,U,(SCI+1))
 Q
