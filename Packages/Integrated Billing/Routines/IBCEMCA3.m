IBCEMCA3 ;ALB/ESG - Multiple CSA Message Management - Actions ;20-SEP-2005
 ;;2.0;INTEGRATED BILLING;**320,349**;21-MAR-1994;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
PRINT ; resubmit by print
 NEW DFN,DIR,DIROUT,DIRUT,DTOUT,DUOUT,FC,FORM,IB0,IB364,IBDA,IBFT,IBFTP
 NEW IBH,IBIFN,IBJ,IBMCSPNT,IBQUIT,IBS,IBS1,IBS2,IBS3,IBTASK,IBX,IBXP,IBY,IBZ
 NEW INS,NS,NSC,PATNAME,PAYER,X,Y,ZIP,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 D FULL^VALM1
 ;
 S NS=+$G(^TMP($J,"IBCEMCL",4))
 I 'NS D  G PRINTX
 . W !!?5,"There are no selected messages." D PAUSE^VALM1
 . Q
 ;
 ; count number of claims too
 S IBIFN=0 F NSC=0:1 S IBIFN=$O(^TMP($J,"IBCEMCL",4,2,IBIFN)) Q:'IBIFN
 ;
 W !!?5,"Number of messages selected:  ",NS
 W !?7,"Number of claims selected:  ",NSC
 ;
 ; check certain form types for a default printer
 K FC S FC=0
 F FORM=2,3,6 D
 . N X S X=$G(^IBE(353,FORM,0))
 . I $P(X,U,2)'="" Q   ; billing printer defined
 . S FC=FC+1,FC($P(X,U,1)_" ")=""
 . Q
 I FC D  I IBQUIT G PRINTX
 . N NM
 . S IBQUIT=0
 . W !!,*7,"Warning!  The default billing printer is missing for the following form type",$S(FC>1:"s",1:""),":",!
 . S NM="" F  S NM=$O(FC(NM)) Q:NM=""  W !?4,NM
 . W !!,"Nothing will print for ",$S(FC>1:"these form types",1:"this form type"),".  Printers are maintained in the option"
 . W !,"'Select Default Device for Forms' on the System Manager's IB Menu."
 . W ! S DIR(0)="Y",DIR("A")="Do you want to continue",DIR("B")="No"
 . D ^DIR K DIR
 . I 'Y S IBQUIT=1   ; No, don't continue quit out
 . Q
 ;
 ; Ask the user for the 3 sort levels
 W !
 S IBS=""
 S IBZ="Z:ZIP;I:INSURANCE COMPANY NAME;P:PATIENT NAME;"
 S IBH="This Resubmit by Print action attempts to print all selected claims in the order requested.  The printed claims may be sorted by: Zip Code, Insurance Company Name, and Patient name."
 S DIR("?")=IBH
 S DIR("A")="First Sort Claims By"
 S DIR(0)="SB^"_IBZ
 D ^DIR K DIR I $D(DIRUT) G PRINTX                   ; primary sort
 S IBS=IBS_$S(Y="Z":1,Y="I":2,Y="P":3,1:0)
 S IBX=$P($P(IBZ,Y_":",2),";",1)
 ;
 S DIR("?")=IBH
 S DIR("?",1)="Enter the field that the claims should be sorted on within "_IBX_"."
 S DIR("?",2)="Press return if the order already entered is sufficient."
 S DIR("?",3)=""
 S DIR("A")="Then Sort Claims By"
 S DIR(0)="SOB^"_IBZ
 D ^DIR K DIR I Y'="",$D(DIRUT) G PRINTX             ; secondary sort
 S IBS=IBS_$S(Y="Z":1,Y="I":2,Y="P":3,1:0)
 I Y="" G P1
 S IBY=$P($P(IBZ,Y_":",2),";",1)
 ;
 S DIR("?")=IBH
 S DIR("?",1)="Enter the field that the claims should be sorted on within "_IBX_" and "_IBY_"."
 S DIR("?",2)="Press return if the order already entered is sufficient."
 S DIR("?",3)=""
 S DIR("A")="Then Sort Claims By"
 S DIR(0)="SOB^"_IBZ
 D ^DIR K DIR I Y'="",$D(DIRUT) G PRINTX             ; tertiary sort
 S IBS=IBS_$S(Y="Z":1,Y="I":2,Y="P":3,1:0)
 ;
P1 ;
 ;
 W !
 S DIR(0)="S^2:2nd Notice;3:3rd Notice;C:Copy;O:Original"
 S DIR("A")="(2)nd Notice, (3)rd Notice, (C)opy or (O)riginal"
 S DIR("B")="C"
 D ^DIR K DIR
 I $D(DIRUT) G PRINTX
 I Y="C" S Y=0   ; copy
 I Y="O" S Y=1   ; original
 S IBMCSPNT=Y
 ;
 W !!,"Note:  Any selected claims in a REQUEST MRA status will not be printed."
 W !
 S DIR(0)="Y"
 S DIR("A")="OK to begin printing claims"
 S DIR("B")="No"
 S DIR("?",1)="   Enter YES to immediately begin printing the selected claims."
 S DIR("?")="   Enter NO to quit this option."
 D ^DIR K DIR
 I 'Y G PRINTX
 ;
 ; kill ^XTMP scratch global
 S IBX="IBCFP" F  S IBX=$O(^XTMP(IBX)) Q:IBX'?1"IBCFP"1.N  K ^XTMP(IBX,$J)
 S IBXP=$$FMADD^XLFDT(DT,1)_U_DT_U_"MCS BATCH PRINT BILLS "_$$HTE^XLFDT($H)_" by "_$S($D(^VA(200,+$G(DUZ),0)):$P(^(0),"^"),1:"Unknown User")
 ;
 ; Loop thru selected claims, queue them and print them
 S IBIFN=0
 F  S IBIFN=$O(^TMP($J,"IBCEMCL",4,2,IBIFN)) Q:'IBIFN  D
 . S IBFT=$$FT^IBCEF(IBIFN)   ; form type of claim
 . I $P($G(^IBE(353,IBFT,0)),U,2)="" Q    ; no printer defined
 . S IB0=$G(^DGCR(399,IBIFN,0))
 . I $P(IB0,U,13)=2 Q    ; don't include MRA requests here
 . S DFN=+$P(IB0,U,2)
 . S PATNAME=$P($G(^DPT(DFN,0)),U,1)
 . S ZIP=$P($G(^DGCR(399,IBIFN,"M")),U,9)   ; field 109 - curr ins zip
 . ; payer
 . S INS=+$P($G(^DGCR(399,IBIFN,"MP")),U,1)
 . I 'INS S INS=+$$CURR^IBCEF2(IBIFN)
 . S PAYER=$P($G(^DIC(36,INS,0)),U,1)
 . ;
 . S IBX=ZIP_U_PAYER_U_PATNAME
 . S IBS1=$P(IBX,U,$E(IBS,1))_" "     ; primary sort data
 . S IBS2=$P(IBX,U,$E(IBS,2))_" "     ; secondary sort data
 . S IBS3=$P(IBX,U,$E(IBS,3))_" "     ; tertiary sort data
 . ;
 . S ^XTMP("IBCFP"_IBFT,$J,IBS1,IBS2,IBS3,IBIFN)=""
 . S ^XTMP("IBCFP"_IBFT,0)=IBXP
 . S IBDA=0
 . F  S IBDA=$O(^TMP($J,"IBCEMCL",4,2,IBIFN,IBDA)) Q:'IBDA  D
 .. N DIE,DA,DR,TXT
 .. S DIE=361,DA=IBDA,DR=".16////"_DT D ^DIE
 .. S TXT(1)="Claim queued for printing by the MCS - 'Resubmit by Print' action",TXT=1
 .. D NOTECHG^IBCECSA2(IBDA,0,.TXT,1)
 .. Q
 . ;
 . ; if this is an MRA secondary claim and MRA's are on file and
 . ; there is a printer defined for MRAs, then include them too
 . I $$MRAEXIST^IBCEMU1(IBIFN),$P($G(^IBE(353,6,0)),U,2)'="" D
 .. S ^XTMP("IBCFP6",$J,IBS1,IBS2,IBS3,IBIFN)=""
 .. S ^XTMP("IBCFP6",0)=IBXP
 .. Q
 . ;
 . ; if the claim's form type is a CMS-1500 and there is a printer
 . ; defined for Bill Addendums, then include them too
 . I IBFT=2,$P($G(^IBE(353,4,0)),U,2)'="" D
 .. S ^XTMP("IBCFP4",$J,IBS1,IBS2,IBS3,IBIFN)=""
 .. S ^XTMP("IBCFP4",0)=IBXP
 .. Q
 . ;
 . Q
 ;
 ; loop thru the ^XTMP scatch global and queue off form type job
 S IBX="IBCFP" K IBTASK
 F  S IBX=$O(^XTMP(IBX)) Q:IBX'?1"IBCFP"1.N  D
 . I '$D(^XTMP(IBX,$J)) Q
 . S IBFT=+$E(IBX,6,99)
 . S ZTIO=$P($G(^IBE(353,IBFT,0)),U,2)  ; printer
 . S IBFTP=IBX                          ; 1st subscript
 . S IBJ=$J                             ; 2nd subscript
 . S ZTDTH=$H
 . S ZTSAVE("IBFTP")=""
 . S ZTSAVE("IBFT")=""
 . S ZTSAVE("IBJ")=""
 . S ZTSAVE("IBMCSPNT")=""
 . S ZTDESC="MCS BATCH PRINTING "_$$FTN^IBCU3(IBFT)
 . S ZTRTN="QBILL^IBCFP1"
 . I IBFT=6 S ZTRTN="QMRA^IBCEMU2"      ; MRA print rtn
 . D ^%ZTLOAD
 . S IBTASK(IBFT)=+$G(ZTSK)
 . Q
 ;
 ; Display the queued task#'s
 I '$D(IBTASK) W !!?5,"Nothing was printed"
 I $D(IBTASK) D
 . W !
 . S IBFT=0 F  S IBFT=$O(IBTASK(IBFT)) Q:'IBFT  D
 .. W !,$J($$FTN^IBCU3(IBFT),15)," form type printing started with TaskMan task# ",IBTASK(IBFT),"."
 .. Q
 . ;
 . W !!?1,"Please Note:  These EDI status messages will be removed from the CSA screen"
 . W !?15,"and the MCS screen once it has been confirmed that these claims"
 . W !?15,"have been successfully printed."
 . Q
 ;
 D PAUSE^VALM1
 ;
 ; rebuild the list
 KILL ^TMP($J,"IBCEMCA"),VALMHDR
 S VALMBG=1
 D UNLOCK^IBCEMCL
 D INIT^IBCEMCL
 I $G(IBCSAMCS)=1 S IBCSAMCS=2   ; flag to rebuild CSA
 ;
PRINTX ;
 S VALMBCK="R"
 Q
 ;
