YTQAPI7 ;ALB/ASF- MHAX ANSWERS ; 5/24/07 10:12am
 ;;5.01;MENTAL HEALTH;**85,129,141**;Dec 30, 1994;Build 85
 Q
KEY(YSDATA,YS) ;get all keys for a test
 ; input: CODE as TEST name
 ; output:SCALE=ScaleName^scale Id
 ;        KEY=Question ID^Target^Value^Key Ien
 N G,YSKEYI,YSCODE,I,N,YSCALEI,YSCNAME,YSCODEN,YSQN,YSTARG,YSVAL
 K ^TMP($J,"YSKEY") S YSDATA=$NA(^TMP($J,"YSKEY"))
 S YSCODE=$G(YS("CODE")) S:YSCODE="" YSCODE=0
 I '$D(^YTT(601.71,"B",YSCODE)) S ^TMP($J,"YSKEY",1)="[ERROR]",^TMP($J,"YSKEY",2)="no ins" Q  ;-->out
 S YSCODEN=$O(^YTT(601.71,"B",YSCODE,0))
 I '$D(^YTT(601.86,"AC",YSCODEN)) S ^TMP($J,"YSKEY",1)="[ERROR]",^TMP($J,"YSKEY",2)="no scale grps found" Q  ;-->out
 D SCALEG^YTQAPI3(.YSDATA,.YS)
 S YSDATA=$NA(^TMP($J,"YSKEY"))
 S ^TMP($J,"YSKEY",1)="[DATA]",N=1
 F I=2:1 Q:'$D(^TMP($J,"YSG",I))  I ^TMP($J,"YSG",I)?1"Scale".E D
 . S YSCALEI=$P(^TMP($J,"YSG",I),U),YSCALEI=$P(YSCALEI,"=",2),YSCNAME=$P(^TMP($J,"YSG",I),U,4)
 . S N=N+1,^TMP($J,"YSKEY",N)="SCALE="_YSCNAME_U_YSCALEI_U
 . S YSKEYI=0 F  S YSKEYI=$O(^YTT(601.91,"AC",YSCALEI,YSKEYI)) Q:YSKEYI'>0  D
 .. S G=^YTT(601.91,YSKEYI,0)
 .. S YSQN=$P(G,U,3),YSTARG=$P(G,U,4),YSVAL=$P(G,U,5)
 .. S N=N+1
 .. S ^TMP($J,"YSKEY",N)="KEY="_YSQN_U_YSTARG_U_YSVAL_U_YSKEYI
 Q
ANSLIST(YSDATA,YS) ;simple answer list
 N D1,N1,YSQ,YSAI,G
 S YSAI=$G(YS("IEN")) I YSAI'?1N.N S YSDATA(1)="[ERROR]",YSDATA(2)="bad admin ien" Q  ;-->out
 S N=1,YSQ=0
 F  S YSQ=$O(^YTT(601.85,"AC",YSAI,YSQ)) Q:YSQ'>0  S DA=0 F  S DA=$O(^YTT(601.85,"AC",YSAI,YSQ,DA)) Q:DA'>0  D
 . S D1=0,N1=0,G=$G(^YTT(601.85,DA,0))
 . F  S D1=$O(^YTT(601.85,DA,1,D1)) Q:D1'>0  D
 .. S N=N+1,N1=N1+1
 .. S YSDATA(N)=$P(G,U,3)_";"_N1_U_$G(^YTT(601.85,DA,1,D1,0))
 Q
VERSRV(YSDATA,YS) ; Return server version stored in YS BROKER1
 ; input: YSB as option name
 ; output: 2:MHA3 version number
 ;         3: CR DLL VERSION
 ;         4:mh DLL VERSION
 N YSLST,YSB,YSVAL
 S YSB=$G(YS("YSB"))
 I YSB="" S YSDATA(1)="[ERROR]",YSDATA(2)="no opt" Q
 D FIND^DIC(19,"",1,"X",YSB,1,,,,"YSLST")
 I 'YSLST("DILIST",0) S YSDATA(1)="[ERROR]",YSDATA(2)="no version found" Q
 S YSVAL=YSLST("DILIST","ID",1,1)
 S YSVAL=$P(YSVAL,"version ",2)
 S YSDATA(1)="[DATA]"
 S YSDATA(2)=$P(YSVAL,"~",1)
 S YSDATA(3)=$P(YSVAL,"~",2)
 S YSDATA(4)=$P(YSVAL,"~",3)
 S YSDATA(5)=$$GET^XPAR("ALL","YS MHA_AUX DLL LOCATION")
 S YSDATA(6)=$$GET^XPAR("ALL","YS MHA SECURE DESKTOP DISABLE")
 ; I $$GET^XPAR("ALL","YSMOCA ATTESTATION ENABLED") D
 I $$NOW^XLFDT>$$GET^XPAR("SYS","YSMOCA ATTESTATION DATE") D
 . N I,X,YSMSG
 . D GETWP^XPAR(.YSMSG,"ALL","YSMOCA MESSAGE")
 . S I=0,X="" F  S I=$O(YSMSG(I)) Q:'I  S X=X_YSMSG(I,0)
 . S YSDATA(7)=X
 Q
UPDVER(WHICH,VER) ; update MHA version number in broker option
 ; WHICH: 1=server, 2="A" DLL, 3=MHA exe
 ; VER: version string for WHICH component
 N OPT,TXT,VERPART,FDA,DIERR
 S OPT=$$FIND1^DIC(19,"","X","YS BROKER1","B")
 I 'OPT D BMES^XPDUTL("ERROR: YS BROKER1 not found on this system.") QUIT
 I $D(DIERR) D BMES^XPDUTL("ERROR: "_$G(^TMP("DIERR",$J,1,"TEXT",1))) QUIT
 S TXT=$$GET1^DIQ(19,OPT_",",1),VERPART=$P(TXT,"version ",2)
 S $P(VERPART,"~",WHICH)=VER,$P(TXT,"version ",2)=VERPART
 S FDA(19,OPT_",",1)=TXT
 D FILE^DIE("","FDA")
 I $D(DIERR) D BMES^XPDUTL("ERROR: "_$G(^TMP("DIERR",$J,1,"TEXT",1)))
 D CLEAN^DILF
 Q
RULEDEL(YSDATA,YS) ; deletes a rule and all associated skips and instrument rules
 ;Input IEN as ien of file 601.82
 ;Output Data vs Error
 N YSRULE,YSIEN,DA,DIK
 S YSRULE=$G(YS("IEN"),-1)
 I '$D(^YTT(601.82,YSRULE)) S YSDATA(1)="[ERROR]",YSDATA(2)="bad rule id" Q  ;--> out
 ;delete rule
 S DA=YSRULE,DIK="^YTT(601.82," D ^DIK
 ;delete instrument rules
 S YSIEN=0 F  S YSIEN=$O(^YTT(601.83,"AC",YSRULE,YSIEN)) Q:YSIEN'>0  S DA=YSIEN,DIK="^YTT(601.83," D ^DIK
 ;delete skips
 S YSIEN=0 F  S YSIEN=$O(^YTT(601.79,"AE",YSRULE,YSIEN)) Q:YSIEN'>0  S DA=YSIEN,DIK="^YTT(601.79," D ^DIK
 S YSDATA(1)="[DATA]",YSDATA(2)="ok deleted"
 Q
BATDEL(YSDATA,YS) ;deletes a battery and associated users and content
 ;Input IEN as ien of file 601.77
 ;Output Data vs Error
 N YSBAT,YSIEN,DA,DIK
 S YSBAT=$G(YS("IEN"),-1)
 I '$D(^YTT(601.77,YSBAT)) S YSDATA(1)="[ERROR]",YSDATA(2)="bad BATTERY id" Q  ;--> out
 ;delete battery
 S DA=YSBAT,DIK="^YTT(601.77," D ^DIK
 ;delete battery Content
 S YSIEN=0 F  S YSIEN=$O(^YTT(601.78,"AD",YSBAT,YSIEN)) Q:YSIEN'>0  S DA=YSIEN,DIK="^YTT(601.78," D ^DIK
 ;delete batt Users
 S YSIEN=0 F  S YSIEN=$O(^YTT(601.781,"AD",YSBAT,YSIEN)) Q:YSIEN'>0  S DA=YSIEN,DIK="^YTT(601.781," D ^DIK
 S YSDATA(1)="[DATA]",YSDATA(2)="ok batt deleted"
 Q
SNDBUL(YSDATA,YS) ;send message to psych test ordering clinician
 ;Input: DFN as patient ien
 ;     : ORD as ordered for (in duz form)
 ;     : TEST1 as name of test ordered (required;string)
 ;     : TEST2-TEST10 as name of other tests ordered (optional but in order;string)
 ;Output: [DATA] VS [ERROR]
 N I,XMB,XMDUZ,XMY,X,DIC,YSORD,YSDFN,Y,YSDT
 S YSDFN=$G(YS("DFN")) I YSDFN="" S YSDATA(1)="[ERROR]",YSDATA(2)="NO DFN" Q  ;--> out
 S YSORD=$G(YS("ORD")) I YSORD="" S YSDATA(1)="[ERROR]",YSDATA(2)="NO ORD" Q  ;--> out
 F I=6:1:15 S XMB(I)=$G(YS("TEST"_(I-5)))
 I XMB(6)="" S YSDATA(1)="[ERROR]",YSDATA(2)="no tests" Q  ;--> out
 S Y=DT X ^DD("DD") S YSDT(1)=Y
 ;as in ENBUL^YSUTL
 S DIC=3.8,DIC(0)="MZ",X="YS PSYCHTEST" D ^DIC
 I Y'>0 S YSDATA(1)="[ERROR]",YSDATA(2)="no YS bulletin" Q  ;-->out
 S XMB="YS PSYCHTEST",XMB(1)=$P(^DPT(YSDFN,0),U),XMB(2)=$P(^VA(200,DUZ,0),U),XMB(3)=YSDT(1) S XMB(4)="" S:YSORD]"" XMB(4)=$P(^VA(200,YSORD,0),U),XMY(YSORD)="" S XMDUZ=DUZ D EN^XMB
 S YSDATA(1)="[DATA]",YSDATA(2)="OK"
