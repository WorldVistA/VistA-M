YTSQOLI ;SLC/PIJ - Score QOLI ; 01/08/2016
 ;;5.01;MENTAL HEALTH;**123,142**;DEC 30,1994;Build 14
 ;
 ;Public, Supported ICRs
 ; #2056 - Fileman API - $$GET1^DIQ
 ;
 Q
 ;
DATA1 ;
 N RAWSCORE
 S RAWSCORE=0
 S YSINSNAM=$P($G(YSDATA(2)),U,3)
 I $G(YSINSNAM)="" S YSINSNAM=$G(YS("CODE"),"NO NAME PASSED")
 S NODE=2 F  S NODE=$O(YSDATA(NODE)) Q:NODE=""  D
 .S DATA=YSDATA(NODE)
 .S YSQN=$P(DATA,U,1)
 .S YSCDA=$P($G(DATA),U,3)
 .D DESGNTR^YTSCORE(YSQN,.DES)
 .S LEG=$$GET1^DIQ(601.75,YSCDA_",",4,"I")
 .I (YSCDA=1155)!(YSCDA=1156) S LEG=1155 ; Skipped
 .I YSCDA=3131 S LEG=0  ; Not Important
 .I YSCDA=3132 S LEG=1  ; Important
 .I YSCDA=3133 S LEG=2  ; Extremely Important
 .I YSCDA=1718 S LEG=0  ; S LEG=-3   ; Very dissatisfied (prior to 139)
 .I YSCDA=4110 S LEG=0  ; S LEG=-3   ; Very dissatisfied
 .I YSCDA=2357 S LEG=1  ; S LEG=-2   ; Somewhat dissatisfied
 .I YSCDA=3134 S LEG=2  ; S LEG=-1   ; A little dissatisfied
 .I YSCDA=3135 S LEG=3  ; S LEG=1    ; A little satisfied
 .I YSCDA=2356 S LEG=4  ; S LEG=2    ; Somewhat satisfied
 .I YSCDA=1714 S LEG=5  ; S LEG=3    ; Very satisfied    (prior to 139)
 .I YSCDA=4109 S LEG=5  ; S LEG=3    ; Very satisfied
 .D SCORANS
 D SCORANS1
 Q
 ;
STRING ;
 S INDENT="   "
 ; The reason for the next 3 lines is that the QOLI calculation does not add zeros to the result
 ; e.g. the RAW score = .8, s/b 0.8
 I (RAW="-.0")!(RAW="0.0") S RAW=0
 ;
 S TSCORE=$$GETTSCOR^YTSQOLI1(RAW,WGHTSAT0,WGHTSAT99)
 S SCORESTR=$$GETPSCOR^YTSQOLI1(RAW,WGHTSAT0,WGHTSAT99)
 F I=1:1:TSCORE S TSCORBAR=TSCORBAR_"*"
 ;
 S STRING=STRING_INDENT_"||(Raw Score: "_RAW_")"
 S STRING=STRING_INDENT_"| T Score: "_TSCORE
 S STRING=STRING_INDENT_"|(%ile Score: "_SCORESTR_")"
 S STRING=STRING_INDENT_"||Overall Quality of Life"
 S STRING=STRING_INDENT_"||            VERY LOW             LOW        AVERAGE              HIGH"
 S STRING=STRING_INDENT_"|-----------------------------------------------------------------------------"
 S STRING=STRING_INDENT_"|"_TSCORBAR
 S STRING=STRING_INDENT_"|-----------------------------------------------------------------------------"
 S STRING=STRING_INDENT_"|:                                  :      :               :                 :"
 S STRING=STRING_INDENT_"|0                                 37     43              58                77"
 S STRING=STRING_INDENT_"|||Weighted Satisfaction Profile"
 S STRING=STRING_INDENT_"||                   DISSATISFACTION       SATISFACTION"
 S STRING=STRING_INDENT_"|                  -6  -4  -3  -2  -1   0   1   2   3   4   6"
 S STRING=STRING_INDENT_"|                 ---------------------------------------------"
 ;
 D PADINFO("Health",SCALE(1))
 D PADINFO("Self-Esteem",SCALE(2))
 D PADINFO("Goals-and-Values",SCALE(3))
 D PADINFO("Money",SCALE(4))
 D PADINFO("Work",SCALE(5))
 D PADINFO("Play",SCALE(6))
 D PADINFO("Learning",SCALE(7))
 D PADINFO("Creativity",SCALE(8))
 D PADINFO("Helping",SCALE(9))
 D PADINFO("Love",SCALE(10))
 D PADINFO("Friends",SCALE(11))
 D PADINFO("Children",SCALE(12))
 D PADINFO("Relatives",SCALE(13))
 D PADINFO("Home",SCALE(14))
 D PADINFO("Neighborhood",SCALE(15))
 D PADINFO("Community",SCALE(16))
 ;
 S STRING=STRING_INDENT_"|                 ---------------------------------------------"
 S STRING=STRING_INDENT_"|                  -6  -4  -3  -2  -1   0   1   2   3   4   6"
 ;
 S STRING=STRING_"||||"_INDENT_"|The following weighted satisfaction ratings indicate areas of dissatisfaction"
 S STRING=STRING_"|for this person:"
 S STRING=STRING_"||"_INDENT_"                     Weighted "
 S STRING=STRING_"|Area              Satisfaction Rating"
 S STRING=STRING_"|----              -------------------"
 D SORTSAT^YTSQOLI1
 ;
 S STRING=STRING_"|||OMITTED ITEMS"
 I OMITITEM'="" S STRING=STRING_"|"_INDENT_$E(OMITITEM,1,$L(OMITITEM)-1)
 I OMITITEM="" S STRING=STRING_"|"_INDENT_"None omitted"
 ; Response summary, but first convert any response of -99 to ''
 S STRING=STRING_"||ITEM RESPONSES|"
 S STRING=STRING_"|"
 ;
 F I=1:1:9 S STRING=STRING_" "_$P(RESPONSE,"|",I)_INDENT
 S STRING=STRING_" "_$P(RESPONSE,"|",10)_"|"
 F I=11:1:19 S STRING=STRING_$P(RESPONSE,"|",I)_INDENT
 S STRING=STRING_" "_$P(RESPONSE,"|",20)_"|"
 F I=21:1:29 S STRING=STRING_$P(RESPONSE,"|",I)_INDENT
 S STRING=STRING_" "_$P(RESPONSE,"|",30)_"|"
 F I=31:1:32 S STRING=STRING_$P(RESPONSE,"|",I)_INDENT
 S STRING=STRING_"|"
 Q
 ;
PADINFO(NAME,SC) ;
 N I,PAD,PAD1,SP,Z,Z1
 S (PAD,PAD1,SP,Z,Z1)=""
 F I=1:1:(16-$L(NAME)) S SP=SP_" "
 S PAD=$S(SC="-6":2,SC="-4":6,SC="-3":10,SC="-2":14,SC="-1":18,SC="0":22,SC="1":26,SC="2":30,SC="3":34,SC="4":38,SC="6":42,1:"")
 F I=1:1:PAD S Z=Z_" "
 S PAD1=61-($L(SP)+$L(NAME)+$L(Z)+1)
 F I=1:1:PAD1 S Z1=Z1_" "
 S STRING=STRING_"|"_SP_NAME_":"_Z_"*"_Z1_":"_NAME
 Q
 ;
SCORANS ; 
 S TMPRSLT=LEG
 S TMPANS=YSCDA
 S (RESULT)=""
 ;
 ; must convert entered response of 1 (itemindex=0) to 1 for display
 S ITEMSCOR(DES)=$S(TMPRSLT=0:1,TMPRSLT=1:2,TMPRSLT=2:3,TMPRSLT=3:4,TMPRSLT=4:5,TMPRSLT=5:6,1:"")
 ;
 ; no conversion yet, itemIndex will be non negative, if unanswered
 I (TMPANS=1155) D
 .S TMPSCALE(DES)="-99"
 .S OMITITEM=OMITITEM_DES_","
 E  D
 .S TMPSCALE(DES)=TMPRSLT   ; TMPANS
 ; need to have a 2nd question before can do any calculations
 I (DES=1) S RESPONSE=RESPONSE_DES_":"_ITEMSCOR(DES)_"|" Q
 ; getting even numbered questions, satisfaction rating, needs conversion
 ; importance rating does not need any conversion.
 I (DES#2)=0 D
 .S TMPSCALE(DES)=$S(TMPSCALE(DES)=0:"-3",TMPSCALE(DES)=1:"-2",TMPSCALE(DES)=2:"-1",TMPSCALE(DES)=3:"1",TMPSCALE(DES)=4:"2",TMPSCALE(DES)=5:"3",1:TMPSCALE(DES))
 .; compute the scale, -99 = unendorsed
 .I (DES=26),(TMPSCALE(DES-1)=0),(TMPSCALE(DES)="-99") D
 ..S SCALE(DES/2)=0
 .; else if
 .E  D
 ..I (TMPSCALE(DES-1)="-99")!(TMPSCALE(DES)="-99") D
 ...S SCALE(DES/2)="-99"
 .E  D
 ..S SCALE(DES/2)=(TMPSCALE(DES-1)*TMPSCALE(DES))
 .; compute the raw score and determine if a valid importance item (odd # question)
 .I SCALE(DES/2)'="-99" D
 ..S RAWSCORE=RAWSCORE+(SCALE(DES/2))
 ..I (TMPSCALE(DES-1)>0) S VALIDSCR=VALIDSCR+1
 .; used to compute invalid percentile score
 .I SCALE(DES/2)=0 S WGHTSAT0=WGHTSAT0+1
 .I SCALE(DES/2)="-99" S WGHTSAT99=WGHTSAT99+1
 ;collect value of all individual questions with the value entered
 S RESPONSE=RESPONSE_DES_":"_ITEMSCOR(DES)_"|"
 Q
 ;
SCORANS1 ;
 ; compute rawScore
 I (VALIDSCR=0) S RAWSCORE="0.05"
 I (VALIDSCR'=0) S RAWSCORE=$J(((RAWSCORE/VALIDSCR)+.05),0,1)
 S RAW=$P(RAWSCORE,".",1)_"."_$E($P(RAWSCORE,".",2),0,1)
 Q
SCORESV ;
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 .K ^TMP($J,"YSCOR")
 .S ^TMP($J,"YSCOR",1)="[ERROR]"
 .S ^TMP($J,"YSCOR",2)=YSINSNAM_" Scale not found"
 ;
 K ^TMP($J,"YSCOR")
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S ^TMP($J,"YSCOR",2)=$$GET1^DIQ(601.87,762_",",3,"I")_"="_SCALE("1")
 S ^TMP($J,"YSCOR",3)=$$GET1^DIQ(601.87,763_",",3,"I")_"="_SCALE("2")
 S ^TMP($J,"YSCOR",4)=$$GET1^DIQ(601.87,764_",",3,"I")_"="_SCALE("3")
 S ^TMP($J,"YSCOR",5)=$$GET1^DIQ(601.87,765_",",3,"I")_"="_SCALE("4")
 S ^TMP($J,"YSCOR",6)=$$GET1^DIQ(601.87,766_",",3,"I")_"="_SCALE("5")
 S ^TMP($J,"YSCOR",7)=$$GET1^DIQ(601.87,767_",",3,"I")_"="_SCALE("6")
 S ^TMP($J,"YSCOR",8)=$$GET1^DIQ(601.87,768_",",3,"I")_"="_SCALE("7")
 S ^TMP($J,"YSCOR",9)=$$GET1^DIQ(601.87,769_",",3,"I")_"="_SCALE("8")
 S ^TMP($J,"YSCOR",10)=$$GET1^DIQ(601.87,770_",",3,"I")_"="_SCALE("9")
 S ^TMP($J,"YSCOR",11)=$$GET1^DIQ(601.87,771_",",3,"I")_"="_SCALE("10")
 S ^TMP($J,"YSCOR",12)=$$GET1^DIQ(601.87,772_",",3,"I")_"="_SCALE("11")
 S ^TMP($J,"YSCOR",13)=$$GET1^DIQ(601.87,773_",",3,"I")_"="_SCALE("12")
 S ^TMP($J,"YSCOR",14)=$$GET1^DIQ(601.87,774_",",3,"I")_"="_SCALE("13")
 S ^TMP($J,"YSCOR",15)=$$GET1^DIQ(601.87,775_",",3,"I")_"="_SCALE("14")
 S ^TMP($J,"YSCOR",16)=$$GET1^DIQ(601.87,776_",",3,"I")_"="_SCALE("15")
 S ^TMP($J,"YSCOR",17)=$$GET1^DIQ(601.87,777_",",3,"I")_"="_SCALE("16")
 Q
 ;
DLLSTR(YSDATA,YS,YSTRNG) ;
 ;  YSTRNG = 1 Score Instrument
 ;  YSTRNG = 2 get Report Answers and Text
 N DATA,DES,I,NODE,LEG,YSQN,YSCDA,INDENT,TMPANS
 N YSINSNAM,ITEMSCOR,SCALE,TMPSCALE
 N TMPRSLT,VALIDSCR
 N SCORESTR,TSCORBAR,TSCORE,OMITTED,FLAG
 N OMITITEM,RESPONSE,STRING,STRING1
 N PROTECT,USE,RISK,RESULT
 N RAW,WGHTSAT0,WGHTSAT99
 ;
 S (TSCORE,SCORESTR,VALIDSCR)=0
 S (OMITTED,TSCORBAR)=""
 ;
 F I=1:1:32 S TMPSCALE(I)=0
 F I=1:1:32 S ITEMSCOR(I)=""
 F I=1:1:16 S SCALE(I)=0,SCALE(I_"."_5)=0
 ;
 S (OMITITEM,RESPONSE,STRING,STRING1)=""
 S (PROTECT,USE,RISK)=0
 S (RAW,WGHTSAT0,WGHTSAT99)=0
 S TMPRSLT=0
 ;
 D DATA1
 ;
 I YSTRNG=1 D SCORESV
 ;
 I YSTRNG=2 D
 .D LDSCORES^YTSCORE(.YSDATA,.YS)
 .D STRING
 .S YSDATA($O(YSDATA(""),-1)+1)=999999999999_U_U_STRING
 Q
