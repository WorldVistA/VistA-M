HMPEHL7 ;SLC/MJK,ASMR/RRB,BL - HMP HL7 ADT Message Processor;May 15, 2016 14:15
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**1**;May 15, 2016;Build 4
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; DE2818 SQA Findings.  Changed ADT entry to accept parameters ASMR/RRB
 ; DE4781 HL7 Delimiters. Add guards to check for delimiter values
 Q
 ;
ADT(HLFS,HLNEXT,HLNODE,HLQUIT) ; -- main entry point for the following HMP ADT client/router protocols:
 ;          - HMP ADT-A04 CLIENT protocol
 ;             o  subscribes to VAFC ADT-A04 SERVER 
 ;          - HMP ADT-A08 CLIENT protocol
 ;             o  subscribes to VAFC ADT-A08 SERVER 
 ;
 ; Note: These variables are provided by the VistA HL7 system when a
 ;       subscriber protocol's ROUTING LOGIC is called:
 ;            - HLNEXT
 ;            - HLQUIT
 ;            - HLNODE
 ;            - HL("FS")
 ;            - HL("ECH")
 ;
 ; -- Filters ADT/A04(registration) & A08 (patient security level change) events
 ;    Scans for PID segment and uses embedded DFN
 ;    Sets ^XTMP("HMPFS~... freshness queue
 ;
 NEW DONE,HMPSEG,HMPEVT
 SET DONE=0
 FOR  XECUTE HLNEXT QUIT:HLQUIT'>0  DO  QUIT:DONE
 . SET HMPSEG=$EXTRACT(HLNODE,1,3)
 . ;
 . IF HMPSEG="EVN" DO  QUIT
 . . SET HMPEVT=$PIECE(HLNODE,HLFS,2)
 . . IF HMPEVT="A04" QUIT
 . . ; -- 97 reason = sensitive patient change occurred
 . . IF HMPEVT="A08",$PIECE(HLNODE,HLFS,5)=97 QUIT
 . . ; -- not an event HMP is interested in so done with message
 . . SET DONE=1
 . ; -- PID segment always comes after EVN segment
 . IF HMPSEG'="PID" QUIT
 . SET DONE=1
 . ; -- HMPEVT should always be defined at this point
 . IF $G(HMPEVT)="" QUIT
 . ;DE4781;BL;The HL("FS") and HL("ECH") may not be set. Ensure there are values or quit.
 . ;Both of these values are specific to the HL(771 file
 . ;they are primary and secondary delimiters
 . I $G(HL("FS"))="" S HL("FS")=$G(HLFS)  ;if not set, set to the HLFS parameter
 . I $G(HL("ECH"))="" S HL("ECH")=$G(HLREC("ECH"))  ;if secondary delimiter not set
 . Q:$G(HL("FS"))=""!($G(HL("ECH"))="")  ;if delimiters not set quit
 . ;end DE4781
 . NEW DFN
 . SET DFN=+$PIECE($PIECE(HLNODE,HL("FS"),4),$EXTRACT(HL("ECH")))
 . IF 'DFN QUIT
 . DO POSTX^HMPEVNT("pt-select",DFN_"&"_HMPEVT)  ;Ref File event
 . IF $DATA(^HMP(800000,"AITEM",DFN)) DO POST^HMPEVNT(DFN,"patient",DFN)
 QUIT
 ;
