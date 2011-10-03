XMRPCTS1 ;(KC-VAMC)/XXX-Simple PCTS front end to MailMan ;02/06/99  10:32
 ;;8.0;MailMan;;Jun 28, 2002
 N XMUS,XMFM,XMSTR,XMRI,XMTO,XMABORT
 ;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ;All should be sent to XXX@VHA.DMIA the local PCTS Domain
 ;Edit these for your site.
 S XMUS="XXXX" ;Local routing indicator
 S XMFM="YYYY" ;from line
 I XMUS="XXXX"!(XMFM="YYYY") S %="FIX Routing codes !!!"_XMPCTS0("ERR")
 ;-------------------------------------------------------------
 S XMABORT=0
 D INIT(.XMDUZ,XMUS,.XMSTR,.XMRI,.XMTO,.XMABORT) Q:XMABORT
 D CRE8XMZ^XMXSEND("Local PCTS Transmission.",.XMZ,1) I XMZ<1 S XMABORT=1 Q
 D EDITON^XMJMS(XMDUZ,XMZ)
 D PROCESS(XMDUZ,XMSTR,XMFM,XMRI,XMTO,.XMZ,.XMABORT)
 D EDITOFF^XMJMS(XMDUZ)
 Q:'XMABORT
 W !!,"TWIX Send aborted !",$C(7)
 H 2
 D KILLMSG^XMXUTIL(XMZ)
 Q
INIT(XMDUZ,XMUS,XMSTR,XMRI,XMTO,XMABORT) ;
 N XMSEQ
 I '$D(DUZ)#2 D  Q
 . W !!,"DUZ not defined..."
 . S XMABORT=1
 D EN^XM
 W !!,"Create PCTS/AMS message.",!
 ;Making this the pseudo-sequence number - meaningless.
 S XMSEQ=$P(^XMB(3.9,0),U,3),XMSEQ=$$RJ^XLFSTR($E(XMSEQ,$L(XMSEQ)-3,99),4,"0")
 ;Build the Header
 S XMSTR="PAAUIJAZ "_XMUS_XMSEQ_" "_$$JD^XMRPCTS0_"-UUUU--"
 D RI(.XMRI,.XMABORT) Q:XMABORT
 D TO(.XMTO,.XMABORT)
 Q
RI(XMRI,XMABORT) ;
 N DIR,DIRUT,Y,X,DTOUT,DUOUT
 S DIR(0)="FO^3:30^K X'?1UP.UP X"
 S DIR("A")="Destination RI"
 S DIR("?")="Enter the Destination Routing Indicator, like RUCHJBO."
 D ^DIR I $D(DTOUT)!$D(DUOUT) S XMABORT=1 Q
 I Y="" S Y="<RI>" W "<blank>"
 S XMRI=Y
 S:$E(XMRI,$L(XMRI))'="." XMRI=XMRI_"."
 Q
TO(XMTO,XMABORT) ;
 N DIR,DIRUT,Y,X,DTOUT,DUOUT
 S DIR(0)="F^3:60"
 S DIR("A")="Destination TO line"
 S DIR("?")="Enter the content of the TO line of the message."
 D ^DIR I $D(DTOUT)!$D(DUOUT) S XMABORT=1 Q
 S XMTO=Y
 Q
PROCESS(XMDUZ,XMSTR,XMFM,XMRI,XMTO,XMZ,XMABORT) ;
 N I,%,XMTEXT,XMINSTR,XMRESTR
 S %="ZNR UUUUU"
 F I="RUCH","RUEV","RUWL","RUGS" I XMRI[I S %="VADM"
 S I=0
 S I=I+1,XMTEXT(I)=XMSTR_XMRI ;header line
 S I=I+1,XMTEXT(I)=%
 S I=I+1,XMTEXT(I)="FM "_XMFM ;from line
 S I=I+1,XMTEXT(I)="TO "_XMTO ;to line
 S I=I+1,XMTEXT(I)="BT"
 S I=I+1,XMTEXT(I)=""
 S I=I+1,XMTEXT(I)="<text>"
 S I=I+1,XMTEXT(I)=""
 S I=I+1,XMTEXT(I)="BT"
 S I=I+1,XMTEXT(I)=""
 S I=I+1,XMTEXT(I)="NNNN"
 D MOVEBODY^XMXSEND(XMZ,"XMTEXT")
 D E Q:XMABORT
 D INIT^XMXADDR
 D READY(XMDUZ,.XMINSTR,.XMRESTR,.XMABORT) Q:XMABORT
 W !,"You may add recipients to this message."
 D TOWHOM^XMJMT(XMDUZ,"Send",.XMINSTR,.XMRESTR,.XMABORT)
 D:'XMABORT XMIT(XMDUZ,XMZ,.XMINSTR,.XMABORT)
 D CLEANUP^XMXADDR
 Q
XMIT(XMDUZ,XMZ,XMINSTR,XMABORT) ;
 N DIR,Y,X,DIRUT,XMFINISH
 S XMFINISH=0
 F  D  Q:XMFINISH!XMABORT
 . S DIR(0)="SAM^E:Edit Text;T:Transmit now"
 . S DIR("A")="Select Message option:  "
 . S DIR("B")="Transmit now"
 . S DIR("??")="^D Q^XMRPCTS1"
 . D ^DIR I $D(DIRUT) S XMABORT=1 Q
 . D @Y
 Q
E ; Edit Text
 F  D BODY^XMJMS(XMDUZ,XMZ,.XMRESTR,.XMABORT) Q:XMABORT!$$NCHECK(XMZ)
 Q
NCHECK(XMZ) ; If "NNNN" found in text, issue error
 N NCNT,I
 S (NCNT,I)=0
 F  S I=$O(^XMB(3.9,XMZ,2,I)) Q:'I  I ^XMB(3.9,XMZ,2,I,0)["NNNN" S NCNT=NCNT+1
 Q:NCNT'>1 1
 W !!,"<< 4 CONSECUTIVE N's ARE NOT ALLOWED IN THE MSG TEXT !!! >>",!!,$C(7)
 H 5
 Q 0
T ; Transmit
 S XMFINISH=1
 D BLDNSND^XMXSEND(XMDUZ,XMZ,.XMINSTR)
 Q
Q W !,"Answer: ",!
 W !,"T  (or just return) to PERMANENTLY transmit the message."
 W !,"E                   to Edit the text of the message."
 W !,"'^'  to cancel the message."
 Q
READY(XMDUZ,XMINSTR,XMRESTR,XMABORT) ;
 N DIR,DIRUT,Y
 S DIR(0)="Y"
 S DIR("A")="Ready to send to the Austin AMS System"
 S DIR("?",1)="'YES' will place the message in the queue for transmission through the AMS System."
 S DIR("?")="'NO' will place the message only in your IN basket."
 D ^DIR I $D(DIRUT) S XMABORT=1 Q
 Q:'Y
 W !,"Send to:  XXX@VHA.DMIA"
 D ADDR^XMXADDR(XMDUZ,"XXX@VHA.DMIA",.XMINSTR,.XMRESTR)
 Q
EXIT ;
 K I,XMTO,XMFM,XMSTR,XMUS,XMTM,XMRI,DIC,XCNP,XMXUSEC,ZTPAR,XMSEQ,XMOUT,DTOUT
 K ^TMP("XMY",$J),^TMP("XMY0",$J)
 Q
