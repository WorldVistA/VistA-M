XVEMKI5 ;DJB/KRN**Indiv Fld DD - New-Style Indexes cont ;2017-08-15  12:58 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
INDEXCD ;Nodes that contain Mumps code
 ;
 NEW CD,NUM
 ;
 W ! Q:$$CHECK
 ;
 ;Set Logic
 D  Q:FLAGQ
 . S CD=$G(^DD("IX",IEN,1)) Q:CD']""
 . W !?C2,"Set Logic:"
 . S STRING=CD D STRING^XVEMKI3
 ;
 ;Overflow Set Logic code
 I $D(^DD("IX",IEN,1.2)) D  Q:FLAGQ
 . S NUM=0
 . F  S NUM=$O(^DD("IX",IEN,1.2,NUM)) Q:'NUM!FLAGQ  D  ;
 .. W !?C2,"  Node ",$P($G(^DD("IX",IEN,1.2,NUM,0)),U,1),":"
 .. S STRING=^DD("IX",IEN,1.2,NUM,1) D STRING^XVEMKI3
 ;
 ;Set Condition
 D  Q:FLAGQ
 . S CD=$G(^DD("IX",IEN,1.3)) Q:CD']""
 . W !?C2,"Set Condition:"
 . S STRING=CD D STRING^XVEMKI3
 ;
 ;Set Condition Code
 D  Q:FLAGQ
 . S CD=$G(^DD("IX",IEN,1.4)) Q:CD']""
 . W !?C2,"Set Cond Cd:"
 . S STRING=CD D STRING^XVEMKI3
 ;
 ;Kill Logic
 D  Q:FLAGQ
 . S CD=$G(^DD("IX",IEN,2)) Q:CD']""
 . W !?C2,"Kill Logic:"
 . S STRING=CD D STRING^XVEMKI3
 ;
 ;Overflow Kill Logic code
 I $D(^DD("IX",IEN,2.2)) D  Q:FLAGQ
 . S NUM=0
 . F  S NUM=$O(^DD("IX",IEN,2.2,NUM)) Q:'NUM!FLAGQ  D  ;
 .. W !?C2,"  Node ",$P($G(^DD("IX",IEN,2.2,NUM,0)),U,1),":"
 .. S STRING=^DD("IX",IEN,2.2,NUM,2) D STRING^XVEMKI3
 ;
 ;Kill Condition
 D  Q:FLAGQ
 . S CD=$G(^DD("IX",IEN,2.3)) Q:CD']""
 . W !?C2,"Kill Condition:"
 . S STRING=CD D STRING^XVEMKI3
 ;
 ;Kill Condition Code
 D  Q:FLAGQ
 . S CD=$G(^DD("IX",IEN,2.4)) Q:CD']""
 . W !?C2,"Kill Cond Cd:"
 . S STRING=CD D STRING^XVEMKI3
 ;
 ;Kill Index
 D  Q:FLAGQ
 . S CD=$G(^DD("IX",IEN,2.5)) Q:CD']""
 . W !?C2,"Kill Index:"
 . S STRING=CD D STRING^XVEMKI3
 ;
 I VENODE2]"" D  Q:FLAGQ
 . W !?C1,"Store Transfrm:"
 . S STRING=VENODE2 D STRING^XVEMKI3
 ;
 I VENODE3]"" D  Q:FLAGQ
 . W !?C1,"Display Transfrm:"
 . S STRING=VENODE3 D STRING^XVEMKI3
 Q
 ;
CHECK() ;Check page length. 0=Ok  1=Quit
 I $Y'>(XVVSIZE+1) Q 0
 D PAGE^XVEMKI3 I FLAGQ Q 1
 Q 0
