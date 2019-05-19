YTQAPI2A ;SLC/KCM - MHAX ANSWERS SPECIAL HANDLING ;10/17/16  13:43
 ;;5.01;MENTAL HEALTH;**121,134,123**;Dec 30, 1994;Build 72
 ;
 ; This routine handles limited complex reporting requirements without
 ; modifying YS_AUX.DLL by adding free text "answers" that can be used by
 ; a report.
 ;
 ; Assumptions:  EDIT incomplete instrument should ignore the extra answers
 ; since there are no associated questions.  GRAPHING should ignore the
 ; answers since they not numeric.
 ;
SPECIAL(YSDATA,N,YSAD,YSTSTN) ; add "hidden" computed question text
 ; 123 - 134 need YS array below for call to GETSCORE
 I $G(YSAD) S YS("AD")=YSAD
 S N=N+1
 N TSTNM S TSTNM=$P(YSDATA(2),U,3)
 ;
 I TSTNM="CCSA-DSM5" D  Q
 .N ANS,CHCE,I,LP,RES,SAVEN,SC,STR,TMP
 .D SETARR
 .S LP=2,SAVEN=N
 .F  S LP=$O(YSDATA(LP)) Q:'LP  S RES=$P(YSDATA(LP),U,3) S CHCE=$S(RES=3448:0,RES=3449:1,RES>3449:2) I CHCE D
 ..S ANS=$P(YSDATA(LP),U)
 ..I CHCE=2 D
 ...I (ANS=7216)!(ANS=7217) S TMP(7771)=7771_U_"9999;1^Positive"
 ...I ANS=7218 S TMP(7772)=7772_U_"9999;1^Positive"
 ...I (ANS=7219)!(ANS=7220) S TMP(7773)=7773_U_"9999;1^Positive"
 ...I (ANS=7221)!(ANS=7222)!(ANS=7223) S TMP(7774)=7774_U_"9999;1^Positive"
 ...I (ANS=7224)!(ANS=7225) S TMP(7775)=7775_U_"9999;1^Positive"
 ...I ANS=7229 S TMP(7778)=7778_U_"9999;1^Positive"
 ...I ANS=7230 S TMP(7779)=7779_U_"9999;1^Positive"
 ...I (ANS=7231)!(ANS=7232) S TMP(7780)=7780_U_"9999;1^Positive"
 ...I ANS=7233 S TMP(7781)=7781_U_"9999;1^Positive"
 ...I (ANS=7234)!(ANS=7235) S TMP(7782)=7782_U_"9999;1^Positive"
 ..; CHCE will be 1 here, 3 scales with lower threshold for being positive
 ..I ANS=7226 S TMP(7776)=7776_U_"9999;1^Positive"
 ..I (ANS=7227)!(ANS=7228) S TMP(7777)=7777_U_"9999;1^Positive"
 ..I (ANS=7236)!(ANS=7237)!(ANS=7238) S TMP(7783)=7783_U_"9999;1^Positive"
 .;Calculations completed, need to update TMP array into YSDATA
 .S I=0 F  S I=$O(TMP(I)) Q:'I  S YSDATA(SAVEN)=TMP(I),SAVEN=SAVEN+1
 .Q
 ;
 ; Questions:  3382 = PHQ9 question #9
 ;   Choices:  1008 = Several days, 1009 = More than half the days,
 ;             1010 = Nearly every day
 I TSTNM="PHQ9","^1008^1009^1010^"[(U_$$ANSWER(3382)_U) D  Q
 . S YSDATA(N)="7771^9999;1^Question 9 answered in the POSITIVE direction, additional clinical assessment is indicated."
 ;
 ;
 ;Calculate totals for the CEMI, SIP-2L, and YBOCSII.
 I TSTNM="SIP-2L"!(TSTNM="CEMI")!(TSTNM="YBOCSII") D  Q
 .N LP,TOT,YSCORE,SCALE,SCORE
 .S TOT=0
 .D GETSCORE^YTQAPI8(.YSCORE,.YS)
 .I ^TMP($J,"YSCOR",1)'="[DATA]" Q
 .S LP=1
 .F  S LP=$O(^TMP($J,"YSCOR",LP)) Q:'LP  D
 ..; run this code to get the total score for SIP-2L, CEMI, YBOCSII
 ..S TOT=TOT+$P(^TMP($J,"YSCOR",LP),"=",2)
 ..S YSDATA(N)="7772^9999;1^"_TOT
 ..;
 ;
 I $L($T(SPECIAL^YTQAPI2B)) D SPECIAL^YTQAPI2B(TSTNM,.YSDATA,N,.YSAD,.YSTSTN) Q
 Q
 ;
ANSWER(QID) ; return answer given question ID
 N ANS,I
 S ANS=""
 S I=2 F  S I=$O(YSDATA(I)) Q:'I  D  Q:$L(ANS)
 . I $P(YSDATA(I),U)=QID S ANS=$P(YSDATA(I),U,3)
 Q ANS
 ;
SETARR ; set YSDATA(ARR) for the customized questions 
 F I=1:1 S STR=$T(SCLGRP+I) Q:$P(STR,";;",2)="Q"  D 
 .S SC=$P($P(STR,";;",2),";",3)
 .S TMP(SC)=SC_U_"9999;1^Negative"
 Q
 ;
SCLGRP ;; Scale grouping for the CCSA-DSM5 ;;QIEN^QIEN;Scale Name;custom question to display;
 ;;7216^7217;Depression;7771;
 ;;7218;Anger;7772;
 ;;7219^7220;Mania;7773;
 ;;7221^7222^7223;Anxiety;7774;
 ;;7224^7225;Somatic Symptoms;7775;
 ;;7226;Suicidal Ideation;7776
 ;;7227^7228;Psychosis;7777;
 ;;7229;Sleep Problems;7778;
 ;;7230;Memory;7779;
 ;;7231^7232;Repetitive Thoughts and Behaviors;7780;
 ;;7233;Dissociation;7781;
 ;;7334^7235;Personality Functioning;7782;
 ;;7236^7237^7238;Substance Use;7783;
 ;;Q
 Q
 ;
