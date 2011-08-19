RORRP015 ;HCIOFO/SG - RPC: DIVISIONS AND HOSPITAL LOCATIONS ; 3/13/06 9:25am
 ;;1.5;CLINICAL CASE REGISTRIES;**1**;Feb 17, 2006;Build 24
 ;
 ; This routine uses the following IAs:
 ;
 ; #1246         WIN^DGPMDDCF (supported)
 ; #2438         Access to the file #40.8 (controlled)
 ; #10040        Access to the HOSPITAL LOCATION file (supported)
 ;
 Q
 ;
 ;***** CHECKS IF THE HOSPITAL LOCATION IS ACTIVE
 ;
 ; LOCIEN        IEN of the hospital location
 ;
ACTLOC(LOCIEN) ;
 N D0,DGPMOS,RDT,X
 Q:$G(^SC(LOCIEN,"OOS")) 0              ; An OOS entry
 S D0=+$G(^SC(LOCIEN,42))
 I D0>0  D WIN^DGPMDDCF  Q 'X           ; Check if ward is inactive
 S X=$G(^SC(LOCIEN,"I"))  Q:'$P(X,U) 1  ; No inactivation date
 S RDT=+$P(X,U,2)
 I DT>$P(X,U)  Q:'RDT!(DT<RDT) 0        ; Check reactivation date
 Q 1
 ;
 ;***** RETURNS THE LIST OF DIVISIONS
 ; RPC: [ROR LIST DIVISIONS]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; [PART]        The partial match restriction.
 ;
 ; [FLAGS]       Flags that control the execution (can be combined)
 ;                 B  Backwards. Traverses the index in the opposite
 ;                    direction of normal traversal.
 ;
 ; [NUMBER]      Maximum number of entries to return. A value of "*"
 ;               or no value in this parameter designates all entries.
 ;
 ; [FROM]        The index entry(s) from which to begin the list
 ;                 ^01: FromName
 ;                 ^02: FromIEN
 ;
 ;               For example, a FROM value of "VA" would list entries
 ;               following VA. You can use the 2-nd and 3-rd "^"-
 ;               pieces of the @RESULTS@(0) node to continue the
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
 ; Otherwise, number of divisions and the value of the FROM parameter
 ; for the next procedure call are returned in the @RESULTS@(0) and
 ; the subsequent nodes of the global array contain the divisions.
 ; 
 ; @RESULTS@(0)          Result Descriptor
 ;                         ^01: Number of divisions
 ;                         ^02: FromName
 ;                         ^03: FromIEN
 ;
 ; @RESULTS@(i)          Division
 ;                         ^01: IEN
 ;                         ^02: Name
 ;                         ^03: Facility Number
 ;                         ^04: Institution IEN
 ;
DIVLIST(RESULTS,PART,FLAGS,NUMBER,FROM) ;
 N BUF,RC,RORERRDL,RORMSG,TMP
 D CLEAR^RORERR("DIVLIST^RORRP015",1)
 K RESULTS  S RESULTS=$NA(^TMP("DILIST",$J))  K @RESULTS
 ;--- Check the parameters
 S PART=$G(PART),FLAGS=$G(FLAGS)
 S NUMBER=$S($G(NUMBER)>0:+NUMBER,1:"*")
 ;--- Setup the start point
 I $G(FROM)'=""  D  S FROM=$P(FROM,U)
 . S:$P(FROM,U,2)>0 FROM("IEN")=+$P(FROM,U,2)
 ;--- Get the list of divisions
 S BUF="@;.01;1;.07I",TMP="P"_$S(FLAGS["B":"B",1:"")
 D LIST^DIC(40.8,,BUF,TMP,NUMBER,.FROM,PART,"B",,,,"RORMSG")
 I $G(DIERR)  D  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . S RC=$$DBS^RORERR("RORMSG",-9,,,40.8)
 . K ^TMP("DILIST",$J)
 ;--- Success
 S TMP=$G(^TMP("DILIST",$J,0)),BUF=+$P(TMP,U)
 K ^TMP("DILIST",$J,0)
 S:$P(TMP,U,3) $P(BUF,U,2,3)=$G(FROM)_U_$G(FROM("IEN"))
 S @RESULTS@(0)=BUF
 Q
 ;
 ;***** RETURNS THE LIST OF HOSPITAL LOCATIONS
 ; RPC: [ROR LIST HOSPITAL LOCATIONS]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; [HLTYPES]     List of location types separated by commas (internal
 ;               values of the TYPE field of the HOSPITAL LOCATION
 ;               file). Only locations of the types defined by this
 ;               parameter are selected by the procedure. By default
 ;               ($G(HLTYPES)=""), all locations are selected.
 ;
 ; [DIVIEN]      Division IEN. If this parameter is defined and
 ;               greater than zero then only the locations associated 
 ;               with this division will be selected.
 ;
 ; [PART]        The partial match restriction.
 ;
 ; [FLAGS]       Flags that control the execution (can be combined):
 ;                 A  Include active locations (default)
 ;                 B  Backwards. Traverses the index in the opposite
 ;                    direction of normal traversal.
 ;                 I  Include inactive locations
 ;
 ; [NUMBER]      Maximum number of entries to return. A value of "*"
 ;               or no value in this parameter designates all entries.
 ;
 ; [FROM]        The index entry(s) from which to begin the list
 ;                 ^01: FromName
 ;                 ^02: FromIEN
 ;
 ;               For example, a FROM value of "VA" would list entries
 ;               following VA. You can use the 2-nd and 3-rd "^"-
 ;               pieces of the @RESULTS@(0) node to continue the
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
 ; Otherwise, number of hospital locations and the value of the
 ; FROM parameter for the next procedure call are returned in
 ; the @RESULTS@(0) and the subsequent nodes of the global array
 ; contain the locations.
 ; 
 ; @RESULTS@(0)          Result Descriptor
 ;                         ^01: Number of locations
 ;                         ^02: FromName
 ;                         ^03: FromIEN
 ;
 ; @RESULTS@(i)          Hospital Location
 ;                         ^01: IEN
 ;                         ^02: Name
 ;                         ^03: Type (internal)
 ;                         ^04: Institution IEN
 ;                         ^05: Division IEN
 ;                         ^06: Active (0/1)
 ;
 ; NOTE: The 6th "^"-piece of the location record (Active) is
 ;       populated only if both "A" and "I" flags are used.
 ;
HLOCLIST(RESULTS,HLTYPES,DIVIEN,PART,FLAGS,NUMBER,FROM) ;
 N BUF,I,RC,RORERRDL,RORHLT,RORMSG,SCR,TMP
 D CLEAR^RORERR("HLOCLIST^RORRP015",1)
 K RESULTS  S RESULTS=$NA(^TMP("DILIST",$J))  K @RESULTS
 ;--- Check the parameters
 S HLTYPES=$$UP^XLFSTR($TR($G(HLTYPES)," "))
 F I=1:1  S TMP=$P(HLTYPES,",",I)  Q:TMP=""  S RORHLT(TMP)=""
 S DIVIEN=$S($G(DIVIEN)>0:+DIVIEN,1:0)
 S PART=$G(PART),FLAGS=$G(FLAGS)
 S NUMBER=$S($G(NUMBER)>0:+NUMBER,1:"*")
 ;--- If neither "A" nor "I" flag is provided, add the "A" (default)
 S:$TR(FLAGS,"AI")=FLAGS FLAGS=FLAGS_"A"
 ;--- Setup the start point
 I $G(FROM)'=""  D  S FROM=$P(FROM,U)
 . S:$P(FROM,U,2)>0 FROM("IEN")=+$P(FROM,U,2)
 ;--- Compile the screen logic (be careful with naked references)
 S SCR=""
 D:$D(RORHLT)>1
 . S SCR=SCR_"S D=$P($G(^(0)),U,3) I D'="""",$D(RORHLT(D)) "
 S:DIVIEN SCR=SCR_"I $P($G(^(0)),U,15)=DIVIEN "
 S:FLAGS'["A" SCR=SCR_"I '$$ACTLOC^RORRP015(+Y) "
 S:FLAGS'["I" SCR=SCR_"I $$ACTLOC^RORRP015(+Y) "
 ;--- Get the list of locations
 S BUF="@;.01;2I;3I;3.5I",TMP="P"_$S(FLAGS["B":"B",1:"")
 D LIST^DIC(44,,BUF,TMP,NUMBER,.FROM,PART,"B",SCR,,,"RORMSG")
 I $G(DIERR)  D  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . S RC=$$DBS^RORERR("RORMSG",-9,,,44)
 . K ^TMP("DILIST",$J)
 ;--- Populate the Active field if both flags are used
 I FLAGS["I",FLAGS["A"  S I=0  D
 . F  S I=$O(@RESULTS@(I))  Q:I=""  D
 . . S $P(@RESULTS@(I,0),U,6)=$$ACTLOC(+@RESULTS@(I,0))
 ;--- Success
 S TMP=$G(^TMP("DILIST",$J,0)),BUF=+$P(TMP,U)
 K ^TMP("DILIST",$J,0)
 S:$P(TMP,U,3) $P(BUF,U,2,3)=$G(FROM)_U_$G(FROM("IEN"))
 S @RESULTS@(0)=BUF
 Q
