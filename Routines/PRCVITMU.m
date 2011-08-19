PRCVITMU ;WOIFO/GJW - Item utilities ; 4/20/05 5:20pm
 ;;5.1;IFCAP;**81**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
TRANS ;Called by the input transform on 441/.01
 N PRCVX,PRCVFLG
 S PRCVFLG=0
 Q:'$D(X)
 S X=$TR(X,"new","NEW") ;other letters are irrelevant
 D:X="NEW"
 .S PRCVFLG=1
 .D NEW
 Q:'$D(X)
 I +X'=X K X Q
 I X?.E1"."1N.N K X Q
 I X<$S(PRCVFLG:$$MIN,1:$$AMIN) K X Q
 Q
 ;
CHK() ;
 Q $$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")
 ;
MIN() ;
 Q $S($$CHK:150000,1:1)
 ;
AMIN() ;
 Q $S($$CHK:100000,1:1)
NEW ;
 N MIN
 S MIN=150000 ;starting value for allocating item #'s at DM sites
 I '$$CHK D
 .;call appropriate routine
 .D EN2^PRCHUTL
 E  D
 .S PRCVX=$O(^PRC(441,"AFREE",MIN-1))
 .S PRCVX(1)=$O(^PRC(441,"AFREE",PRCVX),-1)
 .S PRCVX(2)=$O(^PRC(441,"AFREE",PRCVX(1)))
 .S X=$S(PRCVX(1)'<MIN:PRCVX(1),1:PRCVX(2))
 Q
 ;
SET ;
 N ROOT,FIRST,SECOND
 S ROOT=$NA(^PRC(441,"AFREE"))
 S:'$D(@ROOT) @ROOT@(1,999999)=""
 S FIRST=$$FIND(X)
 I FIRST="" D  Q
 .;Do we need anything here?
 S SECOND=$O(@ROOT@(FIRST,""))
 ;Remove X from free list
 K @ROOT@(FIRST,SECOND)
 I SECOND>FIRST D
 .S:FIRST=X @ROOT@(FIRST+1,SECOND)=""
 .S:SECOND=X @ROOT@(FIRST,SECOND-1)=""
 .I ((FIRST'=X)&(SECOND'=X)) D
 ..S @ROOT@(FIRST,X-1)=""
 ..S @ROOT@(X+1,SECOND)=""
 Q
 ;
KILL ;
 N ROOT,FIRST,SECOND,LOWER,UPPER
 S ROOT=$NA(^PRC(441,"AFREE"))
 S:'$D(@ROOT) @ROOT@(1,999999)=""
 S FIRST=$$FIND(X)
 I FIRST'="" D
 .;return it to free list
 .S SECOND=$O(@ROOT@(FIRST,""))
 .I ((X<FIRST)!(X>SECOND)) D
 ..;Error
 E  D
 .S @ROOT@(X,X)=""
 .;Can lists be merged?
 .;Could X+1 be a lower limit?
 .I $D(@ROOT@(X+1)) D
 ..S UPPER=$O(@ROOT@(X+1,""))
 ..S LOWER=X+1
 ..I UPPER'="" D
 ...K @ROOT@(X)
 ...K @ROOT@(LOWER)
 ...S @ROOT@(X,UPPER)=""
 .;Could X-1 be an upper limit?
 .S LOWER=$$FIND(X-1)
 .I LOWER'="" D
 ..S UPPER=$O(@ROOT@(LOWER,""))
 ..I $G(UPPER)=(X-1) D
 ...K @ROOT@(X)
 ...K @ROOT@(LOWER)
 ...S @ROOT@(LOWER,X)=""
 Q
 ;
FIND(I) ;
 N ROOT,X,Y
 S ROOT=$NA(^PRC(441,"AFREE"))
 Q:$D(@ROOT@(I)) I
 S X=$O(@ROOT@(I),-1)
 S:X="" X=$O(@ROOT@(""))
 Q:X="" ""
 S Y=$O(@ROOT@(X,""))
 I Y<I D
 .;W !,"NOT FOUND!"
 .S X=""
 Q X
