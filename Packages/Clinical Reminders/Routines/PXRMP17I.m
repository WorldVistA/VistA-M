PXRMP17I ; SLC/PKR - Inits for PXRM*2.0*17. ;02/02/2010
 ;;2.0;CLINICAL REMINDERS;**17**;Feb 04, 2005;Build 102
 Q
 ;==========================================
ALLERGY ;Reset computed finding parameter for new version of VA-ALLERGY
 ;computed finding.
 D BMES^XPDUTL("Reset computed finding parameter for new version of VA-ALLERGY")
 N CFIEN,CFPARAM,IEN,FINDING
 S CFIEN=$O(^PXRMD(811.4,"B","VA-ALLERGY",""))
 I CFIEN="" Q
 K ^TMP($J,"LIST")
 D BLDLIST^PXRMFRPT(811.4,"PXRMD(811.4,",CFIEN,"LIST")
 ;Process definitions
 S IEN=""
 F  S IEN=$O(^TMP($J,"LIST",811.4,CFIEN,"DEF",IEN)) Q:IEN=""  D
 . S FINDING=""
 . F  S FINDING=$O(^TMP($J,"LIST",811.4,CFIEN,"DEF",IEN,FINDING)) Q:FINDING=""  D
 .. S CFPARAM=$G(^PXD(811.9,IEN,20,FINDING,15)) Q:$L(CFPARAM,":")'=2  ;already converted if not equal to 2
 .. S ^PXD(811.9,IEN,20,FINDING,15)=CFPARAM_":*:*:*" ;add 3 new parameters
 ;Process terms
 S IEN=""
 F  S IEN=$O(^TMP($J,"LIST",811.4,CFIEN,"TERM",IEN)) Q:IEN=""  D
 . S FINDING=""
 . F  S FINDING=$O(^TMP($J,"LIST",811.4,CFIEN,"TERM",IEN,FINDING)) Q:FINDING=""  D
 .. S CFPARAM=$G(^PXRMD(811.5,IEN,20,FINDING,15)) Q:$L(CFPARAM,":")'=2  ;already converted if not equal to 2
 .. S ^PXRMD(811.5,IEN,20,FINDING,15)=CFPARAM_":*:*:*" ;add 3 new parameters
 K ^TMP($J,"LIST")
 Q
 ;
 ;===============================================================
CFINC(Y) ;List of computed findings to include in the build.
 N CFLIST,CFNAME
 S CFLIST("VA-ALLERGY")=""
 S CFLIST("VA-ASU USER CLASS")=""
 S CFLIST("VA-WAS INPATIENT")=""
 S CFLIST("VA-ACTIVE PATIENT RECORD FLAGS")=""
 S CFNAME=$P($G(^PXRMD(811.4,Y,0)),U)
 Q $S($D(CFLIST(CFNAME)):1,1:0)
 ;
 ;===============================================================
DELDD ;Delete the old data dictionaries.
 ;N DIU,TEXT
 ;D EN^DDIOL("Removing old data dictionaries.")
 ;S DIU(0)=""
 ;F DIU=801.41,810.1,810.2,810.4,810.5,810.7,810.8,810.9,811.2,811.4,811.5,811.6,811.8,811.9 D
 ;. S TEXT=" Deleting data dictionary for file # "_DIU
 ;. D EN^DDIOL(TEXT)
 ;. D EN^DIU2
 Q
 ;
 ;==========================================
INILT ;Initialize list templates
 ;N IEN,IND,LIST,TEMP0
 ;D LTL^PXRMP12I(.LIST)
 ;S IND=0
 ;IA #4123
 ;F  S IND=$O(LIST(IND)) Q:IND=""  D
 ;. S IEN=$O(^SD(409.61,"B",LIST(IND),"")) Q:IEN=""
 ;. S TEMP0=$G(^SD(409.61,IEN,0))
 ;. K ^SD(409.61,IEN)
 ;. S ^SD(409.61,IEN,0)=TEMP0
 Q
 ;
 ;==========================================
LTL(LIST) ;This is the list of list templates that being distributed
 ;in the patch.
 ;S LIST(1)="PXRM EX LIST COMPONENTS"
 ;S LIST(2)="PXRM EX REMINDER EXCHANGE"
 Q
 ;
 ;===============================================================
MSTSYNC ;Run the MST synchronization.
 N TEXT
 K ZTSAVE
 S ZTSAVE("STIME")=-1
 S ZTRTN="SYNCH^PXRMMST"
 S ZTDESC="Clinical Reminders MST synchronization job"
 S ZTDTH=$$NOW^XLFDT
 S ZTIO=""
 D ^%ZTLOAD
 S TEXT="MST synchronization queued, task number "_$G(ZTSK)_"."
 D BMES^XPDUTL(.TEXT)
 Q
 ;
 ;===============================================================
PRE ;Pre-init
 ;Disable options and protocols
 D OPTION^PXRMUTIL("DISABLE")
 D PROTOCOL^PXRMUTIL("DISABLE")
 D DELEXE^PXRMEXSI("EXARRAY","PXRMP17E")
 Q
 ;
 ;===============================================================
POST ;Post-init
 ;Enable options and protocols
 D OPTION^PXRMUTIL("ENABLE")
 D PROTOCOL^PXRMUTIL("ENABLE")
 D RENASPON^PXRMP17I
 D SENDPV^PXRMP17I
 ;Install Exchange File entries.
 D SMEXINS^PXRMEXSI("EXARRAY","PXRMP17E")
 ;Run the MST synchronization.
 D MSTSYNC^PXRMP17I
 ;Reset computed finding parameter for new version of VA-ALLERGY.
 D ALLERGY^PXRMP17U
 D SETPVER^PXRMUTIL("2.0P17")
 Q
 ;
 ;===============================================================
RENASPON ;Rename some Sponsor file entries.
 N OLDNAME,NEWNAME
 D BMES^XPDUTL("Renaming some Sponsor entries")
 S OLDNAME="Mental Health and Behavioral Science Strategic Group"
 S NEWNAME="Office of Mental Health Services"
 D RENAME^PXRMUTIL(811.6,OLDNAME,NEWNAME)
 S OLDNAME="Mental Health and Behavioral Science Strategic Group and Women Veterans Health Program"
 S NEWNAME="Office of Mental Health Services and Women Veterans Health Program"
 D RENAME^PXRMUTIL(811.6,OLDNAME,NEWNAME)
 Q
 ;
 ;==========================================
SENDPV ;Send the system level value of ORQQPX NEW REMINDER PARAMS.
 N FROM,NODE,PARAM,SYSTEM,SUBJ,TO,VALUE
 S NODE="PXRM*2.0*17"
 K ^TMP(NODE,$J)
 S PARAM="ORQQPX NEW REMINDER PARAMS"
 ;DBIA #2263
 S VALUE=$$GET^XPAR("SYS",PARAM,1,"E")
 ;DBIA #1131 for ^XMB("NETNAME")
 S FROM="PXRM*2.0*17 Install@"_^XMB("NETNAME")
 ;DBIA #2541
 S SYSTEM=$$KSP^XUPARAM("WHERE")
 I $$PROD^XUPROD(1) S TO("G.CLINICAL REMINDERS SUPPORT@DOMAIN.EXT")=""
 E  D
 . N MGIEN,MGROUP
 . S MGIEN=$G(^PXRM(800,1,"MGFE"))
 . S MGROUP=$S(MGIEN'="":"G."_$$GET1^DIQ(3.8,MGIEN,.01),1:DUZ)
 . S TO(MGROUP)=""
 S SUBJECT="System level setting of "_PARAM
 S ^TMP(NODE,$J,1,0)=SUBJECT_" is "_VALUE
 S ^TMP(NODE,$J,2,0)="System is "_SYSTEM
 D SEND^PXRMMSG(NODE,SUBJECT,.TO,FROM)
 Q
 ;
