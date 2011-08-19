VADPT6 ;ALB/MJK - PATIENT ID VARIABLES ; 12 AUG 89 @1200
 ;;5.3;Registration;;Aug 13, 1993
 ;
PID ;
13 ; -- Returns the patient id variables for DFN patient
 ;    usually VA("PID")=123-45-6789 and VA("BID")="6789"
 ;    for VA patients.
 ;
 ; -- Returns patient id variables as defined for the requested
 ;    patient eligibility for DFN patient.  The variable VAPTYP should
 ;    contain the internal number of the desired patient eligibility.
 ;
 ;    If the VAPTYP eligibility  does not exist, then the standard
 ;    values, as defined above, will be passed back.
 ;
 N X,L,B K VAERR S (L,B)=""
 ; L = long id ; B = brief or short id
 S VAERR=$S('$D(DFN)#2:1,'$D(^DPT(+DFN,0)):1,1:0) I VAERR G PIDQ
 I $D(VAPTYP),$D(^DPT(DFN,"E",+VAPTYP,0)) S X=^(0),L=$P(X,"^",3),B=$P(X,"^",4)
 ; -- set default id's
 I L="",$D(^DPT(DFN,.36)) S X=^(.36) I +X S L=$P(X,"^",3),B=$P(X,"^",4)
 I L="" S X=$P(^DPT(DFN,0),"^",9) I X]"" S L=$E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,10),B=$E(X,6,10)
 ;
PIDQ S VA("PID")=L,VA("BID")=B Q
 ;
SET ;-- execute id format specific long id, short id and x-ref set logic
 ;   input: VADFN == DFN
 ;
 Q:'$D(^DPT(VADFN,"E",0))
 N X,DA S DA(1)=VADFN
 F DA=0:0 S DA=$O(^DPT(DA(1),"E",DA)) Q:'DA  I $D(^(DA,0)) D SET1
 K X,DA
 Q
SET1 ;
 D CHK G SET1Q:'VAFMT
 ; -- calc/store long id
 S X=""
 I $D(^DIC(8.2,VAFMT,"LONG")) X ^("LONG") S $P(^DPT(DA(1),"E",DA,0),U,3)=X
 ; -- long id x-refs (set logic)
 S VAX=X G SET1Q:X=""
 F VAIX=0:0 S VAIX=$O(^DD(2.0361,.03,1,VAIX)) Q:'VAIX  X ^(VAIX,1) S X=VAX
 ; -- short id x-refs (set logic)
 S (VAX,X)=$P(^DPT(DA(1),"E",DA,0),U,4) G SET1Q:X=""
 F VAIX=0:0 S VAIX=$O(^DD(2.0361,.04,1,VAIX)) Q:'VAIX  X ^(VAIX,1) S X=VAX
SET1Q K VAIX,VAX,X,VAFMT
 Q
 ;
KILL ; -- execute id format specific x-ref kill logic
 ;    input: VADFN ==> DFN
 ;
 Q:'$D(^DPT(VADFN,"E",0))
 N X,DA S DA(1)=VADFN
 F DA=0:0 S DA=$O(^DPT(DA(1),"E",DA)) Q:'DA  I $D(^(DA,0)) D KILL1
 K X,DA
 Q
 ;
KILL1 ;
 D CHK G KILL1Q:'VAFMT
 ; -- short id x-ref (kill logic)
 S (VAX,X)=$P(^DPT(DA(1),"E",DA,0),U,4) G KILL2:X=""
 F VAIX=0:0 S VAIX=$O(^DD(2.0361,.04,1,VAIX)) Q:'VAIX  X ^(VAIX,2) S X=VAX
 S $P(^DPT(DA(1),"E",DA,0),U,4)=""
KILL2 ; -- long id (kill logic)
 S (VAX,X)=$P(^DPT(DA(1),"E",DA,0),U,3) G KILL1Q:X=""
 F VAIX=0:0 S VAIX=$O(^DD(2.0361,.03,1,VAIX)) Q:'VAIX  X ^(VAIX,2) S X=VAX
 S $P(^DPT(DA(1),"E",DA,0),U,3)=""
KILL1Q K VAX,VAIX,VAFMT
 Q
 ;
CHK ; -- ok to proceed ; fmt defined
 S VAFMT=0
 I $D(^DIC(8,DA,0)) S VAFMT=+$P(^(0),U,10),VAFMT=$S($D(^DIC(8.2,VAFMT,0)):VAFMT,1:0)
 Q
