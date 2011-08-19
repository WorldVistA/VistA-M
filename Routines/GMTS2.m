GMTS2 ;SLC/SBW - Health Summary Driver Cont. ; 02/11/2003
 ;;2.7;Health Summary;**2,58,62**;Oct 20, 1995
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
 N SELNAME I $D(GMTSQIT),(GMTSQIT="") Q
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
 . I GMDA]"",GMROOT]"" S GMX=GMX+1,SELNAME(GMX)=$P(GMNODE,U)
 Q
DISPSEL ; Display selection items
 N GMI,GMX
 D CKP^GMTSUP Q:$D(GMTSQIT)  W "  No data available for "
 S (GMI,GMX)=0
 F  S GMI=$O(SELNAME(GMI)) Q:GMI'>0  D
 . S GMX=GMX+1
 . W:GMX>1 "; "
 . W:(77)'>($X+$L(SELNAME(GMI))) !
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W SELNAME(GMI)
 W !
 Q
