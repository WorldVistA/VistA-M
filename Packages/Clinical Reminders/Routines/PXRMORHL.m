PXRMORHL ; SLC/AGP - Reminder Order Checks HL7 updates;10/20/2009
 ;;2.0;CLINICAL REMINDERS;**16**;Feb 04, 2005;Build 119
 ;
 Q
ADDMSG(OI,ACT,NL) ;
 N ACTION,GIEN,OINAME
 I '$D(^PXD(801,"O",OI)),ACT'=1 Q
 S OINAME=$P($G(^ORD(101.43,OI,0)),U)
 S ACTION=$S(ACT=1:"added",ACT=2:"inactivated",ACT=3:"changed",ACT=4:"reactivated",1:"unknown")
 ;only build message for new OI and OI contains within a group
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=""
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=OINAME_" was "_ACTION
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="  it is used in the following Orderable Item Groups"
 ;build OI message for each OI
 ;add specific OI group to the message
 I '$D(^PXD(801,"O",OI)) D  Q
 .S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="   None" Q
 S GIEN=0 F  S GIEN=$O(^PXD(801,"O",OI,GIEN)) Q:GIEN'>0  D
 .S NL=NL+1
 .S ^TMP("PXRMXMZ",$J,NL,0)="   "_$P($G(^PXD(801,GIEN,0)),U)
 Q
 ;
EN ;
 N ACT,CHANGED,NL,NODE,OIIEN,SUB,SUB1
 K ^TMP("PXRMXMZ",$J)
 S NL=0
 ;check for new OI first
 I $D(^TMP($J,"NEW")) D
 .S OIIEN=0 F  S OIIEN=$O(^TMP($J,"NEW",OIIEN)) Q:OIIEN'>0  D ADDMSG(OIIEN,1,.NL)
 ;
 S OIIEN=0 F  S OIIEN=$O(^TMP($J,"BEFORE",OIIEN)) Q:OIIEN'>0  D
 .I '$D(^TMP($J,"AFTER",OIIEN)) Q
 .S CHANGED=0,SUB=""
 .;loop through each OI using the Before Global
 .F  S SUB=$O(^TMP($J,"BEFORE",OIIEN,SUB)) Q:SUB=""!(CHANGED>0)  D
 ..;do checks on multiples node
 ..I SUB=2!(SUB=8)!(SUB=9)!(SUB=10) D  Q
 ...;
 ...;check the zero node first
 ...S NODE=^TMP($J,"BEFORE",OIIEN,SUB,0)
 ...I NODE'=$G(^TMP($J,"AFTER",OIIEN,SUB,0)) S CHANGED=3 Q
 ...;
 ...;check word processing field
 ...I SUB=8 D  Q
 ....S SUB1=0
 ....F  S SUB1=$O(^TMP($J,"BEFORE",OIIEN,SUB,SUB1)) Q:SUB1'>0!(CHANGED>0)  D
 .....S NODE=^TMP($J,"AFTER",OIIEN,8,SUB1,0)
 .....I NODE'=$G(^TMP($J,"AFTER",OIIEN,8,SUB1,0)) S CHANGED=3 Q
 ...;
 ...;for other nodes check the "B" xref
 ...S SUB1=""
 ...F  S SUB1=$O(^TMP($J,"BEFORE",OIIEN,SUB,"B",SUB1)) Q:SUB1=""!(CHANGED>0)  D
 ....I '$D(^TMP($J,"AFTER",OIIEN,SUB,"B",SUB1)) S CHANGED=3
 ..;
 ..;check non-multiple
 ..S NODE=^TMP($J,"BEFORE",OIIEN,SUB)
 ..I NODE'=^TMP($J,"AFTER",OIIEN,SUB) D
 ...I SUB=.1 D  Q
 ....I NODE="" S CHANGED=2 Q
 ....S CHANGED=4
 ...S CHANGED=3
 .;
 .I CHANGED>0 D ADDMSG(OIIEN,CHANGED,.NL)
 I $D(^TMP("PXRMXMZ",$J)) D SEND^PXRMMSG("PXRMXMZ","Orderable Item Updates")
 K ^TMP("PXRMXMZ",$J),^TMP($J,"BEFORE"),^TMP($J,"AFTER"),^TMP($J,"NEW")
 Q
 ;
OIUPDATE(MSG) ;
 K ^TMP($J,"AFTER"),^TMP($J,"BEFORE"),^TMP($J,"NEW")
 M ^TMP($J,"AFTER")=^TMP($J,"OR OI AFTER")
 M ^TMP($J,"BEFORE")=^TMP($J,"OR OI BEFORE")
 I $D(^TMP($J,"OR OI NEW")) M ^TMP($J,"NEW")=^TMP($J,"OR OI NEW")
 D EN
 Q
 ;
