QANDBASE ;WCIOFO/ERC - TEST FOR BAD RECORDS IN ^QA(742 ;9/20/99
 ;;2.0;Incident Reporting;;*26*;08/07/1992
 S QANSIT=$P(^QA(740,1,0),U)
 S QANSIT=$P(^DIC(4,QANSIT,0),U)
 S QANCNT=1
 N QANCC,QANEE,QANRR
 S QANFLG=0
START ; use date cross-reference to determine starting record in 742
 S QANSTART=2990501 ; use date before QAN27
 S QANSTART=$O(^QA(742.4,"BDT",QANSTART)) Q:QANSTART'>0  D
 . S QANEE=$O(^QA(742.4,"BDT",QANSTART,0)) Q:QANEE'>0  D
 . . S QANCC=$O(^QA(742,"BCS",QANEE,0)) Q:QANCC'>0  D 742
 Q
742 ; loop through 742, using QANCC as first record
 S QANRR=QANCC-1
 F  S QANRR=$O(^QA(742,QANRR)) Q:QANRR'>0  D
 . D NOZERO
 . D NO7424
 I $G(QANFLG)=0 S QANTXT(QANCNT)="No records in file 742 with missing .01 field.",QANCNT=QANCNT+1
 S QANTXT(QANCNT)="Last entry in file 742 is "_$P(^QA(742,0),U,3)
 D MAIL
 Q
NOZERO ; check for .01 FIELD
 I $P(^QA(742,QANRR,0),U)']"" S QANTXT(QANCNT)="File 742 record #"_QANRR_" is bad - no .01 Field" S QANFLG=1,QANCNT=QANCNT+1
 Q
NO7424 ; sub-routine will check entries in 742 for valid pointer to 742.4
 S QAN7424=$P(^QA(742,QANRR,0),U,3) Q:$G(QAN7424)']""
 I '$D(^QA(742.4,QAN7424,0)) D
 . S QANTXT(QANCNT)="File 742 record #"_QANRR_" points to a non-existent record in file 742.4.",QANCNT=QANCNT+1
 . S DFN=$P(^QA(742,QANRR,0),U)
 . D DEM^VADPT
 . S QANTXT(QANCNT)="    Patient for file 742 record #"_QANRR_" is "_VADM(1),QANCNT=QANCNT+1
 . K DFN,VADM
 Q
MAIL ;
 N DIFROM,XMROU
 D KILL^XM
 S XMDUZ=.5,XMY(DUZ)=""
 S XMTEXT="QANTXT("
 S XMY("CURTIN,EDNA@FORUM.VA.GOV")=""
 S XMSUB="QAN FILE 742 REPORT - "_QANSIT
 D ^XMD
 D KILL^XM
KILL ;
 K QAN7424,QANCNT,QANFLG,QANSIT,QANSTART,QANTXT
 K XMDUZ,XMTEXT,XMY
 Q
