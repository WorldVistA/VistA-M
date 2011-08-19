GMRCISEG ;SLC/JFR - CREATE IFC HL7 SEGMENTS ;08/16/10  08:30
 ;;3.0;CONSULT/REQUEST TRACKING;**22,66**;DEC 27, 1997;Build 30
 ;   $$GET1^DIQ          ORC+28,ORC+29,OBXTZ+11
 ;#2171 XUAF4, #10103 XLFDT, #10106 HLFNC, #3042 MCAPI, #10112 VASITE, #2541 $$KSP^XUPARAM
 ;
 Q  ;don't enter at top
BUILD(SEG,PCS) ;create any segment from array in PCS using |^&/~
 ; SEG = ORC,OBR,etc.
 ; PCS = array of data elements to be combined into the segement
 ;       array is numbered by the "|" piece
 N ARR,SEGMNT
 S ARR=0,SEGMNT=""
 F  S ARR=$O(PCS(ARR)) Q:'ARR  D
 . S $P(SEGMNT,"|",ARR)=PCS(ARR)
 . Q
 Q SEG_"|"_SEGMNT
ORC(GMRCO,GMRCOC,GMRCOS,GMRCACT)    ;build ORC for all but new orders
 ;Input:
 ; GMRCO = ien from file 123
 ; GMRCOC = order control
 ; GMRCOS = order status
 ; GMRCACT = ien in 40 multiple of particular action
 ;
 ;Output:
 ; ORC segment
 ;
 I '$D(GMRCO)!('$D(GMRCOC))!('$D(GMRCACT)) Q "ERROR"
 N GMRCPCS,SITE,GMRCRP
 S GMRCPCS(1)=GMRCOC
 I $P($G(^GMR(123,GMRCO,12)),U,5)="P" D
 . S GMRCPCS(2)=GMRCO_U_$$STA^XUAF4($$KSP^XUPARAM("INST"))_"^GMRCIFR"
 . S GMRCPCS(3)=$P(^GMR(123,GMRCO,0),U,22)_U_$$STA^XUAF4($P(^(0),U,23))
 . S GMRCPCS(3)=GMRCPCS(3)_"^GMRCIFC"
 I $P($G(^GMR(123,GMRCO,12)),U,5)="F" D
 . S GMRCPCS(2)=$P(^GMR(123,GMRCO,0),U,22)_U_$$STA^XUAF4($P(^(0),U,23))
 . S GMRCPCS(2)=GMRCPCS(2)_"^GMRCIFR"
 . S GMRCPCS(3)=GMRCO_U_$$STA^XUAF4($$KSP^XUPARAM("INST"))_"^GMRCIFC"
 S GMRCPCS(5)=$S($D(GMRCOS):GMRCOS,1:"")
 I GMRCOC["X" D
 .S $P(GMRCPCS(7),U,4)=$$FMTHL7^XLFDT($P(^GMR(123,GMRCO,0),U,24)) ;wat/66
 .S $P(GMRCPCS(7),U,6)=$$URG^GMRCIUTL(GMRCO)
 S GMRCPCS(9)=$$FMTHL7^XLFDT($P(^GMR(123,GMRCO,40,GMRCACT,0),U,1))
 S GMRCPCS(10)=$$HLNAME^GMRCIUTL($P(^GMR(123,GMRCO,40,GMRCACT,0),U,5))
 S GMRCRP=$P(^GMR(123,GMRCO,40,GMRCACT,0),U,4) I +GMRCRP D
 . S GMRCPCS(12)=$$HLNAME^GMRCIUTL(GMRCRP)
 . N GMRCPHN,GMRCPAG
 . S GMRCPHN=$$GET1^DIQ(200,GMRCRP,.132)
 . S GMRCPAG=$$GET1^DIQ(200,GMRCRP,.138)
 . S GMRCPCS(14)=$$HLPHONE^HLFNC(GMRCPHN,GMRCPAG)
 S GMRCPCS(15)=$$FMTHL7^XLFDT($P(^GMR(123,GMRCO,40,GMRCACT,0),U,3))
 I GMRCOC["X"!(GMRCOC="SC")!(GMRCOC="RE") D
 . I GMRCOC="XX" D  Q
 .. I $P(^GMR(123,GMRCO,40,GMRCACT,0),U,2)=25 D  Q
 ... S GMRCPCS(16)="FI^FORWARD TO IFC^99GMRC"
 .. S GMRCPCS(16)="F^FORWARD^99GMRC"
 . I GMRCOC="XO" S GMRCPCS(16)="E^EDIT-RESUBMIT^99GMRC" Q
 . I GMRCOC="SC" D  Q
 .. I GMRCOS="IP" S GMRCPCS(16)="R^RECEIVE^99GMRC"
 .. I GMRCOS="SC"  S GMRCPCS(16)="SC^SCHEDULE^99GMRC"
 . I GMRCOC="RE" D
 .. N ACTVT S ACTVT=$P(^GMR(123,GMRCO,40,GMRCACT,0),U,2)
 .. I ACTVT=12 S GMRCPCS(16)="D^DISASSOCIATE RESULT^99GMRC"
 .. I ACTVT=13 S GMRCPCS(16)="A^ADDENDUM^99GMRC"
 .. I ACTVT=4 S GMRCPCS(16)="S^SIGNIFICANT FINDING^99GMRC"
 . Q
 S SITE=$$SITE^VASITE
 I +SITE S GMRCPCS(17)=$P(SITE,U,3)_U_$P(SITE,U,2) ;use loc instead? ;-(
 Q $$BUILD^GMRCISEG("ORC",.GMRCPCS)
 ;
OBXWP(GMRCO,GMRCOC,GMRCACT,GMRCSEG) ; return a WP field in OBX segs
 ; Input:
 ;  GMRCO   =
 ;  GMRCOC  =
 ;  GMRCACT = activity in 40 mult triggering msg
 ;  GMRCSEG = GLOBAL array to return results in
 ;
 ; Output:
 ;  ARRAY(1)=OBX|1|TX|coding scheme|1|text||||||obs result status
 ;  ARRAY(2)=OBX|1|TX|coding scheme|2|text||||||obs result status
 ;
 K ^TMP("GMRCWP",$J)
 N GMRCPCS
 I GMRCOC="NW"!(GMRCOC="XO") D  Q
 . N SUBS S SUBS=0
 . F  S SUBS=$O(^GMR(123,GMRCO,20,SUBS)) Q:'SUBS  D
 .. S GMRCPCS(1)=1,GMRCPCS(2)="TX"
 .. S GMRCPCS(3)="2000.02^REASON FOR REQUEST^AS4",GMRCPCS(4)=SUBS
 .. S GMRCPCS(5)=$G(^GMR(123,GMRCO,20,SUBS,0)),GMRCPCS(11)="O"
 .. S ^TMP("GMRCWP",$J,SUBS)=$$BUILD^GMRCISEG("OBX",.GMRCPCS)
 . M @GMRCSEG=^TMP("GMRCWP",$J)
 . K ^TMP("GMRCWP",$J)
 . Q
 I '$D(GMRCACT)!('$D(^GMR(123,GMRCO,40,GMRCACT,1))) Q
 N CMT,ACTVT
 S CMT=0,ACTVT=$P(^GMR(123,GMRCO,40,GMRCACT,0),U,2)
 F  S CMT=$O(^GMR(123,GMRCO,40,GMRCACT,1,CMT)) Q:'CMT  D
 . S GMRCPCS(1)=3,GMRCPCS(2)="TX"
 . S GMRCPCS(3)="^COMMENTS^",GMRCPCS(4)=CMT
 . S GMRCPCS(5)=$G(^GMR(123,GMRCO,40,GMRCACT,1,CMT,0))
 . S GMRCPCS(11)=$S(ACTVT=10:"F",1:"P") ;F if an admin comp. else "P"
 . S ^TMP("GMRCWP",$J,CMT)=$$BUILD^GMRCISEG("OBX",.GMRCPCS)
 M @GMRCSEG=^TMP("GMRCWP",$J)
 K ^TMP("GMRCWP",$J)
 Q
 ;
OBXRSLT(GMRCO,GMRCACT) ; build an OBX segment to send a TIU doc reference
 ; Input:
 ;  GMRCO   = ien from file 123
 ;  GMRCACT = activity entry in 40 multiple
 ;
 ; Output:
 ;  OBX segment
 ;    e.g. OBX|4|RP|^TIU DOC^VA8925||41320^TIU^660||||||||F
 ;
 Q:'$D(^GMR(123,GMRCO,40,GMRCACT)) ""
 N GMRCPCS,RSLT,GMRCACTV
 S GMRCPCS(1)=4,GMRCPCS(2)="RP"
 S GMRCPCS(4)=1
 S GMRCACTV=$P(^GMR(123,GMRCO,40,GMRCACT,0),U,2)
 S RSLT=$P(^GMR(123,GMRCO,40,GMRCACT,0),U,9)
 I RSLT["TIU" D
 . S GMRCPCS(3)="^TIU DOC^VA8925"
 . S GMRCPCS(5)=+RSLT_"^TIU DOCUMENT^"_$$STA^XUAF4($$KSP^XUPARAM("INST"))
 I RSLT["MCAR" D
 . N MCPRNM S MCPRNM=$P($$SINGLE^MCAPI(RSLT),U)
 . S GMRCPCS(3)="^MED RSLT^VA"_+$P(RSLT,"MCAR(",2)
 . S GMRCPCS(5)=+RSLT_U_MCPRNM_U_$$STA^XUAF4($$KSP^XUPARAM("INST"))
 S GMRCPCS(11)=$S(GMRCACTV=9:"S",GMRCACTV=12:"D",1:"F")
 Q $$BUILD^GMRCISEG("OBX",.GMRCPCS)
 ;
NTE(GMRCO,GMRCACT,GMRCAR) ;format an NTE seg with DC comment
 ; Input:
 ;  GMRCO   = ien from file 123
 ;  GMRCACT = activity entry in 40 multiple
 ;  GMRCAR  = array in which to pass back NTE segs
 ;
 ; Output:
 ;  array of NTE segments containing the comment
 ;   e.g. NTE|1|L|cancelled by requestor
 ;
 Q:'$D(^GMR(123,GMRCO,40,GMRCACT,1))
 N CMT,GMRCPCS S CMT=0
 F  S CMT=$O(^GMR(123,GMRCO,40,GMRCACT,1,CMT)) Q:'CMT  D
 . S GMRCPCS(1)=CMT,GMRCPCS(2)="L"
 . S GMRCPCS(3)=$G(^GMR(123,GMRCO,40,GMRCACT,1,CMT,0))
 . S GMRCAR(CMT)=$$BUILD^GMRCISEG("NTE",.GMRCPCS)
 Q
 ;
MSA(GMRCAC,GMRCMSG,GMRCERR) ; build MSA for response to placer activity
 ; Input:
 ;  GMRCAC  = acknowledgment code  (AA or AR)
 ;  GMRCMSG = message number from incoming msg being responded to
 ;  GMRCERR = error message if can't accept the activity
 ;
 ; Output:
 ;  MSA segment to include with ACK or NAK
 ;
 N GMRCPCS
 S GMRCPCS(1)=GMRCAC
 S GMRCPCS(2)=GMRCMSG
 S GMRCPCS(3)=$G(GMRCERR)
 Q $$BUILD^GMRCISEG("MSA",.GMRCPCS)
 ;
OBXTZ() ;build and return an OBX with the current TIME ZONE encoded
 ;Input:
 ;  none
 ;
 ;Output:
 ;  OBX segment in the format:
 ;    OBX|5|CE|^TIME ZONE^VA4.4|1|MST||||||0
 N GMRCPCS
 S GMRCPCS(1)=5,GMRCPCS(2)="CE" ;WAT/66
 S GMRCPCS(3)="^TIME ZONE^VA4.4",GMRCPCS(4)=1
 S GMRCPCS(5)=$$GET1^DIQ(4.3,1,1)
 Q $$BUILD^GMRCISEG("OBX",.GMRCPCS)
 ;
OBXSF(GMRCO) ; build OBX seg for Sig. Find.
 ; Input:
 ;  GMRCO = ien from file 123
 ;
 ; Output:
 ;   OBX segment in format:
 ;     OBX|6|TX|^SIG FINDINGS^|1|S||||||O
 ;
 I '$L($P(^GMR(123,GMRCO,0),U,19)) Q ""
 N GMRCPCS
 S GMRCPCS(1)=6,GMRCPCS(2)="TX",GMRCPCS(3)="^SIG FINDINGS^"
 S GMRCPCS(4)=1,GMRCPCS(5)=$P(^GMR(123,GMRCO,0),U,19),GMRCPCS(11)="O"
 Q $$BUILD^GMRCISEG("OBX",.GMRCPCS)
