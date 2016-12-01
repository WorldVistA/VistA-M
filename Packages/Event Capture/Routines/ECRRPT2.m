ECRRPT2 ;ALB/DAN - Event Capture Report RPC Broker (Cont) ;2/12/16  09:41
 ;;2.0;EVENT CAPTURE;**112,131**;8 May 96;Build 13
 ;
ECRDSSUA ;List users with access to DSS Units
 ;     Variables passed in
 ;       ECD0...n    - DSS Unit to report (1, some or ALL)
 ;       ECDUZ       - User IEN from file (#200)
 ;       ECPTYP      - Where to send output (P)rinter, (D)evice or screen, (E)xport
 ;                     data will be returned in ^TMP($J,"ECRPT") in
 ;                     delimited format for export to spreadsheet
 ;
 ;     Variable return
 ;       ^TMP($J,"ECRPT",n)=report output or to print device.
 N ECDSSU,ECV,ECI,ECKEY,ECROU,ECSAVE,ECDESC,ECX,DIC,X,Y
 S ECV="ECD0^ECDUZ^ECPTYP" D REQCHK^ECRRPT(ECV) I ECERR Q
 D  I '$D(ECDSSU) S ^TMP("ECMSG",$J)="1^Invalid DSS Unit." Q
 . I ECD0="ALL" D  Q
 . . S ECKEY=$S($D(^XUSEC("ECALLU",ECDUZ)):1,1:0) D ALLU
 . S ECI=0 F ECI=0:1 S ECX="ECD"_ECI Q:'$D(@ECX)  D
 . . K DIC S DIC=724,DIC(0)="QNZX",X=@ECX D ^DIC I Y<0 Q
 . . S ECDSSU(+Y)=$P(Y,U,2)
 I ECPTYP="P" D  Q
 . S ECROU="STRPT^ECRDSSUA"
 . S ECSAVE("ECDSSU(")=""
 . S ECDESC="Users with access to DSS Units"
 . D QUEUE^ECRRPT
 D STRPT^ECRDSSUA
 Q
ALLU ;-- Get all DSS Units and create ECDSSU array
 N ECD,ECN,ECX,Y
 S ECD="",ECN=0
 F  S ECD=$O(^ECD("B",ECD)) Q:ECD=""  F  S ECN=$O(^ECD("B",ECD,ECN)) Q:'ECN  D
 . Q:'$$VALID(ECN)!('ECKEY&('$D(^VA(200,ECDUZ,"EC",+ECN))))
 . S ECDSSU(ECN)=ECD
ALLUQ Q
 ;
VALID(IEN) ;-- Check DSS Unit for use by Event Capture
 N NODE
 S NODE=$G(^ECD(IEN,0))
 Q $S($P(NODE,"^",8):1,1:0)
 ;
ECRUDSS ;List all DSS units user has access to
 ;     Variables passed in
 ;       ECDUZ       - User IEN from file (#200)
 ;       ECPTYP      - Where to send output (P)rinter, (D)evice or screen, (E)xport
 ;                     data will be returned in ^TMP($J,"ECRPT") in
 ;                     delimited format for export to spreadsheet
 ;
 ;     Variable return
 ;       ^TMP($J,"ECRPT",n)=report output or to print device.
 N ECV,ECROU,ECSAVE,ECDESC
 S ECV="ECDUZ^ECPTYP" D REQCHK^ECRRPT(ECV) I ECERR Q
 I ECPTYP="P" D  Q
 . S ECROU="STRPT^ECRUDSS"
 . S ECSAVE("ECDUZ")=""
 . S ECDESC="DSS unit access for a selected user"
 . D QUEUE^ECRRPT
 D STRPT^ECRUDSS
 Q
 ;
ECRDSSEC ;List event code screens for selected DSS unit
 ;     Variables passed in
 ;       ECD       - DSS Unit IEN
 ;       STAT      - Event code screen, (A)ctive, (I)nactive,(B)oth
 ;       ECPTYP    - Where to send output (P)rinter, (D)evice or screen, (E)xport
 ;
 ;     Variable return
 ;       ^TMP($J,"ECRPT",n)=delimited data
 ;
 ;
 N ECV,ECROU,ECSAVE,ECDESC
 S ECV="ECD^STAT^ECPTYP" D REQCHK^ECRRPT(ECV) I ECERR Q
 I ECPTYP="P" D  Q
 . S ECROU="STRPT^ECRDSSEC"
 . S ECSAVE("ECD")="",ECSAVE("STAT")="",ECSAVE("ECPTYP")=""
 . S ECDESC="Event code screens for selected DSS Unit"
 . D QUEUE^ECRRPT
 D STRPT^ECRDSSEC
 Q
 ;
ECRECER ;Event Capture Encounter Report
 ;     Variables passed in
 ;       ECD0...n    - DSS Unit to report (1, some or ALL)
 ;       ECDUZ       - User IEN from file (#200)
 ;       ECL0        - Location IEN (1 or ALL)
 ;       ECSORT      - Sort ordered by (P)atient or (D)octor (provider)
 ;       ECSD        - Start date range
 ;       ECED        - End date range
 ;       ECPTYP      - Where to send output (P)rinter, (D)evice (screen), (E)xport
 ;
 ;     Variable return
 ;       ^TMP($J,"ECRPT",n)=returned if exported
 N ECDSSU,ECV,ECI,ECKEY,ECROU,ECSAVE,ECDESC,ECX,DIC,X,Y,ECLOC,ECLOC1
 S ECV="ECD0^ECDUZ^ECL0^ECSORT^ECSD^ECED^ECPTYP" D REQCHK^ECRRPT(ECV) I ECERR Q
 D DATECHK^ECRRPT(.ECSD,.ECED)
 D  I '$D(ECDSSU) S ^TMP("ECMSG",$J)="1^Invalid DSS Unit." Q
 . I ECD0="ALL" D  Q
 . . S ECKEY=$S($D(^XUSEC("ECALLU",ECDUZ)):1,1:0) D ALLU
 . S ECI=0 F ECI=0:1 S ECX="ECD"_ECI Q:'$D(@ECX)  D
 . . K DIC S DIC=724,DIC(0)="QNZX",X=@ECX D ^DIC I Y<0 Q
 . . S ECDSSU(+Y)=$P(Y,U,2)
 D  I '$D(ECLOC) S ^TMP("ECMSG",$J)="1^Invalid Location." Q
 . I ECL0="ALL" D LOCARRY^ECRUTL Q
 . S DIC=4,DIC(0)="QNZX",X=ECL0 D ^DIC Q:Y<0  S ECLOC(1)=+Y_U_$P(Y,U,2),ECLOC1(+Y)=$P(Y,U,2)
 I ECPTYP="P" D  Q
 . S ECROU="STRPT^ECRECER"
 . S ECSAVE("ECDSSU(")="",ECSAVE("ECLOC(")="",ECSAVE("ECLOC1(")=""
 . S ECDESC="Event Capture Encounter Report"
 . D QUEUE^ECRRPT
 D STRPT^ECRECER
 Q
 ;
ECRECSIC ;Event Capture Report, Event Capture Screen, Inactive Clinics
 ;     Variables passed in
 ;       ECD0...n    - DSS Unit to report (1, some or ALL)
 ;       ECL0...n    - Location IEN (1,some or ALL)
 ;       ECDUZ       - User IEN from file (#200)
 ;       ECPTYP      - Where to send output (P)rinter, (D)evice (screen), (E)xport
 ;
 ;     Variable return
 ;       ^TMP($J,"ECRPT",n)=returned if exported
 N ECDSSU,ECV,ECI,ECKEY,ECROU,ECSAVE,ECDESC,ECX,DIC,X,Y,ECLOC,ECLOC1
 S ECV="ECD0^ECL0^ECDUZ^ECPTYP" D REQCHK^ECRRPT(ECV) I ECERR Q
 D  I '$D(ECDSSU) S ^TMP("ECMSG",$J)="1^Invalid DSS Unit." Q
 . I ECD0="ALL" D  Q
 . . S ECKEY=$S($D(^XUSEC("ECALLU",ECDUZ)):1,1:0) D ALLU
 . S ECI=0 F ECI=0:1 S ECX="ECD"_ECI Q:'$D(@ECX)  D
 . . K DIC S DIC=724,DIC(0)="QNZX",X=@ECX D ^DIC I Y<0 Q
 . . S ECDSSU(+Y)=$P(Y,U,2)
 D  I '$D(ECLOC) S ^TMP("ECMSG",$J)="1^Invalid Location." Q
 . I ECL0="ALL" D LOCARRY^ECRUTL Q
 . S ECI=0 F ECI=0:1 S ECX="ECL"_ECI Q:'$D(@ECX)  D
 . . S DIC=4,DIC(0)="QNZX",X=@ECX D ^DIC Q:Y<0  S ECLOC(1)=+Y_U_$P(Y,U,2),ECLOC1(+Y)=$P(Y,U,2)
 I ECPTYP="P" D  Q
 . S ECROU="STRPT^ECRECSIC"
 . S ECSAVE("ECDSSU(")=""
 . S ECSAVE("ECLOC(")="",ECSAVE("ECLOC1(")=""
 . S ECDESC="Event Capture Event Code Screens with Inactive Clinics"
 . D QUEUE^ECRRPT
 D STRPT^ECRECSIC
 Q
 ;
ECRECSPC ;Event code screens by procedure code
 ;     Variables passed in
 ;       ECLPC0...n  - Procedure Code (1, some or ALL)
 ;       ECL0...n    - Location IEN (1,some or ALL)
 ;       ECDUZ       - User IEN from file (#200)
 ;       ECPTYP      - Where to send output (P)rinter, (D)evice (screen), (E)xport
 ;
 ;     Variable return
 ;       ^TMP($J,"ECRPT",n)=returned if exported
 N ECV,ECI,ECKEY,ECROU,ECSAVE,ECDESC,ECX,DIC,X,Y,ECPROC,ECLOC,ECLOC1
 S ECV="ECLPC0^ECL0^ECDUZ^ECPTYP" D REQCHK^ECRRPT(ECV) I ECERR Q
 D  I '$D(ECPROC)&(ECLPC0'="ALL") S ^TMP("ECMSG",$J)="1^Invalid Procedure Code." Q
 . I ECLPC0="ALL" Q
 . S ECI=0 F ECI=0:1 S ECX="ECLPC"_ECI Q:'$D(@ECX)  D
 . . S ECPROC(@ECX)=""
 D  I '$D(ECLOC) S ^TMP("ECMSG",$J)="1^Invalid Location." Q
 . I ECL0="ALL" D LOCARRY^ECRUTL Q
 . S ECI=0 F ECI=0:1 S ECX="ECL"_ECI Q:'$D(@ECX)  D
 . . S DIC=4,DIC(0)="QNZX",X=@ECX D ^DIC Q:Y<0  S ECLOC(1)=+Y_U_$P(Y,U,2),ECLOC1(+Y)=$P(Y,U,2)
 I ECPTYP="P" D  Q
 . S ECROU="STRPT^ECRECSPC"
 . S ECSAVE("ECPROC(")=""
 . S ECSAVE("ECLOC(")="",ECSAVE("ECLOC1(")=""
 . S ECDESC="Event Capture Event Code Screens by procedure code"
 . D QUEUE^ECRRPT
 D STRPT^ECRECSPC
 Q
ECRGP ;generic print capability
 ;  Variables passed in
 ;  ECLIN0...n  - Lines of data to be printed out
 ;
 ;  Variables returned - none
 ;
 N ECROU,ECSAVE,ECDESC,ECX,I,ECV
 S ECV="ECLIN0" D REQCHK^ECRRPT(ECV) I ECERR Q
 S ECROU="PRINT^ECRRPT2"
 S ECDESC="Generic Print of Event Capture Report"
 F I=0:1 S ECX="ECLIN"_I Q:'$D(@ECX)  S ECSAVE(ECX)=""
 D QUEUE^ECRRPT
 Q
 ;
PRINT ;Send data to printer
 N I,ECX
 U IO
 W @IOF
 F I=0:1 S ECX="ECLIN"_I Q:'$D(@ECX)  W !,@ECX I $Y>(IOSL-4) W @IOF
 Q
 ;
ECDSSSNR ;131 DSS units set to send no records to PCE
 ;     Variables passed in
 ;       ECPTYP      - Where to send output (P)rinter, (D)evice or screen, (E)xport
 ;                     data will be returned in ^TMP($J,"ECRPT") in
 ;                     delimited format for export to spreadsheet
 ;
 ;     Variable return
 ;       ^TMP($J,"ECRPT",n)=report output or to print device.
 N ECV,ECROU,ECDESC
 S ECV="ECPTYP" D REQCHK^ECRRPT(ECV) I ECERR Q
 I ECPTYP="P" D  Q
 . S ECROU="START^ECDSSSNR"
 . S ECDESC="DSS Units set to send no records to PCE"
 . D QUEUE^ECRRPT
 D START^ECDSSSNR
 Q
 ;
ECDISSUM ;131 Disabled Category and Procedure Summary Report
 ;     Variables passed in
 ;       ECL0..n  - Location to report (1,some or ALL)
 ;       ECPTYP   - Where to send output (P)rinter, (D)evice or screen
 ;                  or (E)xport
 ;
 ;     Variable return
 ;       ^TMP($J,"ECRPT",n)=report output or to print device.
 N ECV,ECLOC,I,LIEN,ECSAVE,ECDESC,ECROU
 S ECV="ECL0^ECPTYP" D REQCHK^ECRRPT(ECV) I ECERR Q
 D  I '$D(ECLOC) S ^TMP("ECMSG",$J)="1^Invalid Location." Q
 . D LOCARRY^ECRUTL I ECL0="ALL" Q
 . K ECLOC F I=0:1 S LIEN=$G(@("ECL"_I)) Q:'+LIEN  I $D(ECLOC1(LIEN)) S ECLOC(I+1)=LIEN_"^"_ECLOC1(LIEN)
 I ECPTYP="P" D  Q
 . S ECV="ECL0^ECPTYP",ECROU="EN^ECDISSUM"
 . S ECSAVE("ECLOC(")=""
 . S ECDESC="EC Disabled Category Report"
 . D QUEUE^ECRRPT
 D EN^ECDISSUM
 Q
