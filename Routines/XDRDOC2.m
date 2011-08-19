XDRDOC2 ;IHS/OHPRD/JCM - CONTINUATION OF ROUTINE DOCUMENTATION ;07/06/93  16:47
 ;;7.3;TOOLKIT;;Apr 25, 1995
 ;
XDRMADD ; ADDS VERIFIED DUPLICATES TO DUPLICATE RECORD FILE
 ;
 ; This routine allows an operator to select two records that are
 ; not already in duplicate record file and add them as verified
 ; duplicates and proceeds with the merge as package entries allow.
 ;
 ; Input variables: XDRFL
 ;
 ; Calls: DIC,FILE^DICN,DIE,FILE^XDRDQUE,XDRDSCOR,XDRDUP,EN^XDRMAIN
 ;
XDRMAIN ; MAIN DRIVER FOR DUPLICATE MERGE SOFTWARE
 ;
 ; Called by: XDRDADD,XDRMADD
 ;
 ; Calls: DIC,DIE,DIR,XDRMAINI,XDRMPACK,XDRMRG,XDRMSG,XDRMVFY
 ;
 ;EN     Entry Point for Automatic Merge
 ;
 ;EN1    Entry point for looping through Verified ready
 ;       to merge duplicates
 ;
 ;EN2    Entry point to select Verified Ready to Merge Duplicate Pair
 ;
 ;EN3    Entry point to select Unverified Potential Duplicate Pair
 ;
XDRMAINI ; INITIALIZATION ROUTINE FOR XDRMAIN AND XDRDMAIN
 ;
 ; This routine is used to initialize variables needed for the
 ; Duplicate Checker and the Merge process.
 ;
 ; Called by: XDRDMAIN,XDRMAIN
 ;
 ; Calls: DIC,XDRDSCOR,XDREMSG
 ;
XDRMPACK ; CHECKS PACKAGE FILE FOR UNIQUE PACKAGE MERGES
 ;
 ; This routine goes through the package file and checks to see
 ; which packages are affected by patient merge.  It then enters
 ; these packages in the merge package mulitple and sets their
 ; merge status to not ready.  It then polls the packages to see if
 ; they have the XDRMRG("FR") record and if they have an interactive
 ; merge.
 ;
 ; Input variables: XDRMPDA,XDRMRG("FR"),XDRMRG("TO")
 ;
 ; Called by: XDRMAIN
 ;
 ; Calls: DIE
 ;
XDRMRG ; MERGES DUPLICATE RECORDS
 ;
 ; Called by: XDRMAIN
 ;
 ; Calls: DIE,DIK,EN^DIT0,DITM2,EN^DITMGMRG,LOCK^XDRU1
 ;
XDRMRG1 ; ERROR TRAP FOR XDRMRG
 ;
 ; Calls: INT^%ET,DIE
 ;
XDRMSG ; SENDS VERIFIED AND MERGED MESSAGES
 ;
 ; This routine is responsible for sending the Verified Duplicate
 ; Bulletin and the Merged Duplicate Bulletin.  If there is a
 ; Verified Msg Routine entry in the Duplicate Resolution file
 ; the 'XDR VERIFIED' bulletin will not be sent and the Verfied
 ; Msg Routine will be allowed to send a customized bulletin.
 ; The same holds true if there is a Merge Msg Routine entry for
 ; when a duplicate pair are merged.  These bulletins will be sent
 ; to the members of the Verified Duplicate and Merge Mail Group
 ; entries in the Duplicate Resolution file.
 ;
 ; Called by: XDRMAIN
 ;
 ; Calls: XMB, the Verified and Merged Msg Routine entries in the
 ;        Duplicate Resolution file.
 ;
XDRMVFY ; VERIFIES POTENTIAL DUPLICATES
 ;
 ; Input Variables: XDRCD,XDRCD2
 ;
 ; Called by: XDRMAIN
 ;
 ; Calls: DIE,DIR,EN^DITC
 ;
XDRU1 ; GENERAL UTILITIES FOR THE KERNEL MERGE
 ;
 ; This routine is a utility routine that at this time is used
 ; only to check the Duplicate Resolution file entry to see
 ; if all the information necessary to run the duplicate checking
 ; software.
 ;
 ; Called by: XDRDQUE,XDRMRG
 ;
 ; Calls: XDREMSG
