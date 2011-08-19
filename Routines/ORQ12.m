ORQ12 ; slc/dcm - Get patient orders in context ;06/29/06
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**12,27,78,92,116,190,220,215,243**;Dec 17, 1997;Build 242
GET(IFN,NEWD,DETAIL,ACTOR) ; -- Setup TMP array
 ; IFN=ifn of order
 ; NEWD=3rd subscript in ^TMP("ORR",$J, node (ORLIST)
 ; DETAIL=see description in ^ORQ1
 ;
 N X0,X3,X4,X6,TXT,STAT,START,DG,STOP,ENTERD
 S ORLST=ORLST+1,^TMP("ORGOTIT",$J,IFN,+$G(ACTOR))=""
 I '$G(DETAIL) S ^TMP("ORR",$J,NEWD,ORLST)=IFN_$S($G(ACTOR):";"_ACTOR,1:"") Q
 S X0=^OR(100,IFN,0),X3=$G(^(3)),X4=$G(^(4)),X6=$G(^(6))
 S DG=$P(X0,U,11),DG=$P($G(^ORD(100.98,+DG,0)),U,3)
 S STAT=$S($P(X3,U,3):$P(^ORD(100.01,$P(X3,U,3),0),U,1,2),1:"") ;.01^abbr
 S ENTERD=$P(X0,U,7),START=$P(X0,U,8),STOP=$P(X0,U,9)
 ; S FLAGREA=$P(X6,U,7)
 S ^TMP("ORR",$J,NEWD,ORLST)=IFN_$S($G(ACTOR):";"_ACTOR,1:"")_U_DG_U_ENTERD_U_START_U_STOP_U_STAT
 D TEXT(.TXT,IFN) M ^TMP("ORR",$J,NEWD,ORLST,"TX")=TXT
 Q
 ;
TEXT(ORTX,ORIFN,WIDTH) ; -- Returns text of order ORIFN in ORTX(#)
 N OR0,OR3,OR6,X,Y,FIRST,ORI,ORJ,DLG,ORX,ORACT,ORTA
 K ORTX S:'$G(WIDTH) WIDTH=244
 S ORACT=+$P(ORIFN,";",2),ORIFN=+ORIFN
 I ORACT<1 S ORACT=+$P($G(^OR(100,ORIFN,3)),U,7) S:'ORACT ORACT=1
 ;D:$O(^OR(100,ORIFN,1,0)) CNV^ORY92(ORIFN) ;convert text otf
 S OR0=$G(^OR(100,ORIFN,0)),OR3=$G(^(3)),OR6=$G(^(6)),ORX=$G(^(8,ORACT,0))
 S ORTX=1,ORTX(1)=""
 I $P($G(OR0),U,11)'="",($P(^ORD(100.98,$P(OR0,U,11),0),U)="NON-VA MEDICATIONS") S X="Non-VA" D ADD
 G:$G(ORIGVIEW)>1 T1
 S:$P(OR0,U,14)=$O(^DIC(9.4,"C","OR",0)) ORTX(1)=">>" ;generic
 S X=$$ACTION($P(ORX,U,2)) D:$L(X) ADD
 I $P(ORX,U,2)="NW",$P(OR3,U,11),'$G(ORIGVIEW) D  ; Changed or Renewed
 . I $P(OR3,U,11)=2 S X="Renew" D ADD Q
 . N ORIG,ORIGTA S ORIG=+$P(OR3,U,5) Q:'ORIG  Q:$P(OR3,U,11)'=1
 . S X="Change" D ADD S ORI=0
 . I $G(IOST)'="P-OTHER" D
 . .S ORIGTA=$$LASTXT(ORIG) ;D:$O(^OR(100,ORIG,1,0)) CNV^ORY92(ORIG)
 . .F  S ORI=$O(^OR(100,ORIG,8,ORIGTA,.1,ORI)) Q:ORI'>0  S X=$G(^(ORI,0)) S:$E(X,1,3)=">> " X=$E(X,4,999) D ADD
 . .S X=" to" D ADD
T1 S ORTA=+$P(ORX,U,14),FIRST=+$O(^OR(100,ORIFN,8,ORTA,.1,0))
 S ORI=0 F  S ORI=$O(^OR(100,ORIFN,8,ORTA,.1,ORI)) Q:ORI'>0  S X=$G(^(ORI,0)) S:(FIRST=ORI)&($E(X,1,3)=">> ") X=$E(X,4,999) D:$L(X) ADD
 Q:$G(ORIGVIEW)>1  ;contents of global only
 S DLG=$P(OR0,U,5) K Y I DLG,$P(DLG,";",2)["101.41",$D(^ORD(101.41,+DLG,9)) X ^(9) I $L($G(Y)) S X=Y D ADD ; additional text
 ; I $P(OR3,U,11)=2 S X="(Renewal)" D ADD
 I $P(ORX,U,4)=2 S X="*UNSIGNED*" D ADD
 I $P(ORX,U,2)="DC"!("^1^13^"[(U_$P(OR3,U,3)_U)),$L(OR6) S X=" <"_$S($L($P(OR6,U,5)):$P(OR6,U,5),$P(OR6,U,4):$P($G(^ORD(100.03,+$P(OR6,U,4),0)),U),1:"")_">" D:$L(X)>3 ADD ; DC Reason
 I $D(XQAID),$G(ORFLG)=12 S ORX=$G(^OR(100,ORIFN,8,ORACT,3)) I $P(ORX,U) S X=" Flagged "_$$DATETIME($P(ORX,U,3))_$S($P(ORX,U,4):" by "_$$NAME($P(ORX,U,4)),1:"")_": "_$P(ORX,U,5) D ADD ; Flagged - show in FUP
 Q
 ;
LASTXT(IFN)     ; -- Returns action with latest text for order IFN
 N I,Y S Y=1
 S I=0 F  S I=$O(^OR(100,IFN,8,I)) Q:I'>0  S:$O(^(I,.1,0)) Y=I
 Q Y
 ;
LAST(CODE) ; -- Return DA of last occurence of CODE action
 N DA
 I '$L($G(CODE)) S DA=$O(^OR(100,ORIFN,8,"A"),-1) ; last entry
 E  S DA=$O(^OR(100,ORIFN,8,"C",CODE,"?"),-1) ; last CODE entry
 Q DA
 ;
ACTION(X) ; -- Returns text of action X
 N Y
 S Y=$S(X="DC":"Discontinue",X="HD":"Hold",X="RL"&'$G(ORIGVIEW):"Release Hold of",X="FL":"Flag",X="UF":"Unflag",X="RN"&'$G(ORIGVIEW):"Renew",1:"")
 Q Y
 ;
DATETIME(X) ; -- Returns date/time in format 00/00/00@00:00am
 N Y,D,T,T1,Z
 S D=$P(X,"."),T=$E($P(X,".",2)_"0000",1,4),T1=$E(T,1,2),Z="AM"
 S:T1>12 T1=T1-12,Z="PM"
 S Y=$E(D,4,5)_"/"_$E(D,6,7)_"/"_(1700+$E(D,1,3))_"@"_T1_":"_$E(T,3,4)_Z
 Q Y
 ;
NAME(X) ; -- Returns name as Lname,F
 N Y,Z S Z=$P($G(^VA(200,+X,0)),U) Q:Z="" ""
 S Y=$P(Z,",")_"," F I=$F(Z,","):1:$L(Z) I $E(Z,I)'=" " S Y=Y_$E(Z,I) Q
 S Y=$$LOWER^VALM1(Y) ; mixed case
 Q Y
 ;
ADD ; -- Add text X to ORTX()
 N I,Y S Y=$L(ORTX(ORTX)) S:Y Y=Y+1 ;allow for space
 I $E(X)=" ",Y S ORTX=ORTX+1,ORTX(ORTX)="",Y=0,X=$E(X,2,999) ;new line
 I Y+$L(X)'>WIDTH S ORTX(ORTX)=ORTX(ORTX)_$S(Y:" ",1:"")_X Q
 F I=1:1:$L(X," ") S Z=$P(X," ",I) D:(Y+$L(Z))>WIDTH  S ORTX(ORTX)=$G(ORTX(ORTX))_$S(Y:" ",1:"")_Z,Y=$L(ORTX(ORTX)) S:Y Y=Y+1
 . I $L(Z)>WIDTH F  S ORTX(ORTX)=$G(ORTX(ORTX))_$S(Y:" ",1:"")_$E(Z,1,WIDTH-Y),Z=$E(Z,WIDTH-Y+1,999) Q:$L(Z)'>WIDTH  S ORTX=ORTX+1,Y=0
 . S ORTX=ORTX+1,Y=0
 Q
 ;
EXPD ; -- loop through ^XTMP("ORAE" to get expired orders
 K ^TMP("ORGOTIT",$J),^TMP("ORSORT",$J)
 N TM,TO,IFN,X0,X3,X7,X8,USTS,NOW,ACTOR,X,ORREP
 S NOW=+$E($$NOW^XLFDT,1,12),TO=0,SDATE=9999999-SDATE,EDATE=9999999-EDATE
 F  S TO=$O(^XTMP("ORAE",PAT,TO)) Q:'TO  I $D(ORGRP(TO)) S TM=EDATE F  S TM=$O(^XTMP("ORAE",PAT,TO,TM)) Q:'TM!(TM>SDATE)!(+TM<EDATE)  D
 . S IFN=0 F  S IFN=$O(^XTMP("ORAE",PAT,TO,TM,IFN)) Q:'IFN  I ('$D(^TMP("ORGOTIT",$J,IFN))!MULT) D
 .. S USTS=$P(^OR(100,IFN,3),U,3)
 .. Q:+$G(USTS)'=7  ;quit if order no longer expired
 .. S ORREP=$P(^OR(100,IFN,3),U,6)
 .. Q:+$G(ORREP)>0  ;quit if order has been replaced
 .. S ^TMP("ORSORT",$J,9999999-TM,TO,IFN)=""
 S TM=0 F  S TM=$O(^TMP("ORSORT",$J,TM)) Q:'TM  S TO=0 F  S TO=$O(^TMP("ORSORT",$J,TM,TO)) Q:'TO  D
 .S IFN=0 F  S IFN=$O(^TMP("ORSORT",$J,TM,TO,IFN)) Q:'IFN  I $D(^OR(100,IFN,0)),$D(^(3)) S X0=^(0),X3=^(3) D
 ..S ACTOR=+$P(X3,U,7) D LP1^ORQ11
 ..;S ACTOR=0 F  S ACTOR=$O(^OR(100,"ACT",PAT,9999999-$P(X0,U,7),TO,IFN,ACTOR)) Q:ACTOR<1  I '$D(^TMP("ORGOTIT",$J,IFN,ACTOR)),$D(^OR(100,IFN,8,ACTOR,0)),$P(^(0),U,15)'=13 S X8=^(0),X7=$G(^(7)) D LP1^ORQ11
 S ^TMP("ORR",$J,ORLIST,"TOT")=$G(ORLST)
 K ^TMP("ORSORT",$J),^TMP("ORGOTIT",$J)
 Q
GETEIE(IFN,NEWD,DETAIL,ACTOR) ; -- Setup TMP array
 ; IFN=ifn of order
 ; NEWD=3rd subscript in ^TMP("ORR",$J, node (ORLIST)
 ; DETAIL=see description in ^ORQ1
 ;
 N X0,X3,X4,X6,TXT,STAT,START,DG,STOP,ENTERD,DCREAS
 S X0=^OR(100,IFN,0),X3=$G(^(3)),X4=$G(^(4)),X6=$G(^(6))
 S DG=$P(X0,U,11),DG=$P($G(^ORD(100.98,+DG,0)),U,3)
 S STAT=$S($P(X3,U,3):$P(^ORD(100.01,$P(X3,U,3),0),U,1,2),1:"")
 S ENTERD=$P(X0,U,7),START=$P(X0,U,8),STOP=$P(X0,U,9)
 S DCREAS=$P($G(X6),U,4) Q:DCREAS'>0
 I DCREAS'=$O(^ORD(100.03,"B","Entered in error","")) Q
 S ORLST=ORLST+1,^TMP("ORGOTIT",$J,IFN,+$G(ACTOR))=""
 I '$G(DETAIL) S ^TMP("ORR",$J,NEWD,ORLST)=IFN_$S($G(ACTOR):";"_ACTOR,1:"") Q
 S ^TMP("ORR",$J,NEWD,ORLST)=IFN_$S($G(ACTOR):";"_ACTOR,1:"")_U_DG_U_ENTERD_U_START_U_STOP_U_STAT
 D TEXT(.TXT,IFN) M ^TMP("ORR",$J,NEWD,ORLST,"TX")=TXT
 Q
