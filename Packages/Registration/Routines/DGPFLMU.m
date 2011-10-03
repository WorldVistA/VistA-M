DGPFLMU ;ALB/KCL - PRF ASSIGNMENT LISTMAN UTILITIES ; 3/06/06 3:39pm
 ;;5.3;Registration;**425,650**;Aug 13, 1993;Build 3
 ;
 ;no direct entry
 QUIT
 ;
BLDHDR(DGDFN,DGPFHDR) ;This procedure builds the VALMHDR array to display the ListMan header.
 ; 
 ; Supported DBIA #2701: The supported DBIA is used to access the
 ;                       MPI functions to retrieve the ICN and CMOR.
 ;
 ;  Input:
 ;     DGDFN - internal entry number of PATIENT (#2) file
 ;   DGPFHDR - header array passed by reference
 ;
 ; Output:
 ;   DGPFHDR - header array
 ;
 N DGCMOR   ;CIRN Master of Record
 N DGICN    ;Integrated Control Number
 N DGPFPAT  ;Patient identifying info
 ;
 ;retrieve patient identifying info
 I $$GETPAT^DGPFUT2(DGDFN,.DGPFPAT)
 ;
 ;set 1st line of header
 S DGPFHDR(1)="Patient: "_$G(DGPFPAT("NAME"))_" "
 S DGPFHDR(1)=$$SETSTR^VALM1("("_$G(DGPFPAT("SSN"))_")",DGPFHDR(1),$L(DGPFHDR(1))+1,80)
 S DGPFHDR(1)=$$SETSTR^VALM1("DOB: "_$$FDATE^VALM1($G(DGPFPAT("DOB"))),DGPFHDR(1),54,80)
 ;
 ;set 2nd line of header
 S DGICN=$$GETICN^MPIF001(DGDFN)
 S DGICN=$S(DGICN<0:"No ICN for patient",1:DGICN)
 S DGPFHDR(2)="    ICN: "_DGICN
 S DGCMOR=$$CMOR2^MPIF001(DGDFN)
 S DGCMOR=$S(DGCMOR<0:$P(DGCMOR,U,2),1:DGCMOR)
 S DGCMOR="CMOR: "_DGCMOR
 S DGPFHDR(2)=$$SETSTR^VALM1(DGCMOR,DGPFHDR(2),53,27)
 Q
 ;
 ;
BLDLIST(DGDFN) ;This procedure will build list of flag assignments for a patient for display in ListMan.
 ;
 ;  Input:
 ;   DGDFN - internal entry number of PATIENT (#2) file
 ;
 ; Output: None
 ;
 N DGIEN  ;ien of assignment
 N DGIENS ;array of assignment ien's
 N DGPFA  ;assignment data array
 N DGPFAH ;assignment history data array
 N DGPTR  ;pointer to last assignment history record
 N DGTXT  ;msg text if no assignments for patient
 ;
 ;kill data and video cntrl arrays associated with active list
 D CLEAN^VALM10
 ;
 ;if no assignments, display msg, quit
 K DGIENS
 I '$$GETALL^DGPFAA(DGDFN,.DGIENS) D  Q
 . S DGTXT="   Selected patient has no record flag assignments on file."
 . D SET^VALM10(1,"")
 . D SET^VALM10(2,DGTXT)
 . D CNTRL^VALM10(2,4,$L(DGTXT),$G(IOINHI),$G(IOINORM))
 . S VALMCNT=2
 ;
 ;if assignments, get data and build list
 S DGIEN=0,VALMCNT=0
 F  S DGIEN=$O(DGIENS(DGIEN)) Q:'DGIEN  D
 . ;-get assignment
 . K DGPFA
 . Q:'$$GETASGN^DGPFAA(DGIEN,.DGPFA)
 . ;-get initial assignment history
 . K DGPFAH
 . Q:'$$GETHIST^DGPFAAH($$GETFIRST^DGPFAAH(DGIEN),.DGPFAH)
 . ;-get 'initial assignment' date
 . S DGPFAH("INITASSIGN")=$G(DGPFAH("ASSIGNDT"))
 . Q:'DGPFAH("INITASSIGN")
 . ;-increment line number count
 . S VALMCNT=VALMCNT+1
 . ;-build list
 . D BLDLIN(VALMCNT,.DGPFA,.DGPFAH,DGIEN)
 ;
 Q
 ;
 ;
BLDLIN(DGLNUM,DGPFA,DGPFAH,DGIEN) ;This procedure will build and setup ListMan lines and array.
 ;
 ;  Input:
 ;    DGLNUM - line number
 ;     DGPFA - array containing assignment, passed by reference
 ;    DGPFAH - array containing assignment history, passed by reference 
 ;     DGIEN - internal entry number of assignment
 ;
 ; Output: None
 ;
 N DGTXT      ;used as temporary text field
 N DGLINE     ;string to insert field data
 S DGLINE=""  ;init
 S DGLINE=$$SETSTR^VALM1(DGLNUM,DGLINE,1,3)
 ;
 ;flag name
 S DGTXT=$P($G(DGPFA("FLAG")),U,2)
 S DGLINE=$$SETFLD^VALM1(DGTXT,DGLINE,"FLAG")
 ;
 ;initial assignment date
 S DGTXT=$$FDATE^VALM1(+$G(DGPFAH("INITASSIGN")))
 S DGLINE=$$SETFLD^VALM1(DGTXT,DGLINE,"ASSIGN DATE")
 ;
 ;review date
 S DGTXT=+$G(DGPFA("REVIEWDT"))
 S DGTXT=$S(DGTXT:$$FDATE^VALM1(DGTXT),1:"N/A")
 S DGLINE=$$SETFLD^VALM1(DGTXT,DGLINE,"REVIEW DATE")
 ;
 ;status/active (yes/no)
 S DGTXT=$P($G(DGPFA("STATUS")),U)
 S DGTXT=$S(DGTXT=1:"YES",1:"NO")
 S DGLINE=$$SETFLD^VALM1(DGTXT,DGLINE,"STATUS")
 ;
 ;local (yes/no)
 S DGTXT="NO"
 I $P($G(DGPFA("FLAG")),U)["26.11" S DGTXT="YES"
 S DGLINE=$$SETFLD^VALM1(DGTXT,DGLINE,"LOCAL")
 ;
 ;owner site
 S DGTXT=$P($G(DGPFA("OWNER")),U,2)
 S DGLINE=$$SETFLD^VALM1(DGTXT,DGLINE,"OWNER SITE")
 ;
 ;construct initial list array
 D SET^VALM10(DGLNUM,DGLINE,DGLNUM)
 ;
 ;set assignment ien and pt DFN into index
 S @VALMAR@("IDX",DGLNUM,DGLNUM)=$G(DGIEN)_U_+$G(DGPFA("DFN"))
 ;
 Q
