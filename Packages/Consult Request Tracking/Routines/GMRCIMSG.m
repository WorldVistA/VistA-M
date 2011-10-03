GMRCIMSG ;SLC/JFR - IFC MESSAGE HANDLING ROUTINE; 09/26/02 00:23
 ;;3.0;CONSULT/REQUEST TRACKING;**22,28,51,44**;DEC 27, 1997
 ;
 Q  ;don't start at the top
IN ;process incoming message and save segments to ^TMP(
 K ^TMP("GMRCIF",$J)
 N HLNODE,SEG,I,GMRCIER  ;production code
 F I=1:1 X HLNEXT Q:HLQUIT'>0  D
 . I $P(HLNODE,"|")="OBX" D  ;multiple segs for OBX
 .. S ^TMP("GMRCIF",$J,"OBX",$P(HLNODE,"|",2),$P(HLNODE,"|",5))=$E(HLNODE,5,999)
 . I $P(HLNODE,"|")="NTE" D  ; may be multiple NTE's
 .. S ^TMP("GMRCIF",$J,"NTE",$P(HLNODE,"|",2))=$E(HLNODE,5,999)
 . I "OBXNTE"'[$P(HLNODE,"|") D  ;all other segs are single
 .. S ^TMP("GMRCIF",$J,$P(HLNODE,"|"))=$E(HLNODE,5,999)
 . Q
 ;
 I '$$VALMSG(^TMP("GMRCIF",$J,"ORC")) D EX Q  ;chk msg for valid cslt #'s
 ;
 I $P(^TMP("GMRCIF",$J,"ORC"),"|")="NW" D  D EX Q
 . I $P(^TMP("GMRCIF",$J,"ORC"),"|",2)["TST1234" D  D EX Q  ;testing impl
 .. D TST^GMRCIAC2($NA(^TMP("GMRCIF",$J)))
 . D NW^GMRCIACT($NA(^TMP("GMRCIF",$J)))
 I $P(^TMP("GMRCIF",$J,"ORC"),"|")="XO" D  D EX Q
 . D RESUB^GMRCIAC1($NA(^TMP("GMRCIF",$J)))
 I $P(^TMP("GMRCIF",$J,"ORC"),"|")="XX" D  D EX Q
 . D FWD^GMRCIAC1($NA(^TMP("GMRCIF",$J)))
 I $P(^TMP("GMRCIF",$J,"ORC"),"|")="RE" D  D EX Q
 . I $P($G(^TMP("GMRCIF",$J,"OBX",4,1)),"|",11)="D" D  Q
 .. D DIS^GMRCIACT($NA(^TMP("GMRCIF",$J))) ; dis-assoc. result
 . I $P($P(^TMP("GMRCIF",$J,"ORC"),"|",16),U)="S" D  Q
 .. D SF^GMRCIAC1($NA(^TMP("GMRCIF",$J))) ; significant findings
 . D COMP^GMRCIAC1($NA(^TMP("GMRCIF",$J)))
 D OTHER^GMRCIACT($NA(^TMP("GMRCIF",$J)))
 D EX
 Q
 ;
EX ; clean up ^TMP(
 K ^TMP("GMRCIF",$J)
 ;call Prosthetics routine - added for RMPR*3*83
 I $T(EN^RMPRFC3)'="" D  ;invoke prosthetics code if tag^routine exists
 . D EN^RMPRFC3
 Q
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
VALMSG(GMRCORC) ;check to make sure placer and filler # match current entry
 ; Input: 
 ;  GMRCORC = ORC segment from incoming HL7 msg
 ;
 I $P(GMRCORC,"|")="NW" Q 1 ; no #'s to match on new order
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
