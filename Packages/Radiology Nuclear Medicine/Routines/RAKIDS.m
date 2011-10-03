RAKIDS ;HCIOFO/SG - INSTALLATION UTILITIES ; 2/24/09 4:17pm
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 Q
 ;
 ;***** DISPLAY THE ERROR MESSAGE WHEN INSTALLATION IS ABORTED
 ;
 ; [DLGNUM]      Dialog number (file #.84). Default: 700005.001
 ;
ABORTMSG(DLGNUM) ;
 N PARAMS,RAI,RANODE,TMP
 S:$G(DLGNUM)'>0 DLGNUM=700005.001
 ;--- Load the message text
 S TMP=+$G(RAPARAMS("KIDS"))
 S PARAMS("KIDS")=$S(TMP=1:"pre-",TMP=2:"post-",1:"")_"install"
 S RANODE=$$DLGTXT^RAUTL22(DLGNUM,.PARAMS,75)
 ;--- Display the message
 S RAI=""
 F  S RAI=$O(@RANODE@(RAI))  Q:RAI=""  D MES(@RANODE@(RAI,0))
 ;--- Cleanup
 K @RANODE
 Q
 ;
 ;***** OUTPUTS THE INSTALLATION MESSAGE WITH INDENTATION
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
 N I
 D BMES^XPDUTL("   "_MSG)
 S I=""
 F  S I=$O(INFO(I))  Q:I=""  D MES^XPDUTL("   "_INFO(I))
 Q
 ;
 ;***** PROCESSES THE INSTALL CHECKPOINT
 ;
 ; CPNAME        Checkpoint name
 ;
 ; CALLBACK      Callback entry point ($$TAG^ROUTINE). This function
 ;               accepts no parameters and must return either 0 if
 ;               everything is Ok or a negative error code.
 ;
 ; [PARAM]       Value to set checkpoint parameter to.
 ;
 ; The function checks if the checkpoint is completed. If it is not,
 ; the callback entry point is XECUTEd. If everything is Ok, the
 ; function completes the checkpoint and returns 0. Otherwise, an
 ; error code is returned (it can be generated either by this function
 ; itself or returned from the callback entry point).
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
CP(CPNAME,CALLBACK,PARAM) ;
 N RC
 ;--- Verify the checkpoint and quit if it is completed
 S RC=$$VERCP^XPDUTL(CPNAME)  Q:RC>0 0
 ;--- Create the new checkpoint
 I RC<0  D  Q:'RC $$ERROR^RAERR(-46,,CPNAME)
 . S RC=$$NEWCP^XPDUTL(CPNAME,,.PARAM)
 ;--- Reset the KIDS progress bar
 S XPDIDTOT=0  D UPDATE^XPDID(0)
 ;--- Execute the callback entry point
 X "S RC="_CALLBACK  Q:RC<0 RC
 ;--- Complete the check point
 S RC=$$COMCP^XPDUTL(CPNAME)
 Q:'RC $$ERROR^RAERR(-47,,CPNAME)
 Q 0
 ;
 ;***** DELETES THE (SUB)FILE DD AND DATA (IF REQUESTED)
 ;
 ; FILE          File or subfile number
 ;
 ; [FLAGS]       String that contains flags for EN^DIU2:
 ;                 "D"  Delete the data as well as the DD
 ;                 "E"  Echo back information during deletion
 ;                 "S"  Subfile data dictionary is to be deleted
 ;                 "T"  Templates are to be deleted
 ;
 ; [SILENT]      If this parameters is defined and non-zero, the
 ;               function will work in "silent" mode.
 ;               Nothing will be displayed on the console or stored
 ;               into the INSTALLATION file.
 ;
DELFILE(FILE,FLAGS,SILENT) ;
 Q:'$$VFILE^DILFD(+FILE)
 N DIU,FT
 S DIU=+FILE,DIU(0)=$G(FLAGS)
 I '$G(SILENT)  D
 . S FT=$S(DIU(0)["S":"subfile",1:"file")
 . D BMES("Deleting the "_FT_" #"_(+FILE)_"...")
 D EN^DIU2
 D:'$G(SILENT) MES("The "_FT_" has been deleted.")
 Q
 ;
 ;***** DELETES FIELD DEFENITIONS FROM THE DD
 ;
 ; FILE          File number
 ;
 ; FLDLST        String that contains list of field numbers to
 ;               delete (separated with the ';').
 ;
 ; [SILENT]      If this parameters is defined and non-zero, the
 ;               function will work in "silent" mode.
 ;               Nothing will be displayed on the console or stored
 ;               into the INSTALLATION file.
 ;
DELFLDS(FILE,FLDLST,SILENT) ;
 Q:'$$VFILE^DILFD(+FILE)
 N DA,DIK,I,RC
 D:'$G(SILENT)
 . D BMES("Deleting the field definitions...")
 . D MES("File #"_(+FILE)_", Fields: '"_FLDLST_"'")
 S DA(1)=+FILE,DIK="^DD("_DA(1)_","
 F I=1:1  S DA=$P(FLDLST,";",I)  Q:'DA  D ^DIK
 D:'$G(SILENT) MES("The definitions have been deleted.")
 Q
 ;
 ;***** OUTPUTS THE INSTALLATION MESSAGE WITH INDENTATION
 ;
 ; MSG           Message
 ;
 ; [.INFO]       Reference to a local array that contains additional
 ;               text that will be displayed after the main message.
 ;
MES(MSG,INFO) ;
 N I
 D MES^XPDUTL("   "_MSG)
 S I=""
 F  S I=$O(INFO(I))  Q:I=""  D MES^XPDUTL("   "_INFO(I))
 Q
 ;
 ;***** UPDATES THE FILE'S PACKAGE REVISION DATA (IF NECESSARY)
 ;
 ; FILE          File number
 ;
 ; [PRD]         Package revision data
 ;                 ^01: Revision number (N.N)
 ;                 ^02: Patch name
 ;
 ; If this entry point is called as a function, it returns the
 ; previous value of the PACKAGE REVISION DATA attribute.
 ;
PRD(FILE,PRD) ;
 N OLDPRD,RORMSG
 S OLDPRD=$$GET1^DID(FILE,,,"PACKAGE REVISION DATA",,"RORMSG")
 D:$G(PRD)>OLDPRD PRD^DILFD(FILE,PRD)
 Q:$QUIT OLDPRD  Q
