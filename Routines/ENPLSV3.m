ENPLSV3 ;WISC/SAB-PROJECT COMMUNICATION SERVER (CONTINUED) ;5/16/95
 ;;7.0;ENGINEERING;**11,23**;Aug 17, 1993
BATH ;
 Q
BCON ;
 ; message
 S X=$E(ENPDA1,5,6)_"/"_$E(ENPDA1,7,8)
 S X=X_" "_$E(ENPTI1,1,2)_":"_$E(ENPTI1,3,4)
 S X=X_"  "_$E(ENPDA2,5,6)_"/"_$E(ENPDA2,7,8)
 S X=X_" "_$E(ENPTI2,1,2)_":"_$E(ENPTI2,3,4)
 S X=X_"  "_ENPNBR_$E(ENBLANK,1,11-$L(ENPNBR))_$S(ENDA>0:"  ",1:"? ")
 S X=X_ENPACT_$E(ENBLANK,1,9-$L(ENPACT))
 S X=X_$E(ENPTTL,1,30)
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 ; log
 I ENDA>0 D
 .K X S X(1)=$$FDT^ENPLUTL(ENPDA1-17000000_"."_ENPTI1)
 .S X(1)=X(1)_"  "_ENSCODE_" Region "_ENPACT_$E(ENBLANK,1,8-$L(ENPACT))
 .S X(1)=X(1)_"proj. transmitted at "
 .S X(1)=X(1)_$$FDT^ENPLUTL(ENPDA2-17000000_"."_ENPTI2)
 .D POSTCL^ENPLUTL(ENDA,"X") K X
 Q
BNVI ;
 ; message
 S X=ENSTEXT_" "_ENPNBR_" "_ENPTTL
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 S X="has been set 'Non-Viable' by "_ENPREV_" on "
 S X=X_$E(ENPDA1,5,6)_"/"_$E(ENPDA1,7,8)
 S X=X_" "_$E(ENPTI1,1,2)_":"_$E(ENPTI1,3,4)
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 S X="with the following comments."
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 S X=" "
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 I ENDA'>0 D
 .S X="**WARNING: Project with this number not found on your system.**"
 .S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 ; log, status
 I ENDA>0 D
 .K X S X(1)=$$FDT^ENPLUTL(ENPDA1-17000000_"."_ENPTI1)
 .S X(1)=X(1)_"  "_ENSCODE_" Region ("_ENPREV_") Set Non-Viable Project:"
 .D POSTCL^ENPLUTL(ENDA,"X") K X
 .S DIE="^ENG(""PROJ"",",DA=ENDA,DR=ENSFIELD_"///NON-VIABLE"
 .D ^DIE K DIE
 Q
BRET ;
 ; message
 S X=ENSTEXT_" "_ENPNBR_" "_ENPTTL
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 S X="has been 'Returned to Site' by "_ENPREV_" on "
 S X=X_$E(ENPDA1,5,6)_"/"_$E(ENPDA1,7,8)
 S X=X_" "_$E(ENPTI1,1,2)_":"_$E(ENPTI1,3,4)
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 S X="with the following comments. Please make appropriate changes"
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 S X="and re-transmit the project to the Regional Construction Database."
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 S X=" "
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 I ENDA'>0 D
 .S X="**WARNING: Project with this number not found on your system.**"
 .S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 ; log, status
 I ENDA>0 D
 .K X S X(1)=$$FDT^ENPLUTL(ENPDA1-17000000_"."_ENPTI1)_"  "
 .S X(1)=X(1)_ENSCODE_" Region ("_ENPREV_") Returned Project to Site:"
 .D POSTCL^ENPLUTL(ENDA,"X") K X
 .S DIE="^ENG(""PROJ"",",DA=ENDA,DR=ENSFIELD_"///RETURNED TO SITE"
 .D ^DIE K DIE
 Q
BDIS ;
 ; message
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=" "
 S X=ENPNBR_$E(ENBLANK,1,11-$L(ENPNBR))_$S(ENDA>0:"  ",1:"? ")
 S X=X_$E(ENPDA1,5,6)_"/"_$E(ENPDA1,7,8)
 S X=X_" "_$E(ENPTI1,1,2)_":"_$E(ENPTI1,3,4)
 S X=X_"    "_ENPREV
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 S X=$E(ENBLANK,1,13)_ENPTTL
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 I ENDA'>0 D
 .S X="**WARNING: Project with this number not found on your system.**"
 .S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 ; log
 I ENDA>0 D
 .K X S X(1)=$$FDT^ENPLUTL(ENPDA1-17000000_"."_ENPTI1)_"  "
 .S X(1)=X(1)_ENSCODE_" Region ("_ENPREV_") Disapproved Project:"
 .D POSTCL^ENPLUTL(ENDA,"X") K X
 Q
BSUM ;
 I ENDA'>0 D
 .S X="**WARNING: Project "_ENPNBR_" not found on your system.**"
 .S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 ; log, status
 I ENDA>0 D
 .K X S X(1)=$$FDT^ENPLUTL(ENPDA1-17000000_"."_ENPTI1)_"  "
 .S X(1)=X(1)_ENSCODE_" Region Summary has Project = "_ENPSTA
 .D POSTCL^ENPLUTL(ENDA,"X") K X
 .I $E(ENCCODE)="F" D
 ..S DIE="^ENG(""PROJ"",",DA=ENDA,DR=ENSFIELD_"///"_ENPSTA
 ..I ENPSTA="DISAPPROVED" D
 ...S X="Project "_ENPNBR_" disapproved so status changed to CANCELED."
 ...S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 ...S DR=DR_";6///CANCELED"
 ..D ^DIE K DIE
 Q
 ;ENPLSV3
