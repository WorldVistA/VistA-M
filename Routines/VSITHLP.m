VSITHLP ;ISD/RJP - Visit Information ;6/6/05
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**76,111,130,168**;Aug 12, 1996;Build 14
 ; Patch PX*1*76 changes the 2nd line of all VSIT* routines to reflect
 ; the incorporation of the module into PCE.  For historical reference,
 ; the old (VISIT TRACKING) 2nd line is included below to reference VSIT
 ; patches.
 ;
 ;;2.0;VISIT TRACKING;;Aug 12, 1996;
 ;
 N TXT,DIR,DX,DY,VSITI,X
 I '$D(IOSL) S IOP=0 D ^%ZIS K IOP
 D HOME^%ZIS W @IOF
 F VSITI=1:1 S TXT=$T(TXT+VSITI) Q:TXT=""  D
 . W $P(TXT,";;",2)
 . I $Y>(IOSL-3) D
 . . S DIR(0)="E" D ^DIR
 . . N X S $P(X," ",79)="" W $C(13),X,$C(13)
 . . S (DX,DY)=0 X ^%ZOSF("XY")
 . E  W !
 Q
 ;
TXT ;
 ;; VSIT(0)   A string of characters which defines how the visit
 ;;           processor will function.
 ;;
 ;;           F - Force adding a new entry.
 ;;           I - Interactive mode.
 ;;           E - Use pt's primary eligibility if now passed on
 ;;               call w/ VSIT("ELG").
 ;;           N - Allow creation of a new visit.
 ;;           D - Look back "n" number of days for a match, default
 ;;               is one (1).   e.g. VSIT(0)="D5"  (v/dt to v/dt-4)
 ;;               Use "D0" to require exact match on date & time.
 ;;           M - Impose criteria on matching or creation of visits.
 ;;               Uses the VSIT(<xxx>) array:
 ;                  [<fld-value>[^...]] for multiple values
 ;;               - If trying to match with existing visit, each element
 ;;                 must match each corresponding field.
 ;;
 ;; Variable names for VISIT file fields:  #9000010   gbl:  ^AUPNVSIT(
 ;;         (format) ->   <internal format>[^<external format>]
 ;;           except VSIT(<ien>) = N^S[^1]
 ;;                      where N = internal entry number
 ;;                            S = value of .01 filed
 ;;                            1 = indicated new entry added
 ;;  .001 - VSIT("IEN") ; NUMBER (internal entry number)
 ;;   .01 - VSIT("VDT") ; VISIT/ADMIT DATE&TIME (date)
 ;;   .02 - VSIT("CDT") ; DATE VISIT CREATED (date)
 ;;   .03 - VSIT("TYP") ; TYPE (set)
 ;;   .05 - VSIT("PAT") ; PATIENT (pointer to PATIENT file #9000001)
 ;;                       (IHS file DINUM'ed to PATIENT file #2)
 ;;   .06 - VSIT("INS") ; LOC. OF ENCOUNTER (pointer to LOCATION file
 ;;                       #9999999.06)
 ;;                       (IHS file DINUM'ed to INSTITUTION file #4)
 ;;   .07 - VSIT("SVC") ; SERVICE CATEGORY (set)
 ;;   .08 - VSIT("DSS") ; CLINIC (pointer to CLINIC STOP file #40.7)
 ;;   .09 - VSIT("CTR") ; DEPENDENT ENTRY COUNTER (number)
 ;;   .11 - VSIT("DEL") ; DELETE FLAG (set)
 ;;   .12 - VSIT("LNK") ; PARENT VISIT LINK (pointer to VISIT file)
 ;;   .13 - VSIT("MDT") ; DATE LAST MODIFIED (date)
 ;;   .18 - VSIT("COD") ; CHECK OUT DATE&TIME (date)
 ;;   .21 - VSIT("ELG") ; ELIGIBILITY (pointer to ELIGIBILITY CODE
 ;;                       file #8)
 ;;   .22 - VSIT("LOC") ; HOSPITAL LOCATION (pointer to HOSPITAL
 ;;                       LOCATION file #44)
 ;;   .23 - VSIT("USR") ; CREATED BY USER (pointer to USER file #200)
 ;;   .24 - VSIT("OPT") ; OPTION USED TO CREATE (pointer to OPTION
 ;;                       file #19)
 ;;   .25 - VSIT("PRO") ; PROTOCOL (pointer to PROTOCOL file #101)
 ;;  2101 - VSIT("OUT") ; OUTSIDE LOCATION (free text)
 ;; 15001 - VSIT("VID") ; VISIT ID (free text)
 ;; 15002 - VSIT("IO")  ; PATIENT STATUS IN/OUT (set)
 ;; 15003 - VSIT("PRI") ; ENCOUNTER TYPE (set)
 ;; 80001 - VSIT("SC")  ; SERVICE CONNECTED (set)
 ;; 80002 - VSIT("AO")  ; AGENT ORANGE EXPOSURE (set)
 ;; 80003 - VSIT("IR")  ; IONIZING RADIATION EXPOSURE (set)
 ;; 80004 - VSIT("EC")  ; PERSIAN GULF EXPOSURE (set)
 ;; 80006 - VSIT("HNC") ; HEAD AND/OR NECK CANCER (set)
 ;; 80007 - VSIT("CV")  ; COMBAT VET (set)
 ;; 80008 - VSIT("SHAD")  ; PROJ 112/SHAD (set)
 ;; 81101 - VSIT("COM") ; COMMENTS (free text)
 ;; 81202 - VSIT("PKG") ; PACKAGE (pointer to PACKAGE file #9.4)
 ;; 81203 - VSIT("SOR") ; DATA SOURCE (pointer to PCE DATA SOURCE
 ;;                       file #839.7)
