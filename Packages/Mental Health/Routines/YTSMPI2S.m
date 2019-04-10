YTSMPI2S ;SLC/LLH - Score MMPI-2-RF ; 01/08/2016
 ;;5.01;MENTAL HEALTH;**123**;DEC 30,1994;Build 73
 ;
 ;Public, Supported ICRs
 ; #2056 - Fileman API - $$GET1^DIQ
 ;
 Q
 ;                  MMPI-2-RF  SOMATIC/COGNITIVE and INTERNALIZING SCALES
 ;
 ;Scale^RawScore^TScore^CountofAnsweredQuestiona
SETSCR ;
 ;TScores --- From TSARR array, piece 3
 N SCALE,TS
 F SCALE="MLS","GIC","HPC","NUC","COG","SUI","HLP","SFD","NFC","STW","AXY","ANP","BRF","MSF" D
 .S TS=$P(TSARR(SCALE),U,3)
 .I SCALE="MLS" S M=TS
 .I SCALE="GIC" S G=TS
 .I SCALE="HPC" S H=TS
 .I SCALE="NUC" S N=TS
 .I SCALE="COG" S C=TS
 .I SCALE="SUI" S S=TS
 .I SCALE="HLP" S HLP=TS
 .I SCALE="SFD" S SFD=TS
 .I SCALE="NFC" S NFC=TS
 .I SCALE="STW" S STW=TS
 .I SCALE="AXY" S A=TS
 .I SCALE="ANP" S ANP=TS
 .I SCALE="BRF" S B=TS
 .I SCALE="MSF" S MSF=TS
 Q 
BLDGRPH ; draw Validity Scale graph
 N I,J,NUMBER,PCENT,TLINE,VALSP,SCLINE,SCALE,GRPH
 N M,G,H,N,C,S,HLP,SFD,NFC,STW,A,ANP,B,MSF
 S GRPH=""
 D SETVAR
 F I=25:-1:0 S TLINE="",NUMBER="" D
 .I (I#5)=0 D NUM
 .I (I#5)'=0 S NUMBER=NUMBER_"    :"
 .S TLINE=NUMBER
 .I (I=12)!(I=8)!(I=5)!(I=0) D
 ..F J=6:1:90 S TLINE=TLINE_"_"
 .E  F J=6:1:90 S TLINE=TLINE_" "
 .S $E(TLINE,37)=":"
 .S M=87,(G,C)=96,H=85,(N,S,A,B)=100,HLP=88,SFD=76,(NFC,ANP)=80,STW=81,MSF=78
 .D DMINMX(I)
 .S M=38,G=46,(H,SFD)=42,N=41,(C,HLP)=40,S=45,(NFC,STW,MSF)=36,A=44,ANP=39,B=43
 .D DMINMX(I)
 .D SETSCR
 .D SETSTAR
 .I $L(TLINE)>90 S TLINE=$E(TLINE,1,90)
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
 ;S SP1="      ",L=":"
 S SP1="     ",L=":"
 S VALSP="|    "_SP1_L_SP1_L_SP1_L_SP1_L_SP1_L_SP1_L_SP1_L_SP1_L_SP1_L_SP1_L_SP1_L_SP1_L_SP1_L_SP1_L
 F SCALE="MLS","GIC","HPC","NUC","COG","SUI","HLP","SFD","NFC","STW","AXY","ANP","BRF","MSF" D
 .S SC=SCALE,PCENT=$P(TSARR(SCALE),U,4) I PCENT<90 S SC="*"_SC
 .I $L(SC)<3 S SC=$$ADDSP^YTSMPI2U(SC,3)
 .;S SCLINE=SCLINE_$$PAD^YTSMPI2U(SC,6)
 .S SCLINE=SCLINE_$$PAD^YTSMPI2U(SC,5)
 Q
 ; 
DMINMX(I) ;
 N K1
 F K1=0:1:3 D
 .I (I*4+(20-K1))=M D  ; MLS
 ..S $E(TLINE,9,11)="---"
 .I (I*4+(20-K1))=G D  ; GIC
 ..S $E(TLINE,15,17)="---"
 .I (I*4+(20-K1))=H D  ; HPC
 ..S $E(TLINE,21,23)="---"
 .I (I*4+(20-K1))=N D  ; NUC
 ..S $E(TLINE,27,29)="---"
 .I (I*4+(20-K1))=C D  ; COG
 ..S $E(TLINE,33,35)="---"
 .I (I*4+(20-K1))=S D  ; SUI
 ..S $E(TLINE,39,41)="---"
 .I (I*4+(20-K1))=HLP D  ; HLP
 ..S $E(TLINE,45,47)="---"
 .I (I*4+(20-K1))=SFD D  ; SFD
 ..S $E(TLINE,51,53)="---"
 .I (I*4+(20-K1))=NFC D  ; NFC
 ..S $E(TLINE,57,59)="---"
 .I (I*4+(20-K1))=STW D  ; STW
 ..S $E(TLINE,63,65)="---"
 .I (I*4+(20-K1))=A D  ; AXY
 ..S $E(TLINE,69,71)="---"
 .I (I*4+(20-K1))=ANP D  ; ANP
 ..S $E(TLINE,75,77)="---"
 .I (I*4+(20-K1))=B D  ; BRF
 ..S $E(TLINE,81,83)="---"
 .I (I*4+(20-K1))=MSF D  ; MSF
 ..S $E(TLINE,87,89)="---"
 Q
 ;
SETSTAR ;
 N K1
 F K1=0:1:3 D
 .I (I*4+(20-K1))=M D  ; MLS
 ..S $E(TLINE,10)="*"
 .I (I*4+(20-K1))=G D  ; GIC
 ..S $E(TLINE,16)="*"
 .I (I*4+(20-K1))=H D  ; HPC
 ..S $E(TLINE,22)="*"
 .I (I*4+(20-K1))=N D  ; NUC
 ..S $E(TLINE,29)="*"
 .I (I*4+(20-K1))=C D  ; COG
 ..S $E(TLINE,34)="*"
 .I (I*4+(20-K1))=S D  ; SUI
 ..S $E(TLINE,40)="*"
 .I (I*4+(20-K1))=HLP D  ; HLP
 ..S $E(TLINE,46)="*"
 .I (I*4+(20-K1))=SFD D  ; SFD
 ..S $E(TLINE,52)="*"
 .I (I*4+(20-K1))=NFC D  ; NFC
 ..S $E(TLINE,58)="*"
 .I (I*4+(20-K1))=STW D  ; STW
 ..S $E(TLINE,64)="*"
 .I (I*4+(20-K1))=A D  ; AXY
 ..S $E(TLINE,70)="*"
 .I (I*4+(20-K1))=ANP D  ; ANP
 ..S $E(TLINE,76)="*"
 .I (I*4+(20-K1))=B D  ; BRF
 ..S $E(TLINE,82)="*"
 .I (I*4+(20-K1))=MSF D  ; MSF
 ..S $E(TLINE,88)="*"
 Q
 ;
DSPSCOR ;
 ;
 N DATA,SCALE
 S TXT=TXT_"|"_$$ADDSP^YTSMPI2U("Raw  ",8)  ; was 9
 F SCALE="MLS","GIC","HPC","NUC","COG","SUI","HLP","SFD","NFC","STW","AXY","ANP","BRF","MSF" D
 .S DATA=$$ADDSP^YTSMPI2U($P(TSARR(SCALE),U,2),6)  ; was 7
 .S TXT=TXT_DATA
 S TXT=TXT_"|"_$$ADDSP^YTSMPI2U("T Score ",8)
 F SCALE="MLS","GIC","HPC","NUC","COG","SUI","HLP","SFD","NFC","STW","AXY","ANP","BRF","MSF" D
 .S DATA=$$ADDSP^YTSMPI2U($P(TSARR(SCALE),U,3),6)
 .S TXT=TXT_DATA
 S TXT=TXT_"|"_$$ADDSP^YTSMPI2U("Resp %  ",8)
 F SCALE="MLS","GIC","HPC","NUC","COG","SUI","HLP","SFD","NFC","STW","AXY","ANP","BRF","MSF" D
 .S DATA=$$ADDSP^YTSMPI2U($P(TSARR(SCALE),U,4),6)
 .S TXT=TXT_DATA
 Q
 ;
SOCOSC ;
 ;
 S TXT=TXT_"||                    MMPI-2-RF  SOMATIC/COGNITIVE and INTERNALIZING SCALES |"
 S TXT=TXT_"|               Somatic/Cognitive                     Internalizing"
 ;build graph/chart
 D BLDGRPH
 ;display Raw, T Score, and % answered
 D DSPSCOR
 S TXT=TXT_"|"_FNOTE
 S TXT=TXT_"||MLS Malaise                       SUI Suicidal/Death Ideation     AXY Anxiety"
 S TXT=TXT_"|GIC Gastrointestinal Complaints   HLP Helplessness/Hopelessness   ANP Anger Proneness"
 S TXT=TXT_"|HPC Head Pain Complaints          SFD Self-Doubt                  BRF Behavior-Restricting Fears"
 S TXT=TXT_"|NUC Neurological Complaints       NFC Inefficacy                  MSF Multiple Specific Fear"
 S TXT=TXT_"|COG Cognitive Complaints          STW Stress/Worry"
 S TXT=TXT_"||***eop***"
 Q
