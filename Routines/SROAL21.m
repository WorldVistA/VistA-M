SROAL21 ;BIR/ADM - LOAD POSTOPERATIVE LAB DATA (CONTINUED) ;06/27/06
 ;;3.0; Surgery ;**38,47,65,88,125,153**;24 Jun 93;Build 11
STUFF ; Transfer data from arrays to file 130.
 W !!,"..Moving postoperative lab data to Surgery Risk Assessment file...."
SRAT2 I $D(SRAT("H",2)) S X=SRAT("H",2) S SRL=1,SRH=5 D INPUT S $P(^SRF(SRTN,203),"^",13)=X,$P(^(204),"^",13)=$S(X'="":SRAD("H",2),1:"")
SRAT3 I $D(SRAT("H",3)) S X=SRAT("H",3) S SRL=1,SRH=5 D INPUT S $P(^SRF(SRTN,203),"^",14)=X,$P(^(204),"^",14)=$S(X'="":SRAD("H",3),1:"")
SRAT4 I $D(SRAT("H",4)) S X=SRAT("H",4) S SRL=1,SRH=5 D INPUT S $P(^SRF(SRTN,203),"^")=X,$P(^(204),"^")=$S(X'="":SRAD("H",4),1:"")
SRAT5 I $D(SRAT("H",5)) S X=SRAT("H",5) S SRL=1,SRH=3 D INPUT S $P(^SRF(SRTN,203),"^",3)=X,$P(^(204),"^",3)=$S(X'="":SRAD("H",5),1:"")
SRAT7 I $D(SRAT("H",7)) S X=SRAT("H",7) S SRL=1,SRH=4 D INPUT S $P(^SRF(SRTN,203),"^",6)=X,$P(^(204),"^",6)=$S(X'="":SRAD("H",7),1:"")
SRAT9 I $D(SRAT("H",9)) S X=SRAT("H",9) S SRL=1,SRH=6 D INPUT S $P(^SRF(SRTN,203),"^",7)=X,$P(^(204),"^",7)=$S(X'="":SRAD("H",9),1:"")
SRAT10 I $D(SRAT("H",10)) S X=SRAT("H",10) S SRL=1,SRH=4 D INPUT S $P(^SRF(SRTN,203),"^",8)=X,$P(^(204),"^",8)=$S(X'="":SRAD("H",10),1:"")
SRAT14 I $D(SRAT("H",14)) S X=SRAT("H",14) S SRL=1,SRH=5 D INPUT S $P(^SRF(SRTN,203),"^",9)=X,$P(^(204),"^",9)=$S(X'="":SRAD("H",14),1:"")
SRAT16 I $D(SRAT("H",16)) S X=SRAT("H",16) S SRL=1,SRH=4 D INPUT S $P(^SRF(SRTN,203),"^",10)=X,$P(^(204),"^",10)=$S(X'="":SRAD("H",16),1:"")
SRAT17 I $D(SRAT("L",17)) S X=SRAT("L",17) S SRL=1,SRH=4 D INPUT S $P(^SRF(SRTN,203),"^",12)=X,$P(^(204),"^",12)=$S(X'="":SRAD("L",17),1:"")
SRAT26 I $D(SRAT("H",26)) S X=SRAT("H",26) S SRL=1,SRH=5 D INPUT S $P(^SRF(SRTN,203),"^",16)=X,$P(^(204),"^",16)=$S(X'="":SRAD("H",26),1:"")
SRAT4L I $D(SRAT("L",4)) S X=SRAT("L",4) S SRL=1,SRH=5 D INPUT S $P(^SRF(SRTN,203),"^",2)=X,$P(^(204),"^",2)=$S(X'="":SRAD("L",4),1:"")
SRAT5L I $D(SRAT("L",5)) S X=SRAT("L",5) S SRL=1,SRH=3 D INPUT S $P(^SRF(SRTN,203),"^",4)=X,$P(^(204),"^",4)=$S(X'="":SRAD("L",5),1:"")
 Q
NUM ; input transform logic for lab tests  
 N SRX I X="NS"!(X="ns") S X="NS" D:$D(SRCICSP) CARDNS Q
 S SRX=X S:"<>"[$E(X) SRX=$E(X,2,99)
 I +SRX'=SRX K X Q
 Q
INPUT ; capture input check
 N SRX,SRY I X="NS"!(X="") Q
 I $L(X)<SRL S X="" Q
 S SRX=X,SRY="" S:" <>"[$E(X) SRY=$E(X),SRX=$E(X,2,99)
 I +SRX'=SRX S X=""
 I $L(X)>SRH D
 .I SRX["." S SRX=SRX+.05\.1*.1,X=SRY_SRX I $L(X)>SRH S SRX=SRX+.5\1,X=SRY_SRX
 .I $L(X)>SRH S X=""
 Q
CARDNS ; if cardiac, NS not allowed
 N SRTYPE,SRXX
 S SRXX=$S($D(SRTN):SRTN,$D(DA):DA,1:"") Q:'SRXX
 S SRTYPE=$P($G(^SRF(SRXX,"RA")),"^",2)
 I SRTYPE="C" K X
 K SRCICSP
 Q
