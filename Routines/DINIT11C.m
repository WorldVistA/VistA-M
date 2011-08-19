DINIT11C ;SFISC/GFT,DCM-INITIALIZE VA FILEMAN ;9/9/94  14:01
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 F I=1:1:6 S D=$P("DD^RD^WR^DEL^LAYGO^AUDIT",U,I),^DD(1,30+I,0)=D_" ACCESS^C^^ ; ^S X=$S($D(^DIC(D0,0,"""_D_""")):^("""_D_"""),1:"""")"
 S ^DD(1,50,0)="LOOKUP PROGRAM^C^^ ; ^S X=$S($D(^DD(D0,0,""DIC"")):^(""DIC""),1:"""")"
 S ^DD(1,51,0)="VERSION^CJ8^^ ; ^S X=$P($G(^DD(D0,0,""VR"")),U)"
 S ^DD(1,51.1,0)="DISTRIBUTION PACKAGE^CJ30^^ ; ^S X=$G(^DD(D0,0,""VRPK""))"
 S ^DD(1,51.2,0)="PACKAGE REVISION DATA^CJ240^^ ; ^S X=$G(^DD(D0,0,""VRRV""))"
 ;S ^DD(1,53,0)="RESTRICT EDITING OF FILE^C^^ ; ^S X=$S($D(^DD(D0,0,""DI"")):$P(^(""DI""),U,2),1:"""")"
 S ^DD(1,54,0)="ARCHIVE FILE^C^^ ; ^S X=$S($D(^DD(D0,0,""DI"")):$P(^(""DI""),U),1:"""")"
 S ^DD(1,1815,0)="COMPILED X-REF ROUTINE^CJ9^^ ; ^S X=$G(^DD(D0,0,""DIK""))"
 S ^DD(1,1816,0)="OLD COMPILED X-REF ROUTINE^CJ8^^ ; ^S X=$G(^DD(D0,0,""DIKOLD""))"
 S ^DD(1,1819,0)="COMPILED CROSS-REFERENCES^CJ3^^ ; ^S X=$S($G(^DD(D0,0,""DIK""))]"""":""YES"",1:""NO"")"
 S ^DD(1,1819,21,0)="^^3^3^2930709^",^(1,0)="Computed field that indicates whether or not cross-references are",^DD(1,1819,21,2,0)="compiled.  This field can be seen when doing an INQUIRE to the FILE "
 S ^DD(1,1819,21,3,0)="file (file #1, sometimes referred to as the file of files.)"
 F I=1815,1816,1819 S ^DD(1,I,9)="^",^(9.01)="",^(9.1)=$P(^(0),U,5,99)
 S $P(^DIC(0),U,1,2)="FILE^1",^DIC(1,0)="FILE^1",^(0,"GL")="^DIC(" D A
 S ^DIC(1,"%D",0)="^^2^2^2940908^"
 S ^DIC(1,"%D",1,0)="This file stores the descriptive information for all files in the FileMan"
 S ^DIC(1,"%D",2,0)="managed database."
 S ^DD(1,.001,0)="NUMBER^N^^ ^K:X<2!$D(^DD(X)) X I $D(X),$D(^VA(200,DUZ,1))#2,$P(^(1),U)]"""" I X<$P(^(1),""-"")!(X>$P($P(^(1),U),""-"",2)) K X"
 S ^(4)="W !?5,""Enter an unused number"" I $D(^VA(200,DUZ,1)),$P(^(1),U)]"""" W "" within the range, "",$P(^(1),U)"
 ;
 F I=.1,0 D XX,XX
 F I=.001,.1,.12,.15,.101,.3,1,1.005,1.01 D XX
 Q
 ;
XX S DA(1)=I,DIK="^DD("_I_","
X W ".." D IXALL^DIK
 Q
 ;
A S (^("RD"),^("LAYGO"),^("WR"),^("DD"))=U Q
A1 S (^("DEL"),^("LAYGO"),^("WR"),^("DD"))=U Q
 ;
