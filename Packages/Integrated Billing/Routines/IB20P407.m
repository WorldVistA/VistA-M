IB20P407 ;ALB/CXW - IB*2.0*407 POST INIT ;10-SEP-08
 ;;2.0;INTEGRATED BILLING;**407**;21-MAR-94;Build 29
 ;;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;This routine is to follow the logic design:
 ;;Queue a task to run in the background.
 ;;Filing message:
 ; - Loop through the entries in file #364.2 by checking the Date
 ;   Recorded field (#.03) within one-year time frame.
 ; - Process the associated message based on the Message Type field
 ;   (#.02) pointing to file #364.3 and file them properly where they
 ;   need to be.
 ;;Deleting message:
 ; - Loop through all types of entries older than one year in file
 ;   #364.2 by checking the Date Recorded field and the Message Type.
 ; - Delete the message in file #364.2 when the Current Status field
 ;   (#8) pointing to file (#430.3) is 108 for Collected/Closed or 210
 ;   for Cancel Bill or 111 for Cancellation for the associated bill
 ;   in the AR file #430.
 ;;Send two bulletin messages to list the filing messages with the
 ;   bills and the deleting messages with the bills when the background
 ;   job has been completed.
 ;
 ;;Output:
 ; - ^XTMP(IB407,0)=purge date_U_today's date_U_patch #_U_total "F" msg_
 ;                  U_total "D" msg_U_date prior to a year_U_oldest date
 ;                  _U_task number
 ; - ^XTMP(IB407,"F",IEN)=message id_U_type_U_recorded dt_U_message dt_
 ;                        U_batch #_U_bill #_U_status
 ; - ^XTMP(IB407,"D",IEN)=messaage id_U_type_U_recorded dt_U_message dt_
 ;                        U_batch #_U_bill #_U_status
 ;Not delete XTMP file until 30 days from now
 ;
START ;
 D BMES^XPDUTL("Tasking the cleanup of the return messages for file 364.2 in a background job.")
 D BMES^XPDUTL("Two Mailman messages will be sent to list the filing messages and the deleting")
 D BMES^XPDUTL("messages when the task has been completed.")
 N ZTSK,ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSAVE
 S ZTRTN="JOB^IB20P407",ZTDESC="IB*2.0*407 post-init process"
 S ZTSAVE("*")="",ZTDTH=$H,ZTIO="" D ^%ZTLOAD
 Q
JOB ;
 N %H,U,X,X1,X2,IB0,IBCT,IBBDA,IBRTN,IBMDT,IBTDA,IBEOB,IBTYP,IB407,IBTDT,IBBIL
 S U="^" S IB407="IB20P407"
 K ^XTMP(IB407)
 S DT=$$DT^XLFDT,X1=DT,X2=30 D C^%DTC
 S ^XTMP(IB407,0)=X_U_DT_U_"IB*2.0*407 POST-INIT"
 ;
FILE S IBCT=0,IBEOB=+$O(^IBE(364.3,"B","835EOB",0))
 S X=DT D H^%DTC S %H=%H-365 D YMD^%DTC
 S $P(^XTMP(IB407,0),U,6)=X,IBTDT=X
 S IBMDT=IBTDT-1 ;prior to one year
 S $P(^XTMP(IB407,0),U,7)=$O(^IBA(364.2,"ARD","")) ;oldest date
 F  S IBMDT=$O(^IBA(364.2,"ARD",IBMDT)) Q:IBMDT=""  S IBTDA=0 F  S IBTDA=$O(^IBA(364.2,"ARD",IBMDT,IBTDA)) Q:'IBTDA  D
 . ;
 . S IB0=$G(^IBA(364.2,IBTDA,0))
 . S IBBIL=$$BILLNO^IBCEM1($P(IB0,U,5))
 . Q:$$CK(IBEOB,IBTDA)
 . S X=$P($G(^IBE(364.3,+$P(IB0,U,2),0)),U,6) S:X="EOB" X="MRA"
 . S IBBDA=$P(IB0,U,4)  ;batch #
 . S IBRTN=$P($G(^IBE(364.3,+$P(IB0,U,2),0)),U)
 . S IBTYP=$S(IBRTN["837":$E(IBRTN,$L(IBRTN)),1:2)
 . ;
 . ; IBRTN=routine to execute, IBBDA=batch #
 . ; IBTDA=internal entry of msg, IBTYP=last digit in the msg type
 . I IBRTN["REPORT" D MAILIT^IBCESRV2
 . I IBRTN["837REC" D CON837^IBCESRV2
 . I IBRTN["837REJ" D REJ837^IBCESRV2
 . I IBRTN["835EOB" D EOB835^IBCESRV3
 . ;
 . N DA,DR,DIE
 . I $G(ZTSK),$G(^IBA(364.2,IBTDA,0)) S DIE="^IBA(364.2,",DR=".11////"_ZTSK_";.06////U",DA=IBTDA D ^DIE
 . I '$D(^IBA(364.2,IBTDA)) D
 .. S ^XTMP(IB407,"F",IBTDA)=$P(IB0,U)_U_$S($P($G(^IBE(364.3,+$P(IB0,U,2),0)),U,6)="EOB":"MRA",1:$P($G(^IBE(364.3,+$P(IB0,U,2),0)),U,6))_U_$$FMTE^XLFDT(IBMDT,2)
 .. S $P(^XTMP(IB407,"F",IBTDA),U,4)=$$FMTE^XLFDT($P(IB0,U,10),2)_U_$P($G(^IBA(364.1,+$P(IB0,U,4),0)),U)_U_IBBIL_U_$$EXPAND^IBTRE(364.2,.06,$P(IB0,U,6))
 .. S IBCT=IBCT+1
 S $P(^XTMP(IB407,0),U,4)=IBCT
 D SNDMAIL("F")
DEL ;
 N SITE,ARIEN,ARST
 S SITE=$P($$SITE^VASITE,U,3)
 S IBCT=0,IBMDT=""
 F  S IBMDT=$O(^IBA(364.2,"ARD",IBMDT)) Q:((IBMDT\1)>(IBTDT-1))!(IBMDT="")  S IBTDA=0 F  S IBTDA=$O(^IBA(364.2,"ARD",IBMDT,IBTDA)) Q:'IBTDA  D
 . S IB0=$G(^IBA(364.2,IBTDA,0))
 . S IBBIL=$$BILLNO^IBCEM1($P(IB0,U,5))
 . Q:$$CK(IBEOB,IBTDA)
 . S ARIEN=$O(^PRCA(430,"B",SITE_"-"_IBBIL,0))
 . Q:ARIEN=""
 . S ARST=$P(^PRCA(430.3,+$P($G(^PRCA(430,+ARIEN,0)),U,8),0),U,3)
 . Q:(ARST'=108)&(ARST'=210)&(ARST'=111)
 . D DELMSG^IBCESRV2(IBTDA)
 . S ^XTMP(IB407,"D",IBTDA)=$P(IB0,U)_U_$S($P($G(^IBE(364.3,+$P(IB0,U,2),0)),U,6)="EOB":"MRA",1:$P($G(^IBE(364.3,+$P(IB0,U,2),0)),U,6))_U_$$FMTE^XLFDT(IBMDT,2)
 . S $P(^XTMP(IB407,"D",IBTDA),U,4)=$$FMTE^XLFDT($P(IB0,U,10),2)_U_$P($G(^IBA(364.1,+$P(IB0,U,4),0)),U)_U_IBBIL_U_$$EXPAND^IBTRE(364.2,.06,$P(IB0,U,6))
 . S IBCT=IBCT+1
 S $P(^XTMP(IB407,0),U,5)=IBCT
 S:$G(ZTSK) $P(^XTMP(IB407,0),U,8)=ZTSK
 D SNDMAIL("D")
 Q
CK(IBEOB,IBTDA) ;
 N IB1,IBSTOP,IBMSGT
 S IB1=$G(^IBA(364.2,IBTDA,0))
 S IBSTOP=0,IBMSGT=$P(IB1,U,2)
 I IBMSGT,IBEOB,IBMSGT=IBEOB D
 . N Z,Z0 ; Only allow MRA EOB's to be processed
 . S Z=0 F  S Z=$O(^IBA(364.2,IBTDA,2,Z)) Q:'Z!(IBSTOP)  S Z0=$G(^(Z,0)) I $E(Z0,1,12)="##RAW DATA: ",$E(Z0,13,18)="835EOB",$P(Z0,U,5)'="Y" S IBSTOP=1
 I $P(IB1,U,6)=""!("UP"'[$P(IB1,U,6)) S IBSTOP=1 ;message status
 Q IBSTOP
 ;
SNDMAIL(FD) ;                              
 N DIFROM,IBTXT,XMSUB,XMDUZ,XMTEXT,XMY,IBTDT
 S XMSUB="IB*2.0*407 Post-Init Completed "_$S(FD="F":"(1)",1:"(2)")
 S XMDUZ="INTEGRATED BILLING PACKAGE"
 S XMTEXT="IBTXT("
 S IB0=$G(^XTMP(IB407,0))
 S IBMDT=$S('$P(IB0,U,7):"",FD="F":$P(IB0,U,6),1:$P(IB0,U,7))
 S IBTDT=$S(FD="F":DT,1:$P(IB0,U,6)-1)
 S IBTXT(1)=$S(FD="F":"Filing",1:"Deleting")_" Return Messages recorded "
 I IBMDT S IBTXT(1)=IBTXT(1)_"from "_$E(IBMDT,4,7)_(1700+$E(IBMDT,1,3))_" to "_$E(IBTDT,4,7)_(1700+$E(IBTDT,1,3))
 I 'IBMDT S IBTXT(1)=IBTXT(1)_"- No Begining Date Found"
 S IBTXT(2)=$S(FD="F":"",1:"** The associated bill has been Collected/Closed or Cancelled in AR **")
 S IBTXT(3)=""
 S IBTXT(4)="Message #  Type    Date Recorded   Message Date    Batch #   Bill #    Status"
 S IBTXT(5)="========== ======  ==============  ==============  ========  ========  ========"
 S IBTDA=0,IBCT=6
 F  S IBTDA=$O(^XTMP(IB407,FD,IBTDA)) Q:'IBTDA  D
 . S IBMSGT=$G(^XTMP(IB407,FD,IBTDA))
 . S IBTXT(IBCT)=$P(IBMSGT,U)_$J("",11-$L($P(IBMSGT,U)))_$P(IBMSGT,U,2)_$J("",8-$L($P(IBMSGT,U,2)))_$P(IBMSGT,U,3)_$J("",16-$L($P(IBMSGT,U,3)))
 . S IBTXT(IBCT)=IBTXT(IBCT)_$P(IBMSGT,U,4)_$J("",16-$L($P(IBMSGT,U,4)))_$P(IBMSGT,U,5)_$J("",10-$L($P(IBMSGT,U,5)))_$P(IBMSGT,U,6)_$J("",10-$L($P(IBMSGT,U,6)))_$P(IBMSGT,U,7)
 . S IBCT=IBCT+1
 S IBTXT(IBCT)="Total EDI Messages:"_$S(FD="F":$P(^XTMP(IB407,0),U,4),1:$P(^XTMP(IB407,0),U,5))
 S XMY(DUZ)=""
 D ^XMD
 Q
