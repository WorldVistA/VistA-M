VATRAN ;ALB/MTC - Establish VADATS Transmission Variables ; 5/25/88 @ 12
 ;;5.3;Registration;;Aug 13, 1993
 ;Pass in  VATNAME=name (.01 field) as in File 407.7
 ;Returns  VATERR=null if no error
 ;         VATERR=1 or 2 or 3 can't process (see error messages ERR^VATRAN)
 ;         if VATERR=null, then VAT array is returned as follows:
 ;         VAT(1),VAT(2),...=Receiving User(s),format: 'receiving user"@"domain mail router'
 ;         VAT("F")=MailMan Message Length - Fixed record
 ;         VAT("V")=MailMan Message Length - Variable record
 K VAT,VATR S VATERR=1 G ERR:'$D(VATNAME) S VATN=$S('$D(^VAT(407.7,"B",VATNAME)):0,1:$O(^VAT(407.7,"B",VATNAME,0))) G ERR:'VATN S W=$S($D(^VAT(407.7,+VATN,0)):^(0),1:0) G ERR:W']"" S VAT("F")=$P(W,U,2),VAT("V")=$P(W,U,3),VATERR=2
 I $D(^VAT(407.7,VATN,"R")) F V=0:0 S V=$O(^VAT(407.7,VATN,"R",V)) Q:'V  I $P(^(V,0),"^",3) S W=^(0),VATR(V)=$P(W,"^")_"^"_$P(W,"^",2)
 G ERR:'$D(VATR) S Q=0
 F V=0:0 S V=$O(VATR(V)) Q:'V  S W=$S($D(^DIC(4.2,+$P(VATR(V),U,2),0)):^(0),1:"") I W]"" S VAT(V)=$P(VATR(V),U)_"@"_$P(W,U) I $P(W,U)["Q-" S Q=Q+1
 I Q>1 S VATERR=4 G ERR
 S VATERR=""
Q K VATN,VATR,V,W Q
ERR S V=$P($T(@VATERR),";;",2) W !,V,*7 K VAT G Q
1 ;;No such Transmission Router Name in TRANSMISSION ROUTERS File
2 ;;Transmission is turned OFF for receiving domains in TRANSMISSION ROUTERS file
3 ;;You do not hold the key to transmit to the domain (obsolete error)
4 ;;Can not transmit to 2 different QUEUEs in Austin, correct the Transmission file
