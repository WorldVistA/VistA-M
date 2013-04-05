LRMIPSU ;DALOI/RBN - MICRO PATIENT REPORT ;05/09/12  17:03
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 Q
 ;
 ;
HDR ;
 ; Handle different callers
 N X
 I $D(LRPGDATA) D  Q  ;
 . S X=$G(LRPGDATA("HDR"))
 . I X'="" X X
 D HDR1
 Q
 ;
 ;
FOOT ;
 ; Handle different callers
 N X
 I $D(LRPGDATA) D  Q  ;
 . S X=$G(LRPGDATA("FTR"))
 . I X'="" X X
 D FOOT1
 Q
 ;
 ;
FH ;
 ; from LRMIPSZ1, LRMIPSZ2, LRMIPSZ5. Also called from LROR4
 ; Handle different callers
 I $D(LRPGDATA) D  Q  ;
 . D NP
 . I LRABORT S LREND=1
 D:$Y>(IOSL-LRFLIP) FOOT,HDR
 Q
 ;
 ;
FHR ; from LRMIPSZ1, LRMIPSZ2
 D:$Y>(IOSL-LRFLIP) FOOT,HDR Q:LREND  D REFS
 Q
 ;
 ;
REFS ; from LRMIPSZ1
 S B=1,LREF=0
 F  S LREF=$O(LRBUG(LREF)) Q:LREF=""  S LRIFN=LRBUG(LREF) D LIST Q:LREND
 K LRBUG
 Q
 ;
 ;
LIST ;
 Q:'$D(^LAB(61.2,LRIFN,"JR",0))
 S LRNUM=0
 F  S LRNUM=$O(^LAB(61.2,LRIFN,"JR",LRNUM)) Q:LRNUM=""  D WR Q:LREND
 Q
 ;
WR ;
 ; Handle different callers
 I $D(LRPGDATA) D  Q  ;
 . D WR2
 D WR1
 Q
 ;
 ;
WR1 ;
 ;
 S X1=^LAB(61.2,LRIFN,"JR",LRNUM,0) Q:$P(X1,U,7)'=1
 D:$Y>(IOSL-LRFLIP-2) FOOT,HDR Q:LREND
 W:B=1 !!,"Reference(s): " S B=0
 W !!,$J(LREF,2),". ",$P(X1,U,2),!,$P(X1,U)
 W ! W:$L($P(X1,U,3)) $P(^LAB(95,$P(X1,U,3),0),U)," ",$P(X1,U,4),":"
 W $P(X1,U,5) W:$L($P(X1,U,6)) ",",$E($P(X1,U,6),1,3)+1700
 Q
 ;
 ;
WR2 ;
 ;
 S X1=^LAB(61.2,LRIFN,"JR",LRNUM,0) Q:$P(X1,U,7)'=1
 D NP Q:LRABORT
 I B=1 W !!,"Reference(s): "
 D NP Q:LRABORT
 S B=0
 W !!,$J(LREF,2),". ",$P(X1,U,2)
 D NP Q:LRABORT
 W !,$P(X1,U)
 D NP Q:LRABORT
 W !
 D NP Q:LRABORT
 I $P(X1,U,3)'="" W $P(^LAB(95,$P(X1,U,3),0),U)," ",$P(X1,U,4),":"
 W $P(X1,U,5)
 W:$L($P(X1,U,6)) ",",$E($P(X1,U,6),1,3)+1700
 D NP Q:LRABORT
 Q
 ;
 ;
FOOT1 ;
 ; Backward compatibility for pre NP^LRUTIL displays
 ; from LRMIPSZ1
 N LRX
 F  W ! Q:$Y>(IOSL-LRFLIP)
 Q:'LRHC
 W !,"Collection sample: ",LRCS,?40,"Collection date: ",LRTK
 W:LRCS'=LRST !,"Site/Specimen: ",LRST W !!
 W !!,PNM,?$X+3,SSN,?$X+3 W:$D(IA) IA W ?60,"  ROUTING: ",LRPATLOC,!
 S LRX=+$G(^LR(LRDFN,LRSS,LRIDT,"RF"))
 I LRX>0 W $$NAME^XUAF4(LRX)
 I LRX<1 W $$INS^LRU
 W " LABORATORY ",?62,LRACC,!,"MICROBIOLOGY",?62,"page ",LRPG,!
 Q
 ;
 ;
FOOT2 ;
 ; for use with NP^LRUTIL displays
 ; from LRMIPSZ1
 N LRX
 I '$D(LRSS) N LRSS S LRSS="MI"
 S LRX="=--"
 W !,$$REPEAT^XLFSTR(LRX,IOM/$L(LRX))
 W !,"Collection sample: ",LRCS,?40,"Collection date: ",LRTK
 W:LRCS'=LRST !,"Site/Specimen: ",LRST
 W !
 S LRX=$$PNMSSN(PNM,SSN)
 W !,LRX
 W:$G(IA)'="" IA
 W ?60,"  ROUTING: ",LRPATLOC
 W !
 S LRX=+$G(^LR(LRDFN,LRSS,LRIDT,"RF"))
 I LRX>0 W $$NAME^XUAF4(LRX)
 I LRX<1 W $$INS^LRU
 W " LABORATORY ",?62,LRACC
 W !,"MICROBIOLOGY",?62,"page ",LRPG
 W !
 Q
 ;
 ;
HDR1 ;
 ; Backward compatible for pre NP^LRUTIL displays
 ; from LRMIPSZ1
 N LRX,X
 S LRPG=LRPG+1 D:LRPG>1 WAIT Q:LREND
 ;
 W:($G(LRJ02))!($G(LRJ0))!($E(IOST,1,2)="C-") @IOF S LRJ02=1
 W !,PNM,?20," ",SSN,?35," AGE: ",AGE W:LRWRD'="" ?45," LOC: ",$E(LRWRD,1,(IOM-70))," "
 ;
 S X=$$HTE^XLFDT($H,"1M")
 W ?IOM-($L(X)+1),X
 ;
 I LRPG=1 W !?27,"----MICROBIOLOGY----",?70
 I '$D(LRH),LRHC W !?32,$S($D(^XUSEC("LRLAB",DUZ))&'$D(LRWRDVEW):"LAB",1:"CHART")," COPY"
 W !
 S LRSS="MI"
 ;
 ; Display printing facility
 I $$GET^XPAR("DIV^PKG","LR REPORTS FACILITY PRINT",1,"Q")>1 D PFAC^LRRP1(DUZ(2),$G(LRPG))
 ;
 ; Display reporting lab
 I $$GET^XPAR("DIV^PKG","LR REPORTS FACILITY PRINT",1,"Q")#2 D
 . S LRX=+$G(^LR(LRDFN,LRSS,LRIDT,"RF"))
 . I LRX D RL^LRRP1(LRX) W !
 ;
 ; LR*5.2*216 Modification - RBN
 ;  Add banner to audit reports
 ;
 I $D(^LR(LRDFN,"MI",LRIDT,LRSB)),(LRPG=1) D:LRPG=1 BANNER^LRMIAU2()
 N LRBANIEN,LRBANFLG
 S LRBANFLG=0
 F LRBANIEN=1,5,8,11,16 I $D(^LR(LRDFN,"MI",LRIDT,LRBANIEN)) S LRBANFLG=1 Q
 I LRPG=1 D
 . D ORU^LRRP1
 . S LRX=^LR(LRDFN,"MI",LRIDT,0)
 . I $P(LRX,"^",3) W !,"Report Completed: ",$$FMTE^XLFDT($P(LRX,"^",3),"M")
 ;
 I LRPG>1 W !?20,">> CONTINUATION OF ",LRACC," <<"
 W !!,"Collection sample: ",LRCS,?40,"Collection date: ",LRTK
 ;
 I LRPG=1 D
 . I LRDOC?1"REF:"1.AN D
 . . N LRX
 . . S LRX=$$REFDOC^LRRP1(LRDFN,LRSS,LRIDT)
 . . I LRX'="" S LRDOC=LRX
 . W !,"Provider: ",LRDOC
 . W !
 . I LRCMNT'="" W "Comment on specimen: ",LRCMNT,!
 Q
 ;
 ;
HDR2(LRPRNTED,LRABORT,LRPGDATA) ;
 ;
 ; Called from NP^LRUTIL via the LRPGDATA array setup in RPT^LRMIPSZ1
 ; Inputs
 ;  LRPRNTED: <byref> Tracks when certain sections are printed
 ;   LRABORT: <byref> Tracks if user entered "^" to stop
 ;  LRPGDATA: <byref> Used by NP^LRUTIL
 ; Outputs
 ;  LRPRNTED: "PFAC" -- Printing Facility address
 ;          :   "RF" -- Reporting Facility address
 ;          :  "ORU" -- Remote ordering info
 ;   LRABORT: 1 if user aborts, 0 if not (set by NP^LRUTIL)
 ;
 N I,ISCONS,LRX,LRY,X,WPGNM
 S LRABORT=$G(LRABORT)
 S LRPG=$G(LRPGDATA("PGNUM"))
 S:LRPG<1 LRPG=1
 S WPGNM=0 ; Page Number written?
 S ISCONS=0
 I '$D(LRSS) N LRSS S LRSS="MI"
 I $E($G(IOST),1,2)="C-" S ISCONS=1 ;is console device
 ;
 I LRPG=1,ISCONS,$G(IOF)'="" W @IOF
 S LRX=$$PNMSSN(PNM,SSN)
 W !,LRX,?39," AGE: ",AGE
 I LRWRD'="",LRWRD'=0 W ?47," LOC: ",$E(LRWRD,1,(IOM-70))," "
 ;
 S X=$$HTE^XLFDT($H,"1M")
 W ?IOM-($L(X)+1),X
 ;
 I LRPG=1 D
 . W !?27,"----MICROBIOLOGY----"
 . I 'WPGNM W ?IOM-5-4,"page ",LRPG S WPGNM=1
 ;
 I '$D(LRH),'ISCONS W !?32,$S($D(^XUSEC("LRLAB",DUZ))&'$D(LRWRDVEW):"LAB",1:"CHART")," COPY"
 ;
 ; Display printing facility
 I $$GET^XPAR("DIV^PKG","LR REPORTS FACILITY PRINT",1,"Q")>1,'$D(LRPRNTED("PFAC")) D
 . S LRPRNTED("PFAC")=1
 . K LRX
 . D PFAC^LRRP1(DUZ(2),,1,.LRX)
 . Q:'$D(LRX)
 . S I=0
 . F  S I=$O(LRX(I)) Q:'I  W !,LRX(I)
 ;
 ; Display reporting lab
 I $$GET^XPAR("DIV^PKG","LR REPORTS FACILITY PRINT",1,"Q")#2,'$D(LRPRNTED("RF")) D
 . S LRPRNTED("RF")=1
 . S LRX=+$G(^LR(LRDFN,"MI",LRIDT,"RF"))
 . W !
 . Q:'LRX
 . K LRY
 . D RL^LRRP1(LRX,1,.LRY)
 . Q:'$D(LRY)
 . S I=0
 . F  S I=$O(LRY(I)) Q:'I  W !,LRY(I)
 . W !
 ;
 I '$D(LRPRNTED("ORU")) D
 . S LRPRNTED("ORU")=1
 . D ORU^LRRP1
 . S LRX=^LR(LRDFN,"MI",LRIDT,0)
 . I $P(LRX,"^",3) W !,"Report Completed: ",$$FMTE^XLFDT($P(LRX,"^",3),"M")
 ;
 I LRPG>1 D
 . W !?20,">> CONTINUATION OF ",LRACC," <<"
 . I 'WPGNM W ?IOM-5-4,"page ",LRPG S WPGNM=1
 ;
 W !,"Collection sample: ",LRCS,?40,"Collection date: ",LRTK
 ;
 I '$D(LRPRNTED("REF")) D
 . N LRX,LRDOCZ
 . S LRPRNTED("REF")=1
 . I LRDOC?1"REF:"1.AN D
 . . S LRX=$$REFDOC^LRRP1(LRDFN,LRSS,LRIDT)
 . . I LRX'="" S LRDOCZ=LRX
 . W !,"Provider: ",$S($D(LRDOCZ):LRDOCZ,1:LRDOC)
 . I LRCMNT'="" W !,"Comment on specimen: ",LRCMNT
 ;
 S LRX="=--"
 W !,$$REPEAT^XLFSTR(LRX,IOM/$L(LRX)),!
 ;
 Q
 ;
 ;
WAIT ;
 ; from LRMIPSZ1, LRMIPSZ2
 F I=$Y:1:IOSL-3 W !
 I 'LRHC W !,PNM,?25,"  ",SSN,"   ROUTING: ",LRPATLOC,?59," PRESS '^' TO STOP " R X:DTIME S:X="" X=1 S:(".^"[X)!('$T) LREND=1
 Q
 ;
 ;
PRE ;
 ; from LRMIPSZ2, LRMIPSZ3, LRMIPSZ4
 ; also indirectly from RPT^LROR4
 N J
 I LRTUS'["F"!($D(^XUSEC("LRLAB",DUZ))&'$D(LRWRDVEW)) D  ;
 . W:+$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,LRPRE,0)) !,"Preliminary Comments: "
 . D NP Q:LRABORT
 . S J=0
 . F  S J=$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,LRPRE,J)) Q:J<1  W !?3,^(J,0) D NP Q:LRABORT
 ;
 D NP Q:LRABORT
 W !
 D NP Q:LRABORT
 Q
 ;
 ;
PROMPT() ;
 ; Creates the "more" prompt for display
 ; Expects PNM,SSN,LRPATLOC
 ; Outputs
 ;   The prompt for display
 N X,PNMX,PLOCX,STR
 S STR=$$PNMSSN(PNM,SSN)
 S PLOCX=$G(LRPATLOC)
 S:$L(PLOCX)>14 PLOCX=$E(PLOCX,1,11)_"..."
 I PLOCX'="" S STR=STR_"   ROUTING: "_PLOCX
 S X="'^' TO STOP"
 S $E(STR,IOM-$L(X),IOM)=X
 Q STR
 ;
 ;
PNMSSN(PNM,SSN) ;
 ; Creates the Patient Name/SSN banner
 ; Inputs
 ;   PNM : Patient's Name
 ;   SSN : SSN
 ; Outputs
 ;   The formatted string for the patient name and SSN
 N X,PNMX,STR
 S PNM=$G(PNM)
 S SSN=$G(SSN)
 S PNMX=PNM
 S:$L(PNMX)>25 PNMX=$E(PNMX,1,22)_"..."
 S STR=PNMX
 S $E(STR,27,27)=" "
 S STR=STR_SSN
 Q STR
 ;
 ;
NP ;
 ; Convenience method
 D NP^LRMIPSZ1
 Q
