YTSMPI2H ;SLC/LLH - Score MMPI-2-RF ; 01/08/2016
 ;;5.01;MENTAL HEALTH;**123**;DEC 30,1994;Build 73
 ;
 ;Public, Supported ICRs
 ; #2056 - Fileman API - $$GET1^DIQ
 ;
 Q
 ;           MMPI-2-RF  HIGHER-ORDER (H-O) and RESTRUCTURED CLINICAL (RC) SCALES
 ;
 ;Scale^RawScore^TScore^CountofAnsweredQuestiona
 ;
SETSCR ;
 ;TScores --- From TSARR array, piece 3
 N SCALE,TS
 F SCALE="EID","THD","BXD","RCd","RC1","RC2","RC3","RC4","RC6","RC7","RC8","RC9" D
 .S TS=$P(TSARR(SCALE),U,3)
 .I SCALE="EID" S E=TS
 .I SCALE="THD" S T=TS
 .I SCALE="BXD" S B=TS
 .I SCALE="RCd" S RC=TS
 .I SCALE="RC1" S R1=TS
 .I SCALE="RC2" S R2=TS
 .I SCALE="RC3" S R3=TS
 .I SCALE="RC4" S R4=TS
 .I SCALE="RC6" S R6=TS
 .I SCALE="RC7" S R7=TS
 .I SCALE="RC8" S R8=TS
 .I SCALE="RC9" S R9=TS
 Q 
BLDGRPH ; draw Validity Scale graph
 N I,J,NUMBER,PCENT,TLINE,VALSP,SCLINE,SCALE,GRPH
 N E,T,B,RC,R1,R2,R3,R4,R6,R7,R8,R9
 S GRPH=""
 D SETVAR
 F I=25:-1:0 S TLINE="",NUMBER="" D
 .I (I#5)=0 D NUM
 .I (I#5)'=0 S NUMBER=NUMBER_"    :"
 .S TLINE=NUMBER
 .I (I=12)!(I=8)!(I=5)!(I=0) D
 ..F J=6:1:88 S TLINE=TLINE_"_"
 .E  F J=6:1:88 S TLINE=TLINE_" "
 .S $E(TLINE,27)=":"
 .S E=93,T=100,B=94,RC=86,R1=100,R2=99,R3=83
 .S R4=99,R6=100,R7=94,R8=100,R9=91
 .D DMINMX(I)
 .S E=30,T=39,B=32,RC=37,R1=36,(R2,R3,R4,R7)=34,R6=43,R8=39,R9=25
 .D DMINMX(I)
 .D SETSCR
 .D SETSTAR
 .I $L(TLINE)>89 S TLINE=$E(TLINE,1,89)
 .S GRPH=GRPH_"|"_TLINE
 S TXT=TXT_GRPH
 S TXT=TXT_VALSP_"|"_SCLINE_"|"
 Q
NUM ;
 S NUMBER=((I*4)+20)_"-:"
 ;I $L(NUMBER)<6 S NUMBER=" "_NUMBER
 I $L(NUMBER)<5 S NUMBER=" "_NUMBER
 Q
SETVAR ;
 N SC,SP1,L
 S PCENT=0,SCALE="",TLINE="    ",SCLINE="    "
 S SP1="      ",L=":"
 S VALSP="|   "_SP1_L_SP1_L_SP1_L_SP1_L_SP1_L_SP1_L_SP1_L_SP1_L_SP1_L_SP1_L_SP1_L_SP1_L
 F SCALE="EID","THD","BXD","RCd","RC1","RC2","RC3","RC4","RC6","RC7","RC8","RC9" D
 .S SC=SCALE,PCENT=$P(TSARR(SCALE),U,4) I PCENT<90 S SC="*"_SC
 .I $L(SC)<3 S SC=$$ADDSP^YTSMPI2U(SC,3)
 .S SCLINE=SCLINE_$$PAD^YTSMPI2U(SC,6)
 Q
 ; 
DMINMX(I) ;
 N K1
 F K1=0:1:3 D
 .I (I*4+(20-K1))=E D  ; EID
 ..S $E(TLINE,9,11)="---"
 .I (I*4+(20-K1))=T D  ; THD
 ..S $E(TLINE,16,18)="---"
 .I (I*4+(20-K1))=B D  ; BXD
 ..S $E(TLINE,21,23)="---"
 .I (I*4+(20-K1))=RC D  ; RCd
 ..S $E(TLINE,30,32)="---"
 .I (I*4+(20-K1))=R1 D  ; RC1
 ..S $E(TLINE,37,39)="---"
 .I (I*4+(20-K1))=R2 D  ; RC2
 ..S $E(TLINE,44,46)="---"
 .I (I*4+(20-K1))=R3 D  ; RC3
 ..S $E(TLINE,51,53)="---"
 .I (I*4+(20-K1))=R4 D  ; RC4
 ..S $E(TLINE,58,60)="---"
 .I (I*4+(20-K1))=R6 D  ; RC6
 ..S $E(TLINE,65,67)="---"
 .I (I*4+(20-K1))=R7 D  ; RC7
 ..S $E(TLINE,72,74)="---"
 .I (I*4+(20-K1))=R8 D  ; RC8
 ..S $E(TLINE,79,81)="---"
 .I (I*4+(20-K1))=R9 D  ; RC9
 ..S $E(TLINE,86,88)="---"
 Q
SETSTAR ;
 N K1
 F K1=0:1:3 D
 .I (I*4+(20-K1))=E D  ; EID
 ..S $E(TLINE,10)="*"
 .I (I*4+(20-K1))=T D  ; THD
 ..S $E(TLINE,17)="*"
 .I (I*4+(20-K1))=B D  ; BXD
 ..S $E(TLINE,23)="*"
 .I (I*4+(20-K1))=RC D  ;RCd
 ..S $E(TLINE,31)="*"
 .I (I*4+(20-K1))=R1 D  ; RC1
 ..S $E(TLINE,38)="*"
 .I (I*4+(20-K1))=R2 D  ; RC2
 ..S $E(TLINE,45)="*"
 .I (I*4+(20-K1))=R3 D  ; RC3
 ..S $E(TLINE,52)="*"
 .I (I*4+(20-K1))=R4 D  ; RC4
 ..S $E(TLINE,59)="*"
 .I (I*4+(20-K1))=R6 D  ; RC6
 ..S $E(TLINE,66)="*"
 .I (I*4+(20-K1))=R7 D  ; RC7
 ..S $E(TLINE,73)="*"
 .I (I*4+(20-K1))=R8 D  ; RC8
 ..S $E(TLINE,80)="*"
 .I (I*4+(20-K1))=R9 D  ; RC9
 ..S $E(TLINE,87)="*"
 Q
 ;
DSPSCOR ;
 N DATA,SCALE
 S TXT=TXT_"|"_$$ADDSP^YTSMPI2U("Raw  ",9)
 F SCALE="EID","THD","BXD","RCd","RC1","RC2","RC3","RC4","RC6","RC7","RC8","RC9" D
 .S DATA=$$ADDSP^YTSMPI2U($P(TSARR(SCALE),U,2),7)
 .S TXT=TXT_DATA
 S TXT=TXT_"|"_$$ADDSP^YTSMPI2U("T Score ",9)
 F SCALE="EID","THD","BXD","RCd","RC1","RC2","RC3","RC4","RC6","RC7","RC8","RC9" D
 .S DATA=$$ADDSP^YTSMPI2U($P(TSARR(SCALE),U,3),7)
 .S TXT=TXT_DATA
 S TXT=TXT_"|"_$$ADDSP^YTSMPI2U("Resp %  ",9)
 F SCALE="EID","THD","BXD","RCd","RC1","RC2","RC3","RC4","RC6","RC7","RC8","RC9" D
 .S DATA=$$ADDSP^YTSMPI2U($P(TSARR(SCALE),U,4),7)
 .S TXT=TXT_DATA
 Q
 ;
HORCSC ;
 ;
 S TXT=TXT_"||                    MMPI-2-RF  HIGHER-ORDER (H-O) and RESTRUCTURED CLINICAL (RC) SCALES |"
 S TXT=TXT_"|          Higher-Order                        Restructured Clinical"
 ;
 ;build graph/chart
 D BLDGRPH
 ;display Raw, T Score, and % answered
 D DSPSCOR
 S TXT=TXT_"|"_FNOTE
 S TXT=TXT_"||EID Emotional/Internalizing Dysfunction   RCd Demoralization         RC6 Ideas of Persecution"
 S TXT=TXT_"|THD Thought Dysfunction                   RC1 Somatic Complaints     RC7 Dysfunctional Negative Emotions"
 S TXT=TXT_"|BXD Behavioral/Externalizing Dysfunction  RC2 Low Positive Emotions  RC8 Aberrant Experiences"
 S TXT=TXT_"|                                          RC3 Cynicism               RC9 Hypomanic Activation"
 S TXT=TXT_"|                                          RC4 Antisocial Behavior"
 S TXT=TXT_"|***eop***"
 Q
