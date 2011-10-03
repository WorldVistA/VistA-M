SCRPW3 ;RENO/KEITH - Clinic Utilization Statistical Summary (cont.) ; 14 May 99 10:45 PM
 ;;5.3;Scheduling;**139,144,184,194,540,562**;AUG 13, 1993;Build 7
START ;Print statistics
 F  S SDCLN=$O(^TMP("SCRPW",$J,SDIV,1,SDCLN)) Q:SDCLN=""!SDOUT  S SDCL=0 F  S SDCL=$O(^TMP("SCRPW",$J,SDIV,1,SDCLN,SDCL)) Q:'SDCL!SDOUT  D CLINE
 Q:SDOUT  D:$Y>(IOSL-12) FOOT^SCRPW2,HDR^SCRPW2 Q:SDOUT  W ! F SDI=1:1:8 W ?(22+(SDI*10)),"--------"
 W ?112,"---------  ---------",!,"*** CLINIC TOTALS ***" S SDCT=SDTAP_U_SDTOB_U_SDTSL_U_SDTNS_U_SDTVSL_U_SDTNSVS_U_SDTOS
 D F1 D FOOT^SCRPW2 Q:'$D(^TMP("SCRPW",$J,SDIV,2))
 D HDR^SCRPW2 Q:SDOUT  W !!,"*** PROVIDER SUMMARY (based on clinic default provider definition) ***"
 S SDPRN="" F  S SDPRN=$O(^TMP("SCRPW",$J,SDIV,2,SDPRN)) Q:SDPRN=""!SDOUT  S SDPR=0 F  S SDPR=$O(^TMP("SCRPW",$J,SDIV,2,SDPRN,SDPR)) Q:'SDPR!SDOUT  D PLINE
 Q:SDOUT  D FOOT^SCRPW2
 Q
 ;
STOP ;Check for stop task request
 S:$G(ZTQUEUED) (SDOUT,ZTSTOP)=$S($$S^%ZTLOAD:1,1:0)
 Q
 ;
AC ;Evaluate all clinics
 S SDCL=0 F  S SDCL=$O(^SC(SDCL)) Q:'SDCL  S SDCL0=^SC(SDCL,0),SDIV=$P(SDCL0,U,15),SDAC=0 I $$DIV() D STOP Q:SDOUT  D A1 D:SDAC CNT,SET
 Q
 ;
A1 Q:$P(SDCL0,U,3)'="C"  S SDCLI=$G(^SC(SDCL,"I")) Q:(($P(SDCLI,U)>0)&($P(SDCLI,U)<SDBDAY)&($P(SDCLI,U,2)=""!($P(SDCLI,U,2)>SDEDAY)))  S SDAC=1
 Q
 ;
SC ;Evaluate selected clinics
 S SDCL=0 F  S SDCL=$O(SDCL(SDCL)) Q:'SDCL  S SDCL0=^SC(SDCL,0),SDIV=$P(SDCL0,U,15),SDAC=0 I $$DIV() D STOP Q:SDOUT  D A1 D:SDAC CNT,SET
 Q
 ;
RC ;Evaluate a range of clinics
 S SDCLN=$O(SDCL("")),SDECL=$O(SDCL(SDCLN)),SDCL=SDCL(SDCLN),SDCL0=^SC(SDCL,0),SDIV=$P(SDCL0,U,15),SDAC=0 I $$DIV() D STOP Q:SDOUT  D A1 D:SDAC CNT,SET
 F  S SDCLN=$O(^SC("B",SDCLN)) Q:(SDCLN=""!(SDCLN]SDECL))  S SDCL=0 F  S SDCL=$O(^SC("B",SDCLN,SDCL)) Q:'SDCL  S SDCL0=^SC(SDCL,0),SDIV=$P(SDCL0,U,15),SDAC=0 I $$DIV() D STOP Q:SDOUT  D A1 D:SDAC CNT,SET
 Q
 ;
RS ;Evaluate a range of stop codes
 S SDBCS=$O(SDCL("")),SDECS=$O(SDCL(SDBCS)),SDCL=0 S:'SDECS SDECS=SDBCS F  S SDCL=$O(^SC(SDCL)) Q:'SDCL  S SDCL0=^SC(SDCL,0),SDIV=$P(SDCL0,U,15),SDAC=0 I $$DIV() D STOP Q:SDOUT  D A1 D:SDAC RC1
 Q
 ;
RC1 S SDCSC=$P(SDCL0,U,7),SDCSC=$P($G(^DIC(40.7,+SDCSC,0)),U,2) Q:('SDCSC!(SDCSC<SDBCS!(SDCSC>SDECS)))  D CNT,SET
 Q
 ;
CG ;Evaluate by clinic group
 S SDCG=$O(SDCL(0)),SDCL=0 F  S SDCL=$O(^SC("ASCRPW",SDCG,SDCL)) Q:'SDCL  S SDCL0=^SC(SDCL,0),SDIV=$P(SDCL0,U,15),SDAC=0 I $$DIV() D STOP Q:SDOUT  D A1 D:SDAC CNT,SET
 Q
 ;
DIV() ;Check division
 S:'$L(SDIV) SDIV=$$PRIM^VASITE()
 Q:'SDDIV 1  Q $D(SDDIV(+SDIV))
 ;
CNT ;Evaluate a clinic
 S SDDAY=SDBDAY-1,(SDVSL,SDAP,SDF1,SDOB,SDSL,SDNS,SDNSVS,SDOS)=0,SDLAP=$P($G(^SC(SDCL,"SL")),U)
 D SPAT(SDCL,SDBDAY,SDMAX),CCPAT S SDOB=SDAP-SDSL S:SDOB<0 SDOB=0
 Q
 ;
CCPAT ;Count clinic patterns and patients
 F  S SDDAY=$O(^TMP(SDSUB,$J,SDCL,"ST",SDDAY)) Q:('SDDAY!(SDDAY>SDEDAY))  D CTPAT(SDDAY)
 S SDDAY=SDBDAY F  S SDDAY=$O(^SC(SDCL,"S",SDDAY)) Q:('SDDAY!(SDDAY>SDEDAY))  S SDI=0 F  S SDI=$O(^SC(SDCL,"S",SDDAY,1,SDI)) Q:'SDI  S SDCP0=$G(^SC(SDCL,"S",SDDAY,1,SDI,0)) D:$L(SDCP0) ACT
 Q
 ;
CTPAT(SDDAY) ;Count slots in availability pattern and master pattern
 ;Input: SDDAY=date to evaluate
 N SDPATT,SDPCT,SDFLAG,SDHLDPAT  ;SD*562 added last 2 variables
 S SDPATT=$E($G(^TMP(SDSUB,$J,SDCL,"ST",SDDAY,1)),6,999) Q:SDPATT'["["
 S SDFLAG=0 I SDPATT["X" S SDFLAG=1,SDHLDPAT=SDPATT  ;SD*562 check for partial canx
 S SDF1=1,SDOS=SDOS+$$PCT(SDPATT)
 S SDPATT=$E($G(^SC(SDCL,"OST",SDDAY,1)),6,999) I $L(SDPATT) S:SDPATT["X" SDFLAG=1,SDHLDPAT=SDPATT D:SDFLAG ADJUST S SDSL=SDSL+$$PCT(SDPATT) Q   ;SD*562 check for partially cancelled day
 N X,%H,%T,%Y,SDDW,SDMPDT
 S X=SDDAY D H^%DTC S SDDW="T"_%Y,SDMPDT=$O(^SC(SDCL,SDDW,SDDAY))
 I SDMPDT S SDPATT=$G(^SC(SDCL,SDDW,SDMPDT,1)) D:SDFLAG ADJUST S SDPCT=$$PCT(SDPATT) I SDPCT S SDSL=SDSL+SDPCT  ;SD*562 added API ADJUST to calculate clinic capacity for partially cancelled day
 Q
 ;
PCT(SDPATT) ;Pattern count
 ;Input: SDPATT=pattern to evaluate
 N X,I S X=0
 S SDPATT=$TR(SDPATT," |[]","")
 F I=1:1:$L(SDPATT) S X=X+$G(SD($E(SDPATT,I)))
 Q X
 ;
ADJUST ;SD*562 calculate clinic capacity for partially cancelled day
 ;SDHLDPAT equals updated pattern from "ST" node
 ;SDPATT equals Master Pattern for day
 S SDUP="",SDUP=SDHLDPAT,CT=0
 S SDUP=$TR(SDUP," |[]","")
 F I=1:1:$L(SDUP) I $E(SDUP,I)'="X" S CT=CT+1
 S SDPATT=$TR(SDPATT," |[]","")
 S SDPATT=$E(SDPATT,1,CT)
 K CT,SDUP,I
 Q
 ;
SET ;Set stats into ^TMP global
 S SDPR=0 I SDF1 S SDPR=$O(^SC("ADPR",SDCL,SDPR)),SDPR=$P($G(^SC(SDCL,"PR",+SDPR,0)),U) I SDPR S SDPRN=$P($G(^VA(200,SDPR,0)),U) S:'$L(SDPRN) SDPR=0
 D SET1(SDIV) D:SDMD SET1(0)
 Q
 ;
SET1(SDIV) S ^TMP("SCRPW",$J,SDIV,1,$P(SDCL0,U),SDCL)=$S('SDF1:"",1:SDAP_U_SDOB_U_SDSL_U_SDNS_U_SDVSL_U_SDNSVS_U_SDOS)
 Q:'SDPR  S SDPCT=$G(^TMP("SCRPW",$J,SDIV,2,SDPRN,SDPR))
 S ^TMP("SCRPW",$J,SDIV,2,SDPRN,SDPR)=($P(SDPCT,U)+SDAP)_U_($P(SDPCT,U,2)+SDOB)_U_($P(SDPCT,U,3)+SDSL)_U_($P(SDPCT,U,4)+SDNS)_U_($P(SDPCT,U,5)+SDVSL)_U_($P(SDPCT,U,6)+SDNSVS)_U_($P(SDPCT,U,7)+SDOS)
 Q
 ;
CLINE ;Print a clinic statistics line
 D:$Y>(IOSL-12) FOOT^SCRPW2,HDR^SCRPW2 Q:SDOUT  S SDCT=^TMP("SCRPW",$J,SDIV,1,SDCLN,SDCL) W !!,SDCLN I '$L(SDCT) W "  (No ava. found)" Q
 D F1 S SDTAP=SDTAP+SDAP,SDTOB=SDTOB+SDOB,SDTSL=SDTSL+SDSL,SDTNS=SDTNS+SDNS,SDTVSL=SDTVSL+SDVSL,SDTNSVS=SDTNSVS+SDNSVS,SDTOS=SDTOS+SDOS
 Q
 ;
F1 S SDAP=$P(SDCT,U),SDOB=$P(SDCT,U,2),SDSL=$P(SDCT,U,3),SDNS=$P(SDCT,U,4),SDVSL=$P(SDCT,U,5),SDNSVS=$P(SDCT,U,6),SDOS=$P(SDCT,U,7)
 W ?32,$J(SDAP,8),?42,$J(SDVSL,8),?52,$J(SDNS,8),?62,$J(SDNSVS,8),?72,$J(SDOB,8),?82,$J(SDOS,8),?92,$J((SDSL-SDAP-SDVSL),8)
 S SDCAP=SDSL W ?102,$J(SDCAP,8),?112,$J($S(SDCAP=0:0,1:(SDAP+SDVSL*100)/SDCAP),8,2),"%"
 W ?123,$J($S(SDCAP=0:0,1:((SDAP+SDVSL-SDNS-SDNSVS)*100)/SDCAP),8,2),"%"
 Q
 ;
PLINE ;Print a provider statistics line
 D:$Y>(IOSL-12) FOOT^SCRPW2,HDR^SCRPW2 Q:SDOUT  S SDCT=^TMP("SCRPW",$J,SDIV,2,SDPRN,SDPR) W !!,SDPRN,"  (",SDPR,")" D F1
 Q
 ;
ACT ;Count appointments, addl. variable appt. slots and no-shows
 Q:$P(SDCP0,U,9)="C"  ;Quit if cancelled
 S SDPLAP=$P(SDCP0,U,2),SDPESL=0 I SDLAP,SDPLAP>SDLAP S SDPESL=SDPLAP\SDLAP-1,SDVSL=SDVSL+SDPESL
 Q:'SDCP0  ;SD*5.3*540
 S SDAP=SDAP+1,SDF1=1
 S SDPAS=^DPT($P(SDCP0,U),"S",SDDAY,0),SDPAS=$P(SDPAS,U,2) Q:SDPAS=""  S:"NA"[SDPAS SDNS=SDNS+1,SDNSVS=SDNSVS+SDPESL
 Q
 ;
SPAT(SC,SDSTRTDT,MAX,SDS) ;Set patterns into ^TMP (modified clone of OVR^SDAUT1)
 ;Input: SC=clinic ifn
 ;Input: SDSTRTDT=start date for gathering patterns
 ;Input: MAX=number of days beyond start date to gather patterns
 ;Input: SDS=array namespace subscript value (optional)
 ;Output: array of clinic current availability patterns in
 ;        ^TMP(SDS,$J,clinic_ifn,"ST",date,1)
 ;
 S SDS=$G(SDS) S:'$L(SDS) SDS="SDTMP" K ^TMP(SDS,$J)
 N SI,SDIN,SDRE,SDSOH,ENDATE,X,X1,X2,SM,I,D,J,Y,SS,DAY
 S SDIN=$G(^SC(SC,"I")),SDRE=$P(SDIN,U,2),SDIN=$P(SDIN,U)
 S DAY="SU^MO^TU^WE^TH^FR^SA"
 S SI=$P($G(^SC(SC,"SL")),U,6),SI=$S(SI<3:4,1:SI)
 S SDSOH=$S('$D(^SC(SC,"SL")):0,$P(^SC(SC,"SL"),"^",8)']"":0,1:1)
 S X1=SDSTRTDT,X2=MAX,SDIN=$G(SDIN) D C^%DTC S ENDATE=X,X=SDSTRTDT
EN1 S:$O(^SC(SC,"T",0))>X X=$O(^SC(SC,"T",0))
 S Y=$$DOW^XLFDT(X,1),I=Y+32,SM=X,D=Y D WM
 K J F Y=0:1:6 I $D(^SC(+SC,"T"_Y)) S J(Y)=""
 I '$D(J) D  Q
 .S D=SDSTRTDT-1 F  S D=$O(^SC(SC,"ST",D)) Q:'D!(D>ENDATE)  D
 ..S X=$G(^SC(SC,"ST",D,1)) S:$L(X) ^TMP(SDS,$J,SC,"ST",D,1)=X Q
 .Q
X1 Q:X>ENDATE  S X1=X\100_28
 I '$$ACTIVE(X,SDIN,SDRE) S X1=X,X2=1 D C^%DTC G X1
W S X=X\1
 I $D(^SC(+SC,"ST",X,1)) S ^TMP(SDS,$J,SC,"ST",X,1)=^SC(+SC,"ST",X,1) G W1
 I '$D(^SC(SC,"ST",X,1)) S Y=D#7 G L:'$D(J(Y)),H:$D(^HOLIDAY(X))&('SDSOH) S SS=$O(^SC(SC,"T"_Y,X)) G L:SS<1,L:^SC(SC,"T"_Y,SS,1)="" D
 .S ^TMP(SDS,$J,SC,"ST",X\1,1)=$P(DAY,U,Y+1)_" "_$E(X,6,7)_$J("",SI+SI-6)_^SC(SC,"T"_Y,SS,1) Q
W1 D WM:X>SM
L Q:X>ENDATE  S X=X+1,D=D+1 G W:X'>X1 S X2=X-X1 D C^%DTC G X1
 ;
H S ^TMP(SDS,$J,SC,"ST",X,1)="   "_$E(X,6,7)_"    "_$P(^(X,0),U,2) G W1
 ;
WM S SM=$S($E(X,4,5)[12:$E(X,1,3)+1_"01",1:$E(X,1,3)_$E(X,4,5)+1)_"00" Q
 ;
ACTIVE(X,SDIN,SDRE) ;Determine if the clinic is active on a given date
 ;Input: X=date to be examined
 ;Input: SDIN=clinic inactive date
 ;Input: SDRE=clinic reactivate date
 ;Output: '1'=active, '0'=inactive
 Q:'SDIN 1  Q:X<SDIN 1  Q:'SDRE 0  Q:X<SDRE 0  Q 1
