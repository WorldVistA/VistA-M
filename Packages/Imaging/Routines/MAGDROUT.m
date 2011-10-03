MAGDROUT ;WOIFO/EdM - Copy routine code ; 01/29/2004  11:59
 ;;3.0;IMAGING;**10,36**;13-February-2004
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ; This routine can be used to copy code from the VistA system
 ; to a DICOM Gateway computer.
 ;
 ; The entry point VISTA collects the software from the live system
 ; and stores it in ^MAGD.
 ;
 ; The entry point DICOM takes the software from the global variable
 ; and stores it in the local system.
 Q
 ;
VISTA D SAVE(1)
 Q
 ;
SILENT D SAVE(0)
 Q
 ;
SAVE(VERBOSE) ; Collect active code
 N D0,D1,I,N,R,X
 S VERBOSE=+$G(VERBOSE),N=0
 ;
 ; From Kernel:
 F R="XLFDT","XUSRB1","XUMF333" S R(R)=""
 ; From Radiology 5.0
 F R="RARIC","RARTE2","RAUTL","RAUTL1","RAUTL2","RAUTL20","RAUTL3","RAUTL5","RAXREF" S R(R)=""
 ; From MAS
 F R="VADPT","VADPT0","VADPT1","VADPT2","VADPT3","VADPT30","VADPT31","VADPT32","VADPT4","VADPT5","VADPT6","VADPT60","VADPT61","VADPT62" S R(R)=""
 ; From TIU
 F R="TIULC1","TIULS","TIUSRVPL" S R(R)=""
 ; From Medicine
 S R="MCUIMAG0",R(R)=""
 ;
 ; Store the code from the routines:
 W !!,"Saving source code for Imaging..."
 W:VERBOSE !!,"Now copying:",!
 S R="" F  S R=$O(R(R)) Q:R=""  D
 . N %
 . W:VERBOSE !,R,?15 S N=N+1
 . D NOW^%DTC
 . S D0=$O(^MAGD(2006.79,"B",R,"")) D:'D0
 . . L +^MAGD(2006.79)
 . . S X=$G(^MAGD(2006.79,0)),$P(X,"^",1,2)="DICOM ROUTINE COPY^2006.79"
 . . S D0=$O(^MAGD(2006.79," "),-1)+1
 . . S ^MAGD(2006.79,D0,0)=R_"^"_%,^MAGD(2006.79,"B",R,D0)=""
 . . S $P(X,"^",3)=D0,$P(X,"^",4)=$P(X,"^",4)+1
 . . S ^MAGD(2006.79,0)=X
 . . L -^MAGD(2006.79)
 . . Q
 . S X=$G(^MAGD(2006.79,D0,0)),$P(X,"^",2)=%
 . L +^MAGD(2006.79,D0)
 . K ^MAGD(2006.79,D0,1)
 . S D1=0 F I=1:1 S X=$T(+I^@R) Q:X=""  S D1=D1+1,^MAGD(2006.79,D0,1,D1,0)=X
 . S ^MAGD(2006.79,D0,1,0)="^2006.791^"_D1_"^"_D1
 . L -^MAGD(2006.79,D0)
 . I VERBOSE W $J(D1,4)," line" W:D1'=1 "s"
 . Q
 W !,"Code saved for ",N," routine" W:N'=1 "s" W "."
 Q
 ;
DICOM ; Restore routines in DICOM environment
 ;N D0,D1,L,N,R,S,X
 S R="" F  S R=$O(^MAGD(2006.79,"B",R)) Q:R=""  D
 . S D0="" F  S D0=$O(^MAGD(2006.79,"B",R,D0)) Q:D0=""  D
 . . W !,R,?15
 . . S X="ZR  S D1=0 F  S D1=$O(^MAGD(2006.79,D0,1,D1)),L="""" S:D1 L=^MAGD(2006.79,D0,1,D1,0),N=D1 ZI:L'="""" L I 'D1 ZS "_R_" ZL "_$T(+0)_" Q"
 . . X X
 . . W $J(N,4)," line" W:N'=1 "s"
 . . Q
 . Q
 Q
