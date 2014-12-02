ONC2PS1A ;Hines OIFO/RVD - Collaborative Staging v0205 conversion ;01/22/14
 ;;2.2;ONCOLOGY;**1**;Jul 31, 2013;Build 8
 ;
 N DISCRIM,EXT,HIST,HIST14,LN,LNE,METS,PSITE,SCHNAME,SITE,ONC6DE,ONC6SG
 N SSF1,SSF2,SSF3,SSF5,ON10,ONC2960,ONC3010,ONC3020,ONC35
 N SSF10,SSF12,SSF13,SSF19,SSF25
 S SITE=$P($G(^ONCO(165.5,IEN,2)),U,1)
 Q:SITE=""
 S HIST=$$HIST^ONCFUNC(IEN)
 S HIST14=$E(HIST,1,4)
 S PSITE=$TR($$GET1^DIQ(164,SITE,1,"I"),".","")
 S EXT=$P($G(^ONCO(165.5,IEN,"CS")),U,11)
 S LN=$P($G(^ONCO(165.5,IEN,"CS")),U,12)
 S LNE=$P($G(^ONCO(165.5,IEN,"CS")),U,2)
 S METS=$P($G(^ONCO(165.5,IEN,"CS")),U,3)
 S ONC2940=$P($G(^ONCO(165.5,IEN,"CS1")),U,1)
 S ONC2960=$P($G(^ONCO(165.5,IEN,"CS1")),U,3)
 S ONC2980=$P($G(^ONCO(165.5,IEN,"CS1")),U,5)
 S ONC35=$P($G(^ONCO(165.5,IEN,"CS1")),U,12)
 S DISCRIM=$$GET1^DIQ(165.5,IEN,240)
 S ONC6DE=$$GET1^DIQ(165.5,IEN,162)
 S ONC6SG=$$GET1^DIQ(165.5,IEN,166)
 S ONC3010=$$GET1^DIQ(165.5,IEN,167)
 S ONC3020=$$GET1^DIQ(165.5,IEN,168)
 S SCHEMA=+$$SCHEMA^ONCSAPIS(.ONCSAPI,PSITE,HIST14,DISCRIM)
 Q:SCHEMA<0
 S SCHEMA=SCHNAME
 S SSF1=$P($G(^ONCO(165.5,IEN,"CS")),U,5)
 S SSF2=$P($G(^ONCO(165.5,IEN,"CS")),U,6)
 S SSF3=$P($G(^ONCO(165.5,IEN,"CS")),U,7)
 S SSF5=$P($G(^ONCO(165.5,IEN,"CS")),U,9)
 S ON10=$P($G(^ONCO(165.5,IEN,"CS")),U,10)
 S SSF10=$P($G(^ONCO(165.5,IEN,"CS2")),U,4)
 S SSF12=$P($G(^ONCO(165.5,IEN,"CS2")),U,6)
 S SSF13=$P($G(^ONCO(165.5,IEN,"CS2")),U,7)
 S SSF19=$P($G(^ONCO(165.5,IEN,"CS2")),U,13)
 S SSF25=$P($G(^ONCO(165.5,IEN,"CS2")),U,19)
 ;schema list for 3a AJCC 6/7 H&N
 S ONCSC3A("BuccalMucosa")="",ONCSC3A("EpiglottisAnterior")="",ONCSC3A("GumLower")="",ONCSC3A("GumOther")=""
 S ONCSC3A("GumUpper")="",ONCSC3A("Hypopharynx")="",ONCSC3A("LarynxGlottic")="",ONCSC3A("LarynxOther")=""
 S ONCSC3A("LarynxSubglottic")="",ONCSC3A("LarynxSupraglottic")="",ONCSC3A("LipLower")="",ONCSCH3A("LipOther")=""
 S ONCSC3A("LipUpper")="",ONCSC3A("Nasopharynx")="",ONCSC3A("Oropharynx")="",ONCSC3A("PalateHard")=""
 S ONCSC3A("PalateSoft")="",ONCSC3A("ParotidGland")="",ONCSC3A("PharayngealTonsil")="",ONCSC3A("SubmandibularGland")=""
 S ONCAC3A("TongueBase")=""
 ;
 ;schema list for 3b AJCC 6 Blank Tis
 ;S ONCSC3B("Appendix")="",ONCSC3B("CarcinoidAppendix")="",ONCSC3B("NETColon")="",ONCSC3B("NETRectum")=""
 ;S ONCSC3B("Colon")="",ONCSC3B("Rectum")="",ONCSC3B("Breast")="",ONCSC3B("Bladder")=""
 ;
 ;CS version list 2935
 S ONC35DAT("000937")="",ONC35DAT("010000")="",ONC35DAT("010002")="",ONC35DAT("010003")="",ONC35DAT("010004")=""
 S ONC35DAT("010005")="",ONC35DAT("010100")="",ONC35DAT("010200")="",ONC35DAT("010300")="",ONC35DAT("010400")=""
 S ONC35DAT("010401")="",ONC35DAT("020001")="",ONC35DAT("020100")="",ONC35DAT("020200")="",ONC35DAT("020302")=""
 S ONC35DAT("020440")=""
 ;
 ;if dt dx is > 12/31/13
 I DATEDX>3131231 S $P(^ONCO(165.5,IEN,"CS3"),U,2)=1,$P(^ONCO(165.5,IEN,"CS3"),U,3)="1 2014 DX" Q
 ;
 I ($G(SCHEMA)="Nasopharynx"),(LN=130!LN=430!LN=530) D  Q
 .S $P(^ONCO(165.5,IEN,"CS3"),U,2)=1,$P(^ONCO(165.5,IEN,"CS3"),U,3)="2a Nasopharynx Nodes"
 ;
 I $G(SCHEMA)="BileDuctsIntraHepat",(SSF10=000!SSF10=999) D  Q
 .S $P(^ONCO(165.5,IEN,"CS3"),U,2)=1
 .S $P(^ONCO(165.5,IEN,"CS3"),U,3)="2b BileDuctsIntraHepat SSF10"
 ;
 I $G(SCHEMA)="Bladder",(LN=400!LN=450) D  Q
 .S $P(^ONCO(165.5,IEN,"CS3"),U,2)=1
 .S $P(^ONCO(165.5,IEN,"CS3"),U,3)="2c Bladder Nodes"
 ;
 ;code for 3a AJCC 6 H&N
 I $D(ONCSC3A(SCHEMA)),DATEDX<310000,SSF1=988,ONC6DE="",ONC6SG="" D  Q
 .S $P(^ONCO(165.5,IEN,"CS3"),U,2)=1
 .S $P(^ONCO(165.5,IEN,"CS3"),U,3)="3a AJCC 6 Blank H&N"
 ;
 ;code for 3b AJCC 6 Blank Tis
 I SCHEMA="Appendix"!SCHEMA="CarcinoidAppendix"!SCHEMA="NETColon"!SCHEMA="NETRectum" D  Q
 .I (ON10="000"!ON10="050"),(LN'="000"!LN'="999"),(METS'="00"!METS'="99"),ONC6SG="" D
 ..S $P(^ONCO(165.5,IEN,"CS3"),U,2)=1
 ..S $P(^ONCO(165.5,IEN,"CS3"),U,3)="3b AJCC 6 Blank Tis"
 I (SCHEMA="Colon"!SCHEMA="Rectum"),(ON10="000"!ON10="050"!ON10="100"!ON10="110"!ON10="120") D  Q
 .I (LN'="000"!LN'="999"),(METS'="00"!METS="99"),ONC6SG="" D
 ..S $P(^ONCO(165.5,IEN,"CS3"),U,2)=1
 ..S $P(^ONCO(165.5,IEN,"CS3"),U,3)="3b AJCC 6 Blank Tis"
 I (SCHEMA="Breast"),(ON10="000"!ON10="050"!ON10="070") D  Q
 .I (LN'="000"!LN'="999"),(METS'="00"!METS'="99"),ONC6SG="" D
 ..S $P(^ONCO(165.5,IEN,"CS3"),U,2)=1
 ..S $P(^ONCO(165.5,IEN,"CS3"),U,3)="3b AJCC 6 Blank Tis"
 I (SCHEMA="Bladder"),(ON10="010"!ON10="030"!ON10="060"!ON10="100") D  Q
 .I (LN'="000"!LN'="999"),(METS'="00"!METS'="99"),ONC6SG="" D
 ..S $P(^ONCO(165.5,IEN,"CS3"),U,2)=1
 ..S $P(^ONCO(165.5,IEN,"CS3"),U,3)="3b AJCC 6 Blank Tis"
 ;
 ;for 3c AJCC 6 Blank GI Nodes
 I (SCHEMA="Esophagus"!SCHEMA="EsophagusGEJunction"!SCHEMA="Stomach"),DATEDX<3100000 D  Q
 .I ((LN>99)&(LN<501)),(LNE=0!LNE=1!LNE=5!LNE=9),(SSF2="000"!SSF2="988"),ON2960="",ONC6SG="" D
 ..S $P(^ONCO(165.5,IEN,"CS3"),U,2)=1
 ..S $P(^ONCO(165.5,IEN,"CS3"),U,3)="3c AJCC 6 Blank GI Nodes"
 I (SCHEMA="Appendix"!SCHEMA="Colon"!SCHEMA="Rectum"),DATEDX<3100000 D  Q
 .I ((LN>99)&(LN<301)),(LNE=0!LNE=1!LNE=5!LNE=9),SSF2="000",ON2960="",ONC6SG="" D
 ..S $P(^ONCO(165.5,IEN,"CS3"),U,2)=1
 ..S $P(^ONCO(165.5,IEN,"CS3"),U,3)="3c AJCC 6 Blank GI Nodes"
 ;
 ;code for 3d AJCC 6 Blank Invalid CS Version"
 I $G(ONC35),'$D(ONC35DAT(ONC35)),(ONC2940=""!ONC2960=""!ONC2980=""!ONC6SG="") D  Q
 .S $P(^ONCO(165.5,IEN,"CS3"),U,2)=1
 .S $P(^ONCO(165.5,IEN,"CS3"),U,3)="3d AJCC 6 Blank Invalid CS Version"
 ;
 ;code for "3e AJCC 6 Blank Other"
 I $G(ONC35),$D(ONC35DAT(ONC35)),(ONC2940=""!ONC2960=""!ONC2980=""!ONC6SG="") D  Q
 .S $P(^ONCO(165.5,IEN,"CS3"),U,2)=1
 .S $P(^ONCO(165.5,IEN,"CS3"),U,3)="3e AJCC 6 Blank Other"
 ;
 ;code for 3a AJCC 7 H&N
 I $D(ONCSC3A(SCHEMA)),DATEDX>310000,SSF1=988,ONC6DE="",ONC6SG="" D  Q
 .S $P(^ONCO(165.5,IEN,"CS3"),U,2)=1
 .S $P(^ONCO(165.5,IEN,"CS3"),U,3)="3a AJCC 7 Blank H&N"
 ;
 ;code for 3c AJCC 7 Blank GI Nodes
 I (SCHEMA="Esophagus"!SCHEMA="EsophagusGEJunction"!SCHEMA="Stomach"),DATEDX>3100000 D  Q
 .I ((LN>99)&(LN<501)),(LNE=0!LNE=1!LNE=5!LNE=9),(SSF2="000"!SSF2="988"),ON2960="",ONC6SG="" D
 ..S $P(^ONCO(165.5,IEN,"CS3"),U,2)=1
 ..S $P(^ONCO(165.5,IEN,"CS3"),U,3)="3c AJCC 6 Blank GI Nodes"
 I (SCHEMA="Appendix"!SCHEMA="Colon"!SCHEMA="Rectum"),DATEDX>3100000 D  Q
 .I ((LN>99)&(LN<301)),(LNE=0!LNE=1!LNE=5!LNE=9),SSF2="000",ON2960="",ONC6SG="" D
 ..S $P(^ONCO(165.5,IEN,"CS3"),U,2)=1
 ..S $P(^ONCO(165.5,IEN,"CS3"),U,3)="3c AJCC 7 Blank GI Nodes"
 ;
 ;code for 3e AJCC 7 Blank Other
 I $G(ONC35),'$D(ONC35DAT(ONC35)),DATEDX>3100000,(ONC2940=""!ONC2960=""!ONC2980=""!ONC6SG="") D  Q
 .S $P(^ONCO(165.5,IEN,"CS3"),U,2)=1
 .S $P(^ONCO(165.5,IEN,"CS3"),U,3)="3e AJCC 7 Blank Other"
 ;
 ;code for 3d SS1977 Blank Invalid CS Version"
 I $G(ONC35),'$D(ONC35DAT(ONC35)),ONC3010="" D  Q
 .S $P(^ONCO(165.5,IEN,"CS3"),U,2)=1
 .S $P(^ONCO(165.5,IEN,"CS3"),U,3)="3d SS1977 Blank Invalid CS Version"
 ;
 ;code for 3e SS1977 Blank Other
 I $G(ONC35),$D(ONC35DAT(ONC35)),ONC3010="" D  Q
 .S $P(^ONCO(165.5,IEN,"CS3"),U,2)=1
 .S $P(^ONCO(165.5,IEN,"CS3"),U,3)="3e SS1977 Blank Other"
 ;
 ;code for 3d SS2000 Blank Invalid CS Version
 I $G(ONC35),'$D(ONC35DAT(ONC35)),ONC3020="" D  Q
 .S $P(^ONCO(165.5,IEN,"CS3"),U,2)=1
 .S $P(^ONCO(165.5,IEN,"CS3"),U,3)="3d SS2000 Blank Invalid CS Version"
 ;
 ;code for 3e SS2000 Blank Other
 I $G(ONC35),$D(ONC35DAT(ONC35)),ONC3020="" D
 .S $P(^ONCO(165.5,IEN,"CS3"),U,2)=1
 .S $P(^ONCO(165.5,IEN,"CS3"),U,3)="3e SS2000 Blank Other"
 Q
 ;
CLEANUP ;Cleanup
 K EXT,IEN,LN,METS,ONCSAPI,SCHEMA,SITE
 K SSF1,SSF2,SSF3,SSF5,SSF12,SSF13,SSF25
