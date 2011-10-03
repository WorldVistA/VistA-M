PRCHQ1 ;(WASH ISC)/LKG-RFQ ;8/22/96  17:25
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
IT1 ;Input Transform File 444, Field #14
 N Z0,DIC
 S Z0=$S($P($G(^PRC(444,D0,0)),U,10)]"":$P(^(0),U,10),1:$E($P($G(^PRC(444,D0,0)),U),1,3)) K:'Z0 X Q:'Z0
 S DIC="^PRC(411,Z0,1,",DIC(0)="QEM" D ^DIC S X=+Y K:Y'>0 X
 Q
OT1 ;Output Transform File 444, Field #14
 N Z0
 Q:Y']""
 S Z0=$S($P($G(^PRC(444,D0,0)),U,10)]"":$P(^(0),U,10),1:$E($P($G(^PRC(444,D0,0)),U),1,3)) Q:'Z0
 S Y=$P($S($D(^PRC(411,Z0,1,Y,0))#10:^(0),1:""),U)
 Q
EH1 ;Executable Help File 444, Field #14
 N D,Z0,DIC
 S X="?",Z0=$S($P($G(^PRC(444,D0,0)),U,10)]"":$P(^(0),U,10),1:$E($P($G(^PRC(444,D0,0)),U),1,3)) Q:'Z0
 S DIC="^PRC(411,Z0,1,",DIC(0)="QEM" D ^DIC
 Q
IT2 ;Part of input transform for File 444, Field #.01
 ;Validate that RFQ number based on an existing 2237 number
 ;and work sheet status
 N PRCX,Y,Z
 D
 . S PRCX=$P(X,"-",1,5),Y=$O(^PRCS(410,"B",PRCX,"")) I Y'?1.N K X Q
 . I ";2;3;4;"'[(";"_$P($G(^PRCS(410,Y,0)),U,4)_";") K X Q
 . S Z=$P($G(^PRC(443,Y,0)),U,7) I Z="" K X Q
 . I ";70;80;"'[(";"_$P($G(^PRCD(442.3,Z,0)),U,2)_";") K X Q
 Q
QUOTEDUE ;Input transform for Date Quote Due
 N X1,X2,%Y,PRCX
 S PRCX=X,X1=X,X2=$$GET^DDSVAL(444,DA,1,"","I") D ^%DTC
 I X<3 D  Q
 . D HLP^DDSUTL("Quote Due Date must be at least 3 days after RFQ Reference Date.")
 . S DDSERROR=1
 S X=PRCX
 I X'<$$GET^DDSVAL(444,DA,13,"","I") D  Q
 . D HLP^DDSUTL("Quote Due Date must be before Required Delivery Date.")
 . S DDSERROR=1
 Q
NSN ;Additional Validation of National Stock Number in ScreenMan
 Q:$G(X)=""
 N PRCX
 I '$D(^PRC(441.2,+X,0)) D  Q
 . D HLP^DDSUTL("Invalid NSN - First 4 characters must be a FSC Code.")
 . S DDSERROR=1
 S PRCX=$O(^PRC(441,"BB",X,0))
 S:PRCX=$$GET^DDSVAL(444.019,.DA,1,"","I") PRCX=$O(^PRC(441,"BB",X,PRCX))
 I PRCX'="" D  Q
 . S PRCX="This NSN has already been assigned to Item # "_PRCX
 . D HLP^DDSUTL(PRCX) S DDSERROR=1
 Q
STUFFITM ;Stuff Item Description, National Stock #, FSC, & SIC Code upon change
 ;of referenced Item Master #
 N PRCX,PRCY,PRCZ S PRCX=X
 I PRCX?1.N D
 . S PRCZ=$G(^PRC(441,PRCX,0))
 . D PUT^DDSVAL(444.019,.DA,1.6,$P(PRCZ,U,2))
 . D PUT^DDSVAL(444.019,.DA,1.5,"^PRC(441,PRCX,1)")
 . D PUT^DDSVAL(444.019,.DA,4,$P(PRCZ,U,3))
 . S PRCY=$P(PRCZ,U,14) S:PRCY="" PRCY="@"
 . D PUT^DDSVAL(444.019,.DA,12,PRCY,"",$S(PRCY'="@":"I",1:"E"))
 S PRCY=$S(PRCX="":"",1:$P($G(^PRC(441,PRCX,3)),U,10))
 D:PRCY?1.N PUT^DDSVAL(444.019,.DA,6,PRCY,"","I")
 S PRCY=$S($G(DDSOLD)]""&($G(PRCX)=""):"@",$G(PRCX)="":"",1:$P($G(^PRC(441,PRCX,0)),U,5))
 D:PRCY'="" PUT^DDSVAL(444.019,.DA,5,PRCY,"","E")
 S PRCY=$S($G(DDSOLD)]""&($G(PRCX)=""):"@",$G(PRCX)="":"",1:$P($G(^PRC(441,PRCX,3)),U,5))
 D:PRCY'="" PUT^DDSVAL(444.019,.DA,8,PRCY,"","E")
 S PRCY=$S($G(DDSOLD)]""&($G(PRCX)=""):"@",$G(PRCX)="":"",1:$P($G(^PRC(441,PRCX,0)),U,4))
 I PRCY="@" D
 . N PRCI
 . F PRCI=13,14,14.1,14.2,14.3 D PUT^DDSVAL(444.019,.DA,PRCI,PRCY)
 I PRCY?1.N D
 . N PRCW,PRCV
 . D PUT^DDSVAL(444.019,.DA,13,PRCY,"","I")
 . S PRCZ=$G(^PRC(441,PRCX,2,PRCY,0)) Q:PRCZ=""
 . S PRCW(1)=$P(PRCZ,U,8),PRCV=$P(PRCZ,U,7) S:PRCW(1)]"" PRCW(1)="PACKAGING MULTIPLE: "_PRCW(1)
 . S:PRCV]"" PRCW(1)=PRCW(1)_"/"_$P($G(^PRCD(420.5,PRCV,0)),U)
 . D:PRCW(1)]"" PUT^DDSVAL(444.019,.DA,1.5,"PRCW","","A")
 . D PUT^DDSVAL(444.019,.DA,14.1,$P(PRCZ,U,2))
 . D PUT^DDSVAL(444.019,.DA,14.2,$P(PRCZ,U,7),"","I")
 . D PUT^DDSVAL(444.019,.DA,14.3,$P(PRCZ,U,6),"","I")
 . S PRCY=$P(PRCZ,U,5) S:PRCY="" PRCY="@"
 . D PUT^DDSVAL(444.019,.DA,7,PRCY)
 . S PRCZ=$P(PRCZ,U,4) S:PRCZ="" PRCZ="@"
 . D PUT^DDSVAL(444.019,.DA,14,PRCZ)
 Q
PA(PRCX) ;Verify Purchasing Agent has Commercial Phone
 Q:$G(PRCX)=""
 I $P($G(^VA(200,+PRCX,.13)),U,5)="" D
 . D HLP^DDSUTL("Contracting Officer lacks Commercial Phone #")
 . S DDSERROR=1
 Q
ESIG(PRCX) ;Verifies that editor has ESIG on file
 I $G(PRCX)]"",$P($G(^VA(200,PRCX,20)),U,4)]"" Q 1
 W !,"*** You must have an Electronic Signature Code on file to use this option!",!
 Q 0
