VIAAQUE ;ALB/CR - RTLS Queue General Utility ;5/04/16 10:00am
 ;;1.0;RTLS;**3**;April 22, 2013;Build 20
 ;
 Q
 ;
 ; create a task that can requeue itself and check file #6930
 ; every 3-6 minutes (180-360 seconds) or so
 ; =============== NOTICE ==================== 
 ; Per HPMO reference # OITIMB33554520, a waiver has been granted
 ; for the use of Cache ObjectScript along with standard MUMPS commands
 ;
STR ; enter here to send a message right away if entries are found
 L +^VIAA(6930):5 Q:'$T  ; we want just one job running
 N COUNT,DATA,ROOT
 I '$D(^VIAA(6930)) Q
 F COUNT=0:0 S COUNT=+$O(^VIAA(6930,COUNT)) Q:'COUNT  D
 . S ROOT=$G(^VIAA(6930,COUNT,0))
 . ; get all 3 pieces for processing in Eng file
 . S DATA=$P(ROOT,U,1,3) ; take first 3 pieces at once
 . D MSG
 L -^VIAA(6930)
 ;
 ; -- if Mule is reachable, then call web service and deliver the
 ; -- entries. Otherwise, defer any action to the queue process.
 Q
 ;
SEND ; come here to place the entries in the queue for the Mule service
 ;
 N ZTRTN,ZTIO,ZTSAVE,ZTDESC,ZTDTH
 I $D(^VIAA(6930)) D
 . S ZTDESC="Pending RTLS File Queue Transmission"
 . S ZTRTN="STR^VIAAQUE"
 . S ZTIO="NULL",ZTDTH=$H ; need the null device for HWSC call
 . S ZTSAVE("*")=""
 . D ^%ZTLOAD
 Q
 ;
 ; for transmission to Mule:
 ; if status = 500, we have to hold the entries for the next round
 ; of the queue; if status = 200, Mule has accepted the record and we
 ; can clean it from the file PENDING RTLS EVENTS (#6930)
MSG N MSG,STATUS,XCODE
 ;
 S MSG="?siteID="_$P(DATA,U,1)_"&"_"fileNumber="_$P(DATA,U,2)_"&"_"IEN="_$P(DATA,U,3)
 S XCODE=$$XMIT(MSG)
 S STATUS=$S(XCODE=200:"OK",XCODE=500:"NOK",1:XCODE)
 I STATUS'="OK" Q
 D DEL^VIAATRI(COUNT) ; clear entry from file #6930
 Q
 ;
XMIT(DATA) ; Transmit the RESTful request.
 ;
 N $ETRAP,$ESTACK,ERR,REST,XCODE,XOBREADR,XOBREAK,XOBSTAT
 S $ETRAP="D XERR^VIAAQUE"
 ;
 S XCODE=0
 S REST=$$GETREST^XOBWLIB("VIAA VISTA TRIGGER SERVICE","VIAA VISTA TRIGGER SERVER")
 S REST.Timeout=60
 I $$POST^XOBWLIB(REST,DATA,.ERR) D
 . S XOBSTAT=##class(%XML.TextReader).ParseStream(REST.HttpResponse.Data,.XOBREADR)
 . I ($$STATCHK^XOBWLIB(XOBSTAT,.ERR)) D
 .. S XOBREAK=0 F  Q:XOBREAK!XOBREADR.EOF!'XOBREADR.Read()  D
 ... I (XOBREADR.NodeType="element"),(XOBREADR.LocalName="code") D
 .... I XOBREADR.MoveToContent() D
 ..... S XCODE=XOBREADR.Value,XOBREAK=1
 Q XCODE
 ;
XERR ; -- Error trap handler --
 ;
 S $ECODE=""
 Q
