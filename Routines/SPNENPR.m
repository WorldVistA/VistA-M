SPNENPR ;;SD/CM- RETRIEVES ENROLLMENT PRIORITY; 6-27-02
 ;;2.0;Spinal Cord Dysfunction;**19**;01/02/97
 ;
START ;
 ;Returns ENROLLMENT PRIORITY from pt's current enrollment.
 ;If pt has a current ENROLLMENT PRIORITY, this function returns
 ;its value, otherwise it returns null.
 ;Used in the computed field ENROLLMENT PRIORITY of file 154.
FINDCUR(DFN) ;
 Q:'$G(DFN)
 N CUR
 S CUR=$P($G(^DPT(DFN,"ENR")),U)
 I CUR,$P($G(^DGEN(27.11,CUR,0)),U,2)'=DFN S CUR=""
 Q CUR
PR(DFN) ;
 N SPNNRIEN
 S SPNNRIEN=$$FINDCUR($G(DFN))
 Q:'SPNNRIEN ""
 Q $P($G(^DGEN(27.11,SPNNRIEN,0)),U,7)
