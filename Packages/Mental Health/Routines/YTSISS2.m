YTSISS2 ;SLC/MJB- SCORE ISS2 ; 10/30/18 9:35am
 ;;5.01;MENTAL HEALTH;**151**;Dec 30, 1994;Build 92
 ;
 ; This routine was split from YTQAPI2A.
 ; This routine handles limited complex reporting requirements without
 ; modifying YS_AUX.DLL by adding free text "answers" that can be used by
 ; a report.
 ;,
 ; Assumptions:  EDIT incomplete instrument should ignore the extra answers
 ; since there are no associated questions.  GRAPHING should ignore the
 ; answers since they not numeric.
 ;
  Q
 ;
DLLSTR(YSDATA,YS,YSTRNG) ;
 ;
 N TOTAL,TXT,YSMED,YSOVER,YSTOTAL,YSCALEI,STRING,YSINSNAM,I,NODE,YSQN,YSCDA,DATA
 N YSCAL,YSVAL,YSCALVI,YTSCOR,YSVALA,YSRSC1,YSRSC2,YSRSC3,YSRSC4,YSRSC5
 N II,ISS2,YSCALIEN,YSSCNAM,YSRSC,YSMOOD,STRING1
 S N=N+1,II=0
 IF YSTRNG=1 D SCORESV
 I YSTRNG=2 D
 .D LDSCORES^YTSCORE(.YSDATA,.YS)
 .D STRING(.STRING1)
 .S YSDATA($O(YSDATA(""),-1)+1)=999999999999_U_U_STRING1
 Q
 ;
SCORESV ;
 D DATA1 D YSRAW
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 .K ^TMP($J,"YSCOR")
 .S ^TMP($J,"YSCOR",1)="[ERROR]"
 .S ^TMP($J,"YSCOR",2)=$G(YSINSNAM)_" Scale not found"
 S YSSCNAM=$P($G(^TMP($J,"YSG",3)),U,4)             ; Scale Name
 ;
 K ^TMP($J,"YSCOR")
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S I=2
 F  S I=$O(^TMP($J,"YSG",I)) Q:'I  D
 .S YSCALIEN=$P($P(^TMP($J,"YSG",I),"^",1),"=",2)
 .S YSRSC="YSRSC"_(I-2)
 .S ^TMP($J,"YSCOR",I)=$$GET1^DIQ(601.87,YSCALIEN_",",3,"I")_"="_@YSRSC
 Q
 ;
DATA1 ;
 S NODE=2 F  S NODE=$O(YSDATA(NODE)) Q:NODE=""  D
 .S DATA=YSDATA(NODE)
 .S YSQN=$P(DATA,U,1)
 .S YSCDA=$P($G(DATA),U,3)
 .S ISS2(NODE)=$$GET1^DIQ(601.75,YSCDA_",",4,"I")
YSRAW ;
 S YSRSC1=0,YSRSC2=0,YSRSC3=0,YSRSC4=0,YSRSC5=0
 S YSRSC1=$G(ISS2(8))+$G(ISS2(10))+$G(ISS2(12))+$G(ISS2(14))+$G(ISS2(15))
 S YSRSC2=$G(ISS2(5))+$G(ISS2(7))+$G(ISS2(17))
 S YSRSC3=$G(ISS2(4))+$G(ISS2(3))+$G(ISS2(6))+$G(ISS2(13))+$G(ISS2(16))
 S YSRSC4=$G(ISS2(9))+$G(ISS2(11))
 S YSRSC5=$G(ISS2(18))
 Q
 ;
STRING(STRING1) ;
 F I=2 S YSRSC1=$P($G(^TMP($J,"YSCOR",2)),"=",2)
 F I=3 S YSRSC2=$P($G(^TMP($J,"YSCOR",3)),"=",2)
 F I=4 S YSRSC3=$P($G(^TMP($J,"YSCOR",4)),"=",2)
 F I=5 S YSRSC4=$P($G(^TMP($J,"YSCOR",5)),"=",2)
 F I=6 S YSRSC5=$P($G(^TMP($J,"YSCOR",6)),"=",2)
 I (YSRSC2>=125)&(YSRSC1<=155) S YSMOOD="EUTHYMIC"
 I (YSRSC2>=125)&(YSRSC1>=155) S YSMOOD="MANIC OR HYPOMANIC"
 I (YSRSC2<125)&(YSRSC1<155) S YSMOOD="DEPRESSED"
 I (YSRSC2<125)&(YSRSC1>=155) S YSMOOD="MIXED"
 ;S YSDATA(N)="7771^9999;1^"_$$PAD(YSRSC1,2) S N=N+1
 ;S YSDATA(N)="7772^9999;1^"_$$PAD(YSRSC2,2) S N=N+1
 ;S YSDATA(N)="7773^9999;1^"_$$PAD(YSRSC3,2) S N=N+1
 ;S YSDATA(N)="7774^9999;1^"_$$PAD(YSRSC4,2) S N=N+1
 ;S YSDATA(N)="7775^9999;1^"_$$PAD(YSRSC5,2) S N=N+1
 S YSDATA(N)="7776^9999;1^"_YSMOOD S N=N+1
 D SCALES(.STRING1)
 Q 
 ;
YSARRAY(YSDATA) ;
 S NODE=2 F  S NODE=$O(YSDATA(NODE)) Q:NODE=""  D
 .S DATA=YSDATA(NODE)
 .S YSQN=$P(DATA,U,1)
 .S YSCDA=$P($G(DATA),U,3)
 .S ISS2(NODE)=$$GET1^DIQ(601.75,YSCDA_",",4,"I")
 Q
PAD(VAL,LENGTH) ; padds the value with spaces at beginning
 N RETURN,PADDING
 I VAL="Left blank by the user." S VAL="--"
 S PADDING=LENGTH-$L(VAL)
 I PADDING'>0 Q VAL
 S $P(RETURN," ",PADDING+1)=VAL
 Q RETURN
 ;
SCALES(STRING1) ;
 S STRING1="SCALES|"
 S STRING1=STRING1_"          Activation: "_$J(YSRSC1,3)_"   (Manic Symptoms, Range 0 to 500)|"
 S STRING1=STRING1_"          Well Being: "_$J(YSRSC2,3)_"   (Range 0 to 300)|"
 S STRING1=STRING1_"  Perceived Conflict: "_$J(YSRSC3,3)_"   (Global Psychopathology Range 0 to 500)|"
 S STRING1=STRING1_"    Depression Index: "_$J(YSRSC4,3)_"   (Range 0 to 200)|"
 S STRING1=STRING1_"Global Bipolar Scale: "_$J(YSRSC5,3)_"   (0=depressed/down < 50=normal > 100=high/manic)|"
 ;
 Q
