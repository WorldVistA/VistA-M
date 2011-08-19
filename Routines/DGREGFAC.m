DGREGFAC ;BAY/JT; 12/18/03 8:16am ; 12/18/03 9:55am
 ;;5.3;Registration;**574**;Aug 13, 1993
DIVCHK(DFN,DFN1) ; call to validate 'facility applying to' (division)
 ; DFN = ien of patient file
 ; DFN1 = ien of Disposition multiple
 ; returns 1 if division is inactive, 0 otherwise
 ;
 N DGDIV,DGINST
 I '$G(DFN)!('$G(DFN1)) Q 0
 ; site not multi-divisional
 I $P($G(^DG(43,1,"GL")),U,2)=0 Q 0
 ; determine division chosen
 S DGDIV=$P($G(^DPT(DFN,"DIS",DFN1,0)),U,4)
 I DGDIV'>0 Q 0
 ; division has no pointer to Institution file
 I $P($G(^DG(40.8,DGDIV,0)),U,7)'>0 Q 1
 S DGINST=$P($G(^DG(40.8,DGDIV,0)),U,7)
 ; Institution file is inactive
 I $P($G(^DIC(4,DGINST,99)),U,4)=1 Q 1
 Q 0
