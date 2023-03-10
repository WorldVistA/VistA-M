GMTS2 ;SLC/SBW - Health Summary Driver Cont. ; 02/27/2019
 ;;2.7;Health Summary;**2,58,62,122**;Oct 20, 1995;Build 183
 ;
TDISBLD ; Temporarily Disabled Components
 D CKP^GMTSUP Q:$D(GMTSQIT)  W "Temporarily disabled",!
 I GMOOTXT]"" D CKP^GMTSUP Q:$D(GMTSQIT)  W GMOOTXT,!
 Q
PDISBLD ; Permanently Disabled Components
 D CKP^GMTSUP Q:$D(GMTSQIT)  W "Permanently disabled",!
 I GMOOTXT]"" D CKP^GMTSUP Q:$D(GMTSQIT)  W GMOOTXT,!
 Q
NOMATCH ; User doesn't hold Security Key
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W "This component is locked with security key "_GMTSLOCK_".",!
 Q
NOSELECT ; No Selection Items
 ;   Handles cases where components that require
 ;   selection items have no selection items defined.
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W "No selection items chosen for this component.",!
 Q
NODATA ; No Data
 ;  This will display "No Data Available" for commponents
 ;  components that retrieve no data.
 I $D(GMTSQIT),(GMTSQIT="") Q
 N PRINTNAME,SELNAME
 Q:GMTSWRIT=0  I $G(GMSUPRES)="Y" K:$D(GMTSOBJ) GMTSEG(+($G(GMTSEGN)))
 I $E(IOST,1)'="C" Q:$G(GMSUPRES)="Y"
 I GMSEL]"" D GETSEL,DISPSEL Q
 D CKP^GMTSUP Q:$D(GMTSQIT)  W:'$D(GMTSOBJ) !
 D CKP^GMTSUP Q:$D(GMTSQIT)  W "  No data available",!
 Q
GETSEL ; Get Selection Items
 N GMX,GMI,GMDA,GMFROOT,GMROOT,GMNODE
 S GMFROOT=$G(GMTSEG(GMTSEGN,GMSEL,0))
 Q:GMFROOT=""
 S (GMX,GMI)=0
 F  S GMI=$O(GMTSEG(GMTSEGN,GMSEL,GMI)) Q:GMI'>0  D
 . S GMDA=$G(GMTSEG(GMTSEGN,GMSEL,GMI))
 . S GMROOT=GMFROOT_GMDA_",0)"
 . S GMNODE=$G(@GMROOT)
 . S GMX=GMX+1,SELNAME(GMX)=$P(GMNODE,U)
 . I GMSEL=9999999.09 S PRINTNAME(GMX)=$P($G(^AUTTEDT(GMDA,0)),U,4)
 . I GMSEL=9999999.15 S PRINTNAME(GMX)=$P($G(^AUTTEXAM(GMDA,200)),U,1)
 . I GMSEL=9999999.64 S PRINTNAME(GMX)=$P($G(^AUTTHF(GMDA,200)),U,1)
 . I $G(PRINTNAME(GMX))="" S PRINTNAME(GMX)=SELNAME(GMX)
 Q
DISPSEL ; Display selection items
 N GMI,GMX
 D CKP^GMTSUP Q:$D(GMTSQIT)  W "No data available for: "
 S (GMI,GMX)=0
 F  S GMI=$O(SELNAME(GMI)) Q:GMI'>0  D
 . S GMX=GMX+1
 . I GMX=1,($X+$L(PRINTNAME(GMI))>77) W !
 . W:GMX>1 !
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W PRINTNAME(GMI)
 W !
 Q
