MAGXCVX ;WOIFO/SEB,MLH - Image File Conversion Export ; 24 Mar 2005  11:00 AM
 ;;3.0;IMAGING;**17,25,31**;Mar 31, 2005
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
 ;
 ; Entry point for the Export Results option (MAG IMAGE INDEX EXPORT)
EXPORT N FNAME,COUNT,MAGDATA,MAGFLD,MAGID,CT,DR,DIE,DA,%ZIS,CLEAR
 N MAGIEN,GRPIEN,CHILD1,UTYPE,MAGTMP,MAGVALS,FLDNUM,START,END
 N MAGNOD ; --- nodes of the current image record, for fast lookup
 N I ; -------- scratch loop index
 N INT ; ------ internal code value
 N EXT ; ------ array for return of external code value from VAL^DIE
 ;
 S COUNT=0
EX1 R !!,"Please enter the filename of the output file: ",FNAME:DTIME
 I $E(FNAME)="?" D  G EX1
 . W !!,"Enter a file name, including the path, of the file to export."
 . Q
 I $TR(FNAME,"^")="" W !!,"No filename entered. Goodbye!" Q
 S %ZIS="",%ZIS("HFSNAME")=FNAME,%ZIS("HFSMODE")="W",IOP="HFS"
 S X="ERR^"_$T(+0),@^%ZOSF("TRAP")
 D ^%ZIS I POP=1 W !,"Unable to open "_FNAME_" for output. Please try again." G EX1
 W ! D BOUNDS^MAGXCVP(.START,.END) I START="^" S COUNT=-1 G ERR
 S START=+$G(START),END=+$G(END) I END=0 S END=+$P($G(^MAG(2005,0)),U,3)
 S MAGIEN=START-1 I MAGIEN=-1 S MAGIEN=0
 W ! U IO W "Image IEN",$C(9),"Short Description",$C(9),"Procedure",$C(9),"Parent Data File",$C(9)
 W "Document Category",$C(9),"Object Type",$C(9),"Save By Group",$C(9)
 W "Package",$C(9),"Class",$C(9),"Type",$C(9),"Specialty",$C(9),"Proc/Event",$C(9),"Origin",!
 F CT=0:1 S MAGIEN=$O(^XTMP("MAGIXCVGEN",MAGIEN)) Q:MAGIEN>END!(+MAGIEN'=MAGIEN)  D
 . U IO(0) W:CT#100=0 MAGIEN W:CT#10=0 "."
 . S GRPIEN=$P($G(^MAG(2005,MAGIEN,0)),U,10) I GRPIEN="" S GRPIEN=MAGIEN
 . F I=0,2,100 S MAGNOD(I)=$G(^MAG(2005,GRPIEN,I))
 . K MAGVALS,UTYPE
 . ; get internal values
 . S MAGVALS(3,"I")=$P(MAGNOD(0),U,6) ; object type
 . S CHILD1=$P($G(^MAG(2005,GRPIEN,1,1,0)),U)
 . I CHILD1]"" S MAGVALS(3,"I")=$P($G(^MAG(2005,CHILD1,0)),U,6)
 . S MAGVALS(6,"I")=$P(MAGNOD(0),U,8) ; procedure
 . S MAGVALS(8,"I")=$P(MAGNOD(2),U,2) ; image save by
 . S MAGVALS(10,"I")=$P(MAGNOD(2),U,4) ; short description
 . S MAGVALS(16,"I")=$P(MAGNOD(2),U,6) ; parent data file
 . S MAGVALS(100,"I")=$P(MAGNOD(100),U) ; descriptive category
 . ; get external values
 . I MAGVALS(3,"I") D
 . . S MAGVALS(3,"E")=$P($G(^MAG(2005.02,MAGVALS(3,"I"),0)),U)
 . . Q
 . S MAGVALS(6,"E")=MAGVALS(6,"I")
 . I MAGVALS(8,"I") S UTYPE=$$GET1^DIQ(200,MAGVALS(8,"I")_",",29,"E")
 . S MAGVALS(10,"E")=MAGVALS(10,"I")
 . I MAGVALS(16,"I") D
 . . S MAGVALS(16,"E")=$P($G(^MAG(2005.03,MAGVALS(16,"I"),0)),U)
 . . Q
 . I MAGVALS(100,"I") D
 . . S MAGVALS(100,"E")=$P($G(^MAG(2005.81,MAGVALS(100,"I"),0)),U)
 . . Q
 . U IO W MAGIEN F FLDNUM=10,6,16,100,3 W $C(9),$G(MAGVALS(FLDNUM,"E"))
 . W $C(9),$G(UTYPE)
 . S MAGDATA=$G(^XTMP("MAGIXCVGEN",MAGIEN))
 . W $C(9),$P(MAGDATA,U,2)
 . W $C(9) I $P(MAGDATA,U,3)'="" W $P(MAGDATA,U,3),"-",$P($G(^MAG(2005.82,$P(MAGDATA,U,3),0)),U)
 . W $C(9) I $P(MAGDATA,U,4)'="" W $P(MAGDATA,U,4),"-",$P($G(^MAG(2005.83,$P(MAGDATA,U,4),0)),U)
 . W $C(9) I $P(MAGDATA,U,6)'="" W $P(MAGDATA,U,6),"-",$P($G(^MAG(2005.84,$P(MAGDATA,U,6),0)),U)
 . W $C(9) I $P(MAGDATA,U,5)'="" W $P(MAGDATA,U,5),"-",$P($G(^MAG(2005.85,$P(MAGDATA,U,5),0)),U)
 . W $C(9) I $P(MAGDATA,U,7)'="" D  ; convert set-of-codes to external value
 . . S INT=$P(MAGDATA,U,7)
 . . D VAL^DIE(2005,"",45,"E",INT,.EXT)
 . . W INT_"-"_$G(EXT(0))
 . . Q
 . W !
 . Q
 U IO W "***end***",!
 U IO(0)
 D ^%ZISC G EXDONE
 ;
ERR ; Reached when an error (including end-of-file) occurs.
 D ^%ZISC
EXDONE S COUNT=COUNT+1
 I COUNT=1 W !,"Done exporting generated index values."
 Q
