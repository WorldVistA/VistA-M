SR00109 ;BIR/JLC - CONVERT DEFAULT BLOOD COMPONENTS;30 JUL 02
 ;;3.0; Surgery ;**109**;24 Jun 93
 ;
 ; Reference to ^LAB(66 supported by DBIA 210.
 ; Reference to ^DD(133 supported by DBIA 3646.
 ;
ENNV ; 
 I $G(DUZ)="" W !,"Your DUZ is not defined.  It must be defined to run this routine." Q
 K ZTSAVE,ZTSK S ZTRTN="ENQN^SR00109",ZTDESC="CONVERT BLOOD COMPONENT INFORMATION (SURGERY)",ZTIO="" D ^%ZTLOAD
 W !!,"The conversion of blood component information in Surgery is",$S($D(ZTSK):"",1:" NOT")," queued",!
 I $D(ZTSK) D
 . W " (to start NOW).",!!,"YOU WILL RECEIVE A MAILMAN MESSAGE WHEN TASK #"_ZTSK_" HAS COMPLETED."
 Q
ENQN ; 
 ;Delete field from DD first
 S DIK="^DD(133,",DA=8,DA(1)=133 D ^DIK
 N CASE,DAYS,HOURS,MINS,NEW,OCNT,P,REQ,S0,SR,SRA,SRCREAT,SREXPR,SRF,SRP,STSTART,X,XMDUZ,XMSUB,XMTEXT,XMY,Y,NAME,BP
 D NOW^%DTC S SRSTART=$E(%,1,12),SRCREAT=$E(%,1,7),SREXPR=$$FMADD^XLFDT(SRCREAT,30,0,0,0)
 K ^XTMP("SR")
 S (SRA,OCNT)=0
 F  S SRA=$O(^SRO(133,SRA)) Q:'SRA  S SRP=$P($G(^SRO(133,SRA,0)),"^",9) I SRP]"",SRP?1.N D
 . S SRF=$P($G(^LAB(66,SRP,0)),"^")
 . I SRF]"" S ^SRO(133,SRA,7)=SRF,$P(^SRO(133,SRA,0),"^",9)="" Q
 . S ^XTMP("SR",1,SRA)=SRP,OCNT=OCNT+1,BP(1,SRF)=$G(BP(SRP))+1
 S CASE=0
 F  S CASE=$O(^SRF(CASE)) Q:'CASE  D
 . S A=$G(^SRF(CASE,11,0)) Q:A=""  S S0=0
 . F  S S0=$O(^SRF(CASE,11,S0)) Q:'S0  D
 .. S REQ=$P($G(^SRF(CASE,11,S0,0)),"^") Q:REQ=""  Q:REQ'?1.N
 .. I '$D(^LAB(66,REQ,0)) D SET Q
 .. S NEW=$P(^LAB(66,REQ,0),"^") I NEW="" D SET Q
 .. S $P(^SRF(CASE,11,S0,0),"^")=NEW
 I $D(^XTMP("SR")) S ^XTMP("SR",0)=SREXPR_"^"_SRCREAT
 D SENDMSG
 S ZTREQ="@"
 Q
SET S A=$G(^SRF(CASE,0)),^XTMP("SR",2,CASE)=$P(A,"^")_"^"_$P(A,"^",9)_"^"_REQ,OCNT=OCNT+1,BP(2,REQ)=$G(BP(2,REQ))+1
 Q
SENDMSG ;Send mail message when check is complete.
 K SR,XMY S XMDUZ="SURGERY,CONVERSION",XMSUB="SURGERY POINTER CONVERSION COMPLETED",XMTEXT="SR(",XMY(DUZ)="" D NOW^%DTC S Y=% X ^DD("DD")
 S SR(1,0)="  The conversion of blood component information in Surgery V.3.0",SR(2,0)="completed as of "_Y_"."
 S X=$$FMDIFF^XLFDT(%,SRSTART,3) S:$L(X," ")>1 DAYS=+$P(X," "),X=$P(X," ",2) S HOURS=+$P(X,":"),MINS=+$P(X,":",2)
 S SR(3,0)=" ",SR(4,0)="This process completed in "_$S($G(DAYS):DAYS_" day"_$E("s",DAYS'=1)_", ",1:"")_HOURS_" hour"_$E("s",HOURS'=1)_" and "_MINS_" minute"_$E("s",MINS'=1)_"."
 S SR(5,0)=OCNT_" entries were found that could not be converted."
 I OCNT>0 D
 . S SR(6,0)=" ",SR(7,0)="These entries could not be converted because the associated"
 . S SR(8,0)="entry in the BLOOD PRODUCT file no longer exists."
 . S SR(9,0)=" ",SR(10,0)="The list of site parameters that could not be converted"
 . S SR(11,0)="      is contained in ^XTMP(""SR"",1",SR(12,0)=" "
 . S SRP=12,P="" F  S P=$O(BP(1,P)) Q:P=""  D
 .. S SRP=SRP+1,SR(SRP,0)="      "_BP(1,P)_$S(BP(1,P)=1:" entry",1:" entries")_" pointed to blood product "_P
 . S SRP=SRP+1,SR(SRP,0)=" ",SRP=SRP+1,SR(SRP,0)="The list of cases that could not be converted"
 . S SRP=SRP+1,SR(SRP,0)="      is contained in ^XTMP(""SR"",2",SRP=SRP+1,SR(SRP,0)=" "
 . S P="" F  S P=$O(BP(2,P)) Q:P=""  D
 .. S SRP=SRP+1,SR(SRP,0)="      "_BP(2,P)_$S(BP(2,P)=1:" entry",1:" entries")_" pointed to blood product "_P
 . S SRP=SRP+1,SR(SRP,0)=" ",SRP=SRP+1,SR(SRP,0)="In coordination with your Lab and Surgery ADPACs, determine"
 . S SRP=SRP+1,SR(SRP,0)="if you have the information required to rebuild these blood"
 . S SRP=SRP+1,SR(SRP,0)="products. If so, you may rebuild them and re-run the conversion."
 . S SRP=SRP+1,SR(SRP,0)="To re-run the conversion, type:"
 . S SRP=SRP+1,SR(SRP,0)=" D ENNV^SR00109 at the programmer's prompt."
 D ^XMD
 Q
