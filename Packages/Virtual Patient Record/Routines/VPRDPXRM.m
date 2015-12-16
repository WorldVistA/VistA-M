VPRDPXRM ;SLC/MKB -- Reminders extract ;8/2/11  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**5**;Sep 01, 2011;Build 21
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DPT                         10035
 ; ^VA(200                      10060
 ; %DT                          10003
 ; DIQ                           2056
 ; PXRMMHV                       4811
 ;(returns ^TMP("PXRMMHVC",$J) and ^TMP("PXRMMHVL,$J))
 ; XLFDT                        10103
 ; XUAF4                         2171
 ;
 ; ------------ Get reminders from VistA ------------
 ;
EN(DFN,BEG,END,MAX,IFN) ; -- find patient's reminders
 ; [BEG,END,IFN not currently used]
 N VPRPROB,VPRN,VPRITM,VPRCNT,X
 D PREMLIST^PXRMMHV
 ;
 ; get one reminder
 I $G(IFN) D EN1(IFN,.VPRITM),XML(.VPRITM) G ENQ
 ;
 ; get all patient reminders
 S DFN=+$G(DFN) Q:DFN<1
 S MAX=$G(MAX,9999),VPRCNT=0
 D MHVC^PXRMMHV(DFN)
 S VPRN=0 F  S VPRN=$O(^TMP("PXRMMHVC",$J,VPRN)) Q:(VPRN<1)!(VPRCNT'<MAX)  D
 . S X=$G(^TMP("PXRMMHVC",$J,VPRN,"STATUS")) Q:$P(X,U)="N/A"
 . K VPRITM D EN1(VPRN,.VPRITM) Q:'$D(VPRITM)
 . D XML(.VPRITM) S VPRCNT=VPRCNT+1
ENQ K ^TMP("PXRMMHVC",$J),^TMP("PXRMMHVL",$J)
 Q
 ;
EN1(ID,REM) ; -- return a reminder in REM("attribute")=value
 N VPRM,X,I,J K REM
 S ID=+$G(ID) Q:ID<1  ;invalid ien
 S VPRM=$G(^TMP("PXRMMHVL",$J,ID)) Q:$P(VPRM,U,3)'="N"  ;nat'l only
 S REM("id")=ID,REM("name")=$P(VPRM,U,2),X=$P(VPRM,U,3)
 S REM("class")=X_U_$S(X="N":"NATIONAL",X="V":"VISN",X="L":"LOCAL",1:X)
 S X=$G(^TMP("PXRMMHVC",$J,ID,"STATUS"))
 S REM("status")=$P(X,U)
 S:$L($P(X,U,2)) REM("due")=$P(X,U,2) ;string or FM date
 S:$L($P(X,U,3)) REM("lastDone")=$P(X,U,3) ;string or FM date
 S REM("facility")=$$FAC^VPRD ;local stn#^name
 I $O(^TMP("PXRMMHVC",$J,ID,"DETAIL",0)) M REM("detail")=^TMP("PXRMMHVC",$J,ID,"DETAIL")
 I $O(^TMP("PXRMMHVC",$J,ID,"SUMMARY",0)) M REM("summary")=^TMP("PXRMMHVC",$J,ID,"SUMMARY")
 Q
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(REM) ; -- Return patient reminder as XML in @VPR@(I)
 N ATT,I,X,Y,NAMES
 D ADD("<reminder>") S VPRTOTL=$G(VPRTOTL)+1
 S ATT="" F  S ATT=$O(REM(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . I ATT="detail"!(ATT="summary") D  S Y="" Q  ;text
 .. S Y="<"_ATT_" xml:space='preserve'>" D ADD(Y)
 .. S I=0 F  S I=$O(REM(ATT,I)) Q:I<1  S X=$G(REM(ATT,I)),Y=$$ESC^VPRD(X) D ADD(Y)
 .. D ADD("</"_ATT_">")
 . S X=$G(REM(ATT)),Y="" Q:'$L(X)
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^VPRD(X)_"' />" Q
 . I $L(X)>1 S NAMES="code^name^Z",Y="<"_ATT_" "_$$LOOP_"/>"
 D ADD("</reminder>")
 Q
 ;
LOOP() ; -- build sub-items string from NAMES and X
 N STR,P,TAG S STR=""
 F P=1:1 S TAG=$P(NAMES,U,P) Q:TAG="Z"  I $L($P(X,U,P)) S STR=STR_TAG_"='"_$$ESC^VPRD($P(X,U,P))_"' "
 Q STR
 ;
ADD(X) ; Add a line @VPR@(n)=X
 S VPRI=$G(VPRI)+1
 S @VPR@(VPRI)=X
 Q
