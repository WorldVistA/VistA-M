LA7VPFL ;DALOI/PDL - Lab Mapping Data Verification ;03/07/12  16:04
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
 Q
 ;
START ;
 N LABORT
 S LABORT=0
 F  D MAIN(.LABORT) Q:LABORT
 Q
 ;
MAIN(LABORT) ;
 ; Prompts for subscript and type of report then queues or displays.
 ; Inputs
 ;  LABORT: <byref>  See Outputs
 ; Outputs
 ;  LABORT: User wants to abort (1=abort)
 ;
 N RTN,RPT,SS,DIR,DIRUT,TASK,X,Y,POP
 S DIR(0)="SO^MI:Microbiology;SP:Surgical Pathology;CY:Cytopathology"
 S DIR("A")="Enter Lab Area Subscript"
 D ^DIR
 I $D(DIRUT) S LABORT=1 Q
 S SS=Y
 K DIR
 S DIR(0)="SO^C:Correctly Mapped Tests;E:Tests with Errors"
 D ^DIR
 I $D(DIRUT) S LABORT=1 Q
 S RPT=0
 I Y="E" S RPT=1
 I Y="C" S RPT=2
 S RTN="SHOW^LA7VPFL("""_SS_""","_RPT_")"
 S TASK=$$QUE^LRUTIL(RTN,"Check Lab Test NLT /Code Mapping")
 I TASK Q
 D SHOW(SS,RPT,.LABORT)
 D HOME^%ZIS
 Q
 ;
SHOW(SS,RPT,LABORT) ;
 ; Branches to the appropriate report subroutine.
 ; Inputs
 ;      SS: LR subscript (MI,SP,CY)
 ;     RPT: Which report 1=errors  2=correct
 ;  LABORT: <byref> See Outputs
 ; Outputs
 ;  LABORT: User wants to abort   1=abort
 ;
 S SS=$G(SS)
 S RPT=$G(RPT)
 S LABORT=$G(LABORT)
 U IO
 I "^1^2^"[("^"_RPT_"^") D  ;
 . I RPT=1 D RPT1(SS,.LABORT)
 . I RPT=2 D RPT2(SS,.LABORT)
 . I $D(ZTQUEUED) S ZTREQ="@"
 D ^%ZISC
 Q
 ;
RPT1(LASS,LABORT) ;
 ; "Mapping Error" report
 ; Inputs
 ;    LASS: Subscript (ie "MI","SP","CY")
 ;  LABORT: <byref>  See Outputs
 ; Outputs
 ;  LABORT:  User wants to abort (1=abort)
 ;
 N LAPGDATA,LAPGNUM,LADATA,LANOW,LAMSG,DATA,NODE,DIERR,X,Y
 N D64061,FILE,FIELD,LEC,PROC,R60,R64,R64061,SECT,TEST,WTEST,WKLD
 S LASS=$G(LASS)
 S LABORT=$G(LABORT)
 S LANOW=$$NOW^XLFDT()
 S LAPGDATA("HDR")="D HDR1^LA7VPFL"
 D HDR1
 S NODE="^LAB(60,""B"")"
 F  S NODE=$Q(@NODE) Q:NODE=""  Q:$QS(NODE,2)'="B"  D  Q:LABORT  ;
 . Q:@NODE=1
 . S WTEST=0 ;Test name was written
 . S R60=$QS(NODE,4)
 . S TEST=$QS(NODE,3)
 . S DATA=$G(^LAB(60,R60,0))
 . S X=$P(DATA,U,4)
 . Q:X'=LASS
 . S DATA=$G(^LAB(60,R60,64))
 . S R64=$P(DATA,U,1)
 . I 'R64 D  Q  ; No 64 pointer
 . . S WTEST=1
 . . D NP Q:LABORT
 . . W !,"[",R60,"] ",TEST
 . . W ?35,"  Not Mapped to File #64"
 . ;
 . S DATA=$G(^LAM(R64,0))
 . S PROC=$P(DATA,U,1)
 . S WKLD=$P(DATA,U,2)
 . I WKLD="" D  ;
 . . I 'WTEST D NP Q:LABORT  W !,"[",R60,"] ",TEST S WTEST=1
 . . D NP Q:LABORT  W !,?35,"  No Workload Code"
 . ;
 . I WKLD'="" Q:WKLD<2
 . S DATA=$G(^LAM(R64,63))
 . S R64061=$P(DATA,U,1)
 . I 'R64061 D  ;
 . . I 'WTEST D NP Q:LABORT  W !,"[",R60,"] ",TEST S WTEST=1
 . . D NP Q:LABORT
 . . W !,?15,"is mapped to: ",PROC," [",WKLD,"]"
 . . D NP Q:LABORT
 . . W !,?37,"Not Linked to File #64.061"
 . ;
 ;
 W !,$$CJ^XLFSTR("<  <  <  End of report  >  >  >",IOM),!
 Q
 ;
RPT2(LASS,LABORT) ;
 ; "Mapping Okay" report
 ; Inputs
 ;    LASS: Subscript (ie "MI","SP","CY")
 ;  LABORT: <byref>  See Outputs
 ; Outputs
 ;  LABORT:  User wants to abort (1=abort)
 ;
 N LAPGDATA,LAPGNUM,LADATA,LANOW,LAMSG,DATA,NODE,DIERR,X,Y
 N D64061,FILE,FIELD,LEC,SECT,R60,R64,R64061,TEST,WKLD
 S LASS=$G(LASS)
 S LABORT=$G(LABORT)
 S LANOW=$$NOW^XLFDT()
 S LAPGDATA("HDR")="D HDR2^LA7VPFL"
 D HDR2
 S NODE="^LAB(60,""B"")"
 F  S NODE=$Q(@NODE) Q:NODE=""  Q:$QS(NODE,2)'="B"  D  Q:LABORT  ;
 . Q:@NODE=1
 . S R60=$QS(NODE,4)
 . S TEST=$QS(NODE,3)
 . S DATA=$G(^LAB(60,R60,0))
 . S X=$P(DATA,U,4)
 . Q:X'=LASS
 . S DATA=$G(^LAB(60,R60,64))
 . S R64=$P(DATA,U,1)
 . Q:'R64
 . S DATA=$G(^LAM(R64,0))
 . S WKLD=$P(DATA,U,2)
 . Q:WKLD=""
 . Q:WKLD<2
 . S DATA=$G(^LAM(R64,63))
 . S R64061=$P(DATA,U,1)
 . Q:'R64061
 . S DATA=$G(^LAB(64.061,R64061,0))
 . S LEC=$P(DATA,U,1) ;#62.041 NAME
 . D GETS^DIQ(64.061,R64061_",","63.1;63.2;63.3","IE","LADATA","LRMSG")
 . M D64061=LADATA(64.061,R64061_",")
 . K LADATA
 . S X=$G(^LAM(R64,0))
 . S X=$P(X,U,1)
 . W !,"[",R60,"] ",TEST
 . D NP Q:LABORT
 . W !,?3,"Mapped to: ",X," [",WKLD,"]"
 . D NP Q:LABORT
 . W !,?5,"Linked to: ",LEC," [",R64061,"]"
 . D NP Q:LABORT
 . S FILE=D64061(63.1,"E")
 . S FIELD=D64061(63.2,"E")
 . S:'FIELD FIELD=.01
 . S SECT=$S(FILE=63.05:5,FILE=63.08:8,FILE=63.09:9,1:"")
 . K LADATA,LAMSG,DIERR
 . I SECT D
 . . D FIELD^DID(63,SECT,"","LABEL","LADATA","LAMSG")
 . . I '$D(LAMSG) S SECT=LADATA("LABEL")
 . I SECT="" S SECT="<??"_FILE_"??>"
 . ;
 . K LADATA,LRMSG,DIERR
 . S X=$P(FIELD,";",2)
 . S FIELD=$P(FIELD,";",1)
 . D FIELD^DID(FILE,FIELD,"","LABEL","LADATA","LAMSG")
 . I '$D(LAMSG) S FIELD=LADATA("LABEL")
 . ;
 . W !,?7,"Lab Data: ",SECT," [",FIELD,"]"
 . D NP Q:LABORT
 . W !,?9,"SCT Top Concept: ",$G(D64061(63.3,"E"))," [",$G(D64061(63.3,"I")),"]"
 . D NP Q:LABORT
 ;
 W !,$$CJ^XLFSTR("<  <  <  End of report  >  >  >",IOM),!
 Q
 ;
HDR1 ;
 ; Generate header used with "Error" report
 N PGNUM,X
 S PGNUM=$G(LAPGDATA("PGNUM"),1)
 I PGNUM=1 I $E($G(IOST),1,2)="C-" I $G(IOF)'="" W @IOF
 W !,"Laboratory Tests for "_LASS_" with mapping errors"
 S X=$$FMTE^XLFDT(LANOW)
 W ?IOM-$L(X),X
 S X="Page: "_PGNUM_"  "
 W !?IOM-$L(X),X
 W !,$$REPEAT^XLFSTR("=",IOM)
 Q
 ;
HDR2 ;
 ; Generate header used with "Correct" report
 N PGNUM,X
 S PGNUM=$G(LAPGDATA("PGNUM"),1)
 I PGNUM=1 I $E($G(IOST),1,2)="C-" I $G(IOF)'="" W @IOF
 W !,"Laboratory Tests for "_LASS_" mapped correctly"
 S X=$$FMTE^XLFDT(LANOW)
 W ?IOM-$L(X),X
 S X="Page: "_PGNUM_"  "
 W !?IOM-$L(X),X
 W !,$$REPEAT^XLFSTR("=",IOM)
 Q
 ;
NP ;
 ; Convenience method
 D NP^LRUTIL(.LABORT,.LAPGDATA)
 Q
