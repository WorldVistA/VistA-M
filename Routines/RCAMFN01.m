RCAMFN01 ;WASH-ISC@ALTOONA,PA/RGY-MISCELLANEOUS AR FUNCTIONS ;4/30/96  8:39 AM
V ;;4.5;Accounts Receivable;**39,86**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
FPS(DATE,STM) ;
 ;Get a future or past statement date
 ;P1(STM)=statement date, P2(STM)=months to add or subtract
 NEW X,Y,END,YR,MT
 S Y=-1
 I $G(DATE)'?7N G Q1
 I $G(STM)'?.1"-"1N.N G Q1
 S YR=$E(DATE,1,3),MT=$E(DATE,4,5),Y=$S(STM<0:-STM,1:STM)
 F X=1:1:Y S MT=MT+$S(STM<0:-1,1:1) S:MT>12 YR=YR+1,MT=1 S:MT<1 YR=YR-1,MT=12
 S Y=YR_$S(MT<10:0_MT,1:MT)_$E(DATE,6,7)
Q1 Q Y
PST(Y) ;Input: debtor variable pointer value (EX: 1;DPT(, 34;DIC(36, etc)
 ;Return: Statement day or -1
 I '$D(Y) S Y=-1
 S:Y?1N.N Y=$P($G(^RCD(340,Y,0)),"^")
 S Y=$P($G(^RCD(340,+$O(^RCD(340,"B",Y,0)),0)),"^",3) S:'Y Y=-1
 Q Y
REC(DEB) ;Return receivable code for debtor
 NEW X
 S X=""
 I $G(DEB)="" G Q4
 S:DEB'?1N.N DEB=$O(^RCD(340,"B",DEB,0))
 S X=$G(^RCD(340,DEB,0)) G:$P(X,"^")="" Q4
 I $P(X,"^")[";DPT(" S X=2 G Q4
 I $P(X,"^")[";VA(200," S X=2 G Q4
 I $P(X,"^")[";DIC(36" S X=$S($P(X,"^",5)=3:3,$P(X,"^",5)=1:1,1:2) G Q4
 I $P(X,"^")[";DIC(4," S X=$S($P(X,"^",5)=3:3,$P(X,"^",5)=2:2,1:1) G Q4
 I $P(X,"^")[";PRC(" S X=$S($P(X,"^",5)=3:3,$P(X,"^",5)=1:1,1:2) G Q4
Q4 Q X
