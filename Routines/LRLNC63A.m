LRLNC63A ;DALOI/FHS-HISTORICAL LOINC MAPPER UTILITY ;01/30/2001 15:19
 ;;5.2;LAB SERVICE;**279**;Sep 27, 1994
XQA ;Send alert message
 S XQA("G.LMI")=""
 D SETUP^XQALERT
 Q
RANGE ; Change for high/low ranges $S( statement to a numeric value
 K LRP,VAL,VALX
 I 'LR5 S AGE=+$$DATE^LRDAGE(DOB,LRCDT) I AGE<1 S AGE=99
 F LRP=2:1:5 D
 . S VAL=$P(LRDATA5,"!",LRP)
 . Q:'$L(VAL)
 . Q:VAL'["$S("
 . S VALX="S VALX="_VAL
 . X VALX
 . S $P(LRDATA5,"!",LRP)=VALX,LR5=1
 Q
XTMP(LRSUB) ;Setup XTMP("LRLNC",1,LRSUB)=Result NLT code
 Q:$D(^XTMP("LRLNC63",1,LRSUB))
 N LRCHK,LRTST
 S (LRCHK,LRTST)=0
 F  S LRTST=$O(^LAB(60,"C","CH;"_LRSUB_";1",LRTST)) Q:LRTST<1!($G(LRCHK))  D
 . Q:'$P($G(^LAB(60,LRTST,64)),U,2)
 . S ^XTMP("LRLNC63",1,LRSUB)=$$NLT(LRTST),LRCHK=^(LRSUB)
 I '$G(LRCHK) S ^XTMP("LRLNC63",1,LRSUB)="-1"
 Q
NLT(X) ;
 N Y
 S Y=$S($D(^LAM(+$P($G(^LAB(60,+X,64)),U,2),0)):$P(^(0),U,2),1:"")
 Q Y
LIST ;List those test not have result NLT codes defined
 K ^TMP("LRLNC63",$J)
 N LRANS,LRSB,LRCNT,LRX
 S ^TMP("LRLNC63",$J,"LST",1,0)="List of tests missing RNLT codes in LABORTORY TEST (#60) file,"
 S ^TMP("LRLNC63",$J,"LST",2,0)="found during LOINC Historical Mapping process."
 S ^TMP("LRLNC63",$J,"LST",3,0)="These test(s) will have no historical LOINC mapping performed."
 S ^TMP("LRLNC63",$J,"LST",4,0)="  "
 S ^TMP("LRLNC63",$J,"LST",5,0)="[Test IEN]  Test Name  Type "
 S ^TMP("LRLNC63",$J,"LST",6,0)=""
 S LRCNT=6,LRSB=0 F  S LRSB=$O(^XTMP("LRLNC63",1,LRSB)) Q:LRSB<1  S LRX=^(LRSB) D
 . Q:LRX>0
 . S LRCH="CH;"_LRSB_";1",LRTST=0
 . F  S LRTST=$O(^LAB(60,"C",LRCH,LRTST)) Q:LRTST<1  D
 . . Q:'$D(^LAB(60,LRTST,0))#2
 . . N LRANS,LRV,LRANS
 . . S LRV=LRTST_","
 . . D GETS^DIQ(60,LRV,".01;3","E","LRANS")
 . . S LRCNT=LRCNT+1
 . . S ^TMP("LRLNC63",$J,"LST",LRCNT,0)="["_LRTST_"] "_$G(LRANS(60,LRV,.01,"E"))_" -- Type: "_$G(LRANS(60,LRV,3,"E"))
MAIL ;Send mail message containing tests not having RNLT codes.
 ;Therefore not historical LOINC mapping could be done.
 D
 . I '$O(^TMP("LRLNC63",$J,"LST",6)) D
 . . S ^TMP("LRLNC63",$J,"LST",7,0)="Negative Report - All test have RNLT codes definded"
 . N XMDUZ,XMTEXT,XMY,XMSUB
 . S XMSUB="LOINC Historical Mapping Exception Report"
 . S XMTEXT="^TMP(""LRLNC63"","_$J_",""LST"","
 . S XMDUZ=.5
 . S XMY("G.LMI")=""
 . D ^XMD
MAP ;Provide a list of mapped test in ^ delimited format
 N NODE,LRSB,LRNLT,LRSPECN,LRCDEF,LRLNC,LRTST
 S LRMCNT=0
 S ^TMP("LRLNC63",$J,"MAP",1,0)="List of test mapped to LOINC codes formatted with '^' as field delimiter."
 S ^TMP("LRLNC63",$J,"MAP",2,0)=" "
 S ^TMP("LRLNC63",$J,"MAP",3,0)="DataName#^Test Name^Specimen^Specimen IEN^RNLT^NLT suffix^LOINC Code"
 S LRMCNT=3
 S NODE="^XTMP(""LRLNC63"","_$J_",""MAP"")"
 F  S NODE=$Q(@NODE) Q:$QS(NODE,2)'="MAP"  D
 . S LRSB=$QS(NODE,3),LRSPEC=$QS(NODE,4)
 . S LRNLT=$QS(NODE,5)
 . S LRSPECN=$S($D(^LAB(61,+LRSPEC,0)):$P(^(0),U),1:"Missing")
 . S LRCDEF=$QS(NODE,6)
 . S LRLNC=$QS(NODE,7),LRLNC=$$GET1^DIQ(95.3,LRLNC_",",.01,"E")
 . S LRTST=+$O(^LAB(60,"C","CH;"_LRSB_";1",0))
 . S LRTST=$S($D(^LAB(60,LRTST,0))#2:$P(^(0),U),1:"Unknown")
 . S LRMCNT=+$G(LRMCNT)+1
 . S ^TMP("LRLNC63",$J,"MAP",LRMCNT,0)=LRSB_U_LRTST_U_LRSPECN_U_LRSPEC_U_LRNLT_U_LRCDEF_U_LRLNC
MAPMAIL ;Send mail message containing mapped test
 D
 . N XMDUZ,XMTEXT,XMY,XMSUB
 . S XMSUB="LOINC Historical Mapped LOINC tests"
 . S XMTEXT="^TMP(""LRLNC63"","_$J_",""MAP"","
 . S XMDUZ=.5
 . S XMY("G.LMI")=""
 . D ^XMD
CLEAN ;
 K ^TMP("LRLNC63",$J)
 Q
DECIMAL ;Check for possible LRDFN's >999999 - LRDFN maybe set to LRIDT format
 S (LRNXT,LRSEQ)=999999
 Q:'$O(^LR(LRSEQ))
 S ^XTMP("LRLNC63","SEQ",LRSEQ,"START")=$$NOW^XLFDT
 F  S LRNXT=$O(^LR(LRNXT)) Q:$S(LRNXT<1:1,$G(^XTMP("LRLNC63","STOP")):1,1:0)  D  I $$S^%ZTLOAD(LRSEQ_" Stopped at "_LRNXT) S ZTSTOP=1 Q
 . I '$G(^LR(LRNXT,0)) S ^XTMP("LRLNC63","SEQ",LRSEQ)=LRNXT Q
 . D LK6304^LRLNC63(LRNXT)
 . S ^XTMP("LRLNC63","SEQ",LRSEQ)=LRNXT
 I $G(^XTMP("LRLNC63","STOP")) D  Q
 . N LRNOW
 . S LRNOW=$$FMTE^XLFDT($$NOW^XLFDT,1)
 . S ^XTMP("LRLNC63","SEQ",LRSEQ,"END")="USER STOP"_U_$$NOW^XLFDT
 . S XQAMSG="LOINC Historical Mapper Sequence "_LRSEQ_"  STOPPED @ "_LRNOW
 . D XQA
 . L -^XTMP("LRLNC63","TASK",LRSEQ)
 S XQAMSG="LOINC Historical Mapper LRDFN sequence "_LRSEQ_" completed @ "_$$FMTE^XLFDT($$NOW^XLFDT,1)
DONE ; Send alert message when LRDFN sequence range mapping is finished
 L -^XTMP("LRLNC63","TASK",LRSEQ)
 S ^XTMP("LRLNC63","SEQ",LRSEQ,"END")=$$NOW^XLFDT
 D XQA
UPDATE ;If mapping complete, send list of tests not having result NLT codes
 ;Update fields 95.3,95.31 in LAB(69.9 file with date and last LRDFN
 K LRSEQX,LRNOP,LRFDA,LRERR
 S LRNOP=0
 F LRSEQX=1:20000:LRLST D  Q:$G(LRNOP)
 . I '$G(^XTMP("LRLNC63","SEQ",LRSEQX,"END")) S LRNOP=1
 Q:$G(LRNOP)
 D LIST^LRLNC63A
 S LRFDA(95,69.9,"1,",95.3)=DT
 S LRFDA(95,69.9,"1,",95.31)=+$P($G(LRLST),".")
 D FILE^DIE("KS","LRFDA(95)","LRERR")
 Q
RERUN ; This will restart the historical mapping from the beginning.
 ; To restart call QUE^LRLNC63
 N DIR,DIRUT,Y
 W !,$$CJ^XLFSTR(" This will re-run LOINC Historical Mapping from the beginning ",80)
 W !,$$CJ^XLFSTR("reseting all globals to zero.",80)
 W !,$$CJ^XLFSTR(" To restart from a stopping point use the",80)
 W !,$$CJ^XLFSTR("LAB DATA LOINC Mapping Option.",80),!!
 S DIR(0)="Y",DIR("A")="Are you certain you want to proceed" D ^DIR
 I $G(Y)'=1 Q
 K ^XTMP("LRLNC63")
 D QUE^LRLNC63
 Q
