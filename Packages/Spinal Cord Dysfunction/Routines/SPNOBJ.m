SPNOBJ ;SD/CM- OBJECTS FROM SCD REGISTRY; 1-27-2003
 ;;2.0;Spinal Cord Dysfunction;**20,23**;01/02/97
MAR(DFN) ;Marital Status
 ;Populate Object Method with: S X=$$MAR^SPNOBJ(DFN)
 S X=$P($G(^DPT(DFN,0)),U,5) S X="Marital Status: "_$S(X:$P(^DIC(11,X,0),U,1),1:"No data available") Q X
 Q
 ;
RSTAT(DFN) ;Registration Status in SCD Registry
 ;Populate Object Method with: S X=$$RSTAT^SPNOBJ(DFN)
 S X=$P($G(^SPNL(154,DFN,0)),U,3) S X="Registration Status: "_$S(X=0:"NOT SCD",X=1:"SCD - CURRENTLY SERVED",X=2:"SCD - NOT CURRENTLY SERVED",X="X":"EXPIRED",1:"No data available") Q X
 Q
 ;
VASCI(DFN) ;VA SCI Status
 ;Populate Object Method with: S X=$$VASCI^SPNOBJ(DFN)
 S X=$P($G(^SPNL(154,DFN,2)),U,6) S X="VA SCI Status: "_$S(X=1:"PARAPLEGIA-TRAUMATIC",X=2:"QUADRIPLEGIA-TRAUMATIC",X=3:"PARAPLEGIA-NONTRAUMATIC",X=4:"QUADRIPLEGIA-NONTRAUMATIC",X="X":"NOT APPLICABLE",1:"No data available") Q X
 Q
 ;
SCILEV(DFN) ;SCI Level
 ;Populate Object Method with: S X=$$SCILEV^SPNOBJ(DFN)
 S X=$P($G(^SPNL(154,DFN,2)),U,1) S X="SCI Level: "_$S(X:$P(^SPNL(154.01,X,0),U,1),1:"No data available") Q X
 Q
 ;
LOFF(DFN) ;Last Annual Eval Offered
 ;Populate Object Method with: S X=$$LOFF^SPNOBJ(DFN)
 S X=$O(^SPNL(154,DFN,"REHAB","B"," "),-1) S X="Last Annual Eval Offered: "_$S(X:$$FMTE^XLFDT(X,"5DZP"),1:"No data available") Q X
 Q
 ;
EP(DFN) ;Enrollment Priority
 ;Populate Object Method with: S X=$$EP^SPNOBJ(DFN)
 N SPNNRIEN
 S SPNNRIEN=$$FINDCUR^SPNENPR($G(DFN)) I '+SPNNRIEN S X="No data available" Q "Enrollment Priority: "_X
 S X="GROUP "_$P($G(^DGEN(27.11,SPNNRIEN,0)),U,7) Q "Enrollment Priority: "_X
 Q
 ;
EXTNT(DFN) ;Extent of SCI
 ;Populate Object Method with: S X=$$EXTNT^SPNOBJ(DFN)
 S X=$P($G(^SPNL(154,DFN,6)),U,9) S X="Extent of SCI: "_$S(X="C":"COMPLETE",X="I":"INCOMPLETE",1:"No data available") Q X
 Q
ETIOL(DFN) ;Etiology.  Returns etiologies
 ;Populate Object Method with: S X=$$EN^SPNETOBJ(DFN)
 S X=$$EN^SPNETOBJ(DFN) Q "Etiologies:"_X
 Q
PCPROV(DFN) ;Primary Care Provider
 ;Populate Object Method with: S X=$$PCPROV^SPNOBJ(DFN)
 S X=$S($L($$GET1^DIQ(154,DFN,8.1))>1:$$GET1^DIQ(154,DFN,8.1),1:"No data available") Q "Primary Care Provider: "_X
 Q
SCDCOOR(DFN) ;SCD Coordinator
 ;Populate Object Method with: S X=$$SCDCOOR^SPNOBJ(DFN)
 S X=$S($L($$GET1^DIQ(154,DFN,8.2))>1:$$GET1^DIQ(154,DFN,8.2),1:"No data available") Q "SCD Coordinator: "_X
 Q
REMARKS(DFN) ;Remarks
 ;Populate Object Method with: S X=$$REMARKS^SPNOBJ(DFN)
 S X=$S($L($$GET1^DIQ(154,DFN,11))>1:$$GET1^DIQ(154,DFN,11),1:"No data available") Q "Remarks: "_X
 Q
MSSUBT(DFN) ;Multiple Sclerosis (MS) Sub Type
 ;Populate Object Method with: S X=$$MSSUBT^SPNOBJ(DFN)
 S X=$S($L($$GET1^DIQ(154,DFN,2.2))>1:$$GET1^DIQ(154,DFN,2.2),1:"No data available") Q "Multiple Sclerosis Sub Type: "_X
 Q
LREC(DFN) ;Last Annual Evaluation Received
 ;Populate Object Method with: S X=$$LREC^SPNOBJ(DFN)
 S X=$$GET1^DIQ(154,DFN,999.07) D ^%DT
 S X=$S(Y'=-1:$$FMTE^XLFDT(Y,"5DZP"),1:"No data available") Q "Last Annual Eval Received: "_X
 Q
BCREIMB(DFN) ;Bowel Care Reimbursement
 ;Populate Object Method with: S X=$$BCREIMB^SPNOBJ(DFN)
 S X=$S($L($$GET1^DIQ(154,DFN,10.1))>1:$$GET1^DIQ(154,DFN,10.1),1:"No data available") Q "Bowel Care Reimbursement: "_X
 Q
BCDC(DFN) ;Bowel Care Date Certified
 ;Populate Object Method with: S X=$$BCDC^SPNOBJ(DFN)
 S X=$$GET1^DIQ(154,DFN,10.2) D ^%DT
 S X=$S(Y'=-1:$$FMTE^XLFDT(Y,"5DZP"),1:"No data available") Q "Bowel Care Date Certified: "_X
 Q
BCPROV(DFN) ;Bowel Care Provider
 ;Populate Object Method with: S X=$$BCPROV^SPNOBJ(DFN)
 S X=$S($L($$GET1^DIQ(154,DFN,10.3))>1:$$GET1^DIQ(154,DFN,10.3),1:"No data available") Q "Bowel Care Provider: "_X
 Q
