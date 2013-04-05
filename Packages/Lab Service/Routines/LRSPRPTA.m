LRSPRPTA ;DALOI/STAFF - CY/EM/SP PATIENT RPT (cont'd) ;11/14/11  13:00
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 ; Continuation of LRSPRPT.
 ;
EN ; from LRSPRPT
 ; Suppress SNOMED codes except on Preliminary
 S LR("SPSM")=$S($G(LRPRE):0,1:1)
 S LR(.21)=+$G(^LRO(69.2,+$G(LRAA),.2))
 K LRO Q:'$D(^LR(LRDFN,LRSS,LRI,0))
 S LRQ=0
 D ^LRUA
 ;
 D GETPCP^LRAPUTL(.LRPRAC,LRDFN,LRSS,LRI)
 ;
 D ^LRAPF Q:LR("Q")
 S LR("F")=1 W !,"Submitted by: ",LRW(5),?44,"Date obtained: ",LRTK
 D:LRA W^LRSPRPT
 W !,"Specimen (Received ",LRTK(1),"):" S LRV=.1 D A^LRSPRPT Q:LR("Q")
 I $P($G(^LR(LRDFN,LRSS,LRI,1.2,0)),"^",4) D
 . W !?14,"*+* SUPPLEMENTARY REPORT HAS BEEN ADDED *+*"
 . W !?19,"*+* REFER TO BOTTOM OF REPORT *+*",!
 ;
 I $O(^LR(LRDFN,LRSS,LRI,99,0)) W !,"Comment:"
 S LRB=0
 F  S LRB=$O(^LR(LRDFN,LRSS,LRI,99,LRB)) Q:'LRB!(LR("Q"))  D
 . W !,^LR(LRDFN,LRSS,LRI,99,LRB,0)
 . I $G(LRSF515),$Y>(IOSL-11) D F^LRAPF,^LRAPF
 ;
 D:LRA W^LRSPRPT W !,"Brief Clinical History:" S LRV=.2 D F^LRSPRPT Q:LR("Q")
 D:LRA W^LRSPRPT W !,"Preoperative Diagnosis:" S LRV=.3 D F^LRSPRPT Q:LR("Q")
 D:LRA W^LRSPRPT W !,"Operative Findings:" S LRV=.4 D F^LRSPRPT Q:LR("Q")
 D:LRA W^LRSPRPT W !,"Postoperative Diagnosis:" S LRV=.5 D F^LRSPRPT Q:LR("Q")
 ;
 ;
 ; Retrieve surgeon/attending
 D ATTEND^LRAPBR1(.LRMD)
 I LRMD'="" W !?27,"Surgeon/physician: ",LRMD
 I LRMD("SR-SURGEON")'="" w !,?28,LRMD("SR-SURGEON")
 I LRMD("SR-ATTEND")'="" W !,?26,LRMD("SR-ATTEND")
 ;I +$G(LRMD("ERR"))=601 W !,?26,$P(LRMD("ERR"),"^",2)
 ;
 I LRA W !,LR("%1")
 ;
 I $Y>(IOSL-14) D  Q:LR("Q")
 . D F^LRAPF,^LRAPF
 E  D P^LRAPF
 ;I $Y>(IOSL-8) D F^LRAPF,^LRAPF Q:LR("Q")
 D:LRA W^LRSPRPT
 W:LRRC="" !?20,"+*+* REPORT INCOMPLETE *+*+",!
 I $Y>(IOSL-11) D F^LRAPF,^LRAPF Q:LR("Q")
 ;
 W !
 I LRRMD'="" W ?31,$S(LRSS="SP":"Pathology Resident: ",LRSS="CY":"Screened by: ",LRSS="EM":"Prepared by: ",1:" "),LRRMD
 I $O(^LR(LRDFN,LRSS,LRI,1.3,0)) D  Q:LR("Q")
 . I $Y>(IOSL-11) D F^LRAPF,^LRAPF Q:LR("Q")
 . W !,LR(69.2,.13)
 . I $P($G(^LR(LRDFN,LRSS,LRI,6,0)),U,4) S LR(0)=6 D ^LRSPRPTM
 ;
 S LRV=1.3 D F^LRSPRPT Q:LR("Q")
 I $O(^LR(LRDFN,LRSS,LRI,1,0)) D  Q:LR("Q")
 . I $Y>(IOSL-11) D F^LRAPF,^LRAPF Q:LR("Q")
 . W !,LR(69.2,.03)
 . I $P($G(^LR(LRDFN,LRSS,LRI,7,0)),U,4) S LR(0)=7 D ^LRSPRPTM
 ;
 S LRV=1 D F^LRSPRPT Q:LR("Q")
 I $O(^LR(LRDFN,LRSS,LRI,1.1,0)) D  Q:LR("Q")
 . I $Y>(IOSL-11) D F^LRAPF,^LRAPF Q:LR("Q")
 . W !,LR(69.2,.04)
 . I $P($G(^LR(LRDFN,LRSS,LRI,4,0)),"^",4) S LR(0)=4 D ^LRSPRPTM
 ;
 S LRV=1.1 D F^LRSPRPT Q:LR("Q")
 I $O(^LR(LRDFN,LRSS,LRI,1.4,0)) D  Q:LR("Q")
 . I $Y>(IOSL-11) D F^LRAPF,^LRAPF Q:LR("Q")
 . W !,LR(69.2,.14)
 . I $P($G(^LR(LRDFN,LRSS,LRI,5,0)),U,4) S LR(0)=5 D ^LRSPRPTM
 ;
 S LRV=1.4 D F^LRSPRPT Q:LR("Q")
 ;
 ; Supplementary Report
 I $O(^LR(LRDFN,LRSS,LRI,1.2,0)) D:LR(.21) F^LRAPF,^LRAPF Q:LR("Q")  D
 . D:$Y>(IOSL-13) F^LRAPF,^LRAPF Q:LR("Q")
 . W !,"Supplementary Report:"
 . S LRV=0 F  S LRV=$O(^LR(LRDFN,LRSS,LRI,1.2,LRV)) Q:'LRV!(LR("Q"))  D
 . . S X=^LR(LRDFN,LRSS,LRI,1.2,LRV,0) D S^LRSPRPT
 D ^LRSPRPT1 Q:LR("Q")
 ;
 ; Print performing laboratory if designated
 D PPL
 ;
 ; Don't set the final flag and print the footer if prelim
 Q:+$G(LRPRE)
 S LRO=1 D F^LRAPF
 Q
 ;
 ;
PPL ; Print any performing laboratories
 ;
 N LRPL,LRJ,LRX
 ;
 D RETLST^LRRPL(.LRPL,LRDFN,LRSS,LRI,0)
 I $G(LRPL)<1 Q
 ;
 ; Start new page if space on existing page too small to display a significant portion of labs
 I $Y>(IOSL-15) D F^LRAPF,^LRAPF Q:LR("Q")
 ;
 W !!,$$REPEAT^XLFSTR("=",IOM)
 W !,"Performing Laboratory:",!
 S LRJ=0
 F  S LRJ=$O(LRPL(LRJ)) Q:'LRJ  D  Q:LR("Q")
 . I $Y>(IOSL-12) D F^LRAPF,^LRAPF Q:LR("Q")  W !,"Performing Laboratory (cont'd):",!
 . W !,LRPL(LRJ)
 ;
 Q
