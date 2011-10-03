IBCEP2B ;ALB/TMP - EDI UTILITIES for provider ID ;18-MAY-04
 ;;2.0;INTEGRATED BILLING;**232,320,400**;21-MAR-94;Build 52
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
PROVID(IBIFN,IBPRIEN,IBCOBN,DIPA) ; Provider id entry on billing screen 8
 ; IBIFN = ien file 399
 ; IBPRIEN = ien file 399.0222
 ; IBCOBN = the COB number of the id being edited
 ; DIPA = passed by ref, returned with id data
 ; DIPA("EDIT")=-1 if no id editing  = 1 if edit id   = 2 if stuff id
 ; DIPA("PRID")= id to stuff   DIPA("PRIDT")= id type to stuff
 N PRN0,Z
 Q:'$G(^DGCR(399,IBIFN,"I1"))
 S PRN0=$G(^DGCR(399,IBIFN,"PRV",IBPRIEN,0))
 S DIPA("EDIT")=1,(DIPA("PRID"),DIPA("PRIDT"))=""
 W @IOF
 W !,?19,"**** SECONDARY PERFORMING PROVIDER IDs ****"
 W !!,$P("PRIMARY^SECONDARY^TERTIARY",U,IBCOBN)_" INSURANCE CO: "_$P($G(^DIC(36,+$G(^DGCR(399,IBIFN,"I"_IBCOBN)),0)),U)
 W !,"PROVIDER: "_$$EXTERNAL^DILFD(399.0222,.02,"",$P(PRN0,U,2))_" ("_$$EXTERNAL^DILFD(399.0222,.01,"",+PRN0)_")",!
 ;
 I $P(PRN0,U,4+IBCOBN)="" K DIPA("PRID"),DIPA("PRIDT") D NEWID(IBIFN,IBPRIEN,IBCOBN,.DIPA) ; No id currently exists for the ins seq/prov
 ;
 Q
 ;
NEWID(IBIFN,IBPRIEN,IBCOBN,DIPA) ;
 N IBDEF,IBCT,IBNUM,IBINS,IBFRM,IBCAR,IBARR,IBARRS,IB0,IBM,IBQUIT,IBSEL,PRN,PRT,PRN,PRN0,DIR,X,Y,Z,Z0,IBZ,IBZ1,IBTYP,IBREQ,IBREQT,IBTYPN,IBID,IBUSED
 S IBREQ=0,IBREQT=""
 S PRN0=$G(^DGCR(399,IBIFN,"PRV",IBPRIEN,0))
 S Z(IBCOBN)=$S($G(DIPA("I"_IBCOBN)):$$GETTYP^IBCEP2A(IBIFN,IBCOBN,$P(PRN0,U)),1:"")
 S IBINS=+$G(^DGCR(399,IBIFN,"I"_IBCOBN)),IB0=$G(^DGCR(399,IBIFN,"PRV",IBPRIEN,0))
 S IBCAR=$$INPAT^IBCEF(IBIFN),IBCAR=$S('IBCAR:2,1:1)
 S IBFRM=$$FT^IBCEF(IBIFN),IBFRM=$S(IBFRM=2:2,1:1)
 I $P(Z(IBCOBN),U) D
 . W !,"INS. COMPANY'S DEFAULT SECONDARY ID TYPE IS: "_$$EXTERNAL^DILFD(36,4.01,"",$P(Z(IBCOBN),U)) S IBREQT=+Z(IBCOBN)
 . I $P(Z(IBCOBN),U,2) W !,?2," AND IS REQUIRED TO BE ENTERED FOR THIS CLAIM" S IBREQ=1
 I $$CUNEED^IBCEP3(IBIFN,IBCOBN) W !,"CARE UNITS ARE DEFINED"_$S($P($G(^DIC(36,IBINS,4)),U,9)'="":" AS "_$P(^(4),U,9),1:"")_" FOR THESE IDs"
 D PRACT^IBCEF71(IBINS,IBFRM,IBCAR,$P(IB0,U,2),.IBARR,$P(IB0,U),$S($$COBN^IBCEF(IBIFN)=IBCOBN:"C",1:"O"),355.9,1)
 S (IBNUM,IBCT)=0,IBDEF=""
 I $O(IBARR(""))="" S IBCT=IBCT+1,DIR("A",IBCT)="NO SECONDARY IDS ARE DEFINED FOR THIS PROV THAT ARE VALID FOR THIS CLAIM"
 S IBCT=IBCT+1,DIR("A",IBCT)="SELECT A SECONDARY ID OR ACTION FROM THE LIST BELOW: ",IBCT=IBCT+1,DIR("A",IBCT)=" "
 ;
 S IBCT=IBCT+1,IBNUM=IBNUM+1,DIR("A",IBCT)="  "_$E(IBNUM_$J("",3),1,3)_" -  NO SECONDARY ID NEEDED",IBNUM=IBNUM+1,IBCT=IBCT+1,DIR("A",IBCT)="  "_$E(IBNUM_$J("",3),1,3)_" -  ADD AN ID FOR THIS CLAIM ONLY"
 I $O(IBARR(""))="" S IBDEF=1,DIPA("EDIT")=$$SELID(.DIR,IBDEF,.IBID,.DIPA,IBNUM) Q
 ;
 S PRN=$$GETID^IBCEP2(IBIFN,2,$P(PRN0,U,2),IBCOBN,.PRT,,$P(PRN0,U)),IBDEF=""
 ;
 I PRN'="",PRT D
 . N PRT1
 . S PRT1=$P($G(^IBE(355.97,+PRT,0)),U)
 . I $P($G(^IBE(355.97,+PRT,1)),U,3) S PRT1="ST LIC("_$P($G(^DIC(5,+$$CAREST^IBCEP2A(IBIFN),0)),U,2)_")"
 . S IBCT=IBCT+1,IBNUM=IBNUM+1
 . S DIR("A",IBCT)="  "_$E(IBNUM_$J("",3),1,3)_" -  "_$E("<DEFAULT> "_PRN_$J("",29),1,29)_"  "_$E(PRT1_$J("",15),1,15)
 . S DIR("A",IBCT)=DIR("A",IBCT)_"  "_$S($P(PRT,U,3)'["355.9":"",$P($G(^IBA(+$P(PRT,U,3),+$P(PRT,U,2),0)),U,3)'="":$$EXTERNAL^DILFD(355.9,.03,"",$P($G(^IBA(+$P(PRT,U,3),+$P(PRT,U,2),0)),U,3)),1:"")
 . S IBID(IBNUM)=PRN_U_+PRT,IBDEF=IBNUM,IBID(IBNUM,1)=DIR("A",IBCT),IBDEF=IBNUM,IBDEF("IEN")=$P(PRT,U,2,3)
 . S IBUSED(PRT,PRN,0)=""
 ;
 S IBQUIT=0,IBSEL=1
 ; Sort ids by id type
 S IBZ="" F  S IBZ=$O(IBARR(IBZ)) Q:IBZ=""  S IBZ1="" F  S IBZ1=$O(IBARR(IBZ,IBZ1)) Q:IBZ1=""  D
 . S IBTYP=+$P(IBARR(IBZ,IBZ1),U,9)
 . I $P(IBARR(IBZ,IBZ1),U,4)]"" Q:$D(IBUSED(IBTYP,$P(IBARR(IBZ,IBZ1),U,4),+$P(IBARR(IBZ,IBZ1),U,7)))
 . I $P($G(IBDEF("IEN")),U,2)["355.9",$P(IBARR(IBZ,IBZ1),U,8),$P(IBARR(IBZ,IBZ1),U,8)=+$G(IBDEF("IEN")) Q:$S($P(IBZ1,U)'["INS DEF":$P($G(IBDEF("IEN")),U,2)=355.9,1:$P($G(IBDEF("IEN")),U,2)=355.91)
 . S IBARRS(IBTYP,IBZ,IBZ1)=IBARR(IBZ,IBZ1)
 . I $P(IBARR(IBZ,IBZ1),U,4)]"" S IBUSED(IBTYP,$P(IBARR(IBZ,IBZ1),U,4),+$P(IBARR(IBZ,IBZ1),U,7))=""
 S IBTYP="" F  S IBTYP=$O(IBARRS(IBTYP)) Q:IBTYP=""  S IBZ="" F  S IBZ=$O(IBARRS(IBTYP,IBZ)) Q:IBZ=""  D  Q:IBQUIT
 . S IBZ1="" F  S IBZ1=$O(IBARRS(IBTYP,IBZ,IBZ1)) Q:IBZ1=""  S IBCT=IBCT+1,IBNUM=IBNUM+1 D  Q:IBQUIT
 .. S Z0=IBARRS(IBTYP,IBZ,IBZ1)
 .. S IBARR=$S($P(Z0,U,8)&(IBZ1'["LIC"):$G(^IBA("355.9"_$S($P(IBZ1,U)'="INS DEF":"",1:1),+$P(Z0,U,8),0)),1:"")
 .. S IBTYPN=$S(IBTYP=+$$STLIC^IBCEP8():"ST LIC ("_$P($G(^DIC(5,+$P(Z0,U,7),0)),U,2)_")",1:$P($G(^IBE(355.97,IBTYP,0)),U))
 .. S DIR("A",IBCT)="  "_$E(IBNUM_$J("",3),1,3)_" -  "_$E($S($P(IBZ1,U)="INS DEF":"<INS DEF> ",1:"")_$P(Z0,U,4)_$J("",29),1,29)_"  "_$E(IBTYPN_$J("",15),1,15)_"  "_$S($P(IBARR,U,3):$$EXTERNAL^DILFD(355.9,.03,"",$P(IBARR,U,3)),1:"")
 .. S IBID(IBNUM,1)=DIR("A",IBCT),IBID(IBNUM)=$P(Z0,U,4)_U_IBTYP
 .. I (IBNUM#15)=0 S IBM=$$MORE(.DIR) D  Q:IBQUIT
 ... I IBM<0 S IBQUIT=1,IBSEL=0 Q  ; User aborted list
 ... I 'IBM S IBQUIT=1 Q  ; User wants to select
 ... W ! K DIR S IBCT=1
 I 'IBSEL S DIPA("EDIT")=-1
 I IBSEL S:IBDEF=""&$G(IBREQ) IBDEF=2 S DIPA("EDIT")=$$SELID(.DIR,IBDEF,.IBID,.DIPA,IBNUM)
 Q
 ;
SELID(DIR,IBDEF,IBID,DIPA,IBNUM) ; Returns the selection from the array of possible IDs/ID actions
 N IDACT,IDSEL,X,Y
 S IDACT=""
 S DIR("B")=$S('$G(IBDEF):1,1:IBDEF),DIR("A",+$O(DIR("A",""),-1)+1)=" "
 S DIR(0)="NA^1:"_IBNUM,DIR("A")="Selection: " W ! D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y=1) S IDACT=-1 G SELIDQ
 I Y=2 S IDACT=1 G SELIDQ
 S IDSEL=Y
 S DIR("A",1)="ID SELECTED:",DIR("A",2)="  "_$G(IBID(+Y,1)),DIR("A")="IS THIS CORRECT?: ",DIR("B")="YES",DIR(0)="YA" W ! D ^DIR K DIR
 I Y'=1 S IDACT=-1 G SELIDQ
 S DIPA("PRID")=$P(IBID(IDSEL),U),DIPA("PRIDT")=$P(IBID(IDSEL),U,2),IDACT=2
 ;
SELIDQ Q IDACT
 ;
MORE(DIR) ;
 N DIR,X,Y,DUOUT,DTOUT
 S DIR(0)="YA",DIR("A")="MORE?: ",DIR("B")="NO" W ! D ^DIR K DIR("B")
 Q $S($D(DTOUT)!$D(DUOUT):-1,1:Y)
 ;
 ; IBFIDFL = E = Electronic Form Type
 ;           A = Additional ID's
 ;           LF - VA Lab/Facility
FACID(IBINS,IBFIDFL) ; Enter/edit billing facility ids
 ; IBINS = ien of ins co (file 36)
 N IBID,Z,Z0,Y
 K ^TMP($J,"IBBF_ID")
 W @IOF
 D GETBPNUM(IBINS)
 K ^TMP("IBCE_PRVFAC_MAINT_INS",$J)
 S ^TMP("IBCE_PRVFAC_MAINT_INS",$J)=IBFIDFL_U_IBINS_U_"1"
 D EN^VALM("IBCE PRVFAC MAINT")
 K ^TMP("IBCE_PRVFAC_MAINT_INS",$J)
 W @IOF
 D FULL^VALM1
 Q
 ;
GETBPNUM(IBINS) ;
 N Z,Z0,IBID,IBMAIN
 S IBMAIN=$$MAIN(),^TMP($J,"IBBF_ID")=IBMAIN
 S IBID=$$BF^IBCU()
 S Z=0 F  S Z=$O(^IBA(355.92,"B",IBINS,Z)) Q:'Z  D
 . S Z0=$G(^IBA(355.92,Z,0))
 . Q:$P(Z0,U,8)'="E"  ; WCJ 1/13/06  There are several ID types in this file 
 . Q:$P(Z0,U,3)]""
 . S ^TMP($J,"IBBF_ID",$S($P(Z0,U,5)=IBMAIN:0,1:+$P(Z0,U,5)),+$P(Z0,U,4))=$P(Z0,U,7)
 . S ^TMP($J,"IBBF_ID",$S($P(Z0,U,5)=IBMAIN:0,1:+$P(Z0,U,5)),+$P(Z0,U,4),"QUAL")=$P(Z0,U,6)
 Q
 ;
MAIN() ; Returns ien of main division of the database
 Q +$$PRIM^VASITE()
 ;
FACNUM(IBIFN,IBCOB,IBQF) ; Function returns the current division's fac billing
 ; prov id for the COB insurance sequence from file 355.92
 ; IBIFN = ien file 399
 ; IBCOB = # of COB ins seq or if "", current assumed
 ; IBQF - 1 if qualifier is to be returned instead of ID
 N Z,IBDIV,IBFT,X,BPZ
 S X="",IBDIV=0
 S:'$G(IBCOB) IBCOB=+$$COBN^IBCEF(IBIFN)
 ;
 ; IB*2*400 - esg - 11/7/08 - Determine the division associated with the billing provider first
 S BPZ=+$$B^IBCEF79(IBIFN,IBCOB)                     ; Inst file pointer as the billing provider for payer seq IBCOB
 I BPZ S IBDIV=+$O(^DG(40.8,"AD",BPZ,0))             ; Billing Provider division (may not exist)
 ;
 I 'IBDIV S IBDIV=+$P($G(^DGCR(399,IBIFN,0)),U,22)   ; Division on claim
 I 'IBDIV S IBDIV=$$MAIN()                           ; main division
 ;
 S IBFT=$$FT^IBCEF(IBIFN),IBFT=$S(IBFT=3:1,1:2)
 K ^TMP($J,"IBBF_ID")
 D GETBPNUM(+$P($G(^DGCR(399,IBIFN,"M")),U,IBCOB))
 I IBDIV=+$G(^TMP($J,"IBBF_ID")) S IBDIV=0
 I '$G(IBQF) S X=$S($D(^TMP($J,"IBBF_ID",IBDIV,IBFT)):^(IBFT),1:$G(^TMP($J,"IBBF_ID",0,IBFT)))
 I $G(IBQF) S X=$S($D(^TMP($J,"IBBF_ID",IBDIV,IBFT,"QUAL")):^("QUAL"),1:$G(^TMP($J,"IBBF_ID",0,IBFT,"QUAL")))
 K ^TMP($J,"IBBF_ID")
 Q X
 ;
SOP(IBIFN,IBZD) ; Returns X12 current source of pay code for bill ien IBIFN
 ; IBZD = the current ins policy type, if known
 N IBZ
 S IBZ=""
 I $G(IBZD)="" D F^IBCEF("N-CURRENT INS POLICY TYPE","IBZD",,IBIFN)
 S IBZ=$S($G(IBZD)="":"G2","MAMB16"[IBZD:"1C",IBZD="TV"!(IBZD="MC"):"1D",IBZD="CH":"1H",IBZD="BL":$S($$FT^IBCEF(IBIFN)=2:"1B",1:"1A"),1:"G2")
 Q IBZ
 ;
