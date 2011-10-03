DVBHS3 ; ALB/JLU;Routine for HINQ screen 3 ; 8/22/05 9:46pm
 ;;4.0;HINQ;**49**;03/25/92 
 ;
 K DVBX(1)
 F LP2=.322,.32101 S X="DVBDIQ(2,"_DFN_","_LP2_")" K @X
 K DVBDIQ(2.04)
 I $D(X(1)) S DVBX(1)=X(1)
 S DIC="^DPT(",DA=DFN,DIQ(0)="E",DIQ="DVBDIQ("
 S DR=".302;.3014;.322;.32101;.361"
 D EN^DIQ1
 S DR=".3721",DR(2.04)=".01;2:6",DIQ(0)="IE"
 F LP=0:0 S LP=$O(^DPT(DFN,.372,LP)) Q:'LP  S DA(2.04)=LP D EN^DIQ1
 I $D(DVBX(1)) S X(1)=DVBX(1) K DVBX(1)
 S DVBSCRN=3 D SCRHD^DVBHUTIL
 S DVBJS=35
 ;
 ;DVB*4*49 - Combat Disability removed - Combined % Disability okay
 ;W !?11,"Comb. % Disab.: "
 ;I $D(DVBDXPCT) W +DVBDXPCT
 W !,"Act. Duty Training: "
 I $D(DVBBIR) W $S($P(DVBBIR,U,24)["Y":"YES",$P(DVBBIR,U,24)["N":"NO",1:"")
 ;as of DVB*4*49 Additional Service is no longer being sent by VBA
 ;
 W ?24,"Tot. Act. Ser.: "
 I $D(DVBTOTAS) W ?40,DVBTOTAS
 ;
 W ?63,"Perm. & Tot.: "
 ;DVB*4*49 - P&T now being sent by VBA. 3=yes,2=no, else null
 I $D(DVBPTI) W ?56,$S(DVBPTI=2:"No",DVBPTI=3:"Yes",1:"")
 ;
 W !,DVBON,"[1]",DVBOFF X DVBLIT1
 W ?4,"Ver. SVC data: "
 W ?21,DVBDIQ(2,DFN,.322,"E")
 I $D(DVBP(6)) W ?49,$S($P(DVBP(6),U,8)["Y":"YES",$P(DVBP(6),U,8)["N":"NO",1:"")
 ;
 W !,DVBON,"[2]",DVBOFF X DVBLIT1
 W ?4,"Vietnam Ser.:"
 W ?21,DVBDIQ(2,DFN,.32101,"E")
 I $D(DVBP(6)) W ?49,$S($P(DVBP(6),U,4)["Y":"YES",$P(DVBP(6),U,4)["N":"NO",1:"")
 ;
 W !,DVBON,"[3]",DVBOFF X DVBLIT1
 W ?4,"Rated Disab.(Pat. File)-Comb. SC%: "
 I DVBDIQ(2,DFN,.361,"E")'="NSC" W ?37,$S(DVBDIQ(2,DFN,.302,"E")]"":+DVBDIQ(2,DFN,.302,"E"),1:"")
 ;W ?37,+DVBDIQ(2,DFN,.302,"E")
 W ?42,"Eff. Date Comb. Eval.: "_DVBDIQ(2,DFN,.3014,"E")
 I $P($G(^DPT(DFN,.372,0)),U,3)>0 D LABELS
 I $D(DVBDIQ(2.04)) F LP=0:0 S LP=$O(DVBDIQ(2.04,LP)) Q:'LP  D
 . I ($Y+5)>IOSL,$E(IOST,1,2)="C-" D PAUSE
 . W !,$E(DVBDIQ(2.04,LP,.01,"E"),1,40),?42,DVBDIQ(2.04,LP,2,"E")
 . W ?50,$G(DVBDIQ(2.04,LP,4,"I")),?55,$G(DVBDIQ(2.04,LP,5,"E"))
 . W ?68,$G(DVBDIQ(2.04,LP,6,"E"))
 N DVBEDT
 I +$G(DVBEFF)>0 S M=$E(DVBEFF,1,2) D MM^DVBHQM11 S DVBEDT=M_" "_$E(DVBEFF,3,4)_","_$E(DVBEFF,5,8)
 W !,?4,"Rated Disab. (HINQ)-     Comb. SC%: "
 W ?39,$S($G(DVBDXPCT)]"":+DVBDXPCT,1:"")
 W ?44,"Eff. Date Comb. Eval.: "_$G(DVBEDT)
 I $D(DVBDX)>9 D S1^DVBHQZ6
 Q
PAUSE ;
 N DIR
 S DIR(0)="E" D ^DIR
 I ('(+Y))!$D(DIRUT) S QUIT=1
 W @IOF,!
 Q
CHKDIS ;check to see if any of the disabilities comng from VBA are absent
 ;from the VistA DISABILITY CONDITION file (#31)
 Q
 N DVBC,DVBERR
 S (DVBC,DVBERR)=0
 F  S DVBC=$O(DVBDX(DVBC)) Q:DVBC'>0  D
 . N DVBDIS,DVBDISAB
 . S DVBDISAB=$P(DVBDX(DVBC),U)
 . S DVBDIS=$O(^DIC(31,"C",DVBDISAB,""))
 . I $G(DVBDIS)']"" W !,"Disability code "_DVBDISAB_" is missing from this site's DISABILITY",!,"CONDITIONS file (#13).  "_DVBDISAB_" not updated to VistA.  Check with ADPAC." S DVBERR=1
 I $G(DVBERR)=0 Q
 N DVBANS
 R !,"Hit any key to continue: ",DVBANS:DTIME
 Q 
CHKEFF(DVBDT) ;
 Q:$G(DVBDT)']""
 F DVBE=1:1:4 I $E(DVBDT,1)=" " S DVBDT=$E(DVBDT,2,8)
 I DVBDT'?1.8N S DVBDT="" Q
 D
 . S DVBOFFST="00000000"
 . S DVBDT=$E(DVBOFFST,1,8-$L(DVBDT))_DVBDT
 . I +DVBDT?5.6N S DVBDT=$E(DVBDT,3,4)_"00"_$E(DVBDT,5,8)
 S DVBDT=($E(DVBDT,5,8)-1700)_$E(DVBDT,1,2)_$E(DVBDT,3,4)
 Q
LABELS ;
 W !?55,"Original",?68,"Current"
 W !?3,"Disability",?43,"%",?49,"Extr.",?54,"Eff. Date",?67,"Eff. Date"
 Q
