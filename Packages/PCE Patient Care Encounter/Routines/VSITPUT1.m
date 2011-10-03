VSITPUT1 ;ISD/RJP - Continued...Verify/set fields and file visit record ;6/20/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**76**;Aug 12, 1996
 ; Patch PX*1*76 changes the 2nd line of all VSIT* routines to reflect
 ; the incorporation of the module into PCE.  For historical reference,
 ; the old (VISIT TRACKING) 2nd line is included below to reference VSIT
 ; patches.
 ;
 ;;2.0;VISIT TRACKING;**3**;Aug 12, 1996;
 ;
 ;Routine called by ^VSITPUT
 K DD,DO,DA,DIC,DIK,X,Y,DLAYGO
 L +^XTMP("VSIT CREATE",+$G(VSIT("PAT")),+VSIT("VDT")):0 Q:'$T
 D:+$G(DINUM)
 . S DLAYGO=9000010
 . S DIC="^AUPNVSIT("
 . S DIC(0)=""
 . S X=+VSIT("VDT")
 . D FILE^DICN
 . L:+Y>0 +^AUPNVSIT(+Y)
 . K DLAYGO,DIC,DD,DO,X
 D:'+$G(DINUM)
 . N VSITI
 . S VSITI=$P(^AUPNVSIT(0),"^",3)
 . F  S VSITI=VSITI+1 L +^AUPNVSIT(VSITI):1 Q:$T&'$D(^AUPNVSIT(VSITI))  L -^AUPNVSIT(VSITI)
 . S ^AUPNVSIT(VSITI,0)=VSIT("VDT")
 . S ^AUPNVSIT("B",VSIT("VDT"),VSITI)=""
 . L +^AUPNVSIT(0)
 . S ^AUPNVSIT(0)=$P(^AUPNVSIT(0),"^",1,2)_"^"_VSITI_"^"_($P(^(0),"^",4)+1)
 . L -^AUPNVSIT(0)
 . L:VSITI'>0 -^AUPNVSIT(VSITI)
 . S Y=VSITI_"^"_VSIT("VDT")_"^1"
 D:Y>0
 . S VSIT("IEN")=Y
 . S $P(^AUPNVSIT(+Y,0),"^",2,99)=$P(VSITREC(0),"^",2,99)
 . S:$G(VSITREC(21))]"" ^AUPNVSIT(+Y,21)=VSITREC(21)
 . S:$G(VSITREC(150))]"" ^AUPNVSIT(+Y,150)=VSITREC(150)
 . S:$G(VSITREC(800))]"" ^AUPNVSIT(+Y,800)=VSITREC(800)
 . S:$G(VSITREC(811))]"" ^AUPNVSIT(+Y,811)=VSITREC(811)
 . S:$G(VSITREC(812))]"" ^AUPNVSIT(+Y,812)=VSITREC(812)
 . S DA=+Y,DIK="^AUPNVSIT(" D IX1^DIK K DIK
 . L -^AUPNVSIT(DA)
 L -^XTMP("VSIT CREATE",+$G(VSIT("PAT")),+VSIT("VDT"))
 K DD,DO,DA,DIC,DIK,X,Y,DLAYGO
 Q
