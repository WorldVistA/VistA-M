XDRDOC ;IHS/OHPRD/JCM - DOCUMENTATION OF KERNEL ROUTINES ;09/13/93  08:39
 ;;7.3;TOOLKIT;;Apr 25, 1995
 ;
XDRDADD ; ADDS POTENTIAL DUPLICATE RECORDS TO DUPLICATE RECORD FILE
 ;
 ; Input Variables: XDRCD,XDRCD2,XDRFL,XDRGL,XDRDSCOR(,XDRDTEST(
 ;
 ; Called by: XDRDUP
 ;
 ; Calls: FILE^DICN,DIE,EN^XDRMAIN
 ;
XDRDADJ ; ADJUSTS DUPLICATE RECORD FILE UPON MERGE OF A PATIENT
 ;
 ; This routine is executed by a MUMPS xref on the MERGE STATUS field
 ; of the DUPLICATE RECORD file only when the status is set to MERGED.
 ; This routine checks for entries in the file that are affected by
 ; the merging of this entry, and adjusts their .01 and .02 fields
 ; accordingly.  The problem being addressed is:
 ;
 ;  1 to 5    If 5 to 10 merged first     1 to 10
 ;  5 to 10   then other entries would    5 to 10
 ;  5 to 20   be adjusted as follows:    10 to 20
 ;
 ; Or, if both 1 to 5 and 1 to 10 existed at the time of the
 ; merge, the 1 to 5 entry would be deleted.
 ;
 ; The STATUS field (.03) is re-indexed because it sets xrefs based
 ; on the values in the .01 and .02 fields.  TRIGGERs are not fired
 ; for the .01, .02, or .03 fields.
 ;
 ; Entries previously resolved are ignored.
 ;
 ; Called by: Cross Reference on Merge Status field of
 ;            Duplicate Record File entry
 ;
 ; Calls: EN^XDRDUP,DIK
 ;
XDRDCOMP ; COMPARE TWO PATIENTS VIA THE DUP CHECKER ALGORITHM
 ;
 ; Input variables: XDRFL
 ;
 ; Calls: %ZIS,%ZTLOAD,DIC,DR,EN^DITC,FILE^XDRDQUE,XDRDSCOR,XDRDUP
 ;
XDRDLIST ; PRINT POTENTIAL AND VERIFIED DUPLICATES
 ;
 ; This routine is the main driver for reports dealing with the
 ; duplicate record file.  It will print listings of Potential
 ; duplicates, ready and not ready to merge verified duplicates.
 ;
 ; Input variables: XDRFL
 ;
 ; Calls: EN1^DIP,DIR,FILE^XDRDQUE
 ;
XDRDMAIN ; MAIN DRIVER FOR DUPLICATE CHECKING SOFTWARE
 ;
 ; Input Variables: XDRFL - File number of File to be Checked
 ;                  XDRDPDTI - Defined if Potential Threshold Increased
 ;                            and Previous search completed
 ;                  XDRDTYPE - Type of search to run
 ;
 ; Calls: NOW^%DTC,DIE,DIK,XDRDPDTI,XDRDUP,XDREMSG,XDRMAINI
 ;
 ; We will pass the variable XDRCD for them to then get the candidates
 ; Expect the routine to send back the possibles in
 ; ^TMP("XDRD",$J,XDRFL,DFN
 ;
 ; There is a basic assumption in the limiting of which records are
 ; checked.  It is assumed that if Record 1 gathers Record 2 as a
 ; candidate for duplicate checking that Record 2 will in turn
 ; gather Record 1 as a candidate for duplicate checking.
 ;
 ; It was decided that if a record is being checked again outside of
 ; the BASIC search type any entries in the Duplicate Record file
 ; other than merged entries will be deleted and then the pair
 ; rechecked.
 ;
XDRDPDTI ; CHECKS POTENTIAL DUPLICATES IF THRESHOLD RAISED
 ;
 ; This routine is called by XDRDMAIN when the Potential Duplicate
 ; threshold has been increased from a previous value.  This routine
 ; $O's through the "APOT" cross reference on the Duplicate Record file
 ; and deletes all entries in the Duplicate Record file that had a DC
 ; Dupe Match Score that did not meet the new Potential Duplicate
 ; Threshold value.  It also updates the DC Potential Dupe Threshold %.
 ; It should be noted that if a person changes the weights of the
 ; Duplicate Tests, they should delete all Non-Verified Potential
 ; Duplicates and rerun the Duplicate Resolution search.
 ;
 ; Input Variables: XDRGL,XDRFL,XDRDSCOR(
 ;
 ; Called by: XDRDMAIN
 ;
 ; Calls: DIE,DIK
 ;
XDRDPRGE ; PURGE DUPLICATE RECORD FILE
 ;
 ; This routine is used to purge the Duplicate Record file of either
 ; Potential Duplicates, Verified Non-Duplicates, or both.
 ; Verified Duplicates cannot be purged until Fileman institutes
 ; some sort of archival or merged node.
 ;
 ; Input Variable: XDRFL
 ;
 ; Calls: %ZTLOAD,DIC,DIR,DIK
 ;
