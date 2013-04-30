EDPDTL ;SLC/MKB - Return various details for ED LOG ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
EN(LOG,TYPE) ; -- Return details for item in EDPXML(n)
 D XML^EDPX("<details>")
 S LOG=+$G(LOG) I 'LOG D ERR(2300007) G ENQ
 I '$D(^EDP(230,LOG))  D ERR(2300006) G ENQ
 S TYPE=$$UP^XLFSTR($G(TYPE)) S:$E(TYPE)="@" TYPE=$E(TYPE,2,99)
 ; switch on TYPE
 I TYPE="PTNM"      D DFN      G ENQ
 I TYPE="LAST4"     D DFN      G ENQ
 I TYPE="BEDNM"     D LOC      G ENQ
 I TYPE="COMPLAINT" D COMP     G ENQ
 I TYPE="LAB"       D ORD("L") G ENQ
 I TYPE="RAD"       D ORD("R") G ENQ
 I TYPE="ORDNEW"    D ORD      G ENQ
 I TYPE="MDNM"      D USR(5)   G ENQ
 I TYPE="RNNM"      D USR(6)   G ENQ
 I TYPE="RESNM"     D USR(7)   G ENQ
 I TYPE="ALLERGY"   D ALLG     G ENQ
 I TYPE="PLIST"     D PROB     G ENQ
 I TYPE="MEDS"      D MEDS     G ENQ
 I TYPE="VITALS"    D VIT      G ENQ
 ; else
 D ERR(2300011)
ENQ ; end
 D XML^EDPX("</details>")
 Q
 ;
ERR(MSG) ; -- return error MSG
 N X S X=$$MSG^EDPX(MSG)
 D XML^EDPX("<error msg='"_X_"' />")
 Q
 ;
BOOL(X) ; -- Return external form of boolean value X
 Q $S(+$G(X):"true",1:"false")
 ;
DFN ; -- Return patient information in EDPXML(n)
 N DFN,VA,VADM,VAEL,VAPA,VAPD,VAOA,VAERR,EDPX,X
 S DFN=+$P($G(^EDP(230,LOG,0)),U,6) Q:DFN<1
 D 6^VADPT,OPD^VADPT,OAD^VADPT
 ;DEM
 S EDPX("name")=VADM(1)                     ;LNAME,FNAME
 S EDPX("ssn")=$P(VADM(2),U,2)              ;000-00-0000
 S EDPX("dob")=+VADM(3)                     ;YYYMMDD
 S EDPX("age")=VADM(4)                      ;00
 S EDPX("sex")=$P(VADM(5),U)                ;M
 ; EDPX("bid")=VA("BID")                    ;0000
 S EDPX("maritalSts")=$P(VADM(10),U,2)      ;MARRIED
 S:VADM(6) EDPX("died")=+VADM(6)            ;YYYMMDD
 ; ELIG
 S EDPX("veteran")=$$BOOL(+VAEL(4))         ;true
 S EDPX("sc")=$$BOOL(+VAEL(3))              ;true
 S:VAEL(3) EDPX("scPct")=$P(VAEL(3),U,2)    ;50
 ; ADD
 S EDPX("address1")=VAPA(1)                 ;123 Main St
 S:$L($G(VAPA(2))) EDPX("address2")=VAPA(2) ;Apt A
 S:$L($G(VAPA(3))) EDPX("address3")=VAPA(3) ;P.O.Box 999
 S EDPX("city")=VAPA(4)                     ;LOGAN
 S EDPX("state")=$P(VAPA(5),U,2)            ;UTAH
 S EDPX("zip")=VAPA(6),X=VAPA(8)            ;12345-6789
 S EDPX("phone")=$$FORMAT^EDPUPD(X)         ;(555)555-5555
 S X=$$GET1^DIQ(2,DFN_",",.134)
 S EDPX("cell")=$$FORMAT^EDPUPD(X)          ;(555)666-6666
 ; OPD
 S EDPX("employmentSts")=$P(VAPD(7),U,2)    ;SELF EMPLOYED
 S EDPX("employmentName")=VAPD(6)           ;CARPENTER
 ; OAD
 S EDPX("nok")=VAOA(9)                      ;LNAME,FNAME
 S EDPX("nokPhone")=VAOA(8)                 ;(555)555-5555
 ;
 ; Advance Directive?
 N MSG K ^TMP("TIUPPCV",$J)
 D ENCOVER^TIUPP3(DFN) I +MSG=0 D
 . N I S I=0 F  S I=$O(^TMP("TIUPPCV",$J,I)) Q:I<1  I $P($G(^(I)),U,2)="D" S EDPX("advDirective")="Yes" Q
 . K ^TMP("TIUPPCV",$J)
 ; Tobacco health factors?
 N HF,X S HF=0
 F  S HF=$O(^AUPNVHF("AA",DFN,HF)) Q:HF<1  D  Q:$D(EDPX("tobaccoUse"))
 . S X=$$GET1^DIQ(9999999.64,HF_",",.01)
 . I X["TOBACCO" S EDPX("tobaccoUse")=X
 ; done
 D XMLE^EDPX(.EDPX)
 Q
 ;
LOC ; -- Return location information
 N LOC,NODE,EDPX
 S LOC=+$P($G(^EDP(230,LOG,3)),U,4) Q:LOC<1
 S NODE=$G(^EDPB(231.8,LOC,0))
 ; parse values
 S EDPX("name")=$P(NODE,U)
 S EDPX("stnNum")=$P(NODE,U,2)
 S EDPX("area")=$P($G(^EDPB(231.9,+$P(NODE,U,3),0)),U)
 S EDPX("inactive")=$$BOOL($P(NODE,U,4))
 S EDPX("sequence")=$P(NODE,U,5)
 S EDPX("displayName")=$P(NODE,U,6)
 S X=$P(NODE,U,7)
 S EDPX("displayWhen")=$S(X=0:"OCCUPIED",X=1:"ALWAYS",X=2:"NEVER",1:"")
 S EDPX("defaultSts")=$P($G(^EDPB(233.1,+$P(NODE,U,8),0)),U,2)
 S X=$P(NODE,U,9)
 S EDPX("multipleAssign")=$S(X=0:"SINGLE",X=1:"MULTIPLE",X=2:"WAITING",X=3:"SINGLE NON-ED",X=4:"MULTIPLE NON-ED",1:"")
 S:$L($P(NODE,U,10)) EDPX("sharedName")=$P(NODE,U,10)
 S:$L($P(NODE,U,11)) EDPX("board")=$P(NODE,U,11)
 S:$L($P(NODE,U,12)) EDPX("color")=$P(NODE,U,12)
 ; done
 D XMLE^EDPX(.EDPX)
 Q
 ;
COMP ; -- Return long complaint
 N X,EDPX
 S X=$G(^EDP(230,LOG,2))
 I $L(X) S EDPX("longComplaint")=X D XMLE^EDPX(.EDPX)
 Q
 ;
USR(P) ; -- Return contact info for provider/resident/rn
 N NP,NODE,EDPX
 S NP=+$P($G(^EDP(230,LOG,3)),U,P) Q:NP<1
 ; name/title
 S NODE=$G(^VA(200,NP,0))
 S EDPX("name")=$P(NODE,U)
 S:$P(NODE,U,9) EDPX("title")=$$GET1^DIQ(3.1,+$P(NODE,U,9)_",",.01)
 ; phone numbers
 S NODE=$G(^VA(200,NP,.13))
 S:$L($P(NODE,U,1)) EDPX("homePhone")=$P(NODE,U)
 S:$L($P(NODE,U,2)) EDPX("officePhone")=$P(NODE,U,2)
 S:$L($P(NODE,U,3)) EDPX("phone3")=$P(NODE,U,3)
 S:$L($P(NODE,U,4)) EDPX("phone4")=$P(NODE,U,4)
 S:$L($P(NODE,U,5)) EDPX("commercialPhone")=$P(NODE,U,5)
 S:$L($P(NODE,U,6)) EDPX("fax")=$P(NODE,U,6)
 S:$L($P(NODE,U,7)) EDPX("voicePager")=$P(NODE,U,7)
 S:$L($P(NODE,U,8)) EDPX("digitalPager")=$P(NODE,U,8)
 ; done
 D XMLE^EDPX(.EDPX)
 Q
 ;
ORD(TYPE) ; -- Return status info for orders
 N I,ORIFN,EDPX,X,OI,STS,X0
 S TYPE=$G(TYPE,"MLRCA"),I=0 ;get all, if not specified?
 F  S I=$O(^EDP(230,LOG,8,I)) Q:I<1  S X0=$G(^(I,0)) I TYPE[$P(X0,U,2) D
 . K EDPX,EDPTXT
 . S ORIFN=+X0,EDPX("orderId")=ORIFN
 . S STS=$$GET1^DIQ(100,ORIFN_",",5,"I"),EDPX("statusId")=STS
 . S EDPX("statusName")=$$STATUS^EDPHIST(STS,TYPE,ORIFN)
 . ; EDPX("start")=$$GET1^DIQ(100,ORIFN_",",21,"I")
 . ; ORIGVIEW=2 D TEXT^ORQ12(.EDPTXT,ORIFN)
 . S EDPX("abbre")=$$ITEM(ORIFN,$P(X0,U,2)) ;$G(EDPTXT(1))
 . S EDPX("name")=$P($$OI^ORX8(ORIFN),U,2)
 . I $P(X0,U,2)="L",$P(X0,U,3)="C" D  Q  ;Lab results
 .. N DFN,LABID,SUB,IDT,I,EDPL K ^TMP("LRRR",$J)
 .. S DFN=+$P($G(^EDP(230,LOG,0)),U,6) Q:DFN<1
 .. S LABID=$$GET1^DIQ(100,ORIFN_",",33) Q:'$L(LABID)
 .. S SUB=$P(LABID,";",4),IDT=$P(LABID,";",5)
 .. S X=$$XMLA^EDPX("lab",.EDPX,"") D XML^EDPX(X)
 .. D RR^LR7OR1(DFN,LABID)
 .. S I=0 F  S I=$O(^TMP("LRRR",$J,DFN,SUB,IDT,I)) Q:I<1  S X=$G(^(I)) D
 ... K EDPL S EDPL("value")=$P(X,U,2),EDPL("units")=$P(X,U,4)
 ... S EDPL("range")=$P(X,U,5) S:$L($P(X,U,3)) EDPL("deviation")=$P(X,U,3)
 ... S X=+X,EDPL("test")=$$GET1^DIQ(60,X_",",51)
 ... S X=$$XMLA^EDPX("result",.EDPL) D XML^EDPX(X)
 .. D XML^EDPX("</lab>")
 . I $P(X0,U,2)="R",$P(X0,U,3)="C" D  Q  ;Radiology report
 .. S X=$$XMLA^EDPX("rad",.EDPX,"") D XML^EDPX(X)
 .. N EDPR S EDPR("report")=$$RADRPT(ORIFN)
 .. D XMLE^EDPX(.EDPR)
 .. D XML^EDPX("</rad>")
 . S X=$$XMLA^EDPX("order",.EDPX) D XML^EDPX(X) ;all other orders
 Q
 ;
ITEM(ORDER,PKG) ; -- Return [short] name of ORDER's orderable item
 N OI,I,X,Y
 S OI=$$OI^ORX8(ORDER),Y=$P(OI,U,2)
 I PKG="L" D  ;Print Name
 . S X=$$GET1^DIQ(60,+$P(OI,U,3)_",",51) S:$L(X) Y=X
 I PKG="R" D  ;[first] synonym
 . S I=+$O(^ORD(101.43,+OI,2,0)),X=$G(^(I,0))
 . S:$L(X) Y=X
 Q Y
 ;
RADRPT(ORIFN) ; -- Return Radiology report as text string
 N ID,DFN,PSET,CASE,PROC,N,TEXT,Y,I
 S ID=+$$PKGID^ORX8(+ORIFN) D EN30^RAO7PC3(ID)
 S DFN=+$P($G(^EDP(230,LOG,0)),U,6)
 S PSET=$D(^TMP($J,"RAE3",DFN,"PRINT_SET")),N=0
 S CASE=0 F  S CASE=$O(^TMP($J,"RAE3",DFN,CASE)) Q:CASE'>0  D
 . I PSET S PROC=$O(^TMP($J,"RAE3",DFN,CASE,"")) S N=N+1,TEXT(N)=PROC Q
 . S PROC="" F  S PROC=$O(^TMP($J,"RAE3",DFN,CASE,PROC)) Q:PROC=""  D
 .. S:N N=N+1,TEXT(N)="   "
 .. S N=N+1,TEXT(N)=PROC
 .. S N=N+1,TEXT(N)="   " D XRPT
 I PSET D  ;printset = list all procs, then one report
 . S CASE=$O(^TMP($J,"RAE3",DFN,0)),PROC=$O(^(CASE,""))
 . S N=N+1,TEXT(N)="   " D XRPT
 K ^TMP($J,"RAE3",DFN)
 ; return in single string Y
 S Y=$G(TEXT(1)),N=1
 F  S N=$O(TEXT(N)) Q:N<1  S Y=Y_$C(13,10)_TEXT(N)
 Q Y
 ;
XRPT ; -- Body of Report for CASE, PROC
 N ORD,X,I
 S ORD=$S($L($G(^TMP($J,"RAE3",DFN,"ORD"))):^("ORD"),$L($G(^("ORD",CASE))):^(CASE),1:"")
 I $L(ORD),ORD'=PROC S N=N+1,TEXT(N)="Proc Ord: "_ORD
 S I=1 F  S I=$O(^TMP($J,"RAE3",DFN,CASE,PROC,I)) Q:I'>0  S X=^(I),N=N+1,TEXT(N)=X ;Skip pt ID on line 1
 Q
 ;
ALLG ; -- Return list of allergies
 N DFN,GMRAL,I,EDPX
 S DFN=+$P($G(^EDP(230,LOG,0)),U,6) Q:DFN<1
 D EN1^GMRADPT Q:'GMRAL
 S I=0 F  S I=$O(GMRAL(I)) Q:I<1  D
 . S EDPX("name")=$P(GMRAL(I),U,2)
 . D XMLE^EDPX(.EDPX)
 Q
 ;
PROB ; -- Return active problems
 N DFN,IEN,EDPX
 S DFN=+$P($G(^EDP(230,LOG,0)),U,6) Q:DFN<1
 S IEN=0 F  S IEN=$O(^AUPNPROB("ACTIVE",DFN,"A",IEN)) Q:IEN<1  D
 . S EDPX("name")=$$GET1^DIQ(9000011,IEN_",",.05,"E")
 . S EDPX("icd")=$$GET1^DIQ(9000011,IEN_",",.01,"E")
 . D XML^EDPX($$XMLA^EDPX("problem",.EDPX))
 Q
 ;
MEDS ; -- Return active Rx's
 N DFN,I,RX,EDPX
 S DFN=+$P($G(^EDP(230,LOG,0)),U,6) Q:DFN<1
 D OCL^PSOORRL(DFN,1,9999999)
 S I=0 F  S I=$O(^TMP("PS",$J,I)) Q:I<1  M RX=^(I) D
 . Q:'$$ACTIVE($P(RX(0),U,9))  ;want only what pt is taking
 . S EDPX("name")=$P(RX(0),U,2)
 . S EDPX("sig")=$G(RX("SIG",1,0))
 . S EDPX("status")=$P(RX(0),U,9)
 . D XML^EDPX($$XMLA^EDPX("med",.EDPX))
 Q
 ;
ACTIVE(X) ; -- return 1 or 0, if X is an active status
 N Y S Y=1
 I X="PURGE" S Y=0
 I X="DELETED" S Y=0
 I X="EXPIRED" S Y=0 ;keep for a time, to renew?
 I $P(X," ")="DISCONTINUED" S Y=0
 Q Y
 ;
VIT ; -- Return vitals taken during current ED visit
 N DFN,IN,GMRVSTR,IDT,TYPE,IEN,REC,EDPX,X
 S DFN=+$P($G(^EDP(230,LOG,0)),U,6),IN=$P($G(^(0)),U,8) Q:DFN<1
 S GMRVSTR="BP;T;R;P;HT;WT;PN",GMRVSTR(0)=IN_"^9999999^9999999^1"
 K ^UTILITY($J,"GMRVD") D EN1^GMRVUT0
 S IDT="A" F  S IDT=$O(^UTILITY($J,"GMRVD",IDT),-1) Q:IDT<1  D
 . K EDPX S X=9999999-IDT,EDPX("time")=$$FMTE^XLFDT(X,"1P")
 . S TYPE="" F  S TYPE=$O(^UTILITY($J,"GMRVD",IDT,TYPE)) Q:TYPE=""  D
 .. S IEN=$O(^UTILITY($J,"GMRVD",IDT,TYPE,0)),REC=$G(^(IEN))
 .. S EDPX(TYPE)=$P(REC,U,8)
 . S EDPX("error")="false" ;for now
 . D XML^EDPX($$XMLA^EDPX("vital",.EDPX))
 Q
