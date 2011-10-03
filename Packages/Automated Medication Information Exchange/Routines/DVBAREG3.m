DVBAREG3 ;ALB/JLU;continuation of DVBAREG2 and DVBAREG1
 ;;2.7;AMIE;;Apr 10, 1995
 ;
DOC(ANS) ;returns a document type.
 ;the return will either be a "A" for admission or "L"
 S ANS=$S(^TMP("DVBA",$J,ANS)["ADMISSION":"A",1:"L")
 Q ANS
 ;
PAT() ;this is a function call to look up the patient
 N STOP
 S DIC="^DPT(",DIC(0)="AEMQZ",DIC("A")="Enter Patient name: "
 K DIC("W")
 D ^DIC
 I $D(DTOUT)!($D(DUOUT))!(X="") S STOP=0
 E  S STOP=Y
 Q STOP
 ;
SET1 ;sets more variables
 S (ONFILE,REOPEN,ARROWOUT,OUT)=0
 Q
 ;
SET2 ;sets the patient information variables
 S PNAM=$P(DFN,U,2),SSN=$P(^DPT(+DFN,0),U,9)
 S CNUM=$S($D(^DPT(+DFN,.31)):$P(^(.31),U,3),1:"Unknown")
 Q
