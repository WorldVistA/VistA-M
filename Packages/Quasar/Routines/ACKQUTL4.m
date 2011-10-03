ACKQUTL4 ;HCIOFO/BH-NEW/EDIT Visit Template Utilities for QUASAR ; 11/13/08 12:57pm
 ;;3.0;QUASAR;**1,8,14,17,16**;Feb 11, 2000;Build 37
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
 ;Reference/IA
 ;GETCUR^DGNTAPI/3457
 ;CVEDT^DGCV/4156
 ;
CHK(Y,ACKVD) ;
 N ACKQQD
 S ACKQQD=$P(^EC(725,Y,0),"^",3) I ACKQQD="" Q 1
 I ACKVD<ACKQQD Q 1
 Q 0
 ;  Clears passed in field # of visit rec.
CLEAR(ACKVIEN,ACKZNUM) ;
 N ACKARR
 S ACKARR(509850.6,ACKVIEN_",",ACKZNUM)=""
 D FILE^DIE("","ACKARR","")
 Q
 ;  Decides if patient is/was suffering from MST at the time of the visit
MST(ACKPCE,ACKVD,ACKPAT) ;
 I '$$PATCH^XPDUTL("DG*5.3*308") Q 0
 I ACKPCE'=1 Q 0
 N ACKRET,ACKXKEEP
 S ACKXKEEP=X
 S ACKRET=$$GETSTAT^DGMSTAPI(ACKPAT,ACKVD)
 S X=ACKXKEEP
 I $P(ACKRET,"^",2)="Y" Q 1
 Q 0
 ;
PROB(ACKPCE,ACKDIV) ;  Decides if Update PCE Problem List prompt appears
 I 'ACKPCE Q 0
 I '$$GET1^DIQ(509850.83,ACKDIV_",1",".09","I") Q 0
 Q 1
 ;
SETUP ;  Called from within the New/Edit visit template to set up parameters
 ;
 D ENS^%ZISS
 ;
 I ACKVISIT="EDIT" D
 . K ACKAR
 . S ACKAR(509850.6,ACKVIEN_",",.27)=""
 . D FILE^DIE("K","ACKAR") K ACKAR
 ;
 N ACKX,ACKD0
 ;
 S (ICPTVDT,ICDVDT)=ACKVD
 ;
 S ACKPCE=$$PCE(ACKDIV,ACKVD)  ;  Sets PCE indicator
 ;
 S ACKEVENT=1
 S ACKEVENT=$$EVENT^ACKQUTL5(ACKDIV,ACKVD)   ; Use EC Codes or CPT
 ;  Indicates whether local clinic #'s are in use
 S ACKCLNO=$$GET1^DIQ(509850.83,ACKDIV_",1",".04","I")
 ;
 ;  Indicates whether the bypass flag for Audiometrics is set
 S ACKBA=$$GET1^DIQ(509850.83,ACKDIV_",1",".07","I")
 ;
 ;  Indicates whether the visit is service connected
 S DFN=ACKPAT D ELIG^VADPT S ACKSC=$P(VAEL(3),U,1)
 ;
 ;  Indicates whether the patient has any previous visits
 ;  with audiometric test scores
 ;
 S ACKATS=1
 S ACKX=$O(^ACK(509850.6,"AMD",ACKPAT,0)),ACKD0=$O(^ACK(509850.6,"AMD",ACKPAT,+ACKX,0))
 I 'ACKX!('$D(^ACK(509850.6,+ACKD0,0))) S ACKATS=0
 ; 
 S (ACKAO,ACKRAD,ACKENV,ACKHNC,ACKCV)=0,(ACKLOSS,ACKLAMD)=""
 I ACKPCE D STATUS
 S:ACKSC ACKQSER=1 S:ACKAO ACKQORG=1
 S:ACKRAD ACKQIR=1 S:ACKENV ACKQECON=1
 ;
 D ELIG
 ;
 K VASV,VAEL
 ;  
 Q
 ;
PCE(ACKDIV,ACKVD) ;  Sets ACKPCE to 1 if - The send to PCE flag is set 
 ; (for the division) and the PCE INTERFACE START DATE is before or on
 ; the same day as the Visit Date and the INTERFACE WITH PCE flag for
 ; the site is set to true.
 N ACKOUT S ACKOUT=0
 I $$GET1^DIQ(509850.8,"1,","2","I") D
 . I $$GET1^DIQ(509850.83,ACKDIV_",1",".03","I"),ACKVD'<$$GET1^DIQ(509850.83,ACKDIV_",1",".08","I") S ACKOUT=1
 Q ACKOUT
 ;
STATUS ;  Sets Agent orange, Radiation and Environmental Contaminant and Combat indicators
 ;  AO,Rad
 D SVC^VADPT S ACKAO=VASV(2),ACKRAD=VASV(3)
 ; Combat Veteran
 ; DBIA 4156
 S:$G(ACKVD) ACKCV=+$P($$CVEDT^DGCV(ACKPAT,ACKVD),U,3)
 ;  HNC
 N ACKHNC0
 D GETCUR^DGNTAPI(DFN,"ACKHNC0")
 S ACKHNC=$S((".3.4.5."[("."_$P($G(ACKHNC0("STAT")),U)_".")):1,1:0)
 ;  ENV
 S ACKENV=$$GET1^DIQ(2,ACKPAT,.322013,"I")
 I ACKENV="Y" S ACKENV=1
 S:ACKENV'="1" ACKENV=0
 Q
 ;-----
 ;
AUDIO() ;  Pass back 1 if user is valid to enter audimetric scores else 0
 ;
 I ACKCP=1 Q 1
 I ACKLOSS,'ACKBA Q 1
 Q 0
 ;
 ;-----
 ;
ELIG ;  Set up eligibiliy variables and if more than one eligibility create
 ;  display array used in block ELIGDISP
 ;
 ;  If not service connected set default to primary & file in visit rec.
 I $P(VAEL(3),U,1)=0 D  Q
 . S ACKELGCT=1,ACKELIG=$P(VAEL(1),U,2),ACKELIG1=$P(VAEL(1),U,1)
 . K ACKAR  S ACKAR(509850.6,ACKVIEN_",",80)=ACKELIG1
 . D FILE^DIE("K","ACKAR") K ACKAR Q
 ;
 S ACKVELG=$$GET1^DIQ(509850.6,ACKVIEN,80,"I") I $G(ACKVELG)'="" D
 . S ACKVELG=ACKVELG_"^"_$$GET1^DIQ(8,ACKVELG,.01,"I")
 ;
 ;  Set default eligibility
 S ACKELIG=$S($G(ACKVELG)'="":$P(ACKVELG,U,2),1:$P(VAEL(1),U,2))
 ;
 ;  Set up display array
 ;
 K ACKELDIS S ACKELGCT=0
 ;
 I $G(ACKVELG)'="" S ACKELDIS($P(ACKVELG,U,1))=ACKVELG,ACKELGCT=ACKELGCT+1
 S ACKELDIS($P(VAEL(1),U,1))=VAEL(1),ACKELGCT=ACKELGCT+1
 ;
 S ACKK2=""
 F  S ACKK2=$O(VAEL(1,ACKK2)) Q:ACKK2=""  D
 .S ACKELGCT=ACKELGCT+1
 .S ACKELDIS($P(VAEL(1,ACKK2),U,1))=VAEL(1,ACKK2)
 ;
 ;  If not already set up add NSC internal number 5
 I '$D(ACKELDIS(5)) S ACKELGCT=ACKELGCT+1,ACKELDIS(5)="5^NSC"
 ;
 Q
 ;
ELIGDIS  ;  Display patients eligibilities
 ;
 N ACKK2,RC
 D ENS^%ZISS
 S RC=$$PAGE^ACKQNQ(6)  Q:RC<0  W:'RC !!
 W IOUON,"This Patient has other Entitled Eligibilities",IOUOFF,!!
 S ACKK2=""
 F  S ACKK2=$O(ACKELDIS(ACKK2)) Q:ACKK2=""  D  Q:RC<0
 .Q:$P(ACKELDIS(ACKK2),U,2)=ACKELIG
 .S RC=$$PAGE^ACKQNQ(2) Q:RC<0
 .W:RC IOUON,"Other Entitled Eligibilities (cont'd)",IOUOFF,!!
 .W ?1,$P(ACKELDIS(ACKK2),U,2)_" "
 .W $$GET1^DIQ(8,ACKK2,5),!
 Q
 ;-----
 ;  Display Patient data concerning Rated Disabilities and service class.
PATDIS ;
 S DFN=ACKPAT  D RATDIS^ACKQNQ
 D CLASDIS^ACKQNQ
 Q
 ;
ACKCP() ;  This initializes the C&P Parameter.
 ;  First check site parameters file for C&P flag
 ;
 I '$$GET1^DIQ(509850.83,ACKDIV_",1",".06","I") Q 0
 ;
 ;  Check if C&P has an open request pass back 1 or 0
 S ACKQCPS=$$EN1^DVBCTRN(ACKPAT,"AUDIO")
 S:ACKQCPS>0 ACKQCPS=$P(ACKQCPS,U)
 I $S(ACKCSC'="A":1,$$EN1^DVBCTRN(ACKPAT,"AUDIO",ACKQCPS)<1:1,$O(^ACK(509850.6,"ALCP",ACKQCPS,0))=ACKVIEN:0,$D(^ACK(509850.6,"ALCP",ACKQCPS)):1,1:0) Q 0
 Q "1^"_ACKQCPS
 ;
 ;-----
PROVDIS ;  Get providers already filed and display
 ;
 N RC
 D ENS^%ZISS
 N ACKK1,ACKPROV,ACKK2,D0,ACKARR,ACKTGT,ACKMSG
 D LIST^DIC(509850.66,","_ACKVIEN_",",".01","","*","","","","","","ACKTGT","ACKMSG")
 S ACKK1=""
 F  S ACKK1=$O(ACKTGT("DILIST",1,ACKK1)) Q:ACKK1=""  D
 . S ACKARR(ACKK1)=ACKTGT("DILIST",1,ACKK1)
 K ACKPROV S ACKK2=ACKVIEN_","
 D GETS^DIQ(509850.6,ACKK2,"6;7","E","ACKPROV")
 I '$D(ACKARR),$G(ACKPROV(509850.6,ACKK2,"6","E"))="",$G(ACKPROV(509850.6,ACKK2,"7","E"))="" Q
 S RC=$$PAGE^ACKQNQ(5) Q:RC<0  W:'RC !!
 W " ",IOUON,"Providers currently recorded for this visit",IOUOFF,!
 I $G(ACKPROV(509850.6,ACKK2,"6","E"))'="" W !," Primary Provider   - "_ACKPROV(509850.6,ACKK2,"6","E")
 I $D(ACKARR)>1  S RC=0  D  Q:RC<0
 . S ACKK1=""
 . F  S ACKK1=$O(ACKARR(ACKK1))  Q:ACKK1=""  D  Q:RC<0
 . . S RC=$$PAGE^ACKQNQ(2)  Q:RC<0
 . . W !," Secondary Provider - "_ACKARR(ACKK1)
 D:$G(ACKPROV(509850.6,ACKK2,"7","E"))'=""
 . S RC=$$PAGE^ACKQNQ(2)  Q:RC<0
 . W !," Student            - "_ACKPROV(509850.6,ACKK2,"7","E")
 W !
 Q
 ;
CPTDIS ;  Get procedures already filed and display
 ;
 D ENS^%ZISS
 N D0,ACKKEY,ACKCPTDS,ACKK3,ACKPIEN,ACKTMOD,ACKCODE,ACKPROC,ACKPRV
 D LIST^DIC(509850.61,","_ACKVIEN_",",".01;.03;.05","I","*","","","","","","ACKCPTDS")
 I '$D(ACKCPTDS("DILIST",1)) Q
 W !!," ",IOUON,"Procedures currently entered for this visit",IOUOFF,!
 S ACKK3=""
 F  S ACKK3=$O(ACKCPTDS("DILIST",1,ACKK3)) Q:ACKK3=""  D
 . S ACKPROC=ACKCPTDS("DILIST",1,ACKK3)
 . S ACKPRV=ACKCPTDS("DILIST","ID",ACKK3,.05)
 . I ACKPRV'="" S ACKPRV=$$CONVERT(ACKPRV)
 . W !," Code: ",$$GET1^DIQ(509850.4,ACKPROC_",",.01),?19,"Volume: ",ACKCPTDS("DILIST","ID",ACKK3,.03) I ACKPRV'="" W "   Provider : ",ACKPRV
 . D LONG^ACKQUTL6(ACKPROC,"1")
 . W !
 . ;  Check if any Modifiers present for this Procedure
 . S ACKPIEN="" I $D(ACKCODE(ACKPROC)) S ACKPIEN=$O(ACKCODE(ACKPROC,""),-1)
 . S ACKPIEN=$O(^ACK(509850.6,ACKVIEN,3,"B",ACKPROC,ACKPIEN))
 . I ACKPIEN="" W ! Q
 . S ACKCODE(ACKPROC,ACKPIEN)=""
 . ;  Modifier level present do a LIST to get them
 . S ACKPIEN=ACKPIEN_","_ACKVIEN
 . D LIST^DIC(509850.64,","_ACKPIEN_",",".01","I","*","","","","","","ACKTMOD")
 . I $D(ACKTMOD("DILIST",1)) D
 . . W "        Modifiers:"
 . . ;  Loop through Modifier Array
 . . S ACKKEY=""
 . . F  S ACKKEY=$O(ACKTMOD("DILIST",1,ACKKEY)) Q:ACKKEY=""  D
 . . . W ?19,$$MODTXT^ACKQUTL8(ACKTMOD("DILIST",1,ACKKEY),ACKVD),!
 . . K ACKTMOD
 W !
 Q
 ;
DIAGDIS ;  Get diagnoses already filed and display
 D ENS^%ZISS
 N ACK1,D0,ACKDIAGD,ACKK3,ACKK4,ACKI,ACKD,RC
 D LIST^DIC(509850.63,","_ACKVIEN_",",".01;.12","I","*","","","","","","ACKDIAGD")
 I '$D(ACKDIAGD("DILIST",1)) Q
 S RC=$$PAGE^ACKQNQ(5)  Q:RC<0  W:'RC !!
 W " ",IOUON,"Diagnoses currently entered for this visit:",IOUOFF,!
 S ACKK3="",ACKSP="                                   "
 F  S ACKK3=$O(ACKDIAGD("DILIST",1,ACKK3)) Q:ACKK3=""  D
 . S ACKK4=ACKDIAGD("DILIST",1,ACKK3)
 . S ACKI=$$GET1^DIQ(80,ACKK4,.01)
 . S ACKD($S(ACKI?.NP:+ACKI,1:ACKI))=ACKI_$E("   ",1,7-$L(ACKI))_"- "_$E($$DIAGTXT^ACKQUTL8(ACKK4,ACKVD)_ACKSP,1,35)_$S($G(ACKDIAGD("DILIST","ID",ACKK3,".12"))=1:"  * Primary Diagnosis *",1:"  * Secondary Diagnosis *")
 ;
 S ACK1=""
 F  S ACK1=$O(ACKD(ACK1)) Q:ACK1=""  D
 . S RC=$$PAGE^ACKQNQ(3)  Q:RC<0
 . W:RC IOUON,"Diagnoses currently entered for this visit (cont'd)",IOUOFF,!
 . W !," ",ACKD(ACK1)
 W !
 Q
 ;
 ;
HLOSS ; Sets hearing loss variable if one or more diagnosis are for hearing
 ;  loss
 ;
 N ACKK4,ACKDIAG
 S (ACKLOSS,ACKK4)=0
 F  S ACKK4=$O(^ACK(509850.6,ACKVIEN,1,ACKK4)) Q:ACKK4'?1.N!(ACKLOSS)  D
 .S ACKDIAG=$P(^ACK(509850.6,ACKVIEN,1,ACKK4,0),U,1)
 .I $P(^ACK(509850.1,ACKDIAG,0),U,5)=1 S ACKLOSS=1 Q 
 Q
 ;
MODDIS ;  Display Modifiers - Called within Executable Help of Modiifer
 ;  Enter Edit.
 S ACK1="0"
 F  S ACK1=$O(^ACK(509850.5,ACK1)) Q:'+ACK1  D
 . W !,"  "_$$GET1^DIQ(81.3,ACK1,.01),?5,$$MODTXT^ACKQUTL8(ACK1,""),?53,$$GET1^DIQ(81.3,ACK1,.04)
 W ! Q
 ;
CONVERT(ACKPRV) ; Converts the QSR Prov Code into a name string from file 200.
 ;
 ;ACKQ*3*17
 Q $$GET1^DIQ(509850.3,ACKPRV,.07)
 ;
CONVERT1(ACKPRV) ;  Converts the Provider IEN number used within Quasar
 ;                  to its equivalent code used on the 200 file.
 ;ACKQ*3*17
 Q +$$GET1^DIQ(509850.3,ACKPRV,.07,"I")
 ;
CONVERT2(ACKPRV) ;  Converts the Provider IEN number used within Quasar
 ;                  to its equivalent code used on the 200 file.
 ;ACKQ*3*17
 Q +$$GET1^DIQ(509850.3,ACKPRV,.07,"I")
 ;
