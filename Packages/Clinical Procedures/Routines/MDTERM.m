MDTERM ;HINES OIFO/DP - Terminology Utilities;04 Jan 2006
 ;;1.0;CLINICAL PROCEDURES;**16,23**;Apr 01, 2004;Build 281
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine uses the following IAs:
 ;  #10141       - MES^XPDUTL                   Kernel                         (supported)
 ;
EN ;
 Q
 ; 
GETTERM(MDVUID) ; Returns term name from VUID
 I '$D(^MDC(704.101,"VUID",MDVUID)) Q "^"
 Q $P($G(^MDC(704.101,+$O(^MDC(704.101,"VUID",MDVUID,0)),0)),U,2)
 ;
CVTVAL(MDVAL,MDFR,MDTO,MDROUND) ; Converts a value from one unit to another
 ; MDVAL   = Value to convert
 ; MDFR    = VUID or Name of unit to convert from (Must be exact match)
 ; MDTO    = VUID or Name of unit to convert to (Must be exact match)
 ; MDROUND = Decimal precision (optional to override conversion logic)
 N MDCVT
 I MDFR=MDTO Q MDVAL ; No conversion done
 S MDFR=+$$FIND1^DIC(704.101,"","X",MDFR,"VUID^C","I $P(^(0),U,5)=2")
 S MDTO=+$$FIND1^DIC(704.101,"","X",MDTO,"VUID^C","I $P(^(0),U,5)=2")
 S MDCVT=$O(^MDC(704.104,"PK",MDFR,MDTO,0)) Q:'MDCVT "^"
 S MDCVT=^MDC(704.104,MDCVT,0)
 S MDVAL=MDVAL+$P(MDCVT,U,3)*$P(MDCVT,U,5)+$P(MDCVT,U,4)
 S:'$D(MDROUND) MDROUND=+$P(MDCVT,U,6)
 Q +$J(MDVAL,0,+MDROUND)
 ;
SCREEN(MDTERM,MDTYPE) ; Generic screen for FM pointers to terminology
 ; Returns 1 of MDTERM is of type MDTYPE and Active
 ; FM Screen example: S DIC("S")="I $$SCREEN^MDTERM(+Y,TYPE)"
 Q ($P(^MDC(704.101,MDTERM,0),U,5)=MDTYPE)&($P(^(0),U,9))
 ;
VERIFY ; Verify the check sums
 N MDCHKSUM
 W !!,"Verifying the Clinical Data Model Checksums",!
 W !,"FILE",?30,"Patch",?42,"Build",?50,"Check-Sum",?70,"Status"
 W !,$TR($J("",79)," ","-")
 F MDD=704.101,704.102,704.103,704.104,704.105,704.106,704.107,704.108,704.109 D
 .S MDCHKSUM=$$GET1^DID(MDD,"","","PACKAGE REVISION DATA")
 .W !,$$GET1^DID(MDD,"","","NAME"),?30,$P(MDCHKSUM,";",1),?42,$P(MDCHKSUM,";",2),?50,$P(MDCHKSUM,";",3),?70
 .I $P(MDCHKSUM,";",3)=$$CHKSUM(MDD) W "Okay" Q
 .W "Error"
 Q
 ;
CHKSUM(MDFILE) ; Calculate a checksum value for a terminology file
 S MDGBL=$NA(^MDC(MDFILE)),Y=0
 F  S MDGBL=$Q(@MDGBL) Q:MDGBL=""  Q:$QS(MDGBL,1)>MDFILE  D
 .D CALC(MDGBL),CALC(@MDGBL)
 Q Y
 ;
CALC(X) ; Update the Checksum
 F %=1:1:$L(X) S Y=$A(X,%)*%+Y
 Q
 ;
MAP2DNP ; Insert a temporary mapping table entry to DNP for a vendor key
 N DIC,DIR,MDTABLE,MDKEY,MDTERM,MDNAME,MDLKUP,MDFDA,MDIEN
 W !,"This option will allow the user to insert a Do Not Process key into a"
 W !,"vendors mapping table. Immediate action should be taken with the national"
 W !,"development team to get this vendor key included in the next release of"
 W !,"the CP Terminology files.",!
 S DIC="^MDC(704.108,"
 S DIC(0)="AEQMZ"
 S DIC("A")="Select Mapping Table To Update: "
 D ^DIC Q:+Y<1
 S (MDLKUP(1),MDTABLE)=Y(0,0),MDNAME=$P(Y(0),U,2)
 S DIR(0)="FA^1:30",DIR("A")="Enter the Vendor Key to Map: " D ^DIR Q:Y=U
 S (MDKEY,MDLKUP(2))=Y
 S MDLKUP(3)=$$GET1^DIQ(704.102,"1,",.01)
 I +$$FIND1^DIC(704.109,,"KX",.MDLKUP)>0 W !!,"ERROR - There is already a mapping entry for this." Q
 S MDTERM="{4615254C-EC67-46D0-BF70-9A54BEB4B32D}"
 W !!,"New Mapping Table Pair",!,$TR($J("",50)," ","-")
 W !,"Table ID:...... ",MDNAME
 W !,"Vendor Key:.... ",MDKEY
 W !,"Pair Type:..... ",$$GET1^DIQ(704.102,"1,",.01)
 W !!,"Are you sure you want to do this" S %=2 D YN^DICN Q:%'=1
 W !!,"Filing..."
 S MDFDA(704.109,"+1,",.01)=MDTABLE
 S MDFDA(704.109,"+1,",.03)=$$GET1^DIQ(704.102,"1,",.01)
 S MDFDA(704.109,"+1,",.04)=MDTERM
 S MDFDA(704.109,"+1,",.1)=MDKEY
 D UPDATE^DIE("","MDFDA","MDIEN")
 I '$G(MDIEN(1)) W "Error, no record added." Q
 W "Done. New IEN: ",MDIEN(1)
 Q
 ;
POSTCHK ; Scan for in-use inactive terms
 ; Called by MDPOST16 but can be used at any time
 D MES^XPDUTL(" Checking for components pointing to inactive terminology")
 D CHKFILE(704.1111,.03)
 D CHKFILE(704.1112,.04)
 D CHKFILE(704.1122,.04)
 D CHKFILE(704.1122,.05)
 D CHKFILE(704.1122,.06)
 D CHKFILE(704.1122,.07)
 D CHKFILE(704.113,.04)
 D CHKFILE(704.1131,.02)
 D CHKFILE(704.115,.03)
 Q
 ;
CHKFILE(DD,FLD) ; Loop through a file and look for inactive terms being used.
 N MDGBL,MDIEN,MDTERM,MDCOUNT
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" Scanning File: "_$$GET1^DID(DD,,,"NAME")_" ("_DD_") Field: "_$$GET1^DID(DD,FLD,,"LABEL"))
 S MDGBL=$$GET1^DID(DD,,,"GLOBAL NAME")_"MDIEN)",MDCOUNT=0
 F MDIEN=0:0 S MDIEN=$O(@MDGBL) Q:'MDIEN  D
 .Q:$$GET1^DIQ(DD,MDIEN_",",FLD)=""  ; It's blank - lets bail!
 .Q:DD=704.1122&('$$GET1^DIQ(704.1122,MDIEN_",",.09,"I"))  ; Make sure a supp page is still active first
 .Q:DD=704.115&('$$GET1^DIQ(704.115,MDIEN_",",.21,"I"))  ; Make sure an alarm isn't deactivated
 .Q:$$GET1^DIQ(DD,MDIEN_",",FLD_":.09","I")  ; Checks the active flag of the term.
 .D MES^XPDUTL("   Entry #"_MDIEN_" References inactive term: "_$$GET1^DIQ(DD,MDIEN_",",FLD_":.02"))
 .S MDCOUNT=MDCOUNT+1
 D MES^XPDUTL("   "_MDCOUNT_" issue(s) found.")
 Q
 ;
EXPORT ; Export the current Data Model to KIDS in @XPDGREF@(...)
 D MES^XPDUTL(" Preparing Clinical Data Model for export...")
 K ^TMP($J)
 ; Move the working TERM_TYPE file
 F X=0:0 S X=$O(^MDC(704.102,X)) Q:'X  S @XPDGREF@("TERM_TYPE",X)=^MDC(704.102,X,0)
 ; Now move the rest of the term files
 F DD=704.101,704.103,704.104,704.105,704.106 D
 .F DA=0:0 S DA=$O(^MDC(DD,DA)) Q:'DA  D
 ..I DD=704.108 Q:'$P(^MDC(DD,DA,0),U,9)  ; skip inactive mapping tables
 ..I DD=704.109 Q:'$P(^MDC(704.108,$P(^MDC(704.109,DA,0),U,1),0),U,9)  ; skip inactive mapping table entries
 ..S IENS=DA_"," D GETS^DIQ(DD,IENS,"*","",$NA(^TMP($J)))
 .S IENS="" F  S IENS=$O(^TMP($J,DD,IENS)) Q:IENS=""  D
 ..F FLD=0:0 S FLD=$O(^TMP($J,DD,IENS,FLD)) Q:'FLD  D
 ...S Y=$O(@XPDGREF@("CDM",""),-1)+1
 ...S @XPDGREF@("CDM",Y)=DD_";"_(+IENS)_";"_FLD_U_^TMP($J,DD,IENS,FLD)
 .K ^TMP($J,DD)
 D MES^XPDUTL(" Clinical Data Model moved to KIDS distribution global.")
 Q
 ;
IMPORT ; Post installation install from @XPDGREF@(...)
 N MD,DA,DIK,MDCMD,MDD,MDA,MDIEN,MDFDA,MDIENS,MDFLD,MDBUILD
 S MDBUILD=$P($P($T(+2),";",7)," ",2)
 D MES^XPDUTL(" Importing a new Dictionary and Clinical Data Model.")
 ;
 ; First we purge the existing CDM
 F MD=704.102,704.103,704.104,704.105,704.106 D:$$VFILE^DILFD(MD)
 .S DIK=$$ROOT^DILFD(MD) F DA=0:0 S DA=$O(@(DIK_"DA)")) Q:'DA  D ^DIK
 ;
 ; Install the new TERM_TYPE file - This file is moved with strict IEN matches
 F X=0:0 S X=$O(@XPDGREF@("TERM_TYPE",X)) Q:'X  S ^MDC(704.102,X,0)=@XPDGREF@("TERM_TYPE",X)
 S DIK="^MDC(704.102," D IXALL^DIK
 ;
 K DA,DIK ; Just in case ;)
 ;
 ; Next we deactivate all the terms already here so only the ones coming in are active
 I $O(^MDC(704.101,0)) D MES^XPDUTL(" Deactivating existing terms.")
 F MDIEN=0:0 S MDIEN=$O(^MDC(704.101,MDIEN)) Q:'MDIEN  D
 .S MDFDA(704.101,MDIEN_",",.09)=0 D FILE^DIE("","MDFDA")
 ;
 ; Now install it
 D MES^XPDUTL(" Installing new terminology.")
 K ^TMP($J,"MDFDA") S MDIEN=0
 F X=0:0 S X=$O(@XPDGREF@("CDM",X)) Q:'X  D
 .S Y=@XPDGREF@("CDM",X)
 .S MDD=+$P(Y,";",1)
 .S MDIENS=+$P(Y,";",2)
 .S MDFLD=+$P(Y,";",3)
 .S ^TMP($J,"MDFDA",MDD,MDIENS,MDFLD)=$P(Y,U,2,250)
 F MDD=0:0 S MDD=$O(^TMP($J,"MDFDA",MDD)) Q:'MDD  D
 .F MDA=0:0 S MDA=$O(^TMP($J,"MDFDA",MDD,MDA)) Q:'MDA  D
 ..K MDFDA
 ..S MDIENS="+1"
 ..S:MDD=704.101 MDIENS=$$GETIENS(^TMP($J,"MDFDA",MDD,MDA,.01))
 ..M MDFDA(MDD,MDIENS_",")=^TMP($J,"MDFDA",MDD,MDA)
 ..D UPDATE^DIE("EK","MDFDA",,"MDMSG")
 ..I $D(MDMSG) D MES^XPDUTL(MDMSG("DIERR",1,"TEXT",1))
 ..K MDMSG,MDFDA
 ;
 ; Update the check sums
 F MDD=704.101,704.102,704.103,704.104,704.105,704.106 D
 .D MES^XPDUTL(" Storing check sum for file "_$$GET1^DID(MDD,"","","NAME")_"...")
 .D PRD^DILFD(MDD,"MD*1.0*23;b"_$P($P($T(+2),";",7)," ",2)_";"_$$CHKSUM^MDTERM(MDD))
 ;
 D MES^XPDUTL(" New Clinical Data Model for Terminology has been installed.")
 Q
 ;
GETIENS(MDID) ; Finds the correct IEN in the SITES TERM file
 I $D(^MDC(704.101,"PK",MDID)) Q +$O(^MDC(704.101,"PK",MDID,0))
 ; No match in "PK" index, add it!
 I 'MDIENS S MDIENS="+1" D MES^XPDUTL("    Term '"_^TMP($J,"MDFDA",MDD,MDA,.01)_"' ("_^(.02)_") will be added...")
 Q MDIENS
 ;
