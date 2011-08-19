XDRDOC1 ;IHS/OHPRD/JCM - DOCUMENTATION OF KERNEL ROUTINES ;07/06/93  16:46
 ;;7.3;TOOLKIT;;Apr 25, 1995
 ;
XDRDQUE ; START AND STOP DUPLICATE CHECKER SEARCH
 ;
 ; Called by: XDRDCOMP,XDRDLIST,XDRDSCOR,XDRMADD if XDRFL or
 ;            XDRFL not defined
 ;
 ; Calls : %ZTLOAD,DIC,DIE,Y^DIQ,DIR,CHECK^XDRU1
 ;
 ;FILE
 ;** I would suggest some sort of screen to allow users to select only
 ;** files that they have access for
 ;
 ;CHECK
 ; Checks the Duplicate Resolution file to make sure that all
 ; the information for the Duplicate Resolution software to
 ; run is present.  Checks for existance of Candidate Collection
 ; routine, Potential Duplicate Threshold, and that there are
 ; Duplicate Tests entered in the Duplicate Tests multiple.
 ;
XDRDSCOR ; SETS SCORES FOR DUPLICATE CHECKING ALGORITHM
 ;
 ; Input Variables: XDRFL,XDRD(0)
 ;
 ; Output Variables - XDRDSCOR(,XDRDTEST(
 ;
 ; Called by: XDRDCOMP,XDRDMAINI,XDRDUP,XDRMADD
 ;
 ; Calls: FILE^XDRDQUE,XDREMSG
 ;
XDRDSTAT ; DISPLAY STATUS OF SEARCH
 ;
 ; Input variables: XDRFL
 ;
 ; Calls: DIC,Y^DIQ
 ;
XDRDUP ; CHECKS TWO RECORDS TO SEE IF DUPLICATES
 ;
 ; Input variables: XDRFL,XDRDPDA
 ;
 ; Called by: XDRDADJ,XDRDCOMP,XDRDMAIN,XDRMADD
 ;
 ; Calls: EN^DIQ1,XDRDADD,XDRDSCOR,XDREMSG
 ;
XDREMSG ; ERROR MESSAGE PROCESSOR
 ;
 ; This routine is responsible for either sending error messages to
 ; the operator or if the calling routine is running in background
 ; it will send a bulletin to the people in the Duplicate Manager
 ; mail group if one is defined.
 ;
 ; The following meanings of XDRERR=
 ;
 ; 1=      The Candidate Collection Routine is Undefined
 ; 2=      The Candidate Collection Routine is not present
 ; 3=      The Potential Duplicate Threshold is Undefined
 ; 4=      There are no Duplicate Tests entered for this Duplicate
 ;         Resolution entry
 ; 5=      The Global root node in DIC is undefined
 ; 6=      No entry in Duplicate Resolution file for this file
 ; 7=      The From and To Record are undefined
 ; 8=      The test routine is not present
 ; 9=      The routine defined as the Pre-Merge routine is not present
 ; 10=     The routine defined as the Post-Merge routine is not present
 ; 11=     The routine defined as the Verified Msg routine is
 ;         not present
 ; 12=     The routine defined as the Merged Msg routine is not present
 ; 13=     Non-Interactive Merge style not allowed with Dinum Files
 ;         for Merge entries
 ;
 ; Input Variables: XDRERR
 ;
 ; Called by: XDRDMAIN,XDRDSCOR,XDRDUP,XDRMAINI,XDRU1
 ;
 ; Calls: XMB
