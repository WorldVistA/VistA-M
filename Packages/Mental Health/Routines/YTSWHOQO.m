YTSWHOQO ;SLC/DJE- ANSWERS SPECIAL HANDLING - WHOQOL-BREF ; 10/16/18 9:35am
 ;;5.01;MENTAL HEALTH;**151**;DEC 30,1994;Build 92
 ;
DATA1(SCORE) ;expects YSDATA, returns SCORE, multiple scales so we use nodes i.e. SCORE(SCALEIEN)=###
 ;specialized DATA1 uses SCOREDATA table to map question to score relationships
 N LINE,TEXT,SKIP,SCALE,RAW,NEWVAL,I,TRANSFORM
 F LINE=1:1 S TEXT=$P($T(SCOREDAT+LINE),";",2) Q:TEXT="QUIT"  D
 .N RAWTYPE,QUESTIONS,I
 .S SCALE=$P(TEXT,"|",1) S RAWTYPE=$P(TEXT,"|",2) S QUESTIONS=$P(TEXT,"|",3)
 .F I=1:1:$L(QUESTIONS,U) D
 ..N NODE,DATA
 ..S NODE=$P(QUESTIONS,U,I)+2 ;YSDATA question nodes start at 3
 ..S DATA=YSDATA(NODE)
 ..;retrieval method section. For each RAWTYPE assign a value to RAW
 ..;typical case, YSDATA piece 3 has the MH CHOICE IEN and raw value is in LEGACY field
 ..I RAWTYPE="LEGACY" S RAW=$$GET1^DIQ(601.75,$P($G(DATA),U,3)_",",4,"I")
 ..I RAW="X" S SKIP(SCALE)=$G(SKIP(SCALE))+1 ;Need to keep count of skipped questions
 ..S SCORE(SCALE)=$G(SCORE(SCALE))+RAW
 ;
 ;logic to handle skipped questions.
 S SCALE=""
 F  S SCALE=$O(SKIP(SCALE)) Q:SCALE=""  D
 .I SCALE=884 D  Q
 ..I SKIP(884)>1 S SCORE(884)="" Q
 ..S RAW=SCORE(884)
 ..S NEWVAL=RAW/6,RAW=RAW+$FN(NEWVAL,"",0)  ;set missing value to average of others
 ..S SCORE(884)=RAW
 .;
 .I SCALE=885 S SCORE(885)="" Q
 .;
 .I SCALE=886 S SCORE(886)="" Q
 .;
 .I SCALE=887 D  Q
 ..I SKIP(887)>1 S SCORE(887)="" Q
 ..S RAW=SCORE(887)
 ..S NEWVAL=RAW/6,RAW=RAW+$FN(NEWVAL,"",0)  ;set missing value to average of others
 ..S SCORE(887)=RAW
 ;
 ;logic for t-scores
 F I=1:1:4 D  ;Only 4 scales have transformed scores
 .S RAW=SCORE(883+I) ;1 to 4 -> 884 to 887
 .I RAW="" Q 
 .S TRANSFORM=$$GETTRANS(RAW,I)
 .S SCORE(883+I)=RAW_U_TRANSFORM
 ;
 Q
 ;
 ;SCOREDATA maps questions to their scale and to the method we use to retrieve the raw value. 
 ;A scale can have multiple lines and does not need to match the scalegroup order
 ;You can create your own RAW RETRIEVAL METHOD, just make sure we handle the case in DATA1
SCOREDAT ; SCALE IEN|RAW RETRIEVAL METHOD|QUES#^QUES#...
 ;1307|LEGACY|1
 ;1308|LEGACY|2
 ;884|LEGACY|3^4^10^15^16^17^18
 ;885|LEGACY|5^6^7^11^19^26
 ;886|LEGACY|20^21^22
 ;887|LEGACY|8^9^12^13^14^23^24^25
 ;QUIT
 Q
 ;
SCORESV(SCORE) ;Expects SCORE to be in format SCORE(SCALE_IEN)=###.  Also expects ^TMP($J,"YSG")
 N YSCORNODE,YSGNODE
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 .K ^TMP($J,"YSCOR")
 .S ^TMP($J,"YSCOR",1)="[ERROR]"
 .S ^TMP($J,"YSCOR",2)="No Scale found for ADMIN"
 ;
 K ^TMP($J,"YSCOR")
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S YSCORNODE=2
 S YSGNODE=2 F  S YSGNODE=$O(^TMP($J,"YSG",YSGNODE)) Q:YSGNODE=""  D
 .N SCALEIEN
 .I $E(^TMP($J,"YSG",YSGNODE),1,5)'="Scale" Q  ;only read the lines for scales
 .S SCALEIEN=+$P(^TMP($J,"YSG",YSGNODE),"=",2) ;grab the first number after "=" sign
 .S ^TMP($J,"YSCOR",YSCORNODE)=$$GET1^DIQ(601.87,SCALEIEN_",",3,"I")_"="_SCORE(SCALEIEN)
 .S YSCORNODE=YSCORNODE+1
 ;
 Q
 ;
DLLSTR(YSDATA,YS,YSTRNG) ;
 ;  YSTRNG = 1 Score Instrument
 ;  YSTRNG = 2 get Report Answers and Text
 N SCORE,TSARR
 ;
 I YSTRNG=1 D DATA1(.SCORE),SCORESV(.SCORE)
 ;LDSCORES is not retrieving t-scores for TMP($J,"YSCOR") so we need to run LDTSCOR.
 I YSTRNG=2 D LDTSCOR^YTSCORE(.TSARR,YS("AD")),BUILDANS(.TSARR,.YSDATA)
 Q
 ;
BUILDANS(TSARR,YSDATA) ;
 N SCORE,I
 S N=N+1
 ;
 S YSDATA(N)="7771^9999;1^"_$P(TSARR("QoL"),U,2),N=N+1
 S YSDATA(N)="7772^9999;1^"_$P(TSARR("GenHealth"),U,2),N=N+1
 ;
 S I=3
 F SCORE="PhyHealth","Psy","SocRel","Envi" D
 .N TEXT,RAW,TRANSFORM
 .D  ;do domains with transformed
 ..S RAW=$P(TSARR(SCORE),U,2)
 ..I RAW="" S TEXT="--                    --" D  Q
 ..S TRANSFORM=$P(TSARR(SCORE),U,3)
 ..S TEXT=RAW_"                    "_TRANSFORM
 .S YSDATA(N)="777"_I_"^9999;1^"_TEXT,N=N+1,I=I+1
 ;
 Q
 ;
GETTRANS(RAW,SCOREIDX) ; get the transformed score given a score's raw #
 N TEXT,LOW,RANGE,RETURN
 S TEXT=$P($T(TABLE+SCOREIDX),U,2)
 I TEXT="" Q ""
 S LOW=$P(TEXT,"|"),RANGE=$P(TEXT,"|",2)
 S RETURN=((RAW-LOW)/RANGE)*100
 S RETURN=$FN(RETURN,"",0)   ;$P(RETURN,".")
 Q RETURN
 ;
TABLE ; Transform scores data Score^low score|range
 ; Domain 1 Physical Health^7|28
 ; Domain 2 Psychological^6|24
 ; Domain 3 Social Relationships^3|12
 ; Domain 4 Environment^8|32
 ;
