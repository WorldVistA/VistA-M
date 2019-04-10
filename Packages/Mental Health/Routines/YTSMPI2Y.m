YTSMPI2Y ;SLC/LLH - Score MMPI-2-RF ; 01/08/2016
 ;;5.01;MENTAL HEALTH;**123**;DEC 30,1994;Build 73
 ;
 ;Public, Supported ICRs
 ; #2056 - Fileman API - $$GET1^DIQ
 ;
 Q
 ;                       MMPI-2-RF  SOMATIC/COGNITIVE and INTERNALIZING SCALES
 ;
 ;Scale^RawScore^TScore^CountofAnsweredQuestiona
SETSCR ;
 ;TScores --- From TSARR array, piece 3
 N SCALE,TS
 F SCALE="AGGR","PSYC","DISC","NEGE","INTR" D
 .S TS=$P(TSARR(SCALE),U,3)
 .I SCALE="AGGR" S AG=TS
 .I SCALE="PSYC" S PS=TS
 .I SCALE="DISC" S DI=TS
 .I SCALE="NEGE" S NE=TS
 .I SCALE="INTR" S IN=TS
 Q 
BLDGRPH ; draw Validity Scale graph
 N I,J,NUMBER,PCENT,TLINE,VALSP,SCLINE,SCALE,GRPH
 N AG,PS,DI,NE,IN
 S GRPH=""
 D SETVAR
 F I=25:-1:0 S TLINE="",NUMBER="" D
 .I (I#5)=0 D NUM
 .I (I#5)'=0 S NUMBER=NUMBER_"    :"
 .S TLINE=NUMBER
 .I (I=12)!(I=8)!(I=5)!(I=0) D
 ..F J=6:1:52 S TLINE=TLINE_"_"
 .E  F J=6:1:52 S TLINE=TLINE_" "
 .S AG=88,PS=100,DI=92,NE=95,IN=93
 .D DMINMX(I)
 .S AG=28,PS=38,DI=31,NE=32,IN=32
 .D DMINMX(I)
 .D SETSCR
 .D SETSTAR
 .I $L(TLINE)>52 S TLINE=$E(TLINE,1,52)
 .S GRPH=GRPH_"|"_TLINE
 S TXT=TXT_GRPH
 S TXT=TXT_VALSP_"|"_SCLINE_"|"
 Q
NUM ;
 S NUMBER=((I*4)+20)_"-:"
 I $L(NUMBER)<5 S NUMBER=" "_NUMBER
 Q
SETVAR ;
 N SC,SP1,L
 S PCENT=0,SCALE="",TLINE="    ",SCLINE="     "
 S SP1="       ",L=":"
 S VALSP="|    "_SP1_L_SP1_L_SP1_L_SP1_L_SP1_L_SP1
 F SCALE="AGGR","PSYC","DISC","NEGE","INTR" D
 .S SC=SCALE,PCENT=$P(TSARR(SCALE),U,4) I PCENT<90 S SC="*"_SC
 .I $L(SC)<3 S SC=$$ADDSP^YTSMPI2U(SC,3)
 .S SCLINE=SCLINE_$$PAD^YTSMPI2U(SC,7)
 Q
 ; 
DMINMX(I) ;
 N K1
 F K1=0:1:3 D
 .I (I*4+(20-K1))=AG D  ; AGGR
 ..S $E(TLINE,10,12)="---"
 .I (I*4+(20-K1))=PS D  ; PSYC
 ..S $E(TLINE,18,20)="---"
 .I (I*4+(20-K1))=DI D  ; DISC
 ..S $E(TLINE,26,28)="---"
 .I (I*4+(20-K1))=NE D  ; NEGE
 ..S $E(TLINE,35,37)="---"
 .I (I*4+(20-K1))=IN D  ; INTR
 ..S $E(TLINE,43,45)="---"
 Q
SETSTAR ;
 N K1
 F K1=0:1:3 D
 .I (I*4+(20-K1))=AG D  ; AGGR
 ..S $E(TLINE,11)="*"
 .I (I*4+(20-K1))=PS D  ; PSYC
 ..S $E(TLINE,19)="*"
 .I (I*4+(20-K1))=DI D  ; DISC
 ..S $E(TLINE,27)="*"
 .I (I*4+(20-K1))=NE D  ; NEGE
 ..S $E(TLINE,36)="*"
 .I (I*4+(20-K1))=IN D  ; INTR
 ..S $E(TLINE,44)="*"
 Q
 ;
DSPSCOR ;
 N DATA,SCALE
 S TXT=TXT_"|"_$$ADDSP^YTSMPI2U("Raw ",10)
 F SCALE="AGGR","PSYC","DISC","NEGE","INTR" D
 .S DATA=$$ADDSP^YTSMPI2U($P(TSARR(SCALE),U,2),8)
 .S TXT=TXT_DATA
 S TXT=TXT_"|"_$$ADDSP^YTSMPI2U("T Score ",10)
 F SCALE="AGGR","PSYC","DISC","NEGE","INTR" D
 .S DATA=$$ADDSP^YTSMPI2U($P(TSARR(SCALE),U,3),8)
 .S TXT=TXT_DATA
 S TXT=TXT_"|"_$$ADDSP^YTSMPI2U("Resp % ",10)
 F SCALE="AGGR","PSYC","DISC","NEGE","INTR" D
 .S DATA=$$ADDSP^YTSMPI2U($P(TSARR(SCALE),U,4),8)
 .S TXT=TXT_DATA
 Q
 ;
PSYSC ;
 ;
 S TXT=TXT_"||                    MMPI-2-RF  PSY-5 SCALES"
 ;build graph/chart
 D BLDGRPH
 ;display Raw, T Score, and % answered
 D DSPSCOR
 S TXT=TXT_"|"_FNOTE
 S TXT=TXT_"||AGGR-r Aggressiveness-Revised"
 S TXT=TXT_"|PSYC-r Psychoticism-Revised"
 S TXT=TXT_"|DISC-r Disconstraint-Revised"
 S TXT=TXT_"|NEGE-r Negative Emotionality/Neuroticism-Revised"
 S TXT=TXT_"|INTR-r Introversion/Low Positive Emotionality-Revised"
 S TXT=TXT_"||***eop***"
 Q
