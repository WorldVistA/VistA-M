ICPTAPIU  ;ALB/DEK/KER - CPT UTILITIES FOR APIS ; 04/18/2004
 ;;6.0;CPT/HCPCS;**1,6,12,14,16,19,22**;May 19, 1997
 ;
 ; External References
 ;   DBIA 10011  ^DIWP
 ;   DBIA 10029  ^DIWW
 ;   DBIA 10103  $$DT^XLFDT 
 ;                          
CPTDIST() ; Distribution Date
 ;  Input:  none (extrinsic variable)
 ; Output:  returns DISTRIBUTION DATE, date codes effective in Austin
 Q $P($G(^DIC(81.2,1,0)),"^",2)
 ;
CAT(CAT,DFN) ; Return CATEGORY NAME given IEN
 ;   Input:  CAT = category ien REQUIRED
 ;           DFN - not in use but included in anticipation of future need
 ;
 ;  Output:  STR = CATEGORY NAME^SOURCE (C or H)^MAJOR CATEGORY IEN^MAJOR CATEGORY NAME  
 ;           STR = -1^error message, if error condition occurred
 ;
 N CATN,STR,MCATIEN,MCATNM
 S (MCATIEN,MCATNM)=""
 I $G(CAT)="" S STR="-1^NO CATEGORY SELECTED" G CATQ
 I '$G(CAT) S STR="-1^INVALID CATEGORY FORMAT" G CATQ
 S STR=$G(^DIC(81.1,+CAT,0))
 I '$L(STR) S STR="-1^NO SUCH CATEGORY" G CATQ
 I $P(STR,"^",2)="" S STR="-1^TYPE OF CATEGORY UNSPECIFIED" G CATQ
 S CATN=$P(STR,"^")
 I $P(STR,"^",2)="m" S MCATNM=CATN,MCATIEN=+CAT
 I $P(STR,"^",2)="s" D
 . S MCATIEN=$P(STR,"^",3)
 . I MCATIEN S MCATNM=$P($G(^DIC(81.1,MCATIEN,0)),"^")
 S STR=CATN_"^"_$P(STR,"^",6)_"^"_MCATIEN_"^"_MCATNM
CATQ Q STR
 ;
NUM(Y) ; Convert CPT/HCPCS Code to Numeric
 ;    Convert HCPCS to $A() of Alpha _ Numeric Portion
 ;
 ;   Input:  Y - CPT or HCPCS code
 ;
 ;  Output:  'plussed' value for CPT code,
 ;         numeric for HCPCS based on $A of 1st character (alpha)
 ;          concatenated with the 4-digit portion of code
 ;
 ;  **This does not convert to ien**
 ;  This converts to a numeric that may be used for range sorting
 ;
 ;Q $S(Y:+Y,1:$A(Y)_$E(Y,2,5))
 ; modified in 2002 to handle few CPT codes that end with "T"
 ; needed to add multiplier to create higher and unique number
 ; e.g. "Z9999"=909999 and "0001T"=8400001
 Q $S(Y?1.N:+Y,Y?4N1A:$A($E(Y,5))*10_$E(Y,1,4),1:$A(Y)_$E(Y,2,5))
 ;
COPY ; API to Print Copyright Information
 ;
 N DIR,DIWL,DIWR,DIWF,VARR,VAXX,X
 Q:'$D(^DIC(81.2,1))  K ^UTILITY($J,"W")
 W !!! S DIWL=1,DIWR=80,DIWF="W"
 F VARR=0:0 S VARR=$O(^DIC(81.2,1,1,VARR)) Q:VARR'>0  S VAXX=^(VARR,0),X=VAXX D ^DIWP
 D:$D(VAXX) ^DIWW
 Q
 ;                   
STATCHK(CODE,CDT) ; Check Status of CPT Code or Modifier
 ; Input:
 ;    CODE - CPT Code/Modifier    REQUIRED
 ;    CDT - Date to screen against (FileMan format, default = today)
 ;
 ; Output:
 ;    2-Piece String containing the status of the code/modifier
 ;    and the IEN if the code/modifier exists, else -1.
 ;    The following are possible outputs:
 ;        1 ^ IEN    Active Code/Modifier
 ;        0 ^ IEN    Inactive Code/Modifier
 ;        0 ^ -1     Code/Modifier not Found
 ;
 ; This API requires the ACT Cross-Reference
 ;    ^ICPT("ACT",<code>,<status>,<date>,<ien>)
 ;    ^DIC(81.3,"ACT",<code>,<status>,<date>,<ien>)
 ;
 N ICPTC,ICPTD,ICPTIEN,ICPTA,ICPTI,X,ICPTG,ICPTR,ICPTD
 S ICPTC=$G(CODE) Q:'$L(ICPTC) "0^-1"
 ;    Case 1:  Not Valid                           0^-1
 ;             Fails Pattern Match for Code
 S ICPTG=$$GBL^ICPTSUPT(ICPTC) Q:ICPTG="" "0^-1"
 ;    Case 2:  Never Active                        0^IEN
 ;             No In/Active Date
 S ICPTD=$S($G(CDT)="":$$DT^XLFDT,1:$$DTBR^ICPTSUPT($G(CDT))),ICPTD=ICPTD+.001
 S ICPTR=$$ACT(ICPTG,ICPTC,1,ICPTD),ICPTA=$O(@(ICPTR_")"),-1)
 I '$L(ICPTA) D  Q X
 . S ICPTA=$O(@(ICPTR_")")),X="0^-1" Q:'$L(ICPTA)
 . S ICPTR=$$ACT(ICPTG,ICPTC,1,ICPTA)
 . S ICPTIEN=$O(@(ICPTR_",0)")) S:+ICPTIEN<1 ICPTIEN=-1
 . S X="0^"_ICPTIEN
 ;    Case 3:  Active, Never Inactive              1^IEN
 ;             Has an Activation Date
 ;             No Inactivation Date
 S ICPTR=$$ACT(ICPTG,ICPTC,0,ICPTD),ICPTI=$O(@(ICPTR_")"),-1)
 I $L(ICPTA),'$L(ICPTI) D  Q X
 . S ICPTR=$$ACT(ICPTG,ICPTC,1,ICPTA),ICPTIEN=$O(@(ICPTR_",0)"))
 . S X=$S(+ICPTIEN=0:"0^-1",1:"1^"_ICPTIEN)
 ;    Case 4:  Active, but later Inactivated       0^IEN
 ;             Has an In/Activation Date
 I $L(ICPTA),$L(ICPTI),ICPTI>ICPTA,ICPTI<ICPTD D  Q X
 . S ICPTR=$$ACT(ICPTG,ICPTC,0,ICPTI),ICPTIEN=$O(@(ICPTR_",0)"))
 . S X=$S(+ICPTIEN=0:"0^-1",1:"0^"_ICPTIEN)
 ;    Case 5:  Active, and not later Inactivated   1^IEN
 ;             Has an In/Activation Date
 ;             Has a Newer Activation Date
 I $L(ICPTA),$L(ICPTI),ICPTI'>ICPTA D  Q X
 . S ICPTR=$$ACT(ICPTG,ICPTC,0,ICPTI),ICPTIEN=$O(@(ICPTR_",1)"))
 . S X=$S(+$O(@(ICPTR_",0)"))=0:"0^-1",1:"1^"_ICPTIEN)
 ;    Case 6:  Fails Time Test                     0^-1
 Q ("0^"_$S(+($G(ICPTIEN))>0:+($G(ICPTIEN)),1:"-1"))
 ;
NEXT(CODE) ; Next CPT Code or Modifier (active or inactive)
 ; Input:
 ;    CODE = CPT Code/Modifier   REQUIRED
 ;
 ; Output:
 ;    The Next CPT Code/Modifier, Null if none
 ;
 N ICPTC,ICPTG
 S ICPTC=$G(CODE) Q:'$L(ICPTC) ""
 S ICPTG=$$GBL^ICPTSUPT(ICPTC) Q:'$L(ICPTG) ""
 S ICPTC=$O(@(ICPTG_"""BA"","""_ICPTC_" "")"))
 Q $S(ICPTC="":"",1:$E(ICPTC,1,$L(ICPTC)-1))
 ;
PREV(CODE) ; Previous CPT Code or Modifier (active or inactive)
 ; Input:
 ;    CODE = CPT Code/Modifier   REQUIRED
 ;
 ; Output:
 ;    The Previous CPT Code/Modifier, Null if none
 ;
 N ICPTC,ICPTG
 S ICPTC=$G(CODE) Q:'$L(ICPTC) ""
 S ICPTG=$$GBL^ICPTSUPT(ICPTC) Q:'$L(ICPTG) ""
 S ICPTC=$O(@(ICPTG_"""BA"","""_ICPTC_" "")"),-1)
 Q $S(ICPTC="":"",1:$E(ICPTC,1,$L(ICPTC)-1))
 ;
HIST(CODE,ARY) ; Activation History
 ; Input:
 ;    CODE - CPT Code or Modifier          REQUIRED
 ;    .ARY - Array, passed by Reference    REQUIRED
 ;
 ; Output:    Mirrors ARY(0) (or, -1 on error)
 ;    ARY(0) = Number of Activation History Entries
 ;    ARY(<date>) = status    where: 1 is Active
 ;    ARY("IEN") = <ien>
 ;
 Q:$G(CODE)="" -1
 N ICPTC,ICPTI,ICPTN,ICPTD,ICPTG,ICPTF,ICPTO
 S ICPTG=$$GBL^ICPTSUPT(CODE) Q:'$L(ICPTG) -1
 S ICPTI=$O(@(ICPTG_"""BA"","""_CODE_" "",0)")) Q:'$L(ICPTI) -1
 S ARY("IEN")=ICPTI,ICPTO="" M ICPTO=@(ICPTG_ICPTI_",60)")
 K ICPT0("B") S ARY(0)=+($P($G(ICPTO(0)),"^",4))
 S:+ARY(0)=0 ARY(0)=-1 K:ARY(0)=-1 ARY("IEN")
 S (ICPTI,ICPTC)=0 F  S ICPTI=$O(ICPTO(ICPTI)) Q:+ICPTI=0  D
 . S ICPTD=$P($G(ICPTO(ICPTI,0)),"^",1) Q:+ICPTD=0
 . S ICPTF=$P($G(ICPTO(ICPTI,0)),"^",2) Q:'$L(ICPTF)
 . S ICPTC=ICPTC+1,ARY(0)=ICPTC,ARY(ICPTD)=ICPTF
 Q ARY(0)
 ;
PERIOD(CODE,ARY) ; return Activation/Inactivation Period in ARY
 ;
 ; Output:  ARY(0) = String: IEN^Selectable
 ; 
 ;          Where the pieces are:
 ; 
 ;            1  Internal Entry Number of code in ^ICPT or ^DIC(81.3,
 ;            2  0:unselectable; 1:selectable
 ; 
 ;          ARY(Activation Date) = Inactivation Date^Short Name
 ;             Where the Short Name is the Versioned text (field 1 of the 61
 ;             multiple), and the text is versioned as follows:
 ; 
 ;                Period is active - Versioned text for TODAY's date
 ;                Period is inactive - Versioned text for inactivation date
 ; 
 ;            or
 ; 
 ;          -1^0 (no period or error)
 ;        
 I $G(CODE)="" S ARY(0)="-1^0" Q
 N ICPTC,ICPTI,ICPTA,ICPTG,ICPTF,ICPTBA,ICPTBI,ICPTST,ICPTS,ICPTZ,ICPTV,ICPTN,ICPTCA
 S ICPTG=$$GBL^ICPTSUPT(CODE) I ICPTG="" S ARY(0)="-1^0" Q
 S ICPTC=$O(@(ICPTG_"""BA"","""_CODE_" "",0)")) I ICPTC="" S ARY(0)="-1^0" Q
 S (ARY(0),ICPTC)=+ICPTC,ICPTZ=$G(@(ICPTG_ICPTC_",0)")),ICPTS=$P(ICPTZ,"^",2)
 S $P(ARY(0),"^",2)=$S(ICPTG="^ICPT(":$P(ICPTZ,"^",6)'="L",1:$P(ICPTZ,"^",4)'="V")
 S (ICPTA,ICPTBA)=0,ICPTG=ICPTG_ICPTC_",60,"
 ; Versioned text for TODAY
 S ICPTN=$$VST^ICPTCOD(ICPTC,$$DT^XLFDT,ICPTG)
 F  Q:ICPTBA  D
 . S ICPTA=$O(@(ICPTG_"""B"","_ICPTA_")"))
 . I ICPTA="" S ICPTBA=1 Q
 . S ICPTF=$O(@(ICPTG_"""B"","_ICPTA_",0)"))
 . I '+ICPTF S ICPTBA=1 Q
 . S ICPTST=$P($G(@(ICPTG_ICPTF_",0)")),"^",2)
 . Q:'ICPTST  ;outer loop looks for active
 . ; Versioned text for activation date
 . S ICPTV=$$VST^ICPTCOD(ICPTC,ICPTA,ICPTG),ICPTCA=1
 . S ARY(ICPTA)="^"_ICPTS,ICPTBI=0,ICPTI=ICPTA
 . S:$L(ICPTV) $P(ARY(ICPTA),"^",2)=ICPTV
 . F  Q:ICPTBI  D
 . . S ICPTI=$O(@(ICPTG_"""B"","_ICPTI_")"))
 . . ; If no inactivation date for ICPTA then use TODAY's text
 . . I ICPTI="" S ARY(ICPTA)="^"_ICPTN,(ICPTBI,ICPTBA)=1 Q
 . . S ICPTF=$O(@(ICPTG_"""B"","_ICPTI_",0)"))
 . . ; If no effective date ICPTF for ICPTI then use TODAY's text
 . . I '+ICPTF S ARY(ICPTA)="^"_ICPTN,(ICPTBI,ICPTBA)=1 Q
 . . S ICPTST=$P($G(@(ICPTG_ICPTF_",0)")),"^",2)
 . . ; If Status ICPTST not Inactive then use TODAY's text
 . . I ICPTST S ARY(ICPTA)="^"_ICPTN,ICPTBI=1 Q
 . . ; Versioned text for inactive date
 . . S ICPTV=$$VST^ICPTCOD(ICPTC,ICPTI,ICPTG)
 . . S $P(ARY(ICPTA),"^")=ICPTI
 . . S:$L(ICPTV) $P(ARY(ICPTA),"^",2)=ICPTV
 . . S ICPTCA=0,ICPTBI=1,ICPTA=ICPTI
 Q
 ;
ACT(ICPTG,ICPTC,ICPTS,ICPTD) ; return "ACT" root
 Q ICPTG_"""ACT"","""_ICPTC_" "","_ICPTS_","_ICPTD
