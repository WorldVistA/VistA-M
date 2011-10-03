DGPFRPI ;ALB/RBS - PRF PRINCIPAL INVEST REPORT ; 7/26/05 3:39pm
 ;;5.3;Registration;**554,730**;Aug 13, 1993;Build 2
 ;
 ;This routine will be used for selecting sort parameters to produce
 ;the DGPF PRINCIPAL INVEST REPORT for Patient Record Flags.
 ;
 ; Selection options will provide the ability to report by:
 ;  PRINCIPAL INVESTIGATOR
 ;  CATEGORY
 ;  STATUS (ASSIGNMENTS)
 ;  BEGINNING DATE
 ;  ENDING DATE
 ;
 ; The following reporting sort array will be built by user prompts:
 ;  DGSORT("DGPRINC") = pointer to NEW PERSON (#200) file^Person Name
 ;                      or
 ;                    = "A" = All Principal Investigator's
 ;  DGSORT("DGCAT") = CATEGORY
 ;                      2^Category II (Local)
 ;  DGSORT("DGSTATUS") = Assignment Status to report on
 ;                         1^Active
 ;                         2^Inactive
 ;                         3^Both
 ;  DGSORT("DGBEG") = BEGINNING DATE  (internal FileMan date)
 ;  DGSORT("DGEND") = ENDING DATE     (internal FileMan date)
 ;
 ;-- no direct entry
 QUIT
 ;
EN ;Entry point
 ;-- user prompts for report selection sorts
 ;  Input: none
 ; Output: Report generated using user selected parameters
 ;
 N DGABORT ;abort flag
 N DGASK   ;return value from $$ANSWER^DGPFUT call
 N DGDIRA  ;DGDIRA - DIR("A") string
 N DGDIRB  ;DGDIRB - DIR("B") string
 N DGDIRH  ;DGDIRH - DIR("?") string
 N DGDIRO  ;DGDIR0 - DIR(0) string
 N DGDIRS  ;DGDIRS - DIR("S") string
 N DGFIRST ;first assignment date
 N DGQ     ;quit flag
 N DGSEL   ;help text var
 N DGSORT  ;array or report parameters
 N ZTSAVE  ;open array reference of input parameters used by tasking
 ;
 ;check for database
 S DGFIRST=$P(+$O(^DGPF(26.14,"D","")),".")    ;first assignment date
 I 'DGFIRST D  Q
 . W !?2,">>> No Patient Record Flag Assignments have been found.",*7
 . I $$ANSWER^DGPFUT("Enter RETURN to continue","","E")  ;pause
 ;
 ;-- prompt for selection of an approved by person
 S DGDIRA="Select to report on a (S)ingle Principal Investigator or (A)ll"
 S DGDIRB="Single"
 S DGDIRH="Enter one of the selections to report on"
 S DGDIRO="S^S:Single Principal Investigator;A:All Principal Investigators"
 S DGASK=$$ANSWER^DGPFUT(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 Q:DGASK=-1!(DGASK=0)
 ;
 S:DGASK="A" DGSORT("DGPRINC")="A"
 ;
 D:DGASK="S"
 .S (DGQ,DGABORT)=0
 .N DIC,D,X,Y,I
 .S DIC="^DGPF(26.11,"
 .S DIC(0)="AEQZ"
 .S D="C"
 .S DIC("A")="Select Principal Investigator's name: "
 .D IX^DIC
 .I Y<0 S DGABORT=1 Q
 .S I=0
 .F  S I=$O(^DGPF(26.11,+Y,2,"B",I)) Q:'I  I $P(^VA(200,I,0),U)[X Q
 .I '$G(I) S DGABORT=1 Q
 .S DGSORT("DGPRINC")=I_U_$$EXTERNAL^DILFD(26.112,.01,"F",I)
 .S DGQ=1
 ;
 Q:$G(DGABORT)
 ;
 ;-- prompt for selection of a flag category
 ; only Cat II (Local) file (#26.11) has Research Flags
 S DGSORT("DGCAT")=2_U_"Category II (Local)"
 ;
 ;-- prompt for selection of the assignment status to report on
 S DGDIRA="Select Assignment Status to report on"
 S DGDIRB="Both"
 S DGDIRH="Enter one of the status selections to report on"
 S DGDIRO="S^1:Active;2:Inactive;3:Both"
 S DGASK=$$ANSWER^DGPFUT(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 Q:(DGASK<1)
 S DGSORT("DGSTATUS")=DGASK_U_$S(DGASK=1:"Active",DGASK=2:"Inactive",DGASK=3:"Both",1:3)
 ;
 ;-- prompt for beginning date
 S DGDIRA="Select Beginning Date"
 S DGDIRB=""
 S DGDIRH="^D HELP^DGPFRPI(1)"
 S DGDIRO="D^"_DGFIRST_":DT:EX"
 S DGASK=$$ANSWER^DGPFUT(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 Q:(DGASK=-1)
 S DGSORT("DGBEG")=DGASK
 ;
 ;-- prompt for ending date
 S DGDIRA="Select Ending Date"
 S DGDIRB=""
 S DGDIRH="^D HELP^DGPFRPI(2)"
 S DGDIRO="D^"_DGSORT("DGBEG")_":DT:EX"
 S DGASK=$$ANSWER^DGPFUT(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 Q:(DGASK=-1)
 S DGSORT("DGEND")=DGASK
 ;
 K DGDIRA,DGDIRB,DGDIRO,DGDIRH,DGDIRS,DGASK,DGQ,DGABORT
 ;
 ;-- prompt for device
 S ZTSAVE("DGSORT(")=""
 D EN^XUTMDEVQ("START^DGPFRPI1","Assignments By Principle Investigator Report",.ZTSAVE)
 D HOME^%ZIS
 Q
 ;
HELP(DGSEL) ;provide extended DIR("?") help text.
 ;
 ;  Input: DGSEL - prompt var for help text word selection
 ; Output: none
 ;
 W !,"  Enter the "_$S(DGSEL=1:"earliest",1:"latest")_" Assignment Date to include in the report."
 W !,"  Please enter a date from the specified date range displayed."
 Q
