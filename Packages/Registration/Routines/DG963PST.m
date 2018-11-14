DG963PST ;BIR/JFW-PATCH DG*5.3*963 POST INSTALLATION ROUTINE ;4/26/18
 ;;5.3;Registration;**963**;Aug 13, 1993;Build 1
 ;
 ; - Story 718515 (jfw)
 ;    Update the DESCRIPTION(s) in the SUPPORTING DOCUMENTATION TYPES
 ;    (#47.75) File for the following entries:
 ;      - UNDER VA AUSPICES
 ;      - EVVE CERTIFICATION
 ;      - EVVE FACT OF DEATH QUERY
 ;
 ; IA's:
 ;  BMES^XPDUTL - Supported #10141
 ;  MES^XPDUTL  - Supported #10141
 ;  WP^DIE      - Supported #2053
 ;
POST ;Post Init process to modify File #47.75
 D BMES^XPDUTL("Post-Install:")
 D SUPPDOC  ;Supporting Documentation Description Update
 D BMES^XPDUTL("Post-Install: Finished")
 Q
 ;
 ;Modify the DESCRIPTIONs for the following TYPE CODEs in the
 ;SUPPORTING DOCUMENTATION TYPES File (#47.75):
 ;     -   EC : EVVE CERTIFICATION
 ;     - EFDQ : EVVE FACT OF DEATH QUERY
 ;     -  UVA : UNDER VA AUSPICES
SUPPDOC ;
 N DGI,DGDOCODES,DGLOC,DGTCODE
 S DGLOC="^TMP($J,""DESC"")"
 D BMES^XPDUTL("  Updating DESCRIPTIONS in SUPPORTING DOCUMENTATION TYPES File (#47.75)")
 D MES^XPDUTL("")
 S DGDOCODES="EC,EFDQ,UVA"
 F DGI=1:1:$L(DGDOCODES,",")  D
 .K @DGLOC
 .S DGTCODE=$P(DGDOCODES,",",DGI)
 .D GWPDATA(DGTCODE,$NA(@DGLOC))  ;Get Description Data
 .D WPUPDT(47.75,50,$O(^DG(47.75,"C",DGTCODE,"")),DGLOC)
 K @DGLOC
 Q
 ;
 ;Retrieve the Word Processing Supporting Document Type
 ;Description for the specified type code entry.
 ;  TYPE  - Supporting Document Type Code
 ;  DGLOC - Location to Store Type Data In
GWPDATA(DGTYPE,DGLOC) ;
 N DGDATA,DGLINE,DGEXIT,DGNODE
 S DGEXIT=0,DGNODE=1
 F DGLINE=2:1 S DGDATA=$P($T(SDTDATA+DGLINE),";",3,$L($T(SDTDATA+DGLINE),";")) Q:(DGDATA=""!DGEXIT)  D
 .;Ignore entry if NOT passed TYPE, but set exit condition
 .;if TYPE already processed to short circuit loop.
 .I $P(DGDATA,"^")'=DGTYPE D  Q
 ..S:($D(@DGLOC)) DGEXIT=1
 .S @DGLOC@(DGNODE)=$P(DGDATA,"^",2),DGNODE=DGNODE+1
 Q
 ;
 ;Update Word Processing (WP) field in File with Data
 ;  DGFILE - File where Record resides to update (REQ)
 ;  DGFLD  - Field in File to update (REQ)
 ;  RECNUM - Record Number in File to update (REQ)
 ;  DATA   - Location of WP DATA (REQ)
WPUPDT(DGFILE,DGFLD,RECNUM,DATA) ;
 N DGERR
 D WP^DIE(DGFILE,RECNUM_",",DGFLD,"K",DATA,"DGERR")
 I ($D(DGERR)) D
 .D MES^XPDUTL("    *** '"_$P(^DG(47.75,RECNUM,0),"^")_"' DESCRIPTION NOT updated.")
 .D MES^XPDUTL("         !!! Execute POST-INSTALL again from command line (D POST^DG963PST)")
 D:('$D(DGERR)) MES^XPDUTL("    *** '"_$P(^DG(47.75,RECNUM,0),"^")_"' DESCRIPTION updated.")
 Q
 ;
SDTDATA ; Supporting Documentation Type Description Data Updates
 ; FORMAT: SUPPORTING DOCUMENT TYPE CODE ^ DOCUMENT DESCRIPTION
 ;;EC^Requires receipt of a successful identity match confirming a previously 
 ;;EC^established Date of Death via the EVVE Death Certification Query. 
 ;;EC^Retention of electronic or hard copy documentation of the death 
 ;;EC^certification is required. (Currently available via the EVVE pilot 
 ;;EC^program only)
 ;;EFDQ^Requires receipt of a successful identity match providing the confirmed 
 ;;EFDQ^Date of Death via one of the three search functions available within EVVE 
 ;;EFDQ^Fact of Death Query:  1) Insurance Regulatory Settlement Agreement, 2) 
 ;;EFDQ^SSN Exact Match, 3) Custom.  Retention of electronic or hard copy 
 ;;EFDQ^documentation of the returned data is required.  (Currently available via 
 ;;EFDQ^the EVVE pilot program only)
 ;;UVA^Deaths under VA auspices include deaths where the VA receives a medical 
 ;;UVA^record from a non-VA provider documenting a death that occurs while the 
 ;;UVA^non-VA provider was furnishing authorized non-VA care; deaths occurring 
 ;;UVA^in a contract nursing home (i.e., a nursing home under contract with the 
 ;;UVA^VA to care for the individual); or deaths during a home visit when a VA 
 ;;UVA^provider is present. Documentation of the death should be received from 
 ;;UVA^the non-VA provider or VA provider and entered into the persons record.
 ;;
