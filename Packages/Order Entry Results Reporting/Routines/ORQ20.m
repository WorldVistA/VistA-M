ORQ20 ; SLC/MKB - Detailed Order Report cont ;3/6/08  10:25
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**12,27,92,94,116,141,177,186,190,215,243**;Dec 17, 1997;Build 242
ACT ; -- add Activity [from ^ORQ2]
 N ORACT S ORACT=$P(ACTION,U,2)
 I ORACT'="NW",$P(ACTION,U,4)=5,$P(ACTION,U,15)=13 Q  ;skip canc actions
 N NVA,USER S:$P(^ORD(100.98,$P(^OR(100,+ORIFN,0),U,11),0),U)="NON-VA MEDICATIONS" NVA=1
 S CNT=CNT+1,@ORY@(CNT)=$$DATE($P(ACTION,U))_"  "_$$ACTION(ORACT)
 I $P(ACTION,U,13) S @ORY@(CNT)=@ORY@(CNT)_" entered by "_$$USER(+$P(ACTION,U,13))
 I ORACT="NW" D  ;Show original order text
 . N ORZ,I,ORIGVIEW S ORIGVIEW=2 D TEXT^ORQ12(.ORZ,ORIFN_";1",80)
 . S CNT=CNT+1,@ORY@(CNT)="     Order Text:        "_$G(ORZ(1))
 . S I=1 F  S I=$O(ORZ(I)) Q:I'>0  S CNT=CNT+1,@ORY@(CNT)=$$REPEAT^XLFSTR(" ",24)_$G(ORZ(I))
 I ORACT="XX" D  ;Changed - show new text
 . N ORZ,I,ORIGVIEW S ORIGVIEW=2 D TEXT^ORQ12(.ORZ,ORIFN_";"_ORI,80)
 . S CNT=CNT+1,@ORY@(CNT)="     Changed to:        "_$G(ORZ(1))
 . S I=1 F  S I=$O(ORZ(I)) Q:I'>0  S CNT=CNT+1,@ORY@(CNT)=$$REPEAT^XLFSTR(" ",24)_$G(ORZ(I))
A1 I $P(ACTION,U,12) D  ;Nature of Order/Release
 . N ORZ S ORZ=$G(^ORD(100.02,+$P(ACTION,U,12),0))
 . S CNT=CNT+1,@ORY@(CNT)="     Nature of Order:   "_$P(ORZ,U)
 . I $P(OR0,U,17),(ORACT="NW") Q  ;see event
 . I "^V^P^"[(U_$P(ORZ,U,2)_U),$P(ACTION,U,16) S CNT=CNT+1,@ORY@(CNT)="     Released by:       "_$$USER(+$P(ACTION,U,17))_" on "_$$DATE($P(ACTION,U,16))
 I $P(OR0,U,17)&(ORACT="NW") D  ;Delayed Release Event
 . N EVT,X,ORV,I S EVT=+$P(OR0,U,17),X=$$NAME^OREVNTX(EVT)
 . S:$E(X,1,8)="Delayed " X=$E(X,9,99)
 . I $G(^ORE(100.2,EVT,1)),'$P(ACTION,U,16) S X=X_" on "_$$DATE(+^(1))
 . S CNT=CNT+1,@ORY@(CNT)="     Delayed Until:     "_X Q:'$P(ACTION,U,16)
 . D EVENT(.ORV) S CNT=CNT+1,@ORY@(CNT)="     Released by:       "_ORV(1)
 . S I=1 F  S I=$O(ORV(I)) Q:I'>0  S CNT=CNT+1,@ORY@(CNT)=$$REPEAT^XLFSTR(" ",24)_$G(ORV(I))
A2 I $P(ACTION,U,5) S CNT=CNT+1,@ORY@(CNT)=$S($P(ACTION,U,4)=7:"      Dig",1:"     Elec")_" Signature:    "_$$USER(+$P(ACTION,U,5))_" on "_$$DATE($P(ACTION,U,6))
 I '$P(ACTION,U,5)!($P(ACTION,U,3)'=$P(ACTION,U,5)),'$$SERVCORR S CNT=CNT+1,@ORY@(CNT)="     "_$S($D(NVA):"Documented by:",1:"Ordered by:   ")_"     "_$$USER(+$P(ACTION,U,3))
 I '$P(ACTION,U,5),$L($P(ACTION,U,4)) D
 .I $P(ACTION,U,4)=0 D
 ..S USER=$$USER(+$P(ACTION,U,7))
 ..S CNT=CNT+1
 ..I USER'="" S @ORY@(CNT)="     Released by:       "_USER_" on "_$$DATE($P(ACTION,U,16))
 ..I USER="" S @ORY@(CNT)="        Released:       "_$$DATE($P(ACTION,U,16))
 .S CNT=CNT+1,@ORY@(CNT)="     Signature:         "_$$SIG($P(ACTION,U,4)) ;186
 ;I '$P(ACTION,U,5),$L($P(ACTION,U,4)) S:$P(ACTION,U,4)=0 CNT=CNT+1,@ORY@(CNT)="     Released by:       "_$$USER(+$P(ACTION,U,7))_" on "_$$DATE($P(ACTION,U,16)) S CNT=CNT+1,@ORY@(CNT)="     Signature:         "_$$SIG($P(ACTION,U,4)) ;186
 I $P(ACTION,U,9) S CNT=CNT+1,@ORY@(CNT)="     Nurse Verified:    "_$S($P(ACTION,U,8):$$USER(+$P(ACTION,U,8))_" on ",1:"")_$$DATE($P(ACTION,U,9))
 I $P(ACTION,U,11) S CNT=CNT+1,@ORY@(CNT)="     Clerk Verified:    "_$S($P(ACTION,U,10):$$USER(+$P(ACTION,U,10))_" on ",1:"")_$$DATE($P(ACTION,U,11))
 I $P(ACTION,U,19) S CNT=CNT+1,@ORY@(CNT)="     Chart Reviewed:    "_$S($P(ACTION,U,18):$$USER(+$P(ACTION,U,18))_" on ",1:"")_$$DATE($P(ACTION,U,19))
A3 I $P(ACTION,U,2)="DC",$L(OR6) S X=$S($L($P(OR6,U,5)):$P(OR6,U,5),$P(OR6,U,4):$P($G(^ORD(100.03,+$P(OR6,U,4),0)),U),$P(OR6,U):$P($G(^ORD(100.02,+$P(OR6,U),0)),U),1:"") S:$L(X) CNT=CNT+1,@ORY@(CNT)="     Reason for DC:     "_X
 I $L($G(^OR(100,ORIFN,8,ORI,1))) S X=^(1) D  ;add backdoor comments
 . N LBL,I S LBL=""
 . I $P(ACTION,U,15)="",$P(ACTION,U,2)'="DC" S LBL="     Comments:          " ;DC shown above
 . I $P(ACTION,U,15)=13,$P(ACTION,U,2)'="NW" S LBL="     Cancelled:         " ;NW shown in ORQ2
 . Q:'$L(LBL)  I $L(X)'>56 S CNT=CNT+1,@ORY@(CNT)=LBL_X Q
 . S DIWL=1,DIWR=56,DIWF="C56" K ^UTILITY($J,"W") D ^DIWP
 . S I=0 F  S I=$O(^UTILITY($J,"W",DIWL,I)) Q:I'>0  S CNT=CNT+1,@ORY@(CNT)=LBL_^(I,0),LBL="                        "
 I $D(^OR(100,ORIFN,8,ORI,5)) D  ;Ward comments
 . N X,ORJ K ^UTILITY($J,"W")
 . S ORJ=0 F  S ORJ=$O(^OR(100,ORIFN,8,ORI,5,ORJ)) Q:ORJ'>0  S X=^(ORJ,0) D ^DIWP
 . S ORJ=0 F  S ORJ=$O(^UTILITY($J,"W",DIWL,ORJ)) Q:ORJ'>0  S CNT=CNT+1,@ORY@(CNT)=$S(ORJ=1:"     Ward/Clinic Cmmts: ",1:"                        ")_^(ORJ,0)
 . K ^UTILITY($J,"W")
A4 I $P(ACTION,U,2)="HD",$G(^OR(100,ORIFN,8,ORI,2)) S X2=^(2),CNT=CNT+1,@ORY@(CNT)="     Hold Released:     "_$$FMTE^XLFDT($P(X2,U),"2P")_" by "_$$USER($P(X2,U,2))
 I $D(^OR(100,ORIFN,8,ORI,3)) D  ;Un-/Flagged
 . N X S X=$G(^OR(100,ORIFN,8,ORI,3))
 . S CNT=CNT+1,@ORY@(CNT)="     Flagged by:        "_$$USER(+$P(X,U,4))_" on "_$$DATE($P(X,U,3))
 . S CNT=CNT+1,@ORY@(CNT)="                        "_$P(X,U,5)
 . Q:X  S CNT=CNT+1,@ORY@(CNT)="     Unflagged by:      "_$$USER(+$P(X,U,7))_" on "_$$DATE($P(X,U,6))
 . S CNT=CNT+1,@ORY@(CNT)="                        "_$P(X,U,8)
 Q
 ;
DC ; -- Add Reason for DC
 S CNT=CNT+1,@ORY@(CNT)=$$DATE($P(OR6,U,3))_$S($P(OR6,U,8):"  Auto-",1:"  ")_"Discontinued"
 I $P(OR6,U,8) D  Q
 . N EVT,PKG,ORV,I
 . S EVT=$P(OR6,U,8),PKG=$P($G(^ORE(100.2,+EVT,3,ORIFN,0)),U,2)
 . S @ORY@(CNT)=@ORY@(CNT)_" by "_$S(PKG="FH":"DIETETICS",PKG="LR":"LABORATORY",PKG="PS":"PHARMACY",1:"CPRS")
 . D EVENT(.ORV,1) S CNT=CNT+1,@ORY@(CNT)="     Patient Movement:  "_ORV(1)
 . S I=1 F  S I=$O(ORV(I)) Q:I'>0  S CNT=CNT+1,@ORY@(CNT)=$$REPEAT^XLFSTR(" ",24)_$G(ORV(I))
 I $P(OR6,U,2),$P($G(^ORD(100.02,+$P(OR6,U),0)),U,2)'="A" S @ORY@(CNT)=@ORY@(CNT)_" by "_$$USER($P(OR6,U,2)) ;don't show user name if auto-dc
 N X S X=$S($L($P(OR6,U,5)):$P(OR6,U,5),$P(OR6,U,4):$P($G(^ORD(100.03,+$P(OR6,U,4),0)),U),$P(OR6,U):$P($G(^ORD(100.02,+$P(OR6,U),0)),U),1:"") S:$L(X) CNT=CNT+1,@ORY@(CNT)="     Reason for DC:     "_X
 Q
 ;
ACTION(CODE) ; -- Return name of action CODE
 N NAME S NAME=$S(CODE="NW":"New Order",CODE="DC":"Discontinue",CODE="HD":"Hold",CODE="RL":"Release Hold",CODE="RN":"Renewal",CODE="XX":"Change",1:"")
 I CODE="NW",$P(OR3,U,11) S NAME=NAME_$S($P(OR3,U,11)=1:" (Change)",$P(OR3,U,11)=2:" (Renewal)",1:"")
 Q NAME
 ;
XACT(X) ; -- Return name of transaction code X
 N Y S X=$G(X)
 S Y=$S(X="XX":"Edited",X="DC":"Discontinued",X="HD":"Held",X="RL":"Hold Released",X="FW":"Forwarded",X="CA":"Cancelled",1:"")
 Q Y
 ;
DATE(X) ; -- Return date formatted as 00/00/0000 00:00
 N T,Y  S T=$P(X,".",2)_"0000"
 S Y=$E(X,4,5)_"/"_$E(X,6,7)_"/"_(1700+$E(X,1,3))
 I T S Y=Y_" "_$E(T,1,2)_":"_$E(T,3,4)
 Q Y
 ;
USER(X) ; -- Returns NAME (TITLE) of New Person X
 N X0,Y S X0=$G(^VA(200,+X,0)),Y=$P(X0,U)
 S:$P(X0,U,9) Y=Y_" ("_$E($P($G(^DIC(3.1,+$P(X0,U,9),0)),U),1,15)_")"
 Q Y
 ;
SIG(X) ; -- Returns text of signature status X
 N Y S Y=""
 I X=0 S Y="ON CHART WITH WRITTEN ORDERS"
 I X=1 S Y="ELECTRONICALLY SIGNED"
 I X=2 S Y="NOT SIGNED"
 I X=3 S Y="NOT REQUIRED"
 I X=4 S Y="ON CHART WITH PRINTED ORDERS"
 I X=5 S Y="NOT REQUIRED DUE TO SERVICE CANCEL/LAPSE"
 I X=6 S Y="SERVICE CORRECTION TO SIGNED ORDER"
 Q Y
 ;
SERVCORR() ; -- Returns 1 or 0, if current ACTION is a serv corr change
 N Y,NATURE,I,X S Y=0
 G:ORACT'="XX" SCQ
 S NATURE=+$P(ACTION,U,12),NATURE=$P($G(^ORD(100.02,NATURE,0)),U,2)
 I "^S^I^"'[(U_NATURE_U) G SCQ
 S I=$O(^OR(100,ORIFN,8,ORI),-1),X=$G(^(I,0))
 I $P(X,U,3)'=$P(ACTION,U,3),$P(X,U,5)'=$P(ACTION,U,3) G SCQ ;show prov
 S Y=1
SCQ Q Y
 ;
EVENT(ORTX,DC) ; -- Returns patient event info for EVT
 N EVT1,REL,X,Y,I,ORMAX
 S ORTX(1)="" ;177
 S EVT1=$G(^ORE(100.2,EVT,1)),REL=$G(^ORE(100.2,EVT,2,ORIFN,0))
 ; Return event data if AutoDC or auto-released by an event:
 I $G(DC)!(REL&'$L($P(REL,U,2))&($P(EVT1,U,2)!$P(EVT1,U,4))) D  Q
 . S Y=$S($P(EVT1,U,5):$P(EVT1,U,5),1:EVT) ;parent owns Activity
 . S Y=+$O(^ORE(100.2,+Y,10,0)),Y=$G(^(Y,0)),X=$P(Y,U,4) Q:'$L(X)
 . S X=$S(X="A":"ADMISSION",X="T":"TRANSFER",X="D":"DISCHARGE",X="S":"SPECIALTY CHANGE",1:$S($P(EVT1,U)>$$DPI^ORUTL1("SR*3.0*157"):"IN TO O.R.",1:"OUT OF O.R."))_" on "_$$DATE($P(EVT1,U)) ;243
 . S ORTX(1)=X,ORTX=1,ORMAX=56
 . I $P(Y,U,6) S X=$S($P(Y,U,4)="D":"from ",1:"to ")_$$GET1^DIQ(45.7,+$P(Y,U,6)_",",.01) D TXT^ORCHTAB
 . I $P(Y,U,7) S X="on "_$$GET1^DIQ(42,+$P(Y,U,7)_",",.01) D TXT^ORCHTAB
 S X=$$USER(+$P(ACTION,U,17))_" on "_$$DATE($P(ACTION,U,16))
 I ORIFN'=+$P($G(^ORE(100.2,EVT,0)),U,4),$P(REL,U,2)="MN" S X=X_" (manually released)"
 S ORTX(1)=X
 Q
