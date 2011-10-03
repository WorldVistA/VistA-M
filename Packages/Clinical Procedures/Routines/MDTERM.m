MDTERM ;HINES OIFO/DP - Terminology Utilities;04 Jan 2006
 ;;1.0;CLINICAL PROCEDURES;**16**;Apr 01, 2004;Build 280
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
