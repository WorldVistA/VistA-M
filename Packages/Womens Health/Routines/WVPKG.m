WVPKG ;ISP/RFR - EDIT PACKAGE PARAMETERS;Jan 03, 2019@15:02
 ;;1.0;WOMEN'S HEALTH;**24**;Sep 30, 1998;Build 582
 Q
EDIT ;EDIT THE PARAMETERS
 N WVPKG,WVERROR
 S WVPKG=+$$FIND1^DIC(9.4,,,"WOMEN'S HEALTH",,"I $P($G(^(0)),U,2)=""WV""","WVERROR")
 I WVPKG=0!($D(WVERROR)) D  Q
 .W !,"ERROR encountered:",!,$$FMERROR^WVUTL11(.WVERROR)
 .W !,"Could not find the WOMEN'S HEALTH entry in the PACKAGE file (#9.4)."
 .W !,"Please contact the national help desk for assistance."
 I WVPKG>0 D TED^XPAREDIT("WV CPRS PACKAGE PARAMETERS","B",WVPKG_";DIC(9.4,")
 Q
