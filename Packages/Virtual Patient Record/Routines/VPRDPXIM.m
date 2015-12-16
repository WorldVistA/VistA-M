VPRDPXIM ;SLC/MKB -- Immunizations extract ;8/2/11  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**2,4,5**;Sep 01, 2011;Build 21
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^PXRMINDX                     4290
 ; ^SC                          10040
 ; ^VA(200                      10060
 ; DILFD                         2055
 ; DIQ                           2056
 ; ICPTCOD                       1995
 ; PXAPI                         1894
 ; PXPXRM                        4250
 ; XUAF4                         2171
 ; 
 ; ------------ Get immunizations from VistA ------------
 ;
EN(DFN,BEG,END,MAX,IFN) ; -- find patient's immunizations
 S DFN=+$G(DFN) Q:DFN<1  ;invalid patient
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999),VPRCNT=0
 N VPRIDT,VPRN,VPRITM,VPRCNT
 ;
 ; get one immunization
 I $G(IFN) D  Q
 . N IMZ,DATE K ^TMP("VPRIMM",$J)
 . S IMZ=0 F  S IMZ=$O(^PXRMINDX(9000010.11,"PI",+$G(DFN),IMZ)) Q:IMZ<1  D  Q:$D(VPRITM)
 .. S DATE=0 F  S DATE=$O(^PXRMINDX(9000010.11,"PI",+$G(DFN),IMZ,DATE)) Q:DATE<1  I $D(^(DATE,IFN)) D  Q
 ... S VPRIDT=9999999-DATE,VPRN=IFN
 ... S ^TMP("VPRIMM",$J,VPRIDT,IFN)=IMZ_U_DATE ;SORT node
 ... D EN1(IFN,.VPRITM),XML(.VPRITM)
 . K ^TMP("VPRIMM",$J),^TMP("PXKENC",$J)
 ;
 ; get all immunizations
 D SORT(DFN,BEG,END) S VPRCNT=0
 S VPRIDT=0 F  S VPRIDT=$O(^TMP("VPRIMM",$J,VPRIDT)) Q:VPRIDT<1  D  Q:VPRCNT'<MAX
 . S VPRN=0 F  S VPRN=$O(^TMP("VPRIMM",$J,VPRIDT,VPRN)) Q:VPRN<1  D  Q:VPRCNT'<MAX
 .. K VPRITM D EN1(VPRN,.VPRITM) Q:'$D(VPRITM)
 .. D XML(.VPRITM) S VPRCNT=VPRCNT+1
 K ^TMP("VPRIMM",$J),^TMP("PXKENC",$J)
 Q
 ;
SORT(DFN,START,STOP) ; -- build ^TMP("VPRIMM",$J,9999999-DATE,DA)=IMM^DATE in range
 ;  from ^PXRMINDX(9000010.11,"PI",DFN,IMM,DATE,DA)
 N IMZ,DATE,DA,IDT K ^TMP("VPRIMM",$J)
 S IMZ=0 F  S IMZ=$O(^PXRMINDX(9000010.11,"PI",+$G(DFN),IMZ)) Q:IMZ<1  D
 . S DATE=0 F  S DATE=$O(^PXRMINDX(9000010.11,"PI",+$G(DFN),IMZ,DATE)) Q:DATE<1  D
 .. Q:DATE<START  Q:DATE>STOP  S IDT=9999999-DATE
 .. S DA=0 F  S DA=$O(^PXRMINDX(9000010.11,"PI",+$G(DFN),IMZ,DATE,DA)) Q:DA<1  S ^TMP("VPRIMM",$J,IDT,DA)=IMZ_U_DATE
 Q
 ;
EN1(IEN,IMM) ; -- return an immunization in IMM("attribute")=value
 ; Expects ^TMP("VPRIMM",$J,VPRIDT,VPRN)=IMM^DATE from EN/SORT
 N TMP,VPRM,VISIT,X0,FAC,LOC,X2,X12,X13,LOT,X,I K IMM
 S TMP=$G(^TMP("VPRIMM",$J,VPRIDT,VPRN))
 S IMM("id")=IEN,IMM("administered")=+$P(TMP,U,2)
 D VIMM^PXPXRM(IEN,.VPRM)
 S X=$G(VPRM("IMMUNIZATION")) I X S IMM("name")=$P(X,U,2)
 E  S IMM("name")=$$EXTERNAL^DILFD(9000010.11,.01,,+TMP)
 S X=$G(VPRM("SERIES")),IMM("series")=$$EXTERNAL^DILFD(9000010.11,.04,,X)
 S X=$G(VPRM("REACTION")),IMM("reaction")=$$EXTERNAL^DILFD(9000010.11,.06,,X)
 S IMM("contraindicated")=+$G(VPRM("CONTRAINDICATED"))
 S IMM("comment")=$G(VPRM("COMMENTS"))
 S VISIT=+$G(VPRM("VISIT")),IMM("encounter")=VISIT
VST ; look for values added by PX*1*210
 S X=$G(VPRM("LOCATION")) S:X IMM("location")=$P(X,U,2) I 'X D  G LOT
 . I '$D(^TMP("PXKENC",$J,VISIT)) D ENCEVENT^PXAPI(VISIT,1)
 . S X0=$G(^TMP("PXKENC",$J,VISIT,"VST",VISIT,0))
 . S FAC=+$P(X0,U,6),LOC=+$P(X0,U,22)
 . S:FAC IMM("facility")=$$STA^XUAF4(FAC)_U_$P($$NS^XUAF4(FAC),U)
 . S:'FAC IMM("facility")=$$FAC^VPRD(LOC)
 . S IMM("location")=$P($G(^SC(LOC,0)),U)
 . S X12=$G(^TMP("PXKENC",$J,VISIT,"IMM",IEN,12)),X13=$G(^(13))
 . S X=$P(X12,U,4) ;S:'X X=$P(X12,U,2)
 . I 'X S I=0 F  S I=$O(^TMP("PXKENC",$J,VISIT,"PRV",I)) Q:I<1  I $P($G(^(I,0)),U,4)="P" S X=+^(0) Q
 . S:X IMM("provider")=X_U_$P($G(^VA(200,X,0)),U)
 S X=$G(VPRM("FACILITY")) S:X IMM("facility")=$P(X,U,3)_U_$P(X,U,2)
 S X=$G(VPRM("ENCOUNTER PROVIDER")) S:X IMM("provider")=X
LOT ; lot number, information
 S X=$G(VPRM("ORDERING PROVIDER")) S:X IMM("orderingProvider")=X
 S X=$G(VPRM("DOCUMENTER")) S:X IMM("documentedBy")=X
 S LOT=$G(VPRM("LOT NUMBER")) I LOT D  ;Lot#
 . S IMM("lot")=$P(LOT,U,2)
 . S X=$G(VPRM("MANUFACTURER")) S:X IMM("manufacturer")=$P(X,U,2)
 . S X=$G(VPRM("EXPIRATION DATE")) S:X IMM("expirationDate")=X
 S X=$G(VPRM("INFO SOURCE")) S:X IMM("source")=$P(X,U,2,3)
 S X=$G(VPRM("ADMIN ROUTE")) S:X IMM("route")=$P(X,U,2,3)
 S X=$G(VPRM("ADMIN SITE")) S:X IMM("bodySite")=$P(X,U,2,3)
 S X=$G(VPRM("DOSAGE")) I $L(X) S IMM("dose")=X
 E  D  ;Dose field to be split
 . S X=$G(VPRM("DOSE")) S:$L(X) IMM("dose")=X
 . S X=$G(VPRM("DOSE UNITS")) S:$L(X) IMM("units")=X
VIS ; vaccine information sheet
 S I=0 F  S I=$O(VPRM("VIS OFFERED",I)) Q:I<1  D
 . S X=$G(VPRM("VIS OFFERED",I,0)) ;ien^date^name^editionDate^language
 . S IMM("vis",+I)=$P(X,U,2,5)
CVX ; CVX, CPT mappings
 S X=$G(VPRM("CVX")) I $L(X) S IMM("cvx")=X
 E  S X=$$GET1^DIQ(9999999.14,+TMP_",",.03) S:$L(X) IMM("cvx")=X
 S X=$G(VPRM("CODES","CPT")) I $L(X) D  Q
 . S X=$$CPT^ICPTCOD(X)
 . S IMM("cpt")=$P(X,U,2,3)
 ; phase out codes from 811.1 ...
 S X=+$$FIND1^DIC(811.1,,"QX",+TMP_";AUTTIMM(","B") I X>0 D
 . S Y=$$GET1^DIQ(811.1,X_",",.02,"I") Q:Y<1
 . N CPT S CPT=$G(@(U_$P(Y,";",2)_+Y_",0)"))
 . S IMM("cpt")=$P(CPT,U,1,2)
 Q
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(IMM) ; -- Return immunizations as XML
 N ATT,X,Y,I,NAMES
 D ADD("<immunization>") S VPRTOTL=$G(VPRTOTL)+1
 S ATT="" F  S ATT=$O(IMM(ATT)) Q:ATT=""  D
 . S NAMES=$S(ATT="vis":"date^name^editionDate^language",1:"code^name")_"^Z"
 . I ATT="vis" D  Q
 .. D ADD("<"_ATT_">")
 .. S I="" F  S I=$O(IMM(ATT,I)) Q:I=""  D
 ... S X=$G(IMM(ATT,I)),Y="<sheet "_$$LOOP_"/>"
 ... D ADD(Y)
 .. D ADD("</"_ATT_">")
 . S X=$G(IMM(ATT)),Y="" Q:'$L(X)
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^VPRD(X)_"' />" D ADD(Y) Q
 . I $L(X)>1 S Y="<"_ATT_" "_$$LOOP_"/>" D ADD(Y)
 D ADD("</immunization>")
 Q
 ;
ADD(X) ; -- Add a line @VPR@(n)=X
 S VPRI=$G(VPRI)+1
 S @VPR@(VPRI)=X
 Q
 ;
LOOP() ; -- build sub-items string from NAMES and X
 N STR,P,TAG S STR=""
 F P=1:1 S TAG=$P(NAMES,U,P) Q:TAG="Z"  I $L($P(X,U,P)) S STR=STR_TAG_"='"_$$ESC^VPRD($P(X,U,P))_"' "
 Q STR
