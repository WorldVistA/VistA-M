SDROUT ;BSN/GRR - ROUTING SLIPS ; 26 APR 84  11:26 am
 ;;5.3;Scheduling;**3,39,377**;Aug 13, 1993
 N VAUTC,SDPLSRT,SDMATCH
 S (SDIQ,SDX,DIV,SDREP,SDSTART)="" D DIV^SDUTL I $T D ROUT^SDDIV G:Y<0 END
R1 S %=2 W !,"DO YOU WANT ROUTING SHEET FOR A SINGLE PATIENT" D YN^DICN I '% D QQ G R1
 G:%<0 END S SDSP=$S(%=2:"N",1:"Y") G:SDSP["Y" SIN1^SDROUT1
R2 R !,"WANT (A)LL ROUTING SHEETS OR (O)NLY ADD-ONS: ONLY ADD-ONS// ",X:DTIME G:X["^"!('$T) END I X="" S X="O" W X
 S Z="^ALL ROUTING SHEETS^ONLY ADD-ONS" D IN^DGHELP I %=-1 W !?12,"CHOOSE FROM:",!?12,"O - To only see add-ons",!?9,"or A - To see all routing sheets" G R2
 S SDX=$S(X="O":"ADD-ONS",1:"ALL")
R22 S ORDER=0,DIR(0)="S^T:TERMINAL DIGIT;N:NAME;C:CLINIC;P:PHYSICAL LOCATION",DIR("B")="T",DIR("A")="PRINT IN",DIR("?")="^D HELP^SDROUT" D ^DIR
 G:Y<0!$D(DTOUT)!$D(DIROUT)!$D(DIRUT) R2
 S X=Y K DIR,DTOUT,DIROUT,DIRUT
R4 S ORDER=$S(X="T":1,X="N":"",X="P":3,1:2)
 ;
RPL I ORDER=3 D
 .S DIR("?")="Enter Physical Location to sort by. Must be an exact match"
 .S DIR("??")="Enter Physical Location to sort by. Must be an exact matchas this is a Free Text field."
 .S DIR(0)="F^1:25",DIR("A")="ENTER PHYSICAL LOCATION TO SORT BY"
 .S DIR("B")="ALL" D ^DIR
 I ORDER=3,Y<0!$D(DTOUT)!$D(DIROUT)!$D(DIRUT) Q
 I ORDER=3 S SDPLSRT=X
 I ORDER=3,$$PLVAL'=1 W !,"Not an exact match!" G RPL
 I ORDER=3 K DIR,DTOUT,DIROUT,DIRUT
 ;
 D:'$D(DT) DT^SDUTL S %DT="AEXF",%DT("A")="PRINT ROUTING SLIPS FOR WHAT DATE: " D ^%DT K %DT("A") G:Y<1 END S SDATE=Y
A5 S %=2 W !,"IS THIS A REPRINT OF A PREVIOUS RUN" D YN^DICN I '% D QQ G A5
 Q:%<0  I '(%-1) S POP=0 D REP^SDROUT1 Q:POP
 I ORDER=2,SDREP="" G END:'$$CLINIC(DIV,.VAUTC)
 I ORDER=3,SDREP="" G END:'$$CLINIC(DIV,.VAUTC)
 S VAR="DIV^VAUTC^VAUTC(^SDX^ORDER^SDATE^SDIQ^SDREP^SDSTART^SDLOC^SDPLSRT"
 S DGPGM="START^SDROUT"
 D ZIS^DGUTQ G:POP END^SDROUT1
 G START
START K ^UTILITY($J) U IO
 S Y=SDATE D DTS^SDUTL S APDATE=Y,Y=DT D DTS^SDUTL S PRDATE=Y
 F SC=0:0 S SC=$O(^SC(SC)) Q:SC<1  D CHECK I $T S GDATE=SDATE F K=0:0 S GDATE=$O(^SC(SC,"S",GDATE)) Q:GDATE<1!(GDATE>(SDATE+1))  I $D(^SC(SC,"S",GDATE,1)) F L=0:0 S L=$O(^SC(SC,"S",GDATE,1,L)) Q:L<1  I $D(^(L,0)),$P(^(0),U,9)'="C" D GOT^SDROUT0
 G GO^SDROUT0
CHECK I $P(^SC(SC,0),"^",3)="C",$S(DIV="":1,$P(^SC(SC,0),"^",15)=DIV:1,1:0),$S('$D(^SC(SC,"I")):1,+^("I")=0:1,+^("I")>SDATE:1,+$P(^("I"),"^",2)'>SDATE&(+$P(^("I"),"^",2)):1,1:0)
 I $T,$S(ORDER'=2:1,SDREP:1,VAUTC=1:1,1:$D(VAUTC(SC)))
 Q
QQ W !,"RESPOND YES OR NO" Q
END K VAUTC,ALL,DIV,ORD,ORDER,RMSEL,SDIQ,SDREP,SDSP,SDSTART,SDX,X,Y,C,V,I,SDEF,%I Q
 ;
CLINIC(SDIV,VAUTC) ;
 N DIV,SDX,ORDER,SDATE,SDIQ,SDREP,SDSTART,VAUTD
 I 'SDIV S VAUTD=1
 I SDIV S VAUTD=0,VAUTD(SDIV)=$P($G(^DG(40.8,SDIV,0)),U)
 Q $$CLINIC1()
 ;
CLINIC1() ; -- get clinic data
 ;  input: VAUTD  := divisions selected
 ; output: VAUTC := clinic selected (VAUTC=1 for all)
 ; return: was selection made [ 1|yes   0|no]
 ;
 W !!,$$LINE^SDAMO("Clinic Selection")
 ;
 ; -- select clinics
 ; -- call generic clinic screen, correct division
 ;
 S DIC("S")="I $$CLINIC2^SDROUT(Y),$S(VAUTD:1,$D(VAUTD(+$P(^SC(Y,0),U,15))):1,'+$P(^(0),U,15)&$D(VAUTD(+$O(^DG(40.8,0)))):1,1:0)"
 S DIC="^SC(",VAUTSTR="clinic",VAUTVB="VAUTC",VAUTNI=2
 D FIRST^VAUTOMA
 ;
 I Y<0 K VAUTC
CLINICQ Q $D(VAUTC)>0
 ;
CLINIC2(SDCL) ; -- generic screen for hos. loc. entries
 ; input:   SDCL := ifn of HOSPITAL LOCATION file
 ;      returned := [ 0 | do not use entry ; 1 | use entry ]
 ;
 ; -- must be a clinic
 N X S X=$G(^SC(SDCL,0))
 Q $P(X,"^",3)="C"
 ;
PLVAL() ; Physical Location Validation.
 N SDCLIN,SDPLOC
 S SDMATCH=0
 I SDPLSRT="ALL" S SDMATCH=1 Q SDMATCH
 S SDCLIN="" F  S SDCLIN=$O(^SC(SDCLIN)) Q:SDCLIN=""!(SDMATCH=1)  D
 .S SDPLOC=$P($G(^SC(SDCLIN,0)),"^",11)
 .I SDPLOC=SDPLSRT S SDMATCH=1
 Q SDMATCH
HELP W !?12,"CHOOSE FROM:",!?12,"T - To see routing slips sorted in terminal digit order",!?12,"N - To see routing slips sorted in alphabetical order by name",!?12,"C - To see routing slips printed by clinic " D
 .W !,?12,"or P - To see routing slip printed by physical location"
