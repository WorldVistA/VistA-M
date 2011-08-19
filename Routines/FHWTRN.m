FHWTRN ; HISC/REL - Process Transfers ;3/17/92  14:39
 ;;5.5;DIETETICS;**4**;Jan 28, 2005;Build 32
 ;patch 4 - added alert if pt is transferred
 S (FHWRNEW,FHWROLD)=""
 S FHZ115="P"_DFN,FHWROLD="" D CHECK^FHOMDPA I FHDFN'="" D
 .S:ADM FHWROLD=$P($G(^FHPT(FHDFN,"A",ADM,0)),U,8)
 I FHOLD="" G T0
 ; Edit,Delete Transfers
 I $P(FHOLD,"^",18)=$P(FHNEW,"^",18) G EX
 S XT=$P(FHOLD,"^",18)
 I "^1^2^3^"[("^"_XT_"^") D RET
 I "^22^23^24^"[("^"_XT_"^") D PASS
T0 S XT=$P(FHNEW,"^",18)
 I "^1^2^3^"[("^"_XT_"^") D PASS
 I "^22^23^24^"[("^"_XT_"^") D RET
EX D WRD^FHWADM
 G:'$G(FHDFN) KIL
 S:ADM FHWRNEW=$P($G(^FHPT(FHDFN,"A",ADM,0)),U,8)
 I FHWRNEW,(FHWROLD'=FHWRNEW) D XQAL  ;process alert for transfer
 G KIL
PASS ; Place on Pass
 S FHZ115="P"_DFN D CHECK^FHOMDPA I FHDFN="" Q
 D SET Q:FHLD="P"  Q:'$D(^FHPT(FHDFN,"A",ADM))
 S FHOR="^^^^",FHLD="P",TYP="",D1=X1,D2="",D4=0,COM="" D STR^FHORD7 Q
RET ; Remove from Pass
 D SET I FHLD'="P",FHLD'="X" Q
 S X=^FHPT(FHDFN,"A",ADM,"DI",FHORD,0),D1=$P(X,"^",9),D2=$S(D1'>X1:X1,1:D1)
 S $P(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0),"^",10)=D2
 S A2=0 F KK=0:0 S KK=$O(^FHPT(FHDFN,"A",ADM,"AC",KK)) Q:KK<1!(KK>X1)  S A2=KK
 Q:'A2  Q:$P(^FHPT(FHDFN,"A",ADM,"AC",A2,0),"^",2)'=FHORD
 F K9=A2-.000001:0 S K9=$O(^FHPT(FHDFN,"A",ADM,"AC",K9)) Q:K9<1  I $P(^(K9,0),"^",2)=FHORD S D1=K9 D S0^FHORD3
 D UPD^FHORD7 Q
SET D NOW^%DTC S NOW=%,DT=%\1,FHPV=DUZ,FHWF=$S($D(^ORD(101)):1,1:0)
 S X=$P($G(^DGPM(ADM,0)),"^",1),X1=$S(X'>NOW:NOW,1:X)
 S A1=0,(FHOR,FHLD)="" F KK=0:0 S KK=$O(^FHPT(FHDFN,"A",ADM,"AC",KK)) Q:KK<1!(KK>X1)  S A1=KK
 Q:'A1  S FHORD=$P(^FHPT(FHDFN,"A",ADM,"AC",A1,0),"^",2),X=^FHPT(FHDFN,"A",ADM,"DI",FHORD,0),FHOR=$P(X,"^",2,6),FHLD=$P(X,"^",7) Q
 ;
XQAL ; Check a patient
 S FHCLIN=""
 D PATNAME^FHOMUTL I DFN="" Q
 D CLR
 D NOW^%DTC S NOW=%,FHEDT=$P(NOW,".")
 S Y=^DPT(DFN,0),NAM=$P(Y,"^",1),SEX=$P(Y,"^",2),DOB=$P(Y,"^",3)
 S AGE="" I DOB'="" S AGE=$E(NOW,1,3)-$E(DOB,1,3)-($E(NOW,4,7)<$E(DOB,4,7))
 S FHDUZ=$P($G(^FH(119.6,FHWRNEW,0)),U,2)
 S:FHDUZ FHCLIN=$P($G(^VA(200,FHDUZ,0)),U,1)
P0 ; Calculate BMI
 S GMRVSTR="WT" D EN6^GMRVUTL S WT=$P(X,"^",8),FHWTDT=$P(X,"^",1)
 S GMRVSTR="HT" D EN6^GMRVUTL S HT=$P(X,"^",8),FHHTDT=$P(X,"^",1)
 S FHGMDT=$S(FHWTDT>FHHTDT:FHWTDT,FHHTDT>FHWTDT:FHHTDT,1:FHWTDT)
 S BMI="" I WT,HT S A2=HT*.0254,BMI=+$J(WT/2.2/(A2*A2),0,1)
 I $G(BMI)=""!($G(BMI)'<18.5) G P1
 S MONTX="Monitor: BMI < 18.5",DTE=NOW
 S N=$O(^FHPT(FHDFN,"A",ADM,"MO","B",MONTX,""),-1)
 I N,'$P(^FHPT(FHDFN,"A",ADM,"MO",N,0),U,4) D FIL S MONIFN=N D TCK G P1
 I 'N,(FHGMDT>(FHEDT-7)) D FIL,TFIL G P1
 I 'N G P1
 ; Check if been 30 days
 S LST=$P($G(^FHPT(FHDFN,"A",ADM,"MO",N,0)),"^",2)
 S X=$$FMDIFF^XLFDT(DTE,LST,3) I X>30 D FIL,TFIL
P1 ; Check for current Tubefeeding
 S TF=$P($G(^FHPT(FHDFN,"A",ADM,0)),"^",4) I 'TF G P2
 S MONTX="Monitor: On Tubefeeding",DTE=NOW
 S N=$O(^FHPT(FHDFN,"A",ADM,"MO","B",MONTX,""),-1)
 I N,'$P(^FHPT(FHDFN,"A",ADM,"MO",N,0),U,4) D FIL S MONIFN=N D TCK G P2
 I 'N D FIL,TFIL G P2
 ; Check if been 7 days
 S LST=$P($G(^FHPT(FHDFN,"A",ADM,"MO",N,0)),"^",2)
 S X=$$FMDIFF^XLFDT(DTE,LST,3) I X>7 D FIL,TFIL
P2 ; Check for Hyperals
 S MONTX="",DTE=NOW
 D PSS435^PSS55(DFN,,"FHIV") F DA=0:0 S DA=$O(^TMP($J,"FHIV",DA)) Q:DA<1  D
 .S X0=$P($G(^TMP($J,"FHIV",DA,.02)),"^",2) I X0>NOW Q
 .S MONTX="Monitor: On Hyperals" Q
 I MONTX'="" D FIL,TFIL
P3 ; Check for Serum Albumin
 S MONTX="",PX=6 D LAB^FHASM4 I $D(^TMP($J,"LRTST")) D
 .F L=0:0 S L=$O(^TMP($J,"LRTST",L)) Q:L<1  S Y=$TR($P(^(L),"^",6)," ","") I Y'?1A.E,Y<2.8 S MONTX="Monitor: Albumin < 2.8",DTE=$P(^(L),"^",7) Q
 .Q
 I MONTX="" G P4
 S N=$O(^FHPT(FHDFN,"A",ADM,"MO","B",MONTX,""),-1)
 I N,'$P(^FHPT(FHDFN,"A",ADM,"MO",N,0),U,4) D FIL S MONIFN=N D TCK G P4
 ;process new Albumin if old test date is within 7 days.
 I 'N S X=$$FMDIFF^XLFDT(NOW,DTE) I X<8 D FIL,TFIL G P4
 I 'N G P4
 ; Check if same test
 S LST=$P($G(^FHPT(FHDFN,"A",ADM,"MO",N,0)),"^",2) I DTE>LST D FIL,TFIL
P4 ; Check for NPO+Clr Liq > 3 days
 S A1=NOW,DTE=NOW
 F  D  Q:'A1
 .S A1=$O(^FHPT(FHDFN,"A",ADM,"AC",A1),-1) Q:'A1
 .S FHORD=$P($G(^FHPT(FHDFN,"A",ADM,"AC",A1,0)),"^",2) I 'FHORD S A1="" Q
 .S FHOR=$G(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0))
 .I $P(FHOR,"^",7)="N" S DTE=A1 Q
 .I $P(FHOR,"^",2)=CLR S DTE=A1 Q
 .S A1="" Q
 I DTE'<NOW G P5
 S X=$$FMDIFF^XLFDT(NOW,DTE,3) G:X<3 P5
 S MONTX="Monitor: NPO+Clr Liq > 3 days",DTE=NOW
 S N=$O(^FHPT(FHDFN,"A",ADM,"MO","B",MONTX,""),-1)
 I N,'$P(^FHPT(FHDFN,"A",ADM,"MO",N,0),U,4) D FIL S MONIFN=N D TCK G P5
 I 'N D FIL,TFIL G P5
 ; Check if been 3 days
 S LST=$P($G(^FHPT(FHDFN,"A",ADM,"MO",N,0)),"^",2)
 S X=$$FMDIFF^XLFDT(NOW,LST,3) I X>3 D FIL,TFIL
P5 ; Done
 Q
CLR ; Find Clear Liquid
 S CLR=$O(^FH(111,"B","CLEAR LIQUID",0)) Q:CLR
 S CLR=$O(^FH(111,"C","CLEAR LIQUID",0)) Q:CLR
 S CLR=$O(^FH(111,"C","CLR LIQ",0)) Q:CLR
 S CLR=$O(^FH(111,"C","CL",0)) Q:CLR
 Q
FIL ; File Monitor
 K XQA
 D PATNAME^FHOMUTL
 Q:(MONTX["BMI")&($P($G(^FH(119.6,FHWRNEW,1)),"^",5)'="Y")
 Q:(MONTX["Tubefeed")&($P($G(^FH(119.6,FHWRNEW,1)),"^",6)'="Y")
 Q:(MONTX["Hyperals")&($P($G(^FH(119.6,FHWRNEW,1)),"^",7)'="Y")
 Q:(MONTX["Albumin")&($P($G(^FH(119.6,FHWRNEW,1)),"^",8)'="Y")
 Q:(MONTX["NPO+Clr")&($P($G(^FH(119.6,FHWRNEW,1)),"^",9)'="Y")
 K XQA,XQAMSG,XQAOPT,XQAROU
 S XQAID="FH,"_$J_","_$H
 S XQAMSG=$E(FHPTNM,1,9)_" ("_$E(FHPTNM,1,1)_$P(FHSSN,"-",3)_"): "
 S XQAOPT="FHCTF2",XQAMSG=XQAMSG_"  "_MONTX_" "_$E(DTE,4,5)_"/"_$E(DTE,6,7)_"/"_$E(DTE,2,3)_"    Clinician: "_FHCLIN
 F A=0:0 S A=$O(^FH(119.6,FHWRNEW,2,A)) Q:A'>0  S TK=$P($G(^FH(119.6,FHWRNEW,2,A,0)),U,1),XQA(TK)=""
 I '$D(XQA(FHDUZ)) S XQA(FHDUZ)=""
 D SETUP^XQALERT
 Q
TFIL ;File patient info
 L +^FHPT(FHDFN,"A",ADM,"MO",0)
 I '$D(^FHPT(FHDFN,"A",ADM,"MO",0)) S ^FHPT(FHDFN,"A",ADM,"MO",0)="^115.11^^"
 L -^FHPT(FHDFN,"A",ADM,"MO",0)
 K DIC,DD,DO,DINUM S DIC="^FHPT(FHDFN,""A"",ADM,""MO"",",DIC(0)="L",DA(1)=ADM,DA(2)=FHDFN,DLAYGO=115,X=MONTX D FILE^DICN K DIC,DLAYGO
 Q:Y<1  S MONIFN=+Y
 S $P(^FHPT(FHDFN,"A",ADM,"MO",MONIFN,0),"^",2)=DTE,^FHPT(FHDFN,"A",ADM,"MO","AC",DTE,MONIFN)=""
TCK S FHTF=DTE_"^M^"_MONTX_"^"_DFN_"^"_ADM_"^"_MONIFN  ;set tickler for a clinician
 D:FHDUZ FILE^FHCTF2
 Q
 ;
KIL K %,A1,A2,COM,D1,D2,D4,FHDU,FHLD,FHOR,FHPV,FHX1,FHX2,FHX3,K,K9,KK,NOW,FHORD,TYP,X,X1,X2,X9
 K FHEDT,FHGMDT,FHWTDT,FHHTDT Q
