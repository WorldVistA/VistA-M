YTAPI5 ;ALB/ASF- MH API NOTES ; 7/24/07 4:11pm
 ;;5.01;MENTAL HEALTH;**62,85**;Dec 30, 1994;Build 48
 Q
OUTNOTE(YSDATA) ;
 N G,I,N,P,R,X,Y,YS2,YSADATE,YSCODE,YSGG,YSGG1,YSGG2,YSJ,YSJJ,YSNCODE,YSSET,YSSR,YSST,YSX1,YSX2,YSX3,YIN,YSINN,YSINE,YSMC
 I $G(YSDATA(1))?1"[ERROR".E Q  ;---->
 I '$D(YSDATA(5)) S YSDATA(1)="[ERROR]",YSDATA(2)="bad ysdata to outnote" Q  ;--->
 S YS2=$G(YSDATA(2))
 S YSCODE=$P(YS2,U,2)
 S YSADATE=$P(YS2,U,4)
 S YSNCODE=$O(^YTT(601,"B",YSCODE,-1))
 S YSX1=$P(YSDATA(3),U,2)
 S YSX2=$P(YSDATA(4),U,2)
 S YSX3=$P(YSDATA(5),U,2)
 S YSSR=$P(YSDATA(6),U,3)
 S YSST=$P(YSDATA(6),U,4)
 S Y=$G(^YTT(601.6,YSNCODE,2))
 I Y="" S YSDATA(1)="[ERROR]",YSDATA(2)="no mh mult outcome code" Q  ;--->
 ;
 X Y
 I X'>0 S YSDATA(1)="[ERROR]",YSDATA(2)="bad M executable" Q  ;--->
LD ;LOAD NOTE
 S N=0
 F  S N=$O(^YTT(601.6,YSNCODE,3,X,1,N)) Q:N'>0  D
 . S YSDATA("ON",N,0)=^YTT(601.6,YSNCODE,3,X,1,N,0)
REP ;replace ||
 S N=0
 F  S N=$O(YSDATA("ON",N)) Q:N'>0  D
 . S G=YSDATA("ON",N,0)
 . S R=""
 . F I=1:1:$L(G,"|") D
 .. S P=$P(G,"|",I)
 .. D:P?1"RSCORE".1N.N RSCORE
 .. D:P?1"SSCORE".1N.N SSCORE
 .. D:P?1"ITEM".1N.E ITEM
 .. D:P?1"EXECUTE".E MC
 .. S R=R_P
 . S YSDATA("ON",N,0)=R
 Q
RSCORE ; raw scores
 S YSJ=$E(P,7,99),P=$P(YSDATA(YSJ+5),U,3)
 Q
SSCORE ;scaled score
 S YSJ=$E(P,7,99),P=$P(YSDATA(YSJ+5),U,4)
 Q
ITEM ;items resolution
 S YSIN=$E(P,5,999)
 S YSSET=$P(YSIN,";",2)
 S YSIN=$P(YSIN,";",1)
 S YSINN=$S(YSIN>400:5,YSIN>200:4,1:3)
 S YSINE=$S(YSIN#200=0:200,1:YSIN)
 S P=$P(YSDATA(YSINN),U,2)
 S P=$E(P,YSINE)
 Q:YSSET=""
 F YSJJ=1:1:$L(YSSET,",") D
 . S YSGG=$P(YSSET,",",YSJJ),YSGG1=$P(YSGG,":"),YSGG2=$P(YSGG,":",2)
 . S:P=YSGG1 P=YSGG2
 Q
MC ;mumps executable setting P
 S YSMC=$P(P,";",2)
 X YSMC
 Q
GAFURL(YSDATA) ;returns MH GAF horizontal sheet
 S YSDATA(1)="[DATA]"
 S YSDATA(2)="http://vaww.mentalhealth.med.va.gov/gafsheet.htm"
 Q
PRIVL(YSDATA,YS) ;check privileges
 N YSCODE,YSET
 S YSCODE=$G(YS("CODE"),-1)
 ;ASF 03/08/06
 I (YSCODE="GAF")!(YSCODE="ASI") S YSDATA(1)="[DATA]",YSDATA(2)="1^exempt test" Q  ;-->out test exempt
 I $D(^YTT(601.71,"B",YSCODE)) D  Q  ;--> out
 . S YSET=$O(^YTT(601.71,"B",YSCODE,0))
 . S YSDATA(1)="[DATA]"
 . S YSKEY=$$GET1^DIQ(601.71,YSET_",",9)
 . I YSKEY="" S YSDATA(2)="1^exempt test" Q  ;-->out
 . I $D(^XUSEC(YSKEY,DUZ)) S YSDATA(2)="1^user privileged" Q  ;-->out has key
 . S YSDATA(2)="0^no access" Q  ;->out
 ;
 I '$D(^YTT(601,"B",YSCODE)) S YSDATA(1)="[ERROR]",YSDATA(2)="BAD TEST CODE" Q  ;--> out
 S YSET=$O(^YTT(601,"B",YSCODE,0))
 S YSDATA(1)="[DATA]"
 I $D(^XUSEC("YSP",DUZ)) S YSDATA(2)="1^user privileged for all tests" Q  ;has key
 I $P(^YTT(601,YSET,0),U,10)="Y"!(YSCODE="GAF")!(YSCODE="ASI") S YSDATA(2)="1^exempt test" Q  ;test exempt
 I $P(^YTT(601,YSET,0),U,9)="I" S YSDATA(2)="1^interview" Q  ;interview
 S YSDATA(2)="0^no access"
 Q
