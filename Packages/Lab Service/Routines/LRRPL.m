LRRPL ;DALOI/JMC - Interim Report Performing Lab Utility ;04/30/12  09:46
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 ;
RETLST(LRPL,LRDFN,LRSS,LRIDT,LROPT) ; Retreive list of Report sections and related performing labs.
 ; Call with LRPL = array listing section and related performing lab name/address/CLIA (by reference)
 ;          LRDFN = File #63 IEN
 ;           LRSS = File #63 subscript
 ;          LRIDT = File #63 inverse date/time of specimen
 ;          LROPT = 0 (addresses); 1 (no addresses); 2 (list/iens)
 ;           
 ; Returns   LRPL = array listing section and related performing lab name/address/CLIA
 ; 
 N LRPLIEN,LRQUIT,LRREC,LRX
 S (LRPL,LRQUIT)=0
 S (LRX,LRREC)=LRDFN_","_LRSS_","_LRIDT_","
 F  S LRX=$O(^LR(LRDFN,"PL","B",LRX)) Q:LRX=""  D  Q:LRQUIT
 . I $P(LRX,",",1,3)'=$P(LRREC,",",1,3) S LRQUIT=1 Q
 . S LRPLIEN=$O(^LR(LRDFN,"PL","B",LRX,0))
 . D RETSEC(.LRPL,LRDFN,LRPLIEN,LROPT)
 ; 
 Q
 ;
 ;
RETSEC(LRREC,LRDFN,LRPLIEN,LROPT) ; Retrieve Report section and related performing lab.
 ; Call with LRREC = array listing section and related performing lab name/address/CLIA (by reference)
 ;           LRDFN = File #63 IEN
 ;         LRPLIEN = Reference to entry in "PL" subscript
 ;           LROPT = 0 (addresses); 1 (no addresses); 2 (list/iens)
 ;
 ; Returns   LRREC = array listing section and related performing lab name/address/CLIA
 ;
 N CLIA,LR4,LRREF,LRX
 S LRX=^LR(LRDFN,"PL",LRPLIEN,0),LRREF=$P(LRX,"^"),LR4=$P(LRX,"^",2)
 ;
 ; Check reference to determine what component of report it's associated with.
 ;  and construct the performing laboratory statement.
 S LRREC=$O(LRREC(""),-1)
 I LRREC>1 S LRREC=LRREC+1,LRREC(LRREC)=" "
 S LRREC=LRREC+1,LRREC(LRREC)=""
 I $P(LRREF,",",2)?1(1"CH",1"MI") D @($P(LRREF,",",2)_"CHK")
 I $P(LRREF,",",2)?1(1"SP",1"CY",1"EM") D APCHK
 I $P(LRREF,",",2)="AU" D AUCHK
 ;
 I LROPT=2 S LRX=$O(LRREC(0,""),-1)+1,LRREC(0,LRX)=LRREF_"^"_LRPLIEN_"^"_LRREC(LRREC)
 ;
 S LRREC(LRREC)=LRREC(LRREC)_" Performed By: "
 S LRREC=LRREC+1,LRREC(LRREC)=$$NAME^XUAF4(LR4)
 ;
 S CLIA=$$ID^XUAF4("CLIA",LR4)
 I CLIA'="" D
 . I $L(LRREC(LRREC))<(IOM-20) S LRREC(LRREC)=LRREC(LRREC)_" [CLIA# "_CLIA_"]"
 . E  S LRREC=LRREC+1,LRREC(LRREC)="CLIA# "_CLIA
 ;
 I LROPT>1 Q
 S LRX=$$PADD^XUAF4(LR4),LRX(1)=$$WHAT^XUAF4(LR4,1.02)
 I LRX="" Q
 S LRREC=LRREC+1
 S LRREC(LRREC)=$P(LRX,U)_" "_$S(LRX(1)'="":LRX(1)_" ",1:"")_$P(LRX,U,2)_$S($P(LRX,U,3)'="":", ",1:"")_$P(LRX,U,3)_" "_$P(LRX,U,4)
 ;
 Q
 ;
 ;
CHCHK ; Check and resolve CH subscript
 ;
 Q
 ;
 ;
MICHK ; Check and resolve MI subscript
 ;
 ; If entire report flagged then check if only one section and report that section
 ;   otherwise report as "microbiology report" when multiple sections.
 I $P(LRREF,",",4)=0 D  Q
 . N LRSECT,X,Y
 . S LRREC(LRREC)="Microbiology Report",LRSECT=0
 . F X=1,5,8,11,16 D  Q:LRSECT=""
 . . I '$D(^LR(LRDFN,"MI",$P(LRREF,",",3),X)) Q
 . . I LRSECT=0 S LRSECT=X
 . . E  S LRSECT=""
 . I LRSECT<1 Q
 . S X="Bacteriology^^^^Parasite^^^Mycology^^^Mycobacterium^^^^^Virology"
 . S Y=$P(X,"^",LRSECT)
 . I Y'="" S LRREC(LRREC)=Y_" Report"
 ;
 I $P($P(LRREF,";"),",",4)=1 D  Q
 . I $P(LRREF,";",2)=5 S LRREC(LRREC)="Sputum Screen" Q
 . I $P(LRREF,";",2)=6 S LRREC(LRREC)="Urine Screen" Q
 . S LRREC(LRREC)="Bacteriology Report"
 ;
 I $P(LRREF,",",4)=2 D  Q
 . I $P(LRREF,",",5)=0 S LRREC(LRREC)="Gram Stain" Q
 . S LRREC(LRREC)="Gram Stain Comment #"_$$CMTSEQ(LRREF)
 ;
 I $P(LRREF,",",4)=3 D  Q
 . N LRORG
 . I $P(LRREF,",",5)=0 S LRREC(LRREC)="Organism Identification" Q
 . S LRORG=$$GETORG(LRREF)
 . I $P(LRREF,",",6)=1 D  Q
 . . I $P(LRREF,",",7)>0 S LRREC(LRREC)=LRORG_" Comment #"_$$CMTSEQ(LRREF) Q
 . . S LRREC(LRREC)=LRORG_" Comment"
 . I ($P(LRREF,",",6)\1)=2 S LRREC(LRREC)=LRORG_" "_$$GETDRUG(3,$P(LRREF,",",6))_" Susceptibility" Q
 . I $P(LRREF,",",6)=3,$P(LRREF,",",7)>0 S LRREC(LRREC)=LRORG_" "_$$GETDRUG2(LRREF)_" Susceptibility" Q
 . S LRREC(LRREC)=LRORG
 ;
 I $P(LRREF,",",4)=4 D  Q
 . I $P(LRREF,",",5)=0 S LRREC(LRREC)="Bact Report Remark" Q
 . S LRREC(LRREC)="Bact Report Remark #"_$$CMTSEQ(LRREF)
 ;
 I $P(LRREF,",",4)=5 S LRREC(LRREC)="Parasite Report" Q
 ;
 I $P(LRREF,",",4)=6 D  Q
 . I $P(LRREF,",",5)=0 S LRREC(LRREC)="Parasite Identification" Q
 . S LRORG=$$GETORG(LRREF)
 . I $P(LRREF,",",8)=1 D  Q
 . . I $P(LRREF,",",9)>0 S LRREC(LRREC)=LRORG_" Stage Comment #"_$$CMTSEQ(LRREF) Q
 . . S LRREC(LRREC)=LRORG_" Stage Comment"
 . I $P(LRREF,",",7)>0 S LRREC(LRREC)=LRORG_" Parasite Stage" Q
 . S LRREC(LRREC)=LRORG
 ;
 I $P(LRREF,",",4)=7 D  Q
 . I $P(LRREF,",",5)=0 S LRREC(LRREC)="Parasite Report Remark" Q
 . S LRREC(LRREC)="Parasite Report Remark #"_$P(LRREF,",",5)
 ;
 I $P(LRREF,",",4)=8 S LRREC(LRREC)="Mycology Report" Q
 ;
 I $P(LRREF,",",4)=9 D  Q
 . I $P(LRREF,",",5)=0 S LRREC(LRREC)="Mycology Identification" Q
 . S LRORG=$$GETORG(LRREF)
 . I $P(LRREF,",",6)=1 D  Q
 . . I $P(LRREF,",",7)>0 S LRREC(LRREC)=LRORG_" Comment #"_$$CMTSEQ(LRREF) Q
 . . S LRREC(LRREC)=LRORG_" Comment"
 . S LRREC(LRREC)=LRORG
 ;
 I $P(LRREF,",",4)=10 D  Q
 . I $P(LRREF,",",5)=0 S LRREC(LRREC)="Mycology Report Remark" Q
 . S LRREC(LRREC)="Mycology Report Remark #"_$$CMTSEQ(LRREF) Q
 ;
 I $P($P(LRREF,";"),",",4)=11 D  Q
 . I $P(LRREF,";",2)=3 S LRREC(LRREC)="Acid Fast Stain" Q
 . S LRREC(LRREC)="Mycobacterium Report"
 ;
 I $P(LRREF,",",4)=12 D
 . N LRORG
 . I $P(LRREF,",",5)=0 S LRREC(LRREC)="Mycobacterium Identification" Q
 . S LRORG=$$GETORG(LRREF)
 . I $P(LRREF,",",6)=1 D  Q
 . . I $P(LRREF,",",7)>0 S LRREC(LRREC)=LRORG_" Comment #"_$$CMTSEQ(LRREF) Q
 . . S LRREC(LRREC)=LRORG_" Comment"
 . I $P(LRREF,",",6)>1 S LRREC(LRREC)=LRORG_" "_$$GETDRUG(12,$P(LRREF,",",6))_" Susceptibility" Q
 . S LRREC(LRREC)=LRORG
 ;
 I $P(LRREF,",",4)=13 D  Q
 . I $P(LRREF,",",5)=0 S LRREC(LRREC)="Mycobacterium Report Remark" Q
 . S LRREC(LRREC)="Mycobacterium Report Remark #"_$$CMTSEQ(LRREF)
 ;
 I $P(LRREF,",",4)=14 D  Q
 . I $P(LRREF,",",5)=0 S LRREC(LRREC)="Antibiotic Serum Level" Q
 . S LRREC(LRREC)="Antibiotic Serum Level "_$$GETDRUG2(LRREF)
 ;
 I $P(LRREF,",",4)=15 D  Q
 . I $P(LRREF,",",5)=0 S LRREC(LRREC)="Mycology Smear/Prep" Q
 . S LRREC(LRREC)="Mycology smear/prep Remark #"_$$CMTSEQ(LRREF)
 ;
 I $P(LRREF,",",4)=16 S LRREC(LRREC)="Virology Report" Q
 ;
 I $P(LRREF,",",4)=17 D  Q
 . I $P(LRREF,",",5)=0 S LRREC(LRREC)="Virus Identification" Q
 . S LRORG=$$GETORG(LRREF)
 . S LRREC(LRREC)=LRORG
 ;
 I $P(LRREF,",",4)=18 D  Q
 . I $P(LRREF,",",5)=0 S LRREC(LRREC)="Virology Report Remark" Q
 . S LRREC(LRREC)="Virology Report Remark #"_$$CMTSEQ(LRREF)
 ;
 I $P(LRREF,",",4)>18,$P(LRREF,",",4)<31 D  Q
 . N LRI,LRX
 . S LRI=$P(LRREF,",",4)
 . I LRI>18,LRI<24 S LRX="Preliminary "_$S(LRI=19:"BACT",LRI=20:"VIROLOGY",LRI=21:"PARASITE",LRI=22:"MYCOLOGY",1:"TB")_" Comment"
 . I LRI>23,LRI<26 S LRX=$S(LRI=24:"PARASITOLOGY",1:"BACTERIOLOGY")_" SMEAR/PREP"
 . I LRI>25,LRI<31 S LRX=$S(LRI=26:"BACTERIOLOGY",LRI=27:"PARASITE",LRI=28:"MYCOLOGY",LRI=29:"TB",1:"VIROLOGY")_" TESTS"
 . I $P(LRREF,",",5)=0 S LRREC(LRREC)=LRX Q
 . S LRREC(LRREC)=LRX_" #"_$$CMTSEQ(LRREF)
 ;
 ; Sterility Results
 I $P(LRREF,",",4)=31 S LRREC(LRREC)="Sterility Results" Q
 ;
 ; Comment on specimen
 I $P(LRREF,",",4)=99 S LRREC(LRREC)="Comment On Specimen" Q
 ;
 Q
 ;
 ;
APCHK ; Check and resolve SP, CY and EM subscript
 ;
 N LRSS
 S LRSS=$P(LRREF,",",2)
 ;
 ; Type of report
 I $P(LRREF,",",4)=0 S LRREC(LRREC)=$S(LRSS="SP":"Surgical Pathology",LRSS="CY":"Cytology",LRSS="EM":"Electron Microscopy",1:"")_" Report" Q
 ;
 ; Frozen section
 I LRSS="SP",$P(LRREF,",",4)=1.3 S LRREC(LRREC)="Frozen Section" Q
 ;
 ; Info accompanying request
 I $P(LRREF,",",4)=.2 S LRREC(LRREC)="Brief Clinical History" Q
 I $P(LRREF,",",4)=.3 S LRREC(LRREC)="Preoperative Diagnosis" Q
 I $P(LRREF,",",4)=.4 S LRREC(LRREC)="Operative Findings" Q
 I $P(LRREF,",",4)=.5 S LRREC(LRREC)="Post-Operative Diagnosis" Q
 ;
 ; Descriptions
 I $P(LRREF,",",4)=1 S LRREC(LRREC)="Gross Description" Q
 I $P(LRREF,",",4)=1.1 S LRREC(LRREC)="Microscopic Description" Q
 ;
 ; Surgical Path Diagnois
 I $P(LRREF,",",4)=1.4 S LRREC(LRREC)="Surgical Path Diagnosis" Q
 ;
 ; Supplementary Reports
 I $P(LRREF,",",4)=1.2 D  Q
 . N LRI,LRX
 . I $P(LRREF,",",5)=0 S LRREC(LRREC)="Supplementary Report" Q
 . S LRI=$G(^LR($P(LRREF,","),$P(LRREF,",",2),$P(LRREF,",",3),$P(LRREF,",",4),$P(LRREF,",",5),0))
 . S LRX=$$FMTE^XLFDT(+LRI,"1MZ")
 . S LRREC(LRREC)="Supplementary Report for "_LRX
 ;
 ; Special Studies
 I $P(LRREF,",",4)=2 D  Q
 . N LRI,LRX,LRSST
 . I $P(LRREF,",",5)=0 S LRREC(LRREC)="Special Studies" Q
 . S LRI=$G(^LR($P(LRREF,","),$P(LRREF,",",2),$P(LRREF,",",3),$P(LRREF,",",4),$P(LRREF,",",5),0))
 . S LRX=$P(^LAB(61,+LRI,0),"^")
 . I $P(LRREF,",",7) D  Q
 . . S LRI=$G(^LR($P(LRREF,","),$P(LRREF,",",2),$P(LRREF,",",3),$P(LRREF,",",4),$P(LRREF,",",5),5,$P(LRREF,",",7),0))
 . . S LRSST=$$EXTERNAL^DILFD(63.819,.01,"",$P(LRI,"^"),"")
 . . S LRREC(LRREC)="Special Studies on "_LRX_" "_LRSST
 . S LRREC(LRREC)="Special Studies on "_LRX
 ;
 ; Delayed report comment
 I $P(LRREF,",",4)=97 D  Q
 . I $P(LRREF,",",5)>0 S LRREC(LRREC)="Delayed Report Comment #"_$$CMTSEQ(LRREF) Q
 . S LRREC(LRREC)="Delayed Report Comment"
 ;
 I $P(LRREF,",",4)=99 D  Q
 . I $P(LRREF,",",5)>0 S LRREC(LRREC)="Comment #"_$$CMTSEQ(LRREF) Q
 . S LRREC(LRREC)="Comment"
 Q
 ;
 ;
AUCHK ; Check and resolve AU subscript
 ;
 ; Type of report
 I $P(LRREF,",",4)="AU",$P(LRREF,",",5)=0 S LRREC(LRREC)="Autospy" Q
 ;
 I $P(LRREF,",",4)="AZC" D
 . I $P(LRREF,",",5)>0 S LRREC(LRREC)="Autopsy Comment #"_$$CMTSEQ(LRREF) Q
 . S LRREC(LRREC)="Autopsy Comment"
 ;
 ; Descriptions
 I $P(LRREF,",",4)=81 S LRREC(LRREC)="Clinical Diagnoses" Q
 I $P(LRREF,",",4)=82 S LRREC(LRREC)="Pathological Diagnoses" Q
 ;
 ; Special Studies
 I $P(LRREF,",",4)="AY" D  Q
 . N LRI,LRX,LRSST
 . I $P(LRREF,",",5)=0 S LRREC(LRREC)="Special Studies" Q
 . S LRI=$G(^LR($P(LRREF,","),$P(LRREF,",",4),$P(LRREF,",",5),0))
 . S LRX=$P(^LAB(61,+LRI,0),"^")
 . I $P(LRREF,",",5) D  Q
 . . S LRI=$G(^LR($P(LRREF,","),$P(LRREF,",",4),$P(LRREF,",",5),$P(LRREF,",",6),$P(LRREF,",",7),0))
 . . S LRSST=$$EXTERNAL^DILFD(63.26,.01,"",$P(LRI,"^"),"")
 . . S LRREC(LRREC)="Special Studies on "_LRX_" "_LRSST
 . S LRREC(LRREC)="Special Studies on "_LRX
 ;
 ; Supplementary Reports
 I $P(LRREF,",",4)=84 D  Q
 . N LRI,LRX
 . I $P(LRREF,",",5)=0 S LRREC(LRREC)="Supplementary Report" Q
 . S LRI=$G(^LR($P(LRREF,","),84,$P(LRREF,",",3),0))
 . S LRX=$$FMTE^XLFDT(+LRI,"1MZ")
 . S LRREC(LRREC)="Supplementary Report for "_LRX
 ;
 Q
 ;
 ;
GETORG(LRREF) ; Retrieve name of organism from file #61.2
 ; Call with LRREF = reference to entry in file #63
 ;
 N LRI,LRX
 S LRI=$G(^LR($P(LRREF,","),$P(LRREF,",",2),$P(LRREF,",",3),$P(LRREF,",",4),$P(LRREF,",",5),0))
 S LRX=$$TITLE^XLFSTR($P($G(^LAB(61.2,+LRI,0)),"^"))
 ;
 Q LRX
 ;
 ;
GETDRUG(LRSECT,LRJ) ; Retreive name of drug in file #62.06 from drug data name
 ; Call with LRSECT = drug section in MI subscript (3=bacteria/12-TB)
 ;              LRJ = drug node
 ;
 ;     Returns LRDN = name of drug
 ;
 N LRDN
 S LRDN=$O(^LAB(62.06,$S(LRSECT=3:"AD",1:"AD1"),LRJ,0))
 I LRDN S LRDN=$$TITLE^XLFSTR($P($G(^LAB(62.06,LRDN,0)),"^"))
 ;
 Q LRDN
 ;
 ;
GETDRUG2(LRREF) ; Retreive name of drug in file 63.32 (#200) ANTIBIOTIC or file 63.42A (#28) ANTIBIOTIC LEVEL
 ; Call with LRREF = reference to entry in file #63
 ;
 ;    Returns LRDN = name of drug
 ;
 N LRDN,LRI
 I $P(LRREF,",",7)="" S LRI=$G(^LR($P(LRREF,","),$P(LRREF,",",2),$P(LRREF,",",3),$P(LRREF,",",4),$P(LRREF,",",5),$P(LRREF,",",6)))
 E  S LRI=$G(^LR($P(LRREF,","),$P(LRREF,",",2),$P(LRREF,",",3),$P(LRREF,",",4),$P(LRREF,",",5),$P(LRREF,",",6),$P(LRREF,",",7),$P(LRREF,",",8)))
 S LRDN=$P(LRI,"^")
 ;
 Q LRDN
 ;
 ;
CMTSEQ(LRREF) ; Determine the sequence # for a comment line
 ; Deal with intervening comments being deleted during edits resulting in the comment IEN being
 ; different than the display sequence #.
 ;
 ; Call with LRREF = id reference of specific comment
 ;
 ; Returns     LRY = display sequence #
 ;
 N LRDFN,LRI,LRIDT,LRSECT,LRSS,LRX,LRY
 S (LRY,LRI)=0
 S LRDFN=$P(LRREF,",")
 I $P(LRREF,",",2)?1(1"CH",1"MI",1"SP",1"CY",1"EM") S LRSS=$P(LRREF,",",2),LRIDT=$P(LRREF,",",3),LRSECT=$P(LRREF,",",4)
 E  S LRSS="AU",LRSECT=$P(LRREF,",",2)
 ;
 I LRSS="MI" D MISEQ
 ;
 ; Check AP comments
 I LRSS?1(1"SP",1"CY",1"EM"),(LRSECT=97!(LRSECT=99)) D
 . F  S LRI=$O(^LR(LRDFN,LRSS,LRIDT,LRSECT,LRI)) Q:'LRI  S LRY=LRY+1 I LRI=$P(LRREF,"^",5) Q
 ;
 I LRSS="AU" D
 . F  S LRI=$O(^LR(LRDFN,LRSECT,LRI)) Q:'LRI  S LRY=LRY+1 I LRI=$P(LRREF,"^",4) Q
 ;
 Q LRY
 ;
 ;
MISEQ ; Check for comment seq on MI subscript
 ;
 ; Sections 2,4,7,10,13,14,15,18-30
 S LRX="^1^^1^^^1^^^1^^^1^1^1^^^1^1^1^1^1^1^1^1^1^1^1^1^1^"
 I $P(LRX,"^",LRSECT) D  Q
 . F  S LRI=$O(^LR(LRDFN,LRSS,LRIDT,LRSECT,LRI)) Q:'LRI  S LRY=LRY+1 I LRI=$P(LRREF,",",5) Q
 ;
 ; Sections 3,9,12
 S LRX="^^1^^^^^^1^^^1^"
 I $P(LRX,"^",LRSECT) D  Q
 . F  S LRI=$O(^LR(LRDFN,LRSS,LRIDT,LRSECT,$P(LRREF,",",5),1,LRI)) Q:'LRI  S LRY=LRY+1 I LRI=$P(LRREF,",",7) Q
 ;
 ; Section 6 - Parasite Stage Comment (multiple 3 levels down)
 I LRSECT=6 D  Q
 . F  S LRI=$O(^LR(LRDFN,LRSS,LRIDT,LRSECT,$P(LRREF,",",5),1,$P(LRREF,",",6),1,LRI)) Q:'LRI  S LRY=LRY+1 I LRI=$P(LRREF,",",9) Q
 ;
 Q
