DG53164P ;ABR/ALB - POST-INIT FOR PTF/MAS 43 Y2K ; 5 JAN 1998
 ;;5.3;Registration;**164**;Aug 13, 1993
 ;
 ;  This routine updates the FY entries in the MAS PARAMETERS file (#43) to
 ;  make them Y2K compatible.  All 2-digit FYs have been changed to the 
 ;  FileMan 3-digit entry (e.g. '91' becomes '291')
 ;
 ;
 ;  This routine may be re-run.
 ;
EN ; POST-INSTALL ENTRY POINT
 D FYUP
 Q
FYUP ; change  FY nodes to FM FY references
 N FY,FMFY
 D BMES^XPDUTL(">> Updating FY nodes for Year 2000 compatibility.")
 F FY=0:0 S FY=$O(^DG(43,1,"FY",FY)) Q:'FY!(FY>200)  D
 . S FMFY=$S(FY>500:FY,1:(FY+200)_"0000")
 . S ^DG(43,1,"FY",FMFY,0)=FMFY_U_$P(^DG(43,1,"FY",FY,0),U,2,99)
 . I FY'=FMFY K ^DG(43,1,"FY",FY)
 S:$G(FMFY) $P(^DG(43,1,"FY",0),U,3)=FMFY
 Q
PTFADMTX ; delete output transform for field 2, file 45.
 Q
 K ^DD(45,2,2),^(2.1)
 D BMES^XPDUTL(">> Deleting unused Output Transform on ADMISSION DATE, PTF file.")
