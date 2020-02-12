SDECCON ;SPFO/DMR SCHEDULING ENHANCEMENTS VSE CONTACT API
 ;;5.3;Scheduling;**669,686**;Aug 13 1993;Build 53
 ;
 ;This API provides SDEC CONTACT(#409.86)file information to the VSE VS GUI.
 ; 3/6/18 - wtc/zeb Added new cross-reference for audit statistics compiler.  Patch 686
 ;
 Q
DISPLAY(RTU,DFN,CLN,PDT,REQT,SER) ;
 Q:'$G(DFN)
 Q:'$G(PDT)
 Q:'$D(REQT)
 S (CC,CC1,CC2,REC)=""
 ;
 S CC="" F  S CC=$O(^SDEC(409.86,"B",DFN,CC)) Q:CC=""  D
 .S REC="" S REC=^SDEC(409.86,CC,0)
 .Q:PDT'=$P($G(REC),"^",3)
 .I $G(CLN)'="" Q:$G(CLN)'=$P($G(REC),"^",2)
 .I $G(SER)'="" Q:$G(SER)'=$P($G(REC),"^",6)
 .Q:REQT'=$P($G(REC),"^",4)
 .S RTU=CC_"^"_REC
 .Q
 D EXIT
 Q
DISMULT(RTT,CIEN) ;
 Q:'$G(CIEN)
 ;
 S (CC1,CC2,REC1,REC2,RTT,ENDT)=""
 ;
 S CC2="" F  S CC2=$O(^SDEC(409.86,CIEN,1,CC2)) Q:CC2=""  D
 .S REC2="" S REC2=$G(^SDEC(409.86,CIEN,1,CC2,1)) Q:REC2=""  D
 ..S ENDT="" S ENDT=$P($G(^SDEC(409.86,CIEN,1,CC2,0)),"^",1)
 ..S (ENTU,ENTUN)="" S ENTUN=$P(REC2,"^",5) I ENTUN>0 D
 ...S ENTU=$$GET1^DIQ(200,ENTUN,.01,"E")
 ..S RTT=RTT_CC1_"^"_REC2_"^"_ENTU_"^"_ENDT_";"
 ..Q
 D EXIT
 Q
 ;
NEW(RET,DFN,CLI,DTP,REQT,SRV,DTCON,CONT,COM,DTENT) ;
 Q:'$G(DFN)
 Q:'$G(DTP)
 Q:'$D(REQT)
 Q:'$G(DTCON)
 Q:'$D(CONT)
 Q:'$G(DTENT)
 I '$D(COM) S COM=""
 I '$G(CLI) S CLI=""
 I '$G(SRV) S SRV=""
 ;
 S (DFN2,CC1,CC2)=""
 ;
 S DFN2="" F  S DFN2=$O(^SDEC(409.86,"B",DFN2)) Q:DFN2=""  D
 .S CC1="" F  S CC1=$O(^SDEC(409.86,"B",DFN2,CC1)) Q:CC1=""  D
 ..S CC2=CC2+1
 ..Q
 S CC2=CC2+1 D
 .S ^SDEC(409.86,0)="SDEC CONTACT^409.86P^"_CC2_"^"_CC2
 .S ^SDEC(409.86,CC2,0)=DFN_"^"_CLI_"^"_DTP_"^"_REQT_"^"_1_SRV
 .S ^SDEC(409.86,CC2,1,0)="^409.863D^1^1"
 .S ^SDEC(409.86,CC2,1,1,0)=DTCON
 .S ^SDEC(409.86,CC2,1,1,1)=CONT_"^"_COM_"^"_0_"^"_1_"^"_DUZ_"^"_DTENT
 .S ^SDEC(409.86,"B",DFN,CC2)=""
 .S ^SDEC(409.86,CC2,1,"B",DTCON,1)=""
 .S ^SDEC(409.86,"AD",DTENT,DUZ,CC2,1)="" ;  3/6/18 WTC/ZEB create date/user cross-reference.
 .Q
 D EXIT
 Q
SEQ(RE1,DF1,CL1,PDATE,RTYPE,SRR) ;
 Q:'$G(DF1)
 Q:'$G(PDATE)
 I '$G(CL1) S CL1=""
 I '$G(SRR) S SRR=""
 ;
 S (JJ,JJ1,RCD,SQU,DF2)=""
 ;
 S JJ="" F  S JJ=$O(^SDEC(409.86,"B",DF1,JJ)) Q:JJ=""  D
 .S RCD="" S RCD=$G(^SDEC(409.86,JJ,0)) Q:RCD=""  D
 ..S SQU="" S SQU=$P($G(^SDEC(409.86,JJ,1,0)),"^",3) D
 ...Q:$G(SQU)=""
 ...Q:PDATE'=$P($G(RCD),"^",3)
 ...Q:RTYPE'=$P($G(RCD),"^",4)
 ...I $P($G(RCD),"^",2)=CL1 D
 ....S $P(^SDEC(409.86,JJ,0),"^",5)=SQU+1
 ....S RE1=SQU+1
 ....Q
 ...I $P($G(RCD),"^",6)=SRR D
 ....S $P(^SDEC(409.86,JJ,0),"^",5)=SQU+1
 ....S RE1=SQU+1
 ....Q
 D EXIT
 Q
UPDATE(RTT,IEN,CONDT,CTYPE,COMM,DTEN) ;
 Q:'$G(IEN)
 Q:'$G(CONDT)
 Q:'$D(CTYPE) 
 I '$D(COMM) S COMM=""
 I '$G(DTEN) S DTEN=""
 ;
 S (MULT,RTT,CC,CCC,COUNT,MULTN)=""
 ;
 S MULT="" S MULT=$G(^SDEC(409.86,IEN,1,0)) I MULT'="" D
 .S MULTN=$P(MULT,"^",4) I MULTN'="" D
 ..S COUNT=MULTN
 .Q
 I COUNT'="" S COUNT=COUNT+1 D
 .S ^SDEC(409.86,IEN,1,0)="^409.863D^"_COUNT_"^"_COUNT
 .S ^SDEC(409.86,IEN,1,COUNT,0)=CONDT
 .S ^SDEC(409.86,IEN,1,COUNT,1)=CTYPE_"^"_COMM_"^"_0_"^"_COUNT_"^"_DUZ_"^"_DTEN
 .S ^SDEC(409.86,IEN,1,"B",CONDT,COUNT)=""
 .S ^SDEC(409.86,"AD",DTEN,DUZ,IEN,COUNT)="" ;  3/6/18 WTC/ZEB create date/user cross-reference.
 .Q
 D EXIT
 Q 
GETSTC(RET,CLIEN) ;
 Q:CLIEN=""
 ;
 ;CLIEN=Clinic IEN
 ;HLF0=Hospital Location File 0 node
 ;SNUM=Stopc Code IEN [0,7]
 ;STPC=Stop Code 40.7
 ;CSNUM=Credit Stop IEN [0,18]
 ;CSTPC=Credit Stop Code 40.7
 ;
 S (HLF0,SNUM,STPC,CSNUM,CSTPC)=""
 ;
 S HLF0=$G(^SC(CLIEN,0)) I HLF0'="" D
 .S SNUM=$P($G(HLF0),"^",7) I SNUM'="" D
 ..S STPC=$$GET1^DIQ(40.7,SNUM,1)
 .S CNUM=$P($G(HLF0),"^",18) I CNUM'="" D
 ..S CSTPC=$$GET1^DIQ(40.7,CNUM,1)
 S RET=STPC_"^"_CSTPC
 K HLF0,SNUM,STPC,CSNUM,CSTPC
 Q
EXIT ;
 K MULT,CC,CCC,COUNT,COMM,DTEN,ENDT
 K JJ,JJ1,RCD,SQU,DF2,DFN2,CC1,CC2,RCD,SQU
 K REC1,REC2,ENDT,MULTN,CLN,PDT,REQT,SER
 Q
