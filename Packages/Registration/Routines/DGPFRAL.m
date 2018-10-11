DGPFRAL ;ALB/RBS - PRF ACTION NOT LINKED REPORT ; 7/26/05 3:18pm
 ;;5.3;Registration;**554,960**;Aug 13, 1993;Build 22
 ;     Last Edited: SHRPE/SGM - Jun 29,2018 15:14
 ;
 ; ICR# TYPE DESCRIIPTION
 ;----- ---- ----------------------------
 ; 1519 Sup  EN^XUTMDEVQ
 ;10006 Sup  ^DIC
 ;10086 Sup  HOME^%ZIS
 ;
 ;This routine will be used for selecting sort parameters to produce
 ;the DGPF ACTION NOT LINKED REPORT for Patient Record Flags.
 ;
 ; Selection options will provide the ability to report by:
 ;  CATEGORY
 ;  BEGINNING DATE
 ;  ENDING DATE
 ;
 ; The following reporting sort array will be built by user prompts:
 ;  DGSORT("DGCAT") = 1^Category I (National)
 ;                    2^Category II (Local)
 ;                    3^Both
 ;  DGSORT("DGBEG") = BEGINNING DATE  (internal FileMan date)
 ;  DGSORT("DGEND") = ENDING DATE     (internal FileMan date)
 ;  DGSORT("DGFAC") = 1^Local Facility Only
 ;                    2^Other Facilities
 ;                    3^Both
 ;  DGSORT("DGFLG") = "" for all flags
 ;                    Else pointer^name^variable_pointer
 ;  DGSORT("DGSTA") = 0^Inactive
 ;                    1^Active
 ;                    2^Both
 ;
 ;-- no direct entry
 QUIT
 ;
EN ;Entry point
 ;-- user prompts for report selection sorts
 ;   DG*5.3*960 - $$FLAGONE, $$STATUS, $$TYPE 
 ;  Input: none
 ; Output: Report generated using user selected parameters
 ;
 N DGFIRST ;first assignment date
 N DGSEL   ;help text var
 N DGSORT  ;array or report parameters
 N ZTSAVE  ;open array reference of input parameters used by tasking
 N X,Y
 ;
 S DGFIRST=$P(+$O(^DGPF(26.14,"D","")),".")    ;first assignment date
 I 'DGFIRST D  Q
 . D E(">>> No Patient Record Flag Assignments have been found.")
 . Q
 ;-- prompt for selection of a flag category
 I '$$FLAG Q  ;  Returns DGSORT("DGCAT")
 ;
 ;-- prompt for a single flag, else all flags
 I $$FLAGONE<0 Q  ;      DGSORT("DGFLG")
 ;
 ;-- prompt for beginning date
 W ! I '$$DATEBEG Q  ;       DGSORT("DGBEG")
 ;
 ;-- prompt for ending date
 I '$$DATEEND Q  ;       DGSORT("DGEND")
 ;
 ;-- prompt for flag status
 I '$$STATUS Q  ;        DGSORT("DGSTA")
 ;
 ;-- prompt for type of History records
 I '$$TYPE Q  ;          DGSORT("DGFAC")
 ;
 ;-- prompt for device
 S ZTSAVE("DGSORT(")=""
 S X="Assignment Action Not Linked to a Progress Note Report"
 D EN^XUTMDEVQ("START^DGPFRAL1",X,.ZTSAVE)
 D HOME^%ZIS
 Q
 ;
 ;-----------------------  PRIVATE SUBROUTINES  -----------------------
HELP(DGSEL) ;provide extended DIR("?") help text.
 ;
 ;  Input: DGSEL - prompt var for help text word selection
 ; Output: none
 ;
 N X S X=$S(DGSEL=1:"earliest",1:"latest")
 W !,"  Enter "_X_" Assignment Action Date to include in the report."
 W !,"  Please enter a date from the specified date range displayed."
 Q
 ;
E(TX) ;  press ENTER to continue prompt
 I $L(TX) W !?2,TX_$C(7)
 I $$ANSWER^DGPFUT("Enter RETURN to continue","","E")
 Q
 ;
DATEBEG() ;-- prompt for beginning date
 N DGASK,DGDIRA,DGDIRB,DGDIRH,DGDIRO
 S DGDIRA="Select Beginning Date"
 S DGDIRB=""
 S DGDIRH="^D HELP^DGPFRAL(1)"
 S DGDIRO="D^"_DGFIRST_":DT:EX"
 S DGASK=$$ANSWER^DGPFUT(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 I DGASK>0 S DGSORT("DGBEG")=DGASK
 Q DGASK>0
 ;
DATEEND() ;-- prompt for ending date
 N DGASK,DGDIRA,DGDIRB,DGDIRH,DGDIRO
 S DGDIRA="Select Ending Date"
 S DGDIRB=""
 S DGDIRH="^D HELP^DGPFRAL(2)"
 S DGDIRO="D^"_DGSORT("DGBEG")_":DT:EX"
 S DGASK=$$ANSWER^DGPFUT(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 I DGASK>0 S DGSORT("DGEND")=DGASK
 Q DGASK>0
 ;
FLAG() ;-- prompt for selection of a flag category
 ;;1:Category I (National);2:Category II (Local);3:Both (Category I & II)
 N DGASK,DGDIRA,DGDIRB,DGDIRH,DGDIRO
 S DGDIRA="Select Flag Category"
 S DGDIRB=""
 S DGDIRH="Enter one of the category selections to report on"
 S DGDIRO="S^"_$P($T(FLAG+1),";",3,9)
 S DGASK=$$ANSWER^DGPFUT(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 I DGASK>0 S DGSORT("DGCAT")=$$PIECE(DGDIRO,DGASK)
 Q DGASK>0
 ;
 ;--- start code addition by DG*5.3*960
FLAGONE() ;-- prompt for a single flag
 ;;
 ;;Press [ENTER] to run report for all flags
 ;;Select a single flag name for the report
 ;;Enter '^' to exit back to your primary menu
 ;;
 N I,X,Y,Z,CAT,DIC,DTOUT,DUOUT
 S DGSORT("DGFLG")=""
 S CAT=+DGSORT("DGCAT") I CAT'=1,CAT'=2 Q 1
 F I=1:1:5 W !,$TR($T(FLAGONE+I),";"," ")
 S DIC=$P("26.15^26.11",U,CAT)
 S DIC(0)="QAEM"
 S DIC("A")="Select Category "_$E("II",1,CAT)_" Flag: "
 D ^DIC W !
 I Y>0 S DGSORT("DGFLG")=Y_U_(+Y)_";"_$P(DIC,U,2)
 Q Y>0
 ;
STATUS() ;-- prompt for flag status
 N DGASK,DGDIRA,DGDIRB,DGDIRH,DGDIRO
 S DGDIRA="Choose Flag Status"
 S DGDIRB=""
 S DGDIRH="Enter which statuses to report on"
 S DGDIRO="S^1:Inactive;2:Active;3:Both active and inactive"
 S DGASK=$$ANSWER^DGPFUT(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 I DGASK>0 S DGSORT("DGSTA")=$$PIECE(DGDIRO,DGASK)
 Q DGASK>0
 ;
TYPE() ;-- prompt for type of history records
 I +DGSORT("DGCAT")=2 S DGSORT("DGFAC")="1^Local Facility" Q 1
 ;
 N X,DGASK,DGDIRA,DGDIRB,DGDIRH,DGDIRO
 S DGDIRA="Choose Type of History Record"
 S DGDIRB=""
 S DGDIRH="^D TYPEH^DGPFRAL"
 S X="S^1:Actions performed by local facility only;"
 S X=X_"2:Actions performed by other facilities;"
 S X=X_"3:Actions performed by all facilities"
 S DGDIRO=X
 S DGASK=$$ANSWER^DGPFUT(DGDIRA,DGDIRB,DGDIRO,DGDIRH) I DGASK>0 D
 . S X=$P("Local Facility^Other Facilities^All Facilities",U,DGASK)
 . S DGSORT("DGFAC")=DGASK_U_X
 . Q
 Q DGASK>0
 ;
TYPEH ;  provide extended DIR("?") help for facility type
 ;;Enter the type of History Action records to display:
 ;;
 ;;    Local: records created by this VAMC
 ;;    Other: records created by other VAMCs, not this VAMC
 ;;     Both: means to show all history records with no regard
 ;;           for the facility that created them
 ;;
 N I F I=1:1:7 W !,$TR($T(HELPT+I),";"," ")
 Q
 ;
PIECE(DGIR0,DGASK) ;
 N X
 S X=$P(DGIR0,U,2)
 S X=$P(X,";",DGASK)
 S X=$P(X,":",2)
 Q DGASK_U_X
