MDPOST91 ;HPS/CW - Post Installation Tasks ; 9/11/19 8:38am
 ;;1.0;CLINICAL PROCEDURES;**91**;Apr 01, 2004;Build 5
 ;;Per VA Directive 6402, this routine should not be modified..
 ;
 ; This routine uses the following IAs:
 ; IA# 10141  MES^XPDUTL      Kernel
 ; IA# 2263 [Supported] XPAR Utilities
 ;
 Q
EN ; Post installation tasks to bring Legacy CP up to snuff
 ;
 D BMES^XPDUTL(" Setting CP web link")
 D EN^XPAR("SYS","MD WEBLINK",1,$$URL())
 ;
 K MDK,MDKLST
 D BMES^XPDUTL(" MD*1.0*91 Post Init complete")
 ;
 Q
 ;
URL() ; [Function] Return Clinical Procedures Homepage URL
 Q "dvagov.sharepoint.com/sites/oitspmhspcsclinproc"
 ;Q "dvagov.sharepoint.com/sites/OITEPMOClinicalProcedures/SitePages/Home.aspx"
 ;
 Q 
