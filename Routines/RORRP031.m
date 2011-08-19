RORRP031 ;HCIOFO/SG - RPC: LOCAL LAB TEST NAMES ; 2/10/04 8:59am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ; This routine uses the following IAs:
 ;
 ; #91           Access to the LABORATORY TEST file
 ;
 Q
 ;
 ;***** PROCESSES THE ERROR(S) AND UNLOCKS THE RECORD(S)
ERROR(RESULTS,RC) ;
 D RPCSTK^RORERR(.RESULTS,RC)
 D UNLOCK^RORLOCK(.RORLOCK)
 Q
 ;
 ;***** RETURNS THE LIST OF LOCAL TEST NAMES
 ; RPC: [ROR LIST LOCAL LAB TESTS]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; REGIEN        Registry IEN
 ;
 ; [GROUP]       Code of the Lab Group. If this parameter is
 ;               defined and greater than zero then only the tests
 ;               associated with this group will be returned.
 ;
 ; The ^TMP("DILIST",$J) global node is used by the procedure.
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0)
 ; indicates an error (see the RPCSTK^RORERR procedure for more
 ; details).
 ;
 ; Otherwise, number of lab tests is returned in the @RESULTS@(0)
 ; and the subsequent nodes of the global array contain the tests.
 ; 
 ; @RESULTS@(0)          Number of Local Tests
 ;
 ; @RESULTS@(i)          Test Descriptor
 ;                         ^01: IEN in the LOCAL TEST NAME multiple
 ;                         ^02: Local test name
 ;                         ^03: IEN of the local test
 ;                         ^04: Code of the Lab Group
 ;
LTLIST(RESULTS,REGIEN,GROUP) ;
 N GROUPIEN,IENS,IR,RC,RORERRDL,RORMSG,SCR,TMP
 D CLEAR^RORERR("LTLIST^RORRP031",1)
 K RESULTS  S RESULTS=$NA(^TMP("DILIST",$J))  K @RESULTS
 ;
 ;--- Check the parameters
 S RC=0  D  I RC<0  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . ;--- Registry IEN
 . I $G(REGIEN)'>0  D  Q
 . . S RC=$$ERROR^RORERR(-88,,,,"REGIEN",$G(REGIEN))
 . S REGIEN=+REGIEN
 . ;--- Code of the Lab Group
 . S GROUP=+$G(GROUP)
 . S GROUPIEN=$S(GROUP>0:$$ITEMIEN^RORUTL09(3,REGIEN,GROUP),1:0)
 . I GROUPIEN<0  D  Q
 . . S RC=$$ERROR^RORERR(GROUPIEN)
 ;
 ;--- Compile the screen logic  (be careful with naked references)
 S SCR=""
 S:GROUPIEN>0 SCR=SCR_"I $P($G(^(0)),U,2)="_GROUPIEN_" "
 ;--- Get the list of tests
 S IENS=","_REGIEN_",",TMP="@;.01E;.01I;.02I"
 D LIST^DIC(798.128,IENS,TMP,"PU",,,,"B",SCR,,,"RORMSG")
 I $G(DIERR)  D  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . S RC=$$DBS^RORERR("RORMSG",-9,,,798.128,IENS)
 ;
 ;--- Replace the group IEN's with the group code(s)
 S (IR,RC)=0
 F  S IR=$O(@RESULTS@(IR))  Q:IR'>0  D  Q:RC<0
 . I GROUPIEN>0  S $P(@RESULTS@(IR,0),U,4)=GROUP  Q
 . S TMP=+$P(@RESULTS@(IR,0),U,4)
 . I TMP'>0  S $P(@RESULTS@(IR,0),U,4)=""  Q
 . S RC=$$ITEMCODE^RORUTL09(TMP)
 . S:RC>0 $P(@RESULTS@(IR,0),U,4)=RC
 I RC<0  D RPCSTK^RORERR(.RESULTS,RC)  Q
 ;--- Success
 S TMP=+$G(^TMP("DILIST",$J,0))
 K ^TMP("DILIST",$J,0)  S @RESULTS@(0)=TMP
 Q
 ;
 ;***** UPDATES THE LIST OF LOCAL TEST NAMES
 ; RPC: [ROR UPDATE LOCAL LAB TESTS]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; REGIEN        Registry IEN
 ;
 ; GROUP         Code of the Lab Group.
 ;
 ;               If this parameter is equal to 0 then every item of
 ;               the LTLST must contain a valid group code. If an
 ;               empty list is passed into the RPC then ALL records
 ;               will be deleted from the LOCAL TEST NAME multiple.
 ;
 ;               If this parameter is not zero then it should contain 
 ;               a valid group code. All records of the LTLST will be 
 ;               associated with this group. If an empty list is
 ;               passed into the RPC then only records associated
 ;               with this group will be deleted from the multiple.
 ;
 ; .LTLST(       Reference to a local variable that contains
 ;               a list of local laboratory tests
 ;
 ;   i)          Test Descriptor
 ;                 ^01: Ignored
 ;                 ^02: Ignored
 ;                 ^03: IEN of the local test
 ;                 ^04: Code of the Lab Group
 ;                      (see also the GROUP parameter)
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0)
 ; indicates an error (see the RPCSTK^RORERR procedure for more
 ; details).
 ;
 ; Otherwise, zero is returned in the RESULTS(0).
 ;
LTLUPD(RESULTS,REGIEN,GROUP,LTLST) ;
 N DA,DIK,ECNT,GROUPIEN,GRPIEN,IENS,IR,LTL,RC,ROOT,RORERRDL,RORFDA,RORLOCK,RORMSG,TMP,TSTIEN
 D CLEAR^RORERR("LTLUPD^RORRP031",1)  K RESULTS
 S ECNT=0
 ;
 ;--- Check the parameters
 S RC=0  D  I RC<0  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . ;--- Registry IEN
 . I $G(REGIEN)'>0  D  Q
 . . S RC=$$ERROR^RORERR(-88,,,,"REGIEN",$G(REGIEN))
 . S REGIEN=+REGIEN
 . ;--- Code of the Lab Group
 . S GROUPIEN=$S($G(GROUP)>0:$$ITEMIEN^RORUTL09(3,REGIEN,GROUP),1:0)
 . I GROUPIEN<0  D  Q
 . . S RC=$$ERROR^RORERR(-88,,,,"GROUP",$G(GROUP))
 . S GROUP=+$G(GROUP)
 ;
 ;--- Lock the LOCAL TEST NAME multiple
 S IENS=","_REGIEN_","
 S RC=$$LOCK^RORLOCK(798.128,IENS)
 I RC  D:RC>0  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . S RC=$$ERROR^RORERR(-11,,,,"the LOCAL TEST NAME multiple")
 ;---
 S RORLOCK(798.128,IENS)=""
 S ROOT=$$ROOT^DILFD(798.128,IENS,1)
 ;
 ;--- Prepare the data
 S IR="",RC=0
 F  S IR=$O(LTLST(IR))  Q:IR=""  D  Q:RC<0
 . ;--- Check if the test is defined in the LABORATORY TEST file
 . S TSTIEN=+$P(LTLST(IR),U,3)
 . Q:$$FIND1^DIC(60,,,"`"_TSTIEN,,,"RORMSG")'>0
 . ;--- Assign the default Group IEN (if the GROUP is provided)
 . I GROUPIEN>0  S LTL(GROUPIEN,TSTIEN)=""  Q
 . ;--- Get IEN of the Lab Group
 . S TMP=+$P(LTLST(IR),U,4)
 . S GRPIEN=$$ITEMIEN^RORUTL09(3,REGIEN,TMP)
 . I GRPIEN'>0  D:GRPIEN<0  Q
 . . S RC=$$ERROR^RORERR(GRPIEN)
 . ;--- Create the reference
 . S LTL(GRPIEN,TSTIEN)=""
 I RC<0  D ERROR(.RESULTS,RC)  Q
 ;
 ;--- Mark the groups to be cleared
 I GROUPIEN'>0  S GRPIEN=""  D
 . F  S GRPIEN=$O(@ROOT@("G",GRPIEN))  Q:GRPIEN=""  S LTL(GRPIEN)=""
 E  S LTL(GROUPIEN)=""
 ;
 ;--- Update the multiple
 S IENS="?+1,"_REGIEN_",",ECNT=0
 S GRPIEN=""
 F  S GRPIEN=$O(LTL(GRPIEN))  Q:GRPIEN=""  D
 . ;--- Delete the old records
 . S DIK=$$OREF^DILF(ROOT),DA(1)=REGIEN
 . S TSTIEN=""
 . F  S TSTIEN=$O(@ROOT@("G",GRPIEN,TSTIEN))  Q:TSTIEN=""  D
 . . S DA=""
 . . F  S DA=$O(@ROOT@("G",GRPIEN,TSTIEN,DA))  Q:DA=""  D ^DIK
 . ;--- Store the new records
 . S TSTIEN=""
 . F  S TSTIEN=$O(LTL(GRPIEN,TSTIEN))  Q:TSTIEN=""  D
 . . S RORFDA(798.128,IENS,.01)=TSTIEN
 . . S RORFDA(798.128,IENS,.02)=GRPIEN
 . . D UPDATE^DIE(,"RORFDA",,"RORMSG")
 . . I $G(DIERR)  D  S ECNT=ECNT+1  Q
 . . . D DBS^RORERR("RORMSG",-9,,,798.128,IENS)
 ;
 ;--- Unlock the multiple and check for errors
 D UNLOCK^RORLOCK(798.128,","_REGIEN_",")
 I ECNT>0  D RPCSTK^RORERR(.RESULTS,-9)  Q
 ;--- Success
 S RESULTS(0)=0
 Q
