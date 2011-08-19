EASEZW ;ALB/jap - Auto-process 1010EZ from Web-based Application ; 5/23/08 4:30pm
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**2,51,70**;Mar 15, 2001;Build 26
 ;
EN ;entry point from server option
 ;standard server variables XMZ,XMRG,XMER
 ;new incoming 1010EZ application data to be filed in #712
 ;
 Q:'$G(XMZ)
 S X=$P(^XMB(3.9,XMZ,0),U,1)
 ;won't always know the exact format of message subject
 S X=$P(X,"SID ",2),X=$P(X,U,1),X=$P(X,":",1)
 S EASWEBID=$TR(X," ","")
 Q:EASWEBID=""
 ;don't process if this web submission has been previously rec'd;
 I $D(^EAS(712,"W",EASWEBID)) D  Q
 . S EASAPP=$O(^EAS(712,"W",EASWEBID,0))
 . ;make sure this is an automated 1010EZ data msg
 . S OK=0 F  X XMREC Q:XMER=-1  S LINE=XMRG D  Q:OK
 . . I (LINE["SECTION")!(LINE["Section") S LINE=$$UC^EASEZT1(LINE)
 . . I LINE["VISTA AUTOMATION" S OK=1
 . ;send receipt confirmation to get Forum in sync and quit
 . I OK D CONFIRM(EASWEBID,EASAPP,XMZ)
 ;continue processing if this web submission is new
 ;get facility applying to (station #)
 S X=$P($P(^XMB(3.9,XMZ,0),U,1),":",1) I X'="" D
 . S EASFAC=X,X=$E(X,1,3)
 . I +X'=X S EASFAC=""
 ;get message receipt date
 S EASRECD=$P($P($G(^XMB(3.9,XMZ,.6)),U,1),".",1)
 ;set next ien for file #712 to match #.01 field, not less than 101
 S OUT=0,CYCLE=0 F  D  Q:OUT  Q:CYCLE>5
 . S CYCLE=CYCLE+1
 . S DINUM=$O(^EAS(712,"B",""),-1) S:'DINUM DINUM=$O(^EAS(712,999999999),-1)
 . S DINUM=DINUM+1 S:DINUM<100 DINUM=DINUM+100
 . S DIC="^EAS(712,",DIC(0)="L",DLAYGO="",(NEWIEN,X)=DINUM
 . K DD,DO D FILE^DICN
 . ;repair faulty "B" index
 . I Y=-1,$D(^EAS(712,NEWIEN,0)) S ^EAS(712,"B",NEWIEN,NEWIEN)="" H 3
 . I Y>0 S OUT=1
 Q:+Y<0
 S (DA,EASAPP)=+Y
 S DIE="^EAS(712,"
 S DR=".2///^S X=XMZ;3////^S X=EASRECD;3.1///^S X=.5;3.2///^S X=""W"";4.5///^S X=EASFAC"
 D ^DIE
 S LINES=$$LINES()
 I 'LINES D
 . S DA=EASAPP,DIK="^EAS(712," D ^DIK
 I LINES D NMSSNDOB D DESIGNEE D CONFIRM(EASWEBID,EASAPP,XMZ)
 ;EAS*1.0*70 - Check for APPLICANT COUNTRY
 I LINES D
 . N X,EASKEY,EASDATA,EASIEN,DINUM,DIC,DIE,DLAYGO,DA,DR,MULTIPLE,ACCEPT
 . S X=+$$KEY711^EASEZU1("APPLICANT COUNTRY")
 . I '$D(^EAS(712,EASAPP,10,"B",X)) D
 . . S EASKEY="I;9H.",EASDATA="USA"
 . . S (EASIEN,DINUM)=$O(^EAS(712,EASAPP,10,"B"),-1)+1
 . . S (DIC,DIE)="^EAS(712,EASAPP,10,",DIC(0)="L",DLAYGO=""
 . . S DA(1)=EASAPP,DIC("P")=$P(^DD(712,10,0),U,2)
 . . K DD,DO D FILE^DICN
 . . S DA=EASIEN,DR(1)="10;",MULTIPLE=1,ACCEPT=1
 . . S DR=".1///^S X=MULTIPLE;1///^S X=EASDATA;1.1///^S X=ACCEPT;"
 . . D ^DIE
 Q
 ;
LINES() ;parse data lines from message into #712 record
 N OUT,SECT,LINE,KEYIEN,DATANM,ADDCHILD,MULTIPLE,ZM,ZMM,OUT,DA,DR,DIC,DIE,DINUM,DLAYGO
 N ADDINSUR,ADDINCOM,ADDASSET,HIIE
 ;find beginning of data lines
 S OUT=0 F  X XMREC Q:XMER=-1  S LINE=XMRG D  Q:OUT
 . I (LINE["SECTION")!(LINE["Section") S LINE=$$UC^EASEZT1(LINE)
 . I LINE["VISTA AUTOMATION" S OUT=1
 . I LINE["SECTION" D  Q
 . . S SECT=$P(LINE," - ",1),SECT=$TR(SECT," ",""),SECT=$P(SECT,"SECTION",2)
 . . S EASSECT=$TR(SECT,".","")
 I 'OUT Q 0
 ;file data lines
 ;variable EASIEN is the subrecord ien for data filing in file #712
 S EASIEN=0,OUT=0,ADDCHILD=0
 S ADDINSUR=0,ADDINCOM=0,ADDASSET=0
 F  X XMREC Q:XMER=-1  D  Q:OUT
 . S LINE=XMRG
 . I (LINE["SECTION")!(LINE["Section") S LINE=$$UC^EASEZT1(LINE)
 . I LINE["SECTION III" D SEC3 S OUT=1 Q
 . I $E(LINE,1,3)="EOF" Q
 . I LINE["ADDITIONAL CHILD" S ADDCHILD=ADDCHILD+1 Q
 . I LINE["ADDITIONAL INSURANCE" S ADDINSUR=ADDINSUR+1 Q
 . I LINE["ADDITIONAL INCOME" S ADDINCOM=ADDINCOM+1 Q
 . I LINE["ADDITIONAL ASSET" S ADDASSET=ADDASSET+1 Q
 . I LINE["SECTION" D  Q
 . . S SECT=$P(LINE," - ",1),SECT=$TR(SECT," ",""),SECT=$P(SECT,"SECTION",2)
 . . S EASSECT=$TR(SECT,".","")
 . S ZM=1,ZMM=2
 . F  D  Q:EASKEY=""  S ZM=ZM+2,ZMM=ZM+1
 . . S EASKEY=$P(LINE,U,ZM),EASKEY=$TR(EASKEY," ","")
 . . Q:EASKEY=""
 . . S EASDATA=$E($P(LINE,U,ZMM),1,240)
 . . ;don't file null data
 . . Q:(EASDATA=" ")!(EASDATA="")
 . . ;don't file 'empty' dates, phone numbers, ssns, etc.
 . . Q:(EASDATA="/")  Q:(EASDATA="//")  Q:(EASDATA="-")  Q:(EASDATA="--")  Q:(EASDATA["?")
 . . I EASKEY["." S EASKEY=EASSECT_";"_EASKEY
 . . I (EASKEY="IIE;1.")!(EASKEY="IIE;2.")!(EASKEY="IIE;3.") S HIIE(EASKEY)=EASDATA
 . . I (EASKEY="IIE;1.1")!(EASKEY="IIE;2.1")!(EASKEY="IIE;3.1") S EASDATA=$G(HIIE($E(EASKEY,1,6)))
 . . ;find this data element in the mapping file #711
 . . S X=$$KEY711^EASEZU1(EASKEY),KEYIEN=+X,DATANM=$P(X,U,2)
 . . S EASIEN=EASIEN+1
 . . ;create subrecord
 . . S DIC="^EAS(712,EASAPP,10,",DIC(0)="L",DLAYGO="",X=KEYIEN,DINUM=EASIEN
 . . S DA(1)=EASAPP,DIC("P")=$P(^DD(712,10,0),U,2)
 . . K DD,DO D FILE^DICN
 . . ;file data element
 . . S DIE="^EAS(712,EASAPP,10,",DA=EASIEN,DA(1)=EASAPP,DR(1)="10;"
 . . S MULTIPLE=1
 . . ;I DATANM["CHILD(N)" S MULTIPLE=ADDCHILD
 . . I DATANM["CHILD(N)" S MULTIPLE=$S(ADDINCOM:ADDINCOM,1:ADDCHILD)
 . . I DATANM["C(N)" S MULTIPLE=ADDCHILD
 . . I DATANM["OTHER(N)" S MULTIPLE=ADDINSUR
 . . ;I DATANM["INCOME(N)" S MULTIPLE=ADDINCOM
 . . I DATANM["ASSET(N)" S MULTIPLE=ADDASSET
 . . S DR=".1///^S X=MULTIPLE;1///^S X=EASDATA;"
 . . D ^DIE
 Q 1
 ;
 ;EAS*1.0*70 - 
 ;The following sections were split out to EASEZW2 to reduce routine
 ;size, but the tags still left in for other routines calling this one.
 ;
SEC3 ;special parsing for Section III
 D SEC3^EASEZW2   ;EAS*1.0*70 - split out to reduce rtn size
 Q
 ;
NMSSNDOB ;find applicant's name,ssn,dob in data subrecords & file in main record
 D NMSSNDOB^EASEZW2   ;EAS*1.0*70 - split out to reduce rtn size
 Q
 ;
VETTYPE(EASAPP) ;derive a veteran type categorization for this Applicant
 ;input  EASAPP = ien in file #712 for Application
 ;output TYPE   = veteran type
 ;
 Q $$VETTYPE^EASEZW2(EASAPP)   ;EAS*1.0*70 - split out to reduce rtn size
 ;
DESIGNEE ;set either NOK or E-CONTACT data into DESIGNEE
 D DESIGNEE^EASEZW2   ;EAS*1.0*70 - split out to reduce rtn size
 Q
 ;
DSGDAT ;
 ;;LAST NAME;
 ;;FIRST NAME;
 ;;STREET ADDRESS;
 ;;CITY;
 ;;STATE;
 ;;ZIP;;
 ;;HOME PHONE AREA CODE;
 ;;HOME PHONE NUMBER;
 ;;WORK PHONE AREA CODE;
 ;;WORK PHONE NUMBER;
 ;;WORK PHONE EXTENSION;
 ;;RELATIONSHIP;
 ;;QUIT
 ;
CONFIRM(EASWEBID,EASAPP,EASXMZ) ;confirm receipt of web submission message to Forum
 ;input EASAPP   = ien in file #712
 ;      EASWEBID = web submission id
 ;      EASXMZ   = ien in file #3.9 for msg being processed
 D CONFIRM^EASEZW2(EASWEBID,EASAPP,EASXMZ)   ;EAS*1.0*70 - split out to reduce rtn size
 Q
