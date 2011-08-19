IBCRHBSZ ;ALB/ARH - RATES: UPLOAD (RC 2+) DIVISION FUNCTIONS ; 10-OCT-03
 ;;2.0;INTEGRATED BILLING;**245**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
SITEDV(DIV) ; return the host file site data on the division passed in
 ; input: site number, output: 0 or 'IFN of site in IBCR RC SITE ^ site number ^ site name ^ 3-digit zip ^ type'
 ;
 N IBY,IBX,IBLN S (IBY,IBX)=0
 I +$G(DIV) S IBY=$O(^XTMP("IBCR RC SITE","C",DIV_" ",0))
 I +IBY S IBLN=$G(^XTMP("IBCR RC SITE",IBY)) I IBLN'="" S IBX=IBY_U_IBLN
 Q IBX
 ;
RGDV(DV) ; return Billing Region data on division passed in
 ; Input: site number, output 0 or 'IFN of region in 363.31 ^ site number ^ site city,st ^ 3-digit zip ^ type'
 N IBRG,IBX,IBY,IBFND S IBFND=0
 I $G(DV)'="" S IBRG="RC "_DV F  S IBRG=$O(^IBE(363.31,"B",IBRG)) Q:$E(IBRG,1,2)'="RC"  D  Q:IBFND
 . I IBRG'[(" "_DV_" ") Q
 . S IBY=$O(^IBE(363.31,"B",IBRG,0)) I 'IBY Q
 . S IBX=$G(^IBE(363.31,+IBY,0))
 . S IBFND=IBY_U_DV_U_$P($P(IBX,U,1)," - ",2)_U_$P(IBX,U,2,3)
 Q IBFND
 ;
MSGDIV(SITE) ; check if division selected is defined as a division (40.8) on the system
 N IBMCDV,IBRG,IBX,IBY,IBFND S (IBMCDV,IBFND)="",SITE=$G(SITE)
 I SITE'="" S IBMCDV=+$O(^DG(40.8,"C",SITE,0))
 I +IBMCDV S IBX=$G(^DG(40.8,+IBMCDV,0)) D
 . W !!,?5,$P(IBX,U,2),?15,$P(IBX,U,1)," is a valid Medical Center division on your system.",!
 . S IBRG="RC" F  S IBRG=$O(^IBE(363.31,"B",IBRG)) Q:$E(IBRG,1,2)'="RC"  D  Q:IBFND
 .. I IBRG[(" "_SITE_" ") S IBFND=1 Q
 .. S IBY=$O(^IBE(363.31,"B",IBRG,0)) I 'IBY Q
 .. I '$O(^IBE(363.31,IBY,11,"B",+IBMCDV,0)) Q
 .. W !!,?5,SITE," is already assigned to Billing Region: ",IBRG,! S IBFND=1
 I 'IBMCDV W !!,?5,"*** ",SITE," is NOT defined as a Medical Center Division on your system ***",!
 Q
 ;
 ;
 ; ***************************************************************************************
 ;
SETRGZIP ; for all existing Billing Regions, set the sites 3-digit zip code into the Identifier field (363.31,.02)
 ; and set the Facility type into the Type field (363.31,.03)
 ; the 3-digit zip was not available with RC v1, so Regions created for RC v1 will not have this field set
 ; the type field was not available until RC v2, so Regions created before RC 2 will not have this field set
 ;
 N DIE,DIC,DA,DR,X,Y,IBRGFN,IBLN,IBZIP,IBSITE,IBTYPE I $$VERSION^IBCRHBRV=1 Q
 ;
 S IBRGFN=0 F  S IBRGFN=$O(^IBE(363.31,IBRGFN)) Q:'IBRGFN  D
 . S IBLN=$G(^IBE(363.31,IBRGFN,0)) Q:$E(IBLN,1,3)'="RC "  I $P(IBLN,U,2)'="",$P(IBLN,U,3)'="" Q
 . ;
 . S IBSITE=$$SITEDV($P(IBLN," ",2))
 . S IBZIP=$P(IBSITE,U,4) Q:IBZIP'?3N
 . S IBTYPE=$P(IBSITE,U,5) Q:IBTYPE=""
 . ;
 . S DR=""
 . I $P(IBLN,U,2)="" S DR=".02////"_IBZIP_";"
 . I $P(IBLN,U,3)="" S DR=DR_".03////"_IBTYPE
 . I DR'="" S DIE="^IBE(363.31,",DA=IBRGFN D ^DIE K DIE,DIC,DA,DR
 Q
 ;
CHKRGZIP ; for all existing Billing Regions, check to ensure each division assigned is actually within that Region
 ; Check the Billing Region zip/type against the Host files zip/type for the site
 ; Also the 3-digit zip of the Regions Divisions must match the 3-digit zip of the Regions primary division
 ; if the 3-digit zips do not match, the Division is deleted from the Region
 ;
 N IBRGFN,IBLN,IBRGSITE,IBRGZIP,IBRGTYPE,IBDVFN,IBDV,IBDVLN,IBDVSITE,IBDVZIP,IBDVTYPE,ARRAY,ARRAY2,DA,DIK,DIC,DIR,X,Y
 ;
 S IBRGFN=0 F  S IBRGFN=$O(^IBE(363.31,IBRGFN)) Q:'IBRGFN  D
 . S IBLN=$G(^IBE(363.31,IBRGFN,0)) Q:$E(IBLN,1,3)'="RC "
 . S IBRGSITE=$$SITEDV($P(IBLN," ",2))
 . S IBRGZIP=$P(IBRGSITE,U,4)
 . S IBRGTYPE=$P(IBRGSITE,U,5)
 . I IBRGZIP'?3N,IBRGTYPE="" Q
 . ;
 . ; check region settings against settings for primary division in host files
 . I $P(IBLN,U,2)'=IBRGZIP S ARRAY2($P(IBLN,U,1))=$P(IBLN,U,2)_U_+$P(IBLN,U,3)_U_IBRGZIP_U_+IBRGTYPE
 . I +IBRGTYPE,$P(IBLN,U,3)'=IBRGTYPE S ARRAY2($P(IBLN,U,1))=$P(IBLN,U,2)_U_+$P(IBLN,U,3)_U_IBRGZIP_U_+IBRGTYPE
 . 
 . ; check regions primary division against the assigned divisions
 . S IBDVFN=0 F  S IBDVFN=$O(^IBE(363.31,IBRGFN,11,IBDVFN)) Q:'IBDVFN  D
 .. S IBDV=+$G(^IBE(363.31,IBRGFN,11,IBDVFN,0)) Q:'IBDV
 .. S IBDVLN=$G(^DG(40.8,+IBDV,0)) Q:IBDVLN=""
 .. S IBDVSITE=$$SITEDV($P(IBDVLN,U,2))
 .. S IBDVZIP=$P(IBDVSITE,U,4)
 .. S IBDVTYPE=$P(IBDVSITE,U,5)
 .. I IBDVZIP'?3N,IBDVTYPE="" Q
 .. ;
 .. I IBRGZIP=IBDVZIP,IBRGTYPE=IBDVTYPE Q
 .. I IBRGTYPE=1,IBDVTYPE<3 Q
 .. S ARRAY(IBRGFN)=IBLN,ARRAY(IBRGFN,IBDV)=$P(IBDVLN,U,1,2)_U_IBDVZIP_U_IBDVTYPE
 .. S DA(1)=IBRGFN,DIK="^IBE(363.31,"_DA(1)_",11,",DA=IBDVFN D ^DIK
 ;
 I $O(ARRAY2(""))'="" D
 . ; check region settings against settings for primary division in host files
 . W @IOF,!,"********************************************************************************"
 . W !,"Error Found: Billing Regions found in Charge Master with Incorrect Zip or Type."
 . W !,"Billing Regions are defined by both the 3-digit zip code and Type of Facility."
 . W !!,"There are Charge Master Billing Regions whose Zip or Type do not match the "
 . W !,"settings of that primary division in the new host files.",!
 . ;
 . W !!,?3,"Billing Region",?32,"CM Zip-Type",?47,"HF Zip-Type",!,?3,"--------------------------------------------------------------------------"
 . S IBRGFN="" F  S IBRGFN=$O(ARRAY2(IBRGFN)) Q:IBRGFN=""  D
 .. S IBLN=ARRAY2(IBRGFN) W !,?3,IBRGFN,?35,$P(IBLN,U,1),"-",$P(IBLN,U,2),?50,$P(IBLN,U,3),"-",$P(IBLN,U,4)
 . ;
 . W !!,"IT IS POSSIBLE THERE ARE PROBLEMS WITH THE CHARGES, PLEASE CONTACT SUPPORT."
 . W !,"********************************************************************************",!
 . S DIR(0)="E" D ^DIR K DIR W @IOF
 ;
 I $O(ARRAY(0)) D
 . ; check regions primary division against the assigned divisions
 . W @IOF,!,"********************************************************************************"
 . W !,"Error Found:  Incorrect Billing Regions found in the Charge Master."
 . W !!,"Billing Regions are defined by the 3-digit zip code identifier and "
 . W !,"Type of Facility of the primary division.  Only Divisions with the "
 . W !,"same 3-digit zip code and type should be assigned to a Billing Region."
 . W !!,"There were Divisions incorrectly associated with Billing Regions in the"
 . W !,"Charge Master.  For the following Billing Regions, the corresponding "
 . W !,"Division has been deleted."
 . W !!,?3,"Billing Region",?43,"Division(s) Deleted",!,?3,"--------------------------------------------------------------------------"
 . ;
 . S IBRGFN=0 F  S IBRGFN=$O(ARRAY(IBRGFN)) Q:'IBRGFN  D
 .. S IBLN=ARRAY(IBRGFN) W !,?3,$E($P(IBLN,U,1),1,23),?26,"(",$P(IBLN,U,2),"-",$P(IBLN,U,3),")"
 .. ;
 .. S IBDV=0 F  S IBDV=$O(ARRAY(IBRGFN,IBDV)) Q:'IBDV  D
 ... S IBLN=ARRAY(IBRGFN,IBDV) W ?43,$P(IBLN,U,2),?50,$E($P(IBLN,U,1),1,20),?72,"(",$P(IBLN,U,3),"-",$P(IBLN,U,4),")",!
 . ;
 . W !,"IT IS LIKELY THE ABOVE DIVISIONS NO LONGER HAVE ANY REASONABLE CHARGES ASSIGNED."
 . W !,"********************************************************************************",!
 . S DIR(0)="E" D ^DIR K DIR W @IOF
 Q
