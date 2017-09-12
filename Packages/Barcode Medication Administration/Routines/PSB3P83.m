PSB3P83 ;BIRMINGHAM/GN-Post install to save Inj to new Body list ;03/06/16 3:06pm
 ;;3.0;BAR CODE MED ADMIN;**83**;Mar 2004;Build 89
 ;Per VHA Directive 2004-038 (or future revisions regarding same), this routine should not be modified.
 ;
 ; Reference/IA
 ; $$GET^XPAR/2263
 ;
EN ;Copy a Divisions old PSB LIST INJECTION SITES to new BODY SITES
 ;
 N PARAM,ENT,QQ,SITE
 S PARAM=$O(^XTV(8989.51,"B","PSB ONLINE",""))   ;Online param ien
 ;
 ;Loop thru Kernel parameters for any Division with the parameter
 ; PSB ONLINE answered Y or N.  Nulls won't have an entry in "AC" xref
 S ENT=""
 F  S ENT=$O(^XTV(8989.5,"AC",PARAM,ENT)) Q:ENT=""  D
 .;
 .;loop thru all sites per Div per Old Inj list if it exists
 .F QQ=1:1 S SITE=$$GET^XPAR(ENT,"PSB LIST INJECTION SITES",QQ) Q:SITE=""  D
 ..;add sites to new list with new structure SiteText|flag|flag
 ..D EN^XPAR(ENT,"PSB LIST BODY SITES",QQ,SITE_"|1|0")
 .;
 .;remove all sites from old Inj list this ENT (Division)
 .D NDEL^XPAR(ENT,"PSB LIST INJECTION SITES")
 ;
 Q
