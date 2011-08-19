ICPTSUPT ;SLC/KER - CPT SUPPORT FOR APIS ; 04/18/2004
 ;;6.0;CPT/HCPCS;**14,19**;May 19, 1997
 ;
 ; External References
 ;   DBIA  10103  $$DT^XLFDT
 ;                     
EFF(FILE,CODE,EDT) ; Returns Effective Date and Status for Code/Modifier
 ; Input:
 ;    FILE = file number  REQUIRED
 ;           81 for CPT file
 ;           81.3 for CPT MODIFIER file
 ;    CODE = CPT CODE ien or CPT MODIFIER ien REQUIRED
 ;    EDT = date to check for (FileMan format) (default = today)
 ;
 ; Output:    effective date^status^Inactivation Date^Active Date
 ;          where STATUS = 1 = active
 ;                         0 = inactive  
 ;          or -1^error message
 ;
 ; Variables:
 ;   EFILE = indirect file reference for code
 ;   EFF,EFFDT,EFFDOS = effective dates
 ;   EFFN = sub-entry ien
 ;   EFFST = effective status
 ;   STR = output
 ;
 I $G(FILE)="" Q "-1^NO FILE SELECTED"
 I '(FILE=81!(FILE=81.3)) Q "-1^INVALID FILE"
 I $G(CODE)="" Q "-1^NO "_$S(FILE=81:"CODE",1:"MODIFIER")_" SELECTED"
 N EFILE,EFF,EFFN,STR,EFFDT,EFFST,EFFB,EFFDOS
 S EFILE=$S(FILE=81:"^ICPT(",1:"^DIC(81.3,")_CODE_",60,"
 S EDT=$S($G(EDT)="":$$DT^XLFDT,1:$$DTBR(EDT))+.001 ;date business rules
 S EFF=$O(@(EFILE_"""B"","_EDT_")"),-1)
 I 'EFF Q "^0^^"
 S EFFN=$O(@(EFILE_"""B"","_EFF_",0)")) ; node 60 (effective date) sub-entry
 S STR=$G(@(EFILE_EFFN_",0)"))
 I STR="" Q "^0^^"
 ;set Opposite eff. date based on status
 S EFFDT=$P(STR,"^"),EFFST=$P(STR,"^",2),EFFB=0,EFF=+EFF
 F  S EFF=$O(@(EFILE_"""B"","_EFF_")"),-1) Q:'EFF!EFFB  D
 . S EFFN=$O(@(EFILE_"""B"","_EFF_",0)")) I 'EFFN S EFFB=1 Q
 . S EFFDOS=$G(@(EFILE_EFFN_",0)")) I 'EFFDOS S EFFB=1 Q
 . S EFFB=(EFFST'=$P(EFFDOS,"^",2))
 S EFFDOS=$P($G(EFFDOS),"^")
 I EFFST S $P(STR,"^",3,4)=(EFFDOS)_"^"_EFFDT
 E  S $P(STR,"^",3,4)=EFFDT_"^"_(EFFDOS)
 Q STR
 ;
DTBR(CDT) ; Date Business Rules
 ; Input:
 ;   CDT - Code Date to check (FileMan format, default=Today)
 ;
 ; Output:
 ;   If CDT < Bus.RuleDflt., use Bus.RuleDflt.
 ;   If CDT is year only, use first of the year
 ;   If CDT is year and month only, use first of the month
 ;
 Q:'$G(CDT) $$DT^XLFDT ;nothing passed - use today
 Q:$L($P(CDT,"."))'=7 $$DT^XLFDT ;bad format - use today
 I CDT#10000=0 S CDT=CDT+101
 S:CDT#100=0 CDT=CDT+1
 Q $S(CDT<2890101:2890101,1:CDT)
 ;
MSG(CDT,CS)     ; Inform of Code Text Inaccuracy
 ;
 ; Input:
 ;
 ;   CDT - Code Date to check (FileMan format, Default = today)
 ;   CS - Code System (0:ICD, 1:CPT/HCPCS, 2:DRG, 3:LEX, Default=0)
 ;
 ; Output: User Alert
 ;
 S CS=+$G(CS) S:CS>3!(CS<0) CS=0
 S CDT=$S($G(CDT)="":$$DT^XLFDT,1:$$DTBR(CDT))
 N MSGTXT,MSGDAT S MSGDAT=3021001,MSGTXT="CODE TEXT MAY BE INACCURATE"
 I CS<3 Q $S(CDT<MSGDAT:MSGTXT,1:"")
 I CS=3,CDT'<3031001 Q ""
 Q MSGTXT
 ;
GBL(CODE) ; return Global Node of Code
 Q:CODE?5N!(CODE?1U4N)!(CODE?4N1U) "^ICPT("
 Q:CODE?2N!(CODE?2U)!(CODE?1U1N) "^DIC(81.3,"
 Q ""
 ;
