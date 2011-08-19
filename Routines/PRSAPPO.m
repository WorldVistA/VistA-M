PRSAPPO ; HISC/MGD - Open New Pay Period ;07/30/07
 ;;4.0;PAID;**93,112**;Sep 21, 1995;Build 54
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 S PPI=$P(^PRST(458,0),"^",3),PPE=$P(^PRST(458,PPI,0),"^",1)
 D NX^PRSAPPU S X1=D1,X2=14 D C^%DTC S D1=X
 S X1=DT,X2=7 D C^%DTC I D1>X W *7,!!,"You cannot open a Pay Period more than 7 days in advance!" G EX
 D PP^PRSAPPU S X=D1 D DTP^PRSAPPU
A1 W !!,"Do you wish to Open Pay Period ",PPE," beginning ",Y," ? "
 R X:DTIME G:'$T!(X["^") EX S:X="" X="*" S X=$TR(X,"yesno","YESNO")
 I $P("YES",X,1)'="",$P("NO",X,1)'="" W !?5,*7,"Answer YES or NO" G A1
 G:$E(X,1)'="Y" EX
 I $D(^PRST(458,"B",PPE)) W !!,*7,"That Pay Period is already open!" G EX
 K DIC,DD,DO S DIC="^PRST(458,",DIC(0)="L",DLAYGO=458,X=PPE D FILE^DICN G:Y<1 EX
 K DIC,DLAYGO S PPI=+Y,PPIP=PPI-1
A2 I PPIP,'$D(^PRST(458,PPIP)) S PPIP=PPIP-1 G A2
 ; Generate dates
 S Y1=D1 F K=1:1:13 S X2=K,X1=D1 D C^%DTC S Y1=Y1_"^"_X
 S Y2="" F K=1:1:14 S X=$P(Y1,"^",K) D DTP^PRSAPPU S Y=$P("Sat Sun Mon Tue Wed Thu Fri"," ",K#7+1)_" "_Y S $P(Y2,"^",K)=Y
 S ^PRST(458,PPI,1)=Y1,^(2)=Y2
 F K=1:1:14 S X=$P(Y1,"^",K),^PRST(458,"AD",X)=PPI_"^"_K
A3 S ^PRST(458,PPI,"E",0)="^458.01P^^" D NOW^%DTC S NOW=% D ^PRSAPPH
 W !!,"Moving Current Employees into Pay Period ... " S N=0
 N MDAT,MIEN,PRSIEN
 S ATL="ATL00" F  S ATL=$O(^PRSPC(ATL)) Q:ATL'?1"ATL".E  S TLE=$E(ATL,4,6),NAM="" F  S NAM=$O(^PRSPC(ATL,NAM)) Q:NAM=""  F DFN=0:0 S DFN=$O(^PRSPC(ATL,NAM,DFN)) Q:DFN<1  D
 .Q:$D(^PRST(458,PPI,"E",DFN,"D",14,0))
 .I $P($G(^PRSPC(DFN,"LWOP")),"^",1)="Y" Q
 .I $P($G(^PRSPC(DFN,1)),"^",20)="Y" Q
 .I $P($G(^PRSPC(DFN,1)),"^",33)'="N" Q
 .S C0=^PRSPC(DFN,0)
 .I $P(C0,U,10)=2,$P(C0,U,16)=80 S NAWS="9Mo AWS",CT9=$G(CT9)+1
 .I $P(C0,U,10)=1,$P(C0,U,16)=72 S NAWS="36/40 AWS",CT36=$G(CT36)+1
 .S PRSIEN=DFN,MDAT=$P(PDT,U,1)
 .S MIEN=$$MIEN^PRSPUT1(PRSIEN,MDAT)
 .D MOV I $D(HOL),'MIEN S TT="HX",DUP=0 D E^PRSAPPH
 .;
 .; Call to Autopost PT Phy Leave
 .I $G(MIEN) D PLPP^PRSPLVA(PRSIEN,PPI)
 .;
 .; Call to Autopost PT Phy Extended Absence
 .I $G(MIEN) D PEAPP^PRSPEAA(PRSIEN,PPI)
 .S N=N+1 W:N#100=0 "." Q
 ;SEND A MESSAGE WHEN A 9 MONTH AWS NURSE IS ACTIVATED AT A SITE
 I +$G(NAWS) D
 .I $G(CT9) S TMP(1)=CT9_" 9 month AWS nurse(s) set up"
 .I $G(CT36) S TMP(2)=CT36_" 36/40 AWS nurse(s) set up"
 .S S=$$KSP^XUPARAM("INST")_"," D FIND^DIC(456,,,"Q",+S)
 .S IND=$S($D(^TMP("DILIST",$J,0)):+^(0),1:$O(^PRST(456,0)))
 .S CM9=$$GET1^DIQ(456,IND,2),CM36=$$GET1^DIQ(456,IND,4)
 .S MAX=$$GET1^DIQ(456,IND,3) N FDA,DIERR
 .I $G(CT9),CM9<MAX S FDA(456,IND_",",2)=CM9+1
 .I $G(CT36),CM36<MAX S FDA(456,IND_",",4)=CM36+1
 .Q:'$D(FDA)  D FILE^DIE("","FDA"),MSG^DIALOG()
 .S S=$$GET1^DIQ(4,+S,99)_" "_$$GET1^DIQ(4,+S,100),XMTEXT="TMP("
 .S TMP(3)="At "_S,XMDUZ=.5,XMY("VHAOIPAIDETANAWSBULLETIN@VA.GOV")=""
 .S XMSUB=+S_" 36/40, 9 month AWS nurse(s) deployed PRS*4.0*112"
 .D ^XMD K TMP
 S $P(^PRST(458,PPI,"E",0),"^",3,4)=N_"^"_N W !!,N," Employee Records created.",!
EX G KILL^XUSCLEAN
RES ; Re-start/Re-open a Pay Period
 S PPI=$P(^PRST(458,0),"^",3),PPIP=PPI-1 G A3
MOV ; Create PP entry for Employee
 I '$D(^PRST(458,PPI,"E",DFN,0)) S ^(0)=DFN_"^T" D
 .S CPI=$G(^PRST(458,PPIP,"E",DFN,0))
 .S CPI=$S($P(CPI,"^",7)'="":$P(CPI,"^",7),$P(CPI,"^",6)'="":$P(CPI,"^",6),1:$P($G(^PRSPC(DFN,1)),"^",7))
 .S:CPI="" CPI=0 S $P(^PRST(458,PPI,"E",DFN,0),"^",6)=CPI Q
 I '$D(^PRST(458,PPI,"E",DFN,"D",0)) S ^(0)="^458.02^14^14"
 ;
 ; if there's a PTP memo and this is the 1st PP for the memo then
 ; set the memo status to Active
 I $G(MIEN),($P($G(^PRST(458.7,+MIEN,9,1,0)),U,1)=$P($G(^PRST(458,PPI,0)),U,1)) D
 . N IENS,PRSFDA
 . S IENS=+MIEN_","
 . S PRSFDA(458.7,IENS,5)=2 ; 2:ACTIVE
 . D FILE^DIE("","PRSFDA")
 . K PRSFDA
 ;
 F DAY=1:1:14 I '$P($G(^PRST(458,PPI,"E",DFN,"D",DAY,0)),"^",2) D
 . D M1
 . ; Update Daily ESR and post Holiday Excused
 . I MIEN D ESRUPDT^PRSPUT3(PPI,DFN,DAY)
 Q
 ;
M1 ; Set a day
 S Z=$G(^PRST(458,PPIP,"E",DFN,"D",DAY,0)),TD=$P(Z,"^",2) I $P(Z,"^",3) S TD=$P(Z,"^",4)
 S X=$G(^PRST(457.1,+TD,1)),TDH=$P($G(^(0)),"^",6)
 S ^PRST(458,PPI,"E",DFN,"D",DAY,0)=DAY_"^"_TD S:TDH'="" $P(^(0),"^",8)=TDH S:X'="" ^(1)=X
 Q
