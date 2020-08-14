DVBCPRF ;ALB/AG-Patient Record Flag ; 5/12/20 10:35am
 ;;2.7;AMIE;**220**;Apr 10, 1995 ;Build 9
 ;Per VHA Directive 6402 this routine should not be modified
 ;
 Q
 ;
FMT(ROOT) ; Format - Convert record flag data to displayable data
 ; Sets ^TMP("DVBPRF",$J,NN) with flag data for multiple flags
 N IDX,IX,CNT
 S (IDX,CNT)=0
 F  S IDX=$O(ROOT(IDX)) Q:'IDX  D
 . S ^TMP("DVBPRF",$J,IDX,"FLAG")=$P($G(ROOT(IDX,"FLAG")),U,2)
 . S ^TMP("DVBPRF",$J,IDX,"CATEGORY")=$P($G(ROOT(IDX,"CATEGORY")),U,2)
 . S CNT=CNT+1,^TMP("DVBPRF",$J,IDX,CNT)="Flag Name:               "_$P($G(ROOT(IDX,"FLAG")),U,2)
 . I $D(ROOT(IDX,"NARR")) D
 . . S CNT=CNT+1,^TMP("DVBPRF",$J,IDX,CNT)="            "
 . . S CNT=CNT+1,^TMP("DVBPRF",$J,IDX,CNT)="Assignment Narrative:   "
 . . S IX=0 F  S IX=$O(ROOT(IDX,"NARR",IX)) Q:'IX  D
 . . . S CNT=CNT+1,^TMP("DVBPRF",$J,IDX,CNT)=$G(ROOT(IDX,"NARR",IX,0))
 . S CNT=CNT+1,^TMP("DVBPRF",$J,IDX,CNT)="            "
 . ; -- Assignment Details:
 . S CNT=CNT+1,^TMP("DVBPRF",$J,IDX,CNT)="Flag Type:               "_$P($G(ROOT(IDX,"FLAGTYPE")),U,2)
 . S CNT=CNT+1,^TMP("DVBPRF",$J,IDX,CNT)="Flag Category:           "_$P($G(ROOT(IDX,"CATEGORY")),U,2)
 . S CNT=CNT+1,^TMP("DVBPRF",$J,IDX,CNT)="Assignment Status:       "_"Active"
 . S CNT=CNT+1,^TMP("DVBPRF",$J,IDX,CNT)="Initial Assigned Date:   "_$P($G(ROOT(IDX,"ASSIGNDT")),U,2)
 . S CNT=CNT+1,^TMP("DVBPRF",$J,IDX,CNT)="Approved by:             "_$P($G(ROOT(IDX,"APPRVBY")),U,2)
 . S CNT=CNT+1,^TMP("DVBPRF",$J,IDX,CNT)="Next Review Date:        "_$P($G(ROOT(IDX,"REVIEWDT")),U,2)
 . S CNT=CNT+1,^TMP("DVBPRF",$J,IDX,CNT)="Owner Site:              "_$P($G(ROOT(IDX,"OWNER")),U,2)
 . S CNT=CNT+1,^TMP("DVBPRF",$J,IDX,CNT)="Originating Site:        "_$P($G(ROOT(IDX,"ORIGSITE")),U,2)
 K ROOT
 Q
 ;
HASFLG(DVBY,PTDFN) ;Does patient PTDFN have flags
 ;     DBIA 3860: $$GETACT^DGPFAPI(PTDFN,.FLGDATA)
 ; Returns array DVBY listing active assigned flags
 ; Array DVBY has form:
 ;   DVBY(flagID) = flagID^flagname,CAT1
 ;      where CAT1 is 1 if flag is cat 1, 0 if cat 2
 ; DVBY = Num of items returned in array ORY = num of flags
 I '$L($TEXT(GETACT^DGPFAPI)) S DVBY=0 Q
 N IDY,PRFARR,CAT1
 K ^TMP("DVBPRF",$J)
 S DVBY=$$GETACT^DGPFAPI(PTDFN,"PRFARR")
 Q:'DVBY
 D FMT(.@("PRFARR")) ; Sets ^TMP("DVBPRF"
 S IDY=0 F  S IDY=$O(^TMP("DVBPRF",$J,IDY)) Q:'IDY  D
 . S DVBY(IDY)=IDY_U_$G(^TMP("DVBPRF",$J,IDY,"FLAG"))
 . S CAT1=0
 . I $G(^TMP("DVBPRF",$J,IDY,"CATEGORY"))="I (NATIONAL)" S CAT1=1
 . S DVBY(IDY)=DVBY(IDY)_U_CAT1
 Q
 ;
TRIGRPOP(POPUP,PTDFN) ;Should the flag display pop up upon patient selection
 ;
 ;   1 if pt has any active flags, either Cat I or Cat II
 ;   0 otherwise
 N PRFARR
 S POPUP=$S($$GETACT^DGPFAPI(PTDFN,"PRFARR"):1,1:0)
 Q
 ;
GETFLG(DVBY,PTDFN,FLAGID) ;Return detailed flag info for flag FLAGID
 I '$D(^TMP("DVBPRF",$J,FLAGID)) Q
 N IX,CNT
 S (IX,CNT)=0
 F  S IX=$O(^TMP("DVBPRF",$J,FLAGID,IX)) Q:'IX  D
 . S CNT=CNT+1,DVBY(CNT)=$G(^TMP("DVBPRF",$J,FLAGID,IX))
 Q
 ;
CLEAR(ORY) ;Clear up the temp global
 K ^TMP("DVBPRF",$J)
 Q
 ;
