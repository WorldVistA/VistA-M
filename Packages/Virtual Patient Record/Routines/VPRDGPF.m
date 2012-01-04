VPRDGPF ;SLC/MKB -- Patient Record Flags ;8/2/11  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;;Sep 01, 2011;Build 12
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; DGPFAPI                       3860
 ; XUAF4                         2171
 ;
 ; ------------ Get data from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find active flags
 ; [BEG,END,MAX not currently used]
 S DFN=+$G(DFN) Q:DFN<1  ;invalid patient
 N NUM,VPRF,VPRN,X,TEXT,VPRITM
 S NUM=$$GETACT^DGPFAPI(DFN,"VPRF")
 ;
 S VPRN=0 F  S VPRN=$O(VPRF(VPRN)) Q:VPRN<1  D  D:$D(VPRITM) XML(.VPRITM)
 . K VPRITM S X=$G(VPRF(VPRN,"FLAG"))
 . I $G(ID),$P(ID,"~",2)'=$P(X,U) Q
 . S VPRITM("id")=DFN_"~"_$P(X,U),VPRITM("name")=$P(X,U,2)
 . S VPRITM("approvedBy")=$G(VPRF(VPRN,"APPRVBY"))
 . S VPRITM("assigned")=$P($G(VPRF(VPRN,"ASSIGNDT")),U)
 . S VPRITM("reviewDue")=$P($G(VPRF(VPRN,"REVIEWDT")),U)
 . S VPRITM("type")=$P($G(VPRF(VPRN,"FLAGTYPE")),U,2)
 . S VPRITM("category")=$P($G(VPRF(VPRN,"CATEGORY")),U,2)
 . S X=$G(VPRF(VPRN,"ORIGSITE"))
 . S:X VPRITM("origSite")=$$STA^XUAF4(+X)_U_$P(X,U,2)
 . S X=$G(VPRF(VPRN,"OWNER"))
 . S:X VPRITM("ownSite")=$$STA^XUAF4(+X)_U_$P(X,U,2)
 . S X=$G(VPRF(VPRN,"TIULINK")) S:X VPRITM("document")=X
 . M TEXT=VPRF(VPRN,"NARR") S VPRITM("content")=$$STRING^VPRD(.TEXT)
 I $G(ID),'$D(VPRITM) D INACT(ID)
 Q
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(FLAG) ; -- Return patient data as XML in @VPR@(n)
 ; as <element code='123' displayName='ABC' />
 N ATT,X,Y,I,ID
 D ADD("<flag>") S VPRTOTL=$G(VPRTOTL)+1
 S ATT="" F  S ATT=$O(FLAG(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . S X=$G(FLAG(ATT)),Y="" Q:'$L(X)
 . I ATT="content" S Y="<"_ATT_" xml:space='preserve'>"_$$ESC^VPRD(X)_"</"_ATT_">" Q
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^VPRD(X)_"' />" Q
 . S Y="<"_ATT_" code='"_$P(X,U)_"' name='"_$$ESC^VPRD($P(X,U,2))_"' />"
 D ADD("</flag>")
 Q
 ;
INACT(ID) ; -- inactivated flag
 D ADD("<flag id='"_ID_"' inactivated='1' />")
 Q
 ;
ADD(X) ; Add a line @VPR@(n)=X
 S VPRI=$G(VPRI)+1
 S @VPR@(VPRI)=X
 Q
