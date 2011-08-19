GMTSRON ; SLC/JER,KER - Surgery Reports ; 06/24/2002 [7/27/04 9:00am]
 ;;2.7;Health Summary;**11,28,37,57**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA  3590  HS^SROGMTS
 ;   DBIA  2056  $$GET1^DIQ (file #130)
 ;                     
ENSR ; Entry point for component
 N REC,GMTSMX,GMCOUNT,GMIDT,GMJ,GMN,SURG,GMTSGL
 S GMTSGL=$$GL^GMTSROE Q:'$L(GMTSGL)  Q:'$D(@(GMTSGL_"""B"","_DFN_")"))
 S GMTSMX=999 I $D(GMTSNDM),(GMTSNDM>0) S GMTSMX=GMTSNDM
 S GMN=0 F  S GMN=$O(@(GMTSGL_"""B"","_DFN_","_GMN_")")) Q:GMN'>0  D SORT
 Q:'$D(SURG)  S (GMCOUNT,GMIDT)=0 F  S GMIDT=$O(SURG(GMIDT)) Q:GMIDT'>0!(GMCOUNT'<GMTSMX)  D
 . S GMN=SURG(GMIDT) K REC I $$CHK D WRT
 K REC
 Q
 ;                               
SORT ; Sort surgeries by inverted date
 N GMDT S GMDT=$P($G(@(GMTSGL_GMN_",0)")),U,9) I GMDT>GMTSBEG&(GMDT<GMTSEND) D
 . F  Q:'$D(SURG(9999999-GMDT))  S GMDT=GMDT+.0001
 . S SURG(9999999-GMDT)=GMN
 Q
 ;                               
WRT ; Write surgical case record
 S GMN=+($G(GMN))
 D:+($$PROK^GMTSU("SROGMTS",100))>0 HS^SROGMTS(GMN)
 D:+($$PROK^GMTSU("SROGMTS",100))'>0 ONE^GMTSROE(GMN)
 N X,Y,GMI,GMDT,GMTSTR
 ;-------------------------------------------------------
 Q:$G(REC(130,GMN,118,"I"))'="Y"  S GMCOUNT=GMCOUNT+1
NONOR ; NON-OR information
SP ;     Date/Specialty/Provider
 D CKP^GMTSUP Q:$D(GMTSQIT)
 S GMDT=$G(REC(130,GMN,.09,"S")) S:'$L(GMDT) GMDT=$$ED^GMTSU($G(REC(130,GMN,.09,"I")))
 S GMTSTR=$G(REC(130,GMN,125,"S")) S:$L($G(GMTSTR))>25 GMTSTR=$$WRAP^GMTSORC(GMTSTR,25)
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W GMDT,?21,$P($G(GMTSTR),"|"),?47,"Provider: ",?56,$G(REC(130,GMN,123,"E")),!
 F GMI=2:1:$L($G(GMTSTR),"|") D CKP^GMTSUP Q:$D(GMTSQIT)  W ?23,$P($G(GMTSTR),"|",GMI),!
 ;
SA ;     Status/Attending
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W ?13,"Status:",?21,$G(REC(130,GMN,"STATUS"))
 W ?46,"Attending: ",?56,$G(REC(130,GMN,124,"E")),!
PA ;     Principal Anesthetist
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W ?45,"Prin Anest: ",?56,$G(REC(130,GMN,.31,"E")),!
PD ;     Principle Diagnosis
 S GMTSTR=$G(REC(130,GMN,33,"S")) S:'$L(GMTSTR) GMTSTR=$G(REC(130,GMN,33,"E"))
 S:$L($G(GMTSTR))>39 GMTSTR=$$WRAP^GMTSORC(GMTSTR,39)
 D CKP^GMTSUP Q:$D(GMTSQIT)  W ?9,"Princ Diag: ",$P($G(GMTSTR),"|"),!
 F GMI=2:1:$L($G(GMTSTR),"|") D CKP^GMTSUP Q:$D(GMTSQIT)  W ?21,$P($G(GMTSTR),"|",GMI),!
PP ;     Principal Procedure
 D CKP^GMTSUP Q:$D(GMTSQIT)  W ?5,"Proc Performed: "
 S GMTSTR=$G(REC(130,GMN,26,"S"))
 S:GMTSTR="" GMTSTR=$G(REC(130,GMN,26,"E"))
 S:$L(GMTSTR)>58 GMTSTR=$$WRAP^GMTSORC(GMTSTR,58)
 F GMJ=1:1:$L(GMTSTR,"|") D  Q:$D(GMTSQIT)
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W ?$S(GMJ=1:21,1:22),$P(GMTSTR,"|",GMJ),!
 Q:$D(GMTSQIT)
PPM ;     Principal Procedure (Modifiers)
 S GMI=0 F  S GMI=$O(REC(130,GMN,130.028,GMI)) Q:GMI'>0  D  Q:$D(GMTSQIT)
 . S GMTSTR=$G(REC(130,GMN,130.028,GMI,.01,"S")) S:GMTSTR="" GMTSTR=$G(REC(130,GMN,130.028,GMI,.01,"E")) S:$L(GMTSTR)>54 GMTSTR=$$WRAP^GMTSORC(GMTSTR,54)
 . F GMJ=1:1:$L(GMTSTR,"|") D  Q:$D(GMTSQIT)
 . . D CKP^GMTSUP Q:$D(GMTSQIT)  W ?$S(GMJ=1:25,1:26),$P(GMTSTR,"|",GMJ),!
 Q:$D(GMTSQIT)
OPP ;     Other Procedure Performed
 S GMI=0 F  S GMI=$O(REC(130,GMN,130.16,GMI)) Q:GMI'>0  D
 . S GMTSTR=$G(REC(130,GMN,130.16,GMI,.01,"S")) S:GMTSTR="" GMTSTR=$G(REC(130,GMN,130.16,GMI,.01,"E")) S:$L(GMTSTR)>58 GMTSTR=$$WRAP^GMTSORC(GMTSTR,58)
 . F GMJ=1:1:$L(GMTSTR,"|") D  Q:$D(GMTSQIT)
 . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . . W ?$S(GMJ=1:21,1:22),$P(GMTSTR,"|",GMJ),!
OPPM . ;       Other Procedure Performed (Modifiers)
 . N GMM S GMM=0
 . F  S GMM=$O(REC(130,GMN,130.16,GMI,130.164,GMM)) Q:+GMM=0  D
 . . S GMTSTR=$G(REC(130,GMN,130.16,GMI,130.164,GMM,.01,"S")) S:'$L(GMTSTR) GMTSTR=$G(REC(130,GMN,130.16,GMI,130.164,GMM,.01,"E")) S:$L(GMTSTR)>54 GMTSTR=$$WRAP^GMTSORC(GMTSTR,54)
 . . F GMJ=1:1:$L(GMTSTR,"|") D  Q:$D(GMTSQIT)
 . . . D CKP^GMTSUP Q:$D(GMTSQIT)  W ?$S(GMJ=1:25,1:26),$P(GMTSTR,"|",GMJ),!
 . Q:$D(GMTSQIT)
 Q:$D(GMTSQIT)
IND ;     Indications for Surgery
 I $G(REC(130,GMN,55,"S",0))>0 D  Q:$D(GMTSQIT)
 . N GMI,GMC S (GMI,GMC)=0 F  S GMI=$O(REC(130,GMN,55,"S",GMI)) Q:+GMI=0  D  Q:$D(GMTSQIT)
 . . S GMC=+GMC+1 D CKP^GMTSUP Q:$D(GMTSQIT)  W:GMC=1 "Indication for Proc:" W ?21,$G(REC(130,GMN,55,"S",GMI)),!
FIND ;     Findings
 I $G(REC(130,GMN,59,"S",0))>0 D  Q:$D(GMTSQIT)
 . N GMI,GMC S (GMI,GMC)=0 F  S GMI=$O(REC(130,GMN,59,"S",GMI)) Q:+GMI=0  D  Q:$D(GMTSQIT)
 . . S GMC=+GMC+1 D CKP^GMTSUP Q:$D(GMTSQIT)  W:GMC=1 " Operative Findings:" W ?21,$G(REC(130,GMN,59,"S",GMI)),!
DICT ;     Dictation
 I $O(REC(130,GMN,1.15,0))>0 D
 . N GMI D CKP^GMTSUP Q:$D(GMTSQIT)  W "Surgeon's Dictation:",!
 . S GMI=0 F  S GMI=$O(REC(130,GMN,1.15,GMI)) Q:+GMI=0  D  Q:$D(GMTSQIT)
 . . D CKP^GMTSUP Q:$D(GMTSQIT)  W ?2,$G(REC(130,GMN,1.15,GMI)),!
 Q
 ;--------------------------------------------------------------------
CHK() ; For selected procedures see if you have a match
 N GMTSI,GMTSF,GMTSC
 S GMTSC=$$GET1^DIQ(130,+($G(GMN)),27,"I") Q:'$D(GMTSEG(GMTSEGN,81)) 1
 S GMTSF=0 F GMTSI=0:0 S GMTSI=$O(GMTSEG(GMTSEGN,81,GMTSI)) Q:'+GMTSI!GMTSF  S:GMTSEG(GMTSEGN,81,GMTSI)=GMTSC GMTSF=1 Q:GMTSF
 Q GMTSF
