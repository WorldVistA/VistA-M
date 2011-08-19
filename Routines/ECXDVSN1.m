ECXDVSN1 ;ALB/JAP - Division selection utility (cont.) ; 3/30/07 7:56am
 ;;3.0;DSS EXTRACTS;**8,105**;Dec 22, 1997;Build 70
 ;
ECQ(ECXDIV,ECXALL,ECXERR) ;setup division/site information for QSR extract audit report
 ;   input
 ;   ECXDIV = passed by reference array variable (required)
 ;   ECXALL = 0/1 (optional)
 ;            '0' indicates user to select QUASAR site/division;
 ;            '1' indicates 'all' sites/divisions or only one site/division
 ;                exists in file #509850.8; currently only one site is allowed
 ;                to be defined;
 ;            default is '1'
 ;   output
 ;   ECXDIV = data for QUASAR site/division;
 ;            ECXDIV(ien in file #4)=ien in file #509850.8^name^station number
 ;   ECXERR = 0/1
 ;            if input problem, then '1' returned
 ;
 N X,Y,DIC,OUT,ECX,ECXD,ECXIEN
 S:'$D(ECXALL) ECXALL=1 S:ECXALL="" ECXALL=1
 ;currently, only ONE site may be defined in file #509850.8
 S:ECXALL=0 ECXALL=1
 S ECXERR=0,ECXD=""
 ;if ecxall=1, then all QUASAR sites/divisions; but there's only one
 I ECXALL=1 D
 .F  S ECXD=$O(^ACK(509850.8,"B",ECXD)) Q:ECXD=""  S ECXIEN=$O(^(ECXD,"")) D
 ..K ECX S DIC="^DIC(4,",DIQ(0)="I",DIQ="ECX",DA=ECXD,DR=".01;99" D EN^DIQ1
 ..I $D(ECX) S ECXDIV(ECXD)=ECXIEN_U_ECX(4,ECXD,.01,"I")_U_ECX(4,ECXD,99,"I")
 ..I '$D(ECX) S ECXERR=1
 I ECXERR=1 K ECXDIV
 I '$D(ECXDIV) S ECXERR=1
 Q
 ;
LAB(ECXACC,ECXALL,ECXERR) ;setup accession area information for LAB extract audit report
 ;   input
 ;   ECXACC = passed by reference array variable (required)
 ;   ECXALL = 0/1 (optional)
 ;            '0' indicates user to select Accession Area(s);
 ;            '1' indicates 'all' Accession Areas are selected
 ;            default is '1'
 ;   output
 ;   ECXACC = data for Accession Area(s);
 ;            ECXACC(ien in file #68)=name^abbreviation
 ;   ECXERR = 0/1
 ;            if input problem, then '1' returned
 ;
 N X,Y,DIC,DIQ,DA,DR,DTOUT,DUOUT,DIRUT,OUT,ECX,ECXA,ECXIEN
 S:'$D(ECXALL) ECXALL=1 S:ECXALL="" ECXALL=1
 S ECXERR=0,ECXA=""
 ;if ecxall=1, then all accession areas are selected
 I ECXALL=1 D
 .;^LRO(68,"B",xxx,ien)=1 indicates a synonym; skip synonyms
 .F  S ECXA=$O(^LRO(68,"B",ECXA)) Q:ECXA=""  S ECXIEN=$O(^(ECXA,"")) D
 ..Q:^LRO(68,"B",ECXA,ECXIEN)=1
 ..K ECX S DIC="^LRO(68,",DR=".01;.09",DIQ="ECX",DA=ECXIEN D EN^DIQ1
 ..Q:'$D(ECX)
 ..;acc. areas with ZZ in name indicates no longer used
 ..Q:$E(ECX(68,ECXIEN,.01),1,2)="ZZ"
 ..S ECXACC(ECXIEN)=ECX(68,ECXIEN,.01)_U_ECX(68,ECXIEN,.09)
 ;if ecxall=0, user selects some/all acc. areas
 ;allow user to choose "ZZ"'d acc. area even though it may currently be inactive
 I ECXALL=0 S OUT=0 D
 .F  Q:OUT!ECXERR  D
 ..S DIC="^LRO(68,",DIC(0)="AEMQZ" K X,Y D ^DIC
 ..I $G(DUOUT)!($G(DTOUT)) S OUT=1,ECXERR=1 Q
 ..I Y=-1,X="" S OUT=1 Q
 ..S ECXACC(+Y)=$P(Y(0),U,1)_U_$P(Y(0),U,11)
 I ECXERR=1 K ECXACC
 I '$D(ECXACC) S ECXERR=1
 Q
 ;
NUR(ECXDIV,ECXALL,ECXERR) ;setup accession area information for LAB extract audit report
 ;   input
 ;   ECXDIV = passed by reference array variable (required)
 ;   ECXALL = 0/1 (optional)
 ;            '0' indicates user to select nursing location(s)/division(s);
 ;            '1' indicates 'all' nursing locations and medical center divisions 
 ;                are selected or facility is non-divisional;
 ;            default is '1'
 ;   output
 ;   ECXDIV = data for nursing location(s) and medical center division(s);
 ;            ECXDIV("D",ien in file #40.8)=ien in file #4^name^station number
 ;            ECXDIV(ien in file #211.4,ien in file #40.8)=ien in file #44
 ;   ECXERR = 0/1
 ;            if input problem, then '1' returned
 ;
 ;N X,Y,DIC,DIQ,DA,OUT,ECX,ECXLOC,ECXSC,ECXDIEN,ECXNLIEN,ECXNLNM,ECXPRIME
 S:'$D(ECXALL) ECXALL=1 S:ECXALL="" ECXALL=1
 S (ECXERR,OUT)=0,ECXSC=""
 ;get ien in file #40.8 of primary division
 S ECXPRIME=$$PRIM^VASITE(DT)
 ;associate nursing locations with medical center divisions
 F  S ECXSC=$O(^NURSF(211.4,"B",ECXSC)) Q:ECXSC=""  S ECXNLIEN="" F  S ECXNLIEN=$O(^NURSF(211.4,"B",ECXSC,ECXNLIEN)) Q:ECXNLIEN=""  D
 .K ECX
 .S ECXDIEN=0,ECXNLNM="",DIC="^SC(",DIQ(0)="I",DIQ="ECX",DA=ECXSC,DR=".01;3.5" D EN^DIQ1
 .;if the 15th piece is null or y=-1 then ecxdien=primary division as default
 .I $D(ECX) S ECXDIEN=+ECX(44,ECXSC,3.5,"I"),ECXNLNM=ECX(44,ECXSC,.01,"I")
 .S:ECXDIEN=0 ECXDIEN=ECXPRIME
 .S ECXLOC(ECXDIEN)="",ECXLOC(ECXDIEN,ECXNLIEN)=ECXSC_U_ECXNLNM
 ;
 ;if ecxall=1 don't prompt; setup all nursing locations and divisions incl. those w/o division
 I ECXALL=1 S ECXDIEN="" D
 .F  S ECXDIEN=$O(ECXLOC(ECXDIEN)) Q:ECXDIEN=""  D
 ..S DIC="^DG(40.8,",DIC(0)="NXZ",X=ECXDIEN D ^DIC I +Y>0 D
 ...S ECXDIV("D",ECXDIEN)=$P(Y(0),U,7)_U_$P(Y(0),U,1)_U_$P(Y(0),U,2),ECXNLIEN=""
 ...F  S ECXNLIEN=$O(ECXLOC(ECXDIEN,ECXNLIEN)) Q:ECXNLIEN=""  S ECXDIV(ECXNLIEN,ECXDIEN)=ECXLOC(ECXDIEN,ECXNLIEN)
 ;
 ;if ecxall=0 let user select division(s)
 I ECXALL=0 F  Q:OUT!ECXERR  D
 .S DIC="^DG(40.8,",DIC(0)="AEMQZ",DIC("S")="I $P(^(0),U,3)'=1"
 .D ^DIC I $G(DUOUT)!($G(DTOUT)) S OUT=1,ECXERR=1 Q
 .I Y=-1,X="" S OUT=1 Q
 .S ECXDIEN=+Y,NM=$P(Y,U,2)
 .I '$D(ECXLOC(ECXDIEN)) D  Q
 ..W !!,?5,"Division "_NM_" not associated with Nursing Locations.",!,?5,"Try again...",!
 .S ECXDIV("D",ECXDIEN)=$P(Y(0),U,7)_U_$P(Y(0),U,1)_U_$P(Y(0),U,2),ECXNLIEN=""
 .F  S ECXNLIEN=$O(ECXLOC(ECXDIEN,ECXNLIEN)) Q:ECXNLIEN=""  S ECXDIV(ECXNLIEN,ECXDIEN)=ECXLOC(ECXDIEN,ECXNLIEN)
 ;in case of user up-arrow out or timeout, make sure nothing returned in ecxdiv
 I ECXERR=1 K ECXDIV
 I '$D(ECXDIV) S ECXERR=1
 Q
 ;
PRE(ECXDIV,ECXALL,ECXERR) ;setup site information for PRE extract audit report
 ;   input
 ;   ECXDIV = passed by reference array variable (required)
 ;   ECXALL = 0/1 (optional)
 ;            '0' indicates user to select Pharmacy site(s);
 ;            '1' indicates 'all' sites are selected
 ;            default is '1'
 ;   output
 ;   ECXDIV = data for Pharmacy site(s);
 ;            ECXDIV(ien in file #59)=IEN in file #59^name^site number^IEN in file #4
 ;   ECXERR = 0/1
 ;            if input problem, then '1' returned
 ;
 N X,Y,DIC,DIQ,DA,OUT,ECXARR,ECXP,ECXIEN,ARRAY
 S:'$D(ECXALL) ECXALL=1 S:ECXALL="" ECXALL=1
 S ECXERR=0,ECXP="",ARRAY="^TMP($J,""ECXDSS"")"
 K @ARRAY
 ;if ecxall=1, then all pharmacy sites are selected or there's only one
 I ECXALL=1 S ECXP="" D
 .D PSS^PSO59(,"??","ECXDSS")
 .F  S ECXP=$O(@ARRAY@("B",ECXP)) Q:ECXP=""  S ECXIEN=$O(^(ECXP,0)) Q:'ECXIEN  Q:'$D(^(ECXIEN))  D
 ..S ECXDIV(ECXIEN)=ECXIEN_U_@ARRAY@(ECXIEN,.01)_U_^(.06)_U_^(100)
 ;if ecxall=0, then user selects pharmacy site(s)
 I ECXALL=0 S OUT=0 D
 .F  Q:OUT!ECXERR  D
 ..N DIC,X,Y,DUOUT,DTOUT
 ..S DIC="^PS(59,",DIC(0)="AEMQZ"
 ..D DIC^PSODI(59,.DIC,.X)
 ..I $G(DUOUT)!($G(DTOUT)) S OUT=1,ECXERR=1 Q
 ..I Y=-1,X="" S OUT=1 Q
 ..D PSS^PSO59(+Y,,"ECXDSS")
 ..Q:'$D(@ARRAY)
 ..S ECXDIV(ECXIEN)=ECXIEN_U_@ARRAY@(ECXIEN,.01)_U_^(.06)_U_^(100)
 ;
 I ECXERR=1 K ECXDIV
 I '$D(ECXDIV) S ECXERR=1
 Q
