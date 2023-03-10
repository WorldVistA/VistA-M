GMRCIMSG ;SLC/JFR - IFC MESSAGE HANDLING ROUTINE; 09/26/02 00:23 ; May 10, 2022@09:28:54
 ;;3.0;CONSULT/REQUEST TRACKING;**22,28,51,44,154,184**;DEC 27, 1997;Build 22
 ;
 ; Reference to EN^RMPRFC3 supported by #4661
 ; #2053 DIE, #4838 MAGDTR01, #2165 HLMA1, #10103 XLFDT, #2263 XPAR, #2171 XUAF4, #2541 XUPARAM 
 ;
 Q  ;don't start at the top
IN ;process incoming message and save segments to ^TMP(
 K ^TMP("GMRCIF",$J)
 N GMRCCRNR,GMRCMSGD,GMRCMSGI,GMRCVALM,HLNODE,SEG,I,GMRCIER  ;production code ;MKN GMRC*3*154 added GMRCCRNR, GMRCMSGI, GMRCVALM
 N GMRCI,TCH,TEXTIN,TEXTOUT,TEXTRM,GMRCFRM ;MKN GMRC*3*154
 S GMRCCRNR=0,GMRCMSGI="" ;MKN GMRC*3*154
 F I=1:1 X HLNEXT Q:HLQUIT'>0  D
 . I $P(HLNODE,"|",8)="CRNR" S GMRCCRNR=1 ;MKN GMRC*3*154
 . I $P(HLNODE,"|")="MSH" D
 .. S GMRCMSGD=$$HL7TFM^XLFDT($P(HLNODE,"|",7),"L"),GMRCMSGD=$$FMTE^XLFDT(GMRCMSGD,"P")
 .. S GMRCMSGI=$P(HLNODE,"|",10)_"^"_GMRCMSGD
 . I $P(HLNODE,"|")="ORC" D
 .. I $G(GMRCCRNR)=1 S ^TMP("GMRCIF",$J,"GMRCCRCR")=1,GMRCFRM=$P($P(HLNODE,"|",3),U,2),^TMP("GMRCIF",$J,"GMRCCRNR")=1_U_$P(GMRCFRM,U,1)  ;WTC GMRC*3.0*184
 . I $P(HLNODE,"|")="OBX" D  ;multiple segs for OBX
 .. ;MKN GMRC*3.0*154 start of mods
 .. I $P(HLNODE,"|",3)="TX" D  Q
 ... D SETTCH
 ... S TEXTIN=$E(HLNODE,5,999),TEXTRM="",TEXTOUT=""
 ... D DECODE^GMRCHL7E(TEXTIN,.TCH,.TEXTOUT,TEXTRM)
 ... S ^TMP("GMRCIF",$J,"OBX",$P(HLNODE,"|",2),$P(HLNODE,"|",5))=TEXTOUT_TEXTRM
 .. ;MKN GMRC*3.0*154 end of mods
 .. S ^TMP("GMRCIF",$J,"OBX",$P(HLNODE,"|",2),$P(HLNODE,"|",5))=$E(HLNODE,5,999)
 . I $P(HLNODE,"|")="NTE" D  ; may be multiple NTE's
 .. ;MKN GMRC*3.0*154 start of mods
 .. D SETTCH
 .. S TEXTIN=$E(HLNODE,5,999),TEXTRM="",TEXTOUT=""
 .. D DECODE^GMRCHL7E(TEXTIN,.TCH,.TEXTOUT,TEXTRM)
 .. S ^TMP("GMRCIF",$J,"NTE",$P(HLNODE,"|",2))=TEXTOUT
 .. ;S ^TMP("GMRCIF",$J,"NTE",$P(HLNODE,"|",2))=$E(HLNODE,5,999)
 .. ;MKN GMRC*3.0*154 end of mods
 . I "OBXNTE"'[$P(HLNODE,"|") D  ;all other segs are single
 .. S ^TMP("GMRCIF",$J,$P(HLNODE,"|"))=$E(HLNODE,5,999)
 . Q
 ;
 S GMRCVALM=$$VALMSG(^TMP("GMRCIF",$J,"ORC"),GMRCCRNR) ; MKN GMRC*3.0*154
 I 'GMRCVALM,'GMRCCRNR D EX Q  ;chk msg for valid cslt #'s ; MKN GMRC*3.0*154 added GMRCCRNR
 I 'GMRCVALM,GMRCCRNR D MGMSG^GMRCIAC2(101,GMRCMSGI),EX Q  ; send app. ACK ;MKN GMRC*3*154 added GMRCCRNR and GMRCMSGI
 ;
 I $P(^TMP("GMRCIF",$J,"ORC"),"|")="NW" D  D EX Q
 . I $P(^TMP("GMRCIF",$J,"ORC"),"|",2)["TST1234" D  D EX Q  ;testing impl
 .. D TST^GMRCIAC2($NA(^TMP("GMRCIF",$J)))
 . D NW^GMRCIACT($NA(^TMP("GMRCIF",$J)))
 I $P(^TMP("GMRCIF",$J,"ORC"),"|")="XO" D  D EX Q
 . D RESUB^GMRCIAC1($NA(^TMP("GMRCIF",$J)),GMRCCRNR,GMRCMSGI) ; MKN GMRC*3.0*154 added GMRCCRNR and GMRCMSGI
 I $P(^TMP("GMRCIF",$J,"ORC"),"|")="XX" D  D EX Q
 . D FWD^GMRCIAC1($NA(^TMP("GMRCIF",$J)),GMRCCRNR,GMRCMSGI) ; MKN GMRC*3.0*154 added GMRCCRNR and GMRCMSGI
 I $P(^TMP("GMRCIF",$J,"ORC"),"|")="RE" D  D EX Q
 . I $P($G(^TMP("GMRCIF",$J,"OBX",4,1)),"|",11)="D" D  Q
 .. D DIS^GMRCIACT($NA(^TMP("GMRCIF",$J)),GMRCCRNR,GMRCMSGI) ; dis-assoc. result ; MKN GMRC*3.0*154 added GMRCCRNR and GMRCMSGI
 . I $P($P(^TMP("GMRCIF",$J,"ORC"),"|",16),U)="S" D  Q
 .. D SF^GMRCIAC1($NA(^TMP("GMRCIF",$J)),GMRCCRNR,GMRCMSGI) ; significant findings ; MKN GMRC*3.0*154 added GMRCCRNR and GMRCMSGI
 . D COMP^GMRCIAC1($NA(^TMP("GMRCIF",$J)),GMRCCRNR,GMRCMSGI) ; MKN GMRC*3.0*154 added GMRCCRNR and GMRCMSGI
 D OTHER^GMRCIACT($NA(^TMP("GMRCIF",$J)),GMRCCRNR,GMRCMSGI) ; MKN GMRC*3.0*154 added GMRCCRNR and GMRCMSGI
 D EX
 Q
 ;
EX ; clean up 
 ; EHRM Prosthetics
 N GMRCEHRM
 S GMRCEHRM=$$EHRMCHK($G(^TMP("GMRCIF",$J,"ORC")),$G(^TMP("GMRCIF",$J,"OBR")))
 K ^TMP("GMRCIF",$J)
 ; Call EHRM Prosthetics routine - added for GMRC*3*154
 I GMRCEHRM=1,$T(EN^GMRCRFC0)'="" D  Q  ; invoke EHRM Prosthetics if tag^routine exists and this is EHRM message. Otherwise, invoke legacy routine EN^RMPRFC3
 .D EN^GMRCRFC0(HLNEXT,HLQUIT)
 ;
 ;call Prosthetics routine - added for RMPR*3*83
 I $T(EN^RMPRFC3)'="" D  ;invoke prosthetics code if tag^routine exists
 . D EN^RMPRFC3
 Q
 ;
EHRMCHK(ORCSEG,OBRSEG) ; Check for EHRM
 N GMRCORC,GMRCORC2,GMRCORC3,GMRCORC5,GMRCSTAT,GMRCOBR4
 S GMRCORC2=$P($P(ORCSEG,"|",2),"^",2)          ; Placer Facility
 S GMRCORC3=$P($P(ORCSEG,"|",3),"^",2)          ; Filler Facility
 S GMRCOBR4=$P($P(OBRSEG,"|",4),"^",2)          ; Text (string) component of the Universal Identifier 
 S GMRCSTAT=$P(ORCSEG,"|")                      ; Control Code
 I GMRCSTAT="OD" S GMRCSTAT=$P(ORCSEG,"|",5)    ; Status
 I (GMRCSTAT'="NW")&(GMRCSTAT'="DC") Q 0        ; Only process NW and DC
 ; EHRM Prosthetics NW requires incoming Placer Facility = Local Facility, Universal Service ID contains PROSTHETICS IFC or PSAS
 I GMRCSTAT="NW" I ($$IEN^XUAF4(GMRCORC2)=$$KSP^XUPARAM("INST")),((GMRCOBR4["PROSTHETICS IFC")!(GMRCOBR4["PSAS")) Q 1
 ; EHRM Prosthetics DC requires incoming Placer Facility = Local Facility, Placer Facility = Filler Facility, Universal Service ID contains PROSTHETICS IFC or PSAS
 I GMRCSTAT="DC" I ($$IEN^XUAF4(GMRCORC2)=$$KSP^XUPARAM("INST")),(GMRCORC2=GMRCORC3),((GMRCOBR4["PROSTHETICS IFC")!(GMRCOBR4["PSAS")) Q 1
 Q 0
 ;
ORRIN ;process IFC responses
 K ^TMP("GMRCIF",$J)
 N HLNODE,SEG,I  ;production code
 F I=1:1 X HLNEXT Q:HLQUIT'>0  D
 .S ^TMP("GMRCIF",$J,$P(HLNODE,"|"))=$E(HLNODE,5,999)
 I $D(^TMP("GMRCIF",$J,"ORC")),$P(^("ORC"),"|")="OK" D
 . N GMRCFNUM,GMRCROUT,GMRCDA,FDA
 . S GMRCROUT=$$IEN^XUAF4($P($P(^TMP("GMRCIF",$J,"ORC"),"|",3),U,2))
 . S GMRCDA=+$P(^TMP("GMRCIF",$J,"ORC"),"|",2)
 . ;I GMRCROUT'=$P(^GMR(123,GMRCDA,0),U,23) Q
 . S GMRCFNUM=+$P(^TMP("GMRCIF",$J,"ORC"),"|",3)
 . S FDA(1,123,GMRCDA_",",.06)=GMRCFNUM
 . ;
 . ;   If Cerner order, extract and save patient account number.  p184
 . ;
 . N PTACCTNO S PTACCTNO=$P($G(^TMP("GMRCIF",$J,"PID")),"|",18) I PTACCTNO'="" S FDA(1,123,GMRCDA_",",502)=PTACCTNO ;
 . ;
 . D UPDATE^DIE("","FDA(1)",,"GMRCERR")
 . Q
 I $P(^TMP("GMRCIF",$J,"MSA"),"|")="AA" D
 . N MSGID,MSGLOG,FDA,GMRCDA,GMRCACT,GMRCLOG
 . S MSGID=$P(^TMP("GMRCIF",$J,"MSA"),"|",2)
 . S MSGLOG=$O(^GMR(123.6,"AM",MSGID,0)) Q:'MSGLOG
 . S FDA(1,123.6,MSGLOG_",",.06)="@"
 . S FDA(1,123.6,MSGLOG_",",.08)="@"
 . D UPDATE^DIE("","FDA(1)",,"GMRCERR")
 . S GMRCDA=$P(^GMR(123.6,MSGLOG,0),U,4) Q:'GMRCDA
 . S GMRCACT=$P(^GMR(123.6,MSGLOG,0),U,5) Q:'GMRCACT
 . S GMRCACT=$O(^GMR(123.6,"AC",GMRCDA,GMRCACT)) D
 .. I 'GMRCACT Q
 .. S GMRCLOG=$O(^GMR(123.6,"AC",GMRCDA,GMRCACT,1,0)) Q:'GMRCLOG
 .. I $P(^GMR(123.6,GMRCLOG,0),U,8)<900 Q  ;re-send 901 & 902 immed.
 .. D TRIGR^GMRCIEVT(GMRCDA,GMRCACT)
 . Q
 I $P(^TMP("GMRCIF",$J,"MSA"),"|")="AR" D
 . N MSGID,MSGLOG,FDA,GMRCERR,GMRCE
 . S MSGID=$P(^TMP("GMRCIF",$J,"MSA"),"|",2)
 . S MSGLOG=$O(^GMR(123.6,"AM",MSGID,0)) Q:'MSGLOG
 . S GMRCE=$P(^TMP("GMRCIF",$J,"MSA"),"|",3)
 . S FDA(1,123.6,MSGLOG_",",.08)=GMRCE
 . I GMRCE=802 S FDA(1,123.6,MSGLOG_",",.06)="@"
 . D UPDATE^DIE("","FDA(1)",,"GMRCERR")
 . I GMRCE=901!(GMRCE=902) Q  ;no alerts on these probs (yet)
 . I GMRCE=201 D  Q
 .. I '$$GET^XPAR("SYS","GMRC IFC ALERT IMMED ON PT ERR",1) Q
 .. D SNDALRT^GMRCIERR(MSGLOG,"C","IFC patient error at remote facility")
 . D SNDALRT^GMRCIERR(MSGLOG,"C")
 K ^TMP("GMRCIF",$J)
 I $T(ORRIN^MAGDTR01)'="" D  ;invoke Imaging code if tag^routine exists
 . D ORRIN^MAGDTR01
 Q
 ;
VALMSG(GMRCORC,GMRCCRNR) ;check to make sure placer and filler # match current entr
 ; Input: 
 ;  GMRCORC = ORC segment from incoming HL7 msg
 ;
 I $P(GMRCORC,"|")="NW" Q 1 ; no #'s to match on new order ; MKN GMRC*3.0*154 added GMRCCRNR
 N GMRCPDA,GMRCFDA,GMRCPSIT,GMRCFSIT,GMRCROL,GMRCOK
 S GMRCPDA=+$P(GMRCORC,"|",2)
 S GMRCPSIT=$$IEN^XUAF4($P($P(GMRCORC,"|",2),U,2))
 S GMRCFDA=+$P(GMRCORC,"|",3)
 S GMRCFSIT=$$IEN^XUAF4($P($P(GMRCORC,"|",3),U,2))
 I $$KSP^XUPARAM("INST")=GMRCPSIT S GMRCROL="P"
 I $$KSP^XUPARAM("INST")=GMRCFSIT S GMRCROL="F"
 S GMRCOK=1
 I '$D(GMRCROL) S GMRCOK=0,GMRCROL="" ;bad institutions in msg
 I GMRCROL="P" D
 . I '$D(^GMR(123,GMRCPDA,0)) S GMRCOK=0 Q  ;no such cslt #
 . I $P(^GMR(123,GMRCPDA,0),U,22)'=GMRCFDA S GMRCOK=0 Q  ;cslt # prob
 . I $P(^GMR(123,GMRCPDA,0),U,23)'=GMRCFSIT S GMRCOK=0 Q  ;routing facil.
 I GMRCROL="F" D
 . I '$D(^GMR(123,GMRCFDA,0)) S GMRCOK=0 Q  ;no such cslt #
 . I $P(^GMR(123,GMRCFDA,0),U,22)'=GMRCPDA S GMRCOK=0 Q  ;cslt # prob
 . I $P(^GMR(123,GMRCFDA,0),U,23)'=GMRCPSIT S GMRCOK=0 Q  ;routing facil.
 I 'GMRCOK D  ;return a 101 error to sending site
 . N GMRCRSLT
 . D RESP^GMRCIUTL("AR",HL("MID"),,,101) ;build HLA(
 . D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"LM",1,.GMRCRSLT) ;-(
 Q GMRCOK
 ;
 ;MKN GMRC*3.0*154 - setting up variables required by DECODE^GMRCHL7E - see call at current line 17 above
SETTCH() ;Set up TCH array with decoding characters
 N GMRCI
 F GMRCI=1:1:4 S TCH($P("\E\-\R\-\S\-\T\","-",GMRCI))=$E("\~^&",GMRCI)
 Q
 ;
SETTCH2()  ;Set up TCH array with encoding characters
 N GMRCI
 F GMRCI=1:1:4 S TCH($E("\~^&",GMRCI))=$P("\E\-\R\-\S\-\T\","-",GMRCI)
 Q
 ;
