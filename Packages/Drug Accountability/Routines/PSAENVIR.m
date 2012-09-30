PSAENVIR ;BIR/JMB-Environment Check ;9/6/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;; 10/24/97
 ;
1 ;CS not installed or not V. 3.0 or greater
 S Y=$$VERSION^XPDUTL("PSD")
 I Y<3 D
 .W !!,"Controlled Substances V. 2.0 or greater must be installed before installing",!,"Drug Accountability. After you install the correct version and setup a",!,"master vault, you can install Drug Accountability." S XPDABORT=1
 I '$$PATCH^XPDUTL("PSD*3.0*6") W !,"Patch PSD*3.0*6 must be installed before installing Drug Accountability.",! S XPDABORT=1
 ;
2 ;PDM not installed or not V. 1.0
 S Y=$$VERSION^XPDUTL("PSS")
 I Y="" W !!,"Pharmacy Data Management V. 1.0 or greater must be installed before",!,"installing Drug Accountability." S XPDABORT=1
 ;
3 ;Kernel not V. 8.0
 S Y=+$$VERSION^XPDUTL("XU")
 I Y<8 W !!,"Kernel V. 8.0 or greater must be installed before installing Drug",!,"Accountability." S XPDABORT=1
 ;
4 ;Toolkit not installed or not V. 7.2
 S Y=+$$VERSION^XPDUTL("XT")
 I Y<7.2 W !!,"Toolkit V. 7.2 or greater must be installed before installing Drug",!,"Accountability." S XPDABORT=1
 ;
5 ;PSN not installed or not V. 3.16
 S Y=+$$VERSION^XPDUTL("PSN")
 I Y<3.16 W !!,"National Drug File V. 3.16 or greater must be installed before installing",!,"Drug Accountability." S XPDABORT=1
 ;
6 ;No master vault.
 I '$O(^PSD(58.8,"ADISP","M",0)) D
 .W !!,"A master vault must be set up in the Controlled Substances package before",!,"installing Drug Accountability. After you have set up a master vault, you",!,"can install Drug Accountability."
 .S XPDABORT=1
 K Y
 Q
