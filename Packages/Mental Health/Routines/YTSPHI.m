YTSPHI ;SLC/KCM - Score PHI and format report ;Mar 03, 2025@14:06:48
 ;;5.01;MENTAL HEALTH;**172,236**;DEC 30,1994;Build 25
 ;
DATA1 ; Loop YSDATA and map questions to choice values
 ; expects YTRESP from DLLSTR
 N YTI,YTQSTN,YTCHC
 F YTI=8555:1:8576 S YTRESP(YTI)=""          ; ensure something is there
 S YTI=2 F  S YTI=$O(YSDATA(YTI)) Q:'YTI  D  ; set actual choice values
 . S YTQSTN=$P(YSDATA(YTI),U),YTCHC=$P(YSDATA(YTI),U,3)
 . I YTQSTN=8558!(YTQSTN=8577)!(YTQSTN=8578) D  Q  ; handle text answers
 . . I YTCHC=1155!(YTCHC=1156)!(YTCHC=1157) D  QUIT
 . . . S YTRESP(YTQSTN)="SKIPPED"
 . . S YTRESP(YTQSTN)=$G(YTRESP(YTQSTN))_$P(YSDATA(YTI),U,3,99)
 . S YTRESP(YTQSTN)=$$MAPCHC(YTCHC)
 Q
MAPCHC(YTCHC) ; Map score to choice
 ; expects YSTRNG from DLLSTR
 I YTCHC=1155!(YTCHC=1156)!(YTCHC=1157) Q $S(YSTRNG=2:"SKIPPED",1:0)
 I $D(^YTT(601.75,YTCHC,0)) Q +$P(^YTT(601.75,YTCHC,0),U,2)
 Q YTCHC
 ;
SCORESV ; Save the scores (only used for graphing for PHI)
 ; expects YTRESP from DLLSTR
 K ^TMP($J,"YSCOR")
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 . S ^TMP($J,"YSCOR",1)="[ERROR]"
 . S ^TMP($J,"YSCOR",2)="No Scale found for ADMIN"
 S ^TMP($J,"YSCOR",1)="[DATA]"
 N X,YTI,YTS,YTSCALE
 S YTI=1 F  S YTI=$O(^TMP($J,"YSG",YTI)) Q:'YTI  D
 . S X=^TMP($J,"YSG",YTI) I $E(X,1,5)'="Scale" Q
 . S X=$P(X,"=",2,99)
 . S YTSCALE($P(X,U))=$P(X,U,4)_"="
 S YTS=0,YTI=1 F  S YTS=$O(YTSCALE(YTS)) Q:'YTS  D
 . I YTS=1354 S X=YTRESP(8555) ; Physical Well-Being
 . I YTS=1355 S X=YTRESP(8556) ; Mental Well-Being
 . I YTS=1356 S X=YTRESP(8557) ; Life Day-to-Day
 . I YTS=1357 S X=YTRESP(8559) ; Moving the Body...Now
 . I YTS=1358 S X=YTRESP(8560) ; Moving the Body...To Be
 . I YTS=1359 S X=YTRESP(8561) ; Recharge...Now
 . I YTS=1360 S X=YTRESP(8562) ; Recharge...To Be
 . I YTS=1361 S X=YTRESP(8563) ; Food and Drink...Now
 . I YTS=1362 S X=YTRESP(8564) ; Food and Drink...To Be
 . I YTS=1363 S X=YTRESP(8565) ; Personal Development...Now
 . I YTS=1364 S X=YTRESP(8566) ; Personal Development...To Be
 . I YTS=1365 S X=YTRESP(8567) ; Family, Friends...Now
 . I YTS=1366 S X=YTRESP(8568) ; Family, Friends...To Be
 . I YTS=1367 S X=YTRESP(8569) ; Spirit and Soul...Now
 . I YTS=1368 S X=YTRESP(8570) ; Spirit and Soul...To Be
 . I YTS=1369 S X=YTRESP(8571) ; Surroundings...Now
 . I YTS=1370 S X=YTRESP(8572) ; Surroundings...To Be
 . I YTS=1371 S X=YTRESP(8573) ; Power of the Mind...Now
 . I YTS=1372 S X=YTRESP(8574) ; Power of the Mind...To Be
 . I YTS=1373 S X=YTRESP(8575) ; Professional Care...Now
 . I YTS=1374 S X=YTRESP(8576) ; Professional Care...To Be
 . S YTI=YTI+1,^TMP($J,"YSCOR",YTI)=YTSCALE(YTS)_X
 Q
 ;
REPORT(REFLECT,CARE) ; Set the special text for the report
 ; expects YTRESP from DLLSTR
 N X
 S X=""
 S X=X_"|Physical Well-Being:                           "_YTRESP(8555)
 S X=X_"|Mental/Emotional Well-Being:                   "_YTRESP(8556)
 S X=X_"|Life: How is it to live your day-to-day life?  "_YTRESP(8557)
 S REFLECT=X,X=""
 S X=X_"|Moving the Body                  "_YTRESP(8559)_$$SPACED(8560)
 S X=X_"|Recharge                         "_YTRESP(8561)_$$SPACED(8562)
 S X=X_"|Food and Drink                   "_YTRESP(8563)_$$SPACED(8564)
 S X=X_"|Personal Development             "_YTRESP(8565)_$$SPACED(8566)
 S X=X_"|Family, Friends, and Co-Workers  "_YTRESP(8567)_$$SPACED(8568)
 S X=X_"|Spirit and Soul                  "_YTRESP(8569)_$$SPACED(8570)
 S X=X_"|Surroundings                     "_YTRESP(8571)_$$SPACED(8572)
 S X=X_"|Power of the Mind                "_YTRESP(8573)_$$SPACED(8574)
 S X=X_"|Professional Care                "_YTRESP(8575)_$$SPACED(8576)
 S CARE=X
 Q
SPACED(QSTN) ; Return answer text with aligned spacing
 N SPACES S SPACES="                      "
 Q $E(SPACES,1,21-$L(YTRESP(QSTN-1)))_YTRESP(QSTN)
 ;
WRAPPED(TX,MAX) ; Wrap the response using "|" delimiters
 N OUT,I,J,X,Y,YNEW
 F I=1:1:$L(TX,"|") S X=$P(TX,"|",I) D
 . I $L(X)'>MAX D ADDOUT(X) QUIT
 . S Y=""
 . F J=1:1:$L(X," ") D
 . . S YNEW=Y_$S(J=1:"",1:" ")_$P(X," ",J)
 . . I $L(YNEW)>MAX D ADDOUT(Y) S Y=$P(X," ",J) I 1
 . . E  S Y=YNEW
 . D ADDOUT(Y) ; add any remaining
 S X="",I=0 F  S I=$O(OUT(I)) Q:'I  S X=X_$S(I=1:"",1:"|")_OUT(I)
 Q X
 ;
ADDOUT(S) ; add string to out array (expects OUT)
 S OUT=+$G(OUT)+1,OUT(OUT)=S
 Q
 ;
DLLSTR(YSDATA,YS,YSTRNG) ;
 ; input
 ;   YSDATA(2)=adminId^patientDFN^instrumentName^dateGiven^complete?
 ;   YSDATA(2+n)=questionId^sequence^choiceId
 ;   YS("AD")=adminId
 ;   YSTRNG=1 for score, 2 for report
 ; output if YSTRNG=1
 ;   ^TMP($J,"YSCOR",n)=scaleId=score
 ; output if YSTRNG=2
 ;   append special "answers" to YSDATA
 ;
 N YTRESP
 D DATA1
 I YSTRNG=1 D SCORESV
 I YSTRNG=2 D
 . N REFLECT,CARE,N
 . D REPORT(.REFLECT,.CARE)
 . S N=$O(YSDATA(""),-1) ; get last node
 . S YSDATA(N+1)="7771^9999;1^"_REFLECT
 . S YSDATA(N+2)="7772^9999;1^"_CARE
 . S YSDATA(N+3)="7773^9999;1^"_$$WRAPPED(YTRESP(8558),76)
 . S YSDATA(N+4)="7774^9999;1^"_$$WRAPPED(YTRESP(8577),76)
 . S YSDATA(N+5)="7775^9999;1^"_$$WRAPPED(YTRESP(8578),76)
 Q
