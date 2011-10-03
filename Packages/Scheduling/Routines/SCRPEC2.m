SCRPEC2 ;ALB/CMM - Detail List of Pts & Enroll Clinics Continued ; 29 Jun 99  04:11PM
 ;;5.3;Scheduling;**41,140,174,177,526**;AUG 13, 1993;Build 8
 ;
 ;Detailed Listing of Patients and Their Enrolled Clinics Report
 ;
PAT(TIEN,PTLIST) ;
 ;TIEN - team ien
 ;PTLIST - array holding patients assigned to team TIEN
 ;
 N PTIEN,ENT,NODE,OKAY,CLLIST,ERR,PC
 S ENT=0,CLLIST="LIST2",ERR="ERROR2"
 K @CLLIST
 F  S ENT=$O(@PTLIST@(ENT)) Q:ENT=""!(ENT'?.N)  D
 .S NODE=$G(@PTLIST@(ENT))
 .Q:NODE=""
 .S PTIEN=+$P(NODE,"^") ;patient ien
 .S PC=$$PCASSIGN(PTIEN,TIEN)
 .Q:PC'=ASSUN  ;not selected assigned/unassigned primary care
 .K @CLLIST
 .S OKAY=$$CLPT^SCAPMC29(PTIEN,"","",.CLLIST,.ERR)
 .;all clinics for patient PTIEN
 .Q:'OKAY
 .D KEEP(TIEN,PTIEN,.CLLIST)
 K @CLLIST
 Q
 ;
KEEP(TIEN,PTIEN,CLLIST) ;keep data for report
 ;TIEN - team ien
 ;PTIEN - patient ien
 ;CLLIST - array holding clinics for patient PTIEN
 ;
 N ENT,TNAME,INS,NODE,INAME,PDATA,NODE,CIEN,CNAME,PNAME
 N SCPCPR,SCPCAP,SCI,PCLIST
 S TNAME=$P($G(^SCTM(404.51,TIEN,0)),"^") ;team name
 S INS=+$P($G(^SCTM(404.51,TIEN,0)),"^",7) ;institution ien
 S INAME=$P($G(^DIC(4,INS,0)),"^") ;institution name
 S PNAME=$P($G(^DPT(PTIEN,0)),"^") ;patient name
 K ^TMP("SC",$J,PTIEN)
 S SCI=$$GETALL^SCAPMCA(PTIEN) D
 .;Name of PC Provider
 .S SCPCPR=$P($G(^TMP("SC",$J,PTIEN,"PCPR",1)),U,2)
 .;Name of Associate Provider
 .S SCPCAP=$P($G(^TMP("SC",$J,PTIEN,"PCAP",1)),U,2)
 .Q
 ;
 S ENT=0
 F  S ENT=$O(@CLLIST@(ENT)) Q:ENT=""!(ENT'?.N)  D
 .S NODE=$G(@CLLIST@(ENT))
 .S CIEN=+$P(NODE,"^") ;clinic ien
 .I CLINIC'=1,'$D(CLINIC(CIEN)) Q
 .S CNAME=$P(NODE,"^",2) ;clinic name
 .D SETUP(INS,INAME,TIEN,TNAME,PTIEN,PNAME,CIEN,CNAME)
 .S PDATA=$$PDATA^SCRPEC(PTIEN,CIEN,1)
 .S $P(PDATA,U,9)=SCPCPR,$P(PDATA,U,10)=SCPCAP
 .;name^pid^mt^pelig^pstat^statd^last^next^pc prov.^assoc. prov.
 .D FORMAT(PTIEN,INS,TIEN,PDATA,CNAME,CIEN)
 Q
 ;
SETUP(INS,INAME,TIEN,TNAME,PTIEN,PNAME,CIEN,CNAME) ;
 ;INS - institution ien
 ;INAME - institution name
 ;TIEN - team ien
 ;TNAME - team name
 ;PTIEN - patient ien
 ;PNAME - patient name
 ;CIEN - clinic ien
 ;CNAME - clinic name
 ;
 I INAME="" S INAME="[BAD DATA]"
 I TNAME="" S TNAME="[BAD DATA]"
 I CNAME="" S CNAME="[BAD DATA]"
 I PNAME="" S PNAME="[BAD DATA]"
 I '$D(@STORE@("I",INAME,INS)) S @STORE@("I",INAME,INS)="",@STORE@(INS)="Division: "_INAME
 I '$D(@STORE@("T",INS,TNAME,TIEN)) S @STORE@("T",INS,TNAME,TIEN)="",@STORE@(INS,TIEN)="Team: "_TNAME
 I '$D(@STORE@("C",INS,TIEN,CNAME,CIEN)) S @STORE@("C",INS,TIEN,CNAME,CIEN)="" ;D HEADER(INS,TIEN,CIEN)
 I '$D(@STORE@("PT",INS,TIEN,CIEN,PNAME,PTIEN)) S @STORE@("PT",INS,TIEN,CIEN,PNAME,PTIEN)=""
 Q
 ;
PCASSIGN(DFN,TIEN) ;patient assigned to team as primary care
 ;DFN - patient ien
 ;TIEN - team ien
 ;1 - yes
 ;0 - no
 ;
 N ADATE,ENTRY,PC
 S PC=0
 I '$D(^SCPT(404.42,"AIDT",DFN,TIEN)) Q PC
 S ADATE=$O(^SCPT(404.42,"AIDT",DFN,TIEN,"")) ; -team assignemtn date
 S ENTRY=$O(^SCPT(404.42,"AIDT",DFN,TIEN,ADATE,"")) ;patient team assignemtn ien
 I $P($G(^SCPT(404.42,+ENTRY,0)),"^",8)=1 S PC=1
 Q PC
 ;
HEADER ;report column titles
 N HLD
 S HLD="H0"
 S $E(@STORE@("SUBHEADER",HLD),25)="M.T."
 S $E(@STORE@("SUBHEADER",HLD),31)="Prim"
 ;Removed by patch 174
 ;S $E(@STORE@("SUBHEADER",HLD),31)="Pat"
 ;S $E(@STORE@("SUBHEADER",HLD),36)="Status"
 S $E(@STORE@("SUBHEADER",HLD),42)="Last"
 S $E(@STORE@("SUBHEADER",HLD),54)="Next"
 S $E(@STORE@("SUBHEADER",HLD),66)="Enrolled"
 S $E(@STORE@("SUBHEADER",HLD),95)="Primary Care"
 S $E(@STORE@("SUBHEADER",HLD),115)="Associate"
 S HLD="H1"
 S @STORE@("SUBHEADER",HLD)="Patient Name"
 S $E(@STORE@("SUBHEADER",HLD),16)="Pt ID"
 S $E(@STORE@("SUBHEADER",HLD),25)="Stat"
 S $E(@STORE@("SUBHEADER",HLD),31)="Elig"
 ;Removed by patch 174
 ;S $E(@STORE@("SUBHEADER",HLD),31)="Stat"
 ;S $E(@STORE@("SUBHEADER",HLD),36)="Date"
 S $E(@STORE@("SUBHEADER",HLD),42)="Appt"
 S $E(@STORE@("SUBHEADER",HLD),54)="Appt"
 S $E(@STORE@("SUBHEADER",HLD),66)="Clinic"
 S $E(@STORE@("SUBHEADER",HLD),95)="Provider"
 S $E(@STORE@("SUBHEADER",HLD),115)="Provider"
 S HLD="H2"
 S $P(@STORE@("SUBHEADER",HLD),"=",133)=""
 Q
 ;
FORMAT(PTIEN,INS,TIEN,PDATA,CNAME,CIEN) ;format data for report
 ;PTIEN - patient ien
 ;INS - institution ien
 ;TIEN - team ien
 ;PDATA - pt name^pid^mt^pelig^pstat^statd^last^next^pc prov.^assoc. prov.
 ;CNAME - clinic name
 ;CIEN - clinic ien
 ;
 S @STORE@(INS,TIEN,CIEN,PTIEN)=$E($P(PDATA,"^"),1,12) ;patient name
 S $E(@STORE@(INS,TIEN,CIEN,PTIEN),14)=$P(PDATA,"^",2) ;primary long id 9 digit
 S $E(@STORE@(INS,TIEN,CIEN,PTIEN),26)=$P(PDATA,"^",3) ;means test category
 S $E(@STORE@(INS,TIEN,CIEN,PTIEN),31)=$P(PDATA,"^",4) ;primary eligibility
 ;Removed by patch 174
 ;S $E(@STORE@(INS,TIEN,CIEN,PTIEN),31)=$P(PDATA,"^",5) ;patient status
 ;S $E(@STORE@(INS,TIEN,CIEN,PTIEN),35)=$P(PDATA,"^",6) ;status date
 S $E(@STORE@(INS,TIEN,CIEN,PTIEN),42)=$P(PDATA,"^",7) ;last appointment
 S $E(@STORE@(INS,TIEN,CIEN,PTIEN),54)=$P(PDATA,"^",8) ;next appointment
 S $E(@STORE@(INS,TIEN,CIEN,PTIEN),66)=$E(CNAME,1,27) ;clinic name
 S $E(@STORE@(INS,TIEN,CIEN,PTIEN),95)=$E($P(PDATA,U,9),1,18) ;PC prov.
 S $E(@STORE@(INS,TIEN,CIEN,PTIEN),115)=$E($P(PDATA,U,10),1,18) ;Assoc. Prov.
 Q
 ;
CHEAD(INS,TEAM,CLINIC) ;
 ;column headings
 ;
 N EN,NEWP
 W !
 S NEWP=0
 I IOST'?1"C-".E,$Y+5>(IOSL-6) D NEWP1^SCRPU3(.PAGE,TITL) S NEWP=1
 I IOST?1"C-".E,$Y+5>(IOSL-6) D HOLD^SCRPU3(.PAGE,TITL) S NEWP=1
 I STOP Q
 I NEWP W !,$G(@STORE@(INS)),!!,$G(@STORE@(INS,TEAM)),!
CH2 F EN="H0","H1","H2" W !,$G(@STORE@("SUBHEADER",EN))
 Q
 ;
