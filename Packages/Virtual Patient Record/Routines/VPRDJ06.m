VPRDJ06 ;SLC/MKB -- Laboratory ;6/25/12  16:11
 ;;1.0;VIRTUAL PATIENT RECORD;**2**;Sep 01, 2011;Build 317
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^LAB(60                      10054
 ; ^LR                            525
 ; ^PXRMINDX                     4290
 ; ^TMP("LRRR" [LR7OR1]          2503
 ; DIQ                           2056
 ; LR7OR1,^TMP("LRRR"            2503
 ; LRPXAPI                       4245
 ; LRPXAPIU                      4246
 ; XLFSTR                       10104
 ; XUAF4                         2171
 ;
 ; All tags expect DFN, ID, LRDFN, [VPRSTART, VPRSTOP, VPRMAX, VPRTEXT]
 ;               & ^TMP("LRRR",$J,DFN,VPRSUB,VPRIDT,VPRP),VPRN
 ;
CH1 ; -- lab ID = CH;VPRIDT;VPRN
 N LAB,LRI,X,X0,SPC,LOINC,ORD,CMMT
 M LAB=VPRACC ;get accession info
 S LAB("localId")=ID,LAB("uid")=$$SETUID^VPRUTILS("lab",DFN,ID)
 S LAB("categoryCode")="urn:va:lab-category:CH"
 S LAB("categoryName")="Laboratory"
 S LAB("displayOrder")=VPRP
 S LRI=$G(^LR(LRDFN,"CH",VPRIDT,VPRN))
 S X0=$G(^TMP("LRRR",$J,DFN,"CH",VPRIDT,VPRP)),SPC=+$P(X0,U,19)
 S LAB("typeId")=+X0,LAB("typeName")=$P($G(^LAB(60,+X0,0)),U)
 S:$L($P(X0,U,2)) LAB("result")=$P(X0,U,2)
 S:$L($P(X0,U,4)) LAB("units")=$P(X0,U,4)
 S X=$P(X0,U,5) I $L(X),X["-" S LAB("low")=$$TRIM^XLFSTR($P(X,"-")),LAB("high")=$$TRIM^XLFSTR($P(X,"-",2))
 S X=$P(X0,U,3) I $L(X) D
 . S:X["*" X=$S(X["L":"LL",1:"HH")
 . S LAB("interpretationCode")="urn:hl7:observation-interpretation:"_X
 . S LAB("interpretationName")=$S(X["L":"Low",1:"High")_$S($L(X)>1:" alert",1:"")
 S LAB("displayName")=$S($L($P(X0,U,15)):$P(X0,U,15),1:LAB("test"))
 S ORD=+$P(X0,U,17) S:ORD LAB("labOrderId")=ORD
 S X=$$ORDER^VPRDLR(ORD,+X0) S:X LAB("orderUid")=$$SETUID^VPRUTILS("order",DFN,X)
 S LOINC=$P($P(LRI,U,3),"!",3) ;S:'LOINC LOINC=$$LOINC(+X0,SPC)
 I LOINC S LAB("typeCode")="urn:lnc:"_$$GET1^DIQ(95.3,+LOINC_",",.01),LAB("vuid")="urn:va:vuid:"_$$VUID^VPRD(+LOINC,95.3)
 I 'LOINC S LAB("typeCode")="urn:va:ien:60:"_+X0_":"_SPC
 I $D(^TMP("LRRR",$J,DFN,"CH",VPRIDT,"N")) M CMMT=^("N") S LAB("comment")=$$STRING^VPRD(.CMMT)
 S LAB("statusCode")="urn:va:lab-status:completed",LAB("statusName")="completed"
 D ADD^VPRDJ("LAB","lab")
 Q
 ;
ACC ; -- put accession-level data in VPRACC("attribute")
 N LR0,CDT,SPC,X K VPRACC
 S LR0=$G(^LR(LRDFN,VPRSUB,VPRIDT,0))
 S CDT=9999999-VPRIDT,VPRACC("observed")=$$DATE(CDT)
 S VPRACC("resulted")=$$DATE($P(LR0,U,3)),SPC=+$P(LR0,U,5) I SPC D
 . N IENS,VPRY S IENS=SPC_","
 . D GETS^DIQ(61,IENS,".01;4.1",,"VPRY")
 . S VPRACC("specimen")=$G(VPRY(61,IENS,.01))
 . S VPRACC("sample")=$G(VPRY(61,IENS,4.1))
 S VPRACC("groupUid")=$$SETUID^VPRUTILS("accession",DFN,VPRSUB_";"_VPRIDT)
 S VPRACC("groupName")=$P(LR0,U,6)
 S X=+$P(LR0,U,14) D  D FACILITY^VPRUTILS(X,"VPRACC")
 . S:X X=$$STA^XUAF4(X)_U_$P($$NS^XUAF4(X),U)
 . I 'X S X=$$FAC^VPRD ;local stn#^name
 Q
 ;
MI ; -- microbiology accession ID = MI;VPRIDT
 N LAB,CDT,LR0,X,ACC,FAC,X0,X1,X2,IDX,VPRM,VPRPX,VPRITM,DA,FLD
 S LAB("localId")=ID,LAB("uid")=$$SETUID^VPRUTILS("lab",DFN,ID)
 S LAB("categoryCode")="urn:va:lab-category:MI"
 S LAB("categoryName")="Microbiology"
 S LAB("statusCode")="urn:va:lab-status:completed",LAB("statusName")="completed"
 S CDT=9999999-VPRIDT,LAB("observed")=$$DATE(CDT)
 S LR0=$G(^LR(LRDFN,"MI",VPRIDT,0))
 S:$P(LR0,U,3) LAB("resulted")=$$DATE($P(LR0,U,3))
 S X=+$P(LR0,U,5) I X D  ;specimen
 . N IENS,VPRY S IENS=X_","
 . D GETS^DIQ(61,IENS,".01;2",,"VPRY")
 . S LAB("specimen")=$G(VPRY(61,IENS,.01))
 . S LAB("sample")=$$GET1^DIQ(61,X_",",4.1)
 S LAB("groupName")=$P(LR0,U,6),ACC=$P(ID,";",1,2) ;accession#
 S LAB("groupUid")=$$SETUID^VPRUTILS("accession",DFN,ACC)
 S X=$P(LR0,U,14),FAC=$S(X:$$STA^XUAF4(X)_U_$P($$NS^XUAF4(X),U),1:$$FAC^VPRD)
 D FACILITY^VPRUTILS(FAC,"LAB")
 ; get results from ^TMP
 S VPRN=0 F  S VPRN=$O(^TMP("LRRR",$J,DFN,VPRSUB,VPRIDT,VPRN)) Q:VPRN<1  D
 . S X0=$G(^TMP("LRRR",$J,DFN,"MI",VPRIDT,VPRN)),X1=$P(X0,U),X2=$P(X0,U,2)
 . I X1="URINE SCREEN" S LAB("urineScreen")=X2 Q
 . ; X1="ORGANISM" S LAB("organism")=$P(X2,";"),LAB("organismQty")=$P(X2,";",2)
 . I X1="GRAM STAIN" S LAB("gramStain",VPRN,"result")=X2 Q
 . I X1="Bacteriology Remark(s)" S LAB("bactRemarks")=X2 Q
 ; get other results from ^PXRMINDX
 S X=$O(^PXRMINDX(63,"PDI",DFN,CDT,"M;T;0")) I X?1"M;T;"1.N D
 . S IDX=$O(^PXRMINDX(63,"PDI",DFN,CDT,X,"")) K VPRM
 . D LRPXRM^LRPXAPI(.VPRM,IDX,X) Q:VPRM<1
 . S LAB("typeName")=$P(VPRM,U,2)
 . S LAB("typeCode")="urn:va:ien:60:"_+VPRM_":"_+$P(VPRM,U,7)
 F VPRPX="M;O;","M;A;" D
 . S VPRITM=VPRPX F  S VPRITM=$O(^PXRMINDX(63,"PDI",DFN,CDT,VPRITM)) Q:$E(VPRITM,1,4)'=VPRPX  D
 .. S IDX=$O(^PXRMINDX(63,"PDI",DFN,CDT,VPRITM,"")) K VPRM
 .. S DA=$P(IDX,";",5),FLD=$P(IDX,";",6)
 .. D LRPXRM^LRPXAPI(.VPRM,IDX,VPRITM) Q:'$L($G(VPRM))
 .. I VPRPX["O" S LAB("organisms",DA,"name")=$P(VPRM,U,2),LAB("organisms",DA,"qty")=$P(VPRM,U,4) Q
 .. I VPRPX["A" D  Q
 ... S LAB("organisms",DA,"drugs",FLD,"name")=$P(VPRM,U,2)
 ... S LAB("organisms",DA,"drugs",FLD,"result")=$P(VPRM,U,3)
 ... S LAB("organisms",DA,"drugs",FLD,"interp")=$P(VPRM,U,4)
 ... S:$L($P(VPRM,U,5)) LAB("organisms",DA,"drugs",FLD,"restrict")=$P(VPRM,U,5)
 ;
 S LAB("results",1,"uid")=ACC
 S LAB("results",1,"resultUid")=$$SETUID^VPRUTILS("document",DFN,ACC)
 S LAB("results",1,"localTitle")="LR MICROBIOLOGY REPORT"
 I $L($G(^LR(LRDFN,"MI",VPRIDT,99))) S LAB("comment")=^(99)
 D ADD^VPRDJ("LAB","lab")
 Q
 ;
ITEM() ; -- find ITEM string from ^PXRMINDX [uses LRDFN,ID,DFN,CDT]
 N ITM,IDX,Y S Y=""
 S IDX=LRDFN_";"_ID,ITM="M"
 F  S ITM=$O(^PXRMINDX(63,"PI",DFN,ITM)) Q:$E(ITM)'="M"  I $D(^PXRMINDX(63,"PI",DFN,ITM,CDT,IDX)) S Y=ITM Q
 Q Y
 ;
AP ; -- pathology ID = VPRSUB;VPRIDT
 N LAB,LR0,X,I,NODE
 S LAB("localId")=ID,LAB("organizerType")="accession"
 S LAB("uid")=$$SETUID^VPRUTILS("lab",DFN,ID)
 S LAB("categoryCode")="urn:va:lab-category:"_VPRSUB
 S LAB("categoryName")=$S(VPRSUB="BB":"Blood Bank",VPRSUB="SP":"Surgical Pathology",1:"Pathology")
 S LAB("statusCode")="urn:va:lab-status:completed",LAB("statusName")="completed"
 S CDT=9999999-VPRIDT,LAB("observed")=$$DATE(CDT)
 S LR0=$G(^LR(LRDFN,VPRSUB,VPRIDT,0))
 S LAB("resulted")=$$DATE($P(LR0,U,11)),LAB("groupName")=$P(LR0,U,6)
 S X="",I=0 F  S I=$O(^LR(LRDFN,VPRSUB,VPRIDT,.1,I)) Q:I<1  S X=X_$S($L(X):", ",1:"")_$P($G(^(I,0)),U)
 S:$L(X) LAB("specimen")=X
 D FACILITY^VPRUTILS($$FAC^VPRD,"LAB")
 S NODE=$S(VPRSUB="AU":$NA(^LR(LRDFN,101)),1:$NA(^LR(LRDFN,VPRSUB,VPRIDT,.05)))
 S I=0 F  S I=$O(@NODE@(I)) Q:I<1  S X=+$P($G(@NODE@(I,0)),U,2) I X D
 . N LT,NT
 . S LT=$$GET1^DIQ(8925,+X_",",.01) Q:$P(LT," ")="Addendum"
 . S NT=$$GET1^DIQ(8925,+X_",",".01:1501") S:NT="" NT="LABORATORY NOTE"
 . S LAB("results",I,"uid")=LAB("uid")_";0"
 . S LAB("results",I,"resultUid")=$$SETUID^VPRUTILS("document",DFN,X)
 . S LAB("results",I,"localTitle")=LT
 . S LAB("results",I,"nationalTitle")=NT
 I '$O(LAB("results",0)) D  ;non-TIU reports
 . S LAB("results",1,"uid")=LAB("uid")_";0"
 . S LAB("results",1,"resultUid")=$$SETUID^VPRUTILS("document",DFN,ID)
 . S LAB("results",1,"localTitle")="LR "_$$NAME^VPRDLRA(VPRSUB)_" REPORT"
 . S LAB("results",1,"nationalTitle")="LABORATORY NOTE"
 D ADD^VPRDJ("LAB","lab")
 ;
DATE(X) ; -- strip off seconds, return JSON format
 N Y S Y=$G(X)
 I $L($P(Y,".",2))>4 S Y=$P(Y,".")_"."_$E($P(Y,".",2),1,4) ;strip seconds
 S:Y Y=$$JSONDT^VPRUTILS(Y)
 Q Y
