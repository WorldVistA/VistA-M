IBCSCH ;ALB/MJB - MCCR HELP ROUTINE ;03 JUN 88 15:25
 ;;2.0;INTEGRATED BILLING;**52,80,106,124,138,51,148,137,161,245,232,287,348,349,374,371,395,400,432,447,458,488,623**;21-MAR-94;Build 70
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;MAP TO DGCRSCH
 ;
 N I,C,IBSCNNZ,IBQ,IBPRNT,Z S IBSCNNZ=$$UP^XLFSTR($G(IBSCNN)),IBQ=0
 I '$D(IBPAR) D  Q:IBQ
 . I $F(".?1500.?HCFA.","."_$G(IBSCNNZ)_"."),$$FT^IBCEF(IBIFN)=2 S IBQ=1,IBPRNT=2 D BL24(IBIFN,0) Q
 . I $G(IBSCNNZ)="?J430D",$$FT^IBCEF(IBIFN)=7 S IBQ=1 D DENTAL^IBCSCH2(IBIFN) Q   ;/vd - IB*2.0*623 - US4055. Added to display DENTAL Mock-up screen when ?J430D is entered on any screen.
 . I $G(IBSCNNZ)="?SC" S IBQ=1 D DISPSC(IBIFN) Q
 . I $G(IBSCNNZ)="?INS" S IBQ=1 D INSDSPL(IBIFN) Q
 . I $G(IBSCNNZ)="?INX" S IBQ=1 D INSDSPLX(IBIFN) Q
 . I $G(IBSCNNZ)="?PRV" S IBQ=1 D DISPROPT(IBIFN) Q
 . I $G(IBSCNNZ)="?CHG" S IBQ=1 D DISPCHG^IBCRBH1(IBIFN) Q
 . I $G(IBSCNNZ)="?PRC" S IBQ=1 D DISPPRC^IBCSCH1(IBIFN) Q
 . I $G(IBSCNNZ)="?CPT" S IBQ=1 D BCPTCHG^IBCRBH2(IBIFN) Q
 . I $G(IBSCNNZ)="?INC" S IBQ=1 D EDIT^IBCBB(IBIFN) Q
 . I $G(IBSCNNZ)="?CLA",$$CK0^IBCIUT1() S IBQ=1 D CLA^IBCISC(IBIFN) Q
 . I $G(IBSCNNZ)="?MRA",$$MCRONBIL^IBEFUNC(IBIFN),$T(SCR^IBCEMVU)'="" S IBQ=1 D SCR^IBCEMVU(IBIFN) Q
 . I $G(IBSCNNZ)="?ID" S IBQ=1 D DISPID^IBCEF74(IBIFN) Q
 . I $G(IBSCNNZ)="?RX" S IBQ=1 D DISPRX^IBCSCH1(IBIFN) Q
 . I $G(IBSCNNZ)="?RNB" S IBQ=1 D EDITRNB^IBCSCH1(IBIFN) Q
 . Q
 ;
 S IBH("HELP")="" D ^IBCSCU,H^IBCSCU K IBH("HELP") W !,"Enter '^' to stop the display ",$S(IBV:"",1:"and edit "),"of data,"
 W:'$D(IBPAR) " '^N' to jump to screen #N (see",!,"listing below), <RET> to continue on to the next available screen" I IBV W "." G M
 W " or enter",!,"the field group number(s) you wish to edit using commas and dashes as",!,"delimiters.  Those groups enclosed in brackets ""[]"" are editable while those"
 W !,"enclosed in arrows ""<>"" are not."
 G:$D(IBPAR) M1
M W "  Special help screens:"
 W !,?5,"Enter '?SC' to view SC Status and Rated Disabilities."
 W !,?5,"Enter '?INS' to view the patients insurance policies."
 W !,?5,"Enter '?INX' to view the patients insurance policies with comments."
 W !,?5,"Enter '?PRV' to view provider specific information."
 W !,?5,"Enter '?PRC' to view all procedures on the bill and related data."
 W !,?5,"Enter '?CHG' to view all items on the bill with potential charges."
 W !,?5,"Enter '?CPT' to view all charges for selected CPT codes and bill type."
 I $$FT^IBCEF(IBIFN)=2 W !,?5,"Enter '?1500' to view how block 24 will print on a CMS-1500."
 I $$FT^IBCEF(IBIFN)=7 W !,?5,"Enter '?J430D' to view data entered on the Dental claim."  ;/vd - Added for IB*2.0*623 - US4055.
 W !,?5,"Enter '?INC' to execute the edits & view the bill inconsistencies."
 I $$CK0^IBCIUT1() W !?5,"Enter '?CLA' to view the ClaimsManager options."
 I $$MCRONBIL^IBEFUNC(IBIFN) W !?5,"Enter '?MRA' to view Medicare Remittance Advice EOB's on file."
 W !,?5,"Enter '?ID' to view all IDs to be electronically transmitted on this claim."
 W !,?5,"Enter '?RX' to view all prescriptions on this claim."
 W !,?5,"Enter '?RNB' to enter an RNB for bill associated Claims Tracking entries."
 ;
 D S W ! F I=$Y:1:20 W !
 S Z="PRESS <RETURN> KEY" X IBWW W " to RETURN to SCREEN ",+IBSR
 R X:DTIME
 Q
 ;
M1 N I,Z S Z="DATA GROUPS ON PARAMETER SCREEN" W !! X IBWW D @(IBSR1_IBSR) D W W ! F I=$Y:1:20 W !
 S Z="PRESS <RETURN> KEY" X IBWW W " to RETURN to PARAMETER SCREEN"
 R X:DTIME
 Q
 ;
 ;
PAR S X="Fed Tax #, BC/BS #, MAS Svc Pointer^Bill Signer, Billing Supervisor^Security Parameters, Outpatient CPT parameters ^Remarks, Mailgroups^Agent Cashier Address/Phone" Q
 ;
S ; display the available screen data
 N C,I,Z,J W ! S Z="AVAILABLE SCREENS" X IBWW
 ; Start IB*2.0*447 BI
 ;S X="Demographic^Employment^Payer^Inpatient Event^Outpatient Event^Inpatient Billing - General^Outpatient Billing - General^Billing - Claim Information^Locally Defined^Billing - Specific"
 S X="Demographic^Employment^Payer^Inpatient Event^Outpatient Event^Inpatient Billing - General^Outpatient Billing - General^Billing - Claim Information^Ambulance^Billing - Specific^Locally Defined"
 ; End IB*2.0*447 BI
 S C=0 F I=1:1 S J=$P(X,"^",I) Q:J=""  I '$E(IBVV,I) S C=C+1,Z="^"_I,IBW=(C#2) W:'(C#2) ?41 X IBWW S Z=$S(I?1N:" ",1:" ")_J_" Data" W Z
 Q
 ;
W ;
 N I,J,Z
 F I=1:1 S J=$P(X,"^",I) Q:J=""  S Z=I,IBW=(I#2) W:'(I#2) ?42 X IBWW W " "_J
 W:'(I-1)#2 ! Q
 Q
 ;IBCSCH
 ;
 ;
BL24(IBIFN,IBNOSHOW) ; display block 24 of CMS-1500
 ; IBNOSHOW = 1 for not to show error/warning text line
 N X,Y,DIR,IBPG,IBLN,IBCOL,IBX,IBQ,IBLC,IBLIN,IBPFORM,IBD,IBC1,Z,Z0,IBXDATA,IBXSAVE,IBNXPG,L,T,NUM
 K ^TMP("IBXSAVE",$J)
 S IBQ=0,IBLC=9 Q:'$G(IBIFN)  K ^TMP("IBXDISP",$J)
 ;
 S IBLIN=$$BOX24D^IBCEF11()
 S IBPFORM=$S($P($G(^IBE(353,2,2)),U,8):$P(^(2),U,8),1:2)
 S IBX=$$BILLN^IBCEFG0(0,"1^99",IBLIN,+IBIFN,IBPFORM)
 ;
 W @IOF,!,"Example of diagnoses, procedures and charges printing on the CMS-1500"
 W !,"--------------------------------------------------------------------------------"
 ;
 ; box 19 - lines 36-37
 F Z=+IBLIN,IBLIN+1 I $D(^TMP("IBXDISP",$J,1,Z)) S Z0=$G(^TMP("IBXDISP",$J,1,Z,+$O(^TMP("IBXDISP",$J,1,Z,20),-1))) I Z0'="" S:Z=+IBLIN Z0="BOX 19 DATA: "_Z0 W !,Z0
 ;
 ; box 21 - lines 39-41
 W !,"21. Diagnosis"
 ;I $D(^TMP("IBXDISP",$J,2,IBLIN+3)) W ?16,"(1st 4 only)"   ; -> baa *488*
 ; Print all 12 diagnosis codes  -> baa *488*
 F L=3,4,5 D
 .W !
 .F T=3,16,29,42 D
 ..S NUM=""
 ..I L=3 S NUM=$S(T=3:1,T=16:2,T=29:3,T=42:4,1:"")
 ..I L=4 S NUM=$S(T=3:5,T=16:6,T=29:7,T=42:8,1:"")
 ..I L=5 S NUM=$S(T=3:9,T=16:10,T=29:11,T=42:12,1:"")
 ..S T2=T+2,T1=T I NUM>9 S T1=T-1
 ..W ?T1,NUM,".",?T2,$G(^TMP("IBXDISP",$J,1,IBLIN+L,T))
 ;W !,?5,"1. ",$G(^TMP("IBXDISP",$J,1,IBLIN+3,3)),?25,"3. ",$G(^TMP("IBXDISP",$J,1,IBLIN+3,30))
 ;W !,?5,"2. ",$G(^TMP("IBXDISP",$J,1,IBLIN+5,3)),?25,"4. ",$G(^TMP("IBXDISP",$J,1,IBLIN+5,30))
 ;
 ; box 24 - lines 44-55
 D PG
 S IBPG=0 F  S IBPG=$O(^TMP("IBXDISP",$J,IBPG)) Q:'IBPG  D  Q:IBQ
 . I '$D(^TMP("IBXDISP",$J,IBPG,IBLIN+9)) Q   ; no line's on this page
 . F IBLN=IBLIN+8:1:+$P(IBLIN,U,2) S IBCOL=$O(^TMP("IBXDISP",$J,IBPG,IBLN,0)) Q:'IBCOL&'$O(^TMP("IBXDISP",$J,IBPG,IBLN))  S IBLC=IBLC+1 I IBCOL D  Q:IBQ
 .. S IBCOL=0,IBC1=1 F  S IBCOL=$O(^TMP("IBXDISP",$J,IBPG,IBLN,IBCOL)) Q:'IBCOL  I $TR($G(^(IBCOL))," ")'="" D
 ... W:IBC1 ! S IBC1=0 W ?(IBCOL-1),$G(^TMP("IBXDISP",$J,IBPG,IBLN,IBCOL))
 . S IBNXPG=$O(^TMP("IBXDISP",$J,IBPG))   ; next page
 . I 'IBQ,IBNXPG,$D(^TMP("IBXDISP",$J,IBNXPG,IBLIN+9)) S IBLIN=$$BOX24D^IBCEF11(),IBQ=$$PAUSE^IBCSCH1(IBLC) Q:IBQ  S IBLC=9 W @IOF D PG
 . Q
 ;
 W !,"--------------------------------------------------------------------------------"
 I 'IBPG,'IBQ S IBQ=$$PAUSE^IBCSCH1(IBLC)
 K ^TMP("IBXDISP",$J),^TMP("IBXSAVE",$J)
 Q
 ;
PG ; Display box 24 letters at top of charge list
 W !,"24. A             B  C    D                 E         F     G H I    J"
 W !,"--------------------------------------------------------------------------------"
 Q
 ;
INSDSPL(IBIFN) ; Display patient's policies
 N DIR,X,Y,IBX,DFN,IBDTIN,IBCOVEXT W @IOF
 S IBX=$G(^DGCR(399,+$G(IBIFN),0)),DFN=$P(IBX,U,2),IBDTIN=$P(IBX,U,3),IBCOVEXT=1
 I +DFN D DISPDT^IBCNS W ! S DIR("A")="Press RETURN to continue",DIR(0)="E" D ^DIR K DIR
 Q
 ;
INSDSPLX(IBIFN) ; Display patient's policies extended (?INX)
 N IBX,DFN,IBDATE S IBX=$G(^DGCR(399,+$G(IBIFN),0)),DFN=$P(IBX,U,2),IBDATE=$P(IBX,U,3) D DISP^IBCNS3(DFN,IBDATE,123)
 Q
 ;
DISPSC(IBIFN) ; display patients SC Status and Rated Disabilities
 N IB0,DFN,IBSC,IBX,VAEL,VAERR
 S IB0=$G(^DGCR(399,+$G(IBIFN),0)),DFN=$P(IB0,U,2),IBSC=$P(IB0,U,18)
 W !,@IOF,!,"SC Status and Rated Disabilities for ",$P($G(^DPT(+$G(DFN),0)),U,1)
 W !,"--------------------------------------------------------------------------------",!
 I +$G(IBIFN) W !," SC At Time Of Care: ",$S(IBSC=1:"Yes",IBSC=0:"No",1:"")
 I +$G(DFN) D ELIG^VADPT D DIS^DGRPDB
 W !!,"--------------------------------------------------------------------------------"
 S IBX=$$PAUSE^IBCSCH1(19)
 Q
 ;
DISPROPT(IBIFN) ; prompt for VA or Non-VA provider.
 N X,Y,DIR
 S DIR(0)="SAO^V:VA PROVIDER;N:NON-VA PROVIDER",DIR("A")="(V)A or (N)on-VA Provider: ",DIR("B")="V"
 D ^DIR
 I Y="V" D DISPPRV^IBCSCH2(IBIFN) Q
 I Y="N" D DISPNVA^IBCSCH2(IBIFN)
 Q
 ;
