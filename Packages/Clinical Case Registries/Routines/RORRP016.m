RORRP016 ;HCIOFO/SG - RPC: LIST OF ICD-9 CODES ;6/16/06 2:16pm
 ;;1.5;CLINICAL CASE REGISTRIES;**1,10,23,19,30**;Feb 17, 2006;Build 37
 ;
 ; This routine uses the following IAs:
 ;
 ; #2051,5388,5773         LIST^DIC (supported)
 ; #5747         $$CSI^ICDEX (controlled)
 ; #5747         $$VSTD^ICDEX (controlled)
 ; #5747         $$VH^ICDEX (controlled)
 ; #5747         $$UPDX^ICDEX (controlled)
 ; #5747         $$VSTP^ICDEX (controlled)
 ; #5699         $$ICDDATA^ICDXCODE (supported)
 ; #5699         $$ICDDESC^ICDXCODE (supported)
 ;
 ;******************************************************************************
 ;******************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*19   FEB  2012   K GUPTA      Support for ICD-10 Coding System
 ;
 ;ROR*1.5*30   OCT 2016   M FERRARESE   Changing the dispay for "Sex" to "Birth Sex" 
 ;******************************************************************************
 ;******************************************************************************
 ;
 Q
 ;
 ;***** RETURNS THE LIST OF ICD CODES (DIAGNOSES OR PROCEDURES)
 ; RPC: [ROR LIST ICD]
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
 ;                 D  Full search by description
 ;                 F  Exclude codes applicable to females only
 ;                 I  Exclude inactive codes
 ;                 K  Search in description keywords
 ;                 M  Exclude codes applicable to males only
 ;                 O  Return operation/procedure codes from file #80.1
 ;                    instead of diagnosis codes from the file #80
 ;                 P  Exclude codes that are not acceptable
 ;                    as primary diagnoses
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
 ;               See description of the LIST^DIC for more details about the
 ;               PART, NUMBER and FROM parameters.
 ;
 ; [ICDTYPE]     TYPE OF ICD SEARCH: ICD9 OR ICD10
 ;
 ; The ^TMP("RORRP016",$J) global node is used by this procedure.
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the @RORESULT@(0)
 ; indicates an error (see the RPCSTK^RORERR procedure for more
 ; details).
 ;
 ; Otherwise, number of ICD-9 codes and the value of the FROM
 ; parameter for the next procedure call are returned in the
 ; @RORESULT@(0) and the subsequent nodes of the global array
 ; contain the codes.
 ; 
 ; @RORESULT@(0)         Result Descriptor
 ;                         ^01: Number of codes
 ;                         ^02: FromName
 ;                         ^03: FromIEN
 ;
 ; @RORESULT@(i)         ICD
 ;                         ^01: IEN
 ;                         ^02: Diagnosis or operation/procedure
 ;                         ^03: Code
 ;                         ^04: Use only with Birth Sex
 ;                         ^05: Inactive {0|1}
 ;                         ^06: Inactivation Date (FileMan)
 ;
 ; @RORESULT@(i+1)       ICD Description
 ;
ICDLIST(RORESULT,DATE,PART,FLAGS,NUMBER,FROM,ICDTYPE) ;
 N BUF,RC,RORERRDL,TMP,RORCODSYS
 D CLEAR^RORERR("ICDLIST^RORRP016",1)
 K RORESULT  S RORESULT=$NA(^TMP("RORRP016",$J))  K @RORESULT
 ;--- Check the parameters
 S PART=$G(PART),FLAGS=$G(FLAGS)
 S NUMBER=$S($G(NUMBER)>0:+NUMBER,1:"*")
 S ICDTYPE=$G(ICDTYPE)
 ;--- Setup the start point
 I $G(FROM)'=""  D  S FROM=$P(FROM,U)
 . S:$P(FROM,U,2)>0 FROM("IEN")=+$P(FROM,U,2)
 ;--- Compile the list
 I FLAGS["O"  D
 . I ICDTYPE="ICD9" S RORCODSYS="2" I 1
 . E  I ICDTYPE="ICD10" S RORCODSYS="31"
 . ;--- Get the list of operation/procedure codes
 . S RC=$$QUERY1(PART,FLAGS,NUMBER,.FROM,RORCODSYS)  Q:RC<0
 . S RORESULT=$NA(@RORESULT@("DILIST"))
 . ;--- Load remaining data and refine the list
 . D REFINE1(PART,FLAGS,$G(DATE),RORCODSYS)
 E  D
 . I ICDTYPE="ICD9" S RORCODSYS="1" I 1
 . E  I ICDTYPE="ICD10" S RORCODSYS="30"
 . ;--- Get the list of diagnosis codes
 . S RC=$$QUERY(PART,FLAGS,NUMBER,.FROM,RORCODSYS)  Q:RC<0
 . S RORESULT=$NA(@RORESULT@("DILIST"))
 . ;--- Load remaining data and refine the list
 . D REFINE(PART,FLAGS,$G(DATE),RORCODSYS)
 I RC<0  D RPCSTK^RORERR(.RORESULT,RC)  Q
 ;--- Success
 S TMP=$G(@RORESULT@(0)),BUF=+$P(TMP,U)
 S:$P(TMP,U,3) $P(BUF,U,2,3)=$G(FROM)_U_$G(FROM("IEN"))
 K @RORESULT@(0)  S @RORESULT@(0)=BUF
 Q
 ;
 ;***** QUERIES THE ICD DIAGNOSIS FILE (#80)
QUERY(PART,FLAGS,NR,FROM,CODSYS) ;
 N FLDS,RORMSG,SCR,TMP,XREF
 ;--- Compile the screen logic (be careful with naked references)
 S SCR=""
 ;I FLAGS["D"  S:PART'="" SCR=SCR_"I $P(D,U,3)["""_PART_""" ",PART=""
 ;S:FLAGS["F" SCR=SCR_"I $P(D,U,10)'=""F"" "
 ;S:FLAGS["M" SCR=SCR_"I $P(D,U,10)'=""M"" "
 ;S:FLAGS["P" SCR=SCR_"I '$P(D,U,4) "
 ;S:SCR'="" SCR="S D=$G(^(0)) "_SCR ;Naked Ref: ^ICD9(
 S:CODSYS]"" SCR=SCR_"I $$CSI^ICDEX(80,Y)="""_CODSYS_""" "
 I FLAGS["D" S:PART'="" SCR=SCR_"I $$UP^XLFSTR($$VSTD^ICDEX(Y))["""_PART_""" ",PART=""
 S:FLAGS["F" SCR=SCR_"I $$VSEX^ICDEX(80,Y)'=""F"" "
 S:FLAGS["M" SCR=SCR_"I $$VSEX^ICDEX(80,Y)'=""M"" "
 S:FLAGS["P" SCR=SCR_"I '$$UPDX^ICDEX(Y) "
 ;--- Get the list of codes and some data
 ;S FLDS="@;3;.01;9.5I;IXI",TMP="P"_$S(FLAGS["B":"B",1:"")
 ;S FLDS="@;.01;9.5I;IXI"
 S FLDS="@;.01;IXI"
 S TMP="P"_$S(FLAGS["B":"B",1:"")
 S XREF=$S(FLAGS["D":"#",FLAGS["K":"D",1:"BA")
 D LIST^DIC(80,,FLDS,TMP,NR,.FROM,PART,XREF,SCR,,RORESULT,"RORMSG")
 I $G(DIERR)  K @RORESULT  Q $$DBS^RORERR("RORMSG",-9,,,80)
 ;--- Add Diagnosis code to RORESULT using API
 D GETDIAG(CODSYS)
 ;--- Success
 Q 0
 ;
 ;***** QUERIES THE ICD OPERATION/PROCEDURE FILE (#80.1)
QUERY1(PART,FLAGS,NR,FROM,CODSYS) ;
 N FLDS,RORMSG,SCR,TMP,XREF
 ;--- Compile the screen logic (be careful with naked references)
 S SCR=""
 ;I FLAGS["D"  S:PART'="" SCR=SCR_"I $P(D,U,4)["""_PART_""" ",PART=""
 ;S:FLAGS["F" SCR=SCR_"I $P(D,U,10)'=""F"" "
 ;S:FLAGS["M" SCR=SCR_"I $P(D,U,10)'=""M"" "
 ;S:SCR'="" SCR="S D=$G(^(0)) "_SCR ;Naked Ref: ^ICD0(
 S:CODSYS]"" SCR=SCR_"I $$CSI^ICDEX(80.1,Y)="""_CODSYS_""" "
 I FLAGS["D" S:PART'="" SCR=SCR_"I $$UP^XLFSTR($$VSTP^ICDEX(Y))["""_PART_""" ",PART=""
 S:FLAGS["F" SCR=SCR_"I $$VSEX^ICDEX(80.1,Y)'=""F"" "
 S:FLAGS["M" SCR=SCR_"I $$VSEX^ICDEX(80.1,Y)'=""M"" "
 ;--- Get the list of codes and some data
 ;S FLDS="@;4;.01;9.5I;IXI",TMP="P"_$S(FLAGS["B":"B",1:"")
 ;S FLDS="@;.01;9.5I;IXI"
 S FLDS="@;.01;IXI"
 S TMP="P"_$S(FLAGS["B":"B",1:"")
 S XREF=$S(FLAGS["D":"#",FLAGS["K":"D",1:"BA")
 D LIST^DIC(80.1,,FLDS,TMP,NR,.FROM,PART,XREF,SCR,,RORESULT,"RORMSG")
 I $G(DIERR)  K @RORESULT  Q $$DBS^RORERR("RORMSG",-9,,,80.1)
 ;--- Add Operation/Procedure  to RORESULT using API
 D GETOPPR(CODSYS)
 ;--- Success
 Q 0
 ;
 ;***** REFINES THE LIST OF DIAGNOSES
REFINE(PART,FLAGS,DATE,CODSYS) ;
 N BUF,CNT,ICDINFO,MODE,RORDESC,SUBS,TMP
 S MODE=($TR(FLAGS,"DK")=FLAGS)
 S (CNT,SUBS)=0
 F  S SUBS=$O(@RORESULT@(SUBS)) Q:SUBS'>0  D
 . S BUF=@RORESULT@(SUBS,0)
 . ;--- Remove duplicates created by the logic of the "BAA" xref
 . I MODE  D  I '(TMP?1.E1" ")  K @RORESULT@(SUBS)  Q
 . . S TMP=$P(BUF,U,4)
 . ;--- Load the additional data
 . S ICDINFO=$$ICDDATA^ICDXCODE(CODSYS,+$P(BUF,U),DATE,"I")
 . I ICDINFO<0  K @RORESULT@(SUBS)  Q
 . ;--- Screen active/inactive records
 . S TMP=+$P(ICDINFO,U,10)                      ; Status
 . I $S(TMP:FLAGS["A",1:FLAGS["I")  K @RORESULT@(SUBS)  Q
 . S $P(BUF,U,4)=$P(ICDINFO,U,11)  ; Birth Sex
 . S $P(BUF,U,5)=TMP
 . S $P(BUF,U,6)=$S(TMP:$P(ICDINFO,U,12),1:"")  ; Inactivation Date
 . ;--- Versioned diagnosis
 . S TMP=$P(ICDINFO,U,4)  S:TMP'="" $P(BUF,U,2)=TMP
 . ;--- Store the data
 . S CNT=CNT+1,@RORESULT@(SUBS,0)=BUF
 . ;--- Versioned description
 . S TMP=$$ICDDESC^ICDXCODE(CODSYS,$P(BUF,U,3),DATE,.RORDESC)
 . S @RORESULT@(SUBS,1)=$S($G(RORDESC(1))'="":RORDESC(1),1:$P(BUF,U,2))
 . K RORDESC
 ;---
 S $P(@RORESULT@(0),U)=CNT
 Q
 ;
 ;***** REFINES THE LIST OF OPERATION/PROCEDURES
REFINE1(PART,FLAGS,DATE,CODSYS) ;
 N BUF,CNT,ICDINFO,MODE,RORDESC,SUBS,TMP
 S MODE=($TR(FLAGS,"DK")=FLAGS)
 S (CNT,SUBS)=0
 F  S SUBS=$O(@RORESULT@(SUBS)) Q:SUBS'>0  D
 . S BUF=@RORESULT@(SUBS,0)
 . ;--- Remove duplicates created by the logic of the "BAA" xref
 . I MODE  D  I '(TMP?1.E1" ")  K @RORESULT@(SUBS)  Q
 . . S TMP=$P(BUF,U,4)
 . ;--- Load the additional data
 . S ICDINFO=$$ICDDATA^ICDXCODE(CODSYS,+$P(BUF,U),DATE,"I")
 . I ICDINFO<0  K @RORESULT@(SUBS)  Q
 . ;--- Screen active/inactive records
 . S TMP=+$P(ICDINFO,U,10)                      ; Status
 . I $S(TMP:FLAGS["A",1:FLAGS["I")  K @RORESULT@(SUBS)  Q
 . S $P(BUF,U,4)=$P(ICDINFO,U,11)  ; Birth Sex
 . S $P(BUF,U,5)=TMP
 . S $P(BUF,U,6)=$S(TMP:$P(ICDINFO,U,12),1:"")  ; Inactivation Date
 . ;--- Versioned operation/procedure
 . S TMP=$P(ICDINFO,U,5)  S:TMP'="" $P(BUF,U,2)=TMP
 . ;--- Store the data
 . S CNT=CNT+1,@RORESULT@(SUBS,0)=BUF
 . ;--- Versioned description
 . S TMP=$$ICDDESC^ICDXCODE(CODSYS,$P(BUF,U,3),DATE,.RORDESC)
 . S @RORESULT@(SUBS,1)=$S($G(RORDESC(1))'="":RORDESC(1),1:$P(BUF,U,2))
 . K RORDESC
 ;---
 S $P(@RORESULT@(0),U)=CNT
 Q
 ;
 ;***** Get Diagnosis code and add to the @RORESULT@("DILIST") array
GETDIAG(CODSYS) ;
 N RORI,RORIEN,RORDIAG,ROR1,RORALL,RORNUM S RORI=0
 F  S RORI=$O(@RORESULT@("DILIST",RORI)) Q:RORI=""  D
 . S RORIEN=$P(@RORESULT@("DILIST",RORI,0),U,1)
 . S RORDIAG=$$VSTD^ICDEX(RORIEN)
 . ;get number of pieces in RORESULT
 . S RORNUM=$L(@RORESULT@("DILIST",RORI,0),U)
 . S ROR1=$P(@RORESULT@("DILIST",RORI,0),U,1) ;1st piece
 . S RORALL=$P(@RORESULT@("DILIST",RORI,0),U,2,RORNUM) ;all other pieces
 . S @RORESULT@("DILIST",RORI,0)=$G(ROR1)_U_$G(RORDIAG)_U_$G(RORALL)
 ;Update the 'map' in RORESULT to include field #3
 S RORNUM=$L(@RORESULT@("DILIST",0,"MAP"),U) ;number of pieces
 S ROR1=$P(@RORESULT@("DILIST",0,"MAP"),U,1) ;first piece
 S RORALL=$P(@RORESULT@("DILIST",0,"MAP"),U,2,RORNUM) ;all other pieces
 S @RORESULT@("DILIST",0,"MAP")=$G(ROR1)_U_"3"_U_$G(RORALL)
 Q
 ;***** Get Operation/Procedure and add to the RORESULT("DILIST") array
GETOPPR(CODSYS) ;
 N RORI,RORIEN,ROROPPR,ROR1,RORALL,RORNUM S RORI=0
 F  S RORI=$O(@RORESULT@("DILIST",RORI)) Q:RORI=""  D
 . S RORIEN=$P(@RORESULT@("DILIST",RORI,0),U,1)
 . S ROROPPR=$$VSTP^ICDEX(RORIEN)
 . ;get number of pieces in RORESULT to reflect field #3
 . S RORNUM=$L(@RORESULT@("DILIST",RORI,0),U)
 . S ROR1=$P(@RORESULT@("DILIST",RORI,0),U,1) ;1st piece
 . S RORALL=$P(@RORESULT@("DILIST",RORI,0),U,2,RORNUM) ;all other pieces
 . S @RORESULT@("DILIST",RORI,0)=$G(ROR1)_U_$G(ROROPPR)_U_$G(RORALL)
 ;Update the 'map' in RORESULT to include field #4
 S RORNUM=$L(@RORESULT@("DILIST",0,"MAP"),U) ;number of pieces
 S ROR1=$P(@RORESULT@("DILIST",0,"MAP"),U,1) ;first piece
 S RORALL=$P(@RORESULT@("DILIST",0,"MAP"),U,2,RORNUM) ;all other pieces
 S @RORESULT@("DILIST",0,"MAP")=$G(ROR1)_U_"4"_U_$G(RORALL)
 Q
