RORRP023 ;HCIOFO/SG - RPC: REGISTRY COORDINATORS ; 7/16/03 11:25am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ; This routine uses the following IAs:
 ;
 ; #10060        Read access (FileMan) to the file #200 (supported)
 ;
 Q
 ;
 ;***** RETURNS THE LIST OF REGISTRY COORDINATORS
 ; RPC: [ROR LIST COORDINATORS]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; REGIEN        Registry IEN
 ;
 ; The ^TMP("DILIST",$J) global node is used by the procedure.
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0)
 ; indicates an error (see the RPCSTK^RORERR procedure for more
 ; details).
 ;
 ; Otherwise, number of coordinators is returned in the
 ; @RESULTS@(0) and the subsequent nodes of the global array
 ; contain the coordinators.
 ; 
 ; @RESULTS@(0)          Number of Coordinators
 ;
 ; @RESULTS@(i)          Coordinator's Descriptor
 ;                         ^01: IEN
 ;                         ^02: Name
 ;
RCLIST(RESULTS,REGIEN) ;
 N IENS,RC,RORERRDL,RORMSG,TMP
 D CLEAR^RORERR("RCLIST^RORRP023",1)
 K RESULTS  S RESULTS=$NA(^TMP("DILIST",$J))  K @RESULTS
 ;--- Check the parameters
 S RC=0  D  I RC<0  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . ;--- Registry IEN
 . I $G(REGIEN)'>0  D  Q
 . . S RC=$$ERROR^RORERR(-88,,,,"REGIEN",$G(REGIEN))
 . S REGIEN=+REGIEN
 ;--- Get the list of coordinators
 S IENS=","_REGIEN_",",TMP="@;.01E"
 D LIST^DIC(798.114,IENS,TMP,"PU",,,,"B",,,,"RORMSG")
 I $G(DIERR)  D  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . S RC=$$DBS^RORERR("RORMSG",-9,,,798.114,IENS)
 ;--- Success
 S TMP=+$G(^TMP("DILIST",$J,0))
 K ^TMP("DILIST",$J,0)  S @RESULTS@(0)=TMP
 Q
 ;
 ;***** UPDATES THE LIST OF REGISTRY COORDINATORS
 ; RPC: [ROR UPDATE COORDINATORS]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; REGIEN        Registry IEN
 ;
 ; .RCLST(       Reference to a local variable that contains
 ;               a list of registry coordinators
 ;   i)            User IEN (DUZ)
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0)
 ; indicates an error (see the RPCSTK^RORERR procedure for more
 ; details).
 ;
 ; Otherwise, zero is returned in the RESULTS(0).
 ;
RCLUPD(RESULTS,REGIEN,RCLST) ;
 N DA,DIK,ECNT,IEN,IENS,RC,RCL,ROOT,RORERRDL,RORFDA,RORIEN,RORMSG,TMP
 D CLEAR^RORERR("RCLUPD^RORRP023",1)  K RESULTS
 ;--- Check the parameters
 S RC=0  D  I RC<0  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . ;--- Registry IEN
 . I $G(REGIEN)'>0  D  Q
 . . S RC=$$ERROR^RORERR(-88,,,,"REGIEN",$G(REGIEN))
 . S REGIEN=+REGIEN
 ;
 ;--- Lock the COORDINATOR multiple
 S IENS=","_REGIEN_","
 S RC=$$LOCK^RORLOCK(798.114,IENS)
 I RC  D:RC>0  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . S RC=$$ERROR^RORERR(-11,,,,"the COORDINATOR multiple")
 ;---
 S ROOT=$$ROOT^DILFD(798.114,IENS,1)
 ;
 ;--- Create a list of coordinators' IENs
 S TMP=""
 F  S TMP=$O(RCLST(TMP))  Q:TMP=""  D
 . S IEN=+RCLST(TMP)
 . S:$$FIND1^DIC(200,,,"`"_IEN,,,"RORMSG")>0 RCL(IEN)=""
 ;
 ;--- Delete the coordinators
 S DIK=$$OREF^DILF(ROOT),DA(1)=REGIEN,DA=0
 F  S DA=$O(@ROOT@(DA))  Q:DA'>0  D:'$D(RCL(DA)) ^DIK
 ;--- Update the coordinators
 S (ECNT,IEN)=0,IENS="?+1,"_REGIEN_","
 F  S IEN=$O(RCL(IEN))  Q:IEN'>0  D
 . S RORFDA(798.114,IENS,.01)=IEN
 . S RORIEN(1)=IEN
 . D UPDATE^DIE(,"RORFDA","RORIEN","RORMSG")
 . I $G(DIERR)  D  S ECNT=ECNT+1  Q
 . . S RC=$$DBS^RORERR("RORMSG",-9,,,798.114,IENS)
 ;
 ;--- Unlock the multiple and check for errors
 D UNLOCK^RORLOCK(798.114,","_REGIEN_",")
 I ECNT>0  D RPCSTK^RORERR(.RESULTS,-9)  Q
 ;--- Success
 S RESULTS(0)=0
 Q
