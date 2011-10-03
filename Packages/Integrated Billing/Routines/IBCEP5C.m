IBCEP5C ;ALB/TMP - EDI UTILITIES for provider ID ;02-NOV-00
 ;;2.0;INTEGRATED BILLING;**137,239,232,320,348,349**;21-MAR-94;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
COMBOK(IBFILE,IBDAT,IBALL,IBF) ; Generic ask if conflict, should id rec still
 ;  be added?
 ; IBFILE = 355.9 or 355.91 for the file being edited
 ; IBDAT = var ptr prov ien (355.9) ^ pc to check ^
 ;           ins co ien or *ALL* ^ care unit or *N/A* ^
 ;           form type code ^ care type code ^ prov id type ptr
 ; IBALL = flag:
 ;   0 = Individual entry selected - check for existing ALL entry
 ;   1 = 'ALL' selected - check for existing individual ones
 ; IBF = 1 if deleting from ins co-related options, ""
 ;       from provider-related options
 ; Returns 1 if ok to continue, 0 if not
 ;
 N X,Y,Q,DIR,Z,IBD,IBDD,IBOK,IBSPEC
 S IBALL=$G(IBALL),IBOK=1
 S IBD=+$P(IBDAT,U,2),IBDD=$S(IBD=4:5,1:4)
 F Z=2:1:6 D
 . I IBD'=Z,$P(IBDAT,U,Z+1)'="" S Z(Z)=$P(IBDAT,U,Z+1) Q
 . I IBD=Z S IBD(Z)=$P(IBDAT,U,Z+1)
 K IBSPEC
 I IBALL D  ; Check for specific
 . N X0,X1
 . S X1=0
 . F  S X1=$O(^IBA(IBFILE,"AC",$S(IBFILE=355.9:Z(6),1:Z(2)),$S(IBFILE=355.9:Z(2),1:Z(6)),$S(IBFILE=355.9:$P(IBDAT,U),1:Z(3)),X1)) Q:'X1  S X0=$G(^IBA(IBFILE,X1,0)) I $S(IBFILE=355.9:$P(X0,U,3)=Z(3),1:1) D
 .. I $P(X0,U,IBD)'=IBD(IBD),"12"[$P(X0,U,IBD),($P(X0,U,IBDD)=Z(IBDD)!($P(X0,U,IBDD)=0)!(Z(IBDD)=0&(IBD(IBD)=0))) S X1($P(X0,U,IBD))=X1 Q
 .. I IBD(IBD)=0,Z(IBDD)=0 S X1(0)=X1
 . S X0=0 F  S X0=$O(X1(X0)) Q:X0=""  D
 .. S IBSPEC=$S($G(IBSPEC)'="":IBSPEC_"  ",1:"")_$P($S(IBD=4:"UB-04^CMS-1500",1:"INPT^OUTPT"),U,X0)_" ONLY"
 . I $D(X1(0)) S IBSPEC=$S($G(IBSPEC)'="":IBSPEC_"  ",1:"")_$S(IBD=4:"BOTH UB-04 and CMS-1500 form type  AND  BOTH INPT and OUTPT care type",1:"BOTH INPT and OUTPT care type  AND  BOTH UB-04 and CMS-1500 form type")
 . ;
 I 'IBALL D
 . N X0,X1
 . S X1=0
 . F  S X1=$O(^IBA(IBFILE,"AC",$S(IBFILE=355.9:Z(6),1:Z(2)),$S(IBFILE=355.9:Z(2),1:Z(6)),$S(IBFILE=355.9:$P(IBDAT,U),1:Z(3)),X1)) Q:'X1  D
 .. S X0=$G(^IBA(IBFILE,X1,0))
 .. I $S(IBFILE=355.9:$P(X0,U,16)=Z(3),1:1),$P(X0,U,IBD)=0,$S($P(X0,U,IBDD)=Z(IBDD):1,1:$P(X0,U,IBDD)=0) S IBSPEC=""
 ;
 I $D(IBSPEC) D
 . N X0,X1,TEXT,IBWHAT
 . S IBWHAT=$S(IBFILE=355.9:$S($G(IBF):"INS CO AND PROVIDER",1:"PROVIDER"),1:"INSURANCE CO")
 . S X0=$S($D(IBD(4)):"UB-04^CMS-1500",1:"INPT^OUTPT")
 . S X1=$S($D(IBD(4)):"FORM TYPE",1:"CARE TYPE")
 . S DIR(0)="YA"
 . S TEXT(1)="WARNING ... POTENTIAL CONFLICT DETECTED!!"
 . S TEXT(2)=" YOUR NEW COMBINATION APPLIES TO "_$S(IBALL:"BOTH "_$S(IBD=4:"FORM ",1:"INPT AND OUTPT CARE ")_"TYPES",1:"ONLY "_$P(X0,U,IBD(IBD))_" "_X1)
 . S TEXT(3)=" THIS SAME COMBINATION ALREADY EXISTS FOR THE "_IBWHAT_" & "_$S('IBALL:"ALL "_X1_"S",1:"SPECIFIC "_X1_"(S):")
 . S:IBSPEC'="" TEXT(4)=$J("",4)_IBSPEC
 . S TEXT($S($D(TEXT(4)):5,1:4))=" "
 . S DIR("A")="ARE YOU SURE YOU STILL WANT TO ADD THIS RECORD?: "
 . S DIR("?",1)=" "
 . S DIR("?",2)="This combination appears to be conflicting with one(s) already on file."
 . S DIR("?",3)="It has already been defined for the "_$$LOW^XLFSTR(IBWHAT)_" for "_$S(IBALL:"at least 1 specific ",1:"ALL ")_$S(IBD=4:"form",1:"care")_" type"_$S(IBALL:".",1:"s.")
 . S DIR("?")="Respond NO to reject this conflicting record or YES to continue on to add it in spite of the apparent conflict.",DIR("B")="NO"
 . W !! F Q=1:1 Q:'$D(TEXT(Q))  W TEXT(Q),!
 . D ^DIR K DIR W !
 . S IBOK=(Y=1)
 Q IBOK
 ;
CAREUN ;Called from NEWID^IBCEP5B to check for existing record combination
 N DIR
 I IBFILE'=355.9 D
 . S IB35591(.03)=IB3559(.03)
 . I "0"[IB35591(.03) S IB35591(.03)="*N/A*"
 . I IB35591(.03)'="*N/A*" S IB35591(.03)=$O(^IBA(355.96,"AUNIQ",IBINS,IB3559(.03),IB3559(.04),IB3559(.05),IBPTYP,"")) I 'IB35591(.03) D
 .. S IB35591(.03)=$O(^IBA(355.96,"AUNIQ",IBINS,IB3559(.03),IB3559(.04),0,IBPTYP,"")) I 'IB35591(.03) D
 ... S IB35591(.03)=$O(^IBA(355.96,"AUNIQ",IBINS,IB3559(.03),0,IB3559(.05),IBPTYP,"")) I 'IB35591(.03) D
 .... S IB35591(.03)=$O(^IBA(355.96,"AUNIQ",IBINS,IB3559(.03),0,0,IBPTYP,""))
 . I $D(^IBA(355.91,"AUNIQ",IBINS,IB35591(.03),IB3559(.04),IB3559(.05),IBPTYP)) D  Q
 .. S DIR(0)="EA",DIR("A",1)="This record already exists - NOT ADDED",DIR("A")="PRESS the ENTER key to continue" W ! D ^DIR K DIR,IB3559,IB35591 W !
 I IBFILE=355.9 D
 . S IB35591(.03)=IB3559(.03)
 . I "0"[IB35591(.03) S IB35591(.03)="*N/A*"
 . I IB35591(.03)'="*N/A*" S IB35591(.03)=$O(^IBA(355.96,"AUNIQ",IBINS,IB3559(.03),IB3559(.04),IB3559(.05),IBPTYP,"")) I 'IB35591(.03) D
 .. S IB35591(.03)=$O(^IBA(355.96,"AUNIQ",IBINS,IB3559(.03),IB3559(.04),0,IBPTYP,"")) I 'IB35591(.03) D
 ... S IB35591(.03)=$O(^IBA(355.96,"AUNIQ",IBINS,IB3559(.03),0,IB3559(.05),IBPTYP,"")) I 'IB35591(.03) D
 .... S IB35591(.03)=$O(^IBA(355.96,"AUNIQ",IBINS,IB3559(.03),0,0,IBPTYP,""))
 . I $D(^IBA(355.9,"AUNIQ",IBPRV,IBINS,IB35591(.03),IB3559(.04),IB3559(.05),IBPTYP)) D  Q
 .. S DIR(0)="EA",DIR("A",1)="This record already exists - NOT ADDED",DIR("A")="PRESS the ENTER key to continue" W ! D ^DIR K DIR,IB3559,IB35591 W !
 Q
 ;
DEL(IBFILE,IBDA,IBF) ; Delete prov specific ID's
 ; IBFILE = 355.9 or 355.91 for the file
 ; IBDA = ien of entry in file IBFILE
 ; IBF = 1 if deleting from ins co-related options, ""
 ;       from prov-related options
 N IB0,IBLAST,IBX,DIK,DA,DIR,X,Y,Z
 F Z=1:1:3 L +^IBA(IBFILE,IBDA):5 Q:$T
 I '$T D  G DELQ
 . W !,"RECORD IS LOCKED BY ANOTHER USER - TRY AGAIN LATER"
 . D ENTER^IBCEP5B(.DIR)
 . W ! D ^DIR K DIR W !
 S IB0=$G(^IBA(IBFILE,IBDA,0))
 S IBX=0
 S IBX=IBX+1,DIR("A",IBX)=" PROVIDER: "_$S(IBFILE=355.9:$$EXPAND^IBTRE(355.9,.01,$P(IB0,U)),1:"*ALL*")
 D DISP^IBCEP4("DIR(""A"")",$P(IB0,U,$S(IBFILE=355.9:2,1:1)),$P(IB0,U,6),$P(IB0,U,4),$P(IB0,U,5),IBX+1,.IBLAST)
 I $P(IB0,U,3)'="" S DIR("A",IBLAST+1)="CARE UNIT: "_$$EXPAND^IBTRE(355.91,.03,$P(IB0,U,3))
 S DIR("A",IBLAST+2)="  PROV ID: "_$P(IB0,U,7),DIR("A",IBLAST+3)=" "
 S DIR("A")="OK TO DELETE THIS "_$S($G(IBF):"INSURANCE COMPANY ",1:"")_"PROVIDER ID RECORD?: ",DIR("B")="NO"
 S DIR(0)="YA"
 W ! D ^DIR K DIR W !
 I Y'=1 G DELQ
 I IBDA>0 D
 . I IBFILE=355.91!(IBFILE=355.9&($P($G(^IBA(IBFILE,IBDA,0)),U)["VA(200,")) D
 .. N NEXTONE S NEXTONE=$$NEXTONE^IBCEP5A()
 .. S ^TMP("IB_EDITED_IDS",$J,NEXTONE)=IBDA_U_"DEL"_U_IBFILE_U_IBDA
 .. S ^TMP("IB_EDITED_IDS",$J,NEXTONE,0)=$G(^IBA(IBFILE,IBDA,0))
 . S DA=IBDA,DIK="^IBA("_IBFILE_"," D ^DIK
DELQ L -^IBA(IBFILE,IBDA)
 Q
 ;
CUCHK(IBDA,IB0) ;Called from CHG^IBCEP5B to check for existing combination
 ; during edit 
 ; IBDA = the ien of the record being edited
 ; IB0 = Proposed changed 0 node of the entry in the file
 ; FUNCTION RETURNS 0 if no duplicate found, 1 if record already exists
 N Z,IBCUCHK,DIR,X,Y
 S IBCUCHK=0
 I IBFILE=355.91 S Z=+$O(^IBA(355.91,"AUNIQ",$P(IB0,U,1),$S($P(IB0,U,3)="@":"*N/A*",$P(IB0,U,3):$P(IB0,U,3),1:$P(IB0,U,10)),$P(IB0,U,4),$P(IB0,U,5),$P(IB0,U,6),0)) I Z,Z'=IBDA S IBCUCHK=1
 I IBFILE=355.9 D
 . N X,X1
 . S X=$S($P(IB0,U,2):$P(IB0,U,2),1:$P(IB0,U,15)) S:X="" X="*ALL*"
 . S X1=$S($P(IB0,U,3):$P(IB0,U,3),$P(IB0,U,3)="@":"",1:$P(IB0,U,16)) S:X1="" X1="*N/A*"
 . S Z=+$O(^IBA(355.9,"AUNIQ",$P(IB0,U,1),X,X1,$P(IB0,U,4),$P(IB0,U,5),$P(IB0,U,6),0)) I Z,Z'=IBDA S IBCUCHK=1
 I IBCUCHK D
 . S DIR(0)="EA",DIR("A",1)="This combination already exists - RECORD NOT CHANGED",DIR("A")="PRESS the ENTER key to continue" W ! D ^DIR K DIR W !
 Q IBCUCHK
 ;
