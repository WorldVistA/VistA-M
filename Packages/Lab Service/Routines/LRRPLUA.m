LRRPLUA ;DALOI/JMC - Lab Report Performing Lab Utility ;10/28/11  16:33
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 Q
 ;
 ;
SETPL(LRREF,LR4) ; Set performing lab reference into workbench
 ; Call with LRREF = performing lab reference
 ;             LR4 = performing lab IEN in file #4
 ;
 S ^TMP("LRPL",$J,1,LRREF)=LR4
 S ^TMP("LRPL",$J,2,LR4,LRREF)=""
 ;
 Q
 ;
 ;
ROLLUPPL(LRDFN,LRSS,LRIDT) ; Roll up performing labs and store in file #63
 ; Call with LRDFN = File #63 internal entry number
 ;            LRSS = File #63 subscript
 ;           LRIDT = inverse date/time of entry in file #63
 ;
 N LRPLAB,LRREF,LRX
 ;
 ; Merge/consolidate workbench entries for same basic reference.
 ; Check and merge TMP entries to create list and elimiate unnecessary multiples.
 D MERGE
 ;
 ; Update existing entry/create new entry
 S LRREF=""
 F  S LRREF=$O(^TMP("LRPL",$J,1,LRREF)) Q:LRREF=""  D
 . S LRPLAB=$P(^TMP("LRPL",$J,1,LRREF),"^")
 . S LRX=$O(^LR(LRDFN,"PL","B",LRREF,0))
 . I 'LRX D CNE^LRRPLU(LRDFN,LRREF,LRPLAB) Q
 . I $P(^LR(LRDFN,"PL",LRX,0),"^",2)'=LRPLAB D UEE^LRRPLU(LRDFN,LRREF,LRPLAB)
 ;
 K ^TMP("LRPL",$J)
 Q
 ;
 ;
MERGE ; Check and merge entries where appropriate.
 ;
 N I,LRJ,LRK,LRONELAB,LRREF,LRX,LRY,LRZ
 ;
 S LRONELAB("ON FILE")="" ; Initialize to no lab (null) on file.
 S LRONELAB("INCOMING")=0 ; Intialize to no lab on incoming report.
 ;
 ; If only one lab listed in incoming report then set flag to that lab.
 S LRX=$O(^TMP("LRPL",$J,2,0))
 I '$O(^TMP("LRPL",$J,2,LRX)) S LRONELAB("INCOMING")=LRX
 ;
 ; Find out if existing report has performing lab and if more then one.
 ;  If more then one then set flag to 0 (zero).
 S LRX=0,LRY=""
 F  S LRX=$O(^LR(LRDFN,"PL","AC",LRSS,LRIDT,LRX)) Q:'LRX  D  Q:LRY=0
 . I LRY,LRY'=$P(^LR(LRDFN,"PL",LRX,0),"^",2) S LRY=0 Q
 . I LRY="" S LRY=$P(^LR(LRDFN,"PL",LRX,0),"^",2)
 ;
 S LRONELAB("ON FILE")=LRY
 ;
 ; If all "on file" sections and all "incoming" sections have the same performing lab
 ;  then mark the entire report as being performed by that lab.
 I LRONELAB("ON FILE")=LRONELAB("INCOMING") D  Q
 . K ^TMP("LRPL",$J)
 . S LRREF=LRDFN_","_LRSS_","_LRIDT_",0"
 . S ^TMP("LRPL",$J,1,LRREF)=LRONELAB("INCOMING")
 ;
 ; If no "on file" lab and one "incoming" lab
 ;  then mark entire report as being performed by the "incoming" lab.
 I LRONELAB("ON FILE")="",LRONELAB("INCOMING") D  Q
 . K ^TMP("LRPL",$J)
 . S LRREF=LRDFN_","_LRSS_","_LRIDT_",0"
 . S ^TMP("LRPL",$J,1,LRREF)=LRONELAB("INCOMING")
 ;
 ; Walk up tree to find parent reference that may cover this reference at a higher level
 S LRREF=""
 F  S LRREF=$O(^TMP("LRPL",$J,1,LRREF)) Q:LRREF=""  D
 . S LRPLAB=$P(^TMP("LRPL",$J,1,LRREF),"^")
 . I LRSS="CH" D CHCHK Q
 . I LRSS?1(1"MI",1"SP",1"CY",1"EM",1"AU") D MIAPCHK
 ;
 Q
 ;
 ;
CHCHK ; Find "on file" performing lab for a "CH" test result.
 ;
 S LRZ=LRREF D CHKNODE
 Q
 ;
 ;
MIAPCHK ; Find performing lab for a MI or AP subscript reference
 ;
 S LRZ=LRREF D CHKNODE Q:LRY
 I $P(LRREF,";",2)'="" S LRZ=$P(LRREF,";") D CHKNODE Q:LRY
 ;
 S LRJ=$L(LRZ,",")
 F LRK=LRJ:-1:4 D  Q:LRY
 . S LRZ=$P(LRZ,",",1,LRK) D CHKNODE Q:LRY
 . I $P(LRZ,",",LRK)>0 S $P(LRZ,",",LRK)=0 D CHKNODE
 ;
 I LRSS="MI",LRY="",$P(LRX,",",4)=99 F I=1,5,8,11,16 S $P(LRZ,",",4)=I D CHKNODE Q:LRY
 ;
 Q
 ;
 ;
CHKNODE ; Check if "on file" node or parent exists and delete "incoming" if it matches "on file" lab
 ;
 N LRI
 S LRY="",LRI=$O(^LR(LRDFN,"PL","B",LRZ,0))
 I LRI S LRY=$P(^LR(LRDFN,"PL",LRI,0),"^",2)
 I LRY,LRY=LRPLAB K ^TMP("LRPL",$J,1,LRREF) Q
 ;
 ; Check if "incoming" has a higher parent for the same lab.
 I LRREF'=LRZ D
 . S LRY=+$G(^TMP("LRPL",$J,1,LRZ))
 . I LRY,LRY=LRPLAB K ^TMP("LRPL",$J,1,LRREF)
 Q
 ;
 ;
TEST ; Entry point to test/debug
 ;
 N LRAA,LRAD,LRAN,LRACC,LRDFN,LRIDT,LRSS
 S LRACC=1
 F  D  Q:LRAA<1
 . W !
 . D EN^LRWU4
 . I LRAA<1 Q
 . S LRDFN=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,0),"^"),LRSS=$P(^LRO(68,LRAA,0),"^",2)
 . I LRSS'="AU" S LRIDT=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,3),"^",5)
 . E  S LRIDT=""
 . I LRSS="BB" W !,"Blood Bank not supported" Q
 . D EDIT^LRRPLU(LRDFN,LRSS,LRIDT)
 . W !!
 ;
 Q
 ;
 ;
TEST2 ; Entry point test printing performing lab for an accession
 ;
 N LRAA,LRAD,LRAN,LRACC,LRDFN,LRIDT,LRPL,LRSS
 S LRACC=1
 F  D  Q:LRAA<1
 . W !
 . D EN^LRWU4
 . I LRAA<1 Q
 . S LRDFN=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,0),"^"),LRSS=$P(^LRO(68,LRAA,0),"^",2)
 . I LRSS'="AU" S LRIDT=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,3),"^",5)
 . E  S LRIDT=0
 . I LRSS="BB" W !,"Blood Bank not supported" Q
 . K LRPL
 . D RETLST^LRRPL(.LRPL,LRDFN,LRSS,LRIDT,0)
 . I '$O(LRPL(0)) K LRPL S LRPL(1)="Performing Lab Sites: None Listed"
 . E  S LRPL(.5)="Performing Lab Sites:",LRPL(.6)=" "
 . W !! D EN^DDIOL(.LRPL)
 Q
NOASK ; Set reference to performing lab in file #63 If ASK PERFORMING LAB =NO
 ; Update if already set otherwise create a new record.
 ;
 N LRDPL,LRFLAG,LRREF,LRPLAB,LRSECT
 S LRFLAG=0,LRSECT=0
 I LRSS?1(1"MI",1"SP",1"CY",1"EM") S LRFLAG=1
 S LRDPL=$$GET^XPAR("USR","LR VER DEFAULT PERFORMING LAB",1,"Q")
 I LRDPL<1 S LRDPL=DUZ(2)
 S LRPLAB=LRDPL
 S LRREF=LRDFN_","_LRSS_","_LRIDT_","_LRSECT
 ;
 W !
 ; Update existing entry
 I $D(^LR(LRDFN,"PL","B",LRREF)) D  Q
 . D UEE^LRRPLU(LRDFN,LRREF,LRPLAB)
 ;
 ; Create new entry
 D CNE^LRRPLU(LRDFN,LRREF,LRPLAB)
 Q
