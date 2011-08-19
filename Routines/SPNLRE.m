SPNLRE ;ISC-SF/GB,SD/WDE SCD PT FOLLOW-UP (LAST ANNUAL EVAL) REPORT ;4/29/98
 ;;2.0;Spinal Cord Dysfunction;**3,6,12,19**;01/02/1997
ASK(QLIST,ABORT) ; Report-specific question
 N DIR,Y,DIRUT,ANS,UNITS,LEN,NUM
 S DIR(0)="154.91,5" ; file #,field # from Site Parameters file
 S DIR("A")="Show Pts whose Last Annual Rehab Eval was more than how long ago"
 S DIR("B")=$P($G(^SPNL(154.91,1,0)),U,6) ; from Site Parameters file
 S:DIR("B")="" DIR("B")="1Y"
 D ^DIR I $D(DIRUT) S ABORT=1 Q
 S ANS=Y,LEN=$L(Y)
 S UNITS=$E(ANS,LEN,LEN)
 S NUM=+ANS
 S UNITS=$S(UNITS="D":"Day",UNITS="W":"Week",UNITS="M":"Month",UNITS="Y":"Year",1:"Unit")_$S(NUM>1:"s",1:"")
 S QLIST("PERIOD")=NUM_" "_UNITS
 S QLIST("SINCE")=$$DATEMATH^SPNLRUDT(DT,"-"_ANS)
 Q
GATHER(DFN,FDATE,TDATE,HIUSERS,QLIST) ;
 ; DFN       Patient's internal entry number in the Patient file
 ; FDATE     "From" date
 ; TDATE     "Thru" date, default=today
 ; Gathers patients who have not been seen since the SINCE date.
 ; Data will be placed into the following global:
 ; ^TMP("SPN",$J,"FU",
 ; with the following nodes:
 ; date last rehab eval,name^ssn)    =""
 N VADM,VA,ISDEAD,SSNLAST4,NAME,LASTEVAL
 S LASTEVAL=$$ARD(DFN)
 Q:LASTEVAL=""
 Q:LASTEVAL'<QLIST("SINCE")
 D DEM^VADPT ; Get patient demographics
 ; We will ignore dead patients 
 S ISDEAD=+$P($G(VADM(6)),U,1)
 Q:ISDEAD
 S NAME=VADM(1)
 S SSNLAST4=VA("BID")
 S ^TMP("SPN",$J,"FU",LASTEVAL,NAME_"^"_SSNLAST4)=""
 Q
ARD(DFN) ;Get the latest annual rehab date
 I '$O(^SPNL(154,DFN,"REHAB",0)) Q ""
 N X,DAT1,DAT2
 ; This subroutine will find the most current annual rehab received
 S (X,DAT1,DAT2)=0
 F  S X=$O(^SPNL(154,DFN,"REHAB",X)) Q:X<1  D
 .Q:'$D(^SPNL(154,DFN,"REHAB",X,0))
 .S DAT2=$P(^SPNL(154,DFN,"REHAB",X,0),U,2)
 .I DAT2>DAT1 S DAT1=DAT2
 .Q
 Q DAT1
 ;
PRINT(FACNAME,XFDATE,XTDATE,HIUSERS,QLIST,ABORT) ;
 ; PAGELEN   Number of lines per page
 ; TITLE     Array of header lines (titles)
 N TITLE,PAGELEN
 S PAGELEN=IOSL-3
 S TYPEFMT=4
 S TITLE(1)=$$CENTER^SPNLRU("SCD - Patient Follow Up")
 S TITLE(2)=$$CENTER^SPNLRU(FACNAME)
 I $D(SPNLTRM1) S TITLE(2.5)=$$CENTER^SPNLRU(SPNLTRM1)
 S TITLE(3)=$$CENTER^SPNLRU("Patients at Risk of Loss to Follow Up")
 S TITLE(4)=$$CENTER^SPNLRU("(Last Annual Rehab Eval Received over "_QLIST("PERIOD")_" ago, before "_$$DATEFMT^SPNLRUDT(QLIST("SINCE"),TYPEFMT))_")"
 D P1(.TITLE,PAGELEN,.ABORT) Q:ABORT
 Q
P1(TITLE,PAGELEN,ABORT) ;
 N LASTEVAL,PAT
 S TITLE(5)=""
 ;          "         1         2         3         4         5         6"
 S TITLE(6)="Last Eval     Name                               Last Four"
 D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 S LASTEVAL=""
 F  S LASTEVAL=$O(^TMP("SPN",$J,"FU",LASTEVAL)) Q:LASTEVAL=""  D  Q:ABORT
 . S PAT=""
 . F  S PAT=$O(^TMP("SPN",$J,"FU",LASTEVAL,PAT)) Q:PAT=""  D  Q:ABORT
 . . I $Y>PAGELEN D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 . . W !,$S(LASTEVAL=0:"no record",1:$E(LASTEVAL,4,5)_"/"_$E(LASTEVAL,6,7)_"/"_$S($E(LASTEVAL,2)>7:"19"_$E(LASTEVAL,2,3),1:"20"_$E(LASTEVAL,2,3)))
 . . W ?14,$P(PAT,U,1),?52,$P(PAT,U,2)
 Q
