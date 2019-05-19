YTSWHODA ;SLC/PIJ - Score WHODAS 2; 01/08/2016
 ;;5.01;MENTAL HEALTH;**123**;DEC 30,1994;Build 72
 ;
 ;Public, Supported ICRs
 ; #2056 - Fileman API - $$GET1^DIQ
 ;
 Q
 ;
DESGNTR(YSQN,DES) ; 
 ; Can't call DESGNTER in YTSCORE: YTSWHODA uses entire designator, expects to see D#.#, not D.
 N STR76
 S DES="NO DESIGNATOR"
 Q:'$G(YSQN)
 S STR76=$O(^YTT(601.76,"AE",YSQN,0))
 Q:'$G(STR76)
 S DES=$P($G(^YTT(601.76,STR76,0)),U,5)
 Q
DATA1 ;
 S YSINSNAM=$P(YSDATA(2),U,3)
 I $G(YSINSNAM)="" S YSINSNAM=$G(YS("CODE"),"NO NAME PASSED")
 S NODE=2 F  S NODE=$O(YSDATA(NODE)) Q:NODE=""  D
 .S DATA=YSDATA(NODE)
 .S YSQN=$P(DATA,U,1)
 .S YSSEQ=$P(DATA,U,2),YSSEQ=$P(YSSEQ,";",1)
 .S YSCDA=$P($G(DATA),U,3)
 .D DESGNTR(YSQN,.DES)
 .S LEG=$$GET1^DIQ(601.75,YSCDA_",",4,"I")
 .;
 .I YSCDA=3035 S LEG=4  ; Extreme or cannot do
 .I YSCDA=5 S LEG=3     ; Severe
 .I YSCDA=4 S LEG=2     ; Moderate
 .I YSCDA=3 S LEG=1     ; Mild
 .I YSCDA=1 S LEG=0     ; None
 .;
 .I YSCDA=1156 Q             ; "Not asked (due to responses on other questions)"
 .; If question = "SKIPPED"
 .I LEG="X" D  Q  ; YSCDA = 1155 = Skipped
 ..I $P(DES,".",1)="D1" S COGM=COGM+1 Q
 ..I $P(DES,".",1)="D2" S MOBILM=MOBILM+1 Q
 ..I $P(DES,".",1)="D3" S SELFM=SELFM+1 Q
 ..I $P(DES,".",1)="D4" S ALONGM=ALONGM+1 Q
 ..I $P(DES,".",1)="D5" D  Q
 ...I (DES>="D5.1"),(DES<="D5.4") D  Q
 ....S LIFE1M=LIFE1M+1
 ...I (DES>="D5.5"),(DES<="D5.8") D  Q
 ....S LIFE2M=LIFE2M+1
 ..I $P(DES,".",1)="D6" S PARTM=PARTM+1 Q
 .; Cognition
 .I (DES="D1.1") S COG=COG+LEG Q
 .I (DES="D1.2") S COG=COG+LEG Q
 .I (DES="D1.3") S COG=COG+LEG Q
 .I (DES="D1.4") S COG=COG+LEG Q
 .I (DES="D1.5") D  Q
 ..I (LEG=1)!(LEG=2) S COG=COG+1 Q
 ..I (LEG=3)!(LEG=4) S COG=COG+2 Q
 .I (DES="D1.6") D  Q
 ..I (LEG=1)!(LEG=2) S COG=COG+1 Q
 ..I (LEG=3)!(LEG=4) S COG=COG+2 Q
 .;
 .;Getting around - Mobility
 .I (DES="D2.1") S MOBIL=MOBIL+LEG Q
 .I (DES="D2.2") D  Q
 ..I (LEG=1)!(LEG=2) S MOBIL=MOBIL+1 Q
 ..I (LEG=3)!(LEG=4) S MOBIL=MOBIL+2 Q
 .I (DES="D2.3") D  Q
 ..I (LEG=1)!(LEG=2) S MOBIL=MOBIL+1 Q
 ..I (LEG=3)!(LEG=4) S MOBIL=MOBIL+2 Q
 .I (DES="D2.4") S MOBIL=MOBIL+LEG Q
 .I (DES="D2.5") S MOBIL=MOBIL+LEG Q
 .;
 .; Self-Care
 .I (DES="D3.1") D  Q
 ..I (LEG=1)!(LEG=2) S SELF=SELF+1 Q
 ..I (LEG=3)!(LEG=4) S SELF=SELF+2 Q
 .I (DES="D3.2") S SELF=SELF+LEG Q
 .I (DES="D3.3") D  Q
 ..I (LEG=1)!(LEG=2) S SELF=SELF+1 Q
 ..I (LEG=3)!(LEG=4) S SELF=SELF+2 Q
 .I (DES="D3.4") D  Q
 ..I (LEG=1)!(LEG=2) S SELF=SELF+1 Q
 ..I (LEG=3)!(LEG=4) S SELF=SELF+2 Q
 .;
 .; Getting Along
 .I (DES="D4.1") D  Q
 ..I (LEG=1)!(LEG=2) S ALONG=ALONG+1 Q
 ..I (LEG=3)!(LEG=4) S ALONG=ALONG+2 Q
 .I (DES="D4.2") D  Q
 ..I (LEG=1)!(LEG=2) S ALONG=ALONG+1 Q
 ..I (LEG=3)!(LEG=4) S ALONG=ALONG+2 Q
 .I (DES="D4.3") D  Q
 ..I (LEG=1)!(LEG=2) S ALONG=ALONG+1 Q
 ..I (LEG=3)!(LEG=4) S ALONG=ALONG+2 Q
 .I (DES="D4.4") S ALONG=ALONG+LEG Q
 .I (DES="D4.5") D  Q
 ..I (LEG=1)!(LEG=2) S ALONG=ALONG+1 Q
 ..I (LEG=3)!(LEG=4) S ALONG=ALONG+2 Q
 .;
 .; Life activities: Household
 .I (DES="D5.1") D  Q
 ..I (LEG=1)!(LEG=2) S LIFE1=LIFE1+1 Q
 ..I (LEG=3)!(LEG=4) S LIFE1=LIFE1+2 Q
 .I (DES="D5.2") D  Q
 ..I (LEG=1)!(LEG=2) S LIFE1=LIFE1+1 Q
 ..I (LEG=3)!(LEG=4) S LIFE1=LIFE1+2 Q
 .I (DES="D5.3") S LIFE1=LIFE1+LEG Q
 .I (DES="D5.4") D  Q
 ..I (LEG=1)!(LEG=2) S LIFE1=LIFE1+1 Q
 ..I (LEG=3)!(LEG=4) S LIFE1=LIFE1+2 Q
 .; Are you working
 .I (LEG="Y") S WORKING="true" Q
 .; Life activities: work/school
 .I (DES="D5.5") D  Q
 ..I (LEG=1)!(LEG=2) S LIFE2=LIFE2+1 Q
 ..I (LEG=3)!(LEG=4) S LIFE2=LIFE2+2 Q
 .I (DES="D5.6") S LIFE2=LIFE2+LEG Q
 .I (DES="D5.7") S LIFE2=LIFE2+LEG Q
 .I (DES="D5.8") S LIFE2=LIFE2+LEG Q
 .; Participation in Society
 .I (DES="D6.1") D
 ..I (LEG=1)!(LEG=2) S PART=PART+1 Q
 ..I (LEG=3)!(LEG=4) S PART=PART+2 Q
 .I (DES="D6.2") S PART=PART+LEG Q
 .I (DES="D6.3") D  Q
 ..I (LEG=1)!(LEG=2) S PART=PART+1 Q
 ..I (LEG=3)!(LEG=4) S PART=PART+2 Q
 .I (DES="D6.4") S PART=PART+LEG Q
 .I (DES="D6.5") S PART=PART+LEG Q
 .I (DES="D6.6") D  Q
 ..I (LEG=1)!(LEG=2) S PART=PART+1 Q
 ..I (LEG=3)!(LEG=4) S PART=PART+2 Q
 .I (DES="D6.7") S PART=PART+LEG Q
 .I (DES="D6.8") D  Q
 ..I (LEG=1)!(LEG=2) S PART=PART+1 Q
 ..I (LEG=3)!(LEG=4) S PART=PART+2 Q
 Q
 ;
CALCS ; Calculations for missing questions
 I (COGM+MOBILM+SELFM+ALONGM+LIFE1M+LIFE2M+PARTM)>2 D  Q
 .S STRING="||WHO Disability Assessment Schedule Domains "
 .S STRING=STRING_"|  Too many missing answers.  Max is 2.:"
 .S STRING=STRING_"||  Range is 0 to 100 where 0 indicates no disability and 100 means full disability.|"
 .S FLAG=2 ; Quit out
 ; One missing Cognitive score: Use the average of the other scores for missing score.
 I (COGM=1) D
 .S COG=COG+(COG/5)
 S COGSTR=((COG*100)/20)
 ; One missing Mobil score
 I (MOBILM=1) D
 .S MOBIL=MOBIL+(MOBIL/5)
 S MOBILSTR=((MOBIL*100)/16)
 ; One missing Self score
 I (SELFM=1) D
 .S SELF=SELF+(SELF/4)
 S SELFSTR=((SELF*100)/10)
 ; One missing Getting Along score
 I (ALONGM=1) D
 .S ALONG=ALONG+(ALONG/5)
 S ALONGSTR=((ALONG*100)/12)
 ; One missing Life score
 I (LIFE1M=1) D
 .S LIFE1=LIFE1+(LIFE1/4)
 S LIFESTR1=((LIFE1*100)/10)
 ; One missing Life score for working folks
 I (WORKING="true") D
 .I (LIFE2M=1) D
 ..S LIFE2=LIFE2+(LIFE2/4)
 .S LIFESTR2=(LIFE2*100)/14
 I (WORKING'="true") S LIFESTR2="N/A",FLAG=1
 ; One missing participation score
 I (PARTM=1) D
 .S PART=PART+(PART/8)
 S PARTSTR=((PART*100)/24)
 Q
 ;
STRING ;
 I '$D(^TMP($J,"YSCOR")) D  Q
 .S STRING1="| "_YSINSNAM_" score could not be determined. "
 ;
 S COGSTR=$P($G(^TMP($J,"YSCOR",2)),"=",2)
 S MOBILSTR=$P($G(^TMP($J,"YSCOR",3)),"=",2)
 S SELFSTR=$P($G(^TMP($J,"YSCOR",4)),"=",2)
 S ALONGSTR=$P($G(^TMP($J,"YSCOR",5)),"=",2)
 S LIFESTR1=$P($G(^TMP($J,"YSCOR",6)),"=",2)
 S LIFESTR2=$P($G(^TMP($J,"YSCOR",7)),"=",2)
 S PARTSTR=$P($G(^TMP($J,"YSCOR",8)),"=",2)
 S TOTAL=$P($G(^TMP($J,"YSCOR",9)),"=",2)
 ;
 S STRING="|| WHO Disability Assessment Schedule Domains "
 ; Using $P vs. $J because $J rounds upward and we need exact
 ;
 S STRING=STRING_"|   Cognition:                      "_COGSTR
 S STRING=STRING_"|   Mobility:                       "_MOBILSTR
 S STRING=STRING_"|   Self-care:                      "_SELFSTR
 S STRING=STRING_"|   Getting along:                  "_ALONGSTR
 S STRING=STRING_"|   Life activities (household):    "_LIFESTR1
 S STRING=STRING_"|   Life activities (work/school):  "_LIFESTR2
 S STRING=STRING_"|   Participation:                  "_PARTSTR
 S STRING=STRING_"|   Summary:                        "_TOTAL
 S STRING=STRING_"|| Range is 0 to 100 where 0 indicates no disability and 100 means full disability."
 Q
 ;
TOTAL ;
 I WORKING="true" D  Q
 . S TOTAL=(((COG+MOBIL+SELF+ALONG+LIFE1+LIFE2+PART)*100)/106)
 S TOTAL=(((COG+MOBIL+SELF+ALONG+LIFE1+PART)*100)/92)
 Q
SCORESV ;
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 .K ^TMP($J,"YSCOR")
 .S ^TMP($J,"YSCOR",1)="[ERROR]"
 .S ^TMP($J,"YSCOR",2)="No Scale found for ADMIN: "_YS("AD")
 ;
 K ^TMP($J,"YSCOR")
 K ^TMP($J,"YSCOR") S YSDATA=$NA(^TMP($J,"YSCOR"))
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S ^TMP($J,"YSCOR",2)=$$GET1^DIQ(601.87,634_",",3,"I")_"="_$P(COGSTR,".",1)
 S ^TMP($J,"YSCOR",3)=$$GET1^DIQ(601.87,635_",",3,"I")_"="_$P(MOBILSTR,".",1)
 S ^TMP($J,"YSCOR",4)=$$GET1^DIQ(601.87,636_",",3,"I")_"="_$P(SELFSTR,".",1)
 S ^TMP($J,"YSCOR",5)=$$GET1^DIQ(601.87,637_",",3,"I")_"="_$P(ALONGSTR,".",1)
 S ^TMP($J,"YSCOR",6)=$$GET1^DIQ(601.87,638_",",3,"I")_"="_$P(LIFESTR1,".",1)
 S ^TMP($J,"YSCOR",7)=$$GET1^DIQ(601.87,639_",",3,"I")_"="_$S(LIFESTR2="N/A":"N/A",1:$P(LIFESTR2,".",1))
 S ^TMP($J,"YSCOR",8)=$$GET1^DIQ(601.87,640_",",3,"I")_"="_$P(PARTSTR,".",1)
 S ^TMP($J,"YSCOR",9)=$$GET1^DIQ(601.87,641_",",3,"I")_"="_$P(TOTAL,".",1)
 Q
 ;
DLLSTR(YSDATA,YS,YSTRNG) ;
 ;  YSTRNG = 1 Score Instrument
 ;  YSTRNG = 2 get Report Answers and Text
 N DATA,DES,NODE,LEG,YSCDA,YSQN,YSINSNAM,YSSEQ
 N STRING,STRING1,TOTAL
 N COG,MOBIL,SELF,ALONG,LIFE1,LIFE2,PART,WORKING
 N COGM,MOBILM,SELFM,ALONGM,LIFE1M,LIFE2M,PARTM
 N COGSTR,MOBILSTR,SELFSTR,ALONGSTR,LIFESTR1,LIFESTR2,PARTSTR
 N FLAG
 ;
 S (DES,STRING,STRING1)=""
 S FLAG=0,WORKING=""
 S (COG,MOBIL,SELF,ALONG,LIFE1,LIFE2,PART,TOTAL)=0
 S (COGM,MOBILM,SELFM,ALONGM,LIFE1M,LIFE2M,PARTM)=0
 S (COGSTR,MOBILSTR,SELFSTR,ALONGSTR,LIFESTR1,LIFESTR2,PARTSTR)=0
 ;
 D DATA1
 D CALCS
 I YSTRNG=1 D
 .D TOTAL
 .D SCORESV
 I YSTRNG=2 D
 .D LDSCORES^YTSCORE(.YSDATA,.YS)
 .D STRING
 .S YSDATA($O(YSDATA(""),-1)+1)=999999999999_U_U_STRING Q
 Q
