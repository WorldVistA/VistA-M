PRCHJS04 ;OI&T/KCL - IFCAP/ECMS INTERFACE 2237 MSG BUILD SEND;7/2/12
 ;;5.1;IFCAP;**167**;Oct 20, 2000;Build 17
 ;Per VHA Directive 2004-38, this routine should not be modified.
 ;
OMNO07(PRCWRK,PRCER) ;Build/Send HL7 OMN^O07 message
 ;This function builds a single HL7 OMN^O07 message containing a
 ;2237 transaction and queues it for transmission to eCMS using HLO APIs.
 ;
 ; Supported ICR:
 ;  #5818 - Obtain the TCP/IP PORT (OPTIMIZED) field for a record
 ;          in the HL LOGICAL LINK (#870) file using $$PORT2^HLOTLNK.
 ;
 ;  Input:
 ;   PRCWRK - (required) name of work global containing 2237 data elements
 ;
 ; Output:
 ;   Function value - on success, returns IEN of the message in the HLO
 ;                    MESSAGES (#778) file. Returns 0 on failure.
 ;            PRCER - (optional) on failure, an error message is returned,
 ;                    pass by ref
 ;
 N PRCPARMS ;HLO input parameters
 N PRCWHOTO ;HLO send to parameters
 N PRCMSG   ;HLO workspace used to build message
 N PRCIDX   ;line items subscript
 N PRCRSLT  ;function result
 ;
 S PRCRSLT=0
 ;
 ;start building a single HL7 msg
 S PRCPARMS("MESSAGE TYPE")="OMN"
 S PRCPARMS("EVENT")="O07"
 S PRCPARMS("FIELD SEPARATOR")="|"
 S PRCPARMS("ENCODING CHARACTERS")="^~\&"
 S PRCPARMS("MESSAGE STRUCTURE")="OMN_O07"
 S PRCPARMS("VERSION")=2.5
 S PRCPARMS("ACCEPT ACK TYPE")="AL" ;commit ACKs are required to be returned
 S PRCPARMS("APP ACK TYPE")="AL"    ;application ACKs are required to be returned    
 S PRCPARMS("SENDING APPLICATION")="PRCHJ_IFCAP_2237_SEND"
 I '$$NEWMSG^HLOAPI(.PRCPARMS,.PRCMSG,.PRCER) Q PRCRSLT
 ;
 ;build NTE segs for 2237 Special Remarks, Justification, and Comments
 I '$$NTE^PRCHJS06(PRCWRK,.PRCMSG,.PRCER) Q PRCRSLT
 ;
 ;loop thru 2237 line items and build the optional Order Group segs:
 ;  {(ORDER)ORC,{[TQ1]}RQD,RQ1,[ZA1],{NTE}}
 S PRCIDX=0
 F  S PRCIDX=$O(@PRCWRK@(PRCIDX)) Q:'(+$G(PRCIDX))!($G(PRCER)]"")  D
 . ;
 . ;build ORC seg
 . I '$$ORC^PRCHJS05(PRCWRK,.PRCMSG,.PRCER) Q
 . ;
 . ;if delivery schedule(s) for item, build TQ1 seg(s)
 . I $O(@PRCWRK@(PRCIDX,0)) D
 . . I '$$TQ1^PRCHJS05(PRCWRK,.PRCMSG,PRCIDX,.PRCER) Q
 . Q:$G(PRCER)]""
 . ;
 . ;build RQD seg
 . I '$$RQD^PRCHJS05(PRCWRK,.PRCMSG,PRCIDX,.PRCER) Q
 . ;
 . ;build RQ1 seg
 . I '$$RQ1^PRCHJS05(PRCWRK,.PRCMSG,PRCIDX,.PRCER) Q
 . ;
 . ;build ZA1 seg
 . I '$$ZA1^PRCHJS05(PRCWRK,.PRCMSG,PRCIDX,.PRCER) Q
 . ;
 . ;build NTE seg(s)
 . I '$$NTEITEM^PRCHJS05(PRCWRK,.PRCMSG,PRCIDX,.PRCER) Q
 ;
 ;quit if error encountered building Order Group segs
 Q:$G(PRCER)]"" PRCRSLT
 ;
 ;build ZZ1 seg
 I '$$ZZ1^PRCHJS06(PRCWRK,.PRCMSG,.PRCER) Q PRCRSLT
 ;
 ;build ZZ2 seg
 I '$$ZZ2^PRCHJS06(PRCWRK,.PRCMSG,.PRCER) Q PRCRSLT
 ;
 ;build ZZ3 seg
 I '$$ZZ3^PRCHJS06(PRCWRK,.PRCMSG,.PRCER) Q PRCRSLT
 ;
 ;send a single HL7 msg
 S PRCWHOTO("RECEIVING APPLICATION")="PRCHJ_ECMS_2237_SEND"
 S PRCWHOTO("STATION NUMBER")=200 ;allow VIE box to route msg to Austin (eCMS)
 ;set these 2 params to allow HLO to send msg to VIE box
 S PRCWHOTO("MIDDLEWARE LINK NAME")="PRCHJ_ECMS"  ;name of logical link for the interface engine
 S PRCWHOTO("PORT")=$$PORT2^HLOTLNK("PRCHJ_ECMS") ;get port from logical link record
 I PRCWHOTO("PORT")']"" S PRCER="Unable to obtain HLO port from logical link record" Q PRCRSLT
 S PRCRSLT=$$SENDONE^HLOAPI1(.PRCMSG,.PRCPARMS,.PRCWHOTO,.PRCER) ;returns msg ien, 0 on failure
 ;
 Q PRCRSLT
