PXRMAPI ;SLC/PKR - Clinical Reminders APIs;03/06/2015  07:38
 ;;2.0;CLINICAL REMINDERS;**45**;Feb 04, 2005;Build 566
 ;========================================================
ITEMLIST(RIEN,GNAME,LIST,SUB) ;Return a list of items for an order
 ;check group.
 ;Controlled by ICR #6029
 ;INPUT: RIEN - Rule IEN (file #801.1) (optional)
 ;       GNAME - GROUP NAME (.01 field in file #801) (optional)
 ;       LIST - type of list to return; either P, O, I or A
 ;              P: Pharmacy item list
 ;              O: Orderable item list
 ;              I: Imaging Type
 ;              A: All entries
 ;       SUB - Name of the subscript underwhich to return data in ^TMP($J,
 ;             (optional; defaults to "PXRMLIST")
 ;OUTPUT: Data is returned descendant from ^TMP($J,SUB)
 ;        Error messages are returned in ^TMP($J,SUB,"ERROR")
 N FIELD,INDEX,ITEM,TYPE,ENTRY
 I $G(SUB)="" S SUB="PXRMLIST"
 K ^TMP($J,SUB)
 ;ICR #10104
 S GNAME=$$UP^XLFSTR($G(GNAME)),LIST=$$UP^XLFSTR($G(LIST))
 I $G(RIEN)="",$G(GNAME)="" D  Q
 .S ^TMP($J,SUB,"ERROR")="You must specify either a rule IEN or a group name."
 I $G(RIEN)'="",$G(GNAME)'="" D  Q
 .S ^TMP($J,SUB,"ERROR")="You cannot request both a rule and a group name at the same time."
 I $G(GNAME)="",$G(RIEN)'?1.N!('$D(^PXD(801.1,$G(RIEN,0)))) D  Q
 .S ^TMP($J,SUB,"ERROR")="Invalid rule requested: "_$G(RIEN)
 I $G(RIEN)="",'$D(^PXD(801,"B",GNAME)) D  Q
 .S ^TMP($J,SUB,"ERROR")="Invalid group name requested: "_GNAME
 I $L(LIST)'=1!("POIA"'[LIST) D  Q
 .S ^TMP($J,SUB,"ERROR")="Invalid list requested: "_LIST_"; specify either P, O, I or A"
 I $G(RIEN) D  Q:$D(^TMP($J,SUB,"ERROR"))
 .N IEN2
 .S IEN2=0 F  S IEN2=$O(^PXD(801,"R",RIEN,IEN2)) Q:'IEN2  D
 ..S ENTRY(IEN2)=$P($G(^PXD(801,IEN2,0)),U)
 .I $D(ENTRY)'=10 S ^TMP($J,SUB,"ERROR")="Invalid rule requested: "_RIEN
 I GNAME'="" D  Q:$D(^TMP($J,SUB,"ERROR"))
 .S ENTRY($O(^PXD(801,"B",GNAME,0)))=GNAME
 .I $D(ENTRY(0)) S ^TMP($J,SUB,"ERROR")="Invalid name requested: "_GNAME
 S INDEX=0 F  S INDEX=$O(ENTRY(INDEX)) Q:'INDEX  D
 .S INDEX(3)=0  F  S INDEX(3)=$O(^PXD(801,INDEX,1.5,"B",INDEX(3))) Q:'INDEX(3)  D
 ..S TYPE=$$GETTYPE(INDEX(3)) I TYPE="" Q
 ..S ^TMP($J,SUB,ENTRY(INDEX),TYPE,INDEX(3))=""
 Q
 ;
GETTYPE(TYPE) ;
 Q $S(TYPE["PSDRUG":"P",TYPE["PSNDF(50.6":"P",TYPE["PS(50.605":"P",TYPE["RA(79.2":"I",TYPE["ORD(101.43":"O",1:"")
 ;========================================================
PUSAGE(IEN) ;Return true if the reminder definition contains a "P"
 ;in the Usage field. This means it is ok for a patient to use the
 ;reminder. IEN is the internal entry number.
 N OK,USAGE
 S USAGE=$P($G(^PXD(811.9,IEN,100)),U,4)
 S OK=$S(USAGE["P":1,1:0)
 Q OK
 ;
 ;========================================================
USAGE(IEN) ;Return the Usage for a reminder definition. IEN is the
 ;internal entry number.
 Q $P($G(^PXD(811.9,IEN,100)),U,4)
 ;
