SDEC53 ;ALB/SAT - VISTA SCHEDULING RPCS ;MAR 15, 2017
 ;;5.3;Scheduling;**627,658**;Aug 13, 1993;Build 23
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
 ;  INP(12) = PHONE (RESIDENCE) - free text 4-20 characters  (Phone #1)
 ;  INP(13) = PHONE (WORK)      - free text 4-20 characters
 ;  INP(14) = COUNTY name - name of a county from the COUNTY multiple within the STATE file (#5)
 ;  INP(15) = PHONE NUMBER [CELLULAR]  4-20 characters
 ;  INP(16) = Patient Email Address - 3-50 characters containing 1 @
 ;  INP(17) = Marital Status - pointer to MARITAL STATUS file (#11)
 ;  INP(18) = Religious Preference - pointer to RELIGION file (#13)
 ;  INP(19) = Patient Temporary Address Active? (.12105) Y:YES N:NO
 ;            Temporary Address data can only be edited if INP(19) is 'Y' or the 'TEMPORARY ADDRESS ACTIVE?' field is already defined as 'Y'.
 ;  INP(20) = Patient Temporary Address Line 1 (.1211)
 ;  INP(21) = Patient Temporary Address Line 2 (.1212)
 ;  INP(22) = Patient Temporary Address Line 3 (.1213)
 ;  INP(23) = Patient Temporary City (.1214)
 ;  INP(24) = Patient Temporary State (.1215)
 ;  INP(25) = Patient Temporary Zip (.1216)
 ;  INP(26) = Patient Temporary Zip+4 (.12112)
 ;  INP(27) = Patient Temporary Country (.1223)
 ;  INP(28) = Patient Temporary County (.12111)
 ;  INP(29) = Patient Temporary Phone (.1219)  (also referred to as Phone #2)
 ;  INP(30) = Patient Temporary Address Start Date (.1217) in external format (no time)
 ;  INP(31) = Patient Temporary Address End Date (.1218) in external format (no time)
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
 N %DT,DIC,RET,X,Y
 N ADD1,ADD2,ADD3,BADADD,CITY,COUNTRY,DA,DIK,DFN,ERR,ETH,ETHN,ETHN1,PHONER,PHONEW,RACE,STATE,ZIP
 N SDECI,SDFDA,SDI,SDIN,SDMSG,RACEN,RACEN1
 S ERR=0
 S SDECI=0
 S SDECY="^TMP(""SDEC53"","_$J_",""PTSET"")"
 K @SDECY
 ; data header
 S @SDECY@(0)="T00030RETURNCODE^T00030TEXT"_$C(30)
 ;check for valid Patient
 S DFN=$G(INP(1))
 I '+DFN D ERR1^SDECERR(-1,"Invalid Patient ID.",SDECI,SDECY) Q
 I '$D(^DPT(DFN,0)) D ERR1^SDECERR(-1,"Invalid Patient ID.",SDECI,SDECY) Q
 ;alb/sat 658 - lock patient: There are multiple variations used to lock a patient
 L +^TMP(DFN,"REGISTRATION IN PROGRESS"):5  I '$T S @SDECY@(1)="-1^Patient is being edited."_$C(30,31) G XIT
 L +^DPT(DFN):5  I '$T S @SDECY@(1)="-1^Patient is being edited."_$C(30,31) L -^TMP(DFN,"REGISTRATION IN PROGRESS") G XIT
 S SDFDA="SDFDA(2,DFN_"","")"
 ;address line 1
 S INP(4)=$G(INP(4))
 I INP(4)'="" D
 .S X=INP(4)
 .I X'="@",(X[""""!($A(X)=45))!($L(X)>35!($L(X)<3)) S @SDECY@(1)="-1^Invalid street address [line 1] "_INP(4)_"."_$C(30,31),ERR=1 Q
 .S @SDFDA@(.111)=INP(4)
 G:ERR EXIT  ;alb/sat 658
 ;address line 2
 S INP(5)=$G(INP(5))
 I INP(5)'="" D
 .N X S X=INP(5)
 .I X'="@",(X[""""!($A(X)=45))!($L(X)>30!($L(X)<3)) S @SDECY@(1)="-1^Invalid street address [line 2] "_INP(5)_"."_$C(30,31),ERR=1 Q
 .S @SDFDA@(.112)=INP(5)
 G:ERR EXIT  ;alb/sat 658
 ;address line 3
 S INP(6)=$G(INP(6))
 I INP(6)'="" D
 .N X S X=INP(6)
 .I X'="@",(X[""""!($A(X)=45))!($L(X)>30!($L(X)<3)) S @SDECY@(1)="-1^Invalid street address [line 3] "_INP(6)_"."_$C(30,31),ERR=1 Q
 .S @SDFDA@(.113)=INP(6)
 G:ERR EXIT  ;alb/sat 658
 ;zip
 S ZIP=$G(INP(7))
 I ZIP'="@",ZIP'="" N X S X=ZIP D ZIPIN^VAFADDR S X=$G(X),ZIP=X I $L(ZIP)'=5,$L(ZIP)'=9 S @SDECY@(1)="-1^Invalid ZIP."_$C(30,31) G EXIT  ;alb/sat 658
 S:ZIP'="" @SDFDA@(.1112)=ZIP
 ;city
 S INP(8)=$G(INP(8))
 I INP(8)'="" D
 .S X=INP(8)
 .I $L(X)>15 S ZIP=$S($L(INP(7))'="":INP(7),1:$$GET1^DIQ(2,DFN_",",.1112)) S:ZIP'="" X=$$CITYAB^SDECDEM(ZIP,X)
 .I X'="@",$L(X)>15!($L(X)<2) S @SDECY@(1)="-1^City name must be 2-15 characters. "_INP(8)_"."_$C(30,31),ERR=1 Q   ;alb/jsm 658 chk for "@"
 .S @SDFDA@(.114)=X
 G:ERR EXIT  ;alb/sat 658
 ;state
 S STATE=$G(INP(9))
 I STATE'="@",STATE'="" I '$D(^DIC(5,+STATE,0)) S @SDECY@(1)="-1^Invalid State ID."_$C(30,31) G EXIT  ;alb/sat/jsm 658 chk for "@"
 S:STATE'="" @SDFDA@(.115)=STATE
 ;country
 S COUNTRY=$G(INP(10))
 I COUNTRY'="@",COUNTRY'="" I '$D(^HL(779.004,+COUNTRY,0)) S @SDECY@(1)="-1^Invalid COUNTRY ID."_$C(30,31) G EXIT  ;alb/sat/jsm 658 chk for "@"
 S:COUNTRY'="" @SDFDA@(.1173)=COUNTRY
 ;bad address
 S BADADD=$G(INP(11))
 I BADADD'="" S:BADADD'="@" BADADD=$S(BADADD="UNDELIVERABLE":1,BADADD="HOMELESS":2,BADADD="OTHER":3,BADADD="ADDRESS NOT FOUND":4,1:"")
 S:BADADD'="" @SDFDA@(.121)=BADADD
 ;phone [residence]
 S INP(12)=$G(INP(12))
 I INP(12)'="" D
 .I INP(12)'="@" D
 ..I $L(INP(12))>20!($L(INP(12))<4) S @SDECY@(1)="-1^Phone Number [Residence] must be 4-20 characters. "_INP(12)_$C(30,31),ERR=1 Q
 ..;I 'ERR N CTR,CHR,VAR S VAR=INP(12) F CTR=1:1:20 S CHR=$E(VAR,CTR) I ("1234567890 -()."'[CHR) S ERR=1
 ..;I ERR S @SDECY@(1)="-1^Invalid Phone Number [Residence] "_INP(12)_$C(30,31),ERR=1 Q
 .I 'ERR S @SDFDA@(.131)=INP(12)
 G:ERR EXIT  ;alb/sat 658
 ;phone [work]
 S INP(13)=$G(INP(13))
 I INP(13)'="" D
 .I INP(13)'="@" D
 ..I $L(INP(13))>20!($L(INP(13))<4) S @SDECY@(1)="-1^Phone Number [work] must be 4-20 characters. "_INP(13)_$C(30,31),ERR=1 Q
 ..;I 'ERR N CTR,CHR,VAR S VAR=INP(13) F CTR=1:1:20 S CHR=$E(VAR,CTR) I ("1234567890 -()."'[CHR) S ERR=1
 ..;I ERR S @SDECY@(1)="-1^Invalid Phone Number [work] "_INP(13)_$C(30,31),ERR=1 Q
 .I 'ERR S @SDFDA@(.132)=INP(13)
 G:ERR EXIT  ;alb/sat 658
 ;pager number .135  ;alb/sat 658
 S INP(32)=$G(INP(32))
 I INP(32)'="" D
 .IF INP(32)'="@" D
 ..S X=INP(32) I $L(X)>20!($L(X)<4) S @SDECY@(1)="-1^Pager must be 4-20 characters. "_INP(32)_$C(30,31),ERR=1 Q
 ..I $D(X) N CTR,CHR,VAR S VAR=X F CTR=1:1:20 S CHR=$E(VAR,CTR) I ("1234567890 -()."'[CHR) S @SDECY@(1)="-1^Pager can only contain these characters: 1234567890 -()."_$C(30,31),ERR=1 Q
 ..S INP(32)=$G(X)
 .I 'ERR S @SDFDA@(.135)=INP(32)
 G:ERR EXIT  ;alb/sat 658
 ;county
 S INP(14)=$G(INP(14))
 I INP(14)'="" D
 .I INP(14)'="@" D  ;alb/jsm 658
 ..N X,Z0
 ..S Z0=$S(STATE'="":STATE,$D(^DPT(DFN,.11)):+$P(^DPT(DFN,.11),"^",5),1:0)
 ..I 'Z0 S @SDECY@(1)="-1^A state must be defined to update the County."_$C(30,31),ERR=1 Q
 ..I $D(^DIC(5,Z0,1,0)) S DIC="^DIC(5,Z0,1,",DIC(0)="QEM",X=INP(14) D ^DIC S X=+Y I Y'>0 S @SDECY@(1)="-1^County "_INP(14)_" does not belong to state "_INP(14)_"."_$C(30,31),ERR=1 Q
 ..S INP(14)=X
 .I 'ERR S @SDFDA@(.117)=INP(14)
 G:ERR EXIT  ;alb/sat
 ;phone [cell]
 S INP(15)=$G(INP(15))
 I INP(15)'="" D
 .I INP(15)'="@" D
 ..I $L(INP(15))>20!($L(INP(15))<4) S @SDECY@(1)="-1^Phone Number [Cellular] must be 4-20 characters. "_INP(15)_$C(30,31),ERR=1 Q
 ..I 'ERR N CTR,CHR,VAR S VAR=INP(15) F CTR=1:1:20 S CHR=$E(VAR,CTR) I ("1234567890 -()."'[CHR) S ERR=1
 ..I ERR S @SDECY@(1)="-1^Invalid Phone Number [Cellular] "_INP(15)_$C(30,31),ERR=1 Q
 .I 'ERR S @SDFDA@(.134)=INP(15)
 G:ERR EXIT  ;alb/sat
 ;email
 S INP(16)=$G(INP(16))
 I INP(16)'="" D
 .I INP(16)'="@" D
 ..N X S X=INP(16)
 ..I $L(X)>50!($L(X)<3)!'(X?1.E1"@"1.E1"."1.E) S @SDECY@(1)="-1^Invalid email address "_INP(16)_$C(30,31),ERR=1
 .I 'ERR S @SDFDA@(.133)=INP(16)
 G:ERR EXIT  ;alb/sat
 ;marital status
 S INP(17)=$G(INP(17))
 I INP(17)'="" D
 .I '$D(^DIC(11,INP(17),0)) S @SDECY@(1)="-1^Invalid marital status ID "_INP(17)_$C(30,31),ERR=1
 .I 'ERR S @SDFDA@(.05)=INP(17)
 G:ERR EXIT  ;alb/sat
 ;religious preference
 S INP(18)=$G(INP(18))
 I INP(18)'="" D
 .I '$D(^DIC(13,INP(18),0)) S @SDECY@(1)="-1^Invalid religious preference ID "_INP(18)_$C(30,31),ERR=1
 .I 'ERR S @SDFDA@(.08)=INP(18)
 G:ERR EXIT  ;alb/sat
 ;temporary address active?
 S INP(19)=$G(INP(19))
 I INP(19)'="" D
 .N X S X=INP(19)
 .S X=$S(X="Y":"Y",X="YES":"Y",X="N":"N",X="NO":"N",1:"")
 .I X="" S @SDECY@(1)="-1^Invalid 'temporary address active' flag "_INP(19)_$C(30,31),ERR=1
 .I 'ERR S (INP(19),@SDFDA@(.12105))=X
 G:ERR EXIT  ;alb/sat
 ;temporary address line 1
 S INP(20)=$G(INP(20))
 I INP(20)'="" D
 .N X S X=INP(20)
 .I X'="@",(X[""""!($A(X)=45))!($L(X)>30!($L(X)<2)) S @SDECY@(1)="-1^Invalid temporary street [line 1] "_INP(20)_"."_$C(30,31),ERR=1 Q
 .I X'="@",INP(19)'="Y",$S(INP(19)="N":1,'$D(^DPT(DFN,.121)):1,$P(^(.121),U,9)'="Y":1,1:0) S (X,INP(20))=""  ; S @SDECY@(1)="-1^Requirement for Temporary Address data not indicated...NO EDITING!",ERR=1 Q
 .I INP(20)'="",'ERR S @SDFDA@(.1211)=INP(20)
 G:ERR EXIT  ;alb/sat
 ;temporary address line 2
 S INP(21)=$G(INP(21))
 I INP(21)'="" D
 .N X S X=INP(21)
 .I X'="@",(X[""""!($A(X)=45))!($L(X)>30!($L(X)<2)) S @SDECY@(1)="-1^Invalid temporary street [line 2] "_INP(21)_"."_$C(30,31),ERR=1 Q
 .I X'="@",INP(19)'="Y",$S(INP(19)="N":1,'$D(^DPT(DFN,.121)):1,$P(^(.121),U,9)'="Y":1,1:0) S (X,INP(21))=""  ; S @SDECY@(1)="-1^Requirement for Temporary Address data not indicated...NO EDITING!",ERR=1 Q
 .I INP(21)'="",'ERR S @SDFDA@(.1212)=INP(21)
 G:ERR EXIT  ;alb/sat
 ;temporary address line 3
 S INP(22)=$G(INP(22))
 I INP(22)'="" D
 .N X S X=INP(22)
 .I X'="@",(X[""""!($A(X)=45))!($L(X)>30!($L(X)<2)) S @SDECY@(1)="-1^Invalid temporary street [line 3] "_INP(22)_"."_$C(30,31),ERR=1 Q
 .I X'="@",INP(19)'="Y",$S(INP(19)="N":1,'$D(^DPT(DFN,.121)):1,$P(^(.121),U,9)'="Y":1,1:0) S (X,INP(22))=""  ; S @SDECY@(1)="-1^Requirement for Temporary Address data not indicated...NO EDITING!",ERR=1 Q
 .I INP(22)'="",'ERR S @SDFDA@(.1213)=INP(22)
 G:ERR EXIT  ;alb/sat
 ;temporary city
 S INP(23)=$G(INP(23))
 I INP(23)'="" D
 .S X=INP(23)
 .I $L(X)>30 S ZIP=$S($L(INP(25))'="":INP(25),1:$$GET1^DIQ(2,DFN_",",.12112)) S:ZIP'="" X=$$CITYAB^SDECDEM(ZIP,X)
 .I X'="@",$L(X)>30!($L(X)<2) S @SDECY@(1)="-1^Invalid temporary city "_INP(23)_"."_$C(30,31),ERR=1 Q  ;alb/jsm 658
 .I X'="@",INP(19)'="Y",$S(INP(19)="N":1,'$D(^DPT(DFN,.121)):1,$P(^(.121),U,9)'="Y":1,1:0) S (X,INP(23))=""  ; S @SDECY@(1)="-1^Requirement for Temporary Address data not indicated...NO EDITING!",ERR=1 Q
 .I INP(23)'="",'ERR S @SDFDA@(.1214)=X
 G:ERR EXIT  ;alb/sat 658
 ;temporary state
 S INP(24)=$G(INP(24))
 I INP(24)'="" D
 .I INP(24)'="@",'$D(^DIC(5,INP(24),0)) S @SDECY@(1)="-1^Invalid temporary State id "_INP(24)_"."_$C(30,31),ERR=1 Q  ;alb/jsm 658
 .I INP(24)'="@",INP(19)'="Y",$S(INP(19)="N":1,'$D(^DPT(DFN,.121)):1,$P(^(.121),U,9)'="Y":1,1:0) S INP(24)=""  ; S @SDECY@(1)="-1^Requirement for Temporary Address data not indicated...NO EDITING!",ERR=1 Q
 .I INP(24)'="",'ERR S @SDFDA@(.1215)=INP(24)
 G:ERR EXIT  ;alb/sat
 ;temporary zip
 S INP(25)=$G(INP(25))
 I INP(25)'="" D
 .N X S X=INP(25)
 .D ZIPIN^VAFADDR S X=$G(X)
 .I X'="@",X[""""!($A(X)=45),$L(X)>5!($L(X)<5)!'(X?5N) S @SDECY@(1)="-1^Invalid Temporary Zip code "_INP(25)_"."_$C(30,31),ERR=1 Q
 .I X'="@",INP(19)'="Y",$S(INP(19)="N":1,'$D(^DPT(DFN,.121)):1,$P(^(.121),U,9)'="Y":1,1:0) S (X,INP(25))=""  ; S @SDECY@(1)="-1^Requirement for Temporary Address data not indicated...NO EDITING!",ERR=1 Q
 .I INP(25)'="",'ERR S @SDFDA@(.1216)=INP(25)
 G:ERR EXIT  ;alb/sat
 ;temporary zip+4
 S INP(26)=$G(INP(26))
 I INP(26)'="" D
 .I INP(26)'="@" D  ;alb/jsm 658
 ..N X S X=INP(26)
 ..I X'="@",X[""""!($A(X)=45),$L(X)>20!($L(X)<5) S @SDECY@(1)="-1^Invalid Temporary Zip+4 "_INP(26)_"."_$C(30,31),ERR=1 Q
 ..I X'="@" D ZIPIN^VAFADDR S X=$G(X) I X="" S @SDECY@(1)="-1^Invalid Temporary Zip+4 "_INP(26)_"."_$C(30,31),ERR=1 Q
 ..I X'="@",INP(19)'="Y",$S(INP(19)="N":1,'$D(^DPT(DFN,.121)):1,$P(^(.121),U,9)'="Y":1,1:0) S (X,INP(26))=""  ; S @SDECY@(1)="-1^Requirement for Temporary Address data not indicated...NO EDITING!",ERR=1 Q
 .I 'ERR,INP(26)'="" S @SDFDA@(.12112)=INP(26)
 G:ERR EXIT  ;alb/sat 658
 ;temporary country
 S INP(27)=$G(INP(27))
 I INP(27)'="" D
 .I INP(27)'="@",'$D(^HL(779.004,INP(27),0)) S @SDECY@(1)="-1^Invalid temporary country ID "_INP(27)_"."_$C(30,31),ERR=1 Q  ;alb/jsm 658
 .S @SDFDA@(.1223)=INP(27)
 G:ERR EXIT  ;alb/sat 658
 ;temporary county
 S INP(28)=$G(INP(28))
 I INP(28)'="" D
 .I INP(28)'="@" D  ;alb/jsm 658
 ..N X,Z0
 ..S Z0=$S(INP(24)'="":INP(24),$D(^DPT(DFN,.121)):+$P(^DPT(DFN,.121),"^",5),1:0)
 ..I 'Z0 S @SDECY@(1)="-1^A state must be defined to update the Temporary County."_$C(30,31),ERR=1 Q
 ..I $D(^DIC(5,Z0,1,0)) S DIC="^DIC(5,Z0,1,",DIC(0)="QEM",X=INP(28) D ^DIC S X=+Y I Y'>0 S @SDECY@(1)="-1^Temporary County "_INP(28)_" does not belong to state "_INP(24)_"."_$C(30,31),ERR=1
 ..S INP(28)=X
 .I 'ERR S @SDFDA@(.12111)=INP(28)
 G:ERR EXIT  ;alb/sat 658
 ;temporary phone
 S INP(29)=$G(INP(29))
 I INP(29)'="" D
 .I INP(29)'="@" D
 ..I $L(INP(29))>20!($L(INP(29))<4) S @SDECY@(1)="-1^Temporary Phone must be 4-20 characters. "_INP(29)_$C(30,31),ERR=1 Q
 ..;I 'ERR N CTR,CHR,VAR S VAR=INP(29) F CTR=1:1:20 S CHR=$E(VAR,CTR) I ("1234567890 -()."'[CHR) S ERR=1
 ..;I ERR S @SDECY@(1)="-1^Invalid Temporary Phone Number "_INP(29)_$C(30,31),ERR=1 Q
 .I 'ERR S @SDFDA@(.1219)=INP(29)
 G:ERR EXIT  ;alb/sat 658
 ;temporary address start date
 S INP(30)=$G(INP(30))
 I INP(30)'="" D
 .I INP(30)'="@" D
 ..N X
 ..S %DT="E",X=INP(30) D ^%DT I Y<1 S @SDECY@(1)="-1^Invalid Temporary Address Start Date "_INP(30)_$C(30,31),ERR=1 Q
 ..S (INP(30),X)=Y
 ..I INP(30)'="@",INP(19)'="Y",$S(INP(19)="N":1,'$D(^DPT(DFN,.121)):1,$P(^(.121),U,9)'="Y":1,1:0) S (X,INP(30))=""  ; S @SDECY@(1)="-1^Requirement for Temporary Address data not indicated...NO EDITING!",ERR=1 Q
 .I 'ERR,INP(30)'="" S @SDFDA@(.1217)=INP(30)
 G:ERR EXIT  ;alb/sat 658
 ;temporary address end date
 S INP(31)=$G(INP(31))
 I INP(31)'="" D
 .I INP(31)'="@" D
 ..N X
 ..S %DT="E",X=INP(31) D ^%DT I Y<1 S @SDECY@(1)="-1^Invalid Temporary Address End Date "_INP(31)_$C(30,31),ERR=1 Q
 ..S (INP(31),X)=Y
 ..I INP(31)'="@",INP(19)'="Y",$S(INP(19)="N":1,'$D(^DPT(DFN,.121)):1,$P(^(.121),U,9)'="Y":1,1:0) S (X,INP(31))=""  ; S @SDECY@(1)="-1^Requirement for Temporary Address data not indicated...NO EDITING!",ERR=1 Q
 .I 'ERR,INP(31)'="" S @SDFDA@(.1218)=INP(31)
 G:ERR EXIT  ;alb/sat 658
 ;
 I $D(@SDFDA) D UPDATE^DIE("","SDFDA")
 I $D(SDMSG) D ERR1^SDECERR(-1,"Error storing data.",SDECI,SDECY) Q
 ;RACE
 S RACEN=$G(INP(2))
 I RACEN'="" D
 .S RACEN1="" F SDI=1:1:$L(RACEN,"|") D
 ..S SDIN=$P(RACEN,"|",SDI)
 ..I $E(SDIN)="@" D  Q
 ...S SDIN=$E(SDIN,2,$L(SDIN))
 ...S RACE=$O(^DPT(DFN,.02,"B",$P(SDIN,";;"),0))
 ...I RACE D
 ....S DIK="^DPT("_DFN_",.02,"
 ....S DA=RACE,DA(1)=DFN
 ....D ^DIK
 ..I $D(^DIC(10,+$P(SDIN,";;"),0)) D
 ...I $P(SDIN,";;",2)'="",$D(^DIC(10.3,+$P(SDIN,";;",2),0)) S RACEN1=$S(RACEN1'="":RACEN1_"|",1:"")_SDIN
 ...I $P(SDIN,";;",2)="" S RACEN1=$S(RACEN1'="":RACEN1_"|",1:"")_SDIN
 .S RACEN=RACEN1
 .I RACEN'="" F SDI=1:1:$L(RACEN,"|") D
 ..K SDFDA
 ..S SDIN=$P(RACEN,"|",SDI)
 ..S RACE=$O(^DPT(DFN,.02,"B",$P(SDIN,";;"),0))
 ..S RACE=$S(RACE'="":RACE,1:"+1")
 ..S SDFDA="SDFDA(2.02,"_$S(RACE'="":RACE_""",""",1:"""+1")_""","_DFN_",)"
 ..S SDFDA=$NA(SDFDA(2.02,RACE_","_DFN_","))
 ..S @SDFDA@(.01)=$P(SDIN,";;")
 ..S:$P(SDIN,";;",2)'="" @SDFDA@(.02)=$P(SDIN,";;",2)
 ..D UPDATE^DIE("","SDFDA")
 ;ethnicity
 S ETHN=$G(INP(3))
 I ETHN'="" D
 .S ETHN1="" F SDI=1:1:$L(ETHN,"|") D
 ..S SDIN=$P(ETHN,"|",SDI)
 ..I $E(SDIN)="@" D  Q
 ...S SDIN=$O(^DPT(DFN,.06,"B",""))
 ...S ETH=$O(^DPT(DFN,.06,"B",SDIN,0))
 ...I ETH D
 ....S DIK="^DPT("_DFN_",.06,"
 ....S DA=ETH,DA(1)=DFN
 ....D ^DIK
 ..I $D(^DIC(10.2,+$P(SDIN,";;",1),0)) D
 ...I $P(SDIN,";;",2)'="",$D(^DIC(10.3,+$P(SDIN,";;",2),0)) S ETHN1=$S(ETHN1'="":ETHN1_"|",1:"")_SDIN
 ...I $P(SDIN,";;",2)="" S ETHN1=$S(ETHN1'="":ETHN1_"|",1:"")_SDIN
 .S ETHN=ETHN1
 .I ETHN'="" F SDI=1:1:$L(ETHN,"|") D
 ..K SDFDA
 ..S SDIN=$P(ETHN,"|",SDI)
 ..S ETH=$O(^DPT(DFN,.06,"B",$P(SDIN,";;",1),0))
 ..S ETH=$S(ETH'="":ETH,1:"+1")
 ..S SDFDA="SDFDA(2.06,"_$S(ETH'="":ETH_""",""",1:"""+1")_""","_DFN_",)"
 ..S SDFDA=$NA(SDFDA(2.06,ETH_","_DFN_","))
 ..S @SDFDA@(.01)=$P(SDIN,";;",1)
 ..S:$P(SDIN,";;",2)'="" @SDFDA@(.02)=$P(SDIN,";;",2)
 ..D UPDATE^DIE("","SDFDA")
 S SDECI=SDECI+1 S @SDECY@(SDECI)="0^"_$C(30,31)
EXIT  ;unlock exit  ;alb/sat 658
 L -^TMP(DFN,"REGISTRATION IN PROGRESS")
 L -^DPT(DFN)
XIT  ;alb/sat 658 - exit tag added
 Q
