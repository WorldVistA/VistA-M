SPNLRB ;ISC-SF/GB-SCD PATIENT BREAKDOWN REPORT ;6/23/95  11:53
 ;;2.0;Spinal Cord Dysfunction;**6,20**;01/02/1997
ASK(QLIST,ABORT) ; Report-specific question
 N DIR,Y,DIRUT
 S DIR(0)="YAO" ; Answer yes or no
 S DIR("A")="Include deceased patients?  "
 S DIR("B")="NO"
 S DIR("?")="Should the report statistics include deceased patients?"
 D ^DIR I $D(DIRUT) S ABORT=1 Q
 S QLIST("INCLUDE DEAD")=Y
 W !
 S DIR(0)="YAO" ; Answer yes or no
 S DIR("A")="Include only those patients seen during a specified period?  "
 S DIR("B")="NO"
 S DIR("?")="Should the report statistics be limited to a certain time period?"
 D ^DIR I $D(DIRUT) S ABORT=1 Q
 S QLIST("WINDOW")=Y
 Q
GATHER(DFN,FDATE,TDATE,HIUSERS,QLIST) ;
 D GATHER^SPNLGRPS(DFN,FDATE,TDATE,.QLIST) ; gather patient statistics
 Q
PRINT(FACNAME,XFDATE,XTDATE,HIUSERS,QLIST,ABORT) ;
 ; PAGELEN   Number of lines per page
 ; TITLE     Array of header lines (titles)
 N TITLE,PAGELEN,PATDESC,SEXLIST,SEX,NUMSEX
 S PAGELEN=IOSL-3
 I QLIST("INCLUDE DEAD") S PATDESC="Patients"
 E  S PATDESC="Patients Currently Alive"
 S TITLE(1)=$$CENTER^SPNLRU("SCD-Registry Patient Breakdown")
 S TITLE(2)=$$CENTER^SPNLRU(FACNAME)
        I $D(SPNLTRM1) S TITLE(2.5)=$$CENTER^SPNLRU(SPNLTRM1)
 I QLIST("WINDOW") S TITLE(3)=$$CENTER^SPNLRU(PATDESC_" Seen During the Period "_XFDATE_" to "_XTDATE)
 E  S TITLE(3)=$$CENTER^SPNLRU(PATDESC)
 S TITLE(4)=""
 S TITLE(5)=$$PAD^SPNLRU(" ",41)
 S SEX=""
 F NUMSEX=0:1 S SEX=$O(^TMP("SPN",$J,"PS","SEX",SEX)) Q:SEX=""  D
 . S SEXLIST(SEX)=""
 . S TITLE(5)=TITLE(5)_$J($S(SEX="F":"Female",SEX="M":"Male",1:"Unknown"),10)
 S:NUMSEX>1 TITLE(5)=TITLE(5)_$J("Total",10)
 D P1^SPNLRB1(.TITLE,PAGELEN,.SEXLIST,.QLIST,.ABORT) Q:ABORT
 D P2^SPNLRB1(.TITLE,PAGELEN,.SEXLIST,.QLIST,.ABORT) Q:ABORT
 D P3^SPNLRB1(.TITLE,PAGELEN,.SEXLIST,.QLIST,.ABORT) Q:ABORT
 D P4^SPNLRB1(.TITLE,PAGELEN,.SEXLIST,.QLIST,.ABORT) Q:ABORT
 D P5^SPNLRB1(.TITLE,PAGELEN,.SEXLIST,.QLIST,.ABORT) Q:ABORT
 D P6^SPNLRB1(.TITLE,PAGELEN,.SEXLIST,.QLIST,.ABORT) Q:ABORT
 D P7^SPNLRB1(.TITLE,PAGELEN,.SEXLIST,.QLIST,.ABORT) Q:ABORT
 Q
