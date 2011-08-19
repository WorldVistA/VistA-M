RORRP032 ;HCIOFO/SG - RPC: LOCAL DRUG NAMES ; 11/3/05 2:26pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ; This routine uses the following IAs:
 ;
 ; #4533         ZERO^PSS50 (supported)
 ;
 Q
 ;
 ;***** PROCESSES THE ERROR(S) AND UNLOCKS THE RECORD(S)
ERROR(RESULTS,RC) ;
 D RPCSTK^RORERR(.RESULTS,RC)
 D UNLOCK^RORLOCK(.RORLOCK)
 Q
 ;
 ;***** RETURNS THE LIST OF LOCAL DRUG NAMES
 ; RPC: [ROR LIST LOCAL DRUGS]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; REGIEN        Registry IEN
 ;
 ; [GROUP]       Code of the Drug Group. If this parameter is
 ;               defined and greater than zero then only the drugs
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
 ; Otherwise, number of drugs is returned in the @RESULTS@(0) and
 ; the subsequent nodes of the global array contain the drugs.
 ; 
 ; @RESULTS@(0)          Number of Local Drugs
 ;
 ; @RESULTS@(i)          Drug Descriptor
 ;                         ^01: IEN in the LOCAL DRUG NAME multiple
 ;                         ^02: Local drug name
 ;                         ^03: IEN of the local drug
 ;                         ^04: Code of the Drug Group
 ;
LDLIST(RESULTS,REGIEN,GROUP) ;
 N GROUPIEN,IENS,IR,RC,RORERRDL,RORMSG,SCR,TMP
 D CLEAR^RORERR("LDLIST^RORRP032",1)
 K RESULTS  S RESULTS=$NA(^TMP("DILIST",$J))  K @RESULTS
 ;
 ;--- Check the parameters
 S RC=0  D  I RC<0  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . ;--- Registry IEN
 . I $G(REGIEN)'>0  D  Q
 . . S RC=$$ERROR^RORERR(-88,,,,"REGIEN",$G(REGIEN))
 . S REGIEN=+REGIEN
 . ;--- Code of the Drug Group
 . S GROUP=+$G(GROUP)
 . S GROUPIEN=$S(GROUP>0:$$ITEMIEN^RORUTL09(4,REGIEN,GROUP),1:0)
 . I GROUPIEN<0  D  Q
 . . S RC=$$ERROR^RORERR(GROUPIEN)
 ;
 ;--- Compile the screen logic  (be careful with naked references)
 S SCR=""
 S:GROUPIEN>0 SCR=SCR_"I $P($G(^(0)),U,2)="_GROUPIEN_" "
 ;--- Get the list of drugs
 S IENS=","_REGIEN_",",TMP="@;.01E;.01I;.02I"
 D LIST^DIC(798.129,IENS,TMP,"PU",,,,"B",SCR,,,"RORMSG")
 I $G(DIERR)  D  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . S RC=$$DBS^RORERR("RORMSG",-9,,,798.129,IENS)
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
 ;***** UPDATES THE LIST OF LOCAL DRUG NAMES
 ; RPC: [ROR UPDATE LOCAL DRUGS]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; REGIEN        Registry IEN
 ;
 ; GROUP         Code of the Drug Group.
 ;
 ;               If this parameter is equal to 0 then every item of
 ;               the LDLST must contain a valid group code. If an
 ;               empty list is passed into the RPC then ALL records
 ;               will be deleted from the LOCAL DRUG NAME multiple.
 ;
 ;               If this parameter is not zero then it should contain 
 ;               a valid group code. All records of the LDLST will be
 ;               associated with this group. If an empty list is
 ;               passed into the RPC then only records associated
 ;               with this group will be deleted from the multiple.
 ;
 ; .LDLST(       Reference to a local variable that contains
 ;               a list of local drugs
 ;
 ;   i)          Test Descriptor
 ;                 ^01: Ignored
 ;                 ^02: Ignored
 ;                 ^03: IEN of the local drug
 ;                 ^04: Code of the Drug Group
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
LDLUPD(RESULTS,REGIEN,GROUP,LDLST) ;
 N DA,DIK,DRUGIEN,ECNT,GROUPIEN,GRPIEN,IENS,IR,LDL,RC,ROOT,RORERRDL,RORFDA,RORLOCK,RORMSG,RORTMP,RORTS,TMP
 D CLEAR^RORERR("LDLUPD^RORRP032",1)  K RESULTS
 S ECNT=0
 ;
 ;--- Check the parameters
 S RC=0  D  I RC<0  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . ;--- Registry IEN
 . I $G(REGIEN)'>0  D  Q
 . . S RC=$$ERROR^RORERR(-88,,,,"REGIEN",$G(REGIEN))
 . S REGIEN=+REGIEN
 . ;--- Code of the Drug Group
 . S GROUPIEN=$S($G(GROUP)>0:$$ITEMIEN^RORUTL09(4,REGIEN,GROUP),1:0)
 . I GROUPIEN<0  D  Q
 . . S RC=$$ERROR^RORERR(-88,,,,"GROUP",$G(GROUP))
 . S GROUP=+$G(GROUP)
 ;
 ;--- Lock the LOCAL DRUG NAME multiple
 S IENS=","_REGIEN_","
 S RC=$$LOCK^RORLOCK(798.129,IENS)
 I RC  D:RC>0  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . S RC=$$ERROR^RORERR(-11,,,,"the LOCAL DRUG NAME multiple")
 ;---
 S RORLOCK(798.129,IENS)=""
 S ROOT=$$ROOT^DILFD(798.129,IENS,1)
 ;
 ;--- Prepare the data
 S RORTMP=$$ALLOC^RORTMP(.RORTS)
 S IR="",RC=0
 F  S IR=$O(LDLST(IR))  Q:IR=""  D  Q:RC<0
 . ;--- Check if the drug is defined in the DRUG file
 . S DRUGIEN=+$P(LDLST(IR),U,3)
 . D ZERO^PSS50(DRUGIEN,,,,,RORTS)
 . Q:$G(@RORTMP@(0))'>0
 . ;--- Assign the default Group IEN (if the GROUP is provided)
 . I GROUPIEN>0  S LDL(GROUPIEN,DRUGIEN)=""  Q
 . ;--- Get IEN of the Drug Group
 . S TMP=+$P(LDLST(IR),U,4)
 . S GRPIEN=$$ITEMIEN^RORUTL09(4,REGIEN,TMP)
 . I GRPIEN'>0  D:GRPIEN<0  Q
 . . S RC=$$ERROR^RORERR(GRPIEN)
 . ;--- Create the reference
 . S LDL(GRPIEN,DRUGIEN)=""
 D FREE^RORTMP(RORTMP)
 I RC<0  D ERROR(.RESULTS,RC)  Q
 ;---
 I GROUPIEN'>0  S GRPIEN=""  D
 . F  S GRPIEN=$O(@ROOT@("G",GRPIEN))  Q:GRPIEN=""  S LDL(GRPIEN)=""
 E  S LDL(GROUPIEN)=""
 ;
 ;--- Update the multiple
 S IENS="?+1,"_REGIEN_",",ECNT=0
 S GRPIEN=""
 F  S GRPIEN=$O(LDL(GRPIEN))  Q:GRPIEN=""  D
 . ;--- Delete the old records
 . S DIK=$$OREF^DILF(ROOT),DA(1)=REGIEN
 . S DRUGIEN=""
 . F  S DRUGIEN=$O(@ROOT@("G",GRPIEN,DRUGIEN))  Q:DRUGIEN=""  D
 . . S DA=""
 . . F  S DA=$O(@ROOT@("G",GRPIEN,DRUGIEN,DA))  Q:DA=""  D ^DIK
 . ;--- Store the new records
 . S DRUGIEN=""
 . F  S DRUGIEN=$O(LDL(GRPIEN,DRUGIEN))  Q:DRUGIEN=""  D
 . . S RORFDA(798.129,IENS,.01)=DRUGIEN
 . . S RORFDA(798.129,IENS,.02)=GRPIEN
 . . D UPDATE^DIE(,"RORFDA",,"RORMSG")
 . . I $G(DIERR)  D  S ECNT=ECNT+1  Q
 . . . D DBS^RORERR("RORMSG",-9,,,798.129,IENS)
 ;
 ;--- Unlock the multiple and check for errors
 D UNLOCK^RORLOCK(798.129,","_REGIEN_",")
 I ECNT>0  D RPCSTK^RORERR(.RESULTS,-9)  Q
 ;--- Success
 S RESULTS(0)=0
 Q
