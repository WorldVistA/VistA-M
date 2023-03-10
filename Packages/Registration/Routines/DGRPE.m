DGRPE ;ALB/MRL,LBD,BRM,TMK,BAJ,PWC,JAM,JAM,JAM,LEG,ARF - REGISTRATIONS EDITS ;23 May 2017  1:51 PM
 ;;5.3;Registration;**32,114,139,169,175,247,190,343,397,342,454,415,489,506,244,547,522,528,555,508,451,626,638,624,677,672,702,689,735,688,797,842,865,871,887,941,985,997,1014,1040,1044,1056,1067,1064**;Aug 13, 1993;Build 41
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
 I DGRPS=6,$S(DGDR["601,"!(DGDR["602,")!(DGDR["603,"):1,1:0) D  I QUIT D Q Q  ;Screen 6 subscreens
 .;Use new ListMan screen for Military Service Episodes (DG*5.3*797)
 . I DGDR["601," D EN^DGRP61(DFN)   ; MSEs
 . ; D SETDR("601,",.DR)
 . ; S (DA,Y)=DFN,DIE="^DPT("
 . ; D ^DIE I $D(Y) S QUIT=1
 . ; S DGDR=$P(DGDR,"601,",1)_$P(DGDR,"601,",2,999)
 . I DGDR["602," D EN^DGRP6CL(DFN,.QUIT)  Q:QUIT  ; Conflicts
 . I DGDR["603," D EN^DGRP6EF(DFN,.QUIT)  Q:QUIT  ; Exposures
 I DGRPS=7,(DGDR["702,") D EN^DGRP7CP(DFN,.QUIT) I QUIT D Q Q  ;DG*5.3*842 screen 7 cp subscreen
 I DGRPS=11,(DGDR["1105,") D EN^DGR111(DFN) ;DG*5.3*871 screen 11 HBP subscreen
 ; DG*5.3*997; jam; Screen 11.5 Caregiver subscreen
 I DGRPS=11.5,(DGDR["1151,") D EN^DGRP11B(DFN)
 I DGRPS=11.5,(DGDR["1152,") D EN^DGRP1152A(DFN) ;LEG; DG*5.3*1014 ; for CCP screen <11.5.2>
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
 ; DG*5.3*1040 - Check for timeout in Screen 1.1
 I DGRPS=1.1,$D(DTOUT),'+$G(DGTMOT) S DGTMOT=1
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
 ;DG*5.3*941 - JAM - Reg Screens 1 and 1.1 new formats - Lines below updated for new field locations
101 ;;
102 ;;1;
103 ;;.091;
104 ;;.134;.135;@21;S X=$$YN1316^DGRPE(DFN);S:(X["N")&($P($G(^DPT(DFN,.13)),"^",3)="") Y="@25";S:(X["N")&($P($G(^DPT(DFN,.13)),"^",3)]"") Y="@24";.133;S:($P($G(^DPT(DFN,.13)),U,16)="Y")&($G(X)="") Y="@21";S Y="@25";@24;.133///@;@25;.1317///NOW;
105 ;;D DR207^DGRPE;7LANGUAGE DATE/TIME;D LANGDEL^DGRPE;
 ;DG*5.3*985; JAM - Group 6 added to screen 1 - Preferred Name
106 ;;.2405;
 ;JAM; DG*5.3*941 - Tag 108 added for QUES^DGRPU1 (ICR 413) to edit the perm address with the home/office phone numbers since patch 941 removed these fields from the Perm Address edit logic
108 ;;N FLG S (FLG(1),FLG(2))=1 D EN^DGREGAED(DFN,.FLG);
109 ;;N FLG S (FLG(1),FLG(2))=1 D EN^DGREGAED(DFN,.FLG);.02;D DR207^DGRPE;7LANGUAGE DATE/TIME;D LANGDEL^DGRPE;D DR109^DGRPE;6;2;K DR(2,2.02),DR(2,2.06);.05;.08;K DIE("NO^");
 ; DG*5.3*1040 - If no timeout from previous field then proceed to next prompt
111 ;;N FLG S (FLG(1),FLG(2))=1 D EN^DGREGRED(DFN,.FLG);D:'+$G(DGTMOT) RESMVQ^DGREGCP1(DFN);
 ;JAM, DG*5.3*941, Home and Office phone numbers not associated with Perm Address - set flg(1)=0 so we don't edit phone numbers with permanent address
 ;CLT, Copy Permanent Mailing Address to Residential Address ;DG*5.3*941
 ; If Perm address is not null, go to update of address. Otherwise give user option to copy residential address to perm.
 ;  and if address is copied quit, otherwise continue with entering in a perm address. 
112 ;;S:$G(^DPT(DFN,.11))'="" Y="@30";D DR11^DGRPE S:$G(^DPT(DFN,.11))'="" Y="@31";
 ; DG*5.3*1040 - If no timeout from previous field then proceed to next prompt
112000 ;;@30;N FLG S FLG(1)=0,FLG(2)=1 D EN^DGREGAED(DFN,.FLG) D:'+$G(DGTMOT) PERMMVQ^DGREGCP1(DFN);@31;
113 ;;.12105TEMP MAILING ADDRESS ACTIVE;S:X="N" Y="@15";S DIE("NO^")="";.1217TEMP MAILING ADDRESS START DATE;.1218TEMP MAILING ADDRESS END DATE;N RET S RET=1 D EN^DGREGTED(DFN,"TEMP",.RET) S:'RET&('+$G(DGTMOT)) Y=.12105;@15;K DIE("NO^");
114 ;;.14105//NO;S:X="N" Y="@111" S:X="Y" DIE("NO^")="";.1417;I X']"" W !?4,$C(7),"But I need a Start Date." S Y=.14105;.1418;D DR111^DGRPE;.141;I '$P($$CAACT^DGRPCADD(DFN),U,2) W !?4,"But I need at least one active category." S Y=.14105;
 ; DG*5.3*1014;jam; add K ^DIE("NO^") after enty of confidential address so if we loop back to beginning, we can exit
 ; DG*5.3*1040 - Add check for variable DGTMOT
114000 ;;K DR(2,2.141);N RET S RET=1 D EN^DGREGTED(DFN,"CONF",.RET) K DIE("NO^") S:'RET&('+$G(DGTMOT)) Y=.14105;@111;K DIE("NO^");
201 ;;.05;.08;.092;.093;.2401:.2403;57.4//NOT APPLICABLE;
202 ;;1010.15//NO;S:X'="Y" Y="@22";S DIE("NO^")="";1010.152;I X']"" W !?4,*7,"But I need to know where you were treated most recently." S Y=1010.15;1010.151;1010.154;S:X']"" Y="@22";1010.153;@22;K DIE("NO^");
203 ;;D DR203^DGRPE;6ETHNICITY;2RACE;K DR(2,2.02),DR(2,2.06);
205 ;;.181;
 ; patch DG*5.3*1064; ARF; added group 6 to the PATIENT DATA, SCREEN <2>
206 ;;D DR206^DGRPE;
 ; patch DG*5.3*985 - NOK - Tags 301 and 302 for Primary and Secondary NOK: phone number no longer copied when copying patient address - phone number entered on its own
 ; patch DG*5.3*997; jam; Tags 301-305 modified to allow for copy or entry of Country/foreign addresses
 ;301 ;;.211;S:X']"" Y="@31";.212;D DR301^DGRPE S:DG4=1 Y=.213;.2125//NO;I X="Y" S DGADD=".21" D AD^DGRPE S Y="@30";.213;K DG4;S:X']"" Y=.216;.214;S:X']"" Y=.216;.215:.217;.2207;@30;.219;.21011;@31;
 ;
 ; DG*5.3*1067; Added new Relationship Type field to replace the free-text Relationship field which will now
 ;  be used to contain any notes. The new and old relationship fields are now entered via DR300^DGRPE 
301 ;;.211;S:X']"" Y="@31";N RET S RET=$$DR300^DGRP3("K",.224,.212) I $G(DGTMOT)=1!('RET) S Y="@31";.2125//NO;I X="Y" S DGADD=".21" D AD^DGRPE S Y="@30";.221//USA;.213;S:X']"" Y=.216;.214;S:X']"" Y=.216;.215;.216;
301000 ;;S DGADD=".21" D DR301^DGRPE S:DG4=1 Y=.222;.217;.2207;S Y="@30";.222;.223;@30;K DG4;.219;.21011;@31;
 ;301 ;;.211;S:X']"" Y="@31";.212;.2125//NO;I X="Y" S DGADD=".21" D AD^DGRPE S Y="@30";.221//USA;.213;S:X']"" Y=.216;.214;S:X']"" Y=.216;.215;.216;S DGADD=".21" D DR301^DGRPE S:DG4=1 Y=.222;.217;.2207;
 ;;S Y="@30";.222;.223;@30;K DG4;.219;.21011;@31;
 ;302 ;;.2191;S:X']"" Y="@32";.2192;D DR301^DGRPE S:DG4=1 Y=.2193;.21925//NO;I X="Y" S DGADD=".211" D AD^DGRPE S Y="@30";
 ;302000 ;;.2193;S:X']"" Y=.2196;.2194;S:X']"" Y=.2196;.2195:.2197;.2203;@30;.2199;.211011;@32;
302 ;;.2191;S:X']"" Y="@32";N RET S RET=$$DR300^DGRP3("K2",.2104,.2192) I $G(DGTMOT)=1!('RET) S Y="@32";.21925//NO;I X="Y" S DGADD=".211" D AD^DGRPE S Y="@301";
302000 ;;.2101//USA;.2193;S:X']"" Y=.2196;.2194;S:X']"" Y=.2196;.2195;.2196;S DGADD=".211" D DR301^DGRPE S:DG4=1 Y=.2102;.2197;.2203;S Y="@301";.2102;.2103;@301;K DG4;.2199;.211011;@32;
 ;
303 ;;N DGX1,DGX2;I '$L($P($G(^DPT(DFN,.21)),U)) S Y="@33";.3305//NO;I X="Y" S Y="@34",DGX1=1 S:$D(^DPT(DFN,.22)) $P(^(.22),U,1)=$P(^(.22),U,7);@33;.331;S:X']"" DGX1=2,Y="@34";
303000 ;;N RET S RET=$$DR300^DGRP3("E",.3309,.332) I $G(DGTMOT)=1!('RET) S Y="@351";@34;
 ;303 ;;N DGX1,DGX2;I '$L($P($G(^DPT(DFN,.21)),U)) S Y="@33";.3305//NO;I X="Y" S Y="@34",DGX1=1 S:$D(^DPT(DFN,.22)) $P(^(.22),U,1)=$P(^(.22),U,7);@33;.331;S:X']"" DGX1=2,Y="@34";.332;@34;
 ;303000 ;;S:$G(DGX1) Y="@341";.333;S:X']"" Y=.336;.334;S:X']"" Y=.336;.335:.337;.2201;.339;.33011;S DGX1=2;@341;
 ;303001 ;;S:$G(DGX1)=2 Y="@35";S DGX2=$G(^DPT(DA,.21));.331///^S X=$P(DGX2,U);.332///^S X=$P(DGX2,U,2);.333////^S X=$P(DGX2,U,3);.334///^S X=$P(DGX2,U,4);@35;
 ;303002 ;;S:$G(DGX1)=2 Y="@351";.335///^S X=$P(DGX2,U,5);.336///^S X=$P(DGX2,U,6);.337///^S X=$P(DGX2,U,7);.338///^S X=$P(DGX2,U,8);.339///^S X=$P(DGX2,U,9);.33011///^S X=$P(DGX2,U,11);@351;K DGX1,DGX2;
 ;
303001 ;;S:$G(DGX1) Y="@341";.3306//USA;.333;S:X']"" Y=.336;.334;S:X']"" Y=.336;.335;.336; S DGADD=".33" D DR301^DGRPE S:DG4=1 Y=.3307;.337;.2201;S Y="@361";.3307;.3308;@361;K DG4;.339;.33011;S DGX1=2;@341;
303002 ;;S:$G(DGX1)=2 Y="@35";S DGX2=$G(^DPT(DA,.21));.331///^S X=$P(DGX2,U);.332///^S X=$P(DGX2,U,2);.333////^S X=$P(DGX2,U,3);.334///^S X=$P(DGX2,U,4);.3306///^S X=$P(DGX2,U,12);.3307///^S X=$P(DGX2,U,13);.3308///^S X=$P(DGX2,U,14);@35;
303003 ;;S:$G(DGX1)=2 Y="@351";.335///^S X=$P(DGX2,U,5);.336///^S X=$P(DGX2,U,6);.337///^S X=$P(DGX2,U,7);.338///^S X=$P(DGX2,U,8);.339///^S X=$P(DGX2,U,9);.33011///^S X=$P(DGX2,U,11);.3309///^S X=$P(DGX2,U,15);@351;K DGX1,DGX2;
 ;
 ;304 ;;.3311;S:X']"" Y="@36";.3312;.3313;S:X']"" Y=.3316;.3314;S:X']"" Y=.3316;.3315:.3317;.2204;.3319;.331011;@36;        
 ;304 ;;.3311;S:X']"" Y="@36";.3312;.331012//USA;.3313;S:X']"" Y=.3316;.3314;S:X']"" Y=.3316;.3315;.3316; S DGADD=".331" D DR301^DGRPE S:DG4=1 Y=.331013;.3317;.2204;S Y="@37";.331013;.331014;@37;K DG4;.3319;.331011;@36; 
304 ;;.3311;S:X']"" Y="@36";N RET S RET=$$DR300^DGRP3("E2",.331015,.3312) I $G(DGTMOT)=1!('RET) S Y="@36";.331012//USA;.3313;S:X']"" Y=.3316;.3314;S:X']"" Y=.3316;.3315;.3316; S DGADD=".331" D DR301^DGRPE S:DG4=1 Y=.331013;.3317;
304000 ;;.2204;S Y="@37";.331013;.331014;@37;K DG4;.3319;.331011;@36;
 ;
 ;305 ;;N DGX1,DGX2;I '$L($P($G(^DPT(DFN,.21)),U)) S Y="@372";.3405//NO;I X="Y" S DGX1=1,Y="@371" S:$D(^DPT(DFN,.22)) $P(^(.22),U,2)=$P(^(.22),U,7);@372;.341;S:X']"" DGX1=2,Y="@371";.342;@371;
305 ;;N DGX1,DGX2;I '$L($P($G(^DPT(DFN,.21)),U)) S Y="@372";.3405//NO;I X="Y" S DGX1=1,Y="@371" S:$D(^DPT(DFN,.22)) $P(^(.22),U,2)=$P(^(.22),U,7);@372;.341;S:X']"" DGX1=2,Y="@371";
305000 ;;N RET S RET=$$DR300^DGRP3("D",.34015,.342) I $G(DGTMOT)=1!('RET) S Y="@39";@371;
 ;305000 ;;S:$G(DGX1) Y="@38";.343;S:X']"" Y=.346;.344;S:X']"" Y=.346;.345:.347;.2202;.349;.34011;S DGX1=2;@38;
 ;305001 ;;S:$G(DGX1)=2 Y="@381";S DGX2=$G(^DPT(DA,.21));.341///^S X=$P(DGX2,U);.342///^S X=$P(DGX2,U,2);.343///^S X=$P(DGX2,U,3);.344///^S X=$P(DGX2,U,4);@381
 ;305002 ;;S:$G(DGX1)=2 Y="@39";.345///^S X=$P(DGX2,U,5);.346///^S X=$P(DGX2,U,6);.347///^S X=$P(DGX2,U,7);.348///^S X=$P(DGX2,U,8);.349///^S X=$P(DGX2,U,9);.34011///^S X=$P(DGX2,U,11);@39;K DGX1,DGX2;
305001 ;;S:$G(DGX1) Y="@38";.34012//USA;.343;S:X']"" Y=.346;.344;S:X']"" Y=.346;.345;.346; S DGADD=".34" D DR301^DGRPE S:DG4=1 Y=.34013;.347;.2202;S Y="@391";.34013;.34014;@391;K DG4;.349;.34011;S DGX1=2;@38;
305002 ;;S:$G(DGX1)=2 Y="@381";S DGX2=$G(^DPT(DA,.21));.341///^S X=$P(DGX2,U);.342///^S X=$P(DGX2,U,2);.343///^S X=$P(DGX2,U,3);.344///^S X=$P(DGX2,U,4);.34012///^S X=$P(DGX2,U,12);.34013///^S X=$P(DGX2,U,13);.34014///^S X=$P(DGX2,U,14);@381
305003 ;;S:$G(DGX1)=2 Y="@39";.345///^S X=$P(DGX2,U,5);.346///^S X=$P(DGX2,U,6);.347///^S X=$P(DGX2,U,7);.348///^S X=$P(DGX2,U,8);.349///^S X=$P(DGX2,U,9);.34011///^S X=$P(DGX2,U,11);.34015///^S X=$P(DGX2,U,15);@39;K DGX1,DGX2;
 ;
401 ;;.01;.31115;S:($S(X']"":1,X=3:1,X=9:1,1:0)) Y="@41" S:(X'=5) Y=.3111;.31116;.3111;S:X']"" Y="@41";.3113;S:X']"" Y=.3116;.3114;S:X']"" Y=.3116;.3115:.3117;.2205;.3119;@41;
402 ;;.2514;.2515;S:($S(X']"":1,X=3:1,X=9:1,1:0)) Y="@42" S:(X'=5) Y=.251;.2516;.251;S:X']"" Y="@42";.252;S:X']"" Y=.255;.253;S:X']"" Y=.255;.254:.256;.2206;.258;@42;
501 ;;
502 ;;.381;.382///NOW;
503 ;;.383;
601 ;;Q;
602 ;;Q;
603 ;;Q;
604 ;;.525//NO;S:X'="Y" Y="@62";.526:.528;@62;
605 ;;.5291//NO;S:X'="Y" Y="@63";.5292:.5294;@63;
606 ;;I $P($G(^DPT(DFN,.361)),U,3)="H" S Y="@6131";.3602//NO;.3603//NO;S Y="@6132";@6131;.3602;.3603;@6132;
607 ;;.368//NO;.369//NO;I $S('$D(^DPT(DA,.36)):1,$P(^(.36),U,8)="Y"!($P(^(.36),U,9)="Y"):0,1:1) S Y="@614";.37;@614;
608 ;;S DGPHFLG=0;.531;S:X'="Y" DGX=X,Y="@616";.532///^S X="PENDING";S Y="@6161";@616;S:DGX'="N" Y="@6162";.533///^S X="VAMC";@6161;S DGPHFLG=1;.535///^S X=$$DIV^DGRPLE();@6162;
AD ; DG*5.3*1014;jam; Replace code below - store data via Fileman and not direct global sets
 ; Input: DGADD =.21 for copying to NOK
 ;              =.211 for copying to NOK2
 ;
 ;N DGZ4,DGPC
 ; patch DG*5.3*985; jam - NOK - do not copy phone number when copying patient address.
 ; patch DG*5.3*997; jam - copy country/province/postal code
 ;S X=$S($D(^DPT(DA,.11)):^(.11),1:""),DGZ4=$P(X,U,12),DGPHONE=$S($D(^(.13)):$P(^(.13),U,1),1:""),Y=$S($D(^(DGADD)):^(DGADD),1:""),^(DGADD)=$P(Y,U,1)_U_$P(Y,U,2)_U_$P(X,U,1,6)_U_DGPHONE_U_$P(Y,U,10)
 ;S X=$S($D(^DPT(DA,.11)):^(.11),1:""),DGZ4=$P(X,U,12),Y=$S($D(^(DGADD)):^(DGADD),1:""),^(DGADD)=$P(Y,U,1)_U_$P(Y,U,2)_U_$P(X,U,1,6)_U_$P(Y,U,9)_U_$P(Y,U,10)_U_$P(Y,U,11)_U_$P(X,U,10)_U_$P(X,U,8)_U_$P(X,U,9)
 ;I DGZ4 S DGPC=$S((DGADD=.33):1,(DGADD=.34):2,(DGADD=.211):3,(DGADD=.331):4,(DGADD=.311):5,(DGADD=.25):6,(DGADD=.21):7,1:0) S:DGPC $P(^DPT(DFN,.22),U,DGPC)=DGZ4
 ;K DGADD,DGPHONE Q
 N DGPMA,DGDATA,DGERROR
 ; get Perm Address
 S DGPMA=$S($D(^DPT(DFN,.11)):^(.11),1:"")
 ; set fields for copying Perm address to NOK
 I DGADD=.21 D
 . S DGDATA(.221)=$P(DGPMA,U,10)
 . S DGDATA(.213)=$P(DGPMA,U,1)
 . S DGDATA(.214)=$P(DGPMA,U,2)
 . S DGDATA(.215)=$P(DGPMA,U,3)
 . S DGDATA(.216)=$P(DGPMA,U,4)
 . S DGDATA(.217)=$P(DGPMA,U,5)
 . S DGDATA(.218)=$P(DGPMA,U,6)
 . S DGDATA(.222)=$P(DGPMA,U,8)
 . S DGDATA(.223)=$P(DGPMA,U,9)
 ; set fields for copying Perm address to NOK2
 I DGADD=.211 D
 . S DGDATA(.2101)=$P(DGPMA,U,10)
 . S DGDATA(.2193)=$P(DGPMA,U,1)
 . S DGDATA(.2194)=$P(DGPMA,U,2)
 . S DGDATA(.2195)=$P(DGPMA,U,3)
 . S DGDATA(.2196)=$P(DGPMA,U,4)
 . S DGDATA(.2197)=$P(DGPMA,U,5)
 . S DGDATA(.2198)=$P(DGPMA,U,6)
 . S DGDATA(.2102)=$P(DGPMA,U,8)
 . S DGDATA(.2103)=$P(DGPMA,U,9)
 I $$UPD^DGENDBS(2,DFN,.DGDATA,.DGERROR)
 K DGADD
 Q
 ;
DR109 ;Drop through (use same logic as DR203)
DR203 S DR(2,2.02)=".01RACE;I $P($G(^DIC(10.3,+$P($G(^DPT(DA(1),.02,DA,0)),""^"",2),0)),""^"",2)=""S"" S Y=""@2031"";.02;@2031;"
 S DR(2,2.06)=".01ETHNICITY;I $P($G(^DIC(10.3,+$P($G(^DPT(DA(1),.06,DA,0)),""^"",2),0)),""^"",2)=""S"" S Y=""@2032"";.02;@2032;"
 Q
DR11 ;clt; DG*5.3*941 - Called from line tag 112 if Perm address is empty
 Q:$G(^DPT(DFN,.115))=""
 ; DG*5.3*1040 - Quit if timeout from previous field
 Q:$D(DTOUT)
 Q:+$G(DGTMOT)
 ;DG*5.3*1056 removed Permanent from the following comment and message
 ; If Residential Address exists, give user the option of copying residential to mailing address
 W !,"The Patient has no Mailing Address."
 D RESMVQ^DGREGCP1(DFN)
 Q
DR111 ; Set DR string for Confidential Address categories
 S DR(2,2.141)=".01;1//YES;"
 ;S DR(2,2.14)=".01;1//"_"YES"
 Q
 ;
DR206 ;DG*5.3*1064; Code for group 6 on screen 2
 ;Verify responses and prompt for approval before storing-set group 6 to uneditable if responses approved
 N DA,DIR,DGFDA,DGERR,X,Y,DTOUT,DUOUT
 S DIR(0)="2,.571",DA=DFN,DIR("A")="Are you an Indian?"
 D ^DIR
 ; quit on ^ or timeout (set DGTMOT for timeout)
 I $D(DUOUT) Q
 I $D(DTOUT) S DGTMOT=1 Q
 S DGFDA(2,+DFN_",",.571)=Y
 Q:Y=""
REENTER ;NULL attestation date is not allowed - redisplay prompt
 S DIR(0)="2,.573",DA=DFN,DIR("A")="Indian Attestation Date"
 D ^DIR
 ; quit on ^ or timeout (set DGTMOT for timeout)
 I $D(DUOUT) Q
 I $D(DTOUT) S DGTMOT=1 Q
 I Y="" W !,"This is a required response. Enter "_"'^'"_" to exit" G REENTER
 S DGFDA(2,+DFN_",",.573)=Y
 I $$CONFIRM()'=1 D  Q
 . ; quit if time-out
 . I $G(DGTMOT) Q
 . W !,"Indian attestation not saved.",!
 . D EOP
 D FILE^DIE("","DGFDA","DGERR")
 W !,"Changes saved.",! D EOP
 Q
CONFIRM() ;Confirm if user wants to save the changes - DG*5.3*1064
 N DIR,X,Y,DTOUT,DUOUT,DIROUT
 S DIR(0)="Y"
 S DIR("A")="Do you wish to save these values"
 S DIR("?")="Enter Yes to store the Indian Data, enter No or "_"'^'"_" to exit without saving the data."
 D ^DIR
 I $D(DTOUT) S DGTMOT=1 Q 0
 I $G(Y)=0 Q 0
 I $D(DUOUT)!$D(DIROUT) Q 0
 Q 1
EOP ;DG*5.3*1064
 N DIR,DTOUT,DUOUT,DIROUT,X,Y
 S DIR(0)="E"
 S DIR("A")="Press ENTER to continue"
 D ^DIR
 S:$D(DTOUT) DGTMOT=1
 Q
 ;
DR207 ; DR string for preferred language ;*///*
 S DR(2,2.07)=".01;.02//ENGLISH;D LANGDEL^DGRPE"
 Q
 ;DR301 ; set up variables for foreign address - REMOVE FOR PATCH 997 - REPLACED BELOW
 N DG3,DG33
 S DG4=0
 S DG3=$P($G(^DPT(DFN,.11)),U,10)
 S DG33=$O(^HL(779.004,"B","USA",""))
 I $G(DG3)]"",(DG3'=$G(DG33)) S DG4=1
 Q
 ;
DR301 ; jam; DG*5.3*997 - check for foreign address
 N DG3,DG33
 S DG4=0
 S DG3=$P($G(^DPT(DFN,DGADD)),U,12)
 S DG33=$O(^HL(779.004,"B","USA",""))
 I $G(DG3)]"",(DG3'=$G(DG33)) S DG4=1
 Q
 ;
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
 ; Component only valid for ARMY/AIR FORCE/MARINES/COAST GUARD/NOAA/USPHS/SPACE FORCE
 Q $S('$G(X):0,X'>5!(X=9)!(X=10)!(X=15):1,1:0)  ;DG*5.3*1044 - added 15 for SPACE FORCE branch of service
 ;
YN1316(DFN) ;Email address indicator - DG*5.3*865
 N %,RSLT
 S DIE("NO^")=""
P1316 ;
 S %=0
 W !,"DOES THE PATIENT HAVE AN EMAIL ADDRESS? Y/N"
 D YN^DICN
 I %=0 W !,"    If the patient has a valid Email Address, please answer with 'Yes'.",!,"    If no Email Address please answer with 'No'." G P1316
 I %=-1 W !,"    EXIT NOT ALLOWED ??" G P1316
 S RSLT=$S(%=1:"Y",%=2:"N")
 N FDA,IENS
 Q:'$G(DFN)
 S IENS=DFN_",",FDA(2,IENS,.1316)=RSLT
 D FILE^DIE("","FDA")
 Q RSLT
 ;
INPXF207 ; Input transform for field 7 in file ;*///*
 I $L(X)>60!($L(X)<1) K X Q
 I X="*" S X="DECLINED TO ANSWER",FMT="?($X+3)" D EN^DDIOL(X,"",FMT) Q
 I $D(X) DO
 .N DIC S DIC(0)="EQMN",DIC="^DI(.85,",DIC("S")="S DIC(""W"")="""" I $P(^DI(.85,+Y,0),U,7)=""L"",$P(^(0),U,2)]"""""
 .D ^DIC S:+Y>0 X=$P(^DI(.85,+Y,0),U) I +Y<0 K X
 Q
 ;
XHELP207 ; This is a screen to be sure the language is a 'living' language, i.e.in use today and that it has the required 2-character code. ;*///*
 N X S X="?" N DIC S DIC("S")="S DIC(""W"")="""" I $P(^DI(.85,+Y,0),U,7)=""L"",$P(^(0),U,2)]""""" S DIC(0)="EQM",DIC="^DI(.85," D ^DIC
 Q
 ;
LANGDEL ; If no language entered, remove the stub record ;*///*
 Q:'$G(D1)
 N X S X=$G(^DPT(DFN,.207,D1,0)) Q:X=""
 I $P(X,U,2)="" DO
 .W $C(7),!!,"No language was entered. Record deleted!",! H 3
 .S DIK="^DPT(DFN,.207,",DA=D1 D ^DIK K DIK
 Q
