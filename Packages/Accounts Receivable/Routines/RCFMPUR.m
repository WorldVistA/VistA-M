RCFMPUR ;WASH-ISC@ALTOONA,PA/RGY-Purge AR Documents to FMS ;9/28/94  2:09 PM
V ;;4.5;Accounts Receivable;**270**;Mar 20, 1995;Build 25
 ;;Per VHA Directive 2004-038, this routine should not be modified.
EN ;
 NEW %DT,PURDT,DATE
 S X="T-34" D ^%DT S PURDT=Y
 S DATE=0 F  S DATE=$O(^RC(347,"AD",DATE)) Q:DATE>PURDT!'DATE  S DOC=0 F  S DOC=$O(^RC(347,"AD",DATE,DOC)) Q:'DOC  D
   .S STAT=$P($G(^RC(347,DOC,0)),"^",3)
   .I ",0,1,3,"[(","_STAT_",") Q
   .D DEL(DOC)
   .Q
 Q
DEL(DOC) ;Delete an FMS document
 NEW DIK,DA,STA,N0
 I $G(DOC)'?1N.N Q
 S N0=$G(^RC(347,DOC,0))
 I N0="" Q
 ; PRCA*4.5*270  this code was prefacing the Doc ID with a "BD-" even though that already existed in the DOC ID
 ;S STA=$P($G(^RC(347.1,+$P(N0,"^",2),0)),"^",2)_"-"_$P(N0,"^",9)_$E("           ",1,11-$L($P(N0,"^",9)))_$S($P(N0,"^",10)]"":"-"_$P(N0,"^",10),1:"")
 I $E($P(N0,"^",9),1,2)'?2A S STA=$P($G(^RC(347.1,+$P(N0,"^",2),0)),"^",2)_"-"_$P(N0,"^",9)_$E("           ",1,11-$L($P(N0,"^",9)))_$S($P(N0,"^",10)]"":"-"_$P(N0,"^",10),1:"")
 I $E($P(N0,"^",9),1,2)?2A S STA=$P(N0,"^",9)_$E("           ",1,11-$L($P(N0,"^",9)))_$S($P(N0,"^",10)]"":"-"_$P(N0,"^",10),1:"")
 D KILLCS^GECSSDCT(STA)
 S DA=DOC,DIK="^RC(347," D ^DIK
 Q
