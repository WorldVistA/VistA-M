DGPFLMT3 ;ALB/RBS - PRF TRANSMIT VIEW MESSAGE LM SCREEN ; 4/27/05 1:05pm
 ;;5.3;Registration;**650**;Aug 13, 1993;Build 3
 ;
 ;no direct entry
 QUIT
 ;
 ;
EN(DGDFN,DGPFIEN) ;Entry point of DGPF TRANSMIT VIEW MESSAGE list template.
 ;
 ;  Input:
 ;      DGDFN - ien of PATIENT (#2) file
 ;    DGPFIEN - ien of PRF HL7 TRANSMISSION LOG (#26.17) record
 ;
 ; Output: None
 ;
 ;quit if required input parameters not defined
 Q:'$G(DGDFN)
 Q:'$G(DGPFIEN)
 ;
 ;display wait msg to user
 D WAIT^DICD
 ;
 ;invoke list template
 D EN^VALM("DGPF TRANSMIT VIEW MESSAGE")
 Q
 ;
 ;
HDR ;Header Code - build patient header detail area
 D HDRBLD(DGDFN,.VALMHDR)
 Q
 ;
 ;
HDRBLD(DGDFN,DGPFHDR) ;This procedure builds the List Manager header.
 ;
 ; Supported DBIA #2701: $$GETICN^MPIF001
 ;   The supported DBIA is used to access the MPI functions to
 ;   retrieve the ICN.
 ;
 ;  Input:
 ;      DGDFN - internal entry number of PATIENT (#2) file
 ;    DGPFHDR - header array passed by reference
 ;
 ; Output:
 ;      DGPFHDR - header array (VALMHDR)
 ;
 N DGICN    ;national integrated control number
 N DGPFPAT  ;patient identifying info array
 ;
 ;get patient identifying info
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
 Q
 ;
 ;
INIT ;Init variables and list array
 D BLD
 Q
 ;
 ;
BLD ;Build error message detail screen (list area)
 D CLEAN^VALM10
 K VALMHDR
 K ^TMP("DGPFVDET",$J)
 ;
 ;init number of lines in list
 S VALMCNT=0
 ;
 ;build header
 D HDR
 ;
 ;build list area for error message detail
 D EN^DGPFLMT4("DGPFVDET",DGPFIEN,.VALMCNT)
 ;
 I 'VALMCNT D
 . D SET^DGPFLMT1("DGPFVDET",1,"",1,,,.VALMCNT)
 . D SET^DGPFLMT1("DGPFVDET",2,"...Sorry, no PRF assignment record details were found to display.",4,$G(IOINHI),$G(IOINORM),.VALMCNT)
 ;
 Q
 ;
 ;
HELP ;Help Code
 N X
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
 ;
EXIT ;Exit Code
 D CLEAN^VALM10
 D CLEAR^VALM1
 K ^TMP("DGPFVDET",$J)
 Q
 ;
 ;
EXPND ;Expand Code
 Q
