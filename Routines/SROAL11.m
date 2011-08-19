SROAL11 ;BIR/ADM - LOAD PREOP LAB DATA (CONTINUED) ;06/27/06
 ;;3.0; Surgery ;**38,47,65,95,125,153,160,174**;24 Jun 93;Build 8
STUFF ; Transfer test data from array to file 130
 W !!,"..Moving preoperative lab test data to Surgery Risk Assessment file...."
N4 I $D(SRAT(4)) S X=SRAT(4),SRL=1,SRH=5 D INPUT S $P(^SRF(SRTN,201),"^")=X S $P(^(202),"^")=$S(X'="":SRAD(4),1:"") ; Sodium
N7 I $D(SRAT(7)) S X=SRAT(7),SRL=1,SRH=4 D INPUT S $P(^SRF(SRTN,201),"^",4)=X,$P(^(202),"^",4)=$S(X'="":SRAD(7),1:"") ; Creatinine
N8 I $D(SRAT(8)) S X=SRAT(8),SRL=1,SRH=5 D INPUT S $P(^SRF(SRTN,201),"^",5)=X,$P(^(202),"^",5)=$S(X'="":SRAD(8),1:"") ; BUN
N11 I $D(SRAT(11)) S X=SRAT(11),SRL=1,SRH=4 D INPUT S $P(^SRF(SRTN,201),"^",8)=X,$P(^(202),"^",8)=$S(X'="":SRAD(11),1:"") ; Albumin
N13 I $D(SRAT(13)) S X=SRAT(13),SRL=1,SRH=5 D INPUT S $P(^SRF(SRTN,201),"^",11)=X,$P(^(202),"^",11)=$S(X'="":SRAD(13),1:"") ; SGOT
N14 I $D(SRAT(14)) S X=SRAT(14),SRL=1,SRH=5 D INPUT S $P(^SRF(SRTN,201),"^",9)=X,$P(^(202),"^",9)=$S(X'="":SRAD(14),1:"") ; Total Bilirubin
N15 I $D(SRAT(15)) S X=SRAT(15),SRL=1,SRH=5 D INPUT S $P(^SRF(SRTN,201),"^",12)=X,$P(^(202),"^",12)=$S(X'="":SRAD(15),1:"") ; Alkaline Phosphatase
N16 I $D(SRAT(16)) S X=SRAT(16),SRL=1,SRH=4 D INPUT S $P(^SRF(SRTN,201),"^",13)=X,$P(^(202),"^",13)=$S(X'="":SRAD(16),1:"") ; White Blood Count
N17 I $D(SRAT(17)) S X=SRAT(17),SRL=1,SRH=4 D INPUT S $P(^SRF(SRTN,201),"^",14)=X,$P(^(202),"^",14)=$S(X'="":SRAD(17),1:"") ; Hematocrit
N18 I $D(SRAT(18)) S X=SRAT(18),SRL=1,SRH=5 D INPUT S $P(^SRF(SRTN,201),"^",15)=X,$P(^(202),"^",15)=$S(X'="":SRAD(18),1:"") ; Platelet Count
N19 I $D(SRAT(19)) S X=SRAT(19),SRL=1,SRH=4 D INPUT S $P(^SRF(SRTN,201),"^",17)=X,$P(^(202),"^",17)=$S(X'="":SRAD(19),1:"") ; PT
N20 I $D(SRAT(20)) S X=SRAT(20),SRL=1,SRH=5 D INPUT S $P(^SRF(SRTN,201),"^",16)=X,$P(^(202),"^",16)=$S(X'="":SRAD(20),1:"") ; PTT
N25 I $D(SRAT(25)) S X=SRAT(25),SRL=1,SRH=5 D INPUT S $P(^SRF(SRTN,201),"^",27)=X,$P(^(202),"^",27)=$S(X'="":SRAD(25),1:"") ; INR
N26 I $D(SRAT(26)) S X=SRAT(26),SRL=1,SRH=5 D INPUT S $P(^SRF(SRTN,203),"^",15)=X,$P(^(204),"^",15)=$S(X'="":SRAD(26),1:"") ; ANION GAP
N27 I $D(SRAT(27)) S X=SRAT(27),SRL=1,SRH=6 D INPUT S $P(^SRF(SRTN,201),"^",28)=X,$P(^(202.1),"^")=$S(X'="":SRAD(27),1:"") ; HEMOGLOBIN A1C
 Q
CARDIAC ; LOAD CARDIAC LAB DATA (CONTINUED)
 N SRCRD
C1 I $D(SRAT(1)) S X=SRAT(1),SRL=1,SRH=7,SRCRD=1 D INPUT S $P(^SRF(SRTN,201),"^",20)=X,$P(^(202),"^",20)=$S(X'="":SRAD(1),1:"") ; Hemoglobin
C5 I $D(SRAT(5)) S X=SRAT(5),SRL=1,SRH=6 D INPUT S $P(^SRF(SRTN,201),"^",23)=X,$P(^(202),"^",23)=$S(X'="":SRAD(5),1:"") ; Potassium (Cardiac)
C7 I $D(SRAT(7)) S X=SRAT(7),SRL=1,SRH=4,SRCRD=1 D INPUT S $P(^SRF(SRTN,201),"^",4)=X,$P(^(202),"^",4)=$S(X'="":SRAD(7),1:"") ; Creatinine
C11 I $D(SRAT(11)) S X=SRAT(11),SRL=1,SRH=4 D INPUT S $P(^SRF(SRTN,201),"^",8)=X,$P(^(202),"^",8)=$S(X'="":SRAD(11),1:"") ; Albumin
C14 I $D(SRAT(14)) S X=SRAT(14),SRL=1,SRH=6 D INPUT S $P(^SRF(SRTN,201),"^",24)=X,$P(^(202),"^",24)=$S(X'="":SRAD(14),1:"") ; Total Bilirubin (Cardiac)
C21 I $D(SRAT(21)) S X=SRAT(21),SRL=1,SRH=6 D INPUT S $P(^SRF(SRTN,201),"^",21)=X,$P(^(202),"^",21)=$S(X'="":SRAD(21),1:"") ; HDL
C22 I $D(SRAT(22)) S X=SRAT(22),SRL=1,SRH=6 D INPUT S $P(^SRF(SRTN,201),"^",22)=X,$P(^(202),"^",22)=$S(X'="":SRAD(22),1:"") ; Triglyceride
C23 I $D(SRAT(23)) S X=SRAT(23),SRL=1,SRH=6 D INPUT S $P(^SRF(SRTN,201),"^",25)=X,$P(^(202),"^",25)=$S(X'="":SRAD(23),1:"") ; LDL
C24 I $D(SRAT(24)) S X=SRAT(24),SRL=1,SRH=6 D INPUT S $P(^SRF(SRTN,201),"^",26)=X,$P(^(202),"^",26)=$S(X'="":SRAD(24),1:"") ; Cholesterol
C27 I $D(SRAT(27)) S X=SRAT(27),SRL=1,SRH=6 D INPUT S $P(^SRF(SRTN,201),"^",28)=X,$P(^(202.1),"^")=$S(X'="":SRAD(27),1:"") ; HEMOGLOBIN A1C
C28 I $D(SRAT(28)) S X=SRAT(28),SRL=1,SRH=6 D INPUT S $P(^SRF(SRTN,201),"^",29)=X,$P(^(202.1),"^",2)=$S(X'="":SRAD(28),1:"") ; B-type Natriuretic Peptide (BNP)
 Q
INPUT ; input checking
 N SRX,SRY I $D(SRCRD),X="NS" S X=""
 K SRCRD I X="NS"!(X="") Q
 I $L(X)<SRL S X="" Q
 S SRX=X,SRY="" S:" <>"[$E(X) SRY=$E(X),SRX=$E(X,2,99)
 I +SRX'=SRX S X="" Q
 I $L(X)>SRH D
 .I SRX["." S SRX=SRX+.05\.1*.1,X=SRY_SRX I $L(X)>SRH S SRX=SRX+.5\1,X=SRY_SRX
 .I $L(X)>SRH S X=""
 Q
