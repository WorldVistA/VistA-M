YSCUP000 ;DALISC/LJA - Pt Move Utils: Master Logic ;8/23/94 18:04
 ;;5.01;MENTAL HEALTH;**2,11,20,29**;Dec 30, 1994
 ;;
 ;
CTRL ;  Process movements starting here... YSCUP is just the "caller".
 ;
 ;  Required Variable: DFN
 ;
 ;  OK to set DFN and call here multiple times.  No harm done.
 ;  This can be done to correct any "errant" patient records.
 ;
CHKPMOV ;  Check type of PIM's movement. If the movement is made from Bed Switch
 ;  [DG SWITCH BED], Provider Change [DGPM PROVIDER CHANGE],
 ;  Check-in Lodger [DGPM CHECK-IN] OR Lodger Check-out [DGPM CHECK-OUT],
 ;  then no MH data is updated.
 ;
 S YSMOVOK=1
 S:$D(ZTQUEUED) ZTREQ="@"
 I DGPMA="",$D(DGPMP)&($P(DGPMP,U,2)=4)!($P(DGPMP,U,2)=5) D
 .  S YSMOVOK=0
 E  I $D(DGPMA) D
 .  I (($D(DGPMA)&(DGPMP'=""))&($P(DGPMA,U,2)=1)&($P(DGPMA,U,7)'=$P(DGPMP,U,7)))!(($P(DGPMA,U,2)=6))!($P(DGPMA,U,2)=4)!($P(DGPMA,U,2)=5) D
 .  .  S YSMOVOK=0
 QUIT:'YSMOVOK
 ;
CHKMOV ;Check movement
 ;
 S YSACTS=0 ;                         Records if Adds, Deletes, or
 ;                                    Updates occured
 D CKDFN QUIT:'YSOK  ;->
 N YSMH
 S YSMH="^TMP(""YSMH"""_","_$J_")"
 D GETMH^YSCUP003(+YSDFN,YSMH) ;    Move MH Entries into ^TMP("YSMH",$J,
 S YSMHMOV=0
 N YSPM
 S YSPM="^TMP(""YSPM"""_","_$J_")"
 D GETMOVES^YSCUP003(+YSDFN,YSPM) ; Move Latest Inpt Stay info -> ^TMP("YSPM",$J,
 D STATUS ;                           Build p(1-2) of YSTatus
 N YSMH,YSPM
 S YSMH="^TMP(""YSMH"""_","_$J_")",YSPM="^TMP(""YSPM"""_","_$J_")"
 D MATCH^YSCUP003(YSMH,YSPM) ;    Compare ^TMP("YSPM",$J, to ^TMP("YSMH",$J, data
 D XTMP^YSCUP004 ;                    Store ^XTMP data
 D ACTION ;                           Create, Edit, or Delete ^YSG("INP",
 D UPDST^YSCUP004 ;                   Store latest value of YST in ^XTMP
 I 'YSACTS D  ;                       If no MH actions, kill ^XTMP data
 .  D CLEAN^YSCUP004
 .  QUIT
 D NOMH^YSCUP004($G(YSXTMP),1) ;      If MH actions, leave 0 node
 ;
 QUIT
 ;
ACTION ;  Perform whatever updating is necessary...
 QUIT:'$D(YSPM)&('$D(YSMH))  ;->
 ;
 ;  Active MH Inpatient?  (0/1)
 S YSAMV=+$O(^TMP("YSPM",$J,0)),YSAMV=+$G(^TMP("YSPM",$J,+YSAMV))
 ;
 ;  MH Inpt entry active now? (0/1)
 S YSAMH=+$O(^TMP("YSMH",$J,0)),YSAMH=$P($G(^TMP("YSMH",$J,+YSAMH,7)),U,4),YSAMH=(YSAMH>0)
 ;
NOMH1 ;  If no MH moves, but latest MH Inpt entry from current stay moves...
 S $P(YST,U,7)="NOMH"
 I $P(YST,U,3)'>0&($$CURRENT>0) D  QUIT  ;->
 .  I '$D(ZTQUEUED),'$G(DGQUIET) W !,"No Mental Health wards in current stay...  Deleting entry# "
 .  S X=+$O(^TMP("YSMH",$J,0)),YSNO=+$G(^TMP("YSMH",$J,+X,0)) W:YSNO>0&('$D(ZTQUEUED))&('$G(DGQUIET)) +YSNO
 .  I '$D(ZTQUEUED),('$G(DGQUIET)) W "..."
 .  I YSNO>0 D DELETE^YSCUP002(+YSNO)
 ;
NOMH2 ;  If no MH moves, and latest MH inpt entry NOT from current stay...
 S $P(YST,U,7)="NOMH2"
 I $P(YST,U,3)'>0&(+$$CURRENT'>0) D  QUIT  ;->
 .  S $P(YST,U,7)="NOMH2"
 .  K ^XTMP(YSXTMP)
 .  S YSACTS=0
 .  I '$D(ZTQUEUED),'$G(DGQUIET) W "  No MH actions taken..."
 ;
DELMH ;  Should MH entry be deleted?
 ;  Get Last Movement information...
 ;       ... Movement Type & Movement Number
 S $P(YST,U,7)="DELMH"
 S X=+$O(^TMP("YSPM",$J,0)),X=$G(^TMP("YSPM",$J,+X)),YSMT=+$P(X,U,4),YSMOVN=+$P(X,U,5)
 ;  Get Last MH Entry Information...
 S X=+$O(^TMP("YSMH",$J,0)),X=$G(^TMP("YSMH",$J,+X,7)),YSMHAN=+$P(X,U,3)
 ;  If last movement is a DC, and IEN of last movement is LESS than the
 ;  Admission IEN used to create the last MH Inpatient entry!!!
 I YSMT=3,YSMHAN>YSMOVN D  QUIT  ;->
 .  I '$D(ZTQUEUED),'$G(DGQUIET) W !,"No Mental Health wards in current stay...  Deleting entry# "
 .  S X=+$O(^TMP("YSMH",$J,0)),YSNO=+$G(^TMP("YSMH",$J,+X,0)) W:(YSNO>0&('$D(ZTQUEUED)))&('$G(DGQUIET)) +YSNO
 .  I '$D(ZTQUEUED),'$G(DGQUIET) W "..."
 .  I YSNO>0 D DELETE^YSCUP002(+YSNO)
 ;
MHMOV ;  If MH moves, and NO current entry
 S $P(YST,U,7)="MHMOV"
 I $P(YST,U,3)>0&(+$$CURRENT'>0) D  QUIT  ;->
 .
 .  QUIT:$G(YSFMTMH)']""!($G(YSFMTMH)="0")  ;->
 .  I '$D(ZTQUEUED),'$G(DGQUIET) W !,"Creating new Mental Health Inpt file entry..."
 .  D ADD^YSCUP002(+YSFMTMH)
 .  I '$D(ZTQUEUED),'$G(DGQUIET) W $S($G(YSIEN)'>0:" No entry made!",1:" #"_+YSIEN)
 .  QUIT:$G(YSIEN)'>0  ;->
 .  D GETMH^YSCUP003(+YSDFN,"^TMP(""YSMH"","_$J_",") ;Update ^TMP("YSMH",$J, array elements...
 .  S X=+$O(^TMP("YSMH",$J,0)),YSNO=+$G(^TMP("YSMH",$J,+X,0))
 .  I '$D(ZTQUEUED),'$G(DGQUIET) W !,"Updating MH entry ",$S(YSNO>0:"#"_+YSNO,1:""),"..."
 .  D UPDATE^YSCUP001(+$O(^TMP("YSMH",$J,0)),+$O(^TMP("YSPM",$J,0)))
 ;
UPDATE ;  Update data in last YSMH entry...
 S $P(YST,U,7)="UPDATE"
 S X=$$CURRENT I +$P(X,U,2)>0&('$D(ZTQUEUED))&('$G(DGQUIET)) W !,"Updating MH entry# ",+$P(X,U,2),"..."
 D UPDATE^YSCUP001(+$O(^TMP("YSMH",$J,0)),+$O(^TMP("YSPM",$J,0)))
 ;
 QUIT
CURRENT() ; Is last YSMH entry part of the current stay?  (0/Move IEN)
 ;  Returns 0 or Movement IEN of move responsible for MH Inpt creation
 I +$O(^TMP("YSMH",$J,0))'>0 QUIT 0 ;->                 No MH entries exist
 S YSMH=+$O(^TMP("YSMH",$J,0)),YSNO=+$P($G(^TMP("YSMH",$J,+YSMH,7)),U,3) I YSNO'>0 QUIT 0 ;->
 S X=$D(^TMP("YSPM",$J,"A",+YSNO)) QUIT:+X'>0 0 ;->
 S YSMH=+$G(^TMP("YSMH",$J,+YSMH,0)) QUIT:YSMH'>0 0 ;->
 S X=+$O(^TMP("YSPM",$J,0)),YSC=+$P($G(^TMP("YSPM",$J,+X)),U,4)
 QUIT +YSNO_U_+YSMH_U_+YSC
 ;
STATUS ;  MH/Patient Movement Data Status...
 ;  YST is used to track various statuses...
 ;  STATUS^YSCUP000 sets the 1st two pieces...
 ;      MH DATA?  ^  MOVEMENT DATA
 ;  MATCH^YSCUP003 sets the third piece.  (Ie., Whether there is
 ;  is a match between movements and MH entries.)
 ;
 S YST=(YSNMH>0)_U_(YSNM>0)
 ;
 QUIT
 ;
CKDFN ;  DFN check...
 S YSOK=1
 S:$G(DFN)>0&($G(YSDFN)'>0) YSDFN=+DFN
 QUIT:$G(YSDFN)>0  ;->
 I '$D(ZTQUEUED),'$G(DGQUIET) W !!,$C(7),"The patient DFN is not defined!!  Exiting..."
 H 10
 S YSOK=0
 QUIT
 ;
EOR ;YSCUP000 - Pt Move Utils: Master Logic ;8/23/94 18:04
