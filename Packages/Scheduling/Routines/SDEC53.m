SDEC53 ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
PTSET(SDECY,INP) ;SET patient demographics
 ;PTSET(SDECY,INP...)  external parameter tag is in SDEC
 ;INPUT:
 ;  all input except DFN is optional
 ;  INP(1)  = DFN       - (required) pointer to PATIENT file
 ;  INP(2)  = RACE      -  pointer to the RACE file 10
 ;                         Each pipe piece contains the following pieces (Race1;;Method1|Race2;;Method2):
 ;                         RACE INFORMATION - pointer to the RACE file 10
 ;                         METHOD OF COLLECTION - pointer to the RACE AND ETHNICITY COLLECTION METHOD file 10.3
 ;  INP(3)  = ETHNICITY -  multiple Ethnicity separated by pipe |
 ;                         Each pipe piece contains the following ;; pieces:
 ;              ETHNICITY INFORMATION - pointer to the ETHNICITY file 10.2
 ;              METHOD OF COLLECTION - pointer to the ETHNICITY COLLECTION METHOD file 10.3
 ;  INP(4)  = ADDRESS1 - Street Address (Line 1) Free text 3-30 characters
 ;  INP(5)  = ADDRESS2 - Street Address (Line 2) Free text 3-30 characters
 ;  INP(6)  = ADDRESS3 - Street Address (Line 3) Free text 3-30 characters
 ;  INP(7)  = ZIP CODE - Zip+4 Free text of 5 or 9 digits
 ;  INP(8)  = CITY     - Free text 2-15 characters
 ;  INP(9)  = STATE    - pointer to STATE file 5
 ;  INP(10)  = COUNTRY  - pointer to COUNTRY CODE file 779.004
 ;  INP(11) = BAD ADDRESS INDICATOR - Valid Values:
 ;                  UNDELIVERABLE
 ;                  HOMELESS
 ;                  OTHER
 ;                  ADDRESS NOT FOUND
 ;  INP(12) = PHONE (RESIDENCE) - free text 4-20 characters
 ;  INP(13) = PHONE (WORK)      - free text 4-20 characters
 ;RETURN:
 ; Successful Return:
 ;   Single Value return in the format "0^"
 ; Caught Exception Return:
 ;   A single entry in the Global Array in the format "-1^<error text>"
 ;   "T00020RETURNCODE^T00100TEXT"
 ; Unexpected Exception Return:
 ;     Handled by the RPC Broker.
 ;     M errors are trapped by the use of M and Kernel error handling.
 ;     The RPC execution stops and the RPC Broker sends the error generated
 ;     text back to the client.
 N ADD1,ADD2,ADD3,BADADD,CITY,COUNTRY,DFN,ETH,ETHN,ETHN1,PHONER,PHONEW,RACE,STATE,ZIP
 N SDECI,SDFDA,SDI,SDIN,SDMSG,RACEN,RACEN1
 S SDECI=0
 S SDECY="^TMP(""SDEC53"","_$J_",""PTSET"")"
 K @SDECY
 ; data header
 S @SDECY@(0)="T00030RETURNCODE^T00030TEXT"_$C(30)
 ;check for valid Patient
 S DFN=$G(INP(1))
 I '+DFN D ERR1^SDECERR(-1,"Invalid Patient ID.",SDECI,SDECY) Q
 I '$D(^DPT(DFN,0)) D ERR1^SDECERR(-1,"Invalid Patient ID.",SDECI,SDECY) Q
 ;check RACE
 ;S RACE=$G(INP(2))
 ;I RACE'="" I '$D(^DIC(10,RACE,0)) S RACE=""
 S RACEN=$G(INP(2))
 I RACEN'="" D
 .S RACEN1="" F SDI=1:1:$L(RACEN,"|") D
 ..S SDIN=$P(RACEN,"|",SDI)
 ..I $D(^DIC(10,+$P(SDIN,";;"),0)) D
 ...I $P(SDIN,";;",2)'="",$D(^DIC(10.3,+$P(SDIN,";;",2),0)) S RACEN1=$S(RACEN1'="":RACEN1_"|",1:"")_SDIN
 ...I $P(SDIN,";;",2)="" S RACEN1=$S(RACEN1'="":RACEN1_"|",1:"")_SDIN
 .S RACEN=RACEN1
 ;check ethnicity
 S ETHN=$G(INP(3))
 I ETHN'="" D
 .S ETHN1="" F SDI=1:1:$L(ETHN,"|") D
 ..S SDIN=$P(ETHN,"|",SDI)
 ..I $D(^DIC(10.2,+$P(SDIN,";;",1),0)) D
 ...I $P(SDIN,";;",2)'="",$D(^DIC(10.3,+$P(SDIN,";;",2),0)) S ETHN1=$S(ETHN1'="":ETHN1_"|",1:"")_SDIN
 ...I $P(SDIN,";;",2)="" S ETHN1=$S(ETHN1'="":ETHN1_"|",1:"")_SDIN
 .S ETHN=ETHN1
 ;check zip
 S ZIP=$G(INP(7))
 I ZIP'="" I $L(ZIP)'=5,$L(ZIP)'=9 S @SDECY@(1)="-1^Invalid ZIP."_$C(30,31) ;S ZIP=""
 ;check state
 S STATE=$G(INP(9))
 I STATE'="" I '$D(^DIC(5,+STATE,0)) S @SDECY@(1)="-1^Invalid State ID."_$C(30,31) Q  ;S STATE=""
 ;check country
 S COUNTRY=$G(INP(10))
 I COUNTRY'="" I '$D(^HL(779.004,+COUNTRY,0)) S @SDECY@(1)="-1^Invalid COUNTRY ID."_$C(30,31) Q  ;S COUNTRY=""
 S BADADD=$G(INP(11))
 I BADADD'="" S BADADD=$S(BADADD="UNDELIVERABLE":1,BADADD="HOMELESS":2,BADADD="OTHER":3,BADADD="ADDRESS NOT FOUND":4,1:"")
 S SDFDA="SDFDA(2,DFN_"","")"
 ;S:RACE'="" @SDFDA@(.06)=RACE
 S:$G(INP(4))'="" @SDFDA@(.111)=INP(4)
 S:$G(INP(5))'="" @SDFDA@(.112)=INP(5)
 S:$G(INP(6))'="" @SDFDA@(.113)=INP(6)
 S:ZIP'="" @SDFDA@(.1112)=ZIP
 S:$G(INP(8))'="" @SDFDA@(.114)=INP(8)
 S:STATE'="" @SDFDA@(.115)=STATE
 S:COUNTRY'="" @SDFDA@(.1173)=COUNTRY
 S:BADADD'="" @SDFDA@(.121)=BADADD
 S:$G(INP(12))'="" @SDFDA@(.131)=INP(12)
 S:$G(INP(13))'="" @SDFDA@(.132)=INP(13)
 ;D UPDATE^DIE("","SDFDA","","SDMSG")
 I $D(SDFDA)=11 D UPDATE^DIE("","SDFDA")
 I $D(SDMSG) D ERR1^SDECERR(-1,"Error storing data.",SDECI,SDECY) Q
 I RACEN'="" F SDI=1:1:$L(RACEN,"|") D
 .K SDFDA
 .S SDIN=$P(RACEN,"|",SDI)
 .S RACE=$O(^DPT(DFN,.02,"B",$P(SDIN,";;"),0))
 .S RACE=$S(RACE'="":RACE,1:"+1")
 .S SDFDA="SDFDA(2.02,"_$S(RACE'="":RACE_""",""",1:"""+1")_""","_DFN_",)"
 .S SDFDA=$NA(SDFDA(2.02,RACE_","_DFN_","))
 .S @SDFDA@(.01)=$P(SDIN,";;")
 .S:$P(SDIN,";;",2)'="" @SDFDA@(.02)=$P(SDIN,";;",2)
 .D UPDATE^DIE("","SDFDA")
 I ETHN'="" F SDI=1:1:$L(ETHN,"|") D
 .K SDFDA
 .S SDIN=$P(ETHN,"|",SDI)
 .S ETH=$O(^DPT(DFN,.06,"B",$P(SDIN,";;",1),0))
 .S ETH=$S(ETH'="":ETH,1:"+1")
 .S SDFDA="SDFDA(2.06,"_$S(ETH'="":ETH_""",""",1:"""+1")_""","_DFN_",)"
 .S SDFDA=$NA(SDFDA(2.06,ETH_","_DFN_","))
 .S @SDFDA@(.01)=$P(SDIN,";;",1)
 .S:$P(SDIN,";;",2)'="" @SDFDA@(.02)=$P(SDIN,";;",2)
 .D UPDATE^DIE("","SDFDA")
 S SDECI=SDECI+1 S @SDECY@(SDECI)="0^"_$C(30,31)
 Q
