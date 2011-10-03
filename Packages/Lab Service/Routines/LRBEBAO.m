LRBEBAO ;DALOI/JAH/FHS - ORDERING AND RESULTING FOR OUTPATIENTS ;8/10/04
 ;;5.2;LAB SERVICE;**291,359,352**;Sep 27, 1994;Build 1
 ;
 ; This routine contains the subroutines that get the diagnosis pointers
 ; and indicators at order entry and result verification for outpatient.
 ;
 ; Reference to EN^DDIOL supported by IA #10142
 ; Reference to ^DIC supported by IA #10006
 ; Reference to $$GET1^DIQ supported by IA #2056
 ; Reference to ^DIR supported by IA #10026
 ; Reference to ^ICD9 supported by IA #10082
 ; Reference to ^DIC(9.4 supported by IA #10048
 ; Reference to ^DIC(81.3 supported by IA #2816
 ;
OPORD ; Outpatient Order Entry
 ;
 ; Input:
 ;  LRBEDFN    - Patient's DFN (#2)
 ;  LRBESMP    - Sample
 ;  LRBESPC    - Specimen
 ;  LRBETST    - Ordered Test
 ;  LRBEDGX    - Pointer to Diagnosis (#80)
 ;  LRBEAR(LRBEDFN,"DOS")      - Date of Service
 ;  LRBEAR(LRBEDFN,"PAT")      - Patient DFN (#2)
 ;  LRBEAR(LRBEDFN,"POS")      - Place of Service
 ;  LRBEAR(LRBEDFN,"ORDGX")    - Ordering or Resulting Diagnosis
 ;  LRBEAR(LRBEDFN,"USR")      - User
 ;  LRBEAR(LRBEDFN,"ORDPRO")    - Ordering Provider
 ;  LRBEAR(LRBEDFN,"LRBEDGX",LRBESMP,LRBESPC,LRBETST,LRBEDGX)
 ;   Piece     Desc
 ;   -----     ---------------------------------
 ;   1     -   Diagnosis
 ;   2     -   Unused (blank)
 ;   3     -   Textual Description of  Diagnosis
 ;   4     -   Agent Orange
 ;   5     -   Ionizing Radiation
 ;   6     -   Service Connected Indicator
 ;   7     -   Environmental Contaminamts
 ;   8     -   MST (Military Sexual Tramua)
 ;   9     -   Head and Neck Cancer
 ;   10    -   Combat Veteran
 ;
 ; Output:
 ;  LRBEAR1(VISIT,TST,LRBEPOV)=LRBEDGX
 ;   VISIT      -  Pointer to VISIT (9000010) file
 ;   TST        -  Ordered Test
 ;   LRBEPOV        -  Pointer to V POV (#9000010.07) file
 ;   LRBEDGX        -  Pointer to Diagnosis (#80)
EN ;
 D INIT
 S SUB1="ENCOUNTER",SUB2="DX/PL",SUB3="PROVIDER"
 S LRBEDFN="" F  S LRBEDFN=$O(LRBEAR(LRBEDFN)) Q:LRBEDFN=""  D
 .S LRBETM=$S($P($G(LRBECDT),".",2):LRBECDT,$G(LRCDT):LRCDT,1:DT)
 .S LRBETM=$$PCETM(LRBETM)
 .S ^TMP("LRPXAPI",$J,SUB1,1,"ENC D/T")=LRBETM
 .S ^TMP("LRPXAPI",$J,SUB1,1,"DSS ID")=LROOS
 .S ^TMP("LRPXAPI",$J,SUB1,1,"HOS LOC")=$G(LRBEAR(LRBEDFN,"POS"))
 .S ^TMP("LRPXAPI",$J,SUB1,1,"PATIENT")=$G(LRBEAR(LRBEDFN,"PAT"))
 .S ^TMP("LRPXAPI",$J,SUB1,1,"SERVICE CATEGORY")="X"
 .S ^TMP("LRPXAPI",$J,SUB1,1,"ENCOUNTER TYPE")="A"
 .S ^TMP("LRPXAPI",$J,SUB3,1,"NAME")=$G(LRBEAR(LRBEDFN,"ORDPRO"))
 .S ^TMP("LRPXAPI",$J,SUB3,1,"PRIMARY")=1
 .I $G(LRBEAR(LRBEDFN,"DEL")) D
 ..S ^TMP("LRPXAPI",$J,SUB1,1,"DELETE")=$G(LRBEAR(LRBEDFN,"DEL"))
 .S LRBESMP=""
 .F  S LRBESMP=$O(LRBEAR(LRBEDFN,"LRBEDGX",LRBESMP)) Q:LRBESMP=""  D
 ..S LRBESPC=""
 ..F  S LRBESPC=+$O(LRBEAR(LRBEDFN,"LRBEDGX",LRBESMP,LRBESPC)) Q:LRBESPC<1  D
 ...D OPWRK
 Q
 ;
OPWRK ; More Outpatient Work
 N X,XX,B,BG,N,DX,LRBEDIA
 ;get all primary (n=1) and secondary (n=2) dx
 S LRBETST="" F  S LRBETST=$O(LRBECPT(LRBETST)) Q:'LRBETST  D
 . S LRBETNUM=0 F  S LRBETNUM=$O(LRBECPT(LRBETST,LRBETNUM)) Q:LRBETNUM<1  D
 . . S LRBEDGX=""
 . . F  S LRBEDGX=$O(LRBEAR(LRBEDFN,"LRBEDGX",LRBESMP,LRBESPC,LRBETST,LRBEDGX)) Q:LRBEDGX=""  D
 . . . S LRBEPTDT=$G(LRBEAR(LRBEDFN,"LRBEDGX",LRBESMP,LRBESPC,LRBETST,LRBEDGX))
 . . . S N=$S($P(LRBEPTDT,U,12):1,1:2),X=$P(LRBEPTDT,U,4,11)
 . . . ;collapse indicators for same dx
 . . . S XX=$G(DX(N,LRBEDGX))
 . . . F B=1:1:8 I $P(XX,U,B)'=1,$P(X,U,B)'="" S $P(XX,U,B)=$P(X,U,B)
 . . . S DX(N,LRBEDGX)=XX
 ;set primary dx in PCE array
 S LRBEDGX=""
 F  S LRBEDGX=$O(DX(1,LRBEDGX)) Q:LRBEDGX=""  D
 . S LRBEDIA=$G(LRBEDIA)+1,XX=DX(1,LRBEDGX)
 . S ^TMP("LRPXAPI",$J,SUB2,LRBEDIA,"DIAGNOSIS")=LRBEDGX
 . S ^TMP("LRPXAPI",$J,SUB2,LRBEDIA,"PRIMARY")=1
 . F B=1:1:8 I $P(XX,U,B)'="" D
 . . S BG=$$GETT(B)
 . . I '$G(^TMP("LRPXAPI",$J,SUB2,LRBEDIA,BG)) S ^TMP("LRPXAPI",$J,SUB2,LRBEDIA,BG)=$P(XX,U,B)
 . . ;collapse dx indicators into encounter node
 . . I '$G(^TMP("LRPXAPI",$J,SUB1,1,$P(BG," ",2))) S ^TMP("LRPXAPI",$J,SUB1,1,$P(BG," ",2))=$P(XX,U,B)
 ;set secondary dx in PCE array
 S LRBEDGX=""
 F  S LRBEDGX=$O(DX(2,LRBEDGX)) Q:LRBEDGX=""  D
 . S LRBEDIA=$G(LRBEDIA)+1,XX=DX(2,LRBEDGX)
 . S ^TMP("LRPXAPI",$J,SUB2,LRBEDIA,"DIAGNOSIS")=LRBEDGX
 . F B=1:1:8 I $P(XX,U,B)'="" D
 . . S BG=$$GETT(B)
 . . I '$G(^TMP("LRPXAPI",$J,SUB2,LRBEDIA,BG)) S ^TMP("LRPXAPI",$J,SUB2,LRBEDIA,BG)=$P(XX,U,B)
 . . ;collapse dx indicators into encounter node
 . . I '$G(^TMP("LRPXAPI",$J,SUB1,1,$P(BG," ",2))) S ^TMP("LRPXAPI",$J,SUB1,1,$P(BG," ",2))=$P(XX,U,B)
 Q
 ;
GETT(X) ; Indicators for ^TMP
 I '+X Q ""
 Q "PL "_$S(X=1:"AO",X=2:"IR",X=3:"SC",X=4:"EC",X=5:"MST",X=6:"HNC",X=7:"CV",X=8:"SHAD",1:"")
 ;
OPRES(LRBEAR,LRBEAR1,LRODT,LRSN,LRBEVST) ; Outpatient Final Resulting
 ; Inputs:
 ;  LRBEDN    -  Data Number of Test in #63 field 400
 ;  LRBEAR(LRBEDFN,"VST")     -  Patient's Encounter Number #9000010
 ;  LRBEAR(LRBEDFN,"LRBEDGX",LRBEDN)
 ;   Piece     Desc
 ;   1     -   Procedure (CPT)
 ;   2     -   Modifiers (Sub-delimited by "~")
 ;   3     -   Diagnosis
 ;   4     -   Diagnosis 2
 ;   5     -   Diagnosis 3
 ;   6     -   Diagnosis 4
 ;   7     -   Event D/T  (DOS)
 ;   8     -   Encounter Provider
 ;   9     -   Ordering Provider
 ;   10    -   Quantity (Number of times procedure was performed)
 ;   11    -   Place of Service 
 ; Output:
 ;  LRBEAR1(VISIT,TST,LRBEPOV)=LRBEDGX
 ;   VISIT      -  Pointer to VISIT (9000010) file
 ;   TST        -  Ordered Test
 ;   LRBEPOV        -  Pointer to V POV (#9000010.07) file
 ;   LRBEDGX        -  Pointer to Diagnosis (#80)
 ;
 D INIT
 N LRSWSTAT,LRSWDATE
 S LRSWSTAT=$$SWSTAT^IBBAPI
 S LRSWDATE=+$P(LRSWSTAT,U,2)
 S LRSWSTAT=+$P(LRSWSTAT,U)
 S SUB1="PROCEDURE"
 I '$G(LRDBEDGX) D
 . N LRX
 . S (LRDBEDGX,LRX)=0
 . F  S LRX=$O(^LRO(69,LRODT,1,LRSN,2,LRX)) Q:LRX<1!($G(LRDBEDGX))  D
 . . ;set a default diagnosis and sc/ei indicators
 . . I $G(^LRO(69,LRODT,1,LRSN,2,LRX,2,1,0)) S LRDBEDGX=+^(0)
 S LRBEDFN="" F  S LRBEDFN=$O(LRBEAR(LRBEDFN)) Q:LRBEDFN=""  D
 . S LRI=0 F  S LRI=$O(LRBEAR(LRBEDFN,"LRBEDGX",LRI)) Q:LRI<1  D
 . . D OPWRK2
 ;microbiology results sent to PCE in LRCAPPH1
 I $P($G(^LRO(68,$G(LRAA),0)),U,2)'="MI" D SEND
 Q
SEND ; Send if procedure is defined
 N LRLNOW,LRVX,PXALOOK,PXUCV
 I '$G(^TMP("LRPXAPI",$J,"PROCEDURE",1,"PROCEDURE")) G END
 I $G(^XTMP("LRPCELOG",0)) D
 . F  S LRLNOW=$$NOW^XLFDT Q:'$D(^XTMP("LRPCELOG",1,LRLNOW))
 . N LRACCX,LRUIDX
 . S LRACCX=$G(LRACC),LRUIDX=$G(LRUID)
 . M ^XTMP("LRPCELOG",2,LRLNOW)=^TMP("LRPXAPI",$J)
 . S ^XTMP("LRPCELOG",2,LRLNOW,0)=LRACCX_U_LRUIDX
 S LRVX=$$DATA2PCE^PXAPI(INROOT,LRPKG,SRC,.LRBEVSIT,USR,ERRDIS)
 I $D(^XTMP("LRPCELOG",2,+$G(LRLNOW),0)) D
 . S $P(^XTMP("LRPCELOG",2,+$G(LRLNOW),0),U,3,4)=LRVX_U_LRBEVSIT
 . M ^XTMP("LRPCELOG",2,LRLNOW)=^TMP("LRPXAPI",$J)
 I $G(LRBEVSIT) D SVST^LRBEBA3(LRBEVSIT,"PCE",LRODT,LRSN)
END K ^TMP("LRPXAPI",$J),LRBETNUM
 Q
 ;
OPWRK2 ; Outpatient Work Two
 K LRBEPTDT
 S LRBEDN=0 F  S LRBEDN=+$O(LRBEAR(LRBEDFN,"LRBEDGX",LRI,LRBEDN)) Q:LRBEDN<1  D OPWRK3
 Q
OPWRK3 ;
 N JJ
 S LRBEPTDT=$G(LRBEAR(LRBEDFN,"LRBEDGX",LRI,LRBEDN))
 Q:'($L(LRBEPTDT))
 I '$P(LRBEPTDT,U,3) D
 .S $P(LRBEPTDT,U,3)=LRDBEDGX
 .S JJ=$O(^TMP("LRPXAPI",$J,"DX/PL",99),-1)+1
 .S ^TMP("LRPXAPI",$J,"DX/PL",JJ,"DIAGNOSIS")=LRDBEDGX
 .I JJ=1 S ^TMP("LRPXAPI",$J,"DX/PL",JJ,"PRIMARY")=1
 .E  S ^TMP("LRPXAPI",$J,"DX/PL",JJ,"PRIMARY")=0
 S LRBETNUM=$G(LRBETNUM)+1,LRBEIEN=LRSN_","_LRODT_","
 I $P(LRBEPTDT,U,1)'="" D
 .S ^TMP("LRPXAPI",$J,SUB1,LRBETNUM,"PROCEDURE")=$P(LRBEPTDT,U,1)
 .S ^TMP("LRPXAPI",$J,SUB1,LRBETNUM,"QTY")=1
 I $P(LRBEPTDT,U,2)'="" D
 .S ^TMP("LRPXAPI",$J,SUB1,LRBETNUM,"MODIFIERS",$P(LRBEPTDT,U,2))=""
 I $P(LRBEPTDT,U,3)'="" D
 .S ^TMP("LRPXAPI",$J,SUB1,LRBETNUM,"DIAGNOSIS")=$P(LRBEPTDT,U,3)
 I $P(LRBEPTDT,U,4)'="" D
 .S ^TMP("LRPXAPI",$J,SUB1,LRBETNUM,"DIAGNOSIS 2")=$P(LRBEPTDT,U,4)
 I $P(LRBEPTDT,U,5)'="" D
 .S ^TMP("LRPXAPI",$J,SUB1,LRBETNUM,"DIAGNOSIS 3")=$P(LRBEPTDT,U,5)
 I $P(LRBEPTDT,U,6)'="" D
 .S ^TMP("LRPXAPI",$J,SUB1,LRBETNUM,"DIAGNOSIS 4")=$P(LRBEPTDT,U,6)
 I $P(LRBEPTDT,U,7)'="" D
 . N LRBETM S LRBETM=$P(LRBEPTDT,U,7)
 . S LRBETM=$$PCETM(LRBETM)
 . S ^TMP("LRPXAPI",$J,SUB1,LRBETNUM,"EVENT D/T")=LRBETM
 I $P(LRBEPTDT,U,8)'="" D
 .S ^TMP("LRPXAPI",$J,SUB1,LRBETNUM,"ENC PROVIDER")=$P(LRBEPTDT,U,8)
 I $P(LRBEPTDT,U,9)>0 D
 .S ^TMP("LRPXAPI",$J,SUB1,LRBETNUM,"ORD PROVIDER")=$P(LRBEPTDT,U,9)
 I $P(LRBEPTDT,U,10)'="" D
 .S ^TMP("LRPXAPI",$J,SUB1,LRBETNUM,"QTY")=$P(LRBEPTDT,U,10)
 I $P(LRBEPTDT,U,12)'="" D
 .S ^TMP("LRPXAPI",$J,SUB1,LRBETNUM,"DIAGNOSIS 5")=$P(LRBEPTDT,U,12)
 I $P(LRBEPTDT,U,13)'="" D
 .S ^TMP("LRPXAPI",$J,SUB1,LRBETNUM,"DIAGNOSIS 6")=$P(LRBEPTDT,U,13)
 I $P(LRBEPTDT,U,14)'="" D
 .S ^TMP("LRPXAPI",$J,SUB1,LRBETNUM,"DIAGNOSIS 7")=$P(LRBEPTDT,U,14)
 I $P(LRBEPTDT,U,15)'="" D
 .S ^TMP("LRPXAPI",$J,SUB1,LRBETNUM,"DIAGNOSIS 8")=$P(LRBEPTDT,U,15)
 I $P(LRBEPTDT,U,16)'="" D
 .S ^TMP("LRPXAPI",$J,SUB1,LRBETNUM,"ORD REFERENCE")=$P(LRBEPTDT,U,16)
 I LRSWSTAT,($P(LRBETM,".")'<LRSWDATE) D
 .S ^TMP("LRPXAPI",$J,"PROCEDURE",LRBETNUM,"DEPARTMENT")=108
 I $P(LRBEPTDT,U,20)'="" D
 .S ^TMP("LRPXAPI",$J,SUB1,LRBETNUM,"QTY")=$P(LRBEPTDT,U,20)
 I $G(^TMP("LRPXAPI",$J,SUB1,LRBETNUM,"DIAGNOSIS"))=0 K ^TMP("LRPXAPI",$J,SUB1,LRBETNUM,"DIAGNOSIS")
 Q
 ;
INIT ;Setup PCE variables
 S INROOT="^TMP(""LRPXAPI"",$J)"
 I '$G(LRPKG) D  Q:'$G(LRPKG)
 . S X="LAB SERVICE",DIC="^DIC(9.4,",DIC(0)="Z" D ^DIC
 . I Y S LRPKG=+Y
 S SRC="LAB DATA",USR=DUZ,(LRBETNUM,ERRDIS)=0
 K DIC
 Q
PCETM(LRBETM) ;Return date/time without seconds
 N PCETM
 S LRBETM=$G(LRBETM)
 Q:'LRBETM LRBETM
 S PCETM=$E($P(LRBETM,".",2),1,4)
 F  Q:($L(PCETM)=4)  S PCETM=PCETM_0
 I PCETM>2359 S PCETM=2359
 I $E(PCETM,3,4)>59 S PCETM=$E(PCETM,1,2)_59
 I 'PCETM S PCETM="0001"
 S $P(LRBETM,".",2)=PCETM
 Q LRBETM
