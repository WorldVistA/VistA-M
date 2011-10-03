RORRP029 ;HCIOFO/SG - RPC: ADDRESS UTILITIES ; 4/16/03 9:35am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ; This routine uses the following IAs:
 ;
 ; #10056        Read access to the STATE file (#5)
 ;
 Q
 ;
 ;***** RETURNS THE LIST OF STATES
 ; RPC: [ROR LIST STATES]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; PART          The search pattern (partial match restriction)
 ;
 ; [FLAGS]       Flags that control the execution (can be combined):
 ;                 A  Enable abbreviation search (if PART contains 2
 ;                    character abbreviation, the corresponding state 
 ;                    is returned. Otherwise, the regular search is
 ;                    performed).
 ;                 B  Backwards. Traverses the index in the opposite
 ;                    direction of normal traversal.
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
 ; A negative value of the first "^"-piece of the @RESULTS@(0)
 ; indicates an error (see the RPCSTK^RORERR procedure for more
 ; details).
 ;
 ; Otherwise, number of states and the value of the FROM
 ; parameter for the next procedure call are returned in the
 ; @RESULTS@(0) and the subsequent nodes of the global array
 ; contain the states.
 ; 
 ; @RESULTS@(0)          Result Descriptor
 ;                         ^01: Number of states
 ;                         ^02: Values that comprise the FROM
 ;                         ^nn: parameter for the subsequent call
 ;
 ; @RESULTS@(i)          State
 ;                         ^01: IEN
 ;                         ^02: Name
 ;                         ^03: Abbreviation
 ;                         ^04: VA State Code
 ;
STATELST(RESULTS,PART,FLAGS,NUMBER,FROM) ;
 N BUF,FIELDS,I,RC,RORERRDL,TMP
 D CLEAR^RORERR("STATELST^RORRP029",1)
 K RESULTS  S RESULTS=$NA(^TMP("DILIST",$J))  K @RESULTS
 S FIELDS="@;.01;1;2"
 ;--- Check the parameters
 S RC=0  D  I RC<0  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . ;--- Flags
 . S FLAGS=$$UP^XLFSTR($G(FLAGS))
 . ;--- Others
 . S PART=$G(PART),FROM=$G(FROM)
 . S NUMBER=$S($G(NUMBER)>0:+NUMBER,1:"*")
 ;--- Setup the start point
 F I=1:1  S TMP=$P(FROM,U,I)  Q:TMP=""  S FROM(I)=TMP
 S FROM=$G(FROM(1))
 ;--- Check for the abbreviation
 S RC=0
 I FLAGS["A",$L(PART)=2  D  I RC<0  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . D LIST^DIC(5,,FIELDS,"P",2,,PART,"C",,,,"RORMSG")
 . I $G(DIERR)  S RC=$$DBS^RORERR("RORMSG",-9,,,5)  Q
 . S:+$G(^TMP("DILIST",$J,0))=1 RC=1
 ;--- Query the file
 I 'RC  D  I RC<0  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . S TMP="P"_$S(FLAGS["B":"B",1:"")
 . D LIST^DIC(5,,FIELDS,TMP,NUMBER,.FROM,PART,"B",,,,"RORMSG")
 . I $G(DIERR)  S RC=$$DBS^RORERR("RORMSG",-9,,,5)  Q
 ;--- Success
 S TMP=$G(^TMP("DILIST",$J,0)),BUF=+$P(TMP,U)
 K ^TMP("DILIST",$J,0)
 I $P(TMP,U,3)  S I=0  D
 . F  S I=$O(FROM(I))  Q:I'>0  S TMP=FROM(I)  S:TMP'="" BUF=BUF_U_TMP
 S @RESULTS@(0)=BUF
 Q
