IB20P818 ;MNTVBB/JWB - FIX FOR IB*2.0*808 BASE RATE FOR VETERAN; JAN 27, 2025@13:00
 ;;2.0;INTEGRATED BILLING;**818**;21-MAR-94;Build 2
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
PRE ; set up check points for pre/post-init
 N %
 S %=$$NEWCP^XPDUTL("THRESH","THRESH^IB20P818")
 S %=$$NEWCP^XPDUTL("PRIOR","PRIOR^IB20P818")
 Q
 ;
THRESH ; Pension Threshold
 N IBA,IBERRM,IBRN,IBTYPE,IBX,DA,DIK,IBADLDEP
 S IBTYPE="Pension Threshold"
 D BMES^XPDUTL("Filing CY 2025 Pension Threshold rates.")
 S IBX=3241200 ;set IBX so that it will pick up all record on or after the new effective date
 F  S IBX=$O(^IBE(354.3,"B",IBX)) Q:'IBX  D  ; remove any records since 12/01/2022
 . S IBRN=0
 . F  S IBRN=$O(^IBE(354.3,"B",IBX,IBRN)) Q:'IBRN  D
 .. S DIK="^IBE(354.3,",DA=IBRN D ^DIK
 S IBA(354.3,"+1,",.01)=3241201 ; effective date for CY 2025 values
 S IBA(354.3,"+1,",.02)=1 ;     internal value 1 = BASIC PENSION
 S IBA(354.3,"+1,",.03)="16965" ;  base rate for veteran
 S IBA(354.3,"+1,",.04)="22216" ; 1 dependent
 S IBADLDEP="2902" ;  additional dependent amount
 F IBX=.05:.01:.11 S IBA(354.3,"+1,",IBX)=IBA(354.3,"+1,",IBX-.01)+IBADLDEP ;2 thru 8 dependents
 S IBA(354.3,"+1,",.12)=IBADLDEP  ;  additional dependent amount
 D UPDATE^DIE("","IBA","","IBERRM") ; file the new record for CY 2025
 I $D(IBERRM) D
 . D BMES^XPDUTL("Unable to file the new rates.  The error message is as follows:")
 . S IBRN=0
 . F  S IBRN=$O(IBERRM("DIERR",1,"TEXT",IBRN)) Q:IBRN=""  D MES^XPDUTL(IBERRM("DIERR",1,"TEXT",IBRN))
 . D BMES^XPDUTL("Please check the database and then file the new rates manually.")
 . D MMSG
 E  D COMPLETE
 Q
 ;
PRIOR ;This code sets up the variables and calls the routine to print or print-and-update the
 ;exemption status.  XPDQUES variables set in the pre-install are used.
 ;
 Q:'$D(^IBA(354.1,"APRIOR",3231201))  ; quit if the "APRIOR" x-ref is not set for 12/1/22.
 N %,IBACT,IBBMES,IBPR,IBPRDT,X,ZTDTH,ZTDESC,ZTRTN,ZTIO,ZTSK
 S IBACT=$G(XPDQUES("POS1")),IBACT=$S(IBACT="U":3,1:2)
 S ZTIO=$G(XPDQUES("POS2"))
 D NOW^%DTC S ZTDTH=%
 ;
 ; -- check to see if prior year thresholds used
 ;
 S IBPR=$P($G(^IBE(354.3,0)),"^",3) I IBPR="" Q
 S IBPR=$P(^IBE(354.3,IBPR,0),"^")
 S X=$S($E($P(IBPR,"^"),1,3)>296:1,1:2) S IBPRDT=$O(^IBE(354.3,"AIVDT",X,-($P(IBPR,"^")))) ;threshold prior to the one entered
 I IBPRDT<0 S IBPRDT=-IBPRDT ; invert negative number
 ; Queuing job.
 S IBBMES=$S(IBACT=3:"& UPDATE ",1:"") D BMES^XPDUTL(" >>>Queuing the PRINT "_IBBMES_"job to run NOW")
 S IO("Q")="",ZTRTN="DQ^IBARXET",ZTDESC="IB PRIOR YEAR THRESHOLD PRINT"_$S(IBACT=3:" AND UPDATE",1:""),ZTSAVE("IB*")="" D ^%ZTLOAD K IO("Q")
 S IBBMES=$S($D(ZTSK):"This job has been queued for NOW, as task number "_ZTSK_".",1:"This job could not be queued. Please edit the 12/1/22 threshold through the 'Add Income Thresholds' option, which allows you to queue this job.")
 D BMES^XPDUTL(" >>>"_IBBMES)
PRIORQ Q  ; end of prior exemptions section
 ;
MMSG ; MailMan message to report update problem to billing groups, patch installer and patch developer
 N DA,IBC,IBGROUP,IBPARAM,IBTXT,XMDUZ,XMSUB,XMTEXT,XMY
 S XMSUB="Integrated Billing Annual Rate Update Error"
 S XMDUZ=DUZ,XMTEXT="IBTXT"
 S IBPARAM("FROM")="PATCH IB*2.0*818 CY 2025 RATE UPDATE"
 F IBGROUP="IB EDI SUPERVISOR","IB ERROR","MCCR" D
 . I $D(^XMB(3.8,"B",IBGROUP)) S IBGROUP="G."_IBGROUP,XMY(IBGROUP)=""
 S XMY(DUZ)=""
 ;
 S IBC=0
 S IBC=IBC+1,IBTXT(IBC)="This message has been sent by patch IB*2.0*818. If you have received this"
 S IBC=IBC+1,IBTXT(IBC)="message, it indicates that the patch encountered some difficulty in filing"
 S IBC=IBC+1,IBTXT(IBC)="the CY 2025 "_IBTYPE_" rates as outlined in the patch description."
 S IBC=IBC+1,IBTXT(IBC)="Please verify the integrity of files 354.3 - BILLING THRESHOLDS and"
 S IBC=IBC+1,IBTXT(IBC)="then enter the new rates manually."
 S IBC=IBC+1,IBTXT(IBC)="You can consult the IB*2.0*818 patch description for additional information."
 S IBC=IBC+1,IBTXT(IBC)="  "
 S IBC=IBC+1,IBTXT(IBC)="This action only needs to be done by one person.  Please verify with the"
 S IBC=IBC+1,IBTXT(IBC)="appropriate billing supervisor that the update has been accomplished."
 D SENDMSG^XMXAPI(XMDUZ,XMSUB,XMTEXT,.XMY,.IBPARAM,"","")
MMSGQ Q  ; end of Mail Message subroutine
 ;
COMPLETE ; display message that step has completed successfully
 D BMES^XPDUTL("Step complete.")
 Q
 ;
