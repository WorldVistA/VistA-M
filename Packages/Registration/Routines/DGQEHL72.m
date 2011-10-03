DGQEHL72 ;ALB/JFP - VIC HL7 Batch Message Builder;09/01/96
 ;;V5.3;REGISTRATION;**73**;DEC 11,1996
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EVENT(DGQEEVN,DFNARR) ;
 ; -- This option is the main entry point for the ID card driver.
 ;
 ;Input     : DGQEEVN -  HL7 event type
 ;            DFNARRY -  Array of DFNs to process
 ;
 ;Output    : None
 ;
 ; -- Check input variables
 Q:'$D(DGQEEVN) "-1^required parameter not passed - event type"
 Q:'$D(DFNARR) "-1^ required parameter not passed - DFN  array"
 ;
 ; -- Declare variables
 N HL7XMIT,XMITERR,MAXBATCH,MAXLINE,BATCHCNT,ERRCNT,DFN,MSGID,INCREM
 N ERRCNT,LINECNT,STATUS,ERRFLG
 N HLECH,HLEID,HLFS,HLMTIEN,HLRESLT,HLSAN
 N CLERK,OPT,SAPPL,RAPPL,MID
 ;
EVNA08 ; -- A08 Update patient information for VIC
 I DGQEEVN="A08" D A08
 I ERRFLG=1 Q "-1^see mail message for details"
 Q 0
 ;
A08 ; -- Builds update patient record
 ;
 ; -- Initialize global locations
 S HL7XMIT="^TMP(""HLS"","_$J_")"
 S XMITERR="^TMP(""DGQE"","_$J_",""ERROR"")"
 K @XMITERR,@HL7XMIT
 ; -- Set limits for batch message
 S MAXBATCH=30
 S MAXLINE=500
 ; -- Set up HL7 variables
 S BATCHCNT=0
 S ERRCNT=0
 D INIT
 ; -- Check for error in init section and quit
 I ERRFLG=1 D FATAL Q
 ; -- Loop through list of transactions
 S DFN=""
 F  S DFN=$O(@DFNARR@(DFN)) Q:('DFN)  D
 .; -- Calculate message control ID
 .S MSGID=HLMID_"-"_((BATCHCNT#MAXBATCH)+1)
 .;W !,"MSGID = ",MSGID
 .; -- Build HL7 message
 .S INCREM=$$BLDA08^DGQEHL73(DFN,.HL,MSGID,HL7XMIT,LINECNT)
 .; -- Check for error, increment less than 1
 .I (INCREM<0) D  Q
 ..S ERRCNT=ERRCNT+1
 ..S @XMITERR@(DFN)=$P(INCREM,"^",2)
 .; -- Increment counts
 .S LINECNT=LINECNT+INCREM
 .S BATCHCNT=BATCHCNT+1
 .; -- Create tracking entry in ADT/HL7 transmission file (#39.4)
 .S FILE=$$FILE^DGQEHL74(MSGID,DFN,CLERK,OPT,SAPPL)
 .I FILE=-1 D ERRBULL^DGQEHL70($P(FILE,"^",2)) Q
 .; -- Check max size of batch, Send on max, Reset HL7 variables
 .I '(BATCHCNT#MAXBATCH)!(LINECNT>MAXLINE) D
 ..D SNDBTCH
 ..D INIT
 ;
 ; -- Check for unsent batch
 I ($O(@HL7XMIT@(0))) D
 .D SNDBTCH
 ; -- Send Completion bulletin
 D CMPLBULL^DGQEHL70(BATCHCNT,XMITERR)
FATAL ; -- Fatal error or clean up variables, exit code
 K @XMITERR,@HL7XMIT
 Q
 ;
INIT ; -- Initialize variables
 S ERRFLG=0
 S LINECNT=1
 K @HL7XMIT
 ; -- Get pointer to sending event
 S HLEID=+$O(^ORD(101,"B","DGQE HL7 A08 VIC SERVER",0))
 ; -- Check existance of event, send error bulletin, done
 I ('HLEID) D  Q
 .D ERRBULL^DGQEHL70("-1^Unable to initialize HL7 variables - protocol not found")
 .S ERRFLG=1
 ; -- Get variables from HL7 package
 D INIT^HLFNC2(HLEID,.HL)
 ; -- Check existance of HL variables, send error bulletin, done
 I ($O(HL(""))="") D  Q
 .D ERRBULL^DGQEHL70("-1^"_$P(HL,"^",2))
 .S ERRFLG=1
 ; -- Set variables for transmission file
 S SAPPL=$S($D(HL("SAN")):$G(HL("SAN")),1:"")
 S CLERK=$S(DUZ'="":$P($G(^VA(200,DUZ,0)),"^",1),1:"")
 S OPT=$S($D(XQY0):$P($G(XQY0),"^",2),1:"")
 ; -- Create batch message
 D CREATE^HLTF(.HLMID,.HLMTIEN,.HLDT,.HLDT1)
 ; -- Check to see if batch message created, send error, done
 I ('HLMTIEN) D  Q
 .D ERRBULL^DGQEHL70("-1^Unable to create batch HL7 message")
 .S ERRFLG=1
 Q
 ;
SNDBTCH ; -- Sends batch message
 S HLP("PRIORITY")="I"
 D GENERATE^HLMA(HLEID,"GB",1,.HLRESLT,HLMTIEN,.HLP)
 ; -- Check for error
 I ($P(HLRESLT,"^",2)'="") D  Q
 .S STATUS=$P(HLRESLT,"^",2)_"^"_$P(HLRESLT,"^",3)
 .D ERRBULL^DGQEHL70(STATUS)
 .S ERRFLG=1
 ; -- Successful call, message ID returned
 S STATUS=$P(HLRESLT,"^",1)
 I $D(JPTEST) W !,"Message ID = ",STATUS
 Q
 ;
END ; -- End of code
 Q
 ;
