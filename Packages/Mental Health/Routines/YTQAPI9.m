YTQAPI9 ;ALB/ASF- MHA ENTRIES ; 12/12/09 5:02pm
 ;;5.01;MENTAL HEALTH;**85,96**;Dec 30, 1994;Build 46
 ;Reference to ^DPT( supported by DBIA #10035
 ;Reference to VADPT APIs supported by DBIA #10061
 ;Reference to ^XUSEC( supported by DBIA #10076
 ;Reference to ^XUSRB APIs supported by DBIA #3277
 ;Reference to ^VA(200, supported by DBIA #10060
 ;Reference to VASITE APIs supported by DBIA #10112
 ;Reference to FILE 8925.1 supported by DBIA #5033
 ;Reference to TIUSRVA APIs supported by DBIA #5541
 ;Reference to TIUFLF7 APIs supported by DBIA #5352
 Q
LEGCR(YSDATA,YS) ;score/report for cr dll
 ;input: YS("ADATE")=date of admin
 ;       YS("DFN") as pt ien
 ;       YS("CODE") as test name
 ;       YS("R1") as first 200 legacy codes in a string
 ;       YS("R2") as 201-400
 N DA,DIK,DFN,YSNCODE,YSCODE,YSADATE,YSJ,YSDFN,VA,VADM,YSDT,YSE,YSEND,YSLIMIT,YSN,YSS,YSSCALE,VAERR,Y,R1,R2,R3,N,J,YSAGE,YSDOB,YSG,YSHDR,YSNM,YSSEX,YSSSN,VADM,YSQQ,YSC1
 K ^TMP($J,"YTAPI4")
 D PARSE^YTAPI(.YS)
 I '$D(^DPT(DFN,0)) S YSDATA(1)="[ERROR]",YSDATA(2)="no such pt" Q
 I '$D(^YTT(601,"B",YSCODE)) S YSDATA(1)="[ERROR]",YSDATA(2)="INCORRECT TEST CODE" Q  ;---> bad code
 S YSNCODE=$O(^YTT(601,"B",YSCODE,-1))
 I YSADATE'=DT S YSDATA(1)="[ERROR]",YSDATA(2)="bad date needs DT" Q  ;---> bad date
 L +^YTD(601.2,DFN,1,YSNCODE,1,YSADATE):1 I '$T S YSDATA(1)="[ERROR]",YSDATA(2)="no lock" Q  ;--->
 D:$D(^YTD(601.2,DFN,1,YSNCODE,1,YSADATE)) INTMP ;save old testing for a day
 ;
 D SAVEIT^YTAPI1(.YSDATA,.YS) ; save responses
 ;I YSDATA(1)?1"[ERROR".E L -^YTD(601.2,DFN,1,YSNCODE,1,YSADATE) Q  ;---> bad save
 ;
 S YSCODEN=$O(^YTT(601.71,"B",YSCODE,0))
 D SCALES^YTQPXRM5(.YSQQ,YSCODEN)
 S N2=0 F  S N2=$O(YSQQ("S",N2)) Q:N2'>0  D
 . S YSCALE1=YSQQ("S",N2)
 . S YSC1($$UCASE^YTQPXRM6(YSCALE1),N2)=""
 K YSQQ
 ;D SCOREIT^YTAPI2(.YSDATA,.YS)
 D SCOREIT^YTQAPI14(.YSDATA,.YS)
 ;scale listing
 S N2=5 F  S N2=$O(YSDATA(N2)) Q:N2'>0  D
 . S YSG1=YSDATA(N2),YSCALE1=$P(YSG1,U,2),YSRT=$P(YSG1,U,3,4)
 . S YSRTI=$O(YSC1($$UCASE^YTQPXRM6(YSCALE1),0))
 . S:YSRTI'="" YSDATA(N2)=$P(YSG1,U)_U_YSCALE1_U_YSRTI_U_YSRT
 D INTRMNT^YTRPWRP(.YSDATA,DFN,YSADATE_","_YSNCODE)
 D DEM^VADPT,PID^VADPT S YSNM=VADM(1),YSSEX=$P(VADM(5),U),YSDOB=$P(VADM(3),U,2),YSAGE=VADM(4),YSSSN=VA("PID")
 S $P(YSHDR," ",60)="",YSHDR=YSSSN_"  "_YSNM_YSHDR,YSHDR=$E(YSHDR,1,44)_YSSEX_" AGE "_YSAGE
AA S YSJ=$O(YSDATA(999),-1)
 S YSDATA(YSJ+1)="^^PROGRESS NOTE^^"
 S N=3,J=1 F  S N=$O(^TMP("YSDATA",$J,1,N)) Q:N'>0  D
 . S YSG=^TMP("YSDATA",$J,1,N)
 . Q:YSG]YSHDR
 . Q:YSG?1"Not valid unless signed: Reviewed by".E
 . Q:YSG?1"Printed by: ".E
 . Q:YSG?." "1"PRINTED    ENTERED"." "
 . Q:YSG?1"Ordered by: ".E
 . S J=J+1,YSDATA(YSJ+J)=YSG
DROP ;kill preview data
 S DIK="^YTD(601.2,DFN,1,YSNCODE,1,",DA=YSADATE,DA(1)=YSNCODE,DA(2)=DFN D ^DIK
 ;
 D:$D(^TMP($J,"YTAPI4")) OUTTMP ;place back old testing
 S DIK="^YTD(601.2,",DA=DFN D IX^DIK ; reindex
 L -^YTD(601.2,DFN,1,YSNCODE,1,YSADATE)
 K YSQQ Q
INTMP ; SAVE OLD
 M ^TMP($J,"YTAPI4")=^YTD(601.2,DFN,1,YSNCODE,1,YSADATE)
 Q
OUTTMP ;replace old testing
 M ^YTD(601.2,DFN,1,YSNCODE,1,YSADATE)=^TMP($J,"YTAPI4")
 Q
NATSET(YSDATA,YS) ; set design environment to save fm entries <100,000
 ;input: NATIONAL as Yes or No
 ;output: YSPROG=1
 N Y1
 I '$D(^XUSEC("YSPROG",DUZ)) S YSDATA(1)="[ERROR]",YSDATA(2)="no prog key" Q  ;-->out
 S Y1=$G(YS("NATIONAL"))
 S Y1=$E(Y1,1)
 I (Y1'="Y")&(Y1'="N") S YSDATA(1)="[ERROR]",YSDATA(2)="no/BAD setting"
 S YSDATA(1)="[DATA]"
 I Y1="N" K YSPROG S YSDATA(2)="local editing set"
 I Y1="Y" S YSPROG=1,YSDATA(2)="national editing set"
 Q
PATSEL(YSDATA,YS) ;patient component
 ;input DFN as ien of file 2
 ;output
 ; YSDATA(2)= name
 ; YSDATA(3)=ssn
 ; YSDATA(4)=dob
 ; YSDATA(5)=age
 ; YSDATA(6)=sex
 ; YSDATA(7)=date of death (or 0)
 ; YSDATA(8)=0 NCS/ 1 SC^%^service connected
 N DFN,VADM,VAEL,VAERR
 S DFN=$G(YS("DFN"),-1)
 I '$D(^DPT(DFN,0)) S YSDATA(1)="[ERROR]",YSDATA(2)="bad dfn" Q  ;-->out
 D 2^VADPT
 I VAERR=1 S YSDATA(1)="[ERROR]",YSDATA(2)="vadpt err" Q  ;-->out
 S YSDATA(1)="[DATA]"
 S YSDATA(2)=VADM(1)_U_"name"
 S YSDATA(3)=VADM(2)_U_"ssn"
 S YSDATA(4)=VADM(3)_U_"dob"
 S YSDATA(5)=VADM(4)_U_"age"
 S YSDATA(6)=VADM(5)_U_"sex"
 S YSDATA(7)=+VADM(6)_U_$P(VADM(6),U,2)_U_"date of death"
 S YSDATA(8)=VAEL(3)_U_"service connected"
 Q
USERQ(YSDATA,YS) ;user info
 ;input DUZ as internal ien file 200 for user to check [optional default is current user]
 ;      KEY as name of security key to check [optional]
 ;      TITLE as name of Pnote [optional]
 ;output YSDATA(2)= name of user
 ;       YSDATA(3) if key sent 1^holds VS 0^lacks KEY
 ;       YSDATA(4) site info
 N K,YSKEY,YSDUZ,YSTITLE,DIC,YSCOS,N2,X
 S YSTITLE=$G(YS("TITLE"),-1)
 S YSDUZ=$G(YS("DUZ"),DUZ)
 S YSKEY=$G(YS("KEY"),-1)
 S YSTITLE=$G(YS("TITLE"))
 S YSDATA(1)="[DATA]"
 D OWNSKEY^XUSRB(.K,YSKEY,YSDUZ)
 S YSDATA(2)=$P($G(^VA(200,YSDUZ,0)),U)_U_YSDUZ
 I YSKEY=-1 S YSDATA(3)=""
 E  S YSDATA(3)=$S(K(0):"1^holds ",1:"0^lacks ")_YSKEY
 S YSDATA(4)=$$SITE^VASITE_U_$$NAME^VASITE(DT)
 ;ASF 12/8/2009
 I YSTITLE="" S YSDATA(5)="^no title sent" Q  ;-->out
 S Y=+$$DDEFIEN^TIUFLF7(YSTITLE,"TL")
 I +Y'>0 S YSDATA(5)="^bad pnote title" Q  ;-->out
 D REQCOS^TIUSRVA(.YSCOS,+Y,"",YSDUZ) ;is cosigner required
 S YSDATA(5)=YSCOS_U_"cosigner "_$S(YSCOS=1:"required",YSCOS=0:"not required",1:"error")
 Q
MHREPORT(YSDATA,YS) ;gets a report format from 601.93
 ;Input: CODE as instrument name
 ;Output: LINE# ^ line text
 N N,N1,YSIENS,YSCODE,YSCODEN,YSIENS
 K ^TMP("YSDATA",$J) S YSDATA=$NA(^TMP("YSDATA",$J))
 S ^TMP("YSDATA",$J,1)="[ERROR]"
 S YSCODE=$G(YS("CODE"),0)
 I '$D(^YTT(601.71,"B",YSCODE)) S ^TMP("YSDATA",$J,2)="bad code" Q  ;-->out
 S YSCODEN=$O(^YTT(601.71,"B",YSCODE,-1))
 S YSIENS=$O(^YTT(601.93,"C",YSCODEN,-1))
 I YSIENS'>0 S ^TMP("YSDATA",$J,1)="[DATA]^0" Q  ;--> out
 S N=1,N1=0 F  S N1=$O(^YTT(601.93,YSIENS,1,N1)) Q:N1'>0  D
 . S N=N+1,^TMP("YSDATA",$J,N)=$G(^YTT(601.93,YSIENS,1,N1,0))
 S ^TMP("YSDATA",$J,1)="[DATA]"_U_YSIENS
 Q
