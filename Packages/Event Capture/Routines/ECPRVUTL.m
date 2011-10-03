ECPRVUTL ;ALB/JAP - Provider Selection with Person Class ;7 Aug 97
 ;;2.0; EVENT CAPTURE ;**5**;8 May 96
 ;
PROV(ECDT,ECPROVS) ;get providers - new providers function
 ;
 ;this function is duplicated in PROV^ECMUTL
 ;
 ;select provider(s) with active person class
 ;no updating of file #721 record is done here
 ;
 ;   input
 ;   ECDT    = date/time of procedure (required)
 ;   ECPROVS = local array, passed by reference (required)
 ;    
 ;   output
 ;   ECU(1)  = provider #1 (mandatory) ien^provider #1 name^person class
 ;   ECU(2)  = provider #2 (optional) ien^provider #2 name^person class
 ;   ECU(3)  = provider #3 (optional) ien^provider #3 name^person class
 ;
 ;   returns
 ;       0 ==> provider selection successful; at least
 ;             provider #1 selected.
 ;       1 ==> selection unsuccessful or user timed-out
 ;       2 ==> selection unsuccessful or user entered "^"
 ;
 N ECU,ECU2,ECU3,ECDA
 D GET("",ECDT,.ECU,.ECU2,.ECU3,.ECOUT)
 S ECPROVS(1)=ECU,ECPROVS(2)=ECU2,ECPROVS(3)=ECU3
 Q ECOUT
 ;
GET(ECDA,ECDT,ECU,ECU2,ECU3,ECOUT) ;get providers with person class
 ;
 ;select provider(s) with active person class
 ;no updating of file #721 record is done here
 ;
 ;   input
 ;   ECDA = ien of pertinent record in file #721 (required)
 ;          but may be null
 ;   ECDT = date/time of procedure (required)
 ;          internal FM format;
 ;          if null defaults to DT
 ;   (ECU,ECU2,ECU3) = any (required; pass by reference);
 ;                     will be reset
 ;   ECOUT = (required; pass by reference)
 ;
 ;   output
 ;   ECU   = provider #1 ien in file #200^provider name^person class OR
 ;           provider #1 ien in file #200^provider name^null OR
 ;           null^null^null (if provider not determined)
 ;           (provider #1 cannot be deleted; required field)
 ;   ECU2  = provider #2 ien in file #200^provider name^person class  OR
 ;           provider #1 ien in file #200^provider name^null OR
 ;           null^null^null (if provider not determined) OR
 ;           @^null^null (if provider deleted)
 ;   ECU3  = (same format as provider #2)
 ;   ECOUT = 0 if selection successful  OR
 ;           1 if user times out; selection unsuccessful
 ;           2 if user up-arrows out; selection unsuccessful
 ;
 ;   Note: If user up-arrows out or times out, then
 ;         ECU,ECU2,ECU3 set back to value at entry.
 ;
 N ECUTN,DA,DIR,DIRUT,DTOUT,DUOUT,X,Y,ECDATA,ECUN,ECUN2,ECUN3,ECUC,ECUC2,ECUC3,OLDP
 S ECOUT=0,(ECU,ECU2,ECU3)="",(ECUN,ECUN2,ECUN3)="",(ECUC,ECUC2,ECUC3)="",ECDATA="" F JJ=1:1:3 S OLDP(JJ)="^^"
 ;if using an existing record in file #721, pick-up some basic data
 I +ECDA>0 D
 .S DA=ECDA,ECDATA=$G(^ECH(ECDA,0)),ECDT=$P(ECDATA,"^",3)
 .S ECU=$P(ECDATA,"^",11),ECU2=$P(ECDATA,"^",15),ECU3=$P(ECDATA,"^",17)
 .S $P(OLDP(1),"^")=ECU,$P(OLDP(2),"^")=ECU2,$P(OLDP(3),"^")=ECU3
 I ECDT="" S ECDT=DT
 ;allow user to select new or update existing provider(s)
 D PV
 I +ECOUT D  Q
 .S ECU=OLDP(1)
 .S ECU2=OLDP(2)
 .S ECU3=OLDP(3)
 I '+ECOUT D
 .S ECU=ECU_"^"_ECUN_"^"_ECUC
 .S ECU2=ECU2_"^"_ECUN2_"^"_ECUC2
 .S ECU3=ECU3_"^"_ECUN3_"^"_ECUC3
 ;make sure no duplicates exist
 I +ECU D
 .I +ECU=+ECU2 S ECU2="@^^"
 .I +ECU=+ECU3 S ECU3="@^^"
 I +ECU2 D
 .I +ECU2=+ECU3 S ECU3="@^^"
 ;if an existing 2nd provider is deleted, fill-in using 3rd provider
 I $E(ECU2,1)="@",+ECU3 S ECU2=ECU3,ECU3="@^^"
 ;make sure info is complete for each provider
 I +ECU>0 D COMP(.ECU,ECDT)
 I +ECU2>0 D COMP(.ECU2,ECDT)
 I +ECU3>0 D COMP(.ECU3,ECDT)
 Q
 ;
 ;if ecu,ecu2,ecu3 are already defined (i.e., not null), then y(0),y(0,0) won't be
 ;returned from DIR call;
PV ;1st provider - required
 ;if 1st provider exists, it can't be deleted; but may be over-written
 K Y,DIR S DIR(0)="721,10",DIR("A")="Provider" D ^DIR K DIR I Y D
 .S ECUN=$G(Y(0,0)) I ECUN="" S ECUN=$$DICLK(ECU)
 .S ECUC=$$CLASS(+Y,ECDT)
 S:$D(DTOUT) ECOUT=1 S:$D(DUOUT) ECOUT=2
 Q:$G(ECOUT)
 I +$G(ECUC)<0 S ECUC="" G PV
 S ECU=+Y
 ;
PV2 ;2nd provider - optional
 ;if 2nd provider exists, it may be deleted or over-written
 K Y,DIR S DIR(0)="721,15",DIR("A")="Provider #2" D ^DIR K DIR I Y D
 .Q:+Y=+ECU
 .S ECUN2=$G(Y(0,0)) I ECUN2="" S ECUN2=$$DICLK(ECU2)
 .S ECUC2=$$CLASS(+Y,ECDT)
 S:$D(DTOUT) ECOUT=1 S:$D(DUOUT) ECOUT=2
 Q:$G(ECOUT)
 I 'Y,X="@",+ECU2 S ECU2="@",ECUN2="" W !,?5,"Provider #2 will be deleted..." I +ECU3 G PV3
 Q:ECU2="@"
 I +Y=+ECU W $C(7),!!,?15,"But that's Provider #1... Try again.",! G PV2
 I +$G(ECUC2)<0 S ECUC2="" G PV2
 S ECU2=$S(+Y>0:+Y,1:"")
 Q:ECU2=""
 ;
PV3 ;3rd provider - optional
 ;if 3rd provider exists, it may be deleted or over-written
 K Y,DIR S DIR(0)="721,17",DIR("A")="Provider #3" D ^DIR K DIR I Y D
 .Q:+Y=+ECU  Q:+Y=+ECU2
 .S ECUN3=$G(Y(0,0)) I ECUN3="" S ECUN3=$$DICLK(ECU3)
 .S ECUC3=$$CLASS(+Y,ECDT)
 S:$D(DTOUT) ECOUT=1 S:$D(DUOUT) ECOUT=2
 Q:$G(ECOUT)
 I 'Y,X="@",+ECU3 S ECU3="@",ECUN3="" W !,?5,"Provider #3 will be deleted..."
 Q:ECU3="@"
 I +Y=+ECU W $C(7),!!,?15,"But that's Provider #1... Try again.",! G PV3
 I +Y=+ECU2 W $C(7),!!,?15,"But that's Provider #2... Try again.",! G PV3
 I +$G(ECUC3)<0 S ECUC3="" G PV3
 S ECU3=$S(+Y>0:+Y,1:"")
 Q
 ;
CLASS(ECUX,ECDTX) ;get person class - display
 ;   input
 ;   ECUX=ien in file #200 (required)
 ;   ECDTX=date/time of procedure (required)
 ;   output
 ;   ECUTN= -1 if no person class
 ;          or
 ;          -2 if no active person class
 ;          or
 ;          ien in file #8932.1^occupation^specialty^subspecialty^effective date^expiration date^va code
 N ECUTN,ECDATE,Y
 S Y=ECDTX D DD^%DT S ECDATE=Y
 S ECUTN=$$GET^XUA4A72(ECUX,ECDTX)
 I +ECUTN>0 D
 .W !?5,"Occupation:   ",$P(ECUTN,"^",2)
 .I $P(ECUTN,"^",3)]"" W !?5,"Specialty:    ",$P(ECUTN,"^",3)
 .I $P(ECUTN,"^",4)]"" W !?5,"Subspecialty: ",$P(ECUTN,"^",4)
 .W !
 E  D CMSG
 Q ECUTN
 ;
CMSG ;inactive person class msgs
 I +ECUTN=-1 D
 .W !!?10,"Only Providers with an active Person Class may"
 .W !?10,"be selected."
 I +ECUTN=-2 D
 .W !!?10,"This Provider does not have an active Person Class"
 .W !?10,"for the date of "_$P(ECDATE,"@",1)_"."
 W !!?10,"Please check your provider selection and try again.",!
 Q
 ;
DICLK(ECUX)   ;use DIC lookup if editing existing provider in file #721
 ;   input
 ;   ECUX=ien in file #200 (required)
 ;   output
 ;   Y(0,0); i.e., name
 N DIC,X
 S X=ECUX,DIC="^VA(200,",DIC(0)="NZ"
 D ^DIC
 Q $G(Y(0,0))
 ;
COMP(ECUX,ECDTX) ;check & complete the provider return variables
 ;or get user/provider name and person class info
 ;   input
 ;   ECUX=ien in file #200^name^person class ien^occupation^specialty^subspecialty^etc.
 ;        (required) 
 ;        but pieces 3,4,5 may be null;
 ;        passed by reference
 ;   ECDTX=pertinent date; internal FM format (required)
 ;         but may be null
 ;   output
 ;   ECUX=ien in file #200^name^compress person class info
 N ECSPEC,E1,E2,E3,ECUTN,X,Y
 ;get provider name, if not there;
 I '$G(ECDTX) S ECDTX=""
 I $P(ECUX,"^",2)="" D
 .S $P(ECUX,"^",2)=$$DICLK(+ECUX)
 .S ECUTN=$$GET^XUA4A72(+ECUX,ECDTX) I +ECUTN<0 S ECUTN=""
 .S $P(ECUX,"^",3)=ECUTN
 ;compress the person class information into 1 piece
 ;if specialty and subspecialty are defined, use that;
 ;otherwise use occupation plus specialty (if defined)
 I +$P(ECUX,"^",3)=0 S ECUX=$P(ECUX,"^",1,2)_"^"_"(Person Class undefined.)" Q
 S E1=$P(ECUX,"^",4),E2=$P(ECUX,"^",5),E3=$P(ECUX,"^",6)
 I $L(E3)>0 D
 .S ECSPEC=$E(E2,1,18)_"/"_$E(E3,1,40)
 .S ECUX=$P(ECUX,"^",1,2)_"^"_ECSPEC
 E  D
 .I $L(E2)>0 S ECSPEC=$E(E1,1,18)_"/"_$E(E2,1,40)
 .I $L(E2)=0 S ECSPEC=E1
 .S ECUX=$P(ECUX,"^",1,2)_"^"_ECSPEC
 Q
