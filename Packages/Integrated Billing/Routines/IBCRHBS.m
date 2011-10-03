IBCRHBS ;ALB/ARH - RATES: UPLOAD HOST FILES (RC 2+) DRIVER ; 10-OCT-03
 ;;2.0;INTEGRATED BILLING;**245**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
 ; called from IBCRHBR to process RC v2.0+ versions
RC ;
 I IBLOAD=1 S IBLOAD=$$HOSTLOAD^IBCRHBS1(IBVERS) I 'IBLOAD Q
 ;
 S IBSITE=$$SELSITE^IBCRHBS4 I 'IBSITE Q
 ;
 D CALCRC^IBCRHBS5(IBSITE)
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
 ; IBCR RC A:  Inpatient DRG and SNF Per Diem Charges, same format/fields as Host File
 ; IBCR RC B:  Facility CPT Charges, same format/fields as Host File
 ; IBCR RC C:  Professional CPT Charges, same format/fields as Host File
 ; IBCR RC D:  Service Category Codes, same format/fields as Host File
 ; IBCR RC E:  Area Factor File, same format/fields as Host File
 ; IBCR RC F:  Division/Zip File, same format/fields as Host File
 ;
 ;
2 ;site file created from all national area factor files
 ;
 ; IBCR RC SITE: site number ^ site name, state ^ 3-digit zip ^ type (if VA division)
 ; IBCR RC SITE, source file: source ifn
 ; IBCR RC SITE, VERSION: version number
 ; IBCR RC SITE, VERSION INACTIVE: version inactive date
 ;
3 ;all XTMP files read by CM utility
 ;
 ; IBCR UPLOAD site, 0: Upload Date + 2 ^ Upload Date ^ Name/Description ^ Item Count
 ; IBCR UPLOAD site, Charge Group: Item Count ^ Billable Item ^ Charge Set
 ; IBCR UPLOAD site, Charge Group, x: item ptr ^ effective date ^ inactive date ^ charge ^ modifier (i) ^ base
 ;
4 ;all updates due to a new version are in routine IBCRHBRV
 ;
 ; ==============================================================================================
 ;
