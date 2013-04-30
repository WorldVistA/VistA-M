LRWU9 ;DALOI/CKA - TOOL TO DETECT, FIX, AND REPORT BAD DATA NAMES ;06/22/12  09:52
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 ;Reference to ^PXRMINDX supported by ICR# 4290
 ;
EN ; Interactive entry point.
 ;
 N INSTALL,LRFIX,LRNUM,LRSITE,LRSPACE,LRSUPFLG,XMDUZ,XMY
 ;
 D INIT
 S LRFIX=$$ASK(),XMY(DUZ)="",XMDUZ=DUZ,INSTALL=0
 S $P(LRSPACE," ",80)=""
 I 'LRFIX Q
 S LRFIX=LRFIX-1
 D DES^XMA21    ; call to get the email recipients list.
 D PREP^XGF     ; setup screen
 D CHKDD
 D CHK63
 D SENDMM,CLEAN^XGF
 K ^TMP("LR",$J)
 ;
 Q
 ;-------------------------------------------------------
KIDS ; Entry point for post install run.
 ;
 N INSTALL,LRFIX,LRNUM,LRSITE,LRSUPFLG,XMY
 ;
 I $G(^XMB("NETNAME"))["domain.ext",$$PROD^XUPROD() S XMY("G.LAB DEV IRMFO@FORUM.domain.ext")="",XMY("G.CSCLIN4@FORUM.domain.ext")=""
 S XMY(DUZ)="",XMY("G.LMI")="",INSTALL=1
 D INIT
 ;S LRFIX=1   ; [ccr-8167] - LRFIX is set to 0 in INIT subroutine.
 D CHKDD,CHK63,SENDMM
 ;
 K ^TMP("LR",$J)
 ;
 Q
 ;-------------------------------------------------------
LRNIGHT ; Entry point for ^LRNIGHT run.
 ;
 N INSTALL,LRFIX,LRNUM,LRSITE,LRSUPFLG,XMY
 ;
 S INSTALL=1
 D INIT,CHKDD,CHK63
 S (XMY(DUZ),XMY("G.LMI"))=""
 I $G(^XMB("NETNAME"))["domain.ext",$$PROD^XUPROD() S XMY("G.LAB DEV IRMFO@FORUM.domain.ext")="",XMY("G.CSCLIN4@FORUM.domain.ext")=""
 I $O(^TMP("LR",$J,"DD63.04",5))]"" D SENDMM
 ;
 K ^TMP("LR",$J)
 ;
 Q
 ;-------------------------------------------------------
INIT ; Initialize variables.
 ;
 K ^TMP("LR",$J)
 D DT^DICRW
 S LRSITE=$$STA^XUAF4($$KSP^XUPARAM("INST"))
 S LRFIX=0
 ;
 Q
 ;-------------------------------------------------------
CHKDD ; CHECK DD FOR BAD DATA NAMES.
 ;First check for DDs with the same subscript
 N CNT,DA,DIK,LR60CNT,LR60IEN,LRLOC,LRDATA,LRD0,LRPC,LRSUB,LRX,LRDD,LRDDA,LRNOTEST,LRNOFIX,LRSUBCNT
 K ^TMP("LR",$J)
 S LRNUM=1
 ;
 S ^TMP("LR",$J,"DD63.04",LRNUM)=$$NAME^XUAF4($$KSP^XUPARAM("INST"))_" ("_$$KSP^XUPARAM("WHERE")_")      "_$$FMTE^XLFDT(DT)
 S LRNUM=LRNUM+1
 S ^TMP("LR",$J,"DD63.04",LRNUM)=" ",LRNUM=LRNUM+1
 S ^TMP("LR",$J,"DD63.04",LRNUM)=" ",LRNUM=LRNUM+1
 S ^TMP("LR",$J,"DD63.04",LRNUM)=" ",LRNUM=LRNUM+1
 S ^TMP("LR",$J,"DD63.04",LRNUM)=" ",LRNUM=LRNUM+1
 ;
 S LRD0=1,LRDD=0,LRDDA=0
 F CNT=0:1 S LRD0=$O(^DD(63.04,LRD0)) Q:LRD0=""  D:$D(^DD(63.04,LRD0,0))
 . S LRDATA=$G(^DD(63.04,LRD0,0)) Q:LRDATA=""
 . S LRSUB=$P($P(LRDATA,U,4),";")
 . S LRPC=$P($P(LRDATA,U,4),";",2)
 . S LR60IEN="",LR60CNT=0
 . S LRX=0 F  S LRX=$O(^LAB(60,"C","CH;"_LRSUB_";"_LRPC,LRX)) Q:'LRX  D
 . . I $P($G(^LAB(60,LRX,.2)),U,1)=LRD0 D
 . . . S LR60IEN=LRX
 . . . S ^TMP("LR",$J,"SORT","LD",LRD0,LR60IEN)=""
 . . . S LR60CNT=LR60CNT+1
 . S LRSUBCNT=$G(^TMP("LR",$J,"SORT",1,LRSUB))+1
 . S ^TMP("LR",$J,"SORT",1,LRSUB)=LRSUBCNT
 . S ^TMP("LR",$J,"SORT",1,LRSUB,LRD0)=$P(LRDATA,U,1)_U_$P(LRDATA,U,4)_U_LR60IEN
 . I 'LR60IEN S ^TMP("LR",$J,"SORT","L",LRSUB,LRD0)=LRSUB ; L subscript used when Data name is not linked to a test
 . I LRPC'=1!(LRSUB'=LRD0) S ^TMP("LR",$J,"SORT","C",LRD0)=LRSUB ; C subscript used when Data name has wrong subscript location
 . I LRSUBCNT>1 S ^TMP("LR",$J,"SORT","D",LRSUB)="" ; D subscript used when more than one Data name has the same subscript
 . I LR60CNT=1 K ^TMP("LR",$J,"SORT","LD",LRD0) ; LD subscript used when there are multiple tests linked to a data name
 ;
 ; Report issues with duplicate subscript locations
 S LRSUB="" F  S LRSUB=$O(^TMP("LR",$J,"SORT","D",LRSUB)) Q:LRSUB=""  D
 . S LRSUPFLG=1
 . S ^TMP("LR",$J,"DD63.04",LRNUM)=" ",LRNUM=LRNUM+1
 . S ^TMP("LR",$J,"DD63.04",LRNUM)="*WARNING* THE FOLLOWING DATA NAMES ARE ASSIGNED THE SAME SUBSCRIPT #"_LRSUB,LRNUM=LRNUM+1
 . S LRD0=0 F  S LRD0=$O(^TMP("LR",$J,"SORT",1,LRSUB,LRD0)) Q:LRD0=""  D
 . . S LRDATA=$G(^TMP("LR",$J,"SORT",1,LRSUB,LRD0))
 . . S ^TMP("LR",$J,"DD63.04",LRNUM)="   - Data Name '"_$P(LRDATA,U,1)_"' (#"_LRD0_") is assigned location: "_$P(LRDATA,U,2),LRNUM=LRNUM+1
 . . I $P(LRDATA,U,3) D
 . . . S ^TMP("LR",$J,"DD63.04",LRNUM)="     (This Data Name is linked to Lab test #"_$P(LRDATA,U,3)_" "_$P(^LAB(60,$P(LRDATA,U,3),0),U)_")",LRNUM=LRNUM+1
 . . I '$P(LRDATA,U,3) D
 . . . S ^TMP("LR",$J,"DD63.04",LRNUM)="     (This Data Name is not linked to a Lab test)",LRNUM=LRNUM+1
 ;
 ; Report issues with multiple tests with the same data name
 S LRD0=0 F  S LRD0=$O(^TMP("LR",$J,"SORT","LD",LRD0)) Q:'LRD0  D
 . S LRSUPFLG=1
 . S ^TMP("LR",$J,"DD63.04",LRNUM)=" ",LRNUM=LRNUM+1
 . S ^TMP("LR",$J,"DD63.04",LRNUM)="*WARNING* THE DATA NAME '"_$P(^DD(63.04,LRD0,0),U)_"' (#"_LRD0_") IS LINKED TO MORE THAN ONE LAB TEST:",LRNUM=LRNUM+1
 . N LRCNT
 . S LR60IEN=0 F  S LR60IEN=$O(^TMP("LR",$J,"SORT","LD",LRD0,LR60IEN)) Q:'LR60IEN  D
 . . S LRCNT=$G(LRCNT)+1
 . . S ^TMP("LR",$J,"DD63.04",LRNUM)="   "_LRCNT_". "_$P($G(^LAB(60,LR60IEN,0)),U,1)_" (#"_LR60IEN_")"
 . . S LRNUM=LRNUM+1
 ;
 ;Check - SUBSCRIPT'=FIELD #
 ;        NOT IN FIRST PIECE
 ;        OR BOTH
 ;
 ;
 I 'INSTALL D SAY^XGF(24,1,LRSPACE),SAY^XGF(24,1,"LRD0=")
 S LRD0=1
 F CNT=0:1 S LRD0=$O(^TMP("LR",$J,"SORT","C",LRD0)) Q:LRD0=""  D
 . S LRDATA=$G(^DD(63.04,LRD0,0)) Q:LRDATA=""
 . S LRSUB=$P($P(LRDATA,U,4),";")
 . S LRPC=$P($P(LRDATA,U,4),";",2)
 . I $D(^TMP("LR",$J,"SORT","D",LRSUB)) Q
 . S LR60IEN=$P($G(^TMP("LR",$J,"SORT",1,LRSUB,LRD0)),U,3)
 . I 'INSTALL,'(CNT#100) D SAY^XGF(24,1,"LRD0="_LRD0)
 . I LRPC'=1!(LRSUB'=LRD0) D
 . . S ^TMP("LR",$J,"DD63.04",LRNUM)=" ",LRNUM=LRNUM+1
 . . S ^TMP("LR",$J,"DD63.04",LRNUM)="Data Name Location "_$P(^DD(63.04,LRD0,0),U)_" CH;"_LRSUB_";"_LRPC_" should be CH;"_LRD0_";1"
 . . I LRFIX,LR60IEN,'$D(^TMP("LR",$J,"SORT","LD",LRD0)) D FIXDD D
 . . . S ^(LRNUM)=^TMP("LR",$J,"DD63.04",LRNUM)_" ***FIXED***"
 . . I LRFIX,('LR60IEN!($D(^TMP("LR",$J,"SORT","LD",LRD0)))) D
 . . . S ^(LRNUM)=^TMP("LR",$J,"DD63.04",LRNUM)_" ***NOT FIXED***"
 . . . S LRSUPFLG=1
 . . S LRNUM=LRNUM+1
 . . I LR60IEN,$G(^TMP("LR",$J,"DDFIXED",LRSUB)) D
 . . . S ^TMP("LR",$J,"DD63.04",LRNUM)="Lab test # "_LR60IEN_" "_$P(^LAB(60,LR60IEN,0),U)_" DATA NAME (LOCATION) SUBSCRIPT  **** FIXED ****"
 . . . S LRNUM=LRNUM+1
 . . . S ^TMP("LR",$J,"DD63.04",LRNUM)="    OLD SUBSCRIPT="_LRSUB_" NEW SUBSCRIPT="_LRD0
 . . . S LRNUM=LRNUM+1
 . . I 'LR60IEN D
 . . . S ^TMP("LR",$J,"DD63.04",LRNUM)="Data Name is not linked to a File #60 Laboratory Test"
 . . . I LRFIX S ^(LRNUM)=^TMP("LR",$J,"DD63.04",LRNUM)_" ***NOT FIXED***",LRSUPFLG=1
 . . . S LRNUM=LRNUM+1
 . . I $D(^TMP("LR",$J,"SORT","LD",LRD0)) D
 . . . S ^TMP("LR",$J,"DD63.04",LRNUM)="Data Name is linked to more than one File #60 Laboratory Test"
 . . . I LRFIX S ^(LRNUM)=^TMP("LR",$J,"DD63.04",LRNUM)_" ***NOT FIXED***",LRSUPFLG=1
 . . . S LRNUM=LRNUM+1
 ;
 Q
 ;-------------------------------------------------------
CHK63 ;CHECK FILE 63 FOR TEST DATA WITH NO DATA NAME
 ;
 N CNT,DATANUM,LRDFN,LRIDT,LRD0,LRNUM1,LRNUM2
 I 'INSTALL D SAY^XGF(24,1,LRSPACE),SAY^XGF(24,1,"LRDFN=")
 S (LRDFN,LRIDT,LRD0)=""
 S LRNUM1=1,LRNUM2=1
 F CNT=0:1 S LRDFN=$O(^LR(LRDFN)) Q:LRDFN=""  D
 . F  S LRIDT=$O(^LR(LRDFN,"CH",LRIDT)) Q:LRIDT=""  D
 . . N LRREPAIR
 . . S LRD0=1
 . . F  S LRD0=$O(^LR(LRDFN,"CH",LRIDT,LRD0)) Q:LRD0'>0  D
 . . . I $D(LRREPAIR(LRD0)) Q  ;Used to prevent issues when two Data Names use each others subscripts
 . . . I 'INSTALL,'(CNT#100) D SAY^XGF(24,1,"LRDFN="_LRDFN)
 . . . I '$D(^DD(63.04,LRD0,0)),'$D(^TMP("LR",$J,"SORT",1,LRD0)) D
 . . . . S ^TMP("LR",$J,"SORT","W",LRD0,LRNUM2)="^LR("_LRDFN_",""CH"","_LRIDT_","_LRD0_")"
 . . . . S LRNUM2=LRNUM2+1
 . . . ; Check if there are results that belong to a Data Name that is not linked to a test.
 . . . S DATANUM=$O(^TMP("LR",$J,"SORT","L",LRD0,0))
 . . . I DATANUM,'$D(^TMP("LR",$J,"SORT","D",LRD0)) D
 . . . . ;SORT BY DATA NAME
 . . . . S ^TMP("LR",$J,"SORT","T",DATANUM,LRNUM1)="^LR("_LRDFN_",""CH"","_LRIDT_","_LRD0_")"
 . . . . S LRNUM1=LRNUM1+1
 . . . I LRFIX D FIX63
 S LRNUM2=0,DATANUM=0
 I $D(^TMP("LR",$J,"SORT","W")) D
 . F  S DATANUM=$O(^TMP("LR",$J,"SORT","W",DATANUM)) Q:DATANUM'>0  D
 . . S ^TMP("LR",$J,"DD63.04",LRNUM)=" ",LRNUM=LRNUM+1
 . . S ^TMP("LR",$J,"DD63.04",LRNUM)="Results in subscript '"_DATANUM_"' without a Data Name at: "
 . . S LRNUM=LRNUM+1
 . . F  S LRNUM2=$O(^TMP("LR",$J,"SORT","W",DATANUM,LRNUM2)) Q:LRNUM2'>0  D
 . . . S ^TMP("LR",$J,"DD63.04",LRNUM)="     "_^TMP("LR",$J,"SORT","W",DATANUM,LRNUM2)
 . . . S LRNUM=LRNUM+1
 . . . S LRSUPFLG=1
 S LRNUM1=0,DATANUM=0
 I $D(^TMP("LR",$J,"SORT","T")) D
 . F  S DATANUM=$O(^TMP("LR",$J,"SORT","T",DATANUM)) Q:DATANUM'>0  D
 . . S ^TMP("LR",$J,"DD63.04",LRNUM)=" ",LRNUM=LRNUM+1
 . . S ^TMP("LR",$J,"DD63.04",LRNUM)="Results in Data Name "_$P(^DD(63.04,DATANUM,0),U,1)_" without a test in file 60 at: "
 . . S LRNUM=LRNUM+1
 . . F  S LRNUM1=$O(^TMP("LR",$J,"SORT","T",DATANUM,LRNUM1)) Q:LRNUM1'>0  D
 . . . S ^TMP("LR",$J,"DD63.04",LRNUM)="     "_^TMP("LR",$J,"SORT","T",DATANUM,LRNUM1)
 . . . S LRNUM=LRNUM+1
 . . . S LRSUPFLG=1
 ;
 Q
 ;-------------------------------------------------------
FIXDD ; FIX DD FOR BAD DATA NAMES.
 ;
 N DDFIELD,LRNAME,LRTYPE
 ;
 D FIELD^DID(63.04,LRD0,"","LABEL;TYPE","DDFIELD")
 S LRNAME=DDFIELD("LABEL")
 S LRTYPE=DDFIELD("TYPE")
 S DA=LRD0
 D DDFIX^LRWU6
 I LR60IEN D
 . I $P(^LAB(60,LR60IEN,0),U,5)'="CH;"_LRD0_";1"!($P(^LAB(60,LR60IEN,0),U,12)'="DD(63.04,"_LRD0_",")!(^LAB(60,LR60IEN,.2)'=LRD0) D
 . . N LRFDA,LRDIE
 . . S LRFDA(1,60,LR60IEN_",",400)=LRD0
 . . S LRFDA(1,60,LR60IEN_",",5)="CH;"_LRD0_";1"
 . . S LRFDA(1,60,LR60IEN_",",13)="DD(63.04,"_LRD0_","
 . . D FILE^DIE("","LRFDA(1)","LRDIE(1)")
 . . S ^TMP("LR",$J,"DDFIXED",LRSUB)=LRD0_U_LRPC_U_LR60IEN
 ;
 Q
 ;-------------------------------------------------------
FIX63 ;FIX DATA NODES IN FILE 63
 ;
 Q:$D(^TMP("LR",$J,"SORT","D",LRD0))
 Q:'$D(^TMP("LR",$J,"DDFIXED",LRD0))
 Q:($P(^TMP("LR",$J,"DDFIXED",LRD0),U,2)'=1)
 S LRLOC=$P(^TMP("LR",$J,"DDFIXED",LRD0),U)
 I $D(^DD(63.04,LRD0,0))!($D(^TMP("LR",$J,"SORT",1,LRD0))) S ^TMP("LR",$J,"DD63.04",LRNUM)=" ",LRNUM=LRNUM+1
 I $D(^LR(LRDFN,"CH",LRIDT,LRLOC)) D  Q
 . S ^TMP("LR",$J,"DD63.04",LRNUM)="*ERROR* MOVING OVER ^LR("_LRDFN_",CH,"_LRIDT_","_LRD0_") TO ^LR("_LRDFN_",CH,"_LRIDT_","_LRLOC_")"
 . S LRNUM=LRNUM+1
 . S ^TMP("LR",$J,"DD63.04",LRNUM)="Data already exists in ^LR("_LRDFN_",CH,"_LRIDT_","_LRLOC_")"
 . S LRNUM=LRNUM+1
 . S LRSUPFLG=1
 D CHKILLPX(LRDFN,LRIDT,LRD0) ;Kill Clinical Reminders Index
 S ^LR(LRDFN,"CH",LRIDT,LRLOC)=^LR(LRDFN,"CH",LRIDT,LRD0)
 K ^LR(LRDFN,"CH",LRIDT,LRD0)
 S LRREPAIR(LRLOC)=""
 D CHSET^LRPX(LRDFN,LRIDT) ;Set Clinical Reminders Index
 S ^TMP("LR",$J,"DD63.04",LRNUM)="DATA LOCATION FIXED IN LAB DATA FILE ^LR"
 S LRNUM=LRNUM+1
 S ^TMP("LR",$J,"DD63.04",LRNUM)="^LR("_LRDFN_",CH,"_LRIDT_","_LRD0_") NOW MOVED TO ^LR("_LRDFN_",CH,"_LRIDT_","_LRLOC_")"
 S LRNUM=LRNUM+1
 ;
 Q
 ;-------------------------------------------------------
CHKILLPX(LRDFN,LRIDT,LRD0) ;Kill Clinical Reminders Index
 N LR60IEN,DFN,DATE,OK,DAS,LRDBLCHK
 S LR60IEN=$P(^TMP("LR",$J,"DDFIXED",LRD0),U,3)
 I 'LR60IEN D
 . N DATA
 . S DATA=^LR(LRDFN,"CH",LRIDT,LRD0)
 . S LR60IEN=+$P($P(DATA,U,3),"!",7)
 I 'LR60IEN Q
 I '$L($G(^LR(+$G(LRDFN),"CH",+$G(LRIDT),0))) Q
 D PATIENT^LRPX(LRDFN,.DFN,.OK) I 'OK Q
 S DATE=9999999-LRIDT
 S DAS=LRDFN_";CH;"_LRIDT_";"_LRD0
 S LRDBLCHK=0
 I '$D(^PXRMINDX(63,"PI",DFN,LR60IEN,DATE,DAS)) S LRDBLCHK=1
 D KLAB^LRPX(DFN,DATE,LR60IEN,DAS)
 ;
 I LRDBLCHK D
 . N ITEM,FLAG
 . S ITEM=0 F  S ITEM=$O(^PXRMINDX(63,"PI",DFN,ITEM)) Q:'ITEM!($D(FLAG))  D
 . . I $D(^PXRMINDX(63,"PI",DFN,ITEM,DATE,DAS)) D
 . . . D KLAB^LRPX(DFN,DATE,ITEM,DAS)
 . . . S FLAG=1
 Q
 ;-------------------------------------------------------
SENDMM ;SEND MAIL MESSAGE OF ERRORS FOUND AND/OR FIXED.
 ;
 N XMSUB,DIFROM,XMINSTR
 ;
 S LRNUM=3
 I $O(^TMP("LR",$J,"DD63.04",5)) D  ;Errors were found
 . ;
 . I 'LRFIX!(LRFIX&($G(LRSUPFLG))) D  ;not all errors were auto-repaired
 . . S ^TMP("LR",$J,"DD63.04",LRNUM)="Contact the National Service Desk to request assistance from the Clin 4",LRNUM=LRNUM+1
 . . S ^TMP("LR",$J,"DD63.04",LRNUM)="Product Support team in resolving the following errors identified in the",LRNUM=LRNUM+1
 . . S ^TMP("LR",$J,"DD63.04",LRNUM)="VistA Laboratory package:",LRNUM=LRNUM+1
 . ;
 . I LRFIX,'$G(LRSUPFLG) D  ;all errors were auto-repaired
 . . S ^TMP("LR",$J,"DD63.04",LRNUM)="The LAB DATA file (#63) cleanup process has found and repaired the",LRNUM=LRNUM+1
 . . S ^TMP("LR",$J,"DD63.04",LRNUM)="following errors:",LRNUM=LRNUM+1
 ;
 I '$O(^TMP("LR",$J,"DD63.04",5)) D  ;No errors were found
 . S ^TMP("LR",$J,"DD63.04",LRNUM)=""
 . S ^TMP("LR",$J,"DD63.04",(LRNUM+1))="*** NO ERRORS FOUND ***"
 ;
 S XMSUB="DATA DICTIONARY ^DD(63.04 CHECK REPORT "
 S XMSUB=XMSUB_$$FMTE^XLFDT($$NOW^XLFDT,"1S")
 S XMINSTR("ADDR FLAGS")="R"
 D SENDMSG^XMXAPI(DUZ,XMSUB,"^TMP(""LR"",$J,""DD63.04"")",.XMY,.XMINSTR)
 ;
 Q
 ;-------------------------------------------------------
ASK() ; Run analyze/repair query
 ;
 N Y,DIR,DIRUT,DTOUT,DUOUT,FIX
 ;
 S FIX=0
 ;
 W !,"This process will check the CHEM, HEM, TOX, RIA, SER, etc."
 W !,"Sub-file (#63.04) of the LAB DATA file (#63) looking for"
 W !,"possible discrepancies in the Data Dictionary.  Once the"
 W !,"process has completed, a MailMan message will be sent to the"
 W !,"user that started this process and any other user selected."
 W !!
 W !,"The two modes in which this process can be run are ANALYZE"
 W !,"and REPAIR.  If the ANALYZE option is chosen, the process will"
 W !,"only look for discrepancies and report the findings via a"
 W !,"MailMan message.  If the ANALYZE,REPAIR option is chosen the"
 W !,"process will ANALYZE and REPAIR any discrepancies found that"
 W !,"can be fixed programmatically and list all those that could"
 W !,"not be fixed but need attention."
 W !!
 ;
 S DIR("A")="Do you want to continue with this process",DIR("B")="NO"
 S DIR(0)="Y"
 D ^DIR
 I 'Y Q FIX
 ;
 K DIR,Y
 ;
 S DIR(0)="NAO^1:3",DIR("B")=3
 S DIR("A",1)="Select the action you wish to take:"
 S DIR("A",2)=""
 S DIR("A",3)="1. Analyze and Report."
 S DIR("A",4)="2. Analyze, Repair, and Report."
 S DIR("A",5)="3. Quit - No Action."
 S DIR("A",6)=""
 S DIR("A")="Enter a number 1 thru 3: "
 S DIR("?")="Select a number 1 thru 3 or press <Return> to exit"
 ;
 D ^DIR
 I Y=1 S FIX=1
 I Y=2 S FIX=2
 I Y=3!(Y=-1)!('Y) S FIX=0 Q FIX
 ;
 K DIR,Y
 S DIR("A")="Are you sure you want to proceed",DIR("B")="NO"
 S DIR(0)="Y"
 D ^DIR
 I 'Y S FIX=0
 ;
 Q FIX
