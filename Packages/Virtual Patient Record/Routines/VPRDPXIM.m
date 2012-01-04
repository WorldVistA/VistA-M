VPRDPXIM ;SLC/MKB -- Immunizations extract ;8/2/11  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;;Sep 01, 2011;Build 12
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^PXRMINDX                     4290
 ; ^SC                          10040
 ; ^VA(200                      10060
 ; DILFD                         2055
 ; DIQ                           2056
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
 N TMP,VPRM,VISIT,X0,FAC,LOC,X12,X,I K IMM
 S TMP=$G(^TMP("VPRIMM",$J,VPRIDT,VPRN))
 S IMM("id")=IEN,IMM("administered")=+$P(TMP,U,2)
 S IMM("name")=$$EXTERNAL^DILFD(9000010.11,.01,,+TMP)
 D VIMM^PXPXRM(IEN,.VPRM)
 S X=$G(VPRM("SERIES")),IMM("series")=$$EXTERNAL^DILFD(9000010.11,.04,,X)
 S X=$G(VPRM("REACTION")),IMM("reaction")=$$EXTERNAL^DILFD(9000010.11,.06,,X)
 S IMM("contraindicated")=+$G(VPRM("CONTRAINDICATED"))
 S IMM("comment")=$G(VPRM("COMMENTS"))
 S VISIT=+$G(VPRM("VISIT")),IMM("encounter")=VISIT
 I '$D(^TMP("PXKENC",$J,VISIT)) D ENCEVENT^PXAPI(VISIT,1)
 S X0=$G(^TMP("PXKENC",$J,VISIT,"VST",VISIT,0))
 S FAC=+$P(X0,U,6),LOC=+$P(X0,U,22)
 S:FAC IMM("facility")=$$STA^XUAF4(FAC)_U_$P($$NS^XUAF4(FAC),U)
 S:'FAC IMM("facility")=$$FAC^VPRD(LOC)
 S IMM("location")=$P($G(^SC(LOC,0)),U)
 S X12=$G(^TMP("PXKENC",$J,VISIT,"IMM",IEN,12))
 S X=$P(X12,U,4) S:'X X=$P(X12,U,2)
 I 'X S I=0 F  S I=$O(^TMP("PXKENC",$J,VISIT,"PRV",I)) Q:I<1  I $P($G(^(I,0)),U,4)="P" S X=+^(0) Q
 S:X IMM("provider")=X_U_$P($G(^VA(200,X,0)),U)
 ; CPT mapping
 S X=+$$FIND1^DIC(811.1,,"QX",IEN_";AUTTIMM(","B") I X>0 D
 . S Y=$$GET1^DIQ(811.1,X_",",.02,"I") Q:Y<1
 . N CPT S CPT=$G(@(U_$P(Y,";",2)_+Y_",0)"))
 . S IMM("cpt")=$P(CPT,U,1,2)
 Q
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(IMM) ; -- Return immunizations as XML
 N ATT,X,Y,I,P,NAMES,TAG
 D ADD("<immunization>") S VPRTOTL=$G(VPRTOTL)+1
 S ATT="" F  S ATT=$O(IMM(ATT)) Q:ATT=""  D
 . S X=$G(IMM(ATT)),Y="" Q:'$L(X)
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^VPRD(X)_"' />" D ADD(Y) Q
 . I $L(X)>1 D
 .. S Y="<"_ATT_" "
 .. F P=1:1 S TAG=$P("code^name^Z",U,P) Q:TAG="Z"  I $L($P(X,U,P)) S Y=Y_TAG_"='"_$$ESC^VPRD($P(X,U,P))_"' "
 .. S Y=Y_"/>" D ADD(Y)
 D ADD("</immunization>")
 Q
 ;
ADD(X) ; -- Add a line @VPR@(n)=X
 S VPRI=$G(VPRI)+1
 S @VPR@(VPRI)=X
 Q
