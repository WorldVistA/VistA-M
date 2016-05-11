HMPFPTC ;SLC/MKB,AGP,ASMR/RRB - Patient look-up Utilities at Facility;Nov 04, 2015 18:37:39
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
CHKS(HMPZ,DFN) ; perform patient select checks
 ;
 N ACCESS,CHKS,CNT,DEATHDT,ERR,I,IEN,STR,X,HMPY
 ; check for sensitive record
 S STR="patientChecks"
 S ACCESS=0
 D PTSEC^DGSEC4(.HMPY,DFN)  ;IA #3027
 S ACCESS=1
 I HMPY(1)>0 D
 .S CHKS("sensitive","dfn")=DFN
 .S ACCESS=(HMPY(1)<3)
 .S CHKS("sensitive","mayAccess")=$S(ACCESS=1:"true",1:"false")
 .S CHKS("sensitive","logAccess")=$S(HMPY(1)>1:"true",1:"false")
 .S CNT=2,X=""
 .F  S CNT=$O(HMPY(CNT)) Q:CNT'>0  S X=X_$C(13)_$C(10)_$G(HMPY(CNT))
 .S CHKS("sensitive","text")=X
 ;
 ; check for deceased patient, DE2818 changed from direct global reference
 D TOP^HMPXGDPT("DEATHDT",DFN,.351,"E")
 D:$L($G(DEATHDT(2,DFN,.351,"E")))
 . S CHKS("deceased","text")="This patient died on "_DEATHDT(2,DFN,.351,"E")_"."_$C(13)_$C(10)_" Do you wish to continue?"
 ;
 ; check for similar patients
 K HMPY
 N MSG,SIM,SIMPAT,TEXT S MSG=0,SIM=0
 D GUIBS5A^DPTLK6(.HMPY,DFN)  ;IA #3593
 I HMPY(1)>0 D
 .S TEXT=""
 .S I=1 F  S I=$O(HMPY(I)) Q:'I  S X=HMPY(I) D
 .. S SIM=SIM+1
 .. I $E(X)=0 S TEXT=$S($L(TEXT):TEXT_$C(13)_$C(10)_$P(X,U,2),1:$P(X,U,2))
 .. I $E(X)=1 D
 ... ;S CHKS("similar",SIM,"dfn")=$P(X,U,2)
 ... ;S CHKS("similar",SIM,"name")=$P(X,U,3)
 ... ;S CHKS("similar",SIM,"dob")=$$FMTE^XLFDT($P(X,U,4),"D")
 ... ;S CHKS("similar",SIM,"ssn")=$P(X,U,5)
 ... S SIMPAT="Patient Name: "_$P(X,U,3)_" Date of Birth: "_$$FMTE^XLFDT($P(X,U,4),"D")_" SSN: "_$P(X,U,5)
 ... S TEXT=TEXT_$C(13)_$C(10)_SIMPAT
 .S CHKS("similar","text")=TEXT
 ;
 ; possibly check means test: GUIMTD^DPTLK6
 ; possibly check legacy data: I $L($T(HXDATA^A7RDPAGU)...
 ;
 I ACCESS D PRF(DFN,.CHKS)
 S ERR(0)=""
 ;S HMP=$$ENCODE^HMPJSON("CHKS","ERR")
 D ENCODE^HMPJSON("CHKS","HMPZ","ERR")
 Q
 ;
PRF(DFN,CHKS) ; get Patient Record Flags
 N HMPY,EDI,PRF,N,X
 Q:$$GETACT^DGPFAPI(DFN,"HMPY")'>0
 S EDI=0 F  S EDI=$O(HMPY(EDI)) Q:EDI<1  K PRF D
 . S CHKS("patientRecordFlags",EDI,"assignmentStatus")="Active"
 . S CHKS("patientRecordFlags",EDI,"assignTS")=$$JSONDT^HMPUTILS($P($G(HMPY(EDI,"ASSIGNDT")),U))
 . S CHKS("patientRecordFlags",EDI,"approved")=$P($G(HMPY(EDI,"APPRVBY")),U,2)
 . S CHKS("patientRecordFlags",EDI,"nextReviewDT")=$$JSONDT^HMPUTILS($P($G(HMPY(EDI,"REVIEWDT")),U))
 . S CHKS("patientRecordFlags",EDI,"name")=$P($G(HMPY(EDI,"FLAG")),U,2)
 . S CHKS("patientRecordFlags",EDI,"type")=$P($G(HMPY(EDI,"FLAGTYPE")),U,2)
 . S CHKS("patientRecordFlags",EDI,"category")=$P($G(HMPY(EDI,"CATEGORY")),U,2)
 . S CHKS("patientRecordFlags",EDI,"ownerSite")=$P($G(HMPY(EDI,"OWNER")),U,2)
 . S CHKS("patientRecordFlags",EDI,"originatingSite")=$P($G(HMPY(EDI,"ORIGSITE")),U,2)
 . S N=1,X=$G(HMPY(EDI,"NARR",1,0))
 . F  S N=$O(HMPY(EDI,"NARR",N)) Q:N<1  S X=X_$C(13)_$C(10)_$G(HMPY(EDI,"NARR",N,0))
 . S CHKS("patientRecordFlags",EDI,"text")=X
 Q
 ;
LOG(HMPZ,DFN) ; Make entry in security log for sensitive patient access
 N ERR,RESULTS,HMPY,X
 D NOTICE^DGSEC4(.HMPY,DFN) ;IA #3027
 S X=$S(HMPY:"ok",1:"fail")
 S RESULTS("result")=X
 ;S HMP=$$ENCODE^HMPJSON("RESULTS","ERR")
 D ENCODE^HMPJSON("RESULTS","HMPZ","ERR")
 Q
 ;
ENROS(HMPZ,DFNARRAY) ;PROCESS PATIENTS FROM A ROSTER
 N DFN S DFN=0
 F  S DFN=$O(DFNARRAY(DFN)) Q:DFN'>0  D CHKS(.HMPZ,DFN)
 Q
 ;
TEST ;
 K EDPSITE
 S EDPSITE=$$IEN^XUAF4(442),NAME="doe,john"
 D CHKS(1,"",NAME)
 ;N PID S EDPSITE=$$IEN^XUAF4(442)
 ;R "DFN:",PID Q:PID=""  W !
 ;D CHK(1,PID,$P(^DPT(PID,0),U))
 N I S I=0 F  S I=$O(EDPXML(I)) Q:'I  W !,EDPXML(I)
 K EDPXML
 Q
TEST1 ;
 S EDPSITE=$$IEN^XUAF4(442),NAME="doe,john"
 D CHKS(1,"",NAME)
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
