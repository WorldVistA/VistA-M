EC2P5PST ;ALB/GTS - PATCH EC*2.0*5 Post-Init Rtn ; 8/13/97
 ;;2.0; EVENT CAPTURE ;**5**;8 May 96
 ;
 ;NOTE: This routine is full if it must be broken to 2nd rtn,
 ; DUPCHK and SCCHK are the tags to pull into EC2P5P1
 ;
TEXT ; Install desc.
 ;; This part of the install walks through the DSS file to check
 ;; for the existence of an Associated DSS ID (Associated Stop Code).
 ;; Those DSS Units not sending data to PCE must have an Associated
 ;; DSS ID.  If the DSS Units Associated DSS IDs, they are converted
 ;; to pointers to the Clinic Stop file (#40.7).  DSS Units not having
 ;; Associated DSS IDs or having inactive DSS IDs are noted in a message
 ;; sent to the installer.  The installer should forward the message
 ;; to Medical Center personnel responsible for administration of
 ;; Event Capture DSS Units.
 ;; 
 ;;QUIT
 ;
MSGINTR ; Mail message intro
 ;; Installation of EC*2*5 walks through the DSS Unit file to check
 ;; the existence of an Associated DSS ID (Associated Stop Code).
 ;; DSS Units not sending data to PCE must have an Associated DSS
 ;; ID.  If the DSS Units have Associated DSS IDs, they are converted
 ;; to pointers to the Clinic Stop file (#40.7).  Those DSS Units
 ;; NOT having Associated DSS IDs or having inactive DSS IDs are noted
 ;; in this message.  Medical Center personnel responsible for
 ;; administration of Event Capture DSS Units should note the items
 ;; in this message indicating '**USER EDIT IS REQUIRED**'.  Those
 ;; items indicating 'User REVIEW suggested' denote DSS IDs which
 ;; have been inactivated.  The Event Capture option, DSS Units for
 ;; Event Capture (Enter/Edit), will allow the user to correct the
 ;; Associated DSS ID problems identified in this message.
 ;;QUIT
 ;
POST ; Set Checkpoint
 N %
 S %=$$NEWCP^XPDUTL("IEN","ENTPOST^EC2P5PST",0)
 Q
 ;
ENTPOST ; Entry point
 ;
 D CRESPEC^EC725P ;** File #725 mods
 ;
 ;* If X-refs for DBIA 1902 already added, do not reindex
 I $$GET1^DID(721,"","","PACKAGE REVISION DATA")["EC*2*5" DO
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL("EC Patient File #721, Visit field #28 previously reindexed.")
 .D MES^XPDUTL(" ")
 ;
 ;* Reindex EC Patient file for DBIA 1902
 I $$GET1^DID(721,"","","PACKAGE REVISION DATA")'["EC*2*5" D RNDEX^EC2P5P1
 ;
 ;* If 724 converted, write message
 I $$GET1^DID(724,"","","PACKAGE REVISION DATA")["EC*2*5" DO
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL("DSS Unit File #724 previously converted from DSS IDs to pointers")
 .D MES^XPDUTL("to the Clinic Stop file (#40.7).")
 .D MES^XPDUTL(" ")
 ;
 ;* Convert DSS Unit, DSS ID
 I $$GET1^DID(724,"","","PACKAGE REVISION DATA")'["EC*2*5" D ENTCNV
 Q
 ;
ENTCNV ; Convert DSS Unit, Associated DSS ID
 N TXTVAR
 D MES^XPDUTL(" "),MES^XPDUTL(" ")
 F I=1:1 S TXTVAR=$P($T(TEXT+I),";;",2) Q:TXTVAR="QUIT"  DO
 .S:TXTVAR="" TXTVAR=" "
 .D MES^XPDUTL(TXTVAR)
 D START
 D KVARS
 Q
 ;
START ; Start proc
 S COUNT=0
 ;
 D MES^XPDUTL(" ")
 D MES^XPDUTL("Inspecting Associated DSS IDs in the DSS Unit file.")
 ;
 ;** Inspect Associated DSS ID
 N ECDUDA,ECPCE,ECDSSID,ECDSUNME,ECDNODE,MSGTXT,MSGTXT1,MSGTXT2,ECIDVAR
 N DSSIDSTF
 D LINE(" "),LINE(" ")
 F I=1:1 S TXTVAR=$P($T(MSGINTR+I),";;",2) Q:TXTVAR="QUIT"  DO
 .S:TXTVAR="" TXTVAR=" "
 .D LINE(TXTVAR)
 S ECDUDA=+$$PARCP^XPDUTL("IEN")
 F  S ECDUDA=$O(^ECD(ECDUDA)) Q:+ECDUDA=0  DO
 .I $D(^ECD(ECDUDA,0)) DO
 ..S ECDNODE=^ECD(ECDUDA,0)
 ..S ECPCE=$P(ECDNODE,"^",14)
 ..;* If Unit not sending to PCE
 ..I ECPCE=""!(ECPCE="N") D NOPCE
 ..I ECPCE'="",(ECPCE'="N") D SENDPCE
 D PRD^DILFD(724,"EC*2*5") ;** Set VRRV node (file #724)
 D MAIL
 Q
 ;
KVARS K COUNT,Y,I
 Q
 ;
NOPCE ; Process Units NOT sent to PCE
 S ECDSSID=$P(ECDNODE,"^",10)
 S ECDSUNME=$P(ECDNODE,"^",1)
 ;* If DSS ID is null
 I ECDSSID="" DO
 .S MSGTXT="There is no Associated DSS ID for the DSS Unit "_ECDSUNME
 .D LINE(" ")
 .D LINE(MSGTXT)
 .D LINE("**USER EDIT IS REQUIRED**")
 ;* If DSS ID is not null
 I ECDSSID'="" DO
 .S ECIDVAR=$$SCCHK(+ECDSSID) ;* Check 40.7 for DSS ID
 .I +ECIDVAR=-1,(+$P(ECIDVAR,"^",2)=0) DO  ;* DSS ID does not exist
 ..S MSGTXT="Associated DSS ID for the DSS Unit "_ECDSUNME_" does not exist."
 ..D LINE(" ")
 ..D LINE(MSGTXT)
 ..D LINE("**USER EDIT IS REQUIRED**")
 ..D NULLID ;**Nullify BAD DSS ID data
 .;* DSS ID is inactive
 .I +ECIDVAR=-1,(+$P(ECIDVAR,"^",2)'=0) DO
 ..S Y=$P(ECIDVAR,"^",3)
 ..D DD^%DT
 ..S MSGTXT="Associated DSS ID for the DSS Unit "_ECDSUNME_" was inactivated"
 ..S MSGTXT1="effective "_Y_".  User REVIEW suggested."
 ..D LINE(" ")
 ..D LINE(MSGTXT)
 ..D LINE(MSGTXT1)
 ..D CONVRT ;**Convert to pointer (40.7)
 .;* DSS ID found and active
 .I +ECIDVAR=1 DO
 ..I +$P(ECIDVAR,"^",3)>0 DO
 ...S Y=$P(ECIDVAR,"^",3)
 ...D DD^%DT
 ...S MSGTXT="Associated DSS ID for "_ECDSUNME_" was found and is active."
 ...S MSGTXT1=ECDSSID_" ("_$P(^DIC(40.7,$P(ECIDVAR,"^",2),0),"^",1)_") will become"
 ...S MSGTXT2="inactive on "_Y_", however.  (User information only.)"
 ...D LINE(" ")
 ...D LINE(MSGTXT)
 ...D LINE(MSGTXT1)
 ...D LINE(MSGTXT2)
 ..D CONVRT ;**Convert to pointer (40.7)
 .I +ECIDVAR=2 DO
 ..S MSGTXT="Associated DSS ID "_ECDSSID_" for the DSS Unit "_ECDSUNME
 ..S MSGTXT1="has multiple DSS ID Names.  **USER EDIT IS REQUIRED**"
 ..D LINE(" ")
 ..D LINE(MSGTXT)
 ..D LINE(MSGTXT1)
 ..D NULLID ;**Nullify BAD DSS ID data
 Q
 ;
SENDPCE ; Process units sent to PCE
 S ECDSSID=$P(ECDNODE,"^",10)
 S ECDSUNME=$P(ECDNODE,"^",1)
 ;* If DSS ID is not Null
 I ECDSSID'="" DO
 .S ECIDVAR=$$SCCHK(+ECDSSID) ;* Check 40.7 for DSS ID
 .I +ECIDVAR'=1 DO
 ..S MSGTXT="Associated DSS ID for "_ECDSUNME_" was either not found, is inactive or has"
 ..S MSGTXT1="multiple active DSS ID names."
 ..S MSGTXT2=ECDSSID_" was removed from "_ECDSUNME_"."
 ..D LINE(" ")
 ..D LINE(MSGTXT)
 ..D LINE(MSGTXT1)
 ..D LINE(MSGTXT2)
 ..D LINE("User Information only.  Events for this unit are not sent to PCE")
 ..D NULLID ;**Nullify BAD DSS ID data
 .I +ECIDVAR=1 DO
 ..S MSGTXT="Associated DSS ID for "_ECDSUNME_" converted for "_ECDSSID_"."
 ..D LINE(" ")
 ..D LINE(MSGTXT)
 ..D LINE("User Information only.  Events for this unit are not sent to PCE")
 ..D CONVRT ;**Convert to pointer (40.7)
 Q
 ;
CONVRT ; Convert DSS ID to pointer
 ; Required variables (defined)
 ;  ECIDVAR  - Result of SCCHK
 ;  ECDUDA   - IEN of DSS Unit processing
 ;  DSSIDSTF - Must be NEW'ed prior to calling
 ;
 S DSSIDSTF=$P(ECIDVAR,"^",2)
 S DIE="^ECD(",DA=ECDUDA,DR="9////^S X=DSSIDSTF"
 D ^DIE
 N %
 S %=$$UPCP^XPDUTL("IEN",ECDUDA)
 K DIE,DA,DR
 Q
 ;
NULLID ; Nullify BAD DSS IDs
 ; Required variables (defined)
 ;  ECDUDA   - IEN of DSS Unit processing
 ;
 S DIE="^ECD(",DA=ECDUDA,DR="9////@"
 D ^DIE
 N %
 S %=$$UPCP^XPDUTL("IEN",ECDUDA)
 K DIE,DA,DR
 Q
 ;
SCCHK(ECDSSID) ; Check 40.7 for DSS ID
 ; Input:
 ;  ECDSSID  - The DSS ID to check
 ;
 ; Output:
 ;  ECRESULT - Indicates if the DSS ID was found
 ;             Values
 ;               -1                       : DSS ID was not found
 ;               -1^ien^Inactivation date : DSS ID found but is inactive
 ;               1^ien^Inactivation date  : DSS ID found and is active
 ;                                         Pce 3=null if no inactv date
 ;               2                        : Multiple active entries found
 ;
 N ECRESULT,ECIDDA,CONTINUE,ECSCNODE,DUPRSLT
 S CONTINUE=1
 S ECRESULT=-1
 I CONTINUE,($D(^DIC(40.7,"C",ECDSSID))) DO
 .S ECIDDA=$O(^DIC(40.7,"C",ECDSSID,""))
 .I CONTINUE,(+ECIDDA'>0) S CONTINUE=0 ;**DSS ID does not exist
 .I CONTINUE,($D(^DIC(40.7,ECIDDA,0))) DO  ;**DSS ID exists
 ..S ECSCNODE=^DIC(40.7,ECIDDA,0)
 ..S DUPRSLT=$$DUPCHK(ECDSSID,ECIDDA)
 ..I CONTINUE,($P(ECSCNODE,"^",3)'="") DO
 ...I CONTINUE,(DT>$P(ECSCNODE,"^",3)) DO  ;**DSS ID inactive
 ....I +DUPRSLT<1 DO  ;**Only one entry (inactive) for DSS ID
 .....S ECRESULT="-1^"_ECIDDA_"^"_$P(ECSCNODE,"^",3)
 ....I +DUPRSLT=1 DO  ;**An active DSS ID found
 .....S ECRESULT="1^"_$P(DUPRSLT,"^",2)_"^"_$P(^DIC(40.7,$P(DUPRSLT,"^",2),0),"^",3)
 ....I +DUPRSLT=2 DO  ;**Multiple active DSS IDs found
 .....S ECRESULT=2
 ....S CONTINUE=0
 ..I CONTINUE,($P(ECSCNODE,"^",3)="") DO  ;**DSS ID active, null date
 ...I +DUPRSLT<1 S ECRESULT="1^"_ECIDDA_"^" ;**1 active DSS ID entry
 ...I +DUPRSLT>0 S ECRESULT=2 ;**Multiple active DSS ID entries found
 ...S CONTINUE=0
 ..I CONTINUE,(DT<$P(ECSCNODE,"^",3)) DO  ;**DSS ID active, with date
 ...;
 ...;**If one active DSS ID entry
 ...I +DUPRSLT<1 S ECRESULT="1^"_ECIDDA_"^"_$P(ECSCNODE,"^",3)
 ...I +DUPRSLT>0 S ECRESULT=2 ;**Multiple active DSS ID entries found
 ...S CONTINUE=0
 Q ECRESULT
 ;
DUPCHK(ECID,ECIDD1) ; Look for 2nd Stop Code entry
 ; Input:
 ;  ECID   - The DSS ID to check
 ;  ECIDD1 - The IEN for the 1st entry found
 ;
 ; Output:
 ;  RSLT   - Indicates if a 2nd entry for the DSS ID was found
 ;           Values
 ;             0      : No second entry was found
 ;             -1     : Second entry found (inactive)
 ;             1^ien  : Second entry found (active)
 ;             2      : Multiple (active) entries found
 N RSLT,NODE0,ACTIVCT,DUPIDCT
 S (DUPIDCT,ACTIVCT,RSLT)=0
 F  S ECIDD1=$O(^DIC(40.7,"C",ECID,ECIDD1)) Q:+ECIDD1=0  DO
 .I $D(^DIC(40.7,ECIDD1,0)) DO
 ..S DUPIDCT=DUPIDCT+1
 ..S NODE0=^DIC(40.7,ECIDD1,0)
 ..I ($P(NODE0,"^",3)="")!(DT<+$P(NODE0,"^",3)) DO
 ...S RSLT="1^"_ECIDD1
 ...S ACTIVCT=ACTIVCT+1
 I DUPIDCT>0,(ACTIVCT=0) S RSLT=-1
 I ACTIVCT>1 S RSLT=2
 Q RSLT
 ;
MAIL ; Send message
 N DIFROM
 S XMY(DUZ)="",XMDUZ=.5
 S XMSUB="EC DSS Unit, DSS ID conversion"
 S XMTEXT="^TMP(""EC V2.0 P5 INSTALL MSG"","_$J_","
 D ^XMD
 K XMDUZ,XMY,XMTEXT,XMSUB
 K ^TMP("EC V2.0 P5 INSTALL MSG",$J)
 Q
 ;
LINE(TEXT)      ; add line to e-mail array
 S COUNT=COUNT+1,^TMP("EC V2.0 P5 INSTALL MSG",$J,COUNT)=TEXT
 Q
