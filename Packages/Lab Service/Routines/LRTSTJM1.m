LRTSTJM1 ;DALOI/STAFF- JAM TESTS ONTO (OR OFF) ACCESSIONS (cont.) ;10/25/11  12:14
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
EXPLD ;
 S LRTSAD1=0
 F  S LRTSAD1=$O(LRTSAD(LRTSUB,LRTSAD1)) Q:'LRTSAD1  D EXPLD1
 K LRTSAD1,LRTSAD2,LRTSAD3,LRTSAD4
 Q
 ;
 ;
EXPLD1 ;
 Q:'$O(^LAB(60,LRTSAD1,2,0))  S LRTSAD4=LRTSAD1 N LRTSAD1,LRTSAD2,LRTSAD3 S LRTSAD2=LRTSAD4,LRTSAD3=0 K LRTSAD4
 F  S LRTSAD3=$O(^LAB(60,LRTSAD2,2,LRTSAD3)) Q:'LRTSAD3  I $D(^(LRTSAD3,0)),'$D(LRTSAD(LRTSUB,+^(0))) S LRTSAD1=+^(0),LRTSAD(LRTSUB,LRTSAD1)="" D EXPLD1
 Q
 ;
 ;
COMPTST ;
 ;
 D SCAN
 ;
 ; After call to SCAN:
 ;  I LRTSUB=0, then some overlap was found between test being added and the tests already on this accession.
 ;  I LRTSUB=2, then no overlap was found
 ;
 I LRTSUB K LRTSAD(2) Q  ;no overlap found
 ;
 ; If LRTSUB=0, then only add those atomic tests that are not already on this accession.
 ;
 I '$L(LRTSURG) D COMTST2 S LRTSURG=LRURG I 'LRURG S LRTSUB=0 Q
 ;
 N LRBORTYP,LRBBERF
 ; LRBORTYP and LRBBERF are used to backup and restore LRORTYP and LRBERF (respectively)
 ; so that user is only prompted for first atomic test in the panel if it's add-on/reflex,
 ; and isn't prompted for every subsequent atomic test in the panel.
 ;
 S (LRTSAD,LRTS)=0 F  S LRTS=$O(LRTSAD(2,LRTS)) Q:'LRTS!($D(LRADDTST))  I '$D(LRTSAD(1,LRTS)) D COMTST1
 W:'LRTSAD !,"All the individual tests for this panel",!,"are already included on this accession."
 K LRTSAD(2),LRTSURG
 Q
 ;
 ;
COMTST1 ;
 Q:$O(^LAB(60,LRTS,2,0))
 S LRTSAD=1,(Y,LRURG)=$S($L(LRTSURG):LRTSURG,1:$P(^LAB(60,LRTS,0),U,18)) W:'$L(Y) !,$P(^LAB(60,LRTS,0),U,1)
 D COMTST2:'$L(Y) S LRFLG=1
 I LRURG D
 . I $D(LRBORTYP) S LRORDTYP=LRBORTYP I $D(LRBBERF) S LRBERF=LRBBERF
 . I '$D(LRBORTYP) D  Q:$D(LRADDTST)
 . . S LRORDTYP=$$ORDTYP()
 . . I LRORDTYP<1 S LRADDTST=1 Q
 . . I $P(LRORDTYP,"^")=2 D
 . . . N LRORDTST
 . . . S LRORDTST=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRTSP,0)),U,9)
 . . . I LRORDTST="" S LRORDTST=LRTSP
 . . . S $P(LRORDTYP,"^",3)=LRORDTST,$P(LRORDTYP,"^",4)=$$NLT^LRVER1(LRORDTST)
 . . I +LRDPF=2,$G(LRSS)'="BB",'$$CHKINP^LRBEBA4(LRDFN,LRODT) S LRBERF=$S(LRORDTYP>0:LRORDTYP-1,1:-1) ;CIDC
 . . S LRBORTYP=LRORDTYP
 . . I $D(LRBERF) S LRBBERF=LRBERF
 . D EN^LRTSTSET
 Q
 ;
 ;
COMTST2 ;
 S DIC=62.05,DIC("B")="ROUTINE",DIC(0)="AEMOQ" D ^DIC K DIC("B") I Y<1 W !,"URGENCY must be defined.  Test not added." S LRURG=0 Q
 W !,"  ...OK" S %=1 D YN^DICN G COMTST2:%=2 S LRURG=$S((%<1):0,1:+Y)
 Q
 ;
 ;
SCAN ;
 N LRTS S LRTS=0 F  S LRTS=$O(LRTSAD(2,LRTS)) Q:'LRTS  I $D(LRTSAD(1,LRTS)) S LRTSUB=0
 Q
 ;
 ;
ORDTYP() ; Ask if test is "add on" or "reflex"
 N DIR,DUOUT,DTOUT,DIRUT,LRX,LRY,X,Y
 S DIR(0)="S^1:Add On;2:Reflex",DIR("A")="Type of test order being added"
 D ^DIR
 I $D(DIRUT) S LRY=-1
 E  S LRY=+Y
 I LRY>0 D
 . S LRX=$S(LRY=1:"A",LRY=2:"G",1:"A")
 . S $P(LRY,"^",2)=$$FIND1^DIC(64.061,"","OX",LRX,"D","I $P(^(0),U,5)=""0065""")
 Q LRY
 ;
 ;
ORUT(LRDFN,LRAA,LRAD,LRAN,LR60,LRORDTYP,LRURG,LRODT,LRSN) ; Setup ORUT node in file #63 for test just added.
 ; Call with LRDFN = file #63 IEN
 ;            LRAA = file #68 IEN
 ;            LRAD = accession date
 ;            LRAN = accession number
 ;            LR60 = file #60 IEN
 ;        LRORDTYP = 1(add)/2(reflex)^file #64.061 ien for code^if reflex parent test^if reflex parent NLT^
 ;           LRURG = file #62.05 urgency ien
 ;          LRORDT = file #69 order date
 ;            LRSN = file #69 order ien
 ;
 ; Called by LRTSTJAM
 ;
 N LR68,LRFDA,LRFILE,LRIDT,LRIENS,LRJUL,LRNLT,LRORD,LRORIFN,LRORNUM,LRPROV,LRSAMP,LRSPEC,LRSS,LRX,LRY,X,Y
 ;
 S LRSS=$P($G(^LRO(68,LRAA,0)),"^",2)
 S LRFILE=$S(LRSS="CH":63.07,LRSS="MI":63.5,LRSS="SP":63.53,LRSS="CY":63.51,LRSS="EM":63.52,1:"")
 Q:'LRFILE
 ;
 S LR68(0)=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,0))
 S X=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,5,0))
 S LR68(5)=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,5,X,0))
 S LRORD=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.1)),"^")
 S LRSPEC=$P(LR68(5),"^"),LRSAMP=$P(LR68(5),"^",2)
 S LRNLT=$$NLT^LRVER1(LR60) Q:+LRNLT<1
 S LRPROV=$P(LR68(0),"^",8),LRORNUM=""
 I LRORD D
 . S LRX=$$FMDIFF^XLFDT(DT,$E(DT,1,3)_"0101",1)
 . S LRX=LRX+1,LRJUL=$E("000",1,3-$L(LRX))_LRX
 . S LRORNUM="LR-"_LRORD_"-"_$E(DT,1,3)_LRJUL
 S LRIDT=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,3)),"^",5)
 S LRORIFN=$P($G(^LRO(69,LRODT,1,LRSN,0)),"^",11)
 ;
 S LRIENS="?+1"_","_LRIDT_","_LRDFN_","
 S LRFDA(5,LRFILE,LRIENS,.01)=LRNLT
 S LRFDA(5,LRFILE,LRIENS,2)=LRURG
 I LRORIFN S LRFDA(5,LRFILE,LRIENS,3)=LRORIFN
 I LRORNUM'="" S LRFDA(5,LRFILE,LRIENS,4)=LRORNUM
 I $P(LRORDTYP,"^",2) S LRFDA(5,LRFILE,LRIENS,5)=$P(LRORDTYP,"^",2)
 ;
 ; Check for regular or LEDI provider
 I LRPROV'="" D
 . I LRPROV?1.N S LRFDA(5,LRFILE,LRIENS,6)=LRPROV Q
 . I $E(LRPROV,1,4)="REF:" D  ; If LEDI find LEDI provider info on exisitng test.
 . . S X=0,LRX=""
 . . F  S X=$O(^LR(LRDFN,LRSS,LRIDT,"ORUT",X)) Q:X<1  D  Q:LRX'=""
 . . . S X(0)=$G(^LR(LRDFN,LRSS,LRIDT,X,0))
 . . . I $P(X(0),"^",7)'="" S LRX=$P(X(0),"^",7)
 . . I LRX'="" S LRPROV=LRX
 . S LRFDA(5,LRFILE,LRIENS,7)=LRPROV
 ;
 I LRSPEC S LRFDA(5,LRFILE,LRIENS,8)=LRSPEC
 I LRSAMP S LRFDA(5,LRFILE,LRIENS,9)=LRSAMP
 I LR60 S LRFDA(5,LRFILE,LRIENS,13)=LR60
 I $P(LRORDTYP,"^",3) D
 . S LRFDA(5,LRFILE,LRIENS,14)=$P(LRORDTYP,"^",3)
 . S LRFDA(5,LRFILE,LRIENS,15)=$P(LRORDTYP,"^",4)
 D UPDATE^DIE("","LRFDA(5)","LRIENS","")
 ;
 Q
