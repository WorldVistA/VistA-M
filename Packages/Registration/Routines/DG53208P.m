DG53208P ;ALB/JDS - PATCH 208 POST INIT ; 11 NOV 1998
 ;;5.3;Registration;**208**;Aug 13, 1993
 ;
 N DGI S DGI=$$NEWCP^XPDUTL("DGASIH","POST^DG53208P","")
 Q
POST N A,B,DA,XPDIDTOT,ASIHTYP,DATE,DIK,PAT,DGI,DR,Y,DIE,DGEGL,DGRCDT
 S DGEGL=+$G(^DG(43,1,"GL"))
 S ASIHTYP=42,DGI=$$PARCP^XPDUTL("DGASIH"),XPDIDTOT=+$P($G(^DGPM(0)),U,4) S:DGI'>0 DGI=0 S DGRCDT=+$P(DGI,U,2),DGI=+DGI
 D MES^XPDUTL("Checking for WHILE ASIH discharges incorrectly linked to an Admission")
 F  S DGI=$O(^DGPM(DGI)) Q:DGI'>0  S:('(DGI#100)) B=$$UPCP^XPDUTL("DGASIH",DGI_U_DGRCDT) D:('(DGI#100)) UPDATE^XPDID(DGI) I $P($G(^DGPM(DGI,0)),U,18)=ASIHTYP D
 .S A=$G(^DGPM(DGI,0)) I $P($G(^DGPM(+$P(A,U,14),0)),U,17)=DGI Q
 .S Y=+A D OLDEST(Y) X ^DD("DD") S DATE=Y S PAT=$P($G(^DPT(+$P(A,U,3),0)),U)
 .N DGADM,DGDIS S DGADM=+$P($G(^DGPM(DGI,0)),U,14),DGDIS=+$P($G(^DGPM(+DGADM,0)),U,17)
 .D MES^XPDUTL("Deleting Patient Movement number "_DGI_" "_DATE_" "_PAT)
 .S DIK="^DGPM(",DA=DGI D ^DIK I $G(DGDIS) S DIE="^DGPM(",DR=".17////"_DGDIS,DA=DGADM D ^DIE
 S Y=$P(DGRCDT,".") X ^DD("DD") D MES^XPDUTL($S(DGRCDT:"G&L should be recalculated back to "_Y,1:"G&L does not need to be recalculated")) H 5
 Q
OLDEST(Y) ;get earliest date to recalculate
 I Y<DGEGL Q
 I Y<2981001 Q
 I 'DGRCDT!(Y<DGRCDT) S DGRCDT=Y
