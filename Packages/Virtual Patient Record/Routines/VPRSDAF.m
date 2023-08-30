VPRSDAF ;SLC/MKB -- SDA PRF/Alert utilities ;10/25/18  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**23,31**;Sep 01, 2011;Build 3
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DDE                          7014
 ; DGPFAA                        7107
 ; DGPFAAH                       7108
 ; TIULQ                         2693
 ; TIULX                         3058
 ; TIUPP3, ^TMP("TIUPPCV")       2864
 ;
PRFQ ; -- Patient Record Flags query
 ; Expects DSTRT, DSTOP, DMAX from DDEGET
 ; Returns DLIST(#)=assignment ien
 N NUM,I,IEN,VPRF
 S:$G(DFN) NUM=$$GETALL^DGPFAA(DFN,.VPRF,,1) Q:$G(NUM)<1
 S (I,IEN)=0 F  S IEN=$O(VPRF(IEN)) Q:IEN<1  S I=I+1,DLIST(I)=IEN
 Q
 ;
PRF1(IEN) ; -- set up one patient record flag assignment
 ; Returns IEN and VPRF, VPRF1H, VPRFLH arrays
 K VPRF,VPRF1H,VPRFLH
 ; convert old vptr ID to IEN
 I $G(IEN)["~" S IEN=$$FNDASGN^DGPFAA(+$P(IEN,"~",2),+IEN_";DGPF(26.15,")
 S IEN=+$G(IEN) I IEN<1 S DDEOUT=1 Q
 I '$$GETASGN^DGPFAA(IEN,.VPRF,1) S DDEOUT=1 Q
 S VPRF1H=$$GETFIRST^DGPFAAH(IEN) D:VPRF1H GETHIST^DGPFAAH(VPRF1H,.VPRF1H)
 S VPRFLH=$$GETLAST^DGPFAAH(IEN) D:VPRFLH GETHIST^DGPFAAH(VPRFLH,.VPRFLH)
 Q
 ;
EVT ; -- DGPF PRF EVENT protocol listener
 N DFN,IEN
 S IEN=+$G(DGIEN) Q:IEN<1
 S DFN=+$G(DGPRF("DFN")) Q:DFN<1
 I $P($G(DGPRF("FLAG")),U)'?1.N1";DGPF(26.15," Q  ;Cat I flags,
 ;I +$G(DGPRF("OWNER"))'=+$$SITE^VASITE Q         ;local only
 D POST^VPRHS(DFN,"Alert",IEN_";26.13")
 Q
 ;
 ;
CWQ ; -- Crisis/Warning notes (alerts) query
 ; Expects DSTRT, DSTOP, DMAX from DDEGET and returns DLIST(#)=ien
 N I,X,CNT,TIUD
 D:$G(DFN) ENCOVER^TIUPP3(DFN)
 ; ^TMP = IEN^Acronym^Category Name^Optional Subject^Date/Time^Optional Addendum
 ; sort by Ref D/T order to retrieve by most recent
 S I=0 F  S I=$O(^TMP("TIUPPCV",$J,I)) Q:I<1  S X=$G(^(I)) I $P(X,U,2)="C"!($P(X,U,2)="W") S TIUD($P(X,U,5))=X
 Q:'$O(TIUD(0))  ;no CW's for patient
 S CNT=0,I=DSTOP
 F  S I=$O(TIUD(I),-1) Q:I<1!(I<DSTRT)  S CNT=CNT+1,DLIST(CNT)=+$G(TIUD(I))_"~"_$P(X,U,2) Q:CNT'<DMAX
 K ^TMP("TIUPPCV",$J)
 Q
 ;
CW1 ; -- get info for one CW note/alert
 K VPRTIU S VPRTYP=$P($G(DIEN),"~",2),DIEN=+$G(DIEN)
 D EXTRACT^TIULQ(DIEN,"VPRTIU",,".01:.05;1201;1202;1212;1301",,1,"I")
 I VPRTYP="" D  S:VPRTYP="" DDEOUT=1
 . N TTL,DAD
 . S TTL=+$G(VPRTIU(DIEN,.01,"I")),DAD=+$G(VPRTIU(DIEN,.04,"I"))
 . S VPRTYP=$S(DAD=30:"C",DAD=31:"W",$$ISA^TIULX(TTL,30):"C",$$ISA^TIULX(TTL,31):"W",1:"")
 Q
 ;
CW23 ; -- ID Action for P23 entity
 D CW1 Q:$G(DDEOUT)
 N RDT S RDT=$G(VPRTIU(DIEN,1301,"I")),DNAME="Alert"
 I RDT<3190101 S DDEOUT=1 Q  ;pre-load entries ok
 ; pre-17: cont w/P23 entity to fix AlertType only
 I RDT<3191101 Q
 ; re-send all since patch 17, when OpsMode may have errored
 S DIENTY=+$O(^DDE("B","VPR CW NOTES",0))
 Q
 ;
ADQ ; -- Adv Directive query
 ; Expects DSTRT, DSTOP, DMAX from DDEGET and returns DLIST(#)=ien
 N I,AD,TIUD,CNT
 D:$G(DFN) ENCOVER^TIUPP3(DFN)
 ; ^TMP = IEN^Acronym^Category Name^Optional Subject^Date/Time^Optional Addendum
 ; sort by Ref D/T order to retrieve by most recent
 S I=0 F  S I=$O(^TMP("TIUPPCV",$J,I)) Q:I<1  S AD=$G(^(I)) I $P(AD,U,2)="D" S TIUD($P(AD,U,5))=AD
 Q:'$O(TIUD(0))  ;no AD's for patient
 S CNT=0,I=DSTOP
 F  S I=$O(TIUD(I),-1) Q:I<1!(I<DSTRT)  S CNT=CNT+1,DLIST(CNT)=+$G(TIUD(I)) Q:CNT'<DMAX
 Q
 ;
AD1(ID) ; -- get info for one Adv Directive
 K VPRTIU S ID=+$G(ID)
 D EXTRACT^TIULQ(+ID,"VPRTIU",,".01:.05;1201;1212;1301;1302",,,"I")
 S:'DFN DFN=+$G(VPRTIU(+ID,.02,"I"))
 Q
