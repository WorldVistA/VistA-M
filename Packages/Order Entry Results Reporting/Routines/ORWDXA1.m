ORWDXA1 ;SLC/JMC - Utilities for Order Flag Actions ;Dec 14, 2021@08:39:22
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**539,405**;Dec 17, 1997;Build 211
 ;Per VA Directive 6402, this routine should not be modified.
 ;
FLAGACT(LST,ORIFN,ACTION) ;perform action on flag order
 N DA,ORNOW,CNT,X,RES,ORFIENS,ORFDA,FDAIEN,ERR,REC,ORVP,X3,USR
 S DA=$P(ORIFN,";",2)
 S ACTION=$G(ACTION,"ALL")
 ; get recipients
 I ACTION="RECIPIENTS"!(ACTION="ALL") D  I ACTION'="ALL" Q
 . D FLAGRCPT(.LST,ORIFN)
 M RES=LST
 K LST
 ; get comments
 I ACTION="COMMENTS"!(ACTION="ALL") D  I ACTION'="ALL" Q
 . D FLGCOM(.LST,ORIFN)
 I $D(RES) S CNT=$O(RES("A"),-1),X=0 F  S X=$O(LST(X)) Q:'X  S CNT=CNT+1,RES(CNT)=LST(X)
 M LST=RES
 Q
FLAGRCPT(LST,ORIFN) ; flag recipients
 N DA,CNT,X,USR,Y
 S DA=$P(ORIFN,";",2),(CNT,X)=0
 F  S X=$O(^OR(100,+ORIFN,8,DA,6,X)) Q:'X  S CNT=CNT+1,Y=$G(^(X,0)),USR=+Y,LST(CNT)=USR_U_$$USER^ORQ20(USR)_" added on "_$$DATE^ORQ20($P(Y,U,2))
 Q
FLAGCOM(LST,ORIFN,ORCOM,ORALRP) ; flag comments, add
 N ORDA,ORVP,ORNOW,ORFIENS,ORFDA,ORAUSR,ORFERR,ORFNM,USR,X,X3
 S ORDA=$P(ORIFN,";",2),ORVP=+$P(^OR(100,+ORIFN,0),U,2)
 I $O(ORCOM(""))="" S LST(1)="0^Comments required, no action taken." Q
 I '$D(^OR(100,+ORIFN)) S LST(1)="0^No such order, no action taken." Q
 S ORNOW=$$NOW^XLFDT
 S ORFIENS="?+1"_","_ORDA_","_+ORIFN_","
 S ORFDA(100.843,ORFIENS,.01)=ORNOW
 S ORFDA(100.843,ORFIENS,1)=DUZ
 D UPDATE^DIE("","ORFDA","ORFNM","ORFERR")
 I ($G(ORFERR)'="")!('+$G(ORFNM(1))) S LST(1)="0^Error while adding Comment data." K ORFERR Q
 ;file comments
 K ^TMP($J,"WP")
 D WP^DIE(100.843,ORFNM(1)_","_ORDA_","_$P(ORIFN,";")_",",2,,"ORCOM","ORFERR")
 I $G(ORFERR)'="" S LST(1)="0^Error adding comments." K ORFERR Q
 K ORFIENS,ORFDA
 ;get recipients on file
 S X=0
 F  S X=$O(^OR(100,+ORIFN,8,ORDA,6,X)) Q:'X  S USR=$P($G(^(X,0)),"^") I USR S ORAUSR(USR)=""
 ;File additional alert Recipients
 S X=0,ORFIENS="?+1"_","_ORDA_","_+ORIFN_","
 F  S X=$O(ORALRP(X)) Q:'X  S USR=+ORALRP(X) I USR,'$D(ORAUSR(USR)) D  I $G(ORFERR)'="" Q
 . S ORFDA(100.842,ORFIENS,.01)=USR
 . S ORFDA(100.842,ORFIENS,1)=ORNOW
 . S ORFDA(100.842,ORFIENS,2)=DUZ
 . D UPDATE^DIE("","ORFDA","","ORFERR")
 . I $G(ORFERR)'="" S LST(1)="0^Error adding alert recipient "_USR Q
 . S ORAUSR(USR)=""
 S LST(1)="1^Comments successfully added."
 ; send notification to originator and recipients
 S X3=$G(^OR(100,+ORIFN,8,ORDA,3)) I $P(X3,U,4)'="" S ORAUSR(+$P(X3,U,4))=""
 K ORFDA,ORAUSR(DUZ) ;don't sent alert to user adding comment
 D CMTMSG(ORIFN,ORVP,.ORAUSR)
 Q
 ;
CMTMSG(ORIFN,ORVP,ORAUSR) ; send alert notification information to recipients
 N ORCMSG,ORN,ORDFN,OR3,ORYT
 S ORCMSG="Comment Added to Flagged Order: "
 S ORN=8,ORDFN=+ORVP,OR3=$G(^OR(100,+ORIFN,3))
 D TEXT^ORQ12(.ORYT,+ORIFN_";"_+$P(OR3,U,7),20)
 S ORCMSG=ORCMSG_$G(ORYT(1))
 D EN^ORB3(ORN,ORDFN,+ORIFN,.ORAUSR,ORCMSG)
 Q
FLGCOM(LST,ORIFN) ; flag comments, get
 N DA,CNT,X,Y,ORZ,DIWL,DIWR,DIWF,DATA,I
 S DA=$P(ORIFN,";",2),(CNT,Y)=0
 D:$D(^OR(100,+ORIFN,8,DA,3))
 . Q:$G(ACTION)=""
 . N BFLAG S BFLAG=$G(^OR(100,+ORIFN,8,DA,3))
 . S CNT=CNT+1,LST(CNT)="<COMMENT>"
 . S CNT=CNT+1,LST(CNT)=$P(BFLAG,U,3)_";"_$$DATE^ORQ20($P(BFLAG,U,3))_U_$P(BFLAG,U,4)_";"_$$USER^ORQ20($P(BFLAG,U,4))
 . S CNT=CNT+1,LST(CNT)="Flagged Reason: "_$P(BFLAG,U,5)
 . S CNT=CNT+1,LST(CNT)="</COMMENT>"
 S DIWL=1,DIWR=70,DIWF="C70" K ^UTILITY($J,"W")
 F  S Y=$O(^OR(100,+ORIFN,8,DA,9,Y)) Q:'Y  D
 . S DATA=$G(^OR(100,+ORIFN,8,DA,9,Y,0))
 . S CNT=CNT+1,LST(CNT)="<COMMENT>"
 . S CNT=CNT+1,LST(CNT)=$P(DATA,U)_";"_$$DATE^ORQ20($P(DATA,U))_U_$P(DATA,U,2)_";"_$$USER^ORQ20($P(DATA,U,2))
 . S ORZ=0 F  S ORZ=$O(^OR(100,+ORIFN,8,DA,9,Y,"COM",ORZ)) Q:'ORZ  S X=^(ORZ,0) D ^DIWP
 . S I=0 F  S I=$O(^UTILITY($J,"W",DIWL,I)) Q:'I  S CNT=CNT+1,LST(CNT)=^(I,0)
 . S CNT=CNT+1,LST(CNT)="</COMMENT>"
 . K ^UTILITY($J,"W")
 Q
FLGHST(ORY,ORIFN) ;archive history of flag order
 N X3,F,Y
 N ORI,X3,CNT,ORJ
 S ORI=$P(ORIFN,";",2),CNT=0
 I $D(^OR(100,+ORIFN,8,ORI,3)) D  ;Un-/Flagged
 . S X3=$G(^OR(100,+ORIFN,8,ORI,3))
 . S CNT=CNT+1,ORY(CNT)="Flagged by:        "_$$USER^ORQ20(+$P(X3,U,4))_" on "_$$DATE^ORQ20($P(X3,U,3))
 . S CNT=CNT+1,ORY(CNT)="                   "_$P(X3,U,5)
 . I $P(X3,U,10)'="" S CNT=CNT+1,ORY(CNT)="No Action Alert:   "_$$DATE^ORQ20($P(X3,U,10))
 ;flagged recipients
 S ORJ=0,F=0 F  S ORJ=$O(^OR(100,+ORIFN,8,ORI,6,ORJ)) Q:'ORJ  S Y=^(ORJ,0) D
 . S CNT=CNT+1,ORY(CNT)=$S('F:"Recipients:        ",1:"                   ")_$$USER^ORQ20(+Y)_" added on "_$$DATE^ORQ20($P(Y,U,2))_" by "_$$USER^ORQ20(+$P(Y,U,3)),F=1
 ;flagged comments
 N DIWL,DIWR,DIWF,X,I,ORK
 S ORJ=0,F=0 F  S ORJ=$O(^OR(100,+ORIFN,8,ORI,9,ORJ)) Q:'ORJ  S Y=^(ORJ,0) D
 . S CNT=CNT+1,ORY(CNT)=$S('F:"Comments by:       ",1:"                   ")_$$USER^ORQ20($P(Y,U,2))_"on "_$$DATE^ORQ20(+Y),F=1
 . S DIWL=19,DIWR=110,DIWF="I19" K ^UTILITY($J,"W")
 . S ORK=0 F  S ORK=$O(^OR(100,+ORIFN,8,ORI,9,ORJ,"COM",ORK)) Q:'ORK  S X=^(ORK,0) D ^DIWP
 . S I=0 F  S I=$O(^UTILITY($J,"W",DIWL,I)) Q:'I  S CNT=CNT+1,ORY(CNT)=^(I,0)
 K ^UTILITY($J,"W")
 I $P($G(X3),U)=0 D
 . S CNT=CNT+1,ORY(CNT)="Unflagged by:      "_$$USER^ORQ20(+$P(X3,U,7))_" on "_$$DATE^ORQ20($P(X3,U,6))
 . S CNT=CNT+1,ORY(CNT)="                   "_$P(X3,U,8)
 K ^UTILITY($J,"W")
 Q
GETHST(ORFH,ORIFN) ;Get flag order history
 N ORI,ORJ,ORK,CNT,Y
 S ORI=$P(ORIFN,";",2),CNT=0
 I $D(^OR(100,+ORIFN,8,ORI,"FHIS")) D
 . S ORJ=0 F  S ORJ=$O(^OR(100,+ORIFN,8,ORI,"FHIS",ORJ)) Q:'ORJ  S ORK=0 D
 . . S ORK=0 F  S ORK=$O(^OR(100,+ORIFN,8,ORI,"FHIS",ORJ,"COM",ORK)) Q:'ORK  S Y=^(ORK,0),CNT=CNT+1,ORFH(CNT)=Y
 Q
SCHALRT(ORVP,ORIFN,OREXP) ;schedule alert in file #100.97
 N ORDATA,ORDA3,ORACT,ORYT,ORNAM
 I (ORVP="")!(ORIFN="")!(OREXP)="" Q
 S ORACT=$P(ORIFN,";",2)
 S ORDA3=$G(^OR(100,+ORIFN,8,ORACT,3))
 S ORDATA("PATIENT")=ORVP
 S ORDATA("WHEN")=OREXP
 S ORDATA("WHO")=$P(ORDA3,U,4)
 S ORDATA("ALERT")="98;ORD(100.9,"
 S ORNAM=$$OI^ORX8(ORIFN)
 S ORDATA("TITLE")="Order flag expired for "_$P(ORNAM,"^",2)_" on "_$$DATE^ORQ20(OREXP)
 S ORDATA("IFN")=ORIFN
 D SCHALRT^ORB3UTL(.ORDATA)
 Q
 ;
FLAGTXTS(CLST,IFNS) ; get flag reason for list of orders
 N L,DA,IFN,CNT
 S (CNT,L)=0
 F  S L=$O(IFNS(L)) Q:'L  S IFN=IFNS(L) D
 . S DA=$S($P(IFN,";",2):$P(IFN,";",2),1:1),IFN=+IFN
 . D FLRSON
 Q
 ;
FLRSON ; flag reason
 N FLAG,I,F,ORUSR,ORCOM,Z
 S FLAG=$G(^OR(100,IFN,8,DA,3))
 S CNT=CNT+1
 S CLST(CNT)="~"_IFN_U_"FLAGGED: "_$$FMTE^XLFDT($P(FLAG,U,3))_" by "_$P($G(^VA(200,+$P(FLAG,U,4),0)),U)
 S CNT=CNT+1
 S CLST(CNT)=$P(FLAG,U,5) ; reason
 I $P(FLAG,U,10)'="" S CNT=CNT+1,CLST(CNT)="NO ACTION ALERT: "_$$FMTE^XLFDT($P(FLAG,U,10))
 D FLAGRCPT^ORWDXA1(.ORUSR,IFNS(L)) ; recipients
 S (I,F)=0
 F  S I=$O(ORUSR(I)) Q:'I  I ORUSR(I) D
 . S CNT=CNT+1,CLST(CNT)=$S('F:"RECIPIENTS:"_$C(9),1:$C(9)_$C(9))_$P(ORUSR(I),U,2),F=1
 D FLGCOM^ORWDXA1(.ORCOM,IFNS(L)) ; comments
 S (I,F)=0
 F  S I=$O(ORCOM(I)) Q:'I  I ORCOM(I)="<COMMENT>" S I=$O(ORCOM(I)) D
 . S CNT=CNT+1,CLST(CNT)=$S('F:"COMMENTS:"_$C(9),1:$C(9)_$C(9))_$P($P(ORCOM(I),U,2),";",2)_" on "_$P($P(ORCOM(I),U),";",2),F=1
 . F  S I=$O(ORCOM(I)) Q:ORCOM(I)="</COMMENT>"  D
 . . S CNT=CNT+1,CLST(CNT)=$C(9)_ORCOM(I)
 Q
 ;
MAP(Y) ; display group mapping
 N C,I,X
 D GRP(.X)
 S C=0,I=0
 F  S I=$O(X(I)) Q:I=""  S C=C+1,Y(I)=X(I)
 Q
GRP(BYGRP) ;
 N I,ORY,TOPINFO
 D GETLST^XPAR(.ORY,"ALL","ORWOR CATEGORY SEQUENCE")
 S I=0 F  S I=$O(ORY(I)) Q:I=""  D
 . S BYGRP($P(ORY(I),U,2))=$P(ORY(I),U,2)
 S I=0 F  S I=$O(BYGRP(I)) Q:I=""  S TOPINFO=BYGRP(I) D EXPAND(I)
 Q
EXPAND(GROUP) ;
 N I,CHILD
 S I=0 F  S I=$O(^ORD(100.98,GROUP,1,I)) Q:I<1  D
 . S CHILD=$P(^ORD(100.98,GROUP,1,I,0),"^",1)
 . I '$D(BYGRP(CHILD)) S BYGRP(CHILD)=TOPINFO D EXPAND(CHILD)
 Q
 ;
CHOREXP(IFN) ;
 Q:'$D(^OR(100.97,"E",IFN))
 N DA,TD S DA=$O(^OR(100.97,"E",IFN,"")) Q:'DA
 S TD=$P($G(^OR(100.97,DA,0)),U,3) Q:'TD!($$NOW^XLFDT()>TD)
 S DIK="^OR(100.97," D ^DIK K DIK
 Q
 ;
