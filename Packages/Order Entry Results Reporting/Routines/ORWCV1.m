ORWCV1 ;SLC/DCM - CoverSheet calls continued ;Aug 20, 2019@09:35
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**85,377**;Dec 17, 1997;Build 582
 ;
COVERLST(LST)        ; -- return data for coversheet
 ;RPC: ORWCV1 COVERSHEET LIST
 N I,J,X,X0,X2,CNT,EOF,ROOT,RPC,LIST,DETAIL,HEAD
 S EOF="$$END",ROOT=$NA(LST),(CNT,I)=0
 D GETLST^XPAR(.LIST,"ALL","ORWCV1 COVERSHEET LIST")
 F  S I=$O(LIST(I)) Q:'I  Q:'$D(^ORD(101.24,$P(LIST(I),U,2),0))  S X0=^(0),X2=$G(^(2)) D
 . Q:$P(X0,U,12)="L"
 . S RPC=$P($G(^XWB(8994,+$P(X0,U,13),0)),U),DETAIL=""
 . I $P(X0,U,18) S DETAIL=$P($G(^ORD(101.24,+$P(X0,U,18),0)),U,13),DETAIL=$P($G(^XWB(8994,+DETAIL,0)),U)
 . S HEAD=$P(X0,U) I $L($P(X2,U,3)) S HEAD=$P(X2,U,3)
 . S X=$P(X0,U,2)_U_HEAD_U_$P(X0,U,3)_U_$P(X0,U,12)_U_$P(X0,U,7)_U_RPC_U_$P(X0,U,9)
 . S X=X_U_$P(X0,U,10)_U_$P(X0,U,11)_U_$P(X0,U,14)_U_$P(X0,U,15)_U_$P(X2,U)_U_$P(X0,U,4)_U_$P(X0,U,16)_U_$P(X0,U,17)_U_DETAIL_U_LIST(I)
 . S X=X_U_$P(X2,U,5)
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
 F  S I=$O(^ORD(101.24,"AC",ID,I)) Q:'I  S X0=$G(^ORD(101.24,I,0)) I $P(X0,U,8)="C",$P(X0,U,18) S DETAIL=$P($G(^ORD(101.24,+$P(X0,U,18),0)),U,13),DETAIL=$P($G(^XWB(8994,+DETAIL,0)),U)
 Q DETAIL
