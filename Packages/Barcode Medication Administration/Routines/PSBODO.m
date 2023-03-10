PSBODO ;BIRMINGHAM/EFC - BCMA UNIT DOSE VIRTUAL DUE LIST FUNCTIONS ;Dec 22, 2021@07:55:46
 ;;3.0;BAR CODE MED ADMIN;**5,21,24,38,58,68,70,83,98,106,93**;Mar 2004;Build 111
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference/IA
 ; EN^PSJBCMA2/2830
 ; GETPROVL^PSGSICH1/5653
 ; INTRDIC^PSGSICH1/5654
 ; GETSIOPI^PSJBCMA5/5763
 ; VA(200)/10060 - NEW PERSON FILE
 ;
 ;*68 - add ability to print new WP Special Instructions/OPI fields
 ;*58 - add sections to display Prv Override comments and Rph
 ;      Interventions to this report for (critical drug/drug and all
 ;      adverse reactions/allergies)
 ;*70 - print clinic name at top of detail section if exists.
 ;*83 - add Removal times
 ;*106- add Hazardous Handle & Dispose flags ;
 ;*93 - add order check to Display Order form, add Indication to order detail
 ;
EN ;
 ;
 ; Description:
 ; Returns a display for a selected order when double clicked on the VDL
 ;
 N PSBGBL,DFN
 S PSBGBL=$NAME(^TMP("PSBO",$J,"B"))
 F  S PSBGBL=$Q(@PSBGBL) Q:PSBGBL=""  Q:$QS(PSBGBL,2)'=$J  Q:$QS(PSBGBL,1)'["PSBO"  D
 .S DFN=$QS(PSBGBL,5)
 .D DISPORD
 .D CLEAN^PSBVT   ;*83 cleanup all PSB* variables
 Q
 ;
DISPORD ;
 N PSBGBL,PSBOI,PSBHDR,PSJGLO,LINE,PSBPRV,PSBPV,PSBRPH,PSBRH,PSBOVR,I,X,Y
 N CNT,DIWF,DIWL,DIWR
 S PSBOI=$$GET1^DIQ(53.69,PSBRPT_",",.09)
 D EN^PSJBCMA2(DFN,PSBOI)
 S PSJGLO="^TMP(""PSJ"""_","_$J
 D CLEAN^PSBVT
 D PSJ1^PSBVT(DFN,PSBOI)
 S PSBHDR(1)="BCMA - Display Order" D PT^PSBOHDR(DFN,.PSBHDR) W !
 I '$G(PSBONX) W !,"Invalid Order"
 D:$G(PSBONX)
 .W:$G(PSBCLORD)]"" "Clinic: "_PSBCLORD,!                         ;*70
 .W !,"Orderable Item: ",PSBOITX
 .W !?17,$S(PSBHAZHN:"<<HAZ Handle>> ",1:""),$S(PSBHAZDS:"<<HAZ Dispose>>",1:"")    ;*106
 .I PSBONX["V" W !,"Infusion Rate:  ",PSBIFR
 .I PSBONX'["V" W !,"Dosage Ordered: ",PSBDOSE
 .W ?40,"Start:    ",PSBOSTX W:$G(^XTMP("PSB DEBUG",0)) "   ("_PSBONX_")"
 .W !?40,"Stop:     ",PSBOSPX,?70,PSBOSTSX                        ;*70
 .W !,"Med Route:      ",PSBMR
 .W !,"Schedule Type:  ",PSBSCHTX
 .I PSBONX'["V" W ?40,"Self Med: ",PSBSMX
 .W:PSBSM !?40,"Hosp Sup: ",PSBSMX
 .W:PSBSCH'="" !,"Schedule: ",PSBSCH
 .I PSBONX'["V" W !,"Admin Times:    ",PSBADST
 .I PSBONX'["V",PSBMRRFL W !,"Removal Times:  ",$$REMSTR^PSBUTL(PSBADST,PSBDOA,PSBSCHT,PSBOSP,PSBOPRSP)
 .I PSBONX["V",((PSBIVT="P")!(PSBISYR=1)) W !,"Admin Times:    ",PSBADST
 .W !,"Provider: ",PSBMDX
 .;*68 change
 .W !,"Special Instructions/Other Print Info:"
 .K ^TMP("PSJBCMA5",$J)
 .D GETSIOPI^PSJBCMA5(DFN,PSBONX,1)
 .F QQ=0:0 S QQ=$O(^TMP("PSJBCMA5",$J,DFN,PSBONX,QQ)) Q:'QQ  D
 ..W !,^TMP("PSJBCMA5",$J,DFN,PSBONX,QQ)
 .K ^TMP("PSJBCMA5",$J)
 .W !,"Indication: "_$P($G(^PS(55,+$G(DFN),$S(PSBONX["V":"IV",1:5),+PSBONX,18)),U)
 .;*68 end
 .;*58 override/intervention section * * *
 .S PSBOVR=0
 .D GETPROVL^PSGSICH1(DFN,PSBONX,.PSBPRV)
 .D INTRDIC^PSGSICH1(DFN,PSBONX,.PSBRPH,2)
 .S PSBPV=$S($D(PSBPRV)>1:1,1:0)
 .S PSBRH=$S($D(PSBRPH)>1:1,1:0)
 .I 'PSBPV,PSBRH D DSPPRV(.PSBPRV,132,2,26,1) S PSBOVR=1
 .I PSBPV D DSPPRV(.PSBPRV,132,2,26) S PSBOVR=1
 .I PSBPV,'PSBRH D DSPRPH(.PSBRPH,132,2,26,1) S PSBOVR=1
 .I PSBRH D DSPRPH(.PSBRPH,132,2,26) S PSBOVR=1
 .I PSBOVR W !,$TR($J("",75)," ","-")
 .;*58 end override/intervention section * * *
 .;
 .W !
 .I $D(PSBDDA(1)) D
 ..W !,"Dispense Drugs",!,"Drug Name",?40,"Units",?50,"Inactive Date"
 ..W !,$TR($J("",75)," ","-")
 ..F Y=0:0 S Y=$O(PSBDDA(Y)) Q:'Y  D
 ...S X=$P(PSBDDA(Y),U,4)
 ...W !,$P(PSBDDA(Y),U,3),?40,$S(X]"":X,1:1)
 ...S X=$P(PSBDDA(Y),U,5) Q:'X
 ...W ?50,$E(X,4,5),"/",$E(X,6,7),"/",(1700+$E(X,1,3))
 .I $D(PSBADA(1)) D
 ..W !!,"Additives",!,"Name",?40,"Strength"
 ..W !,$TR($J("",75)," ","-")
 ..F Y=0:0 S Y=$O(PSBADA(Y)) Q:'Y  D
 ...W !,$P(PSBADA(Y),U,3),?40,$P(PSBADA(Y),U,4)
 .I $D(PSBSOLA(1)) D
 ..W !!,"Solution",!,"Name",?40,"Volume"
 ..W !,$TR($J("",75)," ","-")
 ..F Y=0:0 S Y=$O(PSBSOLA(Y)) Q:'Y  D
 ...W !,$P(PSBSOLA(Y),U,3),?40,$P(PSBSOLA(Y),U,4)
 .I $P(@(PSJGLO_","_0_")"),U,1)'=-1 D
 ..W !,$TR($J("",75)," ","-")
 ..W !,"Pharmacy Activity Log: "
 ..F I=1:1:$P(@(PSJGLO_","_0_")"),U,4) D
 ...W !?9,"Date:  ",$$FMTE^XLFDT($P(@(PSJGLO_","_I_","_1_")"),U,1)),?35,"User:  ",$P(@(PSJGLO_","_I_","_1_")"),U,2)
 ...W !?5,"Activity:  ",$P(@(PSJGLO_","_I_","_1_")"),U,4)
 ...I $D(@(PSJGLO_","_I_","_2_")")) D                             ;*83
 ....I $P(@(PSJGLO_","_I_","_1_")"),U,3)["DURATION" S @(PSJGLO_","_I_","_2_")")=@(PSJGLO_","_I_","_2_")")/60     ;DOA convert min to hr *83
 ....W !?8,"Field:  ",$P(@(PSJGLO_","_I_","_1_")"),U,3),!?5,"Old Data:  ",$S($P(@(PSJGLO_","_I_","_1_")"),U,3)["DATE":$$FMTE^XLFDT(@(PSJGLO_","_I_","_2_")")),1:@(PSJGLO_","_I_","_2_")")) ;correct date, PSB*3*98
 ...I $D(@(PSJGLO_","_I_","_3_")")) W !?7,"Reason:  ",@(PSJGLO_","_I_","_3_")")
 ...W !
 .;*93 begin
 .S CNT=0
 .N ORCPRS,ORIFN,LST,ORY  ;remove LST
 .K ^TMP("PSBORTXT",$J)
 .S ORCPRS=0
 .I PSBONX["U" D PSS431^PSS55(DFN,+PSBONX,,,"PSB") S ORCPRS=$G(^TMP($J,"PSB",+PSBONX,66))
 .I PSBONX["V" D PSS436^PSS55(DFN,+PSBONX,"PBS") S ORCPRS=$G(^TMP($J,"PBS",+PSBONX,110))
 .S ORIFN=ORCPRS,ORY=$NA(^TMP("PSBORTXT",$J)),@ORY=""
 .D ORCHECK  ;create the CPRS order check
 .K ^TMP("PSBORTXT",$J)
 .;*93 end
 W !!
 D CLEAN^PSBVT K @(PSJGLO_")")
 Q
 ;
DSPPRV(ARR,LN,IND,ALGN,NONE) ; Display Provider (CPRS) override reasons
 ; ARR  = array with provider override text.
 ; LN   = total width of report writable area.      (opt, 132 default)
 ; IND  = indent for both left and right margins.      (opt,0 default)
 ; ALGN = align colon on this column.                (opt, 25 default)
 ; NONE = display empty Provider override msg.        (opt, 0 default)
 ;
 N CAT,QQ,OC,HDG,CTRTAB,TMPONX,LINE,L1,L2,XX
 S LN=+$G(LN,132),IND=+$G(IND),ALGN=$G(ALGN,25),NONE=$G(NONE,0)
 S LN=LN-(IND*2)    ;adj writeable area by both L & R margins
 ;provider heading
 W !!?IND,$TR($J("",LN)," ","=")
 S HDG="** Current Provider Overrides for this order **"
 S CTRTAB=(LN-$L(HDG))/2
 W !?CTRTAB,HDG
 W !?IND,$TR($J("",LN)," ","="),!
 ;
 ;special scenario when NO Prv overrides, but Rph Interventions do
 I NONE W !?IND,"No Provider Overrides to display.",! Q
 ;
 ;provider body text
 S TMPONX=$O(ARR("PROV",DFN,"")) I TMPONX D
 .S QQ="" F  S QQ=$O(ARR("PROV",DFN,+TMPONX,QQ)) Q:QQ=""  D
 ..S LINE=ARR("PROV",DFN,+TMPONX,QQ),XX=$F(LINE,":")
 ..S L1=$J($E(LINE,1,XX),ALGN),L2=$E(LINE,XX+1,$L(LINE))
 ..W !?IND,L1,L2
 .W !
 S CAT=0 F  S CAT=$O(ARR("PROVR",DFN,+TMPONX,CAT)) Q:'CAT  D
 .S OC=0 F  S OC=$O(ARR("PROVR",DFN,+TMPONX,CAT,OC)) Q:'OC  D
 ..S LINE=ARR("PROVR",DFN,+TMPONX,CAT,OC,0),XX=$F(LINE,":")
 ..S L1=$J($E(LINE,1,XX),ALGN),L2=$E(LINE,XX+1,$L(LINE))
 ..W !,?IND,$$WRAP^PSBO(IND,LN,LINE),!
 Q
 ;
DSPRPH(ARR,LN,IND,ALGN,NONE) ; Display Pharmacist Interventions
 ; ARR  = array with Pharmacist intervention text.               (opt)
 ; LN   = total width of report writable area.       (opt,132 default)
 ; IND  = indent for both left and right margins.     (opt, 0 default)
 ; ALGN = align colon on this column.                (opt. 25 default)
 ; NONE = display empty Pharmacist intervention msg.  (opt, 0 default)
 ;
 N FLD,WP,WPTAG,WPLIN,HDG,INT,CTRTAB,LINE,L1,L2,XX
 S LN=+$G(LN,132),IND=+$G(IND),ALGN=$G(ALGN,25),NONE=$G(NONE,0)
 S LN=LN-(IND*2)         ;adj writeable area by both L & R margins
 ;
 ;pharmacist heading
 W !?IND,$TR($J("",LN)," ","=")
 S HDG="** Current Pharmacist Interventions for this order **"
 S CTRTAB=(LN-$L(HDG))/2
 W !?CTRTAB,HDG
 W !?IND,$TR($J("",LN)," ","="),!
 ;
 ;special scenario when NO Rph interventions, but Prv overrides do
 I NONE W !?IND,"No Pharmacist Interventions to display.",! Q
 ;
 ;pharmacist body text
 F INT=0:0 S INT=$O(ARR(DFN,PSBONX,INT)) Q:'INT  D
 .F FLD=0:0 S FLD=$O(ARR(DFN,PSBONX,INT,FLD)) Q:'FLD  D
 ..I FLD<1000 D
 ...S LINE=ARR(DFN,PSBONX,INT,FLD),XX=$F(LINE,":")
 ...S L1=$J($E(LINE,1,XX),ALGN),L2=$E(LINE,XX+1,$L(LINE))
 ...W !?IND,L1,L2
 ..I FLD>1000 D
 ...S (WP,WPLIN,WPTAG)="",LIN1=1
 ...F  S WP=$O(ARR(DFN,PSBONX,INT,FLD,WP)) Q:WP=""  D
 ....S LINE=ARR(DFN,PSBONX,INT,FLD,WP)
 ....I WP<1 D                          ;field Hdg line
 .....S LINE=$J(LINE,ALGN) W !?IND,LINE
 ....E  D                              ;detail WP lines
 .....I 'LIN1 W !
 .....W ?IND+ALGN,LINE
 .....S LIN1=0
 .W !
 W !
 Q
DSPORCK(LN,IND,ALGN,NONE) ; Display Order Check(CPRS) #93 NEW TAG
 ; LN   = total width of report writable area.      (opt, 132 default)
 ; IND  = indent for both left and right margins.      (opt,0 default)
 ; ALGN = align colon on this column.                (opt, 25 default)
 ; NONE = display empty order check msg.        (opt, 0 default)
 ;
 N CAT,QQ,OC,HDG,CTRTAB
 S LN=+$G(LN,132),IND=+$G(IND),ALGN=$G(ALGN,25),NONE=$G(NONE,0)
 S LN=LN-(IND*2)    ;adj writeable area by both L & R margins
 ;order check heading
 W !!?IND,$TR($J("",LN)," ","=")
 S HDG="** Current Order Check **"
 S CTRTAB=(LN-$L(HDG))/2
 W !?CTRTAB,HDG
 W !?IND,$TR($J("",LN)," ","="),!
 ;
 ; if there isn't order check information to display
 I NONE W !?IND,"No Order Check to display.",! Q
 ;
 ;write out order check text
 S QQ=0 F  S QQ=$O(^TMP("PSBORTXT",$J,QQ)) Q:QQ'>0  W ?IND,$G(^TMP("PSBORTXT",$J,QQ)),!
 Q
ORCHECK ; recreate CPRS Order Check - copied from ORQ2 #93
 K ^TMP($J,"PSBOCDATA")
 I '$$OCAPI^ORCHECK(+ORIFN,"PSBOCDATA") D DSPORCK(132,2,26,1) Q
 E  D
 . N CK,OK,X0,X,CDL,I,ACK,ALLGYDRG,HDR S HDR=0
 . S ACK=0
 . D ALLERGY
 . S:$D(OK) OK=""
 . S CK=0 F  S CK=$O(^TMP($J,"PSBOCDATA",CK)) Q:CK'>0  D
 .. Q:$D(ALLGYDRG(CK))  ;skip allergy entries
 .. S:HDR=0 CNT=CNT+1,@ORY@(CNT)=" ",CNT=CNT+1,@ORY@(CNT)="Order Checks:",CNT=CNT+1,@ORY@(CNT)=" ",HDR=1
 .. S X0=^TMP($J,"PSBOCDATA",CK,"OC NUMBER")_U_^TMP($J,"PSBOCDATA",CK,"OC LEVEL")_U_U_^TMP($J,"PSBOCDATA",CK,"OR REASON")_U_^TMP($J,"PSBOCDATA",CK,"OR PROVIDER")_U_^TMP($J,"PSBOCDATA",CK,"OR DT")
 .. S X=^TMP($J,"PSBOCDATA",CK,"OC TEXT",1,0)
 .. S CDL=$$CDL($P(X0,U,2)) I $P(X0,U,6),'$D(OK) S OK=$P(X0,U,4,6)
 .. I $L(X)'>100 S CNT=CNT+1,@ORY@(CNT)=CDL_X D XTRA Q
 .. S DIWL=1,DIWR=100,DIWF="C100" K ^UTILITY($J,"W") D ^DIWP
 .. S I=0 F  S I=$O(^UTILITY($J,"W",DIWL,I)) Q:I'>0  S CNT=CNT+1,@ORY@(CNT)=CDL_^(I,0),CDL="            "
 .. D XTRA
 . K ^TMP($J,"PSBOCDATA")
 . Q:(HDR=0)
 . Q:'$L($G(OK))  S CNT=CNT+1,@ORY@(CNT)="Override:   "_$S($P(OK,U,2):$$USER($P(OK,U,2))_" on ",1:"")_$TR($$FMTE^XLFDT($P(OK,U,3),"6MZ"),"@"," ")
 . I $L($P(OK,U))'>100 S CNT=CNT+1,@ORY@(CNT)="            "_$P(OK,U) Q
 . S DIWL=1,DIWR=100,DIWF="C100",X=$P(OK,U) K ^UTILITY($J,"W") D ^DIWP
 . S I=0 F  S I=$O(^UTILITY($J,"W",DIWL,I)) Q:I'>0  S CNT=CNT+1,@ORY@(CNT)="            "_^(I,0)
 D DSPORCK(132,2,26) ;print order check
 K ^UTILITY($J,"W"),ALLGYDRG
 Q
 ;
ALLERGY  ;separate the ALLERGY-DRUG INTERACTION Order Checks  #93 NEW TAG
 N RET,INSTANCE,INSTASAV
 S RET=1,(ACK,CK,CNT)=0
 F  S CK=$O(^TMP($J,"PSBOCDATA",CK)) Q:CK'>0  D
 . I $G(^TMP($J,"PSBOCDATA",CK,"OC NUMBER"))'=3 Q  ;only select the allergy-drug interactions
 . S ALLGYDRG(CK)=" "
 . I ACK=0 S CNT=CNT+1,@ORY@(CNT)=" ",CNT=CNT+1,@ORY@(CNT)="Allergy Order Checks:",CNT=CNT+1,ACK=1
 . S X0=^TMP($J,"PSBOCDATA",CK,"OC NUMBER")_U_^TMP($J,"PSBOCDATA",CK,"OC LEVEL")_U_U_^TMP($J,"PSBOCDATA",CK,"OR REASON")_U_^TMP($J,"PSBOCDATA",CK,"OR PROVIDER")_U_^TMP($J,"PSBOCDATA",CK,"OR DT")
 . S X=^TMP($J,"PSBOCDATA",CK,"OC TEXT",1,0)
 . S CDL=$$CDL($P(X0,U,2)) I $P(X0,U,6),'$D(OK) S OK=$P(X0,U,4,6)
 . I $L(X)'>100 S CNT=CNT+1,@ORY@(CNT)=CDL_X D XTRA Q
 . S DIWL=1,DIWR=100,DIWF="C100" K ^UTILITY($J,"W") D ^DIWP
 . S I=0 F  S I=$O(^UTILITY($J,"W",DIWL,I)) Q:I'>0  S CNT=CNT+1,@ORY@(CNT)=CDL_^(I,0),CDL="            "
 . S INSTANCE=$G(^TMP($J,"PSBOCDATA",CK,"OC INSTANCE"))
 . I INSTANCE>0  D
 .. I $$GET1^DIQ(100.517,RET_","_INSTANCE_",",11)'=""  D
 ... S:'$D(INSTASAV) INSTASAV=INSTANCE
 . D XTRA
 I ACK=1  D  ;if there are allergy-drug interaction check for override
 . Q:'$L($G(OK))  S CNT=CNT+1,@ORY@(CNT)="Override:   "_$S($P(OK,U,2):$$USER($P(OK,U,2))_" on ",1:"")_$TR($$FMTE^XLFDT($P(OK,U,3),"6MZ"),"@"," ")
 . I $L($P(OK,U))'>100 S CNT=CNT+1,@ORY@(CNT)="            "_$P(OK,U),CNT=CNT+1 Q
 . S DIWL=1,DIWR=100,DIWF="C100",X=$P(OK,U) K ^UTILITY($J,"W") D ^DIWP
 . S I=0 F  S I=$O(^UTILITY($J,"W",DIWL,I)) Q:I'>0  S CNT=CNT+1,@ORY@(CNT)="            "_^(I,0)
 I $D(INSTASAV)  D
 . S CNT=CNT+1,@ORY@(CNT)="            "
 . S CNT=CNT+1,@ORY@(CNT)="Remote Comment: "_$$GET1^DIQ(100.517,RET_","_INSTASAV_",",11)
 Q
CDL(X) ; -- Returns Clinical Danger Level X    #93 NEW TAG
 N Y S Y=$S(X=1:"HIGH:",X=2:"MODERATE:",X=3:"LOW:",1:"NONE:")
 S Y=$E(Y_"        ",1,12)
 Q Y
 ;
XTRA ;  #93 NEW TAG
 I $O(^TMP($J,"PSBOCDATA",CK,"OC TEXT",1)) N ORXT S ORXT=1 F  S ORXT=$O(^TMP($J,"PSBOCDATA",CK,"OC TEXT",ORXT)) Q:'ORXT  D
 . S X=^TMP($J,"PSBOCDATA",CK,"OC TEXT",ORXT,0),CDL="              "
 . I $L(X)'>100 S CNT=CNT+1,@ORY@(CNT)=CDL_X Q
 . S DIWL=1,DIWR=100,DIWF="C100" K ^UTILITY($J,"W") D ^DIWP
 . S I=0 F  S I=$O(^UTILITY($J,"W",DIWL,I)) Q:I'>0  S CNT=CNT+1,@ORY@(CNT)=CDL_^(I,0),CDL="              "
 I $O(^TMP($J,"PSBOCDATA",CK,"OC TEXT",1)) S X="",CNT=CNT+1,@ORY@(CNT)="              "
 Q
 ;
USER(X)  ; -- Returns NAME (TITLE) of New Person X   #93 NEW TAG
 N Y,Z
 S Y=$$GET1^DIQ(200,+X,.01),Z=$$GET1^DIQ(200,+X,8)
 S:(Z'="") Y=Y_" ("_Z_")"   ;check if title exist
 Q Y
