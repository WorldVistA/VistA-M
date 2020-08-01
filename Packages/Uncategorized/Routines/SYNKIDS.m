SYNKIDS ; OSE/SMH - Synthea Installer ; 6/28/19 2:57pm
 ;;0.2;VISTA SYN DATA LOADER;;Feb 07, 2019;Build 10
 ;
ENV ; [Fallthrough]
 QUIT
 ;
CACHE() Q $L($SY,",")'=2
GTM() Q $P($SY,",")=47
 ;
TRAN ; [KIDS] - Transport from source system (BAD! SHOULD BE A FILEMAN FILE)
 M @XPDGREF@("SYN")=^SYN
 N I F I=200000000-1:0  S I=$O(^ICPT(I)) Q:'I  M @XPDGREF@("OS5",81,I)=^ICPT(I)
 N LEXF F LEXF=757,757.001,757.01,757.02,757.1,757.21 DO
 . N I F I=3000000000-1:0 S I=$O(^LEX(LEXF,I)) Q:'I  M @XPDGREF@("OS5",LEXF,I)=^LEX(LEXF,I)
 n mapRoot s mapRoot=$$setroot^SYNWD("loinc-lab-map")
 M @XPDGREF@("loinc-lab-map")=@mapRoot
 QUIT
 ;
PRE ; [KIDS] - Pre Install -- all for Cache
 QUIT
 ;
POST ; [KIDS] - Post Install
 DO POSTSYN
 DO POSTINTR
 DO POSTMAP
 QUIT
 ;
POSTMAP ; [Private] Add loinc-lab-map to the graph store
 new root set root=$$setroot^SYNWD("loinc-lab-map")
 kill @root
 merge @root=@XPDGREF@("loinc-lab-map")
 new rindx set rindx=$name(@root@("graph","map"))
 set @root@("index","root")=rindx
 do index^SYNGRAPH(rindx)
 quit
 ;
POSTSYN ; [Private] Restore SYN global
 ; Resore data from saved global
 ; Next line makes this safe to run in dev mode
 D MES^XPDUTL("Merging ^SYN global in. This takes time...")
 I $D(XPDGREF)#2,$D(@XPDGREF@("SYN")) D
 . K ^SYN("2002.030","sct2icd"),^("sct2icdnine"),^("sct2os5") ; **NAKED**
 . M ^SYN=@XPDGREF@("SYN")
 ;
 ; Install OS5 codes
 I $D(XPDGREF)#2,$D(@XPDGREF@("OS5")) D
 . N SYNF F SYNF=81,757,757.001,757.01,757.02,757.1,757.21 DO  ; for each file
 .. N SYNCR S SYNCR=$$ROOT^DILFD(SYNF,,1) ; closed reference
 .. N SYNOR S SYNOR=$$ROOT^DILFD(SYNF)    ; open reference
 .. N SYNI F SYNI=0:0 S SYNI=$O(@XPDGREF@("OS5",SYNF,SYNI)) Q:'SYNI  D  ; for each entry
 ... ;
 ... ; Delete old data
 ... N DA,DIK S DA=SYNI,DIK=SYNOR D ^DIK
 ... ;
 ... ; Add new data
 ... M @SYNCR@(SYNI)=@XPDGREF@("OS5",SYNF,SYNI)
 ... N DA,DIK S DA=SYNI,DIK=SYNOR D IX1^DIK
 ;
 ; Initialize Synthea
 D ^SYNINIT
 QUIT
 ;
POSTINTR ; [Private] Append Users to Intro Text
 N L S L=$O(^XTV(8989.3,1,"INTRO"," "),-1)+1
 I $G(^XTV(8989.3,1,"INTRO",L-1,0))["SYNPHARM123!!" QUIT  ; don't add again
 S ^XTV(8989.3,1,"INTRO",L,0)=" "
 S L=L+1
 S ^XTV(8989.3,1,"INTRO",L,0)=" SYN USER      ACCESS CODE       VERIFY CODE         ELECTRONIC SIGNATURE"
 S L=L+1
 S ^XTV(8989.3,1,"INTRO",L,0)=" --------      -----------       -----------         --------------------"
 S L=L+1
 S ^XTV(8989.3,1,"INTRO",L,0)=" PROVIDER,UNK  SYNPROV123        SYNPROV123!!        123456"
 S L=L+1
 S ^XTV(8989.3,1,"INTRO",L,0)=" PHARMACIST,U  SYNPHARM123       SYNPHARM123!!       123456"
 ;
 S $P(^XTV(8989.3,1,"INTRO",0),U,3,4)=L_U_L
 ;
 QUIT
 ;
