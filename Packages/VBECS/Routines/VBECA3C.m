VBECA3C ;HIOFO/BNT - VBECS Utility to parse XML for CPRS ;12/19/2003  01:00
 ;;1.0;VBECS;**27**;Apr 14, 2005;Build 1
 ;
 ; Note: This routine supports data exchange with an FDA registered
 ; medical device. As such, it may not be changed in any way without
 ; prior written approval from the medical device manufacturer.
 ; 
 ; Integration Agreements:
 ; Reference DBIA 4149 - M XML Parser
 ; Reference to EN^MXMLPRSE supported by IA #4149
 ; Reference to CHKNAME^XQ5 supported by IA #????
 ; 
 ;
 QUIT
 ;
EN(ARR,DOC) ;
 N CBK,CNT
 ;W !!!,"Invoking XML Parser...",!!!
 S OPTION=""
 S VBECRES=$NA(^TMP("VBEC_OE_DATA",$J))
 K @VBECRES
 S (VBECTRHC,VBECTREQ,VBECABHC,VBECTSTC,VBECMSBC,VBECSRC)=0
 ; Unit Type counters
 SET (VBECUNC,VBECUNS,VBECUNA,VBECUND)=0
 D SET(.CBK)
 D EN^MXMLPRSE(DOC,.CBK,.OPTION)
 M ARR=@VBECRES
 ;S CNT=""
 ;W !!!,"Parser Summary:",!!
 ;F  S CNT=$O(CNT(CNT)) Q:CNT=""  W CNT,":",?25,CNT(CNT),!
 Q
 ; Direct entry of XML text from keyboard
 ; Terminate text entry with a solitary '^'
PASTE(OPTION) ;
 N X,Y,GBL
 S GBL=$NA(^TMP("VBEC_OE_XML",$J))
 K @GBL
 F X=1:1 D  Q:Y="^"
 .W X,"> "
 .R Y:$G(DTIME,600),!
 .E  S Y="^"
 .S:Y'="^" @GBL@(X)=Y
 D EN(GBL,.OPTION)
 K @GBL
 Q
 ; Set the event interface entry points
SET(CBK) ;
 K CBK
 ;F X=0:1 S Y=$P($T(SETX+X),";;",2) Q:Y=""  D
 ;.S CBK(Y)=$E(Y,1,8)_"^VBECA3C"
 S CBK("STARTELEMENT")="STELE^VBECA3C"
 S CBK("ENDELEMENT")="ENELE^VBECA3C"
 S CBK("CHARACTERS")="CHAR^VBECA3C"
 Q
 ;
STELE(ELE,ATR) ; -- element start event handler
 SET VBECELE=ELE
 IF ELE="Patient" DO
 . SET @VBECRES@("PATIENT")=$G(ATR("dfn"))_"^"_$G(ATR("firstName"))_"^"_$G(ATR("lastName"))_"^"_$G(ATR("ssn"))
 . SET @VBECRES@("ABORH")=$G(ATR("abo"))_"^"_$G(ATR("rh"))
 . QUIT
 IF ELE="TransfusionReaction" DO
 . SET VBECTRHC=VBECTRHC+1
 . SET @VBECRES@("TRHX",VBECTRHC)=$G(ATR("type"))_"^"_$G(ATR("date"))
 . QUIT
 IF ELE="TransfusionRequirement" DO
 . SET VBECTREQ=VBECTREQ+1
 . SET @VBECRES@("TRREQ",VBECTREQ)=$G(ATR("modifier"))
 . QUIT
 IF ELE="Antibody" DO
 . SET VBECABHC=VBECABHC+1
 . SET @VBECRES@("ABHIS",VBECABHC)=$G(ATR("name"))
 . QUIT
 IF ELE="Unit" DO
 . IF $G(ATR("status"))="C" DO
 . . SET VBECUNC=VBECUNC+1
 . . SET @VBECRES@("UNIT","C",VBECUNC)=$G(ATR("id"))_"^"_$G(ATR("product"))_"^"_$G(ATR("location"))_"^"_$G(ATR("expDate"))
 . IF $G(ATR("status"))="S" DO
 . . SET VBECUNS=VBECUNS+1
 . . SET @VBECRES@("UNIT","S",VBECUNS)=$G(ATR("id"))_"^"_$G(ATR("product"))_"^"_$G(ATR("location"))_"^"_$G(ATR("expDate"))
 . IF $G(ATR("status"))="A" DO
 . . SET VBECUNA=VBECUNA+1
 . . SET @VBECRES@("UNIT","A",VBECUNA)=$G(ATR("id"))_"^"_$G(ATR("product"))_"^"_$G(ATR("location"))_"^"_$G(ATR("expDate"))
 . IF $G(ATR("status"))="D" DO
 . . SET VBECUND=VBECUND+1
 . . SET @VBECRES@("UNIT","D",VBECUND)=$G(ATR("id"))_"^"_$G(ATR("product"))_"^"_$G(ATR("location"))_"^"_$G(ATR("expDate"))
 . QUIT
 IF ELE="Specimen" DO
 . SET @VBECRES@("SPECIMEN")=$G(ATR("expDate"))_"^"_$G(ATR("uid"))
 . QUIT
 IF ELE="Component" DO
 . SET VBECOMP=$G(ATR("id"))
 . SET VBECMSBC=0
 . SET @VBECRES@(VBECOMP,"SPECIMEN")=$G(ATR("specimen"))
 . QUIT
 IF ELE="LabTest" DO
 . SET VBECTSTC=VBECTSTC+1
 . SET @VBECRES@(VBECOMP,"TEST",VBECTSTC)=$G(ATR("id"))_"^"_$G(ATR("name"))
 . QUIT
 IF ELE="Msbos" DO
 . SET VBECMSBC=VBECMSBC+1
 . SET @VBECRES@(VBECOMP,"MSBOS",VBECMSBC)=$G(ATR("name"))_"^"_$G(ATR("threshold"))
 . QUIT
 IF ELE="Surgery" DO
 . SET VBECSRC=VBECSRC+1
 . SET @VBECRES@("SURGERY",VBECSRC)=$G(ATR("name"))_"^"_$G(ATR("noBloodRequiredIndicator"))
 QUIT
ENELE(ELE) ; -- element end event handler
 KILL VBECNT
 QUIT
 ;
CHAR(TEXT) ;
 Q
