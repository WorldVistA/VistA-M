IBCRHBR ;ALB/ARH - RATES: UPLOAD HOST FILES (RC) DRIVER ; 10-OCT-1998
 ;;2.0;INTEGRATED BILLING;**106,138,148,245**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
RC N IBLOAD,IBSITE,IBVERS
 W @IOF,!,"Upload National Reasonable Charges Host Files to Temporary Vista Files (XTMP)"
 W !,"-----------------------------------------------------------------------------"
 ;
 I '$$CONT^IBCRHBR5 Q
 ;
 S IBLOAD=$$RELOAD^IBCRHBR1 I IBLOAD<0 Q
 ;
 I IBLOAD=1 S IBVERS=$$SELVERS^IBCRHBRV Q:'IBVERS
 ;
 I ($G(IBVERS)>1.9)!($$VERSION^IBCRHBRV>1.9) G ^IBCRHBS
 ;
 I IBLOAD=1 S IBLOAD=$$HOSTLOAD^IBCRHBR1(IBVERS) I 'IBLOAD Q
 ;
 S IBSITE=$$SELSITE^IBCRHBR4 I 'IBSITE Q
 ;
 D CALCRC^IBCRHBR5(IBSITE)
 ;
 Q
 ;
 ;
 ; ==============================================================================================
 ;
1 ;XTMP version of national files of all charges and area factors
 ;
 ; IBCR RC x,0: delete date ^ create date ^ name, date/time, by ^ ?? ^ count
 ;
 ; IBCR RC A:  DRG ^ surg/non-surg ^ rm&bd ^ anc ^ begin ^ end
 ;             999 ^  ^ charge ^ ^ begin ^ end
 ; IBCR RC B:  site number ^ surg rm&bd ^ surg anc ^ non-surg rm&bd ^ non-surg anc ^ skilled nursing ^ begin ^end
 ;
 ; IBCR RC C:  CPT ^ charge ^ begin ^ end ^ site limited
 ; IBCR RC D:  site number ^ area factor ^ begin ^ end ^ site limited
 ;
 ; IBCR RC E: CPT ^ modifier ^ work expense ^ practice expense ^ code group ^ conversion factor ^ begin ^ end
 ;
 ; IBCR RC F: CPT ^ modifier ^ charge ^ code group ^ begin ^ end
 ;
 ; IBCR RC G: CPT ^ modifier ^ unit value ^ code group ^ conversion factor ^ begin ^ end
 ;
 ; IBCR RC H: site number ^ work adjuster ^ work expense ^ practice expense ^ begin ^ end
 ; IBCR RC H, BC: code group area factors
 ;
 ; IBCR RC I: site number ^ area factor ^ begin ^ end
 ;
2 ;site file created from all national area factor files
 ;
 ; IBCR RC SITE: site number ^ site name, state ^ 3-digit zip
 ; IBCR RC SITE, source file: source ifn
 ; IBCR RC SITE, VERSION: version number
 ;
3 ;all XTMP files read by CM utility
 ;
 ; IBCR RC site: item ptr ^ effective date ^ inactive date ^ charge ^ modifier ^ base (2.0+)
 ;
4 ;all updates due to a new version are in routine IBCRHBRV
 ;
 ; ==============================================================================================
 ;
 ;
CGROUP ; set up code group array needed when calculating charges
 N IBI,IBLN
 F IBI=1:1 S IBLN=$P($T(CGROUPF+IBI),";;",2) Q:IBLN=""  I +IBLN D
 . S ^TMP($J,"IBCR RC CGROUP",$P(IBLN,U,2))=+IBLN
 Q
CGROUPF ; list of valid Code Groups and their corresponding piece in the area factor file (table h)
 ;; 
 ;;5^Allergy Immunotherapy
 ;;4^Allergy Testing
 ;;21^Anesthesia
 ;;10^Cardiovascular
 ;;16^Chiropractor
 ;;8^Consults
 ;;7^Emer Room Visits and Observation Care
 ;;14^Hearing/Speech Exams
 ;;11^Immunizations
 ;;1^Inpatient Visits
 ;;23^Maternity - Cesarean Deliveries
 ;;24^Maternity - Non-Deliveries
 ;;22^Maternity - Normal Deliveries
 ;;6^Miscellaneous Medical
 ;;2^Office/Home/Urgent Care Visits
 ;;17^Outpatient Psych/Alcohol & Drug Abuse
 ;;20^Pathology
 ;;15^Physical Exams
 ;;9^Physical Medicine
 ;;19^Radiology
 ;;18^Surgery
 ;;3^Therapeutic Injections
 ;;13^Vision Exams
 ;;12^Well Baby Exams
 ;;
