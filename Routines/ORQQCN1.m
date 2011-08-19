ORQQCN1 ; slc/REV - Functions for GUI consult actions - RPCs for GMRCGUIA ; 8-NOV-2000 14:49:16 [1/9/01 10:39am]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,98,85,109,148**;Dec 17, 1997
 ;
RC(Y,GMRCO,GMRCORNP,GMRCAD,ORCOM) ;Receive the consult into the service
 ;GMRCO - The internal file number of the consult from File 123
 ;GMRCORNP - internal file number of the person receiving the request into the service
 ;GMRCAD - date/time consult received into the service
 ;ORCOM - Array containing comments related to receipt of the consult.
 ;Passed as the following form :
 ; ARRAY(1)="xxx xxx xxx",ARRAY(2)="XXX XXX",ARRAY(3)="XXX XXX xx", etc.
 ; Comment is optional when consult is received.
 S Y=$$RC^GMRCGUIA(GMRCO,GMRCORNP,GMRCAD,.ORCOM)
 Q
 ;
DC(Y,GMRCO,GMRCORNP,GMRCAD,GMRCACTM,ORCOM) ;Discontinue or Deny a consult
 ;GMRCO - Internal file number of consult from File 123
 ;GMRCORNP - Provider who Discontinued or Denied consult
 ;GMRCAD - Date/Time Consult was discontinued or denied.
 ;GMRCACTM - If consult is 'DENIED' passed in as 'DY'; if consult is Discontinued passed in as 'DC'.
 ;ORCOM - Array containing explanation of why consult was denied. Passed as the following form :
 ; ARRAY(1)="xxx xxx xxx",ARRAY(2)="XXX XXX",ARRAY(3)="XXX XXX xx", etc.
 ; Comment is a required field when consult is denied or discontinued.
 S Y=$$DC^GMRCGUIA(GMRCO,GMRCORNP,GMRCAD,GMRCACTM,.ORCOM)
 Q
 ;
FR(Y,GMRCO,GMRCSS,GMRCORNP,GMRCATTN,GMRCURGI,ORDATE,ORCOM) ;Forward consult/request to another service
 ;GMRCO - IEN of consult from File 123
 ;GMRCSS - Service to which consult is being forwarded
 ;GMRCATTN - Provider whose attention consult is sent to. Can be "" or pointer to File 200
 ;GMRCURGI - Urgency of the request
 ;GMRCORNP - Person who is responsible for forwarding the consult
 ;ORCOM is the comments array explaining the forwarding action
 ;     passed in as ORCOM(1)="Xxxx Xxxxx...",ORCOM(2)="Xxxx Xx Xxx...", ORCOM(3)="Xxxxx Xxx Xx...", etc.
 S:+$G(GMRCATTN)=0 GMRCATTN=""
 S Y=$$FR^GMRCGUIA(GMRCO,GMRCSS,GMRCORNP,GMRCATTN,GMRCURGI,.ORCOM,ORDATE)
 Q
 ;
SETACTM(Y,GMRCO) ;set action menus in GUI based on service of selected consult
 Q:+$G(GMRCO)=0
 N ORFLG
 S Y=0
 D CPRS^GMRCACTM(GMRCO,1)
 Q:'$D(ORFLG(GMRCO))
 S Y=ORFLG(GMRCO)
 Q
 ;
URG(Y,GMRCO) ;new urgency from 101.42
 Q:+$G(GMRCO)=0
 N GMRCURG,X,GMRCCSLT,GMRCPROC,GMRCTYPE,GMRCPROT
 S GMRCCSLT=$O(^ORD(101,"B","GMRCOR CONSULT",0))
 S GMRCPROC=$O(^ORD(101,"B","GMRCOR REQUEST",0))
 S GMRCTYPE=$P(^GMR(123,+GMRCO,0),"^",17)
 I $P(^GMR(123,+GMRCO,0),"^",18)["I" D
 . S X=$S(GMRCTYPE=GMRCCSLT:"S.GMRCT",1:"S.GMRCR")
 E  S X="S.GMRCO"
 S GMRCURG=""
 F I=1:1  S GMRCURG=$O(^ORD(101.42,X,GMRCURG)) Q:GMRCURG=""  D
 .S GMRCPROT=$O(^ORD(101,"B","GMRCURGENCY - "_GMRCURG,0))
 .S Y(I)=GMRCPROT_U_GMRCURG
 .;S Y(I)=$O(^ORD(101.42,X,GMRCURG,0))_U_GMRCURG
 Q
 ;
GETCSLT(ORY,ORIEN,SHOWADD)      ; Retrieve a complete consult record
 N ORDOC,ORREQ,I,X,SEQUENCE,ORI,ORGMRC,MEDRSLTS,ROOT
 S MEDRSLTS=1
 Q:+$G(ORIEN)=0
 I '$D(^GMR(123,ORIEN)) S ORY(0)="-1^Invalid consult" Q
 I $$PATCH^XPDUTL("GMRC*3.0*17") D
 . D DOCLIST^GMRCGUIB(.ORGMRC,ORIEN,MEDRSLTS)
 E  D DOCLIST^GMRCGUIB(.ORGMRC,ORIEN)
 S ORY(0)=ORGMRC(0),ORREQ=$P(ORY(0),U,14)
 S:+$G(SHOWADD) SEQUENCE="D"
 I ORREQ'="",$D(^VA(200,ORREQ,0)) S $P(ORY(0),U,14)=ORREQ_";"_$P(^VA(200,ORREQ,0),U,1)
 S X=0,I=1,ORI=1
 F  S X=$O(ORGMRC(50,X)) Q:X=""  D
 . S ORDOC=$P(ORGMRC(50,X),U,1)
 . S ROOT=U_$P($P(ORDOC,";",2),",",1)_")"
 . Q:'$D(@ROOT@(+ORDOC))
 . I ROOT="^TIU(8925)" D
 . . S ORY(I)=+ORDOC_U_$$RESOLVE^TIUSRVLO(+ORDOC)
 . . S $P(ORY(I),U,14)="1",I=I+1  ; parent treenode=1 for TIU docs
 . . S ORY("INDX",+ORDOC,ORI)=""
 . . I +$G(SHOWADD) D 
 . . . I +$$HASDAD^TIUSRVLI(+ORDOC) S ORI=I+1 D SETDAD^TIUSRVLI("ORY",+ORDOC,.ORI) S I=ORI+1 ; for treeview of related notes
 . . . I +$$HASKIDS^TIUSRVLI(+ORDOC) S ORI=I+1 D SETKIDS^TIUSRVLI("ORY",+ORDOC,.ORI) S I=ORI+1 ; for treeview of related notes
 . E  I $E(ROOT,1,5)="^MCAR" D
 . . S ORY(I)=ORGMRC(50,X)
 . . S $P(ORY(I),U,14)="2",I=I+1     ; parent treenode=2 for med results
 K ORY("INDX")
 Q
 ;
FINDCSLT(Y,GMRCIEN) ; Return list item for the selected consult only
 N ORPT,X0,GMRCOER,SEQ,SEQ0
 Q:+$G(GMRCIEN)=0
 S X0=$G(^GMR(123,GMRCIEN,0)) I 'X0 S Y="-1^Consult not found" Q
 S ORPT=$P(X0,U,2) I '$G(ORPT) S Y="-1^Patient not found" Q
 S GMRCOER=2,SEQ=""
 D OER^GMRCSLM1(ORPT,"","","","",GMRCOER)
 F  S SEQ=$O(^TMP("GMRCR",$J,"CS",SEQ)) Q:SEQ=""!(SEQ?1A.E)  I SEQ>0 D
 .S SEQ0=^TMP("GMRCR",$J,"CS",SEQ,0) I $P(SEQ0,U,1)=GMRCIEN S Y=SEQ0 Q
 K ^TMP("GMRCR",$J)
 Q
PROCIEN(ORY,ORDITM) ; Return pointer to file 123.3 given orderable item
 S ORY=+$P($G(^ORD(101.43,ORDITM,0)),U,2)
 Q
PROCSVCS(ORY,ORDITM) ; Return a list of services for a procedure
 N PROCIEN
 S PROCIEN=$P($G(^ORD(101.43,ORDITM,0)),U,2)
 D GETSVC^GMRCPR0(.ORY,PROCIEN)
 Q
 ;
GETORDER(Y,GMRCO) ; Return OERR order number for consult/procedure
 I +$G(GMRCO)=0 S Y="-1" Q
 S Y=$$ORIFN^GMRCUTL1(GMRCO)
 ;S Y=$P($G(^GMR(123,GMRCO,0)),U,3)
 Q
CANEDIT(Y,GMRCO) ; Return whether consult can be edited and resubmitted
 S Y=$$EDRESOK^GMRCEDT2(GMRCO)
 Q
RESUBMIT(Y,GMRCO,OREDITED) ; Edit/Resubmit a cancelled consult/procedure request
 N ORNODE
 S ORNODE=$NAME(^TMP("GMRCR",$J))
 M @ORNODE=OREDITED
 D FILE^GMRCGUIC(GMRCO,ORNODE)
 S Y=0
 Q
EDITLOAD(Y,GMRCO) ; Load a cancelled consult/procedure for editing
 Q:+$G(GMRCO)=0
 N ORNODE,I
 S ORNODE=$NAME(^TMP("GMRCR",$J)),I=0
 D SEND^GMRCGUIC(GMRCO,ORNODE)
 S Y=ORNODE
 Q
