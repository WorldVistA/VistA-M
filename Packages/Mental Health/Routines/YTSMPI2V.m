YTSMPI2V ;SLC/PIJ - Score MMPI-2-RF ; 01/08/2016
 ;;5.01;MENTAL HEALTH;**123**;DEC 30,1994;Build 73
 ;
 ;Public, Supported ICRs
 ; #2056 - Fileman API - $$GET1^DIQ
 ;
 Q
 ;        MMPI-2-RF VALIDITY SCALES 
 ;
 ;Scale^RawScore^TScore^CountofAnsweredQuestiona
SETSCR ;
 ;TScores --- From TSARR array, piece 3
 N SCALE,TS
 F SCALE="VRIN","TRIN","F-r","Fp-r","Fs","FBS-r","RBS","L-r","K-r" D
 .S TS=$P(TSARR(SCALE),U,3)
 .I SCALE="VRIN" S V=TS
 .I SCALE="TRIN" S T=TS
 .I SCALE="F-r" S F=TS
 .I SCALE="Fp-r" S FP=TS
 .I SCALE="Fs" S FS=TS
 .I SCALE="FBS-r" S FB=TS
 .I SCALE="RBS" S RB=TS
 .I SCALE="L-r" S L=TS
 .I SCALE="K-r" S K=TS
 Q 
BLDGRPH ; draw Validity Scale graph
 N I,J,NUMBER,PCENT,TLINE,VALSP,SCLINE,SCALE,GRPH
 N V,T,F,FP,FS,FB,RB,L,K
 S GRPH=""
 D SETVAR
 F I=25:-1:0 S TLINE="",NUMBER="" D
 .I (I#5)=0 D NUM
 .I (I#5)'=0 S NUMBER=NUMBER_"    :"
 .S TLINE=NUMBER
 .I (I=8)!(I=0) D
 ..F J=6:1:72 S TLINE=TLINE_"_"
 .E  F J=6:1:72 S TLINE=TLINE_" "
 .S (V,T,F,FP,FS,FB,RB)=120,L=105,K=72
 .D DMINMX(I)
 .S V=34,T=50,(F,FP,FS)=42,FB=26,RB=29,L=37,K=24
 .D DMINMX(I)
 .D SETSCR
 .D SETSTAR
 .I $L(TLINE)>72 S TLINE=$E(TLINE,1,72)
 .S GRPH=GRPH_"|"_TLINE
 S TXT=TXT_GRPH
 S TXT=TXT_VALSP_"|"_SCLINE_"|"
 Q
NUM ;
 S NUMBER=((I*4)+20)_"-:"
 I $L(NUMBER)<5 S NUMBER=" "_NUMBER
 Q
SETVAR ;
 N SP1,L,SC
 S PCENT=0,SCALE="",TLINE="    ",SCLINE="     "
 S SP1="      ",L=":"
 S VALSP="|    "_SP1_L_SP1_L_SP1_L_SP1_L_SP1_L_SP1_L_SP1_L_SP1_L_SP1_L
 F SCALE="VRIN","TRIN","F-r","Fp-r","Fs","FBS-r","RBS","L-r","K-r" D
 .S SC=SCALE,PCENT=$P(TSARR(SCALE),U,4) I PCENT<90 S SC="*"_SC
 .I $L(SC)<3 S SC=$$ADDSP^YTSMPI2U(SC,3)
 .S SCLINE=SCLINE_$$PAD^YTSMPI2U(SC,6)
 Q
 ; 
DMINMX(I) ;
 N K1
 F K1=0:1:3 D
 .I (I*4+(20-K1))=V D  ; VRIN-r
 ..S $E(TLINE,11,13)="---"
 .I (I*4+(20-K1))=T D  ; TRIN-r
 ..S $E(TLINE,17,19)="---"
 .I (I*4+(20-K1))=F D  ; F-r
 ..S $E(TLINE,24,26)="---"
 .I (I*4+(20-K1))=FP D  ; Fp-r
 ..S $E(TLINE,31,33)="---"
 .I (I*4+(20-K1))=FS D  ; Fs
 ..S $E(TLINE,38,40)="---"
 .I (I*4+(20-K1))=FB D  ; FBS-r
 ..S $E(TLINE,44,46)="---"
 .I (I*4+(20-K1))=RB D  ; RBS
 ..S $E(TLINE,52,54)="---"
 .I (I*4+(20-K1))=L D  ; L-r
 ..S $E(TLINE,59,61)="---"
 .I (I*4+(20-K1))=K D  ; K-r
 ..S $E(TLINE,66,68)="---"
 Q
 ;
SETSTAR ;
 N K1
 F K1=0:1:3 D
 .I (I*4+(20-K1))=V D  ; VRIN-r
 ..S $E(TLINE,12)="*"
 .I (I*4+(20-K1))=T D  ; TRIN-r
 ..S $E(TLINE,18)="*"
 .I (I*4+(20-K1))=F D  ; F-r
 ..S $E(TLINE,25)="*"
 .I (I*4+(20-K1))=FP D  ; Fp-r
 ..S $E(TLINE,32)="*"
 .I (I*4+(20-K1))=FS D  ; Fs
 ..S $E(TLINE,39)="*"
 .I (I*4+(20-K1))=FB D  ; FBS-r
 ..S $E(TLINE,45)="*"
 .I (I*4+(20-K1))=RB D  ; RBS
 ..S $E(TLINE,53)="*"
 .I (I*4+(20-K1))=L D  ; L-r
 ..S $E(TLINE,60)="*"
 .I (I*4+(20-K1))=K D  ; K-r
 ..S $E(TLINE,67)="*"
 Q
 ;
DSPSCOR ;
 N DATA,SCALE
 S TXT=TXT_"|"_$$ADDSP^YTSMPI2U("Raw ",9)
 F SCALE="VRIN","TRIN","F-r","Fp-r","Fs","FBS-r","RBS","L-r","K-r" D
 .S DATA=$$ADDSP^YTSMPI2U($P(TSARR(SCALE),U,2),7)
 .S TXT=TXT_DATA
 S TXT=TXT_"|"_$$ADDSP^YTSMPI2U("T Score ",9)
 F SCALE="VRIN","TRIN","F-r","Fp-r","Fs","FBS-r","RBS","L-r","K-r" D
 .S DATA=$$ADDSP^YTSMPI2U($P(TSARR(SCALE),U,3),7)
 .S TXT=TXT_DATA
 S TXT=TXT_"|"_$$ADDSP^YTSMPI2U("Resp % ",9)
 F SCALE="VRIN","TRIN","F-r","Fp-r","Fs","FBS-r","RBS","L-r","K-r" D
 .S DATA=$$ADDSP^YTSMPI2U($P(TSARR(SCALE),U,4),7)
 .S TXT=TXT_DATA
 Q
 ;
VLDTYSC ;
 S TXT=TXT_"|||                        MMPI-2-RF VALIDITY SCALES |"
 ;build graph/chart
 D BLDGRPH
 ;display Raw, T Score, and % answered
 D DSPSCOR
 S TXT=TXT_"||Cannot Say (Raw) "_CNT("cannotSay")
 S TXT=TXT_"              Percent True of items answered "_CNT("trueCount")
 ;
 S TXT=TXT_"|"_FNOTE
 S TXT=TXT_"||VRIN-r Variable Response Inconsistency     Fs    Infrequent Somatic Responses"
 S TXT=TXT_"|TRIN-r True Response Inconsistency         FBS-r Symptom Validity"
 S TXT=TXT_"|F-r    Infrequent Responses                RBS   Response Bias Scale"
 S TXT=TXT_"|L-r    Uncommon Virtues                    Fp-r  Infrequent Psychopathology Responses"
 S TXT=TXT_"|K-r    Adjustment Validity"
 S TXT=TXT_"||***eop***"
 Q
