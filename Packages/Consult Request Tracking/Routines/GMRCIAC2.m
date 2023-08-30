GMRCIAC2 ;SLC/JFR - FILE IFC ACTIVITIES CONT'D ; Feb 6, 2023@11:28:17
 ;;3.0;CONSULT/REQUEST TRACKING;**22,28,35,66,154,184,193**;DEC 27, 1997;Build 40
 ;
 ; Reference to ^DIE in ICR #2053
 ; Reference to ^XUAF4 in ICR #2171
 ; Reference to ^XLFDT in ICR #10103
 ; Reference to $$KSP^XUPARAM in ICR #2541
 ; Reference to ^HLMA1 in ICR #2165
 ;
 Q  ;can't start here
 ;
FILRES(GMRCO,GMRCOBX) ;file or delete results
 N GMRCRES,GMRCFIL,GMRCSITE,GMRCROOT,RESIEN,GMRCERR
 S GMRCRES=+$P(GMRCOBX,"|",5)
 S GMRCFIL=$P($P(GMRCOBX,"|",3),U,3)
 S GMRCROOT=$S($P($P(GMRCOBX,"|",3),U,2)["TIU":"TIU(",1:"MCAR(")
 S GMRCFIL=$P(GMRCFIL,"VA",2)
 S GMRCRES=GMRCRES_";"_GMRCROOT_GMRCFIL
 S GMRCSITE=$$IEN^XUAF4($P($P(GMRCOBX,"|",5),U,3))
 I $P(GMRCOBX,"|",11)'="D" D  ;add new result
 . S FDA(1,123.051,"+1,"_GMRCO_",",.01)=$$NOW^XLFDT
 . S FDA(1,123.051,"+1,"_GMRCO_",",.02)=GMRCRES
 . S FDA(1,123.051,"+1,"_GMRCO_",",.03)=GMRCSITE
 I $P(GMRCOBX,"|",11)="D" D  ; find and delete result
 . N RESIEN
 . S RESIEN=$O(^GMR(123,GMRCO,51,"AR",GMRCRES,GMRCSITE,0))
 . I 'RESIEN Q
 . S FDA(1,123.051,RESIEN_","_GMRCO_",",.01)="@"
 I '$D(FDA) Q
 D UPDATE^DIE("","FDA(1)",,"GMRCERR")
 Q
UPDORD(GMRCDA,GMRC40) ; update CPRS order if action on placer order.
 ; Input:
 ;  GMRCDA   = ien from file 123
 ;  GMRC40 = ien of activity in 40 multiple
 ;
 N GMRCDFN,GMRCAD,AC,GMRCOC,GMRCMT
 S GMRCDFN=$P(^GMR(123,GMRCDA,0),U,2)
 I $O(^GMR(123,GMRCDA,40,GMRC40,1,0)) D
 . S GMRCMT=1,GMRCMT(0)=GMRC40
 S GMRCAD=$P(^GMR(123,GMRCDA,40,GMRC40,0),U,3)
 S AC=$P(^GMR(123,GMRCDA,40,GMRC40,0),U,2)
 S GMRCOC=$S(AC=6:"OD",AC=19:"OC",AC=10:"RE",AC=9:"RE",AC=8:"ZC",1:"SC")
 D EN^GMRCHL7(GMRCDFN,GMRCDA,"","",GMRCOC,"","",.GMRCMT,,GMRCAD)
 Q
FILEACT(GMRCO,GMRCLAST,GMRCFR,GMRCAR,GMRCCRNR,GMRCROUT) ;file REQUEST PROCESSING ACTIVITY - P184
 ; Input:
 ;  GMRCO     = ien from file 123
 ;  GMRCLAST  = last action taken on request
 ;  GMRCFR    = service that consult was forwarded from
 ;  GMRCAR    = name of the array containing the message
 ;  GMRCCRNR  = 1 if from Cerner [OPTIONAL]
 ;  GMRCROUT  = Routine station [OPTIONAL]
 ;
 K ^TMP("GMRCFIL",$J) ;p193
 N GMRCORC,GMRCFDA,GMRCRP,GMRCEP,GMRCACT,GMRCERR,FDA
 M ^TMP("GMRCFIL",$J)=@GMRCAR
 S GMRCORC=^TMP("GMRCFIL",$J,"ORC")
 S GMRCFDA(.01)=$$NOW^XLFDT
 S GMRCFDA(.25)=$$HL7TFM^XLFDT($P(GMRCORC,"|",9))
 S GMRCFDA(1)=GMRCLAST
 S GMRCFDA(2)=$$HL7TFM^XLFDT($P(GMRCORC,"|",15))
 D  ;get entering and responsible persons
 . D UNHLNAME^GMRCIUTL($P(GMRCORC,"|",10),.GMRCEP,0,U)
 . D UNHLNAME^GMRCIUTL($P(GMRCORC,"|",12),.GMRCRP,0,U)
 S GMRCFDA(.21)=GMRCEP
 S GMRCFDA(.22)=GMRCRP
 S GMRCFDA(.23)=$P($G(^TMP("GMRCFIL",$J,"OBX",5,1)),"|",5)
 I $G(GMRCCRNR) S GMRCFDA(.32)=1,GMRCFDA(.33)=$G(GMRCROUT) ; WTC P184
 I $D(GMRCFR) S GMRCFDA(.31)=GMRCFR
 I $D(^TMP("GMRCFIL",$J,"OBX",4)) D
 . N RFIL,RSLT,DESC,GMRCOBX,ROOT,RSITE
 . S GMRCOBX=^TMP("GMRCFIL",$J,"OBX",4,1)
 . S RFIL=$P($P(GMRCOBX,"|",3),U,3),RFIL=$P(RFIL,"VA",2)
 . S RSLT=+$P(GMRCOBX,"|",5)
 . S RSITE=$$IEN^XUAF4($P($P(GMRCOBX,"|",5),U,3))
 . S ROOT=$S($P($P(GMRCOBX,"|",3),U,2)["TIU":"TIU(",1:"MCAR(")
 . S DESC=$P($P(GMRCOBX,"|",5),U,2)
 . S GMRCFDA(.24)=RSLT_";"_ROOT_RFIL_";"_DESC_";"_RSITE
 I GMRCLAST=10 D  ; overwite inc. report in last action?
 . N GMRCLACT
 . S GMRCLACT=$O(^GMR(123,GMRCO,40," "),-1)
 . I '$G(GMRCLACT) Q
 . I $P($G(^GMR(123,GMRCO,40,GMRCLACT,0)),U,2)'=9 Q
 . I $$FMDIFF^XLFDT($$NOW^XLFDT,+^GMR(123,GMRCO,40,GMRCLACT,0),2)>900 Q
 . I $P($G(^GMR(123,GMRCO,40,GMRCLACT,2)),U,4)=GMRCFDA(.24) D
 .. S GMRCACT(1)=GMRCLACT
 .. M FDA(1,123.02,GMRCACT(1)_","_GMRCO_",")=GMRCFDA
 .. D UPDATE^DIE("","FDA(1)",,"GMRCERR")
 . Q
 I '$D(GMRCACT(1)) D  ; need to create new activity
 . M FDA(1,123.02,"+1,"_GMRCO_",")=GMRCFDA
 . D UPDATE^DIE("","FDA(1)","GMRCACT","GMRCERR")
 K GMRCFDA,FDA
 D  ; file comments if present
 . I $D(^TMP("GMRCFIL",$J,"OBX",3)) D  ; general comments
 .. N TMPARR
 .. S TMPARR=$NA(^TMP("GMRCFIL",$J,"OBX",3))
 .. D TRIMWP^GMRCIUTL(TMPARR,5)
 .. D WP^DIE(123.02,GMRCACT(1)_","_GMRCO_",",5,"K",TMPARR)
 . I $D(^TMP("GMRCFIL",$J,"NTE")) D  ; DC or cancel comments
 .. N TMPARR
 .. S TMPARR=$NA(^TMP("GMRCFIL",$J,"NTE"))
 .. D TRIMWP^GMRCIUTL(TMPARR,3)
 .. D WP^DIE(123.02,GMRCACT(1)_","_GMRCO_",",5,"K",TMPARR)
 .. Q
 D  ; update order if necessary
 . I $P($G(^GMR(123,GMRCO,12)),U,5)="F" Q  ; fillers have no order
 . I GMRCLAST=11!(GMRCLAST=13)!(GMRCLAST=14) Q  ;no status chg
 . I GMRCLAST=4!(GMRCLAST=20) Q  ;no status chg
 . D UPDORD(GMRCO,GMRCACT(1))
 K ^TMP("GMRCFIL",$J)
 Q
 ;
TST(ARRAY) ;process test message and check item ordered
 ;Input:
 ; ARRAY  = name of array containing message parts
 ;
 N GMRCFDA,GMRCORC,GMRCDA,GMRCITM,GMRCITER
 K ^TMP("GMRCIN",$J)
 M ^TMP("GMRCIN",$J)=@ARRAY
 D  ;get ordered item and service
 . S GMRCITM=$P(^TMP("GMRCIN",$J,"OBR"),"|",4)
 . I GMRCITM["VA1233" D  ; proc
 .. N PROC
 .. S PROC=$$GETPROC^GMRCIUTL(GMRCITM)
 .. I +PROC'>0!('$P(PROC,U,2)) S GMRCITER=$P(PROC,U,3) Q
 . I GMRCITM["VA1235" D
 .. N SERV
 .. S SERV=$$GETSERV^GMRCIUTL(GMRCITM) ;consult
 .. I +SERV'>0 S GMRCITER=$P(SERV,U,3)
 I $D(GMRCITER) D  ;error in procedure or service, reject new order
 . N GMRCRSLT
 . D RESP^GMRCIUTL("AR",HL("MID"),,,GMRCITER) ;build HLA(
 . D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"LM",1,.GMRCRSLT)
 I '$D(GMRCITER) D
 . N GMRCRSLT
 . D RESP^GMRCIUTL("AA",HL("MID")) ;build HLA(
 . D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"LM",1,.GMRCRSLT)
 K ^TMP("GMRCIN",$J)
 Q
 ;
GETDA(GMRCORC) ; determine what local Consult ien to work on
 ; Input:
 ;  GMRCORC = ORC seg from incoming message
 ; Output:
 ;  ien from file 123
 ;
 N GMRCORC2,GMRCORC3
 S GMRCORC2=$P(GMRCORC,"|",2),GMRCORC3=$P(GMRCORC,"|",3)
 ;
 ; JCH-EHRM-GMRC*3*154 - Allow inbound Cerner Updates to use Placer (ORC-3) Order 
 ; as Vista Consults Order # where following conditions are true
 ;   1) IF filler station # (ORC-3.2) = placer station # (ORC-2.2)
 ;       - 1.1) hould be unique to EHRM Prosthetics
 ;   2) AND if OBR-4 contains "Prosthetics IFC" or "(PSAS)"
 ;       - 2.1) Cerner specific - Vista does not send OBR when ORC-3 populated
 ;   3) AND if Filler station # (ORC-3.2) = local station # (ORC-2.2)
 ;       - 3.1) Must be associated with local station
 ;   4) AND if ORC-3.1 Filler Order Number exists in ^GMR(123
 ;       - 4.1) Order exists ^GMR(123,GMRCDA,0) 
 ;       - 4.2) this will cause hard error if not true (in OTHER+13^GMRCIACT)
 ; THEN always use ORC-3.1 as local consult Order # 
 ;
 N GMRCOBR4 S GMRCOBR4=$P($G(^TMP("GMRCIN",$J,"OBR")),"|",4)
 I ($P(GMRCORC2,U,2)=$P(GMRCORC3,U,2)),((GMRCOBR4["PROSTHETICS IFC")!(GMRCOBR4["PSAS")),$$IEN^XUAF4($P(GMRCORC2,U,2))=$$KSP^XUPARAM("INST"),$D(^GMR(123,+GMRCORC3,0)) Q +GMRCORC3
 ;
 I $$IEN^XUAF4($P(GMRCORC2,U,2))=$$KSP^XUPARAM("INST") Q +GMRCORC2
 Q +GMRCORC3
 ;
DUPACT(GMRCO,ACTVT,ORC,OBX,CRNR,MSGI) ;check to see if activity is a dup transmission ;MKN added CRNR and MSGI
 ;Input:
 ;  GMRCO = ien of consult
 ;  ACTVT = ien of activity from file 123.1
 ;  ORC   = ORC segment from message
 ;  OBX   = OBX segment containing result
 ;  CRNR  = 1 if message came from Cerner
 ;  MSGI  = message ID
 ;
 ;Output:
 ;  0  = activity is not a duplicate of one on file already
 ;  1  = duplicate, activity already on file
 ;
 N GMRCIADT,GMRCIFDT,DUP
 S GMRCIFDT=+$$HL7TFM^XLFDT($P(ORC,"|",9))
 S GMRCIADT=+$$HL7TFM^XLFDT($P(ORC,"|",15))
 S DUP=0
 S CRNR=$G(CRNR,0),MSGI=$G(MSGI) ; MKN GMRC*3.0*154
 I $D(^GMR(123,GMRCO,40,"AC",ACTVT,GMRCIFDT,GMRCIADT)) D  Q DUP ;dupl.
 . N RSLT,RFIL,RSITE,ROOT
 . I $L($G(OBX)) D  Q:'$G(DUP)
 .. S RFIL=$P($P(OBX,"|",3),U,3),RFIL=$P(RFIL,"VA",2)
 .. S RSLT=+$P(OBX,"|",5)
 .. S RSITE=$$IEN^XUAF4($P($P(OBX,"|",5),U,3))
 .. S ROOT=$S($P($P(OBX,"|",3),U,2)["TIU":"TIU(",1:"MCAR(")
 .. S RSLT=RSLT_";"_ROOT_RFIL
 .. I ACTVT=12,$D(^GMR(123,GMRCO,51,"AR",RSLT,RSITE)) Q  ;no dup
 .. I ACTVT'=12,'$D(^GMR(123,GMRCO,51,"AR",RSLT,RSITE)) Q  ;no dup
 .. S DUP=1
 . S DUP=1
 . D APPACK(GMRCO,"AR",802,CRNR,MSGI) ;send app. ACK and unlock record
 Q 0
 ;
APPACK(GMRCO,ACK,ERR,CRNR,MSGID) ;send application acknowledgement for all cases ;MKN GMRC*3*154 added CRNR and MSGID
 ;Input:
 ;  GMRCO = ien from file 123
 ;  ACK   = ACK code to include  ("AA"=accept or "AR"=reject)
 ;  ERR   = error code to return if there is one (optional)
 ;  CRNR  = 1 message came from Cerner  ELSE  message did not come from Cerner
 ;  MSGID = HL7 message ID
 ;
 ; Output: none
 ;
 ;send appl ACK
 N GMRCRSLT
 I '$G(ERR) S ERR=""
 S CRNR=$G(CRNR,0),MSGID=$G(MSGID)
 D RESP^GMRCIUTL(ACK,HL("MID"),,,ERR) ;build HLA("HLA", array
 D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"LM",1,.GMRCRSLT)
 ;
 D UNLKREC^GMRCUTL1(GMRCO) ;unlock record
 ;
 ;MKN GMRC*3*154 - If message came from Cerner, MailMan messages should be sent to GMRC CRNR, and GMRC TIER II mail group(S) for this error code - see tag CRNR below
 Q:'CRNR!('$T(@+ERR))
 D MGMSG(ERR,MSGID)
 Q
 ;
MGMSG(ERR,MSGID) ;Send message to required mail groups
 N GMRCERR,GMRCMG,GMRCMGN,GMRCMGNA,GMRCORG,GMRCPAR,GMRCX
 S GMRCMG=$T(@ERR),GMRCERR=$P(GMRCMG,";",6),MSGID=$G(MSGID) F GMRCMGN=2:1 S GMRCX=$P(GMRCMG,";",GMRCMGN) Q:GMRCX=""  D:GMRCX
 . S GMRCPAR=$P($T(CRNR),";",GMRCMGN),GMRCMGNA=$$GET^XPAR("SYS",GMRCPAR)
 . I GMRCMGNA S GMRCORG=$$GET1^DIQ(3.8,GMRCMGNA,5,"I"),GMRCMGNA=$$GET1^DIQ(3.8,GMRCMGNA,.01) D:GMRCMGNA]"" SENDMSG(GMRCMGNA,ERR,GMRCERR,MSGID)
 Q
 ;
SENDMSG(GRP,ERR,ERRTEXT,MSGID) ; Send a MailMan Message with the errors
 N GRPIEN,MEM,XMDUZ,XMSUB,XMTEXT,XMY
 S XMSUB="Failed IFC transaction: "_ERRTEXT,XMTEXT="XMTEXT("
 D:$G(MSGID)]""
 . S XMTEXT(1)="HL7 Message ID: "_$P(MSGID,U)
 . S XMTEXT(2)="Date and time of message: "_$P(MSGID,U,2)
 . S XMTEXT(3)="Error # "_ERR_" ("_ERRTEXT_")"
 D:$G(MSGID)=""
 . S XMTEXT(1)="Error # "_ERR_" ("_ERRTEXT_")"
 S GRPIEN=$O(^XMB(3.8,"B",GRP,"")) Q:'GRPIEN
 ;Set up XMY for MEMBERS
 S MEM=0 F  S MEM=$O(^XMB(3.8,GRPIEN,1,MEM)) Q:'MEM  S XMY($P(^XMB(3.8,GRPIEN,1,MEM,0),U))=""
 ;Set up XMY for MEMBERS REMOTE
 S MEM=0 F  S MEM=$O(^XMB(3.8,GRPIEN,6,MEM)) Q:'MEM  S XMY($P(^XMB(3.8,GRPIEN,6,MEM,0),U))=""
 Q:'$D(XMY)
 S XMDUZ=GRP
 D XMZ^XMA2 ; call Create Message Module
 D EN1^XMD
 Q
 ;
CRNR ;GMRC CRNR IFC ERRORS;GMRC CRNR IFC TECH ERRORS;GMRC CRNR IFC CLIN ERRORS;GMRC TIER II CRNR IFC ERRORS
101 ;1;1;0;1;Unknown Consult/Procedure request
202 ;1;0;1;1;Local or Unknown MPI Identifiers
301 ;1;0;1;1;Service not Matched to Receiving Facility
401 ;1;0;1;1;Procedure not Matched to Receiving Facility
501 ;1;0;1;1;Error in Procedure Name
601 ;1;0;1;1;Multiple Services Matched to Procedure
701 ;1;0;1;1;Error in Service Name
702 ;1;0;1;1;Service is Disabled
703 ;1;0;1;1;Procedure is Inactive
801 ;1;1;0;1;Inappropriate Action for Specified Request
802 ;1;0;0;1;Duplicate, activity not filed
901 ;1;0;0;1;Unable to Update Record Successfully
902 ;1;0;0;1;Earlier Pending Transactions
903 ;0;0;0;0;HL Logical Link not Found - will not hit the APPACK API
904 ;0;0;0;0;VistA HL7 Unable to Send Transaction - will not hit the APPACK API
201 ;0;0;0;0;Unknown Patient - will not hit the APPACK API
 ;End of MKN GMRC*3*154
 ;
