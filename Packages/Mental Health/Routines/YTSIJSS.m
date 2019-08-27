YTSIJSS ;SLC/BLD- MHAX ANSWERS SPECIAL HANDLING ;2/7/2018
 ;;5.01;MENTAL HEALTH;**123,147**;DEC 30,1994;Build 283
 ;
 ;Public, Supported ICRs
 ; #2056 - Fileman API - $$GET1^DIQ
 ;
 Q
 ;
STRING ;
 ;
 S YSDATA(N)="7771^9999;1^"_$P($P(^TMP($J,"YSCOR",2),"=",2),"^",2),N=N+1
 S YSDATA(N)="7772^9999;1^"_$P($P(^TMP($J,"YSCOR",3),"=",2),"^",2),N=N+1
 S YSDATA(N)="7773^9999;1^"_$P($P(^TMP($J,"YSCOR",4),"=",2),"^",2),N=N+1
 S YSDATA(N)="7774^9999;1^"_$P($P(^TMP($J,"YSCOR",5),"=",2),"^",2),N=N+1
 S YSDATA(N)="7775^9999;1^"_$P($P(^TMP($J,"YSCOR",6),"=",2),"^",2),N=N+1
 S YSDATA(N)="7776^9999;1^"_$P($P(^TMP($J,"YSCOR",7),"=",2),"^",2),N=N+1
 S YSDATA(N)="7777^9999;1^"_$P($P(^TMP($J,"YSCOR",8),"=",2),"^",2),N=N+1
 Q
 ;set up a string varible you want displayed in your report.
REST2 ; setting up Report Question and Answer section; will move this to YSDATA so
 N I
 F I=1:1 Q:'$D(^YTT(601.72,YSQN,1,I,0))  D
 .S TMP(NODE)=YSQN_U_"9999;1^"_DES_". "_$$GET1^DIQ(601.75,YSCDA_",",3,"E")_" ("_LEG_" points)"
 Q
TRANS ; move Answers from TMP to YSDATA
 N I,STR,ANS
 F I=3:1 Q:'$D(YSDATA(I))  K YSDATA(I)
 ;
 S ANS=7971 ;*************this is the first question - 1 as a starting point*****************
 ;
 F I=3:1 Q:'$D(TMP(I))!(TMP(I)["999999999999")  S STR=$P(TMP(I),U,2,4) D
 .S ANS=ANS+1
 .S YSDATA(I)=ANS_U_STR
 Q
 ;
SCORESV ;
 D DATA1
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 .K ^TMP($J,"YSCOR")
 .S ^TMP($J,"YSCOR",1)="[ERROR]"
 .S ^TMP($J,"YSCOR",2)=$G(YSINSNAM)_" Scale not found"
 S YSSCNAM=$P($G(^TMP($J,"YSG",3)),U,4)             ; Scale Name
 ;
 K ^TMP($J,"YSCOR")
 S ^TMP($J,"YSCOR",1)="[DATA]"
 ;
 ;S YSSCALIEN=1120   ;**************this needs to be changed to the current instrument scale***********
 ;
 S ^TMP($J,"YSCOR",2)=$$GET1^DIQ(601.87,1121_",",3,"I")_"="_GENSAT_"^"_GENSATT
 S ^TMP($J,"YSCOR",3)=$$GET1^DIQ(601.87,1122_",",3,"I")_"="_PAY_"^"_PAYT
 S ^TMP($J,"YSCOR",4)=$$GET1^DIQ(601.87,1123_",",3,"I")_"="_ADVANCE_"^"_ADVANCET
 S ^TMP($J,"YSCOR",5)=$$GET1^DIQ(601.87,1124_",",3,"I")_"="_SUPER_"^"_SUPERT
 S ^TMP($J,"YSCOR",6)=$$GET1^DIQ(601.87,1125_",",3,"I")_"="_COWORKER_"^"_COWORKERT
 S ^TMP($J,"YSCOR",7)=$$GET1^DIQ(601.87,1126_",",3,"I")_"="_HOW_"^"_HOWT
 S ^TMP($J,"YSCOR",8)=$$GET1^DIQ(601.87,1120_",",3,"I")_"="_TOTAL_"^"_TOTALT
 Q
 ;
DLLSTR(YSDATA,YS,YSTRNG) ;
 ;  YSTRNG = 1 Score Instrument
 ;  YSTRNG = 2 get Report Answers and Text
 N DATA,DES,LEG,NODE,YSQN,YSSCALIEN,TOTSCORE,TMP,TSTNM
 N YSCDA,YSSCNAM,YSINSNAM,STRING,STRING1
 N TOTALT,GENSATT,PAYT,ADVANCET,SUPERT,COWORKERT,HOWT
 N TOTAL,GENSAT,PAY,ADVANCE,SUPER,COWORKER,HOW,IJSS
 S (TOTAL,GENSAT,PAY,ADVANCE,SUPER,COWORKER,HOW)=""
 S N=N+1
 ;
 ; IJSS returns a scale score which is calculated and stored, no special text in report
 I YSTRNG=1 D SCORESV
 I YSTRNG=2 D
 .D LDSCORES(.YSDATA,.YS)
 .D STRING
 ;
 Q
 ;
DATA1 ;
 ;
 F I=3:1:7 S GENSAT=GENSAT+$$GET1^DIQ(601.75,$P(YSDATA(I),"^",3)_",",4,"I")
 F I=8:1:11 S PAY=PAY+$$GET1^DIQ(601.75,$P(YSDATA(I),"^",3)_",",4,"I")
 F I=12:1:14 S ADVANCE=ADVANCE+$$GET1^DIQ(601.75,$P(YSDATA(I),"^",3)_",",4,"I")
 F I=15:1:19 S SUPER=SUPER+$$GET1^DIQ(601.75,$P(YSDATA(I),"^",3)_",",4,"I")
 F I=20:1:26 S COWORKER=COWORKER+$$GET1^DIQ(601.75,$P(YSDATA(I),"^",3)_",",4,"I")
 F I=27:1:34 S HOW=HOW+$$GET1^DIQ(601.75,$P(YSDATA(I),"^",3)_",",4,"I")
 S GENSATT=$FN(GENSAT/5,"",2)
 S PAYT=$FN(PAY/4,"",2)
 S ADVANCET=$FN(ADVANCE/3,"",2)
 S SUPERT=$FN(SUPER/5,"",2)
 S COWORKERT=$FN(COWORKER/7,"",2)
 S HOWT=$FN(HOW/8,"",2)
 S TOTAL=(GENSATT+PAYT+ADVANCET+SUPERT+COWORKERT+HOWT)
 S TOTALT=$FN(TOTAL/6,"",2)
 ;
 Q
 ;
LDSCORES(YSDATA,YS) ;  new call for patch 123
 ;input:AD = ADMINISTRATION #
 ;output: [DATA]
 N G,N,IEN71,SCALE,YSAD,YSCODEN,YSCALE
 S YSAD=$G(YS("AD"))
 ;
 S YSDATA=$NA(^TMP($J,"YSCOR"))
 S ^TMP($J,"YSCOR",1)="[DATA]",N=1
 ;
 S YSCALE="",N=1
 F  S YSCALE=$O(^YTT(601.92,"AC",YSAD,YSCALE))  Q:'YSCALE  D
 .S G=$G(^YTT(601.92,YSCALE,0))
 .S SCALE=$P(G,U,3),N=N+1
 .S ^TMP($J,"YSCOR",N)=SCALE_"="_$P(G,U,4,7)
 Q
