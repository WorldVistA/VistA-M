RORRP035 ;HCIOFO/SG - RPC: GENERIC DRUG NAMES ; 10/18/05 12:10pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** RETURNS THE LIST OF GENERIC DRUGS
 ; RPC: [ROR LIST GENERIC DRUGS]
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
 ;                         ^01: IEN in the ROR GENERIC DRUG file
 ;                         ^02: Generic drug name
 ;                         ^03: IEN of the generic drug (file #50.6)
 ;                         ^04: Code of the Drug Group
 ;
GDLIST(RESULTS,REGIEN,GROUP) ;
 N GROUPIEN,IENS,IR,PART,RC,RORERRDL,RORMSG,SCR,TMP
 D CLEAR^RORERR("GDLIST^RORRP032",1)
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
 S:GROUPIEN>0 SCR=SCR_"I $P($G(^(0)),U,3)="_GROUPIEN_" "
 ;--- Get the list of drugs
 S TMP="@;.04E;.04I;.03I",PART(1)=REGIEN_"#"
 D LIST^DIC(799.51,,TMP,"PU",,,.PART,"ARDG",SCR,,,"RORMSG")
 I $G(DIERR)  D  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . S RC=$$DBS^RORERR("RORMSG",-9,,,799.51)
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
