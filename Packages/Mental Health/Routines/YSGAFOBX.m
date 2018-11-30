YSGAFOBX ;ALB/SCK-GAF score event handler ;7/11/98
 ;;5.01;MENTAL HEALTH;**43,50,59**;Dec 30, 1994
 ;
 ; ^VA(200 supported by DBIA #10060
 ; ^DPT( supported by DBIA #10035
 ;
 Q
EN(YSDA) ;
 ; Entry point for handling the GAF score entry to the 
 ; DIAGNOSTICS RESULTS -MENTAL HEALTH file (#627.8)
 ; This entry point will trigger the GAF A08 HL7 update message transmission
 ; Input  - IEN of the entry in file #627.8
 ;
 ; Output
 ;        If no problems are encountered, a confirmation message of the 
 ;        HL7 message transmission will be sent to the specified mail 
 ;        group indicating the patient and HL7 message number.
 ;  
 ;        The Mail Group is "YS GAF TRANSMISSION ACK".
 ;
 ;        If a problem occurrs, an error message indicating the patient
 ;        observation and event DT, and error will be sent to the same
 ;        mail group
 ;
 ;
 ;
START ;; Check input
 S YSDA=+$G(YSDA)
 Q:('$D(^YSD(627.8,YSDA,0)))
 ;
 N DFN,YSDXDT,YSOBX,YSINFO,RETURN,YSEVDT
 ;
 ;; Build data array
 ;; Send error message if DFN not defined
 S DFN=+$P($G(^YSD(627.8,YSDA,0)),"^",2)
 I 'DFN D  Q
 . D RESPONSE(YSDA,"-1^DFN was not defined",DFN)
 ;
 ;; Send error message if AXIS 5 score not defined
 S YSOBX(5)=$P($G(^YSD(627.8,YSDA,60)),"^",3)
 I ('+YSOBX(5)) D  Q
 . D RESPONSE(YSDA,"-1^AXIS 5 (GAF) was not defined",DFN)
 ;
 ;; Send error message if observation DT not defined
 S YSOBX(14)=$P($G(^YSD(627.8,YSDA,0)),"^",3)
 I ('+YSOBX(14)) D  Q
 . D RESPONSE(YSDA,"-1^Date/Time of Diagnosis was not defined",DFN)
 ;
 S YSOBX(11)="F"
 S YSOBX(3)="GAF~Global Assessment of Function~AXIS 5"
 S YSOBX(4)=$P($G(^YSD(627.8,YSDA,60)),"^",4)
 S YSOBX(2)="ST"
 S YSOBX(16)=$P($G(^YSD(627.8,YSDA,0)),"^",4)
 ;
 ;; Set HL7 required data
 S YSEVDT=$$NOW^XLFDT
 S YSINFO("SERVER PROTOCOL")="YS GAF"
 S RETURN=$$EN^YSGAFHL7(DFN,"A08",YSEVDT,"YSOBX","YSINFO")
 D RESPONSE(YSDA,RETURN,DFN)
 Q
 ;
RESPONSE(YSIEN,TXT,DFN) ; Send error message for problem with GAF HL7 transmission
 ;
 N XMCHAN,XMDUZ,MSGTXT,XMSUB,XMDUZ,XMTEXT,XMY
 ;
 ;; Create Mail message and send to GAF mail group
 S XMSUB=$S(+TXT>0:"GAF Score Sent",1:"GAF Score Transmission Problem")
 S XMDUZ="GAF HL7 TRANSMISSION"
 S XMY("G.YS GAF TRANSMISSION ACK")=""
 S XMCHAN=1
 ;
 ;D DEM^VADPT
 I +TXT>0 D
 . S MSGTXT(1)="GAF Score for   "_$P($G(^DPT(DFN,0)),"^")
 . S MSGTXT(2)="Observation Dt: "_$$FMTE^XLFDT($P($G(^YSD(627.8,YSIEN,0)),"^",3),"1P")
 . S MSGTXT(3)="HL7 Message Number: #"_+TXT
 E  D
 . S MSGTXT(1)="A problem occured during transmission of a GAF score to the NPCD"
 . S MSGTXT(2)="   Error Msg   = "_$P(TXT,"^",2)
 . S MSGTXT(3)="   User        = "_$P($G(^VA(200,DUZ,0)),"^")
 . S MSGTXT(4)="   Patient     = "_$P($G(^DPT(DFN,0)),"^")
 . S MSGTXT(5)="   Obs. Date   = "_$$FMTE^XLFDT(+$P($G(^YSD(627.8,YSIEN,0)),"^",3),"1P")
 . S MSGTXT(6)="   File Date   = "_$$FMTE^XLFDT($P($G(^YSD(627.8,YSIEN,0)),"^"),"1P")
 ;
 S XMTEXT="MSGTXT("
 D ^XMD
 Q
