PRC5C ;WISC/PLT-IFCAP environment check routine defined in package file ;
V ;;5.0;IFCAP;;4/21/95
 ;
 ;invoke by the environment check routine field of package file.
EN ;called from routine prcinit/prc5ins1
 N PRCERR,PRCMSG
 S (PRCERR,PRCMSG)=""
 D EN^DDIOL("IFCAP ENVIRONMENT CHECK STARTS:")
 D ^PRC5INS1 ;check other package(s) installed
 D:PRCIVER<5
 . D EN^PRC5C1("FND") S:$G(PRCERR) PRCMSG=PRCMSG_"1^",PRCERR=""
 . D EN^PRC5C1("PCL") S:$G(PRCERR) PRCMSG=PRCMSG_"2^",PRCERR=""
 . D EN^PRC5C1("PAC") S:$G(PRCERR) PRCMSG=PRCMSG_"3^",PRCERR=""
 . D EN1^PRC5C1 S:$G(PRCERR) PRCMSG=PRCMSG_"5^",PRCERR=""
 . QUIT
 D:PRCIVER<5&PRCIVER
 . D EN^PRC5C1("CPF") S:$G(PRCERR) PRCMSG=PRCMSG_"4^",PRCERR=""
 . QUIT
 D EN2^PRC5C1 S:$G(PRCERR) PRCMSG=PRCMSG_"6^",PRCERR=""
 D EN^DDIOL("IFCAP PACKAGE ENVIRONMENT CHECK DONE!")
EXIT I PRCMSG]"" D  K DIFQ,PRC5INST
 . N A,B
 . D EN^DDIOL("IFCAP PACKAGE ENVIRONMENT CHECK FAILS:")
 . F A=1:1 S B=$P(PRCMSG,"^",A) Q:'B  S B=$T(MSG+B) D EN^DDIOL($P(B,";",3,999))
 . QUIT
 QUIT
 ;
MSG ;error message
 ;;Missing fms conversion doc 'FND'.
 ;;Missing fms conversion doc 'PCL'.
 ;;Missing fms conversion doc 'PAC'.
 ;;Missing fms conversion doc 'CPF'.
 ;;Distributed standard dictionaries were not preloded (check patch 'PRC*4*28')
 ;;Station is missing the FMS security code in file 411.
 ;
 ;
