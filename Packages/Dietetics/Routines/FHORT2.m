FHORT2 ; HISC/REL/NCA - Tubefeeding Inquiry/Cancel ;6/25/96  10:50 ;
 ;;5.5;DIETETICS;**1**;Jan 28, 2005
EN2 ; Current Tubefeeding
 S (ALL,TF)=0 D ^FHDPA Q:'DFN  Q:'FHDFN
 S TF=$P(^FHPT(FHDFN,"A",ADM,0),"^",4)
 I TF<1 W !!,"No Tubefeeding Order Exists" Q
DIS ; Display Tubefeeding
 S T=^FHPT(FHDFN,"A",ADM,"TF",TF,0),DTP=$P(T,"^",1),NO=0 D DTP^FH W !!,"Date Ordered: ",DTP
 W ! F TF2=0:0 S TF2=$O(^FHPT(FHDFN,"A",ADM,"TF",TF,"P",TF2)) Q:TF2<1  S Y=^(TF2,0),TUN(+Y)=Y,NO=NO+1 D D1
 S TFCOM=$P(T,"^",5)
 W !!,"Total KCAL: ",$P(T,"^",7),?42,"Total Quantity: ",$P(T,"^",6)," ml"
 W:TFCOM'="" !,"Comment: ",TFCOM Q
D1 S TUN=$P(Y,"^",1),STR=$P(Y,"^",2),QUA=$P(Y,"^",3)
 I QUA["CC" S QUAFI=$P(QUA,"CC",1),QUASE=$P(QUA,"CC",2),QUA=QUAFI_"ML"_QUASE
 W !,"Product: ",$P($G(^FH(118.2,TUN,0)),"^",1),", ",$S(STR=4:"Full",STR=1:"1/4",STR=2:"1/2",1:"3/4")," Str., ",QUA Q
EN3 ; Cancel Tubefeeding
 D EN2 G:TF<1 KIL S FHD="N" D ASK G:FHD'="Y" KIL D CAN
 D CUR^FHORD7 I Y="" W *7,!!,"Note: NO current DIET ORDER exists for this patient!" G KIL
 G:"^^^^"'[FHOR KIL I FHLD'="" W *7,!!,"Note: Patient is on a WITHHOLD SERVICE Order!"
C1 R !!,"Do you wish to RESUME Tray Service? N// ",X:DTIME G:'$T!(X="^") KIL S:X="" X="N" D TR^FH I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7,"  Answer YES or NO" G C1
 G:X'?1"Y".E KIL S A2=0 F KK=0:0 S KK=$O(^FHPT(FHDFN,"A",ADM,"AC",KK)) Q:KK<1!(KK'<NOW)  I $P(^(KK,0),"^",2)=FHORD S A2=KK
 I 'A2 W *7,!!,"Cannot CANCEL -- Try using Cancel Withhold option!" G KIL
 S DT=$P(NOW,".",1),KK=A2,OLD=FHLD D T0^FHORD3 G KIL
ASK ; Ask if wish to cancel
 W !!,"Do you wish to CANCEL the ORIGINAL Tubefeeding? ",FHD,"// " R X:DTIME I '$T!(X["^") S FHD="N" Q
 S:X="" X=FHD D TR^FH I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7,"  Answer YES or NO" G ASK
 S FHD=$E(X,1) W:FHD'="Y" "  ... no change" Q
CAN ; Perform cancel
 N FHORN,FILL,COM D NOW^%DTC S NOW=%
 S $P(^FHPT(FHDFN,"A",ADM,0),"^",4)="" K ^FHPT("ADTF",FHDFN,ADM)
 S $P(^FHPT(FHDFN,"A",ADM,"TF",TF,0),"^",11,12)=NOW_"^"_DUZ
 S FHORN=$P(^FHPT(FHDFN,"A",ADM,"TF",TF,0),"^",14)
 S FHSAV=$G(^FHPT(FHDFN,"A",ADM,"TF",TF,0))
 K % S EVT="T^C^"_TF D ^FHORX I FHORN S FILL="T"_";"_ADM_";"_TF_";"_$P(FHSAV,"^",6)_";"_$P(FHSAV,"^",7)_";"_$P(FHSAV,"^",5)_";" D CODE^FHWOR5 D:$D(MSG) MSG^XQOR("FH EVSEND OR",.MSG) K MSG,FHSAV,FILL
 Q
KIL K %,%H,%I,A1,A2,C,D1,D2,D3,DA,KK,P2,FHDU,NOW,X1,X2,OLD,FHDR,FHORD,FHPAR,FHLD,FHWF,FHPV,FHOR,I,K9,ADM,ALL,COM,TFCOM,FHDFN,DFN,FHD,POP,PID,BID,DTP,QUA,STR,T,TF,TF2,TUN,WARD,X,X9,Y Q
