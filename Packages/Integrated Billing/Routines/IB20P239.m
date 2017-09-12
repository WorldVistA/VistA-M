IB20P239 ;ISP/TDP - Post-Init routine for IB*2.0*239 ;11/14/2003
 ;;2.0;INTEGRATED BILLING;**239**;21-MAR-94
 ; This routine is to remove hyphens from the SUBSCRIBER ID (#1) field
 ; of the INSURANCE TYPE SUB-FIELD (#2.312) file of the PATIENT (#2)
 ; file.  It also will delete invalid entries from the IB DM EXTRACT
 ; DATA (#351.71) file.
 ;
 Q
POST ; Start of Post-Init process.
 N BILL,CU,DA,DATA,DBILL,DCU,DFORM,DID,DIE,DINS,DR,FORM,IB35591,IBACCNT
 N IBANQCNT,IBCNT,IBNOW,IBPURGE,IBTYPE,ID,IEN,INS,X,X1,X2
 D BMES^XPDUTL("PROVIDER ID CARE UNIT clean up started in the")
 D MES^XPDUTL("   IB INSURANCE CO LEVEL BILLING PROV ID (#355.91) file.")
 ;D BMES^XPDUTL(" ")
 D BMES^XPDUTL("> Searching for Care Unit values of -1.")
 ;D BMES^XPDUTL(" ")
 K ^XTMP("IB20P239",$J)
 D NOW^%DTC S (IBNOW,X1)=X
 S X2=30
 D C^%DTC S IBPURGE=X
 S ^XTMP("IB20P239",0)=IBPURGE_"^"_IBNOW_"^"_$G(DUZ)
 S DA="",(IBACCNT,IBANQCNT,IBCNT)=0
 ;Find and delete the -1 Care Unit values from the records.
 F  S DA=$O(^IBA(355.91,DA)) Q:DA=""  D
 . I $P($G(^IBA(355.91,DA,0)),U,3)=-1 D
 .. S DR=".03///@",DIE="^IBA(355.91,"
 .. S IB35591=$G(^IBA(355.91,DA,0))
 .. L +^IBA(355.91,DA) I $T D ^DIE L -^IBA(355.91,DA)
 .. S ^XTMP("IB20P239",$J,DA,0)=IB35591,IBCNT=IBCNT+1
 .. D MES^XPDUTL(">> Record "_DA_" has been modified.")
 ;Now, clean up the "AC" and "AUNIQ" cross-references that may have been
 ;left with -1 Care Unit values or invalid cross-references.
 D BMES^XPDUTL("> Searching for invalid ""AUNIQ"" cross-references.")
 S INS=""
 F  S INS=$O(^IBA(355.91,"AUNIQ",INS)) Q:INS=""  D
 . S CU=""
 . F  S CU=$O(^IBA(355.91,"AUNIQ",INS,CU)) Q:CU=""  D
 .. S FORM=""
 .. F  S FORM=$O(^IBA(355.91,"AUNIQ",INS,CU,FORM)) Q:FORM=""  D
 ... S BILL=""
 ... F  S BILL=$O(^IBA(355.91,"AUNIQ",INS,CU,FORM,BILL)) Q:BILL=""  D
 .... S ID=""
 .... F  S ID=$O(^IBA(355.91,"AUNIQ",INS,CU,FORM,BILL,ID)) Q:ID=""  D
 ..... S IEN=""
 ..... F  S IEN=$O(^IBA(355.91,"AUNIQ",INS,CU,FORM,BILL,ID,IEN)) Q:IEN=""  D
 ...... I CU<0 D AUNIQ Q
 ...... S DATA=$G(^IBA(355.91,IEN,0))
 ...... I DATA="" D AUNIQ Q
 ...... S DINS=$P(DATA,"^",1)
 ...... S DCU=$P(DATA,"^",10)
 ...... S DFORM=$P(DATA,"^",4)
 ...... S DBILL=$P(DATA,"^",5)
 ...... S DID=$P(DATA,"^",6)
 ...... I DINS'=INS!(DCU'=CU)!(DFORM'=FORM)!(DBILL'=BILL)!(DID'=ID) D AUNIQ Q
 D BMES^XPDUTL("> Searching for invalid ""AC"" cross-references.")
 F  S INS=$O(^IBA(355.91,"AC",INS)) Q:INS=""  D
 . S ID=""
 . F  S ID=$O(^IBA(355.91,"AC",INS,ID)) Q:ID=""  D
 .. S CU=""
 .. F  S CU=$O(^IBA(355.91,"AC",INS,ID,CU)) Q:CU=""  D
 ... S IEN=""
 ... F  S IEN=$O(^IBA(355.91,"AC",INS,ID,CU,IEN)) Q:IEN=""  D
 .... I CU<0 D AC Q
 .... S DATA=$G(^IBA(355.91,IEN,0))
 .... I DATA="" D AC Q
 .... S DINS=$P(DATA,"^",1)
 .... S DID=$P(DATA,"^",6)
 .... S DCU=$P(DATA,"^",10)
 .... I DINS'=INS!(DID'=ID)!(DCU'=CU) D AC Q
 D BMES^XPDUTL("> Searches have completed.")
 I IBACCNT!(IBANQCNT)!(IBCNT) D
 . D MES^XPDUTL(" ")
 . D MES^XPDUTL("> "_IBCNT_" total records were modified.")
 . D MES^XPDUTL("> "_IBACCNT_" total ""AC"" cross-references were modified.")
 . D MES^XPDUTL("> "_IBANQCNT_" total ""AUNIQ"" cross-references were modified.")
 I 'IBACCNT,'IBANQCNT,'IBCNT D
 . D BMES^XPDUTL("> No records needed to be modified.")
 ;D BMES^XPDUTL(" ")
 D BMES^XPDUTL("PROVIDER ID CARE UNIT clean up completed.")
END ; display message that pre-init has completed successfully
 K BILL,CU,DA,DATA,DBILL,DCU,DFORM,DID,DIE,DINS,DR,FORM,IB35591,IBACCNT
 K IBANQCNT,IBCNT,IBNOW,IBPURGE,IBTYPE,ID,IEN,INS,X,X1,X2
 Q
AC ;Set "AC" cross-reference entry into temporary global then kill the
 ;"AC" cross-reference.
 S IBACCNT=IBACCNT+1
 S ^XTMP("IB20P239",$J,"AC",INS,ID,CU,IEN)=""
 K ^IBA(355.91,"AC",INS,ID,CU,IEN)
 Q
AUNIQ ;Set "AUNIQ" cross-reference entry into temporary global then kill the
 ;"AUNIQ" cross-reference.
 S IBANQCNT=IBANQCNT+1
 S ^XTMP("IB20P239",$J,"AUNIQ",INS,CU,FORM,BILL,ID,IEN)=""
 K ^IBA(355.91,"AUNIQ",INS,CU,FORM,BILL,ID,IEN)
 Q
 ;
MSG ; Send message
 N IBC,IBGROUP,IBPARAM,IBTXT,XMDUZ,XMERR,XMSUB,XMTEXT,XMY
 S XMSUB="PROVIDER ID CARE UNIT CLEAN UP COMPLETE"
 S XMDUZ=DUZ,XMTEXT="IBTXT"
 S IBPARAM("FROM")="PATCH IB*2.0*239 POST-INIT"
 S IBGROUP="IB EDI SUPERVISOR"
 I '$D(^XMB(3.8,"B",IBGROUP)) S IBGROUP=DUZ ; billing group not defined - send to the user
 E  S IBGROUP="G."_IBGROUP
 S XMY(IBGROUP)="",XMY("PHELPS.TY@DOMAIN.EXT")=""
 ;
 S IBC=0
 S IBC=IBC+1,IBTXT(IBC)="This message has been sent by patch IB*2.0*239 at the completion of"
 S IBC=IBC+1,IBTXT(IBC)="the post-init routine."
 S IBC=IBC+1,IBTXT(IBC)="The following entries in file 355.91 have been modified:"
 S IBC=IBC+1,IBTXT(IBC)="  "
 S IBCNT=0,DA=""
 F  S DA=$O(^XTMP("IB20P239",$J,DA)) Q:DA=""  D
 . S IBC=IBC+1,IBTXT(IBC)="^IBA(355.91,DA)"
 . S IBCNT=IBCNT+1
 S IBC=IBC+1,IBTXT(IBC)="  "
 S IBC=IBC+1,IBTXT(IBC)="Total records modified: "_IBCNT_"."
 D SENDMSG^XMXAPI(XMDUZ,XMSUB,XMTEXT,.XMY,.IBPARAM,"","")
 S IBTXT="Provider ID Care Unit clean up message "_$S($D(XMERR):"not sent due to error in message set up.",1:"sent to IB EDI SUPERVISOR mail group and to the patch developer.")
 D BMES^XPDUTL(IBTXT)
 Q
