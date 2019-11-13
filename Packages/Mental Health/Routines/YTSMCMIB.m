YTSMCMIB ;BAL/KTL- MCMI4 ANSWERS SPECIAL HANDLING - INI ; 9/14/18 3:19pm
 ;;5.01;MENTAL HEALTH;**151**;Dec 30, 1994;Build 92
 ;
 ; MCMI4 Scoring
 ;
 ; Initialize arrays for scoring MCMI4
 ;
INICOD ;
 ;The MH SCALES are entered by name Since the Scale Codes can be cryptic (e.g. Scale Name 'Disclosure' has the Scale Code of 'X')
 ;However it is overly verbose to index all the arrays by Scale Name therefore we create a xref by NAME of CODE and 
 ;set up the YSCOD array
 ; YSCOD("NAME",name)=code
 ; YSCOD("ORDER",name)=display order number
 ;
 N NAM,ORD
 S YSCOD("NAME","6A.3 Acting-Out Dynamics")="6A.3"
 S YSCOD("NAME","5.3 Admirable Self-Image")="5.3"
 S YSCOD("NAME","B Alcohol Use")="B"
 S YSCOD("NAME","2A.2 Alienated Self-Image")="2A.2"
 S YSCOD("NAME","6A Antisocial")="6A"
 S YSCOD("NAME","6A.2 Autonomous Self-Image")="6A.2"
 S YSCOD("NAME","2A Avoidant")="2A"
 S YSCOD("NAME","N Bipolar Spectrum")="N"
 S YSCOD("NAME","C Borderline")="C"
 S YSCOD("NAME","S.3 Chaotic Content")="S.3"
 S YSCOD("NAME","S.1 Cognitively Circumstantial")="S.1"
 S YSCOD("NAME","7.2 Cognitively Constricted")="7.2"
 S YSCOD("NAME","5.2 Cognitively Expansive")="5.2"
 S YSCOD("NAME","2B.1 Cognitively Fatalistic")="2B.1"
 S YSCOD("NAME","P.2 Cognitively Mistrustful")="P.2"
 S YSCOD("NAME","7 Compulsive")="7"
 S YSCOD("NAME","PP Delusional")="PP"
 S YSCOD("NAME","3 Dependent")="3"
 S YSCOD("NAME","8A.2 Discontented Self-Image")="8A.2"
 S YSCOD("NAME","T Drug Use")="T"
 S YSCOD("NAME","6B.3 Eruptive Architecture")="6B.3"
 S YSCOD("NAME","S.2 Estranged Self-Image")="S.2"
 S YSCOD("NAME","4B.3 Exalted Self-Image")="4B.3"
 S YSCOD("NAME","P.1 Expressively Defensive")="P.1"
 S YSCOD("NAME","7.1 Expressively Disciplined")="7.1"
 S YSCOD("NAME","4A.1 Expressively Dramatic")="4A.1"
 S YSCOD("NAME","8A.1 Expressively Embittered")="8A.1"
 S YSCOD("NAME","4B.1 Expressively Impetuous")="4B.1"
 S YSCOD("NAME","6B.1 Expressively Precipitate")="6B.1"
 S YSCOD("NAME","3.1 Expressively Puerile")="3.1"
 S YSCOD("NAME","A Generalized Anxiety")="A"
 S YSCOD("NAME","4A Histrionic")="4A"
 S YSCOD("NAME","3.3 Inept Self-Image")="3.3"
 S YSCOD("NAME","6B.2 Interpersonally Abrasive")="6B.2"
 S YSCOD("NAME","4A.2 Interpersonally Attention-Seeking")="4A.2"
 S YSCOD("NAME","2A.1 Interpersonally Aversive")="2A.1"
 S YSCOD("NAME","5.1 Interpersonally Exploitive")="5.1"
 S YSCOD("NAME","4B.2 Interpersonally High-Spirited")="4B.2"
 S YSCOD("NAME","6A.1 Interpersonally Irresponsible")="6A.1"
 S YSCOD("NAME","3.2 Interpersonally Submissive")="3.2"
 S YSCOD("NAME","1.1 Interpersonally Unengaged")="1.1"
 S YSCOD("NAME","8B.2 Inverted Architecture")="8B.2"
 S YSCOD("NAME","CC Major Depression")="CC"
 S YSCOD("NAME","8B Masochistic")="8B"
 S YSCOD("NAME","1.2 Meager Content")="1.2"
 S YSCOD("NAME","2B Melancholic")="2B"
 S YSCOD("NAME","5 Narcissistic")="5"
 S YSCOD("NAME","8A Negativistic")="8A"
 S YSCOD("NAME","P Paranoid")="P"
 S YSCOD("NAME","D Persistent Depression")="D"
 S YSCOD("NAME","R Post-Traumatic Stress")="R"
 S YSCOD("NAME","P.3 Projection Dynamics")="P.3"
 S YSCOD("NAME","7.3 Reliable Self-Image")="7.3"
 S YSCOD("NAME","6B Sadistic")="6B"
 S YSCOD("NAME","1 Schizoid")="1"
 S YSCOD("NAME","SS Schizophrenic Spectrum")="SS"
 S YSCOD("NAME","S Schizotypal")="S"
 S YSCOD("NAME","H Somatic Symptom")="H"
 S YSCOD("NAME","C.2 Split Architecture")="C.2"
 S YSCOD("NAME","1.3 Temperamentally Apathetic")="1.3"
 S YSCOD("NAME","8B.3 Temperamentally Dysphoric")="8B.3"
 S YSCOD("NAME","4A.3 Temperamentally Fickle")="4A.3"
 S YSCOD("NAME","8A.3 Temperamentally Irritable")="8A.3"
 S YSCOD("NAME","C.3 Temperamentally Labile")="C.3"
 S YSCOD("NAME","2B.3 Temperamentally Woeful")="2B.3"
 S YSCOD("NAME","4B Turbulent")="4B"
 S YSCOD("NAME","C.1 Uncertain Self-Image")="C.1"
 S YSCOD("NAME","8B.1 Undeserving Self-Image")="8B.1"
 S YSCOD("NAME","2A.3 Vexatious Content")="2A.3"
 S YSCOD("NAME","2B.2 Worthless Self-Image")="2B.2"
 S YSCOD("NAME","X Disclosure")="X"
 S YSCOD("NAME","Y Desirability")="Y"
 S YSCOD("NAME","Z Debasement")="Z"
 S YSCOD("NAME","V Invalidity")="V"
 S YSCOD("NAME","W Inconsistency")="W"
 ;
 S ORD=1 F  S ORD=$O(^TMP($J,"YSCOR",ORD)) Q:+ORD=0  D
 .S SCAL=$P(^TMP($J,"YSCOR",ORD),"=")
 .S YSCOD("ORDER",SCAL)=ORD
 Q
YSQ ;
 ;Initialize array of scales and questions associated with that scale
 ;MCMI Scales range from 1140-1169,1240-1284 in MH SCALES
 N SCALCOD,STR,SCAL,N0,NAM,STR
 S SCAL=1139 F  S SCAL=$O(^YTT(601.87,SCAL)) Q:SCAL>1169  D
 .D YSQ2
 S SCAL=1239 F  S SCAL=$O(^YTT(601.87,SCAL)) Q:SCAL>1284  D
 .D YSQ2
 M ^TMP("YKTL","YSQSCAL")=YSQSCAL
 Q
YSQ2 ;
 N NN0,SCOR,N0,NAM,QUES,STR
 S STR=""
 S N0=^YTT(601.87,SCAL,0),NAM=$P(N0,"^",4)
 S SCOR="" F  S SCOR=$O(^YTT(601.91,"AC",SCAL,SCOR)) Q:SCOR=""  D
 .S NN0=^YTT(601.91,SCOR,0),QUES=$P(NN0,"^",3),QUES=QUES-8014  ;8015=question#1 so subtrat 8014 from QUES
 .S STR=STR_QUES_"^"
 S STR=$E(STR,1,$L(STR)-1)
 S YSQSCAL(NAM)=STR
 Q
