YTSNEOPI ;SLC/PIJ - Score NEO-PI-3 ; 01/08/2016
 ;;5.01;MENTAL HEALTH;**123**;DEC 30,1994;Build 73
 ;
 ;Public, Supported ICRs
 ; #2056 - Fileman API - $$GET1^DIQ
 ;
 Q
 ;
DATA1 ;
 S YSINSNAM=$P($G(YSDATA(2)),U,3)
 I $G(YSINSNAM)="" S YSINSNAM=$G(YS("CODE"),"NO NAME PASSED")
 S NODE=2 F  S NODE=$O(YSDATA(NODE)) Q:NODE=""  D  ; Start at YSDATA(3)
 .S DATA=YSDATA(NODE)
 .S YSQN=$P(DATA,U,1)
 .S YSCDA=$P($G(DATA),U,3) ; Choice ID
 .D DESGNTR^YTSCORE(YSQN,.DES)
 .;
 .;The Legacy Value (field #4 in file 601.75) cannot be used as 2 of the CHOICES are "mapped"
 .;to incorrect values:  
 .;    782: Disagree = 3 and should be 2
 .;    785: Strongly agree = 6 and should be 5
 .;Additionally, the Legacy Value is the item number response and should be reduced by 1, i.e.
 .;Strongly Disagree = 1 and is scored as a 0, unless reverse scored.
 .;
 .I YSCDA=241 S LEG=0  ; Yes
 .I YSCDA=237 S LEG=1  ; No
 .;
 .I YSCDA=780 S LEG=0  ; Strongly disagree
 .I YSCDA=782 S LEG=1  ; Disagree
 .I YSCDA=999 S LEG=2  ; Neutral
 .I YSCDA=783 S LEG=3  ; Agree
 .I YSCDA=785 S LEG=4  ; Strongly agree
 .;using Question IEN
 .I YSQN=5963 S VA=LEG  ; Question 'A'
 .I YSQN=5964 S VB=LEG  ; Question 'B'
 .I YSQN=5965 S VC=LEG  ; Question 'C'
 .; calculates the raw score for the non-domain scales, N1,N2...C5,C6 and counts skipped questions
 .D SCORANS^YTSNEOP1
 Q
 ;
SCORESV ; For the Graph/Table
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 .K ^TMP($J,"YSCOR")
 .S ^TMP($J,"YSCOR",1)="[ERROR]"
 .S ^TMP($J,"YSCOR",2)=YSINSNAM_" Scale not found"
 ;
 K ^TMP($J,"YSCOR")
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S ^TMP($J,"YSCOR",2)=$$GET1^DIQ(601.87,694_",",3,"I")_"="_$J(N,0,0)
 S ^TMP($J,"YSCOR",3)=$$GET1^DIQ(601.87,695_",",3,"I")_"="_$J(E,0,0)
 S ^TMP($J,"YSCOR",4)=$$GET1^DIQ(601.87,696_",",3,"I")_"="_$J(O,0,0)
 S ^TMP($J,"YSCOR",5)=$$GET1^DIQ(601.87,697_",",3,"I")_"="_$J(A,0,0)
 S ^TMP($J,"YSCOR",6)=$$GET1^DIQ(601.87,698_",",3,"I")_"="_$J(C,0,0)
 ; "N"
 S ^TMP($J,"YSCOR",7)=$$GET1^DIQ(601.87,642_",",3,"I")_"="_N1_U_$J($$GETTSCOR^YTSNEOP1("N1",N1),0,0)
 S ^TMP($J,"YSCOR",8)=$$GET1^DIQ(601.87,672_",",3,"I")_"="_N2_U_$J($$GETTSCOR^YTSNEOP1("N2",N2),0,0)
 S ^TMP($J,"YSCOR",9)=$$GET1^DIQ(601.87,674_",",3,"I")_"="_N3_U_$J($$GETTSCOR^YTSNEOP1("N3",N3),0,0)
 S ^TMP($J,"YSCOR",10)=$$GET1^DIQ(601.87,675_",",3,"I")_"="_N4_U_$J($$GETTSCOR^YTSNEOP1("N4",N4),0,0)
 S ^TMP($J,"YSCOR",11)=$$GET1^DIQ(601.87,691_",",3,"I")_"="_N5_U_$J($$GETTSCOR^YTSNEOP1("N5",N5),0,0)
 S ^TMP($J,"YSCOR",12)=$$GET1^DIQ(601.87,692_",",3,"I")_"="_N6_U_$J($$GETTSCOR^YTSNEOP1("N6",N6),0,0)
 ; "E"
 S ^TMP($J,"YSCOR",13)=$$GET1^DIQ(601.87,648_",",3,"I")_"="_E1_U_$J($$GETTSCOR^YTSNEOP1("E1",E1),0,0)
 S ^TMP($J,"YSCOR",14)=$$GET1^DIQ(601.87,677_",",3,"I")_"="_E2_U_$J($$GETTSCOR^YTSNEOP1("E2",E2),0,0)
 S ^TMP($J,"YSCOR",15)=$$GET1^DIQ(601.87,678_",",3,"I")_"="_E3_U_$J($$GETTSCOR^YTSNEOP1("E3",E3),0,0)
 S ^TMP($J,"YSCOR",16)=$$GET1^DIQ(601.87,679_",",3,"I")_"="_E4_U_$J($$GETTSCOR^YTSNEOP1("E4",E4),0,0)
 S ^TMP($J,"YSCOR",17)=$$GET1^DIQ(601.87,680_",",3,"I")_"="_E5_U_$J($$GETTSCOR^YTSNEOP1("E5",E5),0,0)
 S ^TMP($J,"YSCOR",18)=$$GET1^DIQ(601.87,681_",",3,"I")_"="_E6_U_$J($$GETTSCOR^YTSNEOP1("E6",E6),0,0)
 ; "O"
 S ^TMP($J,"YSCOR",19)=$$GET1^DIQ(601.87,654_",",3,"I")_"="_O1_U_$J($$GETTSCOR^YTSNEOP1("O1",O1),0,0)
 S ^TMP($J,"YSCOR",20)=$$GET1^DIQ(601.87,682_",",3,"I")_"="_O2_U_$J($$GETTSCOR^YTSNEOP1("O2",O2),0,0)
 S ^TMP($J,"YSCOR",21)=$$GET1^DIQ(601.87,683_",",3,"I")_"="_O3_U_$J($$GETTSCOR^YTSNEOP1("O3",O3),0,0)
 S ^TMP($J,"YSCOR",22)=$$GET1^DIQ(601.87,684_",",3,"I")_"="_O4_U_$J($$GETTSCOR^YTSNEOP1("O4",O4),0,0)
 S ^TMP($J,"YSCOR",23)=$$GET1^DIQ(601.87,685_",",3,"I")_"="_O5_U_$J($$GETTSCOR^YTSNEOP1("O5",O5),0,0)
 S ^TMP($J,"YSCOR",24)=$$GET1^DIQ(601.87,686_",",3,"I")_"="_O6_U_$J($$GETTSCOR^YTSNEOP1("O6",O6),0,0)
 ; "A"
 S ^TMP($J,"YSCOR",25)=$$GET1^DIQ(601.87,660_",",3,"I")_"="_A1_U_$J($$GETTSCOR^YTSNEOP1("A1",A1),0,0)
 S ^TMP($J,"YSCOR",26)=$$GET1^DIQ(601.87,687_",",3,"I")_"="_A2_U_$J($$GETTSCOR^YTSNEOP1("A2",A2),0,0)
 S ^TMP($J,"YSCOR",27)=$$GET1^DIQ(601.87,688_",",3,"I")_"="_A3_U_$J($$GETTSCOR^YTSNEOP1("A3",A3),0,0)
 S ^TMP($J,"YSCOR",28)=$$GET1^DIQ(601.87,689_",",3,"I")_"="_A4_U_$J($$GETTSCOR^YTSNEOP1("A4",A4),0,0)
 S ^TMP($J,"YSCOR",29)=$$GET1^DIQ(601.87,690_",",3,"I")_"="_A5_U_$J($$GETTSCOR^YTSNEOP1("A5",A5),0,0)
 S ^TMP($J,"YSCOR",30)=$$GET1^DIQ(601.87,693_",",3,"I")_"="_A6_U_$J($$GETTSCOR^YTSNEOP1("A6",A6),0,0)
 ; "C"
 S ^TMP($J,"YSCOR",31)=$$GET1^DIQ(601.87,666_",",3,"I")_"="_C1_U_$J($$GETTSCOR^YTSNEOP1("C1",C1),0,0)
 S ^TMP($J,"YSCOR",32)=$$GET1^DIQ(601.87,667_",",3,"I")_"="_C2_U_$J($$GETTSCOR^YTSNEOP1("C2",C2),0,0)
 S ^TMP($J,"YSCOR",33)=$$GET1^DIQ(601.87,668_",",3,"I")_"="_C3_U_$J($$GETTSCOR^YTSNEOP1("C3",C3),0,0)
 S ^TMP($J,"YSCOR",34)=$$GET1^DIQ(601.87,669_",",3,"I")_"="_C4_U_$J($$GETTSCOR^YTSNEOP1("C4",C4),0,0)
 S ^TMP($J,"YSCOR",35)=$$GET1^DIQ(601.87,670_",",3,"I")_"="_C5_U_$J($$GETTSCOR^YTSNEOP1("C5",C5),0,0)
 S ^TMP($J,"YSCOR",36)=$$GET1^DIQ(601.87,671_",",3,"I")_"="_C6_U_$J($$GETTSCOR^YTSNEOP1("C6",C6),0,0)
 Q
 ;
DLLSTR(YSDATA,YS,YSTRNG) ;
 ;  YSTRNG = 1 Score Instrument
 ;  YSTRNG = 2 get Report Answers and Text
 N DATA,DES,NODE,LEG,SCORE,YSCDA,YSQN,YSINSNAM,TSARR
 N RAW,RESULT,SKIP,RSLT,RSLT1,SCALE,YSAD
 N ZERO,ONE,TWO,THREE,FOUR
 N TMPRSLT,TMPANS,VA,VB,VC,VR
 N REGULAR,REVERSE,REGREV,TSARR
 N V0,V1,V2,V3,V4
 N N,N1,N2,N3,N4,N5,N6
 N E,E1,E2,E3,E4,E5,E6
 N O,O1,O2,O3,O4,O5,O6
 N A,A1,A2,A3,A4,A5,A6
 N C,C1,C2,C3,C4,C5,C6
 ;
 S REVERSE="REVERSE"
 S REGULAR="REGULAR"
 ;
 S (TMPRSLT,TMPANS)=""
 S (N,N1,N2,N3,N4,N5,N6)=0
 S (E,E1,E2,E3,E4,E5,E6)=0
 S (O,O1,O2,O3,O4,O5,O6)=0
 S (A,A1,A2,A3,A4,A5,A6)=0
 S (C,C1,C2,C3,C4,C5,C6)=0
 S (V0,V1,V2,V3,V4)=0
 S (SKIP,ZERO,ONE,TWO,THREE,FOUR)=0
 S (VA,VB,VC,VR)=""
 ;
 S (RESULT,STRING)=""
 S (DES,RAW)=0
 ;
 D DATA1
 ;
 I YSTRNG=1 D
 .D SCORDOM^YTSNEOP3
 .D SCORESV
 ;
 I YSTRNG=2 D
 .K TSARR
 .S RSLT="",RSLT1="",TSARR("NOADM")=""
 .S YSAD=YS("AD")
 .; special subroutine to get both Raw and Transformed scores
 .D LDTSCOR^YTSCORE(.TSARR,YSAD)
 .I TSARR("NOADM")="" D
 ..D PROGNOTE^YTSNEOP2
 .S YSDATA($O(YSDATA(""),-1)+1)=999999999999_U_U_$S(TSARR("NOADM")'="":TSARR("NOADM"),1:RSLT)
 Q
