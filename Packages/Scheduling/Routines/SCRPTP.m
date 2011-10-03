SCRPTP ;ALB/CMM - List of Team's Patients ; 29 Jun 99  04:11PM
 ;;5.3;Scheduling;**41,48,174,177,526,520**;AUG 13, 1993;Build 26
 ;
PROMPTS ;Prompt for Institution, Team, Role, Patient Status and Print device
 N QTIME,PRNT,VAUTD,VAUTT,VAUTR,VAUTPS,NUMBER
 K SCUP
 S QTIME=""
 W ! D INST^SCRPU1 I Y=-1 G ERR
 W ! K Y D PRMTT^SCRPU1 I '$D(VAUTT) G ERR
 W ! K Y D ROLE^SCRPU1 I '$D(VAUTR) G ERR
 W ! K Y D PTSTAT^SCRPU2 I '$D(VAUTPS) G ERR
 W ! K Y S SORT=$$SORT2^SCRPU2()
 I SORT<1 G ERR
 W !!,"This report requires 132 column output!"
 D QUE(.VAUTD,.VAUTT,.VAUTR,VAUTPS,SORT) Q
 ;
QUE(INST,TEAM,ROLE,PSTAT,SORT,IOP,ZTDTH) ;queue report
 ;INST - institutions selected (variable and array) 
 ;TEAM - teams selected (variable and array) 
 ;ROLE - roles selected (variable and array) 
 ;PSTAT - patient status - 1=all or OPT or AC 
 ;SORT - 1=d,t,ptname 2=d,t,Pt ID 3=d,t,pract,pt name 4=d,t,pract,Pt ID
 N ZTSAVE,II
 F II="INST","TEAM","ROLE","ROLE(","SORT","PSTAT","INST(","TEAM(" S ZTSAVE(II)=""
 W ! D EN^XUTMDEVQ("QENTRY^SCRPTP","Team Patient Listing",.ZTSAVE)
 Q
 ;
ENTRY2(INST,TEAM,ROLE,PSTAT,SORT,IOP,ZTDTH) ;Second entry point for GUI to use
 ;INST - institutions selected (variable and array)
 ;TEAM - teams selected (variable and array)
 ;ROLE - roles selected (variable and array)
 ;PSTAT - patient status - 1=all or OPT or AC
 ;SORT - 1=d,t,ptname 2=d,t,Pt ID 3=d,t,pract,pt name 4=d,t,pract,Pt ID
 ;IOP - print device
 ;ZTDTH - queue time (optional)
 ;
 ;validate parameters
 I '$D(INST)!'$D(TEAM)!'$D(ROLE)!'$D(PSTAT)!'$D(SORT)!'$D(IOP)!(IOP="") Q
 N NUMBER
 S IOST=$P(IOP,"^",2),IOP=$P(IOP,"^")
 I IOP?1"Q;".E S IOP=$P(IOP,"Q;",2)
 I IOST?1"C-".E D QENTRY G RET
 I ZTDTH="" S ZTDTH=$H
 S ZTRTN="QENTRY^SCRPTP"
 S ZTDESC="List of Team's Patients",ZTIO=IOP
 N II
 F II="INST","TEAM","ROLE","ROLE(","SORT","PSTAT","INST(","TEAM(","IOP" S ZTSAVE(II)=""
 D ^%ZTLOAD
RET S NUMBER=0
 I $D(ZTSK) S NUMBER=ZTSK
 D EXIT1
 Q NUMBER
 ;
QENTRY ;driver entry point
 S TITL="Team Patient Listing",STORE="^TMP("_$J_",""SCRPTP"")"
 K @STORE
 S @STORE=0
 D FIND
 I $O(@STORE@(0))="" S NODATA=$$NODATA^SCRPU3(TITL)
 I '$D(NODATA) D PRINTIT^SCRPTP2(STORE,TITL)
 D EXIT2
 Q
ERR ;
EXIT1 ;
 K ZTDTH,ZTRTN,ZTDESC,ZTSK,ZTIO,ZTSAVE,SCUP
 Q
EXIT2 ;
 K @STORE
 K STOP,STORE,TITL,IOP,TEAM,INST,ROLE,PSTAT,SORT,NODATA
 Q
FIND ;
 N TIEN,ERR,LIST,OKAY
 I TEAM=1 D TALL^SCRPPAT3 ;gets all teams for all divisions selected
 S TIEN="",LIST="^TMP("_$J_",""SCRPTP ARRAY"")",ERR="ERROR"
 K @LIST,@ERR
 F  S TIEN=$O(TEAM(TIEN)) Q:TIEN=""  D
 .;TIEN - team ien
 .S OKAY=$$PTTM^SCAPMC2(TIEN,"",LIST,ERR)
 .; gets all patients for given team
 .D HITS^SCRPTP3(LIST,TIEN)
 .K @LIST,@ERR
 K @LIST,@ERR
 Q
TINF(TIEN) ;team information
 ;TIEN - team ien
 ;returns: institution ien ^ team name ^ primary care ^ team phone
 N PC,PHONE,TNODE,TNAME
 S TNODE=$G(^SCTM(404.51,TIEN,0))
 S TNAME=$P(TNODE,"^") ;team name
 S PC=$S($P(TNODE,"^",5)=1:"YES",1:"NO") ;primary care team
 S PHONE=$P(TNODE,"^",2) ;team phone
 S INS=+$P(TNODE,"^",7) ;institution ien
 D TDESC^SCRPITP2(TIEN,INS) ;gets team description
 Q INS_"^"_TNAME_"^"_PC_"^"_PHONE
 ;
PST(PTIEN,CLIEN) ;
 ;PTIEN - patient ien
 ;CLIEN - associated clinic ien
 ;returns 1=selected patient status, 0=not selected patient status
 ;
 N EN,NXT,FOUND,ENODE
 S EN="",(FOUND,NXT)=0
 Q:'$D(^DPT(PTIEN,"DE","B",CLIEN)) FOUND
 S EN=$O(^DPT(PTIEN,"DE","B",CLIEN,""))
 I EN=""&(PSTAT=1) S FOUND=1 Q FOUND
 Q:EN=""!'$D(^DPT(PTIEN,"DE",EN,1)) FOUND
 F  S NXT=$O(^DPT(PTIEN,"DE",EN,1,NXT)) Q:(FOUND)!(NXT="")!(NXT'?.N)  D
 .;check if active enrollment
 .S ENODE=$G(^DPT(PTIEN,"DE",EN,1,NXT,0))
 .I $P(ENODE,"^",3)'="",$P(ENODE,"^",3)<DT+1!$P(ENODE,"^")>DT Q  ;not active enrollment
 .;                      ^ discharge date     ^ enrollment date
 .Q:$P(ENODE,"^",2)'=$E(PSTAT,1)&(PSTAT'=1)  ;not selected patient status
 .S FOUND=1
 Q FOUND
 ;
FORMAT(INS,TIEN,PTIEN,PTNAME,PID,PIEN,PNAME,CNAME,PINF,ROLN,PCAP) ;Format column information
 ;INS - Institution ien
 ;TIEN - team ien
 ;PTIEN - patient ien
 ;PTNAME - patient name
 ;PID - SSN
 ;PIEN - practitioner ien
 ;PNAME - practitioner name
 ;CNAME - clinic name
 ;LAST - last appointment
 ;NEXT - next appointment
 ;ROLN - role name
 ;PCAP - PC?
 ;
 N SEC,TRD
 I PNAME="" S PNAME="[BAD DATA]"
 I PTNAME="" S PTNAME="[BAD DATA]"
 I PID="" S PID="*********"
 S @STORE@("P",INS,TIEN,PNAME,PIEN)="" ;practitioner
 S @STORE@("PT",INS,TIEN,PTNAME,PTIEN)="" ;patient
 S @STORE@("PID",INS,TIEN,PID,PTIEN)=""
 I (SORT=1)!(SORT=2) S SEC=PTIEN,TRD=PIEN ;sort doesn't include practitioner
 I (SORT=3)!(SORT=4) S SEC=PIEN,TRD=PTIEN ;sort includes practitioner
 S @STORE@(INS,TIEN,SEC,TRD)=$E(PTNAME,1,15) ;patient name
 S $E(@STORE@(INS,TIEN,SEC,TRD),18)=PID ;9 digit pid
 S $E(@STORE@(INS,TIEN,SEC,TRD),32)=$E(PNAME,1,22) ;practitioner name
 S $E(@STORE@(INS,TIEN,SEC,TRD),56)=$E($G(ROLN),1,22) ;role name
 S $E(@STORE@(INS,TIEN,SEC,TRD),80)=$G(PCAP) ;PC?
 S $E(@STORE@(INS,TIEN,SEC,TRD),85)=$P(PINF,"^",8) ;last appointment
 S $E(@STORE@(INS,TIEN,SEC,TRD),97)=$P(PINF,"^",9) ;next appointment
 S $E(@STORE@(INS,TIEN,SEC,TRD),109)=$E(CNAME,1,24) ;clinic name
 Q
FORMATAC(SCCNT,CNAME,PINF,INS,TIEN,PTIEN,PTNAME,PID,PIEN,PNAME,ROLN,PCAP) ;Format MULTIPLES
 ;INS - Institution ien
 ;TIEN - team ien
 ;PTIEN - patient ien
 ;PTNAME - patient name
 ;PID - last 4 PID - includes pseudo notation as 5th
 ;PIEN - practitioner ien
 ;PNAME - practitioner name
 ;CNAME - clinic name
 ;LAST - last appointment
 ;NEXT - next appointment
 ;ROLN - role name
 ;PCAP - PC?
 ;
 N SEC,TRD
 I PNAME="" S PNAME="[BAD DATA]"
 I PTNAME="" S PTNAME="[BAD DATA]"
 I PID="" S PID="****"
 S @STORE@("P",INS,TIEN,PNAME,PIEN)="" ;practitioner
 S @STORE@("PT",INS,TIEN,PTNAME,PTIEN)="" ;patient
 S @STORE@("PID",INS,TIEN,PID,PTIEN)="" ;last 4 pid
 N TRD
 I (SORT=1)!(SORT=2) S SEC=PTIEN,TRD=PIEN ;sort doesn't include practitioner
 I (SORT=3)!(SORT=4) S SEC=PIEN,TRD=PTIEN ;sort includes practitioner
 I '$D(@STORE@(INS,TIEN,SEC,TRD,SCCNT))  D
 .S $E(@STORE@(INS,TIEN,SEC,TRD,SCCNT),85)=$P(PINF,"^",8) ;last appointment
 .S $E(@STORE@(INS,TIEN,SEC,TRD,SCCNT),97)=$P(PINF,"^",9) ;next appointment
 .S $E(@STORE@(INS,TIEN,SEC,TRD,SCCNT),109)=$E(CNAME,1,24) ;clinic name
 .Q
 Q
