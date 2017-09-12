IBDY340 ;ALB/DHH - POST INSTALL FOR PATCH IBD*3*40 ; OCT 1, 1999
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**40**;APR 24, 1997
 ;
 D ASK
 ;
 Q
 ;
ASK ;-- Change PX INPUT HEALTH FACTORS to check for inactive 
 ;   in the package interface file
 ;
 D MES^XPDUTL(">>> Updating PX INPUT HEALTH FACTORS Package Interface.")
 N I,J,X
 S I=0
 F  S I=$O(^IBE(357.6,"B",$E("PX INPUT HEALTH FACTORS",1,30),I)) Q:'I  D
 .I $P($G(^IBE(357.6,I,0)),"^")="PX INPUT HEALTH FACTORS" D
 ..S ^IBE(357.6,I,18)="S IBDF(""OTHER"")=""9999999.64^I '$P(^(0),U,10),$P(^(0),U,10)=""""F"""",'$P(^(0),U,11)"" D LIST^IBDFDE2(.IBDSEL,.IBDF,""Health Factors"")"
 Q
