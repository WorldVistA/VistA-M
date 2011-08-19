ENPLX1 ;WISC/SAB; PROJECT TRANSMISSION (cont); 6/12/97
 ;;7.0;ENGINEERING;**23,28**;Aug 17, 1993
LOCK ; lock valid projects on list
 S ENPN=""
 F  S ENPN=$O(^TMP($J,"L",ENPN)) Q:ENPN=""  S ENX=^(ENPN) D
 . S ENDA=$P(ENX,U)
 . I $P(ENX,U,2)>1 L +^ENG("PROJ",ENDA):10 I '$T S END=1,$P(^TMP($J,"L",ENPN),U,3)=1
 Q:'END
 ;
 S XMSUB="ERROR DURING QUEUED TRANSMISSION"
 S XMDUZ="Engineering Package"
 D XMZ^XMA2 I XMZ<1 Q
 S ENX="Your queued transmission of "
 S ENX=ENX_$S(ENTY="F":"Five Year Facility Plan Projects",ENTY="A":"Project Applications",ENTY="R":"Project Progress Reports",1:"")
 S ENL=1,^XMB(3.9,XMZ,2,ENL,0)=ENX
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)="was not performed because the asterisked projects were being edited."
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=" "
 S ENPN=""
 F  S ENPN=$O(^TMP($J,"L",ENPN)) Q:ENPN=""  S ENX=^(ENPN) D
 . S ENDA=$P(ENX,U)
 . I $P(ENX,U,2)>1 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=$S($P(ENX,U,3):"*",1:" ")_ENPN
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_ENL_U_ENL_U_DT
 S XMY(DUZ)=""
 D ENT1^XMD
 K XMZ
 Q
CREATE ; Create Mail Message
 I $G(XMZ)'<1 D SEND
 S ENC("MSG")=ENC("MSG")+1
 S ENX="EN XMIT "_$P("^FYFP^APPL^REPT",U,$F("FAR",ENTY))_" "
 S:ENT("PACK")=1!(ENT("PROJ")=1) ENX=ENX_ENPN
 S:ENT("PACK")'=1&(ENT("PROJ")>1) ENX=ENX_$E(1000+$E($P($G(^DIC(6910,1,0)),U,2),1,3),2,4)_" SEQ "_ENC("MSG")_" OF "_ENT("MSG")
 S XMSUB=ENX
 S XMDUZ=DUZ
 D XMZ^XMA2 I XMZ<1 S END=1 Q
 D NOW^%DTC S ENDT=%\1,ENY=$P(%,".",2)
 S ENCLDT=$$FDT^ENPLUTL(%)
 S ENX="ENG^"_$E(1000+$E($P($G(^DIC(6910,1,0)),U,2),1,3),2,4)
 S ENX=ENX_U_$P("^5YRP^1193^0051",U,$F("FAR",ENTY))
 S ENX=ENX_U_(%+17000000\1)_U_ENY_$E("000000",1,6-$L(ENY))
 S ENX=ENX_U_$$LTZ^ENPLUTL_$E("   ",1,3-$L($$LTZ^ENPLUTL))
 S ENX=ENX_U_$E(1000+ENC("MSG"),2,4)_U_$E(1000+ENT("MSG"),2,4)
 S ENX=ENX_U_$P("^004^004^002",U,$F("FAR",ENTY))
 S ENX=ENX_"^|"
 S ENL=1,^XMB(3.9,XMZ,2,ENL,0)=ENX
 I ENC("MSG")=1,"FA"[ENTY D MG
 Q
SEND ; Send Mail Message
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=$S(ENC("MSG")=ENT("MSG"):"$",1:"~")
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_ENL_U_ENL_U_DT
 S XMY(DUZ)=""
 S:"F"[ENTY XMY("G.OFMRD@"_ENDOMAIN)="",XMY("S.OFMRD-SRV1@"_ENDOMAIN)=""
 S:"A"[ENTY XMY("G.OFMRD@"_ENDOMAIN)="",XMY("S.OFMRD-SRV2@"_ENDOMAIN)=""
 S:"R"[ENTY XMY("S.EN_UPDATEA"_"@"_ENDOMAIN)=""
 S XMCHAN=1 D ENT1^XMD K XMCHAN
 K XMZ
 Q
UPD ; update project
 Q:"FA"'[ENTY
 K ENTXT
 S ENTXT(1)=ENCLDT_"  "_$S(ENTY="F":"5-Yr",ENTY="A":"Appl",1:"    ")
 S ENTXT(1)=ENTXT(1)_" Site transmitted project to Region"
 D POSTCL^ENPLUTL(ENDA,"ENTXT") K ENTXT
 I $$GET1^DIQ(6925,ENDA_",",181.1,"I")=1 K ENFDA S ENFDA(6925,ENDA_",",181.1)=0 D FILE^DIE("","ENFDA")
 I ENTY="A",$$GET1^DIQ(6925,ENDA_",",251,"I")=1 K ENFDA S ENFDA(6925,ENDA_",",251)=0 D FILE^DIE("","ENFDA")
 S:ENTY="F" $P(^ENG("PROJ",ENDA,33),U,7,8)=ENDT_U_DUZ
 S:ENTY="A" $P(^ENG("PROJ",ENDA,33),U,9,10)=ENDT_U_DUZ
 Q
MG ; mail group members
 N ENC,ENI,ENQ,ENT,ENX
 S ENX=$$FIND1^DIC(3.8,"","X","EN PROJECTS") I 'ENX Q
 D LIST^DIC(3.81,","_ENX_",","","","*","","","","","","ENQ")
 S ENT=$P(ENQ("DILIST",0),U)
 S ENX=""
 I ENT S ENI="" F ENC=1:1 S ENI=$O(ENQ("DILIST",1,ENI)) Q:ENI=""  D
 . S ENX=ENX_U_ENQ("DILIST",1,ENI)
 . I '(ENC#5)!(ENC=ENT) D
 . . S ENX="MG^"_(ENC+4\5)_U_(ENT+4\5)_ENX_$E("^^^^^",1,6-$L(ENX,U))
 . . S ENX=ENX_"^|"
 . . S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=ENX
 . . S ENX=""
 Q
REPTPR ; Progress Report Pre-Xmit
 Q:"R"'[ENTY
 N ENPR,ENY52
 K ENFDA
 ; check 'Not Applicable' fields
 S ENPR=$P($G(^ENG("PROJ",ENDA,0)),U,6)
 S ENY52=$G(^ENG("PROJ",ENDA,52))
 I "^NR^"'[(U_ENPR_U) D  ; delete both EPA fields
 . I $P(ENY52,U,7)]"" S ENFDA(6925,ENDA_",",158.6)="@"
 . I $P(ENY52,U,8)]"" S ENFDA(6925,ENDA_",",158.7)="@"
 I $P(ENY52,U,7)'="Y" D  ; delete EPA REPORTING CATEGORY
 . I $P(ENY52,U,8)]"" S ENFDA(6925,ENDA_",",158.7)="@"
 I "^NR^SL^"'[(U_ENPR_U) D  ; delete BONUS CATEGORY
 . I $P(ENY52,U,9)]"" S ENFDA(6925,ENDA_",",158.8)="@"
 ; update reporting period
 S ENFDA(6925,ENDA_",",1)=ENRP
 ;
 D FILE^DIE("","ENFDA")
 Q
REPTPS ; Progress Report Post-Xmit
 Q:"R"'[ENTY
 ; update prior submission
 S ^ENG("PROJ",ENDA,60)=$G(^ENG("PROJ",ENDA,0))
 I $D(^ENG("PROJ",ENDA,1)) S $P(^(60),U,11)="",^(60)=^(60)_^(1)
 S ^ENG("PROJ",ENDA,61)=$G(^ENG("PROJ",ENDA,2))
 S ^ENG("PROJ",ENDA,62)=$G(^ENG("PROJ",ENDA,3))
 S ^ENG("PROJ",ENDA,63)=$G(^ENG("PROJ",ENDA,4))
 S ^ENG("PROJ",ENDA,64)=$G(^ENG("PROJ",ENDA,5))
 I $D(^ENG("PROJ",ENDA,8)) S $P(^(64),U,11)="",^(64)=^(64)_^(8)
 I $D(^ENG("PROJ",ENDA,10)) S $P(^(64),U,21)="",^(64)=^(64)_^(10)
 S ^ENG("PROJ",ENDA,65)=$G(^ENG("PROJ",ENDA,13))
 S ^ENG("PROJ",ENDA,66)=$G(^ENG("PROJ",ENDA,50))
 S ^ENG("PROJ",ENDA,67)=$G(^ENG("PROJ",ENDA,51))
 S ^ENG("PROJ",ENDA,68)=$G(^ENG("PROJ",ENDA,52))
 I $D(^ENG("PROJ",ENDA,53)) S $P(^(68),U,11)="",^(68)=^(68)_^(53)
 S ^ENG("PROJ",ENDA,69)=$G(^ENG("PROJ",ENDA,56))
 S ^ENG("PROJ",ENDA,70)=$P($G(^ENG("PROJ",ENDA,15)),U)
 K ^ENG("PROJ",ENDA,58) MERGE ^ENG("PROJ",ENDA,58)=^ENG("PROJ",ENDA,57)
 S:$D(^ENG("PROJ",ENDA,58)) $P(^ENG("PROJ",ENDA,58),U,2)="6925.0186S"
 ; move progress notes to remarks
 S ENX=$P($G(^ENG("PROJ",ENDA,13)),U) I ENX]"" D
 . K ENXT
 . S ENDATE=$$FMTE^XLFDT(DT)
 . S ENXT="@"
 . S ENXT(1)="Progress note transmitted "_ENDATE_":"
 . S ENXT(2)=ENX
 . S ENXT(3)="End of note ("_ENDATE_")"
 . D WP^DIE(6925,ENDA_",",145,"A","ENXT")
 . S $P(^ENG("PROJ",ENDA,13),U)=""
 ; if status = completed project then turn-off monthly updates
 S:$P($G(^ENG("PROJ",ENDA,1)),U,3)=16 $P(^ENG("PROJ",ENDA,0),U,5)="N"
 Q
 ;ENPLX1
