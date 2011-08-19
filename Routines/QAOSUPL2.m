QAOSUPL2 ;HISC/DAD-GENERATE SUMMARY OF OS UPLOAD BULLETIN ;10/7/93  11:01
 ;;3.0;Occurrence Screen;**3**;09/14/1993
EN ;
 D KILL^XM
 S XMSUB="SUMMARY OF OCCURRENCE SCREEN"
 S XMDUZ=QAOSSITE,XMTEXT="QAOSUPLD("
 S XMY(QAOSSERV_"@"_QAOSDOM)=""
ASKMAIL ;
 W @IOF
 W !,"Reporting period: ",QAQ2HED
 W !!,"Results of Reliability Assessments."
 W !?5,"Date clinical review reliability assessment completed:"
 S Y=QAOSRELY("C",1) X ^DD("DD") W ?69,$S(Y]"":Y,1:"N/A")
 W !?5,"Percentage agreement found:"
 S Y=QAOSRELY("C",2) W ?69,$S(Y]"":$J(Y,6,2)_"%",1:"N/A")
 W !?5,"Date peer review reliability assessment completed: "
 S Y=QAOSRELY("P",1) X ^DD("DD") W ?69,$S(Y]"":Y,1:"N/A")
 W !?5,"Percentage agreement found:"
 S Y=QAOSRELY("P",2) W ?69,$S(Y]"":$J(Y,6,2)_"%",1:"N/A")
 W !!,"Facility Workload Data."
 W !?5,"Number of admissions to acute care by bed section."
 W !?10,"Medicine (Include Neurology, exclude Intermediate Med.):"
 S Y=QAOSWORK(1) W ?66,$S(Y]"":$J(Y,6),1:"   N/A")
 W !?10,"Surgery:" S Y=QAOSWORK(2) W ?66,$S(Y]"":$J(Y,6),1:"   N/A")
 W !?10,"Psychiatry:" S Y=QAOSWORK(3) W ?66,$S(Y]"":$J(Y,6),1:"   N/A")
 W !?5,"Number of ""Unscheduled"" and ""10-10"" ambulatory care visits:"
 S Y=QAOSWORK(4) W ?66,$S(Y]"":$J(Y,6),1:"   N/A")
 W !?5,"Number of surgical procedures performed:"
 S Y=QAOSWORK(7) W ?66,$S(Y]"":$J(Y,6),1:"   N/A")
 ;
 W !!,"WARNING: This data will overwrite your pre-existing data"
 W !,"         at the NQADB for this semi-annual period !!"
 W !!,"Ready to send the ",XMSUB," data to the National Quality"
 W !,"Assurance DataBase (NQADB) at ",QAOSSERV,"@",QAOSDOM
 W !,"OK to send" S %=2 D YN^DICN G:(%=-1)!(%=2) EXIT
 I '% W !!?5,"Please answer Y(es) or N(o) " R QA:5 G ASKMAIL
 W !,"Sending . . ." D BUILD,^XMD
EXIT ;
 K %,ERROR,QA,QAOERROR,QAOSDATA,QAOSDOM,QAOSLIST,QAOSSCRN,QAOSSEQ
 K QAOSSERV,QAOSSITE,QAOSSTNO,QAOSUPLD,QAOSZERO,QAO,QAOS,QAOSCLIN,QAOSCRN
 K QAOSD0,QAOSDATE,QAOSFIND,QAOSLINE,QAOSMGMT,QAOSNUM,QAOSPEER,QAOSRELY
 K QAOSRFPR,QAOSSPEC,QAOSWORK,QAOFINAL,QAOSACTN,QAOSCREV,QAOSD1,QAOSHOSP
 K QAOSLEVL,QAOSRV,QAOSS1,QAOSS2,QAOSSTAT,QAOSTEMP,QAOSWARD,SERV
 K ^UTILITY($J,"QAOSPSM"),^UTILITY($J,"QAOSXREF"),^UTILITY($J,"QAOSPEND")
 D K^QAQDATE,KILL^XM S:$D(ZTQUEUED) ZTREQ="@"
 Q
BUILD ;
 S QAOSLIST(0)="1," D ^QAOSPSM0
 K QAOSUPLD S QAOSLINE=1
SERVER ;
 S QAOSUPLD(QAOSLINE)="^^QAO0^",QAOSLINE=QAOSLINE+1
SITE ;
 S QAOSUPLD(QAOSLINE)="SITE",QAOSLINE=QAOSLINE+1
 S QAOSUPLD(QAOSLINE)=QAOSSTNO_"^"_QAOSSITE_"^"_QAQNBEG_"^"_QAQNEND_"^"
 S QAOSLINE=QAOSLINE+1
RELY ;
 S QAOSUPLD(QAOSLINE)="RELY",QAOSLINE=QAOSLINE+1
 S X=QAOSRELY("C",1)_"^"_QAOSRELY("C",2)_"^"
 S X=X_QAOSRELY("P",1)_"^"_QAOSRELY("P",2)_"^"
 S QAOSUPLD(QAOSLINE)=X,QAOSLINE=QAOSLINE+1
WORK ;
 S QAOSUPLD(QAOSLINE)="WORK",QAOSLINE=QAOSLINE+1,X=""
 F QA=1:1:7 S X=X_QAOSWORK(QA)_"^"
 S QAOSUPLD(QAOSLINE)=X,QAOSLINE=QAOSLINE+1
ACTN ;
 S QAOSUPLD(QAOSLINE)="ACTN",QAOSLINE=QAOSLINE+1,X=""
 F QA=8:1:22 S X=X_QA_";"_+$G(QAOSACTN("N",QA))_"^"
 S QAOSUPLD(QAOSLINE)=X,QAOSLINE=QAOSLINE+1
SCRN ;
 S QAOSUPLD(QAOSLINE)="SCRN",QAOSLINE=QAOSLINE+1,QAOSSEQ=0
 F  S QAOSSEQ=$O(^UTILITY($J,"QAOSPSM","N",QAOSSEQ)) Q:QAOSSEQ'>0  D
 . S QAOSDATA=^UTILITY($J,"QAOSPSM","N",QAOSSEQ)
 . S QAOSSCRN=$P(QAOSDATA,"^")
 . S X=QAOSSCRN_"^"
 . F QA=2:1:9 S X=X_+$P(QAOSDATA,"^",QA)_"^"
 . I "^1^4^"[("^"_QAOSSEQ_"^") S QAOSSPEC="1^2^3^4^5"
 . I QAOSSEQ=2 S QAOSSPEC="N/A^N/A^N/A^N/A^5"
 . I QAOSSEQ=3 S QAOSSPEC="N/A^2^N/A^N/A^2"
 . S X=X_$$SERVICE(QAOSSEQ,QAOSSPEC)_"^"
 . S QAOSUPLD(QAOSLINE)=X,QAOSLINE=QAOSLINE+1
 . Q
 Q
 ;
SERVICE(SEQUENCE,PATTERN) ;
 N QA F QA=1:1:5 D
 . S PATTERN(0)=$P(PATTERN,"^",QA)
 . Q:PATTERN(0)="N/A"
 . S $P(PATTERN,"^",QA)=+$P($G(QAOSRV("N",SEQUENCE)),"^",PATTERN(0))
 . Q
 Q PATTERN
