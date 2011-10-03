SPNLRD ;ISC-SF/GB-SCD PATIENT FOLLOW-UP (LAST SEEN) REPORT ;6/23/95  12:11
 ;;2.0;Spinal Cord Dysfunction;**12,19**;01/02/1997
ASK(QLIST,ABORT) ; Report-specific question
 N DIR,Y,DIRUT,ANS,UNITS,LEN,NUM
 S DIR(0)="154.91,4" ; file #,field # from Site Parameters file
 S DIR("A")="Show patients last seen more than how long ago?"
 S DIR("B")=$P($G(^SPNL(154.91,1,0)),U,5) ; from Site Parameters file
 S:DIR("B")="" DIR("B")="1Y"
 D ^DIR I $D(DIRUT) S ABORT=1 Q
 S ANS=Y,LEN=$L(Y)
 S UNITS=$E(ANS,LEN,LEN)
 S NUM=+ANS
 S UNITS=$S(UNITS="D":"Day",UNITS="W":"Week",UNITS="M":"Month",UNITS="Y":"Year",1:"Unit")_$S(NUM>1:"s",1:"")
 S QLIST("PERIOD")=NUM_" "_UNITS
 S QLIST("SINCE")=$$DATEMATH^SPNLRUDT(DT,"-"_ANS)
 ; Enter a date; Optional; no minimum; the "since" date is the maximum
 ;S DIR(0)="DO^:"_QLIST("SINCE")_":EX"
 S QLIST("LOOK FROM")="2800101" ; Our default
 ;S DIR("A")="Start searching the records from"
 ;S DIR("?")="How far back should we look?"
 ;S DIR("B")="2800101" ; whatever is in the Site Parameters file
 ;D ^DIR I $D(DIRUT) S ABORT=1 Q
 ;S QLIST("LOOK FROM")=Y
 Q
GATHER(DFN,FDATE,TDATE,HIUSERS,QLIST) ;
 D GATHER^SPNLGIFU(DFN,QLIST("LOOK FROM"),DT,QLIST("SINCE")) ; gather follow up loss risks
 Q
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
 S TITLE(4)=$$CENTER^SPNLRU("(Not seen in over "_QLIST("PERIOD")_", since before "_$$DATEFMT^SPNLRUDT(QLIST("SINCE"),TYPEFMT))_")"
 D P1(.TITLE,PAGELEN,.ABORT) Q:ABORT
 Q
P1(TITLE,PAGELEN,ABORT) ;
 N LASTSEEN,PAT
 S TITLE(5)=""
 ;          "         1         2         3         4         5         6"
 S TITLE(6)="Last Seen     Name                               Last Four"
 D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 S LASTSEEN=""
 F  S LASTSEEN=$O(^TMP("SPN",$J,"FU",LASTSEEN)) Q:LASTSEEN=""  D  Q:ABORT
 . S PAT=""
 . F  S PAT=$O(^TMP("SPN",$J,"FU",LASTSEEN,PAT)) Q:PAT=""  D  Q:ABORT
 . . I $Y>PAGELEN D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 . . W !,$S(LASTSEEN=0:"no record",1:$E(LASTSEEN,4,5)_"/"_$E(LASTSEEN,6,7)_"/"_$S($E(LASTSEEN,2)>7:"19"_$E(LASTSEEN,2,3),1:"20"_$E(LASTSEEN,2,3)))
 . . W ?14,$P(PAT,U,1),?52,$P(PAT,U,2)
 Q
