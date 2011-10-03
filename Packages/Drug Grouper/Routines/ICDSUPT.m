ICDSUPT ;DLS/DEK - ICD SUPPORT FOR APIS ; 04/28/2003
 ;;18.0;DRG Grouper;**6**;Oct 20, 2000
 ;
 ; External References
 ;   DBIA 10103  $$DT^XLFDT
 ;
EFF(FILE,CODE,EDT) ; returns effective date and status for code/modifier
 ; Input:
 ;    FILE = file number  REQUIRED
 ;           80 = ICD DX
 ;           80.1 = ICD O/P
 ;    CODE = ICD CODE ien  REQUIRED
 ;    EDT = date to check (FileMan format) REQUIRED
 ;
 ; Output:  STATUS^Inactivation Date^Activation Date
 ;          where STATUS = 1 = active
 ;                         0 = inactive  
 ;          Activation Date = date code became active
 ;          Inactivation Date = date code became inactive
 ;     -or-
 ;          -1^error message
 ;
 ; Variables:
 ;   EFILE = indirect file reference for code
 ;   EFF,EFFDT,EFFDOS,EFFDFLT = effective dates
 ;   EFFN = sub-entry ien
 ;   EFFST = effective status
 ;   STR = output
 ;
 I $G(CODE)="" Q "-1^NO CODE SELECTED"
 I $G(FILE)="" Q "-1^NO FILE SELECTED"
 I '(FILE=80!(FILE=80.1)) Q "-1^INVALID FILE"
 I '$G(EDT) Q "-1^NO DATE SELECTED"
 N EFILE,EFF,EFFN,STR,EFFDT,EFFST,EFFB,EFFDOS
 S EFILE=$S(FILE=80:"^ICD9(",1:"^ICD0(")_CODE_",66,"
 S EDT=$S($G(EDT)="":$$DT^XLFDT,1:$$DTBR^ICDAPIU(EDT))+.001 ;date business rules
 S EFF=$O(@(EFILE_"""B"","_EDT_")"),-1)
 I 'EFF Q "0^^"
 S EFFN=$O(@(EFILE_"""B"","_EFF_",0)")) ; node 66 (effective date) sub-entry
 S STR=$G(@(EFILE_EFFN_",0)"))
 I STR="" Q "0^^"
 ;set Opposite eff. date based on status
 S EFFDT=$P(STR,"^"),EFFST=$P(STR,"^",2),EFFB=0,EFF=+EFF
 F  S EFF=$O(@(EFILE_"""B"","_EFF_")"),-1) Q:'EFF!EFFB  D
 . S EFFN=$O(@(EFILE_"""B"","_EFF_",0)")) I 'EFFN S EFFB=1 Q
 . S EFFDOS=$G(@(EFILE_EFFN_",0)")) I 'EFFDOS S EFFB=1 Q
 . S EFFB=(EFFST'=$P(EFFDOS,"^",2))
 S EFFDOS=$P($G(EFFDOS),"^")
 I EFFST S $P(STR,"^",3,4)=(EFFDOS)_"^"_EFFDT
 E  S $P(STR,"^",3,4)=EFFDT_"^"_(EFFDOS)
 Q $P(STR,"^",2,4)
 ;
NUM(Y) ; convert ICD to $A() of alpha _ numeric portion
 ; Input:  Y - ICD code
 ; Output:  'plussed' value for ICD OP code,
 ;          numeric for ICD based on $A of 1st character (alpha)
 ;          concatenated with the remainder of the ICD DX code
 ;
 ;      **This does not convert to ien**
 ;
 ;  This converts to a numeric that may be used for range sorting
 ;
 ; A few ICD DX codes start with "E", "M", or "V" - use ascii
 ; Remaining ICD DX codes will use 10 as a prefix - insuring DX > OP
 ; All ICD OP codes match dd.d, dd.dd, or dd.ddd
 ;     where 'd' is a digit; e.g. "V83.89"=8683.89 and "008.8"=10008.8
 ;
 Q $S(Y?2N1"."1.3N:+Y,Y?1U2.3N1".".2N:$A($E(Y))_$E(Y,2,6),1:10_$E(Y,2,7))
 ;
