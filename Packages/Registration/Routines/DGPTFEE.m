DGPTFEE ;ALB/MRY - PTF VistA/FPPS (create/delete) DRIVER ; 2/11/04 1:12pm
 ;;5.3;Registration;**605**;Aug 13, 1993
 ;
 Q
 ;
CREATE(DFN,DGDTTM,DGFLAG) ; create Fee PTF
 ;Input
 ;  DFN     := Patient ien
 ;  DGDTTM  := Date.Time
 ;  DGFLAG  := Fee patient flag (value is 1)
 ;
 ;Output
 ;  Y       := returns newly created PTF ien (successful)
 ;          or, -1 (unsuccessful, patient ien not defined)
 ;
 N Y
 I DGFLAG'=1 Q 0
 S Y=DGDTTM_"^"_DGFLAG
 D CREATE^DGPTFCR
 Q Y
 ;
DELETE(DFN,DGDTTM) ; Delete Fee PTF entry
 ;Input
 ;  DFN      := Patient ien
 ;  DGDTTM   := Date.Time
 ;
 ;Output
 ;  1 := delete successful, -1 := unsuccessful
 ;
 N DA,DIK
 S DA=$O(^DGPT("AFEE",DFN,DGDTTM,0))
 I $S('$G(DA):1,$D(^DGP(45.84,DA)):1,$D(^DGP(45.83,"C",DA)):1,1:0) G ERR
 S DIK="^DGPT(" D ^DIK
 Q 1
ERR Q -1
