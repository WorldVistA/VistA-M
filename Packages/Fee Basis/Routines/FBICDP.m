FBICDP ;AISC/JAS - ICD-9 & 10 PROCEDURE CODE UTILITIES ;9/26/2013
 ;;3.5;FEE BASIS;**139**;JAN 30, 1995;Build 127
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; References to API $$IMPDATE^LEXU supported by ICR #5679
 ; Reference to API $$FILE^ICDEX supported by ICR #5747
 ; Reference to API $$ROOT^ICDEX supported by ICR #5747
 ; Reference to API $$SYS^ICDEX supported by ICR #5747
 ; Reference to API $$ICDOP^ICDEX supported by ICR #5747
 ;
 ;THIS ROUTINE WAS CLONED FROM FBICD9, BUT HAS BEEN MODIFIED TO BE USED FOR ICD-9 AND ICD-10 PROCEDURE CODES.
 ; Input - FBIDT= date of interest to check  FBPRMT= user prompt  FBALW= allow user to early exit if set to Y 
 ;         ALDEL= allow deletion of Proc field? (optional)  -if this is set to "Y", @ is an acceptable entry
 ;         ALFREQ= allow forcing a field to be required (optional)  -if this is set to "Y", the field will be forced to be required
 ;         FBDFLT= default values for the search string (can be a code by default)
 ; Output- Y = IEN^Proc code OR -1^inactive code"
ENICD9(FBIDT,FBPRMT,FBALW,ALDEL,ALFREQ,FBDFLT) ; prompt user for ICD procedure code and test if code is inactive
 N Y,DIC,FBICDCD,FBIMPDT K X
 S:'$D(FBALW) FBALW="N" ; early exit allow flag
 S:'$D(ALDEL) ALDEL="N" ; delete allow flag
 S:'$D(ALFREQ) ALFREQ="N" ; force required allow flag
 S FBICDCD=31,FBIMPDT=$$IMPDATE^FBCSV1("10D")
 S:FBIDT<FBIMPDT FBICDCD=2
SRCH1 ;
 S Y=$$SEARCH(FBIDT)
 I (Y>0)&('$$ICD9ACT(+Y,FBIDT)) D
 . W !!,*7,"ICD Proc Code "_"("_$P(Y,U,2)_")"_" inactive on date of service ("_$$FMTE^XLFDT(FBIDT)_").",!
 . S Y="-1^inactive code"
 . Q
 Q Y
 ; 
 ; Input  -FBINDT = ICD versioning date
 ; Output -Y = IEN^Proc code    
SEARCH(FBINDT) ; 
 I $G(FBDFLT)>0 S DIR("A")=FBPRMT_": "_$P($$ICDOP^ICDEX(FBDFLT,FBIDT,FBICDCD,"I"),"^",2)_"// "
 E  S DIR("A")=FBPRMT_": "
 S DIR(0)="FAOr^0:245"
 S DIR("?")="Answer with ICD OPERATION/PROCEDURE CODE NUMBER, or DESCRIPTION"
 D ^DIR K DIR
 I ((X="@")&(ALFREQ="Y")) W "?? REQUIRED" G SRCH1
 I X="@",ALDEL="Y",$G(FBDFLT)="" S ALDEL="N"
 I X="@",ALDEL="Y" N FBYN D  Q:FBYN=1 "@" G SRCH1
 . S FBYN=$$QUESTION^FBASF(2,"SURE YOU WANT TO DELETE")
 . I FBYN'=1 W " <NOTHING DELETED>"
 I X="@" W "??" G SRCH1
 I X="^",FBALW="Y" Q -1
 I X="^" W !,?4,"EXIT NOT ALLOWED ??" G SRCH1
 N ROOT,FILE,SYS,ICDVDT,FILEID,SCREEN,DISFIL
 S FILEID=80.1,SCREEN="I $$CHKVERS^FBICDP(+Y,FBINDT)",DISFIL="EIMQ"
 S FILE=$$FILE^ICDEX($G(FILEID)) Q:+FILE'>0 -1
 S (DIC,ROOT)=$$ROOT^ICDEX(FILE) Q:'$L(ROOT) -1
 S DIC("S")=$S($L($G(SCREEN)):$G(SCREEN),1:"I 1")
 S:$G(FBINDT) ICDVDT=$G(FBINDT)
 S SYS=$$SYS^ICDEX(FILE,$G(ICDVDT)) S:+SYS>0 ICDSYS=+SYS
 S DISFIL=$G(DISFIL,"EMQZ") S DISFIL=$TR(DISFIL,"L","") K DLAYGO
 S DIC(0)=DISFIL D ^DIC K DIC,ICDSYS,ICDFMT
 S:+($G(Y))'>0 Y=-1
 G:((Y=-1)&($L(X)>0)) SRCH1
 Q Y
 ;
 ;Input : Y (ien of file 80.1), (date of interest)
 ;Output: 1 (true) or 0 (false)
CHKVERS(FBDIRY,FBDT) ; return true (1) if procedure code is a current versioned Proc code, otherwise return false (0) 
 N FBICDSYS,FBINF,FBIC9SYS
 S FBICDSYS=$S(FBDT<$$IMPDATE^LEXU(31):2,1:31)            ; 2 = icd-9 version  31 = icd-10 version
 S FBIC9SYS=$P($$ICDOP^ICDEX(FBDIRY,FBDT,"","I"),U,15) ; 2 = icd-9 version  31 = icd-10 version
 Q:FBICDSYS=FBIC9SYS 1 ; returns true
 Q 0 ; returns false
 ;
ICD9ACT(IEN,FBDT) ;Is the given code active for the date? (default-today)
 N FBINF,FBRES
 I '$G(FBDT) S FBDT=DT
 S FBRES=0
 S FBINF=$$ICDOP^ICDEX(IEN,FBDT,"","I")
 I FBINF'<0,$P(FBINF,U,10) S FBRES=1
 Q FBRES
 ;
