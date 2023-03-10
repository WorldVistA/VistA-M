LRWU9A ;HPS/DSK - TOOL TO DETECT, FIX, AND REPORT BAD DATA NAMES ;Apr 11, 2019@16:00
 ;;5.2;LAB SERVICE;**519,543,549,554**;Sep 27, 1994;Build 13
 ;
 ;Reference to ^DD(63.04 supported by DBIA #7053
 ;Reference to ^ORD(101.43 supported by DBIA #2843
 ;
 Q
 ;
B6304 ;check "B" cross reference
 ;
 ;LRNUM = Current MailMessage line number
 ;
 N LRA,LRB,LRMISNM,LRCOUNT
 S (LRA,LRB)="",LRMISNM=0
 F  S LRA=$O(^DD(63.04,"B",LRA)) Q:LRA=""  D
 . S LRCOUNT=0
 . F  S LRB=$O(^DD(63.04,"B",LRA,LRB)) Q:LRB=""  D
 . . S LRCOUNT=LRCOUNT+1
 . . I LRCOUNT>1 M ^TMP("LR63.04B",$J,LRA)=^DD(63.04,"B",LRA)
 ;
 ;Check whether issues were found. If so, add to MailMan ^TMP from LRWU9
 I $D(^TMP("LR63.04B",$J)) D BMAIL
 Q
 ;
BMAIL ;Generate MailMan message for "B" cross ref issues
 N LRSPACE,LRDASH,LRSTR,LRHIT,LRA,LRB
 S LRSPACE="                              "
 S LRDASH="------------------------------------------------------------"
 S LRNUM=LRNUM+1
 S ^TMP("LR",$J,"DD63.04",LRNUM)=" "
 S LRNUM=LRNUM+1
 S ^TMP("LR",$J,"DD63.04",LRNUM)="**** The following issue(s) were found in ^DD(63.04. ****"
 S LRNUM=LRNUM+1
 S ^TMP("LR",$J,"DD63.04",LRNUM)="Please submit a ServiceNow ticket with the assignment group"
 S LRNUM=LRNUM+1
 S ^TMP("LR",$J,"DD63.04",LRNUM)="of NTL SUP CLIN2 for assistance with correcting the issue(s)."
 S LRNUM=LRNUM+1
 S ^TMP("LR",$J,"DD63.04",LRNUM)=" "
 S LRNUM=LRNUM+1
 S ^TMP("LR",$J,"DD63.04",LRNUM)="NOTE: Names such as ""not in use"", etc. which do not appear to"
 S LRNUM=LRNUM+1
 S ^TMP("LR",$J,"DD63.04",LRNUM)="      pertain to active tests do not warrant correction."
 S LRNUM=LRNUM+1
 S ^TMP("LR",$J,"DD63.04",LRNUM)=" "
 S LRNUM=LRNUM+1
 S ^TMP("LR",$J,"DD63.04",LRNUM)="Name(s) With Multiple IENs"
 S LRNUM=LRNUM+1
 S ^TMP("LR",$J,"DD63.04",LRNUM)="Name                     IEN"
 S LRNUM=LRNUM+1
 S ^TMP("LR",$J,"DD63.04",LRNUM)=LRDASH
 S (LRA,LRB)=""
 F  S LRA=$O(^TMP("LR63.04B",$J,LRA)) Q:LRA=""  D
 . S LRB=$O(^TMP("LR63.04B",$J,LRA,"")) D
 . . S LRNUM=LRNUM+1
 . . S ^TMP("LR",$J,"DD63.04",LRNUM)=$E(LRA,1,23)_$E(LRSPACE,1,25-$L(LRA))_LRB
 . F  S LRB=$O(^TMP("LR63.04B",$J,LRA,LRB)) Q:LRB=""  D
 . . S LRNUM=LRNUM+1
 . . S ^TMP("LR",$J,"DD63.04",LRNUM)=$E(LRSPACE,1,25)_LRB
 . ;
 S LRNUM=LRNUM+1
 S ^TMP("LR",$J,"DD63.04",LRNUM)=" "
 S LRNUM=LRNUM+1
 S ^TMP("LR",$J,"DD63.04",LRNUM)="**** End of issue(s) found in ^DD(63.04 ****"
 S LRNUM=LRNUM+1
 S ^TMP("LR",$J,"DD63.04",LRNUM)=" "
 Q
 ;
LRNIGHT ;
 ;LR*5.2*543: Check for OI's pointing to non-existent Lab tests.
 ;            Entries which do not have names beginning with "ZZ" and/or
 ;            inactive dates are captured.
 N LRSPACE,LRNAME,LROI,LRTST,LRSEQ,LRNAMX
 K ^TMP("LR OI CHECK")
 S LRSPACE="                                     "
 S (LRNAME,LROI)="",LRSEQ=11
 F  S LRNAME=$O(^ORD(101.43,"S.LAB",LRNAME)) Q:LRNAME=""  D
 . F  S LROI=$O(^ORD(101.43,"S.LAB",LRNAME,LROI)) Q:LROI=""  D
 . . ;Do not list if name starts with ZZ and inactive date is populated
 . . I $E(LRNAME,1,2)="ZZ",$P($G(^ORD(101.43,LROI,.1)),"^")]"" Q
 . . S LRTST=$P($P($G(^ORD(101.43,LROI,0)),"^",2),";99LRT")
 . . I LRTST]"",'$D(^LAB(60,LRTST,0)) D
 . . . S LRSEQ=LRSEQ+1
 . . . S LRNAMX=$E(LRNAME,1,30)
 . . . S ^TMP("LR OI CHECK",LRSEQ)=LRNAMX_" (#"_LROI_")"_$E(LRSPACE,1,37-($L(LRNAMX)+$L(LROI)))_LRTST
 I $O(^TMP("LR OI CHECK",11)) D XTMP,MAIL
 K ^TMP("LR OI CHECK")
 ;
 ;LR*5.2*549 Add check for invalid values in ORGANISM data 
 D LRORG
 Q
 ;
XTMP ;Generate MailMan message
 S ^TMP("LR OI CHECK",1)=" "
 S ^TMP("LR OI CHECK",2)="The NIGHTLY CLEANUP task found "_(LRSEQ-11)_" entries in the ORDERABLE ITEMS (#101.43)"
 S ^TMP("LR OI CHECK",3)="file of concern that reference non-existent Laboratory tests. Listed below"
 S ^TMP("LR OI CHECK",4)="are such entries which have a name not prefixed with ""ZZ"" and/or no date in"
 S ^TMP("LR OI CHECK",5)="the INACTIVATED (#.1) field."
 S ^TMP("LR OI CHECK",6)=" "
 S ^TMP("LR OI CHECK",7)="The following should be edited in the ORDERABLE ITEMS (#101.43) file so the"
 S ^TMP("LR OI CHECK",8)="name is prefixed with ""ZZ"" and a date entered into the INACTIVATED (#.1) field."
 S ^TMP("LR OI CHECK",9)=" "
 S ^TMP("LR OI CHECK",10)="Orderable Item/IEN                       Non-Existent Laboratory Test IEN"
 S ^TMP("LR OI CHECK",11)="--------------------------               --------------------------------"
 Q
 ;
MAIL ;
 N LRMIN,LRMY,LRMSUB,LRMTEXT
 S LRMIN("FROM")="NIGHTLY TASK CLEANUP"
 S LRMY("G.LMI")=""
 S LRMY("G.OR CACS")=""
 S LRMSUB="ORDERABLE ITEMS POINTING TO NON-EXISTENT LAB TESTS"
 S LRMTEXT="^TMP(""LR OI CHECK"")"
 D SENDMSG^XMXAPI(DUZ,LRMSUB,LRMTEXT,.LRMY,.LRMIN,"","")
 Q
 ;
LRORG ;
 ; LR*5.2*549 Check for missing Organism zero node or null organism pointer
 N LRDFN,LRDTM,LRSEQ,LRSQ,LRDATA
 K ^TMP("LR ORG CHECK")
 S LRSPACE="                                     "
 S LRDFN=0,LRSEQ=7
 F  S LRDFN=$O(^LR(LRDFN)) Q:'LRDFN  D
 . S LRDTM=0 F  S LRDTM=$O(^LR(LRDFN,"MI",LRDTM)) Q:'LRDTM  D
 . . S LRSQ=0 F  S LRSQ=$O(^LR(LRDFN,"MI",LRDTM,3,LRSQ)) Q:'LRSQ  D
 . . . I $P($G(^LR(LRDFN,"MI",LRDTM,3,LRSQ,0)),U)'="" Q
 . . . S LRDATA=$G(^LR(LRDFN,"MI",LRDTM,0))
 . . . S LRDATA="^LR("_LRDFN_","_"""MI"""_","_LRDTM_",0)="_LRDATA
 . . . S LRSEQ=LRSEQ+1,^TMP("LR ORG CHECK",LRSEQ)=LRDATA
 . . . S LRSEQ=LRSEQ+1,^TMP("LR ORG CHECK",LRSEQ)=" "
 I $O(^TMP("LR ORG CHECK",6)) D XTMPORG,MAILORG
 K ^TMP("LR ORG CHECK")
 Q
 ;
XTMPORG ;Generate MailMan message
 S ^TMP("LR ORG CHECK",1)=" "
 S ^TMP("LR ORG CHECK",2)="The following entries in the LAB DATA file (#63) have corrupted organism"
 S ^TMP("LR ORG CHECK",3)="nodes and require repair.  Please enter a YourIT ticket requesting regional"
 S ^TMP("LR ORG CHECK",4)="support for the Laboratory package."
 S ^TMP("LR ORG CHECK",5)="----------------------------------------------------------------------------"
 S ^TMP("LR ORG CHECK",6)=" "
 Q
 ;
MAILORG ;
 N LRMIN,LRMY,LRMSUB,LRMTEXT
 S LRMIN("FROM")="ORGANISM NIGHTLY TASK REVIEW"
 S LRMY("G.LMI")=""
 S LRMSUB="CORRUPT ORGANISM DATA REPORT"
 S LRMTEXT="^TMP(""LR ORG CHECK"")"
 D SENDMSG^XMXAPI(DUZ,LRMSUB,LRMTEXT,.LRMY,.LRMIN,"","")
 Q
 ;
LRHOWDY ;
 ;LR*5.2*554 Purge 69.87 records older than 9 years old
 N LRPDT,LRSTDT,LRDA,DA,DIK,LRUID
 ;SET PURGE DATE TO 9 YEARS AGO
 S LRPDT=DT-90000,LRUID=""
 F  S LRUID=$O(^LRHY(69.87,"B",LRUID)) Q:LRUID=""  D
 . ;Loop thru just in case there could ever have been multiple records for a UID
 . S LRDA=0 F  S LRDA=$O(^LRHY(69.87,"B",LRUID,LRDA)) Q:'LRDA  D
 . . S LRSTDT=$P($G(^LRHY(69.87,LRDA,2)),".") ;INITIAL SCAN TIME
 . . I 'LRSTDT S LRSTDT=$P($G(^LRHY(69.87,LRDA,8)),".") ;COLLECTION TIME
 . . I 'LRSTDT S LRSTDT=$P($G(^LRHY(69.87,LRDA,4)),".") ;TIME LABEL PRINTED
 . . I LRSTDT'<LRPDT Q
 . . S DIK="^LRHY(69.87,",DA=LRDA D ^DIK
 Q
