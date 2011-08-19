SPNPSR00 ;HIRMFO/DAD,WAA-HUNT: UTILITIES ;8/10/95  13:51
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
 ;======================================================================
EN1(ACTION,SEQUENCE,BDATE,EDATE) ; *** Date range
 ; Input:
 ;  ACTION,SEQUENCE = Search ACTION,SEQUENCE number
 ; Output:
 ;  SPNLEXIT = $S( User_Abort/Timeout : 1 , 1 : 0 )
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"BEGINNING DATE") = Date ^ Date_(Ext)
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"ENDING DATE") = Date ^ Date_(Ext)
 ;   BDATE = FM FORMAT BEGINNING DATE
 ;   EDATE.=.FM FORMAT ENDING DATE
 ;
 N DATE,DIR,DIRUT,DTOUT,DUOUT,I
 F I="BEGINNING DATE","ENDING DATE" K ^TMP($J,"SPNPRT",ACTION,SEQUENCE,I)
 K DIR S DIR(0)="DOA^::E"
 S DIR("A")="Beginning date: "
 D ^DIR S DATE("BEGINNING DATE")=Y_U_$G(Y(0))
 S SPNLEXIT=$S($D(DTOUT):1,$D(DUOUT):1,1:0)
 I 'SPNLEXIT,Y'="" D
 . K DIR S DIR(0)="DOA^"_$P(DATE("BEGINNING DATE"),U)_"::E"
 . S DIR("A")="Ending date:   "
 . D ^DIR S DATE("ENDING DATE")=Y_U_$G(Y(0))
 . Q
 S SPNLEXIT=$S($D(DTOUT):1,$D(DUOUT):1,1:0)
 I 'SPNLEXIT,Y'="" D
 . F I="BEGINNING DATE","ENDING DATE" D
 .. S ^TMP($J,"SPNPRT",ACTION,SEQUENCE,I)=DATE(I)
 .. Q
 . S BDATE=$P(DATE("BEGINNING DATE"),U)
 . S EDATE=$P(DATE("ENDING DATE"),U)
 . Q
 Q
 ;======================================================================
EN2 ; *** User entry of the SEARCH criteria
 ; Returns:
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,  -  Search code & parameters
 ;  SPNLSORT  -  1^Patient Name, 2^SSN, 3^Diagnosis
 ;
 S SPNLMAX=3 ; Maximum # of search variables user may select 
 ;
 W !!,"You may choose a maximum of ",SPNLMAX," search variables.",!
 S SPNLEXIT=0 K ^TMP($J,"SPNPRT"),SPNPRT
 F SEQUENCE=1:1:SPNLMAX D  Q:SPNLEXIT
 . S SPNLQUIT=0
 . F  D  Q:SPNLQUIT
 .. K DIC S DIC="^SPNL(154.92,",DIC(0)="AEMNQ"
 .. S DIC("A")="Select SEARCH VARIABLE #"_SEQUENCE_": "
 .. S DIC("S")="I $G(^SPNL(154.92,+Y,1))]"""""
 .. W ! D ^DIC S SPNLD0=+Y
 .. I $D(DTOUT)!$D(DUOUT) S SPNLQUIT=1,SPNLEXIT=2 Q
 .. I SPNLD0'>0 S SPNLQUIT=1,SPNLEXIT=1 Q
 .. I $G(SPNPRT(SPNLD0)) D  Q
 ... W !!?5,"*** You have already chosen that one! ***",$C(7)
 ... Q
 .. S SPNLINQR=$G(^SPNL(154.92,SPNLD0,2)),SPNLEXIT=0
 .. I SPNLINQR]"" X SPNLINQR S SPNLEXIT=$S(SPNLEXIT:2,1:0)
 .. S SPNLQUIT=1
 .. Q
 . I SPNLD0>0,SPNLEXIT'=2 D
 .. S SPNPRT(SPNLD0)=SPNLD0
 .. S ^TMP($J,"SPNPRT",ACTION,SEQUENCE)=$G(^SPNL(154.92,SPNLD0,1))
 .. Q
 . Q
 S SPNLEXIT=$S($O(SPNPRT(0))'>0:1,1:(SPNLEXIT=2))
EN11 ; *** User entry of the SORT criteria
 I SPNLEXIT=0 D
 . K DIR S DIR(0)="SAM^1:PATIENT NAME;2:SSN;3:DIAGNOSIS"
 . S DIR("A")="How do you want the report sorted? ",DIR("B")="PATIENT"
 . W ! D ^DIR S SPNLSORT=Y_U_$G(Y(0)),SPNLEXIT=$S($D(DIRUT):1,1:0)
 . Q
 Q
 ;======================================================================
PAUSE I $E(IOST)="C" K DIR S DIR(0)="E" D ^DIR S SPNLEXIT=$S(Y'>0:1,1:0)
 Q
HEAD I SPNLEXIT Q
 W @IOF
 W !!?26,"SEARCH / SORT SPECIFICATION"
 W !?26,"---------------------------"
 Q
