GMTSXA ; SLC/KER - List Parameters                       ; 02/27/2002
 ;;2.7;Health Summary;**47,49**;Oct 20, 1995
 Q
 ;                                
 ; External References in GMTSXA
 ;                                  
 ;   DBIA  2336  EDITPAR^XPAREDIT
 ;   DBIA  2336  EDIT^XPAREDIT
 ;   DBIA  2343  $$ACTIVE^XUSER
 ;   DBIA 10086  HOME^%ZIS
 ;                        
DISP ; Display User Defaults
 G:+($G(DUZ))=.5 DS N GMTSENV,GMTSMGR S GMTSENV=$$ENV Q:+GMTSENV'>0
 S GMTSMGR=$$MGR^GMTSXAW3
 D:+GMTSMGR>0&(+($G(DUZ))>.9) DM D:+GMTSMGR'>0&(+($G(DUZ))>.9) DU Q
DU ;   Display - User Entry Point
 N GMTSENV S GMTSENV=$$ENV Q:+GMTSENV'>0  D EN^GMTSXAD Q
DM ;   Display - Manager Entry Point
 N GMTSENV,GMTSMGR S GMTSENV=$$ENV Q:+GMTSENV'>0
 S GMTSMGR=$$MGR^GMTSXAW3 Q:GMTSMGR'>0
 S GMTSUSR=$$USR^GMTSXAW3("Display defaults for user:  ")
 W:+GMTSUSR>0 ! D:+GMTSUSR>0 EN2^GMTSXAD(GMTSUSR) Q
DS ;   Display - Manager Entry Point
 N GMTSENV,GMTSMGR S GMTSENV=$$ENV Q:+GMTSENV'>0  S GMTSUSR=.5 W !
 D EN3^GMTSXAD Q
 ;            
PREC ; Set Precedence
 N GMTSENV,GMTSMGR S GMTSENV=$$ENV Q:+GMTSENV'>0
 S GMTSMGR=$$MGR^GMTSXAW3 D:+GMTSMGR>0 PM D:+GMTSMGR'>0 PU Q
PU ;   Precedence - User Entry Point
 N GMTSENV S GMTSENV=$$ENV Q:+GMTSENV'>0  D EN^GMTSXAP Q
PM ;   Precedence - Manager Entry Point
 N GMTSENV,GMTSMGR S GMTSENV=$$ENV Q:+GMTSENV'>0
 S GMTSMGR=$$MGR^GMTSXAW3 Q:GMTSMGR'>0
 S GMTSUSR=$$USR^GMTSXAW3("Set Health Summary Precedence for user:  ")
 W:+GMTSUSR>0 ! D:+GMTSUSR>0 EN2^GMTSXAP(GMTSUSR) Q
PS ;   Precedence - Site
 D ADED^GMTSXAR Q
RS ;   Resequence Site Precedence
 D EN^GMTSXAR Q
 ;            
METH ; Set Method of Building List
 N GMTSENV,GMTSMGR S GMTSENV=$$ENV Q:+GMTSENV'>0
 S GMTSMGR=$$MGR^GMTSXAW3 D:+GMTSMGR>0 MM D:+GMTSMGR'>0 MU Q
MU ;   Method - User Entry Point
 N GMTSENV S GMTSENV=$$ENV Q:+GMTSENV'>0  D EN^GMTSXAO Q
MM ;   Method - Manager Entry Point
 N GMTSENV,GMTSMGR S GMTSENV=$$ENV Q:+GMTSENV'>0
 S GMTSMGR=$$MGR^GMTSXAW3 Q:GMTSMGR'>0
 S GMTSUSR=$$USR^GMTSXAW3("Set Method of Building list for user:  ")
 W:+GMTSUSR>0 ! D:+GMTSUSR>0 EN2^GMTSXAO(GMTSUSR) Q
MS ;   Method - Default for Site Wide
 N GMTSUSR S GMTSUSR=.5 D EN3^GMTSXAO Q
 ;                        
EDIT ; Edit Type List
 N GMTSENV,GMTSMGR S GMTSENV=$$ENV Q:+GMTSENV'>0
 S GMTSMGR=$$MGR^GMTSXAW3 D:+GMTSMGR>0 EM D:+GMTSMGR'>0 EU Q
EU ;   Edit List - User Entry Point
 N GMTSENV S GMTSENV=$$ENV Q:+GMTSENV'>0  D EL(+($G(DUZ))) Q
EM ;   Edit List - Manager Entry Point
 N GMTSENV,GMTSMGR,GMTSLST S GMTSENV=$$ENV Q:+GMTSENV'>0
 S GMTSMGR=$$MGR^GMTSXAW3 Q:GMTSMGR'>0
 W ! D EDITPAR^XPAREDIT("ORWRP HEALTH SUMMARY TYPE LIST")
 Q
EL(X) ;   Edit List
 N GMTSENT,GMTSVEN,GMTSPAR,GMTSUSR,GMTSACT S GMTSUSR=+($G(X))
 Q:'$L($$UNM^GMTSXAW3(+($G(GMTSUSR))))
 S GMTSACT=$$ACTIVE^XUSER(+GMTSUSR)
 D:+GMTSACT'>0 DP^GMTSXAP2(+GMTSUSR) Q:+GMTSACT'>0
 S GMTSPAR=$$PDI^GMTSXAW3("ORWRP HEALTH SUMMARY TYPE LIST")
 Q:+GMTSPAR'>0  S GMTSENT=$$ETI^GMTSXAW3("USR") Q:+GMTSENT'>0
 S GMTSVEN=$$UVP^GMTSXAW3(+($G(GMTSUSR)))
 W !!,"Edit the CPRS Health Summary Types list on the reports tab"
 D EDIT^XPAREDIT(GMTSVEN,(+GMTSPAR_"^GUI Health Summary Type List")) W !
 Q
 ;                                 
 ; Miscellaneous
ENV(X) ;   Environment check
 D HOME^%ZIS S U="^" Q:'$L($$UNM^GMTSXAW3(+($G(DUZ)))) 0
 Q 1
LP ;   List Preferences
 N GMTSN,GMTSS,GMTSI,GMTSM,GMTSP,GMTSC,GMTSNUM S GMTSN="",GMTSC=0
 F  S GMTSN=$O(^GMT(142.98,"AB",GMTSN)) Q:GMTSN=""  D
 . S GMTSI=0  F  S GMTSI=$O(^GMT(142.98,"AB",GMTSN,GMTSI)) Q:+GMTSI=0  D
 . . S GMTSM=$G(^GMT(142.98,+GMTSI,1)),GMTSP=$P(GMTSM,"^",2)
 . . S GMTSM=$S(+GMTSM=1:"Append   ",1:"Overwrite")
 . . S GMTSNUM=$$NUM^GMTSXAL(+GMTSI) S GMTSC=GMTSC+1 I GMTSC=1 D
 . . . W !!,"Health Summary Preferences",!!,"  Name ",?24," Method"
 . . . W ?36," Precedence",?59,"  Types"
 . . . W !,"  --------------------",?24," ---------"
 . . . W ?36," -------------------",?59,"  -----"
 . . . S GMTSD=$$DEF^GMTSXAW
 . . . I $L(GMTSD) D
 . . . . W !,"  <default>",?24," Append",?36," ",GMTSD,?59,"  <all>"
 . . W !,?2,$E(GMTSN,1,20),?24," ",GMTSM,?36," ",GMTSP
 . . W ?59,"   ",$J(+GMTSNUM,2)
 W !
 Q
TRIM(X,Y,I) ;   Trim Character
 S X=$G(X),Y=$G(Y),I=+($G(I)) Q:'$L(X) X
 S:'$L(Y) Y=" " S:I=0 I=3 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 I +I>1 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 I I>2 F  Q:X'[(Y_Y)  S X=$P(X,(Y_Y),1)_Y_$P(X,(Y_Y),2,229)
 Q X
UP(X) ;   Uppercase
 Q $TR($G(X),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
