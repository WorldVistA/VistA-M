SPNALERT ;SAN/WDE/Main Alert Driver
 ;;2.0;Spinal Cord Dysfunction;**11,12,13,15**;01/02/1997
 ; called from the protocal DGPM MOVEMENT
 ; for the time we are only going to check for 
 ; admits.
EN ;
 Q:'$D(DFN)
 Q:'$D(DGPMT)
 ;we only want admits and discharges ignore the rest
 Q:DGPMT=2
 Q:DGPMT>3
 Q:'$D(^SPNL(154,DFN))
 S SPNACT=DGPMT
 ;this is a new parm that will go in 154.91
 S SPNSITE=0,SPNSITE=$O(^SPNL(154.91,SPNSITE)) I SPNSITE="" D ZAP Q
 S SPNSEND=$P($G(^SPNL(154.91,SPNSITE,0)),U,8) I SPNSEND'=1 D CHKOTHER  D ZAP Q
 ;must have a site entered and yes to send alerts
 D 1,CHKOTHER D ZAP
 D ZAP
 Q
 ;------------------------------------------------------
1 ;Check to see if the local station has the notice turned on
 ;if so check for type of patient and build send to group
TEST ;
 ;Check to see if the pt has an etiology of ms
 S SPNTYP="",SPNNU=""
 S SPNNU=0 F  S SPNNU=$O(^SPNL(154,DFN,"E",SPNNU)) Q:(SPNNU="")!('+SPNNU)  D
 .S SPNTYP=$P($G(^SPNL(154,DFN,"E",SPNNU,0)),U,1)
 .S SPNTYP=$G(^SPNL(154.03,SPNTYP,0))
 .I SPNTYP["MULTIPLE SCLEROSIS" S SPNNU=999999 Q
 .Q
 I SPNTYP["MULTIPLE SCLEROSIS" S SPNTO=$P($G(^SPNL(154.91,SPNSITE,0)),U,10)
 I SPNTYP'["MULTIPLE SCLEROSIS" S SPNTO=$P($G(^SPNL(154.91,SPNSITE,0)),U,9)
 I $G(SPNTO)'="" S SPNTO=$P($G(^XMB(3.8,SPNTO,0)),U,1)
 I $G(SPNTO)="" S SPNTO="SPNL SCD COORDINATOR"
 S SPNTO="G."_SPNTO
 S XMY(SPNTO)=""
 Q
 ;---------------------------------------------------------------------
ZAP ;
 K SPNTO,SPNTYP,SPNNU,SPNSITE
 K SPWARD,SPNTXT,SPNINST,SPNDOM,SPNLN
 K SPZ,SPLN,SPNTEXT
 Q
CHKOTHER ;looks at additional care va and sends to that sci coord grp
 ;  Note that its getting the host site from 154.7
 S SPNDOM="" F SPZ=3.2,3.3,3.4 D
 .S SPNINST=$$GET1^DIQ(154,DFN_",",SPZ,"I") Q:SPNINST=""
 .Q:SPNINST=$G(^DD("SITE",1))  ;Checks for same site pt is adm to.
 .S SPNDOM="" S SPNDOM=$P($G(^SPNL(154.7,SPNINST,0)),U,4) Q:SPNDOM=""
 .S XMY("G.SPNL SCD COORDINATOR@"_SPNDOM)=""
 ;-------------------------------------------------------------------
 Q:'$D(XMY)  ;no one to send it to
 ;at this point pt is seen at other va
 S SPNLAS=$E($P($G(^DPT(DFN,0)),U,1),1)_$E($P($G(^DPT(DFN,0)),U,9),6,9)
 S SPNTXT(1)="Patient                 : "_SPNLAS
 I DGPMT=1 S SPWARD=$P($G(DGPMA),U,6) S:SPWARD="" SPWARD="Ward Unknown" I +SPWARD S SPWARD=$S($D(^DIC(42,SPWARD,0)):$P(^DIC(42,SPWARD,0),U,1),1:"Ward Unknown")
 I DGPMT=3 S SPWARD=$P($G(DGPMVI(5)),U,2) S:SPWARD="" SPWARD="Ward Unknown"
 S Y=$P($G(DGPMA),U,1) X ^DD("DD") S SPTIME=Y S:Y="" Y="Missing date"
 S SPNTXT(2)=$S(SPNACT=1:"Date Admitted           : ",1:"Date Discharged         : ")_SPTIME
 S SPNTXT(3)=$S(SPNACT=1:"Admitted to             : ",1:"Discharged From         : ")_SPWARD
 I SPNACT=1 S SPNBD=$P($G(DGPMA),U,7) I +SPNBD S SPNBD=$P($G(^DG(405.4,SPNBD,0)),U,1)
 I SPNACT=1 S SPNTXT(4)="Room-Bed                : "_SPNBD
 S SPNTXT(5)="REGISTRATION STATUS     : "_$$GET1^DIQ(154,DFN_",",.03)
 S SPNTXT(6)="VA SCI STATUS           : "_$$GET1^DIQ(154,DFN_",",2.6)
 S SPNTXT(7)="PRIMARY CARE PROVIDER   : "_$$GET1^DIQ(154,DFN_",",8.1)
 S SPNTXT(8)="SCI LEVEL               : "_$$GET1^DIQ(154,DFN_",",2.1)
 S SPNTXT(9)="Etiology                          Onset        Other"
 S SPNTXT(10)="------------------------------------------------------------------------------"
 D GETS^DIQ(154,DFN_",","4*","","SPNTMP")
 S SPENT=0,SPLN=11 F  S SPENT=$O(SPNTMP(154.004,SPENT)) Q:SPENT=""  D
 .S SPTXT=$G(SPNTMP(154.004,SPENT,.01))_"                              "
 .S SPTXT=$E(SPTXT,1,32)_$G(SPNTMP(154.004,SPENT,.02))_"  "_$G(SPNTMP(154.004,SPENT,.03))
 .S SPLN=SPLN+1 S SPNTXT(SPLN)=SPTXT S SPTXT=""
 S SPLN=SPLN+1 S SPNTXT(SPLN)="-------------------------------------------------------------------------------"
 S SPLN=SPLN+1 S SPNTXT(SPLN)="Recipients of this message:"
 S SPLN=SPLN+1 S SPSENT="" F  S SPSENT=$O(XMY(SPSENT)) Q:SPSENT=""  S SPNTXT(SPLN)=SPSENT S SPLN=SPLN+1
 S XMSUB=$S(SPNACT=1:"Admission",1:"Discharge")_" notice for "_SPNLAS_" from "_$P($G(^DD("SITE")),".",1)
 S XMTEXT="SPNTXT("
 D ^XMD
 K XMTEXT,SPTXT,SPENT,XMA,SPNSENT,SPNSITE,SPNDOM,SPNTO,SPWARD,SPNBD
 K SPNTMP,SPWARD,SPNACT,SPNL,SPSENT,SPNTXT,SPNBD,SPTIME
 K SPNSEND,SPNLAS
