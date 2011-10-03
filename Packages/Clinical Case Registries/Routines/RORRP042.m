RORRP042 ;HCIOFO/SG - RPC: CPT CODES ; 11/10/05 9:21am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ; This routine uses the following IAs:
 ;
 ; #1995          $$CPT^ICPTCOD (supported)
 ; #2815          Access to the file #81 (supported)
 ;
 Q
 ;
 ;***** RETURNS THE LIST OF CPT CODES
 ; RPC: [ROR LIST CPT]
 ;
 ; .RORESULT     Reference to a local variable where the results
 ;               are returned to.
 ;
 ; [DATE]        Date for the code set versioning.
 ;
 ; [PART]        The partial match restriction.
 ;
 ; [FLAGS]       Flags that control the execution (can be combined):
 ;                 A  Exclude active codes
 ;                 B  Backwards. Traverses the index in the opposite
 ;                    direction of normal traversal
 ;                 D  Full search by short name
 ;                 I  Exclude inactive codes
 ;                 K  Search in description keywords
 ;
 ; [NUMBER]      Maximum number of entries to return. A value of "*"
 ;               or no value in this parameter designates all entries.
 ;
 ; [FROM]        The index entry(s) from which to begin the list
 ;                 ^01: FromName
 ;                 ^02: FromIEN
 ;
 ;               For example, a FROM value of "51" would list entries
 ;               following 51. You can use the 2-nd and 3-rd "^"-
 ;               pieces of the @RORESULT@(0) node to continue the
 ;               listing in the subsequent procedure calls.
 ;
 ;               NOTE: The FROM value itself is not included in
 ;                     the resulting list.
 ;
 ; See description of the LIST^DIC for more details about the
 ; PART, NUMBER and FROM parameters.
 ;
 ; The ^TMP("RORRP042",$J) global node is used by this procedure.
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the @RORESULT@(0)
 ; indicates an error (see the RPCSTK^RORERR procedure for more
 ; details).
 ;
 ; Otherwise, number of CPT codes and the value of the FROM
 ; parameter for the next procedure call are returned in the
 ; @RORESULT@(0) and the subsequent nodes of the global array
 ; contain the codes.
 ; 
 ; @RORESULT@(0)         Result Descriptor
 ;                         ^01: Number of codes
 ;                         ^02: FromName
 ;                         ^03: FromIEN
 ;
 ; @RORESULT@(i)         CPT
 ;                         ^01: IEN
 ;                         ^02: Short Name
 ;                         ^03: Code
 ;                         ^04: reserved
 ;                         ^05: Inactive {0|1}
 ;                         ^06: Inactivation Date (FileMan)
 ;
CPTLIST(RORESULT,DATE,PART,FLAGS,NUMBER,FROM) ;
 N BUF,RC,RORERRDL,TMP
 D CLEAR^RORERR("CPTLIST^RORRP042",1)
 K RORESULT  S RORESULT=$NA(^TMP("RORRP042",$J))  K @RORESULT
 ;--- Check the parameters
 S PART=$G(PART),FLAGS=$G(FLAGS)
 S NUMBER=$S($G(NUMBER)>0:+NUMBER,1:"*")
 ;--- Setup the start point
 I $G(FROM)'=""  D  S FROM=$P(FROM,U)
 . S:$P(FROM,U,2)>0 FROM("IEN")=+$P(FROM,U,2)
 ;--- Get the list of CPT codes
 S RC=$$QUERY(PART,FLAGS,NUMBER,.FROM)
 I RC<0  D RPCSTK^RORERR(.RORESULT,RC)  Q
 S RORESULT=$NA(@RORESULT@("DILIST"))
 ;--- Load remaining data and refine the list
 D REFINE($G(DATE),FLAGS)
 ;--- Success
 S TMP=$G(@RORESULT@(0)),BUF=+$P(TMP,U)
 S:$P(TMP,U,3) $P(BUF,U,2,3)=$G(FROM)_U_$G(FROM("IEN"))
 K @RORESULT@(0)  S @RORESULT@(0)=BUF
 Q
 ;
 ;***** QUERIES THE CPT FILE (#81)
QUERY(PART,FLAGS,NR,FROM) ;
 N FLDS,RORMSG,SCR,TMP,XREF
 ;--- Compile the screen logic (be careful with naked references)
 S SCR=""
 I FLAGS["D"  S:PART'="" SCR=SCR_"I $P(D,U,2)["""_PART_""" ",PART=""
 S:SCR'="" SCR="S D=$G(^(0)) "_SCR
 ;--- Get the list of codes and some data
 S FLDS="@;.01;.01",TMP="P"_$S(FLAGS["B":"B",1:"")
 S XREF=$S(FLAGS["D":"#",FLAGS["K":"C",1:"B")
 D LIST^DIC(81,,FLDS,TMP,NR,.FROM,PART,XREF,SCR,,RORESULT,"RORMSG")
 I $G(DIERR)  K @RORESULT  Q $$DBS^RORERR("RORMSG",-9,,,80)
 ;--- Success
 Q 0
 ;
 ;***** REFINES THE LIST OF CPT CODES
REFINE(DATE,FLAGS) ;
 N BUF,CNT,CPTINFO,RORDESC,SUBS,TMP
 S (CNT,SUBS)=0
 F  S SUBS=$O(@RORESULT@(SUBS)) Q:SUBS'>0  D
 . S BUF=@RORESULT@(SUBS,0)
 . S CPTINFO=$$CPT^ICPTCOD(+$P(BUF,U),DATE)
 . I CPTINFO<0  K @RORESULT@(SUBS)  Q
 . ;--- Screen active/inactive records
 . S TMP=+$P(CPTINFO,U,7)                      ; Status
 . I $S(TMP:FLAGS["A",1:FLAGS["I")  K @RORESULT@(SUBS)  Q
 . S $P(BUF,U,5)=TMP
 . S $P(BUF,U,6)=$S(TMP:$P(CPTINFO,U,8),1:"")  ; Inactivation Date
 . ;--- Versioned short name
 . S TMP=$P(CPTINFO,U,3)  S:TMP'="" $P(BUF,U,2)=TMP
 . ;--- Store the data
 . S CNT=CNT+1,@RORESULT@(SUBS,0)=BUF
 ;---
 S $P(@RORESULT@(0),U)=CNT
 Q
