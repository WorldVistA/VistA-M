MDPRE23 ;HINES OIFO/BJ - Installation Tasks;07 OCTOBER 2011
 ;;1.0;CLINICAL PROCEDURES;**23**;Apr 01, 2004;Build 281
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine uses the following IAs:
 ;  # 2263       - XPAR calls                   TOOLKIT                        (supported)
 ;  #10141       - MES^XPDUTL                   Kernel                         (supported)
 ;
TERM ; Terminology Pre-Init tasks
 ; Remove existing CDM files so new xrefs etc. come in clean
 D MES^XPDUTL(" Removing existing Clinical Data Model files.")
 N MD,DIU
 F MD=704.103,704.104,704.105,704.106,704.107 D:$$VFILE^DILFD(MD)
 .S DIU=MD,DIU(0)="DT" D EN^DIU2
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
 D EXPORT^MDTERM
 Q
