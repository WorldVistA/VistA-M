DGRP6CL ;ALB/TMK,LBD,ARF - REGISTRATION SCREEN 6 FIELDS Conflict locations ; 6/23/09 4:08pm
 ;;5.3;Registration;**689,751,764,797,1014**;Aug 13, 1993;Build 42
 ;
CLLST(DFN,DGCONF,DGPOSS,DGMSE) ;
 ; For patient DFN:
 ; Returns DGCONF array: DGCONF(conf loc)= Start dt^End dt
 ;  or, for multiple OEF/OIF/ UNKNOWN OEF/OIF: DGCONF(conf loc-ien) =
 ;                    Start dt ^ End dt ^ Site source ^ Lock flag
 ;    DGCONF(conflict loc,1)=1 if dts inconsistent w/mse dts
 ; DGPOSS = array of possible conflict locations, based on service
 ;          episode dts DGPOSS(conf loc)=""
 ; DGMSE = array of military svc episodes
 ;          DGMSE(1-n)=fr dt^to dt^branch ien^comp code
 ;
 N DGZ,DGZ0,DIQUIET,FRTO
 S DIQUIET=1 K DGCONF,DGPOSS
 ; Get Military Service Episodes and store in DGMSE array (DG*5.3*797)
 D GETMSE
 ;
 ; Must chk all possible/on-file conf locs for valid mil svc pd
 ; Extract OEF/OIF data
 F DGZ="OEF","OIF","UNK" S DGCONF(DGZ)=""
 D GET^DGENOEIF(DFN,.DGZ,0,"","")
 S DGZ0=0 F  S DGZ0=$O(DGZ("IEN",DGZ0)) Q:'DGZ0  S DGZ=$G(DGZ("IEN",DGZ0)) D
 . N DGCONFX
 . Q:'$G(DGZ("FR",DGZ0))&'$G(DGZ("TO",DGZ0))
 . S DGCONFX=$P("OIF^OEF^UNK",U,+$G(DGZ("LOC",DGZ0)))_"-"_DGZ,DGCONF=DGCONFX,DGCONF($P(DGCONFX,"-"))=$G(DGCONF($P(DGCONFX,"-")))_DGZ_";"
 . F FRTO=1,0 S $P(DGCONF(DGCONFX),U,$S(FRTO:1,1:2))=$$GETDT^DGRPMS(DFN,DGCONFX,FRTO) I FRTO=0 D CKDT^DGRP6CL1(.DGCONF,.DGMSE,.DGPOSS)
 . S $P(DGCONF(DGCONFX),U,3)=$G(DGZ("SITE",DGZ0))
 . S $P(DGCONF(DGCONFX),U,4)=$G(DGZ("LOCK",DGZ0))
 F DGCONF="OEF","OIF","UNK" D CKDT^DGRP6CL1(.DGCONF,.DGMSE,.DGPOSS)
 F DGCONF="VIET","LEB","GREN","PAN","GULF","SOM","YUG" F FRTO=1,0 S $P(DGCONF(DGCONF),U,$S(FRTO:1,1:2))=$$GETDT^DGRPMS(DFN,DGCONF,FRTO) I FRTO=0 D CKDT^DGRP6CL1(.DGCONF,.DGMSE,.DGPOSS)
 Q
 ;
GETMSE ;Get Military Service Data and store in DGMSE array (DG*5.3*797)
 ;DGMSE(1-3)=fr dt^to dt^branch ien^comp code
 ;Get MSE data from MSE sub-file #2.3216, if it's populated
 N MSE,DGZ,DGZ0,DGZ1,DG32,DG3291
 I $D(^DPT(DFN,.3216)) D  Q
 . D GETMSE^DGMSEUTL(DFN,.MSE)
 . S (MSE,DGZ)=0
 . F  S MSE=$O(MSE(MSE)) Q:'MSE  S DGZ=DGZ+1,DGMSE(DGZ)=$P(MSE(MSE),U,1,4)
 ;Else get MSE data from .32 and .3291 nodes of Patient file #2
 S DG32=$G(^DPT(DFN,.32)),DG3291=$G(^(.3291))
 S DGZ1=0
 F DGZ=1:1:3 S DGZ0=$S(DGZ=1:"5^5^6^7",DGZ=2:"19^10^11^12",1:"20^15^16^17") D
 . Q:$S($P(DG32,U,+DGZ0)="Y":0,1:'$P(DG32,U,+DGZ0))
 . S DGZ1=DGZ1+1,DGMSE(DGZ1)=$P(DG32,U,$P(DGZ0,U,3))_U_$P(DG32,U,$P(DGZ0,U,4))_U_$P(DG32,U,$P(DGZ0,U,2))_U_$P(DG3291,U,DGZ)
 Q
 ;
YN(DGRPX,X) ;Format Yes/No fld in $P(DGRPX,U,X)
 Q $S($P(DGRPX,"^",X)="Y":"YES",$P(DGRPX,"^",X)="N":"NO ",$P(DGRPX,"^",X)="U":"UNK",1:"   ")
 ;
DAT(DGRPX,X,Z1) ; Format dt in $P(DGRPX,U,X) for a length of Z1
 N Z
 S Z=$P(DGRPX,U,X)
 I Z'="" S Z=$$FMTE^XLFDT(Z,"5DZ")
 S:$L(Z)<Z1 Z=$E(Z_$J("",Z1),1,Z1)
 Q Z
 ;
EN(DFN,QUIT) ; Entry from reg screen 6
 N DIPA,DGCONF,DGCONFS,DGCONF1,DGMSE,DGMSG,DGPOSS,DIR,DIE,DR,DA
 ;
 ; Return QUIT=1 if ^ entered
EN1 ; Entry from conf subscreen off reg screen 6
 ; Routine loops until exit/quit from subscreen
 D CLEAR^VALM1
 K DGCONF,DGCONFS,DGPOSS,DGMSE,DGMSG,DGDISP
 N DIR,DTOUT,DUOUT,Z,Z0,Z1,Z2,X,Y,LOOP,DG,DGM,DGZ,DGEG,DGEGS,DGX,DGX1,DG321,DG322,DGCT,DGY,DGY1,DGCTX,SSN
 D CLLST(DFN,.DGCONF,.DGPOSS,.DGMSE)
 I $G(DGRPV) S $E(DGRPVV(6),2,3)="00",DGRPVV(6,"NOEDIT")=1
 I '$G(DGRPV),$E(DGRPVV(6),2,3)="11" S $E(DGRPVV(6),2,3)="00",DGRPVV(6,"NOEDIT")=1
 S DGMSG=0,DGCTX=0
 F Z="OEF","OIF","UNK" D  ; Sort OEF/OIF/ UNKNOWN OEF/OIF
 . ; by reverse from dt within each conf
 . S Z0=Z F  S Z0=$O(DGCONF(Z0)) Q:Z0=""!(Z0'[Z)  S Z2=Z_"-"_(9999999-DGCONF(Z0)) S DGCONFS(Z2)=$P(Z0,"-",2) I 'DGMSG,$G(DGCONF(Z0,1)) S DGMSG=1
 S DG321=$G(^DPT(DFN,.321)),DG322=$G(^(.322))
 ;
 S DIR(0)="SA^",DGCT=0
 N DGSSNSTR,DGPTYPE,DGSSN,DGDOB ;ARF-DG*5.3*1014 - begin - add standardize patient data to the screen banner
 S DGSSNSTR=$$SSNNM^DGRPU(DFN)
 S DGSSN=$P($P(DGSSNSTR,";",2)," ",3)
 S DGDOB=$$GET1^DIQ(2,DFN,.03,"I")
 S DGDOB=$$UP^XLFSTR($$FMTE^XLFDT($E(DGDOB,1,12),1))
 S DGPTYPE=$$GET1^DIQ(391,$$GET1^DIQ(2,DFN_",",391,"I")_",",.01)
 S:DGPTYPE="" DGPTYPE="PATIENT TYPE UNKNOWN"
 S DGCT=DGCT+1,DIR("A",DGCT)=$P(DGSSNSTR,";",1)_$S($$GET1^DIQ(2,DFN,.2405)'="":" ("_$$GET1^DIQ(2,DFN,.2405)_")",1:"")_"    "_DGDOB
 S DGCT=DGCT+1,DIR("A",DGCT)=$S($P($P(DGSSNSTR,";",2)," ",2)'="":$E($P($P(DGSSNSTR,";",2)," ",2),1,40)_"    ",1:"")_DGSSN_"    "_DGPTYPE
 ;S X=$S($D(^DPT(+DFN,0)):^(0),1:""),SSN=$P(X,"^",9),SSN=$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,10)
 ;S DGCT=DGCT+1,DIR("A",DGCT)=$$SSNNM^DGRPU(DFN) ;ARF-DG*5.3*1014 - end
 S DGCT=DGCT+1,DIR("A",DGCT)="",$P(DIR("A",DGCT),"=",81)=""
 S DGCT=DGCT+1,DIR("A",DGCT)=$S($O(DGMSE(0)):"MILITARY SERVICE PERIODS:",1:"NO SERVICE PERIODS FOR THIS PATIENT - NO CONFLICT LOC CAN BE ENTERED")
 S Z=0 F  S Z=$O(DGMSE(Z)) Q:'Z!(Z>4)  D
 . I Z=4 S DGCT=DGCT+1,DIR("A",DGCT)=$J("",3)_"<more episodes>" Q
 . S DGCT=DGCT+1,DIR("A",DGCT)=$J("",3)_$E($$EXTERNAL^DILFD(2,.325,"",$P(DGMSE(Z),U,3))_$S($P(DGMSE(Z),U,4)'="":"/"_$$SVCCOMP($P(DGMSE(Z),U,4)),1:"")_$J("",30),1,30)
 . S DIR("A",DGCT)=DIR("A",DGCT)_"  ("_$S($P(DGMSE(Z),U):$$FMTE^XLFDT($P(DGMSE(Z),U),"5DZ"),1:"missing")_"-"_$S($P(DGMSE(Z),U,2):$$FMTE^XLFDT($P(DGMSE(Z),U,2),"5DZ"),1:"missing")_")"
 S DGCT=DGCT+1,DIR("A",DGCT)=" "
 S DGCT=DGCT+1,DIR("A",DGCT)=$J("",24)_"---- CONFLICT LOCATIONS ----"
 S DGCT=DGCT+1,DIR("A",DGCT)=$J("",34)_"FROM"_$J("",9)_"TO"_$J("",7)_"SOURCE (FOR OEF/OIF)"
 ; DGCONF(DGCONF,"OK")=# entries for OEF/OIF/ UNKNOWN OEF/OIF
 ;                     that are site-entered
 ; DGCONF(DGCONF,"OK",entry ien)=display #^formatted from dt^
 ;       formatted to dt^inconsistent flag (valid entries for editing)
 S DGEG=0
 F DGEGS=2,1,3 D
 . S DGCONF=$P("OIF^OEF^UNK",U,DGEGS),DGM=0
 . S DG=$$ISVALID^DGRP6CL2(.DGCONF,.DGPOSS)
 . S DGEG=DGEG+1
 . S DGDISP=$S(DGCONF'="UNK":$J("",8),1:"OEF/OIF ")_DGCONF_": "
 . S DGCT=DGCT+1,DGCTX=DGCT S DIR("A",DGCT)="   "_$E(DG,1)_DGEG_$E(DG,2)_"  -"_DGDISP_$$YN($S(DGCONF(DGCONF):"Y",'$D(^DPT(DFN,.3215,0)):"",1:"N"),1)
 . I $G(DGCONF(DGCONF))!$D(DGPOSS(DGCONF)) I '$G(DGRPV),$G(DGCONF(DGCONF,"VEDIT"))'=2,'$G(DGCONF(DGCONF,"NOEDIT")) S:DGCONF'="UNK" DIR(0)=DIR(0)_DGEG_":"_DGCONF_";"
 . S (DGZ,DGCONFS)=DGCONF F  S DGCONFS=$O(DGCONFS(DGCONFS)) Q:DGCONFS=""!(DGCONFS'[DGZ)  D
 .. N DGUN,DGIEN,STA
 .. S DGIEN=DGCONFS(DGCONFS),DGCONF=DGZ_"-"_DGIEN,DGCONF1=DGZ,DGM=DGM+1
 .. I $G(DGCONF(DGCONF,1)),DGCTX S $E(DIR("A",DGCTX),1,3)="***"
 .. S DG=$$ISVALID^DGRP6CL2(.DGCONF,.DGPOSS)
 .. S DGUN=$S($G(DGCONF(DGCONF,"NOEDIT")):1,1:0)
 .. I 'DGUN S DGCONF(DGCONF1,"OK")=$G(DGCONF(DGCONF1,"OK"))+1,DGCONF(DGCONF1,"OK",DGIEN)=DGM_U_$$FMTE^XLFDT($P(DGCONF(DGCONF),U),"5DZ")_U_$$FMTE^XLFDT($P(DGCONF(DGCONF),U,2),"5DZ")
 .. I DGM>1 S DGCT=DGCT+1
 .. S DIR("A",DGCT)=$S(DGM>1:$J("",27-$L(DGM)),1:DIR("A",DGCT)_" ")_"("_DGM_")  "_$E($$DAT(DGCONF(DGCONF),1,13)_$J("",12),1,12)_$E($$DAT(DGCONF(DGCONF),2,11)_$J("",10),1,10)_"   "
 .. S STA=$P(DGCONF(DGCONF),U,3)
 .. S:STA STA=$P($G(^DIC(4,+STA,99)),U)
 .. S DIR("A",DGCT)=DIR("A",DGCT)_$S($P(DGCONF(DGCONF),U,3)="CEV":"",1:"Station #")_$E(STA_$J("",$S('DGUN:6,1:3)),1,$S('DGUN:6,1:3))
 .. I DGUN S DIR("A",DGCT)=DIR("A",DGCT)_" (No Edit)"
 D LOOPCNF^DGRP6CL1(.DGCONF,.DGPOSS,.DIR)
 S DGCT=DGCT+1,DIR("A",DGCT)=" "
 I $G(DGMSG) S DGCT=DGCT+1,DIR("A",DGCT)="*** ==>OEF/OIF Dates are inconsistent with veteran's military service episodes"
 S DIR("A")="SELECT THE NUMBER OF A CONFLICT LOCATION OR (Q)UIT: "
 S DIR(0)=DIR(0)_"Q:QUIT"
 S DIR("?")="^D HELP^DGRP6CL1($P(DIR(0),U,2))"
 S DIR("B")="QUIT"
 D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT)!(Y="Q") S:Y'="Q" QUIT=1 G QUIT
 S DGY=Y,DGY1=$S(Y=2:1,Y=1:2,1:Y)
 I DGY<4 S DGCONF=""
 I DGY'<4 D
 . S DGCONF=$P("OEF^OIF^UNK^VIET^LEB^GREN^PAN^GULF^SOM^YUG",U,DGY)
 . I $G(DGCONF(DGCONF,1)) W !!,"WARNING - THIS CONFLICT IS INCONSISTENT WITH MILITARY SERVICE DATA",!
 . S DIE=2,DA=DFN,DR=$P($T(@DGCONF),";;",2) D:DR'="" ^DIE K DIE,DA,DR
 I DGY=1!(DGY=2) D
 . S DGCONF=$P("OEF^OIF",U,DGY)
 . I '$G(DGCONF(DGCONF,"OK")),$G(DGCONF(DGCONF,"VEDIT"))'=2 D ADDCFL^DGRP6CL1(DFN,DGY1,DGCONF) Q  ; Add new only valid action
 . I $G(DGCONF(DGCONF,"VEDIT"))=1 S DIR("A")="DO YOU WANT TO (A)DD OR (E)DIT "_DGCONF_" CONFLICT DATA?: ",DIR(0)="SA^A:ADD;E:EDIT",DIR("B")="ADD" D ^DIR K DIR
 . I $G(DGCONF(DGCONF,"VEDIT"))=2,$G(DGCONF(DGCONF,"OK")) S DIR("A")="DO YOU WANT TO EDIT "_DGCONF_" CONFLICT DATA?: ",DIR(0)="YA",DIR("B")="YES" D ^DIR K DIR S Y=$S(Y=1:"E",1:Y)
 . Q:$D(DTOUT)!$D(DUOUT)
 . I Y="A" D ADDCFL^DGRP6CL1(DFN,DGY1,DGCONF) Q
 . I Y="E" D
 .. N DGXREF,IEN,DIR,X,Y
 .. I DGCONF(DGCONF,"OK")=1 S IEN=+$O(DGCONF(DGCONF,"OK",0)) I IEN D EDCFL^DGRP6CL1(DFN,IEN,$G(DGCONF(DGCONF,"VEDIT"))) Q
 .. S DIR(0)="SA^",DIR("A")="SELECT THE # OF THE "_DGCONF_" CONFLICT PERIOD TO EDIT: ",DIR("A",1)=" "
 .. S Z=0 F  S Z=$O(DGCONF(DGCONF,"OK",Z)) Q:'Z  S Z0=DGCONF(DGCONF,"OK",Z),DIR(0)=DIR(0)_+Z0_":"_$P(Z0,U,2)_$S($P(Z0,U,3)'="":"-"_$P(Z0,U,3),1:"")_";",DGXREF(+Z0)=Z
 .. S DIR(0)=DIR(0)_"Q:QUIT"
 .. D ^DIR K DIR
 .. I Y D EDCFL^DGRP6CL1(DFN,+$G(DGXREF(+Y)),$G(DGCONF(DGCONF,"VEDIT")))
 G EN1
 ;
QUIT Q
 ;
EN2 ; Consistency checker re-edit entrypoint for OEF/OIF data
 N DGOEIF,DGZ,DGQUIT,Z,Z0,Y
 D GET^DGENOEIF(DFN,.DGOEIF,2,"",1)
 I $G(DGOEIF("COUNT"))&($O(DGOEIF("OIF",0))!$O(DGOEIF("OEF",0))) D
 . F Z="OEF","OIF" S Z0=0 F  S Z0=$O(DGOEIF(Z,Z0)) Q:'Z0  I $G(DGOEIF(Z,Z0,"IEN")) S DGZ(DGOEIF(Z,Z0,"IEN"))=""
 . S (DGQUIT,DGZ)=0 F  S DGZ=$O(DGZ(DGZ)) Q:'DGZ  D  Q:DGQUIT
 .. N DGX,DA,DIE,DR,X
 .. S DGX=$G(^DPT(DFN,.3215,DGZ,0))
 .. W !!,"OEF/OIF CONFLICT: ",$$EXTERNAL^DILFD(2.3215,.01,"",$P(DGX,U)),"  FROM: "_$$EXTERNAL^DILFD(2.3215,.02,"",$P(DGX,U,2)),"  TO: "_$$EXTERNAL^DILFD(2.3215,.03,"",$P(DGX,U,3))
 .. S DA=DGZ,DA(1)=DFN,DIE="^DPT("_DA(1)_",.3215,",DR=".01;.02R;.03R" D ^DIE I $D(Y) S DGQUIT=1
 Q
 ;
SVCCOMP(X) ; Returns display text for service component
 Q $S(X="R":"REGULAR",X="V":"RESERVE",X="G":"GUARD",1:"")
 ;
VIET ;;.32101//NO;S:X'="Y" Y="@64";.32104;.32105;@64;
LEB ;;.3221//NO;S:X'="Y" Y="@67";.3222;Q;.3223;@67;
GREN ;;.3224//NO;S:X'="Y" Y="@68";.3225;Q;.3226;@68;
PAN ;;.3227//NO;S:X'="Y" Y="@69";.3228;Q;.3229;@69;
GULF ;;.32201//NO;S:X'="Y" Y="@610";.322011;Q;.322012;@610;
SOM ;;.322016//NO;S:X'="Y" Y="@611";.322017;Q;.322018;@611;
YUG ;;.322019//NO;S:X'="Y" Y="@615";.32202;Q;.322021;@615;
OEF ;;
OIF ;;
UNK ;;
 ;;
