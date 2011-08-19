ORRCXQ ;SLC/MKB - Alert utilities for CM ; 25 Jul 2003  9:31 AM
 ;;1.0;CARE MANAGEMENT;;Jul 15, 2003
 ;
USER(ORY,ORDUZ) ; -- Return user's current alerts in @ORY@(PKGID,AID)=DATA
 ;    
 N ORXQ,X,I,PKGID,AID,TM,DATA
 S ORDUZ=$G(ORDUZ,DUZ),ORY=$NA(^TMP($J,"ORY")) K @ORY
 S ORXQ="^TMP($J,""ORXQ"")" D USER^XQALERT(ORXQ,ORDUZ)
 S I=0 F  S I=$O(@ORXQ@(I)) Q:I<1  D
 . S X=$P(@ORXQ@(I),U,2),PKGID=$P(X,";"),AID=$P(X,";",2,3),TM=$P(X,";",3)
 . S DATA=$G(^XTV(8992,ORDUZ,"XQA",TM,1)) ;IA#2689
 . S @ORY@(PKGID,AID)=DATA
 K @ORXQ
 Q
 ;
PAT(ORY,ORPAT,ORUSR) ; -- Return non-ADT alerts for ORPAT to ORUSR
 ; in @ORY@(#) = Item=ID^Text^Date in HL7 format
 ;                where ID is "NOT:<XQAID>"
 ; RPC = ORRC ALERTS BY PATIENT
 N ORXQ,ORN,I,TEXT,XQAID,DATE,NOT,ACTDT
 S ORUSR=+$G(ORUSR),ACTDT=$$PARAM^ORRCACK(ORUSR)
 S ORXQ="^TMP($J,""ORXQ"")" D USER^XQALERT(ORXQ,ORUSR)
 S ORY=$NA(^TMP($J,"ORRCNOT")),ORN=0 K @ORY
 S I=0 F  S I=$O(@ORXQ@(I)) Q:I<1  D
 . S TEXT=$P(@ORXQ@(I),U),XQAID=$P(@ORXQ@(I),U,2),DATE=$P(XQAID,";",3)
 . Q:XQAID'?1"OR,".E  I $G(ORPAT) Q:+$P(XQAID,",",2)'=ORPAT
 . S NOT=+$P(XQAID,",",3) Q:"^18^19^20^35^36^"[(U_NOT_U)  ;skip ADT ones
 . I ACTDT,ACTDT'>DT,$$INCLD(NOT) Q  ;skip results ones already included
 . S ORN=ORN+1,@ORY@(ORN)="Item=NOT:"_XQAID_U_$E(TEXT,23,99)_U_$$FMTHL7^XLFDT(DATE)
 K @ORXQ
 Q
 ;
INCLD(NIEN) ; -- Order already in Results column?
 ;    [from PAT - uses ORUSR]
 N X,Y,DATA,NMSP,PKG S X=U_NIEN_U,Y=0
 S NMSP=$S("^3^14^24^57^58^"[X:"LR","^21^22^25^53^"[X:"RA","^23^"[X:"GMRC","^32^33^44^60^"[X:"X",1:"") I NMSP="" Q 0
 S DATA=$G(^XTV(8992,ORUSR,"XQA",DATE,1)),PKG=$P($P(DATA,"|",2),"@",2)
 S ORIFN=0 F  S ORIFN=$O(^ORA(102.4,"ACK",ORUSR,ORIFN)) Q:ORIFN<1  D  Q:Y
 . S OR0=$G(^OR(100,+ORIFN,0)),PKGIFN=+$G(^(4))
 . S ORVP=$P(OR0,U,2) Q:+ORVP'=ORPAT
 . S ORPKG=$$NMSP^ORCD($P(OR0,U,14)) I ORPKG'=NMSP,'(NMSP="X"&(PKG[ORPKG)) Q
 . S:$$MATCH Y=1
 Q Y
 ;
RSLT(ORDER,ORUSR) ; -- clear alerts for ORDERs results
 N ORY,ORN,ORIFN,OR0,ORVP,ORPKG,PKGIFN,NIEN,PKGID,AID,DATA
 D USER(.ORY,ORUSR),ORN ;notifs by pkg
 S ORIFN=0 F  S ORIFN=$O(ORDER(ORIFN)) Q:ORIFN<1  D
 . S OR0=$G(^OR(100,+ORIFN,0)),PKGIFN=+$G(^(4))
 . S ORPKG=$$NMSP^ORCD($P(OR0,U,14)) Q:"^LR^RA^GMRC^"'[(U_ORPKG_U)
 . S ORVP=$P(OR0,U,2),PKGID="OR,"_+ORVP
 . F  S PKGID=$O(@ORY@(PKGID)) Q:$P(PKGID,",",1,2)'=("OR,"_+ORVP)  D
 .. S NIEN=$P(PKGID,",",3) Q:'$D(ORN(ORPKG,NIEN))  ;alert not for ORPKG
 .. S AID="" F  S AID=$O(@ORY@(PKGID,AID)) Q:AID=""  D
 ... S DATA=@ORY@(PKGID,AID) Q:'$$MATCH
 ... D DELETE(PKGID_";"_AID)
 K @ORY
 Q
 ;
ORN ; -- List result notifications by pkg in ORN(NMSP,IEN)
 N X,Y,I,N K ORN
 F X="LR","RA","GMRC" D
 . S Y=$S(X="LR":"3^14^24^57^58",X="RA":"21^22^25^53",X="GMRC":"23",1:"")
 . F I=1:1:$L(Y,U) S N=$P(Y,U,I),ORN(X,N)=""
 . F I=32,33,44,60 S ORN(X,I)="" ;flagged or stat results, for any pkg
 Q
 ;
MATCH() ; -- Return 1 or 0, if alert matches current order
 ;    Called from RSLT & $$INCLD, so expects those var's to be defined
 N Y,APKG,ADATA S Y=0
 S ADATA=$P(DATA,"|"),APKG=$P($P(DATA,"|",2),"@",2)
 I ORPKG="LR",APKG["LR",+DATA=+ORIFN S Y=1 G MQ
 I "^32^33^44^60^"[(U_NIEN_U) D  G MQ
 . I ORPKG="RA",APKG["RA",$D(^RADPT("AO",PKGIFN,+ORVP,+$P(ADATA,"~",2),+$P(ADATA,"~",3))) S Y=1 ;IA#2588
 . I ORPKG="GMRC",APKG["GMRC",PKGIFN=+ADATA S Y=1
 I ORPKG="RA",$D(^RADPT("AO",PKGIFN,+ORVP,+ADATA,+$P(ADATA,"~",2))) S Y=1 ;IA#2588
 I ORPKG="GMRC",PKGIFN=+ADATA S Y=1
MQ Q Y
 ;
SIGN(ID) ; -- clear alerts for signatures
 N ORY,ORNKILL,ORVP,PKGID,AID
 D USER(.ORY,DUZ) I ID["OR" D  G SIGQ
 . S ORVP=$P($G(^OR(100,+ID,0)),U,2) Q:$O(^OR(100,"AS",ORVP,0))
 . S PKGID="OR,"_+ORVP_",12",AID=""
 . F  S AID=$O(@ORY@(PKGID,AID)) Q:AID=""  S ORNKILL(PKGID_";"_AID)=""
 I ID["TIU" D  G SIGQ
 . S PKGID="TIU"_+ID,AID=""
 . F  S AID=$O(@ORY@(PKGID,AID)) Q:AID=""  S ORNKILL(PKGID_";"_AID)=""
 . ;ck w/Joel: possible alerts + formats, kill conditions
SIGQ I $D(ORNKILL) D DELETE
 K @ORY
 Q
 ;
DELETE(XQAID) ; -- Delete alert XQAID
 Q:'$L($G(XQAID))  N XQAKILL,ORN
 S ORN=+$P($P(XQAID,";"),",",3),XQAKILL=$S(ORN:$$XQAKILL^ORB3F1(ORN),1:0)
 D DELETE^XQALERT ;for DUZ
 Q
 ;
MSGTXT(ID) ; -- Return message text of alert ID
 N IDX,D0,D1,Y
 S IDX="^XTV(8992,""AXQA"","""_ID_""")",IDX=$Q(@IDX)
 S D0=+$P(IDX,",",6),D1=+$P(IDX,",",7)
 S Y=$P($G(^XTV(8992,D0,"XQA",D1,0)),U,3),Y=$E(Y,20,999)
 Q Y
 ;
MSGDT(ADT,ATXT) ; -- Return event date from alert date and text
 N I,X,Y,%DT
 I ATXT?1"Transfer".E S Y=ADT G MDQ ;no date in text
 S I=$F(ATXT," on "),X="" S:I X=$E(ATXT,I,999)
 I ATXT?1"Admit".E S I=$F(X,"  "),X=$E(X,1,I-3) ;strip off ward,rm-bed
 S:X?2N1"/"2N1" "2N1":"2N X=$TR(X," ","@")
 S %DT="TS" D ^%DT I Y<0 S Y=ADT
MDQ Q Y
