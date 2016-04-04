DIPZ0 ;SFISC/TKW-COMPILE PRINT TEMPLATES ;19JAN2010
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**160,163**
 ;
SIZ(DITYP) ;PROMPT FOR SIZE OF COMPILED ROUTINE
 ;PARAMETER DITYP CONTAINS A NUMBER IN DIALOG FILE POINTING TO EITHER
 ;TEXT FOR A TEMPLATE TYPE, OR TO THE TEXT 'CROSS-REFERENCES'.
 N %,DIR
 S %=$G(^DD("ROU")) S:'% %=$P($G(^DD("OS",DISYS,0)),U,4) S:'% %=5000
 S DIR(0)="N^2400:"_%_":0",DIR("B")=%,DIR("A")=$$EZBLD^DIALOG(8027)
 K % S %(1)=$$EZBLD^DIALOG(DITYP) D BLD^DIALOG(9002,.%,"","DIR(""?"")")
 D ^DIR Q
 ;
RNM(DITYP) ;PROMPT FOR COMPILED ROUTINE NAME
 ;PARAMETER SAME AS FOR SIZ.
 N %,DIR,DIRNM
 S DIRNM="" D
 .I DITYP<8036 S DIRNM=$G(@(DIC_DIPZ_",""ROUOLD"")")),DIRNM(1)=$G(@(DIC_DIPZ_",""ROU"")"))
 .E  S DIRNM=$G(@("^DD("_DIPZ_",0,""DIKOLD"")")),DIRNM(1)=$G(@("^DD("_DIPZ_",0,""DIK"")")) S:DIRNM="" DIRNM=DIRNM(1)
 .Q
 I DIRNM(1)]"" S DIR(0)="Y",DIR("B")="NO" D  D ^DIR K DIR Q:$D(DIRUT)  I Y D UNC Q
 .K % S %(1)=$$EZBLD^DIALOG(DITYP),%(2)=DIRNM(1)
 .D BLD^DIALOG(8028,.%,"","DIR(""A"")")
 .K %(2) D BLD^DIALOG(9004,.%,"","DIR(""?"")")
 .Q
 S %=7 ;S:DITYP=8036 %=6
 S DIR(0)="F^3:"_%_"^K:X'?1U.NU&(X'?1""%""1U.NU)!(X?1""DI"".E) X" S:DIRNM]"" DIR("B")=DIRNM
 D BLD^DIALOG(8001,"","","DIR(""A"")"),BLD^DIALOG(9006,%,"","DIR(""?"")")
 D ^DIR K DIR Q:$D(DIRUT)!(X="")
 I $L(X)>6 D
 .N A,% D BLD^DIALOG(8031,"","","A") W $C(7),! F %=0:0 S %=$O(A(%)) Q:'%  W A(%),!
 .W ! Q
 I $$ROUEXIST^DILIBF(X) K % S %(1)=U_X D BLD^DIALOG(8016,.%,"","DIR") W $C(7),!?5,DIR K DIR
 Q
UNC ;UNCOMPILE TEMPLATES/CROSS-REFS
 N %,DIR,DIPZ0 I DITYP<8036 K @(DIC_DIPZ_",""ROU"")") S DIPZ0=$G(^("ROUOLD")) D
 . I DITYP=8033 D UNCAF^DIEZ(DIPZ)
 .D DELETROU^DIEZ(DIPZ0)
 E  S X=DIPZ D A^DIU21
 S %(1)=$$EZBLD^DIALOG(DITYP) D BLD^DIALOG(8026,.%,"","DIR(""A"")") ;'IS NOW UNCOMPILED'
 W $C(7),!!,DIR("A")
 S X="" Q
 ;
 ;DIALOG #8001  'Routine Name'
 ;       #8016  'Note that...is already in the routine directory'
 ;       #8027  'Maximum routine size on this computer...'
 ;       #8028  '...currently compiled under namespace...UNCOMPILE...'
 ;       #8031  'WARNING!!  Since the namespace...routine...so long...'
 ;       #8033  'Input template'
 ;       #8034  'Print Template'
 ;       #8036  'Cross-Reference(s)'
 ;       #9002  'This number will be used to determine how large...'
 ;       #9004  'Answer YES to UNCOMPILE the ...'
 ;       #9006  'Enter a valid MUMPS routine name...'
