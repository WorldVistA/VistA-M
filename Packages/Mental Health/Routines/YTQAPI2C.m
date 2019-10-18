YTQAPI2C ;SLC/BLD- MHAX ANSWERS SPECIAL HANDLING #2 ;2/7/2018  17:35
 ;;5.01;MENTAL HEALTH;**136,139**;Dec 30, 1994;Build 134
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
SPECIAL(TSTNM,YSDATA,N,YSAD,YSTSTN) ; add "hidden" computed question text
 N ANSWER,DEPSCORE,IEN,KEY,LP,PCT,PTSD,SATTSCORE,SCORES,SCRE,SUCSCORE,SUISCORE,SWHENSCORES,TEXT,TEXT1,TEXT2
 N TEXT2A,TEXT2B,TOT,YSCORE,YSCREC,SUISCRN,ALLQUES,POSTXT1,POSTXT2,QUE1621,QUE67,QUE915,YSBPRS
 ;
 ;bld/dsb 4/19/2018 Complex Reporting for BPRS-A
 I TSTNM="BPRS-A" D  Q
 .N LP,TOT,YSCORE,TOTARRAY,TOTDIST,TOTANX,TOTPARNA,TOTWITH,TOTPATH,YSBPRS
 .S TOT=0,TOTARRAY="",YSCORE="",II=1
 .D GETSCORE^YTQAPI8(.YSCORE,.YS)
 .I ^TMP($J,"YSCOR",1)'="[DATA]" Q
 .F I=3:1 Q:'$D(YSDATA(I))  S YSBPRS(I-2)=$$GET1^DIQ(601.75,$P(YSDATA(I),"^",3)_",",4,"I")
 .;D YSARRAY(.YSBPRS)
 .S TOTDIST=YSBPRS(4)+(YSBPRS(12))+YSBPRS(15)   ;Thinking Disturbance 
 .S TOTANX=YSBPRS(2)+(YSBPRS(5))+YSBPRS(9)     ;Anxious Depression
 .S TOTPARNA=YSBPRS(10)+(YSBPRS(11))+YSBPRS(14)    ;Paranoid Disturbances
 .S TOTWITH=YSBPRS(3)+(YSBPRS(13))+YSBPRS(16)   ;Withdrawal Retardation 
 .F I=1:1:16 S TOTPATH=$G(TOTPATH)+YSBPRS(I)   ;TOTAL PATHOLOGY SCORE
 .S YSDATA(N)="7771^9999;1^"_TOTDIST,N=N+1
 .S YSDATA(N)="7772^9999;1^"_TOTANX,N=N+1
 .S YSDATA(N)="7773^9999;1^"_TOTPARNA,N=N+1
 .S YSDATA(N)="7774^9999;1^"_TOTWITH,N=N+1
 .S YSDATA(N)="7775^9999;1^"_TOTPATH,N=N+1
 .S YSDATA(N)="7776^9999;1^"_"In the past week.",N=N+1
 .Q
 ;
 ;bld 4/19/2018 logic for PSS-3 2nd Report
 ;
 I TSTNM="PSS-3 2ND" D  Q
 .N I,OLDN,SCORE,SC,TEXT,QNBR,QNBRTXT,QNBR,POSTXT,LEN,LSTQNBR,QUENBR,TMP,POSTXT1,POSTXT2,POSTXT3,YSARRY
 .S N=N+1,OLDN=N
 .D GETSCORE^YTQAPI8(.YSCORE,.YS)
 .I ^TMP($J,"YSCOR",1)'="[DATA]" Q
 .D YSARRAY(.YSARRY)
 .M TMP=^TMP($J,"YSCOR")
 .S POSTXT1="Presence of one or more Positive Indicators means that, in addition to any immediate suicide "
 .S POSTXT2="safety measures, the treating provider should consider consulting a mental consulting a mental "
 .S POSTXT3="health professional. 'Yes' indicates a positive response. 'No' indicates a negative response."
 .;
 .S QUENBR=7771
 .F I=1:1:7 S SCORE=$S($G(SCORE)="":$P(TMP(I),"=",2),1:SCORE_"^"_$P(TMP(I),"=",2))
 .S YSDATA(N)="7780^9999;1^"_POSTXT1 S N=N+1
 .S YSDATA(N)="7781^9999;1^"_POSTXT2 S N=N+1
 .S YSDATA(N)="7782^9999;1^"_POSTXT3 S N=N+1
 .I $P(SCORE,U,1)=1 S YSDATA(N)=QUENBR_"^9999;1^Active suicide ideation with a past attempt." S N=N+1,QUENBR=QUENBR+1  ;QUESTION 1
 .I $P(SCORE,U,2)=1 S YSDATA(N)=QUENBR_"^9999;1^Has or recently begun a suicide plan." S N=N+1,QUENBR=QUENBR+1   ;QUESTION 2
 .I $P(SCORE,U,3)=1 S YSDATA(N)=QUENBR_"^9999;1^Reports recent intent to act on suicidal ideation." S N=N+1,QUENBR=QUENBR+1   ;QUESTION 3
 .I $P(SCORE,U,4)=1 S YSDATA(N)=QUENBR_"^9999;1^Has a past psychiatric hospitalization." S N=N+1,QUENBR=QUENBR+1     ;QUESTION 4
 .I $P(SCORE,U,5)=1 S YSDATA(N)=QUENBR_"^9999;1^Has a pattern of excessive substance use." S N=N+1,QUENBR=QUENBR+1    ;QUESTION 5
 .I $P(SCORE,U,6)=1 S YSDATA(N)=QUENBR_"^9999;1^Currently presents with irritable, agitated, and/or aggressive behavior." S N=N+1,QUENBR=QUENBR+1   ;QUESTION 6
 .I SCORE'[1 S YSDATA(N)=QUENBR_"^9999;1^None" S N=N+1,QUENBR=QUENBR+1
 .S SC="" F I=1:1:6 I $P(SCORE,"^",I)>2 S SC=$S($G(SC)="":$P(SCORE,"^",I),1:SC_"^"_$P(SCORE,"^",I)),SC(I)=$P(SCORE,"^",I)
 .S LEN=$S($G(SC)="":0,1:$L(SC,"^"))
 .S TEXT=": The response was either Refused or Unable to Complete."
 .;
 .I LEN>0 D
 ..S QUENBR=7778
 ..S QNBR="",LSTQNBR=$O(SC(QNBR),-1)
 ..F I=1:1:LSTQNBR S QNBR=$O(SC(QNBR)) Q:'QNBR  D  Q:('$D(SC(QNBR)))!(QNBR>LSTQNBR)
 ...S QNBRTXT=$S($G(QNBRTXT)="":QNBR,QNBR'=LSTQNBR:QNBRTXT_", "_QNBR,1:QNBRTXT_" and "_QNBR)
 ..;
 ..S YSDATA(N)=QUENBR_"^9999;1^Question "_QNBRTXT_TEXT
 ;
 I TSTNM="PCL-5 WEEKLY" D  Q
 .Q
 .N OLDN,QUE15,QUE67,QUE915,QUE1621,CLUSTERB,CLUSTERC,CLUSTERD,CLUSTERE,TOTAL
 .S N=N+1
 .D GETSCORE^YTQAPI8(.YSCORE,.YS)
 .I ^TMP($J,"YSCOR",1)'="[DATA]" Q
 .M TMP=^TMP($J,"YSCOR")
 .S CLUSTERB=$P(^TMP($J,"YSCOR",3),"=",2)
 .S CLUSTERC=$P(^TMP($J,"YSCOR",4),"=",2)
 .S CLUSTERD=$P(^TMP($J,"YSCOR",5),"=",2)
 .S CLUSTERE=$P(^TMP($J,"YSCOR",6),"=",2)
 .S TOTAL=CLUSTERB+CLUSTERC+CLUSTERD+CLUSTERE
 .S YSDATA(N)="7771^9999;1^"_TOTAL S N=N+1
 .S YSDATA(N)="7772^9999;1^"_CLUSTERB S N=N+1
 .S YSDATA(N)="7773^9999;1^"_CLUSTERC S N=N+1
 .S YSDATA(N)="7774^9999;1^"_CLUSTERD S N=N+1
 .S YSDATA(N)="7775^9999;1^"_CLUSTERE S N=N+1
 ;
 ;Heavness in Smoking Index
 I TSTNM="HSI" D  Q
 .N QUE1,QUE2,ANS1,TXT1,TXT2,TXT3,DEPENCE,INDEX,SAMPLE1,SAMPLE2,SCOREINFO
 .S N=N+1
 .D GETSCORE^YTQAPI8(.YSCORE,.YS)
 .I ^TMP($J,"YSCOR",1)'="[DATA]" Q
 .M TMP=^TMP($J,"YSCOR")
 .S ANS1=$P(TMP(2),"=",2)
 .S TOT=ANS1
 .S SAMPLE1=5,SAMPLE2="""high"""
 .S DEPENCE=$S(TOT=0:"NO nicotine dependence",12[TOT:"LOW nicotine dependence",34[TOT:"MODERATE nicotine dependence",1:"HIGH nicotine dependence")
 .S TXT1="("_TOT_" represents the sum of points for each question and "_DEPENCE
 .S TXT2="is the associated dependence level for that score from below, e.g., a Nicotine"
 .S TXT3=" Dependence Score of """_SAMPLE1_""""_" would indicate "_SAMPLE2_" nicotine dependence.)"
 .S SCOREINFO=TXT1_TXT2
 .S INDEX="HEAVINESS OF SMOKING INDEX: "_TOT_" indicating "_DEPENCE
 .S YSDATA(N)="7771^9999;1^"_INDEX S N=N+1
 .S YSDATA(N)="7772^9999;1^"_TXT1 S N=N+1
 .S YSDATA(N)="7773^9999;1^"_TXT2 S N=N+1
 .S YSDATA(N)="7774^9999:1^"_TXT3 S N=N+1
 ;
 I TSTNM="WEMWBS" D  Q
 .N I,SCORE,TEXT
 .S N=N+1,SCORE=0
 .D GETSCORE^YTQAPI8(.YSCORE,.YS)
 .I ^TMP($J,"YSCOR",1)'="[DATA]" Q
 .M TMP=^TMP($J,"YSCOR")
 .S SCORE=$P(^TMP($J,"YSCOR",2),"=",2)
 .S TEXT="WEMWBS Total Score: ",TEXT=TEXT_SCORE
 .S YSDATA(N)="7771^9999;1^"_TEXT
 ;
 ;
 I TSTNM="MHRM" D  Q
 .N I,SCORE,TEXT,YSTOTAL,YSMHRM,II,YSCALEI,YSKEYI,YSQN,YSTARG,YSVAL,YSAI,YSAN,YSOS,YSSE,YSLS,YSBF,YSOW,YSNP,YSSP,YSAE,G
 .S N=N+1,SCORE=0,II=1,YSTOTAL=0
 .S (YSOS,YSSE,YSLS,YSBF,YSOW,YSNP,YSSP,YSAE)=0
 .D GETSCORE^YTQAPI8(.YSCORE,.YS)
 .F I=2:1 Q:'$D(^TMP($J,"YSG",I))  I ^TMP($J,"YSG",I)?1"Scale".E D
 .. S YSCALEI=$P(^TMP($J,"YSG",I),U),YSCALEI=$P(YSCALEI,"=",2)
 .. S YSKEYI=0 F  S YSKEYI=$O(^YTT(601.91,"AC",YSCALEI,YSKEYI)) Q:YSKEYI'>0  D
 ...S G=^YTT(601.91,YSKEYI,0)
 ...S YSQN=$P(G,U,3),YSTARG=$P(G,U,4),YSVAL=$P(G,U,5)
 ...S YSAI=$O(^YTT(601.85,"AC",YSAD,YSQN,0))
 ...Q:YSAI'>0
 ...Q:'$D(^YTT(601.85,YSAI,0))
 ...S YSAN=""
 ...I $D(^YTT(601.85,YSAI,1,1,0)) S YSAN=^YTT(601.85,YSAI,1,1,0)
 ...I $P(^YTT(601.85,YSAI,0),U,4)?1N.N S YSAN=$P(^YTT(601.85,YSAI,0),U,4),YSAN=$G(^YTT(601.75,YSAN,1))
 ...I YSAN=YSTARG S YSMHRM(II)=YSVAL,II=II+1 ;S ^TMP($J,"TEST",II,YSQN,YSAN,YSTARG)=YSVAL
 .;
 .F I=1:1:4 S YSOS=YSOS+$G(YSMHRM(I))                ;Overcoming Stuckness
 .F I=5:1:8 S YSSE=YSSE+$G(YSMHRM(I))                ;Self-Empowerment
 .F I=9:1:12 S YSLS=YSLS+$G(YSMHRM(I))               ;Learning and Self-redefinition
 .F I=13:1:16 S YSBF=YSBF+$G(YSMHRM(I))              ;Basic Functioning
 .F I=17:1:20 S YSOW=YSOW+$G(YSMHRM(I))              ;Overall Well Being
 .F I=21:1:24 S YSNP=YSNP+$G(YSMHRM(I))              ;New Potentials
 .F I=25:1:26 S YSSP=YSSP+$G(YSMHRM(I))              ;Spirituality
 .F I=27:1:30 S YSAE=YSAE+$G(YSMHRM(I))              ;Advocacy/Enrichment
 .;
 .S YSTOTAL=$P(^TMP($J,"YSCOR",2),"=",2)
 .S YSDATA(N)="7771^9999;1^"_YSTOTAL,N=N+1
 .S YSDATA(N)="7772^9999;1^"_YSOS,N=N+1
 .S YSDATA(N)="7773^9999;1^"_YSSE,N=N+1
 .S YSDATA(N)="7774^9999;1^"_YSLS,N=N+1
 .S YSDATA(N)="7775^9999;1^"_YSBF,N=N+1
 .S YSDATA(N)="7776^9999;1^"_YSOW,N=N+1
 .S YSDATA(N)="7777^9999;1^"_YSNP,N=N+1
 .S YSDATA(N)="7778^9999;1^"_YSSP,N=N+1
 .S YSDATA(N)="7779^9999;1^"_YSAE,N=N+1
 ;
 I $L($T(SPECIAL^YTQAPI2D)) D SPECIAL^YTQAPI2D(TSTNM,.YSDATA,N,.YSAD,.YSTSTN)
 Q
 ;
 ;************************************************************************
 ;  ADD ADDITONAL INSTRUMENT LOGIC ABOVE THE FIRST *** LINE
 ;************************************************************************
  ;
YSARRAY(YSARRAY) ;
 N II,YSVAL,YSCALEI,YSKEYI,G,YSQN,YSAI,YSAN,YSTARG
 K YSARRAY
 S II=1
 F I=2:1 Q:'$D(^TMP($J,"YSG",I))  I ^TMP($J,"YSG",I)?1"Scale".E D
 . S YSCALEI=$P(^TMP($J,"YSG",I),U),YSCALEI=$P(YSCALEI,"=",2)
 . S YSKEYI=0 F  S YSKEYI=$O(^YTT(601.91,"AC",YSCALEI,YSKEYI)) Q:YSKEYI'>0  D
 ..S G=^YTT(601.91,YSKEYI,0)
 ..S YSQN=$P(G,U,3),YSTARG=$P(G,U,4),YSVAL=$P(G,U,5)
 ..S YSAI=$O(^YTT(601.85,"AC",YSAD,YSQN,0))
 ..Q:YSAI'>0
 ..Q:'$D(^YTT(601.85,YSAI,0))
 ..S YSAN=""
 ..I $D(^YTT(601.85,YSAI,1,1,0)) S YSAN=^YTT(601.85,YSAI,1,1,0)
 ..I $P(^YTT(601.85,YSAI,0),U,4)?1N.N S YSAN=$P(^YTT(601.85,YSAI,0),U,4),YSAN=$G(^YTT(601.75,YSAN,1))
 ..I YSAN=YSTARG S YSARRAY(II)=YSVAL,II=II+1
 Q
