PXVPARS ;ISP/LMT - VIMM MANAGE PARAMETERS  ;Jun 25, 2019@08:53:11
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**217**;Aug 12, 1996;Build 134
 ;
 ;
SEQPAREN ;
 ;
 N PXQUIT
 ;
 F  S PXQUIT=$$SEQPAR() Q:PXQUIT
 Q
 ;
SEQPAR() ;
 ;
 N DIR,DIRUT,PXPAR,X,Y
 ;
 W @IOF
 W !
 W !,"1. Information Sources Sequence."
 W !,"2. Contraindication Reasons Sequence."
 W !,"3. Refusal Reasons Sequence."
 W !
 S DIR(0)="NOA^1:3:0"
 S DIR("A")="Select which Immunization setting to edit (1-3): "
 D ^DIR
 I $D(DIRUT)!(Y<1)!(Y>3) Q 1
 ;
 S PXPAR=$S(Y=1:"PXV INFO SOURCE SEQUENCE",Y=2:"PXV CONTRA SEQUENCE",1:"PXV REFUSAL SEQUENCE")
 D EDITPAR^XPAREDIT(PXPAR)
 ;
 Q 0
 ;
