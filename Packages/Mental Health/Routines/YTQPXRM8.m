YTQPXRM8 ;ALB/ASF - PSYCH TEST API FOR CLINICAL REMINDERS ; 8/27/08 3:39pm
 ;;5.01;MENTAL HEALTH;**98,123**;Dec 30, 1994;Build 72
 Q
SETSCR(YSDATA,YS) ;save  scratch CR
 ;input: DFN = Patient ien
 ;input: CODE= Test NAME from 601.71
 ;input: HANDLE= identifer for cprs GIU
 ;input: YS(1) thru YS(N) WP entries as
 ; QuestionID^AnswerID^LegacyValue^IsMultipleChoice
 ;output: [DATA] vs [ERROR]
 N YSHANDLE,YSDFN,YSTN,YSNOW,YSCODE,YSIEN,N,N2,N3,X,Y,%
 S YSDATA(1)="[ERROR]",YSDATA(2)=U_U_YS("CODE")
 S YSHANDLE=$G(YS("HANDLE"),0)
 S YSDFN=$G(YS("DFN"))
 S YSCODE=$G(YS("CODE"),0)
 S YSTN=$O(^YTT(601.71,"B",YSCODE,0))
 I YSDFN'?1N.N S YSDATA(2)="bad DFN setscr" Q  ;-->out
 I YSTN'?1N.N S YSDATA(2)="bad test num setcr" Q  ;-->out
 D NOW^%DTC S YSNOW=%
 S N=0
 F  S N=N+1 Q:'$D(YS(N))  D
 .S YSIEN=$$NEW^YTQLIB(601.94)
 .L +^YTT(601.94,YSIEN):10
 .S ^YTT(601.94,YSIEN,0)=YSIEN_U_YSDFN_U_YSNOW_U_YSTN_U_YS(N)_DUZ
 .S:YSHANDLE'=0 ^YTT(601.94,YSIEN,2)=YSHANDLE
 .S ^YTT(601.94,0)=$P(^YTT(601.94,0),U,1,2)_U_YSIEN_U_($P(^YTT(601.94,0),U,4)+1)
 .S ^YTT(601.94,"B",YSIEN,YSIEN)=""
 .S ^YTT(601.94,"AF",DUZ,YSDFN,YSTN,YSHANDLE,YSIEN)=""
 .S ^YTT(601.94,"AD",YSNOW,YSIEN)=""
 .S ^YTT(601.94,"AE",YSHANDLE,YSIEN)=""
 .;answer wp
 .S N2=N,N3=0 F  S N2=$O(YS(N2)) Q:(N2=(N+1))!(N2'>0)  S N3=N3+1,^YTT(601.94,YSIEN,1,N3,0)=YS(N2)
 .L -^YTT(601.94,YSIEN)
 S YSDATA(1)="[DATA]",YSDATA(2)="OK"
 Q
GETSCR(YSDATA,YS) ;get CR scratch -for a user,patient and instrument
 ; input: DFN as Patient Ien
 ; input: CODE as Instrument name- 601.71
 ; input: HANDLE= identifer for cprs GIU
 ; output: SCRATCH list in format
 ;    QuestionID^AnswerValue^AnswerLegacyValue^IsMultipleChoice^Response Date
 N G,G2,YSQN,YSTN,YSDFN,N,N1,N2,X1,X2,X,YSIEN,YSRDATE,%,YSHANDLE,YSCODE
 K ^TMP($J,"YSSCR") S YSDATA=$NA(^TMP($J,"YSSCR"))
 S ^TMP($J,"YSSCR",1)="[ERROR]"
 S YSDFN=$G(YS("DFN"))
 S YSCODE=$G(YS("CODE"),0)
 S YSHANDLE=$G(YS("HANDLE"),0)
 S YSTN=$O(^YTT(601.71,"B",YSCODE,0))
 I YSDFN'?1N.N S ^TMP($J,"YSSCR",2)="bad ad num getscr" Q  ;-->out
 I YSTN'?1N.N S ^TMP($J,"YSSCR",2)="bad test num getscr" Q  ;-->out
 D NOW^%DTC S X=%
 D H^%DTC S X1=%H*86400+%T
 S YSIEN=0,N1=1
 F  S YSIEN=$O(^YTT(601.94,"AE",YSHANDLE,YSIEN)) Q:YSIEN'>0  D
 . S G=$G(^YTT(601.94,YSIEN,0))
 . Q:($P(G,U,2)'=YSDFN)  ;--> out wrong patient
 . Q:($P(G,U,9)'=DUZ)  ;--> out wrong user
 . Q:($P(G,U,4)'=YSTN)  ;--> out wrong test
 . S X=$P(G,U,3)
 . D H^%DTC S X2=%H*86400+%T
 . Q:((X1-X2)>86400)  ;-->out too old
 . S G2=$G(^YTT(601.94,YSIEN,2))
 . S YSQN=$P(G,U,5)
 . S N1=N1+1
 . S ^TMP($J,"YSSCR",N1)=$P(G,U,5,8)_U_$P(G,U,3)
 . S N2=0 F  S N2=$O(^YTT(601.94,YSIEN,1,N2)) Q:N2'>0  D
 .. S N1=N1+1
 .. S ^TMP($J,"YSSCR",N1)=YSQN_U_$G(^YTT(601.94,YSIEN,1,N2,0))
 S ^TMP($J,"YSSCR",1)="[DATA]"
 S:'$D(^TMP($J,"YSSCR",2)) ^TMP($J,"YSSCR",2)="ok-none found!"
 Q
KILLSCR(YSDATA,YS) ;delete scratch data
 ;input: DFN = Patient ien
 ;input: CODE= Test name from 601.71
 ;input: HANDLE= identifer for cprs GIU
 ;output: [DATA] vs [ERROR]
 N YSDFN,YSTN,YSIEN,DA,YSRDATE,N,DIK
 S YSDATA(1)="[ERROR]"
 S YSDFN=$G(YS("DFN"))
 I YSDFN'?1N.N S YSDATA(2)="bad DFN killscr" Q  ;-->out
 S YSHANDLE=$G(YS("HANDLE"),0)
 S YSCODE=$G(YS("CODE"),0)
 I YSCODE=0 D MULTT Q  ;-->out ASF 8/27/08
 S YSTN=$O(^YTT(601.71,"B",YSCODE,0))
 I YSTN'?1N.N S YSDATA(2)="bad test num killscr" Q  ;-->out
 S YSIEN=0
 F  S YSIEN=$O(^YTT(601.94,"AF",DUZ,YSDFN,YSTN,YSHANDLE,YSIEN)) Q:YSIEN'>0  D
 . S DA=YSIEN,DIK="^YTT(601.94," D ^DIK
 S YSDATA(1)="[DATA]"
 Q
MULTT ;multiple test remover
 S YSTN=0 F  S YSTN=$O(^YTT(601.94,"AF",DUZ,YSDFN,YSTN)) Q:YSTN'>0  D
 . S YSIEN=0
 . F  S YSIEN=$O(^YTT(601.94,"AF",DUZ,YSDFN,YSTN,YSHANDLE,YSIEN)) Q:YSIEN'>0  S DA=YSIEN,DIK="^YTT(601.94," D ^DIK
 S YSDATA(1)="[DATA]"
 Q
OLDKILL ;clean up scratch file
 N X1,X2,X,DA,DIK,YSWHEN,YSOUT
 S X1=DT,X2=-2 D C^%DTC
 S YSOUT=X
 S DIK="^YTT(601.94,"
 S YSWHEN=0 F  S YSWHEN=$O(^YTT(601.94,"AD",YSWHEN)) Q:YSWHEN'>0!(YSWHEN>YSOUT)  D
 . S DA=0 F  S DA=$O(^YTT(601.94,"AD",YSWHEN,DA)) Q:DA'>0  D ^DIK
 Q
 ;
GETTSC(YSCRA,YS) ;patch 123, calculate Scale scores from Scratch Global
 ; input: DFN as Patient Ien
 ; input: CODE as Instrument name- 601.71
 ; input: HANDLE= identifer for cprs GIU
 ; output: Temp SCALE SCORES in format: '*' + Scale IEN + '~' + Scale Score
 N YSKEYI,YSQN,YSTN,YSDFN,YSIEN,YSTARG,YSVAL,YSRTN71,YSHANDLE,YSCODE,YSRAW,YSCH,YSCH1
 N ARR,FAIL,G,SCA,SCARR,STR,N,N1,N2,X1,X2,X,%
 S YSDFN=$G(YS("DFN"))
 S YSCODE=$G(YS("CODE"),0)
 S YSHANDLE=$G(YS("HANDLE"),0)
 S YSTN=$O(^YTT(601.71,"B",YSCODE,0))
 S FAIL=0
 K ^TMP($J,"YSSCR")
 S YSCRA=$NA(^TMP($J,"YSSCR"))
 S ^TMP($J,"YSSCR",1)="[ERROR]"
 I YSDFN'?1N.N S ^TMP($J,"YSSCR",2)="bad ad num getscr" Q  ;-->out
 I YSTN'?1N.N S ^TMP($J,"YSSCR",2)="bad test num getscr" Q  ;-->out
 ;map scratch answers to questions, put in ARR
 D MAPSCR I FAIL Q
 ;get scales for instrument
 D SCALEG^YTQAPI3(.YSDATA,.YS)
 ;determine if M scoring routine exists, if yes, score, quit
 S YSRTN71=$$GET1^DIQ(601.71,YSTN_",",92)
 I (YSRTN71'=""),(YSRTN71'="YTSCORE") D CMPLX Q
 ;otherwise scoring keys used to score
 D SETARR(.SCARR,"SIEN")
 S SCA=""
 F  S SCA=$O(SCARR(SCA)) Q:'SCA  S YSRAW="0" D  S SCARR(SCA)=YSRAW
 .S YSKEYI=0 F  S YSKEYI=$O(^YTT(601.91,"AC",SCA,YSKEYI)) Q:YSKEYI'>0  D
 ..S G=^YTT(601.91,YSKEYI,0)
 ..S YSQN=$P(G,U,3),YSTARG=$P(G,U,4),YSVAL=$P(G,U,5)
 ..S YSCH=$G(ARR(YSQN),0)
 ..Q:YSCH'>0
 ..S YSCH1=$G(^YTT(601.75,YSCH,1))
 ..I YSCH1=YSTARG S YSRAW=YSRAW+YSVAL
 I ^TMP($J,"YSSCR",1)'="[DATA]" S ^TMP($J,"YSSCR",2)="Scratch data not found for Scoring Keys!" Q
 S STR="",SCA="",N=1
 F  S SCA=$O(SCARR(SCA)) Q:'SCA  D
 .S N=N+1,^TMP($J,"YSSCR",N)="*"_SCA_"~"_SCARR(SCA)
 Q
 ;
MAPSCR ;
 N NX
 D NOW^%DTC S X=%
 D H^%DTC S X1=%H*86400+%T
 S YSIEN=0
 F  S YSIEN=$O(^YTT(601.94,"AE",YSHANDLE,YSIEN)) Q:YSIEN'>0  D
 .S G=$G(^YTT(601.94,YSIEN,0))
 .Q:($P(G,U,2)'=YSDFN)  ;--> out wrong patient
 .Q:($P(G,U,9)'=DUZ)  ;--> out wrong user
 .Q:($P(G,U,4)'=YSTN)  ;--> out wrong test
 .S X=$P(G,U,3)
 .D H^%DTC S X2=%H*86400+%T
 .Q:((X1-X2)>86400)  ;-->out too old
 .S YSQN=$P(G,U,5)
 .Q:'$D(YSQN)
 .;
 .S ARR(YSQN)=$P(G,U,6)
 .;need to handle questions that are not multiple choice but have integer answeres
 .I ARR(YSQN)="" D
 ..Q:'$$ANSWER(YSQN)  ; make sure Answer is integer value
 ..S NX=0 F  S NX=$O(^YTT(601.94,YSIEN,1,NX)) Q:NX'>0  D
 ...S ANS=^YTT(601.94,YSIEN,1,NX,0)
 ...I ANS?1N.N S ARR(YSQN)=";"_NX_U_ANS
 .;
 I '$D(ARR) S ^TMP($J,"YSSCR",2)="Scratch data not found!",FAIL=1 Q
 S ^TMP($J,"YSSCR",1)="[DATA]"
 Q
 ;
CMPLX ;
 N FAIL,I,QUE,N,SCA,SNM,YS76,YSDATA,YSRTN
 I '$D(ARR) S ^TMP($J,"YSSCR",2)="In Get Temp Score, ARR not built",FAIL=1 Q
 ;loop through ^TMP($J,"YSG" Set up a mapping array
 I '$D(^TMP($J,"YSG")) S ^TMP($J,"YSSCR",2)="In Get Temp Score, No YSG global",FAIL=1 Q
 ;
 D SETARR(.SCARR,"NM")
 S QUE="",N=3
 F  S QUE=$O(ARR(QUE)) Q:'QUE  D
 .S YS76=$O(^YTT(601.76,"AE",QUE,"")) I '$G(YS76) Q
 .I '$D(YSDATA(2)) S $P(YSDATA(2),U,3)=YSCODE
 .S STR=$G(^YTT(601.76,YS76,0))
 .I $G(ARR(QUE)) S ARR(QUE)=U_ARR(QUE)
 .S YSDATA(N)=QUE_U_$P(STR,U,3)_ARR(QUE),N=N+1
 S YSRTN="DLLSTR^"_YSRTN71_"(.YSDATA,.YS,1)"
 D @YSRTN
 I '$D(^TMP($J,"YSCOR")) S ^TMP($J,"YSSCR",2)="Complex scoring failed!" Q
 S N=1
 F I=2:1 Q:'$D(^TMP($J,"YSCOR",I))  D
 .S SCA=^TMP($J,"YSCOR",I)
 .S SNM=$P(SCA,"=",1)
 .I $D(SCARR(SNM)) S N=N+1,^TMP($J,"YSSCR",N)="*"_SCARR(SNM)_"~"_$P(SCA,"=",2)
 K ^TMP($J,"YSG"),^TMP($J,"YSCOR")
 Q
SETARR(SCARR,NODE) ;
 ;set SCARR array to be used in calculating score
 N I,STR1,SCA,SNM,IX,VAL
 F I=2:1 Q:'$D(^TMP($J,"YSG",I))  I ^TMP($J,"YSG",I)?1"Scale".E D
 .S STR1=$G(^TMP($J,"YSG",I)),SCA=$P($P(STR1,"=",2),U),SNM=$P($P(STR1,"=",2),U,4)
 .S IX=$S(NODE="NM":SNM,NODE="SIEN":SCA,1:"ERR")
 .S VAL=$S(NODE="NM":SCA,1:"")
 .S SCARR(IX)=VAL
 Q
ANSWER(YSQN) ;
 N NODE
 S NODE=$$GET1^DIQ(601.72,YSQN_",",3,"I")
 I (NODE=2)!(NODE=7) Q 1
 Q 0
