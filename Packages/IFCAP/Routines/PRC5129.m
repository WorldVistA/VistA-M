PRC5129 ;(WOIFO)/SU-Extract IFCAP user counts ; 04/09/2001  03:30 PM
V ;;5.1;IFCAP;**29**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
POST ;
 ;
 NEW I,J,K,IE,FCP,DONE,STA,ESTA,IVP,LOA,LC,FDT,MGR,XMSUB,XMTEXT,XMY
 NEW DIFROM
 S U="^",DT=$$DT^XLFDT
 K ^TMP("PRC5129")
FCP ;
 ;     Control Point
 S I=0 F  S I=$O(^PRC(420,"C",I)) Q:'I  D
 . S STA=0 F  S STA=$O(^PRC(420,"C",I,STA)) Q:'STA  D
 .. S FCP=0,K=4,DONE=0
 .. F  S FCP=$O(^PRC(420,"C",I,STA,FCP)) Q:'FCP!DONE  D
 ... ;  skip Inactive Fund
 ... I $P(^PRC(420,STA,1,FCP,0),"^",19) Q
 ... ;  get control point Level Of Access
 ... S LOA=$P($G(^PRC(420,STA,1,FCP,1,I,0)),"^",2)
 ... I LOA>3!'LOA Q
 ... I K>LOA S K=LOA   ; K only keep the highest level of access
 ... I LOA=1 S DONE=1   ; Stop here if find official level
 .. I K'=4 D SETP(K)
 ;
INV ;
 ;      Inventory
 ;
 ;   sort user by station # through "AD",DUZ x-ref
 S I=0 F  S I=$O(^PRCP(445,"AD",I)) Q:'I  D
 . S IVP=0 K MGR              ;get inv pointer
 . F  S IVP=$O(^PRCP(445,"AD",I,IVP)) Q:'IVP  D
 .. S J=$P(^PRCP(445,IVP,0),"^",3)                ; get inv type
 .. S STA=+^PRCP(445,IVP,0)                       ; get station number
 .. S ^TMP("PRC5129",$J,"INV",STA,I,J)=""
 ;
 S STA=0 F  S STA=$O(^TMP("PRC5129",$J,"INV",STA)) Q:'STA  D
 . S I=0 F  S I=$O(^TMP("PRC5129",$J,"INV",STA,I)) Q:'I  D
 .. S J="" F  S J=$O(^TMP("PRC5129",$J,"INV",STA,I,J)) Q:J=""  D
 ... I J="W" D                                  ; Warehouse
 .... D SETP(7)                                 ;   user
 .... I $D(^XUSEC("PRCPW MGRKEY",I)) D SETP(4)  ;   manager
 ... I J="P" D                                  ; Primary
 .... D SETP(8)                                 ;   user
 .... I $D(^XUSEC("PRCP MGRKEY",I)) D SETP(5)   ;   manager
 ... I J="S" D                                  ; Secondary
 .... D SETP(9)                                 ;   user
 .... I $D(^XUSEC("PRCP2 MGRKEY",I)) D SETP(6)  ;   manager
 ;
PRCH ;
 ;    purchasing
 ;
 ;  get IFCAP primary station number   (assume only one primary)
 S STA=+$O(^PRC(411,"AC","Y",0))
 ;
 ;  get default station for Engineering (piece 17, ^XTV(8989.3,1,"XUS"))
 S ESTA=$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",99)
 ;
 S I=0 F  S I=$O(^VA(200,I)) Q:'I  D
 . ;  Purchasing
 . S J=+$G(^VA(200,I,400))
 . I J,J<5 D
 .. I J=1 D SETP(13)           ; Warehouse Employee
 .. I J=2 D SETP(10)           ; PPM Accountable Officer
 .. I J=3 D SETP(11)           ; Purchasing Agent
 .. I J=4 D SETP(12)           ; Supply Manager
 . ;   Engineering
 . ;                Logic copied from ENZACC2 by Scott Baumann
 . S K=0 I $$ACCESS^XQCHK(I,"ENINVNEW")>0 D SETE(1) S K=1
 . I 'K,$$ACCESS^XQCHK(I,"ENINVINV")>0 D SETE(2) S K=1
 . I $$ACCESS^XQCHK(I,"ENSPROOM")>0 D SETE(4) S K=1
 . I $$ACCESS^XQCHK(I,"ENWONEW")>0 D SETE(3) S $E(K,2)=1
 . I '$E(K,2),$$ACCESS^XQCHK(I,"ENWOCLOSE")>0 D SETE(3) S $E(K,2)=1
 . I +K D SETE(5)
 .  ; if none of the first 5 case is true or
 .  ; case SETE(3) is not true but other case is true
 . I ($E(K,2)'=1&+K)!'K I $$ACCESS^XQCHK(I,"ENWONEW-WARD")>0 D SETE(6)
 . ; count Accounting Staff 1 time only per station
 . I $D(^XUSEC("PRCFA SUPERVISOR",I)) D SETP(15) Q
 . I $D(^XUSEC("PRCFA TRANSMIT",I)) D SETP(15) Q
 . I $D(^XUSEC("PRCFA VENDOR EDIT",I)) D SETP(15) Q
 . I $D(^XUSEC("PRCFA PURGE CODE SHEETS",I)) D SETP(15) Q
 ;
 ;
BUDGET ;
 S STA=0 F  S STA=$O(^PRC(420,STA)) Q:'STA  D
 . S I=0 F  S I=$O(^PRC(420,STA,2,I)) Q:'I  D SETP(14)
 ;
ACNT ;
 ;   Accounting
 S STA=0 F  S STA=$O(^PRC(411,"AE",1,STA)) Q:'STA!(STA>999)  D
 . S I=0 F  S I=$O(^PRC(411,STA,6,I)) Q:'I  D SETP(15)
 ;
PCARD ;
 ;   Purchase Card
 S J=0 F  S J=$O(^PRC(440.5,J)) Q:'J  S K=$G(^(J,0)) D 
 . S STA=$P($G(^PRC(440.5,J,2)),"^",3) Q:'STA
 . I $P(^PRC(440.5,J,2),"^",2)="Y" Q    ; if Inactive flag set to 'Y'
 . S I=$P(K,"^",8) I I D SETP(16)       ; Purchase card holder
 . S I=$P(K,"^",9) I I D SETP(18)       ; P card approving officer
 . S I=$P(K,"^",10) I I D SETP(19)      ; Alt. P card approving officer
 . ;   Get surrogate user which is not the card holder
 . S I=0 F  S I=$O(^PRC(440.5,J,1,I)) Q:'I  D:$P(K,"^",8)'=I SETP(17)
 ;
 D RPT
EXIT ;
 K ^TMP("PRC5129")
 Q
 ;
RPT ;
 ;   Generate report from ^TMP("PRC5129")
 ;     1. count from ^TMP
 F IE="I","E" D
 . S STA=0 F  S STA=$O(^TMP("PRC5129",$J,IE,STA)) Q:'STA  D
 .. K FDT S (FDT,I)=0
 .. F  S I=$O(^TMP("PRC5129",$J,IE,STA,I)) Q:'I  S J=$G(^(I)) D
 ... F K=1:1:$S(IE="I":19,1:6) I $P(J,"^",K) S FDT(K)=$G(FDT(K))+1
 ... S:IE="I" FDT=FDT+1
 .. F K=1:1:$S(IE="I":19,1:6) D
 ... S $P(^TMP("PRC5129",$J,IE,STA),"^",K)=$G(FDT(K))
 .. I IE="I" S $P(^TMP("PRC5129",$J,"I",STA),"^",20)=FDT
 ;     2. format report using local array
 K FDT S LC=1,FDT(LC)="$REPORT"
 F IE="I","E" D
 . S STA=0 F  S STA=$O(^TMP("PRC5129",$J,IE,STA)) Q:'STA  S I=$G(^(STA)) D
 .. I LC>1 F J=1:1:3 S LC=LC+1,FDT(LC)=""
 .. S LC=LC+1,FDT(LC)="   "_$S(IE="I":"IFCAP",1:"ENGINEERING")_" USERS BY ROLE"
 .. S LC=LC+1,FDT(LC)="   STATION #: "_STA
 .. S LC=LC+1,FDT(LC)="       Role"_$J("Count",38)
 .. F K=1:1:$S(IE="I":19,1:4) D 
 ... S:IE="I" J=$P($T(FORMAT+K),";;",2)
 ... S:IE="E" J=$P($T(ENGFMT+K),";;",2)
 ... S LC=LC+1,FDT(LC)="       "_J_$J(+$P(I,"^",K),42-$L(J))
 .. S LC=LC+1,J="Total Unique "_$S(IE="I":"IFCAP",1:"ENGINEERING")_" Users"
 .. S FDT(LC)="   "_J_$J(+$P(I,"^",$S(IE="I":20,1:5)),46-$L(J))
 .. I IE="E" D
 ... S LC=LC+1,J="Electronic Work Order Requesters"
 ... S FDT(LC)="   "_J_$J(+$P(I,"^",6),46-$L(J))
 ;
 ;   $DATA
 ;    IFCAP data
 S LC=LC+1,FDT(LC)="$DATA(IFCAP)"
 S STA=0 F  S STA=$O(^TMP("PRC5129",$J,"I",STA)) Q:'STA  S J=^(STA) D
 . S K="" F I=1:1:19 S K=K_+$P(J,"^",I)_","
 . S LC=LC+1,FDT(LC)="Station"_STA_","_K_+$P(J,"^",20)
 ;    Engineering data
 S LC=LC+1,FDT(LC)="$DATA(ENGINEERING)"
 S STA=$O(^TMP("PRC5129",$J,"E",0)) I STA  S J=^(STA) D
 . S K="" F I=1:1:5 S K=K_+$P(J,"^",I)_","
 . S LC=LC+1,FDT(LC)="Station"_STA_","_K_+$P(J,"^",6)
 S LC=LC+1,FDT(LC)="$END"
 ;
MAIL ;
 ;   get mail group member
 F I=1:1 S J=$T(MAILGRP+I),J=$P(J,";;",2) Q:J=""  S XMY(J)=""
 ;   mail to user who install patch 29
 I $G(DUZ),$D(^VA(200,DUZ)) S XMY(DUZ)=""
 S STA=$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",.01)
 I STA="" S STA="UNKNOWN"
 S XMSUB="Extract IFCAP Users by Role ("_STA_")"
 S XMTEXT="FDT("
 D ^XMD
 Q
MAILGRP ;
 ;;G.coreFLS VistA Stats@DOMAIN.EXT
 ;;
 Q
FORMAT ;
 ;;FCP Official
 ;;FCP Clerk
 ;;FCP Requestor
 ;;Warehouse Inv Manager
 ;;Primary Inv Manager
 ;;Secondary Inv Manager
 ;;Warehouse Inv User
 ;;Primary Inv User
 ;;Secondary Inv User
 ;;PPM Accountable Officer
 ;;Purchasing Agent
 ;;Supply Manager
 ;;Warehouse Employee
 ;;Budget Releasing Official
 ;;Accounting Staff
 ;;Purchase Card Holder
 ;;Purchase Card Surrogate
 ;;Purchase Card Approving Official
 ;;Alt PC Approving Official
 ;;
ENGFMT ;
 ;;Asset Update
 ;;Asset View Only
 ;;Engr. Work Order
 ;;Update Location
 ;;
SETP(PC) ;
 ; set value into ^TMP,    STA -- station number,    I -- DUZ
 ;   If termination date is smaller than today's date
 I $P($G(^VA(200,I,0)),"^",11),DT>$P(^(0),"^",11) Q
 I '$P($G(^TMP("PRC5129",$J,"I",STA,I)),"^",PC) S $P(^(I),"^",PC)=1
 Q
 ;
SETE(PC) ;
 ; set value into ^TMP,    ESTA -- engineer station number,    I -- DUZ
 ;   If termination date is smaller than today's date
 I $P($G(^VA(200,I,0)),"^",11),DT>$P(^(0),"^",11) Q
 I '$P($G(^TMP("PRC5129",$J,"E",ESTA,I)),"^",PC) S $P(^(I),"^",PC)=1
 Q
