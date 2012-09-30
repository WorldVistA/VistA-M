LR302P ;DALOI/FHS - LR*5.2*302 POST INSTALL ROUTINE;31-AUG-2001
 ;;5.2;LAB SERVICE;**302**;Sep 27, 1994
 ;Resolve preinstall data saved in XTMP("LR302",FILE#,IEN,FIELD)=Free Text  - 
EN ;
 Q:'$D(XPDNM)
DD ;Purge .001 from installed files
 F LRDA=64.2,64.3,64.061,64.062,95.3,95.31 D
 . N DA,DIK
 . S DA(1)=LRDA,DA=.001,DIK="^DD("_LRDA_","
 . D ^DIK
 N LRGLB,LRFDA,LRDATA
 I '$G(^XTMP("LR302",1,0)) D  Q
 . D BMES^LR302("ERROR CONDITION - Preinstall historical data maybe incomplete.")
 . D BMES^LR302("Post-Install repointing process aborted.")
 S LRGLB="^XTMP(""LR302"",2)",LRCNT=0,LRFILE=""
 K LRFDA
LOOP ;Loop through historical data and restore file
 F  S LRGLB=$Q(@LRGLB) Q:$QS(LRGLB,1)'="LR302"  Q:'$QS(LRGLB,2)  D
 . I $G(LRFILE)'=$QS(LRGLB,2) D
 . . S LRFILE=$QS(LRGLB,2) D BMES^LR302("Processing data for File/Subfile #"_LRFILE)
 . S LRIEN=$QS(LRGLB,3),LRFLD=$QS(LRGLB,4),LRDATA=@LRGLB,LRCNT=$G(LRCNT)+1
 . Q:$S('$G(LRIEN):1,'LRFLD:1,'$L(LRDATA):1,1:0)
 . I LRFILE=64.2 D
 . . N LR642,ERR
 . . S LR642=$G(^XTMP("LR302",LRFILE,LRIEN,1))
 . . S LRIEN=$$FIND1^DIC(LRFILE,"","XO",LR642_" ","C","","ERR")
 . . I '$G(LRIEN) K LRIEN Q
 . . S LRIEN=LRIEN_","
 . Q:'$G(LRIEN)
 . I LRFILE=64.2,LRFLD=1 Q
 . S LRFDA(LRCNT,LRFILE,LRIEN,LRFLD)=LRDATA
 . I LRCNT#200=0 W "."
 . I $G(LRDBUG)=2 W "LRFDA("_LRCNT_","_LRFILE_","_LRIEN_","_LRFLD_") = "_@LRGLB,! Q
 . K LRERR
 . D FILE^DIE("KSE","LRFDA("_LRCNT_")","LRERR")
 . I $D(LRERR) D ERR Q
 . K LRFDA(LRCNT)
 . I '$G(LRDBUG) K ^XTMP("LR302",LRFILE,LRIEN,LRFLD)
 . S $P(^XTMP("LR302",1,0),U,3)=LRCNT
 . S ^XTMP("LR302",1,LRFILE)=LRIEN
 D BMES^LR302("Historical data restored")
 D
 . N LRIEN
 . S LRIEN="" F  S LRIEN=$O(^XTMP("LR302",64.2,LRIEN)) Q:LRIEN=""  D
 . . Q:$O(^XTMP("LR302",64.2,LRIEN,1))
 . . K ^XTMP("LR302",64.2,LRIEN)
 D MESLMI
 Q
ERR ;Record data update error
 W !,"ERROR" S ^XTMP("LR302","LRERR",LRCNT)=LRFILE_U_LRIEN_U_LRFLD_U_LRDATA
 K LRFDA(LRCNT)
 Q
MESLMI ; Notify LIM patch is installed.
 N XQA,XQAMSG
 D BMES^LR302("Sending install completion alert to mail group G.LMI")
 ;
 S XQAMSG="Installation of patch "_$G(XPDNM,"Unknown patch")_" completed on "_$$HTE^XLFDT($H)
 S XQA("G.LMI")=""
 D SETUP^XQALERT
 ;
 S XQAMSG="LIM: Review description for "_$G(XPDNM,"Unknown patch")_" use KIDS:Utilities:Build File Print"
 S XQA("G.LMI")=""
 D SETUP^XQALERT
 Q
