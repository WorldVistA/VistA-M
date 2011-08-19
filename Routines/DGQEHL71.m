DGQEHL71 ;ALB/JFP - VIC Single HL7 Message Builder;09/01/96
 ;;V5.3;REGISTRATION;**73**;DEC 11,1996
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EVENT(DGQEEVN,DFN) ;  Entry point
 ;This option is the main entry point for the ID card driver.
 ;All VIC events will processed through this routine.
 ;
 ;Input   :  DGQEEVN - HL7 event type to process
 ;           DFN     - pointer to Patient file (#2)
 ;
 ;Output  :  Message ID in file 772 sucessful
 ;           -1^error text
 ;
 ; -- Check parameters
 Q:'$D(DGQEEVN) "-1^Required parameter not passed - event type"
 Q:'$D(DFN) "-1^Required parameter not passed - DFN"
 ; -- Declare variables
 N STATUS,HL7XMIT,CNT,INCREM
 N HLECH,HLEID,HLFS,HLMTIEN,HLRESLT,HLSAN
 N CLERK,OPT,SAPPL,RAPPL,MID
 S STATUS=0
 ;
EVNA08 ; -- A08 Update patient information for VIC
 I DGQEEVN="A08" D  Q STATUS
 .D A08
 Q "-1^No mumps code for event type "_DGQEEVN
 ;
A08 ; -- Builds update patient record
 ; -- Initialize variables
 ;
 ; -- Get pointer to sending event
 S HLEID=+$O(^ORD(101,"B","DGQE HL7 A08 VIC SERVER",0))
 ; -- Check existance of event, send error bulletin, done
 I ('HLEID) D  Q
 .S STATUS="-1^Unable to initialize HL7 variables - protocol not found"
 .D ERRBULL^DGQEHL70(STATUS) Q
 ; -- Get variables from HL7 package
 D INIT^HLFNC2(HLEID,.HL)
 ; -- Check existance of HL variables, send error bulletin, done
 I ($O(HL(""))="") S STATUS="-1^"_$P(HL,"^",2) D ERRBULL^DGQEHL70(STATUS) Q
 S SAPPL=$S($D(HL("SAN")):$G(HL("SAN")),1:" ")
 ; -- Set global array
 S HL7XMIT="^TMP(""HLS"","_$J_")"
 K @HL7XMIT
 ; -- Build HL7 message, message header build by HL7 package
 S CNT=0
 S INCREM=$$BLDA08^DGQEHL73(DFN,.HL,"",HL7XMIT,CNT)
 ; -- Check for error, increment less than 1
 I (INCREM<0) D  Q
 .S STATUS="-1^"_$P(INCREM,"^",2)
 .D ERRBULL^DGQEHL70(STATUS)
 ; -- Send HL7 message - immediate priority
 S HLP("PRIORITY")="I"
 D GENERATE^HLMA(HLEID,"GM",1,.HLRESLT,"",.HLP)
 ; -- Check for error
 I ($P(HLRESLT,"^",2)'="") D  Q
 .S STATUS=$P(HLRESLT,"^",2)_"^"_$P(HLRESLT,"^",3)
 .D ERRBULL^DGQEHL70(STATUS)
 ; -- Successful call, message ID returned
 S MID=$P(HLRESLT,"^",1)
 I $D(JPTEST) W !,"Message ID = ",MID
 ; -- Create tracking entry in ADT/HL7 TRANSMISSION file (#39.4)
 S CLERK=$S(DUZ'="":$P($G(^VA(200,DUZ,0)),"^",1),1:" ")
 S OPT=$S($D(XQY0):$P($G(XQY0),"^",1),1:" ")
 S FILE=$$FILE^DGQEHL74(MID,DFN,CLERK,OPT,SAPPL)
 I FILE=-1 D ERRBULL^DGQEHL70($P(FILE,"^",2)) Q
 Q
 ;
END ; -- End of code
 Q
 ;
