IBDFDEA ;ALB/AAS - AICS Data Entry API ; 19-JUN-96
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
 ;
EN1(PXCA,IBDF) ; -- Procedure
 ; -- supported reference to process encounter form data.
 ;    Packages that know patient, visit date/time, and clinic
 ;    can call this api to use the AICS data entry system to prompt
 ;    users for encounter data and subsequently store this data
 ;    using the PCE device interface (this is done automatically using
 ;    the aics parameters).
 ;    D EN1^IBDFDEA(.RESULTS,.IBDF)
 ;
 ; -- Input:  PXCA, called by reference, the results of processing
 ;            are returned in this array.  See PCE device inteface
 ;            manual for description of data nodes
 ;            IBDF, called by reference
 ;            IBDF("APPT")   :=  Appointment Date Time (required)
 ;            IBDF("DFN")    :=  pointer to patient file (required)
 ;            IBDF("CLINIC") :=  pointer to hospital location file (44)
 ;                               (optional) if clinic not defined and no
 ;                               form printed, no data entry allowed
 ;            IBDF("NOAPPT") :=  (optional) if AICS parameters allow 
 ;                               making follow up appointments, setting
 ;                               this to any non-zero value will suppress
 ;                               the ability to add followup appointments
 ;          IBDF("PROVIDER") :=  (optional) if defined, will be used as
 ;                               primary provider for data entry, use
 ;                               for provider data entry options
 ;
 N %,%H,C,I,J,X,Y,ADD,DEL,ASKOTHER,DIR,DIC,DA,CNT,DFN,DIRUT,DUOUT,DTOUT,POP,RTN,FRMDATA,IBY,IBQUIT,IBDOBJ,IBDPTSTI,IBDPTSTE,IBDPTNM,IBDPTDTI,SEL
 N IBDPTDTE,IBDFMNME,IBDFMIEN,IBDFMSTI,IBDFMSTE,IBDFMIDI,IBDCLNME,IBFORM,IBDCLNPH,IBDPID,IBDPTPRI,IBDSEL,IBDPI,IBDCO,SDCLST,PXCASTAT,PXKNODA,PXKNODB,IBDREDIT,IBDASK,IBDPRE,IBDOK
 N ANS1,AUPNDAYS,AUPNDOB,AUPNDOD,AUPNPAT,AUPNSEX,FORMLST
 ;
 I '$D(IOF) D HOME^%ZIS
 G:'$G(IBDF("DFN")) EN1Q S DFN=IBDF("DFN")
 G:'$G(IBDF("APPT")) EN1Q
 S IBQUIT=0
 ;
 ; -- if no form create entry
 S FORMLST=$$FINDID^IBDF18C(DFN,IBDF("APPT"),"",1)
 I FORMLST="",$G(IBDF("CLINIC")) D ANYWAY^IBDFDE6
 ;
 G:IBQUIT EN1Q
 ;
 I FORMLST F IBDX=1:1 S IBDF("FORM")=$P(FORMLST,"^",IBDX) Q:IBDF("FORM")=""  I IBDF("FORM")'="" D EN^IBDFDE K IBDSEL,IBDPI Q:IBQUIT
 ;
EN1Q Q
 ;
SCANFRM(X) ; is entry scannable
 Q +$P($G(^IBE(357,+$P($G(^IBD(357.95,+$P($G(^IBD(357.96,X,0)),"^",4),0)),"^",21),0)),"^",12)
 ;
DELFT ; -- Delete forms Tracking Entry
 N I,J,IBD,DIR,DIRUT,VALMY,IBDF,IBDNODE,DFN,APPT,IBX,CLN,IBQUIT,FORMID
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) D FULL^VALM1 S IBD=0 F  S IBD=$O(VALMY(IBD)) Q:'IBD!$D(DIRUT)  D
 .S IBDF=$P($G(^TMP("FRMIDX",$J,+IBD)),"^",2)
 .S IBDNODE=$G(^IBD(357.96,+IBDF,0)) I IBDNODE="" W !,"No Form Tracking record associated with entry #",IBD H 2 Q
 .I $D(^XUSEC("IBD MANAGER",DUZ)) D
 ..S IBX=$P(IBDNODE,"^",11) I IBX>1,IBX<20 W !!,"***** Status indicates action has been taken on this entry #"_IBD_" *****"
 ..W !!?25,"*** Entry #"_IBD_" STATUS: "_$S(IBX=1:"PRINTED",IBX=2:"SCANNED",IBX=3:"SCD/PCE",IBX=4:"SCD w/ER",IBX=5:"DENTRY",IBX=6:"DE to PCE",IBX=7:"DE w/ER",IBX=11:"PEND Pgs",IBX=12:"NO TRANS",20:"AVAIL DE",1:"NOT PRNT")_" ***"
 .I '$D(^XUSEC("IBD MANAGER",DUZ)) D
 ..S DFN=$P(IBDNODE,"^",2),APPT=$P(IBDNODE,"^",3),CLN=$P(IBDNODE,"^",10),FORMID=$P(IBDNODE,"^",4)
 ..I $D(^DPT(DFN,"S",APPT,0)),$P(^DPT(DFN,"S",APPT,0),"^",1)=CLN D  ; !,"Entry #"_IBD_" - Nothing Deleted...Deleting entries only allowed for entries not associated with an appointment." H 2 S IBQUIT=1 Q
 ...I $D(^IBD(357.95,FORMID,0)),'$P(^IBD(357.95,FORMID,0),"^",2) W !,"Entry #"_IBD_" - Nothing Deleted...This entry is associated with an appointment,  and is the most current version of the form." H 2 S IBQUIT=1 Q
 ..;I $P(IBDNODE,"^",11)>1,$P(IBDNODE,"^",11)<20 W !,"Status indicates action taken on this entry, deletion not allowed." H 2 Q
 .I '$D(IBQUIT) W ! S DIR(0)="Y",DIR("B")="NO",DIR("A")="Are You Sure you want to delete entry #"_IBD
 .I '$D(IBQUIT) D ^DIR I Y'=1 W !,"Entry #",IBD," not Deleted!" H 2 Q
 .I '$D(IBQUIT) D DP1
 .K IBQUIT
 I '$D(VALMY) G DTQ1
 ;
DTQ K ^TMP("CNT",$J),^TMP("FRM",$J),^TMP("FTRK",$J),^TMP("STATS",$J),^TMP("FRMIDX",$J),^TMP("STAIDX",$J)
 D EXIT1^IBDFFT,START^IBDFFT1
DTQ1 S VALMBCK="R" Q
 ;
DP1 ; -- actual deletion of forms tracking entry
 N DA,DIC,DIK
 S DA=IBDF,DIK="^IBD(357.96," D ^DIK
 W !,"Entry ",IBD," Deleted!"
 Q
