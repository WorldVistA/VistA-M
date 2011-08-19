ENPLSV4 ;WISC/SAB-PROJECT COMMUNICATION SERVER (CONTINUED) ;5/16/95
 ;;7.0;ENGINEERING;**11,23**;Aug 17, 1993
DATH ;
 ; message
 S X=ENSTEXT_" "_ENPNBR_" "_ENPTTL
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 S X="has been 'Authorized' by "_ENPREV_" on "
 S X=X_$E(ENPDA1,5,6)_"/"_$E(ENPDA1,7,8)
 S X=X_" "_$E(ENPTI1,1,2)_":"_$E(ENPTI1,3,4)
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 S X=" "
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 S X="The CONSTRUCTION PROJECT file will automatically be updated"
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 S X="with the following information."
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 S X=" "
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 S X="STATUS                           AUTHORIZED"
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 S X="MONTHLY UPDATES                  YES"
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 S X=" "
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 S Y=$P(ENREC,U,2) I Y]"" D
 .S X="Approved A/E Funding             $"_$J(Y,7)
 .S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 S Y=$P(ENREC,U,3) I Y]"" D
 .S X="Approved Construction            $"_$J(Y,7)
 .S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 S X=" "
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 S Y=$P(ENREC,U,4) I Y]"" D
 .S X="Design Program Start (Planned)   "_$E(Y,5,6)_"-"_$E(Y,7,8)_"-"_$E(Y,3,4)
 .S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 S Y=$P(ENREC,U,5) I Y]"" D
 .S X="Auth Letter Received (Actual)    "_$E(Y,5,6)_"-"_$E(Y,7,8)_"-"_$E(Y,3,4)
 .S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 S Y=$P(ENREC,U,6) I Y]"" D
 .S X="A/E Award (Planned)              "_$E(Y,5,6)_"-"_$E(Y,7,8)_"-"_$E(Y,3,4)
 .S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 S Y=$P(ENREC,U,7) I Y]"" D
 .S X="Start Schematics (Planned)       "_$E(Y,5,6)_"-"_$E(Y,7,8)_"-"_$E(Y,3,4)
 .S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 S Y=$P(ENREC,U,8) I Y]"" D
 .S X="Start DD (Planned)               "_$E(Y,5,6)_"-"_$E(Y,7,8)_"-"_$E(Y,3,4)
 .S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 S Y=$P(ENREC,U,9) I Y]"" D
 .S X="Start CD (Planned)               "_$E(Y,5,6)_"-"_$E(Y,7,8)_"-"_$E(Y,3,4)
 .S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 S Y=$P(ENREC,U,10) I Y]"" D
 .S X="Issue IFB (Planned)              "_$E(Y,5,6)_"-"_$E(Y,7,8)_"-"_$E(Y,3,4)
 .S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 S Y=$P(ENREC,U,11) I Y]"" D
 .S X="Bid Open (Planned)               "_$E(Y,5,6)_"-"_$E(Y,7,8)_"-"_$E(Y,3,4)
 .S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 S Y=$P(ENREC,U,12) I Y]"" D
 .S X="Construction Award (Planned)     "_$E(Y,5,6)_"-"_$E(Y,7,8)_"-"_$E(Y,3,4)
 .S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 S X=" "
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 I ENDA'>0 D
 .S X="**WARNING: Project with this number not found on your system.**"
 .S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 ; log, status
 I ENDA>0 D
 .K X S X(1)=$$FDT^ENPLUTL(ENPDA1-17000000_"."_ENPTI1)_"  "
 .S X(1)=X(1)_ENSCODE_" Region ("_ENPREV_") Authorized Project"
 .D POSTCL^ENPLUTL(ENDA,"X") K X
 .S DIE="^ENG(""PROJ"",",DA=ENDA
 .S DR="6///AUTHORIZED;2.5///YES" D ^DIE
 .S DR=ENSFIELD_"///AUTHORIZED" D ^DIE
 .I $P(ENREC,U,2)]"" S DR="5///"_$P(ENREC,U,2) D ^DIE
 .I $P(ENREC,U,3)]"" S DR="4///"_$P(ENREC,U,3) D ^DIE
 .I $P(ENREC,U,4)]"" S DR="20////"_($P(ENREC,U,4)-17000000) D ^DIE
 .I $P(ENREC,U,5)]"" S DR="50////"_($P(ENREC,U,5)-17000000) D ^DIE
 .I $P(ENREC,U,6)]"" S DR="20.5////"_($P(ENREC,U,6)-17000000) D ^DIE
 .I $P(ENREC,U,7)]"" S DR="21////"_($P(ENREC,U,7)-17000000) D ^DIE
 .I $P(ENREC,U,8)]"" S DR="22.5////"_($P(ENREC,U,8)-17000000) D ^DIE
 .I $P(ENREC,U,9)]"" S DR="23////"_($P(ENREC,U,9)-17000000) D ^DIE
 .I $P(ENREC,U,10)]"" S DR="25////"_($P(ENREC,U,10)-17000000) D ^DIE
 .I $P(ENREC,U,11)]"" S DR="26////"_($P(ENREC,U,11)-17000000) D ^DIE
 .I $P(ENREC,U,12)]"" S DR="27////"_($P(ENREC,U,12)-17000000) D ^DIE
 .K DIE
 Q
 ;ENPLSV4
