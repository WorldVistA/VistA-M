PSOUTLA ;BHAM ISC/AMC - pharmacy utility program ; 07/24/96  1:13 pm
 ;;7.0;OUTPATIENT PHARMACY;**1,15,23,56,126,222**;DEC 1997;Build 12
 ;External reference ^PS(54 supported by DBIA 2227
 ;External reference ^PSDRUG( supported by DBIA 221
CHK I '$D(PY(PSPR)) W !?10,$C(7),"  # ",PSPR," is not a valid choice." S PSPOP=1 Q
 I $D(PSDUP(PY(PSPR))) W !?10,$C(7),"RX# ",$P(^PSRX(+$P(PY(PSPR),"^"),0),"^")," is a duplicate choice." S PSPOP=1 Q
 S PSDUP(PY(PSPR))="" Q:'PSODIV  Q:'$P(^PSRX(+PY(PSPR),2),"^",9)  Q:+$P(^(2),"^",9)=PSOSITE
 S PSPRXN=+$P(PY(PSPR),"^")
CHK1 I '$P(PSOSYS,"^",2) W !!,$C(7),"RX# "_$P(^PSRX(PSPRXN,0),"^")_" is not a valid choice. (Different Division)",! S PSPOP=1 Q
 I $P(PSOSYS,"^",3) K DIR,DUOUT,DTOUT D
 .W $C(7) S DIR("A",1)="",DIR("A",2)="RX# "_$P(^PSRX(PSPRXN,0),"^")_" is from another division.",DIR("A")="Continue: (Y/N)",DIR(0)="Y",DIR("?",1)="'Y' FOR YES",DIR("?")="'N' FOR NO"
 .S DIR("B")="N" D ^DIR I 'Y!($D(DUOUT))!($D(DTOUT)) S PSPOP=1 W !
 K DIR,DUOUT,DTOUT Q
 ;
ZIPIN ; input transform for ZIP field in file #59 internal format (no '-'s)
 ;  Input:  X as user entered value
 ; Output:  X as internal value of user input OR
 ;            undefined if input from user was invalid
 N % I X'?.N F %=1:1:$L(X) I $E(X,%)?1P S X=$E(X,0,%-1)_$E(X,%+1,20),%=%-1
 I X'?5N,(X'?9N) K X
 Q
 ;
ZIPOUT ; output transform for ZIP - prints either ZIP or ZIP+4 (in 12345-1234)
 ; format.
 ; Input:  Y internal value
 ; Output:  Y external (12345 or 12345-1234)
 S Y=$E(Y,1,5)_$S($E(Y,6,9)]"":"-"_$E(Y,6,9),1:"")
 Q
YN ;YES/NO PROMPT
 W !?5,"'Y' FOR YES",!?5,"'N' FOR NO",!
 Q
DAYS K PSFMAX S ED=1,PSODEA=$P(^PSDRUG($P(^PSRX(DA,0),"^",6),0),"^",3),PSDAYS=$P(^PSRX(DA,0),"^",8),CS=0 D EDNEW K:ED PSFMAX,ED
 K:$P(^PSRX(DA,0),"^",9)'>MAX PSMAX
 Q
EDNEW K PSMAX,PSFMAX F DEA=1:1 Q:$E(PSODEA,DEA)=""  I $E(+PSODEA,DEA)>1,$E(+PSODEA,DEA)<6 S CS=1
 I $D(CLOZPAT) S MAX=$S(CLOZPAT=2&(PSDAYS=14):1,CLOZPAT=2&(PSDAYS=7):3,CLOZPAT=1&(PSDAYS=7):1,1:0) G CLOZPAT
 I CS D
 .S PSOX1=$S(PTRF>5:5,1:PTRF),PSOX=$S(PSOX1=5:5,1:PSOX1)
 .S PSOX=$S('PSOX:0,PSDAYS=90:1,1:PSOX),PSDY1=$S(PSDAYS<60:5,PSDAYS'<60&(PSDAYS'>89):2,PSDAYS=90:1,1:0) S MAX=$S(PSOX'>PSDY1:PSOX,1:PSDY1)
 E  D
 .S PSOX1=PTRF,PSOX=$S(PSOX1=11:11,1:PSOX1),PSOX=$S('PSOX:0,PSDAYS=90:3,1:PSOX)
 .S PSDY1=$S(PSDAYS<60:11,PSDAYS'<60&(PSDAYS'>89):5,PSDAYS=90:3,1:0) S MAX=$S(PSOX'>PSDY1:PSOX,1:PSDY1)
CLOZPAT I PSRF>MAX D
 .W $C(7),!!,PSRF_" refills are not correct for a "_PSDAYS_" day supply.",!,"Please enter correct # of refills for a "_PSDAYS_" day supply. Max refills allowed is "_MAX_".",!
 .;S (PSMAX("MAX"),PSFMAX("MAX"))=MAX,(PSMAX("RF"),PSFMAX("RF"))=PSRF,(PSMAX("DAYS"),PSFMAX("DAYS"))=PSDAYS,(PSMAX,PSFMAX)=1
 K PSTMAX D EDSTAT
 Q
STATDAY K PSMAX,PSRMAX,PSFMAX,PSTMAX S PSDAYS=$P(^PSRX(DA,0),"^",8),PSRF=$P(^PSRX(DA,0),"^",9),PTST=$P(^PS(53,X,0),"^"),PTDY=$P(^(0),"^",3),PTRF=$P(^(0),"^",4)
EDSTAT I PSRF>PTRF D EN^DDIOL(PSRF_" refills are greater than "_PTRF_" allowed for "_$P(PTST,"^")_" Rx Patient Status.","","$C(7),!") D EN^DDIOL(" ","","!") ;S PSTMAX=1,PSTMAX("PTRF")=PTRF,PSTMAX("PSRF")=PSRF,PSTMAX("PT")=$P(PTST,"^")
 Q
PARKILL S CNT=0 F SUB=0:0 S SUB=$O(^PSRX(DA(1),"A",SUB)) Q:'SUB  S CNT=SUB
 I '$G(RESK) D  G:$D(DIRUT) PARKILL
 .D EN^DDIOL(" ","","!") K DIR S DIR(0)="FO^10:75",DIR("A",1)="Enter Reason for Edit:",DIR("A")="=>",DIR("?",1)="This is a required response.  No Up-arrowing allowed."
 .S DIR("?")="Response must be 10-75 characters in length.",DIR("B")="Entered In Error"
 .D ^DIR I $D(DIRUT) D EN^DDIOL("This is a required response.  No Up-arrowing allowed.","","!") Q
 .S ACOM=$S($G(Y)]""&('$D(DIRUT)):Y,1:"Partial Entered In Error.")
 .S PSOPRZ=$G(PSOPRZ)-1 S:PSOPRZ<0 PSOPRZ=0
 S:$G(RESK) ACOM="Partial fill returned to stock."
 D NOW^%DTC S CNT=CNT+1 S ^PSRX(DA(1),"A",0)="^52.3DA^"_CNT_"^"_CNT,^PSRX(DA(1),"A",CNT,0)=%_"^D^"_DUZ_"^6^"_ACOM K CNT,SUB,DIR,DTOUT,DUOUT
 Q
SETUP ;enter/edit clinic sort groups
 W ! S (DLAYGO,DIC,DIE)=59.8,DIC("A")="Select Clinic Sort Group: ",DIC(0)="AEQML" D ^DIC G:"^"[$E(X) SETUPX G:Y<1 SETUP S DA=+Y,DR=".01;1" D ^DIE
SETUPX K DIE,DIC,DA,DLAYGO,Y,X,DR
 Q
FSIG(PSOFILE,PSOINTR,PSOLENTH) ;Format front door sig
 ;PSOFILE is 'P' if in Pending File, 'R' if in Prescription File
 ;PSOINTR is internal number for either file
 ;PSOLENTH is length of each line of the Sig
 ;returned in the FSIG array
 K FSIG I $G(PSOFILE)=""!('$G(PSOINTR))!('$G(PSOLENTH)) G FQUIT
 I PSOFILE'="P",PSOFILE'="R" G FQUIT
 I PSOFILE="P",'$D(^PS(52.41,+PSOINTR,0)) G FQUIT
 I PSOFILE="R",'$D(^PSRX(+PSOINTR,0)) G FQUIT
 I PSOFILE="R",'$P($G(^PSRX(+PSOINTR,"SIG")),"^",2) G FQUIT
 N FFF,NNN,CNT,FVAR,FVAR1,FLIM,HSIG,II
 I PSOFILE="P" F NNN=0:0 S NNN=$O(^PS(52.41,PSOINTR,"SIG",NNN)) Q:'NNN  S:$G(^(NNN,0))'="" HSIG(NNN)=^(0)
 I PSOFILE="P" G:'$O(HSIG(0)) FQUIT G FSTART
 ;S HSIG(1)=$P($G(^PSRX(PSOINTR,"SIG")),"^") S FFF=2 F NNN=0:0 S NNN=$O(^PSRX(PSOINTR,"SIG1",NNN)) Q:'NNN  I $G(^(NNN,0))'="" S HSIG(FFF)=$G(^(0)),FFF=FFF+1
 S FFF=1 F NNN=0:0 S NNN=$O(^PSRX(PSOINTR,"SIG1",NNN)) Q:'NNN  I $G(^(NNN,0))'="" S HSIG(FFF)=^(0) S FFF=FFF+1
 G:'$O(HSIG(0)) FQUIT
FSTART S (FVAR,FVAR1)="",II=1
 F FFF=0:0 S FFF=$O(HSIG(FFF)) Q:'FFF  S CNT=0 F NNN=1:1:$L(HSIG(FFF)) I $E(HSIG(FFF),NNN)=" "!($L(HSIG(FFF))=NNN) S CNT=CNT+1 D  I $L(FVAR)>PSOLENTH S FSIG(II)=FLIM_" ",II=II+1,FVAR=FVAR1
 .S FVAR1=$P(HSIG(FFF)," ",(CNT))
 .S FLIM=FVAR
 .S FVAR=$S(FVAR="":FVAR1,1:FVAR_" "_FVAR1)
 I $G(FVAR)'="" S FSIG(II)=FVAR
 I $G(FSIG(1))=""!($G(FSIG(1))=" ") S FSIG(1)=$G(FSIG(2)) K FSIG(2)
FQUIT Q
DRUGW ;
 F Z0=1:1 Q:$P(X,",",Z0,99)=""  S Z1=$P(X,",",Z0) W:$D(^PS(54,Z1,0)) ?35,$P(^(0),"^"),! I '$D(^(0)) W ?35,"NO SUCH WARNING LABEL" K X Q
 Q
HLNEW ;formats provider instructions in FSIG for front door order
 K FSIG N FFF,NNN,CNT,FVAR,FVAR1,FLIM,HSIG,II,LLP,PSOLENTH
 S PSOLENTH=59,LLP=1 F LLL=0:0 S LLL=$O(WPARRAY(7,LLL)) Q:'LLL  S HSIG(LLP)=$G(WPARRAY(7,LLL)),LLP=LLP+1
 D FSTART Q
HLNEWX ;
 K FSIG N FFF,NNN,CNT,FVAR,FVAR1,FLIM,HSIG,II,LLP,PSOLENTH
 S PSOLENTH=59,LLP=1 F LLL=0:0 S LLL=$O(WPARRAY(6,LLL)) Q:'LLL  S HSIG(LLP)=$G(WPARRAY(6,LLL)),LLP=LLP+1
 D FSTART Q
 ;
SUSFDS ;
 N SUSIEN
 Q:$O(^PSRX(DA,1,0))
 S SUSIEN=+$O(^PS(52.5,"B",DA,0)) Q:'$G(SUSIEN)
 Q:'$D(^PS(52.5,SUSIEN,0))!($G(^PS(52.5,SUSIEN,"P")))
 I '$P($G(^PS(52.5,SUSIEN,0)),"^",5),'$P($G(^(0)),"^",13) S $P(^PS(52.5,SUSIEN,0),"^",2)=X,^PS(52.5,"C",X,SUSIEN)="" D
 .I $P($G(^PS(52.5,SUSIEN,0)),"^",7)="Q" S ^PS(52.5,"AQ",X,+$P($G(^PS(52.5,SUSIEN,0)),"^",3),SUSIEN)="" D SCMPX^PSOCMOP(SUSIEN,"Q") Q
 .S ^PS(52.5,"AC",+$P($G(^PS(52.5,SUSIEN,0)),"^",3),X,SUSIEN)=""
 Q
SUSFDK ;
 N SUSIEN
 Q:$O(^PSRX(DA,1,0))
 S SUSIEN=+$O(^PS(52.5,"B",DA,0)) Q:'$G(SUSIEN)
 Q:'$D(^PS(52.5,SUSIEN,0))!($G(^PS(52.5,SUSIEN,"P")))
 I '$P($G(^PS(52.5,SUSIEN,0)),"^",5),'$P($G(^(0)),"^",13) K ^PS(52.5,"C",X,SUSIEN) D
 .I $P($G(^PS(52.5,SUSIEN,0)),"^",7)="Q" K ^PS(52.5,"AQ",X,+$P($G(^PS(52.5,SUSIEN,0)),"^",3),SUSIEN) D KCMPX^PSOCMOP(SUSIEN,"Q") Q
 .K ^PS(52.5,"AC",+$P($G(^PS(52.5,SUSIEN,0)),"^",3),X,SUSIEN)
 Q
