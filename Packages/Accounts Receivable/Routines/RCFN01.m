RCFN01 ;WASH-ISC@ALTOONA,PA/RGY - MISCELLANEOUS AR FUNCTIONS ;Mar 20, 1995
V ;;4.5;Accounts Receivable;**39,65,104,184,348,397**;Mar 20, 1995;Build 7
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;PRCA*4.5*348 Last statement event handler when no last
 ;             statement event exists in file 341 
 ;
SSN(DEBT) ;Get SSN for debtor
 ;Input Debtor (340)
 ;Output: SSN # or null
 NEW Y
 S Y=-1 G:'$G(DEBT) Q1
 S:DEBT?1N.N DEBT=$P($G(^RCD(340,DEBT,0)),"^")
 I DEBT[";DPT(" S Y=$P($G(^DPT(+DEBT,0)),"^",9)
 I DEBT[";VA(200," S Y=$P($G(^VA(200,+DEBT,1)),"^",9)
Q1 Q Y
SADD(TYPE) ;Get AR Group address
 ;Input Type of Address (342.1)
 ;Output: Str1^Str2^Str3^City^State^Zip^Phone
 NEW X
 S X="" G:$G(TYPE)="" Q2 I ",1,2,3,4,5,8,"'[(","_TYPE_","),TYPE'?1N.N1";RC(342.1," G Q2
 I TYPE?1N.N S TYPE=$O(^RC(342.1,"AC",TYPE,0)) G:TYPE="" Q2 S TYPE=TYPE_";RC(342.1,"
 S X=$P($G(^RC(342.1,+TYPE,1)),"^",1,8)
 S:$P(X,"^",5) $P(X,"^",5)=$P($G(^DIC(5,+$P(X,"^",5),0)),"^",2) S:$P(X,"^",6)?9N $P(X,"^",6)=$E($P(X,"^",6),1,5)_"-"_$E($P(X,"^",6),6,9)
Q2 Q X
NAM(DEBT) ;Get DEBTOR name
 NEW Y
 S Y="" G:'$G(DEBT) Q3
 S:DEBT?1N.N DEBT=$P($G(^RCD(340,DEBT,0)),"^") G:DEBT="" Q3
 S Y=$P($G(@("^"_$P(DEBT,";",2)_(+DEBT)_",0)")),"^")
Q3 Q Y
LST(DEBT,TYPE,PRCASTMT) ;Get last type of event for debtor   PRCA*4.5*348
 ;PRCASTMT   Set to 1 when called from statement compiler for no event 2 condition handling
 NEW Y,PRCABIL,PRCATX,PRCADT,PRCATX0,PRCABDT,PRCABLDT,PRCABN     ;PRCA*4.5*348  
 D NOW^%DTC
 S Y=-1 G:'$G(DEBT)!'$G(TYPE) Q4
 S:DEBT?1N.N1";"1A.A1"(" DEBT=$O(^RCD(340,"B",DEBT,0))
 S TYPE=+$O(^RC(341.1,"AC",TYPE,0))
 S Y=+$O(^RC(341,"AD",DEBT,TYPE,0)) I 'Y,'$G(PRCASTMT) S Y=-1 G Q4
 I 'Y,$G(PRCASTMT) D  G Q4
 . S PRCABIL=0,PRCABLDT=0 F  S PRCABIL=$O(^PRCA(430,"C",DEBT,PRCABIL)) Q:'PRCABIL  D
 . . I ":16:42:"[(":"_$P($G(^PRCA(430,PRCABIL,0)),"^",8)_":") D
 . . . S PRCABDT=$P($G(^PRCA(430,PRCABIL,6)),"^",21)
 . . . I 'PRCABLDT S PRCABLDT=PRCABIL_U_PRCABDT Q
 . . . I PRCABDT<$P(PRCABLDT,U,2) S PRCABLDT=PRCABIL_U_PRCABDT
 . S Y=$S(PRCABLDT:$P(PRCABLDT,U,2),1:%) S Y=Y-.000001
 . F PRCADT=Y:0 S PRCADT=$O(^PRCA(433,"ATD",DEBT,PRCADT)) Q:'PRCADT  F PRCATX=0:0 S PRCATX=$O(^PRCA(433,"ATD",DEBT,PRCADT,PRCATX)) Q:'PRCATX  D
 . . S PRCATX0=$G(^PRCA(433,PRCATX,0)) Q:'PRCATX0
 . . S PRCABN=$P(PRCATX0,U,2) Q:PRCABN=""  ;PRCA*4.5*397
 . . S PRCABDT=$P($G(^PRCA(430,PRCABN,6)),U,21) ;PRCA*4.5*397
 . . I PRCABDT,PRCABDT<Y S Y=PRCABDT-.000001,PRCADT=Y,PRCATX="Z"
 . S Y=Y_"^0",PBAL=0
 S Y=9999999.999999-Y_"^"_$O(^RC(341,"AD",DEBT,TYPE,Y,0))
Q4 Q Y
DET(DEBT) ;Return type of detail for RX info
 NEW Y
 S Y=$S($P($G(^RC(342,1,0)),"^",5):$P(^(0),"^",5),1:1) G:'$G(DEBT) Q5
 S:DEBT?1N.N1";"1A.A1"(" DEBT=$O(^RCD(340,"B",DEBT,""))
 I $P($G(^RCD(340,DEBT,0)),"^",2) S Y=$P(^(0),"^",2)
Q5 Q Y
SLH(DATE,DEL) ;Return date format of mm/dd/yyyy
 NEW %DT,X,Y,YR
 S X=$G(DATE),DEL=$S($G(DEL)="":"/",1:DEL),%DT="T" D ^%DT S DATE=Y S:Y<0 DATE="0000000"
 S YR=$E(($E(DATE,1,3)+1700),1,2)
Q6 Q $E(DATE,4,5)_DEL_$E(DATE,6,7)_DEL_$G(YR)_$E(DATE,2,3)
ARPS(BN,DA) ;Determines the purge status of a bill
 ;Input: Bill no. (BN) and file 442 record IEN (DA)
 ;Output: Value of 1 (purge) or 0 (don't purge)
 NEW X,Y
 I $G(BN)=""!($G(DA)="") Q 0
 I '$D(^PRCA(430,"B",BN)),'$D(^PRCA(430,"F",DA)) Q 1
 I $D(^PRCA(430,"B",BN)) S X=+$O(^(BN,0)) I X>0,$D(^PRCA(430.3,"AC",115,+$P(^PRCA(430,X,0),U,8))) Q 1
 I $D(^PRCA(430,"F",DA)) S Y=+$O(^(DA,0)) I Y>0,$D(^PRCA(430.3,"AC",115,+$P(^PRCA(430,Y,0),U,8))) Q 1
 Q 0
FY(DATE) ;Return FY for date, DT is default
 NEW FY
 S:$G(DATE)'?7N.E DATE=DT
 S FY=$E(DATE,2,3) S:$E(DATE,4,5)>9 FY=FY+1 S:FY=100 FY="00"
 I +$E(DATE,4,5)=9 D
 .I $E(DATE,6,7)>$E($$LDATE^RCRJR(DATE),6,7) S FY=FY+1
 .Q
 S:$L(FY)<2 FY="0"_FY
 Q FY
 ;
INTEG(SITE) ;integrated site
 N X
 S X=+$P($G(^RC(342,1,6)),U)
 Q X
 ;
