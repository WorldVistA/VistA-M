DGRPE ;ALB/MRL,LBD,BRM,TMK,BAJ - REGISTRATIONS EDITS ; 09/12/05 1:27pm
 ;;5.3;Registration;**32,114,139,169,175,247,190,343,397,342,454,415,489,506,244,547,522,528,555,508,451,626,638,624,677,672,702,689,735,688**;Aug 13, 1993;Build 29
 ;
 ;DGDR contains a string of edits; edit=screen*10+item #
 ;
 ;line tag screen*10+item*1000 = continuation line
 ;
 I DGRPS=1,DGDR["101," D CEDITS^DGRPECE(DFN)
 I DGRPS=8 D ^DGRPEIS,Q Q  ; family demographic edit...not conventional!!  :)
 I DGRPS=9 D EDIT9^DGRPEIS2,Q Q  ; income screening data ($$$)
 I DGRPS=5,DGDR["501," D
 .I $G(DGPRFLG) D PREG^IBCNBME(DFN) Q
 .D REG^IBCNBME(DFN)
 .Q
 N QUIT S QUIT=0
 I DGRPS=6,$S(DGDR["602,"!(DGDR["603,"):1,1:0) D  I QUIT D Q Q  ;Screen 6 subscreens
 . I DGDR["601," D  Q:QUIT
 .. D SETDR("601,",.DR)
 .. S (DA,Y)=DFN,DIE="^DPT("
 .. D ^DIE I $D(Y) S QUIT=1
 .. S DGDR=$P(DGDR,"601,",1)_$P(DGDR,"601,",2,999)
 . I DGDR["602," D EN^DGRP6CL(DFN,.QUIT)  Q:QUIT  ; Conflicts
 . I DGDR["603," D EN^DGRP6EF(DFN,.QUIT)  Q:QUIT  ; Exposures
 ;-- Tricare screen #15
 I DGRPS=15 D EDIT^DGRP15,Q Q
 ;
 N DGPH,DGPHFLG
 K DR S (DA,Y)=DFN,DIE="^DPT(",DR="",DGDRS="DR",DGCT=0
 G ^DGRPE1:DGRPS>6
 I DGRPS=4 D ^DGRPE4
 D SETDR(DGDR,.DR)
 S (DA,Y)=DFN,DIE="^DPT("
 D ^DIE
 ;check for Combat Vet status
 I $G(DGCVFLG)=1,($P($$CVEDT^DGCV(DFN),U,2)']"") D
 . W !!,"**NOTE-Change(s) made in this session deleted the veteran's Combat Vet status!"
 . S DIR(0)="EA" D ^DIR K DIR
 I $G(DGPHFLG)>0 D EDITPH1^DGRPLE()
Q K DA,DIE,DR,DGCT,DGCVFLG,DGDR,DGDRD,DGDRS,DGRPADI,I,J,J1,DGCOMLOC,DIPA
 Q
 ;
SETDR(DGDR,DR) ; Set up DR string(s) for edit groups selected
 N DGCT,DGDRS,J1,J2
 K DR S DR="",DGDRS="DR",DGCT=0
 F I=1:1 S J=$P(DGDR,",",I) Q:J=""  S J1=J D:$T(@J1)
 . S DGDRD=$P($T(@J1),";;",2) D S
 . N J2
 . F J2=0:1 S J1=J*1000+J2 Q:'$T(@J1)  S DGDRD=$P($T(@J1),";;",2) D S
 Q
 ;
S I $L(@DGDRS)+$L(DGDRD)<241 S @DGDRS=@DGDRS_DGDRD Q
 S DGCT=DGCT+1,DGDRS="DR(1,2,"_DGCT_")",@DGDRS=DGDRD Q
 Q
 ;
SETFLDS(DGDR) ; Set up fields to edit
 Q
 ;
101 ;;
102 ;;1;
103 ;;.091;
104 ;;N FLG S (FLG(1),FLG(2))=1 D EN^DGREGAED(DFN,.FLG);
105 ;;.12105//NO;S:X="N" Y="@15" S:X="Y" DIE("NO^")="";.1217;I X']"" W !?4,$C(7),"But I need a Start Date for this Temporary Address." S Y=.12105;.1218;
105000 ;;N RET S RET=1 D EN^DGREGTED(DFN,"TEMP",.RET) S:'RET Y=.12105;@15;K DIE("NO^");
109 ;;N FLG S (FLG(1),FLG(2))=1 D EN^DGREGAED(DFN,.FLG);.02;D DR109^DGRPE;6;2;K DR(2,2.02),DR(2,2.06);.05;.08;K DIE("NO^");
111 ;;.14105//NO;S:X="N" Y="@111" S:X="Y" DIE("NO^")="";.1417;I X']"" W !?4,$C(7),"But I need a Start Date." S Y=.14105;.1418;D DR111^DGRPE;.141;I '$P($$CAACT^DGRPCADD(DFN),U,2) W !?4,"But I need at least one active category." S Y=.14105;
111000 ;;K DR(2,2.141);N RET S RET=1 D EN^DGREGTED(DFN,"CONF",.RET) S:'RET Y=.14105;@111;K DIE("NO^");
112 ;;.134;.135;.133
201 ;;.05;.08;.092;.093;.2401:.2403;57.4//NOT APPLICABLE;
202 ;;1010.15//NO;S:X'="Y" Y="@22";S DIE("NO^")="";1010.152;I X']"" W !?4,*7,"But I need to know where you were treated most recently." S Y=1010.15;1010.151;1010.154;S:X']"" Y="@22";1010.153;@22;K DIE("NO^");
203 ;;D DR203^DGRPE;6ETHNICITY;2RACE;K DR(2,2.02),DR(2,2.06);
205 ;;.181;
301 ;;.211;S:X']"" Y="@31";.212;D DR301^DGRPE S:DG4=1 Y=.213;.2125//NO;I X="Y" S DGADD=".21" D AD^DGRPE S Y=.21011;.213;K DG4;S:X']"" Y=.216;.214;S:X']"" Y=.216;.215:.217;.2207;.219;.21011;@31;
302 ;;.2191;S:X']"" Y="@32";.2192;D DR301^DGRPE S:DG4=1 Y=.2193;.21925//NO;I X="Y" S DGADD=".211" D AD^DGRPE S Y=.211011;
302000 ;;.2193;S:X']"" Y=.2196;.2194;S:X']"" Y=.2196;.2195:.2197;.2203;.2199;.211011;@32;
303 ;;N DGX1,DGX2;I '$L($P($G(^DPT(DFN,.21)),U)) S Y="@33";.3305//NO;I X="Y" S Y="@34",DGX1=1 S:$D(^DPT(DFN,.22)) $P(^(.22),U,1)=$P(^(.22),U,7);@33;.331;S:X']"" DGX1=2,Y="@34";.332;@34;
303000 ;;S:$G(DGX1) Y="@341";.333;S:X']"" Y=.336;.334;S:X']"" Y=.336;.335:.337;.2201;.339;.33011;S DGX1=2;@341;
303001 ;;S:$G(DGX1)=2 Y="@35";S DGX2=$G(^DPT(DA,.21));.331///^S X=$P(DGX2,U);.332///^S X=$P(DGX2,U,2);.333////^S X=$P(DGX2,U,3);.334///^S X=$P(DGX2,U,4);@35;
303002 ;;S:$G(DGX1)=2 Y="@351";.335///^S X=$P(DGX2,U,5);.336///^S X=$P(DGX2,U,6);.337///^S X=$P(DGX2,U,7);.338///^S X=$P(DGX2,U,8);.339///^S X=$P(DGX2,U,9);.33011///^S X=$P(DGX2,U,11);@351;K DGX1,DGX2;
304 ;;.3311;S:X']"" Y="@36";.3312;.3313;S:X']"" Y=.3316;.3314;S:X']"" Y=.3316;.3315:.3317;.2204;.3319;.331011;@36;        
305 ;;N DGX1,DGX2;I '$L($P($G(^DPT(DFN,.21)),U)) S Y="@37";.3405//NO;I X="Y" S DGX1=1,Y="@371" S:$D(^DPT(DFN,.22)) $P(^(.22),U,2)=$P(^(.22),U,7);@37;.341;S:X']"" DGX1=2,Y="@371";.342;@371;
305000 ;;S:$G(DGX1) Y="@38";.343;S:X']"" Y=.346;.344;S:X']"" Y=.346;.345:.347;.2202;.349;.34011;S DGX1=2;@38;
305001 ;;S:$G(DGX1)=2 Y="@381";S DGX2=$G(^DPT(DA,.21));.341///^S X=$P(DGX2,U);.342///^S X=$P(DGX2,U,2);.343///^S X=$P(DGX2,U,3);.344///^S X=$P(DGX2,U,4);@381
305002 ;;S:$G(DGX1)=2 Y="@39";.345///^S X=$P(DGX2,U,5);.346///^S X=$P(DGX2,U,6);.347///^S X=$P(DGX2,U,7);.348///^S X=$P(DGX2,U,8);.349///^S X=$P(DGX2,U,9);.34011///^S X=$P(DGX2,U,11);@39;K DGX1,DGX2;
401 ;;.01;.31115;S:($S(X']"":1,X=3:1,X=9:1,1:0)) Y="@41" S:(X'=5) Y=.3111;.31116;.3111;S:X']"" Y="@41";.3113;S:X']"" Y=.3116;.3114;S:X']"" Y=.3116;.3115:.3117;.2205;.3119;@41;
402 ;;.2514;.2515;S:($S(X']"":1,X=3:1,X=9:1,1:0)) Y="@42" S:(X'=5) Y=.251;.2516;.251;S:X']"" Y="@42";.252;S:X']"" Y=.255;.253;S:X']"" Y=.255;.254:.256;.2206;.258;@42;
501 ;;
502 ;;.381;.382///NOW;
503 ;;.383;
601 ;;@60101;D SET32^DGRPE(DA,.DIPA,1);.325;S DIPA("X1")=X S:X="" Y="@60199" I X'="" S:$$FV^DGRPMS(X)'=1 Y="@60111";.3214;I X="" D PRF^DGRPE S Y="@60101";S Y="@6011";
601000 ;;@60111;D:DIPA("X1")'="" WARN32^DGRPE(DIPA("X1"),.DIPA,1,.Y);.32911;@6011;.328;.326;.327;.324;.3285//NO;S:X'="Y" Y="@60199";
601001 ;;@60102;D SET32^DGRPE(DA,.DIPA,2);.3291;S DIPA("X2")=X S:X="" Y="@60199" I X'="" S:$$FV^DGRPMS(X)'=1 Y="@60112";.3214;I X="" D PRF^DGRPE S Y="@60102";S Y="@6012";
601002 ;;@60112;D:DIPA("X2")'="" WARN32^DGRPE(DIPA("X2"),.DIPA,2,.Y);.32912;@6012;.3294;.3292;.3293;.329;.32945//NO;S:X'="Y" Y="@60199";
601003 ;;@60103;D SET32^DGRPE(DA,.DIPA,3);.3296;S DIPA("X3")=X S:X="" Y="@60199" I X'="" S:$$FV^DGRPMS(X)'=1 Y="@60113";.3214;I X="" D PRF^DGRPE S Y="@60103";S Y="@6013";
601004 ;;@60113;D:DIPA("X3")'="" WARN32^DGRPE(DIPA("X3"),.DIPA,3,.Y);.32913;@6013;.3299;.3297;.3298;.3295;@60199;
602 ;;Q;
603 ;;Q;
604 ;;.525//NO;S:X'="Y" Y="@62";.526:.528;@62;
605 ;;.5291//NO;S:X'="Y" Y="@63";.5292:.5294;@63;
606 ;;I $P($G(^DPT(DFN,.361)),U,3)="H" S Y="@6131";.3602//NO;.3603//NO;S Y="@6132";@6131;.3602;.3603;@6132;
607 ;;.368//NO;.369//NO;I $S('$D(^DPT(DA,.36)):1,$P(^(.36),U,8)="Y"!($P(^(.36),U,9)="Y"):0,1:1) S Y="@614";.37;@614;
608 ;;S DGPHFLG=0;.531;S:X'="Y" DGX=X,Y="@616";.532///^S X="PENDING";S Y="@6161";@616;S:DGX'="N" Y="@6162";.533///^S X="VAMC";@6161;S DGPHFLG=1;.535///^S X=$$DIV^DGRPLE();@6162;
AD N DGZ4,DGPC
 S X=$S($D(^DPT(DA,.11)):^(.11),1:""),DGZ4=$P(X,U,12),DGPHONE=$S($D(^(.13)):$P(^(.13),U,1),1:""),Y=$S($D(^(DGADD)):^(DGADD),1:""),^(DGADD)=$P(Y,U,1)_U_$P(Y,U,2)_U_$P(X,U,1,6)_U_DGPHONE_U_$P(Y,U,10)
 I DGZ4 S DGPC=$S((DGADD=.33):1,(DGADD=.34):2,(DGADD=.211):3,(DGADD=.331):4,(DGADD=.311):5,(DGADD=.25):6,(DGADD=.21):7,1:0) S:DGPC $P(^DPT(DFN,.22),U,DGPC)=DGZ4
 K DGADD,DGPHONE Q
DR109 ;Drop through (use same logic as DR203)
DR203 S DR(2,2.02)=".01RACE;I $P($G(^DIC(10.3,+$P($G(^DPT(DA(1),.02,DA,0)),""^"",2),0)),""^"",2)=""S"" S Y=""@2031"";.02;@2031;"
 S DR(2,2.06)=".01ETHNICITY;I $P($G(^DIC(10.3,+$P($G(^DPT(DA(1),.06,DA,0)),""^"",2),0)),""^"",2)=""S"" S Y=""@2032"";.02;@2032;"
 Q
DR111 ;Set DR string for Confidential Address categories
 S DR(2,2.141)=".01;1//YES;"
 Q
DR301 ;set up variables for foreign address
 N DG3,DG33
 S DG4=0
 S DG3=$P($G(^DPT(DFN,.11)),U,10)
 S DG33=$O(^HL(779.004,"B","USA",""))
 I $G(DG3)]"",(DG3'=$G(DG33)) S DG4=1
 Q
PRF ; Write Proof needed for FV
 W !?4,$C(7),"Proof is required for Filipino vet."
 Q
 ;
SET32(DA,DIPA,SEQ) ; Extract the .32 node from patient file and set DIPA
 ; array with the BOS and component data for the SEQ military service
 ; episode (1-3)
 N I,Q,Z
 K DIPA(32,SEQ)
 S Q=$G(^DPT(DA,.32)),Z=$G(^(.3291))
 S DIPA(32,SEQ)=$P(Q,U,SEQ*5)_U_$P(Z,U,SEQ),DIPA("X"_SEQ)=$P(DIPA(32,SEQ),U)
 Q
 ;
WARN32(X,DIPA,SEQ,Y) ; Warn if the BOS is changed, then the component will
 ; be deleted
 ; Returns Y to skip component if the component should not be asked
 ;   for this branch of service
 N Z
 I '$$CMP(X) S Y="@601"_SEQ
 S Z=$G(DIPA(32,SEQ))
 Q:$S($P(Z,U,2)=""!($P(Z,U)=""):1,1:$P(Z,U)=X)
 ;
 I '$D(DIQUIET) W !!,*7,"** WARNING - BRANCH OF SERVICE WAS CHANGED SO THE COMPONENT WAS DELETED",!
 Q
 ;
CMP(X) ; Function to determine if service component is valid for
 ; branch of service ien in X   0 = invalid  1 = valid  
 ; Component only valid for ARMY/AIR FORCE/MARINES/COAST GUARD/NOAA/USPHS
 Q $S('$G(X):0,X'>5!(X=9)!(X=10):1,1:0)
 ;
