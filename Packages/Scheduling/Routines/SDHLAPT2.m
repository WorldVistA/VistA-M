SDHLAPT2 ;MS/PB - VISTA SCHEDULING RPCS ;Nov 14, 2014
 ;;5.3;Scheduling;**704,773,810**;Nov 14, 2018;Build 3
 ;
 Q
AIL ;
 D PARSESEG^SDHL7APU(SEG,.AIL,.HL)
 S SDCL=+$G(AIL(3,1,1)) N RET,RET1 D RESLKUP^SDHL7APU(SDCL) S SDECRES=RET1
 N STCREC,CONSID,MTC
 S STCREC=""
 S SDAPTYP=""
 S (SDPARENT)=$G(AIL(1,4,1,4))
 I $G(AIL(1,4,1,2))="C" S CONSID=$G(AIL(1,4,1,1)),SDAPTYP="C|"_$G(AIL(1,4,1,1))
 I $G(AIL(1,4,1,2))="R" D
 . S MTC=$P($G(^SDEC(409.85,+$G(SDPARENT),3)),"^"),SDMRTC=$S(MTC>0:1,1:0)
 . ;get the last child sequence number and set RTCID and MSGARY("RTCID") = to last sequence number plus 1
 . K X12,RTCID S RTCID="",X12=0 I +$L(SDPARENT) F  S X12=$O(^SDEC(409.85,SDPARENT,2,X12)) Q:X12'>0  S RTCID=X12+1
 . S:$G(MTC)=1 SDAPTYP="R|"_$G(RTCID) ; if this is a multi RTC order $P(SDAPTYP,"|",2) is the next child sequence number, else it is null
 . Q
 ;Get parent rtc order if it is a multi appointment rtc
 S:$G(AIL(1,4,1,2))="A" SDAPTYP="A|"
 I $P(PROVAPT(XX+1),"|")="NTE" S SDECNOTE=$P($G(PROVAPT(XX+1)),"|",4)
 Q
 ;
NEWTIME  ;Adjust time for intrafacility appointment
 N ST1,ST12
 S ST12=$P(SDTMPHL(1),"|",12),ST1=$P(ST12,"^",4)
 S INST=$$INST^SDTMPHLA(AIL(2,3,1,1))
 S ST1=$$JSONTFM(ST1,INST)
 S ST1=$$FMADD^XLFDT(ST1,,,5) ;Add 5 minutes
 S ST1=$$TMCONV^SDTMPHLA(ST1,INST)
 S $P(ST12,"^",4)=$G(ST1)
 S $P(SDTMPHL(1),"|",12)=$G(ST12)
 S $P(SDTMPHL(5),"|",5)=$P(ST12,"^",4)
 Q
 ;
CHKCON(DFN,SDAPTYP) ; checks if both consult ids or both rtc ids match the patient, if the consult or rts is not for the patient, reject
 Q:$G(AIL(1,3,1,4))'=$G(AIL(2,3,1,4))
 S STOPME=0
 N IENS,X1,GMRDFN
 I $P($G(SDAPTYP),"|",1)="C" D
 .F X1=1:1:2 D
 ..Q:$G(STOPME)=1
 ..S IENS=+$G(AIL(X1,4,1,1))
 ..Q:+$G(IENS)'>0
 ..S GMRDFN=$$GET1^DIQ(123,IENS_",",.02,"I","ERR")
 ..I $G(GMRDFN)'=$G(DFN)!($G(^GMR(123,+$G(IENS),0))="") D
 ...S ERR="MSA^1^^100^AE^CONSULT ID# "_+$G(IENS)_" IS NOT FOR PATIENT "_$P(^DPT(DFN,0),"^")
 ...D SENDERR^SDHL7APU(ERR)
 ...S STOPME=1
 ..Q
 .Q
 I $P($G(SDAPTYP),"|",1)="R" D
 .F X1=1:1:2 D
 ..Q:$G(STOPME)=1
 ..S IENS=+$G(AIL(X1,4,1,1))
 ..Q:+$G(IENS)'>0
 ..I $G(DFN)'=$P($G(^SDEC(409.85,IENS,0)),"^",1)!($G(^SDEC(409.85,IENS,0))="") D
 ...S STOPME=1
 ...S ERR="MSA^1^^100^AE^RTC ORDER# "_+$P($G(SDAPTYP),"|",2)_" IS NOT FOR PATIENT "_$P(^DPT(DFN,0),"^")
 ...D SENDERR^SDHL7APU(ERR)
 ..Q
 Q
 ;
CHKCAN(PAT,CLINIC,DATE) ; check to see if the appointment in 44 is canceled correctly. if not cancel it
 N TIEN,DIK,DA
 Q:$G(PAT)'>0
 Q:$G(CLINIC)'>0
 Q:$G(DATE)=""
 S TIEN=$$SCIEN^SDECU2(PAT,CLINIC,DATE)
 Q:$G(TIEN)'>0
 I $G(TIEN)>0 D
 .S DIK="^SC("_CLINIC_",""S"","_DATE_",1,"
 .S DA(2)=CLINIC,DA(1)=DATE,DA=TIEN
 .D ^DIK
 .K DIK,DA
 Q
 ;
JSONTFM(DTTM,INST) ;Convert XML/JSON external time to FM format in local timezone. If zulu time, apply timezone difference.
 ;Inputs:
 ; DTTM = Date with time in JSON format
 ; INST = Institution
 ;Output:
 ; Date and time in FileMan format with zulu difference applied if indicated
 N DIFF,DATE,TM,SDT,ZULU,TZINST
 S ZULU=DTTM["Z" ;is this zulu time?
 S TZINST=$$CHKINST^SDTMPHLA(INST) ;get correct institution
 S DATE=$P(DTTM,"T"),DATE=$TR(DATE,"-",""),DATE=DATE-17000000 ;get date
 S TM=$P(DTTM,"T",2),TM=$P(TM,"."),TM=$TR(TM,":",""),TM=+("."_TM) ;get time
 I TM=0 S TM=".000001" ;Add 1 second to avoid midnight problem
 S DIFF=0 I ZULU S DIFF=$P($$UTC^DIUTC(DATE_TM,,TZINST,,1),"^",3) ;if zulu compute tz difference
 S SDT=$$FMADD^XLFDT(DATE_TM,,$G(DIFF),0) ;add tz difference
 Q +$E(SDT,1,13) ;get rid of 1 second and trailing zeroes
