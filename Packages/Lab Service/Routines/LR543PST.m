LR543PST ;HPS/DSK - LR*5.2*543 PATCH POST INSTALL ROUTINE ;Mar 17, 2021@17:17
 ;;5.2;LAB SERVICE;**543**;Sep 27, 1994;Build 7
 ;
 Q
 ;
 ;ICR #2843 - ^ORD(101.43 Read Access
 ;
EN ;
 ;This routine is not deleted after install since it is tasked. A future
 ;patch will delete the routine.
 ;
 N LRDUZ
 S ZTRTN="START^LR543PST"
 S ZTDESC="LR*5.2*543 Post-Install Routine"
 S ZTIO="",ZTDTH=$H
 S LRDUZ=DUZ
 S ZTSAVE("LRDUZ")=""
 D ^%ZTLOAD
 W !!,"LR*5.2*543 Post-Install Routine has been tasked - TASK NUMBER: ",$G(ZTSK)
 W !!,"You as well as members of the LMI and OR CACS MailMan Groups will receive"
 W !,"a MailMan message when the search completes.",!
 Q
 ;
START ;
 N LRNAME,LROI,LRTST,LRSEQ,LRSPACE,LRNAMX
 K ^XTMP("LR 543 MAILMAN MESSAGE")
 S LRSPACE="                                     "
 S (LRNAME,LROI)="",LRSEQ=11
 F  S LRNAME=$O(^ORD(101.43,"S.LAB",LRNAME)) Q:LRNAME=""  D
 . F  S LROI=$O(^ORD(101.43,"S.LAB",LRNAME,LROI)) Q:LROI=""  D
 . . ;Do not list if name starts with ZZ and inactive date is populated
 . . S LRTST=$P($P($G(^ORD(101.43,LROI,0)),"^",2),";99LRT")
 . . I LRTST]"",'$D(^LAB(60,LRTST,0)) D
 . . . I $E(LRNAME,1,2)="ZZ",$P($G(^ORD(101.43,LROI,.1)),"^")]"" Q
 . . . S LRSEQ=LRSEQ+1
 . . . S LRNAMX=$E(LRNAME,1,30)
 . . . S ^XTMP("LR 543 MAILMAN MESSAGE",LRSEQ)=LRNAMX_" (#"_LROI_")"_$E(LRSPACE,1,37-($L(LRNAMX)+$L(LROI)))_LRTST
 D XTMP,MAIL
 Q
 ;
XTMP ;Generate MailMan message and keep in ^XTMP for 60 days
 S ^XTMP("LR 543 MAILMAN MESSAGE",0)=$$FMADD^XLFDT(DT,60)_"^"_DT_"^LR*5.2*543 POST INSTALL"
 S ^XTMP("LR 543 MAILMAN MESSAGE",1)=" "
 S ^XTMP("LR 543 MAILMAN MESSAGE",2)="LR*5.2*543 post-install routine found "_$S(LRSEQ=11:"no",1:(LRSEQ-11))_" entries in the ORDERABLE ITEMS"
 S ^XTMP("LR 543 MAILMAN MESSAGE",3)="(#101.43) file of concern that reference non-existent Laboratory tests."
 I LRSEQ>11 D
 . S ^XTMP("LR 543 MAILMAN MESSAGE",4)="Listed below are such entries which have a name not prefixed with ""ZZ"""
 . S ^XTMP("LR 543 MAILMAN MESSAGE",5)="and/or no date in the INACTIVATED (#.1) field."
 . S ^XTMP("LR 543 MAILMAN MESSAGE",6)=" "
 . S ^XTMP("LR 543 MAILMAN MESSAGE",7)="The following should be edited in the ORDERABLE ITEMS (#101.43) file so the"
 . S ^XTMP("LR 543 MAILMAN MESSAGE",8)="name is prefixed with ""ZZ"" and a date entered in the INACTIVATED (#.1) field."
 . S ^XTMP("LR 543 MAILMAN MESSAGE",9)=" "
 . S ^XTMP("LR 543 MAILMAN MESSAGE",10)="Orderable Item/IEN                       Non-Existent Laboratory Test IEN"
 . S ^XTMP("LR 543 MAILMAN MESSAGE",11)="--------------------------               --------------------------------"
 Q
 ;
MAIL ;
 N LRMIN,LRMY,LRMSUB,LRMTEXT
 S LRMIN("FROM")="LR*5.2*543 Post-Install"
 S LRMY(LRDUZ)=""
 S LRMY("G.LMI")=""
 S LRMY("G.OR CACS")=""
 S LRMSUB="LR*5.2*543 Post-Install"
 S LRMTEXT="^XTMP(""LR 543 MAILMAN MESSAGE"")"
 D SENDMSG^XMXAPI(DUZ,LRMSUB,LRMTEXT,.LRMY,.LRMIN,"","")
 Q
