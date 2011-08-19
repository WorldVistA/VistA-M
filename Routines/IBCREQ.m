IBCREQ ;ALB/ARH-RATES: CM FAST ENTER/EDIT OPTION ;22-MAY-1996
 ;;2.0;INTEGRATED BILLING;**52,153,167,187**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ENTER ; OPTION:  fast enter Tort or Interagency rates - this option requires charge sets defined as released,
 ; name not changed and a standard set of charges
 N DIR,DIRUT,DTOUT,DUOUT,X,Y,IBARR,IBRATE,IBEFDT,IBRVCD
 W @IOF W !!,?10,"Fast Enter of Tortiously Liable and Interagency Rates",!!
 ;
 S DIR(0)="SO^T:Tortiously Liable;I:Interagency",DIR("A")="Enter which rates" D ^DIR K DIR
 S IBRATE=$S(Y="T":"1^TORTIOUSLY LIABLE",Y="I":"2^INTERAGENCY",1:"") Q:'IBRATE
 ;
 S IBEFDT=$$GETDT^IBCRU1() I IBEFDT'?7N Q
 I +IBRATE=1 S IBRVCD=$$NPFRC Q:'IBRVCD  I '$$TORT(IBRATE,IBEFDT,.IBARR,IBRVCD) Q
 I +IBRATE=2 I '$$IA(IBRATE,IBEFDT,.IBARR) Q
 ;
 D DISP(IBRATE,.IBARR) Q:$D(DIRUT)
 I +IBRATE=2 D SET(IBRATE,.IBARR)
 E  D SET(IBRATE,.IBARR):'$$MT
 ;
 I IBRATE=1 D ENR^IBEMTO K IBRUN ; bill MT OPT charges awaiting the new copay rate
 ;
 Q
 ;
TORT(IBRATE,EFDT,ARR,IBRVCD) ; find the standard charge sets for Tort rates
 N IBCSN,IBX K ARR S ARR=$G(EFDT),IBRVCD=$G(IBRVCD),IBX=0
 S ARR(1)="INPATIENT^INPT",ARR(2)="OUTPATIENT VISIT^OPT VISIT",ARR(3)="PRESCRIPTION REFILL^RX REFILL"
 S ARR(4)="OUTPATIENT DENTAL^OPT DENTAL" ;ARR(5)="MT OUTPATIENT COPAYMENT^MT OPT COPAY"
 S IBCSN="TL-INPT (INCLUSIVE)" I '$$CS(IBRATE,IBCSN,1,1,"","(All Inclusive)",.ARR) G TORTQ
 S IBCSN="TL-INPT (NPF)" I '$$CS(IBRATE,IBCSN,1,2,$P(IBRVCD,U,1),"(Room,board)",.ARR) G TORTQ
 S IBCSN="TL-INPT (NPF)" I '$$CS(IBRATE,IBCSN,1,3,$P(IBRVCD,U,2),"(Ancillary)",.ARR) G TORTQ
 S IBCSN="TL-INPT (PF)" I '$$CS(IBRATE,IBCSN,1,4,"","(Physician)",.ARR) G TORTQ
 S IBCSN="TL-OPT VST" I '$$CS(IBRATE,IBCSN,2,1,"","",.ARR) G TORTQ
 S IBCSN="TL-RX FILL" I '$$CS(IBRATE,IBCSN,3,1,"","",.ARR) G TORTQ
 S IBCSN="TL-OPT DENTAL" I '$$CS(IBRATE,IBCSN,4,1,"","",.ARR) G TORTQ
 ;S IBCSN="TL-MT OPT COPAY" I '$$CS(IBRATE,IBCSN,5,1,"","",.ARR) G TORTQ
 S IBX=1
TORTQ I 'IBX W !!,"The Fast Enter of rates expects to find the standard rates and sets released",!,"nationally, if these are not found this option can not be used."
 Q IBX
 ;
IA(IBRATE,EFDT,ARR) ; find the standard charge sets for Interagency rates
 N IBCSN,IBX K ARR S ARR=$G(EFDT),IBX=0
 S ARR(1)="INPATIENT",ARR(2)="OUTPATIENT VISIT",ARR(3)="PRESCRIPTION REFILL",ARR(4)="OUTPATIENT DENTAL"
 S ARR(1)="INPATIENT^INPT",ARR(2)="OUTPATIENT VISIT^OPT VISIT",ARR(3)="PRESCRIPTION REFILL^RX REFILL",ARR(4)="OUTPATIENT DENTAL^OPT DENTAL"
 S IBCSN="IA-INPT" I '$$CS(IBRATE,IBCSN,1,1,"","(All Inclusive)",.ARR) G IAQ
 S IBCSN="IA-OPT VST" I '$$CS(IBRATE,IBCSN,2,1,"","",.ARR) G IAQ
 S IBCSN="IA-RX FILL" I '$$CS(IBRATE,IBCSN,3,1,"","",.ARR) G IAQ
 S IBCSN="IA-OPT DENTAL" I '$$CS(IBRATE,IBCSN,4,1,"","",.ARR) G IAQ
 S IBX=1
IAQ I 'IBX W !!,"The Fast Enter of rates expects to find the standard rates and sets released",!,"nationally, if these are not found this option can not be used."
 Q IBX
 ;
CS(IBRATE,IBCSN,TYPE,ITEM,RVCD,DESC,ARR) ; accumulate standard charge sets for a rate
 ; check the billing rate is correct and return all relevant info
 ; Output:  ARR(event type) = event type name
 ;          ARR(event type, X) = CS name ^ CS IFN ^ default rev code ^ rev code to store ^ description of charge
 N IBX,IBCS,IBLN,IBERROR S (IBERROR,IBX)=""
 S IBCS=$O(^IBE(363.1,"B",IBCSN,0)) I +IBCS  D
 . S IBLN=$G(^IBE(363.1,IBCS,0)) Q:IBLN=""
 . I $P(IBLN,U,2)'=+IBRATE S IBERROR="*** Error:  Charge Set "_IBCSN_" is not a "_$P(IBRATE,U,2)_" rate." Q
 . S IBX=IBCS,ARR(TYPE,ITEM)=IBCSN_U_IBCS_U_$S($G(RVCD):RVCD,1:$P(IBLN,U,5))_U_$G(RVCD)_U_$G(DESC)
 I 'IBX,IBERROR="" S IBERROR="*** Error:  The Charge Set "_IBCSN_" was not found."
 I IBERROR'="" W !!!,IBERROR,!,"            Can not continue!"
 Q IBX
 ;
SET(IBRATE,ARR) ; add/edit charges:  for each type of charge and each item, displays rev code and description
 ; then askes the user for bedsection and charge
 ;
 N IBEFDT,IBTYP,IBBS,IBJ,IBIT,IBLN,IBCS,IBRVCD,IBCHG,IBOCHG,IBCI,IBX,IBDFTY,DIR,DIRUT,DTOUT,DUOUT,X,Y
 S IBEFDT=+ARR
 S IBTYP=0 F  S IBTYP=$O(ARR(IBTYP)) Q:'IBTYP  D  Q:IBBS<0
 . W !!,"--------------------------------------------------------------------------------"
 . W !,"Enter ",$P(ARR(IBTYP),U,1)," ",$P(IBRATE,U,2)," charges effective ",$$FMTE^XLFDT(IBEFDT),":"
 . W !,"--------------------------------------------------------------------------------"
 . S IBDFTY=IBTYP
 . F IBJ=1:1 W ! S IBBS=$$GETBS(10,$P(ARR(IBTYP),U,2),IBDFTY) Q:IBBS<1  D  I IBTYP>1 S IBDFTY=""
 .. S IBIT=0 F  S IBIT=$O(ARR(IBTYP,IBIT)) Q:'IBIT  D  I $D(DUOUT) Q
 ... S IBLN=ARR(IBTYP,IBIT),IBCS=$P(IBLN,U,2),IBRVCD=$P(IBLN,U,4),IBOCHG=""
 ... S IBX=$E($P(IBBS,U,2),1,28)
 ... S IBX=IBX_$J("",(30-$L(IBX)))_$P(IBLN,U,5)
 ... S IBX=IBX_$J("",(50-$L(IBX)))_$P($G(^DGCR(399.2,+$P(IBLN,U,3),0)),U,1)_"  $ = "
 ... S IBCI=$$FINDCI^IBCRU4(IBCS,+IBBS,IBEFDT,"",IBRVCD)
 ... I +IBCI S IBOCHG=$P($G(^IBA(363.2,+IBCI,0)),U,5),DIR("B")=$FN(IBOCHG,"",2)
 ... S DIR("A")=IBX,DIR(0)="NAO^0:999999:2" D ^DIR K DIR S IBCHG=+Y I IBCHG<1!(IBCHG=IBOCHG) Q
 ... I 'IBCI S IBCI=$$ADDCI^IBCREF(IBCS,+IBBS,IBEFDT,IBCHG,IBRVCD) I +IBCI W ?74,"added" Q
 ... I +IBCI D EDITCI^IBCREF(+IBCI,+IBCHG) W ?74,"edited"
 Q
 ;
NPFRC() ; get the default revenue codes for non-professional inpatient services
 ;
 N IBX,DIC,X,Y,DTOUT,DUOUT,IBY S IBX=0
 W !!,"Enter the Revenue Code to use for all non-professional inpatient services:",!
 S DIC("A")="Room, Board, Nursing Services: ",DIC("B")=101,DIC("S")="I +$P(^(0),U,3)"
 S DIC="^DGCR(399.2,",DIC(0)="AEQ" D ^DIC I Y<1 G NPFRCQ
 S IBY=+Y
 ;
 S DIC("A")="Ancillary Services: ",DIC("B")=240,DIC("S")="I +$P(^(0),U,3)"
 S DIC="^DGCR(399.2,",DIC(0)="AEQ" D ^DIC I Y<1 G NPFRCQ
 S IBX=IBY_U_+Y
 ;
NPFRCQ I 'IBX W !!,"Both of these revenue codes are required for the Inpatient Non-Professional",!,"charges to be added to bills.  Can Not Continue!",!
 Q IBX
 ;
DISP(IBRATE,ARR) ;
 N IBTYP,IBI,IBLN
 W @IOF,!,$P(IBRATE,U,2)," charges effective ",$$FMTE^XLFDT(ARR)," will be added as follows:"
 W !,"Charge Type",?30,"Charge Set",?55,"Rev Code",!,"--------------------------------------------------------------------------------",!
 S IBTYP=0 F  S IBTYP=$O(ARR(IBTYP)) Q:'IBTYP  D
 . W $P(ARR(IBTYP),U,1)
 . S IBI=0 F  S IBI=$O(ARR(IBTYP,IBI)) Q:'IBI  D
 .. S IBLN=ARR(IBTYP,IBI)
 .. W ?30,$P(IBLN,U,1),?55,$P($G(^DGCR(399.2,+$P(IBLN,U,3),0)),U,1),?65,$P(IBLN,U,5),!
 W !,"If any of the revenue codes are incorrect then change the Default Revenue for",!,"the Charge set." W:+IBRATE=1 " (except the non-prof inpt rev codes entered above)"
 W !!,"If any of the Charge Sets are incorrect DO NOT USE this option."
 W !,"This option may NOT be used to delete rates or add zero charges."
 W !!,"The charges will be asked in sections based on the Charge Types listed above."
 W !,"The first section is INPATIENT, enter all Inpatient Bedsections and their"
 W !,"charges, then press return at the Select Bedsection prompt to move to the"
 W !,"OUTPATIENT VISIT section and enter the Outpatient Visit Bedsection and charge..."
 W ! S DIR(0)="E" D ^DIR K DIR
 Q
 ;
GETBS(COL,PROMPT,TYPE) ; ask and return billable bedsection (399.1):  (-1 if ^, 0 if none)  IFN^.01
 ; if type is inpatient then not PRESCRIPTION or OUTPATIENT bedsections can be selected
 ; if type is not inpatient then default bedsections are provided
 N IBX,DIC,DIE,DA,DR,X,Y,DTOUT,DUOUT S IBX=0
 S DIC("S")="I +$P(^(0),U,5)=1"
 I $G(TYPE)=1 S DIC("S")=DIC("S")_",$P(^(0),U,1)'[""OUTPATIENT"",$P(^(0),U,1)'[""PRESCRIPTION"""
 I +$G(TYPE)>1 S DIC("B")=$S(TYPE=3:"PRESCRIPTION",TYPE=4:"OUTPATIENT DENTAL",1:"OUTPATIENT VISIT")
 S DIC("A")=$J("",$G(COL))_"Select "_$G(PROMPT)_" BEDSECTION: "
 S DIC="^DGCR(399.1,",DIC(0)="AENQ" D ^DIC K DIC
 I $D(DTOUT)!($D(DUOUT)) S IBX=-1
 I +Y>0 S IBX=Y
 Q IBX
 ;
MT() ; do the new mt rate format (misc type) eff 12/6/01 ib*2*167
 N IBCS,IBTYPE,IBITEM,IBCI,IBX,IBOCHG,DIR,X,Y,IBCHG,IBERROR
 S IBCS=$$CSN^IBCRU3("TL-MT OPT COPAY"),(IBOCHG,IBERROR)=""
 I 'IBCS W !,"*** Error:  Charge set TL-MT OPT COPAY not found" Q 1
 W !!,"--------------------------------------------------------------------------------"
 W !,"Enter MT OUTPATIENT COPAYMENT charges effective ",$$FMTE^XLFDT(IBEFDT),":"
 W !,"--------------------------------------------------------------------------------"
 F IBTYPE="BASIC CARE","SPECIALTY CARE" D  Q:$L(IBERROR)
 . S IBITEM=+$$ADDBI^IBCREF("MISCELLANEOUS",IBTYPE)
 . I 'IBITEM S IBERROR="*** Error:  Billable Item "_IBTYPE_" not found" Q
 . S IBX=IBTYPE_$J("",(50-$L(IBTYPE)))_"$ ="
 . S IBCI=$$FINDCI^IBCRU4(IBCS,+IBITEM,IBEFDT)
 . I +IBCI S IBOCHG=$P($G(^IBA(363.2,+IBCI,0)),U,5),DIR("B")=$FN(IBOCHG,"",2)
 . S DIR("A")=IBX,DIR(0)="NAO^0:999999:2" D ^DIR K DIR S IBCHG=+Y I IBCHG<1!(IBCHG=IBOCHG) Q
 . I 'IBCI S IBCI=$$ADDCI^IBCREF(IBCS,+IBITEM,IBEFDT,IBCHG) I +IBCI W ?74,"added" Q
 . I +IBCI D EDITCI^IBCREF(+IBCI,+IBCHG) W ?74,"edited"
 W !,IBERROR
 Q $L(IBERROR)
