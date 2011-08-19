EDPFPTC ;SLC/MKB - Patient look-up Utilities at Facility
 ;;1.0;EMERGENCY DEPARTMENT;;Sep 30, 2009;Build 74
 ;
CHK(AREA,DFN,NAME) ; perform patient select checks
 ;
 ; check for active on board
 N IEN,X0,CHK S NAME=$$UP^XLFSTR(NAME)
 S IEN=0 F  S IEN=$O(^EDP(230,"AC",EDPSITE,AREA,IEN)) Q:'IEN  D  Q:$D(CHK("onBoard"))
 . S X0=^EDP(230,IEN,0)
 . I DFN,($P(X0,U,6)=DFN) S CHK("onBoard")=$P(^DPT(DFN,0),U)
 . I 'DFN,($E(NAME,1,10)'="(AMBULANCE"),($$UP^XLFSTR($P(X0,U,4))=NAME) S CHK("onBoard")=NAME
 ;
 ; stop here if no DFN
 I 'DFN D  Q
 . S CHK("sensitive")=0,CHK("mayAccess")=1,CHK("logAccess")=0
 . D XML^EDPX($$XMLA^EDPX("checks",.CHK,"/"))
 ;
 ; check for sensitive record
 N EDPY,WARN,I,X
 D PTSEC^DGSEC4(.EDPY,DFN,1)  ;IA #3027
 S CHK("dfn")=DFN
 S CHK("sensitive")=(EDPY(1)>0)
 S CHK("mayAccess")=(EDPY(1)<3)
 S CHK("logAccess")=(EDPY(1)>1)
 M WARN=EDPY K WARN(1)
 ;
 ; check for deceased patient
 N DIED S DIED=0
 I +$G(^DPT(DFN,.35)) D
 . S DIED(1)="This patient died on "_$$FMTE^XLFDT(^DPT(DFN,.35),"D")_"."
 . S DIED(2)="Do you wish to continue?"
 ;
 ; check for similar patients
 K EDPY
 N MSG,SIM S MSG=0,SIM=0
 D GUIBS5A^DPTLK6(.EDPY,DFN)  ;IA #3593
 S CHK("similar")=(EDPY(1)>0)
 S I=1 F  S I=$O(EDPY(I)) Q:'I  S X=EDPY(I) D
 . I $E(X)=0 S MSG=MSG+1,MSG(MSG)=$P(X,U,2)
 . I $E(X)=1 D
 .. S X("dfn")=$P(X,U,2)
 .. S X("name")=$P(X,U,3)
 .. S X("dob")=$$FMTE^XLFDT($P(X,U,4),"D")
 .. S X("ssn")=$P(X,U,5)
 .. S SIM=SIM+1,SIM(SIM)=$$XMLA^EDPX("similar",.X,"/")
 ;
 ; possibly check means test: GUIMTD^DPTLK6
 ; possibly check legacy data: I $L($T(HXDATA^A7RDPAGU)...
 ;
 ; put it all together
 D XML^EDPX($$XMLA^EDPX("checks",.CHK,"/"))
 I $D(WARN) D
 . D XML^EDPX("<warning>")
 . S I=0 F  S I=$O(WARN(I)) Q:'I  D XML^EDPX(WARN(I))
 . I CHK("logAccess"),CHK("mayAccess") D XML^EDPX("Are you sure you wish to continue?")
 . D XML^EDPX("</warning>")
 S I=0 F  S I=$O(SIM(I)) Q:'I  D XML^EDPX(SIM(I))
 I $D(MSG) D
 . D XML^EDPX("<warnSimilar>")
 . S I=0 F  S I=$O(MSG(I)) Q:'I  D XML^EDPX(MSG(I))
 . D XML^EDPX("</warnSimilar>")
 I $D(DIED) D
 . D XML^EDPX("<died>")
 . S I=0 F  S I=$O(DIED(I)) Q:'I  D XML^EDPX(DIED(I))
 . D XML^EDPX("</died>")
 I CHK("mayAccess") D PRF(DFN)
 Q
PRF(DFN) ; get Patient Record Flags
 N EDPY,EDI,PRF,N,X
 Q:$$GETACT^DGPFAPI(DFN,"EDPY")'>0
 D XML^EDPX("<patientRecordFlags>")
 S EDI=0 F  S EDI=$O(EDPY(EDI)) Q:EDI<1  K PRF D
 . S PRF("assignmentStatus")="Active"
 . S PRF("assignTS")=$P($G(EDPY(EDI,"ASSIGNDT")),U)
 . S PRF("approved")=$P($G(EDPY(EDI,"APPRVBY")),U,2)
 . S PRF("nextReviewDT")=$P($G(EDPY(EDI,"REVIEWDT")),U)
 . S PRF("name")=$P($G(EDPY(EDI,"FLAG")),U,2)
 . S PRF("type")=$P($G(EDPY(EDI,"FLAGTYPE")),U,2)
 . S PRF("category")=$P($G(EDPY(EDI,"CATEGORY")),U,2)
 . S PRF("ownerSite")=$P($G(EDPY(EDI,"OWNER")),U,2)
 . S PRF("originatingSite")=$P($G(EDPY(EDI,"ORIGSITE")),U,2)
 . D XML^EDPX($$XMLA^EDPX("flag",.PRF,""))
 . S N=1,X=$G(EDPY(EDI,"NARR",1,0))
 . F  S N=$O(EDPY(EDI,"NARR",N)) Q:N<1  S X=X_$C(13,10)_$G(EDPY(EDI,"NARR",N,0))
 . D XML^EDPX("<text>"_$$ESC^EDPX(X)_"</text>")
 . D XML^EDPX("</flag>")
 D XML^EDPX("</patientRecordFlags>")
 Q
 ;
LOG(DFN) ; Make entry in security log for sensitive patient access
 N EDPY,X
 D NOTICE^DGSEC4(.EDPY,DFN) ;IA #3027
 S X=$S(EDPY:"ok",1:"fail")
 D XML^EDPX("<save status='"_X_"' />")
 Q
 ;
TEST ; 
 S EDPSITE=$$IEN^XUAF4(442),NAME="doe,john"
 D CHK(1,"",NAME)
 ;N PID S EDPSITE=$$IEN^XUAF4(442)
 ;R "DFN:",PID Q:PID=""  W !
 ;D CHK(1,PID,$P(^DPT(PID,0),U))
 N I S I=0 F  S I=$O(EDPXML(I)) Q:'I  W !,EDPXML(I)
 K EDPXML
 Q
TEST1 ;
 S EDPSITE=$$IEN^XUAF4(442),NAME="doe,john"
 D CHK(1,"",NAME)
 ;
 ;DO LATER?  -- linked progress notes
 ;D GETTITLE^TIUPRF2(.EDPT,DFN,EDI),GETNOTES^TIUPRF2(.EDPN,DFN,EDPT,1)
 ;I $O(EDPN(0)) D
 ;. D XML^EDPX("<notes>")
 ;. S N=0 F  S N=$O(EDPN(N)) Q:N<1  K PN S X=EDPN(N) D
 ;.. S PN("id")=+X,PN("action")=$P(X,U,2),PN("author")=$P(X,U,4)
 ;.. S PN("noteTS")=9999999-N
 ;.. D TGET^TIUSRVR1(.EDPX,+X)
 ;.. S X=$$XMLA^EDPX("note",.PN),X=$TR(X,"/") D XML^EDPX(X)
 ;.. S I=1,X=$G(@EDPX@(1))
 ;.. F  S I=$O(@EDPX@(I)) Q:I<1  S X=X_$C(13,10)_$G(@EDPX@(I))
 ;.. S X="<text>"_$$ESC^EDPX(X)_"</text>" D XML^EDPX(X)
 ;.. D XML^EDPX("</note>")
 ;. D XML^EDPX("</notes>")
