SDTMPHLB ;MS/PB - TMP HL7 Routine;MAY 29, 2018
 ;;5.3;Scheduling;**704,733,714**;May 29, 2018;Build 80
 Q
EN(CLINID) ; Entry to the routine to build an HL7 message
 ;notification to TMP about a new appointment in a TeleHealth Clinic
 ;put in check for this to be a telehealth clinic. if not a telehealth clinic quit
 ;Call API to create MSH segment
 ;
 ;need to parse data from the file based on clinic, need to get VISN, overbooks and clinic status and privileged users
 ;default provider and default provider email.
 N STOP,SSTOP,PSTOP,MSG,RTN,UPDTTM
 S PSTOP=$P(^SC(CLINID,0),"^",7),SSTOP=$P(^SC(CLINID,0),"^",18)
 I ($G(PSTOP)=""&($G(SSTOP)="")) Q 0 ;if both PSTOP and SSTOP are null, the clinic is not a tele health clinic so quit
 S:$G(PSTOP)'="" STOP=$$CHKCLIN^SDTMPHLA($G(PSTOP)) ;if STOP=0, primary stop code is not a tele health stop code so check secondary stop code to see if it is a tele health clinic
 ;I $G(STOP)=0,($$CHKCLIN^SDTMPHLA($G(SSTOP))'="") Q  ;if primary stop code is not tele health check secondary stop code if secondary not tele health stop
 I $G(STOP)=0 Q:$G(SSTOP)'>0  S STOP=$$CHKCLIN^SDTMPHLA(SSTOP) ; if primary stop code is not tele health check secondary stop code if secondary not tele health stop
 Q:$G(STOP)=0  ; Double check for either primary or secondary stop code to be a tele health clinic
 N PARMS,SEG,WHOTO,ERROR,SEQ
 S PARMS("MESSAGE TYPE")="MFN",PARMS("EVENT")="M05"
 I '$$NEWMSG^HLOAPI(.PARMS,.MSG,.ERROR) W !,"ERR= "_$G(ERROR) Q 0
 S SEQ=1
 N % D NOW^%DTC S UPDTTM=$$TMCONV^SDTMPHLA(%) ; need to convert to HL7 in UTC
 K CLIN,IEN S IEN=CLINID_"," D CLINDATA(IEN)
 D MFI(CLINID,SEQ,.SEG)
 I '$$ADDSEG^HLOAPI(.MSG,.SEG,.ERROR) W !,"NOT ADDED "_$G(ERROR)_" " Q 0
 D MFE(CLINID,SEQ,.SEG)
 I '$$ADDSEG^HLOAPI(.MSG,.SEG,.ERROR) Q 0
 D LOC(CLINID,SEQ,.SEG)
 I '$$ADDSEG^HLOAPI(.MSG,.SEG,.ERROR) Q 0
 D NTE(CLINID,SEQ,.SEG)
 I '$$ADDSEG^HLOAPI(.MSG,.SEG,.ERROR) Q 0
 D LDP(CLINID,SEQ,.SEG)
 I '$$ADDSEG^HLOAPI(.MSG,.SEG,.ERROR) Q 0
 D ZDP(CLINID,SEQ,.SEG)
 I $D(SEG),'$$ADDSEG^HLOAPI(.MSG,.SEG,.ERROR) Q 0
 D ZPU(CLINID,SEQ,.SEG)
 S PARMS("SENDING APPLICATION")="TMP_OUT"
 S WHOTO("RECEIVING APPLICATION")="TMP VIMT"
 S WHOTO("FACILITY LINK NAME")="TMP_SEND"
 S WHOTO("FACILITY LINK IEN")=$O(^HLCS(870,"B","TMP_SEND",0))
 S RTN=$$SENDONE^HLOAPI1(.MSG,.PARMS,.WHOTO,.ERROR)
 K CLINID,LOC
 Q RTN
MFI(CLINID,SEQ,SEG) ;
 N APPID
 D SET^HLOAPI(.SEG,"MFI",0) ; Set the segment type
 ;D SET^HLOAPI(.SEG,"MFI",0) ; Set segment type to MFI
 D SET^HLOAPI(.SEG,CLINID,1) ; Set CLINIC ID
 S APPID="44^HOSPITAL LOCATION"
 D SET^HLOAPI(.SEG,APPID,2) ; File to be updated
 D SET^HLOAPI(.SEG,"UPD",3) ; Hard set as an UPD to the file  -- Need code to determine if new or update
 D SET^HLOAPI(.SEG,UPDTTM,4) ; date/time the update occurred
 D SET^HLOAPI(.SEG,UPDTTM,5) ; effective date/time
 D SET^HLOAPI(.SEG,"AL",6) ; response level code, this is set to AL for ALWAYS
 Q
MFE(CLINID,SEQ,SEG) ;
 N TYPE
 D SET^HLOAPI(.SEG,"MFE",0) ; Set the segment type
 S TYPE="MUP" ; this will be MAD for adding a new clinic, MUP for an update, MDS do deactivate and MAC for reactivate
 D SET^HLOAPI(.SEG,TYPE,1) ; type of action
 D SET^HLOAPI(.SEG,CLINID,2) ; Clinic IEN from the Hospital Location file
 D SET^HLOAPI(.SEG,UPDTTM,3)
 D SET^HLOAPI(.SEG,CLINID,4)
 D SET^HLOAPI(.SEG,"CE",5) ; Primary key value type, this will always be CE
 Q
LOC(CLINID,SEQ,SEG) ;
 N INSTNUM,VISN,STATNUM,CLINNM,DIV,DIV1,DIV2,DIV3
 K LOC
 S CLINNM=CLIN(44,CLINID_",",.01,"E"),STATNUM=$G(CLIN(44,CLINID_",",3,"I"))
 ;Patch 714 PB - 11/07/19 Add division id to HL7 message
 S DIV1=$$GET1^DIQ(44,CLINID_",",3.5,"I") S:$G(DIV1)>0 DIV2=$P(^DG(40.8,$G(DIV1),0),"^",7) S:$G(DIV2)>0 DIV3=$$GET1^DIQ(4,DIV2_",",99,"E")
 D SET^HLOAPI(.SEG,"LOC",0) ; Set the segment type
 D SET^HLOAPI(.SEG,CLINID,1) ; IEN from the Hospital Location file
 D SET^HLOAPI(.SEG,CLINNM,2) ; .01 from the Hospital Location file for the clinic
 D SET^HLOAPI(.SEG,"C",3) ; location type, this will always be C for clinic
 S INSTNUM=$$KSP^XUPARAM("INST"),INSTNUM=$P(^DIC(4,INSTNUM,99),"^")
 S VISN=$$VISN(INSTNUM) S:$G(VISN)'>0 VISN=0 ; Makes the assumption that a medical center only has one Parent Facility in the Institution file
 ; Need to change how LOC is used to set the data on the LOC segment. this is causing problems
 S LOC=$G(CLINNM)_"^"_INSTNUM_"^^^"_$G(VISN)_"^"_$G(STATNUM)
 D SET^HLOAPI(.SEG,$G(CLINNM),4,1) ; Clinic name
 D SET^HLOAPI(.SEG,$G(INSTNUM),4,2) ; institution number
 D SET^HLOAPI(.SEG,$G(VISN),4,5) ; visn
 D SET^HLOAPI(.SEG,$G(DIV3),4,3) ; station number Patch 714 PB 11/07/19 division id as station number
 Q
NTE(CLINID,SEQ,SEG) ;
 ;only one NTE per message. has the clinic start time and number of overbooks per day
 N CLINSTRT,OVERBK
 S CLINSTRT=CLIN(44,CLINID_",",1914,"E"),OVERBK=CLIN(44,CLINID_",",1918,"E")
 D SET^HLOAPI(.SEG,"NTE",0)
 D SET^HLOAPI(.SEG,1,1)
 D SET^HLOAPI(.SEG,$G(CLINSTRT),2)
 D SET^HLOAPI(.SEG,$G(OVERBK),3)
 Q
LDP(CLINID,SEQ,SEG) ;
 W !,"LDP"
 N LS,TSPEC,PSTOP,SSTOP,PSNM,CSNM,ACT
 D ACT
 S LS=CLIN(44,CLINID_",",9,"E")
 S TSPEC=CLIN(44,CLINID_",",9.5,"E")
 S PSTOP=CLIN(44,CLINID_",",8,"I"),SSTOP=CLIN(44,CLINID_",",2503,"I"),PSNM=CLIN(44,CLINID_",",8,"E"),CSNM=CLIN(44,CLINID_",",2503,"E")
 S:$G(PSTOP)>0 PSTOP=$$GET1^DIQ(40.7,PSTOP_",",1,"I")
 S:$G(SSTOP)>0 SSTOP=$$GET1^DIQ(40.7,SSTOP_",",1,"I")
 D SET^HLOAPI(.SEG,"LDP",0)
 D SET^HLOAPI(.SEG,CLINID,1)
 ;NEED TO CHANGE THE SEGMENT FIELD SET BELOW TO SET INTO THE SUB FIELDS CORRECTLY
 D SET^HLOAPI(.SEG,LOC,2)
 D SET^HLOAPI(.SEG,$G(LS),3)
 D SET^HLOAPI(.SEG,$G(TSPEC),4)
 D SET^HLOAPI(.SEG,$G(ACT),6)
 D SET^HLOAPI(.SEG,$G(ACTDT),7)  ; reactivation date
 D SET^HLOAPI(.SEG,$G(INACTDT),8)  ; inactivation date
 D SET^HLOAPI(.SEG,"UNK",9)
 ; change the line below to use HLO to set up the field and sub fields don't do manually
 D SET^HLOAPI(.SEG,$G(PSTOP)_"^"_$G(PSNM)_"^CLINIC STOP^"_$G(SSTOP)_"^"_$G(CSNM),12) ;STOP CODES
 Q
ZPU(CLINID,SEQ,SEG) ;
 N XX,SEQA
 ; Need code to loop thru the privileged users and add a segment for each privileged user
 S XX=0,SEQA=1 F  S XX=$O(^SC(CLINID,"SDPRIV",XX)) Q:XX'>0  D
 .N CIEN S CIEN=+$P(^SC(CLINID,"SDPRIV",XX,0),"^")
 .Q:$G(CIEN)'>0
 .N CLERKNM,CLERKEMAIL,CVPID
 .S CLERKNM=$$GET1^DIQ(200,CIEN_",",.01,"E"),CLERKEMAIL=$$GET1^DIQ(200,CIEN_",",.151,"E"),CVPID=$$GET1^DIQ(200,CIEN_",",9000,"I")
 .I $G(CLERKNM)'="",$G(CLERKEMAIL)="" S CLERKEMAIL="UNK"
 .S:$G(CVPID)="" CVPID="0"
 .D SET^HLOAPI(.SEG,"ZPU",0)
 .D SET^HLOAPI(.SEG,SEQA,1)
 .D SET^HLOAPI(.SEG,CLERKNM,2)
 .D SET^HLOAPI(.SEG,CLERKEMAIL,3)
 .D SET^HLOAPI(.SEG,CVPID,4)
 .S SEQA=$G(SEQA)+1
 .I '$$ADDSEG^HLOAPI(.MSG,.SEG,.ERROR) Q
 Q
ZDP(CLINID,SEQ,SEG) ; has the default provider duz, default provider name and default provider email
 ;default provider duz comes from the Clinic in file 44. provider name and email from file 2
 K PROVDUZ,PROVNM,PROVEMAIL,VPID
 ;S PROVNM="BURKHALTER,PHIL",PROVEMAIL="phil.burkhalter@anymail.com",VPID="123245V123"
 S PROVDUZ=CLIN(44,CLINID_",",16,"I"),PROVNM=CLIN(44,CLINID_",",16,"E")
 S PROVEMAIL="",VPID=""
 I $G(PROVDUZ)>0 S PROVEMAIL=$$GET1^DIQ(200,PROVDUZ_",",.151,"E","SDTMPERR"),VPID=$$GET1^DIQ(200,PROVDUZ_",",9000,"I","SDTMPERR")
 S:$G(PROVEMAIL)="" PROVEMAIL="UNK"
 S:$G(VPID)="" VPID="0"
 D SET^HLOAPI(.SEG,"ZDP",0)
 D SET^HLOAPI(.SEG,SEQ,1)
 D SET^HLOAPI(.SEG,$G(PROVNM),2)
 D SET^HLOAPI(.SEG,$G(PROVEMAIL),3)
 D SET^HLOAPI(.SEG,$G(VPID),4)
 K PROVNM,PROVEMAIL,VPID
 Q
CLINDATA(CLINID) ; get the clinic data, add code to pull the data from file 44 and 200
 N FLDS
 Q:$G(CLINID)'>0
 S IEN=CLINID_",",FLDS=".01;3;8;9;9.5;16;1914;1918;2503;2505;2506"
 D GETS^DIQ(44,IEN,FLDS,"IE","CLIN","TMPERR")
 Q
VISN(INSTNUM) ;
 N IEN,VISNPTR
 S VISN=0
 S IEN=$$IEN^XUAF4(INSTNUM)
 S:$G(IEN)>0 VISNPTR=$P(^DIC(4,IEN,7,1,0),"^",2)
 I $G(VISNPTR)>0 D
 .S VISN=$P($G(^DIC(4,VISNPTR,0)),"^",1)
 .S VISN=$P(VISN," ",2)
 Q VISN
ACT ;
 N INACTDT,ACTDT
 S INACTDT=CLIN(44,CLINID_",",2505,"I")
 I INACTDT="" S ACT="A"
 I INACTDT'="" D
 .S ACT="I"
 .S ACTDT=CLIN(44,CLINID_",",2506,"I")
 .I ACTDT>INACTDT S ACT="A"
 Q
