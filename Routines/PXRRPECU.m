PXRRPECU ;ISL/PKR - Utilities for dealing with the Person Class file. ;4/3/97
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**12,31**;Aug 12, 1996
 ;
 ;=======================================================================
ABBRV(VACODE) ;Given a VACODE get the full Person Class entry and return an
 ;abbreviation for it.
 N ABBRV,MAXLEN,MAXLENP3,OCC,PCLASS,SPEC,SUB
 ;If there is no VACODE then return Unknown.
 I $L(VACODE)'>0 Q "Unknown"
 ;
 S MAXLEN=20
 S MAXLENP3=MAXLEN+3
 I $L(VACODE,U)=3 S PCLASS=U_VACODE
 E  S PCLASS=$$OCCUP^PXBGPRV("","",VACODE,1,"")
 ;
 S OCC=$P(PCLASS,U,2)
 I $L(OCC)>MAXLENP3 S OCC=$E(OCC,1,MAXLEN)_"..."
 S ABBRV=OCC
 ;
 S SPEC=$P(PCLASS,U,3)
 I $L(SPEC)>MAXLENP3 S SPEC=$E(SPEC,1,MAXLEN)_"..."
 I $L(SPEC)>0 S ABBRV=ABBRV_"+"_SPEC
 S SUB=$P(PCLASS,U,4)
 I $L(SUB)>MAXLENP3 S SUB=$E(SUB,1,MAXLEN)_"..."
 I $L(SUB)>0 S ABBRV=ABBRV_"+"_SUB
 Q ABBRV
 ;
 ;=======================================================================
ALPHA(PCLASS) ;Given a person class of the form IEN_U_Occupation_U_Specialty
 ;_U_^Subspecialty return an abbreviation useful for alphabetizing.
 N T1,TEMP
 ;If there is no person class return Unknown.
 I +$P(PCLASS,U,1)'>0 Q "Unknown"
 S TEMP=$E($P(PCLASS,U,2),1,4)
 S T1=$E($P(PCLASS,U,3),1,4)
 I $L(T1)'>0 S T1="+"
 S TEMP=TEMP_T1
 S T1=$E($P(PCLASS,U,4),1,4)
 I $L(T1)'>0 S T1="+"
 S TEMP=TEMP_T1
 S TEMP=TEMP_U_$P(PCLASS,U,7)
 Q TEMP
 ;
 ;=======================================================================
FDME(INP,ARRAY) ;Find and display the entries matching the input and get a selection.
 N DIR,IC,JC,LINP,RET,SA,X,Y
 ;Check for the special cases first.
 ;The null selection.
 I INP="" Q INP
 ;The wildcard selection.
 I INP=WC Q WC_U_WC
 ;An exact match.
 I $D(ARRAY(INP)) Q INP_U_ARRAY(INP)
 ;
 S RET=-1
 S INP=$$UPPRCASE(INP)
 S LINP=$L(INP)
 S IC=INP
 S JC=0
 F  S IC=$O(ARRAY(IC)) Q:(INP'=$E(IC,1,LINP))  D
 . S JC=JC+1
 . S SA(JC)=IC_U_ARRAY(IC)
 I JC=1 W " ",$P(SA(1),U,1) Q SA(1)
 I JC>1 D
 . F IC=1:1:JC D
 .. W !,IC,?INDENT,$P(SA(IC),U,1)
 . S DIR(0)="NAO^1:"_JC
 . S DIR("A")="Choose 1-"_JC_": "
 . W !
 . D ^DIR
 . I +Y>0 S RET=SA(+Y)
 Q RET
 ;
 ;=======================================================================
GETYORN(PROMPT) ;Get a yes or no answer, return true (yes) or false (no).
 N DIR,X,Y
 S DIR(0)="YAO"
 I $D(PROMPT) S DIR("A")=PROMPT
 D ^DIR
 Q Y
 ;
 ;=======================================================================
LISTA(ARRAY) ;List all the elements of ARRAY.
 N IC,DONE
 K SELECT
 S $Y=0
 S DONE=0
 W !,"Choose from:"
 S IC=""
 F  S IC=$O(ARRAY(IC)) Q:(IC="")!(DONE)  D
 . W !,?INDENT,IC
 . I $Y>(IOSL-3) D PAGE(.ARRAY)
 I $D(SELECT) D
 . I SELECT'=-1 D
 .. ;S SSPEC=SELECT
 .. S DIR("B")=$P(SELECT,U,1)
 Q
 ;
 ;=======================================================================
MATCH(PCLASS) ;Return true if PCLASS is in the PERSON CLASS list, PXXRPECL.
 N CLASSIEN,IC,LOCC,LSPEC,LSUB,MATCH,MOCC,MSPEC,MSUB
 N NS,OCC,SPEC,SUB,WC
 ;If PCLASS is less than 0 then no person class was returned.
 ;Therefore there cannot be a match.
 I +PCLASS<0 Q 0
 ;
 S NS="NOT SPECIFIED"
 S WC="*"
 S CLASSIEN=$P(PCLASS,U,1)
 ;OCCUP^PXBGPRV returns negative numbers in first piece if there was no
 ;person class.  In this case the only match will be for the wildcard.
 I +CLASSIEN'>0 D
 . S (OCC,SPEC,SUB)=WC
 E  D
 . S OCC=$P(PCLASS,U,2)
 . S SPEC=$P(PCLASS,U,3)
 . S SUB=$P(PCLASS,U,4)
 I $L(SPEC)=0 S SPEC=NS
 I $L(SUB)=0 S SUB=NS
 ;
 S MATCH=0
 F IC=1:1:NCL Q:MATCH  D
 . S LOCC=$P(PXRRPECL(IC),U,1)
 . I (LOCC'=OCC)&(LOCC'=WC) Q
 . S LSPEC=$P(PXRRPECL(IC),U,2)
 . I (LSPEC'=SPEC)&(LSPEC'=WC) Q
 . S LSUB=$P(PXRRPECL(IC),U,3)
 . I (LSUB'=SUB)&(LSUB'=WC) Q
 .;If we got to here we have a match.
 . S $P(PXRRPECL(IC),U,4)="M"
 . S MATCH=1
 ;
 Q MATCH
 ;
 ;=======================================================================
NXREF(XREF,STRING) ;Return the number of elements for the STRING and cross-ref pair.
 N IC,JC
 S (IC,JC)=0
 F  S IC=$O(^USC(8932.1,XREF,STRING,IC))  Q:+IC=0  D
 . S JC=JC+1
 Q JC
 ;
 ;=======================================================================
PAGE(ARRAY) ;Page breaking with optional return of selection.
 N DIR,X,Y
 S DIR(0)="FAOU^1:60"
 S DIR("A")="Enter Return to continue, your selection, or '^' to exit: "
 W !
 D ^DIR K DIR
 I $D(DUOUT)!($D(DTOUT)) S DONE=1 Q
 I Y="" W:$D(IOF) @IOF
 E  D  Q
 . S SELECT=$$FDME(Y,.ARRAY)
 . S DONE=1
 K DTOUT,DUOUT
 Q
 ;
 ;=======================================================================
PCLLIST(NEWPIEN,BDT,EDT,LIST) ;Build a list of all the person classes for the
 ;provider NEWPIEN in the date range BDT to EDT.  Return the total
 ;number.
 N IC,PCLASS,TEMP,TLIST,TOTAL
 K LIST
 S TOTAL=0
 F IC=BDT:1:EDT D
 . S PCLASS=$$GET^XUA4A72(NEWPIEN,IC)
 . I PCLASS>0 D
 .. S TEMP=$$ALPHA(PCLASS)
 . E  S TEMP="Unknown"
 . S TLIST(TEMP)=""
 ;Count and return the unique entries.
 S IC=""
 F  S IC=$O(TLIST(IC)) Q:IC=""  D
 . S TOTAL=TOTAL+1
 . S LIST(TOTAL)=IC
 Q TOTAL
 ;
 ;=======================================================================
UPPRCASE(STRING) ;Convert STRING to uppercase and return it.
 Q $TR(STRING,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
 ;=======================================================================
VERIFY ;Have the user verify the most recent Person Class selection.
 N KEEP,PROMPT
 W !!,"Your Person Class Selection was:"
 W !,?INDENT,"OCCUPATION:   ",$P(PXRRPECL(NCL),U,1)
 W !,?INDENT,"SPECIALTY:    ",$P(PXRRPECL(NCL),U,2)
 W !,?INDENT,"SUBSPECIALTY: ",$P(PXRRPECL(NCL),U,3)
 W !
 S PROMPT="Is this selection correct? "
 S KEEP=$$GETYORN(PROMPT)
 I 'KEEP D
 . K PXRRPECL(NCL)
 . S NCL=NCL-1
 Q
