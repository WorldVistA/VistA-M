IBDEHELP ; ALB/ISC - ENCOUNTER FORM UTILITIES - INSTRUCTIONS FOR EXECUTING DIFROM ;AUG 16, 1993
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
HELP ;
 N LINE,IBARY,IBHDRRTN,CNT
 S IBHDRRTN="D HDR^IBDEHELP"
 S CNT=0
 S IBARY="^TMP(""IBDF"",$J,""IMP/EXP HELP"")"
 K @IBARY
 F  S LINE=$P($T(LINES+CNT),";;",2) Q:LINE=""  D
 .S CNT=CNT+1
 .S @IBARY@(CNT,0)=LINE
 S $P(@IBARY@(0),"^",4)=CNT
 D EN^VALM("IBDE TEXT DISPLAY")
 K @IBARY
 S VALMBCK="R"
 Q
HDR ;
 S VALMHDR(1)="HELP for the IMPORT/EXPORT UTILITY"
 Q
 ;
LINES ;;The initial install of the Encounter Form Utilities at your site
 ;;included a toolkit of forms and blocks. The ONLY SAFE METHOD for
 ;;transferring additional forms and blocks between sites is through this
 ;;IMPORT/EXPORT UTILITY.
 ;;  
 ;;The IMPORT/EXPORT UTILITY includes a set of files that are nearly
 ;;identical to the files used by the ENCOUNTER FORM UTILTIES to contain
 ;;the form descriptions. These import/export files constitute a WORK
 ;;SPACE in which forms and blocks can be safely exported (to other sites)
 ;;and imported (from other sites to your own).
 ;;  
 ;;You should have a PACKAGE entry for the IMPORT/EXPORT UTILITY already
 ;;set up. The files listed should be in the range 358 to 358.91.
 ;;The package entry is named IB ENCOUNTER FORM IMP/EXP, and the prefix
 ;;is IBDE. The package entry is necessary to accomplish EXPORT.
 ;;  
 ;;  
 ;;TO IMPORT:
 ;;  
 ;;  1) The other site must have prepared a set of inits, using this
 ;;     utility, that contain the forms and toolkit blocks they want to
 ;;     transfer.
 ;;  
 ;;  2) The work space MUST NOT ALREADY CONTAIN any forms or blocks that
 ;;     you want to keep. First decide what you want to do with anything
 ;;     that is already in the workspace. The work space will be cleared
 ;;     before the inits are executed, so anything there will be lost.
 ;;  
 ;;  3) You must execute the inits, using this this utility, by choosing
 ;;     the action RUN INITS. The init should normally be named IBDEINIT.
 ;;  
 ;;  4) The work space should now contain forms and toolkit blocks. You
 ;;     can choose which ones you want, then choose the action IMPORT
 ;;     ENTRY to actually make the form or block available for use. The
 ;;     forms can not be viewed while in the work space, but you can view
 ;;     the IMPORT/EXP NOTES.
 ;;  
 ;;TO EXPORT:
 ;;  
 ;;   0) Only users with PROGRAMMER ACCESS can export.
 ;;  
 ;;   1) First clear the work space of anything you do not want to export.
 ;;  
 ;;   2) Then add any forms or blocks to the work space that you do want
 ;;      to export.
 ;;  
 ;;   3) Add EXPORT/IMPORT NOTES to each entry you add to the work space.
 ;;      You must accuratly describe the form for the site that you are
 ;;      exporting it to. They will be able to view the notes, but they
 ;;      will not be able to view the form itself until they import it.
 ;;  
 ;;   4) Then, through the DIFROM action that is part of this utility,
 ;;      create the inits that will be sent to the other site.
 ;;  
 ;;   5) Send the inits to the other site.
