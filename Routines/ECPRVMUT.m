ECPRVMUT ;ALB/JAM - Event Capture Multiple Provider Utilities ;24 Aug 05
 ;;2.0; EVENT CAPTURE ;**72**;8 May 96
 ;
GETPRV(ECIEN,OUTARR) ;Returns providers associated with an encounter
 ;*** This recall replaces GET^ECPRVUTL to allow for multiple providers 
 ;    instead of three.
 ;  Input: ECIEN  - IEN entry in file 721/^ECH(
 ;
 ; Output: OUTARR - output array with providers
 ;                  ^ECH IEN^provider ien^provider description^
 ;                  Primary/Secondary code^Primary/Secondary description
 ;         returns 0 if successful or 1 if unsuccessful
 ;      
 I $G(ECIEN)="" Q 1  ;IEN not define.
 I '$D(^ECH(ECIEN)) Q 1  ;IEN does not exist in file 721/^ECH(
 I $O(^ECH(ECIEN,"PRV",0))="" Q 1  ;No provider on file for entry
 N PRV,IEN,ECERR,SEQ,TYP,TYD,TMPARR,PRI,CNT,PRVARY
 S PRI=0
 D GETS^DIQ(721,ECIEN,"42*","IE","PRVARY","ECERR")
 I $D(ECERR) Q 1  ;Error looking up entry
 S SEQ="" F  S SEQ=$O(PRVARY(721.042,SEQ)) Q:SEQ=""  D
 . S IEN=$G(PRVARY(721.042,SEQ,.01,"I")) I IEN="" Q
 . S PRV=$G(PRVARY(721.042,SEQ,.01,"E")) I PRV="" S PRV="Unknown"
 . S TYP=$G(PRVARY(721.042,SEQ,.02,"I")) I TYP="" S TYP="Ukn"
 . S TYD=$G(PRVARY(721.042,SEQ,.02,"E")) I TYD="" S TYD="Unknown"
 . I 'PRI,TYP="P" S PRI=1_U_$P(SEQ,",")
 . I $P(SEQ,",")'="" S TMPARR($P(SEQ,","))=IEN_U_PRV_U_TYP_U_TYD
 ;set primary provider as first subscript
 S CNT=1,PRI=$S(PRI:$P(PRI,U,2),1:$O(TMPARR(0))),OUTARR(CNT)=TMPARR(PRI)
 K TMPARR(PRI)
 S IEN=0 F  S IEN=$O(TMPARR(IEN)) Q:'IEN  D
 . S CNT=CNT+1,OUTARR(CNT)=TMPARR(IEN)
 Q $S($D(OUTARR):0,1:1)
 ;
GETPPRV(ECIEN,ECPPROV) ;returns primary provider associated with an encounter
 ;  Input: ECIEN  - IEN entry in file 721/^ECH(
 ;
 ; Output: ECPPROV - primary provider
 ;                   provider ien^provider description
 ;         returns 0 if successful or 1 if unsuccessful
 ;      
 I $G(ECIEN)="" Q 1  ;IEN not define.
 I '$D(^ECH(ECIEN)) Q 1  ;IEN does not exist in file 721/^ECH(
 I $O(^ECH(ECIEN,"PRV",0))="" Q 1  ;No provider on file for entry
 N PRVARY,PRV,IEN,ECERR,SEQ,ECOUT,TYP
 S ECOUT=0
 D GETS^DIQ(721,ECIEN,"42*","IE","PRVARY","ECERR")
 I $D(ECERR) Q 1  ;Error looking up entry
 S SEQ="" F  S SEQ=$O(PRVARY(721.042,SEQ)) Q:SEQ=""  D  I ECOUT Q
 . S IEN=$G(PRVARY(721.042,SEQ,.01,"I")) I IEN="" Q
 . S PRV=$G(PRVARY(721.042,SEQ,.01,"E")) I PRV="" S PRV="Unknown"
 . S TYP=$G(PRVARY(721.042,SEQ,.02,"I")) I TYP="" S TYD="Unknown"
 . I TYP="P" S ECPPROV=IEN_U_PRV,ECOUT=1
 Q $S($D(ECPPROV):0,1:1)
 ;
FILPRV(ECIEN,ECPRVARY,ECOUT) ;File multiple providers for an encounter
 ;  Input: ECIEN    - IEN entry in file 721/^ECH(
 ;         ECPRVARY - array with providers
 ;         ECOUT    - Error flag (1/0)
 ;
 ; Output: returns 1 if successful or 0 if unsuccessful
 ;      
 I $G(ECIEN)="" Q 0  ;IEN not define.
 I '$D(^ECH(ECIEN)) Q 0  ;IEN does not exist in file 721/^ECH(
 I '$O(ECPRVARY(0)) Q 0  ;No entry in provider array
 N SIEN,ECERR,ERR,ECPRVDA,ECDATA,DA,DIK
 ;delete old entries
 S DA(1)=ECIEN,DIK="^ECH("_DA(1)_",""PRV"",",DA=0
 F  S DA=$O(^ECH(DA(1),"PRV",DA)) Q:'DA  D ^DIK
 S SIEN=0,ERR=""
 F  S SIEN=$O(ECPRVARY(SIEN)) Q:SIEN=""  D
 .K ECPRVDA,ECERR
 .S ECDATA=ECPRVARY(SIEN)
 .S ECPRVDA(721,"?1,",.01)=ECIEN
 .S ECPRVDA(721.042,"+2,?1,",.01)=$P(ECDATA,U)
 .S ECPRVDA(721.042,"+2,?1,",.02)=$P(ECDATA,U,3)
 .D UPDATE^DIE("","ECPRVDA","","ECERR")
 .I $D(ECERR) S ERR=ERR_SIEN_";"
 Q $S(ERR="":1,1:"0^"_ERR)
 ;
DSPPRV ;Display providers
 N ECX,ECDAT,ECW
 W "Encounter Providers"
 S ECX=0  F  S ECX=$O(ECPRVARY(ECX)) Q:'ECX  D
 .S ECDAT=ECPRVARY(ECX)
 .W !,?3,$P(ECDAT,U),?15,$P(ECDAT,U,2) I $P(ECDAT,U,3)="P" W " (Primary)"
 Q
ASKPRV(ECIEN,ECDT,ECPRVARY,ECOUT) ;ask provider question (primary and multiple secondary)
 ; Variables: ECIEN    - IEN entry in file 721/^ECH(
 ;            ECDT     - date/time of encounter
 ;            ECPRVARY - array with providers
 ;            ECOUT    - Error flag (1/0)
 ;
 ; Output: returns 1 if successful or 0 if unsuccessful
 N ECINF
 K ECPRVARY,ECPRV,ECPRVN
 ;get providers
 I $G(ECIEN)'="" D
 .S ECINF=$$GETPRV(ECIEN,.ECPRVARY)
 .S ECINF=$$GETPPRV(ECIEN,.ECPRVN) I 'ECINF S ECPRV=$P(ECPRVN,U),ECPRVN=$P(ECPRVN,U,2)
 ;display providers
 I $O(ECPRVARY(""))'="" D DSPPRV
 ;ask for primary provider
 D PPRV I $G(ECOUT) Q
 ;ask for secondary provider
 D SPRV
 Q
PPRV ;Ask primary provider
 ;   Variables:   ECPRV   = Primary provider ien
 ;                ECPRVN  = Primary provider descript, default if define
 ;                ECPRVARY= Array with providers
 ;                          subscript=provider IEN, 
 ;                          data=(P)rimary_^_provider description
 ;                ECOUT   = Error flag (1/0)
 ;   
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,ECW,X,Y,IEN
 S ECPRV=$G(ECPRV),ECPRVN=$G(ECPRVN)
 S DIR(0)="P^VA(200,:AEZQM",DIR("A")="Primary Provider"
 S DIR("?")="Enter the provider responsible for providing primary care for this encounter."
 I ECPRV'="" S DIR("B")=$$DICLK^ECPRVUTL(ECPRV)
 ;get provider with active person class
 S DIR("S")="I +$$GET^XUA4A72(+Y,$G(ECDT,DT))>0"
 D ^DIR
 I +Y>0 D  Q
 .;check if provider exist as secondary and remove.
 .S IEN=0
 .F  S IEN=$O(ECPRVARY(IEN)) Q:'IEN  I $P(ECPRVARY(IEN),U,3)'="P" D
 ..I +ECPRVARY(IEN)=+Y D
 ...W !?25,"*** (Provider removed as secondary.) ***" K ECPRVARY(IEN)
 .S ECW=$$CLASS^ECPRVUTL(+Y,$G(ECDT,DT))
 .S ECPRV=+Y,ECPRVN=Y(0,0),ECPRVARY(1)=ECPRV_"^"_Y(0,0)_"^P^PRIMARY"
 S ECOUT=1 Q
 Q
SPRV ;Ask secondary provider(s)
 ;   Variables:   ECPRV   = Primary provider ien, default if define
 ;                ECPRVARY= Array with providers
 ;                          subscript=provider IEN, 
 ;                          data=(S)econdary_^_provider description
 ;
 N Y,X,DEF,DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,CNT,X,Y
 ;create "B" xref and subscript by provider ien in array ECPRVARY
 ;set last provider as default
 S DEF="",IEN=$O(ECPRVARY(""),-1),CNT=+IEN+1 I IEN D
 .I $P(ECPRVARY(IEN),U)'=$G(ECPRV) S DEF=$P(ECPRVARY(IEN),U)
 S IEN=0
 F  S IEN=$O(ECPRVARY(IEN)) Q:'IEN  I $P(ECPRVARY(IEN),U,3)'="P" D
 .S ECPRVARY("B",+ECPRVARY(IEN))=IEN
 S:DEF'="" DIR("B")=$$DICLK^ECPRVUTL(DEF) ;DIR("B")="`"_DEF
 S DIR(0)="PO^VA(200,:AEZQM",DIR("A")="Secondary Provider"
 S DIR("?")="^D PRVHLP^ECPRVMUT"
 ;get providers with active person class
 S DIR("S")="I +$$GET^XUA4A72(+Y,$G(ECDT,DT))>0"
 F  D ^DIR S:$D(DUOUT) ECOUT=1 Q:(X="")!($D(DTOUT))!($D(DUOUT))  D
 .I +Y>0,+Y=$G(ECPRV) W "    Provider already entered as primary." Q
 .I +Y=DEF K DIR("B") S DEF="" Q
 .I X="@",DEF'="" D  Q
 ..I DEF=$G(ECPRV) W "    Provider flag as primary. Can't delete." Q
 ..W "    "_$$GET1^DIQ(200,DEF,.01)_"...deleted"
 ..K ECPRVARY(ECPRVARY("B",DEF)),ECPRVARY("B",DEF),DIR("B")
 .Q:+Y<0  I $D(ECPRVARY("B",+Y)) S DEF=+Y,DIR("B")=$$DICLK^ECPRVUTL(DEF) Q
 .S ECW=$$CLASS^ECPRVUTL(+Y,$G(ECDT,DT))
 .S ECPRVARY("B",+Y)=CNT,ECPRVARY(CNT)=+Y_"^"_Y(0,0)_"^S^SECONDARY"
 .S DEF="",CNT=CNT+1 K DIR("B")
 K ECPRVARY("B")
 Q 
PRVHLP ;Help for Provider Code
 N DIC,PRV,D
 I $D(ECPRVARY) D
 .W !?1,"Provider Already Entered:" S PRV=0
 .F  S PRV=$O(ECPRVARY(PRV)) Q:'PRV  D
 ..W !,?3,$P(ECPRVARY(PRV),U),?15,$P(ECPRVARY(PRV),U,2)
 ..I $P(ECPRVARY(PRV),U,3)="P" W " (Primary)"
 W !?1,"You may enter a new Provider, if you wish.  Enter the secondary Provider"
 W !?1,"for this procedure."
 Q
 ;
COMP(ECUX,ECDTX) ;get provider information, similar to COMP^ECPRVUTL
 ;Input:  ECUX  = IEN in file #200
 ;        ECDTX = Date of encounter
 ;
 ;Output: ECUX  = ien in file #200^name^compress person class info
 ;
 I $G(ECUX)="" Q
 S ECDTX=$G(ECDTX,DT)
 ;build ECUX=ien in file #200^name^person class ien^occupation^specialty^
 ;           subspecialty^etc.
 S ECUX=+ECUX_"^"_$$GET1^DIQ(200,+ECUX,.01)_"^"_$$GET^XUA4A72(+ECUX,ECDTX)
 D COMP^ECPRVUTL(.ECUX,ECDTX)
 Q
DSP1416(ECPRVARY) ;Display providers for data entry options
 N ECI,ECDAT,ECUP,CNT
 S (ECI,CNT)=0 F  S ECI=$O(ECPRVARY(ECI)) Q:'ECI  D
 .S ECDAT=ECPRVARY(ECI),CNT=CNT+1
 .W !,"Provider"_$S(CNT=1:"",1:" #"_CNT)_":",?14,$P(ECDAT,U,2)
 .I +$P(ECDAT,U) S ECUP=+$P(ECDAT,U) D COMP(.ECUP,$G(ECDT,DT)) D
 ..W !?16,$P(ECUP,"^",3)
 Q
DSP1442(ECPRVARY) ;Display providers for data entry options
 N ECI,ECDAT,ECUP,CNT
 S (ECI,CNT)=0  F  S ECI=$O(ECPRVARY(ECI)) Q:'ECI  D
 .S ECDAT=ECPRVARY(ECI),CNT=CNT+1
 .W !,"Provider"_$S(CNT=1:"",1:" #"_CNT)_":",?14,$E($P(ECDAT,U,2),1,24)
 .I +$P(ECDAT,U) S ECUP=+$P(ECDAT,U) D COMP^ECPRVMUT(.ECUP,$G(ECDT,DT)) D
 ..W ?42,$E($P(ECUP,U,3),1,36)
 Q
DSP1444(ECPRVARY) ;Display providers for data entry options
 N ECI,ECDAT,ECUP,CNT
 S (ECI,CNT)=0  F  S ECI=$O(ECPRVARY(ECI)) Q:'ECI  D
 .S ECDAT=ECPRVARY(ECI),CNT=CNT+1
 .W !,"Provider"_$S(CNT=1:"",1:" #"_CNT)_":",?14,$E($P(ECDAT,U,2),1,24)
 .I +$P(ECDAT,U) S ECUP=+$P(ECDAT,U) D COMP^ECPRVMUT(.ECUP,$G(ECDT,DT)) D
 ..W ?44,$E($P(ECUP,U,3),1,34)
 Q
