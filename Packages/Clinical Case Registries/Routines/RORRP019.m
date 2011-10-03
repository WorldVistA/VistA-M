RORRP019 ;HCIOFO/SG - RPC: LIST OF PATIENTS ; 5/26/06 12:03pm
 ;;1.5;CLINICAL CASE REGISTRIES;**1**;Feb 17, 2006;Build 24
 ;
 Q
 ;
 ;***** RETURNS THE LIST OF PATIENTS (EITHER FROM #798 OR #2)
 ; RPC: [ROR LIST PATIENTS]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; REGIEN        Registry IEN
 ;
 ; [DATE]        If the value of this parameter is greater than 0
 ;               and the 'C' flag is defined, then patients who
 ;               were confrmed in the registry before this date,
 ;               will be skipped.
 ;
 ; [PART]        The search pattern (partial match restriction).
 ;               If this parameter is a number preceded by the '`',
 ;               then a list containing only the patient with this
 ;               IEN is compiled.
 ;
 ; [FLAGS]       Flags that control the execution (can be combined):
 ;                 2  Search in the PATIENT file. By default, the
 ;                    ROR REGISTRY RECORD and ROR PATIENT files are
 ;                    queried. This flag overrides the 'C' and 'P'
 ;                    flags.
 ;                 B  Backwards. Traverses the index in the opposite
 ;                    direction of normal traversal.
 ;                 C  Include confirmed patients
 ;                 O  Add values of the optional fields
 ;                 P  Include pending patients
 ;
 ; [NUMBER]      Maximum number of entries to return. A value of "*"
 ;               or no value in this parameter designates all entries.
 ;
 ; [FROM]        The index entry(s) from which to begin the list.
 ;               You should use the pieces of the @RESULTS@(0) node
 ;               (starting from the second one) to continue the
 ;               listing in the subsequent procedure calls.
 ;
 ;               NOTE: The FROM value itself is not included in
 ;                     the resulting list.
 ;
 ; The ^TMP("DILIST",$J) global node is used by the procedure.
 ;
 ; See description of the LIST^DIC for more details about the
 ; PART, NUMBER and FROM parameters.
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0)
 ; indicates an error (see the RPCSTK^RORERR procedure for more
 ; details).
 ;
 ; Otherwise, number of patients and the value of the FROM
 ; parameter for the next procedure call are returned in the
 ; @RESULTS@(0) and the subsequent nodes of the global array
 ; contain the patients.
 ; 
 ; @RESULTS@(0)          Result Descriptor
 ;                         ^01: Number of patients
 ;                         ^02: Values that comprise the FROM
 ;                         ^nn: parameter for the subsequent call
 ;
 ; @RESULTS@(i)          Patient
 ;                         ...  See the $$LOAD2^RORRP020 (RORDEM)
 ;
 ; @RESULTS@(i+1)        Optional fields (these nodes are created only
 ;                       if the FLAGS parameter contains the 'O' flag)
 ;                         ^01: "O" (letter O)
 ;                         ...  See the $$LOAD798^RORRP020
 ;
PTLIST(RESULTS,REGIEN,DATE,PART,FLAGS,NUMBER,FROM) ;
 N BUF,I,RC,RORERRDL,RORMSG,TMP
 D CLEAR^RORERR("PTLIST^RORRP019",1)
 K RESULTS  S RESULTS=$NA(^TMP("DILIST",$J))  K @RESULTS
 ;
 ;=== Check the parameters
 S RC=0  D  I RC<0  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . ;--- Registry IEN
 . I $G(REGIEN)'>0  D  Q
 . . S RC=$$ERROR^RORERR(-88,,,,"REGIEN",$G(REGIEN))
 . S REGIEN=+REGIEN
 . ;--- Flags and date
 . S FLAGS=$$UP^XLFSTR($G(FLAGS)),DATE=+$G(DATE)
 . S TMP=$TR(FLAGS,"CP")
 . ;- The '2' flag overrides all flags related to the CCR files.
 . I FLAGS["2"  S FLAGS=TMP
 . ;- By default, all registry patients are included
 . ;- (except those who are marked for deletion).
 . E  I TMP=FLAGS  S FLAGS=FLAGS_"CP"
 . ;- If the date is provided, then make sure that confirmed
 . ;- registry patients are included in the search (the 'C' flag).
 . E  S:DATE>0 FLAGS=FLAGS_"C"
 . ;--- Others
 . S PART=$G(PART),FROM=$G(FROM)
 . S NUMBER=$S($G(NUMBER)>0:+NUMBER,1:"*")
 ;
 ;=== Setup the starting point
 F I=1:1  S TMP=$P(FROM,U,I)  Q:TMP=""  S FROM(I)=TMP
 S FROM=$G(FROM(1))
 ;
 ;=== Query the file
 S RC=0  D
 . ;--- Decode coded SSN of a registry patient
 . I PART?1"#"1.11N.1"P"  D
 . . S PART=$$XOR^RORUTL03($P(PART,"#",2))
 . . S TMP=$S(PART["P":10,1:9)
 . . S:$L(PART)<TMP PART=$TR($J(PART,TMP)," ","0")
 . . S FLAGS=$TR(FLAGS,"2CP")_"CP"
 . ;--- Load a single patient with the provided IEN
 . I PART?1"`"1.N  D  Q
 . . I FLAGS'["2"  Q:$$PRRIEN^RORUTL01($P(PART,"`",2),REGIEN)'>0
 . . D FIND^DIC(2,,"@","P",PART,"*","#",,,,"RORMSG")
 . . S:$G(DIERR) RC=$$DBS^RORERR("RORMSG",-9,,,2)
 . ;--- List of patients from PATIENT file (#2)
 . I FLAGS["2"  D  Q
 . . S RC=$$LST2(REGIEN,PART,FLAGS,NUMBER,.FROM)
 . ;--- List of registry patients
 . S RC=$$LST798(REGIEN,DATE,PART,FLAGS,NUMBER,.FROM)
 ;
 ;=== Check for the error(s)
 I RC<0  D  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . K ^TMP("DILIST",$J)
 ;
 ;=== Post-processing
 S RC=$$POSTPROC^RORRP020(RESULTS,REGIEN,FLAGS)
 I RC<0  D RPCSTK^RORERR(.RESULTS,RC)  Q
 ;
 ;=== Success
 S TMP=$G(^TMP("DILIST",$J,0)),BUF=+$P(TMP,U)
 K ^TMP("DILIST",$J,0)
 I $P(TMP,U,3)  S I=0  D
 . F  S I=$O(FROM(I))  Q:I'>0  S TMP=FROM(I)  S:TMP'="" BUF=BUF_U_TMP
 S @RESULTS@(0)=BUF
 Q
 ;
 ;***** QUERIES THE 'PATIENT' FILE (#2)
 ;
 ; RORREG        Registry IEN
 ;
 ; PART          The partial match restriction
 ;
 ; FLAGS         Flags that control the execution
 ;
 ; NUMBER        Maximum number of entries to return
 ;
 ; .FROM         Reference to a local variable that contains the
 ;               starting point for the LIST^DIC. The new point is
 ;               returned in this variable as well.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
LST2(RORREG,PART,FLAGS,NUMBER,FROM) ;
 N RC,RORMSG,SCR,TMP,XREF
 ;--- Select the cross-reference
 S XREF=$S(PART?4N:"BS",PART?1U4N:"BS5",PART?9N.1"P":"SSN",1:"B")
 ;--- Compile the screen logic (be careful with naked references)
 S SCR="I '$$SKIPEMPL^RORUTL02(+Y,.RORREG)"
 ;--- Get the list of patients
 S TMP="P"_$S(FLAGS["B":"B",1:"")_$S(XREF="B":"M",1:"")
 D LIST^DIC(2,,"@",TMP,NUMBER,.FROM,PART,XREF,SCR,,,"RORMSG")
 S:$G(DIERR) RC=$$DBS^RORERR("RORMSG",-9,,,2)
 ;---
 Q $S($G(RC)<0:RC,1:0)
 ;
 ;***** QUERIES THE CCR FILES (#798 OR #798.4)
 ;
 ; REGIEN        Registry IEN
 ;
 ; RORDT         Ignore patients who were confirmed in the registry
 ;               before the provided date (if the FLAGS parameter
 ;               contains the "C" flag)
 ;
 ; PART          The partial match restriction
 ;
 ; FLAGS         Flags that control the execution
 ;
 ; NUMBER        Maximum number of entries to return
 ;
 ; .FROM         Reference to a local variable that contains the
 ;               starting point for the LIST^DIC. The new point is
 ;               returned in this variable as well.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
LST798(REGIEN,RORDT,PART,FLAGS,NUMBER,FROM) ;
 N APART,RC,RORMSG,RORPS,SCR,TMP,XREF
 S RC=0
 ;--- Analyze the parameters
 S:FLAGS["C" RORPS(0)=""  ; Confirmed
 S:FLAGS["P" RORPS(4)=""  ; Pending
 S XREF=$S(PART?4N:"BS",PART?1U4N:"BS5",PART?9N.1"P":"SSN",1:"")
 ;--- Select the appropriate CCR file and perform the query
 I XREF'=""  D
 . S SCR="S D=$O(^RORDATA(798,""KEY"",+Y,"_REGIEN_",0)) "
 . S SCR=SCR_"I D>0 S D=$G(^RORDATA(798,D,0)) "
 . S SCR=SCR_"I $D(RORPS(+$P(D,U,5))) "
 . ;--- If the confirmation threshold is provided, add the
 . ;    screen code and check if there is at least one record
 . ;--- that conforms the confirmation date criterion
 . I RORDT>0  D  Q:'$D(SCR)
 . . I FLAGS["B"  D  Q
 . . . S SCR=SCR_"I $P(D,U,4)'>RORDT "
 . . . K:$O(^RORDATA(798,"ARCP",REGIEN_"#",""))>RORDT SCR
 . . ;---
 . . S SCR=SCR_"I $P(D,U,4)'<RORDT "
 . . K:$O(^RORDATA(798,"ARCP",REGIEN_"#",""),-1)<RORDT SCR
 . ;--- Query the ROR PATIENT file
 . S TMP="P"_$S(FLAGS["B":"B",1:"")
 . D LIST^DIC(798.4,,"@",TMP,NUMBER,.FROM,PART,XREF,SCR,,,"RORMSG")
 . S:$G(DIERR) RC=$$DBS^RORERR("RORMSG",-9,,,798.4)
 E  D
 . S APART(1)=REGIEN_"#"
 . S FROM(1)=$S(FLAGS["B":"~",1:" ")
 . S SCR="S D=+$P($G(^(0)),U,5) I $D(RORPS(D)) "
 . ;---
 . I RORDT>0  S XREF="ARCP",APART(3)=PART  D:$G(FROM(2))=""
 . . S FROM(2)=$$FMADD^XLFDT(RORDT,,,,$S(FLAGS["B":1,1:-1))
 . E  S XREF="ARP",APART(2)=PART
 . ;--- Query the ROR REGISTRY RECORD file
 . S TMP="P"_$S(FLAGS["B":"B",1:"")
 . D LIST^DIC(798,,"@;.01I",TMP,NUMBER,.FROM,.APART,XREF,SCR,,,"RORMSG")
 . S:$G(DIERR) RC=$$DBS^RORERR("RORMSG",-9,,,798)
 ;---
 Q $S($G(RC)<0:RC,1:0)
