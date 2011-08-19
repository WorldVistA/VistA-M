RORRP017 ;HIOFO/SG,VC - RPC: DRUGS AND CLASSES ;4/17/09 10:45am
 ;;1.5;CLINICAL CASE REGISTRIES;**8**;Feb 17, 2006;Build 8
 ;
 ; This routine uses the following IAs:
 ;
 ; #4533         ZERO^PSS50, NDF^PSS50, DATA^PSS50 (supported)
 ; #4540         ZERO^PSN50P6 (supported)
 ; #4543         C^PSN50P65, IEN^PSN50P65 (supported)
 ;
 ; This routine was modified March 2009 to include Registry Drugs
 ; RPC call is ROR LIST REGISTRY DRUGS into tag RORGEN
 ;
 Q
 ;
 ;***** RETURNS THE LIST OF DRUGS (DISPENSED OR GENERIC)
 ; RPC: [ROR LIST DRUGS]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; [PART]        The partial match restriction.
 ;
 ; [FLAGS]       Flags that control the execution (can be combined):
 ;                 G  Retrive generic drugs (from file #50.6).
 ;                    Otherwise, list of dispensed drugs (from
 ;                    file #50) is retrieved.
 ;
 ; [NUMBER]      Deprecated
 ; [FROM]        Deprecated
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0)
 ; indicates an error (see the RPCSTK^RORERR procedure for more
 ; details).
 ;
 ; Otherwise, number of drugs is returned in the
 ; @RESULTS@(0) and the subsequent nodes of the global array
 ; contain the drugs.
 ; 
 ; @RESULTS@(0)          Number of drugs
 ;
 ; @RESULTS@(i)          Drug
 ;                         ^01: Drug IEN
 ;                         ^02: Drug Name
 ;                         ^03: VA Drug Class (only for dispensed)
 ;
DRUGLIST(RESULTS,PART,FLAGS,NUMBER,FROM) ;
 N BUF,CNT,GENERIC,IEN,LP,NAME,NODE,RC,RORERRDL,TMP
 D CLEAR^RORERR("DRUGLIST^RORRP017",1)
 K RESULTS  S RESULTS=$$ALLOC^RORTMP()
 ;--- Check the parameters
 S FLAGS=$G(FLAGS)  S:$G(PART)="" PART="??"
 S GENERIC=(FLAGS["G")
 ;--- Get the list of drugs
 S NODE=$$ALLOC^RORTMP(.TMP)
 I GENERIC  D
 . D ZERO^PSN50P6(,PART,,,TMP)  ; Generic
 E  D ZERO^PSS50(,PART,,,,TMP)  ; Dispensed
 ;--- Copy the data to the destination array
 S:PART="??" PART=""  S LP=$L(PART)
 S NAME="",CNT=0
 F  S NAME=$O(@NODE@("B",NAME))  Q:NAME=""  D
 . S IEN=""
 . F  S IEN=$O(@NODE@("B",NAME,IEN))  Q:IEN=""  D
 . . S TMP=$G(@NODE@(IEN,.01))  Q:TMP=""
 . . Q:$E(TMP,1,LP)'=PART  ; Exclude mnemonics
 . . S BUF=IEN_U_TMP  S:'GENERIC $P(BUF,U,3)=$G(@NODE@(IEN,2))
 . . S CNT=CNT+1,@RESULTS@(CNT)=BUF
 ;--- Success
 S @RESULTS@(0)=CNT
 D FREE^RORTMP(NODE)
 Q
 ;
 ;***** RETURNS THE LIST OF VA DRUG CLASSES
 ; RPC: [ROR LIST VA DRUG CLASSES]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; [PARENT]      Reserved
 ;
 ; [PART]        The partial match restriction.
 ;
 ; [FLAGS]       Flags that control the execution (can be combined):
 ;                 N  Search classes by their names
 ;                    (by default, the search is performed by codes)
 ;
 ; [NUMBER]      Deprecated
 ; [FROM]        Deprecated
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the @RESULTS@(0)
 ; indicates an error (see the RPCSTK^RORERR procedure for more
 ; details).
 ;
 ; Otherwise, number of drug classes is returned in the
 ; @RESULTS@(0) and the subsequent nodes of the global array
 ; contain the classes.
 ; 
 ; @RESULTS@(0)          Number of classes
 ;
 ; @RESULTS@(i)          Drug Class
 ;                         ^01: IEN
 ;                         ^02: Classification
 ;                         ^03: Code
 ;
VACLSLST(RESULTS,PARENT,PART,FLAGS,NUMBER,FROM) ;
 N CNT,IEN,LP,NODE,RC,RORERRDL,SUBS,TMP,VAL,XREF
 D CLEAR^RORERR("VACLSLST^RORRP017",1)
 K RESULTS  S RESULTS=$$ALLOC^RORTMP()
 ;--- Check the parameters
 S FLAGS=$G(FLAGS)  S:$G(PART)="" PART="??"
 ;--- Get the list of codes
 S NODE=$$ALLOC^RORTMP(.TMP)
 I FLAGS["N"  D  S XREF="C",SUBS=1
 . D C^PSN50P65(,PART,TMP)
 E  D  S XREF="B",SUBS=.01
 . D IEN^PSN50P65(,PART,TMP)
 ;--- Copy the data to the destination array
 S:PART="??" PART=""  S LP=$L(PART)
 S VAL="",CNT=0
 F  S VAL=$O(@NODE@(XREF,VAL))  Q:VAL=""  D
 . S IEN=""
 . F  S IEN=$O(@NODE@(XREF,VAL,IEN))  Q:IEN=""  D
 . . S TMP=$G(@NODE@(IEN,SUBS))
 . . Q:$E(TMP,1,LP)'=PART  ; Exclude mnemonics
 . . S CNT=CNT+1
 . . S @RESULTS@(CNT)=IEN_U_$G(@NODE@(IEN,1))_U_$G(@NODE@(IEN,.01))
 ;--- Success
 S @RESULTS@(0)=CNT
 D FREE^RORTMP(NODE)
 Q
 ;
 ;***** RETURNS THE LIST OF REGISTRY DRUGS
 ; RPC: [ROR LIST REGISTRY DRUGS]
 ; .RESULTS    Reference to a local variable where the results
 ;             are return to
 ; PART        The partial match value passed in from Application
 ; FLAGS       Not used
 ; NUMBER      Not used
 ; FROM        Not used
 ;
 ; Information returned
 ;    @RESULTS@(0)   Number of drugs returned
 ;    @RESULTS@(n)   Drug Class
 ;                   $p1= IEN
 ;                   $p2= NAME OF DRUG
 ;
RORGEN(RESULTS,PART,FLAGS,NUMBER,FROM) ;
 N BUF,CNT,GENERIC,IEN,LP,NAME,RC,RORERRDL,TMP,REGID,RRIEN
 D CLEAR^RORERR("RORGEN^RORRP017",1)
 K RESULTS S RESULTS=$$ALLOC^RORTMP()
 S:$G(PART)="" PART="??"
 S:PART="??" PART=""
 S LP=$L(PART)
 S NAME=PART,CNT=0
 F  S NAME=$O(^ROR(799.51,"B",NAME)) Q:NAME=""  D
 . Q:$E(NAME,1,LP)'=PART
 .S IEN=""
 .F  S IEN=$O(^ROR(799.51,"B",NAME,IEN)) Q:IEN=""  D
 . . S REGID=$P($G(^ROR(799.51,IEN,0)),U,2)
 . . Q:REGID'=FLAGS
 . . S RRIEN=$P($G(^ROR(799.51,IEN,0)),U,4)
 . . S BUF=RRIEN_U_NAME,CNT=CNT+1
 . . S @RESULTS@(CNT)=BUF
 S @RESULTS@(0)=CNT
 Q
 ;
 ;---  Returns a list of Investigative Drugs per registry
 ; RPC:   [ROR LIST INVESTIGATIVE DRUGS]
 ; .RESULTS     Reference to a local variable where the results
 ;              are returned to
 ; PART         The partial match value passed in from the application
 ; FLAGS        Indicator of registry HEPC=1, HIV=2
 ; NUMBER       Not used
 ; FROM         Not used
RORINV(RESULTS,PART,FLAGS,NUMBER,FROM) ;
 N BUF,CNT,IEN,LP,NAME,NODE,RC,RORERRDL,TMP,TMP2,INVES,CLAS,SUBS,PNTR
 N RORREG,XREF,VAL
 D CLEAR^RORERR("RORINV^RORRP017",1)
 K RESULTS
 S RESULTS=$$ALLOC^RORTMP()
 S NODE=$$ALLOC^RORTMP(.TMP)
 S SUBS=$$ALLOC^RORTMP(.TMP2)
 S FLAGS=$G(FLAGS)
 I FLAGS=1 S RORREG="IN140"
 I FLAGS=2 S RORREG="IN150"
 S:$G(PART)="" PART="??"
 S:PART="??" PART=""
 S LP=$L(PART)
 ;D B^PSS50(PART,,,,TMP)
 D NDF^PSS50(,PART,,,,TMP)
 S XREF="B"
 S VAL="",CNT=0
 F  S VAL=$O(@NODE@(XREF,VAL)) Q:VAL=""  D
 . S IEN=""
 . F  S IEN=$O(@NODE@(XREF,VAL,IEN)) Q:IEN=""  D
 . . D DATA^PSS50(IEN,,,,,TMP2)
 . . S CLAS=$P($G(@SUBS@(IEN,25)),U,2)
 . . Q:CLAS'=RORREG
 . . S PNTR=$P($G(@SUBS@(IEN,20)),U,1)
 . . S CNT=CNT+1
 . . S BUF=PNTR_U_$G(@SUBS@(IEN,.01))
 . . S @RESULTS@(CNT)=BUF
 S @RESULTS@(0)=CNT
 D FREE^RORTMP(NODE)
 D FREE^RORTMP(SUBS)
 Q
 ;
