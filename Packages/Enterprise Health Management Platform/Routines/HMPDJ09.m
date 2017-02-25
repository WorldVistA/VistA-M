HMPDJ09 ;SLC/MKB,ASMR/RRB,OB,MAT,CPC,HM - PCE;Apr 13, 2016 16:04:25
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**1,2**;May 15, 2016;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;DE4068 - reworked all PCRMINDX references to include ICD10
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
 N N,ROOT,IDX,P,ITEM,DATE,HMPIDT,ICDSYS
 S N=+$P(FNUM,".",2) K ^TMP("HMPPX",$J)
 I N=7!(N=18) S ROOT="^PXRMINDX("_FNUM_",""PPI"","_+$G(DFN)
 E  S ROOT="^PXRMINDX("_FNUM_",""PI"","_+$G(DFN)
 S IDX=ROOT_")" F  S IDX=$Q(@IDX) Q:$P(IDX,",",1,3)'=ROOT  D
 . S P=$L(IDX,",") Q:ID'=+$P(IDX,",",P)  ;last subscript
 . S DATE=+$P(IDX,",",P-1),ITEM=+$P(IDX,",",P-2)
 . S HMPIDT=9999999-DATE,^TMP("HMPPX",$J,HMPIDT,ID)=ITEM_U_DATE
 ;DE4068 also check for ICD10
 I N=7 S ROOT="^PXRMINDX("_FNUM_",""10D"",""PPI"","_+$G(DFN) D
 . S IDX=ROOT_")" F  S IDX=$Q(@IDX) Q:$P(IDX,",",1,4)'=ROOT  D
 ..  S P=$L(IDX,",") Q:ID'=+$P(IDX,",",P)  ;last subscript
 ..  S DATE=+$P(IDX,",",P-1),ITEM=+$P(IDX,",",P-2)
 ..  S HMPIDT=9999999-DATE,^TMP("HMPPX",$J,HMPIDT,ID)=ITEM_U_DATE
 Q:'$D(^TMP("HMPPX",$J))  ;not found
PX1 ; -- PCE ^TMP("HMPPX",$J,HMPIDT,ID)=ITM^DATE for FNUM
 N N,COLL,FAC,FLD,HMPF,I,LOC,LOTIEN,PCE,TAG,TMP,VISIT,X,X0,X12,Y
 N $ES,$ET,ERRPAT,ERRMSG
 N ERR,FLDS,FLG,VISITIEN
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
 S PCE(TAG)=$$JSONDT^HMPUTILS($P(TMP,U,2)) I $L(PCE(TAG))<14 S PCE(TAG)=$E(PCE(TAG)_"000000",1,14)
 I N=7!(N=18) I $G(FILTER("freshnessDateTime")) S PCE(TAG)=$$JSONDT^HMPUTILS(FILTER("freshnessDateTime")) ;DE4068
 S PCE("name")=$$EXTERNAL^DILFD(FNUM,.01,,+TMP)
 S VISIT=+$G(HMPF("VISIT")),PCE("encounterUid")=$$SETUID^HMPUTILS("visit",DFN,VISIT)
 S PCE("encounterName")=$$NAME^HMPDJ04(VISIT)
 ;DE2818, ^AUPNVSIT - ICR 2028
 ; get VISIT information 0th node
 ; 9000010 - Visit 
 S VISITIEN=VISIT_",",FLG="I",FLDS=".06;.22;"
 D GETS^DIQ(9000010,VISITIEN,FLDS,FLG,"X0","ERR")
 S FAC=$G(X0(9000010,VISITIEN,.06,"I")),LOC=$G(X0(9000010,VISITIEN,.22,"I"))
 ;
 S:FAC X=$$STA^XUAF4(FAC)_U_$P($$NS^XUAF4(FAC),U)
 S:'FAC X=$$FAC^HMPD(LOC)
 D FACILITY^HMPUTILS(X,"PCE")
 ;DE2818 ^SC global reference changed to FileMan
 S:LOC PCE("locationUid")=$$SETUID^HMPUTILS("location",,LOC),PCE("locationName")=$$GET1^DIQ(44,LOC_",",.01)
 S:$L($G(HMPF("COMMENTS"))) PCE("comment")=HMPF("COMMENTS")
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
 . D VIMM(ID,.HMPF,VISIT)
 . D:$L($G(HMPF("IMMCODE"))) VIMIMM(HMPF("IMMCODE"),.HMPF)
 . I $L($G(HMPF("LOTNUMBER"))) D
 .. S LOTIEN=$$FIND1^DIC(9999999.41,,"MX",HMPF("LOTNUMBER"),"B",,"ERR")
 .. D VIML(LOTIEN,.HMPF)
 .. S PCE("lotNumber")=HMPF("LOTNUMBER")
 .. S PCE("manufacturer")=HMPF("MANUFACTURER")
 .. S PCE("expirationDate")=$E($$JSONDT^HMPUTILS(HMPF("EXPDATE"))_"000000",1,14)
 . S:$L($G(HMPF("INFOSRC"))) PCE("eventInformationSource")=HMPF("INFOSRC")
 . S:$L($G(HMPF("ENCLOC"))) PCE("encounterLocation")=HMPF("ENCLOC")
 . S:$L($G(HMPF("ORDPRV"))) PCE("orderingProvider")=HMPF("ORDPRV")
 . S:$L($G(HMPF("CVXCODE"))) PCE("cvxCode")=HMPF("CVXCODE")
 . S:$L($G(HMPF("ROUTE"))) PCE("routeOfAdministration")=HMPF("ROUTE")
 . S:$L($G(HMPF("ADMNSITE"))) PCE("siteOfAdministration")=HMPF("ADMNSITE")
 . I $L($G(HMPF("EVNTDAT"))) D
 .. S PCE("eventDate")=$E($$JSONDT^HMPUTILS(HMPF("EVNTDAT"))_"000000",1,14)
 . S:$L($G(HMPF("DOSE"))) PCE("dosage")=HMPF("DOSE")
 . S:$L($G(HMPF("DOSEUNITS"))) PCE("dosageUnits")=HMPF("DOSEUNITS")
 . S:$L($G(HMPF("VISDAT"))) PCE("visData")=HMPF("VISDAT")
 . S:$L($G(HMPF("REMARKS"))) PCE("remarks")=HMPF("REMARKS")
 . S:$L(Y) PCE("seriesName")=Y,PCE("seriesCode")=$$SETUID^HMPUTILS("series",DFN,Y)
 . I $L($G(HMPF("REACTION"))) D
 .. S PCE("reactionName")=$$EXTERNAL^DILFD(9000010.11,.06,,HMPF("REACTION"))
 .. S PCE("reactionCode")=$$SETUID^HMPUTILS("reaction",DFN,HMPF("REACTION"))
 . S PCE("contraindicated")=$S(+$G(HMPF("CONTRAINDICATED")):"true",1:"false")
 . I '$D(^TMP("PXKENC",$J,VISIT)) D ENCEVENT^PXAPI(VISIT,1)
 . S X12=$G(^TMP("PXKENC",$J,VISIT,"IMM",ID,12))
 . S X=$P(X12,U,4) S:'X X=$P(X12,U,2)
 . I 'X S I=0 F  S I=$O(^TMP("PXKENC",$J,VISIT,"PRV",I)) Q:I<1  I $P($G(^TMP("PXKENC",$J,VISIT,"PRV",I,0)),U,4)="P" S X=+^TMP("PXKENC",$J,VISIT,"PRV",I,0) Q
 . ;DE2818, ^VA(200 reference changed to FileMan
 . S:X PCE("performerUid")=$$SETUID^HMPUTILS("user",,+X),PCE("performerName")=$$GET1^DIQ(200,X_",",.01)
 . ; CPT mapping
 . S X=+$$FIND1^DIC(811.1,,"QX",+TMP_";AUTTIMM(","B") I X>0 D
 .. S Y=$$GET1^DIQ(811.1,X_",",.02,"I") Q:Y<1
 .. N CPT S CPT=$G(@(U_$P(Y,";",2)_+Y_",0)"))
 .. S PCE("cptCode")=$$SETNCS^HMPUTILS("cpt",+CPT)
 .. S (PCE("summary"),PCE("cptName"))=$P(CPT,U,2)
 . ; US14129 - Add cdc full vaccine name to return
 . M:$D(HMPF("CDCNAME")) PCE("cdcFullVaccineName","\")=HMPF("CDCNAME")
 . N I S I="" F  S I=$O(HMPF("VIS",I)) Q:'I  D
 . . S PCE("vis",I,"visName")=$G(HMPF("VIS",I,"VISNAME"))
 . . S PCE("vis",I,"editionDate")=$G(HMPF("VIS",I,"EDITIONDATE"))
 . . S PCE("vis",I,"language")=$G(HMPF("VIS",I,"LANGUAGE"))
 . . S PCE("vis",I,"offeredDate")=$G(HMPF("VIS",I,"OFFEREDDATE"))
HF I FNUM=9000010.23 D  G PXQ ;health factor
 . S:$L(X) PCE("severityUid")=$$SETVURN^HMPUTILS("factor-severity",X),PCE("severityName")=$$LOWER^VALM1(Y)
 . S X=$$GET1^DIQ(9999999.64,+TMP_",",.03,"I") I X D
 .. S PCE("categoryUid")=$$SETVURN^HMPUTILS("factor-category",X)
 .. S PCE("categoryName")=$$EXTERNAL^DILFD(9999999.64,.03,"",X)
 . S X=$$GET1^DIQ(9999999.64,+TMP_",",.08)
 . I $E(X)="Y" S PCE("display")="true"
 . S PCE("kind")="Health Factor",PCE("summary")=PCE("name")
SK I FNUM=9000010.12 D  ;skin test [fall thru to set result]
 . S:$L($G(HMPF("READING"))) PCE("reading")=HMPF("READING")
 . S:$G(HMPF("DATE READ")) PCE("dateRead")=$$JSONDT^HMPUTILS(HMPF("DATE READ"))
 S:$L(Y) PCE("result")=Y
PXQ ;finish
 S PCE("lastUpdateTime")=$$EN^HMPSTMP(COLL) ; RHL 20150115
 S PCE("stampTime")=PCE("lastUpdateTime")   ; RHL 20150115
 ;US6734 - pre-compile metastamp
 I $G(HMPMETA) D ADD^HMPMETA(COLL,PCE("uid"),PCE("stampTime")) Q:HMPMETA=1  ;US11019/US6734
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
 Q:FNUM=9000010.18  ;
 ;for POV also check ICD10 CODES
 S TYPE="" F  S TYPE=$O(^PXRMINDX(FNUM,"10D","PPI",+$G(DFN),TYPE)) Q:TYPE=""  D
 . S ITEM="" F  S ITEM=$O(^PXRMINDX(FNUM,"10D","PPI",+$G(DFN),TYPE,ITEM)) Q:ITEM=""  D
 .. S DATE=0 F  S DATE=$O(^PXRMINDX(FNUM,"10D","PPI",+$G(DFN),TYPE,ITEM,DATE)) Q:DATE<1  D
 ... Q:DATE<HMPSTART  Q:DATE>HMPSTOP  S IDT=9999999-DATE
 ... S DA=0 F  S DA=$O(^PXRMINDX(FNUM,"10D","PPI",+$G(DFN),TYPE,ITEM,DATE,DA)) Q:DA<1  S ^TMP("HMPPX",$J,IDT,DA)=ITEM_U_DATE
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
 N HMPISYS,HMPTYP,HMPDX,HMPDT,HMPITEM,HMPRDT
 S HMPISYS="" F  S HMPISYS=$O(^PXRMINDX(45,HMPISYS)) Q:HMPISYS=""  D 
 . Q:'$D(^PXRMINDX(45,HMPISYS,"PNI",+$G(DFN)))
 . S HMPTYP="" F  S HMPTYP=$O(^PXRMINDX(45,HMPISYS,"PNI",+$G(DFN),HMPTYP)) Q:HMPTYP=""  D
 .. S HMPDX=0 F  S HMPDX=$O(^PXRMINDX(45,HMPISYS,"PNI",+$G(DFN),HMPTYP,HMPDX)) Q:HMPDX=""  D
 ... S HMPDT=0 F  S HMPDT=$O(^PXRMINDX(45,HMPISYS,"PNI",+$G(DFN),HMPTYP,HMPDX,HMPDT)) Q:HMPDT<1  D
 .... Q:HMPDT<HMPSTART  Q:HMPDT>HMPSTOP  S HMPRDT=9999999-HMPDT
 .... S HMPITEM="" F  S HMPITEM=$O(^PXRMINDX(45,HMPISYS,"PNI",+$G(DFN),HMPTYP,HMPDX,HMPDT,HMPITEM)) Q:HMPITEM=""  S ^TMP("HMPPX",$J,HMPRDT,HMPITEM_";"_HMPTYP)=HMPDX_U_HMPDT_U_HMPISYS
 Q
VIML(LOT,IMDATA) ;VIMM2.0 Return IMMUNIZATION LOT data (Lot #, Expiration Date, and Mfr. can also be in COMMENTS)
 N ARR,DATA,ERR,FILE,FLDS,FLGS,IEN
 S FILE=9999999.41 ;IMMUNIZATION LOT
 S IEN=LOT_",",FLDS=".02;.09",FLGS="IE",ARR="DATA",ERR="ERR"
 D GETS^DIQ(FILE,IEN,FLDS,FLGS,ARR,ERR)
 ;
 ; --- Expiration Date & Manufacturer
 S IMDATA("EXPDATE")=$G(DATA(FILE,IEN,.09,"I"))
 S IMDATA("MANUFACTURER")=$G(DATA(FILE,IEN,.02,"E"))
 Q
VIMM(DA,IMDATA,VISIT) ;VIMM2.0 Return data for a specified V IMMUNIZATION entry.
 N ADMIN1,ARR,DATA,ERR,FLDS,FLGS,IEN,INFO1,ROUTE1,TEMP,TMPGBL,VIS,VISIEN
 ; 9000010.11 - V IMMUNIZATION
 S IEN=DA_",",FLDS=".01;.02;.03;.04;.05;.06;.07;.08;.09;.12;1101;1201;1202;1203;1204;1205;1206;1207;1301;1302;1303;1312;1313;80101;80102;81101;81201;81202;81203;2*"
 S FLGS="IE",ARR="DATA",ERR="ERR"
 D GETS^DIQ(9000010.11,IEN,FLDS,FLGS,ARR,ERR)
 ;
 ; Immunization Code
 ;US14129 - This line was causing VIMIMM to be sent the vaccine *name* not IEN. Had to fix it for the story.
 S IMDATA("IMMCODE")=$G(DATA(9000010.11,IEN,.01,"I"))
 ;
 ; Dosage & Units
 S IMDATA("DOSE")=$G(DATA(9000010.11,IEN,1312,"E"))
 S IMDATA("DOSEUNITS")=$G(DATA(9000010.11,IEN,1313,"E"))
 ;
 ; Lot Number
 S IMDATA("LOTNUMBER")=$G(DATA(9000010.11,IEN,1207,"E"))
 ;
 ; Ordering Provider
 S IMDATA("ORDPRV")=$G(DATA(9000010.11,IEN,1202,"E"))
 ;
 ; Admin / Encounter Provuder
 S IMDATA("ADMNPRV")=$G(DATA(9000010.11,IEN,1204,"E"))
 ;
 ; Event Date and Time
 S IMDATA("EVNTDAT")=$G(DATA(9000010.11,IEN,1201,"I"))
 ;
 ; Remarks
 ; DE3454 - added logic for word processing field data - HM 
 N CT,X,WP,COUNT
 S X=$$GET1^DIQ(9000010.11,IEN,1101,"","WP"),COUNT=0
 I $D(WP(1)) S CT="" D
 . F  S CT=$O(WP(CT)) Q:CT=""  S COUNT=COUNT+1
 I COUNT>0 S IMDATA("REMARKS")="",CT="" D
 . F  S CT=$O(WP(CT)) Q:CT=""  D
 . . S IMDATA("REMARKS")=$S(CT'=COUNT:IMDATA("REMARKS")_WP(CT)_" "_$C(13)_$C(10),CT=COUNT:IMDATA("REMARKS")_WP(CT),1:0)
 ;
 ; Comments
 S IMDATA("COMMENTS")=$G(DATA(9000010.11,IEN,81101,"E"))
 ;
 ; Information Source
 S IMDATA("INFOSRC")=$G(DATA(9000010.11,IEN,1301,"E"))
 ;
 ; Route
 S IMDATA("ROUTE")=$G(DATA(9000010.11,IEN,1302,"E"))
 ;
 ; Administration Site
 S IMDATA("ADMNSITE")=$G(DATA(9000010.11,IEN,1303,"E"))
 ;
 ; Vaccine Information Statement (VIS)
 S IMDATA("VISDAT")=$$VIMVIS(.DATA)
 ;US14129 - Add More VIS data to extract
 D VIMVISNW(.DATA,.IMDATA)
 Q
VIMIMM(IMMCODE,IMDATA) ;VIMM2.0 Return data for an IMMUNIZATION entry.
 N ARR,DATA,ERR,FLDS,FLGS,IEN
 ; 9999999.14 - Immunization
 S IEN=IMMCODE_",",FLDS=".03;2",FLGS="IE",ARR="DATA",ERR="ERR"
 D GETS^DIQ(9999999.14,IEN,FLDS,FLGS,ARR,ERR)
 ;
 ; CVX code
 S IMDATA("CVXCODE")=$G(DATA(9999999.14,IEN,.03,"E"))
 ; US14129 - Add cdc full vaccine name to return
 ; Use our existing API to format the Word Processing data for JSON
 D SETTEXT^HMPUTILS($NA(DATA(9999999.14,IEN,2)),$NA(IMDATA("CDCNAME")))
 Q
VIMVIS(DATA) ;VIMM2.0 Return an IMMUNIZATION's VACCINE INFORMATION STATEMENT(s).
 N DT,SC,SL,VDX,VIS,VISALL,VISIEN
 S (DT,VIS,VISALL,VDX)="",SL="/",SC=";"
 S VISIEN="" F  S VISIEN=$O(DATA(9000010.112,VISIEN)) Q:VISIEN=""  D
 . S VIS=$G(DATA(9000010.112,VISIEN,".01","E"))
 . I $D(DATA(9000010.112,VISIEN,".02","I")) D
 . . S DT=$G(DATA(9000010.112,VISIEN,".02","I")),DT=$E($$JSONDT^HMPUTILS(DT)_"000000",1,14)
 . I $G(DT),$G(VIS)'="" S VISALL(VIS_SL_DT_SC)=""
 S (VDX,VIS)="" F  S VDX=$O(VISALL(VDX)) Q:VDX=""  S VIS=VIS_" "_$C(13)_$C(10)_VDX ; DE3454 - added logic for word processing field data - HM 
 Q VIS
 ;
VIMVISNW(DATA,IMDATA) ;US14129 - Add VIS data to extract
 N PTVISIEN,VISIEN,IEN,LANGIEN
 S PTVISIEN="" F I=1:1 S PTVISIEN=$O(DATA(9000010.112,PTVISIEN)) Q:PTVISIEN=""  D
 . S VISIEN=$G(DATA(9000010.112,PTVISIEN,".01","I"))_"," Q:'VISIEN
 . I $D(DATA(9000010.112,PTVISIEN,".01","E")) S IMDATA("VIS",I,"VISNAME")=$G(DATA(9000010.112,PTVISIEN,".01","E"))
 . S:$G(DATA(9000010.112,PTVISIEN,".02","I")) IMDATA("VIS",I,"OFFEREDDATE")=$$JSONDT^HMPUTILS(DATA(9000010.112,PTVISIEN,".02","I"))
 . D GETS^DIQ(920,VISIEN,".01;.02;.04","IE","DATA","ERR")
 . S:$G(DATA(920,VISIEN,".02","I")) IMDATA("VIS",I,"EDITIONDATE")=$$JSONDT^HMPUTILS(DATA(920,VISIEN,".02","I"))
 . ;Need to pull NAME (#1), not CODE (#.01), field from language file.
 . S LANGIEN=$G(DATA(920,VISIEN,".04","I")) S:LANGIEN IMDATA("VIS",I,"LANGUAGE")=$$GET1^DIQ(.85,LANGIEN_",",1)
 Q
