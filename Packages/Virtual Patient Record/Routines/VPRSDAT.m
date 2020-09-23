VPRSDAT ;SLC/MKB -- SDA TIU utilities ;10/25/18  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**20**;Sep 01, 2011;Build 9
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^SC                          10040
 ; ^TIU(8925.1                   5677
 ; DIQ                           2056
 ; TIULQ                         2693
 ;
DOC1(IEN) ; -- ID Action for single document
 K VPRTIU S IEN=+$G(IEN) I IEN<1 S DDEOUT=1 Q
 D EXTRACT^TIULQ(IEN,"VPRTIU",,".01:.08;1201;1202;1205;1212;1301;1302;1307;1501:1508;1606;1701;2101",,,"I")
 Q
 ;
TEXT ; -- get note text
 N VPRT,STS,TAG,FILE,FIELD,IEN ;protect variables
 S STS=+$G(VPRTIU(DIEN,.05,"I"))
 I STS=15 S WP(1)="This document has been RETRACTED." Q
 I STS=14 S WP(1)="This document has been DELETED." Q
 I '$G(VPRTIU(DIEN,.01,"I")) S WP(1)="This document has been DELETED." Q
 D RPT^VPRDTIU(.VPRT,DIEN) M WP=@VPRT
 Q
 ;
TYPE(IEN) ; -- return code^name for document type/class
 N X,Y S Y=""
 S X=$$CATG^VPRDTIU(IEN) I X="PN" D
 . N NATL,SVC
 . S NATL=+$G(^TIU(8925.1,+$G(IEN),15)) Q:'NATL
 . S SVC=$$GET1^DIQ(8926.1,NATL_",",.07) Q:SVC=""
 . I SVC["HISTORY & PHYSICAL"!(SVC["HISTORY AND PHYSICAL") S Y="HP^History & Physical" Q
 . I SVC["COMPENSATION & PENSION" S Y="CM^Compensation & Pension" Q
 S:'$L(Y) Y=X_U_$$TYPE^VPRDJ08(X)
 Q Y
 ;
SIGDT(IEN) ; -- return date of authorization
 N Y S Y="",IEN=+$G(IEN)
 I $G(VPRTIU(IEN,1501,"I")) S Y=VPRTIU(IEN,1501,"I") ;Signed
 I $G(VPRTIU(IEN,1507,"I")) S Y=VPRTIU(IEN,1507,"I") ;Co-signed
 I $G(VPRTIU(IEN,1606,"I")) S Y=VPRTIU(IEN,1606,"I") ;Admin Closure
 Q Y
 ;
NATL(IEN) ; -- convert 8925.1 IEN to 8926.1 IEN
 ;  Returns   DATA = code ^ [description] ^ system
 ;          TIUTTL = local title name
 N TIUNATL S IEN=+$G(IEN),DATA=""
 ; VPRNATL set in VPR DOCUMENT EXTENSION
 S TIUNATL=$S($G(VPRNATL):VPRNATL,1:+$G(^TIU(8925.1,IEN,15)))
 S TIUTTL=$P($G(^TIU(8925.1,IEN,0)),U)
 ; if no national mapping, return local title
 I 'TIUNATL D  Q
 . I $P(TIUTTL," ")="LR" D  Q:$L(DATA)
 .. N TTL S TTL=$E($P(TIUTTL," ",2),1,2)
 .. S DATA=$S(TTL="AU":"18743-5^AUTOPSY REPORT",TTL="CY":"26438-2^CYTOLOGY STUDIES",TTL="EL":"50668-3^MICROSCOPY STUDIES",TTL="SU":"27898-6^PATHOLOGY STUDIES",1:"")
 .. I $L(DATA) S DATA=DATA_"^LOINC" Q
 . S DATA=IEN_U_TIUTTL_"^VA8925.1"
 ; get LOINC or VUID
 S IEN=TIUNATL,DATA=$$CODE^VPRSDA(IEN,8926.1,"LNC")
 I DATA="" S DATA=$$VUID^VPRD(IEN,8926.1) S:DATA DATA=DATA_"^^VHAT"
 ; else default = 8926.1 ien as per usual
 Q
 ;
AVSTS(STS) ; -- return Availability Status of document
 N Y S STS=+$G(STS),Y=""
 I STS<7!(STS>13) S Y="UN^Unavailable for patient care"
 E  S Y="AV^Available for patient care"
 Q Y
 ;
COMP(IEN,VST) ; -- return 1 or 0, if document is complete
 S IEN=+$G(IEN) I IEN<1 Q ""
 N VPRTIU,STS,Y D EXTRACT^TIULQ(IEN,"VPRTIU",,".03;.05",,,"I")
 S VST=$G(VPRTIU(IEN,.03,"I")) ;return, if VST passed by ref
 S STS=+$G(VPRTIU(IEN,.05,"I"))
 S Y=$S(STS=7:1,STS=8:1,1:0)
 Q Y
 ;
FAC(IEN) ; -- return #4 ien for TIU document
 N LOC,FAC S IEN=+$G(IEN)
 ; return location's facility if available
 S LOC=+$G(VPRTIU(IEN,1205,"I")),FAC="" I LOC>0 D
 . N L0 S L0=$G(^SC(LOC,0)),FAC=$P(L0,U,4)
 . ; Get P:4 via Med Ctr Div, if not directly linked
 . I 'FAC,$P(L0,U,15) S FAC=$$GET1^DIQ(44,LOC_",","3.5:.07","I")
 ; if no location, or loc has no facility, use Division field
 I FAC="" S FAC=$G(VPRTIU(IEN,1212,"I"))
 Q FAC
 ;
AD(ID) ; -- get info for one Adv Directive
 K VPRTIU S ID=$G(ID)
 D EXTRACT^TIULQ(+ID,"VPRTIU",,".01:.05;1201;1205;1212;1301;1302",,1,"I")
 S:'DFN DFN=+$G(VPRTIU(+ID,.02,"I"))
 I DFN,'$D(^TMP("TIUPPCV",$J)) D  ;one, do query
 . N DLIST,I,X
 . D ADVDIR^VPRSDAQ
 . S I=0 F  S I=$O(DLIST(I)) Q:I<1  S X=$G(DLIST(I)) I +X=+ID S ID=X Q
 S VPRADV=ID,ID=+ID
 Q
