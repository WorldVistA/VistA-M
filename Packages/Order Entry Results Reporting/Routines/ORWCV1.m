ORWCV1 ; slc/dcm - CoverSheet calls continued ;Nov 24, 2018@17:07
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**85,OSE/SMH**;Dec 17, 1997
 ; OSE/SMH Changes (c) Sam Habiel 2018
 ; Licensed Under Apache 2.0
 ;
COVERLST(LST)        ; -- return data for coversheet
 ;RPC: ORWCV1 COVERSHEET LIST
 N I,J,X,X0,X2,CNT,EOF,ROOT,RPC,LIST,DETAIL,HEAD
 S EOF="$$END",ROOT=$NA(LST),(CNT,I)=0
 D GETLST^XPAR(.LIST,"ALL","ORWCV1 COVERSHEET LIST")
 F  S I=$O(LIST(I)) Q:'I  Q:'$D(^ORD(101.24,$P(LIST(I),"^",2),0))  S X0=^(0),X2=$G(^(2)) D
 . Q:$P(X0,"^",12)="L"
 . S RPC=$P($G(^XWB(8994,+$P(X0,"^",13),0)),"^"),DETAIL=""
 . I $P(X0,"^",18) S DETAIL=$P($G(^ORD(101.24,+$P(X0,"^",18),0)),"^",13),DETAIL=$P($G(^XWB(8994,+DETAIL,0)),"^")
 . S HEAD=$P(X0,"^") I $L($P(X2,"^",3)) S HEAD=$$GET1^DIQ(101.24,$P(LIST(I),U,2),.23) ; OSE/SMH - was S HEAD=$P(X2,"^",3)
 . S X=$P(X0,"^",2)_"^"_HEAD_"^"_$P(X0,"^",3)_"^"_$P(X0,"^",12)_"^"_$P(X0,"^",7)_"^"_RPC_"^"_$P(X0,"^",9)
 . S X=X_"^"_$P(X0,"^",10)_"^"_$P(X0,"^",11)_"^"_$P(X0,"^",14)_"^"_$P(X0,"^",15)_"^"_$P(X2,"^")_"^"_$P(X0,"^",4)_"^"_$P(X0,"^",16)_"^"_$P(X0,"^",17)_"^"_DETAIL_"^"_LIST(I)
 . D SETITEM(.ROOT,X)
 Q
SETITEM(ROOT,X) ; -- set item in list
 S @ROOT@($O(@ROOT@(9999),-1)+1)=X
 Q
DETAIL(ID)  ;Get RPC for Detail report
 ;ID=Cover sheet TAG ID
 Q:'$L($G(ID)) ""
 N I,X0,DETAIL
 S I=0,DETAIL=""
 F  S I=$O(^ORD(101.24,"AC",ID,I)) Q:'I  S X0=$G(^ORD(101.24,I,0)) I $P(X0,"^",8)="C",$P(X0,"^",18) S DETAIL=$P($G(^ORD(101.24,+$P(X0,"^",18),0)),"^",13),DETAIL=$P($G(^XWB(8994,+DETAIL,0)),"^")
 Q DETAIL
