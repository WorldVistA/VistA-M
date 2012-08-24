DG53688A ;ALB/SCK - Patch DG*5.3*688 Pre-Install Utility Routine ; 5 MAR 2007
 ;;5.3;Registration;**688**;AUG 13, 1993;Build 29
 ;
START ; Entry point for EVENT^IVMPLOG trigger clean-up
 N DGXRF,DGFLD,X,Y,LINE,CNT,DGFILE,DGXNUM,RSLT,MSG
 ;
 ; Set start-notice into KIDS build file
 D BMES^XPDUTL(">> Starting Index cleanup...")
 ; Get the file number for the cross-reference clean-up from the file parameters below
 S LINE=$P($T(FILE+1),";;",2)
 ; If unable to determine file to clean-up, post warning and quit
 I LINE']"" D BMES^XPDUTL(">> Index cleanup canceled, unable to determine file information") Q 
 S DGFILE=$P(LINE,";",2)
 I DGFILE'>0 D BMES^XPDUTL(">> Index cleanup canceled, No File number specified") Q
 ;
 ; Cycle through the cross-references listed in the TEXT section below to remove/cleanup each x-ref.
 ; For each cross-reference, call $$FIND to get the x-ref number from the DD file
 ; if a x-ref number is determined, call the REMOVE procedure to delete the cross-reference
 ; 
 F CNT=1:1 S LINE=$P($T(TEXT+CNT),";;",2) Q:LINE="DONE"  D
 . K DGRXF,DGFLD
 . S DGXRF=$P(LINE,";"),DGFLD=$P(LINE,";",2)
 . S DGXNUM=$$FIND(DGXRF,DGFLD)
 . I DGXNUM>0 D REMOVE(DGXRF,DGFLD,DGXNUM)
 ;
 ;Set the completion notice into the KIDS build file
 D BMES^XPDUTL(">> Index cleanup completed")
 Q
 ;
FIND(DGXRF,DGFLD) ; This procedure will determine the selected x-ref's number from the DD file
 ; and return the number to the calling procedure
 ; Input
 ;         DGXRF - Name of the cross-reference
 ;         DGFLD - DD Field the cross-reference is stored on
 ; Output
 ;         DGNUM - The number of the cross-reference
 ; 
 N XX,DGDONE,DGNUM
 ;
 S XX=0
 F  S XX=$O(^DD(DGFILE,DGFLD,1,XX)) Q:'XX  D  Q:$G(DGDONE)
 . I $P(^DD(DGFILE,DGFLD,1,XX,0),U,2)=DGXRF S DGNUM=XX,DGDONE=1
 ;
 Q $G(DGNUM)
 ;
REMOVE(DGXRF,DGFLD,DGXNUM) ; The procedure will delete the cross-reference from the Data Dictionary
 ; Input
 ;    DGXRF   - Name of the cross-reference
 ;    DGFLD   - DD Field number the cross-reference is stored on
 ;    DGXNUM  - The cross-reference number
 ; 
 N DGOUT,DGERR,DGTEXT,DGX,DGCNT,DGNAME,MSG
 ;
 S DGNAME=$P($G(^DD(DGFILE,DGFLD,0)),U,1)
 S MSG=">> Removing the "_DGXRF_" cross-reference, #"_DGXNUM_", from the "_DGNAME_" field, #"_DGFLD
 D BMES^XPDUTL(MSG)
 ;
 D DELIX^DDMOD(DGFILE,DGFLD,DGXNUM,"","DGOUT","DGERR")
 ;
 ; If the output array is populated, pull the template information from the array and add it to the 
 ; message array to posted into the KIDS results
 I $D(DGOUT) D
 . S DGX=0,DGCNT=100
 . F  S DGX=$O(DGOUT("DIEZ",DGX)) Q:'DGX  D
 . . S DGTEXT(DGCNT)="    Input Template "_$P($G(^DGOUT("DIEZ",DGX)),U,1)_" was recompiled in "_$P($G(^DGOUT("DIEZ",DGX)),U,3)
 . . S DGCNT=DGCNT+1
 ;
 ; If an error occurred, post the error array into the KIDS results for display
 ; otherwise post a success message
 I $D(DGERR) D
 . M DGTEXT=DGERR
 E  D
 . S DGTEXT(1)="   Cross-Reference "_DGXRF_" Successfully removed."
 D MES^XPDUTL(.DGTEXT)
 Q
 ;
FILE ; Data Dictionary containing the cross-references to be cleaned-up
 ;;PATIENT;2
 ;
TEXT ; Cross-reference ID;Field Number
 ;;AENR99101;991.01
 ;;AENR99103;991.03
 ;;AENR01;.01
 ;;AENR03;.03
 ;;AENR02;.02
 ;;AENR09;.09
 ;;DONE
