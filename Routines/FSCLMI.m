FSCLMI ;SLC/STAFF-NOIS List Manager - Installs ;1/13/98  12:34
 ;;1.1;NOIS;;Sep 06, 1998
 ;
ENTRY ; from list template - entry code, FSCSTUR
 N DAY,LINE,NUM,NUM0,NUM1,SEQ
 K ^TMP("FSC INSTALLS",$J)
 I '$G(FSCDEV) W !
 S VALMCNT=0,VALMCAP="",$P(VALMCAP," ",80)=""
 I '$D(FSCSTU) Q
 ;S VALMCNT=VALMCNT+1,^TMP("FSC INSTALLS",$J,VALMCNT,0)="Description:"
 S DATE=$G(DATE,DT)
 D
 .I FSCSTU="ALERT" D  Q
 ..N DA,DIK S DIK="^FSCD(""STU ALERT"","
 ..S NUM="" F  S NUM=$O(^FSCD("STU ALERT","B",DUZ,NUM),-1) Q:NUM=""  S NUM0=+$P($G(^FSCD("STU ALERT",NUM,0)),U,2) I NUM0 D
 ...S NUM1=0 F  S NUM1=$O(^FSCD("STU MSG",NUM0,1,NUM1)) Q:NUM1<1  S LINE=$G(^(NUM1,0)) D
 ....S VALMCNT=VALMCNT+1,^TMP("FSC INSTALLS",$J,VALMCNT,0)=LINE
 ...S DA=+NUM D ^DIK
 .I FSCSTU="ALL" D  Q
 ..S DAY="" F  S DAY=$O(^FSCD("STU MSG","B",DAY),-1) Q:DAY=""  Q:DAY<DATE  D
 ...S NUM="" F  S NUM=$O(^FSCD("STU MSG","B",DAY,NUM),-1) Q:NUM=""  D
 ....S NUM1=0 F  S NUM1=$O(^FSCD("STU MSG",NUM,1,NUM1)) Q:NUM1<1  S LINE=$G(^(NUM1,0)) D
 .....S VALMCNT=VALMCNT+1,^TMP("FSC INSTALLS",$J,VALMCNT,0)=LINE
 .I FSCSTU="PACKAGE" D  Q
 ..I '$G(PACKAGE) Q
 ..S DAY="" F  S DAY=$O(^FSCD("STU MSG","APD",PACKAGE,DAY),-1) Q:DAY=""  Q:DAY<DATE  D
 ...S NUM="" F  S NUM=$O(^FSCD("STU MSG","APD",PACKAGE,DAY,NUM),-1) Q:NUM=""  D
 ....S NUM1=0 F  S NUM1=$O(^FSCD("STU MSG",NUM,1,NUM1)) Q:NUM1<1  S LINE=$G(^(NUM1,0)) D
 .....S VALMCNT=VALMCNT+1,^TMP("FSC INSTALLS",$J,VALMCNT,0)=LINE
 .I FSCSTU="SITE" D  Q
 ..I '$G(SITE) Q
 ..S DAY="" F  S DAY=$O(^FSCD("STU MSG","ASD",SITE,DAY),-1) Q:DAY=""  Q:DAY<DATE  D
 ...S NUM="" F  S NUM=$O(^FSCD("STU MSG","ASD",SITE,DAY,NUM),-1) Q:NUM=""  D
 ....S NUM1=0 F  S NUM1=$O(^FSCD("STU MSG",NUM,1,NUM1)) Q:NUM1<1  S LINE=$G(^(NUM1,0)) D
 .....S VALMCNT=VALMCNT+1,^TMP("FSC INSTALLS",$J,VALMCNT,0)=LINE
 S ^TMP("FSC INSTALLS",$J)=VALMCNT_U_VALMCNT
 I 'VALMCNT S VALMCNT=2,^TMP("FSC INSTALLS",$J,1,0)=" ",^TMP("FSC INSTALLS",$J,2,0)="     No messages on list."
 Q
 ;
HDRPATCH ; from FSCSTUR
 N HDR S FSCSTU=$G(FSCSTU),DATE=$G(DATE,DT)
 S HDR="Site Tracking"
 I FSCSTU="PATCH SITE" S HDR=HDR_" - Patch "_$P($G(^A1AE(11005,+$G(PATCH),0)),U)_" installed at these sites"
 I FSCSTU="PATCH SITENOT" S HDR=HDR_" - Patch "_$P($G(^A1AE(11005,+$G(PATCH),0)),U)_" is NOT installed at these sites"
 I FSCSTU="PATCH ALL" S HDR=HDR_" - "_$P($G(^FSC("SITE",+$G(SITE),0)),U)_" patch installs backto "_$$FMTE^XLFDT(DATE)
 I FSCSTU="PATCH ALLNOT" S HDR=HDR_" - "_$P($G(^FSC("SITE",+$G(SITE),0)),U)_" patches NOT installed"
 I FSCSTU="PATCH PACK" S HDR=HDR_" - "_$P($G(^FSC("SITE",+$G(SITE),0)),U)_" patches for "_$P($G(^FSC("MOD",+$G(MODULE),0)),U)
 I FSCSTU="PATCH PACKNOT" S HDR=HDR_" - "_$P($G(^FSC("SITE",+$G(SITE),0)),U)_" patches NOT installed for "_$P($G(^FSC("MOD",+$G(MODULE),0)),U)
 S VALMHDR(1)=HDR
 Q
 ;
HEADER ; from list template - header code, FSCSTUR
 N HDR S FSCSTU=$G(FSCSTU),DATE=$G(DATE,DT)
 S HDR="Site Tracking Update Messages"
 I FSCSTU="ALERT" S HDR=HDR_" - Install Alerts"
 I FSCSTU="ALL" S HDR=HDR_" - All installs backto "_$$FMTE^XLFDT(DATE)
 I FSCSTU="PACKAGE" S HDR=HDR_" - "_$P($G(^FSC("PACK",+$G(PACKAGE),0)),U)_" installs backto "_$$FMTE^XLFDT(DATE)
 I FSCSTU="SITE" S HDR=HDR_" - "_$P($G(^FSC("SITE",+$G(SITE),0)),U)_" installs backto "_$$FMTE^XLFDT(DATE)
 S VALMHDR(1)=HDR
 Q
 ;
EXIT ; from list template - exit code
 I $G(FSC1) D CLEAR^VALM1
 K ^TMP("FSC INSTALLS",$J)
 Q
 ;
HELP ; from list template - help code
 I $G(X)'["?" Q
 S VALMBCK="R"
 N XQH
 I X="?" S XQH="FSC MENU MODIFY" D EN^XQH Q
 I X="???" S VALMANS="?" D CLEAR^VALM1 S XQH="FSC U1 NOIS" D EN^XQH Q
 Q
