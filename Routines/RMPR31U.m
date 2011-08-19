RMPR31U ;PHX/RFM-FUNCTIONS ;8/29/1994
 ;;3.0;PROSTHETICS;;Feb 09, 1996
ITM(X) ;  Displays external name of an item
 ;  X=Internal number from 661
 S X=+X
 I '$D(^RMPR(661,X,0)) Q "Item not Found"
 S X=$P(^PRC(441,$P(^RMPR(661,X,0),U),0),U,2)
 Q X
ITM1(X) ;  Display # of an item
 ;  X=Internal number from 661
 S X=+X
 I '$D(^RMPR(661,X,0)) Q "Item not Found"
 S X=$P(^PRC(441,$P(^RMPR(661,X,0),U),0),U,1)
 Q X
 ;
VEN(X) ;  Displays external name of a vendor
 ;  X=Internal number of vendor from 440
 S X=+X
 I '$D(^PRC(440,X,0)) Q "Vendor not found"
 S X=$P(^PRC(440,X,0),U)
 Q X
 ;
PAT(X) ;  Displays name of Patient
 N RX
 S RX=X,X=$$NAMESSN^RMPRU(RX)
 Q $P(X,U,1)
 ;  X=Patient IEN
 ;S X=+X
 ;II'$D(^DPT(X,0)) Q "Patient not found"
 ;S X=$P(^DPT(X,0),U)
 ;Q X
 ;
EMP(X) ;  Displays name of employee
 ;  X=Internal number from 200
 S X=+X
 S X=$S($D(^VA(200,X,0)):$P(^(0),U),1:"")
 Q X
 ;
ITEM(X) ;  Displays name of item from 660
 ;  X=IEN of record from 660
 S X=+X
 I '$D(^RMPR(660,X,0)) Q ""
 I '$D(^RMPR(661,+$P(^RMPR(660,X,0),U,6),0)) Q ""
 S X=$P(^PRC(441,$P(^RMPR(661,$P(^RMPR(660,X,0),U,6),0),U),0),U,2)
 Q X
ITMN(X) ;  Displays NUMBER of item from 660
 ;  X=IEN of record from 660
 S X=+X
 I '$D(^RMPR(660,X,0)) Q ""
 I '$D(^RMPR(661,+$P(^RMPR(660,X,0),U,6),0)) Q ""
 S X=$P(^PRC(441,$P(^RMPR(661,$P(^RMPR(660,X,0),U,6),0),U),0),U,1)
 Q X
SIG(X) ;Displays Printed signature bock from file 200
 S X=+X
 S X=$S($D(^VA(200,X,20)):$P(^(20),U,2),1:"")
 Q X
STA(X) ;Displays Station Name from file Institution File
 S X=+X
 S X=$S($D(^DIC(4,X,0)):$P(^(0),U),1:"")
 Q X
STAN(X) ;Displays Station Number from file Institution File
 S X=+X
 S X=$S($D(^DIC(4,X,99)):$P(^(99),U),1:"")
 Q X
CODE(PZD,TYPE,SRC) ;GET ORTHOTIC OR RESTORATION CODE
 ;N RAM
 I TYPE="X",SRC="R" S AMIS=$S(+$P(RMPRAM,U,2):"134",1:$P($G(^RMPR(663,+$P(PZD,U,8),0)),U,5))_U_$S($D(RMPRGEC):$P($G(^RMPR(663,+$P(PZD,U,8),0)),U),1:+$P(PZD,U,8))
 I TYPE="X",SRC'="R" S AMIS=$S(+$P(RMPRAM,U,2):"138",1:$P($G(^RMPR(663,+$P(PZD,U,6),0)),U,5))_U_$S($D(RMPRGEC):$P($G(^RMPR(663,+$P(PZD,U,6),0)),U),1:+$P(PZD,U,6))
 I TYPE'="X",SRC'="R" S AMIS=$S(+$P(RMPRAM,U,2):"138",1:$P($G(^RMPR(663,+$P(PZD,U,5),0)),U,5))_U_$S($D(RMPRGEC):$P($G(^RMPR(663,+$P(PZD,U,5),0)),U),1:+$P(PZD,U,5))
 I TYPE'="X",SRC="R" S AMIS=$S(+$P(RMPRAM,U,2):"134",1:$P($G(^RMPR(663,+$P(PZD,U,7),0)),U,5))_U_$S($D(RMPRGEC):$P($G(^RMPR(663,+$P(PZD,U,7),0)),U),1:+$P(PZD,U,7))
 I '$D(RMPRGEC),$G(RMPRE),RMPRE'=$P(AMIS,U,2) S AMIS=""
 Q AMIS
BLD ;BUILD TMP GLOBAL FOR LAB/RESTORATION AMIS
 N RI,RA,RT
 F RI=132,133,135,136,137 F RT=0:0 S RT=$O(^RMPR(663,"E",RI,RT)) Q:RT'>0  I $D(^RMPR(663,RT,0)) S ^TMP($J,RI_U_$P(^RMPR(663,RT,0),U))="0^0^0^0^0^0^0^0^0"
 F RA=134,138 F RI="01","02","03","04","05","06","07","08","09","10" S ^TMP($J,RA_U_RI)="0^0^0^0^0^0^0"
 Q
