IBCSCH2 ;ALB/DLS - Continuation of routine IBCSCH ;12 JUN 2007
 ;;2.0;INTEGRATED BILLING;**374,623**;21-MAR-94;Build 70
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
DISPPRV(IBIFN) ; Display provider information: interactive - user selects provider
 N DIC,DA,X,Y,IBI,IBJ,IBW,IBPRV,IBPX,IBDT,IBARR,IBNPISTR,IBNPI,IBPRVTAX,IBTAXFLG
 N IBPRVDAT,IBTAXID,IBTAXEFF,IBTAXTRM,IBTAXX12
 W !!,"This is a display of provider specific information."
 D SPECIFIC^IBCEU5(IBIFN)
 S IBDT=+$G(^DGCR(399,+$G(IBIFN),"U")) I 'IBDT S IBDT=DT
 ;
 F IBI=1:1 W ! S DIC("A")="Select PROVIDER NAME: ",DIC="^VA(200,",DIC(0)="AEQM" D ^DIC Q:Y'>0  D
 . S IBPRV=Y
 . W !!,$TR($J(" ",IOM)," ","-")
 . S IBPX=$$ESBLOCK^XUSESIG1(+IBPRV)
 . W !," Signature Name: ",$P(IBPX,U,1)
 . W !,"Signature Title: ",$P(IBPX,U,3)
 . W !,"         Degree: ",$P(IBPX,U,2)
 . ;
 . ; PRXM/DLS - Patch 374. Adding NPI to Signature information.
 . S IBNPISTR=$$NPI^XUSNPI("Individual_ID",+IBPRV)                               ; Get NPI information.
 . S IBNPI=$P(IBNPISTR,U)                                                        ; Get NPI.
 . W !,"            NPI: ",$S(IBNPI>0:IBNPI,1:"")                                ; Write NPI.
 . ;
 . S IBPX=$$PRVLIC^IBCU1(+IBPRV,IBDT,.IBARR)                                     ; Get License Info.
 . W !!,"     License(s): " D
 . . I IBPX'>0 W "None Active on ",$$FMTE^XLFDT(IBDT,2) Q
 . . S IBJ=0,IBW=0 F  S IBJ=$O(IBARR(IBJ)) Q:'IBJ  D
 . . . S IBPX=IBARR(IBJ),IBPX=$P($G(^DIC(5,+IBPX,0)),U,2)_": "_$P(IBPX,U,2)
 . . . I (IBW+$L(IBPX))>61 W !,?17 S IBW=0
 . . . W IBPX,"  " S IBW=IBW+$L(IBPX)+2
 . ;
 . ; PRXM/DLS - Display Person Class/Taxonomy Information.
 . S IBTAXFLG=0                                                                  ; Init to 0, set to 1 if Person Class info found.
 . S IBPRVTAX=0                                                                  ; Loop through prov's Person Class entries.
 . F  S IBPRVTAX=$O(^VA(200,+IBPRV,"USC1",IBPRVTAX)) Q:'IBPRVTAX  D
 . . ; Get Basic Information
 . . S IBTAXID=$$GET1^DIQ(200.05,IBPRVTAX_","_+IBPRV_",",.01,"I") Q:IBTAXID=""   ; Person Class IEN.
 . . S IBTAXEFF=$$GET1^DIQ(200.05,IBPRVTAX_","_+IBPRV_",",2,"I")                 ; Person Class Eff Date.
 . . S IBTAXTRM=$$GET1^DIQ(200.05,IBPRVTAX_","_+IBPRV_",",3,"I") ;I IBTAXTRM=""   ; Person Class Term Date.
 . . I IBTAXTRM="" S IBTAXTRM=9999999
 . . ; See if claim beginning service date falls within Eff date range. If so, proceed.
 . . I (IBTAXEFF'>IBDT),(IBTAXTRM>IBDT) D
 . . . S IBTAXFLG=1                                                              ; A Person Class found, set flag to 1.
 . . . ; Get Detailed Information and Display.
 . . . S IBPX=$$IEN2DATA^XUA4A72(IBTAXID)                                        ; Person Class Details.
 . . . S IBTAXX12=$$GET1^DIQ(8932.1,IBTAXID_",",6)                               ; Get X12 Code.
 . . . W !
 . . . W !,"   Person Class: ",$P(IBPX,U,6)                                      ; Display Person Class Name.
 . . . W !,"  PROVIDER TYPE: ",$P(IBPX,U)                                        ; Display Provider Type.
 . . . W !," CLASSIFICATION: ",$P(IBPX,U,2)                                      ; Display Classification.
 . . . W !," SPECIALIZATION: ",$P(IBPX,U,3)                                      ; Display Specialization.
 . . . W !,"       TAXONOMY: ",IBTAXX12,$S(IBTAXX12'="":" ("_IBTAXID_")",1:"")   ; Display X12 Code and Internal Code (IEN).
 . . . W !,"      EFFECTIVE: ",$$FMTE^XLFDT(IBTAXEFF,2)                          ; Display EFF Date.
 . . . I IBTAXTRM'=9999999 W " - ",$$FMTE^XLFDT(IBTAXTRM,2)                      ; Display TRM Date, if it exists.
 . ; If no Person Class entries exists for this Provider, notate it.
 . I 'IBTAXFLG W !!,"   Person Class: None Active on ",$$FMTE^XLFDT(IBDT,2)
 . S IBPX=$$PRVTYP^IBCRU6(+IBPRV,+IBDT)
 . W !!,"RC Provider Group: ",$S(+IBPX:$P(IBPX,U,3)_", "_$P(IBPX,U,5)_"%",1:"None")
 . W !,$TR($J(" ",IOM)," ","-")
 Q
 ;
DISPNVA(IBIFN) ; Display Non-VA individual provider information.
 N IBDT,IBI,IBNVFLG,IBNVID,IBNVTX,IBNVTX2,IBNVTXID,IBNVSL,X,Y,DIC,DA,IBTAXX12,IBPX
 S IBDT=+$G(^DGCR(399,+$G(IBIFN),"U")) I 'IBDT S IBDT=DT
 ; Select Non-VA Provider
 F IBI=1:1 W ! S DIC("A")="Select NON-VA PROVIDER NAME: ",DIC="^IBA(355.93,",DIC(0)="AEQM",DIC("S")="I $P(^(0),U,2)=2" D ^DIC Q:Y'>0  D
 . S IBNVID=+Y W !!,$TR($J(" ",IOM)," ","-")
 . W !," Signature Name: ",$$GET1^DIQ(355.93,IBNVID_",",.01)
 . W !,"            NPI: ",$$GET1^DIQ(355.93,IBNVID_",",41.01)
 . W !
 . S IBNVSL=$$GET1^DIQ(355.93,IBNVID_",",.12)                                        ; Get and Display License info.
 . W !,"     License(s): ",$S(IBNVSL'="":IBNVSL,1:"None Active on "_$$FMTE^XLFDT(IBDT,2))
 . W !
 . S IBNVTX=""
 . S IBNVFLG=0
 . F  S IBNVTX=$O(^IBA(355.93,IBNVID,"TAXONOMY","D",IBNVTX),-1) Q:IBNVTX=""  D       ; Loop through prov's Person Class X-Ref.
 . . S IBNVTX2=""
 . . F  S IBNVTX2=$O(^IBA(355.93,IBNVID,"TAXONOMY","D",IBNVTX,IBNVTX2)) Q:'IBNVTX2  D
 . . . I $$GET1^DIQ(355.9342,IBNVTX2_","_IBNVID_",",.03,"I")="A" D                   ; Proceed if the Person Class is Active.
 . . . . S IBNVFLG=1
 . . . . S IBNVTXID=$$GET1^DIQ(355.9342,IBNVTX2_","_IBNVID_",",.01,"I")
 . . . . ; Get Detailed Information and Display.
 . . . . S IBPX=$$IEN2DATA^XUA4A72(IBNVTXID)                                         ; Person Class Details.
 . . . . S IBTAXX12=$$GET1^DIQ(8932.1,IBNVTXID_",",6)                                ; Get X12 Code.
 . . . . W !,"   Person Class: ",$P(IBPX,U,6)                                        ; Display Person Class Name.
 . . . . W $S($G(IBNVTX)=1:" (Primary)",1:" (Secondary)")
 . . . . W !,"  PROVIDER TYPE: ",$P(IBPX,U)                                          ; Display Provider Type.
 . . . . W !," CLASSIFICATION: ",$P(IBPX,U,2)                                        ; Display Classification.
 . . . . W !," SPECIALIZATION: ",$P(IBPX,U,3)                                        ; Display Specialization.
 . . . . W !,"       TAXONOMY: ",IBTAXX12,$S(IBTAXX12'="":" ("_IBNVTXID_")",1:""),!  ; Display X12 Code and Internal Code (IEN).
 . I 'IBNVFLG W !,"   Person Class: None Active on ",$$FMTE^XLFDT(IBDT,2),!
 . W $TR($J(" ",IOM)," ","-"),!
 Q
 ;
 ;/vd - IB*2.0*623 (US4055) - Beginning.
DENTAL(IBIFN) ; Select Dental Claim detail gathered and displayed here
 Q:'$G(IBIFN)
 N ARY,CPTMOD,I,IBLC,IBLIN,IBQ,IBRORA,IBRORARES,IBRORATX,IBX,IBXDATA,L,N,NN,NPI,NUM,POS,PRVARY,SEQ,T,T1,T2,XABCD,XIBI,XDIAG
 K ^TMP("IBXSAVE",$J),^TMP("IBXDISP",$J)
 S IBLIN=$$BOX24D^IBCEF11()
 S IBX=$$BILLN^IBCEFG0(0,"1^99",IBLIN,+IBIFN,2)  ;Set ^TMP("IBXDISP",$J) w/ data for Diagnosis display
 D OUTPT^IBCEF11(IBIFN,1) ;Gather procedure-level Dental data - stored in IBXDATA array
 D GETPROVS(IBIFN,.PRVARY)  ;Get the Provider Types.
 ;Output claim-level information
 W @IOF,"Example of dx, procedures, teeth info, and charges entered on the Dental claim"
 W !,"--------------------------------------------------------------------------------"
 W !,"Claim Provider:"
 S IBRORA=0
 I $D(PRVARY) D    ; Display the Provider Types & their IDs.
 . W !
 . S POS=0,SEQ=""
 . F  S SEQ=$O(PRVARY("SQ",SEQ)) Q:SEQ=""  D
 . . W ?POS,PRVARY("SQ",SEQ) S POS=POS+$L(PRVARY("SQ",SEQ))+5
 ;
 ;Output diagnosis codes using ^TMP("IBXDISP",$J) created by $$BILLN^IBCEFG0 function
 W !!,"34a. Diagnosis:"
 F L=3,4,5 D
 .Q:(L'=3)   ; Due to a request by eBiz...only 4 diagnosis codes should display on a Dental Claim (US4055).
 .W !
 .F T=3,16,29,42 D
 ..S NUM=""
 ..I L=3 S NUM=$S(T=3:1,T=16:2,T=29:3,T=42:4,1:"")
 ..S T2=T+2,T1=T I NUM>9 S T1=T-1
 ..W ?T1,NUM,".",?T2,$G(^TMP("IBXDISP",$J,1,IBLIN+L,T))
 W !,"35. Dental Claim Note:"
 W !,$$GET1^DIQ(399,IBIFN,97)
 ;
 W ! D PG S IBLC=13
 ;Order thru IBXDATA array to output procedure-level data
 S ARY="TMP(""IBXDATA"",$J)" K @ARY
 I $D(IBXDATA)>1 S N="" F  S N=$O(IBXDATA(N)) Q:N=""  D
 . S @ARY@(N,"POS")=$P($G(IBXDATA(N)),U,3)
 . S @ARY@(N,"CPT")=$P($G(IBXDATA(N)),U,5)
 . S XIBI=+$G(IBXDATA(N,"CPLNK"))
 . S XDIAG=$P($G(IBXDATA(N)),U,7),XABCD=""
 . F I=1:1:4 I +$P(XDIAG,",",I),$P(XDIAG,",",I)<5 S XABCD=XABCD_$TR($P(XDIAG,",",I),"1234,","ABCD")
 . S @ARY@(N,"DIAG")=XABCD
 . S @ARY@(N,"QTY")=$P($G(IBXDATA(N)),U,9)
 . S @ARY@(N,"CHARGE")=$P($G(IBXDATA(N)),U,8)*@ARY@(N,"QTY")*100
 . S CPTMOD=$P($G(IBXDATA(N)),U,10) I $TR(CPTMOD,",")]"" F I=1:1:$L(CPTMOD,",") D
 . . Q:$P(CPTMOD,",",I)=""
 . . S $P(CPTMOD,",",I)=$P($G(^DIC(81.3,$P(CPTMOD,",",I),0)),U)
 . . S @ARY@(N,"CPTMOD")=$TR(CPTMOD,","," ")
 . S @ARY@(N,"ORALCAV")=$TR($P($G(IBXDATA(N,"DEN")),U,1,5),U," ")
 . ;
 . S @ARY@(N,"START")=$E($P($G(IBXDATA(N)),U,1),1,2)_" "_$E($P($G(IBXDATA(N)),U,1),3,4)_" "_$E($P($G(IBXDATA(N)),U,1),7,8)
 . S @ARY@(N,"END")=$E($P($G(IBXDATA(N)),U,2),1,2)_" "_$E($P($G(IBXDATA(N)),U,2),3,4)_" "_$E($P($G(IBXDATA(N)),U,2),7,8)
 . I $P($G(IBXDATA(N)),U,2)="" S @ARY@(N,"END")=@ARY@(N,"START")
 . ;
 . S NN=0 F  S NN=$O(IBXDATA(N,"DEN1",NN)) Q:NN=""  I NN?1.N D
 . . S @ARY@(N,NN,"TOOTH")=$P($G(IBXDATA(N,"DEN1",NN,0)),U)
 . . S @ARY@(N,NN,"SURFACE")=$TR($P($G(IBXDATA(N,"DEN1",NN,0)),U,2,6),U)
 ;
 S N="" F  S N=$O(@ARY@(N)) Q:N=""  D
 . W !,@ARY@(N,"START"),?9,@ARY@(N,"END"),?18,@ARY@(N,"ORALCAV")
 . W ?33,$G(@ARY@(N,1,"TOOTH")),?36,$G(@ARY@(N,1,"SURFACE")),?42,$G(@ARY@(N,"CPT"))
 . W ?48,$G(@ARY@(N,"CPTMOD")),?60,$G(@ARY@(N,"DIAG")),?65,$G(@ARY@(N,"QTY")),?68,$G(@ARY@(N,"CHARGE")),?77,@ARY@(N,"POS")
 . S IBLC=IBLC+1 I IBLC>20,($O(@ARY@(N))!($O(@ARY@(N,1)))) W !,$TR($J("-",80)," ","-") S IBQ=$$PAUSE^IBCSCH1(IBLC) Q:IBQ  W @IOF D PG
 . S NN=1 F  S NN=$O(@ARY@(N,NN)) Q:NN=""  D
 . . I $G(@ARY@(N,NN,"TOOTH"))="",($G(@ARY@(N,NN,"SURFACE")))="" Q
 . . W !,?33,$G(@ARY@(N,NN,"TOOTH")),?36,$G(@ARY@(N,NN,"SURFACE"))
 . . S IBLC=IBLC+1 I IBLC>20,$O(@ARY@(N,NN)) W !,$TR($J("-",80)," ","-") I  S IBQ=$$PAUSE^IBCSCH1(IBLC) Q:IBQ  W @IOF D PG
 W !,"--------------------------------------------------------------------------------"
 S IBQ=$$PAUSE^IBCSCH1(IBLC)
 K @ARY
 Q
 ;
GETPROVS(IBIFN,PRVARY) ;Get the Provider Types
 N FILE,FLD,PROV,SQ,TYPE,UCTYPE
 K PRVARY
 Q:'IBIFN
 S TYPE=""
 F  S TYPE=$O(^DGCR(399,IBIFN,"PRV","C",TYPE)) Q:TYPE=""  D
 . S UCTYPE=$$UP^XLFSTR(TYPE)
 . I UCTYPE="ASSISTANT SURGEON" S UCTYPE="ASST SURGEON"
 . I $D(PRVARY("P",UCTYPE)) Q  ; Already have capitalized version of this Provider Type.
 . S SQ=$O(^DGCR(399,IBIFN,"PRV","C",TYPE,"")) Q:SQ=""
 . S FILE=+$P($P($G(^DGCR(399,IBIFN,"PRV",SQ,0)),U,2),"(",2)
 . S PROV=$P($P($G(^DGCR(399,IBIFN,"PRV",SQ,0)),U,2),";")
 . S FLD=$S(FILE["355.93":41.01,1:41.99)
 . S NPI=$$GET1^DIQ(FILE,PROV,FLD) S:$TR(NPI," ")="" NPI="**NO NPI**"
 . S PRVARY("P",UCTYPE)=SQ,PRVARY("SQ",SQ)=UCTYPE_"/"_NPI
 Q
 ;
PG ; Display Dental form box numbers at top of charge list
 W "24                25             27 28    29                29a  29b 31      38"
 W !,"--------------------------------------------------------------------------------"
 S IBLC=3
 Q
 ;/vd - IB*2.0*623 (US4055) - End.
 ;
