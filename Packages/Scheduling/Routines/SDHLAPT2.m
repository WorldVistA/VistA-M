SDHLAPT2 ;MS/PB - VISTA SCHEDULING RPCS ; 4/29/24 10:37am
 ;;5.3;Scheduling;**704,773,810,879**;Aug 13, 1993;Build 31
 ;
 ;879 - moved code here from sdhl7apt due to 15k limits
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
 . S:$G(MTC)=1 SDAPTYP="R|"                                                                                        ;879 init this var typ of R
 . ;get the last child sequence number and set RTCID and MSGARY("RTCID") = to last sequence number plus 1          ;879 stop below set to next mult ien +1 that is not an RTCID ien
 . ;K X12,RTCID S RTCID="",X12=0 I +$L(SDPARENT) F  S X12=$O(^SDEC(409.85,SDPARENT,2,X12)) Q:X12'>0  S RTCID=X12+1  ;New, don't kill
 . ;S:$G(MTC)=1 SDAPTYP="R|"_$G(RTCID) ; if this is a multi RTC order $P(SDAPTYP,"|",2) is the next child sequence number, else it is null
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
 ;
LOOPMSG(ERR,ERRTXT) ;Loop to read in HL7 msg data. Code moved here from sdhl7apt. 879
 S (ERR,ERRTXT)=""
  F  Q:'$D(@MSGROOT@(CNT))  Q:ERR  D  S CNT=CNT+1,PREVSEG=SEGTYPE
 .S SEGTYPE=$G(@MSGROOT@(CNT,0))
 .I SEGTYPE="MSH" M MSH=@MSGROOT@(CNT) Q
 .I SEGTYPE="SCH" M SCH=@MSGROOT@(CNT) Q
 .I SEGTYPE="NTE",(PREVSEG="SCH") M SCHNTE=@MSGROOT@(CNT) Q
 .I SEGTYPE="PID" M PID=@MSGROOT@(CNT) Q
 .I SEGTYPE="PV1" M PV1=@MSGROOT@(CNT) Q
 .I SEGTYPE="OBX" M OBX=@MSGROOT@(CNT) Q
 .I SEGTYPE="RGS" D  Q
 ..S SETID=$G(@MSGROOT@(CNT,1))
 ..I +SETID=0 S ERR=1,ERRTXT="Invalid RGS SetID received" Q
 ..M RGS(SETID)=@MSGROOT@(CNT)
 ..S GRPCNT=GRPCNT+1
 .I SEGTYPE="AIS" M AIS(SETID)=@MSGROOT@(CNT) Q
 .I SEGTYPE="NTE",(PREVSEG="AIS") M AISNTE(SETID)=@MSGROOT@(CNT) Q
 .I SEGTYPE="AIG" M AIG(SETID)=@MSGROOT@(CNT) Q
 .I SEGTYPE="NTE",(PREVSEG="AIG") M AIGNTE(SETID)=@MSGROOT@(CNT) Q 
 .I SEGTYPE="AIL" M AIL(SETID)=@MSGROOT@(CNT) Q
 .I SEGTYPE="NTE",(PREVSEG="AIL") M AILNTE(SETID)=@MSGROOT@(CNT) Q 
 .I SEGTYPE="AIP" M AIP(SETID)=@MSGROOT@(CNT) Q
 .I SEGTYPE="NTE",(PREVSEG="AIP") M AIPNTE(SETID)=@MSGROOT@(CNT)
 Q
 ;
CHKCHILD() ; Multi-RTC check if children exist
 N INPBK M INPBK=INP  ;879
 N FCHILD,MTC
 S FCHILD=0,SDCLNERR=""
 I $P($G(SDAPTYP),"|",1)="R" D  ; if rtc check to see if the children exist
 .I $G(SDPARENT)="" S SDPARENT=$G(SCH(24,1,1))
 .I $G(SDPARENT)="" S SDPARENT=$G(SCH(23,1,1))
 .Q:'SDPARENT
 .S MTC=+$P($G(^SDEC(409.85,SDPARENT,3)),"^",3),SDMRTC=$S(MTC>0:"1",1:0)   ;879 Always init MTC
 .Q:MTC=0  ; Not a multi RTC
 .S:$G(SDCL)>0 SDRTCCLIN=$P(^SDEC(409.85,SDPARENT,0),"^",9)
 .S DUZ=$G(MSGARY("DUZ"))
 .I $G(SDRTCCLIN)'=SDCL S SDCLNERR="CLINIC SCHEDULED & CLINIC APPT REQUEST ARE MIS-MATCHED" Q   ;when clinic in Request file does not match IT skips make children and books to MRTC Parent Req rec incorrectly.
 .I '$$CHILDREN(SDPARENT) S FCHILD=$$MRTCCHILD(SDPARENT,MTC)   ;If no children Reqs, then Add all children and return First child ien
 K INP M INP=INPBK    ;879
 Q FCHILD
 ;
CHILDREN(PARENT) ;Check if any children Reqs exists from parent to end of file
 ; return 1 = Yes ; 0 = No
 Q:'PARENT 0
 N QQ,YES,REC3
 S YES=0,QQ=PARENT F  S QQ=$O(^SDEC(409.85,QQ)) Q:'QQ  D  Q:YES
 .S REC3=$G(^SDEC(409.85,QQ,3)) I $P(REC3,U,5)=PARENT S YES=1
 Q YES
 ;
APPTSCENARIO ;Examine SCH/AIL segments for correct passed in scenarios from CRM/HS also handle exceptions
 S SDCHILD=$G(SDCHILD),SDPARENT=$G(SDPARENT)
 I '$G(AIL(1,4)) D                                                    ;All but VVC - get child and parent for non VVC, correct any exceptions below when RTC
 .D:$G(SDPATMODE)
 ..S SDCHILD=$S($G(SCH(7,1,1)):$G(SCH(7,1,1)),1:$G(AIL(1,4,1,1)))
 ..S SDPARENT=$S($G(SCH(23,1,1)):$G(SCH(23,1,1)),1:$G(AIL(1,4,1,4)))
 .D:$G(SDPRVMODE)
 ..S SDCHILD=$S($G(SCH(7,1,4)):$G(SCH(7,1,4)),1:$G(AIL(1,4,1,1)))
 ..S SDPARENT=$S($G(SCH(24,1,1)):$G(SCH(24,1,1)),1:$G(AIL(1,4,1,4)))
 I $G(AIL(1,4)) D                                                     ;VVC use AIL values if not prev defined and only sends in AIL(1,4) AIL(1,2) + SCH
 .S:$G(AIL(1,2))]"" $P(SDAPTYP,"|",1)=AIL(1,2)
 .S:'SDCHILD SDCHILD=$G(AIL(1,4)),$P(SDAPTYP,"|",2)=SDCHILD
 .S:'SDPARENT SDPARENT=$G(SCH(24,1,1))
 I 'SDCHILD,'SDPARENT S $P(SDAPTYP,"|",2)=""                          ;Init sdaptyp piece 2 to null for no passed in via AIL segment ien values
 ; start RTC examinations includes Single RTC & MRTC
 I ($P(SDAPTYP,"|",1)="R")!($G(AIL(1,4,1,2))="R") D                   ;RTCs only processing
 .I SDPARENT="null",SDCHILD S SDAPTYP="R|"_SDCHILD,SDPARENT="" Q       ;Single RTC case (a) specific case
 .I SDPARENT="null",'SDCHILD S SDAPTYP="R"_RTCID,SDPARENT="" Q         ;Single RTC case (b) specific case
 .I SDCHILD,SDPARENT,SDCHILD'=SDPARENT S SDAPTYP="R|"_SDCHILD Q        ;MRTC Normal case (a), where both correct child and parent passed in, so use child for REQ file
 .I SDCHILD,SDPARENT,SDCHILD=SDPARENT S SDCHILD=""                     ;MRTC Solo case (b) or Single RTC case (a) Patient site
 .I 'SDCHILD,SDPARENT D
 ..I '$P(^SDEC(409.85,SDPARENT,3),U,1) D                               ;Single RTC case (a)
 ...S SDMTC=0,SDCHILD=SDPARENT,SDAPTYP="R|"_SDPARENT,SDPARENT=""          ;child ien left null in AIL(1,4,1,1) and AIL(1,4,1,4) ien (parent) had the RTC ien, Switch parent & child as parent must not be defined for single RTC
 ..E  D                                                                ;MRTC Solo parent case (b), where child passed is also parent (1st time to use new CPRS RTC order)
 ...S SDMTC=1,FCHILD=$$CHKCHILD^SDHLAPT2                                  ;if the child orders are not yet in 409.85, then add them
 ...S:$G(FCHILD) SDCHILD=FCHILD,SDAPTYP="R|"_FCHILD                       ;MRTC, 1st child just added above
 Q
 ;
MRTCCHILD(PARENT,MTC) ;Add children RTCs to Req file for a solo parent and increment CID date for each Req child
 N %DT,FCHILD,I,INTV,PARPID,RTN,SCXX,X
 S FCHILD="",RTN=0,INTV=$P(^SDEC(409.85,PARENT,3),U,2),PARPID=$P(^SDEC(409.85,PARENT,0),U,16)
 I MTC>0 F I=1:1:MTC Q:I>MTC  D
 .S INP(1)=""
 .S INP(3)=$$FMTE^XLFDT($$NOW^XLFDT)
 .S INP(5)="RTC"
 .S INP(6)=$P(^SDEC(409.85,PARENT,0),"^",9)
 .S:I=1 INP(11)=PARPID                              ;1st request being built use parent CID date
 .S:I>1 INP(11)=$$FMADD^XLFDT(PARPID,(INTV*(I-1)))  ;subsequent requests being built, use interval to setup CID dates
 .S INP(9)="PROVIDER"
 .S INP(10)=$P($G(^SDEC(409.85,PARENT,0)),"^",13)   ;Prov ien from parent
 .S INP(12)=$G(SDECNOTE)
 .S INP(14)="YES"
 .S INP(15)=INTV
 .S INP(16)=MTC
 .S SCXX=$S(PARENT>0:$$GET1^DIQ(409.85,PARENT_",",15,"I"),1:0)
 .S INP(18)=$S($G(SCXX)=1:"YES",1:"NO")  ;is this service connected? we can get this from the parent
 .S INP(19)=+$P(^DPT($G(INP(2)),.3),"^",2)
 .S INP(22)="9"
 .S INP(23)="NEW"
 .S INP(25)=PARENT
 .D ARSET^SDECAR2(.RTN,.INP)
 .S:I=1 FCHILD=+$P(RTN,$c(30),2)   ;return the 1st FCHILD request
 Q FCHILD
 ;
BLDARRAYS(ERR,ERRTXT) ;Build segment arrays. Code moved here from sdhl7apt. 879
 S (ERR,ERRTXT)=""
 D MSH^SDHL7APU(.MSH,.INP,.MSGARY)
 D SCH^SDHL7APU(.SCH,.INP,.MSGARY)
 I ERR Q   ;859-check for a Cancel Reason
 D SCHNTE^SDHL7APU(.SCHNTE,.INP,.MSGARY)
 D PID^SDHL7APU(.PID,.INP,.MSGARY)
 D PV1^SDHL7APU(.PV1,.INP,.MSGARY)
 D OBX^SDHL7APU(.OBX,.INP)
 F IX=1:1:GRPCNT D
 .D RGS^SDHL7APU(.RGS,IX,.INP)
 .D AIS^SDHL7APU(.AIS,IX,.INP,.MSGARY)
 .D AISNTE^SDHL7APU(.AISNTE,IX,.INP)
 .D AIG^SDHL7APU(.AIG,IX,.INP)
 .D AIGNTE^SDHL7APU(.AIGNTE,IX,.INP)
 .D AIL^SDHL7APU(.AIL,IX,.INP,.MSGARY)
 .D AILNTE^SDHL7APU(.AILNTE,IX,.INP)
 .D AIP^SDHL7APU(.AIP,IX,.INP,.MSGARY)
 .D AIPNTE^SDHL7APU(.AIPNTE,IX,.INP)
 Q
 ;
LASTCHILD(PARENT) ;Check if the last child for this MRTC Appt was made
 N LAST,QUIT,PCNT,CHIEN,RR,REC0,REC3
 S (QUIT,LAST,PCNT)=0
 Q:'+^SDEC(409.85,PARENT,3) LAST                         ;quit not a MRTC parent
 S PCNT=+$P(^SDEC(409.85,PARENT,3),U,3)                  ;tot num of RTC Appts needed to complete the MRTC
 S RR=PARENT
 F  S RR=$O(^SDEC(409.85,RR)) Q:'RR  D                   ;read all that point to parent and account for them
 .S REC0=$G(^SDEC(409.85,RR,0))
 .S REC3=$G(^SDEC(409.85,RR,3))
 .I $P(REC3,U,5)=PARENT,$P(REC0,U,17)="C" S PCNT=PCNT-1
 I PCNT'>0 S LAST=1                                      ;if orig parent count reduced to 0, then is lastchild
 Q LAST
 ;
MRTCCLOSEOUT ;MRTC appts only closeout processing for parent
 D AR433^SDECAR2(SDPARENT,SDAPT_"~"_SDCHILD)  ;Set parent Req Mult #2 node for last appt just made
 I $$LASTCHILD^SDHLAPT2(SDPARENT) D           ;IF Lastchild, then close parent MRTC Req
 .N INP S INP(1)=+SDPARENT,INP(2)="MC",INP(3)=$G(DUZ),DUZ(2)=$G(STA),INP(4)=$$FMTE^XLFDT(DT)    ;Close/disposition Parent req
 .D ARCLOSE^SDECAR(.RET,.INP)
 Q
 ;
MRTCREOPEN ;Execute MRTC Parent Re-Open logic
 N INP,SDC,SDCIEN,SDFDA,QUIT S (QUIT,SDC)=""
 F  S SDC=$O(^SDEC(409.85,SDPARENT,2,"B",SDC)) Q:(SDC="")!(QUIT)  D                   ;Find 2 mult sdchild ien rec and correct if found.
 .I SDC=SDCHILD D  Q:QUIT                                                               ;If recien ptr = sdchild, then erase this one and quit
 ..S SDCIEN=$O(^SDEC(409.85,SDPARENT,2,"B",SDC,""))
 ..S SDFDA(409.852,SDCIEN_","_SDPARENT_",",.02)="" D UPDATE^DIE("","SDFDA") S QUIT=1      ;Erase Appt file ppointer
 I '$$LASTCHILD^SDHLAPT2(SDPARENT) D AROPEN^SDECAR("","",SDPARENT)                    ;Open Parent req
 Q
