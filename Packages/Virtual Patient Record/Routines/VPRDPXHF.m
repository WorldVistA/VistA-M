VPRDPXHF ;SLC/MKB -- PCE Health Factors ;8/2/11  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**1**;Sep 01, 2011;Build 38
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^AUPNVSIT                     2028
 ; ^AUTTHF                       4295
 ; ^PXRMINDX                     4290
 ; DILFD                         2055
 ; DIQ                           2056
 ; PXPXRM                        4250
 ; XUAF4                         2171
 ;
 ; ------------ Get data from VistA ------------
 ;
EN(DFN,BEG,END,MAX,IFN) ; -- find a patient's health factors
 S DFN=+$G(DFN) Q:DFN<1  ;invalid patient
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)
 N VPRIDT,VPRN,VPRITM,VPRCNT
 ;
 ; get one health factor
 I $G(IFN) D  Q
 . N HF,DATE K ^TMP("VPRHF",$J)
 . S HF=0 F  S HF=$O(^PXRMINDX(9000010.23,"PI",+$G(DFN),HF)) Q:HF<1  D  Q:$D(VPRITM)
 .. S DATE=0 F  S DATE=$O(^PXRMINDX(9000010.23,"PI",+$G(DFN),HF,DATE)) Q:DATE<1  I $D(^(DATE,IFN)) D  Q
 ... S VPRIDT=9999999-DATE,^TMP("VPRHF",$J,VPRIDT,IFN)=HF_U_DATE
 ... D EN1(IFN,.VPRITM),XML(.VPRITM)
 ;
 ; get all health factors
 D SORT(DFN,BEG,END) S VPRCNT=0
 S VPRIDT=0 F  S VPRIDT=$O(^TMP("VPRHF",$J,VPRIDT)) Q:VPRIDT<1  D  Q:VPRCNT'<MAX
 . S VPRN=0 F  S VPRN=$O(^TMP("VPRHF",$J,VPRIDT,VPRN)) Q:VPRN<1  D  Q:VPRCNT'<MAX
 .. K VPRITM D EN1(VPRN,.VPRITM) Q:'$D(VPRITM)
 .. D XML(.VPRITM) S VPRCNT=VPRCNT+1
 K ^TMP("VPRHF",$J)
 Q
 ;
SORT(DFN,START,STOP) ; -- build ^TMP("VPRHF",$J,9999999-DATE,DA)=HF^DATE in range
 ;  from ^PXRMINDX(9000010.23,"PI",DFN,HF,DATE,DA)
 N HF,DATE,DA,IDT K ^TMP("VPRHF",$J)
 S HF=0 F  S HF=$O(^PXRMINDX(9000010.23,"PI",+$G(DFN),HF)) Q:HF<1  D
 . S DATE=0 F  S DATE=$O(^PXRMINDX(9000010.23,"PI",+$G(DFN),HF,DATE)) Q:DATE<1  D
 .. Q:DATE<START  Q:DATE>STOP  S IDT=9999999-DATE
 .. S DA=0 F  S DA=$O(^PXRMINDX(9000010.23,"PI",+$G(DFN),HF,DATE,DA)) Q:DA<1  S ^TMP("VPRHF",$J,IDT,DA)=HF_U_DATE
 Q
 ;
EN1(IEN,HF) ; -- return a health factor in HF("attribute")=value
 ;  from EN: expects ^TMP("VPRHF",$J,VPRIDT,IEN)=HF^DATE
 N VPRF,TMP,VISIT,X0,FAC,LOC,X K HF
 D VHF^PXPXRM(IEN,.VPRF)
 S HF("id")=IEN,HF("severity")=$G(VPRF("VALUE"))
 S TMP=$G(^TMP("VPRHF",$J,VPRIDT,IEN)),HF("recorded")=$P(TMP,U,2)
 S HF("name")=$$EXTERNAL^DILFD(9000010.23,.01,,+TMP)
 S HF("comment")=$G(VPRF("COMMENTS"))
 S VISIT=$G(VPRF("VISIT")),HF("encounter")=VISIT
 S X0=$G(^AUPNVSIT(+VISIT,0))
 S FAC=+$P(X0,U,6),LOC=+$P(X0,U,22)
 S:FAC HF("facility")=$$STA^XUAF4(FAC)_U_$P($$NS^XUAF4(FAC),U)
 S:'FAC HF("facility")=$$FAC^VPRD(LOC)
 S X=$$GET1^DIQ(9999999.64,+TMP_",",.03,"I")
 S:X HF("category")=X_U_$$GET1^DIQ(9999999.64,+TMP_",",.03)
 Q
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(HF) ; -- Return patient data as XML in @VPR@(n)
 ; as <element code='123' displayName='ABC' />
 N ATT,X,Y,I,ID
 D ADD("<factor>") S VPRTOTL=$G(VPRTOTL)+1
 S ATT="" F  S ATT=$O(HF(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . S X=$G(HF(ATT)),Y="" Q:'$L(X)
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^VPRD(X)_"' />" Q
 . S Y="<"_ATT_" code='"_$P(X,U)_"' name='"_$$ESC^VPRD($P(X,U,2))_"' />"
 D ADD("</factor>")
 Q
 ;
ADD(X) ; Add a line @VPR@(n)=X
 S VPRI=$G(VPRI)+1
 S @VPR@(VPRI)=X
 Q
