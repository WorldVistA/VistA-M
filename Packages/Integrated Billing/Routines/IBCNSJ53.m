IBCNSJ53 ;AITC/DTG - INSURANCE PLAN MAINTENANCE ACTION VIEW SUBSCRIBER ; 15-MAY-2023
 ;;2.0;INTEGRATED BILLING;**763,771,778,804**;21-MAR-94;Build 6
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;
VP ; -- Edit/View Plan  (VS entry point)
 D FULL^VALM1
 D EN^VALM("IBCNSC PLAN VIEW SUBSCRIBERS")
 S VALMBCK="R",VALMBG=1
 Q
 ;
VSUBS ; entry from list template protocol 'IBCNSJ PLAN VIEW SUBSCRIBERS' from the 'IBCNSC PLAN DETAIL' menu
 ;
 N DIR,FIEN,FTF,FTFV,IBA,IBB,IBC,IBD,IBDOB,IBDTCK,IBE,IBEFFDT,IBERR,IBEXPDT,IBF
 N IBIND,IBINS0,IBNAM,IBPTDFN,IBPTHOLD,IBPTINS,NUM
 N ST,X,XX,X0,X11,Y,Z
 ; clear working array
 S IBTMP="^TMP(""IBCNSJ53I"",$J)"
 K @IBTMP
 S (IBCST,IBACCT,IBINACCT,LENEP,LENPT)=0
 ;set insurance CO. info
 ;
 S X0=$G(^DIC(36,IB36,0))
 S X11=$G(^DIC(36,IB36,.11))
 S Z=$P(X11,"^",6)
 S ST=$S($P(X11,"^",5):$P($G(^DIC(5,$P(X11,"^",5),0)),"^",2),1:"")
 S XX=$S($P(X0,"^",5):"*",1:"")
 S X=XX_$E($P(X0,"^",1),1,30)
 S $P(X,"^",2)=$P(X11,"^",1)
 S $P(X,"^",3)=$P(X11,"^",4) S:$P(X,U,3)'="" $P(X,U,3)=$P(X,U,3)_","
 S $P(X,"^",4)=$G(ST)
 S $P(X,"^",5)=$E(Z,1,5)
 S $P(X,"^",6)=""
 S $P(X,U,7)=$P(X,U,3)_" "_$P(X,U,4)_" "_$P(X,U,5)
 ; Insurance Company name (first 30 chars) with leading '*' if inactive ^ Street Address Line 1
 ; ^ City ^ ST ^ ZIP ^
 S @IBTMP@(1)=X
 ;set plan info
 ;            A1 - Group Plan Number (leading '*' if Inactive)
 ;            A2 - Group Plan Name   (leading '+' if Individual)
 ;            A3 - 
 ;            A4 - Electronic Plan Type (max length 26)
 ;            A5 - Type of Plan (max length 34)
 ;
 N IBFL1,IBFL2,NAME,NUM,XX,ZZ
 S NUM=$$GET1^DIQ(355.3,IB3553,2.02)
 S:NUM="" NUM="<NO GROUP NUMBER>"
 S XX=$$GET1^DIQ(355.3,IB3553,.02,"I")     ; Group or Individual Plan
 S IBFL1=$S(XX=1:"",1:"+")
 S ZZ=$$GET1^DIQ(355.3,IB3553,.11,"I")     ; Inactive Flag
 S IBFL2=$S(ZZ=1:"*",1:"")
 S $P(XX,"^",1)=IBFL2_NUM                     ; Add Inactive/Individual flags
 S NAME=$$GET1^DIQ(355.3,IB3553,2.01)
 S:NAME="" NAME="<NO GROUP NAME>"
 S $P(XX,"^",2)=IBFL1_NAME                       ; Group Name
 S $P(XX,"^",3)=""
 S ZZ=$$GET1^DIQ(355.3,IB3553_",",.15)       ; Electronic Plan Type
 S:$L(ZZ)>$G(LENEP) LENEP=$L(ZZ)               ; Maximum Electronic Plan length
 S $P(XX,"^",4)=ZZ
 S ZZ=$$GET1^DIQ(355.3,IB3553_",",.09)       ; Type of Plan
 S:$L(ZZ)>34 ZZ=$E(ZZ,1,34)
 S:$L(ZZ)>$G(LENEP) LENEP=$L(ZZ)               ; Maximum Plan Type length
 S $P(XX,"^",5)=ZZ
 ; plan info
 S @IBTMP@(2)=XX
 S IBINS0=$G(^IBA(355.3,+IB3553,0))
 ; get plan subscribers
 ;IB*804/DTG add sort to view subscribers
 ;F IBA=3,4,5 K @IBTMP@(IBA)
 F IBA=3,4,5,9,10,11 K @IBTMP@(IBA)
 ;
 S IBPTDFN=0
 F  S IBPTDFN=$O(^DPT("AB",IB36,IBPTDFN)) Q:'IBPTDFN  S IBPTINS=0 D
 .F  S IBPTINS=$O(^DPT("AB",IB36,IBPTDFN,IBPTINS)) Q:'IBPTINS  D
 ..S IBA=$$GET1^DIQ(2.312,IBPTINS_","_IBPTDFN_",",.18,"I") I IBA=IB3553 D
 ...S IBIND=$$ZND^IBCNS1(IBPTDFN,IBPTINS)
 ...S IBCST=IBCST+1
 ...S X=$$PT^IBEFUNC(IBPTDFN)
 ...S IBNAM=$E($P(X,"^",1),1,22)               ; Patient's Name (22 chars)
 ...S:IBNAM="" IBNAM="<Pt. "_IBPTDFN_" Name Missing>"
 ...S IBPTHOLD=IBNAM
 ...; Retrieve last 4 of SSN (last 5 if pseudo SSN)
 ...S XX=$$GET1^DIQ(2,IBPTDFN_",",.09,"I")         ; Patient's SSN
 ...S XX=$S($E(XX,$L(XX))="P":$E(XX,$L(XX)-4,$L(XX)),1:$E(XX,$L(XX)-3,$L(XX)))
 ...S $P(IBPTHOLD,"^",2)=XX
 ...S IBDOB=$$GET1^DIQ(2,IBPTDFN_",",.03,"I"),XX=$$DTC(IBDOB)         ; Patient's DOB
 ...S $P(IBPTHOLD,"^",3)=XX
 ...S XX=$$DTC5(IBDOB),$P(IBPTHOLD,"^",12)=XX  ;IB*804/DTG add in the 5 digit date for sort
 ...S XX=$P(IBIND,"^",2),XX=$S(XX'="":XX,1:"<NO SUBS ID>")
 ...S $P(IBPTHOLD,"^",4)=XX                         ; Subscriber ID (20 chars max)
 ...S IBEFFDT=$P(IBIND,"^",8),XX=$$DTC(IBEFFDT)   ; Effective Date
 ...S $P(IBPTHOLD,"^",5)=XX
 ...S XX=$$DTC5(IBEFFDT),$P(IBPTHOLD,"^",13)=XX  ;IB*804/DTG add in the 5 digit date for sort
 ...S IBEXPDT=$P(IBIND,"^",4),XX=$$DTC(IBEXPDT)   ; Expiration Date
 ...S $P(IBPTHOLD,"^",6)=XX
 ...S XX=$$DTC5(IBEXPDT),$P(IBPTHOLD,"^",14)=XX  ;IB*804/DTG add in the 5 digit date for sort
 ...; Whose Insurance?
 ...S XX=$P(IBIND,"^",6),XX=$S(XX="v":"VET",XX="s":"SPO",XX="o":"OTH",1:"UNK")
 ...S $P(IBPTHOLD,"^",7)=XX
 ...S XX=$$GET1^DIQ(2.312,IBPTINS_","_IBPTDFN_",",5.01,"I")  ; Patient ID
 ...S $P(IBPTHOLD,"^",8)=XX
 ...; IB*778/DTG removed code for unused variable LENPID
 ...;active or inactive
 ...S (IBACT,IBINACT)=0 D  S $P(IBPTHOLD,U,9)=IBACT,$P(IBPTHOLD,U,10)=IBINACT
 ....;
 ....I 'IBEFFDT!($P(IBPTHOLD,U,5)="") S IBINACT=1 Q  ; if not a valid effective date count inactive
 ....;
 ....I (IBEXPDT'=""&($P(IBPTHOLD,U,6)'="")) D  Q  ; if there is a valid expiration date
 .....;
 .....I IBEXPDT<DT S IBINACT=1 Q  ; if the expiration date is less than today count inactive
 .....;
 .....S IBACT=1  ; otherwise count active
 ....;
 ....I (IBEFFDT&($P(IBPTHOLD,U,5)'="")&(IBEFFDT>DT)) S IBINACT=1 Q  ; if a valid effective date and the date is greater than today count inactive
 ....;
 ....S IBACT=1  ; otherwise count active
 ....;
 ...S IBACCT=IBACCT+IBACT,IBINACCT=IBINACCT+IBINACT
 ...;
 ...;end active or inactive
 ...;
 ...; 3=ALL, 4=ACTIVE, 5=INACTIVE
 ...; Patient's Name (22 chars) ^ Patient's SSN ^ Patient's DOB ^ Subscriber ID (20 chars max)
 ...; ^ Effective Date ^ Expiration Date ^ Whose Insurance? ^ Patient ID ^ ACTIVE ^ INACTIVE ^^ 4 digit DOB year
 ...; ^ 4 digit eff dt year ^ 4 digit exp dt year 
 ...; IB*804/DTG add sort to view subscribers
 ...;S @IBTMP@(3,IB3553,IBNAM_"@@"_IBPTDFN_"@@"_IBPTINS)=IBPTHOLD
 ...;S @IBTMP@(($S(IBACT=1:4,1:5)),IB3553,IBNAM_"@@"_IBPTDFN_"@@"_IBPTINS)=IBPTHOLD
 ...S @IBTMP@(9,IB3553,IBNAM_"@@"_IBPTDFN_"@@"_IBPTINS)=IBPTHOLD
 ...S @IBTMP@(($S(IBACT=1:10,1:11)),IB3553,IBNAM_"@@"_IBPTDFN_"@@"_IBPTINS)=IBPTHOLD
 ...; total ^ active ^ inactive
 ...S @IBTMP@(0)=+IBCST_U_+IBACCT_U_+IBINACCT
 ;
 ;IB*804/DTG add sort to view subscribers
 ; base set of values
 D IBASE
 ;
VSUBX ; quit back
 ;
 Q
DTC(IBDTCK) ; check date return external if valid
 ;
 N IBDT,IBBK S IBDT=""
 I 'IBDTCK G DTCO
 S IBDT=$$FMTE^XLFDT(IBDTCK,"2DZ")
 ;
 G DTCO
 ;
DTCO ; date check exit
 ;
 Q IBDT
 ;
DTC5(IBDTCK) ; check date return external if valid ;IB*804/DTG 4 digit year for sort's
 ;
 N IBDT,IBBK S IBDT=""
 I 'IBDTCK G DTCO
 S IBDT=$$FMTE^XLFDT(IBDTCK,"5DZ")
 ;
 G DTC5O
 ;
DTC5O ; date check exit
 ;
 Q IBDT
 ;
EXIT ; -- exit code
 K VALMBCK,^TMP("IBCNSJ53",$J),^TMP("IBCNSJ53I",$J),IBVPCLBG,IBVPCLEN
 D CLEAN^VALM10,CLEAR^VALM1
 S VALMBCK="R",VALMBG=1
 Q
 ;
HELP ; -- help code
 ;
 I $G(VALMANS)="??" S X="?" D DISP^XQORM1 W !! Q
 D FULL^VALM1
 N DIR,X,Y
 W !
 W !," Enter AC to only see active subscribers."
 W !," Enter IN to only see inactive subscribers."
 ; IB*804/DTG add sort to view subscribers
 ;W !," Enter VA to see all subscribers.",!
 W !," Enter VA to see all subscribers."
 W !," Enter ST to sort the subscriber records",!
 S DIR(0)="E",DIR("A")="Press <Enter> to return to View Subscribers"
 D ^DIR
 K DIR,X,Y
 S VALMBCK="R"
 Q
 ;
INIT ; -- Load the plan detail segments
 ;
 K ^TMP("IBCNSJ53",$J)
 S VALMBG=1,(IBLCNT,VALMCNT)=0
 S IB36=+$G(IBCNS),IB3553=+$G(IBCPOL)
 S IBTMP="^TMP(""IBCNSJ53I"",$J)",(IBCST,IBACCT,IBINACCT,LENEP,LENPT)=0
 S (IBOSRT,IBSORTA)=0,IBSACT=3  ;IB*804/DTG add sort to view subscribers. default sort type is all
 K @IBTMP
 D NOW^%DTC
 S IBHDT=$$DAT2^IBOUTL($E(%,1,12))
 S IBSPACE="",$P(IBSPACE," ",80)=""
 I IB36<1!(IB3553<1) D  Q
 . W !!,*7,"Missing Insurance or Plan IEN."
 ;
 D KILL^VALM10()
 ;
 D VSUBS
 ;
 D BVA
 S VALMBCK="R",VALMBG=1
 Q
 ;
ACINI ; active subscribers
 ;
 S IBSORTA="",IBSACT=4 D IBASE  ; IB*804/DTG VS sort
 D FULL^VALM1
 D HDR("Active")
 D AC
 S VALMBCK="R",VALMBG=1
 Q
 ;
ININI ; inactive subscribers
 ;
 S IBSORTA="",IBSACT=5 D IBASE  ; IB*804/DTG VS sort
 D FULL^VALM1
 D HDR("Inactive")
 D IS
 S VALMBCK="R",VALMBG=1
 Q
 ;
ALLINI ; all subscribers
 ;
 S IBSORTA="",IBSACT=3 D IBASE  ; IB*804/DTG VS sort
 D FULL^VALM1
 D HDR("All")
 D BVA
 S VALMBCK="R",VALMBG=1
 Q
 ;
HDR(IBDIS) ; -- Plan Subscribers
 ;
 N IBA,IBB,IBC,IBD,IBE,IBF1,IBF2,IBL,IB1,IB2,IB3
 S (IB1,IB2,IB3)=""
 S IBA=$G(^TMP("IBCNSJ53I",$J,1)),IBB=$G(^TMP("IBCNSJ53I",$J,2)),IBC=$G(^TMP("IBCNSJ53I",$J,0))
 S IBF2=$E($P(IBB,U,2))
 S IBF1=$E($P(IBB,U,1))
 S IBDIS=$G(IBDIS),IBDIS=$S(IBDIS'="":IBDIS,1:"All")
 S VALM("TITLE")=IBDIS_" Subscribers"
 ;
 S IB1=$E($P(IBA,U,1),1,30) ; ins co name
 ; IB*804/DTG include sorts in view subscriber
 N IB5,IBLA S (IB5,IBLA)=""
 I '$G(IBSORTA) S IB5="Sort by: NAME"  ;IB*804/DTG added in for sort type if none chosen
 I $G(IBSORTA) S IB5="Sort by: "_$S(IBSORTA=1:"NAME",IBSORTA=2:"DOB",IBSORTA=3:"EFF DATE",IBSORTA=4:"EXP DATE",1:"")
 ;S IBL=(30-$L(IB1))+30,IB2=$E(IBSPACE,1,IBL)
 S IBL=(35-$L(IB1)),IBLA=(25-$L(IB5)),IB2=$E(IBSPACE,1,IBL)_IB5_$E(IBSPACE,1,IBLA)
 ;
 S IB3="TOTAL SUB: "_($E(IBSPACE,1,(8-($L(+$P(IBC,U,1))))))_(+$P(IBC,U,1))
 S VALMHDR(1)=IB1_IB2_IB3
 ;
 S IB1=$E($P(IBA,U,2),1,35)  ; ins addr
 S IBE=$E($P(IBB,U,2),1,(21+($S(IBF2="+":1,1:0))))
 S IBL=(35-$L(IB1))+(1+($S(IBF2="+":0,1:1)))
 S IB2=$E(IBSPACE,1,IBL)_IBE ; group name
 S IBL=(($S(IBF2="+":22,1:21))-$L(IBE))+1
 S IB3=$E(IBSPACE,1,IBL)_"ACTIVE SUB: "_($E(IBSPACE,1,(8-($L(+$P(IBC,U,2))))))_(+$P(IBC,U,2))
 S VALMHDR(2)=IB1_IB2_IB3
 ;
 S IB1=$E($P(IBA,U,7),1,35)  ; city, state zip
 S IBE=$E($P(IBB,U,1),1,(19+($S(IBF1="*":1,1:0))))
 S IBL=(35-($L(IB1))+(1+($S(IBF1="*":0,1:1))))
 S IB2=$E(IBSPACE,1,IBL)_IBE  ; group number
 S IBL=(($S(IBF1="*":20,1:19))-$L(IBE))+1
 S IB3=$E(IBSPACE,1,IBL)_"INACTIVE SUB: "_($E(IBSPACE,1,(8-($L(+$P(IBC,U,3))))))_(+$P(IBC,U,3))
 S VALMHDR(3)=IB1_IB2_IB3
 ;
 Q
 ;
BVA ; Build ALL subscribers
 ;
 N IBLINE,IBTMP1,IBF
 ;IB*804/DTG chage array for sort
 ;S IBTMP1="^TMP(""IBCNSJ53I"",$J,3,"_IB3553_")"
 S IBTMP1="^TMP(""IBCNSJ53I"",$J,3)"
 S VALMCNT=0,VALMBG=1,IBLINE=0
 K @VALMAR
 S IBF=$G(^TMP("IBCNSJ53I",$J,0))
 I '+IBF D  Q  ; IB*771/DTG put none found back in display
 . S VALMCNT=2,@VALMAR@(1,0)=" "
 . S @VALMAR@(2,0)=" ***Group Contains No Subscribers***"
 ; go through the 3 level
 D BPAS
 Q
 ;
BPAS ; build items from base into valm display
 ;
 N IBA,IBB,IBC,IBD,IBE,IBNM,IBDFN,IBNODE,X
 ;S IBA="",X="" F  S IBA=$O(@IBTMP1@(IBA)) Q:IBA=""  D
 ; IB*804/DTG include sorts in view subscriber Change from a single dot '.' level to three dot '.' levels
 ;S IBA="",X="" F  S IBA=$O(@IBTMP1@(IBA)) Q:IBA=""  D
 N IBCNTR,IBG
 S IBCNTR="" F  S IBCNTR=$O(@IBTMP1@(IBCNTR)) Q:IBCNTR=""  S IBG="" D
 . F  S IBG=$O(@IBTMP1@(IBCNTR,IBG)) Q:IBG=""  S IBA="",X="" D
 .. F  S IBA=$O(@IBTMP1@(IBCNTR,IBG,IBA)) Q:IBA=""  D
 ... S IBNM=$P(IBA,"@@",1),IBDFN=$P(IBA,"@@",2),IBNODE=$P(IBA,"@@",3)
 ... S VALMCNT=VALMCNT+1,IBC=@IBTMP1@(IBCNTR,IBG,IBA),X="",IBLINE=IBLINE+1
 ... S X=$$SETFLD^VALM1($P(IBC,"^",1),X,"SNAME")
 ... S X=$$SETFLD^VALM1($P(IBC,"^",2),X,"SSN4")
 ... S X=$$SETFLD^VALM1($P(IBC,U,3),X,"DOB10")
 ... S X=$$SETFLD^VALM1($P(IBC,"^",4),X,"SUBID")
 ... S X=$$SETFLD^VALM1($P(IBC,U,5),X,"EFFDT")
 ... S X=$$SETFLD^VALM1($P(IBC,U,6),X,"EXPDT")
 ... S X=$$SETFLD^VALM1($P(IBC,"^",7),X,"WHO")
 ... S X=$$SETFLD^VALM1($P(IBC,"^",8),X,"PATID")
 ... S IBD=$P(IBC,U,9),X=$$SETFLD^VALM1($S(IBD=1:"Y",1:""),X,"ACT")
 ... S @VALMAR@(VALMCNT,0)=X
 Q
 ;
AC ; active subscriber entry
 ;
 N IBLINE,IBTMP1,IBF
 ;IB*804/DTG chage array for sort
 ;S IBTMP1="^TMP(""IBCNSJ53I"",$J,4,"_IB3553_")"
 S IBTMP1="^TMP(""IBCNSJ53I"",$J,4)"
 S VALMCNT=0,VALMBG=1,IBLINE=0
 K @VALMAR
 S IBF=$G(^TMP("IBCNSJ53I",$J,0))
 I '+$P(IBF,U,2) D  Q
 . S VALMCNT=2,@VALMAR@(1,0)=" "
 . S @VALMAR@(2,0)=" ***Group Contains No Active Subscribers***"
 ; go through the 4 level
 D BPAS
 Q
 ;
IS ; inactive subscriber entry
 ;
 N IBLINE,IBTMP1,IBF
 ;IB*804/DTG chage array for sort
 ;S IBTMP1="^TMP(""IBCNSJ53I"",$J,5,"_IB3553_")"
 S IBTMP1="^TMP(""IBCNSJ53I"",$J,5)"
 S VALMCNT=0,VALMBG=1,IBLINE=0
 K @VALMAR
 S IBF=$G(^TMP("IBCNSJ53I",$J,0))
 I '+$P(IBF,U,3) D  Q
 . S VALMCNT=2,@VALMAR@(1,0)=" "
 . S @VALMAR@(2,0)=" ***Group Contains No Inactive Subscribers***"
 ; go through the 5 level
 D BPAS
 Q
 ;
 ;IB*804/DTG new for sort SORT - IBASE
SORT ; ask sort questions if sort selected then re-build ^TMP("IBCNSJ53I",$J,
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,IBJ,IBQUIT,IBSRF,IBSRNM,IBWORK,X,Y
 S IBQUIT=0
 D FULL^VALM1
 S IBSACT=$G(IBSACT) I IBSACT<3 S IBSACT=3
 S IBOSRT=IBSORTA
 K DIR S DIR(0)="S^1:Subscriber Name;2:Date of Birth;3:Effective Date;4:Expiration Date"
 S DIR("A")="SELECT 1, 2, 3, or 4"
 S DIR("?")="Select a sort method or Enter '^' to quit"
 S DIR("B")=$S(IBOSRT=2:"Date of Birth",IBOSRT=3:"Effective Date",IBOSRT=4:"Expiration Date",1:"Subscriber Name")
 D ^DIR
 I $E(Y)=U!$D(DIROUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT) S Y="^"
 I $E(Y)=U S IBQUIT=1 G SORTQ
 S IBSORTA=+Y I Y<1 S IBQUIT=1 G SORTQ
 I IBSORTA=1 D IBSRTNM G SORTQ
 S IBJ=$S(IBSORTA=2:"Date of Birth",IBSORTA=3:"Effective Date",IBSORTA=4:"Expiration Date",1:"")
 I IBJ="" S IBQUIT=1 G SORTQ
 S Y=$$IBSRQU(IBJ,"",0)
 I $E(Y)=U!(Y="") S IBQUIT=1 G SORTQ
 D IBSRTCOM(IBSORTA,IBWORK) G SORTQ
 ;
SORTQ ; sort exit point
 ;
 I IBQUIT S IBSORTA=IBOSRT I 'IBSORTA D IBASE
 D FULL^VALM1
 ; update header and build output array for SHOW^VALM
 I $G(IBSACT)=3 D HDR("All"),BVA
 I $G(IBSACT)=4 D HDR("Active"),AC
 I $G(IBSACT)=5 D HDR("Inactive"),IS
 S VALMBCK="R",VALMBG=1
 Q
 ;
IBSRTNM ; subscriber name sort type and order
 ;
 N X,Y
 S Y=$$IBSRQU("Subscriber Name","",0)
 I $E(Y)=U!(Y="") S IBQUIT=1 Q
 D IBSRTCOM(IBSORTA,IBWORK)
 Q
 ;
 ;
IBSRQU(IBSRNM,IBSRF,IBSRR) ; get the type
 ;
 ; IBSRNM - sort name
 ;  IBSRF - default response "" =none, 1 =Ascending, 2 =Descending
 ;  IBSRR - required response 0 or "" =no, 1 =yes
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,IBQUIT,X,Y
 K DIR S IBSRF=$G(IBSRF)
 S DIR(0)="S"_($S(+IBSRR:"",1:"O"))_"^1:Ascending "_IBSRNM_";2:Descending "_IBSRNM
 I IBSRF'="" S DIR("B")=IBSRF
 S DIR("A")="SELECT 1 or 2"
 S DIR("?")="Select Ascending or Descending "_IBSRNM_" or Enter '^' to quit"
 D ^DIR
 I Y=""&(IBSRF'="") S Y=IBSRF
 I $E(Y)=U!$D(DIROUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT) S Y="^"
 S IBWORK=""
 S IBWORK=$S(+Y=2:"-1",1:"1")
 Q Y
 ;
IBSRTCOM(IBSORTA,IBWORK) ; go thru the compiled and sort for display
 ;
 ; IBSORTA - Sort Type
 ; IBWORK  - Sort Order
 ;
 ; 3=ALL-9, 4=ACTIVE-10, 5=INACTIVE-11
 ; Patient's Name (22 chars) ^ Patient's SSN ^ Patient's DOB ^ Subscriber ID (20 chars max)
 ; ^ Effective Date ^ Expiration Date ^ Whose Insurance? ^ Patient ID ^ ACTIVE ^ INACTIVE ^^ 4 digit DOB year
 ; ^ 4 digit eff dt year ^ 4 digit exp dt year
 N IBA,IBC,IBD,IBE,IBF,IBI,IBJ,IBK
 I IBSORTA="" Q  ; sort not picked
 ;         1         Subscriber Name
 ;         2         Date of Birth
 ;         3         Effective Date
 ;         4         Expiration Date
 ;
 ; cycle through all, active, inactive
 S IBI=IBSACT K ^TMP("IBCNSJ53I",$J,IBI)
 ; to save time only clear and sort for the current display
 S IBI=(IBSACT+6) K ^TMP("IBCNSJ53I",$J,"TEMP"),^TMP("IBCNSJ53I",$J,"TEMPA")
 S IBA=""  F  S IBA=$O(^TMP("IBCNSJ53I",$J,IBI,IBA)) D:IBA="" IBSRTMV Q:IBA=""  D
 . S IBB="" F  S IBB=$O(^TMP("IBCNSJ53I",$J,IBI,IBA,IBB)) Q:IBB=""  D
 .. S IBC=$G(^TMP("IBCNSJ53I",$J,IBI,IBA,IBB)),(IBD,IBJ)=""
 .. I IBSORTA=1 S IBD=$P(IBC,U,1) S:IBD="" IBD=" " D IBSV Q
 .. I IBSORTA=2!(IBSORTA=3)!(IBSORTA=4) S IBD="",IBK=$S(IBSORTA=2:12,IBSORTA=3:13,IBSORTA=4:14,1:"") D
 ... S:IBK IBD=$P(IBC,U,IBK) S IBJ=""
 ... D DT^DILF(,IBD,.IBJ) S IBD=$G(IBJ) S:IBD="" IBD=" " S:IBD="-1" IBD="  "
 ... I $E(IBD)'=" " D IBSV Q
 ... I $E(IBD)=" " D IBSVA Q
 ;
 K ^TMP("IBCNSJ53I",$J,"TEMP"),^TMP("IBCNSJ53I",$J,"TEMPA")
 Q
 ;
IBSV ; save in selected item order to temp area
 ;
 S ^TMP("IBCNSJ53I",$J,"TEMP",IBD,IBA,IBB)=IBC
 Q
 ;
IBSVA ; save invalid dates in selected item order to temp area
 ;
 S ^TMP("IBCNSJ53I",$J,"TEMP",IBD,IBA,IBB)=IBC
 Q
 ;
IBSRTMV ; move from temp and place in viewing order
 ;
 N IBCT,IBG,IBH,IBK,IBJ
 S IBK=$S(IBWORK="-1":"ZZZZZ",1:""),IBCT=0
 I IBWORK'="-1" D IBSRTA
 F  S IBK=$O(^TMP("IBCNSJ53I",$J,"TEMP",IBK),IBWORK) Q:IBK=""  D
 . I $E(IBK)=" " Q
 . S IBG=$S(IBWORK="-1":"ZZZZZ",1:"")
 . F  S IBG=$O(^TMP("IBCNSJ53I",$J,"TEMP",IBK,IBG),IBWORK) Q:IBG=""  D
 .. S IBH=$S(IBWORK="-1":"ZZZZZ",1:"")
 .. F  S IBH=$O(^TMP("IBCNSJ53I",$J,"TEMP",IBK,IBG,IBH),IBWORK) Q:IBH=""  D
 ... S IBJ=$G(^TMP("IBCNSJ53I",$J,"TEMP",IBK,IBG,IBH))
 ... S IBCT=IBCT+1,^TMP("IBCNSJ53I",$J,(IBI-6),IBCT,IBG,IBH)=IBJ
 I IBWORK="-1" D IBSRTA
 Q
 ;
IBSRTA ; pick up blank and bad date items
 ;
 N IBA,IBB,IBC,IBD,IBE
 I IBWORK'="-1" D
 . F IBA=" ","  " D IBSRTA1
 I IBWORK="-1" D
 . F IBA="  "," " D IBSRTA1
 Q
 ;
IBSRTA1 ; loop through bad/blank dates
 ;
 S IBB=$S(IBWORK="-1":"ZZZZZ",1:"")
 F  S IBB=$O(^TMP("IBCNSJ53I",$J,"TEMP",IBA,IBB),IBWORK) Q:IBB=""  D
 . S IBC=$S(IBWORK="-1":"ZZZZZ",1:"")
 . F  S IBC=$O(^TMP("IBCNSJ53I",$J,"TEMP",IBA,IBB,IBC),IBWORK) Q:IBC=""  D
 .. S IBD=$G(^TMP("IBCNSJ53I",$J,"TEMP",IBA,IBB,IBC))
 .. S IBCT=IBCT+1,^TMP("IBCNSJ53I",$J,(IBI-6),IBCT,IBB,IBC)=IBD
 Q
 ;
IBASE ; reset levels to base
 ;
 ;IB*804/DTG add sort to view subscribers
 ; base set of values
 N IBA,IBB,IBC,IBCNT,IBD,IBI
 F IBA=3,4,5 K ^TMP("IBCNSJ53I",$J,IBA)
 F IBI=9,10,11 S IBA="",IBCNT=0 F  S IBA=$O(^TMP("IBCNSJ53I",$J,IBI,IBA)) Q:IBA=""  S IBB="" D
 . F  S IBB=$O(^TMP("IBCNSJ53I",$J,IBI,IBA,IBB)) Q:IBB=""  D
 .. S IBD=^TMP("IBCNSJ53I",$J,IBI,IBA,IBB),IBCNT=IBCNT+1
 .. S ^TMP("IBCNSJ53I",$J,(IBI-6),IBCNT,IBA,IBB)=IBD
 ;
 Q
 ;
