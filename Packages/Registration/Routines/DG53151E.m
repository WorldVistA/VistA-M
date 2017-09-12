DG53151E ;ALB/ABR - ENVIRONMENT CHECK ROUTINE;20-JAN-1998
 ;;5.3;Registration;**151**;Aug 13, 1993
 ;
EN ;Main entry point for patch DG*5.3*151 environment check routine
 ;
 ;Input  : All variables set by KIDS
 ;Output : Variables required by KIDS to denote success or failure
 ;         of environment check (XPDQUIT and XPDABORT)
 ;
 ;
 ;Check for installation of DG*5.3*106 - required for install
 I $T(+2^VAFHLPV1)'["106" D
 .W !!,"      *** Required element missing ***"
 .W !,"      Installation of this patch requires patch DG*5.3*106"
 .W !
 .S XPDABORT=2
 ;Check for installation of DG*5.3*75 - required for install
 I $T(+2^DGSTAT)'["75" D
 .W !!,"      *** Required element missing ***"
 .W !,"      Installation of this patch requires patch DG*5.3*75"
 .W !
 .S XPDABORT=2
 ;Check for installation of DG*5.3*24 - required for install
 I $T(+2^DGREGE)'["24" D
 .W !!,"      *** Required element missing ***"
 .W !,"      Installation of this patch requires patch DG*5.3*24"
 .W !
 .S XPDABORT=2
 Q
UPDATE ; Post-install for patch DG*5.3*151 
 ;  Updates package file for patch DG*5.3*106
 N PATCH,PKG,SPTC,SPTCN,SPKG,SPKGN,VER,VERN,UPD
 ; find associated patch SD*5.3*70 that brought in DG*5.3*106
 ; use info to update patch application history with date/time
 ; of install of SD*5.3*70 (same as DG*5.3*106)
 ;  
 ; If not found, use today, w/ Mailman as user.
 ;
 S SPTC="70 SEQ #67",SPKG="SCHEDULING",VER="5.3"
 S SPKGN=$O(^DIC(9.4,"B",SPKG,0)) I SPKGN D
 . S VERN=$O(^DIC(9.4,SPKGN,22,"B",VER,0))
 . Q:'VERN
 . S SPTCN=+$O(^DIC(9.4,SPKGN,22,VERN,"PAH","B",SPTC,0))
 . S PATCH=$G(^DIC(9.4,SPKGN,22,VERN,"PAH",SPTCN,0))
 S PATCH=$S($G(PATCH):"106 SEQ #101^"_$P(PATCH,U,2,3),1:"106 SEQ #101^"_DT_"^.05")
 S PKG=$O(^DIC(9.4,"B","REGISTRATION",0)) Q:'PKG
 S UPD=$$PKGPAT^XPDIP(PKG,5.3,.PATCH)
 Q
