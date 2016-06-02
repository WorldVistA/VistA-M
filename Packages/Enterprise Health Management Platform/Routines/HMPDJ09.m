HMPDJ09 ;SLC/MKB,ASMR/RRB - PCE;Nov 16, 2015 14:08:57
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^AUPNVSIT                     2028
 ; ^PXRMINDX                     4290
 ; ^SC                          10040
 ; ^VA(200                      10060
 ; DIC                           2051
 ; DILFD                         2055
 ; DIQ                           2056
 ; PXAPI,^TMP("PXKENC"           1894
 ; VALM1                        10116
 ; XUAF4                         2171
 ;
 ; All tags expect DFN, ID, [HMPSTART, HMPSTOP, HMPMAX, HMPTEXT]
 Q
 ;
PX(FNUM) ; -- PCE item(s)
 I $G(HMPID) D PXA(HMPID) Q
 N HMPIDT,ID D SORT ;sort ^PXRMINDX into ^TMP("HMPPX",$J,IDT)
 S HMPIDT=0 F  S HMPIDT=$O(^TMP("HMPPX",$J,HMPIDT)) Q:HMPIDT<1  D  Q:HMPI'<HMPMAX
 . S ID=0 F  S ID=$O(^TMP("HMPPX",$J,HMPIDT,ID)) Q:ID<1  D PX1 Q:HMPI'<HMPMAX
 K ^TMP("HMPPX",$J)
 Q
 ;
PXA(ID) ; -- find ID in ^PXRMINDX(FNUM), fall thru to PX1 if successful
 N N,ROOT,IDX,P,ITEM,DATE,HMPIDT
 S N=+$P(FNUM,".",2) K ^TMP("HMPPX",$J)
 I N=7!(N=18) S ROOT="^PXRMINDX("_FNUM_",""PPI"","_+$G(DFN)
 E  S ROOT="^PXRMINDX("_FNUM_",""PI"","_+$G(DFN)
 S IDX=ROOT_")" F  S IDX=$Q(@IDX) Q:$P(IDX,",",1,3)'=ROOT  D
 . S P=$L(IDX,",") Q:ID'=+$P(IDX,",",P)  ;last subscript
 . S DATE=+$P(IDX,",",P-1),ITEM=+$P(IDX,",",P-2)
 . S HMPIDT=9999999-DATE,^TMP("HMPPX",$J,HMPIDT,ID)=ITEM_U_DATE
 Q:'$D(^TMP("HMPPX",$J))  ;not found
PX1 ; -- PCE ^TMP("HMPPX",$J,HMPIDT,ID)=ITM^DATE for FNUM
 N N,COLL,TAG,HMPF,FLD,TMP,VISIT,X0,X12,FAC,LOC,X,Y,PCE
 N $ES,$ET,ERRPAT,ERRMSG
 S $ET="D ERRHDLR^HMPDERRH",ERRPAT=DFN
 S N=+$P(FNUM,".",2),TAG=$S(N=7:"VPOV",N=11:"VIMM",N=12:"VSKIN",N=13:"VXAM",N=16:"VPEDU",N=18:"VCPT",1:"VHF")
 S ERRMSG="A problem occurred converting record "_ID_" for "_TAG
 D @(TAG_"^PXPXRM(ID,.HMPF)")
 ;
 S PCE("localId")=ID,TMP=$G(^TMP("HMPPX",$J,HMPIDT,ID))
 S COLL=$S(N=7:"pov",N=11:"immunization",N=12:"skin",N=13:"exam",N=16:"education",N=18:"cpt",1:"factor")
 S PCE("uid")=$$SETUID^HMPUTILS(COLL,DFN,ID)
 ; TAG=$S(N=23:"recorded",N=11:"administeredDateTime",1:"dateTimeEntered")
 S TAG=$S(N=11:"administeredDateTime",1:"entered")
 S PCE(TAG)=$$JSONDT^HMPUTILS($P(TMP,U,2))
 S PCE("name")=$$EXTERNAL^DILFD(FNUM,.01,,+TMP)
 S VISIT=+$G(HMPF("VISIT")),PCE("encounterUid")=$$SETUID^HMPUTILS("visit",DFN,VISIT)
 S PCE("encounterName")=$$NAME^HMPDJ04(VISIT)
 ;DE2818, ^AUPNVSIT - ICR 2028
 S X0=$G(^AUPNVSIT(+VISIT,0)),FAC=+$P(X0,U,6),LOC=+$P(X0,U,22)  ;(#.06) LOC. OF ENCOUNTER, (#.22) HOSPITAL LOCATION
 S:FAC X=$$STA^XUAF4(FAC)_U_$P($$NS^XUAF4(FAC),U)
 S:'FAC X=$$FAC^HMPD(LOC)
 D FACILITY^HMPUTILS(X,"PCE")
 ;DE2818 ^SC global reference changed to FileMan
 S:LOC PCE("locationUid")=$$SETUID^HMPUTILS("location",,LOC),PCE("locationName")=$$GET1^DIQ(44,LOC_",",.01)
 S X=$G(HMPF("COMMENTS")) S:$L(X) PCE("comment")=X
POV I FNUM=9000010.07 D  G PXQ
 . S X=$G(HMPF("PRIMARY/SECONDARY")),PCE("type")=$S($L(X):X,1:"U")
 . S X=PCE("name"),PCE("icdCode")=$$SETNCS^HMPUTILS("icd",X)
 . S X=$G(HMPF("PROVIDER NARRATIVE")),PCE("name")=$$EXTERNAL^DILFD(9000010.07,.04,,X)
CPT I FNUM=9000010.18 D  G PXQ
 . S X=$G(HMPF("PRINCIPAL PROCEDURE")),PCE("type")=$S($L(X):X,1:"U")
 . S X=PCE("name"),PCE("cptCode")=$$SETNCS^HMPUTILS("cpt",X)
 . S X=$G(HMPF("PROVIDER NARRATIVE")),PCE("name")=$$EXTERNAL^DILFD(9000010.18,.04,,X)
 . S PCE("quantity")=HMPF("QUANTITY")
 S X=$G(HMPF("VALUE")),FLD=$S(FNUM=9000010.16:.06,1:.04)
 S Y=$$EXTERNAL^DILFD(FNUM,FLD,,X)
IM I FNUM=9000010.11 D  G PXQ ;immunization
 . S:$L(Y) PCE("seriesName")=Y,PCE("seriesCode")=$$SETUID^HMPUTILS("series",DFN,Y)
 . S X=$G(HMPF("REACTION")) I $L(X) D
 .. S PCE("reactionName")=$$EXTERNAL^DILFD(9000010.11,.06,,X)
 .. S PCE("reactionCode")=$$SETUID^HMPUTILS("reaction",DFN,X)
 . S PCE("contraindicated")=$S(+$G(HMPF("CONTRAINDICATED")):"true",1:"false")
 . I '$D(^TMP("PXKENC",$J,VISIT)) D ENCEVENT^PXAPI(VISIT,1)
 . S X12=$G(^TMP("PXKENC",$J,VISIT,"IMM",ID,12))
 . S X=$P(X12,U,4) S:'X X=$P(X12,U,2)
 . I 'X S I=0 F  S I=$O(^TMP("PXKENC",$J,VISIT,"PRV",I)) Q:I<1  I $P($G(^(I,0)),U,4)="P" S X=+^(0) Q
 . ;DE2818, ^VA(200 reference changed to FileMan
 . S:X PCE("performerUid")=$$SETUID^HMPUTILS("user",,+X),PCE("performerName")=$$GET1^DIQ(200,X_",",.01)
 . ; CPT mapping
 . S X=+$$FIND1^DIC(811.1,,"QX",+TMP_";AUTTIMM(","B") I X>0 D
 .. S Y=$$GET1^DIQ(811.1,X_",",.02,"I") Q:Y<1
 .. N CPT S CPT=$G(@(U_$P(Y,";",2)_+Y_",0)"))
 .. S PCE("cptCode")=$$SETNCS^HMPUTILS("cpt",+CPT)
 .. S (PCE("summary"),PCE("cptName"))=$P(CPT,U,2)
HF I FNUM=9000010.23 D  G PXQ ;health factor
 . S:$L(X) PCE("severityUid")=$$SETVURN^HMPUTILS("factor-severity",X),PCE("severityName")=$$LOWER^VALM1(Y)
 . S X=$$GET1^DIQ(9999999.64,+TMP_",",.03,"I") I X D
 .. S PCE("categoryUid")=$$SETVURN^HMPUTILS("factor-category",X)
 .. S PCE("categoryName")=$$EXTERNAL^DILFD(9999999.64,.03,"",X)
 . S X=$$GET1^DIQ(9999999.64,+TMP_",",.08)
 . I $E(X)="Y" S PCE("display")="true"
 . S PCE("kind")="Health Factor",PCE("summary")=PCE("name")
SK I FNUM=9000010.12 D  ;skin test [fall thru to set result]
 . S X=$G(HMPF("READING")) S:$L(X) PCE("reading")=X
 . S X=$G(HMPF("DATE READ")) S:X PCE("dateRead")=$$JSONDT^HMPUTILS(X)
 S:$L(Y) PCE("result")=Y
PXQ ;finish
 S PCE("lastUpdateTime")=$$EN^HMPSTMP(COLL) ; RHL 20150115
 S PCE("stampTime")=PCE("lastUpdateTime")   ; RHL 20150115
 ;US6734 - pre-compile metastamp
 I $G(HMPMETA) D ADD^HMPMETA(COLL,PCE("uid"),PCE("stampTime")) Q:HMPMETA=1  ;US6734,US11019
 D ADD^HMPDJ("PCE",COLL)
 Q
 ;
SORT ; -- build ^TMP("HMPPX",$J,9999999-DATE,DA)=ITEM^DATE in range
 N TYPE,ITEM,DATE,DA,IDT K ^TMP("HMPPX",$J)
 I FNUM=9000010.07!(FNUM=9000010.18) G PPI
PI ; from ^PXRMINDX(FNUM,"PI",DFN,ITEM,DATE,DA)
 ;DE2818, ^PXRMINDX - ICR 4290
 S ITEM=0 F  S ITEM=$O(^PXRMINDX(FNUM,"PI",+$G(DFN),ITEM)) Q:ITEM<1  D
 . S DATE=0 F  S DATE=$O(^PXRMINDX(FNUM,"PI",+$G(DFN),ITEM,DATE)) Q:DATE<1  D
 .. Q:DATE<HMPSTART  Q:DATE>HMPSTOP  S IDT=9999999-DATE
 .. S DA=0 F  S DA=$O(^PXRMINDX(FNUM,"PI",+$G(DFN),ITEM,DATE,DA)) Q:DA<1  S ^TMP("HMPPX",$J,IDT,DA)=ITEM_U_DATE
 Q
PPI ; from ^PXRMINDX(FNUM,"PPI",DFN,TYPE,ITEM,DATE,DA)
 S TYPE="" F  S TYPE=$O(^PXRMINDX(FNUM,"PPI",+$G(DFN),TYPE)) Q:TYPE=""  D
 . S ITEM=0 F  S ITEM=$O(^PXRMINDX(FNUM,"PPI",+$G(DFN),TYPE,ITEM)) Q:ITEM<1  D
 .. S DATE=0 F  S DATE=$O(^PXRMINDX(FNUM,"PPI",+$G(DFN),TYPE,ITEM,DATE)) Q:DATE<1  D
 ... Q:DATE<HMPSTART  Q:DATE>HMPSTOP  S IDT=9999999-DATE
 ... S DA=0 F  S DA=$O(^PXRMINDX(FNUM,"PPI",+$G(DFN),TYPE,ITEM,DATE,DA)) Q:DA<1  S ^TMP("HMPPX",$J,IDT,DA)=ITEM_U_DATE
 Q
PTF ; from ^PXRMINDX(45,"ICD9","PNI",DFN,TYPE,ITEM,DATE,DA)
 ;Purpose - Build ^TMP("HMPPX") from ^PXRMINDX(45,HMPISYS,"PNI",DFN)
 ;
 ;Called by - PTF^HMPDJ0 (if HMPID is not set)
 ;
 ;Assumptions -
 ;1. DFN, HMPSTART and HMPSTOP variables have been set in prior code
 ;2. ^TMP("HMPPX") does not exist and needs to be built
 ;3. '$G(HMPID)
 ;
 ;Modification History -
 ;US5630 (TW) - HMPISYS can be either "ICD" or "10D" (ICD-10)
 ;
 N HMPISYS,HMPTYP,HMPDX,HMPDT,HMPITEM
 S HMPISYS="" F  S HMPISYS=$O(^PXRMINDX(45,HMPISYS)) Q:HMPISYS=""  D 
 . Q:'$D(^PXRMINDX(45,HMPISYS,"PNI",+$G(DFN)))
 . S HMPTYP="" F  S HMPTYP=$O(^PXRMINDX(45,HMPISYS,"PNI",+$G(DFN),HMPTYP)) Q:HMPTYP=""  D
 .. S HMPDX=0 F  S HMPDX=$O(^PXRMINDX(45,HMPISYS,"PNI",+$G(DFN),HMPTYP,HMPDX)) Q:HMPDX=""  D
 ... S HMPDT=0 F  S HMPDT=$O(^PXRMINDX(45,HMPISYS,"PNI",+$G(DFN),HMPTYP,HMPDX,HMPDT)) Q:HMPDT<1  D
 .... Q:HMPDT<HMPSTART  Q:HMPDT>HMPSTOP  S HMPRDT=9999999-HMPDT
 .... S HMPITEM="" F  S HMPITEM=$O(^PXRMINDX(45,HMPISYS,"PNI",+$G(DFN),HMPTYP,HMPDX,HMPDT,HMPITEM)) Q:HMPITEM=""  S ^TMP("HMPPX",$J,HMPRDT,HMPITEM_";"_HMPTYP)=HMPDX_U_HMPDT_U_HMPISYS
 Q
