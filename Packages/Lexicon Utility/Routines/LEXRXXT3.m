LEXRXXT3 ;ISL/KER - Repair/Re-Index - Task (cont) ;08/17/2011
 ;;2.0;LEXICON UTILITY;**81**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^XTMP("LEXRX")      SACC 2.3.2.5.2
 ;               
 ; External References
 ;    $$S^%ZTLOAD         ICR  10063
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMADD^XLFDT       ICR  10103
 ;    $$NOW^XLFDT         ICR  10103
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;     LEXQ       Quiet flag      NEWed/KILLed by LEXRXXT2
 ;     ZTQUEUED   Task flag       NEWed/KILLed by Taskman
 ;     ZTSK       Task Number     NEWed/KILLed by Taskman
 ;
 Q
UPD(X,LEXDES,LEXUPD) ; Update Task ^XTMP and ^%ZTSK
 Q:$D(LEXQ) 0  N LEXNAM,LEXCRE,LEXPRG,LEXTC S LEXTC=0
 S LEXNAM=$G(X),LEXDES=$G(LEXDES),LEXUPD=$G(LEXUPD)
 S LEXCRE=$$DT^XLFDT,LEXPRG=$$FMADD^XLFDT(LEXCRE,1)
 I $L(LEXNAM),'$L(LEXDES),'$L(LEXUPD) K ^XTMP(LEXNAM) Q 0
 I $L(LEXNAM) I '$D(^XTMP(LEXNAM,0)) D
 . S ^XTMP(LEXNAM,0)=LEXPRG_"^"_LEXCRE I $L(LEXDES) D
 . S $P(^XTMP(LEXNAM,0),"^",3)=$$NOW^XLFDT
 . S $P(^XTMP(LEXNAM,0),"^",4)=LEXDES
 . S:+($G(ZTSK))>0 ^XTMP(LEXNAM,1)=+($G(ZTSK))
 I $L(LEXNAM),$L(LEXUPD) I $D(^XTMP(LEXNAM,0)) D
 . S ^XTMP(LEXNAM,2)=$$NOW^XLFDT_"^"_LEXUPD
 I $D(ZTQUEUED) D
 . S:$L(LEXDES)&('$L(LEXUPD)) LEXTC=$$S^%ZTLOAD(LEXDES)
 . S:$L(LEXUPD) LEXTC=$$S^%ZTLOAD(LEXUPD)
 . S:+($G(ZTSK))>0 ^XTMP(LEXNAM,1)=+($G(ZTSK))
 S X=LEXTC
 Q X
 ;              
 ; Miscellaneous
CLR ;   Clear
 K LEXQ,ZTQUEUED,ZTSK
 Q
