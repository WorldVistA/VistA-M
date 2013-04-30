EDPRPT12 ;SLC/MKB - Orders by Acuity Report ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
ORD(BEG,END,CSV) ; Get Acuity Report for EDPSITE by date range
 ;   CNT = counters by acuity
 N IN,OUT,X,X0,I,SERV,ACU,CNT,ROW,EDLOC
 D INIT ;set counters, sums to 0
 S IN=BEG-.000001
 F  S IN=$O(^EDP(230,"ATI",EDPSITE,IN)) Q:'IN  Q:IN>END  S LOG=0 F  S LOG=+$O(^EDP(230,"ATI",EDPSITE,IN,LOG)) Q:LOG<1  D
 . S X=$P($G(^EDP(230,LOG,3)),U,3),ACU=$$ECODE(X)
 . I '$D(^EDP(230,LOG,8)) D FIND(LOG,ACU) Q  ;old/converted visit
 . S I=0 F  S I=$O(^EDP(230,LOG,8,I)) Q:I<1  S X0=$G(^(I,0)) D
 .. S SERV=$$ENAME($P(X0,U,2))
 .. S CNT(ACU,SERV)=CNT(ACU,SERV)+1
 ;
OR1 ; return counts
 I $G(CSV) D  Q  ;as CSV
 . N TAB S TAB=$C(9)
 . S X="Acuity"_TAB_"Labs"_TAB_"Images"_TAB_"Consults"_TAB_"Meds"_TAB_"Other"
 . D ADD^EDPCSV(X)
 . F ACU=0,1,2,3,4,5 D
 .. K ROW S ROW("acuity")=ACU M ROW=CNT(ACU)
 .. D ROW(ACU,.ROW)
 ; or as XML
 D XML^EDPX("<statistics>")
 F ACU=0,1,2,3,4,5 D
 . K ROW S ROW("acuity")=ACU M ROW=CNT(ACU)
 . S X=$$XMLA^EDPX("row",.ROW) D XML^EDPX(X)
 D XML^EDPX("</statistics>")
 Q
 ;
ROW(NAME,LIST) ; add line
 N I S X=NAME
 F I="labs","images","consults","meds","other" S X=X_TAB_LIST(I)
 D ADD^EDPCSV(X)
 Q
 ;
INIT ; Initialize acuity/service counters
 N A,S
 F A=0,1,2,3,4,5 D
 . F S="meds","labs","images","consults","other" S CNT(A,S)=0
 Q
 ;
ECODE(IEN) ; Return external value for an Acuity code
 N X0,X,Y S X0=$G(^EDPB(233.1,+IEN,0))
 S X=$P(X0,U,3) S:X<1 X=$P(X0,U,4) ;code or nat'l code
 ;S Y=$S(X=1:"one",X=2:"two",X=3:"three",X=4:"four",X=5:"five",1:"none")
 S Y=+X I (Y<1)!(Y>5) S Y=0
 Q Y
 ;
ENAME(X) ; Return external name for a Service code
 I X="L"!($E(X,1,2)="LR") Q "labs"
 I X="R"!($E(X,1,2)="RA") Q "images"
 I X="C"!(X="GMRC")       Q "consults"
 I X="M"!($E(X,1,2)="PS") Q "meds"
 I X="A"                  Q "other"
 Q "other"
 ;
FIND(LOG,ACU) ; find/count orders placed during visit LOG
 ;  (for converted data)
 N ORLIST,X0,DFN,IN,OUT,ORI,ORIFN,ORL,PKG,SERV
 S X0=$G(^EDP(230,LOG,0)),DFN=+$P(X0,U,6) Q:DFN<1
 S IN=$P(X0,U,8),OUT=$P(X0,U,9)
 D:'$D(EDLOC) GETLST^XPAR(.EDLOC,"ALL","EDPF LOCATION")
 K ^TMP("ORR",$J) D EN^ORQ1(DFN_";DPT(",,1,,IN,OUT) S ORI=0
 F  S ORI=$O(^TMP("ORR",$J,ORLIST,ORI)) Q:ORI<1  S ORIFN=+$G(^(ORI)) D
 . S ORL=$$GET1^DIQ(100,ORIFN_",",6,"I") Q:'$$ED(+ORL)
 . S PKG=$$GET1^DIQ(100,ORIFN_",","12:1")
 . S SERV=$$ENAME(PKG)
 . S CNT(ACU,SERV)=CNT(ACU,SERV)+1
 Q
 ;
ED(LOC) ; -- Return 1 or 0, if LOCation is part of ED
 ; Expects EDLOC(n) = seq ^ #44 ien
 N I,Y S (I,Y)=0
 F  S I=$O(EDLOC(I)) Q:I<1  I $P(EDLOC(I),U,2)=LOC S Y=1 Q
 Q Y
