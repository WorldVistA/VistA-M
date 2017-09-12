IBYZ20R ;ALB/CPM - FIX CT ENTRIES FOR PATCH IB*2*62 ; 13-JUN-96
 ;;Version 2.0 ; INTEGRATED BILLING ;**62**; 21-MAR-94
 ;
 D ID ; update the Procedures (#399.0304) identifier
 D CT ; remove scheduled admission pointers in Claims Tracking
 Q
 ;
 ;
CT ; Remove Scheduled Admission pointer from Claims Tracking entries.
 S X(1)=">>> Examining all CT entries with a Scheduled Admission pointer..."
 S X(2)=" " D BMES^XPDUTL(.X)
 ;
 S (IBDELS,IBSCHA)=0 K ^TMP($J,"IBT")
 S IBSCH=0 F  S IBSCH=$O(^IBT(356,"ASCH",IBSCH)) Q:'IBSCH  D
 .S IBTRN=0 F  S IBTRN=$O(^IBT(356,"ASCH",IBSCH,IBTRN)) Q:'IBTRN  D
 ..;
 ..; - if there is no CT entry, kill x-ref and quit
 ..S IBTRND=$G(^IBT(356,IBTRN,0))
 ..I IBTRND="" K ^IBT(356,"ASCH",IBSCH,IBTRN) Q
 ..;
 ..; - if the CT entry is inactive, delete the SA ptr and quit
 ..I '$P(IBTRND,"^",20) D INAC Q
 ..;
 ..; - get the CT admission ptr, event date, DFN
 ..S IBADM=$P(IBTRND,"^",5),IBCTED=$P(IBTRND,"^",6),DFN=$P(IBTRND,"^",2)
 ..;
 ..; - if there's no adm ptr, check to see if the CT entry should
 ..;   be inactivated (with the SA ptr deleted).  Otherwise, it's
 ..;   a valid SA CT entry, just waiting for the vet to be admitted.
 ..I 'IBADM D  Q
 ...S IBSCHD=$G(^DGS(41.1,IBSCH,0))
 ...;
 ...; - got a dangling ptr
 ...I IBSCHD="" D INAC Q
 ...;
 ...; - SA is cancelled or already admitted
 ...I $P(IBSCHD,"^",13)!$P(IBSCHD,"^",17) D INAC Q
 ...;
 ...; - the SA patient is not the same as the CT patient
 ...I +IBSCHD'=DFN D INAC Q
 ...;
 ...; - the SA day is not the same as the CT Event day
 ...I $P($P(IBSCHD,"^",2),".")'=$P(IBCTED,".") D INAC Q
 ...;
 ...; - valid SA CT entry
 ...S IBSCHA=IBSCHA+1
 ...Q
 ..;
 ..; - CT entry has an adm ptr; the SA ptr will be deleted.
 ..;
 ..; - if the CT has an IR dated 21 days prior to the CT event date,
 ..;   or a HR dated prior to the CT event date, the CT is suspect.
 ..S (IBSTOP,IBTRC)=0 F  S IBTRC=$O(^IBT(356.2,"C",IBTRN,IBTRC)) Q:'IBTRC  S IBDATE=+$G(^IBT(356.2,IBTRC,0))\1 I $$FMDIFF^XLFDT(IBCTED\1,IBDATE)>21 S IBSTOP="1^IR: "_$$DAT1^IBOUTL(IBDATE) Q
 ..;
 ..I 'IBSTOP S IBTRV=0 F  S IBTRV=$O(^IBT(356.1,"C",IBTRN,IBTRV)) Q:'IBTRV  S IBDATE=+$G(^IBT(356.1,IBTRV,0))\1 I $$FMDIFF^XLFDT(IBCTED\1,IBDATE)>0 S IBSTOP="1^HR: "_$$DAT1^IBOUTL(IBDATE) Q
 ..;
 ..I IBSTOP S ^TMP($J,"IBT",IBTRN)=DFN_"^"_$P(IBSTOP,"^",2)
 ..;
 ..; - delete the ptr
 ..S DA=IBTRN,DR=".32///@",DIE="^IBT(356," D ^DIE K DA,DR,DIE
 ..S IBDELS=IBDELS+1
 ;
 ;
 D BMES^XPDUTL("Scheduled Admission pointers were deleted from "_IBDELS_" entries.")
 D BMES^XPDUTL("Found "_IBSCHA_" valid SA CT entries awaiting admission.")
 D LIST
 K ^TMP($J,"IBT"),IBSCHA,IBSCH,IBSCHD,IBTRN,IBDATE,IBTRND,IBSTOP,IBTRC,IBTRV,DFN,IBADM,IBCTED,IBDELS,X,Y
 Q
 ;
 ;
INAC ; Inactivate a CT entry and delete the Sched Adm ptr.
 S DA=IBTRN,DR=".2////0;.32///@",DIE="^IBT(356,"
 D ^DIE K DA,DR,DIE S IBDELS=IBDELS+1
 Q
 ;
LIST ; List CT entries which may have been overlaid.
 N IBTRN,X,Y S X(1)=" "
 I '$D(^TMP($J,"IBT")) D  G LISTQ
 .S X(2)="Didn't find any CT entries which may have been overlaid."
 .D BMES^XPDUTL(.X)
 S X(2)="List of CT entries to be checked:"
 S X(3)="---------------------------------"
 D BMES^XPDUTL(.X) K X
 S IBTRN=0 F  S IBTRN=$O(^TMP($J,"IBT",IBTRN)) Q:'IBTRN  S Y=$G(^(IBTRN)) D
 .S X=$E($E($P($G(^DPT(+Y,0)),"^"),1,25)_" ("_$E($P($G(^(0)),"^",9),6,10)_")"_$J("",35),1,35)
 .S X=X_"CT ien: "_IBTRN_" ("_$$DAT1^IBOUTL(IBCTED)_")    "_$P(Y,"^",2)
 .D MES^XPDUTL(X)
LISTQ Q
 ;
 ;
ID ; Set the identifier for the Procedures (#399.0304) sub-file.
 N X
 S X(1)=">>> Updating the Procedures (#399.0304) identifier..."
 S X(2)=" " D BMES^XPDUTL(.X)
 S ^DD(399.0304,0,"ID","WRITE")="D DISPID^IBCSC4D"
 Q
