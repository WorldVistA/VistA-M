MAGKIDS ;WOIFO/SG - INSTALLATION UTILITIES ; 3/9/09 12:52pm
 ;;3.0;IMAGING;**93**;Dec 02, 2009;Build 163
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
 ;***** DISPLAYS THE MESSAGE IF THE INSTALLATION ABORTS
ABTMSG() ;
 ;;Installation of the patch has been aborted due to error(s).
 ;;Please fix the problem(s) and restart the installation using
 ;;the Restart Install of Package(s) [XPD RESTART INSTALL] option
 ;;of the Installation ... [XPD INSTALLATION MENU] menu.
 ;
 N I,TEXT,TMP
 F I=2:1  S TMP=$T(ABTMSG+I)  Q:TMP'[";;"  S TEXT(I)=$P(TMP,";;",2,99)
 D BMES($P($T(ABTMSG+1),";;",2,99),.TEXT)
 Q
 ;
 ;##### OUTPUTS THE INSTALLATION MESSAGE WITH INDENTATION
 ;
 ; MSG           Message
 ;
 ; [.INFO]       Reference to a local array that contains additional
 ;               text that will be displayed after the main message.
 ;
 ; This procedure automatically adds an empty string before the
 ; message (see the BMES^XPDUTL).
 ;
BMES(MSG,INFO) ;
 N MAGI
 D BMES^XPDUTL("   "_MSG)
 S MAGI=""
 F  S MAGI=$O(INFO(MAGI))  Q:MAGI=""  D MES^XPDUTL("   "_INFO(MAGI))
 Q
 ;
 ;##### PROCESSES THE INSTALL CHECKPOINT
 ;
 ; CPNAME        Checkpoint name
 ;
 ; CALLBACK      Callback entry point: "$$TAG^ROUTINE(PARAMETERS)".
 ;               This function must return either 0 if everything is
 ;               Ok or the error descriptor.
 ;
 ; [PARAM]       Value to set the checkpoint parameter to.
 ;
 ; The function checks if the checkpoint is completed. If it is not,
 ; the callback entry point is XECUTEd. If everything is Ok, the
 ; function completes the checkpoint and returns 0. Otherwise, an
 ; error code is returned (it can be generated either by this function
 ; itself or returned from the callback entry point).
 ;
 ; Return Values
 ; =============
 ;           <0  Error code
 ;            0  Ok
 ;
CP(CPNAME,CALLBACK,PARAM) ;
 N RC
 ;--- Validate parameters
 I $G(CALLBACK)'?1"$$"1.8UN1"^MAG"1.5UN.1(1"(".E1")")  D  Q RC
 . S RC=$$IPVE^MAGUERR("CALLBACK")
 . Q
 ;--- Verify the checkpoint and quit if it is completed
 S RC=$$VERCP^XPDUTL(CPNAME)  Q:RC>0 0
 ;--- Create the new checkpoint
 I RC<0  D  Q:'RC $$ERROR^MAGUERR(-28,,CPNAME)
 . S RC=$$NEWCP^XPDUTL(CPNAME,,.PARAM)
 . Q
 ;--- Reset the KIDS progress bar
 S XPDIDTOT=0  D UPDATE^XPDID(0)
 ;--- Execute the callback entry point
 X "S RC="_CALLBACK  Q:RC<0 RC
 ;--- Complete the check point
 S RC=$$COMCP^XPDUTL(CPNAME)
 Q:'RC $$ERROR^MAGUERR(-29,,CPNAME)
 ;--- Success
 Q 0
 ;
 ;##### DELETES THE (SUB)FILE DD AND DATA (IF REQUESTED)
 ;
 ; FILE          File or subfile number
 ;
 ; [DIU2FLAGS]   Flags for the EN^DIU2 (can be combined):
 ;
 ;                 D  Delete the data as well as the DD
 ;                 E  Echo back information during deletion
 ;                 S  Subfile data dictionary is to be deleted
 ;                 T  Templates are to be deleted
 ;
 ; [FLAGS]       Flags that control the execution (can be combined):
 ;
 ;                 S  If this flag is provided, the procedure will
 ;                    work in "silent" mode. Nothing will be
 ;                    displayed on the console or stored into the
 ;                    INSTALLATION file (#9.7).
 ;
 ; Notes
 ; =====
 ;
 ; This entry point can be called either as a procedure or as a
 ; function (always returns 0).
 ;
DELFILE(FILE,DIU2FLAGS,FLAGS) ;
 I '$$VFILE^DILFD(+FILE)  Q:$QUIT 0  Q
 N DIU,FT,RC
 S FLAGS=$G(FLAGS)
 S DIU=+FILE,DIU(0)=$G(DIU2FLAGS)
 I FLAGS'["S"  D
 . S FT=$S(DIU(0)["S":"subfile",1:"file")
 . D BMES("Deleting the "_FT_" #"_(+FILE)_"...")
 . Q
 D EN^DIU2
 D:FLAGS'["S" MES("The "_FT_" has been deleted.")
 Q:$QUIT 0  Q
 ;
 ;##### DELETES FIELD DEFINITIONS FROM THE DD
 ;
 ; FILE          File number
 ;
 ; FLDLST        String that contains list of field numbers to
 ;               delete separated by semicolons.
 ;
 ; [FLAGS]       Flags that control the execution (can be combined):
 ;
 ;                 S  If this flag is provided, the procedure will
 ;                    work in "silent" mode. Nothing will be
 ;                    displayed on the console or stored into the
 ;                    INSTALLATION file (#9.7).
 ;
 ; Notes
 ; =====
 ;
 ; This entry point can be called either as a procedure or as a
 ; function (always returns 0).
 ;
DELFLDS(FILE,FLDLST,FLAGS) ;
 I '$$VFILE^DILFD(+FILE)  Q:$QUIT 0  Q
 N DA,DIK,MAGI,RC
 S FLAGS=$G(FLAGS)
 D:FLAGS'["S"
 . D BMES("Deleting the field definitions...")
 . D MES("File #"_(+FILE)_", Fields: '"_FLDLST_"'")
 . Q
 S DA(1)=+FILE,DIK="^DD("_DA(1)_","
 F MAGI=1:1  S DA=$P(FLDLST,";",MAGI)  Q:'DA  D ^DIK
 D:FLAGS'["S" MES("The definitions have been deleted.")
 Q:$QUIT 0  Q
 ;
 ;##### OUTPUTS THE INSTALLATION MESSAGE WITH INDENTATION
 ;
 ; MSG           Message
 ;
 ; [.INFO]       Reference to a local array that contains additional
 ;               text that will be displayed after the main message.
 ;
MES(MSG,INFO) ;
 N MAGI
 D MES^XPDUTL("   "_MSG)
 S MAGI=""
 F  S MAGI=$O(INFO(MAGI))  Q:MAGI=""  D MES^XPDUTL("   "_INFO(MAGI))
 Q
 ;
 ;##### CHECKS AND/OR UPDATES THE FILE'S PACKAGE REVISION DATA
 ;
 ; FILE          File number
 ;
 ; PATCH         Patch number (e.g. 93)
 ;
 ; [MODE]        Execution mode:
 ;
 ;                 "A"  Add the patch number to the file revision data
 ;
 ;                 "D"  Delete the patch from the file revision data
 ;
 ; Return Values
 ; =============
 ;            0  Patch number is (was) in the file revision data
 ;            1  Patch number is (was) NOT in the revision data
 ;
 ; Notes
 ; =====
 ;
 ; If the MODE parameter is not defined or empty, then this function
 ; checks if the patch number is present in the file revision data.
 ;
 ; Otherwise, it performs the requested action and returns the value
 ; that indicates whether the patch number was present in the file
 ; revision data before the action.
 ; 
 ; This entry point can also be called as a procedure:
 ; D PRD^MAGKIDS(...) if you do not need its return value.
 ;
 ; If a full data dictionary is exported in the KIDS build, the file
 ; revision data is also exported!
 ;
 ; When a new version of the package is released, package revison
 ; data for all package files must be cleared (use the PRD^DILFD).
 ;
PRD(FILE,PATCH,MODE) ;
 N FOUND,MAGMSG,PRD
 S PATCH=+PATCH
 ;
 ;=== Get the patch list from the file revision data
 S PRD=$$GET1^DID(FILE,,,"PACKAGE REVISION DATA",,"MAGMSG")
 S PRD=$TR(PRD," "),FOUND=(","_PRD_",")[(","_PATCH_",")
 ;
 ;=== Add the patch number to the list
 I $G(MODE)="A"  D:'FOUND  Q:$QUIT FOUND  Q
 . N I
 . S I=$L(PRD,",")  S:$P(PRD,",",I)'="" I=I+1
 . S $P(PRD,",",I)=PATCH
 . ;--- If the list is too long, purge the oldest entries
 . F  Q:$L(PRD)<254  S $P(PRD,",",1,2)=$P(PRD,",",2)
 . ;--- Store the list as the file revision data
 . D PRD^DILFD(FILE,PRD)
 . Q
 ;
 ;=== Delete the patch number from the list
 I $G(MODE)="D"  D:FOUND  Q:$QUIT FOUND  Q
 . N I,IP
 . F I=$L(PRD,","):-1:1  I $P(PRD,",",I)=PATCH  S IP=I  Q
 . Q:$G(IP)'>0  ; This should never happen.
 . S $P(PRD,",",IP,IP+1)=$P(PRD,",",IP+1)
 . ;--- Remove the trailing comma
 . S I=$L(PRD)  S:$E(PRD,I)="," $E(PRD,I)=""
 . ;--- Store the list as the file revision data
 . D PRD^DILFD(FILE,PRD)
 . Q
 ;
 ;===
 Q:$QUIT FOUND  Q
