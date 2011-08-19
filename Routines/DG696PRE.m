DG696PRE ;BAY/JAT;
 ;;5.3;Registration;**696*;Aug 13,1993
 ;
 ; This is a pre-init routine for DG*5.3*696
 ;
EN ;
 ; replace Y/N set with 1/0
 D BMES^XPDUTL("Updating field #.08 of file #46.1")
 S ^DD(46.1,.08,0)="COMBAT VET^S^1:YES;0:NO;^0;8^Q"
 S ^DD(46.1,.08,"DT")=3060519
 ; replace $N with $O
 D BMES^XPDUTL("Updating field #7.4 of file #45")
 S ^DD(45,7.4,0)="TRANSMISSION DATE^DCJ8,0X^^ ; ^S X=$S($D(^DGP(45.83,""C"",D0)):$O(^DGP(45.83,""C"",D0,0)),1:""""),X=$S($D(^DGP(45.83,+X,""P"",D0,0)):$P(^(0),U,2),1:"""")"
    S ^DD(45,7.4,"DT")=3060519
 S ^DD(45,7.4,9.1)="S X=$S($D(^DGP(45.83,""C"",D0)):$O(^DGP(45.83,""C"",D0,0)),1:""""),X=$S($D(^DGP(45.83,+X,""P"",D0,0)):$P(^(0),U,2),1:"""")"
 Q
