FHVER ; HISC/REL - Dietetics Version ;2/15/95  15:45 
 ;;5.5;DIETETICS;;Jan 28, 2005
 S U="^" S:'$D(FHA1) FHA1=0 S:'$D(DTIME) DTIME=9999 D DT^DICRW
 K %ZIS S IOP="" D ^%ZIS K %ZIS,IOP
 I FHA1=1 W @IOF,!!?20,"D I E T E T I C S   M A N A G E M E N T",!! G VER
 I FHA1=2 W @IOF,!!?22,"C L I N I C A L   D I E T E T I C S",!! G VER
 I FHA1=3 W @IOF,!!?25,"D I E T E T I C   O R D E R S",!! G VER
 I FHA1=4 W @IOF,!!?17,"D I E T E T I C   A D M I N I S T R A T I O N",!! G VER
 I FHA1=5 W @IOF,!!?21,"C L I N I C A L   M A N A G E M E N T",!! G VER
 I FHA1=6 W @IOF,!!?16,"D I E T E T I C   P A T I E N T   P R O F I L E",!! G VER
 I FHA1=7 W @IOF,!!?25,"F O O D   P R O D U C T I O N",!! G VER
 I FHA1=8 W @IOF,!!?5,"A N N U A L   D I E T E T I C   R E P O R T   M A N A G E M E N T",!! G VER
 K FHA1,VER Q
VER S VER=$P($T(FHVER+1),";",3) W ?34,"Version ",VER,!!! K VER,FHA1 Q
