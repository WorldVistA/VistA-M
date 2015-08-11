ONC2PS04 ;Hines OIFO/RTK - Post-Install Routine for Patch ONC*2.2*4 ;09/3/14
 ;;2.2;ONCOLOGY;**4**;Jul 31, 2013;Build 5
 ;
 N RC
 ;DC production server.
 S RC=$$UPDCSURL^ONCSAPIU("http://127.0.0.1:1757/cgi_bin/oncsrv.exe")
 ;DC test server, comment out for final release.
 ;S RC=$$UPDCSURL^ONCSAPIU("http://127.0.0.1:1755/cgi_bin/oncsrv.exe")
 ;
 D ADDX,ADD3H,GEO,PROCON
 D NAA15^ONC2PS4A
 Q
 ;
ADDX ;Modify the ACTION field for the Address at DX--State extract fields
 S ONCNWACT="S ACDANS=$$ADDDXST~ONCACDU1(IEN)"  ;set for all 3 extracts
 S DA=405,DA(1)=1,DIE="^ONCO(160.16,"_DA(1)_",""FIELD"","
 S DR="4///^S X=ONCNWACT"
 D ^DIE
 S DA=405,DA(1)=2,DIE="^ONCO(160.16,"_DA(1)_",""FIELD"","
 S DR="4///^S X=ONCNWACT"
 D ^DIE
 S DA=405,DA(1)=3,DIE="^ONCO(160.16,"_DA(1)_",""FIELD"","
 S DR="4///^S X=ONCNWACT"
 D ^DIE
 K ONCNWACT
 Q
ADD3H ;Add 3 new Histologies to file #169.3 for NAACCR 2015
 I '$D(^ONCO(169.3,82133)) D
 .S X="SERRATED ADENOCARCINOMA"
 .S DIC("DR")="1///8213/3;71///3",DINUM=82133 D ICD3ADD
 I '$D(^ONCO(169.3,85073)) D
 .S X="MICROPAPILLARY CARCINOMA, NOS (C18._, C19.9, C20.9"
 .S DIC("DR")="1///8507/3;71///3",DINUM=85073 D ICD3ADD
 I '$D(^ONCO(169.3,93613)) D
 .S X="PAPILLARY TUMOR OF THE PINEAL REGION"
 .S DIC("DR")="1///9361/3;71///9",DINUM=93613 D ICD3ADD
 Q
ICD3ADD ;Add new ICD-O-3 MORPHOLOGY (169.3) entries
 S DIC="^ONCO(169.3,",DIC(0)="L" D FILE^DICN
 K DIC,DINUM,X Q
GEO ;new GEOCODES for Yugoslavia,Czechoslovakia, Brunei, Slovakia and Vanuatu
 N DIE,DIK,DA,DR
 S DIE="^ONCO(165.2,"
 S DA=452,DR="1///^S X=""CSK""" D ^DIE
 S DA=453,DR="1///^S X=""YUG""" D ^DIE
 S DA=730,DR=".01///Brunei;.02///^S X=671;1///^S X=""BRN"";1.1///^S X=""XX""" D ^DIE
 S DA=732,DR=".01///Slovakia;.02///^S X=452;1///^S X=""SVK"";1.1///^S X=""XX""" D ^DIE
 S DA=734,DR=".01///Vanuatu;.02///^S X=721;1///^S X=""VUT"";1.1///^S X=""XX""" D ^DIE
 ;remove Brunei from Malaysia and Slovakia from Czechoslovakia
 S DA=3,DA(1)=452,DIK="^ONCO(165.2,"_DA(1)_",1," D ^DIK
 S DA=2,DA(1)=671,DIK="^ONCO(165.2,"_DA(1)_",1," D ^DIK
 Q
PROCON ;Prostate Grade Conversion for NAACCR V15
 S CTR=0
 D BMES^XPDUTL("Prostate Grade Conversion...")
 F DTDX=3139999:0 S DTDX=$O(^ONCO(165.5,"ADX",DTDX)) Q:DTDX'>0  D
 .F IEN=0:0 S IEN=$O(^ONCO(165.5,"ADX",DTDX,IEN)) Q:IEN'>0  D
 ..S CTR=CTR+1 I CTR#150=0 D BMES^XPDUTL(".")
 ..S GRADE=$P($G(^ONCO(165.5,IEN,2)),U,5)
 ..S PRSTCD=$$GET1^DIQ(165.5,IEN,20.1)
 ..S SSF8=$P($G(^ONCO(165.5,IEN,"CS2")),U,2)
 ..S SSF10=$P($G(^ONCO(165.5,IEN,"CS2")),U,4)
 ..;
 ..I ((SSF8="002")!(SSF8="003")!(SSF8="004")!(SSF8="005")!(SSF8="006")),((SSF10="002")!(SSF10="003")!(SSF10="004")!(SSF10="005")!(SSF10="006")!(SSF10=998)!(SSF10=999)),(PRSTCD="C61.9") D
 ...S $P(^ONCO(165.5,IEN,2),U,5)=1
 ..I ((SSF8=998)!(SSF8=999)),((SSF10="002")!(SSF10="003")!(SSF10="004")!(SSF10="005")!(SSF10="006")),(PRSTCD="C61.9") D
 ...S $P(^ONCO(165.5,IEN,2),U,5)=1
 ..I ((SSF8="002")!(SSF8="003")!(SSF8="004")!(SSF8="005")!(SSF8="006")),(SSF10="007"),(PRSTCD="C61.9") D
 ...S $P(^ONCO(165.5,IEN,2),U,5)=2
 ..I (SSF8="007"),((SSF10="002")!(SSF10="003")!(SSF10="004")!(SSF10="005")!(SSF10="006")!(SSF10="007")!(SSF10=998)!(SSF10=999)),(PRSTCD="C61.9") D
 ...S $P(^ONCO(165.5,IEN,2),U,5)=2
 ..I ((SSF8=998)!(SSF8=999)),(SSF10="007"),(PRSTCD="C61.9") D
 ...S $P(^ONCO(165.5,IEN,2),U,5)=2
 ..I ((SSF8="002")!(SSF8="003")!(SSF8="004")!(SSF8="005")!(SSF8="006")),((SSF10="008")!(SSF10="009")!(SSF10="010")),(PRSTCD="C61.9") D
 ...S $P(^ONCO(165.5,IEN,2),U,5)=3
 ..I (SSF8="007"),((SSF10="008")!(SSF10="009")!(SSF10="010")),(PRSTCD="C61.9") D
 ...S $P(^ONCO(165.5,IEN,2),U,5)=3
 ..I ((SSF8="008")!(SSF8="009")!(SSF8="010")),((SSF10="002")!(SSF10="003")!(SSF10="004")!(SSF10="005")!(SSF10="006")!(SSF10="007")!(SSF10="008")!(SSF10="009")!(SSF10="010")!(SSF10=998)!(SSF10=999)),(PRSTCD="C61.9") D
 ...S $P(^ONCO(165.5,IEN,2),U,5)=3
 ..I ((SSF8=998)!(SSF8=999)),((SSF10="008")!(SSF10="009")!(SSF10="010")),(PRSTCD="C61.9") D
 ...S $P(^ONCO(165.5,IEN,2),U,5)=3
 Q
