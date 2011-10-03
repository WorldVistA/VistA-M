DGPTDD ;ALB/LD - DD calls for Suffix fields of PTF file; 27 May 1995
 ;;5.3;Registration;**58**;Aug 13, 1993
 ;
 ; DD calls for the Suffix and Transferring Suffix fields of PTF
 ; file (#45).
 ;
ACTIVE(X,Y,DGADM) ; Suffix active during patient's admission date?
 ;
 ;         DGEFDT  -- Suffix Effective Date
 ;         DGEFIEN -- Suffix Effective Date IEN
 ;        DGSUFPTR -- Suffix pointer from Station Type file
 ;
 ;  INPUT:     X   --  Suffix
 ;             Y   --  Station Type Number
 ;         DGADM   --  PTF IEN (use to get 2nd piece which is
 ;                              admission date or use DT if null)
 ; OUTPUT: DGACT   --  Active during admission date? (1=YES,0=NO)
 ;
 N DGACT,DGEFDT,DGEFIEN,DGFL,DGSUFPTR,DGI
 S (DGACT,DGEFIEN,DGEFDT,DGFL,DGSUFPTR)=0
 F DGI=0:0 S DGI=$O(^DIC(45.81,+$G(Y),"S","B",DGI)) Q:'DGI!$G(DGFL)  D
 .I $P($G(^DIC(45.68,DGI,0)),U)=$G(X) S DGSUFPTR=DGI,DGFL=1
 I $D(^DGPT(+$G(DGADM),0)) S DGADM=+$P(^(0),U,2)
 S DGADM=$S(+$G(DGADM)>0:-DGADM,1:-DT) S:$P(DGADM,".",2) DGADM=$P(DGADM,".") S DGADM=DGADM_.2359
 S DGEFDT=+$O(^DIC(45.68,DGSUFPTR,"E","AEFF",DGADM))
 I -(DGEFDT)'>0 S DGEFDT=+$O(^DIC(45.68,DGSUFPTR,"E","B",DGEFDT)),DGEFDT=-DGEFDT
 S DGEFIEN=$O(^DIC(45.68,DGSUFPTR,"E","AEFF",DGEFDT,DGEFIEN))
 S DGACT=$P($G(^DIC(45.68,+DGSUFPTR,"E",+DGEFIEN,0)),U,2)
 Q +$G(DGACT)
 ;
ACTLST(DGADM) ;    List of active suffixes
 ;
 ;          DGEFFDT -- Suffix Effective Date
 ;         DGEFFIEN -- Suffix Effective Date IEN
 ;
 ;  INPUT:     DGADM  --  PTF IEN (use to get 2nd piece which is
 ;                                 admission date or use DT if null)
 ; OUTPUT:     List of active suffixes during admission date
 ;
 N DGCTR,DGEFFDT,DGEFFIEN,DGI,DGOUT,DGST,DGX,DGY
 S (DGEFFDT,DGOUT)=0,DGCTR=1
 I $D(^DGPT(+$G(DGADM),0)) S DGADM=+$P(^(0),U,2)
 S DGADM=$S(+$G(DGADM)>0:-DGADM,1:-DT) S:$P(DGADM,".",2) DGADM=$P(DGADM,".")
 F DGST=0:0 S DGST=$O(^DIC(45.81,"B",DGST)) Q:'DGST  D
 .F DGI=0:0 S DGI=$O(^DIC(45.81,DGST,"S","B",DGI)) Q:'DGI  D
 ..S DGEFFDT=+$O(^DIC(45.68,DGI,"E","AEFF",DGADM))
 ..I -(DGEFFDT)'>0 S DGEFFDT=$O(^DIC(45.68,DGI,"E","B",DGEFFDT)),DGEFFDT=-DGEFFDT
 ..S DGEFFIEN=0,DGEFFIEN=$O(^DIC(45.68,DGI,"E","AEFF",DGEFFDT,DGEFFIEN))
 ..S:$P($G(^DIC(45.68,DGI,"E",+DGEFFIEN,0)),U,2)=1 ^TMP("ACTSUFF",$J,DGCTR)=$P($G(^DIC(45.68,DGI,0)),U)_U_$P($G(^DIC(45.81,DGST,0)),U,2),DGCTR=DGCTR+1
 W @IOF,"Choose From:",!
 F DGX=0:0 S DGX=$O(^TMP("ACTSUFF",$J,DGX)) Q:'DGX!($G(DGOUT))  D
 .I $Y>(IOSL-5) D NEXTSCR
 .W:'$G(DGOUT) !,$P($G(^TMP("ACTSUFF",$J,DGX)),U),?15,$P($G(^TMP("ACTSUFF",$J,DGX)),U,2)
 K ^TMP("ACTSUFF")
 Q
NEXTSCR ;
 F DGY=$Y:1:(IOSL-4) W !
 S DIR(0)="E" D ^DIR K DIR I $D(DIRUT)!($D(DUOUT)) S DGOUT=1 K DIRUT,DTOUT,DUOUT G NEXTSCRQ
 W @IOF,"Choose From:",!
NEXTSCRQ ;
 Q
