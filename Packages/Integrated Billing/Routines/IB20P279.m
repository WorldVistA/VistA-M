IB20P279 ;ISP/TDP - IB*2*279 PRE-INIT ROUTINE ;07/21/2004
 ;;2.0;INTEGRATED BILLING;**279**;21-MAR-94
 ;
ENV ; environment check
PRE ; set up check points for pre-init
 N %
 S %=$$NEWCP^XPDUTL("PROVID","PROVID^IB20P279")
 Q
PROVID ;Search files 355.9 and 355.91 for invalid Care Unit pointers to file
 ;355.96.
 D BMES^XPDUTL("Beginning invalid Care Unit pointer search.")
 D 3559,35591 I $D(^TMP($J,"IB20P279")) D MESSAGE
 D COMPLETE
 D END
 Q
35591 ;Search file 355.91 for invalid Care Unit pointers to file 355.96.
 D BMES^XPDUTL("Searching for invalid Care Unit pointers in file 355.91.")
 N DA,DIE,DR,IB35591,IBCARE,IBCIVAL,IBCNT,IBCU,IBCUCHK,IBECNT,IBFORM
 N IBINS,IBINSNM,IBNUM,IBPRVID,IBPRVTYP
 S (IBCNT,IBECNT,IBNUM)=0
 S DIE="^IBA(355.91,"
 F  S IBNUM=$O(^IBA(355.91,IBNUM)) Q:IBNUM=""  D
 . I 'IBNUM Q
 . S IB35591=$G(^IBA(355.91,IBNUM,0)) I IB35591="" Q
 . S IBINS=$P(IB35591,U,1)
 . S IBCU=$P(IB35591,U,3) I IBCU="" Q
 . S IBFORM=$P(IB35591,U,4)
 . S IBCARE=$P(IB35591,U,5)
 . S IBPRVID=$P(IB35591,U,6)
 . D VALIDCU I IBCIVAL=IBCU Q
 . S IBCUCHK=0 D CUCHK I IBCUCHK D  Q
 .. S IBINSNM=$P($G(^DIC(36,IBINS,0)),U,1) I IBINSNM="" S IBINSNM="UNKNOWN (IEN "_IBINS_")"
 .. S IBPRVTYP=$P($G(^IBE(355.97,IBPRVID,0)),U,1)
 .. S ^TMP($J,"IB20P279",IBINSNM,IBPRVTYP,"<<INS CO DEFAULT>>",IBNUM)=IB35591
 .. S IBECNT=IBECNT+1
 .. D OUTPUT
 . D FILE
 D TOTALS
 Q
3559 ;Search file 355.9 for invalid Care Unit pointers to file 355.96.
 D BMES^XPDUTL("Searching for invalid Care Unit pointers in file 355.9.")
 N DA,DIE,DR,IB3559,IBCARE,IBCIVAL,IBCNT,IBCU,IBCUCHK,IBECNT,IBFORM,IBGBL
 N IBINS,IBINSNM,IBNAME,IBNUM,IBPROV,IBPRVID,IBPRVTYP
 K ^TMP($J,"IB20P279")
 S (IBCNT,IBECNT,IBNUM)=0
 S DIE="^IBA(355.9,"
 F  S IBNUM=$O(^IBA(355.9,IBNUM)) Q:IBNUM=""  D
 . I 'IBNUM Q
 . S IB3559=$G(^IBA(355.9,IBNUM,0)) I IB3559="" Q
 . S IBPROV=$P(IB3559,U,1)
 . S IBINS=$P(IB3559,U,2)
 . S IBCU=$P(IB3559,U,3) I IBCU="" Q
 . S IBFORM=$P(IB3559,U,4)
 . S IBCARE=$P(IB3559,U,5)
 . S IBPRVID=$P(IB3559,U,6)
 . D VALIDCU I IBCIVAL=IBCU Q
 . S IBCUCHK=0 D CUCHK I IBCUCHK D  Q
 .. S IBINSNM=$P($G(^DIC(36,IBINS,0)),U,1) I IBINSNM="" S IBINSNM="UNKNOWN (IEN "_IBINS_")"
 .. S IBPRVTYP=$P($G(^IBE(355.97,IBPRVID,0)),U,1)
 .. S IBGBL="^"_$P($G(IBPROV),";",2)_$P($G(IBPROV),";",1)_",0)"
 .. S IBNAME=$P($G(@IBGBL),"^",1)
 .. S ^TMP($J,"IB20P279",IBINSNM,IBPRVTYP,IBNAME,IBNUM)=IB3559
 .. S IBECNT=IBECNT+1
 .. D OUTPUT
 . D FILE
 D TOTALS
 Q
TOTALS ; Print cleanup totals.
 N IBFILE
 S IBFILE=$S(DIE["355.91":"355.91.",1:"355.9.")
 I 'IBCNT,'IBECNT D BMES^XPDUTL("There were no invalid Care Unit pointers in file "_IBFILE) Q
 I IBCNT D BMES^XPDUTL(IBCNT_" total invalid Care Unit pointer(s) were corrected in file "_IBFILE)
 I IBECNT D BMES^XPDUTL(IBECNT_" total invalid Care Unit pointer(s) were NOT corrected in file "_IBFILE)
 Q
OUTPUT ; Failed conversion message.
 D MES^XPDUTL("> Cannot change Care Unit Pointer for "_DIE_IBNUM_").  A Mailman")
 D MES^XPDUTL("  message will be generated with more information.")
 Q
FILE ; Save change and display success message.
 N IBL,IBLOCK,X
 S IBL=0
 S IBLOCK=DIE_IBNUM_")"
 F X=1:1:10 L +@IBLOCK:2 H:'$T 5 I $T S IBL=1 Q
 I 'IBL D  Q
 . S IBINSNM=$P($G(^DIC(36,IBINS,0)),U,1) I IBINSNM="" S IBINSNM="UNKNOWN (IEN "_IBINS_")"
 . S IBPRVTYP=$P($G(^IBE(355.97,IBPRVID,0)),U,1)
 . S IBGBL="^"_$P($G(IBPROV),";",2)_$P($G(IBPROV),";",1)_",0)"
 . S IBNAME=$P($G(@IBGBL),"^",1)
 . S ^TMP($J,"IB20P279",IBINSNM,IBPRVTYP,IBNAME,IBNUM)=$S($D(IB3559):IB3559,1:IB35591)
 . S IBECNT=IBECNT+1
 . D OUTPUT
 S DA=IBNUM
 S DR=".03////"_IBCIVAL
 D ^DIE K DA,DR
 L -@IBLOCK
 D MES^XPDUTL("> Care Unit Pointer for "_DIE_IBNUM_") has been updated.")
 S IBCNT=IBCNT+1
 Q
VALIDCU ;Checks for valid Care Unit combination.
 ;Set IBCIVAL to insure Care Unit Pointer (355.9 and 355.91) is correct.
 N IBCUVAL
 S IBCUVAL=$P($G(^IBA(355.96,+IBCU,0)),U,1) I IBCUVAL="" S IBCIVAL="@" Q
 S IBCIVAL=$O(^IBA(355.96,"AUNIQ",IBINS,IBCUVAL,IBFORM,IBCARE,IBPRVID,"")) I IBCIVAL'="" Q
 S IBCIVAL=$O(^IBA(355.96,"AUNIQ",IBINS,IBCUVAL,IBFORM,0,IBPRVID,"")) I IBCIVAL'="" Q
 S IBCIVAL=$O(^IBA(355.96,"AUNIQ",IBINS,IBCUVAL,0,IBCARE,IBPRVID,"")) I IBCIVAL'="" Q
 S IBCIVAL=$O(^IBA(355.96,"AUNIQ",IBINS,IBCUVAL,0,0,IBPRVID,"")) I IBCIVAL'="" Q
 S IBCIVAL="@"
 Q
CUCHK ;Checks for existing Care Unit combination.
 I DIE="^IBA(355.91,",$D(^IBA(355.91,"AUNIQ",IBINS,$S(IBCIVAL="@":"*N/A*",IBCIVAL:IBCIVAL,1:$P(IB35591,U,10)),IBFORM,IBCARE,IBPRVID)) S IBCUCHK=1
 I DIE="^IBA(355.9,",$D(^IBA(355.9,"AUNIQ",IBPROV,IBINS,$S(IBCIVAL="@":"*N/A*",IBCIVAL:IBCIVAL,1:$P(IB3559,U,16)),IBFORM,IBCARE,IBPRVID)) S IBCUCHK=1
 Q
MESSAGE ;Send message to user if unable to change Care Unit pointer(s).
 N IBC,IBCARE,IBCNT,IBCU,IBDATA,IBFORM,IBGROUP,IBGRP,IBINS,IBMSG,IBNAME
 N IBNCNT,IBNETNM,IBNME,IBNMSPC,IBNUM,IBPARAM,IBPRV,IBPRVID,IBTST,IBTXT
 N XMDUZ,XMERR,XMSUB,XMTEXT,XMY
 S XMSUB="PROVIDER ID CARE UNIT POINTERS INVALID"
 I DUZ="" N DUZ S DUZ=.5 ; if user not defined set to postmaster
 S XMDUZ=DUZ,XMTEXT="IBTXT"
 S IBPARAM("FROM")="PATCH IB*2.0*279 PRE-INIT"
 S IBGROUP="IB EDI SUPERVISOR"
 S IBGRP=$O(^XMB(3.8,"B",IBGROUP,"")) I IBGRP D  ; billing group defined
 . I +$P($G(^XMB(3.8,IBGRP,1,0)),U,4)'>0 Q  ; no members defined
 . S XMY("G."_IBGROUP)="" ; send message to the group.
 S XMY(DUZ)="" ; send message to user
 S IBTST=".TEST.MIR.TST.MIRROR.TRAIN."     ; various test names
 S IBNETNM=$G(^XMB("NETNAME"))
 I IBNETNM'="",('$F(IBTST,"."_$P(IBNETNM,".",1)_".")) S XMY("PHELPS,TY@FORUM.VA.GOV")=""
 S IBC=0
 S IBC=IBC+1,IBTXT(IBC)="This message has been sent by patch IB*2.0*279 at the completion of"
 S IBC=IBC+1,IBTXT(IBC)="the pre-init routine."
 S IBC=IBC+1,IBTXT(IBC)="  "
 S IBC=IBC+1,IBTXT(IBC)="The Care Unit pointer values could not be corrected automatically for the"
 S IBC=IBC+1,IBTXT(IBC)="following Provider ID entries.  These entries need to be deleted or modified"
 S IBC=IBC+1,IBTXT(IBC)="by choosing INSURANCE CO IDS from the Provider ID Maintenance [IBCE PROVIDER"
 S IBC=IBC+1,IBTXT(IBC)="MAINT] menu option.  If there is only one entry with the combination"
 S IBC=IBC+1,IBTXT(IBC)="selected, then choose Edit an ID Record and accept all the defaults.  The"
 S IBC=IBC+1,IBTXT(IBC)="Care Unit combination pointer will be corrected.  If there are two (2)"
 S IBC=IBC+1,IBTXT(IBC)="identical entries, and you are unable to determine which one needs to be"
 S IBC=IBC+1,IBTXT(IBC)="corrected, then delete both entries and then re-enter the data.  If you are"
 S IBC=IBC+1,IBTXT(IBC)="able to distinguish which entry is the invalid one, then you can either edit"
 S IBC=IBC+1,IBTXT(IBC)="the Care Unit to a new one which does not create a duplicate combination or"
 S IBC=IBC+1,IBTXT(IBC)="you may delete it.  It is important that the invalid entry NOT be left"
 S IBC=IBC+1,IBTXT(IBC)="unchanged on the system."
 S IBC=IBC+1,IBTXT(IBC)="  "
 S IBC=IBC+1,IBTXT(IBC)="INSURANCE CO."
 S IBC=IBC+1,IBTXT(IBC)="   PROVIDER ID TYPE                  CARE"
 S IBC=IBC+1,IBTXT(IBC)="      PROVIDER                 FORM  TYPE       CARE UNIT        ID#"
 S IBC=IBC+1,IBTXT(IBC)="==============================================================================="
 S IBNMSPC="                         "
 S IBCNT=0,IBINS=""
 F  S IBINS=$O(^TMP($J,"IB20P279",IBINS)) Q:IBINS=""  D
 . S IBC=IBC+1,IBTXT(IBC)="  "
 . S IBC=IBC+1,IBTXT(IBC)=IBINS
 . S IBPRV=""
 . F  S IBPRV=$O(^TMP($J,"IB20P279",IBINS,IBPRV)) Q:IBPRV=""  D
 .. S IBC=IBC+1,IBTXT(IBC)="   "_IBPRV
 .. S IBNAME=""
 .. F  S IBNAME=$O(^TMP($J,"IB20P279",IBINS,IBPRV,IBNAME)) Q:IBNAME=""  D
 ... S IBNME=$E(IBNAME_"                         ",1,24)_" "
 ... S IBNCNT=0
 ... S IBNUM=""
 ... F  S IBNUM=$O(^TMP($J,"IB20P279",IBINS,IBPRV,IBNAME,IBNUM)) Q:IBNUM=""  D
 .... S IBDATA=$G(^TMP($J,"IB20P279",IBINS,IBPRV,IBNAME,IBNUM)) I IBDATA="" Q
 .... S IBFORM=$P(IBDATA,U,4),IBFORM=$E($S(IBFORM=1:"UB-92",IBFORM=2:"HCFA",1:"BOTH")_"     ",1,5)_" "
 .... S IBCARE=$P(IBDATA,U,5),IBCARE=$E($S(IBCARE=1:"INPT",IBCARE=2:"OUTPT",1:"INPT/OUTPT")_"          ",1,10)_" "
 .... S IBCU=$P($G(^IBA(355.95,$P($G(^IBA(355.96,$P(IBDATA,U,3),0)),"^",1),0)),"^",1),IBCU=$E(IBCU_"                ",1,16)_" "
 .... S IBPRVID=$E($P(IBDATA,U,7)_"              ",1,14)
 .... S IBC=IBC+1,IBTXT(IBC)="      "_$S(IBNCNT:IBNMSPC,1:IBNME)_IBFORM_IBCARE_IBCU_IBPRVID
 .... S IBCNT=IBCNT+1
 .... I 'IBNCNT S IBNCNT=1
 S IBC=IBC+1,IBTXT(IBC)="  "
 S IBC=IBC+1,IBTXT(IBC)="  "
 S IBC=IBC+1,IBTXT(IBC)="Total records needing to be modified: "_IBCNT_"."
 D SENDMSG^XMXAPI(XMDUZ,XMSUB,XMTEXT,.XMY,.IBPARAM,"","")
 S IBMSG(1)=" "
 S IBMSG(2)="******************************************************************************"
 S IBMSG(3)="** Provider ID Care Unit clean up message "_$S($D(XMERR):"not sent due to error in",1:"sent to the ")
 I $D(XMERR) S IBMSG(4)="** message set up.  Dumping message to screen."
 I '$D(XMERR) S IBMSG(3)=IBMSG(3)_$S(DUZ=.5:"postmaster",1:"user")_$S('$D(XMY("G.IB EDI SUPERVISOR")):".",1:"")
 I '$D(XMERR) S IBMSG(4)=$S($D(XMY("G.IB EDI SUPERVISOR")):"** and the IB EDI SUPERVISOR mail group.",1:"** Please forward message to your billing staff for action.")
 S IBMSG(5)="******************************************************************************"
 D BMES^XPDUTL(.IBMSG)
 I $D(XMERR) D BMES^XPDUTL("  "),BMES^XPDUTL(.IBTXT)
 K ^TMP($J,"IB20P279")
 Q
COMPLETE ; display message that step has completed
 D BMES^XPDUTL("Step complete.")
 Q
END ; display message that pre-init has completed successfully
 D BMES^XPDUTL("Pre-init complete")
 Q
