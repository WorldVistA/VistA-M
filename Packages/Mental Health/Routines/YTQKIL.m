YTQKIL ;ASF/ALB,HIOFO/FT - MHA3 DELETES ; 11/14/11 2:01pm
 ;;5.01;MENTAL HEALTH;**85,100,106**;Dec 30, 1994;Build 10
 Q
 ;
 ;Reference to ^XLFDT APIs supported by DBIA #10103
 ;
EN ; Called from ^YTKIL - Delete Patient Data [YSMKIL]
 N DIR,DIRUT,YS71,YSAD,YSANS,YSGIVEN,YSORD,YSORDID,YSTST,G,N,X,Y,YS,YSGIVEFM
 I '$D(^YTT(601.84,"C",YSDFN)) W !,"No MH administration/test data exists for this patient." H 4 Q
 K YSDATA
 S YS("DFN")=YSDFN,YS("COMPLETE")="Y" D ADMINS^YTQAPI5(.YSDATA,.YS)
 S N=2 F  S N=$O(YSDATA(N)) Q:N'>0!($G(DIRUT))  D
 . S G=YSDATA(N)
 . S YSAD=$P(G,U) Q:YSAD'?1N.N  ;-->out
 . S YSTST=$P(G,U,2)
 . S YSGIVEN=$$GET1^DIQ(601.84,YSAD_",",3)
 . S YSGIVEFM=$$GET1^DIQ(601.84,YSAD_",",3,"I")
 . S YSGIVEFM=$$FMTHL7^XLFDT(YSGIVEFM)
 . S YSORD=$$GET1^DIQ(601.84,YSAD_",",5)
 . S YSORDID=$$GET1^DIQ(601.84,YSAD_",",5,"I")
 . S YS71=$O(^YTT(601.71,"B",YSTST,0))
 . W !,YSTST_" on "_YSGIVEN_" by "_YSORD
 . S DIR(0)="Y",DIR("A")="Delete",DIR("B")="No" D ^DIR
 . D:Y DEL ;ft 11/14/11 removed call to EMAIL. Remove EMAIL & XMIT subroutines, too.
 Q
DEL ;delete admin
 S DIR(0)="Y",DIR("A")="Are you sure",DIR("B")="No" D ^DIR
 Q:'Y
 N DA,DIK
 S DIK="^YTT(601.84,",DA=YSAD D ^DIK
 S YSANS=0 F  S YSANS=$O(^YTT(601.85,"AD",YSAD,YSANS)) Q:YSANS'>0  D
 . S DIK="^YTT(601.85,",DA=YSANS D ^DIK
 W "  ***Deleted"
 Q
