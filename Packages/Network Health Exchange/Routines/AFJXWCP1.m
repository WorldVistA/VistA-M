AFJXWCP1 ;FO-OAKLAND/GMB-REQUEST PATIENT INFORMATION ;4/11/96  05:36
 ;;5.1;Network Health Exchange;**1,31,34**;Jan 23, 1996
 ; Totally rewritten 11/2001.  (Previously FJ/CWS.)
 ; Called from ^AFJXWCPM
REQUEST(AXTYPE) ; Request data
 N AXFINIS,AXABORT,AXPARM,AXSSN,I
 S (AXFINIS,AXABORT)=0
 D INIT(AXTYPE,.AXPARM,.AXABORT) Q:AXABORT
 W @IOF,!! F I=1:1:80 W "@"
 W !,?8,"This option will request ",AXPARM("U")," DATA from another VAMC."
 W ! F I=1:1:80 W "@"
 W !!,?5,"You can't request information if the patient is not already on file.",!
 F  D  Q:AXFINIS!AXABORT
 . N DIC,X,Y,AXTO
 . W !!
 . S DIC("A")="SOCIAL SECURITY # or NAME: "
 . S DIC="^DPT("
 . S DIC(0)="AEMOQZ"
 . D ^DIC I Y<1 S AXFINIS=1 Q
 . S AXSSN=$P(Y(0),U,9)
 . I $G(AXSSN)["P" W !,?5,$C(7),"SORRY, You can't request Pseudo SSNs." Q
 . D SITES(.AXTO,.AXABORT) Q:AXABORT
 . I '$D(AXTO) D  Q
 . . W !,$C(7),"No valid sites chosen.  No request sent."
 . D MESSAGE(.AXTO,AXSSN)
 Q
INIT(AXTYPE,AXPARM,AXABORT) ;
 I AXTYPE="R" S AXPARM("U")="PATIENT PHARMACY",AXPARM("S")="PHARMACY DATA",AXPARM("L")="PHARM"
 E  I AXTYPE="RB" S AXPARM("U")="BRIEF PHARMACY",AXPARM("S")="BRIEF PHARMACY",AXPARM("L")="NHBP"
 E  I AXTYPE="P" S AXPARM("U")="PATIENT",AXPARM("S")="TOTAL DATA",AXPARM("L")="TOTAL"
 E  I AXTYPE="PB" S AXPARM("U")="BRIEF PATIENT",AXPARM("S")="BRIEF DATA",AXPARM("L")="BRIEF"
 E  D  Q
 . W !,"Routine ^AFJXWCP1 called with incorrect TYPE parameter: ",AXTYPE
 . S AXABORT=1
 N DIR,X,Y
 W !
 S DIR(0)="Y"
 S DIR("A")="Would you like to look for any previous requests on file"
 S DIR("B")="NO"
 D ^DIR I $D(DTOUT)!$D(DUOUT) S AXABORT=1 Q
 D:Y ENTER^AFJXMBOX
 Q
SITES(AXTO,AXABORT) ; Choose station(s)
 N AXFINIS,AXDOMIEN,AX25IEN,DIR,X,Y,DIRUT
 S DIR(0)="S^A:ALL Local Area Sites;S:Selected Sites"
 S DIR("A")="Request patient information from"
 D ^DIR I $D(DIRUT) S AXABORT=1 Q
 I Y="A" D CHKALL(.AXTO) Q
 K DIR,X,Y
 S AXFINIS=0
 F  D  Q:AXFINIS!AXABORT
 . N DIC,X,Y,DUOUT,DTOUT
 . W !
 . S DIC=537025,DIC(0)="AEMOQ"
 . S DIC("A")=$S($D(AXTO):"Another site: ",1:"Select a site: ")
 . S DIC("S")="I $P($G(^DIC(4.2,+^(0),0)),U,2)'[""C"""
 . D ^DIC I $D(DUOUT)!$D(DTOUT) S AXABORT=1 Q
 . I Y<1 S AXFINIS=1 Q
 . S AXDOMIEN=$P(Y,U,2),AX25IEN=+Y
 . D CHKSITE(AXDOMIEN,AX25IEN,.AXTO)
 Q
CHKALL(AXTO) ; "ALL LOCAL AREA SITES"
 N AX25IEN,AX25REC
 W !,"Network Area Recipients:"
 S AX25IEN=0
 F  S AX25IEN=$O(^AFJ(537025,AX25IEN)) Q:'AX25IEN  D
 . S AX25REC=$G(^AFJ(537025,AX25IEN,0))
 . I $P(AX25REC,U,3) D CHKSITE($P(AX25REC,U),AX25IEN,.AXTO)
 Q
CHKSITE(AXDOMIEN,AX25IEN,AXTO) ;
 N AXBAD,AXDOMREC
 S AXBAD=0
 I AXDOMIEN=^XMB("NUM") D
 . ;S AXBAD=1
 . S AXTO("S.AFJXSERVER")=""
 . W !,^XMB("NETNAME"),"   FYI: That's this domain."
 . S AXTO("S.AFJXSERVER")=""
 E  D
 . S AXDOMREC=$P(^DIC(4.2,AXDOMIEN,0),U,1,2)
 . I AXDOMREC="" D  Q
 . . S AXBAD=1
 . . ;W !!,$C(7),"Broken pointer to the DOMAIN file."
 . I $P(AXDOMREC,U,2)'["C" D  Q
 . . S AXTO("S.AFJXSERVER@"_$P(AXDOMREC,U,1))=""
 . . W !,$P(AXDOMREC,U,1)
 . S AXBAD=1
 . ;W !!,$C(7),"Domain ",DOMNAME," is closed."
 Q:'AXBAD
 ;W !,"   Ignoring it."
 Q
 ;W !,"   Deleting it from the Authorized Sites file."
 ;N DIK,DA S DIK="^AFJ(537025,",DA=AX25IEN D ^DIK
 ;Q
MESSAGE(XMY,AXSSN) ; Build message and transmit
 N XMSUB,XMDUZ,XMTEXT,XMZ,AXRQST,AXREC,DIC,DLAYGO,X,Y,DA,DINUM,DD,DO
 W !!,"Sending Patient Data Request..."
 S XMDUZ=DUZ,XMTEXT="AXRQST("
 S XMSUB="NETWORK HEALTH EXCHANGE "_AXPARM("S")_" REQUEST FOR "_AXSSN
 S AXRQST(1)=AXSSN_U_DUZ_U_$P($G(^VA(200,+DUZ,0)),U)_U_$$NOW^XLFDT_U_^XMB("NETNAME")_U_AXPARM("L")
 D ^XMD W !,"Local Message ID: "_XMZ
 ; Audit
 S AXREC=AXRQST(1)
 S DIC="^AFJ(537000,",DLAYGO=537000
 S DIC(0)="L",X=XMZ
 S DIC("DR")="1////"_$P(AXREC,U,4)_";2////"_AXPARM("L")_";3////"_AXSSN_";6////"_DUZ_";7////"_$P(AXREC,U,3)_";8////"_^XMB("NUM")_";11////Y"
 D FILE^DICN
 W !!,"Your request has been submitted for completion."
 Q
