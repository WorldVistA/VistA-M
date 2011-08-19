XDRRMRG0 ;SF-IRMFO/REM - DUP VERIFICATION FOR ANCILLARY SERVICES ;08/09/2000  10:47
 ;;7.3;TOOLKIT;**23,47**;Apr 25, 1995
 ;;
EN ;
 N XDRNAME,XDRY,XQADATA,XDRFILE,DFNFR,DFNTO,XDRNOD2,XDRDA,X,Y,XDRAID,ZXQAID,PRIFILE ; MODIFIED 03/28/00
 S PRIFILE=$$FILE^XDRDPICK Q:PRIFILE'>0  ; MODIFIED 03/28/00
 K DIC S DIC="^VA(15.1,PRIFILE,2,",DIC("S")="I $$SCRN2^XDRRMRG0(+Y)" ; MODIFIED 03/28/00
 S DIC(0)="AEQZ" D ^DIC K DIC Q:+Y'>0
 S XDRNAME=Y(0,0),XDRFILE=$P(Y(0),U,3),XDRAID=+Y
 K DIC S DIC("S")="I $$SCRN^XDRRMRG0(XDRNAME,+Y)",DIC("A")="Select a POTENTIAL DUPLICATE ENTRY: "
 S DIC=15,DIC(0)="AEQZ" D ^DIC K DIC S XDRY=+Y Q:XDRY'>0 
 G:$$CHKSTAT(XDRY,XDRNAME) END
 S X=^VA(15,XDRY,0)
 I $P($G(^VA(15,XDRY,2,1,0)),U,5)=2 S DFNTO=+X,DFNFR=+$P(X,U,2)
 E  S DFNFR=+X,DFNTO=+$P(X,U,2)
 S XDRDA=$O(^VA(15.1,PRIFILE,2,"B",XDRNAME,0)) Q:XDRDA'>0  ; MODIFIED 03/28/00
 S XDRNOD2=$G(^VA(15.1,PRIFILE,2,XDRDA,2)) ; MODIFIED 03/28/00
 S XQADATA=XDRY_U_DFNFR_";"_DFNTO_U_XDRNAME_U_XDRFILE_U_$P(XDRNOD2,U)_U_$P(XDRNOD2,U,2)
 S (XQAID,ZXQAID)="XDR,"_DFNFR_"/"_DFNTO_","_XDRAID
 D ^XDRRMRG1
 I XDRY="V" S XQAID=ZXQAID D DELETEA^XQALERT
END W ! K DIR S DIR(0)="Y",DIR("A")="Do you want to process another",DIR("B")="YES"
 ;S DIR("?")="  Enter 'Y' to proceed, 'N' or '^' to stop." 
 D ^DIR K DIR
 G:Y EN Q:$D(DIRUT)
 Q
 ;
CHKSTAT(DA,NAME) ;Check ancillary Service Determination fld.
 N X
 S X=$O(@("^VA(15,"_DA_",2,""B"","_""""_NAME_""""_",0)")) I X'>0 Q 0
 I $$GET1^DIQ(15.02,X_","_DA_",",.02,"I")="V" D  Q 1
 .W !!,*7,"  This pair has already been processed as VERIFIED, DUPLICATE by your service!",!
 Q 0
 ;
SCRN(NAME,DA) ;Screen ancillary service with no data.
 N IEN
 I $P(^(0),U,3)'="X"&($P(^(0),U,3)'="R") Q 0 ; NAKED GLOBAL FROM FILEMAN DIC CALL
 S IEN=$O(^(2,"B",NAME,0)) Q:IEN'>0 1
 I $P(^VA(15,DA,2,IEN,0),U,2)="D" Q 0
 Q 1
 ;
SCRN2(DA2) ;Check if user part of ancillary service mailgrp.
 N XDRGRP,X,XDRFLG
 S XDRFLG=0
 S XDRGRP=$P(^(0),U,2) I XDRGRP="" Q XDRFLG
 S X=0 F  S X=$O(^XMB(3.8,XDRGRP,1,X)) Q:X'>0!(XDRFLG)  D
 . I +$G(^XMB(3.8,XDRGRP,1,X,0))=DUZ S XDRFLG=1
 Q XDRFLG
 ;
SEND ;REM - 9/9/96 using mail msgs instead of alerts.
 I '$D(XDRGL) S XDRGL="^DPT(" ;*Take out after alpha.
 S XQAID="XDR,"_DFNFR_"/"_DFNTO_","_XDRAID
 S XQAROU="XDRRMRG1"
 S (XMSUB,XQAMSG)=XDRNAME_" possible duplicates: "_$P(@(XDRGL_DFNFR_",0)"),U)_" AND "_$P(@(XDRGL_DFNTO_",0)"),U)
 D SETUP^XQALERT
 S XMDUZ=.5,XMCHAN=1 D:XDRGRP'="" ^XMD
 Q
 ;
SETARY ;REM - 9/9/96 Sets the R array for the text of the mail msg.
 N SSNFR,SSNTO
 I '$D(XDRGL) S XDRGL="^DPT(" ;*Take out after alpha.
 S SSNFR=$$GET1^DIQ(2,DFNFR,.09)
 S SSNTO=$$GET1^DIQ(2,DFNTO,.09)
 S R(1,0)="FROM Record              "_SSNFR_"  "_$P(@(XDRGL_DFNFR_",0)"),U)_"  [#"_DFNFR_"]"
 S R(2,0)="INTO Record              "_SSNTO_"  "_$P(@(XDRGL_DFNTO_",0)"),U)_"  [#"_DFNTO_"]"
 S R(2.1,0)=""
 S R(2.2,0)="Ancillary service name:  "_XDRNAME
 Q
