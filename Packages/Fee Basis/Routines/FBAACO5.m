FBAACO5 ;AISC/GRR-ENTER PAYMENT CONTINUED ;5/5/93  09:24
 ;;3.5;FEE BASIS;**73,79,124**;JAN 30, 1995;Build 20
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
FILEV(DFN,FBV) ;files vendor multiple in outpatient payment file
 ;required input variable DFN,FBV (vendor ien)
 K FBAAOUT
 I '$G(DFN)!('FBV) S FBAAOUT=1 Q
 S:'$D(^FBAAC(DFN,1,0)) ^FBAAC(DFN,1,0)="^162.01P^0^0"
 S DLAYGO=162,DIC="^FBAAC("_DFN_",1,",DIC(0)="QLNM",DA(1)=DFN,X="`"_FBV D ^DIC K DIC,DLAYGO I Y<0 W !,*7,"Cannot select this Vendor at this time" S FBAAOUT=1 Q
 Q
GETSVDT(DFN,FBV,FBASSOC,FBA,X) ;set date of service multiple
 ;required input DFN,FBV (vendor ien),FBASSOC (auth ptr,0 if not known)
 ;required input FBA (1=ask dt,0=do not ask dt)
 ;optional/required input X (dt) - X req if FBA=0 (do not ask)
 ;output FBSDI=ien of svc date mult,FBAADT=svc date
TRYAGAIN ;
 K FBAAOUT
 I '$G(DFN)!('$G(FBV))!('$D(FBASSOC))!('$D(FBA)) S FBAAOUT=1 Q
 I FBA=0,('$G(X)) S FBAAOUT=1 Q
 I $G(FBA) S DIC("A")="Date of Service: ",DIC(0)="AEQLM"
 I '$G(FBA) S DIC(0)="QLMN"
 I '$D(^FBAAC(DFN,1,FBV,1,0)) S ^FBAAC(DFN,1,FBV,1,0)="^162.02DA^0^0"
 S DLAYGO=162,DA(2)=DFN,DA(1)=FBV,DIC="^FBAAC("_DFN_",1,"_FBV_",1," D ^DIC K DLAYGO,DIC,DA I X=""!(X="^")!(Y<0) S FBAAOUT=1 Q
 ;if date of service input transform called skip checks
 I $D(HOLDY),HOLDY=$P(Y,"^",2) GOTO DONASK
 I $D(FBAAID),$P(Y,"^",2)>FBAAID D  G TRYAGAIN
 .N SHODAT S SHODAT=$E(FBAAID,4,5)_"/"_$E(FBAAID,6,7)_"/"_$E(FBAAID,2,3)
 .W !!,*7,?5,"*** Date of Service cannot be later than",!?8," Invoice Received Date ("_SHODAT_") !!!",!
 I $D(FBAABDT),$D(FBAAEDT),($P(Y,"^",2)<FBAABDT!($P(Y,"^",2)>FBAAEDT)) D  G TRYAGAIN
 .N PRIORLAT,AUTHDAT,SHODAT
 .S PRIORLAT=$S($P(Y,"^",2)<FBAABDT:"prior to ",1:"later than ")
 .S AUTHDAT=$S($P(Y,"^",2)<FBAABDT:FBAABDT,1:FBAAEDT)
 .S SHODAT=$E(AUTHDAT,4,5)_"/"_$E(AUTHDAT,6,7)_"/"_$E(AUTHDAT,2,3)
 .W !!,*7,?5,"*** Date of Service cannot be ",PRIORLAT,!?8," Authorization period ("_SHODAT_") !!!",!
DONASK ;
 S FBSDI=+Y,FBAADT=$P(Y,"^",2) I FBASSOC>0 S DA(2)=DFN,DA(1)=FBV,DA=FBSDI,DIE="^FBAAC("_DFN_",1,"_FBV_",1,",DR="3///^S X=FBASSOC" D ^DIE K DIE,DA,DR
 Q
