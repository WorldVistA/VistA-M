FBAAV0 ;AISC/GRR - ELECTRONICALLY TRANSMIT FEE DATA ;3/22/2012
 ;;3.5;FEE BASIS;**3,4,55,89,98,116,108,132,139,123**;JAN 30, 1995;Build 51
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; References to API $$CODEABA^ICDEX supported by ICR #5747
 ;
 K ^TMP($J,"FBAABATCH"),^TMP($J,"FBVADAT") D DT^DICRW
 ;
 N FBTRT S FBTRT=0   ; Flag indicating if any transactions are found that need to be transmitted
 I $D(^FBAA(161.7,"AC","S")) S FBTRT=1       ; supervisor closed batch
 I $D(^FBAA(161.7,"AC","R")) S FBTRT=1       ; reviewed after pricer batch
 I $D(^FBAA(161.25,"AE")) S FBTRT=1          ; vendor correction
 I +$O(^FBAA(161.26,"AC","P",0)) S FBTRT=1   ; FB patient master record changes
 I +$O(^FBAA(161.96,"AS","P",0)) S FBTRT=1   ; ipac vendor agreement MRA changes (FB*3.5*123)
 I 'FBTRT W !,*7,"There are no transactions requiring transmission",*7 Q
 ;
 W !!,"This option will transmit all Batches and MRA's ready to be transmitted",!,"to Austin"
RD W !! S DIR(0)="Y",DIR("A")="Are you sure you want to continue",DIR("B")="No" D ^DIR K DIR G END:'Y
 L +^FBAA(161.7,"AC"):0 G:'$T LOCK^FBAAUTL1
 W !!,"The following Batches will be transmitted: " F FBSTAT="S","R" F J=0:0 S J=$O(^FBAA(161.7,"AC",FBSTAT,J)) Q:J'>0  S FBATCH=$G(^FBAA(161.7,J,0)) D
 .Q:'+FBATCH
 .I (FBSTAT="S"&($P(FBATCH,U,15)="Y"))!(+$P(FBATCH,U,9)) S ^TMP($J,"FBAABATCH",J)="" W !,+FBATCH
RTRAN ;Entry from Re-transmit MRA routine
 D ADDRESS^FBAAV01 G END:VATERR K VAT
 D WAIT^DICD,STATION^FBAAUTL,HD^FBAAUTL I $D(FB("ERROR")) G END
 S TOTSTR=0,$P(PAD," ",200)=" "
 D ^FBAAV1:$D(^FBAA(161.25,"AE"))         ; Vendor MRA
 D ^FBAAV4:$D(^FBAA(161.26,"AC","P"))     ; Patient MRA
 D ^FBAAV8:$D(^FBAA(161.96,"AS","P"))     ; IPAC agreement MRA (FB*3.5*123)
 ;
 F J=0:0 S J=$O(^TMP($J,"FBAABATCH",J)) Q:J'>0  I $D(^FBAA(161.7,J,0)) S Y(0)=^(0) D SET1,DET:FBAABT="B3",DETP^FBAAV2:FBAABT="B5",DETT^FBAAV3:FBAABT="B2",^FBAAV5:FBAABT="B9"
END L -^FBAA(161.7,"AC") D KILL^FBAAV1 Q
SET1 ; build the payment batch header string (used by all four formats)
 S FBAABN=$P(Y(0),"^",1),FBAABN=$E("00000",$L(FBAABN)+1,5)_FBAABN
 S FBAAON=$E($P(Y(0),"^",2),3,6)
 S FBAACD=$$AUSDT^FBAAV3(DT)
 S FBAACP=$E($P(Y(0),"^",2),1,2)
 S FBAABT=$P(Y(0),"^",3)
 S FBAAAP=$$AUSAMT^FBAAV3($P(Y(0),"^",9),11)
 S FBSTAT=$P(^FBAA(161.7,J,"ST"),"^")
 S FBCHB=$P(Y(0),"^",15)
 S FBEXMPT=$P(Y(0),"^",18)
 S X=$$SUB^FBAAUTL5(+$P(Y(0),U,8)_"-"_$P(Y(0),U,2))
 S FBAASN=$$LJ^XLFSTR($S(X]"":X,1:FBAASN),6," ")
 I FBSTAT="R"!(FBSTAT="S"&(FBCHB'["Y"))!(FBSTAT="S"&($G(FBEXMPT)="Y")) S FBSTR=FBHD_$S(FBAABT="B2":"BT",1:FBAABT)_FBAACD_FBAASN_FBAABN_" "_FBAAAP_FBAACP_" $"
 Q
DET ;entry point to process B3 (outpatient/ancillary) batch
 ; input (partial list)
 ;   J      - Batch IEN in file 161.7
 ;   FBAAON - last 4 of obligation number
 ;   FBAASN - station number (formatted)
 S FBTXT=0
 D CKB3V^FBAAV01 I $G(FBERR) K FBERR Q
 ; HIPAA 5010 - line items that have 0.00 amount paid are now required to go to Central Fee
 F K=0:0 S K=$O(^FBAAC("AC",J,K)) Q:K'>0  F L=0:0 S L=$O(^FBAAC("AC",J,K,L)) Q:L'>0  F M=0:0 S M=$O(^FBAAC("AC",J,K,L,M)) Q:M'>0  F N=0:0 S N=$O(^FBAAC("AC",J,K,L,M,N)) Q:N'>0  S Y(0)=$G(^FBAAC(K,1,L,1,M,1,N,0)) I Y(0)]"" D
 .N FBDTSR1,FBPICN
 .S FBDTSR1=+$G(^FBAAC(K,1,L,1,M,0))
 .S FBPICN=K_U_L_U_M_U_N
 .S FBPICN=$$ORGICN^FBAAVR5(162.03,FBPICN)
 .S FBY=$G(^FBAAC(K,1,L,1,M,1,N,2))
 .S FBY3=$G(^FBAAC(K,1,L,1,M,1,N,3))
 .I 'FBTXT S FBTXT=1 D NEWMSG^FBAAV01,STORE^FBAAV01,UPD
 .D GOT
 ;
 D:FBTXT XMIT^FBAAV01
 Q
 ;
GOT ; process a B3 line item
 ;
 N DFN,FBADJ,FBADJA1,FBADJA2,FBADJR1,FBADJR2,FBADMIT,FBAUTHF,FBIENS
 N FBMOD1,FBMOD2,FBMOD3,FBMOD4,FBPNAMX,FBUNITS,FBX,FBNPI
 N FBCSID,FBEDIF,FBCNTRN
 N FBIA,FBDODINV
 ;
 S FBIENS=N_","_M_","_L_","_K_","
 ;
 S FBEDIF=$S($P($G(^FBAAC(K,1,L,1,M,1,N,3)),"^")]"":"Y",1:" ") ;EDI flag
 ; get CPT modifiers
 D
 . N FBMODA,FBMODL
 . D MODDATA^FBAAUTL4(K,L,M,N)
 . S FBMODL=$$MODL^FBAAUTL4("FBMODA","E")
 . S FBMOD1=$$RJ^XLFSTR($P(FBMODL,",",1),5," ")
 . S FBMOD2=$$RJ^XLFSTR($P(FBMODL,",",2),5," ")
 . S FBMOD3=$$RJ^XLFSTR($P(FBMODL,",",3),5," ")
 . S FBMOD4=$$RJ^XLFSTR($P(FBMODL,",",4),5," ")
 ;
 S FBPAYT=$P(Y(0),"^",20),FBPAYT=$S(FBPAYT]"":FBPAYT,1:"V")
 ;
 S FBVID=$P($G(^FBAAV(L,0)),U,2)
 S FBVID=FBVID_$E(PAD,$L(FBVID)+1,11)
 ;
 ; FB*3.5*123 - get IPAC variables
 S FBIA=+$P(FBY3,U,6)                                            ; IPAC agreement ptr
 S FBIA=$S(FBIA:$P($G(^FBAA(161.95,FBIA,0)),U,1),1:"")           ; IPAC external agreement id# or ""
 S FBIA=$$LJ^XLFSTR(FBIA,"10T")                                  ; format to 10 characters
 S FBDODINV=$P(FBY3,U,7),FBDODINV=$$LJ^XLFSTR(FBDODINV,"22T")    ; DoD invoice# formatted to 22 characters
 ;
 S:FBPAYT="R" FBVID=$E(PAD,1,11)
 S FBNPI=$$EN^FBNPILK(L)  ;SET THE NPI TO BE PASSED TO FBAAV01,FBAAV2,FBAAV5
 ;
 D POV^FBAAUTL2
 S POV=$S(POV']"":"",POV="A":6,POV="B":7,POV="C":8,POV="D":9,POV="E":10,1:POV)
 S POV=$S(POV']"":99,$D(^FBAA(161.82,POV,0)):$P(^(0),"^",3),1:99)
 S FBPOV=POV
 S FBTT=$S(FBTT]"":FBTT,1:1)
 S FBCPT=$$CPT^FBAAUTL4($P(Y(0),"^")),FBCPT=$S($L(FBCPT)=5:FBCPT,1:"     ")
 S FBPSA=$$PSA^FBAAV5(+$P(Y(0),U,12),+FBAASN) I $L(+FBPSA)'=3 S FBPSA=999
 S FBPATT=$P(Y(0),"^",17),FBPATT=$S(FBPATT]"":FBPATT,1:10)
 S FBTD=$$AUSDT^FBAAV3(FBDTSR1) ; formatted treatment date
 S FBSUSP=$P(Y(0),"^",5),FBSUSP=$S(FBSUSP]"":FBSUSP,1:" ")
 S FBSUSP=$S(FBSUSP=" ":" ",$D(^FBAA(161.27,+FBSUSP,0)):$P(^(0),"^"),1:" ")
 S FBAP=$$AUSAMT^FBAAV3($P(Y(0),"^",3),8) ; amount paid
 S FBPOS=+$P(Y(0),"^",25),FBPOS=$S(FBPOS:$P(^IBE(353.1,FBPOS,0),"^"),1:"  ")
 S FBHCFA=+$P(Y(0),"^",26),FBHCFA=$S(FBHCFA:$P(^IBE(353.2,FBHCFA,0),"^"),1:""),FBHCFA=$E(PAD,$L(FBHCFA)+1,2)_FBHCFA
 S FBVTOS=+$P(Y(0),"^",24),FBVTOS=$S(FBVTOS:$P(^FBAA(163.85,FBVTOS,0),"^",2),1:"  ")
 ; FB*3.5*139-DEM-Modifications for ICD-10 remediation
 S FBPD=+$P(Y(0),"^",23)
 S FBPD=$S(FBPD:$$ICD9^FBCSV1(FBPD,$G(FBDTSR1)),1:"")
 ; decimal is stripped only from ICD-10 diagnosis codes.
 I FBPD'="",$$CODEABA^ICDEX(FBPD,80,30)>0 S:FBPD["." FBPD=$P(FBPD,".",1)_$P(FBPD,".",2)
 S FBPD=$E(PAD,$L(FBPD)+1,7)_FBPD
 ; End 139
 S FBINVN=$P(Y(0),"^",16)
 S FBINVN=$E("000000000",$L(FBINVN)+1,9)_FBINVN
 S FBAUTHF=$S($P(Y(0),U,13)["FB583":"U",1:"A") ; auth/unauth flag
 S FBDIN=$$AUSDT^FBAAV3($P(Y(0),"^",15)) ; invoice date rec'd
 S FBADMIT=$$AUSDT^FBAAV3($$B3ADMIT(FBIENS)) ; formatted admission date
 ;
 S VAPA("P")=""
 S DFN=K
 ; Note - before this point Y(0) was the 0 node of subfile #162.03
 ;      - after this point Y(0) will be the 0 node of file #2
 S Y(0)=$G(^DPT(+K,0)) Q:Y(0)']""
 D PAT^FBAAUTL2
 ; obtain date of birth, must follow call to PAT^FBAAUTL2 to overwrite 
 ; the value returned from it
 S FBDOB=$$AUSDT^FBAAV3($P(Y(0),"^",3)) ; date of birth
 D ADD^VADPT
 S FBPNAMX=$$HL7NAME^FBAAV2(DFN) ; patient name
 S FBUNITS=$P(FBY,U,14)
 S:FBUNITS<1 FBUNITS=1
 S FBUNITS=$$RJ^XLFSTR(FBUNITS,5,0) ; volume indicator (units paid)
 S FBCSID=$$LJ^XLFSTR($P(FBY,"^",16),20," ") ; patient acct #
 D
 . N FBCNTRP
 . S FBCNTRP=$P(FBY3,"^",8)
 . S FBCNTRN=$S(FBCNTRP:$P($G(^FBAA(161.43,FBCNTRP,0)),"^"),1:"")
 . S FBCNTRN=$$LJ^XLFSTR(FBCNTRN,20," ") ; contract number
 ;
 ; get and format adjustment reason codes and amounts (if any)
 D LOADADJ^FBAAFA(FBIENS,.FBADJ)
 S FBX=$$ADJL^FBUTL2(.FBADJ)
 S FBADJR1=$$RJ^XLFSTR($P(FBX,U,1),5," ")
 S FBADJA1=$$AUSAMT^FBAAV3($P(FBX,U,3),9,1)
 S FBADJR2=$$RJ^XLFSTR($P(FBX,U,4),5," ")
 S FBADJA2=$$AUSAMT^FBAAV3($P(FBX,U,6),9,1)
 K FBADJ,FBX
 ;
 S FBST=$S($P(VAPA(5),"^")="":"  ",$D(^DIC(5,$P(VAPA(5),"^"),0)):$P(^(0),"^",2),1:"  ")
 I $L(FBST)>2 S FBST="**"
 S:$L(FBST)'=2 FBST=$E(PAD,$L(FBST)+1,2)_FBST
 S FBCTY=$S($P(VAPA(7),"^",1)="":"   ",FBST="  ":"   ",$D(^DIC(5,$P(VAPA(5),"^"),1,$P(VAPA(7),"^"),0)):$P(^(0),"^",3),1:"   ")
 I $L(FBCTY)'=3 S FBCTY=$E("000",$L(FBCTY)+1,3)_FBCTY
 S FBZIP=$S('+$G(VAPA(11)):VAPA(6),+VAPA(11):$P(VAPA(11),U),1:VAPA(6)),FBZIP=$TR(FBZIP,"-","")_$E("000000000",$L(FBZIP)+1,9)
 D STRING^FBAAV01
 Q
 ;
UPD ; update the batch file
 N Y
 S DA=J,(DIC,DIE)="^FBAA(161.7,"
 S DR="11////^S X=""T"";12////^S X=DT"
 D ^DIE
 Q
 ;
STORE D STORE^FBAAV01 Q
 ;
B3ADMIT(FBIENS) ; Determine Admission Date for a B3 payment line item
 ; input
 ;   FBIENS - IENS (FileMan format) for subfile 162.03 entry
 ; returns admission date in internal FileMan format or null value
 ;
 N FB7078,FBRET
 S FBRET=""
 S FB7078=$$GET1^DIQ(162.03,FBIENS,27,"I") ; associated 7078/583
 ; (the unauthorized ancillary claims will have the treatment date
 ;  instead of the inpatient admission date so nothing is sent to
 ;  Austin for them)
 ;
 ; if line items points to a 7078 authorization then return a date
 I $P(FB7078,";",2)="FB7078(" D
 . N FBY
 . S FBY=$G(^FB7078(+FB7078,0))
 . ; if fee program is civil hospital then return 7078 date of admission
 . I $P(FBY,U,11)=6 S FBRET=$P(FBY,U,15)
 . ; if fee program is CNH then return 7078 authorized from date
 . I $P(FBY,U,11)=7 S FBRET=$P(FBY,U,4)
 ;
 Q FBRET
