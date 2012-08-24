VPRDPXAM ;SLC/MKB -- PCE V Exams ;8/2/11  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**1**;Sep 01, 2011;Build 38
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^AUPNVSIT                     2028
 ; ^PXRMINDX                     4290
 ; DILFD                         2055
 ; PXPXRM                        4250
 ; XUAF4                         2171
 ;
 ; ------------ Get data from VistA ------------
 ;
EN(DFN,BEG,END,MAX,IFN) ; -- find a patient's exams
 S DFN=+$G(DFN) Q:DFN<1  ;invalid patient
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)
 N VPRIDT,VPRN,VPRITM,VPRCNT
 ;
 ; get one exam
 I $G(IFN) D  Q
 . N ITM,DATE K ^TMP("VPRPX",$J)
 . S ITM=0 F  S ITM=$O(^PXRMINDX(9000010.13,"PI",+$G(DFN),ITM)) Q:ITM<1  D  Q:$D(VPRITM)
 .. S DATE=0 F  S DATE=$O(^PXRMINDX(9000010.13,"PI",+$G(DFN),ITM,DATE)) Q:DATE<1  I $D(^(DATE,IFN)) D  Q
 ... S VPRIDT=9999999-DATE,^TMP("VPRPX",$J,VPRIDT,IFN)=ITM_U_DATE
 ... D EN1(IFN,.VPRITM),XML(.VPRITM)
 ;
 ; get all exams
 D SORT(DFN,BEG,END) S VPRCNT=0
 S VPRIDT=0 F  S VPRIDT=$O(^TMP("VPRPX",$J,VPRIDT)) Q:VPRIDT<1  D  Q:VPRCNT'<MAX
 . S VPRN=0 F  S VPRN=$O(^TMP("VPRPX",$J,VPRIDT,VPRN)) Q:VPRN<1  D  Q:VPRCNT'<MAX
 .. K VPRITM D EN1(VPRN,.VPRITM) Q:'$D(VPRITM)
 .. D XML(.VPRITM) S VPRCNT=VPRCNT+1
 K ^TMP("VPRPX",$J)
 Q
 ;
SORT(DFN,START,STOP) ; -- build ^TMP("VPRPX",$J,9999999-DATE,DA)=ITM^DATE in range
 ;  from ^PXRMINDX(9000010.13,"PI",DFN,ITM,DATE,DA)
 N ITM,DATE,DA,IDT K ^TMP("VPRPX",$J)
 S ITM=0 F  S ITM=$O(^PXRMINDX(9000010.13,"PI",+$G(DFN),ITM)) Q:ITM<1  D
 . S DATE=0 F  S DATE=$O(^PXRMINDX(9000010.13,"PI",+$G(DFN),ITM,DATE)) Q:DATE<1  D
 .. Q:DATE<START  Q:DATE>STOP  S IDT=9999999-DATE
 .. S DA=0 F  S DA=$O(^PXRMINDX(9000010.13,"PI",+$G(DFN),ITM,DATE,DA)) Q:DA<1  S ^TMP("VPRPX",$J,IDT,DA)=ITM_U_DATE
 Q
 ;
EN1(IEN,PCE) ; -- return an exam in PCE("attribute")=value
 ;  from EN: expects ^TMP("VPRPX",$J,VPRIDT,IEN)=ITM^DATE
 N VPRF,TMP,VISIT,X0,FAC,LOC,X K PCE
 D VXAM^PXPXRM(IEN,.VPRF)
 S PCE("id")=IEN,X=$G(VPRF("VALUE"))
 S PCE("result")=$$EXTERNAL^DILFD(9000010.13,.04,,X)
 S TMP=$G(^TMP("VPRPX",$J,VPRIDT,IEN)),PCE("dateTime")=$P(TMP,U,2)
 S PCE("name")=$$EXTERNAL^DILFD(9000010.13,.01,,+TMP)
 S PCE("comment")=$G(VPRF("COMMENTS"))
 S VISIT=$G(VPRF("VISIT")),PCE("encounter")=VISIT
 S X0=$G(^AUPNVSIT(+VISIT,0))
 S FAC=+$P(X0,U,6),LOC=+$P(X0,U,22)
 S:FAC PCE("facility")=$$STA^XUAF4(FAC)_U_$P($$NS^XUAF4(FAC),U)
 S:'FAC PCE("facility")=$$FAC^VPRD(LOC)
 Q
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(PCE) ; -- Return patient data as XML in @VPR@(n)
 ; as <element code='123' displayName='ABC' />
 N ATT,X,Y,I,ID
 D ADD("<exam>") S VPRTOTL=$G(VPRTOTL)+1
 S ATT="" F  S ATT=$O(PCE(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . S X=$G(PCE(ATT)),Y="" Q:'$L(X)
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^VPRD(X)_"' />" Q
 . S Y="<"_ATT_" code='"_$P(X,U)_"' name='"_$$ESC^VPRD($P(X,U,2))_"' />"
 D ADD("</exam>")
 Q
 ;
ADD(X) ; Add a line @VPR@(n)=X
 S VPRI=$G(VPRI)+1
 S @VPR@(VPRI)=X
 Q
