PSGMAR3 ;BIR/CML3-24 HOUR MAR(HEADER,BOT) ;14 Oct 98 / 4:28 PM
 ;;5.0; INPATIENT MEDICATIONS ;**8,20,85,111,131**;16 DEC 97
 ;
 ;
HEADER ; pat info
 S:'$G(PSGXDT) PSGXDT=PSGDT
 S PSGFORM="VA FORM 10-"_$S(PST["C":"2970",1:"5568d")
 S PSGMAROC=0,(MSG1,MSG2)="",PSGL=$E("|",PST["C")_" " W:$G(PSGPG)&($Y) @IOF S PSGPG=1 W !,$S(PST["C":"CONTINUOUS",1:"ONE-TIME/PRN")_" SHEET",?60,"24 HOUR MAR",?86,PSGMARSP_"  through  "_PSGMARFP
 W !?5,$P($$SITE^PSGMMAR2(80),U,2),?101,"Printed on   "_$$ENDTC2^PSGMI(PSGXDT)
 W !?5,"Name:  "_PPN,?62,"Weight (kg): "_WT,?103,"Loc: "_$S(PWDN'["C!":PWDN,1:$P($G(^SC($P(PWDN,"!",2),0)),"^"))
 W !?6,"PID:  "_PSSN,?25,"DOB: "_BD_"  ("_PAGE_")",?62,"Height (cm): "_HT,?99,"Room-Bed: "_$S(PWDN'["C!":PRB,1:"")
 W !?6,"Sex:  "_PSEX,?25," Dx: "_DX,?$S(TD:94,1:99),$S(TD:"Last Transfer: "_TD,1:"Admitted: "_$S(PWDN'["C!":AD,1:""))
 I '$D(PSGALG) W !,"Allergies:  See attached list of Allergies/Adverse Reactions"
 NEW PSGX S PSGX=0 D ATS(.PSGX) D:PSGX HEADER Q:PSGX
 W !,?49,"Admin"
 W:$G(PSJDIET)]"" ?57,"Diet: ",PSJDIET
 W !?1,"Order",?8,"Start",?20,"Stop",?49,"Times" W ?59 F X=PSGMARSD:1 S:X>24 X=1 W $S(X<10:0_X,1:X)," " Q:X=+PSGMARFD
 W !,LN1
 Q
 ;
ATS(PSGX) ;*** Print allergies and reactions.
 I '$D(PSGALG),'$D(PSGVALG),'$D(PSGADR),'$D(PSGVADR) Q
 I (PSGALG+PSGADR+PSGVALG+PSGVADR)<116 D  Q
 . I PSGALG(1)["NKA",(PSGVALG(1)["NKA") S PSGALG(1)=""
 . I PSGALG=20,(PSGALG(1)["_______") S PSGALG(1)=""
 . I PSGALG(1)]"",(PSGVALG(1)["NKA") S PSGALG(1)=""
 . I PSGADR=20,(PSGADR(1)["_______") S PSGADR(1)=""
 . S:PSGVALG(1)="" PSGVALG(1)="No Allergy Assessment"
 . W !,"Allergies:  ",PSGVALG(1)," ",PSGALG(1),"   ADR: ",PSGVADR(1)," ",PSGADR(1)
 S PSGX=1
 W !!,"Verified Allergies:",!
 F X=0:0 S X=$O(PSGVALG(X)) Q:'X  W ?12,PSGVALG(X),!
 W !!,"Non-Verified Allergies:",!
 F X=0:0 S X=$O(PSGALG(X)) Q:'X  W ?12,PSGALG(X),!
 W !!,"Verified Adverse Reactions:",!
 F X=0:0 S X=$O(PSGVADR(X)) Q:'X  W ?12,PSGVADR(X),!
 W !!,"Non-Verified Adverse Reactions:",!
 F X=0:0 S X=$O(PSGADR(X)) Q:'X  W ?12,PSGADR(X),!
 K PSGALG,PSGADR,PSGVALG,PSGVADR
 Q
TMSTR ;*** Set up the Admin times to print across on the 24 hour MAR.
 ;BHW;Added/modified next 2 lines to account for admin times between 0000 and 0059
 N ADMINHR
 W ?59 S MPH=PSGPLS\1,(HRS,TIM)="" F MPH=1:1:$L(TMSTR,"-") S ADMINHR=$E($P(TMSTR,"-",MPH),1,2) S:ADMINHR="00" ADMINHR=24 S HRS=HRS_ADMINHR_"-"
 F Q=PSGMARSD:1 D:Q>24 ADD S:Q>24 Q=1 S QQ=$S(Q<10:"0"_Q,Q>24:"01",1:Q) S:HRS[QQ TIM=$P(HRS,"-",($F(HRS,QQ)/3)) S TIM=$S(HRS[QQ&(TIM=(QQ_"00")):QQ,HRS[QQ:TIM,1:"  ") W $S(MPH_"."_QQ'<PSGLFFD:"***",($G(ONHOLD)&TIM):"HLD",1:TIM_" ") Q:Q=+PSGMARFD
 K HRS,TIM,MPH Q
ADD ;
 S X1=$P(MPH,"."),X2=1 D C^%DTC S MPH=X
 Q
 ;
TS(X) ;
 K TS S TS=$S(PST["C":$L(X,"-"),1:0) F Q=1:1:$S(TS<6:6,1:TS) S TS(Q)=""
 S:TS=1 TS(3)=$P(X,"-")
 S:TS=2 TS(1)=$P(X,"-"),TS(5)=$P(X,"-",2)
 S:TS=3 TS(1)=$P(X,"-"),TS(3)=$P(X,"-",2),TS(5)=$P(X,"-",3)
 I TS>3 F Q=1:1:TS S TS(Q)=$P(X,"-",Q)
 Q
 ;
BOT ; bottom of MAR
 I MSG1]"" F QQ=1:1:6 W ! W:QQ=1 ?7,"|",?19,"|" W:34[QQ ?12,$S(QQ=3:MSG1,1:MSG2) W ?55,$S(1:"|",OPST'["C":LN5,QQ<6:LN4,1:LN7)
 I PSGMAROC<6 S PSGMAROC=6-PSGMAROC F Q=1:1:PSGMAROC F QQ=1:1:6 W ! W:QQ=1 ?7,"|",?19,"|" W:34[QQ ?12,$S(QQ=3:MSG1,1:MSG2) W ?55,$S(1:"",OPST'["C":LN5,QQ<6:LN4,1:LN7) I QQ=6,Q<PSGMAROC W !?7,LN2
ENB ;
 I $D(PSGMPG) S PSGMPG=PSGMPG+1 S PSGMPGN=$S(PSGMPGN'["LAST":"PAGE: ",1:PSGMPGN)_PSGMPG
 W !,LN1
 W !,"|",?12,"SIGNATURE/TITLE",?39,"| INIT |  ALLERGIES   |  INJECTION SITES   |",?87,"MED/DOSE OMITTED",?107,"|     REASON     | INIT |"
 F Q=1:1:10 W !,"|"_$E(LN1,1,38)_"|------|--------------|"_BLN(Q),?82,"|"_$E(LN1,1,24)_"|"_$E(LN1,1,16)_"|------|"
 W !,LN1,!?3,PPN,?45,PSSN,?58,"Room-Bed: "_$S(PWDN'["C!":PRB,1:""),?100,$S($D(PSGMPG):PSGMPGN,1:""),?116,PSGFORM
 Q
