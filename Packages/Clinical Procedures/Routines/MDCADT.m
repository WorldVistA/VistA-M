MDCADT ;HINES OIFO/DP/BJ - HL7 Build ADT Axx Messages;10 Aug 2007
 ;;1.0;CLINICAL PROCEDURES;**16**;Apr 01, 2004;Build 280
 ; Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine uses the following Integration Agreements (IAs):
 ;  # 2050       - $$EZBLD^DIALOG()      FileMan         (supported)
 ;  # 2887       - $$GETAPP^HLCS2 call   HL7             (supported)
 ;  #10106       - $$HLDATE^HLFNC        HL7             (supported)
 ;  # 4571       - ERR^VDEFREQ calls     VDEF            (controlled, subscribed)
 ;  #10070       - ^XMD call             MailMan         (supported)
 ;  #10035       - access ^DPT(          Registration    (supported)
 ;
VALID ;VDEF HL7 MESSAGE BUILDER
 ; Creates HL7 V2.4 "Axx Type" message
 ; stolen from GMVVDEF1
 ; segments returned will fall into 1 of four categories
 ;    Case 1 = simple unsubscripted variable       e.g. SEG="IN1^Blue Cross.....^^"
 ;    Case 2 = single segment, 2 or more nodes     e.g. SEG="PD1^Smith,John...^^"
 ;                                                      SEG(1)="3505 94ST^....^^"
 ;    Case 3 = Multiple segments, 1 node each      e.g. SEG(1,0)="NK1^Smith,Mary^2...^^"
 ;                                                      SEG(2,0)="NK1^Smith,Joey^3...^^"
 ;    Case 4 = Multiple segments, 1 or more nodes  e.g. SEG(1,0)="ZCL^ data ...^^"
 ;                                                      SEG(1,0,1)="^ more data ...^^"
 ;                                                      SEG(1,0,2)="^ end of data ...^^"
 ;                                                      SEG(2,0)="ZCL^ all of segment ^^"
 ;                                                      SEG(3,0)="ZCL^ another segment  ^^"
 ;                                                      SEG(3,0,1)=" etc., etc.  ^^"
 ;  I $D(SEG)=1          Case 1
 ;  I $D(SEG)=11         Case 2
 ;  I $D(SEG)=10         Case 3 or 4
 Q
 ;
BLDMSG(EVIEN,KEY,VFLAG,OUT,MSHP,MDCEVN) ;
 ;
 ; Inputs: EVIEN         - IEN of message in file 577
 ;         KEY           - IEN of file to create message from
 ;         VFLAG         - "V" for VistA HL7 destination (default)
 ;         OUT           - target array, passed by reference
 ;         MSHP          - Piece 4 contains message subtype
 ;         MDCEVN        - message type, e.g. A04
 ;
 ; Output: Two part string with parts separated by "^"
 ;         Part 1: "LM" - output in local array passed in "OUT" parameter
 ;                 "GM" - output in ^TMP("HLS",$J)
 ;         Part 2: No longer used        ;
 ;
 N HLCM,HLRP,HLSC,HLES,HLECH,HLFS,HLQ,HL7RC,HLMAXLEN
 N MDCMAIL,IENSSAVE,TARGET
 N DFN,MDCS,EV,MDCERAY,MDCERR,MDCSEG,MDCIEN
 ;
 S IENSSAVE=$G(IENS)
 S MDCIEN=KEY,MDCS=0
 K ^TMP("HLS",$J),OUT
 ;S ARRAY="^TMP("_"""HLS"""_",$J,MDCS)",TARGET="GM^"  ; array is a global
 S ARRAY="OUT("_"""HLS"""_",MDCS)",TARGET="LM^"  ;  array is a local variable
 ;
 ; Set up HL7 delimiters based on VDEFHL().
 D MOREDLMS^MDCUTL
 ;
 ;  Get DATA
 M MDCDATA=^MDC(704.005,KEY)
 ;
 ;  Validate Patient Movement Data
 ;
 I '$D(MDCDATA) D  Q TARGET
 . S MDCERAY(1)=KEY
 . S MDCERR=$$EZBLD^DIALOG(7040020.002,.MDCERAY)
 . D ERR(MDCERR)
 ;
 ;  Get and Validate Patient IEN
 S DFN=+$P($G(MDCDATA(0)),U)
 I '$D(^DPT(DFN,0))!(DFN=0) D  Q TARGET
 . S MDCERAY(1)=DFN
 . S MDCERR=$$EZBLD^DIALOG(7040020.003,.MDCERAY)
 . D ERR(MDCERR)
 ;
 ; Build segments
 ;
EVN ; EVN - Event Type with EVN.7.1 - required
 D EN^MDCEVN(MDCEVN,.MDCIEN,.MDCSEG,.MDCERR) I $D(MDCERR) D ERR(MDCERR) Q TARGET
 I '$D(MDCSEG) D  Q TARGET                   ; missing segment
 . S MDCPARM(1)="EVN",MDCPARM(2)=+$G(MDCIEN),MDCPARM(3)=405
 . S MDCERR=$$EZBLD^DIALOG(7040020.004,.MDCPARM)
 . D ERR(MDCERR)
 D SAVE
 ;
PID ; PID - Patient Identification - required
 D EN^MDCPID(DFN,.MDCSEG,.MDCERR) I $D(MDCERR) D ERR(MDCERR) Q TARGET
 I '$D(MDCSEG) D  Q TARGET                      ; missing segment
 . S MDCPARM(1)="PID",MDCPARM(2)=DFN,MDCPARM(3)=2
 . S MDCERR=$$EZBLD^DIALOG(7040020.004,.MDCPARM)
 . D ERR(MDCERR)
 D SAVE
 ;
PV1 ; PV1 - Patient Visit - required or empty
 D EN^MDCPV1(.MDCDATA,.MDCSEG,.MDCERR) I $D(MDCERR) D ERR(MDCERR) Q TARGET
 I '$D(MDCSEG) D  Q TARGET                      ; missing segment
 . S MDCPARM(1)="PV1",MDCPARM(MDCIEN)=DFN,MDCPARM(3)=405
 . S MDCERR=$$EZBLD^DIALOG(7040020.004,.MDCPARM)
 . D ERR(MDCERR)
 D SAVE
 ;
 ; Done building segments, clean up and exit
 K PARAM,MDCSITE,MDCDATA
 Q TARGET
 ;
SAVE ;
 I $D(MDCSEG)#10 D  ; single segment, one node
 . S MDCS=MDCS+1
 . M @ARRAY=MDCSEG
 I $D(MDCSEG)=10 D       ; maybe multiple segments, multiple nodes
 . N I
 . S I=""
 . F  D  Q:I=""
 .. S I=$O(MDCSEG(I)) Q:I=""
 .. S MDCS=MDCS+1
 .. M @ARRAY=MDCSEG(I,0)
 K MDCSEG
 ; Move local array to global if it's getting too big
 I $P(TARGET,U)="LM",$S<16000 D
 . K ^TMP("HLS",$J) M ^TMP("HLS",$J)=OUT("HLS") K OUT("HLS")
 . S $P(TARGET,U)="GM",ARRAY="^TMP("_"""HLS"""_",$J,MDCS)"
 Q
 ;
 ;  Error Processing
ERR(MDCERR) ;
 ;    Input:     MDCERR - Error message.
 N IENS,ZTSTOP
 S IENS=$G(IENSSAVE,MDCIEN)
 D ERR^VDEFREQ(MDCERR)
 D MAILERR
 S ZTSTOP=1
 K MDCPARM,OUT
 Q
 ;
 ;  Mail Message
MAILERR ; mail error notification to g.developers
 N RECEIVER,XMDUZ,XMY,XMSUB,XMTEXT,HL7DATE,%
 D NOW^%DTC
 S HL7DATE=$$HLDATE^HLFNC(%,"TS")
 S RECEIVER=$$GETAPP^HLCS2(HL("SAN"))
 S RECEIVER="g."_$P(RECEIVER,U)
 S XMDUZ=.5
 S XMY(RECEIVER)=""
 S XMSUB=" HL7 "_MDCEVN_" Error Message Key="_KEY_" (VDEF Queue #"_EVIEN_")"
 S XMTEXT="MDCMAIL("
 S MDCMAIL(1)=MDCERR
 D ^XMD
 Q
