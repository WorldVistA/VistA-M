RORRP018 ;HCIOFO/SG - RPC: LIST OF LAB TESTS ; 10/19/05 8:23am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ; This routine uses the following IAs:
 ;
 ; #91           Access to the LABORATORY TEST file
 ;
 Q
 ;
 ;***** RETURNS THE LIST OF LAB TESTS
 ; RPC: [ROR LIST LABORATORY TESTS]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; [SUBSCR]      List of the test subscripts (separated by commas)
 ;               to include. By default ($G(SUBSCR)=""), all tests
 ;               are retrieved.
 ;
 ; [PART]        The partial match restriction.
 ;
 ; [FLAGS]       Flags that control the execution (can be combined):
 ;                 B  Backwards. Traverses the index in the opposite
 ;                    direction of normal traversal
 ;                 P  Include panels (by default, the panels are
 ;                    excluded from the list)
 ;
 ; [NUMBER]      Maximum number of entries to return. A value of "*"
 ;               or no value in this parameter designates all entries.
 ;
 ; [FROM]        The index entry(s) from which to begin the list
 ;                 ^01: FromName
 ;                 ^02: FromIEN
 ;
 ;               For example, a FROM value of "AD" would list entries
 ;               following AD. You can use the 2-nd and 3-rd "^"-
 ;               pieces of the @RESULTS@(0) node to continue the
 ;               listing in the subsequent procedure calls.
 ;
 ;               NOTE: The FROM value itself is not included in
 ;                     the resulting list.
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
 ; Otherwise, number of lab tests and the value of the FROM
 ; parameter for the next procedure call are returned in the
 ; @RESULTS@(0) and the subsequent nodes of the global array
 ; contain the tests.
 ; 
 ; @RESULTS@(0)          Result Descriptor
 ;                         ^01: Number of tests
 ;                         ^02: FromName
 ;                         ^03: FromIEN
 ;
 ; @RESULTS@(i)          Lab Test
 ;                         ^01: IEN
 ;                         ^02: Test Name
 ;                         ^03: Subscript (internal)
 ;                         ^04: Panel {""|1}
 ;
LABTLIST(RESULTS,SUBSCR,PART,FLAGS,NUMBER,FROM) ;
 N BUF,I,RC,RORERRDL,RORMSG,RORSUBS,SCR,TMP
 D CLEAR^RORERR("LABTLIST^RORRP018",1)
 K RESULTS  S RESULTS=$$ALLOC^RORTMP()
 ;--- Check the parameters
 S SUBSCR=$$UP^XLFSTR($TR($G(SUBSCR)," "))
 F I=1:1  S TMP=$P(SUBSCR,",",I)  Q:TMP=""  S RORSUBS(TMP)=""
 S PART=$G(PART),FLAGS=$G(FLAGS)
 S NUMBER=$S($G(NUMBER)>0:+NUMBER,1:"*")
 ;--- Setup the start point
 I $G(FROM)'=""  D  S FROM=$P(FROM,U)
 . S:$P(FROM,U,2)>0 FROM("IEN")=+$P(FROM,U,2)
 ;--- Compile the screen logic (be careful with naked references)
 S SCR=""
 D:$D(RORSUBS)>0
 . S SCR=SCR_"S D=$P($G(^(0)),U,4) I D'="""",$D(RORSUBS(D)) "
 S:FLAGS'["P" SCR=SCR_"I $O(^(2,0))'>0 "  ; Exclude panels
 ;--- Get the list of tests
 S BUF="@;.01;4I",TMP="PM"_$S(FLAGS["B":"B",1:"")
 D LIST^DIC(60,,BUF,TMP,NUMBER,.FROM,PART,"B",SCR,,RESULTS,"RORMSG")
 I $G(DIERR)  D  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . S RC=$$DBS^RORERR("RORMSG",-9,,,60)
 . D FREE^RORTMP(RESULTS)
 S RESULTS=$NA(@RESULTS@("DILIST"))
 ;--- Post processing
 D:FLAGS["P"
 . ;--- Mark the Lab panels
 . S I=0
 . F  S I=$O(@RESULTS@(I))  Q:I'>0  D
 . . S IEN=+$P(@RESULTS@(I,0),U)
 . . S TMP=$$GET1^DIQ(60,IEN_",","COUNT(#200)",,,"RORMSG")
 . . S:TMP>0 $P(@RESULTS@(I,0),U,4)=1
 ;--- Success
 S TMP=$G(@RESULTS@(0)),BUF=+$P(TMP,U)
 K @RESULTS@(0)
 S:$P(TMP,U,3) $P(BUF,U,2,3)=$G(FROM)_U_$G(FROM("IEN"))
 S @RESULTS@(0)=BUF
 Q
