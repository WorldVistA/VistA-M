IB20P244 ;ISP/TDP - Post-Init routine for IB*2.0*244 ;10/14/2003
 ;;2.0;INTEGRATED BILLING;**244**;21-MAR-94
POST ; This routine is to remove hyphens from the SUBSCRIBER ID (#1) field
 ; of the INSURANCE TYPE SUB-FIELD (#2.312) file of the PATIENT (#2)
 ; file.  It also will delete invalid entries from the IB DM EXTRACT
 ; DATA (#351.71) file.
 ;
EN ; Start of Post-Init process.
 N %,IBDATE,IBNOW,IBPURGE,X,X1,X2
 D NOW^%DTC S (IBNOW,X1)=X,IBDATE=%
 S X2=120
 D C^%DTC S IBPURGE=X
 ;K ^XTMP("IB20P244",IBDATE)
 S ^XTMP("IB20P244",0)=IBPURGE_"^"_IBNOW_"^"_$G(DUZ)
 D SUBSCR
 D INSUR
 D END
 Q
SUBSCR ;Remove all hyphens from subscriber ID's in the INSURANCE TYPE
 ;SUB-FIELD (#2.312) file of the PATIENT (#2) file.
 D MES^XPDUTL("SUBSCRIBER ID clean up started in the")
 D MES^XPDUTL("   INSURANCE TYPE SUB-FIELD (#2.312) file.")
 D MES^XPDUTL("> Searching for SUBSCRIBER ID's containing invalid characters.")
 D MES^XPDUTL(" ")
 N DA,DFN,DIE,DR,IBCHAR,IBCHAR1,IBCNT,IBHICN,IBINS,IBINSCO,IBNAME,IBNODE
 N IBRC,IBSSN,IBSUB,IBSUB1,IBSUB2,IBWNR
 K ^TMP("IB20P244",$J)
 S ^TMP("IB20P244",$J)=""
 S IBCHAR="~` !@#$%^&*()_-+={}[]|\/:;<>,.?'"""
 S IBCHAR1="~`!@$%^&*()_+={}[]|:;<>?'"""
 S IBWNR=+$$GETWNR^IBCNSMM1
 S (DFN,IBRC,IBCNT)=0
 ; Loop through Patient (#2) file
 F  S DFN=$O(^DPT(DFN)) Q:DFN=""  D
 . S IBINS=0
 . ; Loop through Insurance Type Sub-Field
 . F  S IBINS=$O(^DPT(DFN,.312,IBINS)) Q:IBINS=""  D
 .. S IBCNT=IBCNT+1 I IBCNT>999 W ". " S IBCNT=0
 .. S IBNODE=$G(^DPT(DFN,.312,IBINS,0))
 .. ; Get Subscriber ID
 .. S IBSUB=$P(IBNODE,U,2) I IBSUB="" Q
 .. S IBSSN=$TR($P($G(^DPT(DFN,0)),U,9),IBCHAR,"")
 .. S IBNAME=$P($G(^DPT(DFN,0)),U,1)
 .. ; Remove non-alphanumeric characters
 .. I $P(IBNODE,U,1)=IBWNR D  ;Medicare
 ... S IBSUB1=$TR(IBSUB,IBCHAR,"")
 ... ; Check for invalid HICN format and no date of death
 ... I '$$VALHIC^IBCNSMM(IBSUB1),'$P($G(^DPT(DFN,.35)),U,1) S ^TMP("IB20P244",$J,"HICN INVALID",IBNAME_" ("_IBSSN_")")=IBSUB_"^"_IBSUB1
 .. I $P(IBNODE,U,1)'=IBWNR D  ;non-Medicare
 ... S IBSUB1=$TR(IBSUB,IBCHAR1,"")
 ... ;If subscriber id is SSN, then remove all extraneous characters
 ... S IBSUB2=$TR(IBSUB1," #-/\,.","")
 ... I IBSUB2=IBSSN,$L(IBSSN)=9 S IBSUB1=IBSUB2
 .. ;I IBHICN S ^TMP("IB20P244",$J,"HICN INVALID",IBNAME_" ("_IBSSN_")")=IBSUB_"^"_IBSUB1 S IBHICN=0
 .. ; Quit if no change in data
 .. I IBSUB1=IBSUB Q
 .. S IBINSCO=$P($G(^DIC(36,$P($G(^DPT(DFN,.312,IBINS,0)),U,1),0)),U,1)
 .. S IBRC=IBRC+1
 .. S ^XTMP("IB20P244",IBDATE,"SUB",DFN,IBINS)=IBSUB_"^"_IBSUB1
 .. ; Save newly cleaned Subscriber ID
 .. S DA=IBINS,DA(1)=DFN,DR="1////"_$S(IBSUB1="":"@",1:IBSUB1),DIE="^DPT(DFN,.312," D ^DIE
 .. ;D MES^XPDUTL(">> Converted SUBSCRIBER ID of patient "_IBNAME_" ("_IBSSN_") from "_IBSUB_" to "_IBSUB1_" for insurance company "_IBINSCO)
 D BMES^XPDUTL("> "_IBRC_" total SUBSCRIBER ID(S) were cleaned up.")
 I $D(^TMP("IB20P244",$J,"HICN INVALID")) D MESSAGE
 K ^TMP("IB20P244",$J)
 Q
 ;
END ; display message that post-init has completed successfully
 K X,Y
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Data clean up conversions complete.")
 Q
 ;
INSUR ;This will remove all future dates and all past date entries which
 ;contain a day other than "00".  For example, 3031000 is a valid entry
 ;while 3051200 and 3031014 are not based on a current date of 3031015.
 N FTDT,PTDT
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("IB DM EXTRACT DATA (#351.71) file clean up started.")
 D MES^XPDUTL("> Searching for invalid entries.")
 D FUTURE
 D PAST
 D MES^XPDUTL(" ")
 I FTDT D MES^XPDUTL(">> "_FTDT_" invalid future date entries were deleted.")
 I 'FTDT D MES^XPDUTL(">> There were no invalid future date entries found.")
 I PTDT D MES^XPDUTL(">> "_PTDT_" invalid past date entries were deleted.")
 I 'PTDT D MES^XPDUTL(">> There were no invalid past date entries found.")
 D BMES^XPDUTL("> IB DM EXTRACT DATA (#351.71) file clean up completed.")
INSURQ Q
 ;
FUTURE ;This utility searches for and deletes future date entries from file
 ;351.71.
 ;Outputs:  FTDT - number of future date entries deleted from 351.71.
 ; ^XTMP("IB20P244",IBDATE,"INS","FUT") - This global is created
 ;        to temporarily store the data from the deleted future
 ;        date entries.  Will not exist if no future dates are
 ;        found.
 N CDT,DA,DATE,DIK
 S FTDT=0
 D NOW^%DTC S CDT=X
 S DATE=99999999
 F  S DATE=$O(^IBE(351.71,DATE),-1) Q:DATE'>CDT  D
 . M ^XTMP("IB20P244",IBDATE,"INS","FUT",DATE)=^IBE(351.71,DATE)
 . S DIK="^IBE(351.71,",DA=DATE D ^DIK
 . S FTDT=FTDT+1
 . Q
 Q
 ;
PAST ;This utility searches for and deletes past date entries from file
 ;351.71 that end with something other than "00".
 ;Outputs:  PTDT - number of entries deleted from 351.71.
 ; ^XTMP("IB20P244",IBDATE,"INS","PST") - This global is created
 ;        to temporarily store the data from the deleted past
 ;        date entries.  Will not exist if no past dates are
 ;        found.
 N DA,DATE,DIK
 S PTDT=0
 S DATE=0
 F  S DATE=$O(^IBE(351.71,DATE)) Q:DATE=""  D
 . I $E(DATE,6,7)="00" Q
 . I 'DATE Q
 . M ^XTMP("IB20P244",IBDATE,"INS","PST",DATE)=^IBE(351.71,DATE)
 . S DIK="^IBE(351.71,",DA=DATE D ^DIK
 . S PTDT=PTDT+1
 . Q
 Q
 ;
MESSAGE ; Send message reporting invalid HICN format
 N IBC,IBBCNT,IBCNT,IBDATA,IBFCNT,IBIDENT,IBGROUP,IBGRP,IBINSCO,IBMMSG
 N IBMSG,IBNETNM,IBPARAM,IBSUB,IBTCNT,IBTST,IBTXT,XMDUZ,XMERR,XMSUB
 N XMTEXT,XMY
 S IBTCNT=0,IBIDENT=""
 F  S IBIDENT=$O(^TMP("IB20P244",$J,"HICN INVALID",IBIDENT)) Q:IBIDENT=""  D
 . S IBTCNT=IBTCNT+1
 S IBSUB=0
 D MSGHDR
 I DUZ="" N DUZ S DUZ=.5 ; if user not defined set to postmaster
 S XMDUZ=DUZ,XMTEXT=$NA(^TMP($J))
 S IBPARAM("FROM")="PATCH IB*2.0*244 POST-INIT"
 S IBGROUP="IB EDI SUPERVISOR"
 S IBGRP=$O(^XMB(3.8,"B",IBGROUP,"")) I IBGRP D  ;billing group defined
 . I +$P($G(^XMB(3.8,IBGRP,1,0)),U,4)'>0 Q  ; no members defined
 . S XMY("G."_IBGROUP)="" ; send message to the group.
 ;I '$D(^XMB(3.8,"B",IBGROUP)) S IBGROUP=DUZ ; billing group not defined - send to the user
 ;E  S IBGROUP="G."_IBGROUP
 S XMY(DUZ)="" ; send message to user
 ;Send to developer if not test account (next 3 lines)
 S IBTST=".TEST.MIR.TST.MIRROR.TRAIN."     ; various test names
 S IBNETNM=$G(^XMB("NETNAME"))
 I IBNETNM'="",('$F(IBTST,"."_$P(IBNETNM,".",1)_".")) S XMY("PHELPS,TY@FORUM.VA.GOV")=""
 ;
 S IBINSCO=$P($G(^DIC(36,IBWNR,0)),U,1)
MSG1 S IBC=0
 S IBC=IBC+1,^TMP($J,IBC)="This message has been sent by patch IB*2.0*244 at the completion of"
 S IBC=IBC+1,^TMP($J,IBC)="the post-init routine."
 S IBC=IBC+1,^TMP($J,IBC)="The following "_IBINSCO_" SUBSCRIBER ID entries remain in an invalid state:"
 S IBC=IBC+1,^TMP($J,IBC)="  "
 S IBC=IBC+1,^TMP($J,IBC)="NAME(SSN) ^ ORIGINAL ID ^ MODIFIED ID"
 S IBC=IBC+1,^TMP($J,IBC)="  "
 S (IBMMSG,IBMSG)=0
 I IBSUB=1 S IBCNT=0,IBIDENT="",IBBCNT=1
 I IBSUB>1 S IBBCNT=IBCNT+1
 F  S IBIDENT=$O(^TMP("IB20P244",$J,"HICN INVALID",IBIDENT)) Q:IBIDENT=""  D  G:IBMSG MSG1
 . S IBDATA=$G(^TMP("IB20P244",$J,"HICN INVALID",IBIDENT))
 . S IBC=IBC+1,^TMP($J,IBC)=IBIDENT_"^"_IBDATA
 . S IBCNT=IBCNT+1
 . I 'IBMMSG S IBMMSG=1
 . I IBC>9500 S IBFCNT=IBCNT D
 .. S IBC=IBC+1,^TMP($J,IBC)="  "
 .. S IBC=IBC+1,^TMP($J,IBC)="This message contains "_IBBCNT_" thru "_IBFCNT_" of "_IBTCNT_" total"
 .. S IBC=IBC+1,^TMP($J,IBC)="records left in an invalid state."
 .. D SNDMSG,MSGHDR S IBMSG=1
 S IBC=IBC+1,^TMP($J,IBC)="  "
 I IBSUB=1 D
 .S IBC=IBC+1,^TMP($J,IBC)="Total records left in an invalid state: "_IBCNT_"."
 I IBSUB>1 D
 . S IBC=IBC+1,^TMP($J,IBC)="This message contains "_IBBCNT_" thru "_IBCNT_" of "_IBTCNT_" total"
 . S IBC=IBC+1,^TMP($J,IBC)="records left in an invalid state."
 I IBMMSG D SNDMSG
 Q
SNDMSG ;
 D SENDMSG^XMXAPI(XMDUZ,XMSUB,XMTEXT,.XMY,.IBPARAM,"","")
 S IBTXT="Invalid Medicare SUBSCRIBER ID message #"_IBSUB_" "_$S($D(XMERR):"not sent due to error in message set up.",1:"sent to ")_$S($D(XMY("G.IB EDI SUPERVISOR")):"IB EDI SUPERVISOR mail group, ",1:"")
 D BMES^XPDUTL(IBTXT)
 S IBTXT="   the "_$S(DUZ=.5:"POSTMASTER ",1:"user ")_"and the patch developer."
 D MES^XPDUTL(IBTXT)
 K ^TMP($J)
 Q
 ;
MSGHDR ;Creates message subject line
 K ^TMP($J)
 S IBSUB=IBSUB+1
 S XMSUB="SUBSCRIBER ID CLEAN UP COMPLETE"
 I IBSUB>1 S XMSUB=XMSUB_" (MSG #"_IBSUB_")"
 Q
