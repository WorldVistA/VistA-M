LRCAPES1 ;DALOI/FHS/KLL-CONT MANUAL PCE CPT WORKLOAD CAPTURE ;07/30/04
 ;;5.2;LAB SERVICE;**274,308**;Sep 27, 1994
 ;Continuation of LRCAPES
EN ;Setup the order of defined NLT codes
 ; ^ICPTCOD supported by DBIA 1995-A
 Q:$G(^TMP("LR",$J,"AK",0,1))=DUZ_U_DT
 N LRI,LRY,LRX,LRX2,LRX3,LRDES,LRCNT
 K ^TMP("LR",$J,"AK")
 S LRCNT=0
 S ^TMP("LR",$J,"AK",0)=$$FMADD^XLFDT(DT,2)_U_DT_U_"ES CPT code list"
 S ^TMP("LR",$J,"AK",0,1)=DUZ_U_DT
 S LRY="^LAM(""AK"")" F  S LRY=$Q(@LRY) Q:$QS(LRY,1)'="AK"  D
 . N LRDES
 . S LRX2=$QS(LRY,2),LRX3=$QS(LRY,3)
 . Q:'$G(LRX2)!('$G(LRX3))
 . S LRI=0 F  S LRI=$O(^LAM(LRX3,4,"AC","CPT",LRI)) Q:LRI<1  D
 . . S LRX=+$G(^LAM(LRX3,4,LRI,0)),LRX=$$CPT^ICPTCOD(LRX,DT)
 . . Q:'$P(LRX,U,7)
 . . K LRDES S LRDES=$$CPTD^ICPTCOD(+LRX,"LRDES")
 . . S LRCNT=LRCNT+1
 . . I $L(LRDES(1)) S ^TMP("LR",$J,"AK",LRX2,LRI,+LRX)=LRX3_U_$E(LRDES(1),1,55)_U_$$GET1^DIQ(64,LRX3_",",.01,"E")_U_$$GET1^DIQ(64,LRX3_",",1,"E") Q
 . . S ^TMP("LR",$J,"AK",LRX2,LRI,+LRX)=LRX3_U_$P(LRX,U,3)_U_$$GET1^DIQ(64,LRX3_",",.01,"E")_U_$$GET1^DIQ(64,LRX3_",",1,"E")
 Q
SET(DFN,LRPRO,LREDT,LRLOC,LRINS,LRCPT,LRAA,LRAD,LRAN) ; Call to check variable
 S (LREND,LROK)=0,LRAA=+$G(LRAA),LRAD=+$G(LRAD),LRAN=+$G(LRAN)
 I '$D(^DPT(DFN,0))#2 S LROK="1^Error Patient" Q LROK
 I $$GET^XUA4A72(LRPRO,DT)<1 S LROK="2^Inactive Provider" Q LROK
 I LREDT'?7N.E S LROK="3^Date Format" Q LROK
 I '$D(^SC(LRLOC,0))#2 S LROK="4^Location Error" Q LROK
 I "CMZ"'[$P($G(^SC(LRLOC,0)),U,3) S LROK="4.2^Not Inpatient Location" Q LROK
 I '$G(LRDSSID) S LROK="4.2^Not Inpatient Location" Q LROK
 I '$D(^DIC(4,LRINS,0))#2 S LROK="5^Institution Error" Q LROK
 I '$O(LRCPT(0)) S LROK="6^No CPT Codes Passed" Q LROK
 D EN^LRCAPES,READ^LRCAPES1
 D DIS I '$O(^TMP("LR",$J,"LRLST",0)) S LROK="-1" Q LROK
 D LOAD^LRCAPES,CLEAN^LRCAPES
 Q LROK
 ;
SEND ;Send data to PCE via DATA2PCE^PXAPI API
 I $$GET1^DIQ(63,+$G(LRDFN),.02,"I")=2,$G(LRDSSID),$O(^TMP("LRPXAPI",$J,"PROCEDURE",0)) D
 . I '$D(LRQUIET) W !,$$CJ^XLFSTR("Sending PCE Workload",IOM)
 . S:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,"PCE")) ^("PCE")="" S LRPCEN=^("PCE")
 . S LREDT=$S($G(LREDT):LREDT,1:$$NOW^XLFDT)
 . S:'$P(LREDT,".",2) $P(LREDT,".",2)="1201"
 . D SEND^LRCAPPH1
 . I '$D(LRQUIET) W $$CJ^XLFSTR("Visit # "_LRVSITN,80)
 . S ^LRO(68,LRAA,1,LRAD,1,LRAN,"PCE")=$E(LRPCEN_LRVSITN_";",1,80)
 D SETWKL(LRAA,LRAD,LRAN)
 Q
SETWKL(LRAA,LRAD,LRAN) ;Set workload into 68 from CPT coding
 Q:'$P(LRPARAM,U,14)!('$P($G(^LRO(68,+$G(LRAA),0)),U,16))
 I '$G(^LRO(68,+$G(LRAA),1,+$G(LRAD),1,+$G(LRAN),0)) Q
 I '$O(^TMP("LR",$J,"LRLST",0)) K ^TMP("LR",$J,"LRLST") Q
 I '$D(LRQUIET) W !,$$CJ^XLFSTR("Storing LMIP Workload",IOM)
 N LRCNT,LRT,LRP,LRTIME,LRCDEF,LRURGW,LRI,LRADD
 S:'$G(LRURG) LRURG=9
 S (LRADD,LRCNT)=1,LRCDEF="3000",LRURGW=+$G(LRURG)
 S LRT("P")=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,0))
 S LRI=0 F  S LRI=$O(^TMP("LR",$J,"LRLST",LRI)) Q:LRI<1  D
 . S LRP=$P(^TMP("LR",$J,"LRLST",LRI),U,2)
 . I 'LRP D  Q:'LRP
 . . S LRP=+$O(^LAM("AB",$P(^TMP("LR",$J,"LRLST",LRI),U)_";ICPT(",0))
 . Q:'($D(^LAM(LRP,0))#2)
 . S LRT=+$O(^LAM(LRP,7,"B",0))
 . I 'LRT S LRT=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,0))
 . Q:'LRT
 . D SET^LRCAPV1S,STUFI^LRCAPV1
 K ^TMP("LR",$J,"LRLST")
 Q
DIS ;
 N X9
 K X,LRLST,LRCNT,LRI,LRX,LRXY,LRXTST
 K ^TMP("LR",$J,"LRLST")
 N LRNOTFD,LRNOLK,LRIA81,LRIA64,LRRF64
 I $G(LRANSX) D
 . S X=LRANSX D RANGE^LRWU2
 . X (X9_"S LRX=T1 D EX1^LRCAPES")
 I '$O(^TMP("LR",$J,"LRLST",0)) D  Q
 . W !!!,?5,"The following CPT Code(s) are not selected:"
 . W:$G(LRNOTFD) !?8,"Not found in #81: ",LRNOTFD
 . W:$G(LRIA81) !?8,"Inactive in #81: ",LRIA81
 . W:$G(LRIA64) !?8,"Inactive in #64: ",LRIA64
 . W:$G(LRNOLK) !?8,"Not linked to workload: ",LRNOLK
 . W !
 . S LRANSY=0
 D DEM
CHK ;User accepts CPT list
 N DIR
 S DIR("A")="Is this correct "
 S DIR(0)="Y",DIR("B")="Yes" D RD
 I $G(LRANSY)'=1 D
 .K ^TMP("LR",$J,"LRLST")
 .S ^TMP("LR",$J,"LRLST")=$$FMADD^XLFDT(DT,2)_U_DT_U_"LAB ES CPT"
 Q
PG ;Page break
 N DIR,DIRUT,DUOUT,DTOUT
 S DIR(0)="E" D ^DIR
 I $G(DIRUT) S LREND=1 Q
 W @IOF
 Q
RD ;DIR read
 N Y,X,DTOUT,DUOUT,DIRUT,DIROUT
 S (LRANSY,LRANSX)=0
 S LREND=0 W !
 D ^DIR I $D(DIRUT) S LREND=1 Q
 S LRANSY=$G(Y),LRANSX=$G(X)
 Q
READ ;Select CPT codes for accession
 ; Ask if want to see previously loaded CPT codes
 D LSTCPT(LRAA,LRAD,LRAN)
 N DIR,LREND
 S DIR(0)="LO",LREND=0
 S DIR("A")="Select CPT codes"
 S DIR("?")="List or range e.g, 1,3,5-7,88000."
 S DIR("??")="^D HLP^LRCAPES1"
 D RD
 Q
DEM ;
 N LRIENS,DA
 S LRIENS=LRAN_","_LRAD_","_LRAA_","
 W @IOF
 W !?3,PNM,?35,SSN,?55,"DOB: ",$$FMTE^XLFDT(DOB,1)
 W !?5,LRCDT
 W !?10,LRSPECID,?60,"Loc: ",$G(LRLLOCX)
 I $G(^LRO(68,LRAA,1,LRAD,1,LRAN,"PCE")) W !?15,"PCE ENC # "_^("PCE")
 W !?15,"Specimen: ",$$GET1^DIQ(68.05,"1,"_LRIENS,.01,"E")
 I $L($G(LRSS)),$O(^LR(LRDFN,LRSS,LRIDT,.1,0)) D
 . N LRX
 . W !?5,"Tissue Specimens: "
 . S LRX=0 F  S LRX=$O(^LR(LRDFN,LRSS,LRIDT,.1,LRX)) Q:LRX<1  W !,?15,$P($G(^(LRX,0)),U)
 W !?5,"Test(s); "
 S (LREND,LRX)=0 D
 . N LREND
 . F  S LRX=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRX)) Q:LRX<1!($G(LREND))  D
 . . I $Y>(IOSL-5) D PG Q:$G(LREND)
 . . W ?15,$P($G(^LAB(60,+LRX,0)),U)_"/ "
 ;Display pathologist's name
 N LRPATH,LRIENS,LRFL
 S:LRSS="AU" LRPATH=$$GET1^DIQ(63,LRDFN,13.6,"I")
 I LRSS'="AU" D
 .S LRFL=$S(LRSS="EM":63.02,LRSS="CY":63.09,LRSS="SP":63.08,1:0)
 .S LRIENS=LRIDT_","_LRDFN_","
 .S LRPATH=$$GET1^DIQ(LRFL,LRIENS,.02,"I")
 S LRPATH=$$GET1^DIQ(200,+$G(LRPATH),.01,"I")
 W:LRSS="CY" !?5,"Pathologist/Cytotechnologist: ",LRPATH,!
 W:LRSS'="CY" !?5,"Pathologist: ",LRPATH,!
 ;
 Q:'$O(^TMP("LR",$J,"LRLST",0))
 W !!,$$CJ^XLFSTR("Selected CPT Codes",IOM)
 W ! S (LREND,LRX)=0 D
 . N LREND,LRTMP
 . S LRTMP=0
 . F  S LRX=+$O(^TMP("LR",$J,"LRLST",LRX)) Q:LRX<1!($G(LREND))  D
 . . I $Y>(IOSL-5) D PG Q:$G(LREND)
 . . S LRTMP=$G(^TMP("LR",$J,"LRLST",LRX))
 . . W !?5,"("_LRX_")  "_$P(LRTMP,U)_" "_$E($P(LRTMP,U,3),1,50),!
 . . W:$P(LRTMP,U,5) ?10,$E($P(LRTMP,U,4),1,50)_"  {"_$P(LRTMP,U,5)_"}"
 I $G(LRNOTFD)!$G(LRIA81)!$G(LRIA64)!$G(LRNOLK)!$G(LRRF64) D
 . W !!!?5,"The following CPT Codes are NOT Selected"
 . W:$G(LRNOTFD) !?8,"Not found in #81: ",LRNOTFD
 . W:$G(LRIA81) !?8,"Inactive in #81: ",LRIA81
 . W:$G(LRIA64) !?8,"Inactive in #64: ",LRIA64
 . W:$G(LRNOLK) !?8,"Not Linked to Workload: ",LRNOLK
 . W:$G(LRRF64) !?8,"Inactive in #64\Active Replacement Found: ",LRRF64
 Q
CHKCPT ;Edit CPT code - does it exist,active in 81 or 64, linked to workload?
 N LRINACT,LRII
 S (LRNR,LRACTV,LRXY2,LRWL2,LRD2)=0,LRXY1=$P(LRXY,U)
 I LRXY1=-1 S LRNOTFD=$S($G(LRNOTFD):LRNOTFD_LRX_",",1:LRX_",") Q
 I '$P(LRXY,U,7) S LRIA81=$S($G(LRIA81):LRIA81_LRXY1_",",1:LRXY1_",") Q
 I '$O(^LAM("AB",LRXY1_";ICPT(",0)) D  Q
 . S LRNOLK=$S($G(LRNOLK):LRNOLK_LRXY1_",",1:LRXY1_","),LRNR=1
 ;If CPT is not active in 64, look for alternative active CPT
 S LRWL2=+$O(^LAM("AB",LRXY1_";ICPT(",0))
 S:$G(LRQ)'="" LRWL2=$P(@LRQ,"^") ;For ES Display CPTs
 Q:'LRWL2
 S LRD2=+$O(^LAM("AB",LRXY1_";ICPT(",LRWL2,LRD2))
 S LRREL2=$P(^LAM(LRWL2,4,LRD2,0),U,3),LRINA2=$P(^(0),U,4)
 Q:LRREL2&(LRINA2="")
 Q:LREDT>(LRREL2-1)&((LREDT<LRINA2)!(LRINA2=""))
 ;CPT is inactive, search for another linked, active CPT to replace it
 S LRD2="A",LRD2=$O(^LAM(LRWL2,4,LRD2),-1)
 I LRD2>1 D
 .S LRII=0,(LRREL2,LRINA2)=""
 .F  S LRII=$O(^LAM(LRWL2,4,LRII)) Q:'LRII!(LRACTV)  D
 ..S LRXY2=+$P(^LAM(LRWL2,4,LRII,0),U)
 ..Q:LRXY2=LRXY1
 ..S LRREL2=$P(^LAM(LRWL2,4,LRII,0),U,3),LRINA2=$P(^(0),U,4)
 ..I LRREL2&(LRINA2="") S LRACTV=1  Q
 ..I LREDT>(LRREL2-1)&((LREDT<LRINA2)!(LRINA2="")) S LRACTV=1  Q
 ;No replacement active CPT found, 
 I 'LRACTV S LRIA64=$S($G(LRIA64):LRIA64_LRXY1_",",1:LRXY1_","),LRNR=1 Q
 Q
LSTCPT(LRAA,LRAD,LRAN)  ; Show loaded CPT codes if any
 Q:$S('$G(LRAA):1,'$G(LRAD):1,'$G(LRAN):1,1:0)
 N LRSTR
 S LRSTR=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,"PCE")) Q:'LRSTR
 N DA,DIC,DIR,DIRUT,DIR,DR,ERR,DUOUT,IEN,LRDA,LRENC,LREND,LRP,S,X,Y
 S DIR(0)="Y",DIR("A")=" Would you like to see PCE CPT Information"
 S DIR("B")="No" D ^DIR Q:$G(DIRUT)!($G(Y)'=1)
 ;List filed CPT CODES
 W @IOF
 F LRP=1:1 S IEN=$P(LRSTR,";",LRP) Q:IEN=""  D
 . D GETCPT^PXAPIOE(IEN,"LRENC","ERR")
 S (LRDA,LREND)=0 F  S LRDA=$O(LRENC(LRDA)) Q:'LRDA!($G(LREND))  D
 . I $Y>(IOSL-6) D PG W @IOF Q:$G(LREND)
 . S S=0,DA=LRDA,DR="0:99",DIC="^AUPNVCPT(" D EN^DIQ
 Q
HLP ;Help display for CPT selection
 N DIR,DIRUT,DUOUT,DTOUT,LREND,LRX,LRY
 W @IOF
 S LRX="^TMP(""LR"","_$J_",""AK"",0,1)"
 W $$CJ^XLFSTR("List or range e.g, 1,3,5-7,88300.",IOM)
 W $$CJ^XLFSTR("Select from the following or enter CPT separated by a comma",IOM),!
 F  S LRX=$Q(@LRX) Q:$QS(LRX,2)'=$J!($G(LREND))!($QS(LRX,1)'="LR")  D
 . S LRY=@LRX
 . W !?3,$QS(LRX,4),?6," = "_$QS(LRX,6)_"  "_$E($P(LRY,U,2),1,60),!
 . W:$P(LRY,U,4) ?8,$P(LRY,U,3)_" { NLT = "_$P(LRY,U,4)_" }",!
 . I $Y>(IOSL-6) S DIR(0)="E" D RD I '$G(LREND)  W @IOF
 D LSTCPT^LRCAPES1($G(LRAA),$G(LRAD),$G(LRAN))
 Q
