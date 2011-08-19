YTAPI10A ;ALB/ASF- PSYCH TEST API FOR CLINICAL REMINDERS ;09/20/2004
 ;;5.01;MENTAL HEALTH;**77**;Dec 30, 1994
 ;Reference to ^PXRMINDX(601.2, supported by DBIA #4114
SET(X) ;
 S N=N+1
 S YSSUB(N)=X
 Q
OCCUR(YSSUB,YS) ;occurances OF TESTS,GAF,ASI
 ;Input:
 ;YS("CODE"): Test code NUMBER from file 601 including "ASI","GAF"
 ;YS("BEGIN"): inclusive date in %DT acceptable format (11/11/2011) to begin search [optional]                
 ;YS("END"): inclusive date in %DT acceptable format (11/11/2011) to end search  [optional]           
 ;YS("LIMIT"): Last N administrations [optional]
 ;Output
 ;^TMP($J,YSSUB,1)=[DATA]^NUMBER FOUND
 ;^TMP($J,YSSUB,DFN,OCCURANCE)=DAS^DFN^TEST (DAS=entry endas^ytapi10)
 N G,YSLIMIT,YSJJ,YSSONE,S,R,N,YSN2,N4,I,II,DFN,YSCODE,YSADATE,YSSCALE,YSBED,YSEND,YSAA,DAS,YSOCC,YSZN,YST,YSLM
 N IFN,R1,R2,R3,SFN1,SFN2,YSBEG,YSCK,YSDFN,YSED,YSIFN,YSINUM,YSITEM,YSN2,YSNODE,YSPRIV,YSQT,YSR,YSSTAFF,YSTYPE,YSCODE,NI,YSID
 D PARSE^YTAPI(.YS)
 S YSLM=$G(YS("LIMIT")) S:YSLM'?1N.N YSLM=1
 S N=0
 K ^TMP($J,YSSUB)
 I '$D(^YTT(601,"B",YSCODE)) S ^TMP($J,YSSUB,1)="[ERROR]^BAD TEST CODE #" Q  ;-->out
 S YSCODE=$O(^YTT(601,"B",YSCODE,0))
 I $P(^YTT(601,YSCODE,0),U)="ASI" D ASIOC Q  ;-->out
 I $P(^YTT(601,YSCODE,0),U)="GAF" D GAFOC Q  ;-->out
P0 S DFN=0,NI=0 F  S DFN=$O(^PXRMINDX(601.2,"IP",YSCODE,DFN)) Q:DFN'>0  S YS("DFN")=DFN D P1
 S ^TMP($J,YSSUB)="[DATA]"_U_NI
 Q
P1 I $D(^YTT(601,YSCODE)) S YSN2=YSEND+.1,YSOCC=0 F  S YSN2=$O(^YTD(601.2,DFN,1,YSCODE,1,YSN2),-1) Q:YSN2'>0!(YSN2<YSBEG)  D
 . S YSOCC=YSOCC+1
 . Q:(YSOCC>YSLM)
 . S NI=NI+1
 . S ^TMP($J,YSSUB,DFN,YSOCC)=DFN_";1;"_YSCODE_";1;"_YSN2_U_YSN2_U_YSCODE
 Q
GAFOC ;all axis5 DXs in time frame
 S YST=YSEND+.0000001,NI=0
 F  S YST=$O(^YSD(627.8,"B",YST),-1) Q:YST'>0!(YST<YSBEG)  S IFN=0 F  S IFN=$O(^YSD(627.8,"B",YST,IFN)) Q:IFN'>0  D
 . S X=$P($G(^YSD(627.8,IFN,60)),U,3)
 . Q:X=""
 . S DFN=$P($G(^YSD(627.8,IFN,0)),U,2) Q:DFN'>0  ;bad dfn
 . S YSOCC=$O(^TMP($J,YSSUB,DFN,999999),-1)+1
 . Q:(YSOCC>YSLM)
 . S NI=NI+1
 . S ^TMP($J,YSSUB,DFN,YSOCC)=DFN_";1;"_YSCODE_";1;"_IFN_U_YST_U_YSCODE
 S ^TMP($J,YSSUB)="[DATA]"_U_NI
 Q
ASIOC ;
 S NI=0,DFN=0,YSID=YSEND+.01
 F  S YSID=$O(^YSTX(604,"AD",YSID),-1) Q:(YSID'>0)!(YSID<YSBEG)  S IFN=0 F  S IFN=$O(^YSTX(604,"AD",YSID,IFN)) Q:IFN'>0  D
 . Q:'$D(^YSTX(604,IFN,.5))  ; no sig
 . S G=$G(^YSTX(604,IFN,0))
 . S DFN=$P(G,U,2) Q:DFN'>0  ;bad dfn
 . S YSOCC=$O(^TMP($J,YSSUB,DFN,999999),-1)+1
 . Q:(YSOCC>YSLM)
 . S NI=NI+1
 . S ^TMP($J,YSSUB,DFN,YSOCC)=DFN_";1;"_YSCODE_";1;"_IFN_U_$P(G,U,5)_U_Y
 S ^TMP($J,YSSUB)="[DATA]"_U_NI
 Q
PTTEST(YSDATA,YS) ;all data scores for a specific patient
 ;Input:
 ;YS("DFN"): Patient IFN from file2
 ;YS("CODE"): Test code NUMBER from file 601 including "ASI","GAF"
 ;YS("BEGIN"): inclusive date in %DT acceptable format (11/11/2011) to begin search [optional]                
 ;YS("END"): inclusive date in %DT acceptable format (11/11/2011) to end search  [optional]           
 ;YS("LIMIT"): Last N administrations [optional]
 ;Output
 ;YSDATA(1)=[DATA]^NUMBER FOUND
 ;YSDATA(OCCURANCE,1:999) most recent to least recent occurance for this test for this patient
 N YSBEG,YSCODE,R1,R2,R3,YSADATE,YSEND,YSLIMIT,YSLM,YSOCC,YSSCALE,YSSTAFF,YSZ,YSZN,G,YSORT
 D PARSE^YTAPI(.YS)
 S YSLM=$G(YS("LIMIT")) S:YSLM="" YSLM=1
 I YSLM'?1NP.N!(YSLM=0) S YSDATA(1)="[ERROR]",YSDATA(2)="bad limit" Q  ;-->out
 S YSORT=$S(YSLM<0:1,1:-1) ;set sort order
 I YSLM>0 S YSID=YSEND+.00001
 E  S YSID=YSBEG-.00001,YSLM=YSLM*-1
 I YSCODE="ASI" D ASIPT Q  ;-->out
 I YSCODE="GAF" D GAFPT Q  ;-->out
 S YSCODE=$O(^YTT(601,"B",YSCODE,0))
 S NI=0
 F  S YSID=$O(^PXRMINDX(601.2,"PI",DFN,YSCODE,YSID),YSORT) Q:(YSID'>0)!(YSID<YSBEG)!(YSID>YSEND)!(NI=YSLM)  D
 . S DAS=DFN_";;"_YSCODE_";;"_YSID
 . S DAS=DFN_";1;"_YSCODE_";1;"_YSID
 . S YSOCC=$O(YSDATA(9999999),-1)+1 S:YSOCC<2 YSOCC=2
 . S YSDATA(YSOCC)=DAS_U_YSID,NI=NI+1
 S YSDATA(1)="[DATA]"_U_NI
 Q
GAFPT ;gaf for pt IN time
 S IFN=$S(YSORT=1:0,1:9999999),NI=0
 K ^TMP($J,"YSGAF")
 S YSCODE=$O(^YTT(601,"B","GAF",0))
 F  S IFN=$O(^YSD(627.8,"C",DFN,IFN),YSORT) Q:(IFN'>0)!(NI=YSLM)  D
 . S X=$P($G(^YSD(627.8,IFN,60)),U,3)
 . Q:X=""
 . S X=$P($G(^YSD(627.8,IFN,0)),U,3)
 . Q:(X<YSBEG)!(X>YSEND)
 . S NI=NI+1
 . S ^TMP($J,"YSGAF",X,IFN)=""
 S X=$S(YSORT=1:0,1:9999999)
 F  S X=$O(^TMP($J,"YSGAF",X),YSORT) Q:X'>0  S IFN=0 F  S IFN=$O(^TMP($J,"YSGAF",X,IFN)) Q:IFN'>0  D
 . S YSOCC=$O(YSDATA(9999999),-1)+1 S:YSOCC<2 YSOCC=2
 . S DAS=DFN_";1;"_YSCODE_";1;"_IFN
 . S YSDATA(YSOCC)=DAS_U_X
 S YSDATA(1)="[DATA]"_U_NI
 Q
ASIPT ;asis for pt IN time
 S IFN=$S(YSORT=1:0,1:9999999),NI=0
 S YSCODE=$O(^YTT(601,"B","ASI",0))
 F  S IFN=$O(^YSTX(604,"C",DFN,IFN),YSORT) Q:IFN'>0!(NI=YSLM)  D
 . Q:'$D(^YSTX(604,IFN,.5))  ; no sig
 . S X=$P($G(^YSTX(604,IFN,0)),U,5)
 . Q:X=""
 . Q:(X<YSBEG)!(X>YSEND)
 . S YSOCC=$O(YSDATA(9999999),-1)+1 S:YSOCC<2 YSOCC=2
 . S NI=NI+1
 . S DAS=DFN_";1;"_YSCODE_";1;"_IFN
 . S YSDATA(YSOCC)=DAS_U_X
 S YSDATA(1)="[DATA]"_U_NI
 Q
