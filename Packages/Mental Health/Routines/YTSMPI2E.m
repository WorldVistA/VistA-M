YTSMPI2E ;SLC/LLH - Score MMPI-2-RF ; 01/08/2016
 ;;5.01;MENTAL HEALTH;**123**;DEC 30,1994;Build 73
 ;
 ;Public, Supported ICRs
 ; #2056 - Fileman API - $$GET1^DIQ
 ;
 Q
 ;           MMPI-2-RF  EXTERNALIZING, INTERPERSONAL and INTEREST SCALES
 ;
 ;Scale^RawScore^TScore^CountofAnsweredQuestiona
 ;
SETSCR ;
 ;TScores --- From TSARR array, piece 3
 N SCALE,TS
 F SCALE="JCP","SUB","AGG","ACT","FML","IPP","SAV","SHY","DSF","AES","MEC" D
 .S TS=$P(TSARR(SCALE),U,3)
 .I SCALE="JCP" S JCP=TS
 .I SCALE="SUB" S S=TS
 .I SCALE="AGG" S A=TS
 .I SCALE="ACT" S ACT=TS
 .I SCALE="FML" S F=TS
 .I SCALE="IPP" S IPP=TS
 .I SCALE="SAV" S SAV=TS
 .I SCALE="SHY" S SHY=TS
 .I SCALE="DSF" S D=TS
 .I SCALE="AES" S AES=TS
 .I SCALE="MEC" S M=TS
 Q 
BLDGRPH ; draw Validity Scale graph
 N I,J,NUMBER,PCENT,TLINE,VALSP,SCLINE,SCALE,GRPH
 N JCP,S,A,ACT,F,IPP,SAV,SHY,D,AES,M
 S GRPH=""
 D SETVAR
 F I=25:-1:0 S TLINE="",NUMBER="" D
 .I (I#5)=0 D NUM
 .I (I#5)'=0 S NUMBER=NUMBER_"    :"
 .S TLINE=NUMBER
 .I (I=12)!(I=8)!(I=5)!(I=0) D
 ..F J=6:1:82 S TLINE=TLINE_"_"
 .E  F J=6:1:82 S TLINE=TLINE_" "
 .S $E(TLINE,35)=":"
 .S $E(TLINE,70)=":"
 .S JCP=84,S=93,A=92,ACT=83,F=90,IPP=81,SAV=80,SHY=75,D=100,AES=73,M=78
 .D DMINMX(I)
 .S JCP=40,S=41,A=37,ACT=33,F=37,IPP=34,SAV=36,SHY=37,D=44,AES=33,M=38
 .D DMINMX(I)
 .D SETSCR
 .D SETSTAR
 .I $L(TLINE)>82 S TLINE=$E(TLINE,1,82)
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
 S SP1="      ",L=":"
 S VALSP="|    "_SP1_L_SP1_L_SP1_L_SP1_L_SP1_L_SP1_L_SP1_L_SP1_L_SP1_L_SP1_L_SP1_L
 F SCALE="JCP","SUB","AGG","ACT","FML","IPP","SAV","SHY","DSF","AES","MEC" D
 .S SC=SCALE,PCENT=$P(TSARR(SCALE),U,4) I PCENT<90 S SC="*"_SC
 .I $L(SC)<3 S SC=$$ADDSP^YTSMPI2U(SC,3)
 .S SCLINE=SCLINE_$$PAD^YTSMPI2U(SC,6)
 Q
 ; 
DMINMX(I) ;
 N K1
 F K1=0:1:3 D
 .I (I*4+(20-K1))=JCP D  ; JCP
 ..S $E(TLINE,10,12)="---"
 .I (I*4+(20-K1))=S D  ; SUB
 ..S $E(TLINE,17,19)="---"
 .I (I*4+(20-K1))=A D  ; AGG
 ..S $E(TLINE,24,26)="---"
 .I (I*4+(20-K1))=ACT D  ; ACT
 ..S $E(TLINE,31,33)="---"
 .I (I*4+(20-K1))=F D  ; FML
 ..S $E(TLINE,38,40)="---"
 .I (I*4+(20-K1))=IPP D  ; IPP
 ..S $E(TLINE,45,47)="---"
 .I (I*4+(20-K1))=SAV D  ; SAV
 ..S $E(TLINE,52,54)="---"
 .I (I*4+(20-K1))=SHY D  ; SHY
 ..S $E(TLINE,59,61)="---"
 .I (I*4+(20-K1))=D D  ; DFS
 ..S $E(TLINE,66,68)="---"
 .I (I*4+(20-K1))=AES D  ; AES
 ..S $E(TLINE,73,75)="---"
 .I (I*4+(20-K1))=M D  ; MEC
 ..S $E(TLINE,80,82)="---"
 Q
SETSTAR ;
 N K1
 F K1=0:1:3 D
 .I (I*4+(20-K1))=JCP D  ; JCP
 ..S $E(TLINE,11)="*"
 .I (I*4+(20-K1))=S D  ; SUB
 ..S $E(TLINE,18)="*"
 .I (I*4+(20-K1))=A D  ; AGG
 ..S $E(TLINE,25)="*"
 .I (I*4+(20-K1))=ACT D  ; ACT
 ..S $E(TLINE,32)="*"
 .I (I*4+(20-K1))=F D  ; FML
 ..S $E(TLINE,39)="*"
 .I (I*4+(20-K1))=IPP D  ; IPP
 ..S $E(TLINE,46)="*"
 .I (I*4+(20-K1))=SAV D  ; SAV
 ..S $E(TLINE,53)="*"
 .I (I*4+(20-K1))=SHY D  ; SHY
 ..S $E(TLINE,60)="*"
 .I (I*4+(20-K1))=D D  ; DFS
 ..S $E(TLINE,67)="*"
 .I (I*4+(20-K1))=AES D  ; AES
 ..S $E(TLINE,74)="*"
 .I (I*4+(20-K1))=M D  ; MEC
 ..S $E(TLINE,81)="*"
 Q
 ;
DSPSCOR ;
 N DATA,SCALE
 S TXT=TXT_"|"_$$ADDSP^YTSMPI2U("Raw  ",9)
 F SCALE="JCP","SUB","AGG","ACT","FML","IPP","SAV","SHY","DSF","AES","MEC" D
 .S DATA=$$ADDSP^YTSMPI2U($P(TSARR(SCALE),U,2),7)
 .S TXT=TXT_DATA
 S TXT=TXT_"|"_$$ADDSP^YTSMPI2U("T Score ",9)
 F SCALE="JCP","SUB","AGG","ACT","FML","IPP","SAV","SHY","DSF","AES","MEC" D
 .S DATA=$$ADDSP^YTSMPI2U($P(TSARR(SCALE),U,3),7)
 .S TXT=TXT_DATA
 S TXT=TXT_"|"_$$ADDSP^YTSMPI2U("Resp %  ",9)
 F SCALE="JCP","SUB","AGG","ACT","FML","IPP","SAV","SHY","DSF","AES","MEC" D
 .S DATA=$$ADDSP^YTSMPI2U($P(TSARR(SCALE),U,4),7)
 .S TXT=TXT_DATA
 Q
EIISC ;
 S TXT=TXT_"||                    MMPI-2-RF  EXTERNALIZING, INTERPERSONAL and INTEREST SCALES |"
 S TXT=TXT_"|            Externalizing                 Interpersonal                    Interest"
 ;build graph/chart
 D BLDGRPH
 ;display Raw, T Score, and % answered
 D DSPSCOR
 S TXT=TXT_"|"_FNOTE
 S TXT=TXT_"||JCP Juvenile Conduct Problems   FML Family Problems            AES Aesthetic-Literary Interests"
 S TXT=TXT_"|SUB Substance Abuse             IPP Interpersonal Passivity    MEC Mechanical-Physical Interests"
 S TXT=TXT_"|AGG Aggression                  SAV Social Avoidance"
 S TXT=TXT_"|ACT Activation                  SHY Shyness"
 S TXT=TXT_"|                                DSF Disaffiliativeness"
 S TXT=TXT_"|***eop***"
 Q
