DVBHS6 ;ALB/JLU;Screen six of the HINQ screens ;10/4/91
 ;;4.0;HINQ;**11,49**;03/25/92 
EN ;Entry point from the edit template.
 ;with patch DVB*4*49 the income information will no longer be displayed
 ;this code is left here for historical purposes
 Q 
 N Y
 K DVBX(1)
 F LP2=.3623,.3628,.36285,.3629 S X="DVBDIQ(2,"_DFN_","_LP2_")" K @X
 I $D(X(1)) S DVBX(1)=X(1)
 S DIC="^DPT(",DA=DFN,DIQ(0)="E",DIQ="DVBDIQ("
 S DR=".36225;.3628;.36285;.3629"
 D EN^DIQ1
 I $D(DVBX(1)) S X(1)=DVBX(1) K DVBX(1)
 S DVBSCRN=6 D SCRHD^DVBHUTIL
 S DVBJS=64
 ;
 W !,?6,"Amount Earned Annual Income (SPOUSE): "
 W $S($D(DVBSPENC):"$"_DVBSPENC,1:"")
 W !,?1,"Amount of Annual Social Security (SPOUSE): "
 W $S($D(DVBSPSSA):"$"_DVBSPSSA,1:"")
 W !,?2,"Type of other Annual Retirement (SPOUSE): "
 I $D(DVBSPRET) S V=DVBSPRET D TR W V
 W !,"Amount of other Annual Retirement (SPOUSE): "
 W $S($D(DVBSPETO):"$"_DVBSPETO,1:"")
 W !,?4,"Amount of other Annual Income (SPOUSE): "
 W $S($D(DVBSPINC):"$"_DVBSPINC,1:"")
 W !!,?4,"Amount of Earned Annual Income (PAYEE): "
 W $S($D(DVBEINC):"$"_DVBEINC,1:"")
 ;
 ;W !!!,DVBON,"[1]",DVBOFF X DVBLIT1
 ;W ?4,"Amount Annual"
 ;W !,?6,"Soc. Sec. (PAYEE):"
 ;W ?26,"$",$S(+DVBDIQ(2,DFN,.3623,"E"):DVBDIQ(2,DFN,.3623,"E"),1:0)
 ;W ?48,$S($D(DVBSSA):"$"_DVBSSA,1:"")
 ;
 W !!!,DVBON,"[1]",DVBOFF X DVBLIT1
 W ?4,"Receiving Soc. Sec. (PAYEE):"
 ;W !,?6,"Soc. Sec. (PAYEE):"
 W ?33,DVBDIQ(2,DFN,.36225,"E")
 W ?48,$S($D(DVBSSA):$S(DVBSSA:"YES",1:"NO"),1:"NO")
 ;
 W !,DVBON,"[2]",DVBOFF X DVBLIT1
 W ?4,"Other Annual"
 W !,?13,"Retirement (PAYEE):"
 W ?26,DVBDIQ(2,DFN,.36285,"E")
 I $D(DVBRETT) S V=DVBRETT D TR W ?48,V
 ;
 W !,DVBON,"[3]",DVBOFF X DVBLIT1
 W ?4,"Amount Other Annual"
 W !,?13,"Retirement (PAYEE):"
 W ?26,"$",$S(+DVBDIQ(2,DFN,.3628,"E"):DVBDIQ(2,DFN,.3628,"E"),1:0)
 W ?48,$S($D(DVBRETO):"$"_DVBRETO,1:"")
 ;
 W !,DVBON,"[4]",DVBOFF X DVBLIT1
 W ?4,"Amount Other Annual"
 W !,?17,"Income (PAYEE):"
 W ?26,"$",$S(+DVBDIQ(2,DFN,.3629,"E"):DVBDIQ(2,DFN,.3629,"E"),1:0)
 W ?48,$S($D(DVBOINC):"$"_DVBOINC,1:"")
 Q
TR S V=$S(V="B":"BLACKLUNG",V="M":"MILITARY",V="C":"CIVIL SERVICE",V="R":"RAILROAD",V="O":"OTHER",V="X":"COMBINATION",1:V) Q
