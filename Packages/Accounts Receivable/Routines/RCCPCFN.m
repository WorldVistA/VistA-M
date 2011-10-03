RCCPCFN ;WASH-ISC@ALTOONA,PA/NYB-Function calls for CCPC ;12/31/96  9:27 AM
V ;;4.5;Accounts Receivable;**34,104,140**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
FP() ;Returns facility phone number
 N GRP,TYP
 S TYP=$O(^RC(342.2,"B","AGENT CASHIER",0))
 S GRP=$O(^RC(342.1,"AC",TYP,0))
 Q $P($G(^RC(342.1,GRP,1)),"^",7)
DAT(DAT) ;Changes date from FM to DDMMYYYY format for CCPC
 N YR
 I '$G(DAT) G QDAT
 S YR=$E(($E(DAT,1,3)+1700),1,2)
 Q $E(DAT,4,5)_$E(DAT,6,7)_$G(YR)_$E(DAT,2,3)
QDAT Q ""
NM(I340) ;Returns first, middle, and last name in 3 different variables
 N FN,LN,MN,NM,XN
 I '$D(I340) G QNM
 S NM=$P($G(^RCPS(349.2,I340,0)),"^",3)
 S LN=$P($G(NM),","),MN=$P($P($G(NM),",",2)," ",2)
 I ($E(MN,1,2)="SR")!($E(MN,1,2)="JR")!(MN?2.3"I")!(MN?0.1"I"1"V"1.3"I") S XN=MN,MN=""
 I $G(XN)="" S XN=$P($G(NM),",",3)
 I $G(XN)="" S XN=$P($P($G(NM),",",2)," ",3)
 S FN=$P($P($G(NM),",",2)," ")
 Q LN_" "_$G(XN)_"^"_FN_"^"_MN
QNM Q ""
STDY() ;Returns Site's Statement Day
 N STDY
 S STDY=$P($G(^RC(342,1,0)),"^",11)
 I $L(STDY)=1 S STDY="0"_STDY
 Q STDY
STDT(SDT) ;Returns Site's Statement Date in MMDDYYYY format for CCPC
 N MTH,STDY,YR
 I SDT="" S SDT=DT
 S STDY=$$STDY()
 I '$G(STDY) S STDY=$E(SDT,6,7)
 S YR=$E(($E(SDT,1,3)+1700),1,2)
 I +$E(SDT,6,7)'>STDY S MTH=$E(SDT,4,5),YR=$G(YR)_$E(SDT,2,3)
 I +$E(SDT,6,7)>STDY S MTH=$$FPS^RCAMFN01(SDT,1),YR=YR_$E(MTH,2,3),MTH=$E(MTH,4,5)
 I +$E(SDT,6,7)'>STDY S MTH=$E(SDT,4,5)
 Q MTH_STDY_$G(YR)
 ;
STD() ;Returns the Statement Date in Fileman format
 N X
 I (+$E(DT,6,7)>+$$STDY^RCCPCFN) S X=$$FPS^RCAMFN01($E(DT,1,5)_$$STDY^RCCPCFN,1)
 E  S X=$E(DT,1,5)_$$STDY
 Q X
STM() ;Returns the Processing Date in DD MM YYYY format for CCPC
 N X1,X2,YR
 ;S X1=$$STD(),X2=-5 D C^%DTC
 S X=$O(^RCPS(349.2,0)),X=$P($G(^RCPS(349.2,+X,0)),"^",10)
 S X=$$ASOF(X)
 S YR=$E(($E(X,1,3)+1700),1,2)
 Q $E(X,4,5)_$E(X,6,7)_$G(YR)_$E(X,2,3)
 ;
KEY(PT) ;Returns CCPC KEY for patient from 340 IFN input
 N X
 S X=$S(($P($G(^RCPS(349.2,+PT,0)),"^",2)]"")&($P($G(^(0)),"^",3)]""):$TR($E($P(^(0),"^",2),1,9)_$E($P($P(^(0),"^",3),","),1,5)," ",""),1:"")
 S X=$$UP^XLFSTR(X)
 Q X
 ;
HEX(AMT) ;sets up amount formatted as 999999999V99S w/no leading blanks and trailing sign
 I $G(AMT)'?.1"-".N.1".".N S AMT="" G Q
 S AMT=$TR($J(AMT,9,2)," ","")
 I $E(AMT)="-" S AMT=$E(AMT,2,99)_$E(AMT,1)
 E  S AMT=AMT_"+"
 S AMT=$P(AMT,".")_$P(AMT,".",2)
Q Q AMT
 ;
 ;
FPS(PT) ;Returns last statement date and activity as of
 N Y
 I '$G(PT) S Y="" G FPSQ
 S Y=$O(^RC(341,"AD",+PT,2,0)),Y=$O(^RC(341,"AD",+PT,2,+Y,0))
 I Y S Y=$G(^RC(341,+Y,6))_"^"_$P($G(^RC(341,+Y,0)),"^",7)
FPSQ Q Y
 ;
 ;
ASOF(DTE) ;Returns the as of date based upon time
 N X
 I '$G(DTE) G ASOFQ
 S X=$P(DTE,".",2) I 'X S X=DTE G ASOFQ
 I $E(X,1,2)'<18 S X=$P(DTE,".") G ASOFQ
 I $E(X,1,2)<18 S X1=DTE,X2=-1 D C^%DTC S X=$P(X,".") G ASOFQ
ASOFQ Q X
