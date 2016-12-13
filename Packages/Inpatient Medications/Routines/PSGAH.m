PSGAH ;ALB/DRP-ADMINISTRATION HISTORY RPT ;29 Oct 2015 12:44 PM
 ;;5.0;INPATIENT MEDICATIONS;**315**;16 DEC 97;Build 73
 ;Per VHA Directive 2004-038 (or future revisions regarding same), this routine should not be modified.
 ;
 ;Call to MEDHIST^PSBUTL controlled by IA 6271
 ;
 Q
 ;Routine is called by Hidden Actions Menu so DFN variable will be passed in from the Menu
INIT ; Initialize Variables
 I '$$PATCH^XPDUTL("PSB*3.0*83") W !,"Report not available until install of patch PSB*3.0*83" S TERM=1 D PAUSE Q
 I ($G(ON)["V") W !,"AH Report cannot be run for this order. Use CPRS or BCMA to find Admin history." S TERM=1 D PAUSE Q
 I ($G(ON)["P"),$P($G(^PS(53.1,+ON,0)),U,4)'["U" W !,"AH Report cannot be run for this order. Use CPRS or BCMA to find Admin history." S TERM=1 D PAUSE Q
 Q:$G(DFN)=""
 N PSGACAR,PSGQ,PSGORD,PSGOIEN,PSGSPCE,PSGMRT,PSGSCH,PSGDRNG,PSGLOC
 N TERM,PSGACT,COUNT,PAGNO,PSGDSG,PSGIN
 N $ESTACK,$ETRAP S $ETRAP="D ERRTRP^PSGAH" ;
 S PSGOIEN=$G(PSGOPD) Q:'PSGOIEN
 S $P(PSGSPCE," ",30)="",COUNT=0
 D ENCV^PSGSETU Q:$D(XQUIT)
 D FULL^VALM1,PRMTRNG,MAIN
 K ^XTMP("PSGAH",$J)
 Q
 ;
MAIN ; Main control
 Q:$G(PSGQ)
 D OPEN^%ZISUTL("PSGAH",,) I $G(POP) W !!,"Nothing queued to print.",! Q
 S:$E(IOSL,1)'["9" TERM=$S($E($G(IOST),1,2)="C-":1,1:0)
 U IO S PAGNO=0
 ;Get OI then get all orders for OI within time frame determined by ?
 D GETHIST D:$D(PSGACAR) GETORD
 D PRNHDR,WRITE
 W !!,"Press RETURN to continue....." R X:$G(DTIME) ;pause before returning to Detail screen
 D CLOSE^%ZISUTL("PSGAH")
 K POP
 Q
 ;
GETORD ; Get order information
 N I,STR,PSGCUR S I=0
 F  S I=$O(PSGACAR(I)) Q:'I  D
 . S STR=PSGACAR(I),PSGCUR=0,PSGIN=$P(STR,U,6),PSGLOC=$P(STR,U,5)
 . S PSGORD=+$P(STR,U,3),PSGACT=$P(STR,U,2) S:PSGORD=+$G(ON) PSGCUR=1 ;ON passed in from Menu
 . S PSGMRT=$P($G(^PS(55,DFN,5,PSGORD,0)),U,3),PSGMRT=$P(^PS(51.2,PSGMRT,0),U,1)
 . S PSGSCH=$P($G(^PS(55,DFN,5,PSGORD,2)),U,1)
 . S PSGDSG=$P($G(^PS(55,DFN,5,PSGORD,.2)),U,2)
 . D SETTMP(I)        ;check and then set ^XTMP for sort
 .Q
 Q
 ;
GETHIST ; Get last 99 actions for each OI Dosage
 ;MEDHIST(LIST,DFN,OI,MAX) ;Last nn admin actions per a patients Orderable Item
 ; Input:
 ;   DFN - Patient num
 ;   OI  - Inpatient Meds Orderable Item ien
 ;   MAX - Max days back to search
 ; Output:
 ;   LIST - Array of actions formatted as :
 ;     DATE^ACTION^ORDNO^LSTSITE^LOCATION^NURSINITL
 D MEDHIST^PSBUTL(.PSGACAR,DFN,PSGOIEN,PSGDRNG) ;ZW PSGACAR
 Q
 ;
 ;The following items were requested for this new report:  
 ;Dose. 
 ;All administrations for the Orderable Item
 ;Sorted by time. 
 ;Grouped by all administrations by orderable item for that patient.
SETTMP(ORDDT) ; Builds ^XTMP for sort
 S ^XTMP("PSGAH",$J,ORDDT,PSGORD)=PSGDSG_U_PSGMRT_U_PSGSCH_$S(PSGCUR:"-Current",1:"")_U_PSGACT_U_PSGIN_U_PSGLOC
 Q
 ;
WRITE ; WRITE records to output
 ;        "DOSAGE ORDERD"_" "_MED ROUTE (INTERNAL)_" "_SCHEDULE(INTERNAL)_$S(CURRENT ORDER:"(*)",1:"")
 N DATE,ORDER,STR S DATE=9999999
 F  S DATE=$O(^XTMP("PSGAH",$J,DATE),-1) Q:DATE=""!$G(PSGQ)  D
 . S ORDER=0
 . F  S ORDER=$O(^XTMP("PSGAH",$J,DATE,ORDER)) Q:ORDER=""!$G(PSGQ)  D
 ..S STR=^XTMP("PSGAH",$J,DATE,ORDER),PSGDSG=$P(STR,U,1),PSGMRT=$P(STR,U,2),PSGSCH=$P(STR,U,3),PSGACT=$P(STR,U,4)
 ..S PSGIN=$P(STR,U,5),PSGLOC=$P(STR,U,6)
 ..D PRNLN
 ..Q
 .Q
 Q
 ;
PRNHDR ; Heading
 Q:$G(PSGQ)
 S PAGNO=PAGNO+1
 W @IOF
 W ! W:'$G(TERM) ?5 W $E($$FMTE^XLFDT($$NOW^XLFDT),1,18)
 W ! W:'$G(TERM) ?5 W "Administration History for Orderable Item ",?73,"Page ",PAGNO
 W ! W:'$G(TERM) ?10 W $G(PSGOPDN)
 W ! W:'$G(TERM) ?5 W "Date             Action  Initials Location"
 W ! W:'$G(TERM) ?8 W "Dosage Ordered                  Med Route     Schedule"
 W ! W:'$G(TERM) ?5 W "---------------------------------------------------------------------------"
 Q
 ;
PRNLN ;Write line on report
 ;N ACTLBL S ACTLBL=$S(COUNT:"PREVIOUS ACTION "_COUNT_" ",1:"LAST ACTION: ")
 W ! W:'$G(TERM) ?5 W $E($P($$FMTE^XLFDT(DATE,5),":",1,2)_PSGSPCE,1,16)_" "_$E(PSGACT_PSGSPCE,1,6)_"  "_$E(PSGIN_PSGSPCE,1,8)_" "_$G(PSGLOC,"UNKNOWN")
 W ! W:'$G(TERM) ?8 W $E(PSGDSG_PSGSPCE,1,30)_"  "_$E(PSGMRT_PSGSPCE,1,12)_"  "_$E(PSGSCH_PSGSPCE,1,30),!
 S COUNT=COUNT+1
 I $Y>(IOSL-2) D:$G(TERM) PAUSE D PRNHDR
 Q
 ;
PAUSE Q:'($G(TERM))
 N X
 U IO(0) W !!,"Press RETURN to continue, '^' to exit"
 R X:$G(DTIME) I (X="^")!('$T) S PSGQ=1 Q
 U IO
 Q
PRMTRNG ; prompt for number of Days back to return
 K DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="N^1:99999:0"
 S DIR("A")="Enter Number of days back to search",DIR("B")="14"
 S DIR("?")="Enter an  '^' to exit this option now."
 S DIR("?",1)="Enter the number days prior to today to search the BCMA MEDICATION LOG"
 S DIR("?",2)="All BCMA orders within indicated range will be included"
 S DIR("?",3)=""
 S DIR("?",4)=""
 D ^DIR S PSGDRNG=$S($D(DIRUT):0,1:Y) S:$D(DIRUT) PSGQ=1
 K DIR,DIRUT,Y
 Q
 ;
ERRTRP ; Error trap processing
 N Z,PROBLEM
 S Z(1,1)=$$EC^%ZOSV ; mumps error location and description
 S Z="A SYSTEM ERROR HAS BEEN DETECTED AT THE FOLLOWING LOCATION"
 S PROBLEM=7
 D ^%ZTER ; record the error in the trap
 G UNWIND^%ZTER ; unwind stack levels
 Q
