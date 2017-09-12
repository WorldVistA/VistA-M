MDTERMX ;HINES OIFO/DP - Installation Tasks;02 Mar 2008 ; 2/10/17 2:31pm
 ;;1.0;CLINICAL PROCEDURES;**53**;Aug 2, 2012;Build 7
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine uses the following IAs:
 ;  #10141       - MES^XPDUTL                   Kernel            (supported
 ;
EN ;Use in Post installation of Clinical Data Model
 New MD,DA,DIK,MDCMD,MDD,MDA,MDIEN,MDFDA,MDIENS,MDFLD
 ;
 Do MES^XPDUTL(" Installing new Clinical Data Model.")
 For MDFILE=0:0 Set MDFILE=$Order(@XPDGREF@(MDFILE)) Quit:'MDFILE  Do
 . ; Purge each file as we find it in @XPDGREF@(MDFILE)
 . Set Y=$Piece(^MDC(MDFILE,0),U,1,2) Kill ^MDC(MDFILE) Set ^MDC(MDFILE,0)=Y
 . Set MDIENS="" For  Set MDIENS=$Order(@XPDGREF@(MDFILE,MDIENS)) Quit:MDIENS=""  Do
 . . New MDFDA,MDERR
 . . Merge MDFDA(MDFILE,"+1,")=@XPDGREF@(MDFILE,MDIENS)
 . . Do UPDATE^DIE("EK","MDFDA",,"MDERR")
 . . If $Data(MDERR) Write !,"Error: ",! ZWrite MDERR
 . . Else  Write "."
 . ; Apply the checksum to the file
 . Do PRD^DILFD(MDFILE,"Checksum;"_$$CHKSUM^MDTERM(MDFILE))
 Do MES^XPDUTL(" New Clinical Data Model for Terminology has been installed.")
 Quit
 ;
EXPORT ; KIDS export call
 New MDCMD,MDX,MDTXT,DD,DA,IENS,FLD
 Kill @XPDGREF
 ; Move the Clinical Data Model into the KIDS distribution global
 Do MES^XPDUTL(" Moving Clinical Data Model to KIDS transport global.")
 For DD=704.103,704.104,704.105,704.106 Do
 . For DA=0:0 Set DA=$Order(^MDC(DD,DA)) Quit:'DA  Do
 . . Set IENS=DA_","
 . . Do GETS^DIQ(DD,DA_",","*","",$Name(@XPDGREF))
 Do MES^XPDUTL(" Clinical Data Model successfully moved to KIDS transport global.")
 Quit
 ;
