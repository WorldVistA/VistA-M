VSITASK ;ISD/RJP - Prompt User ;6/20/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**76**;Aug 12, 1996
 ; Patch PX*1*76 changes the 2nd line of all VSIT* routines to reflect
 ; the incorporation of the module into PCE.  For historical reference,
 ; the old (VISIT TRACKING) 2nd line is included below to reference VSIT
 ; patches.
 ;
 ;;2.0;VISIT TRACKING;;Aug 12, 1996;
 ;
VSIT(DFN,LST) ; - prompt user to select visit
 ; - called by VSIT
 ;
 ; - pass DFN = <patient record number>
 ;        LST = <passed by reference, array of matching visits VSITGET>
 ; - rtns     = <visit record # selected>
 ;
 N X,Y,NOD,VSITI,X1,X2,DIR
 D:$D(DFN)&$D(LST)
 . S X="Visits for "_$P(^DPT(DFN,0),"^")
 . S Y="",$P(Y,"-",$L(X)+1)="" W !,X,!,Y,!
 . F VSITI=1:1:LST S NOD=$G(LST(VSITI)) Q:NOD=""  D
 . . D FMT(+$P(NOD,"|"))
 . . W $J(VSITI,2)_" - ",?5,X1,!,?5,X2,!
 . S DIR(0)="NA^1:"_LST
 . S DIR("A")="Select Visit (1-"_LST_"): "
 . S DIR("B")="1" D ^DIR
 Q $G(Y)
 ;
FMT(IEN) ; - format display lines for a visit
 ;
 ; - pass IEN   = <visit record #>
 ; - rtns X1,X2 = <formatted display lines>
 ;
 N VSITI,VSIT,X,Y
 S IEN=$G(IEN),(X1,X2)=""
 D SLC^VSITVAR(IEN,"VDT^SVC^INS^TYP^ELG^LOC^DSS","E")
 S X=$P(VSIT("VDT"),"^",2),X1=X_$E($J("",80),$L(X)+1,27)
 S X=$E($P(VSIT("SVC"),"^",2),1,18),X1=X1_X_"   "
 S X=$E($P(VSIT("INS"),"^",2),1,18),X1=X1_X_"  "
 S X=$E($P($P(VSIT("TYP"),"^",2)," "),1,8),X1=X1_"("_X_")"
 S X=$S($P(VSIT("ELG"),"^",2)]"":" Elig: ",1:"")_$E($P(VSIT("ELG"),"^",2),1,13),X2=X2_X_$E($J("",80),$L(X)+1,22)
 S X="Loc: "_$E($P(VSIT("LOC"),"^",2),1,18),X2=X2_X_$E($J("",80),$L(X)+1,20)
 S X="Cat: "_$E($P(VSIT("DSS"),"^",2),1,18),X2=X2_X_$E($J("",80),$L(X)+1,20)
 Q
 ;
ELG(PAT) ; - prompt user to select pt. eligibility
 ; - called by VSITCK1
 ;
 ; - pass PAT = <patient record number>
 ;   rtns     = <selected eligibility>
 ;
 N X,Y,DIC,D,DZ S PAT=$$GET^VSITVAR("PAT",PAT,"B")
 S X="Eligibilities for "_$P(PAT,"^",2)
 S Y="",$P(Y,"-",$L(X)+1)="" W !,X,!,Y
 S DIC(0)="AEQMZ",DIC="^DIC(8,"
 S DIC("S")="I $D(^DPT(+PAT,""E"",+Y,0))"
 I $G(^DPT(+PAT,.36)) S DIC("B")=$P(^DIC(8,+^(.36),0),"^")
 S DIC("A")="Select Eligibility for this Visit: "
 S D="B",DZ="??" D DQ^DICQ K D,DZ F  D ^DIC Q:Y>0  W "   Required!"
 Q $P(Y,"^")
