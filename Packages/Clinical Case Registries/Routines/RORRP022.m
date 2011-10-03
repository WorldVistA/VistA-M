RORRP022 ;HCIOFO/SG - RPC: SELECTION RULES ; 8/2/05 11:15am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** LOADS THE SELECTION RULES FROM THE REGISTRY RECORD
 ; RPC: [ROR PATIENT SELECTION RULES]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; REGIEN        Registry IEN
 ;
 ; PATIEN        IEN of the registry patient (DFN)
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0)
 ; indicates an error (see the RPCSTK^RORERR procedure for more
 ; details).
 ;
 ; Otherwise, number of selection rules is returned in the RESULTS(0)
 ; and the subsequent nodes of the array contain the rules.
 ; 
 ; RESULTS(0)            Number of selection rules
 ;
 ; RESULTS(i)            Selection Rule
 ;                         ^01: IEN in the SELECTION RULE multiple
 ;                              of the ROR REGISTRY RECORD file
 ;                         ^02: IEN of the Rule (in the
 ;                              ROR SELECTION RULE file)
 ;                         ^03: Name of the Rule
 ;                         ^04: Date (FileMan)
 ;                         ^05: Location IEN  (Institution IEN)
 ;                         ^06: Location Name (Institution Name)
 ;                         ^07: Short Description
 ;
PTRULES(RESULTS,REGIEN,PATIEN) ;
 N BUF,CNT,I,IEN,IENS,RC,RORBUF,RORMSG,TMP
 D CLEAR^RORERR("PTRULES^RORRP022",1)
 K RESULTS  S RESULTS(0)=0
 ;--- Check the parameters
 S RC=0  D  I RC<0  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . ;--- Registry IEN
 . I $G(REGIEN)'>0  D  Q
 . . S RC=$$ERROR^RORERR(-88,,,,"REGIEN",$G(REGIEN))
 . S REGIEN=+REGIEN
 . ;--- Patient IEN
 . I $G(PATIEN)'>0  D  Q
 . . S RC=$$ERROR^RORERR(-88,,,,"PATIEN",$G(PATIEN))
 . S PATIEN=+PATIEN
 ;--- Get the IEN of the registry record
 S IEN=$$PRRIEN^RORUTL01(PATIEN,REGIEN)  Q:IEN'>0
 ;--- Load the selection rules
 S IENS=","_IEN_",",TMP="@;.01I;.01E;1I;2I;2E"
 D LIST^DIC(798.01,IENS,TMP,"P",,,,"AD",,,"RORBUF","RORMSG")
 I $G(DIERR)  D  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . S RC=$$DBS^RORERR("RORMSG",-9,,,798.01,IENS)
 ;--- Populate the output array
 S (CNT,I)=0
 F  S I=$O(RORBUF("DILIST",I))  Q:I'>0  D
 . S BUF=RORBUF("DILIST",I,0),IEN=+$P(BUF,U,2)  Q:IEN'>0
 . S CNT=CNT+1,RESULTS(CNT)=BUF
 . S TMP=$$GET1^DIQ(798.2,IEN_",",4,,,"RORMSG")
 . S $P(RESULTS(CNT),U,7)=$S(TMP'="":TMP,1:$P(BUF,U,3))
 S RESULTS(0)=CNT
 Q
