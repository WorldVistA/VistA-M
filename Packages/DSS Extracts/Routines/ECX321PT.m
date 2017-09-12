ECX321PT ;ALB/JAP - PATCH ECX*3*21 Post-Install ; February 26, 1999
 ;;3.0;DSS EXTRACTS;**21**;Dec 22, 1997
 ;
POST ;Entry point
 ;place PRO audit report option back in service
 N A,DIC,DIE,DA,DR,X,Y,IENS,ECX,ECXX
 K ^TMP($J,"WP")
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" ")
 D MES^XPDUTL("Removing 'Out of order' flag from")
 D MES^XPDUTL("[ECX PRO SOURCE AUDIT] option.")
 D MES^XPDUTL(" ")
 S DIC="^DIC(19,",DIC(0)="X",X="ECX PRO SOURCE AUDIT"
 D ^DIC
 Q:Y=-1
 S A="",DA=+Y,DIE=DIC,DR="2///@"
 D ^DIE
 ;update audit description in PRO extract definition record
 K Y S DIC="^ECX(727.1,",DIC(0)="X",X="PROSTHETICS"
 D ^DIC
 I Y=-1 D  Q
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL("Can't find PROSTHETICS in EXTRACT DEFINITIONS file")
 .D MES^XPDUTL("(#727.1) -- AUDIT DESCRIPTION not updated.")
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL(" ")
 F ECX=1:1 S ECXX=$P($T(TEXT+ECX),";;",2) Q:ECXX="QUIT"  S ^TMP($J,"WP",ECX,0)=ECXX
 S IENS=+Y_","
 D WP^DIE(727.1,IENS,10,"","^TMP($J,""WP"")","ERR")
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" ")
 D MES^XPDUTL("PROSTHETICS record in EXTRACT DEFINITIONS file")
 D MES^XPDUTL("(#727.1) has been successfully updated.")
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" ")
 K ^TMP($J,"WP")
 Q
 ;
TEXT ;
 ;; The following PROSTHETICS package options may be used to verify the PRO
 ;; extract audit report.
 ;;  
 ;; RMPR NPPD PRT          Print NPPD Worksheets
 ;; RMPR NPPD PRL L        Print NPPD Single Line Detail
 ;;   
 ;; Please note, however, that these Prosthetics package options organize
 ;; and display data by the ENTRY DATE field (#.01) of the Prosthetics 
 ;; items in its RECORD OF PROS APPLIANCE/REPAIR file (#660).  The PRO
 ;; extract record does not use the ENTRY DATE.  Instead, it uses the
 ;; DELIVERY DATE (field #10) of the Prosthetic item.  Therefore, the PRO
 ;; extract audit report organizes and displays data by DELIVERY DATE.
 ;;  
 ;; Because of this date difference, the user may see many discrepancies 
 ;; between the PRO extract audit report and the PROSTHETICS package NPPD
 ;; reports.  This will be particularly true for large, high cost items 
 ;; which are ordered far in advance of actual delivery date.  The DSS 
 ;; program office has requested that PROSTHETICS provide an NPPD report 
 ;; which is sorted by DELIVERY DATE rather than ENTRY DATE to facilitate 
 ;; this validation process.
 ;;  
 ;; A PRO extract audit report can be printed in SUMMARY or in DETAIL.
 ;; The SUMMARY report displays data by NPPD line item, while the DETAIL
 ;; report shows a breakout of data contained in a specific line item. 
 ;; The following shows each NPPD category and the line items it contains:
 ;;   
 ;; 1.   WHEELCHAIRS AND ACCESSORIES
 ;;  
 ;;      100 A   MOTORIZED
 ;;      100 A1  SCOOTERS
 ;;      100 B   MANUAL CUSTOM
 ;;      100 C   MANUAL A/O
 ;;      100 D   ACCESSORIES
 ;;      100 E   CUSHION FOAM
 ;;      100 F   CUSHION SPEC
 ;;   
 ;; 2.   ARTIFICAL LEGS
 ;;  
 ;;      200 A   LEG IPOP
 ;;      200 B   LEG TEM
 ;;      200 C   LEG PART FOOT
 ;;      200 E   LEG SYMES
 ;;      200 F   LEG B/K
 ;;      200 G   LEG A/O
 ;;      200 H   LEG A/K
 ;;  
 ;; 3.   ARTIFICAL ARMS AND TERMINAL DEVICES
 ;;  
 ;;      300 A   ARM B/E
 ;;      300 B   ARM, A/E
 ;;      300 C   COSMETIC GLOVES
 ;;      300 D   ARM, A/O
 ;;      300 E   TERMINAL DEVICES
 ;;      300 F   EXT. POWERED,ARM
 ;;  
 ;; 4.   BRACES AND ORTHOTICS
 ;;  
 ;;      400 A   BRACE ANKLE
 ;;      400 B   BRACE LEG AK
 ;;      400 C   BRACE, SPINAL
 ;;      400 D   BRACE AL/OTH
 ;;      400 E   ELAS HOSE, EA
 ;;      400 F   BRACES, KNEE
 ;;      400 G   CORSET/BELT
 ;;  
 ;; 5.   SHOES/ORTHOTICS
 ;;  
 ;;      500 A   ARCH SUPT, EA
 ;;      500 B   SHOE INLAY, EA
 ;;      500 C   SHOE MOLDED, EA
 ;;      500 D   SHOE ORTH OTH
 ;;      500 E   INSERTS, SHOE
 ;;      500 F   SHOES A/O, EA
 ;;  
 ;; 6.   NEUROSENSORY AIDS
 ;;   
 ;;      600 1   EYEGLASSES PR
 ;;      600 A   SP OVER 2,500
 ;;      600 B   HEARING AIDS
 ;;      600 C   AID FOR BLIND
 ;;      600 D   CONT LENS, EA.
 ;;      600 E   EAR INSERT
 ;;  
 ;; 7.   RESTORATIONS
 ;;  
 ;;      700 A   EYE
 ;;      700 B   FACIAL
 ;;      700 C   BODY, OTHER
 ;;  
 ;; 8.   OXYGEN AND RESPIRATIORY
 ;;  
 ;;      800 A   OXYGEN EQP
 ;;      800 B   OXYGEN CONCEN
 ;;      800 C   OXYGEN GAS
 ;;      800 D   OXYGEN, SUPPLIES
 ;;      800 E   OXYGEN LIQUID
 ;;      800 F   VENTILATOR, A/O
 ;;  
 ;; 9.   MEDICAL EQUIPMENT, MISC., ALL OTHER NEW
 ;;  
 ;;      900 A   WALKING AIDS
 ;;      900 B   INVALID LIFT
 ;;      900 C   BED HOSP STD
 ;;      900 D   BED HOSP SPEC
 ;;      900 E   MATTRESS STAN
 ;;      900 F   MATTRESS SPEC
 ;;      900 G   BED, ACCESSORIES
 ;;      900 H   ENVIRON CONTR
 ;;      900 I   SPEC HOME EQP (SAFETY)
 ;;      900 J   TENS UNIT
 ;;      900 K   MED EQP AL/OTH
 ;;      900 L   EQP RENTAL
 ;;      910 A   MED SUP AL/OTH
 ;;      920 A   HOME DIAL EQP
 ;;      920 B   HOME DIAL SUP
 ;;      930 A   MOD VANS
 ;;      930 B   ADAPT EQP AL/OTH
 ;;      999 A   AL/OTH ITEMS
 ;;      999 X   HCPCS NOT GRP
 ;;      999 Z   NO HCPCS
 ;;  
 ;; 10.  REPAIR
 ;;  
 ;;      R10     WHEELCHAIR
 ;;      R20 A   LEG A/K
 ;;      R20 B   LEG B/K, PTB
 ;;      R20 C   LEG B/K, STD
 ;;      R20 D   LEG ALL OTHER
 ;;      R30     ART ARM,TOTAL
 ;;      R40     BRACE TOTAL
 ;;      R50 A   ORTH SHOE ALL
 ;;      R50 B   SHOE MOD
 ;;      R50 C   A/O ITEM SERV
 ;;      R60 A   AID FOR BLIND
 ;;      R60 B   EYEGLASS RPR
 ;;      R60 C   HEARING AID
 ;;      R70     HOME DIAL EQU
 ;;      R80 A   INVALID LIFTS
 ;;      R80 B   REPAIR TO ECU
 ;;      R80 C   MED EQUIP A/O
 ;;      R90     ALL OTHER
 ;;      R90 A   SHIPPING
 ;;      R99 X   HCPCS NOT GRP
 ;;      R99 Z   NO HCPCS
 ;;   
 ;; Compare a SUMMARY report to the Print NPPD Worksheets report of the
 ;; PROSTHETICS package.  Compare a DETAIL report to the Print NPPD Single
 ;; Line Detail report of the PROSTHETICS package.  In spite of the date
 ;; problem indicated above, the user should usually specify the same date
 ;; range for both the PRO extract audit report and its related NPPD 
 ;; report.  This date range will generally be a one month period which
 ;; covers the first day through the last day of a given month.
 ;;   
 ;; However, it may be useful under certain conditions to vary the date 
 ;; range when comparing DETAIL from the PRO extract audit report with an
 ;; NPPD single line report.  For example, if it is known that for some
 ;; complex Prosthetics items (e.g., artificial limbs) the order date 
 ;; normally precedes delivery date by about 90 days, and if you wish to
 ;; verify January PRO extract data, then --
 ;;  
 ;; (a) generate a DETAIL display for the appropriate NPPD line item
 ;;     category (e.g., 200 A, LEG IPOP) from a PRO extract audit report 
 ;;     which covers a date range of January 1 through January 31;
 ;;  
 ;; (b) generate an NPPD single line detail report for that same line
 ;;     item for a date range of October 1 through October 31.
 ;;   
 ;; The NPPD single line report for October may coincide quite well
 ;; with the PRO extract audit report DETAIL for January. 
 ;;  
 ;; A further note for sites that are multi-divisional for PROSTHETICS.
 ;; ===================================================================
 ;;  
 ;;    A multi-divisional Prosthetics site can print NPPD data reports
 ;;    for only ONE division at a time.  The PRO extract audit report
 ;;    may be printed for a single division or for an entire facility.
 ;;  
 ;;    To compare the PRO extract audit report with the PROSTHETICS 
 ;;    package NPPD report, the user must select the same division for
 ;;    both reports.  Or the user may generate a PRO extract audit
 ;;    report for the entire facility and compare its data to the sum
 ;;    of the data from each of the single division NPPD reports.
 ;;QUIT
