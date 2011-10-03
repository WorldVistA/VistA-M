FHORT1 ; HISC/REL/NCA - Tubefeeding ;8/19/96  14:55 ;
 ;;5.5;DIETETICS;**1**;Jan 28, 2005
 S ALL=0 D ^FHDPA G:'DFN KIL G:'FHDFN KIL
 ; Set HL7
 D E0 G:'DFN KIL G:'FHDFN KIL S TF=$P($G(^FHPT(FHDFN,"A",ADM,0)),"^",4) D:TF CAN^FHORT2 D ^FHORT11 G:'FHWF KIL
 D TF^FHWOR5 F FHTF=0:0 S FHTF=$O(TUN(FHTF)) Q:FHTF<1  S XX=$G(TUN(FHTF)) D TF1^FHWOR5
 D:$D(MSG) MSG^XQOR("FH EVSEND OR",.MSG) K MSG
 G KIL
E0 ; Process tubefeeding
 S (NO,T1,T2,T3,T4)=0,(PRO,TFCOM)="" K TUN
 S TF=$P(^FHPT(FHDFN,"A",ADM,0),"^",4) G:TF<1 E3
 W !!,"An ACTVE TUBEFEEDING ORDER exists!" D DIS^FHORT2
 R !!,"Do You Wish to Cancel the Existing Tubefeeding and Enter a New One? Y// ",ANS:DTIME I '$T!(ANS="^")  W *7,!!,"No order entered!" S (DFN,FHDFN)="" Q
 S:ANS="" ANS="Y" S X=ANS D TR^FH S ANS=X
 I $P("YES",ANS,1)'="",$P("NO",ANS,1)'="" W !!,"Answer YES to Cancel Existing Order and Enter a New One.",!,"Answer NO to Edit the Existing Tubefeeding Order.",!,"Enter ""^"" to Exit Completely." G E0
 I ANS?1"Y".E K TUN S TFCOM="",NO=0
 I ANS'?1"Y".E W *7,!!,"Edit the Existing Tubefeeding." S TFCOM=$P(T,"^",5)
 I NO=5 W !!,*7,"There are FIVE products already!",!,"You may edit them, or delete a product before adding any."
E3 D ^FHORT10 Q:'DFN  Q:'FHDFN
 I $O(TUN(0))="" W !!,"No Tubefeeding Products selected." G AB
 S (TC,TK)=0 W !
 F K=0:0 S K=$O(TUN(K)) Q:K<1  D
 .S TC=TC+$P(TUN(K),"^",4)+$P(TUN(K),"^",5)
 .S TK=TK+$P(TUN(K),"^",6),STR=$P(TUN(K),"^",2)
 .S PRO=$P(TUN(K),"^",1)
 .W !,"Product: ",$P($G(^FH(118.2,PRO,0)),"^",1),", "
 .W $S(STR=4:"Full",STR=2:"1/2",STR=1:"1/4",1:"3/4"),", "
 .W $P(TUN(K),"^",3)
 .Q
 W !!,"Total Kcal: ",TK,?36,"Total Quantity: ",TC
 I TC>5000 W *7,!!,"WARNING: Total amount exceeds 5000ml: ",TC," ml",!,"Please Edit the Tubefeeding and Modify." G E3
E31 R !!,"Is this Correct ? Y// ",X:DTIME G:'$T!(X="^") AB S:X="" X="Y" D TR^FH I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7,"  Answer YES or NO" G E31
 G:X'?1"Y".E E3
 G:TC>5000 AB
E4 W !,"Comment: ",$S(TFCOM'="":TFCOM_"// ",1:"") R X:DTIME G:'$T!(X[U) AB I X'?.ANP W *7," ??" G E4
 I $L(X)>160!(X?1"?".E) W *7,!,"Enter a comment of up to 160 characters" G E4
 I X'="" S TFCOM=X
E5 R !,"Cancel all current or future tray orders? Y// ",YN:DTIME G:'$T!(YN["^") AB S:YN="" YN="Y" S X=YN D TR^FH S YN=X I $P("YES",YN,1)'="",$P("NO",YN,1)'="" W *7," Answer YES or NO" G E5
 S CAN=YN?1"Y".E
E6 Q:FHWF=2  R !,"Ok to Enter Order? Y// ",YN:DTIME G:'$T!(YN["^") AB S:YN="" YN="Y" S X=YN D TR^FH S YN=X I $P("YES",YN,1)'="",$P("NO",YN,1)'="" W *7," Answer YES or NO" G E6
 G:YN'?1"Y".E AB Q
KIL K %,%H,%I,A,A1,A2,A3,A4,ADM,ALL,ANS,C,CAN,COM,TFCOM,CS,D1,D2,D3,D4,FHDFN,DFN,DX,E,PID,BID,DIC,FHD,FHDR,FHORD,FLG,FLG1,FHLD,FHOR,FHPAR,FHWF,FHPV,FHTF,FHDU,I,K,NO,NOW,DTP,P,P1,P2,POP
 K OLDT,FHSAV,FHORN,MNUM,PR,PRO,NU,QUA,S1,S2,S3,STR,ST1,ST3,T,T1,T2,T3,T4,TC,TK,TF,TF2,TP,TT,TU,TUN,TW,TYP,UNT,WARD,WRD,X,X1,X2,XX,Y,Y0,Y2,YN,YY,Z,Z1,ZZ Q
AB W *7,!!,"Tubefeeding Order TERMINATED - No order entered!" S (DFN,FHDFN)="" Q
