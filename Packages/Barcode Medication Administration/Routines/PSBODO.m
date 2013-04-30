PSBODO ;BRMINGHAM/EFC-BCMA UNIT DOSE VIRTUAL DUE LIST FUNCTIONS ;1/30/12 1:13pm
 ;;3.0;BAR CODE MED ADMIN;**5,21,24,38,58,68**;Mar 2004;Build 26
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Reference/IA
 ; EN^PSJBCMA2/2830
 ; GETPROVL^PSGSICH1/5653
 ; INTRDIC^PSGSICH1/5654
 ; GETSIOPI^PSJBCMA5/5763
 ;
 ;*68 - add ability to print new WP Special Instructions/OPI fields
 ;*58 - add sections to display Prv Override comments and Rph
 ;      Interventions to this report for (critical drug/drug and all
 ;      adverse reactions/allergies)
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
 Q
 ;
DISPORD ;
 N PSBGBL,PSBOI,PSBHDR,PSJGLO,LINE,PSBPRV,PSBPV,PSBRPH,PSBRH,PSBOVR,I,X,Y
 S PSBOI=$$GET1^DIQ(53.69,PSBRPT_",",.09)
 D EN^PSJBCMA2(DFN,PSBOI)
 S PSJGLO="^TMP(""PSJ"""_","_$J
 D CLEAN^PSBVT
 D PSJ1^PSBVT(DFN,PSBOI)
 S PSBHDR(1)="BCMA - Display Order" D PT^PSBOHDR(DFN,.PSBHDR) W !
 I '$G(PSBONX) W !,"Invalid Order"
 D:$G(PSBONX)
 .W !,"Orderable Item: ",PSBOITX
 .I PSBONX["V" W !,"Infusion Rate:  ",PSBIFR
 .I PSBONX'["V" W !,"Dosage Ordered: ",PSBDOSE
 .W ?40,"Start:    ",PSBOSTX
 .W !?40,"Stop:     ",PSBOSPX
 .W !,"Med Route:      ",PSBMR
 .W !,"Schedule Type:  ",PSBSCHTX
 .I PSBONX'["V" W ?40,"Self Med: ",PSBSMX
 .W:PSBSM !?40,"Hosp Sup: ",PSBSMX
 .W:PSBSCH'="" !,"Schedule: ",PSBSCH
 .I PSBONX'["V" W !,"Admin Times:    ",PSBADST
 .I PSBONX["V",((PSBIVT="P")!(PSBISYR=1)) W !,"Admin Times:    ",PSBADST
 .W !,"Provider: ",PSBMDX
 .;*68 change
 .W !,"Special Instructions/Other Print Info:"
 .K ^TMP("PSJBCMA5",$J)
 .D GETSIOPI^PSJBCMA5(DFN,PSBONX,1)
 .F QQ=0:0 S QQ=$O(^TMP("PSJBCMA5",$J,DFN,PSBONX,QQ)) Q:'QQ  D
 ..W !,^TMP("PSJBCMA5",$J,DFN,PSBONX,QQ)
 .K ^TMP("PSJBCMA5",$J)
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
 ...I $D(@(PSJGLO_","_I_","_2_")")) W !?8,"Field:  ",$P(@(PSJGLO_","_I_","_1_")"),U,3),!?5,"Old Data:  ",@(PSJGLO_","_I_","_2_")")
 ...I $D(@(PSJGLO_","_I_","_3_")")) W !?7,"Reason:  ",@(PSJGLO_","_I_","_3_")")
 ...W !
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
