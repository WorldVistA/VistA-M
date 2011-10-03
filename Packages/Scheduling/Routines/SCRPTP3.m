SCRPTP3 ;ALB/CMM - List of Team's Patients ; 29 Jun 99  04:11PM
 ;;5.3;Scheduling;**41,48,98,177,231,433,526,520**;AUG 13, 1993;Build 26
 ;;DMR BP-OIFO Patch SD*5.3*526
 ;
 ;List of Team's Patients Report
 ;
HITS(ARRY,TIEN) ;
 ;ARRY - list of patients for a given team
 ;TIEN - team ien
 ;
 N PTIEN,PIEN,PTNAME,PNAME,PTAI,NXT,NODE,CIEN,CNAME,INAME,INST,LAST,NEXT
 N PAIEN,PC,PHONE,PNODE,PTPA,PTPAN,ROL,PID,TINFO,TNAME,TPIEN,TPNODE
 N CNT,TPA,FLAG,DFN,VA,VAERR,PCAP,ROLN
 S INACTIVE=0
 S NXT=0
 F  S NXT=$O(@ARRY@(NXT)) Q:NXT=""!(NXT'?.N)  D
 .S NODE=$G(@ARRY@(NXT))
 .Q:NODE=""
 .S PTIEN=+$P(NODE,"^") ;patient ien
 .S PTNAME=$P(NODE,"^",2) ;patient name
 .S PTAI=+$P(NODE,"^",3) ;patient team assignment ien (#404.42)
 .;
 .S PNODE=$G(^DPT(PTIEN,0))
 .Q:PNODE=""
 .S DFN=PTIEN
 .D PID^VADPT6
 .;S PID=VA("BID")
 .S PID=$E(VA("PID"),1,3)_$E(VA("PID"),5,6)_$E(VA("PID"),8,12)
 .;
 .N CNAME,PINF,CLIEN
 .S CNT=""
 .F  S CNT=$O(^SCPT(404.43,"B",PTAI,CNT)) Q:CNT=""!(CNT'?.N)  D
 ..D TPAR(PTAI,CNT,.PINF,.CNAME,.CLIEN,.PNAME,.ROLN,.PCAP)
 Q
 ;
TPAR(PTAI,START,PINF,CNAME,CLIEN,PNAME,ROLN,PCAP) ;
 N PTPA,TPIEN,TPNODE,ROL,CIEN,ENROLL,OKAY,NEXT,LAST,PAIEN
 I '$D(^SCPT(404.43,"B",PTAI)) Q "0^[Not Assigned]"
 ; ^ no patient team position assignment
 IF START="" D
 .S PTPA=$O(^SCPT(404.43,"B",PTAI,START))
 ELSE  D
 .S PTPA=START
 I PTPA="" Q "0^[Not Assigned]"
 S PTPAN=$G(^SCPT(404.43,PTPA,0))  ;patient team assignment
 I PTPAN=""!(PTPAN=0) Q "0^[Not Assigned]"
 I $P(PTPAN,"^",4)'="",$P(PTPAN,"^",4)<DT Q -1
 S TPIEN=+$P(PTPAN,"^",2) ;team position ien (#404.57)
 I '$D(^SCTM(404.57,TPIEN,0)) Q "0^[Not Assigned]"
 S TPNODE=$G(^SCTM(404.57,TPIEN,0))
 I TPNODE="" Q "0^[Not Assigned]"
 S ROL=+$P(TPNODE,"^",3) ;role for position (ien)
 Q:'$D(ROLE(ROL))&(ROLE'=1) -1
 ; ^ not a selected role
 S ROLN=$P($G(^SD(403.46,ROL,0)),U) ;role name
 ;
 S PCAP=$S($P(PTPAN,U,5)<1:"NPC",+$$OKPREC3^SCMCLK(TPIEN,DT)>0:" AP",1:"PCP") ;PC?
 ;
 D SETASCL^SCRPRAC2(TPIEN,.CNAME,.CLIEN)
 ;next two lines commented off - SD*5.3*433
 ;S ENROLL=$$ENRL(PTIEN,CIEN) ;enrolled in associated clinic
 ;I 'ENROLL S CNAME="",CIEN=0
 ;
 S PAIEN=$$CHK(TPIEN)
 I +PAIEN'=0 S PIEN=+PAIEN,PNAME=$P(PAIEN,"^",2) ; practitioner's name
 ;SD*5.3*231
 I +PAIEN=0 S PIEN=0,PNAME="[Inactive Position]"
 ;
 D GETPINF^SCRPPAT2(PTIEN,.CLIEN,.PINF)  ;get patient info
 S CNAME=$G(CNAME(0))
 S PINF=$G(PINF(0))
 I PINF="" D
 .S PINF=PIEN_"^"_$$PDATA^SCRPEC(PIEN,CNAME,CNAME,1)
 I INACTIVE S @STORE@(INS,TIEN,"INACT")=""
 S FLAG="Y"
 S TINFO=$$TINF^SCRPTP(TIEN) ;team information
 S INST=+$P(TINFO,"^") ;institution ien
 S INAME=$P($G(^DIC(4,INST,0)),"^") ;institution name
 S PHONE=$P(TINFO,"^",4) ;team phone
 S PC=$P(TINFO,"^",3) ;primary care?
 S TNAME=$P(TINFO,"^",2) ;team name
 D TFORMAT^SCRPTP2(INST,INAME,TIEN,TNAME,PHONE,PC)
 D FORMAT^SCRPTP(INS,TIEN,PTIEN,PTNAME,PID,PIEN,PNAME,CNAME,PINF,ROLN,PCAP)
 N SCCNT
 S SCCNT=0 F  S SCCNT=$O(CNAME(SCCNT)) Q:SCCNT=""  D FORMATAC^SCRPTP(SCCNT,CNAME(SCCNT),PINF(SCCNT),INS,TIEN,PTIEN,PTNAME,PID,PIEN,PNAME,ROLN,PCAP)
 Q
 ;
ENRL(PTIEN,CLIEN) ;FUNCTIONALITY DISABLED
 ;
 ;N FOUND,ENODE,EN,NXT
 ;S FOUND=0
 ;Q:'$D(^DPT(PTIEN,"DE","B",CLIEN)) FOUND
 ;S EN=$O(^DPT(PTIEN,"DE","B",CLIEN,""))
 ;Q:EN=""!'$D(^DPT(PTIEN,"DE",EN,1)) FOUND
 ;S NXT=""
 ;F  S NXT=$O(^DPT(PTIEN,"DE",EN,1,NXT)) Q:(FOUND)!(NXT="")!(NXT'?.N)  D
 ;check if active enrollment
 ;S ENODE=$G(^DPT(PTIEN,"DE",EN,1,NXT,0))
 ;I $P(ENODE,"^",3)'="",$P(ENODE,"^",3)<DT+1!$P(ENODE,"^")>DT Q  ;not active enrollment
 ;;                      ^ discharge date     ^ enrollment date
 S FOUND=0
 Q FOUND
 ;
CHK(TPIEN) ;assigned to a position
 ;TPIEN - ien of 404.57 Team Position file
 ;returns:  ien of 200 New Person file
 N EN,PLIST,PERR,ERR,NAME
 S PLIST="PLST",PERR="PRR"
 K @PLIST,@PERR
 S ERR=$$PRTP^SCAPMC8(TPIEN,,.PLIST,.PERR)
 I '$D(@PERR) D
 .S EN=$P($G(@PLIST@(1)),"^") ;ien of new person file
 .S NAME=$P($G(@PLIST@(1)),"^",2) ; new person name
 K @PLIST,@PERR
 Q EN_"^"_NAME
 ;
