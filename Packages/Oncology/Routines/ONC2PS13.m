ONC2PS13 ;HINES OIFO/RTK - Post-Install Routine for Patch ONC*2.2*13 ;01/21/21
 ;;2.2;ONCOLOGY;**13**;Jul 31, 2013;Build 7
 ;
 ;N RC
 ;DC production server Patch 12
 ;S RC=$$UPDCSURL^ONCSAPIU("http://127.0.0.1:83/cgi_bin/oncsrv.exe")
 ;DC PRODUCTION SERVER V21
 S RC=$$UPDCSURL^ONCSAPIU("http://127.0.0.1:86/cgi_bin/oncsrv.exe")
 ;test server uRL V21
 ;S RC=$$UPDCSURL^ONCSAPIU("http://127.0.0.1:81/cgi_bin/oncsrv.exe")
 ;
 ;Quit before conversions if patch already has been installed in this account
 I $D(^ONCO(165.55,"B","ONCV2.2P13 CONVERSIONS")) Q
 ;
 ; Set new "G" and "H" cross-reference on (file #165.5, fields #5004, #5014)
 D BMES^XPDUTL("Setting 'G' and 'H' cross-references of file #165.5...")
 N DIK S DIK="^ONCO(165.5,",DIK(1)="5004^G"
 D ENALL2^DIK ;Kill existing "G" cross-reference.
 D ENALL^DIK ;Re-create "G" cross-reference.
 N DIK S DIK="^ONCO(165.5,",DIK(1)="5014^H"
 D ENALL2^DIK ;Kill existing "H" cross-reference.
 D ENALL^DIK ;Re-create "H" cross-reference.
 ;
 ;Convert values for NAACCR 2021 updates
 D BMES^XPDUTL("Convert Visceral Parietal Plueral Invasion [3937] data...")
 D BMES^XPDUTL("Convert Phase Radiation Treatment Modality [5506,5516,5526] data...")
 D BMES^XPDUTL("Convert Lacrimal Gland Grade data...")
 D BMES^XPDUTL("Convert Lymphoma Ocular Adnexa Grade data...")
 D BMES^XPDUTL("Convert FIGO Stage [3836] data...")
 D BMES^XPDUTL("Convert Residual Tumor Volume Post Cytoreduction [3921] data...")
 S ONCDXVP=3171231 F  S ONCDXVP=$O(^ONCO(165.5,"ADX",ONCDXVP)) Q:ONCDXVP'>0  D
 .S IEN=0 F  S IEN=$O(^ONCO(165.5,"ADX",ONCDXVP,IEN)) Q:IEN'>0  D
 ..I $P($G(^ONCO(165.5,IEN,"SSD4")),"^",32)=1 S $P(^ONCO(165.5,IEN,"SSD4"),"^",32)=4
 ..I $P($G(^ONCO(165.5,IEN,"SSD4")),"^",32)=2 S $P(^ONCO(165.5,IEN,"SSD4"),"^",32)=4
 ..I $P($G(^ONCO(165.5,IEN,"SSD4")),"^",32)=3 S $P(^ONCO(165.5,IEN,"SSD4"),"^",32)=5
 ..;
 ..I ($P($G(^ONCO(165.5,IEN,"RAD18")),"^",6)=18)&($P($G(^ONCO(165.5,IEN,3)),"^",35)=0) S $P(^ONCO(165.5,IEN,"RAD18"),"^",6)=19
 ..I ($P($G(^ONCO(165.5,IEN,"RAD18")),"^",13)=18)&($P($G(^ONCO(165.5,IEN,3)),"^",35)=0) S $P(^ONCO(165.5,IEN,"RAD18"),"^",13)=19
 ..I ($P($G(^ONCO(165.5,IEN,"RAD18")),"^",20)=18)&($P($G(^ONCO(165.5,IEN,3)),"^",35)=0) S $P(^ONCO(165.5,IEN,"RAD18"),"^",20)=19
 ..;
 ..I ($P($G(^ONCO(165.5,IEN,"SSD1")),"^",1)="00690")&($P($G(^ONCO(165.5,IEN,2.3)),"^",12)="A") S $P(^ONCO(165.5,IEN,2.3),"^",12)=1
 ..I ($P($G(^ONCO(165.5,IEN,"SSD1")),"^",1)="00690")&($P($G(^ONCO(165.5,IEN,2.3)),"^",13)="A") S $P(^ONCO(165.5,IEN,2.3),"^",13)=1
 ..I ($P($G(^ONCO(165.5,IEN,"SSD1")),"^",1)="00690")&($P($G(^ONCO(165.5,IEN,2.3)),"^",14)="A") S $P(^ONCO(165.5,IEN,2.3),"^",14)=1
 ..I ($P($G(^ONCO(165.5,IEN,"SSD1")),"^",1)="00690")&($P($G(^ONCO(165.5,IEN,2.3)),"^",12)="B") S $P(^ONCO(165.5,IEN,2.3),"^",12)=2
 ..I ($P($G(^ONCO(165.5,IEN,"SSD1")),"^",1)="00690")&($P($G(^ONCO(165.5,IEN,2.3)),"^",13)="B") S $P(^ONCO(165.5,IEN,2.3),"^",13)=2
 ..I ($P($G(^ONCO(165.5,IEN,"SSD1")),"^",1)="00690")&($P($G(^ONCO(165.5,IEN,2.3)),"^",14)="B") S $P(^ONCO(165.5,IEN,2.3),"^",14)=2
 ..I ($P($G(^ONCO(165.5,IEN,"SSD1")),"^",1)="00690")&($P($G(^ONCO(165.5,IEN,2.3)),"^",12)="C") S $P(^ONCO(165.5,IEN,2.3),"^",12)=3
 ..I ($P($G(^ONCO(165.5,IEN,"SSD1")),"^",1)="00690")&($P($G(^ONCO(165.5,IEN,2.3)),"^",13)="C") S $P(^ONCO(165.5,IEN,2.3),"^",13)=3
 ..I ($P($G(^ONCO(165.5,IEN,"SSD1")),"^",1)="00690")&($P($G(^ONCO(165.5,IEN,2.3)),"^",14)="C") S $P(^ONCO(165.5,IEN,2.3),"^",14)=3
 ..I ($P($G(^ONCO(165.5,IEN,"SSD1")),"^",1)="00690")&($P($G(^ONCO(165.5,IEN,2.3)),"^",12)="D") S $P(^ONCO(165.5,IEN,2.3),"^",12)=4
 ..I ($P($G(^ONCO(165.5,IEN,"SSD1")),"^",1)="00690")&($P($G(^ONCO(165.5,IEN,2.3)),"^",13)="D") S $P(^ONCO(165.5,IEN,2.3),"^",13)=4
 ..I ($P($G(^ONCO(165.5,IEN,"SSD1")),"^",1)="00690")&($P($G(^ONCO(165.5,IEN,2.3)),"^",14)="D") S $P(^ONCO(165.5,IEN,2.3),"^",14)=4
 ..;
 ..I ($P($G(^ONCO(165.5,IEN,"SSD1")),"^",1)="00710")&($P($G(^ONCO(165.5,IEN,2.3)),"^",12)=4) S $P(^ONCO(165.5,IEN,2.3),"^",12)=3
 ..I ($P($G(^ONCO(165.5,IEN,"SSD1")),"^",1)="00710")&($P($G(^ONCO(165.5,IEN,2.3)),"^",13)=4) S $P(^ONCO(165.5,IEN,2.3),"^",13)=3
 ..I ($P($G(^ONCO(165.5,IEN,"SSD1")),"^",1)="00710")&($P($G(^ONCO(165.5,IEN,2.3)),"^",14)=4) S $P(^ONCO(165.5,IEN,2.3),"^",14)=3
 ..I ($P($G(^ONCO(165.5,IEN,"SSD1")),"^",1)="00710")&($P($G(^ONCO(165.5,IEN,2.3)),"^",12)=5) S $P(^ONCO(165.5,IEN,2.3),"^",12)=4
 ..I ($P($G(^ONCO(165.5,IEN,"SSD1")),"^",1)="00710")&($P($G(^ONCO(165.5,IEN,2.3)),"^",13)=5) S $P(^ONCO(165.5,IEN,2.3),"^",13)=4
 ..I ($P($G(^ONCO(165.5,IEN,"SSD1")),"^",1)="00710")&($P($G(^ONCO(165.5,IEN,2.3)),"^",14)=5) S $P(^ONCO(165.5,IEN,2.3),"^",14)=4
 ..I ($P($G(^ONCO(165.5,IEN,"SSD1")),"^",1)="00710")&($P($G(^ONCO(165.5,IEN,2.3)),"^",12)="L") S $P(^ONCO(165.5,IEN,2.3),"^",12)=9
 ..I ($P($G(^ONCO(165.5,IEN,"SSD1")),"^",1)="00710")&($P($G(^ONCO(165.5,IEN,2.3)),"^",13)="L") S $P(^ONCO(165.5,IEN,2.3),"^",13)=9
 ..I ($P($G(^ONCO(165.5,IEN,"SSD1")),"^",1)="00710")&($P($G(^ONCO(165.5,IEN,2.3)),"^",14)="L") S $P(^ONCO(165.5,IEN,2.3),"^",14)=9
 ..;
 ..I $P($G(^ONCO(165.5,IEN,"SSD2")),"^",2)="01" S $P(^ONCO(165.5,IEN,"SSD2"),"^",2)=1
 ..I $P($G(^ONCO(165.5,IEN,"SSD2")),"^",2)="02" S $P(^ONCO(165.5,IEN,"SSD2"),"^",2)="1A"
 ..I $P($G(^ONCO(165.5,IEN,"SSD2")),"^",2)="03" S $P(^ONCO(165.5,IEN,"SSD2"),"^",2)="1A1"
 ..I $P($G(^ONCO(165.5,IEN,"SSD2")),"^",2)="04" S $P(^ONCO(165.5,IEN,"SSD2"),"^",2)="1A2"
 ..I $P($G(^ONCO(165.5,IEN,"SSD2")),"^",2)="05" S $P(^ONCO(165.5,IEN,"SSD2"),"^",2)="1B"
 ..I $P($G(^ONCO(165.5,IEN,"SSD2")),"^",2)="06" S $P(^ONCO(165.5,IEN,"SSD2"),"^",2)="1B1"
 ..I $P($G(^ONCO(165.5,IEN,"SSD2")),"^",2)="07" S $P(^ONCO(165.5,IEN,"SSD2"),"^",2)="1B2"
 ..I $P($G(^ONCO(165.5,IEN,"SSD2")),"^",2)="08" S $P(^ONCO(165.5,IEN,"SSD2"),"^",2)="1C"
 ..I $P($G(^ONCO(165.5,IEN,"SSD2")),"^",2)="09" S $P(^ONCO(165.5,IEN,"SSD2"),"^",2)="1C1"
 ..I $P($G(^ONCO(165.5,IEN,"SSD2")),"^",2)=10 S $P(^ONCO(165.5,IEN,"SSD2"),"^",2)="1C2"
 ..I $P($G(^ONCO(165.5,IEN,"SSD2")),"^",2)=11 S $P(^ONCO(165.5,IEN,"SSD2"),"^",2)="1C3"
 ..I $P($G(^ONCO(165.5,IEN,"SSD2")),"^",2)=20 S $P(^ONCO(165.5,IEN,"SSD2"),"^",2)=2
 ..I $P($G(^ONCO(165.5,IEN,"SSD2")),"^",2)=21 S $P(^ONCO(165.5,IEN,"SSD2"),"^",2)="2A"
 ..I $P($G(^ONCO(165.5,IEN,"SSD2")),"^",2)=22 S $P(^ONCO(165.5,IEN,"SSD2"),"^",2)="2A1"
 ..I $P($G(^ONCO(165.5,IEN,"SSD2")),"^",2)=23 S $P(^ONCO(165.5,IEN,"SSD2"),"^",2)="2A2"
 ..I $P($G(^ONCO(165.5,IEN,"SSD2")),"^",2)=24 S $P(^ONCO(165.5,IEN,"SSD2"),"^",2)="2B"
 ..I $P($G(^ONCO(165.5,IEN,"SSD2")),"^",2)=30 S $P(^ONCO(165.5,IEN,"SSD2"),"^",2)=3
 ..I $P($G(^ONCO(165.5,IEN,"SSD2")),"^",2)=31 S $P(^ONCO(165.5,IEN,"SSD2"),"^",2)="3A"
 ..I $P($G(^ONCO(165.5,IEN,"SSD2")),"^",2)=32 S $P(^ONCO(165.5,IEN,"SSD2"),"^",2)="3A1"
 ..I $P($G(^ONCO(165.5,IEN,"SSD2")),"^",2)=33 S $P(^ONCO(165.5,IEN,"SSD2"),"^",2)="3A11"
 ..I $P($G(^ONCO(165.5,IEN,"SSD2")),"^",2)=34 S $P(^ONCO(165.5,IEN,"SSD2"),"^",2)="3A12"
 ..I $P($G(^ONCO(165.5,IEN,"SSD2")),"^",2)=35 S $P(^ONCO(165.5,IEN,"SSD2"),"^",2)="3A2"
 ..I $P($G(^ONCO(165.5,IEN,"SSD2")),"^",2)=36 S $P(^ONCO(165.5,IEN,"SSD2"),"^",2)="3B"
 ..I $P($G(^ONCO(165.5,IEN,"SSD2")),"^",2)=37 S $P(^ONCO(165.5,IEN,"SSD2"),"^",2)="3C"
 ..I $P($G(^ONCO(165.5,IEN,"SSD2")),"^",2)=38 S $P(^ONCO(165.5,IEN,"SSD2"),"^",2)="3C1"
 ..I $P($G(^ONCO(165.5,IEN,"SSD2")),"^",2)=39 S $P(^ONCO(165.5,IEN,"SSD2"),"^",2)="3C2"
 ..I $P($G(^ONCO(165.5,IEN,"SSD2")),"^",2)=40 S $P(^ONCO(165.5,IEN,"SSD2"),"^",2)=4
 ..I $P($G(^ONCO(165.5,IEN,"SSD2")),"^",2)=41 S $P(^ONCO(165.5,IEN,"SSD2"),"^",2)="4A"
 ..I $P($G(^ONCO(165.5,IEN,"SSD2")),"^",2)=42 S $P(^ONCO(165.5,IEN,"SSD2"),"^",2)="4B"
 ..;
 ..I ($P($G(^ONCO(165.5,IEN,"SSD1")),"^",1)="00551")!($P($G(^ONCO(165.5,IEN,"SSD1")),"^",1)="00552")!($P($G(^ONCO(165.5,IEN,"SSD1")),"^",1)="00553") D
 ...I ($P($G(^ONCO(165.5,IEN,"SSD4")),"^",16)=3) S $P(^ONCO(165.5,IEN,"SSD4"),"^",16)=2
 ...I ($P($G(^ONCO(165.5,IEN,"SSD4")),"^",16)=4)!($P($G(^ONCO(165.5,IEN,"SSD4")),"^",16)=5) S $P(^ONCO(165.5,IEN,"SSD4"),"^",16)=3
 ...I ($P($G(^ONCO(165.5,IEN,"SSD4")),"^",16)=6)!($P($G(^ONCO(165.5,IEN,"SSD4")),"^",16)=7) S $P(^ONCO(165.5,IEN,"SSD4"),"^",16)=4
 ...I ($P($G(^ONCO(165.5,IEN,"SSD4")),"^",16)=8)!($P($G(^ONCO(165.5,IEN,"SSD4")),"^",16)=9) S $P(^ONCO(165.5,IEN,"SSD4"),"^",16)=5
 ..;
 ..S $P(^ONCO(165.5,IEN,"NCR21"),"^",5)="1.7"
 ..S $P(^ONCO(165.5,IEN,"NCR21"),"^",6)="1.7"
 ;
 ;Once the post-install has run, set this node so the conversions won't run
 ; again if patch is re-installed in same account
 K DD,DO N ONCVALUE S DIC="^ONCO(165.55,",DIC(0)="L",ONCVALUE="Y"
 S DIC("DR")="1///^S X=ONCVALUE",X="ONCV2.2P13 CONVERSIONS"
 D FILE^DICN
 Q
