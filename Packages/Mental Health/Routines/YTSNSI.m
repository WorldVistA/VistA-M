YTSNSI ;BAL/KTL - Report for NSI FOR TBI ;Mar 27, 2025@08:59:02
 ;;5.01;MENTAL HEALTH;**255**;Dec 30, 1994;Build 13
 ;
 ;
DLLSTR(YSDATA,YS,YSTRNG) ; compute scores or report text based on YSTRNG
 ; input
 ;   YSDATA(2)=adminId^patientDFN^instrumentName^dateGiven^isComplete
 ;   YSDATA(2+n)=questionId^sequence^choiceId
 ;   YS("AD")=adminId
 ;   YSTRNG=1 for score, 2 for report
 ; output if YSTRNG=1: ^TMP($J,"YSCOR",n)=scaleId=score
 ; output if YSTRNG=2: append special "answers" to YSDATA
 ;
 N YSN,YSTEXT
 ;
 I YSTRNG=1 D BYKEY^YTSCORE(.YSDATA)  ; just use "regular" scoring
 ;
 I YSTRNG=2 D
 . N SCOREVAL,N
 . D LDSCORES^YTSCORE(.YSDATA,.YS) ; puts score into ^TMP($J,"YSCOR",2)
 . D REPORT
 Q
 ;
REPORT ; build the numerical answer array for the report
 ; expects ^TMP($J,"YSCOR",...) and ^TMP($J,"YSG") from DLLSTR
 ;         YSDATA from DLLSTR
 ; Question IEN = 9567-9588
 ; Answer array = 7771-7781
 N YTI,YTRAW,YTCNT,YTCHC,YTQUE,YTANS,TMPYS,II
 N YSTEXT
 S YTRAW=0,YTCNT=0
 S YTI=$O(YSDATA(""),-1)
 S II=2 F  S II=$O(YSDATA(II)) Q:'II  D
 . S YTQUE=$P(YSDATA(II),U)
 . S YTCHC=$P(YSDATA(II),U,3)
 . S YSTEXT=$G(^YTT(601.75,YTCHC,1))
 . S YTANS=YTQUE-1796  ;e.g. 9567-1796=7771
 . I (YTCHC=1155)!(YTCHC=1156)!(YTCHC=1157) D  Q  ; N/A or skipped
 .. S YTI=YTI+1,TMPYS(YTI)=YTANS_"^9999;1^"_$S(YTCHC=1155:"Skipped",YTCHC=1156:"Not asked (due to responses on other questions)",1:"Missing")
 . S YSTEXT=$$WRAP(YSTEXT,70,"     ")
 . S YTI=YTI+1,TMPYS(YTI)=YTANS_"^9999;1^"_YSTEXT
 M YSDATA=TMPYS
 Q
 ;
WRAP(TX,MAX,IND) ; If length of TX > MAX, wrap by adding LF and INDent
 N OUT,I,J,X,Y,YNEW,LF
 S LF="|"
 F I=1:1:$L(TX,LF) S X=$P(TX,LF,I) D
 . I $L(X)'>MAX D ADDOUT(X) QUIT
 . S Y=""
 . F J=1:1:$L(X," ") D
 . . S YNEW=Y_$S(J=1:"",1:" ")_$P(X," ",J)
 . . I $L(YNEW)>MAX D ADDOUT(Y) S Y=$P(X," ",J) I 1
 . . E  S Y=YNEW
 . D ADDOUT(Y) ; add any remaining
 S X="",I=0 F  S I=$O(OUT(I)) Q:'I  S X=X_$S(I=1:"",1:LF_IND)_OUT(I)
 Q X
 ;
ADDOUT(S) ; add string to out array (expects OUT)
 S OUT=+$G(OUT)+1,OUT(OUT)=S
 Q
 ;
