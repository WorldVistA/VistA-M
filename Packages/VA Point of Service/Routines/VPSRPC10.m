VPSRPC10  ;WOIFO/BT - Patient Demographic and Clinic RPC;08/14/14 09:28
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**4**;Aug 8, 2014;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External Reference DBIA#
 ; ------------------------
 ; #1246  - WIN^DGPMDDCF              (supported)
 ; #1713  - LIST^DIC                  (Supported)
 ; #10040 - File #44 ^SC( references  (Supported)
 ; #10104 - XLFSTR call               (Supported)
 QUIT
 ;
ALLCLN(RESULTS,HLTYPES,DIVIEN,PART,FLAGS,NUMBER,FROM) ;RPC: VPS GET ALL CLINICS
 ;***** RETURNS THE LIST OF HOSPITAL LOCATIONS
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
 ; =============
 ; A negative value of the first "^"-piece of the @RESULTS@(0) indicates an error 
 ; Otherwise, number of hospital locations and the value of the
 ; FROM parameter for the next procedure call are returned in
 ; the @RESULTS@(0) and the subsequent nodes of the global array
 ; contain the locations.
 ; 
 ; @RESULTS@(0)    Error Result Descriptor
 ;                         ^01: -1
 ;                         ^02: Error Message
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
 S RESULTS=$NA(^TMP("DILIST",$J)) K ^TMP("DILIST",$J)
 ;
 ;--- Check the parameters
 S HLTYPES=$$UP^XLFSTR($TR($G(HLTYPES)," "))
 N HLT,HLTYPE F I=1:1 S HLTYPE=$P(HLTYPES,",",I) QUIT:HLTYPE=""  S HLT(HLTYPE)=""
 S DIVIEN=$S($G(DIVIEN)>0:+DIVIEN,1:0)
 S PART=$G(PART)
 S FLAGS=$G(FLAGS)
 S NUMBER=$S($G(NUMBER)>0:+NUMBER,1:"*")
 ;--- If neither "A" nor "I" flag is provided, add the "A" (default)
 S:FLAGS="B"!(FLAGS="") FLAGS=FLAGS_"A"
 ;--- Setup the start point
 I $G(FROM)'="" D
 . S:$P(FROM,U,2)>0 FROM("IEN")=+$P(FROM,U,2)
 . S FROM=$P(FROM,U)
 ;
 ;--- Compile the screen logic (be careful with naked references)
 N SCR S SCR=""
 I $D(HLT)>1 S SCR=SCR_"S D=$P($G(^(0)),U,3) I D'="""",$D(HLT(D)) "
 S:DIVIEN SCR=SCR_"I $P($G(^(0)),U,15)=DIVIEN "
 S:FLAGS'["A" SCR=SCR_"I '$$ACTLOC^VPSRPC10(+Y) "
 S:FLAGS'["I" SCR=SCR_"I $$ACTLOC^VPSRPC10(+Y) "
 ;
 ;--- Get the list of locations
 N BUF S BUF="@;.01;2I;3I;3.5I"
 N ORDER S ORDER="P"_$S(FLAGS["B":"B",1:"")
 N VPSERR D LIST^DIC(44,,BUF,ORDER,NUMBER,.FROM,PART,"B",SCR,,,"VPSERR")
 I $G(DIERR) K ^TMP("DILIST",$J) S @RESULTS@(0)=-1_U_$$ERROR(.VPSERR) QUIT
 ; 
 ;--- Populate the Active field if both flags are used
 I FLAGS["I",FLAGS["A" D
 . N SEQ S SEQ=0
 . F  S SEQ=$O(@RESULTS@(SEQ)) QUIT:SEQ=""  D
 . . S $P(@RESULTS@(SEQ,0),U,6)=$$ACTLOC(+@RESULTS@(SEQ,0))
 ;
 ;--- Success
 N TMP S TMP=$G(^TMP("DILIST",$J,0))
 S BUF=+$P(TMP,U)
 S:$P(TMP,U,3) $P(BUF,U,2,3)=$G(FROM)_U_$G(FROM("IEN"))
 K ^TMP("DILIST",$J,0) S @RESULTS@(0)=BUF
 QUIT
 ;
ACTLOC(LOCIEN) ;***** CHECKS IF THE HOSPITAL LOCATION IS ACTIVE
 ; LOCIEN : IEN of the hospital location
 QUIT:$G(^SC(LOCIEN,"OOS")) 0  ; An OOS entry
 ; 
 N D0 S D0=+$G(^SC(LOCIEN,42))
 N DGPMOS ; today - used in WIN^DGPMDDCF
 N X I D0>0 D WIN^DGPMDDCF QUIT 'X ; Check if ward is inactive
 N IADT S IADT=$G(^SC(LOCIEN,"I")) QUIT:'$P(IADT,U) 1 ; No inactivation date
 N RDT S RDT=+$P(IADT,U,2) ; reactivate date
 I DT>$P(IADT,U) QUIT:'RDT!(DT<RDT) 0 ; Check reactivation date 
 QUIT 1
 ;
ERROR(FDAERR) ;return error text
 QUIT:'$D(FDAERR) ""
 N ERRNUM S ERRNUM=0
 S ERRNUM=$O(FDAERR("DIERR",ERRNUM))
 N ERRTXT S ERRTXT=""
 S:ERRNUM ERRTXT=FDAERR("DIERR",ERRNUM,"TEXT",1)
 QUIT ERRTXT
