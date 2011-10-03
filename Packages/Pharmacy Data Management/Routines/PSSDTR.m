PSSDTR ;BIR/EJW-Print Drug Text Report ;
 ;;1.0;PHARMACY DATA MANAGEMENT;**55**;9/30/97
 ;
 ;Reference to $$FORMRX^PSNAPIS(DA,K,.LIST) supported by DBIA #2574
 ;
 W !!,"This report shows each selected drug text entry and lists all drugs",!,"and orderable items linked to it."
EN ;
 K PSSHOW,PSSBEG,PSSEND,PSSNUMBX,PSSSRT
 K DIR S DIR(0)="S^A:ALL;S:SINGLE ENTRY OR RANGE",DIR("B")="S",DIR("A")="Print for (A)ll or (S)elect Single Entry or Range" D
 .S DIR("?")=" ",DIR("?",1)="Enter 'A' for all drug text entries,",DIR("?",2)="or 'S' to select single entry or range."
 D ^DIR K DIR I Y["^"!($D(DTOUT))!($D(DUOUT)) W !!,"Nothing queued to print.",! G DONE
 S PSSHOW=Y I PSSHOW="A" S PSSBEG="",PSSEND="Z" S PSSSRT="A" G TASK
 ;
 S PSSNUMB="" F  S PSSNUMB=$O(^PS(51.7,"B",PSSNUMB)) Q:'PSSNUMB!($G(PSSNUMBX))  S PSSNUMBX=1
 I $G(PSSNUMBX) K DIR S DIR(0)="Y",DIR("A")="Print report for drug text entries with leading numerics",DIR("B")="N" D  D ^DIR K DIR I Y["^"!($D(DUOUT))!($D(DTOUT)) W !!,"Nothing queued to print.",! G DONE
 .W !!!,"There are drugs in the drug text file with leading numerics.",!
 .S DIR("?")=" ",DIR("?",1)="There are some entries in the drug text file with leading numerics.",DIR("?",2)="Enter Yes to print the report for those entries.",DIR("?",3)=" "
 I $G(PSSNUMBX),$G(Y)=1 S PSSSRT="N" G TASK
 K PSSNUMB,PSSNUMBX
ASKA K PSSBEG,PSSEND
 W !!,"Enter a single drug text entry or to see all drug text entries beginning with"
 W !,"the letter 'A' for example, enter 'A' or whichever letter you wish to see."
 W !,"To see drug text entries in a range for example starting with 'H', 'I' and 'J'"
 W !,"enter in the format 'H-J'.",!
 S DIR("?",1)=" ",DIR("?",2)="Enter a single drug text entry or enter a letter, 'A', 'B', etc., to see",DIR("?",3)="entries beginning with that letter or to see a range of drug text entries"
 S DIR("?",4)="enter 'A-C', 'G-M', etc.",DIR("?",5)=" ",DIR("?")=" "
 S DIR("A")="Enter a single entry or select a range",DIR(0)="F^1:100" D ^DIR K DIR I Y["^"!($D(DTOUT))!($D(DUOUT)) W !!,"Nothing queued to print.",! G DONE
 S PSSXX=Y
 I PSSXX'?1U&(PSSXX'?1U1"-"1U)&(PSSXX'?1L)&(PSSXX'?1L1"-"1L) I PSSXX'="",'$D(^PS(51.7,"B",PSSXX)) D  W ! G ASKA
 . W !!,"Invalid response." W $S($L(PSSXX)>1&(PSSXX'["-"):" Entry not found.",1:" Enter a single entry, or a letter, 'A', 'B', etc., or a range.")
 I PSSXX["-" S PSSBEG=$P(PSSXX,"-"),PSSEND=$P(PSSXX,"-",2) I $A(PSSEND)<$A(PSSBEG) W !!,"Invalid response.",! G ASKA
 I PSSXX'["-" S PSSBEG=PSSXX,PSSEND=PSSXX
 S PSSSRT="X"
TASK ;
 I PSSSRT="X",$L(PSSXX)>1,PSSXX'["-" S PSSSRT="S" ; single entry
 I PSSSRT="X" W !!,"Report will be for drug text starting with "_$G(PSSBEG)_",",!,"and ending with drug text starting with "_$G(PSSEND)_".",!
 I PSSSRT="N" W !!,"This report will be for drug text with leading numerics.",!
 I PSSSRT="A" W !!,"This report will be for all drug text entries.",!
 I PSSSRT="S" W !!,"This report will be for drug text entry: ",PSSXX,!
 K DIR S DIR(0)="Y",DIR("A")="Is this correct",DIR("B")="Y" D ^DIR K DIR I Y'=1 W ! G EN
 I PSSSRT="X",$L(PSSXX)>1,PSSXX'["-" S PSSSRT="S" ; single entry
RPT W !!,"You may queue the report to print, if you wish.",!
 K PSSFIRST
 ;
DVC K %ZIS,POP,IOP S %ZIS="QM" D ^%ZIS I $G(POP) W !!,"Nothing queued to print.",! G DONE
QUEUE I $D(IO("Q")) S ZTRTN="START^PSSDTR",ZTDESC="Drug Text File Report",ZTSAVE("PSSBEG")="",ZTSAVE("PSSEND")="",ZTSAVE("PSSSRT")="",ZTSAVE("PSSXX")="" D ^%ZTLOAD K %ZSI W !,"Report queued to print.",! G DONE
START ;
 U IO
 S PSSOUT=0,PSSDV=$S($E(IOST)="C":"C",1:"P")
 S PSSPGCT=0,PSSPGLN=IOSL-7,PSSPGCT=1
 D TITLE
 I PSSSRT="X" S PSSX=$A(PSSBEG)-1,PSSLCL=$C(PSSX)_"zzzz"
 I $G(PSSSRT)="N"!($G(PSSSRT)="A") S (PSSLCL,PSSEND)=""
 ;
 I PSSSRT'="S" F  S PSSLCL=$O(^PS(51.7,"B",PSSLCL)) Q:$S(PSSSRT="N"&('PSSLCL):1,PSSSRT="X"&(PSSLCL](PSSEND_"zzzz")):1,1:0)!(PSSLCL="")!($G(PSSOUT))  D DTXTRPT
 I PSSSRT="S",PSSBEG'="" S PSSLCL=PSSBEG I $D(^PS(51.7,"B",PSSLCL)) D DTXTRPT
 G END
DTXTRPT F PSSB=0:0 S PSSB=$O(^PS(51.7,"B",PSSLCL,PSSB)) Q:'PSSB  D
 . I $G(^PS(51.7,PSSB,0))'="" D DTNAME D FULL Q:($G(PSSOUT))  D DTEXT Q:$G(PSSOUT)  D OITEXT I $G(PSSOUT) Q
 D FULL I $G(PSSOUT) Q
 W ! F MJT=1:1:70 W "-"
 W !
 Q
DTNAME D FULL Q:$G(PSSOUT)  W !,"DRUG TEXT NAME:  ",PSSLCL
 D FULL2 Q:($G(PSSOUT))  S Y=+$P($G(^PS(51.7,PSSB,0)),"^",2) I Y>0 X ^DD("DD") W !,?3,"** INACTIVE DATE:  ",Y," **",!
 N PSSSYN
 ; print synonyms, if any
 I $O(^PS(51.7,PSSB,1,0))?1.N D FULL Q:(PSSOUT)  D
 . W !,?3,"SYNONYM(S):  "
 . S PSSSYN=0 F  S PSSSYN=$O(^PS(51.7,PSSB,1,PSSSYN)) Q:'PSSSYN  D FULL Q:$G(PSSOUT)  W ?17,^PS(51.7,PSSB,1,PSSSYN,0),!
 ; print drug text
 N PSSTXT
 D FULL2 I $G(PSSOUT) Q
 W !!,?3,"DRUG TEXT:"
 S PSSTXT=0 F  S PSSTXT=$O(^PS(51.7,PSSB,2,PSSTXT)) Q:'PSSTXT  D FULL Q:$G(PSSOUT)  W !,?3,^PS(51.7,PSSB,2,PSSTXT,0)
 D NRESTR
 Q
 ;
DTEXT ;
 D FULL2 I $G(PSSOUT) Q
 W !!,?3,"DRUG file entries:",!,?3,"-----------------"
 I $O(^PSDRUG("DTXT",PSSB,""))="" D FULL Q:$G(PSSOUT)  W !,?3,"NONE" Q
 S PSSDRG="" F  S PSSDRG=$O(^PSDRUG("DTXT",PSSB,PSSDRG)) Q:'PSSDRG  D FULL Q:($G(PSSOUT))  W !,?3,$P($G(^PSDRUG(PSSDRG,0)),"^",1) D
 . I $P($G(^PSDRUG(PSSDRG,"I")),"^",1)'="" D FULL Q:($G(PSSOUT))  S Y=+$P($G(^PSDRUG(PSSDRG,"I")),"^",1) I Y>0 X ^DD("DD") W !,?6,"** INACTIVE DATE:  ",Y," **",!
 Q
 ;
OITEXT ;
 N DFPTR
 D FULL2 Q:$G(PSSOUT)  W !!,?3,"ORDERABLE ITEM file entries:  " D
 . W !,?3,"---------------------------"
 I $O(^PS(50.7,"DTXT",PSSB,""))="" D FULL Q:$G(PSSOUT)  W !,?3,"NONE"
 S PSSDRG="" F  S PSSDRG=$O(^PS(50.7,"DTXT",PSSB,PSSDRG)) Q:'PSSDRG  D FULL Q:$G(PSSOUT)  W !,?3,$P($G(^PS(50.7,PSSDRG,0)),"^",1) D
 . S DFPTR=$P(^PS(50.7,PSSDRG,0),"^",2) W "  ",$P(^PS(50.606,DFPTR,0),"^",1)
 . I $P(^PS(50.7,PSSDRG,0),"^",4)'="" D
 . . D FULL Q:($G(PSSOUT))  S Y=+$P($G(^PS(50.7,PSSDRG,0)),"^",4) I Y>0 X ^DD("DD") W !,?6,"** INACTIVE DATE:  ",Y," **",!
 Q
 ;
NRESTR ; check for National Formulary Restrictions
 N PSXGN,PSXVP,PSXDN,DONE,XX2
 S DONE=0
 S PSSDRG="" F  S PSSDRG=$O(^PSDRUG("DTXT",PSSB,PSSDRG)) Q:'PSSDRG  D  Q:DONE
 .I $D(^PSDRUG(PSSDRG,"ND")) S PSXDN=$G(^PSDRUG(PSSDRG,"ND")),PSXGN=$P(PSXDN,"^"),PSXVP=$P(PSXDN,"^",3)
 .D FULL2 Q:$G(PSSOUT)  I $G(PSXGN),$G(PSXVP) S DONE=1 W !!,?3,"NATIONAL FORMULARY RESTRICTION TEXT:" S XX2=$$FORMRX^PSNAPIS(PSXGN,PSXVP,.LIST) I $G(XX2)=1,$D(LIST) F XX2=0:0 S XX2=$O(LIST(XX2)) Q:'XX2  D FULL Q:$G(PSSOUT)  W !,?3,LIST(XX2,0)
 K LIST
 Q
 ;
FULL ;
 I ($Y+5)>IOSL&('$G(PSSOUT)) D TITLE
 Q
 ;
FULL2 ;
 I ($Y+6)>IOSL&('$G(PSSOUT)) D TITLE
 Q
TITLE ;
 I $G(PSSDV)="C",$G(PSSPGCT)'=1 W ! K DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSSOUT=1 Q
 ;
 W @IOF D
 . I PSSSRT="N" W !,?16,"Drug Text Report for Drug Text entries with Leading Numerics",! Q
 . I PSSSRT="A" W !,?16,"Drug Text Report for all Drug Text entries",! Q
 . I PSSSRT="X" W !,?16,"Drug Text Report for drug text from "_PSSBEG_" through "_PSSEND,! Q
 . I PSSSRT="S" W !,?16,"Drug Text Report for drug text : "_PSSBEG,! Q
 S Y=DT X ^DD("DD") W !,"Date printed: ",Y,?70,"Page: ",PSSPGCT,!
 F MJT=1:1:79 W "="
 W !
 I $G(PSSFIRST)="" D
 . W !,"PLEASE NOTE: The National Formulary Restriction Text is the original text"
 . W !,"exported with the DRUG TEXT file (#51.7) and automatically linked to the DRUG"
 . W !,"file (#50) entries based on the VA product match. No ORDERABLE ITEM file"
 . W !,"(#50.7) entries were automatically linked with DRUG TEXT file (#51.7).",!
 . S PSSFIRST=1
 S PSSPGCT=PSSPGCT+1
 Q
END ;
 I '$G(PSSOUT),$G(PSSDV)="C" W !!,"End of Report." K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 I $G(PSSDV)="C" W !
 E  W @IOF
DONE ;
 K PSSB,PSSLCL,MJT,PSSPGCT,PSSPGLN,Y,DIR,INDT,PSSXX,X,OITM,IOP,POP,IO("Q"),DIRUT,DUOUT,DTOUT
 K PSSSRT,PSSDRG,PSSDV,PSSX,PSSOUT,PSSHOW,PSSBEG,PSSEND D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
