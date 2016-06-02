HMPDJ06 ;SLC/MKB,ASMR/RRB - Laboratory;Nov 12, 2015 18:20:53
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^LAB(60                         91
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
 ; All tags expect DFN, ID, LRDFN, [HMPSTART, HMPSTOP, HMPMAX, HMPTEXT]
 ;               & ^TMP("LRRR",$J,DFN,HMPSUB,HMPIDT,HMPP),HMPN
 Q
 ;
CH1 ; -- lab ID = CH;HMPIDT;HMPN
 N LAB,LRI,X,X0,SPC,LOINC,ORD,CMMT
 N $ES,$ET,ERRPAT,ERRMSG
 S $ET="D ERRHDLR^HMPDERRH",ERRPAT=DFN
 S ERRMSG="A problem occurred converting record "_ID_" for the chemistry domain"
 ;
 M LAB=HMPACC ;get accession info
 S LAB("localId")=ID,LAB("uid")=$$SETUID^HMPUTILS("lab",DFN,ID)
 S LAB("categoryCode")="urn:va:lab-category:CH"
 S LAB("categoryName")="Laboratory"
 S LAB("displayOrder")=HMPP
 S LRI=$G(^LR(LRDFN,"CH",HMPIDT,HMPN))  ;DE2818, ^LR( - ICR525
 S X0=$G(^TMP("LRRR",$J,DFN,"CH",HMPIDT,HMPP)),SPC=+$P(X0,U,19)
 ;DE2818 - ^LAB(60) references - ICR 91
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
 S X=$$ORDER^HMPDLR(ORD,+X0) S:X LAB("orderUid")=$$SETUID^HMPUTILS("order",DFN,X)
 S LOINC=$P($P(LRI,U,3),"!",3) ;S:'LOINC LOINC=$$LOINC^HMPDJ06X(+X0,SPC)
 I LOINC S LAB("typeCode")="urn:lnc:"_$$GET1^DIQ(95.3,+LOINC_",",.01),LAB("vuid")="urn:va:vuid:"_$$VUID^HMPD(+LOINC,95.3)
 I 'LOINC S LAB("typeCode")="urn:va:ien:60:"_+X0_":"_SPC
 I $D(^TMP("LRRR",$J,DFN,"CH",HMPIDT,"N")) M CMMT=^("N") S LAB("comment")=$$STRING^HMPD(.CMMT)
 S LAB("statusCode")="urn:va:lab-status:completed",LAB("statusName")="completed"
 S LAB("lastUpdateTime")=$$EN^HMPSTMP("lab") ;RHL 20150102
 S LAB("stampTime")=LAB("lastUpdateTime") ; RHL 20150102
 ;US6734 - pre-compile metastamp
 I $G(HMPMETA) D ADD^HMPMETA("lab",LAB("uid"),LAB("stampTime")) Q:HMPMETA=1  ;US6734,US11019
 D ADD^HMPDJ("LAB","lab")
 Q
 ;
ACC ; -- put accession-level data in HMPACC("attribute")
 N LR0,CDT,SPC,X K HMPACC
 S LR0=$G(^LR(LRDFN,HMPSUB,HMPIDT,0))  ;DE2818, ^LR( - ICR525
 S CDT=9999999-HMPIDT,HMPACC("observed")=$$DATE(CDT)
 S HMPACC("resulted")=$$DATE($P(LR0,U,3)),SPC=+$P(LR0,U,5) I SPC D
 . N IENS,HMPY S IENS=SPC_","
 . D GETS^DIQ(61,IENS,".01;4.1",,"HMPY")
 . S HMPACC("specimen")=$G(HMPY(61,IENS,.01))
 . S HMPACC("sample")=$G(HMPY(61,IENS,4.1))
 S HMPACC("groupUid")=$$SETUID^HMPUTILS("accession",DFN,HMPSUB_";"_HMPIDT)
 S HMPACC("groupName")=$P(LR0,U,6)
 S X=+$P(LR0,U,14) D  D FACILITY^HMPUTILS(X,"HMPACC")
 . S:X X=$$STA^XUAF4(X)_U_$P($$NS^XUAF4(X),U)
 . I 'X S X=$$FAC^HMPD ;local stn#^name
 Q
 ;
MI ; -- microbiology accession ID = MI;HMPIDT
 N LAB,CDT,LR0,X,ACC,FAC,X0,X1,X2,IDX,HMPM,HMPPX,HMPITM,DA,FLD
 N $ES,$ET,ERRPAT,ERRMSG
 S $ET="D ERRHDLR^HMPDERRH",ERRPAT=DFN
 S ERRMSG="A problem occurred converting record "_ID_" for the microbiology domain"
 ;
 S LAB("localId")=ID,LAB("uid")=$$SETUID^HMPUTILS("lab",DFN,ID)
 S LAB("categoryCode")="urn:va:lab-category:MI"
 S LAB("categoryName")="Microbiology"
 S LAB("statusCode")="urn:va:lab-status:completed",LAB("statusName")="completed"
 S CDT=9999999-HMPIDT,LAB("observed")=$$DATE(CDT)
 S LR0=$G(^LR(LRDFN,"MI",HMPIDT,0))  ; DE2818, ^LR( - ICR525
 S:$P(LR0,U,3) LAB("resulted")=$$DATE($P(LR0,U,3))
 S X=+$P(LR0,U,5) I X D  ;specimen
 . N IENS,HMPY S IENS=X_","
 . D GETS^DIQ(61,IENS,".01;2",,"HMPY")
 . S LAB("specimen")=$G(HMPY(61,IENS,.01))
 . S LAB("sample")=$$GET1^DIQ(61,X_",",4.1)
 S LAB("groupName")=$P(LR0,U,6),ACC=$P(ID,";",1,2) ;accession#
 S LAB("groupUid")=$$SETUID^HMPUTILS("accession",DFN,ACC)
 S X=$P(LR0,U,14),FAC=$S(X:$$STA^XUAF4(X)_U_$P($$NS^XUAF4(X),U),1:$$FAC^HMPD)
 D FACILITY^HMPUTILS(FAC,"LAB")
 ; get results from ^TMP
 S HMPN=0 F  S HMPN=$O(^TMP("LRRR",$J,DFN,HMPSUB,HMPIDT,HMPN)) Q:HMPN<1  D
 . S X0=$G(^TMP("LRRR",$J,DFN,"MI",HMPIDT,HMPN)),X1=$P(X0,U),X2=$P(X0,U,2)
 . I X1="URINE SCREEN" S LAB("urineScreen")=X2 Q
 . ; X1="ORGANISM" S LAB("organism")=$P(X2,";"),LAB("organismQty")=$P(X2,";",2)
 . I X1="GRAM STAIN" S LAB("gramStain",HMPN,"result")=X2 Q
 . I X1="Bacteriology Remark(s)" S LAB("bactRemarks")=X2 Q
 ; get other results from ^PXRMINDX
 S X=$O(^PXRMINDX(63,"PDI",DFN,CDT,"M;T;0")) I X?1"M;T;"1.N D
 . S IDX=$O(^PXRMINDX(63,"PDI",DFN,CDT,X,"")) K HMPM
 . D LRPXRM^LRPXAPI(.HMPM,IDX,X) Q:HMPM<1
 . S LAB("typeName")=$P(HMPM,U,2)
 . S LAB("typeCode")="urn:va:ien:60:"_+HMPM_":"_+$P(HMPM,U,7)
 F HMPPX="M;O;","M;A;" D
 . S HMPITM=HMPPX F  S HMPITM=$O(^PXRMINDX(63,"PDI",DFN,CDT,HMPITM)) Q:$E(HMPITM,1,4)'=HMPPX  D
 .. S IDX=$O(^PXRMINDX(63,"PDI",DFN,CDT,HMPITM,"")) K HMPM
 .. S DA=$P(IDX,";",5),FLD=$P(IDX,";",6)
 .. D LRPXRM^LRPXAPI(.HMPM,IDX,HMPITM) Q:'$L($G(HMPM))
 .. I HMPPX["O" S LAB("organisms",DA,"name")=$P(HMPM,U,2),LAB("organisms",DA,"qty")=$P(HMPM,U,4) Q
 .. I HMPPX["A" D  Q
 ... S LAB("organisms",DA,"drugs",FLD,"name")=$P(HMPM,U,2)
 ... S LAB("organisms",DA,"drugs",FLD,"result")=$P(HMPM,U,3)
 ... S LAB("organisms",DA,"drugs",FLD,"interp")=$P(HMPM,U,4)
 ... S:$L($P(HMPM,U,5)) LAB("organisms",DA,"drugs",FLD,"restrict")=$P(HMPM,U,5)
 ;
 S LAB("results",1,"uid")=ACC
 S LAB("results",1,"resultUid")=$$SETUID^HMPUTILS("document",DFN,ACC)
 S LAB("results",1,"localTitle")="LR MICROBIOLOGY REPORT"
 I $L($G(^LR(LRDFN,"MI",HMPIDT,99))) S LAB("comment")=^(99)  ; DE2818, ^LR( - ICR525
 S LAB("lastUpdateTime")=$$EN^HMPSTMP("lab") ;RHL 20150102
 S LAB("stampTime")=LAB("lastUpdateTime") ; RHL 20150102
 ;US6734 - pre-compile metastamp
 I $G(HMPMETA) D ADD^HMPMETA("lab",LAB("uid"),LAB("stampTime")) Q:HMPMETA=1  ;US6734,US11019
 D ADD^HMPDJ("LAB","lab")
 Q
 ;
ITEM() ; -- find ITEM string from ^PXRMINDX [uses LRDFN,ID,DFN,CDT]
 N ITM,IDX,Y S Y=""
 S IDX=LRDFN_";"_ID,ITM="M"
 F  S ITM=$O(^PXRMINDX(63,"PI",DFN,ITM)) Q:$E(ITM)'="M"  I $D(^PXRMINDX(63,"PI",DFN,ITM,CDT,IDX)) S Y=ITM Q
 Q Y
 ;
AP ; -- pathology ID = HMPSUB;HMPIDT
 N LAB,LR0,X,I,NODE
 N $ES,$ET,ERRPAT,ERRMSG
 S $ET="D ERRHDLR^HMPDERRH",ERRPAT=DFN
 S ERRMSG="A problem occurred converting record "_ID_" for the pathology domain"
 ;
 S LAB("localId")=ID,LAB("organizerType")="accession"
 S LAB("uid")=$$SETUID^HMPUTILS("lab",DFN,ID)
 S LAB("categoryCode")="urn:va:lab-category:"_HMPSUB
 S LAB("categoryName")=$S(HMPSUB="BB":"Blood Bank",HMPSUB="SP":"Surgical Pathology",1:"Pathology")
 S LAB("statusCode")="urn:va:lab-status:completed",LAB("statusName")="completed"
 S CDT=9999999-HMPIDT,LAB("observed")=$$DATE(CDT)
 ;DE2818 begin, ^LR( references - ICR525
 S LR0=$G(^LR(LRDFN,HMPSUB,HMPIDT,0))
 S LAB("resulted")=$$DATE($P(LR0,U,11)),LAB("groupName")=$P(LR0,U,6)
 S X="",I=0 F  S I=$O(^LR(LRDFN,HMPSUB,HMPIDT,.1,I)) Q:I<1  S X=X_$S($L(X):", ",1:"")_$P($G(^(I,0)),U)
 S:$L(X) LAB("specimen")=X
 D FACILITY^HMPUTILS($$FAC^HMPD,"LAB")
 S NODE=$S(HMPSUB="AU":$NA(^LR(LRDFN,101)),1:$NA(^LR(LRDFN,HMPSUB,HMPIDT,.05)))
 S I=0 F  S I=$O(@NODE@(I)) Q:I<1  S X=+$P($G(@NODE@(I,0)),U,2) I X D
 . N LT S LT=$$GET1^DIQ(8925,+X_",",.01) Q:$P(LT," ")="Addendum"
 . S LAB("results",I,"uid")=LAB("uid")
 . S LAB("results",I,"resultUid")=$$SETUID^HMPUTILS("document",DFN,X)
 . S LAB("results",I,"localTitle")=LT
 I '$O(LAB("results",0)) D  ;non-TIU reports
 . S LAB("results",1,"uid")=LAB("uid")
 . S LAB("results",1,"resultUid")=$$SETUID^HMPUTILS("document",DFN,ID)
 . S LAB("results",1,"localTitle")="LR "_$$NAME^HMPDLRA(HMPSUB)_" REPORT"
 ; ;DE2818 end, ^LR( references - ICR525
 S LAB("lastUpdateTime")=$$EN^HMPSTMP("lab") ;RHL 20150102
 S LAB("stampTime")=LAB("lastUpdateTime") ; RHL 20150102
 ;US6734 - pre-compile metastamp
 I $G(HMPMETA) D ADD^HMPMETA("lab",LAB("uid"),LAB("stampTime")) Q:HMPMETA=1  ;US6734,US11019
 D ADD^HMPDJ("LAB","lab")
 ;
DATE(X) ; -- strip off seconds, return JSON format
 N Y S Y=$G(X)
 I $L($P(Y,".",2))>4 S Y=$P(Y,".")_"."_$E($P(Y,".",2),1,4) ;strip seconds
 S:Y Y=$$JSONDT^HMPUTILS(Y)
 Q Y
