IBCOC1 ;ALB/NLR - NEW, NOT VERIFIED INS. ENTRIES ; 24-NOV-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;
% ;
 ; -- fileman print of new, not verified insurance entries
 ;
 W !!,"Print List of New, Not Verified Insurance Entries"
 W !!,"You will need a 132 column printer for this report!",!!
 ;
 S DIC="^DPT(",FLDS="[IBNOTVER]",BY="[IBNOTVER1]"
 D ASK G:$G(IBQ)=1 END
 S DHD="REPORT OF NEW, NOT VERIFIED INSURANCE ENTRIES FROM: "_FR(1)_" TO: "_TO(1)
 D EN1^DIP
 ;
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
END K DIC,FLDS,BY,FR,TO,IBQ,DHD
 Q
ASK ;
 N IBBDT,IBEDT
 D DATE^IBOUTL
 I (IBBDT<1)!(IBEDT<1) S IBQ=1
 S FR=",,"_IBBDT_",?",TO=",,"_IBEDT_",?"
 S FR(1)=$$DAT1^IBOUTL(IBBDT),TO(1)=$$DAT1^IBOUTL(IBEDT)
 Q
