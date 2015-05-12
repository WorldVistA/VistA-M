ICDEXD6 ;SLC/KER - ICD Extractor - DRG APIs (cont) ;12/19/2014
 ;;18.0;DRG Grouper;**67**;Oct 20, 2000;Build 1
 ;               
 ; Global Variables
 ;    ^ICDS(              N/A
 ;               
 ; External References
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMADD^XLFDT       ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;    ^%DT                ICR  10003
 ;    ^DIR                ICR  10026
 ;               
 Q
UPDX(IEN) ; Unacceptable as Principle DX
 ;
 ; Input:
 ;
 ;    IEN   Internal Entry Number for file 80
 ;
 ; Output:
 ;
 ;   $$UPDX  Boolean value only (default)
 ;   
 ;            0 No, Code is Acceptable as Principle DX
 ;            1 Yes, Code is Unacceptable as Principle DX
 ;
 N ICDEXC S ICDEXC=$$EXC^ICDEX(80,+($G(IEN))) Q:+ICDEXC>0 1
 Q +($P($G(^ICD9(+($G(IEN)),1)),"^",3))
POAE(X) ; Present on Admission (POA) Exempt
 ;
 ; Input:
 ;
 ;    IEN   Internal Entry Number for file 80
 ;
 ; Output:
 ;
 ;   $$POAE Boolean value only
 ;   
 ;            0 No, Code is not exempt for POA
 ;            1 Yes, Code is exempt for POA
 ; 
 Q:+($G(X))'>0 0  Q:'$L($G(^ICD9(+($G(IEN)),1))) 0
 Q +($P($G(^ICD9(+($G(IEN)),1)),"^",9))
HAC(X) ; Hospital Acquired Conditions (HACS)
 ;
 ; Input:
 ;
 ;    IEN   Internal Entry Number for file 80
 ;
 ; Output:
 ;
 ;   $$HAC  Boolean value only
 ;   
 ;            0 No, Code is not a Hospital Acquired Condition
 ;            1 Yes, Code is a Hospital Acquired Condition
 ; 
 Q:+($G(X))'>0 0  Q:'$L($G(^ICD9(+($G(IEN)),1))) 0
 I $D(^ICDHAC("C",+($G(IEN)))) Q 1
 Q 0
EFM(X) ; Convert External Date to FM
 ;
 ; Input:
 ;
 ;   X      External Date
 ;
 ; Output:
 ;
 ;   $$EFM  Internal Fileman Date
 ;
 ; Replaces unsupported $$DGY2K^DGPTOD0(X)
 ;
 N %DT,Y D ^%DT K %DT
 Q Y
FY(X) ;Return FY
 ;
 ; Input:
 ;
 ;   X      Internal Fileman Date
 ;
 ; Output:
 ;
 ;   $$FY   FY Year YYYY
 ;
 ; Replaces unsupported $$FY^DGPTOD0(X)
 ; 
 S X=$P($G(X),".",1) Q:$L(X)>7 ""  Q:$E(X,1,5)'?5N ""
 S:$E(X,4,5)>9 X=$E(X,1,3)+1
 Q (17+$E(X))_$E(X,2,3)
DRGN(CODE) ; Return the IEN of DRG
 ;
 ;   Input:  
 ;   
 ;     CODE     DRG code
 ;       
 ;  Output:  
 ;  
 ;     $$DRGN   IEN of DRG code
 ;       
 ;              or 
 ;       
 ;              -1 on error
 ;
 Q:$G(CODE)="" -1
 N COD S COD=+$O(^ICD("B",CODE,0))
 Q $S(COD>0:COD,1:-1)
 Q
DRGC(IEN) ; DRG Code
 ;
 ; Input:
 ; 
 ;    IEN      Internal Entry Number file 80.2
 ;
 ; Output:
 ; 
 ;    $$DRGC   Code (field .01)
 ;
 ; Replaces ICR 370
 ; 
 S IEN=+($G(IEN)) Q:'$D(^ICD(+IEN,0)) ""
 Q $P($G(^ICD(+IEN,0)),"^",1)
DRGW(IEN) ; DRG Weighted Work Unit (WWU)
 ;
 ; Input:
 ; 
 ;    IEN      Internal Entry Number file 80.2
 ;
 ; Output:
 ; 
 ;    $$WT     Weight
 ;
 ; Replaces ICR 48
 ; 
 S IEN=+($G(IEN)) Q:'$D(^ICD(+IEN,0)) ""
 Q $P($G(^ICD(+IEN,0)),"^",2)
EFD(X) ; Get Effective date in range (interactive)
 ;
 ; Prompts for Effective Date for DRG grouper
 ; 
 ; The lower boundary for the date is the ICD-9 
 ; implementation date October 1, 1978.
 ; 
 ; The upper boundary for date is either
 ; 
 ;       3 years from the ICD-10 implementation date or
 ;       3 years from TODAY
 ;       
 ;       Whichever is further into the future
 ;
 ; Input:   
 ; 
 ;   None
 ;
 ; Output:
 ;
 ;   $$EFF  3 piece ^ delimited string
 ;   
 ;          1   Date Fileman format         nnnnnnn
 ;          2   Date External Short Format  mm/dd/yyyy
 ;          3   Date External Long Format   Mmm dd, yyyy
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,ICDH,ICDI,ICDIMP,ICDT,Y
 S ICDT=$$DT^XLFDT,ICDH="",ICDI=0
 F  S ICDI=$O(^ICDS(ICDI)) Q:+ICDI'>0  D
 . N ICDIMP S ICDIMP=$P($G(^ICDS(ICDI,0)),"^",3)
 . S:ICDIMP>ICDH ICDH=ICDIMP
 S:ICDT>ICDH ICDH=ICDT S ICDH=$$FMADD^XLFDT(ICDH,1095)
 S DIR(0)="DAO^2781001:"_ICDH_":AEX"
 S DIR("B")="TODAY",DIR("A")=" Effective Date:  " I ICDH?7N D 
 . S DIR("A")=" Effective Date ("_$$FMTE^XLFDT(2781001,"5Z")
 . S DIR("A")=DIR("A")_" to "_$$FMTE^XLFDT($G(ICDH),"5Z")_"):  "
 S DIR("PRE")="S:X[""?"" X=""??""",(DIR("?"),DIR("??"))="^D EFFH^ICDEXD"
 D ^DIR Q:$D(DIROUT) "^^"  Q:$D(DIRUT) "^"  Q:$D(DTOUT) ""
 S X=Y S:X?7N X=X_"^"_$$FMTE^XLFDT(X,"5Z")_"^"_$$FMTE^XLFDT(X)
 Q X
EFFH ; Effective Date Help
 I $L($G(ICDH)) D
 . W !,?5,"Enter an effective date from ",$$FMTE^XLFDT(2781001,"5Z")
 . W " to ",$$FMTE^XLFDT($G(ICDH),"5Z")
 . W !,?5,"to be used to select or calculated time sensitive data.",!
 W !,?5,"Examples of Valid Dates:"
 W !,?5,"  JAN 20 1980 or 20 JAN 80 or 1/20/57 or 012080"
 W !,?5,"  T   (for TODAY),  T+1 (for TOMORROW),  T+2,  T+7, etc."
 W !,?5,"  T-1 (for YESTERDAY),  T-3W (for 3 WEEKS AGO), etc."
 W !,?5,"If the year is omitted, the computer uses CURRENT YEAR. "
 W !,?5,"Two digit year assumes no more than 20 years in the future,"
 W !,?5," or 80 years in the past."
 Q
