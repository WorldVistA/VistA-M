MDCPHL7C ; HINES OIFO/BJ - CP Outbound message record maintenance routine.;26 OCT 2011
 ;;1.0;CLINICAL PROCEDURES;**23**;OCT 26, 2011;Build 281
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine uses the following IAs:
 ;  #325       - ADM^VADPT2                        Registration                   (controlled,subscription)
 ;  #417       - $P(^DA(40.8,DA,0),U,7)            Registration                   (controlled,subscription)
 ;
SNDA08 ;
 ; Called via ScriptRunner
 ; P2(0) - DFN of patient
 ; P2(1) - ID of Protocol Subscriber from file 704.006 to use
 ;
 N IEN,EVENT,WARD,DIV,BED,DFN
 ;
 D NEWDOC^MDCLIO("RESULTS","SENDA08")
 D XMLHDR^MDCLIO("RECORD")
 I +$G(P2(0))<1 D  G SNDA08A
 . D XMLDATA^MDCLIO("STATUS","-1")
 . D XMLDATA^MDCLIO("MESSAGE","PATIENT UNDEFINED")
 S DFN=P2(0)
 ; Yes, I know we're just checking to see if there's anything in the protocol field.
 ; At this point, though, it isn't worth doing a pattern match on the protocol sent in.
 I $G(P2(1))="" D  G SNDA08A
 . D XMLDATA^MDCLIO("STATUS","-1")
 . D XMLDATA^MDCLIO("MESSAGE","PROTOCOL UNDEFINED")
 ; First, sanity checks.
 S IEN=$$FIND1^DIC(704.006,"","KO",P2(1))
 I +IEN<1 D  G SNDA08A
 . D XMLDATA^MDCLIO("STATUS","-1")
 . D XMLDATA^MDCLIO("MESSAGE","UNABLE TO FIND PROTOCOL SUBSCRIBER WITH REQUESTED ID")
 S EVENT=$$GET1^DIQ(704.006,IEN_",",".05")
 I EVENT'="A08" D  G SNDA08A
 . D XMLDATA^MDCLIO("STATUS","-1")
 . D XMLDATA^MDCLIO("MESSAGE","SPECIFIED PROTOCOL DOES NOT SUPPORT A08 MESSAGES")
 ;
 ; Okay: at this point, we have a valid protocol and a (presumably) valid patient.
 ; Now to send the message.
 ;
 ;
 D ADD^MDCPVDEF(DFN,"","","","ADT","A08",,IEN)
 ; FIXME: Need to get IEN of new entry in 704.005 and check actual status.
 D XMLDATA^MDCLIO("STATUS","1")
 D XMLDATA^MDCLIO("MESSAGE","SUCCESS")
SNDA08A ;
 D XMLFTR^MDCLIO("RECORD")
 D ENDDOC^MDCLIO("RESULTS")
 Q
 ;
CANRESND ;
 ; Called via ScriptRunner
 ; P2(0) - DFN of patient
 ;
 D NEWDOC^MDCLIO("RESULTS","CAN RESEND ADT")
 D XMLHDR^MDCLIO("RECORD")
 N LSTSNTDT,DFN,LSTSNTID
 S DFN=P2(0)
 ; Is this an inpatient?  If not, we're not sending an anything other than an A08.
 ;
 D ADM^VADPT2 I +$G(VADMVT)=0 D  G CANRSND1
 . D XMLDATA^MDCLIO("STATUS","-1")
 . D XMLDATA^MDCLIO("MESSAGE","PATIENT NOT ADMITTED")
 ;
 S LSTSNTDT=+$O(^MDC(704.005,"LSTMSG",DFN,9999999),-1)
 I LSTSNTDT<1 D  G CANRSND1
 . D XMLDATA^MDCLIO("STATUS","-1")
 . D XMLDATA^MDCLIO("MESSAGE","NO PREVIOUS MESSAGE")
 ;
 ;
 N EVENT S EVENT=$O(^MDC(704.005,"LSTMSG",DFN,LSTSNTDT,""))
 S LSTSNTID=+$O(^MDC(704.005,"LSTMSG",DFN,LSTSNTDT,EVENT,0))
 I LSTSNTID<0 D  G CANRSND1
 . D XMLDATA^MDCLIO("STATUS","-1")
 . D XMLDATA^MDCLIO("MESSAGE","INVALID MESSAGE ID")
 ;
 ; We now have a valid DFN and message ID.  Send the info back to Delphiland so the appropriate menu options can be enabled.
 ;
 D XMLDATA^MDCLIO("STATUS","1")
 D XMLDATA^MDCLIO("MESSAGE",LSTSNTID)
 ;
CANRSND1 ;
 D XMLFTR^MDCLIO("RECORD")
 D ENDDOC^MDCLIO("RESULTS")
 Q
 ;
DORESND ; 
 ; Called via ScriptRunner
 ;
 ; P2(0) - IEN of message to resend.
 ;
 D NEWDOC^MDCLIO("RESULTS","RESEND ADT MESSAGE")
 D XMLHDR^MDCLIO("RECORD")
 S IEN=$G(P2(0))
 I IEN="" D  G DORESND1
 . D XMLDATA^MDCLIO("STATUS","-1")
 . D XMLDATA^MDCLIO("MESSAGE","INVALID IEN")
 ;
 N EVENT,STATUS
 S EVENT=$$GET1^DIQ(704.005,IEN_",",".07")
 I "A01A02A03A11A12A12"'[$G(EVENT) D  G DORESND1
 . D XMLDATA^MDCLIO("STATUS","-1")
 . D XMLDATA^MDCLIO("MESSAGE","INVALID MESSAGE STATUS "_EVENT_" FOR MESSAGE "_IEN)
 ;
 I $$QUE^MDCPMESQ(IEN,EVENT,.STATUS) D
 . D XMLDATA^MDCLIO("STATUS","1")
 . D XMLDATA^MDCLIO("MESSAGE","SUCCESS")
 E  D
 . D XMLDATA^MDCLIO("STATUS","-1")
 . D XMLDATA^MDCLIO("MESSAGE","ERROR REQUEING MESSAGE "_IEN_": "_STATUS)
 ;
DORESND1 ;
 D XMLFTR^MDCLIO("RECORD")
 D ENDDOC^MDCLIO("RESULTS")
 Q
 ;
GETA08DV ; 
 ; Called via ScriptRunner
 ;
 ; No incoming params.
 ;
 N X,DIV,INST S X=0
 K @RESULTS
 D NEWDOC^MDCLIO("RESULTS","GET A08 DEVICES")
 D XMLHDR^MDCLIO("DEVICES")
 F  S X=$O(^MDC(704.006,"INSTA08","A08",X)) Q:X=""  D
 . S DIV=$P($G(^MDC(704.006,X,0)),U,2)
 . S INST=$P($G(^DG(40.8,DIV,0)),U,7)
 . I INST=DUZ(2) D
 .. D XMLHDR^MDCLIO("RECORD")
 .. D XMLDATA^MDCLIO("DEVICE",X)
 .. D XMLDATA^MDCLIO("NAME",$P($G(^MDC(704.006,X,0)),U,7))
 .. D XMLDATA^MDCLIO("ID",$P($G(^MDC(704.006,X,0)),U,6))
 .. D XMLFTR^MDCLIO("RECORD")
 D XMLFTR^MDCLIO("DEVICES")
 D ENDDOC^MDCLIO("RESULTS")
 Q
