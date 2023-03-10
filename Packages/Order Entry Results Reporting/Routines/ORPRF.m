ORPRF ;SLC/JLI/JMC -Patient record flag ;6/14/06
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**173,187,190,215,243,472,542**;Dec 17, 1997;Build 11
 ;
FMT(ROOT,DBRSDATA,DGHIST) ; Format - Convert record flag data to displayable data
 ; Sets ^TMP("ORPRF",$J,NN) with flag data for multiple flags
 ; DBRSDATA - local array with DBRS data
 ; DGHIST - local array with PRF history records
 N IDX,IX,CNT,CURFLAG
 S (IDX,CNT)=0
 F  S IDX=$O(ROOT(IDX)) Q:'IDX  D
 . S ^TMP("ORPRF",$J,IDX,"FLAG")=$P($G(ROOT(IDX,"FLAG")),U,2)
 . S ^TMP("ORPRF",$J,IDX,"CATEGORY")=$P($G(ROOT(IDX,"CATEGORY")),U,2)
 . S CNT=CNT+1,^TMP("ORPRF",$J,IDX,CNT)="Flag Name:               "_$P($G(ROOT(IDX,"FLAG")),U,2)
 . I $D(ROOT(IDX,"NARR")) D
 . . S CNT=CNT+1,^TMP("ORPRF",$J,IDX,CNT)="            "
 . . S CNT=CNT+1,^TMP("ORPRF",$J,IDX,CNT)="Assignment Narrative:   "
 . . S IX=0 F  S IX=$O(ROOT(IDX,"NARR",IX)) Q:'IX  D
 . . . S CNT=CNT+1,^TMP("ORPRF",$J,IDX,CNT)=$G(ROOT(IDX,"NARR",IX,0))
 . S CNT=CNT+1,^TMP("ORPRF",$J,IDX,CNT)="            "
 . ; -- Assignment Details:
 . S CNT=CNT+1,^TMP("ORPRF",$J,IDX,CNT)="Flag Type:               "_$P($G(ROOT(IDX,"FLAGTYPE")),U,2)
 . S CNT=CNT+1,^TMP("ORPRF",$J,IDX,CNT)="Flag Category:           "_$P($G(ROOT(IDX,"CATEGORY")),U,2)
 . S CNT=CNT+1,^TMP("ORPRF",$J,IDX,CNT)="Assignment Status:       "_"Active"
 . S CNT=CNT+1,^TMP("ORPRF",$J,IDX,CNT)="Initial Assigned Date:   "_$P($G(ROOT(IDX,"ASSIGNDT")),U,2)
 . S CNT=CNT+1,^TMP("ORPRF",$J,IDX,CNT)="Approved by:             "_$P($G(ROOT(IDX,"APPRVBY")),U,2)
 . S CNT=CNT+1,^TMP("ORPRF",$J,IDX,CNT)="Next Review Date:        "_$P($G(ROOT(IDX,"REVIEWDT")),U,2)
 . S CNT=CNT+1,^TMP("ORPRF",$J,IDX,CNT)="Owner Site:              "_$P($G(ROOT(IDX,"OWNER")),U,2)
 . S CNT=CNT+1,^TMP("ORPRF",$J,IDX,CNT)="Originating Site:        "_$P($G(ROOT(IDX,"ORIGSITE")),U,2)
 . ;DBRS data
 . I $O(DBRSDATA("BEHAVIORAL",0)) I $P($G(ROOT(IDX,"FLAG")),U,2)="BEHAVIORAL" D
 . . N ORDBRSC,ORZDBRSD
 . . S ORDBRSC=0 F  S ORDBRSC=+$O(DBRSDATA("BEHAVIORAL",ORDBRSC)) Q:ORDBRSC=0  D
 . . . S ORZDBRSD=$G(DBRSDATA("BEHAVIORAL",ORDBRSC))
 . . . I $P(ORZDBRSD,U,1)']"" Q
 . . . S CNT=CNT+1,^TMP("ORPRF",$J,IDX,CNT)="DBRS number:             "_$P(ORZDBRSD,U,1)
 . . . I $P(ORZDBRSD,U,2)]"" S CNT=CNT+1,^TMP("ORPRF",$J,IDX,CNT)="Other DBRS data:         "_$P(ORZDBRSD,U,2)
 . ;check if any history for the PRF flag that is being processed now
 . S CURFLAG=$P($G(ROOT(IDX,"FLAG")),U,2)
 . I $O(DGHIST(CURFLAG,0)) D
 . . N ORPRFHCN,ORPRFHDA,ORPRFSIT,ORQUIT
 . . S ORPRFSIT="",ORQUIT=0
 . . S ORPRFHCN=0 F  S ORPRFHCN=+$O(DGHIST(CURFLAG,ORPRFHCN)) Q:ORPRFHCN=0!(ORQUIT=1)  D  Q:ORQUIT=1
 . . . I $D(DGHIST(CURFLAG,ORPRFHCN)),ORPRFHCN>10 D  Q:ORQUIT=1
 . . . . S ORQUIT=1
 . . . . S CNT=CNT+1,^TMP("ORPRF",$J,IDX,CNT)="*** Additional information is in VistA ***"
 . . . I ORPRFHCN=1 S CNT=CNT+1,^TMP("ORPRF",$J,IDX,CNT)=""
 . . . I ORPRFHCN=1 S CNT=CNT+1,^TMP("ORPRF",$J,IDX,CNT)="History of Actions Taken:"
 . . . I ORPRFHCN=1 S CNT=CNT+1,^TMP("ORPRF",$J,IDX,CNT)="Date          Action          Site ID  Site Name"
 . . . I ORPRFHCN=1 S CNT=CNT+1,^TMP("ORPRF",$J,IDX,CNT)="------------------------------------------------"
 . . . S ORPRFHDA=$G(DGHIST(CURFLAG,ORPRFHCN)) Q:ORPRFHDA=""
 . . . ;I ORPRFSIT'=$P(ORPRFHDA,U) S ORPRFSIT=$P(ORPRFHDA,U) S CNT=CNT+1,^TMP("ORPRF",$J,IDX,CNT)=ORPRFSIT_" changes:"
 . . . S CNT=CNT+1,^TMP("ORPRF",$J,IDX,CNT)=$P($P(ORPRFHDA,U,2),"@",1)_"  "_$$LJ^XLFSTR($P(ORPRFHDA,U,3),15)_" "_$$LJ^XLFSTR($P(ORPRFHDA,U,4),8)_" "_$$LJ^XLFSTR($E($P(ORPRFHDA,U,1),1,20),30)
 K ROOT
 Q
 ;
HASFLG(ORY,PTDFN) ;Does patient PTDFN has flags
 ;     DBIA 3860: $$GETACT^DGPFAPI(PTDFN,.FLGDATA)
 ; Returns array ORY listing active assigned flags
 ; Array ORY has form:
 ;   ORY(flagID) = flagID^flagname,CAT1
 ;      where CAT1 is 1 if flag is cat 1, 0 if cat 2
 ; ORY = Num of items returned in array ORY = num of flags
 I '$L($TEXT(GETACT^DGPFAPI)) S ORY=0 Q
 N IDY,PRFARR,CAT1
 K ^TMP("ORPRF",$J)
 S ORY=$$GETACT^DGPFAPI(PTDFN,"PRFARR")
 Q:'ORY
 ;
 N DBRSARR,PRFHIST
 ;ICR# 6874 - check if DG*5.3*951 installed and then call the API to get DBRS information
 I $T(GETDBRS^DGPFDBRS)'="" I $$GETDBRS^DGPFDBRS(PTDFN,.DBRSARR)
 ;get history records for active PRFs
 D ACTPRFHS^ORPRFHST(PTDFN,.PRFHIST)
 ;
 D FMT(.@("PRFARR"),.DBRSARR,.PRFHIST) ; Sets ^TMP("ORPRF"
 S IDY=0 F  S IDY=$O(^TMP("ORPRF",$J,IDY)) Q:'IDY  D
 . S ORY(IDY)=IDY_U_$G(^TMP("ORPRF",$J,IDY,"FLAG"))
 . S CAT1=0
 . I $G(^TMP("ORPRF",$J,IDY,"CATEGORY"))="I (NATIONAL)" S CAT1=1
 . S ORY(IDY)=ORY(IDY)_U_CAT1
 Q
 ;
HASFLG1(ORY,PTDFN) ; Does patient PTDFN have **Cat I** flags
 ; Returns array ORY listing active assigned Cat I flags
 ; Array ORY has form:
 ;   ORY(flagID) = flagID^flagname
 ; ORY = Num of Cat I flags
 ;   If pt has no Cat I flags ORY = 0 and no flags are returned.
 ; Also calls FMT^ORPRF, which sets ^TMP("ORPRF" for Cat I flags
 ;  
 I '$L($TEXT(GETACT^DGPFAPI)) S ORY=0 Q
 N FLAGID,PRFARR,CAT1CNT,ACTFLGS
 K ^TMP("ORPRF",$J)
 S ACTFLGS=$$GETACT^DGPFAPI(PTDFN,"PRFARR")
 I 'ACTFLGS S ORY=0 Q
 S (FLAGID,CAT1CNT)=0
 F  S FLAGID=$O(PRFARR(FLAGID)) Q:'FLAGID  D
 . I $P($G(PRFARR(FLAGID,"CATEGORY"))," ")="I" S CAT1CNT=CAT1CNT+1 Q
 . K PRFARR(FLAGID)
 I 'CAT1CNT S ORY=0 Q
 D FMT(.@("PRFARR"))
 S IDY=0 F  S IDY=$O(^TMP("ORPRF",$J,IDY)) Q:'IDY  D
 . S ORY(IDY)=IDY_U_$G(^TMP("ORPRF",$J,IDY,"FLAG"))
 S ORY=CAT1CNT
 Q
 ;
HASCAT1(HASCAT1,PTDFN) ;Does patient have Category I flags (no arrays)
 ; Returns boolean HASCAT1 = 0 or 1
 ; Does NOT set arrays or TMP globals
 N FLAGID,PRFARR,ACTFLGS
 S (HASCAT1,FLAGID)=0
 S ACTFLGS=$$GETACT^DGPFAPI(PTDFN,"PRFARR") I 'ACTFLGS G HASCAT1X
 F  S FLAGID=$O(PRFARR(FLAGID)) Q:'FLAGID  D  Q:HASCAT1
 . I $P($G(PRFARR(FLAGID,"CATEGORY"))," ")="I" S HASCAT1=1
HASCAT1X ;
 Q
 ;
TRIGRPOP(POPUP,PTDFN) ;Should the flag display pop up upon patient selection
 ; for patient PTDFN?
 ;As of 1/10/06, returns POPUP as:
 ;   1 if pt has any active flags, either Cat I or Cat II
 ;   0 otherwise
 N PRFARR
 S POPUP=$S($$GETACT^DGPFAPI(PTDFN,"PRFARR"):1,1:0)
 Q
 ;
GETFLG(ORY,PTDFN,FLAGID) ;Return detailed flag info for flag FLAGID
 I '$D(^TMP("ORPRF",$J,FLAGID)) Q
 N IX,CNT
 S (IX,CNT)=0
 F  S IX=$O(^TMP("ORPRF",$J,FLAGID,IX)) Q:'IX  D
 . S CNT=CNT+1,ORY(CNT)=$G(^TMP("ORPRF",$J,FLAGID,IX))
 Q
 ;
CLEAR(ORY) ;Clear up the temp global
 K ^TMP("ORPRF",$J)
 Q
 ;
