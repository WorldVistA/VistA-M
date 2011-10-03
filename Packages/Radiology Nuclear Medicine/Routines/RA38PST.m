RA38PST ;HOIFO/SWM-Post install ;6/2/03  10:30
 ;;5.0;Radiology/Nuclear Medicine;**38**;Mar 16, 1998
 ; This is the post-install routine for patch RA*5.0*38
 ; and patch RA*5.0*38 is part of the combined build CSV_PS_1_0.KID
 ;
 ; This routine may be deleted after CSV_PS_1_0.KID is installed.
 ;
 ; Silent recompile of input template RA REGISTER
 I '$D(XPDNM)#2 D EN^DDIOL("This entry point must be called from the KIDS installation -- Nothing Done.",,"!!,$C(7)") Q
 N X,Y,DMAX,RATXT,RAITMPL,RAERR,I,N,RABAD
 S DMAX=$$ROUSIZE^DILF
 S X="RACTRG" ; compile routine name
 S RAITMPL="RA REGISTER" ; input template name
 S Y=$$FIND1^DIC(.402,,"BX",RAITMPL,,,"RAERR")
 I 'Y D  S RABAD=1
 . S RATXT(1)=" "
 . S RATXT(2)="** Cannot find input template "_RAITMPL_" **"
 . S RATXT(6)=" "
 . D MES^XPDUTL(.RATXT)
 I $D(RAERR) D  S RABAD=1
 . K RATXT
 . S RATXT(1)=" "
 . S RATXT(2)="** One or more error codes were return: **"
 . S N=2
 . S I=0 F I=1:1:17 S I=$O(RAERR("DIERR","E",I)) Q:'I  S N=N+1,RATXT(N)="     "_I_" -- "_$G(RAERR("DIERR",1,"TEXT",1))
 . S N=N+1,RATXT(N)=" "
 . D MES^XPDUTL(.RATXT)
 I $D(RABAD) D  Q
 . K RATXT
 . S RATXT(1)="** Recompilation of "_RAITMPL_" is not done. **"
 . S RATXT(2)=" "
 . S RATXT(3)="** Please log a NOIS for the Radiology module. **"
 . S RATXT(4)=" "
 . D MES^XPDUTL(.RATXT)
 S RATXT="          Compiling input template "_RAITMPL_"."
 D BMES^XPDUTL(RATXT)
 D EN^DIEZ
 S RATXT="          Finished compiling input template "_RAITMPL_"."
 D BMES^XPDUTL(RATXT)
 Q
