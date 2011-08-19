LRLNC63 ;DALOI/FHS-HISTORICAL LOINC CODE MAPPER FOR DD(63.04 DATA ;10/15/2001  15:19
 ;;5.2;LAB SERVICE;**279**;Sep 27, 1994
TASK ;
 I '$G(^XTMP("LRLNC63",0)) S ^(0)=$$FMADD^XLFDT(DT,30)_U_DT_U_"LOINC HISTORICAL MAPPER INFORMATION"
 Q:'$G(LRSEQ)
 L +^XTMP("LRLNC63","TASK",LRSEQ):1 Q:'$T
 H 5
 I LRSEQ=999999 D DECIMAL^LRLNC63A Q
 S LRNXT=+$G(^XTMP("LRLNC63","SEQ",LRSEQ))
 I LRNXT>1 S LRNXT=LRNXT-1
 S:LRNXT<1 LRNXT=(LRSEQ-1)
 S:LRNXT<0 LRNXT=0
 S LRMAP=$$GET1^DIQ(69.9,"1,",95.3,"I","","ERR")
 S ^XTMP("LRLNC63","SEQ",LRSEQ,"START")=$$NOW^XLFDT
 F  S LRNXT=$O(^LR(LRNXT)) Q:$S(LRNXT<1:1,LRNXT>(LRSEQ+20000):1,$G(^XTMP("LRLNC63","STOP")):1,1:0)  D  I $$S^%ZTLOAD(LRSEQ_" Stopped at "_LRNXT) S ZTSTOP=1 Q
 . I '$G(^LR(LRNXT,0)) S ^XTMP("LRLNC63","SEQ",LRSEQ)=LRNXT Q
 . D LK6304(LRNXT)
 . S ^XTMP("LRLNC63","SEQ",LRSEQ)=LRNXT
 I $G(^XTMP("LRLNC63","STOP")) D  Q
 . N LRNOW
 . S LRNOW=$$FMTE^XLFDT($$NOW^XLFDT,1)
 . S ^XTMP("LRLNC63","SEQ",LRSEQ,"END")="USER STOP"_U_$$NOW^XLFDT
 . S XQAMSG="LOINC Historical Mapper Sequence "_LRSEQ_"-"_(LRSEQ+20000)_"  STOPPED @ "_LRNOW
 . D XQA^LRLNC63A
 . L -^XTMP("LRLNC63","TASK",LRSEQ)
MES ; Send alert message when LRDFN sequence range mapping is finished
 S XQAMSG="LOINC Historical Mapper LRDFN sequence "_LRSEQ_" - "_(LRSEQ+20000)_" completed @ "_$$FMTE^XLFDT($$NOW^XLFDT,1)
 D DONE^LRLNC63A
 Q
6304 ;Entry point for setting ALL Patient's LOINC CODE for CH subscripted test
 K LRDFN,LRIDT,LRDATA,LRNLT,LRLNC
 K ^XTMP("LRLNC63")
 I $P($G(^LR(LRDFN,0)),U,2)=62.3 Q
 S LRDFN=0 F  S LRDFN=$O(^LR(LRDFN)) Q:LRDFN<1  I $O(^LR(LRDFN,"CH",0)) D  I $$S^%ZTLOAD Q
 . D LK6304(LRDFN)
 Q
LK6304(LRDFN) ;Call with LRDFN defined for single patient mapping
 Q:'LRDFN
 Q:'$G(^LR(LRDFN,0))  S LRFILE=+$P(^(0),U,2),DFN=+$P(^(0),U,3)
 I '$G(LRFILE)!(LRFILE=62.3)!('DFN) Q  ;Do not process controls
 K LRSAGE
 S SEX="M",AGE=99,LRSAGE=0
 I $S($G(LRMAP):0,LRFILE=2:1,LRFILE=67:1,1:0) D
 . D GETS^DIQ(LRFILE,DFN_",",".02;.03","IE","LRSAGE")
 . S DOB=$G(LRSAGE(LRFILE,DFN_",",.03,"I"))
 . I $L($G(LRSAGE(LRFILE,DFN_",",.02,"I"))) S SEX=LRSAGE(LRFILE,DFN_",",.02,"I")
 . S LRSAGE=1
 S LRIDT=0 F  S LRIDT=$O(^LR(LRDFN,"CH",LRIDT)) Q:LRIDT<1  D
 . I $G(LRDBUG),'(LRDFN#100) W "."
 . Q:$G(^LR(LRDFN,"CH",LRIDT,"NPC"))<2  ;Must have the New Person Convertion node set to >1
 . Q:'$P($G(^LR(LRDFN,"CH",LRIDT,0)),U,3)  S LRCDT=$P(^(0),U),LRDSPEC=$P(^(0),U,5) ; Must have completion date
 . D SUB(LRDFN,LRIDT)
 Q
SUB(LRDFN,LRIDT) ;Single or all test LOINC mapping
 ;LRDFN=Lab IEN number
 ;LRIDT inverse date
 ;Check each result and determine LOINC CODE
 ;If Result NLT code is defined (LRNLT)
 ;If Workload suffix code is set (LRCDEF)
 ;If Specimen is defined (LRSPEC)
 ;Variable LRLNC is the LOINC CODE
 ;LRSB(LRSUB) will screen for only those datanames
 ;LRSB(LRSUB)=Workload suffix -- this will be used to change default suffix code.
 ;LRDATA= ^LR(LRDFN,"CH",LRIDT,TEST) node
 K LR5,LRLNC,LRMNODE,LROVR,LRSUB,LRXDEF,LRXNLT,LRXCDEF
 S LRXDEF=0,LRSUB=1
 F  S LRSUB=$O(^LR(LRDFN,"CH",LRIDT,LRSUB)) Q:LRSUB<1  S LRDATA=^(LRSUB) D
 . I '$D(^XTMP("LRLNC63",1,LRSUB)) D XTMP^LRLNC63A(LRSUB)
 . S (LR5,LROVR,LRLNC,LRXCDEF,LRMOD1)=""
 . I $G(LRMOD),$G(^XTMP("LRLNC63",2,LRSUB)) S LRMNODE=^(LRSUB) D
 . . S LROVR=+$P(LRMNODE,U,6),LRXCDEF=$P(LRMNODE,U,5)
 . . S LRMOD1=1
 . S LRDATA3=$P(LRDATA,U,3),LRDATA5=$P(LRDATA,U,5)
 . S LRNLT=$S($G(LRXNLT):LRXNLT,1:$P(LRDATA3,"!",2))
 . S LRCDEF=$S($G(LROVR):LRXCDEF,$P(LRDATA3,"!",4):$P(LRDATA3,"!",4),1:LRXCDEF)
 . S LRSPEC=$S($P(LRDATA,U,5):+$P(LRDATA,U,5),1:LRDSPEC)
 . I '$G(LRNLT) S LRNLT=$S(LRNLT:LRNLT,1:$G(^XTMP("LRLNC63",1,LRSUB)))
 . I LRNLT>1,LRSPEC S LRLNC=$$LNC^LRVER1(LRNLT,LRCDEF,LRSPEC)
 . I LRLNC D
 . . S $P(LRDATA3,"!",3)=LRLNC,$P(LRDATA3,"!",4)=LRCDEF
 . . I '$D(^XTMP("LRLNC63","MAP",LRSUB,LRSPEC,LRNLT,+LRCDEF,LRLNC)) S ^(LRLNC)=""
 . I '$G(LRMAP),LRSAGE,LRDATA5["$S(" D RANGE^LRLNC63A
 . I $G(LRDBUG) D  Q
 . . W !,LRDFN,?10,LRIDT,?30,LRSUB_"  "_LRSPEC
 . . I $G(LRDBUG)=2,$G(LRLNC) W !,LRDATA3,!,LRDATA5 Q
 . . I $G(LRDBUG)=1 W !,$S(LRLNC:"",1:"** ")_LRDATA3,!,LRDATA5
 . I $G(LRLNC) D
 . . S $P(LRDATA3,"!",5)=$S($G(LRMOD1):2,1:1)
 . . S $P(LRDATA,U,3)=LRDATA3
 . . S $P(^LR(LRDFN,"CH",LRIDT,LRSUB),U,3)=LRDATA3
 . I $G(LR5) S $P(^LR(LRDFN,"CH",LRIDT,LRSUB),U,5)=LRDATA5
 Q
LNC(LRNLT,LRCDEF,LRSPEC) ;reture the LOINC code for WKLD Code/Specimen
 ; Call with (nlt code,method suffix,test specimen)
 ; TA = Time Aspect
 N X,LRXN,Y,LRSPECN,VAL,ERR,TA S X=""
 Q:'LRNLT X
 K LRMSGM
 S:'$L($G(LRCDEF)) LRCDEF="0000"
 I $P($G(LRCDEF),".",2) S LRCDEF=$P(LRCDEF,".",2)
 S LRCDEF=$S($P(LRNLT,".",2):$P(LRNLT,".",2),1:LRCDEF)
 I $L(LRCDEF)'=4 S LRCDEF=LRCDEF_$E("0000",$L(LRCDEF),($L(LRCDEF-4)))
 S LRCDEF=LRCDEF_" "
 S LRSPEC=+LRSPEC
 ;Get time aspect from 61
 S TA=$$GET1^DIQ(61,LRSPEC_",",.0961,"I")
 S LRSPECN=$S($D(^LAB(61,LRSPEC,0))#2:$$GET1^DIQ(61,LRSPEC_",",.01),1:"Unknown")
 S LRNLT=$P(LRNLT,".")_"."
 ;Check for WKLD CODE_LOAD/WORK LIST method suffix
 S VAL(1)=LRNLT_LRCDEF
 S LRXN=$$FIND1^DIC(64,"","X",.VAL,"C","","ERR")
 ;Looking for specimen specific LOINC
 I LRXN,LRSPEC D  I X D MSG(1) Q X
 . I TA S X=$$GET1^DIQ(64.02,TA_","_LRSPEC_","_LRXN_",",4,"I") Q:X
 . S TA=$O(^LAM(LRXN,5,LRSPEC,1,0)) ; get time aspect
 . I TA S X=$$GET1^DIQ(64.02,TA_","_LRSPEC_","_LRXN_",",4,"I") Q:X
 ;Looking LOINC default
 I LRXN S X=$$LDEF(LRXN) I X D MSG(2) Q X
 I LRCDEF="0000 " Q ""
 ;Looking for WKLD CODE_GENERIC suffix
 K VAL
 S VAL(1)=LRNLT_"0000 "
 S LRXN=$$FIND1^DIC(64,"","X",.VAL,"C","","ERR")
 I 'LRXN Q ""
 ;Looking for WKLD CODE_GENERIC specimen specific LOINC
 I LRSPEC D  I X D MSG(3) Q X
 . I TA S X=$$GET1^DIQ(64.02,TA_","_LRSPEC_","_LRXN_",",4,"I") Q:X
 . S TA=$O(^LAM(LRXN,5,LRSPEC,1,0)) ; get time aspect
 . I TA S X=$$GET1^DIQ(64.02,TA_","_LRSPEC_","_LRXN_",",4,"I") Q:X
 ;Looking for WKLD CODE_GENERIC default LOINC
 I 'X,LRXN S X=$$LDEF(LRXN) I X D MSG(4)
 I 'X S X=""
 Q X
LDEF(LRY) ;Find the default LOINC code for WKLD CODE
 I 'LRY Q ""
 S X=$$GET1^DIQ(64,LRY_",",25,"I")
 I 'X S X=""
 Q X
TMPSB(LRSB) ; Get LOINC code from ^TMP("LR",$J,"TMP",LRSB,"P")
 S NODE=$G(^TMP("LR",$J,"TMP",LRSB,"P"))
 I 'NODE Q ""
 S $P(NODE,"!",3)=$$LNC($P(NODE,"!",2),$G(LRCDEF),$G(LRSPEC))
 S $P(NODE,"!",4)=$G(LRCDEF)
 Q $P(NODE,U,2)
 Q
MSG(VAL) ;Set output message
 Q:'$G(LRMSG)
 S LRMSGM="0-No LOINC Code Defined for "_LRNLT_"  "_LRCDEF
 N TANAME
 I $G(TA) S TANAME=$$GET1^DIQ(64.061,TA_",",.01,"E") ;TA Name
 I VAL=1 S LRMSGM="1-"_LRNLT_$E(LRCDEF,1,4)_" - "_LRSPECN
 I VAL=2 S LRMSGM="2-"_LRNLT_$E(LRCDEF,1,4)_" - Default LOINC"
 I VAL=3 S LRMSGM="3-"_LRNLT_"0000 - "_LRSPECN
 I VAL=4 S LRMSGM="4-"_LRNLT_"0000 - Default LOINC"
 I $G(TA) S LRMSGM=LRMSGM_" Time Aspect "_TANAME
 W:$G(LRDBUG) !,LRMSGM,!
 Q
 ;
RNLT(X) ;
 I 'X Q ""
 N Y
 S Y(1)=+$P($G(^LAB(60,X,64)),U,2)
 S Y=$S($P($G(^LAM(Y(1),0)),U,2):$P(^(0),U,2),1:"")
 I Y S $P(Y,"!",2)=$$LNC(Y,$G(LRCDEF),$G(LRSPEC))
 S $P(Y,"!",3)=$G(LRCDEF)
 Q Y
 ;
QUE ;Entry point to start/restart historical mapper
 ;Queue to a the resource device LRRESOURCE to trottle number of
 ;active conversion jobs.
SEC ;Check for security key
 I '$D(^XUSEC("XUPROGMODE",+$G(DUZ))) D  Q
 . W !,$$CJ^XLFSTR("You are not cleared to use this option",80)
DEV ;Check to make sure LRRESOURCE device exist
 W @IOF
 N LRERR
 S LRDEV=$$FIND1^DIC(3.5,"","B","LRRESOURCE","","","LRERR")
 I '$G(LRDEV) D  G END
 . W !,$$CJ^XLFSTR("You must define the resource device named 'LRRESOURCE'",80)
 . W !,$$CJ^XLFSTR("with at least one slot. Process Aborted.",80)
 S LRSLOT=$$GET1^DIQ(3.5,LRDEV_",",35,"I")
 I LRSLOT'>0 D  G END
 . W !,$$CJ^XLFSTR("LRRESOURCE device must have at leaset 1 slot.",80)
 . W !,$$CJ^XLFSTR("The recommended number is 8.",80)
 W !!,$$CJ^XLFSTR("D STOP^LRLNC63 to stop all background historical mapping tasks.",80),!
DIS ;Inform the user of the option's functionality
 W !!,$$CJ^XLFSTR("This option should be run during 24 hour off peak time frame!!",80),!!
 W !,$$CJ^XLFSTR("This option will queue multiple tasks to LOINC map",80)
 W !,$$CJ^XLFSTR("historical data in the LAB DATA (#63).",80)
 K DIR S DIR(0)="Y",DIR("A")="Are you certain you wish to proceed"
 D ^DIR I $G(Y)'=1 G END
 S LRSTOP=$G(^XTMP("LRLNC63","STOP"))
 K ^XTMP("LRLNC63",1),^XTMP("LRLNC63","STOP")
 S LRLST=$O(^LR(999999),-1)
 D
 . I LRLST[".",$D(^LR(0))#2 S $P(^(0),U,3)=$P(LRLST,".") Q
 . I $D(^LR(0))#2 S $P(^(0),U,3)=LRLST
 K ^XTMP("LRLNC63",0)
 F LRSEQ=1:20000:LRLST D IO
 I $O(^LR(999999)) S LRSEQ=999999 D IO
END ;Cleanup
 K LRDEV,LRSLOT,LRLST,LRSEQ
 K ZTSAVE,ZTDTH,ZTDESC,ZTRTN
 Q
IO ;Task to LRRESOURCE
 L +^XTMP("LRLNC63","TASK",LRSEQ):1 I '$T D  Q
 . W !,$$CJ^XLFSTR("Sequence # "_LRSEQ_" is already running.",80),!
 I $G(^XTMP("LRLNC63","SEQ",LRSEQ,"END")) D
 . K ^XTMP("LRLNC63","SEQ",LRSEQ)
 I $G(LRSTOP) K ^XTMP("LRLNC63","SEQ",LRSEQ,"END")
 S ZTSAVE("LRSEQ")="",ZTIO="LRRESOURCE",ZTDTH=$H
 S ZTDESC="LOINC Historical Conversion - Seq "_LRSEQ_" "_$$NOW^XLFDT
 S ZTSAVE("LRLST")=""
 S ZTRTN="TASK^LRLNC63"
 D ^%ZTLOAD
 L -^XTMP("LRLNC63","TASK",LRSEQ)
 Q:'$D(ZTSK)
 S XQAMSG="LRDFN Conversion Sequence "_LRSEQ_"-"_(LRSEQ+20000)_" Task number is "_ZTSK
 W !,XQAMSG D XQA^LRLNC63A
 Q
STOP ;Stop all LOINC conversion background jobs
 N DIR
 W !?5,"Stopping all background LOINC historical mapping jobs",!!
 S DIR(0)="Y",DIR("A")="Are you certain you want to continue"
 D ^DIR Q:Y'=1
 S ^XTMP("LRLNC63","STOP")=$H_U_$$HTE^XLFDT($H)_U_"DUZ= "_$G(DUZ)
 W !," Background task stop node has been set, jobs should stop soon",!
 Q
