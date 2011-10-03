PSGOENG ;BIR/CML3-MARK ORDER AS 'NOT TO BE GIVEN' ;22 SEP 97 / 1:33 PM 
 ;;5.0; INPATIENT MEDICATIONS ;**58**;16 DEC 97
 ;
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ;
 I +$G(PSJORD)'>0 W !!," Option only available on Order View screens." H 2 G OUT
 I $G(PSJORD)["V" W !," Can't mark IV orders as NOT TO BE GIVEN!" H 2 G OUT
 N PSJRPH S PSJRPH=$D(^XUSEC("PSJU MGR",DUZ))!($D(^XUSEC("PSJ RPHARM",DUZ)))
 I 'PSJRPH W !," Only pharmacists can mark orders Not To Be Given" H 2 G OUT
 I PSJORD["P"!("D_E_DE_DR"'[$P($G(^PS(55,PSGP,5,+PSJORD,0)),"^",9)) D  H 2 G OUT
 .W !," Only Discontinued or Expired orders may be marked as Not To Be Given."
 I $P($G(^PS(55,PSGP,5,+PSJORD,.2)),U,4)="D",'$P($G(^(4)),"^",3) D  H 2 G OUT
 .W !,"Orders with a priority of done and not verified by a pharmacist may not",!,"be marked as Not To Be Given."
 F  W !!,"DO YOU WANT TO MARK THIS ORDER AS 'NOT TO BE GIVEN'" S %=2 D YN^DICN Q:%  W !!,"If you answer 'YES', this order will be marked as 'NOT TO BE GIVEN'.  Orders",!,"so marked cannot be renewed, reinstated, or copied."
 I %=1 D
 .S $P(^PS(55,PSGP,5,+PSJORD,0),"^",22)=1,PSGACT=$P(PSGACT,"N")_$P(PSGACT,"N",2),PSGOENG=1,DA(1)=PSGP,DA=+PSJORD,PSGAL("C")=23000 D ^PSGAL5 S:PSGACT["R" PSGACT=$P(PSGACT,"R")_$P(PSGACT,"R",2)
 .;I ($P($G(^PS(55,PSGP,5,+PSJORD,0)),"^",21)) D EN1^PSJHL2(PSGP,"XX",PSJORD,"NOT TO BE GIVEN") K DA,PSGAL
 E  W "  No Change made."
OUT S VALMBCK="R"
 Q
