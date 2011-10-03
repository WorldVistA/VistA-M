PSDPATI ;B'ham ISC/BJW - Patient/Location Inquiry ; 11 Feb 98
 ;;3.0; CONTROLLED SUBSTANCES ;**8**;13 Feb 97
 ;**Y2K compliance**,"P" added to date input string
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 I '$D(^XUSEC("PSD ERROR",DUZ)) W $C(7),!!,"Contact your Pharmacy Coordinator for access to display the",!,"Patient/Location data.",!!,"PSD ERROR security key required.",! Q
PAT ;ask patient
 K DA,DIC S DIC=2,DIC(0)="QEAMZ",DIC("A")="Select Patient Name: "
 D ^DIC K DIC G:Y<0 END  S DFN=+Y,PSDPAT=$P(Y,"^",2)
DATE ;ask date
 K DA,%DT S %DT="AEPT",%DT("A")="Enter Date of Stay: "
 D ^%DT K %DT G:Y<0 END S VAINDT=+Y X ^DD("DD") S PSDT=Y
INQ ;patient inquire
 D INP^VADPT W @IOF,?15,"Patient Inquiry",!!,"Patient: ",PSDPAT,!,"Date of Stay: ",PSDT,!,"Ward Location: ",$P(VAIN(4),"^",2),!,"Room-Bed: ",$P(VAIN(5),"^"),!
 D KVAR^VADPT K VA
 G PAT
END ;kills variables
 K %DT,DA,DIC,DTOUT,DUOUT,PSDT,PSDPAT,X,Y
 Q
