XDRRMRG2 ;SF-IRMFO/GB,JLI - GET PATIENT HEALTH SUMMARY ;06/26/98  13:35
 ;;7.3;TOOLKIT;**23,29**;Apr 25, 1995
 ;;
ASK(QLIST,ABORT) ; Report-specific questions
 N DIC,Y,DTOUT,DUOUT
 ; Which patient?
 ; S DIC="^SPNL(154,"
 ; S DIC("S")="I $P(^(0),U,3)=""A"""  ; Select only from active patients
 ; S DIC(0)="AEQM"
 ; S DIC("A")="Select SCD Patient:  "
 ; S DIC("?")="Select the patient for whom you want the Health Summary"
 ; D ^DIC I $D(DTOUT)!($D(DUOUT))!(Y<0) S ABORT=1 Q
 ; S QLIST("DFN")=+Y     ; IEN's are DINUM'd to the ^DPT
 K DIC
 ; Which Health Summary Type?
 S DIC="^GMT(142,"
 S DIC(0)="AEQM"
 S DIC("A")="Select Health Summary Type Name:  "
 ;S DIC("?")="Choose one, if you aren't sure, experiment!"
 D ^DIC I $D(DTOUT)!($D(DUOUT))!(Y<0) S ABORT=1 Q
 S QLIST("TYPE")=+Y
ASKX Q
 ;
GATHER(DFN,FDATE,TDATE,HIUSERS,QLIST) ; No need to gather
 Q
 ;
PRINT(QLIST) ;Call to print health summary
 D ENX^GMTSDVR(QLIST("DFN"),QLIST("TYPE"))
PRINTX Q
 ;
PRINT2 ;Prints the record pair using the Browser of to a device.
 N XDRIOP
 W ! S DIR(0)="Y",DIR("A",1)="Would you like to use the FM Browser to"
 S DIR("A")="view the record pair"
 S DIR("B")="YES",DIR("?")="You may use FM Browser to view the record pair else you will be prompted to select a device for each record."
 D ^DIR S:Y=1 XDRIOP=1 Q:$D(DIRUT)
 K ^TMP("XDRRMRG1",$J),^TMP("XDRRMRG",$J)
 ;S IOP="XDRBROWSER1" D ^%ZIS Q:POP  ;Old code, delete after testing
REC1 S:$D(XDRIOP) IOP="XDRBROWSER1" S:'$D(XDRIOP) %ZIS="QM"
 S %ZIS("A")="DEVICE FOR FIRST RECORD: "
 W ! D ^%ZIS Q:POP
 I $D(IO("Q")) D  G REC2 ;Will queue to TaskMan
 . S ZTRTN="QUEUE^XDRRMRG2",ZTIO=ION,ZTDESC="XDR Health Summary for first patient."
 . S DFN=DFNFRX,TYPE=QLIST("TYPE"),ZTSAVE("DFN")="",ZTSAVE("TYPE")=""
 . D ^%ZTLOAD W:$D(ZTSK) !!,"Queued as task "_ZTSK,!
 . Q
 U IO(0) W:$D(XDRIOP) "    Getting first entry ",!
 D ENX^GMTSDVR(DFNFRX,QLIST("TYPE"))
 U IO D ^%ZISC
 S ^TMP("XDRRMRG",$J,"ENTER <PF1>S  TO VIEW OTHER- "_$E($G(DFNFR(1)),1,30)_"  "_$G(DFNFR(2))_" ("_DFNFRX_")")="^TMP(""XDRRMRG1"",$J,1)"
 M ^TMP("XDRRMRG1",$J,1)=^TMP("DDB",$J)
 ;S IOP="XDRBROWSER1" D ^%ZIS Q:POP  ;old code delete after testing
REC2 S:$D(XDRIOP) IOP="XDRBROWSER1" S:'$D(XDRIOP) %ZIS="QM"
 S %ZIS("A")="DEVICE FOR SECOND RECORD: "
 W ! D ^%ZIS Q:POP
 I $D(IO("Q")) D  G PRINTX ;Will queue to TaskMan
 . S ZTRTN="QUEUE^XDRRMRG2",ZTIO=ION,ZTDESC="XDR Health Summary for second patient."
 . S DFN=DFNTOX,TYPE=QLIST("TYPE"),ZTSAVE("DFN")="",ZTSAVE("TYPE")=""
 . D ^%ZTLOAD W:$D(ZTSK) !!,"Queued as task "_ZTSK,!
 . Q
 U IO(0) W:$D(XDRIOP) "     Getting second entry ",!
 D ENX^GMTSDVR(DFNTOX,QLIST("TYPE"))
 D ^%ZISC U IO(0)
 S ^TMP("XDRRMRG",$J,"ENTER <PF1>S  TO VIEW OTHER- "_$E($G(DFNTO(1)),1,30)_"  "_$G(DFNTO(2))_" ("_DFNTOX_")")="^TMP(""XDRRMRG1"",$J,2)"
 M ^TMP("XDRRMRG1",$J,2)=^TMP("DDB",$J)
 D DOCLIST^DDBR($NA(^TMP("XDRRMRG",$J)),"R")
 K ^TMP("XDRRMRG1",$J),^TMP("XDRRMRG",$J)
PRINT2X Q
 ;
QUEUE ;Will process the print task for patients' health summaries.
 D ENX^GMTSDVR(DFN,TYPE)
QUEUEX Q
 ;
COUNT(XDRFILE,FROM,TO)  ;
 N X,I,FIL1,FIL2,NOD,PIECE,X1,X2,N1,N2
 S N1=0,N2=0
 S FIL2=^DIC(XDRFILE,0,"GL")
 S FIL1=FIL2_"FROM)"
 S FIL2=FIL2_"TO)"
 F I=0:0 S I=$O(^DD(XDRFILE,I)) Q:I'>0  S X=^(I,0) D
 . S NOD=$P($P(X,U,4),";")
 . S PIECE=$P($P(X,U,4),";",2)
 . I PIECE>0 D
 . . S X1=$P($G(@FIL1@(NOD)),U,PIECE)
 . . S X2=$P($G(@FIL2@(NOD)),U,PIECE)
 . . I X1'="",X2="" S N1=N1+1
 . . I X2'="",X1="" S N2=N2+1
COUNTX Q $S(N1>N2:2,N2>N1:1,1:0)
 ;
LABIEN(FILE,REC) ;REM - Resolve LABs DFNFR and DFNTO.
 S NAMREC=""
 S FILDIC=$G(^DIC(FILE,0,"GL")) Q:FILDIC="" NAMREC
 S FILREC=FILDIC_"REC)"
 S NAMREC=+$P(@FILREC@(0),U,3)
LABIENX Q NAMREC
