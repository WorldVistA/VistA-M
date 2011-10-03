ORWRP3 ; slc/dcm - OE/RR Report Extract RPC's ; 08 May 2001  13:32PM
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**109,120,132,215,243**;Dec 17, 1997;Build 242
 ;
 ; DBIA 4011   Access ^XWB(8994)
 ;
EX(ROOT,TST) ;Expand columns
  ;TST=ptr to file 101.24
  ;Y(i)=id^Name^Qualifier^IOM^Entry^Routine^Remote^Type^Category^RPC^ifn^sort_order^max_days^direct^hdr^fhie
  Q:'$G(TST)
  N J,X,X0,X1,X2,X4,RPC,HEAD,ORX0,ORX2,ORX4,ORX,ORTIMOCC,MAX
  I '$L($G(C)) S C=0
  S ORTIMOCC=$$GET^XPAR("USR.`"_DUZ_"^SYS^PKG","ORWRP TIME/OCC LIMITS INDV",+TST,"I")
  I '$L(ORTIMOCC) S ORTIMOCC=$$GET^XPAR("USR.`"_DUZ_"^SYS^PKG","ORWRP TIME/OCC LIMITS ALL",1,"I")
  S X0=$G(^ORD(101.24,+TST,0)),X2=$G(^(2)),X4=$G(^(4)),MAX=$P(X4,"^",2),X=$P($P(ORTIMOCC,";"),"-",2)
  I $P(X4,"^",10) Q
  I X,MAX,X>MAX S ORTIMOCC="T-"_MAX_";"_$P(ORTIMOCC,";",2,99)
  I '$L(ORTIMOCC) S ORTIMOCC=";;"
  I '$O(^ORD(101.24,+TST,10,0)) D  Q
  . Q:$P(X0,"^",12)="L"
  . S RPC=$P($G(^XWB(8994,+$P(X0,"^",13),0)),"^")  ;DBIA 4011
  . S HEAD=$P(X0,"^")
  . I $L($P(X2,"^",3)) S HEAD=$P(X2,"^",3)
  . S X1=$P(X0,U,2)_U_HEAD_U_ORTIMOCC_";"_$P(X0,U,4)_U_$P(X0,U,19)_";"_$P(X0,U,20)_";"
  . S X=X1_+$P(X0,U,21)_U_$P(X0,U,6)_U_$P(X0,U,5)_U_$P(X0,U,3)_U_$P(X0,U,12)_U_$P(X0,U,7)_U_RPC_U_+TST_U_$P(X4,U)_U_$P(X4,U,2)_U_$P(X4,U,4)_U_$P(X4,U,5)_U_$P(X4,U,8)_U_$P(X4,U,9)
  . D SETITEM(.ROOT,X)
  I $O(^ORD(101.24,+TST,10,0)) S ORX0=^ORD(101.24,+TST,0),ORX2=$G(^(2)),ORX4=$G(^(4)) D
  . I $P(ORX4,"^",10) Q
  . S RPC=$P($G(^XWB(8994,+$P(X0,"^",13),0)),"^")  ;DBIA 4011
  . S X=ORX0,HEAD=$P(X,"^")
  . I $L($P(ORX2,"^",3)) S HEAD=$P(ORX2,"^",3)
  . S X1=$P(X,U,2)_U_HEAD_U_ORTIMOCC_";"_$P(X,U,4)_U_$P(X,U,19)_";"_$P(X,U,20)_";"
  . S ORX=X1_+$P(X,U,21)_U_$P(X,U,6)_U_$P(X,U,5)_U_$P(X,U,3)_U_$P(X,U,12)_U_$P(X,U,7)_U_RPC_U_+TST_U_$P(ORX4,U)_U_$P(ORX4,U,2)_U_$P(ORX4,U,4)_U_$P(ORX4,U,5)_U_$P(ORX4,U,8)_U_$P(X4,U,9)
  . D SETITEM(.ROOT,"[PARENT START]^"_ORX)
  . S J=0 F  S J=$O(^ORD(101.24,+TST,10,J)) Q:J<1  S X=^(J,0) D EX(.ROOT,+X)
  . D SETITEM(.ROOT,"[PARENT END]^"_ORX)
  Q
LIST(LST,TAB)       ;Get list for Reports & Labs Tab Treeview
 N ROOT
 S ROOT=$NA(LST)
 K @ROOT
 D TRY1(.ROOT,$G(TAB))
 Q
TRY1(ROOT,TAB)    ;Test expanding reports using established parameters
 N I,ORLIST
 D SETITEM(.ROOT,"[REPORT LIST]")
 D GETLST^XPAR(.ORLIST,"ALL",$S($G(TAB)="LABS":"ORWRP REPORT LAB LIST",1:"ORWRP REPORT LIST"))
 S I=0
 F  S I=$O(ORLIST(I)) Q:'I  Q:'$D(^ORD(101.24,$P(ORLIST(I),"^",2),0))  D EX(.ROOT,$P(ORLIST(I),"^",2))
 D SETITEM(.ROOT,"$$END")
 Q
SETITEM(ROOT,X) ; -- set item in list
 S @ROOT@($O(@ROOT@(9999),-1)+1)=X
 Q
