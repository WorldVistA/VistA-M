YSPP1A ;ALB/ASF,ALB/DAK-PRINT ELIGIBLITY DATA ; 2/15/89  09:30 ;
 ;;5.01;MENTAL HEALTH;**37**;Dec 30, 1994
 ;
 S YSFHDR="Disability, Financial Data <<section 3>>" D ENHD^YSFORM
ENCE ; Called indirectly from YSCEN31
 ;
 I $P(A(.15),U,2)?7N W !?20,"PATIENT LISTED AS INELIGIBLE",$C(7,7)
DIS ;
 W !,"    DISABILITY: " S I=0 F  S I=$O(^DPT(YSDFN,.372,I)) Q:'I  S I1=^(I,0),I2=$P($G(^DIC(31,+I1,0)),U) W:$X+$L(I2)>71 !?17 W I2," ",$J($P(I1,U,2),2,1)_"%",$S(+$P(I1,U,3):"-S",1:""),",  "
MON ;
 W !!,"MONETARY BEN:" W:+A(.362) " A&A: $",$J(A(.362),3,2)," " W:+$P(A(.362),U,2) " HB: $",$J($P(A(.362),U,2),3,2)," " W:+$P(A(.362),U,3) " SS: $",$J($P(A(.362),U,3),3,2)," "
 W:+$P(A(.362),U,5) "  MILT RETIREMENT: $",$J($P(A(.362),U,5),3,2)," " W:$X>60 !?15 W:+$P(A(.3),U,3) "  MILT. DIS: $",$J($P(A(.3),U,3),3,2)," " W:$X>60 !?15 W:+$P(A(.362),U,4) "  VA PENSION: $",$J($P(A(.362),U,4),3,2)," "
 W:$X>60 !?15 W:+$P(A(.362),U,6) "  GI INSUR: $",$J($P(A(.362),U,6),3,2) W:$X>60 !?15 W:+$P(A(.362),U,7) "  SS INSUR: $",$J($P(A(.362),U,7),3,2)
 W:$X>60 !?15 W:+$P(A(.362),U,8) "  OTH RETIRE: $",$J($P(A(.362),U,8),3,2) W:$X>48&(+$P(A(.362),U,9)) !?15 W:+$P(A(.362),U,9) "  OTH PERSONAL INCOME: $",$J($P(A(.362),U,9),3,2)
INSU ;
 W !!,"INSURANCE TYPE",?30,"NUMBER",?45,"GROUP #",?55,"EXPIR DATE",! F I=1:1:65 W "="
 S I=0 F  S I=$O(^DPT(DA,.312,I)) Q:'I  S L=^(I,0),D=$P(L,U,4) W !,$E($P($G(^DIC(36,+L,0)),U),1,28),?30,$P(L,U,2),?45,$P(L,U,3) W:D?7N ?55,$$FMTE^XLFDT(D,"5ZD")
 S L=$P(A(.31),U,9) W !!,"ABLE TO DEFRAY EXP: ",$S(L="Y":"YES",L="N":"NO",L="D":"DOES NOT APPLY",1:"")
 S L=$P(A(.31),U,10) W ?40,"PAY FOR TRAVEL: ",$S(L="Y":"YES",L="N":"NO",L="D":"DOES NOT APPLY",1:""),!
EN ;
 F I=.15,.36,.361,"INE" S A(I)="" S:$D(^DPT(DA,I)) A(I)=^(I)
 W !," ELIGIB CODE: " W:$D(^DIC(8,+A(.36),0)) $P(^(0),U) S I=$P(A(.361),U) W ?45,"STATUS: ",$S(I="V":"VERIFIED",I="P":"PEND VER",I="R":"PEND RE-VER",1:"")
 S I=$P(A(.361),U,2) W ?65,"DATE: " W:I>0 $$FMTE^XLFDT(I,"5ZD") S I=$P(A(.361),U,4) W !,"  INTER RESP DT: " W:I>0 $$FMTE^XLFDT(I,"5ZD") W ?40,"METH OF VER: ",$P(A(.361),U,5)
 Q:$D(YSNOFORM)  D WAIT1^YSUTL:'YST,ENFT^YSFORM:YST Q
