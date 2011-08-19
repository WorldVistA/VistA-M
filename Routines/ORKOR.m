ORKOR ; slc/CLA - Order checking support procedure for orders ;12/15/97 [ 04/02/97  2:55 PM ]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**6,32,74,92,105**;Dec 17, 1997
 Q
DUP(ORY,ORDFN,OI,ODT,DG) ; return duplicate order in format:
 ; order#^order text(first 60 chars) order effective d/t [order status]
 Q:DG="FH"  ;quit if diet order (all previous diet orders are auto DCed)
 N BDT,INBDT,XDT,X,ORDT,ORN,ORS,ORSI
 S XDT="",ORN=""
 S X=$$DUPRANGE^ORQOR2(OI,DG,ODT,ORDFN)
 S BDT=$P(X,U),INBDT=$P(X,U,2)
 Q:BDT=0  ;if dup range for OI is zero, don't process dup order oc
 F  S XDT=$O(^OR(100,"AOI",OI,ORDFN_";DPT(",XDT)) Q:XDT=""  D
 .I $G(XDT)<INBDT S ORN="" F  S ORN=$O(^OR(100,"AOI",OI,ORDFN_";DPT(",XDT,ORN)) Q:ORN=""  D
 ..S ORDT=9999999-XDT
 ..Q:'ORN
 ..Q:+$G(ORN)=+$G(ORIFN)  ;quit current order # = dup order #
 ..Q:($P(^OR(100,ORN,8,$P(^OR(100,ORN,8,0),U,3),0),U,2)="DC")
 ..S ORS=$$STATUS^ORQOR2(ORN),ORSI=$P(ORS,U)
 ..;if order status is not canceled, discontinued, expired, lapsed, replaced, delayed:
 ..I (ORSI'=13)&(ORSI'=1)&(ORSI'=7)&(ORSI'=14)&(ORSI'=12)&(ORSI'=10) D
 ...S ORDT=$$FMTE^XLFDT(ORDT,"2P")
 ...S ORY=ORN_U_$P($$TEXT(ORN,60),U,2)_" "_$G(ORDT)_" ["_$P(ORS,U,2)_"]"
 Q
TEXT(ORNUM,ORCHAR) ;ext funct rtns the first ORCHAR chars of an order text
 ;ORNUM - order number (main order number - $P(ORNUM,";",1))
 ;ORCHAR - number of characters to return
 N ORY
 D TEXT^ORQ12(.ORY,+ORNUM,ORCHAR)
 Q:+$G(ORY)>0 "1^"_ORY(1)
 Q "0^Order text not found."
ORDERER(ORNUM) ;extrinsic function returns the order's (ORNUM) original requesting provider
 Q $$ORDERER^ORQOR2(ORNUM)
