GMRCIAC2 ;SLC/JFR - FILE IFC ACTIVITIES CONT'D ;08/16/10  08:34
 ;;3.0;CONSULT/REQUEST TRACKING;**22,28,35,66**;DEC 27, 1997;Build 30
 ;;ICRs in use
 ;;#2053 DIE, #2171 XUAF4, #10103 XLFDT, #2541 $$KSP^XUPARAM, #2165 HLMA1
 Q  ;can't start here
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
 ;
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
FILEACT(GMRCO,GMRCLAST,GMRCFR,GMRCAR) ;file REQUEST PROCESSING ACTIVITY
 ; Input:
 ;  GMRCO     = ien from file 123
 ;  GMRCLAST  = last action taken on request
 ;  GMRCFR    = service that consult was forwarded from
 ;  GMRCAR    = name of the array containing the message
 ;
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
 I $$IEN^XUAF4($P(GMRCORC2,U,2))=$$KSP^XUPARAM("INST") Q +GMRCORC2
 Q +GMRCORC3
 ;
DUPACT(GMRCO,ACTVT,ORC,OBX) ;check to see if activity is a dup transmission
 ;Input:
 ;  GMRCO = ien of consult
 ;  ACTVT = ien of activity from file 123.1
 ;  ORC   = ORC segment from message
 ;  OBX   = OBX segment containing result
 ;
 ;Output:
 ;  0  = activity is not a duplicate of one on file already
 ;  1  = duplicate, activity already on file
 ;
 N GMRCIADT,GMRCIFDT,DUP
 S GMRCIFDT=+$$HL7TFM^XLFDT($P(ORC,"|",9))
 S GMRCIADT=+$$HL7TFM^XLFDT($P(ORC,"|",15))
 S DUP=0
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
 . D APPACK(GMRCO,"AR",802) ;send app. ACK and unlock record
 Q 0
 ;
APPACK(GMRCO,ACK,ERR) ;send application acknowledgement for all cases
 ;Input:
 ;  GMRCO = ien from file 123
 ;  ACK   = ACK code to include  ("AA"=accept or "AR"=reject)
 ;  ERR   = error code to return if there is one (optional)
 ;
 ; Output: none
 ;
 ;send appl ACK
 N GMRCRSLT
 I '$G(ERR) S ERR=""
 D RESP^GMRCIUTL(ACK,HL("MID"),,,ERR) ;build HLA("HLA", array
 D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"LM",1,.GMRCRSLT)
 ;
 D UNLKREC^GMRCUTL1(GMRCO) ;unlock record
 Q
