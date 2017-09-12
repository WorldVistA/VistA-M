PSBPRE28 ;BIRMINGHAM/DRF-BCMA MSF PRE-INSTALL ROUTINE ;Mar 2004
 ;;3.0;BAR CODE MED ADMIN;**28**;Mar 2004;Build 9
 ;
 ; PRE-Install per BCMA MSF (PSB*3.0*28)
 ;
PRE ; Delete field definition for .51 in File #53.69, BCMA Report Request.
 ;
 S DIK="^DD(53.69,",DA=.51,DA(1)=53.69
 D ^DIK
 Q
