LRWLST12 ;DALOI/STAFF - ACCESSION SETUP ;Jan 5, 2009
 ;;5.2;LAB SERVICE;**153,201,350**;Sep 27, 1994;Build 230
 ;
 ;
CAP ; from LRWLST11,LRTSTJAM
 N LRCNT
 Q:'($D(^LRO(68,LRAA,1,LRAD,1,LRAN,0))#2)
 S:'($D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,0))#2) ^(0)="^68.04PA" S $P(^(0),U,3)=+LRTS,$P(^(0),U,4)=1+$P(^(0),U,4)
 S:'($D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,+LRTS,0))#2) ^(0)=LRTS,$P(^(0),U,9)=+$G(LRTSORU)
 S:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,"B",+LRTS,+LRTS)) ^(+LRTS)=""
 ;
 S:'$G(LRSAMP) LRSAMP=+$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,5,1,0)),U,2)
 ;
 I $P(LRPARAM,U,14),$P($G(^LRO(68,+LRAA,0)),U,16) D
 . S LRCI=0
 . F  S LRCI=$O(^LAB(60,+LRTS,9.1,LRCI)) Q:LRCI<1  I $D(^(LRCI,0)) S X=^(0),LRCNT=$S(+$P(X,U,3):+$P(X,U,3),1:1) D CAP1
 I $P(LRPARAM,U,14),$P($G(^LRO(68,LRAA,0)),U,16) D
 . S LRCI=0
 . F  S LRCI=$O(^LAB(62,+LRSAMP,9,LRAA,1,+LRTS,1,LRCI)) Q:LRCI<1  I $D(^(LRCI,0)) S X=^(0),LRCNT=$S(+$P(X,U,3):+$P(X,U,3),1:1) D CAP1
 ;
 K LRCI,LRCWT,X,C3,C4,C0,LRCI,LRCNT
 Q
 ;
 ;
CAP1 ;
 S LRT=+LRTS D STUFI^LRCAPV1
 K LRT
 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,+LRTS,1,0)) S ^(0)="^68.14P^^"
 S C0=^LRO(68,LRAA,1,LRAD,1,LRAN,4,+LRTS,1,0),C4=$P(C0,U,4)+1,$P(C0,U,3)=LRCI,$P(C0,U,4)=C4,^(0)=C0
 ;
C3 ;
 I '($D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,+LRTS,1,LRCI,0))#2) D
 . S:'$D(LRNT) LRNT=$$HTFM^XLFDT($H)
 . S ^LRO(68,LRAA,1,LRAD,1,LRAN,4,+LRTS,1,LRCI,0)=LRCI_U_LRCNT_"^^^^"_LRNT_"^.5"_U_DUZ(2)_U_LRAA_U_LRAA_U
 Q
 ;
 ;
VMSG ;
 N LA7V
 S LA7V=""
 I $G(LR696IEN),$D(^LRO(69.6,LR696IEN,0))#2 D
 . S $P(^LRO(69.6,LR696IEN,0),U,10)=160,LRCNT=0
 . F  S LRCNT=$O(LROT(LRSAMP,LRSPEC,LRCNT)) Q:LRCNT<1  I $D(LROT(LRSAMP,LRSPEC,LRCNT,"B",+LRTS))#2 D
 . . S LRTSN=LROT(LRSAMP,LRSPEC,LRCNT,"B",+LRTS)
 . . I $D(^LRO(69.6,LR696IEN,2,+LRTSN,0)) S $P(^(0),U,7)=LRNT,$P(^(0),U,9)=LRUID,$P(^(0),U,6)=160 D
 . . . D SET^LA7VMSG($P(LRORU3,U,4),$P(LRORU3,U,2),$P(LRORU3,U,5),$P(LRORU3,U,3),$P(LRTSN,U,3),$P(LRTSN,U,2),LRIDT,LRSS,LRDFN,LRODT,,"ORR")
 ;. D ORR^LA7VMSG ; Update status to in process - need to task this from another place (JMC/27NOV06)
 ;
 Q
 ;
 ;
ORUT2 ; Update ordered test in file #69.6
 ; Called by LRWLST11
 N FDA,LRDIE,LRI,LRNLT,LROK,LRSTATUS,LRUPSTAT,LRTST,LRX
 S LRNLT=$$NLT^LRVER1(+LRTSORU) Q:+LRNLT<1
 S LRTST=$P($G(^LAM($O(^LAM("E",LRNLT,0)),0)),U) Q:LRTST=""!('$G(LR696IEN))
 ;Q:'($D(^LRO(69.6,LR696IEN,0))#2)!($D(^LRO(69.6,LR696IEN,2,"C",LRNLT)))
 I '$D(^LRO(69.6,LR696IEN,0)) Q
 ;
 S LRUPSTAT=$$FIND1^DIC(64.061,"","OX","Specimen in process","B","I $P(^LAB(64.061,Y,0),U,7)=""U""")
 ; Update existing entry with current status
 I $D(^LRO(69.6,LR696IEN,2,"C",LRNLT)) D
 . S LRI=$O(^LRO(69.6,LR696IEN,2,"C",LRNLT,0))
 . S FDA(1,69.64,LRI_","_LR696IEN_",",5)=LRUPSTAT
 . S FDA(1,69.64,LRI_","_LR696IEN_",",8)=LRNT
 . S FDA(1,69.64,LRI_","_LR696IEN_",",9)=LRUID
 . S FDA(1,69.64,LRI_","_LR696IEN_",",12)=LRURG
 . D FILE^DIE("","FDA(1)","LRDIE(1)")
 . D CLEAN^DILF
 ;
 ; JMC/8 Feb 07 - need to rewrite to use FileMan DBS call
 ; Create new entry with current status
 I '$D(^LRO(69.6,LR696IEN,2,"C",LRNLT)) D
 . S:'$D(^LRO(69.6,LR696IEN,2,0)) ^(0)="^69.64A^"
 . N DA,DIC,DIE,DLAYGO,DR
 . S DLAYGO=69.6,DA=LR696IEN
 . S LRURG=$S($L($P($G(^LAB(62.05,+$P(LRTS,U,2),0)),U,4)):$P(^(0),U,4),1:"R")
 . S (DIE,DIC)="^LRO(69.6,",DIC(0)="LM"
 . S DR=20_"///"_LRTST_";",DR(1,69.6)="20///"_LRTST_";"
 . S DR(2,69.64)=".01///"_LRTST_";1///"_LRNLT_";4///"_LRURG_";5////160;8///"_LRNT_";9///"_LRUID
 . D ^DIE
 ;
 ; Check and update specimen status based on test order status
 ;  - if specimen status is 'in-transit' then update if all tests have been processed.
 S LRX=+$P(^LRO(69.6,LR696IEN,0),U,10),LROK=1,LRSTATUS=""
 I LRX S LRSTATUS=$$GET1^DIQ(64.061,LRX_",",.01)
 I LRSTATUS="In-Transit" D
 . S LRI=0
 . F  S LRI=$O(^LRO(69.6,LR696,2,LRI)) Q:'LRI  D  Q:'LROK
 . . S X=$P(^LRO(69.6,LR696,2,LRI,0),"^",6) Q:'X
 . . I $$GET1^DIQ(64.061,X_",",.01)="In-Transit" S LROK=0
 . I 'LROK Q
 . I LRSTATUS="" Q
 . S FDA(3,69.6,LR696IEN_",",6)=LRUPSTAT
 . D FILE^DIE("","FDA(3)","LRDIE(3)")
 . D CLEAN^DILF
 Q
 ;
 ;
PROVCPY ; Copy remote ordering provider from file #69.6 to ordered test multiple (#.35)
 ; Called from LRWLST11
 N FDA,LRDIE,LRFILE,LRI,LRPROV,LRX,LRY,LRZ
 ;
 S LRFILE=$S(LRSS="CH":63.07,LRSS="MI":63.5,LRSS="SP":63.53,LRSS="CY":63.51,LRSS="EM":63.52,1:"")
 I LRFILE="" Q
 S LRI=0,LRPROV=""
 F  S LRI=$O(^LR(LRDFN,LRSS,LRIDT,"ORUT",LRI)) Q:'LRI  D
 . S LRX=$P($G(^LR(LRDFN,LRSS,LRIDT,"ORUT",LRI,0)),"^")
 . S LRY=$O(^LRO(69.6,LR696,2,"C",LRX,0))
 . I LRY="" Q
 . S LRZ=$P($G(^LRO(69.6,LR696,2,LRY,1)),"^")
 . I LRZ="" Q
 . S LRPROV=$E(LRZ,1,45)
 . S FDA(1,LRFILE,LRI_","_LRIDT_","_LRDFN_",",7)=LRPROV
 . D FILE^DIE("","FDA(1)","LRDIE(1)")
 . K FDA(1),LRDIE(1)
 ;
 ; Copy ordering provider to file #63, AP field #.011 SPECIMEN SUBMITTED BY (free text field)
 ;   - Copied from last or only test, only can store one.
 I LRPROV'="","SPCYEM"[LRSS D
 . S LRFILE=$S(LRSS="SP":63.08,LRSS="CY":63.09,LRSS="EM":63.02,1:"")
 . I LRFILE="" Q
 . S FDA(2,LRFILE,LRIDT_","_LRDFN_",",.011)=LRPROV
 . D FILE^DIE("","FDA(2)","LRDIE(2)")
 . K FDA(2),LRDIE(2)
 ;
 D CLEAN^DILF
 ;
 Q
 ;
 ;
APMOVE ; Copy anatomic pathology data from file #69.6 to corresponding fields in file #63 for this accession.
 ; Called from LRWLST11
 ;
 ; Copy specimen multiple to file #63
 N FDA,LRDIE,LRFILE,LRI,LRX,LRY
 S LRFILE=$S(LRSS="SP":63.812,LRSS="CY":63.902,LRSS="EM":63.202,1:0)
 I 'LRFILE Q
 S LRI=0
 F  S LRI=$O(^LRO(69.6,LR696,61,LRI)) Q:'LRI  D
 . S LRY=$G(^LRO(69.6,LR696,61,LRI,0))
 . I $P(LRY,"^")="" Q
 . S FDA(1,LRFILE,"+1,"_LRIDT_","_LRDFN_",",.01)=$P(LRY,"^")
 . I $P(LRY,"^",2) S FDA(1,LRFILE,"+1,"_LRIDT_","_LRDFN_",",.06)=$P(LRY,"^",2)
 . I $P(LRY,"^",3) S FDA(1,LRFILE,"+1,"_LRIDT_","_LRDFN_",",.07)=$P(LRY,"^",3)
 . I $D(FDA(1)) D UPDATE^DIE("","FDA(1)","","LRDIE(1)")
 . K FDA(1),LRDIE(1)
 ;
 ; If no free text specimen and topography then create from top-level topography
 I '$D(^LRO(69.6,LR696,61)) D
 . S LRX=$G(^LRO(69.6,LR696,0))
 . I '$P(LRX,"^",7) Q
 . S LRY=$$GET1^DIQ(61,$P(LRX,"^",7),.01),$P(LRY,"^",2,3)=$P(LRX,"^",7,8)
 . S FDA(2,LRFILE,"+1,"_LRIDT_","_LRDFN_",",.01)=$P(LRY,"^")
 . I $P(LRY,"^",2) S FDA(2,LRFILE,"+1,"_LRIDT_","_LRDFN_",",.06)=$P(LRY,"^",2)
 . I $P(LRY,"^",3) S FDA(2,LRFILE,"+1,"_LRIDT_","_LRDFN_",",.07)=$P(LRY,"^",3)
 . I $D(FDA(2)) D UPDATE^DIE("","FDA(2)","","LRDIE(2)")
 . K FDA(2),LRDIE(2)
 ;
 ; Copy accompanying text to corresponding word-processing fields in file #63
 ; If frozen section (1.3) and not SP subscript then store in microscopic description (1.1) - only SP supports frozen section.
 S LRI=0,LRFILE=$S(LRSS="SP":63.08,LRSS="CY":63.09,LRSS="EM":63.02,1:0)
 F  S LRI=$O(^LRO(69.6,LR696,63,LRI)) Q:'LRI  D
 . S LRY=+$G(^LRO(69.6,LR696,63,LRI,0))
 . I '$D(^LRO(69.6,LR696,63,LRI,1)) Q
 . I LRI=1.3,LRSS'="SP" S LRI=1.1
 . I LRFILE D WP^DIE(LRFILE,LRIDT_","_LRDFN_",",LRY,"A","^LRO(69.6,LR696,63,LRI,1)","LRDIE(LRFILE)")
 ;
 D CLEAN^DILF
 Q
 ;
 ;
MAILALRT(LRRNAME,LRFMERR) ;
 ; Send mail message alert when FileMan DBS errors returned
 ; Inputs
 ;  LRRNAME: Routine name (TAG~RTN)
 ;  LRFMERR:<byref><opt> FileMan error local array
 ;
 N J,LR68,LRCNT,LRMTXT,X,XMINSTR,XMSUB,XMTO,Y
 ;
 I $D(^LRO(68,LRAA,1,LRAD,1,LRAN)) M LR68=^LRO(68,LRAA,1,LRAD,1,LRAN)
 ;
 S LRMTXT(1)="The following debugging information is provided to assist"
 S LRMTXT(2)="support staff in resolving error during accessioning."
 S LRMTXT(3)=" ",LRCNT=3
 ;
 F J="DILOCKTM","DUZ","FDA","FDAIEN","LR68","LRAA","LRAD","LRAN","LRDFN","LRDIE","LRFDA","LRFDAIEN","LRFMERR","LRSAMP","LRSPEC","LRSS","LRTSTS","LRUNQ","LRWLC","XQY","XQY0" D
 . S X=$G(@J)
 . I X'="" S LRCNT=LRCNT+1,LRMTXT(LRCNT)=J_"="_X
 . F  S J=$Q(@J) Q:J=""  S LRCNT=LRCNT+1,LRMTXT(LRCNT)=J_"="_@J
 S LRCNT=LRCNT+1,LRMTXT(LRCNT)="Last Global Ref="_$$LGR^%ZOSV
 S LRCNT=LRCNT+1,LRMTXT(LRCNT)="Version="_$$VERSION^%ZOSV(1)_" "_$$VERSION^%ZOSV
 S LRCNT=LRCNT+1,LRMTXT(LRCNT)="Operating System="_$$OS^%ZOSV
 D GETENV^%ZOSV
 S LRCNT=LRCNT+1,LRMTXT(LRCNT)="Environment="_Y
 ;
 S XMSUB="FileMan DBS call failed during accessioning in routine "_$G(LRRNAME,"LRWLST1")
 I $L(XMSUB)>65 S XMSUB="FileMan DBS failed during accessioning in "_$G(LRRNAME,"LRWLST1")
 S XMTO("G.LMI")="",XMINSTR("FROM")=.5,XMINSTR("ADDR FLAGS")="R"
 D SENDMSG^XMXAPI(DUZ,XMSUB,"LRMTXT",.XMTO,.XMINSTR)
 Q
