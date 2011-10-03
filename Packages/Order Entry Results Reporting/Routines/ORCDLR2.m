ORCDLR2 ;SLC/MKB - Silent utilities for LR dialogs ; 11/4/2007
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**243,303,317**;Dec 17, 1997;Build 2
 ;
 ;DJE/VM *317 ORLR changed to ORLRGUI
GUI(ORY,ORL,ORDERS)  ; -- ck list of ORDERS for labs w/invalid coll times
 N ORI,ORIFN,ORCNT,RES,I,N,DAD,X
 K ^TMP($J,"ORLRGUI") S ORCNT=0
 S ORI="" F  S ORI=$O(ORDERS(ORI)) Q:ORI=""  D
 . Q:+$P(ORDERS(ORI),";",2)>1          ;only ck NW order actions
 . S ORIFN=+ORDERS(ORI) Q:'$$LC(ORIFN)  ;only ck Lab, LC/I orders
 . K RES D KIDS(.RES,$G(ORL),ORIFN)
 . S I=0 F  S I=$O(RES(I)) Q:I<1  I $P(RES(I),U,2) K RES(I)
 . Q:'$O(RES(0))  ;no invalid times found
 . S ORCNT=ORCNT+1,^TMP($J,"ORLRGUI",ORCNT)=ORIFN
 . S I=0 F  S I=$O(RES(I)) Q:I<1  S ^TMP($J,"ORLRGUI",ORCNT,I)=RES(I)
 S ORY(1)="~COUNT",ORY(2)="d"_ORCNT,N=2
 F DAD=1:1:ORCNT S ORIFN=$G(^TMP($J,"ORLRGUI",DAD)) D
 . S N=N+1,ORY(N)="~ORDER_"_DAD
 . S N=N+1,ORY(N)="t#"_ORIFN_"  "_$G(^OR(100,ORIFN,8,1,.1,1,0)) ;1st line order text
 . S ORI=0 F  S ORI=$O(^TMP($J,"ORLRGUI",DAD,ORI)) Q:ORI<1  S X=^(ORI) D
 .. S N=N+1,ORY(N)="i"_X
 Q
 ;
KIDS(ORY,ORL,ORIFN,DATE,TYPE,SCH,DUR) ; -- get child times, validate LC/IC
 ; ORL   = Hospital Location file #44 vptr
 ; ORIFN = Orders file #100 ien
 ;   or
 ; DATE  = Start date.time or "AM" or "NEXT"
 ; TYPE  = LC or I
 ; SCH   = Administration Schedule file #51.1 ien
 ; DUR   = # or "X"_#
 ; Will quit if OREVENT exists <can't check delayed orders>
 ; 
 ; Returns ORY(n) = child start.time ^ 1 or 0 ^ [error message]
 ; 
 N OR0,VALIDT,ORTIME,ORIMTIME,ORDIV,X,Y,%DT,ORSTRT,ORI,ORN,OK
 S OR0=$G(^OR(100,+$G(ORIFN),0)) Q:$P(OR0,U,17)  Q:$G(OREVENT)  ;delayed orders
 I $G(ORIFN),'$L($G(DATE))!'$L($G(TYPE))!'$G(SCH)!'$L($G(DUR)) D  ;get values
 . S DATE=$$VALUE^ORX8(ORIFN,"START")
 . S TYPE=$$VALUE^ORX8(ORIFN,"COLLECT")
 . S SCH=$$VALUE^ORX8(ORIFN,"SCHEDULE")
 . S DUR=$$VALUE^ORX8(ORIFN,"DAYS")
 Q:'$L($G(DATE))  Q:'$G(SCH)  Q:"SPWC"[$G(TYPE)  Q:'$L($G(DUR))
 S VALIDT="" D GETIMES^ORCDLR1
 D AM^ORCSAVE2:DATE="AM",NEXT^ORCSAVE2:DATE="NEXT" ; returns X
 S %DT="T" S:'$D(X) X=DATE  D ^%DT I Y<1 Q
 D SCHEDULE(.ORSTRT,Y,SCH,DUR) Q:ORSTRT'>1 0 ; get all starts
 K ORY S ORY=ORSTRT
 S (ORI,ORN)=0 F  S ORI=$O(ORSTRT(ORI)) Q:'ORI  S OK="" D
 . I TYPE="LC" S OK=$$LABCOLL^ORCDLR1(ORI)
 . I TYPE="I" S OK=$$IMMCOLL^ORCDLR1(ORI)
 . S ORN=ORN+1,ORY(ORN)=ORI_U_OK
 Q
 ;
SCHEDULE(ORY,PSJSD,SCH,ORDUR) ; Returns list of start time(s) from schedule
 ; PSJEEU  - DBIA #2417
 ; PSS51P1 - DBIA #4546
 N I,X,ORSCH,PSJFD,PSJW,PSJNE,PSJPP,PSJX,PSJAT,PSJM,PSJTS,PSJY,PSJAX,PSJSCH,PSJOSD,PSJOFD,PSJC,NXT
 Q:'$G(PSJSD)  S ORY=1,ORY(PSJSD)="",SCH=$G(SCH) ;1st occurrance
 S I="",X=SCH S:+SCH I=+SCH,X="" ;I=ien or X=name
 D ZERO^PSS51P1(I,X,"LR",,"ORLR") S ORSCH=+$O(^TMP($J,"ORLR",0)) ;ien
 S PSJX=$G(^TMP($J,"ORLR",ORSCH,.01))
 S PSJW=+$G(ORL),PSJNE="",PSJPP="LR" D ENSV^PSJEEU Q:'$L($G(PSJX))
 I $G(PSJTS)'="C",$G(PSJTS)'="D" Q  ;not continuous or day-of-week
 S PSJSCH=PSJX
 S:ORDUR PSJFD=$$FMADD^XLFDT(PSJSD,+ORDUR,,-1)
 I 'ORDUR S X=+$E(ORDUR,2,9) D
 . I PSJM S PSJFD=$$FMADD^XLFDT(PSJSD,,,(PSJM*X)-1) ;X_#times
 . E  D  ;no freq in minutes --> day of week
 .. N DAYS,LOCMX,SCHMX
 .. S LOCMX=$$GET^XPAR("ALL^LOC.`"_+$G(ORL),"LR MAX DAYS CONTINUOUS",1,"Q")
 .. S SCHMX=$G(^TMP($J,"ORLR",ORSCH,2.5))
 .. S DAYS=$S('SCHMX:LOCMX,LOCMX<SCHMX:LOCMX,1:SCHMX)
 .. S PSJFD=$$FMADD^XLFDT(PSJSD,DAYS,,-1)
 D ENSPU^PSJEEU K ORY
 I ORDUR M ORY=PSJC Q
 S ORY=$S(PSJC<$E(ORDUR,2,9):PSJC,1:$E(ORDUR,2,9))
 S NXT=0 F I=1:1:ORY S NXT=$O(PSJC(NXT)) Q:'NXT  S ORY(NXT)=PSJC(NXT)
 Q
 ;
LC(IEN) ; -- Return 1 or 0, if order IEN is to Lab for LC or I
 N Y,X0,PKG S Y=0
 S X0=$G(^OR(100,+$G(IEN),0)),PKG=$$NMSP^ORCD(+$P(X0,U,14))
 I PKG="LR" D
 . N X S X=$$VALUE^ORX8(IEN,"COLLECT")
 . I X="LC"!(X="I") S Y=1
 Q Y
