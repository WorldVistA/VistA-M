ROREVT01 ;HCIOFO/SG - EVENT PROTOCOLS  ; 6/9/03 1:50pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ; This routine uses the following IAs:
 ;
 ; #1181         Subscription to the DGPM MOVEMENT EVENT protocol
 ; #1298         Subscription to the PXK VISIT DATA EVENT protocol
 ; #3565         Subscription to the LR7O ALL EVSEND RESULTS protocol
 ;
 Q
 ;
 ;***** 'ROR EVENT LAB' PROTOCOL IMPLEMENTATION (DATA AREA #1)
LAB ;
 Q:$G(OREMSG)=""
 N BUF,DATE,DONE,FS,I,PATIEN
 S I="",DONE="00"
 F  S I=$O(@OREMSG@(I))  Q:I=""  D  Q:DONE="11"
 . S BUF=$G(@OREMSG@(I))
 . ;--- Get the HL7 field separator
 . I $G(FS)=""  S:$E(BUF,1,3)="MSH" FS=$E(BUF,4)  Q:$G(FS)=""
 . ;--- Get the patient IEN
 . I $P(BUF,FS)="PID"  D:'$E(DONE,1)  Q
 . . S PATIEN=+$P(BUF,FS,4)              ; PID-3
 . . S:PATIEN>0 $E(DONE,1)="1"
 . ;--- Get the specimen date
 . I $P(BUF,FS)="OBR"  D:'$E(DONE,2)  Q
 . . S DATE=$$HL7TFM^XLFDT($P(BUF,FS,8)) ; OBR-7
 . . S $E(DONE,2)="1"
 ;--- Create the event reference
 S:DONE="11" I=$$ADD^RORUPP02(PATIEN,1,DATE)
 Q
 ;
 ;***** RETURNS THE LIST OF PACKAGE EVENT PROTOCOLS
 ;
 ; .EPLST        Reference to a local variable. The list of
 ;               package event protocols will be returned via
 ;               this parameter: EPLST(ProtocolName)=""
 ;
LIST(EPLST) ;
 K EPLST
 S EPLST("ROR EVENT LAB")=""
 S EPLST("ROR EVENT PTF")=""
 S EPLST("ROR EVENT VISIT")=""
 Q
 ;
 ;***** 'ROR EVENT PTF' PROTOCOL IMPLEMENTATION (DATA AREA #3)
PTF ;
 N ADATE,IEN405,PATIEN,PDATE,RC,TRC
 S PATIEN=$P($G(DGPMA),"^",3)  Q:PATIEN'>0
 ;--- Admissions, transfers and discharges
 F TRC=1,2,3  D
 . S IEN405=0
 . F  S IEN405=$O(^UTILITY("DGPM",$J,TRC,IEN405))  Q:IEN405'>0  D
 . . S PDATE=$P($G(^UTILITY("DGPM",$J,TRC,IEN405,"P")),"^")
 . . S ADATE=$P($G(^UTILITY("DGPM",$J,TRC,IEN405,"A")),"^")
 . . I PDATE>0               S RC=$$ADD^RORUPP02(PATIEN,3,PDATE)
 . . I ADATE>0  S:ADATE'=PDATE RC=$$ADD^RORUPP02(PATIEN,3,ADATE)
 Q
 ;
 ;***** 'ROR EVENT VISIT' PROTOCOL IMPLEMENTATION (DATA AREA #2)
VISIT ;
 N BUF,IEN,PATIEN,RC,VSIEN
 S VSIEN=""
 F  S VSIEN=$O(^TMP("PXKCO",$J,VSIEN))  Q:VSIEN=""  D
 . S IEN=""
 . F  S IEN=$O(^TMP("PXKCO",$J,VSIEN,"VST",IEN))  Q:IEN=""  D
 . . S BUF=$G(^TMP("PXKCO",$J,VSIEN,"VST",IEN,0,"AFTER"))
 . . S PATIEN=$P(BUF,"^",5)  Q:(PATIEN'>0)!$P(BUF,"^",11)
 . . ;--- Create the event reference
 . . S RC=$$ADD^RORUPP02(PATIEN,2,$P(BUF,"^",2))
 Q
