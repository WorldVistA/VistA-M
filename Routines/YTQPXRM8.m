YTQPXRM8 ;ALB/ASF- PSYCH TEST API FOR CLINICAL REMINDERS ; 8/27/08 3:39pm
 ;;5.01;MENTAL HEALTH;**98**;Dec 30, 1994;Build 11
 Q
SETSCR(YSDATA,YS) ;save  scratch CR
 ;input: DFN = Patient ien
 ;input: CODE= Test NAME from 601.71
 ;input: HANDLE= identifer for cprs GIU
 ;input: YS(1) thru YS(N) WP entries as
 ; QuestionID^AnswerID^LegacyValue^IsMultipleChoice
 ;output: [DATA] vs [ERROR]
 N YSHANDLE,YSDFN,YSTN,YSNOW,YSCODE,YSIEN,N,N2,N3,X,Y,%
 S YSDATA(1)="[ERROR]"
 S YSHANDLE=$G(YS("HANDLE"),0)
 S YSDFN=$G(YS("DFN"))
 S YSCODE=$G(YS("CODE"),0)
 S YSTN=$O(^YTT(601.71,"B",YSCODE,0))
 I YSDFN'?1N.N S YSDATA(2)="bad DFN setscr" Q  ;-->out
 I YSTN'?1N.N S YSDATA(2)="bad test num setcr" Q  ;-->out
 D NOW^%DTC S YSNOW=%
 S N=0
 F  S N=N+1 Q:'$D(YS(N))  D
 . S YSIEN=$$NEW^YTQLIB(601.94)
 . L +^YTT(601.94,YSIEN):10
 . S ^YTT(601.94,YSIEN,0)=YSIEN_U_YSDFN_U_YSNOW_U_YSTN_U_YS(N)_DUZ
 . S:YSHANDLE'=0 ^YTT(601.94,YSIEN,2)=YSHANDLE
 . S ^YTT(601.94,0)=$P(^YTT(601.94,0),U,1,2)_U_YSIEN_U_($P(^YTT(601.94,0),U,4)+1)
 . S ^YTT(601.94,"B",YSIEN,YSIEN)=""
 . S ^YTT(601.94,"AF",DUZ,YSDFN,YSTN,YSHANDLE,YSIEN)=""
 . S ^YTT(601.94,"AD",YSNOW,YSIEN)=""
 . S ^YTT(601.94,"AE",YSHANDLE,YSIEN)=""
 . ;answer wp
 . S N2=N,N3=0 F  S N2=$O(YS(N2)) Q:(N2=(N+1))!(N2'>0)  S N3=N3+1,^YTT(601.94,YSIEN,1,N3,0)=YS(N2)
 . L -^YTT(601.94,YSIEN)
 S YSDATA(1)="[DATA]",YSDATA(2)="OK"
 Q
GETSCR(YSDATA,YS) ;get CR scratch -for a user,patient and instrument
 ; input: DFN as Patient Ien
 ; input: CODE as Instrument name- 601.71
 ; input: HANDLE= identifer for cprs GIU
 ; output: SCRATCH list in format
 ;    QuestionID^AnswerValue^AnswerLegacyValue^IsMultipleChoice^Response Date
 N G,G2,YSQN,YSTN,YSDFN,N,N1,N2,X1,X2,X,YSIEN,YSRDATE,%,YSHANDLE
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
