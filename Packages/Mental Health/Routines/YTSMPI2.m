YTSMPI2 ;SLC/PIJ - Score MMPI-2-RF ; 01/08/2016
 ;;5.01;MENTAL HEALTH;**123**;DEC 30,1994;Build 73
 ;
 ;Public, Supported ICRs
 ; #2056 - Fileman API - $$GET1^DIQ
 ;
 Q
 ;
DATA1 ; Use YSDATA to put responses in Sequence order to utilize previously writen code
 ; This approach is different from other instruments which use Legacy Values and designator
 N NODE,I,SEQ,QNUM
 S YSINSNAM=$P($G(YSDATA(2)),U,3)
 I $G(YSINSNAM)="" S YSINSNAM=$G(YS("CODE"),"NO NAME PASSED")
 S NODE=2 F  S NODE=$O(YSDATA(NODE)) Q:NODE=""  D  ; Start at YSDATA(3)
 . S SEQ($P(YSDATA(NODE),U,2),NODE)=$P(^YTT(601.75,$P(YSDATA(NODE),U,3),0),U,2)
 S QNUM=0
 S SEQ=0 F  S SEQ=$O(SEQ(SEQ)) Q:'SEQ  S I=0 F  S I=$O(SEQ(SEQ,I)) Q:'I  D
 .S QNUM=QNUM+1,RSP(QNUM)=SEQ(SEQ,I)
 .I RSP(QNUM)="X" S RSP(QNUM)="",CANTSAY=CANTSAY_QNUM_", "
 .I $L(CANTSAY)>55,($L(CANTSAY,"|")'>1) S CANTSAY=CANTSAY_"|"
 .I $L(CANTSAY)>170 S CANTSAY=CANTSAY_"|"
 .I $L(CANTSAY)>255 S CANTSAY=CANTSAY_"|"
 I $E(CANTSAY,$L(CANTSAY)-1)="," S CANTSAY=$E(CANTSAY,1,$L(CANTSAY)-2)
 Q
 ;
SCORE ;
 F SCALE="VRIN-r","TRIN-r","F-r","Fp-r","Fs","FBS-r","RBS","L-r","K-r" D
 .D SCORE1^YTSMPIR(.RSLT,SCALE,.RSP)
 F SCALE="EID","THD","BXD","RCd","RC1","RC2","RC3","RC4","RC6","RC7","RC8","RC9" D
 .D SCORE1^YTSMPIR(.RSLT,SCALE,.RSP)
 F SCALE="MLS","HPC","NUC","GIC","SUI","HLP","SFD","NFC","COG","STW","AXY","ANP","BRF","MSF" D
 .D SCORE1^YTSMPIR(.RSLT,SCALE,.RSP)
 F SCALE="JCP","SUB","AGG","ACT","FML","IPP","SAV","SHY","DSF","AES","MEC" D
 .D SCORE1^YTSMPIR(.RSLT,SCALE,.RSP)
 F SCALE="AGGR","PSYC","DISC","NEGE","INTR" D
 .D SCORE1^YTSMPIR(.RSLT,SCALE,.RSP)
 Q
 ;
SCORESV ;
 ;
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 .K ^TMP($J,"YSCOR")
 .S ^TMP($J,"YSCOR",1)="[ERROR]"
 .S ^TMP($J,"YSCOR",2)=YSINSNAM_" Scale not found"
 ;
 K ^TMP($J,"YSCOR")
 S ^TMP($J,"YSCOR",1)="[DATA]"
 ; MMPI-2-RF^Validity
 ; SCR(SCALE)=RAW^TSCORE^PERCENT_ANSWERED^COUNT
 S ^TMP($J,"YSCOR",2)=$$GET1^DIQ(601.87,706_",",3,"I")_"="_SCR("VRIN-r") ; VRIN
 S ^TMP($J,"YSCOR",3)=$$GET1^DIQ(601.87,707_",",3,"I")_"="_SCR("TRIN-r") ;TRIN
 S ^TMP($J,"YSCOR",4)=$$GET1^DIQ(601.87,709_",",3,"I")_"="_SCR("F-r")
 S ^TMP($J,"YSCOR",5)=$$GET1^DIQ(601.87,710_",",3,"I")_"="_SCR("Fp-r")
 S ^TMP($J,"YSCOR",6)=$$GET1^DIQ(601.87,711_",",3,"I")_"="_SCR("Fs")
 S ^TMP($J,"YSCOR",7)=$$GET1^DIQ(601.87,712_",",3,"I")_"="_SCR("FBS-r")
 S ^TMP($J,"YSCOR",8)=$$GET1^DIQ(601.87,713_",",3,"I")_"="_SCR("RBS")
 S ^TMP($J,"YSCOR",9)=$$GET1^DIQ(601.87,714_",",3,"I")_"="_SCR("L-r")
 S ^TMP($J,"YSCOR",10)=$$GET1^DIQ(601.87,715_",",3,"I")_"="_SCR("K-r")
 ; MMPI-2-RF^Higher-Order
 S ^TMP($J,"YSCOR",11)=$$GET1^DIQ(601.87,708_",",3,"I")_"="_SCR("EID")
 S ^TMP($J,"YSCOR",12)=$$GET1^DIQ(601.87,718_",",3,"I")_"="_SCR("THD")
 S ^TMP($J,"YSCOR",13)=$$GET1^DIQ(601.87,719_",",3,"I")_"="_SCR("BXD")
 ; MMPI-2-RF^Restructured Clinical
 S ^TMP($J,"YSCOR",14)=$$GET1^DIQ(601.87,730_",",3,"I")_"="_SCR("RCd")
 S ^TMP($J,"YSCOR",15)=$$GET1^DIQ(601.87,731_",",3,"I")_"="_SCR("RC1")
 S ^TMP($J,"YSCOR",16)=$$GET1^DIQ(601.87,722_",",3,"I")_"="_SCR("RC2")
 S ^TMP($J,"YSCOR",17)=$$GET1^DIQ(601.87,723_",",3,"I")_"="_SCR("RC3")
 S ^TMP($J,"YSCOR",18)=$$GET1^DIQ(601.87,724_",",3,"I")_"="_SCR("RC4")
 S ^TMP($J,"YSCOR",19)=$$GET1^DIQ(601.87,725_",",3,"I")_"="_SCR("RC6")
 S ^TMP($J,"YSCOR",20)=$$GET1^DIQ(601.87,726_",",3,"I")_"="_SCR("RC7")
 S ^TMP($J,"YSCOR",21)=$$GET1^DIQ(601.87,727_",",3,"I")_"="_SCR("RC8")
 S ^TMP($J,"YSCOR",22)=$$GET1^DIQ(601.87,728_",",3,"I")_"="_SCR("RC9")
 ; MMPI-2-RF^Somatic/Cognitive
 S ^TMP($J,"YSCOR",23)=$$GET1^DIQ(601.87,732_",",3,"I")_"="_SCR("MLS")
 S ^TMP($J,"YSCOR",24)=$$GET1^DIQ(601.87,733_",",3,"I")_"="_SCR("GIC")
 S ^TMP($J,"YSCOR",25)=$$GET1^DIQ(601.87,734_",",3,"I")_"="_SCR("HPC")
 S ^TMP($J,"YSCOR",26)=$$GET1^DIQ(601.87,735_",",3,"I")_"="_SCR("NUC")
 S ^TMP($J,"YSCOR",27)=$$GET1^DIQ(601.87,736_",",3,"I")_"="_SCR("COG")
 ; MMPI-2-RF^Internalizing
 S ^TMP($J,"YSCOR",28)=$$GET1^DIQ(601.87,737_",",3,"I")_"="_SCR("SUI")
 S ^TMP($J,"YSCOR",29)=$$GET1^DIQ(601.87,738_",",3,"I")_"="_SCR("HLP")
 S ^TMP($J,"YSCOR",30)=$$GET1^DIQ(601.87,739_",",3,"I")_"="_SCR("SFD")
 S ^TMP($J,"YSCOR",31)=$$GET1^DIQ(601.87,740_",",3,"I")_"="_SCR("NFC")
 S ^TMP($J,"YSCOR",32)=$$GET1^DIQ(601.87,741_",",3,"I")_"="_SCR("STW")
 S ^TMP($J,"YSCOR",33)=$$GET1^DIQ(601.87,742_",",3,"I")_"="_SCR("AXY")
 S ^TMP($J,"YSCOR",34)=$$GET1^DIQ(601.87,743_",",3,"I")_"="_SCR("ANP")
 S ^TMP($J,"YSCOR",35)=$$GET1^DIQ(601.87,744_",",3,"I")_"="_SCR("BRF")
 S ^TMP($J,"YSCOR",36)=$$GET1^DIQ(601.87,745_",",3,"I")_"="_SCR("MSF")
 ; MMPI-2-RF^Externalizing
 S ^TMP($J,"YSCOR",37)=$$GET1^DIQ(601.87,746_",",3,"I")_"="_SCR("JCP")
 S ^TMP($J,"YSCOR",38)=$$GET1^DIQ(601.87,747_",",3,"I")_"="_SCR("SUB")
 S ^TMP($J,"YSCOR",39)=$$GET1^DIQ(601.87,748_",",3,"I")_"="_SCR("AGG")
 S ^TMP($J,"YSCOR",40)=$$GET1^DIQ(601.87,749_",",3,"I")_"="_SCR("ACT")
 ; MMPI-2-RF^Interpersonal
 S ^TMP($J,"YSCOR",41)=$$GET1^DIQ(601.87,752_",",3,"I")_"="_SCR("FML")
 S ^TMP($J,"YSCOR",42)=$$GET1^DIQ(601.87,753_",",3,"I")_"="_SCR("IPP")
 S ^TMP($J,"YSCOR",43)=$$GET1^DIQ(601.87,754_",",3,"I")_"="_SCR("SAV")
 S ^TMP($J,"YSCOR",44)=$$GET1^DIQ(601.87,755_",",3,"I")_"="_SCR("SHY")
 S ^TMP($J,"YSCOR",45)=$$GET1^DIQ(601.87,756_",",3,"I")_"="_SCR("DSF")
 ; MMPI-2-RF^Interest
 S ^TMP($J,"YSCOR",46)=$$GET1^DIQ(601.87,750_",",3,"I")_"="_SCR("AES")
 S ^TMP($J,"YSCOR",47)=$$GET1^DIQ(601.87,751_",",3,"I")_"="_SCR("MEC")
 ; MMPI-2-RF^Personality Psychopathology
 S ^TMP($J,"YSCOR",48)=$$GET1^DIQ(601.87,757_",",3,"I")_"="_SCR("AGGR")
 S ^TMP($J,"YSCOR",49)=$$GET1^DIQ(601.87,758_",",3,"I")_"="_SCR("PSYC")
 S ^TMP($J,"YSCOR",50)=$$GET1^DIQ(601.87,759_",",3,"I")_"="_SCR("DISC")
 S ^TMP($J,"YSCOR",51)=$$GET1^DIQ(601.87,760_",",3,"I")_"="_SCR("NEGE")
 S ^TMP($J,"YSCOR",52)=$$GET1^DIQ(601.87,761_",",3,"I")_"="_SCR("INTR")
 Q
 ;
DLLSTR(YSDATA,YS,YSTRNG) ;
 ;  YSTRNG = 1 Score Instrument
 ;  YSTRNG = 2 get Report Answers and Text
 N CANTSAY,CNT,DASHES,RSP,RSLT,SCALE,SCR,TSARR,TXT,YSINSNAM,YSAD
 S RSLT="",CNT="",SCR="",CANTSAY=""
 ;
 D DATA1
 D SCAN^YTSMPIR(.CNT,.RSP)
 ;
 I YSTRNG=1 D 
 .D BLDRAW^YTSMPIRD
 .D SCORE
 .D SCORESV
 ;
 I YSTRNG=2 D
 .K TSARR
 .S TXT="",TSARR("NOADM")=""
 .S YSAD=YS("AD")
 .; special call to get RESULTS since there are TRANSFORMED values
 .D LDTSCOR^YTSCORE(.TSARR,YSAD)
 .I TSARR("NOADM")="" D
 ..D PROGNOTE^YTSMPI2P
 .S YSDATA($O(YSDATA(""),-1)+1)=999999999999_U_U_$S(TSARR("NOADM")'="":TSARR("NOADM"),1:TXT)
 K T,K2
 Q
