VPRDJ09 ;SLC/MKB -- PCE ;8/2/11  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**2,5**;Sep 01, 2011;Build 21
 ;;Per VHA Directive 2004-038, this routine should not be modified.
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
 ; All tags expect DFN, ID, [VPRSTART, VPRSTOP, VPRMAX, VPRTEXT]
 ;
PX(FNUM) ; -- PCE item(s)
 N VPRIDT,ID
 D SORT ;sort ^PXRMINDX into ^TMP("VPRPX",$J,IDT)
 S VPRIDT=0 F  S VPRIDT=$O(^TMP("VPRPX",$J,VPRIDT)) Q:VPRIDT<1  D  Q:VPRI'<VPRMAX
 . S ID=0 F  S ID=$O(^TMP("VPRPX",$J,VPRIDT,ID)) Q:ID<1  D  Q:VPRI'<VPRMAX
 .. I $G(VPRID),ID'=VPRID Q
 .. D PX1
 K ^TMP("VPRPX",$J)
 Q
 ;
PX1 ; -- PCE ^TMP("VPRPX",$J,VPRIDT,ID)=ITM^DATE for FNUM
 N N,COLL,TAG,VPRF,FLD,TMP,VISIT,X0,X12,FAC,LOC,X,Y,PCE
 S N=+$P(FNUM,".",2),TAG=$S(N=7:"VPOV",N=11:"VIMM",N=12:"VSKIN",N=13:"VXAM",N=16:"VPEDU",N=18:"VCPT",1:"VHF")
 D @(TAG_"^PXPXRM(ID,.VPRF)")
 ;
 S PCE("localId")=ID,TMP=$G(^TMP("VPRPX",$J,VPRIDT,ID))
 S COLL=$S(N=7:"pov",N=11:"immunization",N=12:"skin",N=13:"exam",N=16:"education",N=18:"cpt",1:"factor")
 S PCE("uid")=$$SETUID^VPRUTILS(COLL,DFN,ID)
 ; TAG=$S(N=23:"recorded",N=11:"administeredDateTime",1:"dateTimeEntered")
 S TAG=$S(N=11:"administeredDateTime",1:"entered")
 S PCE(TAG)=$$JSONDT^VPRUTILS($P(TMP,U,2))
 S PCE("name")=$S($P(TMP,U,3)="10D":$P(TMP,U),1:$$EXTERNAL^DILFD(FNUM,.01,,+TMP))
 S VISIT=+$G(VPRF("VISIT")),PCE("encounterUid")=$$SETUID^VPRUTILS("visit",DFN,VISIT)
 S PCE("encounterName")=$$NAME^VPRDJ04(VISIT)
 S X0=$G(^AUPNVSIT(+VISIT,0)),FAC=+$P(X0,U,6),LOC=+$P(X0,U,22)
 S:FAC X=$$STA^XUAF4(FAC)_U_$P($$NS^XUAF4(FAC),U)
 S:'FAC X=$$FAC^VPRD(LOC)
 D FACILITY^VPRUTILS(X,"PCE")
 S:LOC PCE("locationUid")=$$SETUID^VPRUTILS("location",,LOC),PCE("locationName")=$P($G(^SC(LOC,0)),U)
 S X=$G(VPRF("COMMENTS")) S:$L(X) PCE("comment")=X
POV I FNUM=9000010.07 D  G PXQ
 . S X=$G(VPRF("PRIMARY/SECONDARY")),PCE("type")=$S($L(X):X,1:"U")
 . S Y=$$LOW^XLFSTR($P(TMP,U,3)) ;coding system
 . S X=PCE("name"),PCE("icdCode")=$$SETNCS^VPRUTILS(Y,X)
 . S X=$G(VPRF("PROVIDER NARRATIVE")),PCE("name")=$$EXTERNAL^DILFD(9000010.07,.04,,X)
CPT I FNUM=9000010.18 D  G PXQ
 . S X=$G(VPRF("PRINCIPAL PROCEDURE")),PCE("type")=$S($L(X):X,1:"U")
 . S X=PCE("name"),PCE("cptCode")=$$SETNCS^VPRUTILS("cpt",X)
 . S X=$G(VPRF("PROVIDER NARRATIVE")),PCE("name")=$$EXTERNAL^DILFD(9000010.18,.04,,X)
 . S PCE("quantity")=VPRF("QUANTITY")
 S X=$G(VPRF("VALUE")),FLD=$S(FNUM=9000010.16:.06,1:.04)
 S Y=$$EXTERNAL^DILFD(FNUM,FLD,,X)
IM I FNUM=9000010.11 D  G PXQ ;immunization
 . S:$L(Y) PCE("seriesName")=Y,PCE("seriesCode")=$$SETUID^VPRUTILS("series",DFN,Y)
 . S X=$G(VPRF("REACTION")) I $L(X) D
 .. S PCE("reactionName")=$$EXTERNAL^DILFD(9000010.11,.06,,X)
 .. S PCE("reactionCode")=$$SETUID^VPRUTILS("reaction",DFN,X)
 . S PCE("contraindicated")=$S(+$G(VPRF("CONTRAINDICATED")):"true",1:"false")
 . I '$D(^TMP("PXKENC",$J,VISIT)) D ENCEVENT^PXAPI(VISIT,1)
 . S X12=$G(^TMP("PXKENC",$J,VISIT,"IMM",ID,12))
 . S X=$P(X12,U,4) S:'X X=$P(X12,U,2)
 . I 'X S I=0 F  S I=$O(^TMP("PXKENC",$J,VISIT,"PRV",I)) Q:I<1  I $P($G(^(I,0)),U,4)="P" S X=+^(0) Q
 . S:X PCE("performerUid")=$$SETUID^VPRUTILS("user",,+X),PCE("performerName")=$P($G(^VA(200,X,0)),U)
 . ; CPT mapping
 . S X=+$$FIND1^DIC(811.1,,"QX",+TMP_";AUTTIMM(","B") I X>0 D
 .. S Y=$$GET1^DIQ(811.1,X_",",.02,"I") Q:Y<1
 .. N CPT S CPT=$G(@(U_$P(Y,";",2)_+Y_",0)"))
 .. S PCE("cptCode")=$$SETNCS^VPRUTILS("cpt",+CPT)
 .. S (PCE("summary"),PCE("cptName"))=$P(CPT,U,2)
HF I FNUM=9000010.23 D  G PXQ ;health factor
 . S:$L(X) PCE("severityUid")=$$SETVURN^VPRUTILS("factor-severity",X),PCE("severityName")=$$LOWER^VALM1(Y)
 . S X=$$GET1^DIQ(9999999.64,+TMP_",",.03,"I") I X D
 .. S PCE("categoryUid")=$$SETVURN^VPRUTILS("factor-category",X)
 .. S PCE("categoryName")=$$EXTERNAL^DILFD(9999999.64,.03,"",X)
 . S X=$$GET1^DIQ(9999999.64,+TMP_",",.08)
 . I $E(X)="Y" S PCE("display")="true"
 . S PCE("kind")="Health Factor",PCE("summary")=PCE("name")
SK I FNUM=9000010.12 D  ;skin test [fall thru to set result]
 . S X=$G(VPRF("READING")) S:$L(X) PCE("reading")=X
 . S X=$G(VPRF("DATE READ")) S:X PCE("dateRead")=$$JSONDT^VPRUTILS(X)
 S:$L(Y) PCE("result")=Y
PXQ ;finish
 D ADD^VPRDJ("PCE",COLL)
 Q
 ;
SORT ; -- build ^TMP("VPRPX",$J,9999999-DATE,DA)=ITEM^DATE^[SYS] in range
 ;  Expects VPRSTART and VPRSTOP
 N TYPE,ITEM,DATE,DA,IDT,SYS K ^TMP("VPRPX",$J)
 I FNUM=9000010.07!(FNUM=9000010.18) D  Q
 . N INDEX
 . S INDEX=$NA(^PXRMINDX(FNUM)) D PPI(INDEX)
 . I FNUM=9000010.07 S INDEX=$NA(^PXRMINDX(FNUM,"10D")) D PPI(INDEX)
PI ; from ^PXRMINDX(FNUM,"PI",DFN,ITEM,DATE,DA)
 S ITEM=0 F  S ITEM=$O(^PXRMINDX(FNUM,"PI",+$G(DFN),ITEM)) Q:ITEM<1  D
 . S DATE=0 F  S DATE=$O(^PXRMINDX(FNUM,"PI",+$G(DFN),ITEM,DATE)) Q:DATE<1  D
 .. Q:DATE<VPRSTART  Q:DATE>VPRSTOP  S IDT=9999999-DATE
 .. S DA=0 F  S DA=$O(^PXRMINDX(FNUM,"PI",+$G(DFN),ITEM,DATE,DA)) Q:DA<1  S ^TMP("VPRPX",$J,IDT,DA)=ITEM_U_DATE
 Q
PPI(INDX) ; from ^PXRMINDX(FNUM,["10D",]"PPI",DFN,TYPE,ITEM,DATE,DA)
 S TYPE="" F  S TYPE=$O(@INDX@("PPI",+$G(DFN),TYPE)) Q:TYPE=""  D
 . S ITEM="" F  S ITEM=$O(@INDX@("PPI",+$G(DFN),TYPE,ITEM)) Q:ITEM=""  D
 .. S DATE=0 F  S DATE=$O(@INDX@("PPI",+$G(DFN),TYPE,ITEM,DATE)) Q:DATE<1  D
 ... Q:DATE<VPRSTART  Q:DATE>VPRSTOP  S IDT=9999999-DATE
 ... S SYS=$S(INDX["10D":"10D",INDX[".07":"ICD",1:"CPT")
 ... S DA=0 F  S DA=$O(@INDX@("PPI",+$G(DFN),TYPE,ITEM,DATE,DA)) Q:DA<1  S ^TMP("VPRPX",$J,IDT,DA)=ITEM_U_DATE_U_SYS
 Q
PTF ; from ^PXRMINDX(45,"ICD","PNI",DFN,TYPE,ITEM,DATE,DA)
 ;  Expects VPRSTART and VPRSTOP
 N SYS,TYPE,ITEM,DATE,IDT,DA
 F SYS="ICD","10D" D
 .S TYPE="" F  S TYPE=$O(^PXRMINDX(45,SYS,"PNI",+$G(DFN),TYPE)) Q:TYPE=""  D
 .. S ITEM=0 F  S ITEM=$O(^PXRMINDX(45,SYS,"PNI",+$G(DFN),TYPE,ITEM)) Q:ITEM<1  D
 ... S DATE=0 F  S DATE=$O(^PXRMINDX(45,SYS,"PNI",+$G(DFN),TYPE,ITEM,DATE)) Q:DATE<1  D
 .... Q:DATE<VPRSTART  Q:DATE>VPRSTOP  S IDT=9999999-DATE
 .... S DA="" F  S DA=$O(^PXRMINDX(45,SYS,"PNI",+$G(DFN),TYPE,ITEM,DATE,DA)) Q:DA=""  S ^TMP("VPRPX",$J,IDT,DA_";"_TYPE)=ITEM_U_DATE_U_SYS
 Q
