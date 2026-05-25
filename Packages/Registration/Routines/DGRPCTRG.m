DGRPCTRG ;ALB/BAJ,JAM - CONFIDENTIAL ADDRESS TRIGGER AXEE141 ;May 17, 2006
 ;;5.3;Registration;**653,1143**;Aug 13, 1993;Build 36
 ;;**653 BAJ May 1,2006 Modifications to Confidential address to support functionality moved
 ;;from EVC Release 2 to EVC Release 1
 ;; Reference to EVENT^IVMPLOG in ICR #2486
 Q
EECHG ; entry point
 ; this tag is called by a trigger in the CONFIDENTIAL ADDRESS CATEGORY FIELD (#2.141)
 ; If the ELIGIBILITY/ENROLLMENT Category has been added, changed, or deleted, X will equal 1
 ; A Z07 must be sent anytime the E/E Category is modified on a confidential address
 Q:'$G(DFN)
 ; DG*5.3*1143 - For Real-Time address updates, pass 2nd parameter to ^IVMPLOG for RTA or HL7 processing
 I X=1 D EVENT^IVMPLOG(DFN,1)
 Q
EECONF(DFN) ; used to identify E/E Confidential Category
 ; This tag is called by all Confidential Address fields and files a Z07 message if true:
 ; I $$EECONF^DGRPCTRG(DFN) D EVENT^IVMPLOG
 ;
 ; if there is no active E/E Category on file for this Confidential Address, return 0
 N ISEE,ACT
 S ISEE=0
 I '$G(DFN) Q ISEE
 I '$D(^DPT(DFN,.14,"B",1)) Q ISEE
 S ACT=+$O(^DPT(DFN,.14,"B",1,""))
 S ISEE=$P(^DPT(DFN,.14,ACT,0),U,2)="Y"
 Q ISEE
