DVBHS5 ; ALB/JLU;Routine for HINQ screen 5 ; 7/13/05 12:58pm
 ;;4.0;HINQ;**12,11,20,49,61**;03/25/92;Build 19
 N Y,DVBAA,DVBHH,DVBAAHB
 K DVBX(1)
 K DVBDIQ ;F LP2=.3611,.3616,.3612,.306,.3615,391,1901,.301,.302,.361,.36205,.3621,.36235,.3624,.36215,.3622,.36295,.3025,.303 S X="DVBDIQ(2,"_DFN_","_LP2_")" K @X
 I $D(X(1)) S DVBX(1)=X(1)
 S DIC="^DPT(",DIQ(0)="E",DIQ="DVBDIQ("
 ;S DR=".01;.09;.3611;.3616;.3612;.306;.3615;391;1901;.301;.302;.361;.36205;.3621;.36235;.3624;.36215;.3622;.36295;.3025;.303"
 S DR=".01;.09;.3611;.3616;.3612;.306;.3615;391;1901;.301;.302;.361;.36205;.36235;.36215;.36295;.3025"
 D EN^DIQ1
 I $D(DVBX(1)) S X(1)=DVBX(1) K DVBX(1)
 S DVBAA=DVBDIQ(2,DVBQDFN,".36205","E")
 S DVBHB=DVBDIQ(2,DVBQDFN,".36215","E")
 S DVBAAHB=""
 I DVBHB="YES" S DVBAAHB="H"
 I DVBAA="YES" S DVBAAHB="A"
 ;
 S DVBSCRN=5 D SCRHD^DVBHUTIL
 S DVBJS=53
 W !,"Check Amt.: ",$S($D(DVBCHECK):"$"_DVBCHECK,1:"")
 W ?28,"Combined %: ",$S($D(DVBDXPCT):+DVBDXPCT_"%",1:"")
 W ?48,"Net Award Amt.: ",$S($D(DVBBAS(1)):"$"_$P(DVBBAS(1),U,20),1:"")
 I $D(DVBP(1)) S T1=$P(DVBP(1),U,4)
 ;with DVB*4*49, VBA no longer sending entitlement code, so a type
 ;benefit is being calculated and displayed where entitlement code was
 S DVBENT=$S($G(T1)="01":"Compensation",$G(T1)="0L":"Pension",1:"")
 K T1,T2 W !,"Benefit Type:",?15,$S($D(DVBENT):DVBENT,1:"")
 W ?40,"Income for VA Purposes: $"_$S($P($G(DVBINC),U,15)>0:$P(DVBINC,U,15)_".00",1:"0.00")
 W !,"Aid & Attendance: " I $D(DVBAAHB) S Y=$S(DVBAAHB="A":2,DVBAAHB="H":3,1:"")  D AAA^DVBHQM2 W Y
 ;W !,"Rated (HINQ) Disabilities:" I $D(DVBDXNO),DVBDXNO'=0 D S1^DVBHQZ6
 I $D(DVBSCR) K DVBSCR D LINE Q
 ;
 W !!,"--- ",DVBON,"Patient Data",DVBOFF," ---"
 W !,DVBON,"(1)",DVBOFF," Elig. Stat.: ",$E(DVBDIQ(2,DFN,.3611,"E"),1,20) X DVBLIT1
 W ?38,"Elig. Stat. ent. by: ",$E(DVBDIQ(2,DFN,.3616,"E"),1,18)
 W !,?5,"Stat. date: ",DVBDIQ(2,DFN,.3612,"E")
 W ?37,"Monetary Ben. Verif.: ",DVBDIQ(2,DFN,.306,"E")
 W !,?3,"Verif. Meth.: ",$E(DVBDIQ(2,DFN,.3615,"E"),1,50)
 W ?44,"Patient Elig.: "
 I $D(^DPT(DFN,"E",0)),+$P(^(0),U,3) D
 . N DVBE1,DVBELIG,DVBER2,DVBQ
 . D GETS^DIQ(2,DFN_",","361*","EI","DVBELIG","DVBER2")
 . N DVBCT
 . S (DVBCT,DVBE1)=""
 . S DVBQ=0
 . F  S DVBE1=$O(DVBELIG(2.0361,DVBE1)) Q:'DVBE1!(DVBQ=1)  D
 . . I DVBELIG(2.0361,DVBE1,.01,"I")'=+^DPT(DFN,"E",0) S DVBOH=DVBELIG(2.0361,DVBE1,.01,"E") S DVBQ=1
 W $S($G(DVBOH)]"":$E(DVBOH,1,18),1:"")
 W !!,DVBON,"(2)",DVBOFF," Pat. Type: ",$E(DVBDIQ(2,DFN,391,"E"),1,20) X DVBLIT1
 W ?36,"Vet.(Y/N)?: ",DVBDIQ(2,DFN,1901,"E")
 W !,?4,"Ser. Con.: ",DVBDIQ(2,DFN,.301,"E")
 ;W ?40,"Ser. Con. %: ",DVBDIQ(2,DFN,.302,"E")
 W ?36,"Elig. Code: ",$E(DVBDIQ(2,DFN,.361,"E"),1,30)
 W !!,DVBON,"(3)",DVBOFF,"     A&A: ",DVBDIQ(2,DFN,.36205,"E") X DVBLIT1
 ;W ?18,"Amt.: $",$E(DVBDIQ(2,DFN,.3621,"E"),1,11)
 W ?41,"VA Pension: ",DVBDIQ(2,DFN,.36235,"E")
 ;W ?58,"Amt.: $",$E(DVBDIQ(2,DFN,.3624,"E"),1,11)
 W !,"House Bound: ",DVBDIQ(2,DFN,.36215,"E")
 ;W ?18,"Amt.: $",$E(DVBDIQ(2,DFN,.3622,"E"),1,11)
 W ?38,"VA Disability: ",DVBDIQ(2,DFN,.3025,"E")
 ;W ?58,"Amt.: $",$E(DVBDIQ(2,DFN,.303,"E"),1,11)
 W !,"Tot.Ann. VA Check Amt.: $",DVBDIQ(2,DFN,.36295,"E")
 S NEW=DVBDIQ(2,DFN,.01,"E"),NEW2=DVBDIQ(2,DFN,.09,"E") K DVBDIQ
 S DVBDIQ(2,DFN,.01,"E")=NEW,DVBDIQ(2,DFN,.09,"E")=NEW2 K NEW,NEW2 Q
LINE W !,"------------------------------------------------------------------------------"
