MDPRE16 ;HINES OIFO/DP - Installation Tasks;02 Mar 2008
 ;;1.0;CLINICAL PROCEDURES;**16**;Apr 01, 2004;Build 280
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine uses the following IAs:
 ;  # 2263       - XPAR calls                   TOOLKIT                        (supported)
 ;  #10141       - MES^XPDUTL                   Kernel                         (supported)
 ;
CORE ; Update core files
 D:$$VFIELD^DILFD(704.002,.03)
 .D:$$GET1^DID(704.002,.03,"","TYPE")["POINTER"
 ..D MES^XPDUTL(" Updating source field in CP_HL7_LOG file...")
 ..F X=0:0 S X=$O(^MDC(704.002,X)) Q:'X  D
 ...S Y=$P(^MDC(704.002,X,0),U,3) Q:+Y'=Y
 ...S Y=$P($G(^MDC(704.108,Y,.2)),U,2)
 ...S $P(^MDC(704.002,X,0),U,3)=Y
 D:$$VFILE^DILFD(704.122)
 .D:$$GET1^DID(704.122,"","","NAME")="CARE_ACTION_SCHEDULE"
 ..D MES^XPDUTL(" Removing obsolete KARDEX structures...")
 ..N DIU
 ..S DIU="^MDC(704.121,",DIU(0)="DT" D EN^DIU2
 ..S DIU="^MDC(704.122,",DIU(0)="DT" D EN^DIU2
 ;
TERM ; Terminology Pre-Init tasks
 ; Remove existing CDM files so new xrefs etc. come in clean
 D MES^XPDUTL(" Removing existing Clinical Data Model files.")
 N MD,DIU
 F MD=704.103,704.104,704.105,704.106,704.107,704.108,704.109 D:$$VFILE^DILFD(MD)
 .S DIU=MD,DIU(0)="DT" D EN^DIU2
 ;
FLOW ; Flowsheet pre-init tasks
 ; Update supplemental pages
 D:$$GET1^DID(704.1122,.01,"","TYPE")["POINTER"
 .N MDFDA,MDX,MDGUID
 .D MES^XPDUTL(" Updating Supplemental Pages...")
 .F MDX=0:0 S MDX=$O(^MDC(704.1122,MDX)) Q:'MDX  D
 ..D GETGUID^MDCLIO1(.MDGUID)
 ..S $P(^MDC(704.1122,MDX,0),U,10)=+^MDC(704.1122,MDX,0)
 ..S MDFDA(704.1122,MDX_",",.01)=MDGUID
 ..D FILE^DIE("","MDFDA")
 ;
 D MES^XPDUTL(" MD*1.0*16 Pre-Init Tasks Done.")
 Q
 ;
EXPORT ; KIDS export call
 ;
 ; Export the command file into the KIDS global
 ;
 N MDCMD,MDX,MDTXT,DD,DA,IENS,FLD
 D MES^XPDUTL(" Preparing Command File for export...")
 D GETLST^XPAR(.MDCMD,"SYS","MD COMMANDS","Q")
 F MDX=0:0 S MDX=$O(MDCMD(MDX)) Q:'MDX  D
 .S MDCMD=$P(MDCMD(MDX),U,1)
 .D GETWP^XPAR(.MDTXT,"SYS","MD COMMANDS",MDCMD)
 .M @XPDGREF@("MD COMMANDS",MDCMD)=MDTXT
 D MES^XPDUTL(" Command File moved to KIDS distribution global.")
 ;
 ; Export the CDM into the KIDS distribution global
 ; 
 D MES^XPDUTL(" Preparing Clinical Data Model for export...")
 K ^TMP($J)
 F DD=704.101,704.103,704.104,704.105,704.106,704.107,704.108,704.109 D
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
