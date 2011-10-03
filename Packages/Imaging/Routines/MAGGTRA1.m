MAGGTRA1 ;WOIFO/GEK - RPC Call to list Patient's Rad/Nuc Exams, Reports ; [ 11/08/2001 17:18 ]
 ;;3.0;IMAGING;;Mar 01, 2002
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
 Q
LIST(MAGRY,DATA) ; RPC Call MAGGRADLIST
 ;MAGRY - the return array of patient's exams.
 ;DATA   - DFN ^ begining date ^ end date ^ number to return
 ;  (only DFN is being sent for now. later we'll enable date 
 ;                                           ranges and/or counts ) 
 ;
 IF $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 E  S X="ERRA^MAGGTERR",@^%ZOSF("TRAP")
 ;
 N X,Y,Z,I,J,K,MAGNAME,MAGDFN,MAGCNT,MAGBDT,MAGEDT,MAGEXN
 S MAGDFN=+DATA
 S MAGNAME=$P($G(^DPT(MAGDFN,0)),U)
 I MAGNAME="" S MAGRY(0)="0^INVALID Patient ID" Q
 ; We have to account for old Wrkstation code that was returning a 
 ;  1 as second piece.
 I $P(DATA,U,2)=1 S $P(DATA,U,2)=""
 ; Set default Begin,End dates and number to return
 S MAGBDT=$S($P(DATA,U,2):$P(DATA,U,2),1:"1070101")
 S MAGEDT=$S($P(DATA,U,3):$P(DATA,U,3),1:$$DT^XLFDT)
 S MAGEXN=$S($P(DATA,U,4):$P(DATA,U,4),1:200)
 S MAGRY(0)="0^Compiling list of Radiology Exams..."
 ;
 D EN1^RAO7PC1(MAGDFN,MAGBDT,MAGEDT,MAGEXN)
 I '$D(^TMP($J,"RAE1")) S MAGRY(0)="0^No Radiology Exams for "_MAGNAME Q
 ;
 ; we'll return MAGRY(0) = return count^message 
 ;              MAGRY(1)=column heading^column heading^column h.....
 ;              MAGRY(2..n)=info from exam.
 D CONVERT
 S MAGRY(0)=MAGCNT-1_"^Radiology Exams: "_MAGNAME
 S MAGRY(1)="#^Day-Case^Procedure^Exam Date^Exam status  /  Report status^Imaging Loc"
 Q
CONVERT ; Convert the ^TMP($J,"RAE1",MAGDFN  to our output array.
 N XRPT
 S MAGCNT=1
 S I=0 F  S I=$O(^TMP($J,"RAE1",MAGDFN,I)) Q:'I  D
 . S MAGCNT=MAGCNT+1
 . S J=^TMP($J,"RAE1",MAGDFN,I) ; Changed to full reference /gek
 . S X=9999999.9999-$P(I,"-"),X=$E(X,4,7)_$E(X,2,3)
 . ; Y2K not needed on day-case - Rad uses as string variable.
 . ;   1 #         2  day-case       3  desc
 . S Z=MAGCNT-1_U_X_"-"_$P(J,"^",2)_U_$P(J,U)_U
 . S X=9999999.9999-$P(I,"-")
 . ;    4  date
 . S Z=Z_$E(X,4,5)_"/"_$E(X,6,7)_"/"_(1700+$E(X,1,3))_U
 . ;    5 EXAM status  / Report status
 . S Z=Z_$P($P(J,U,6),"~",2)_"  /  "_$P(J,U,3)_U
 . S K=$$FMTE^XLFDT(X,"1P")
 . ;   6 image loc  7 dfn    8 invrs dt     9 case # 10 11 12 output date
 . S Z=Z_$P(J,U,7)_U_MAGDFN_U_$P(I,"-")_U_$P(I,"-",2)_U_U_U_K_U
 . ;   13 intdt  14 RACN        16  rarpt
 . S Z=Z_X_U_$P(J,U,2)_U_U_$P(J,U,5)_U_U
 . S XRPT=$P(J,U,5) I XRPT I $P($G(^RARPT(XRPT,0)),U,2)'=MAGDFN D
 . . S $P(Z,U,16)=XRPT_"PMRAD"
 . . S $P(Z,U,5)="Patient Mismatch. Radiology Files"
 . ; If this report has images, we'll display "(I)"
 . I $O(^RARPT(+$P(J,U,5),2005,0)) S $P(Z,U,5)=$P(Z,U,5)_" (I)"
 . ;
 . S MAGRY(MAGCNT)=Z
 Q
