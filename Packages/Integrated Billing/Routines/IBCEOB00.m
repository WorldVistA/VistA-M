IBCEOB00 ;ALB/ESG - 835 EDI EOB MSG PROCESSING CONT ;30-JUN-2003
 ;;2.0;INTEGRATED BILLING;**155,349,377**;21-MAR-94;Build 23
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
RCRU(IBZDATA,IB0,IBLN) ; Revenue Code Roll-up procedure check -
 ; Total up outbound line items by revenue code and compare with
 ; incoming EOB 40 record to see if it has been rolled up
 ;
 ; IBZDATA - UB output formatter array, passed by reference
 ; IB0     - 40 record data
 ; IBLN    - output parameter, passed by reference
 ;
 NEW Z,LN,REV,UN,CH,RUD,RUD2,UCH,MRAUCH
 I $P(IB0,U,4)="" G RCRUX
 S IBLN="",Z=0
 F  S Z=$O(IBZDATA(Z)) Q:'Z  S LN=IBZDATA(Z) D
 . S REV=$P(LN,U,1),UN=$P(LN,U,4),CH=$P(LN,U,5),UCH=+$P(LN,U,3)
 . I REV="" Q
 . ;
 . S RUD=$G(RUD(REV))                 ; roll up data array for rev code
 . S $P(RUD,U,1)=$P(RUD,U,1)+CH       ; total charges
 . S $P(RUD,U,2)=$P(RUD,U,2)+UN       ; total units
 . S $P(RUD,U,3)=$P(RUD,U,3)+1        ; total line items
 . S RUD(REV)=RUD
 . S RUD(REV,Z)=""
 . ;
 . S RUD2=$G(RUD2(REV,UCH))           ; roll up data array for rev code
 . S $P(RUD2,U,1)=$P(RUD2,U,1)+CH     ; total charges
 . S $P(RUD2,U,2)=$P(RUD2,U,2)+UN     ; total units
 . S $P(RUD2,U,3)=$P(RUD2,U,3)+1      ; total line items
 . S RUD2(REV,UCH)=RUD2
 . S RUD2(REV,UCH,Z)=""
 . ;
 . Q
 ;
 I '$D(RUD),'$D(RUD2) G RCRUX
 ;
 ; delete the revenue code roll-up, if only 1 line item.
 S REV=""     ; this is not a roll up situation
 F  S REV=$O(RUD(REV)) Q:REV=""  I $P(RUD(REV),U,3)=1 KILL RUD(REV)
 ;
 S (REV,UCH)=""
 F  S REV=$O(RUD2(REV)) Q:REV=""  F  S UCH=$O(RUD2(REV,UCH)) Q:UCH=""  I $P(RUD2(REV,UCH),U,3)=1 KILL RUD2(REV,UCH)
 ;
 I '$D(RUD),'$D(RUD2) G RCRUX
 ;
 S RUD=$G(RUD($P(IB0,U,4)))      ; compare with 40 record data
 I RUD="" G RCRU2                ; make sure it exists
 I $P(RUD,U,1)'=+$$DOLLAR^IBCEOB($P(IB0,U,15)) G RCRU2    ; charges
 I $P(RUD,U,2)'=$P(IB0,U,16) G RCRU2                      ; units
 S IBLN=$O(RUD($P(IB0,U,4),""))  ; use the first line# found
 G RCRUX
 ;
RCRU2 ; check roll-up data by rev code and unit charge
 S MRAUCH=0
 I $P(IB0,U,16) S MRAUCH=+$$DOLLAR^IBCEOB($P(IB0,U,15))/$P(IB0,U,16)
 S RUD2=$G(RUD2($P(IB0,U,4),MRAUCH))     ; compare with 40 record data
 I RUD2="" G RCRUX                       ; make sure it exists
 I $P(RUD2,U,1)'=+$$DOLLAR^IBCEOB($P(IB0,U,15)) G RCRUX   ; charges
 I $P(RUD2,U,2)'=$P(IB0,U,16) G RCRUX                     ; units
 S IBLN=$O(RUD2($P(IB0,U,4),MRAUCH,""))  ; use the first line# found
 ;
RCRUX ;
 Q
 ;
ICN(IBEOB,ICN,COBN,IBOK) ; File the 835 ICN into the Bill
 ;
 ; Input parameters
 ;   IBEOB - ien to file 361.1
 ;   ICN   - the ICN# from the 835 transmission
 ;   COBN  - the insurance sequence#
 ;
 ; Output parameter
 ;   IBOK  - returns as 0 if we get a filing error here
 ;
 ; The field in file 399 depends on the current payer sequence
 ;     399,453 - primary ICN
 ;     399,454 - secondary ICN
 ;     399,455 - tertiary ICN
 ;
 NEW IBIFN,FIELD,D,D0,DA,DI,DIC,DIE,DQ,DR,X,Y
 S IBEOB=+$G(IBEOB),COBN=+$G(COBN)
 I 'IBEOB!'COBN G ICNX
 S IBIFN=+$P($G(^IBM(361.1,IBEOB,0)),U,1)
 I '$D(^DGCR(399,IBIFN)) G ICNX
 I $G(ICN)="" G ICNX
 I '$F(".1.2.3.","."_COBN_".") G ICNX
 ;
 S FIELD=452+COBN
 S DIE=399,DA=IBIFN,DR=FIELD_"////"_ICN D ^DIE
 S IBOK=($D(Y)=0)
 I 'IBOK S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Error in filing the ICN into the Bill/Claims file"
ICNX ;
 Q
 ;
15(IB0,IBEGBL,IBEOB) ; Record '15'
 ;
 N A,IBOK
 ;
 S A="3;1.03;1;0;0^4;1.04;1;0;0^5;1.05;1;0;0^6;1.07;1;0;0^7;1.08;1;0;0^8;1.09;1;0;0^9;1.02;1;0;0^10;2.05;1;0;0"
 ;
 S IBOK=$$STORE^IBCEOB1(A,IB0,IBEOB)
 I 'IBOK S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Bad record 15 data" G Q15
 ;
 ; For Medicare MRA's only:
 ; If the Covered Amount is present (15 record, piece 3), then file
 ; a claim level adjustment with Group code=OA, Reason code=AB3.
 ;
 I $P($G(^IBM(361.1,IBEOB,0)),U,4)=1,+$P(IB0,U,3) D
 . N IB20
 . S IB20=20_U_$P(IB0,U,2)_U_"OA"_U_"AB3"_U_$P(IB0,U,3)_U_"0000000000"
 . S IB20=IB20_U_"Covered Amount"
 . S IBOK=$$20(IB20,IBEGBL,IBEOB)
 . I 'IBOK S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Could not file the OA-AB3 claim level adjustment for the Covered Amount"
 . K ^TMP($J,20)
 . Q
 ;
Q15 Q IBOK
 ;
20(IB0,IBEGBL,IBEOB) ; Record '20'
 ;
 N A,LEVEL,IBGRP,IBDA,IBOK
 ;
 S IBGRP=$P(IB0,U,3)
 I IBGRP'="" S ^TMP($J,20)=IBGRP
 I IBGRP="" S IBGRP=$G(^TMP($J,20))
 I IBGRP="" S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Missing claim level adjustment group code" G Q20
 ;
 S IBDA(1)=$O(^IBM(361.1,IBEOB,10,"B",IBGRP,0))
 ;
 I 'IBDA(1) D  ;Needs a new entry at group level
 . N X,Y,DA,DD,DO,DIC,DLAYGO
 . S DIC="^IBM(361.1,"_IBEOB_",10,",DIC(0)="L",DLAYGO=361.11,DA(1)=IBEOB
 . S DIC("P")=$$GETSPEC^IBEFUNC(361.1,10)
 . S X=IBGRP
 . D FILE^DICN K DIC,DO,DD,DLAYGO
 . I Y<0 K IBDA S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Adjustment group code could not be added" Q
 . S IBDA(1)=+Y
 ;
 I $G(IBDA(1)) D  ;Add a new entry at the reason code level
 . S DIC="^IBM(361.1,"_IBEOB_",10,"_IBDA(1)_",1,",DIC(0)="L",DLAYGO=361.111,DA(2)=IBEOB,DA(1)=IBDA(1)
 . S DIC("P")=$$GETSPEC^IBEFUNC(361.11,1)
 . S X=$P(IB0,U,4)
 . D FILE^DICN K DIC,DO,DD,DLAYGO
 . I Y<0 K IBDA S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Adjustment reason code could not be added" Q
 . S IBDA=+Y
 ;
 I $G(IBDA) D
 . S LEVEL=10,LEVEL("DIE")="^IBM(361.1,"_IBEOB_",10,"_IBDA(1)_",1,"
 . S LEVEL(0)=IBDA,LEVEL(1)=IBDA(1),LEVEL(2)=IBEOB
 . S A="5;.02;1;0;0^6;.03;0;1;1^7;.04;0;1;0"
 . S IBOK=$$STORE^IBCEOB1(A,IB0,IBEOB,.LEVEL)
 . I 'IBOK S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Bad adjustment reason code ("_$P(IB0,U,4)_") data" Q
Q20 Q $G(IBOK)
 ;
35(IB0,IBEGBL,IBEOB) ; Record '35'
 ;
 N A,IBOK
 ;
 S A="3;4.12;1;0;0^4;4.13;1;0;0^5;4.14;0;1;1^6;4.15;1;0;0^7;4.16;1;0;0^8;4.17;1;0;0^9;4.18;1;0;0^10;4.04;1;0;0^11;3.01;0;1;1^12;3.02;1;0;0^13;3.08;1;0;0^14;3.09;1;0;0"
 ;
 S IBOK=$$STORE^IBCEOB1(A,IB0,IBEOB)
 I 'IBOK S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Bad MEDICARE Inpt Adjudication data"
Q35 Q $G(IBOK)
 ;
37(IB0,IBEGBL,IBEOB) ; Record '37'
 ;
 N IBOK,IBCT
 S IBCT=$G(^TMP($J,37))+1
 I IBCT>5 S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Too many Medicare Claim Level Adjudication Remarks" G Q37    ; Max 5 allowed
 S A="4;"_$S($P(IB0,U,3)="O":"3.0"_(IBCT+2),1:"5.0"_IBCT)_";0;0;0^5;5.0"_IBCT_"1;0;0;0"
 S IBOK=$$STORE^IBCEOB1(A,IB0,IBEOB)
 I 'IBOK S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Bad Medicare Claim Level Adjudication Remarks data"
 ;
 ; 4/22/03 - esg - If claim level remark code MA15 is reported, then
 ;         this is a split EOB and we need to change the REVIEW STATUS
 ;         of this EOB to be ACCEPTED-INTERIM EOB.
 ;
 I $P(IB0,U,4)["MA15" D
 . N DA,DIE,DR,DIC
 . S DA=IBEOB,DIE=361.1,DR=".16////2" D ^DIE S IBOK=($D(Y)=0)
 . I 'IBOK S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Split EOB, but review status was not updated correctly"
 . Q
 ;
Q37 S ^TMP($J,37)=$G(^TMP($J,37))+1 ; Saves the # of entries for 37 records
 Q $G(IBOK)
 ;
 ;
DET40(IB0,ARRAY) ; Format important details of record 40 for error
 ; IB0 = data on 40 record (some pieces pre-formatted)
 ;  ARRAY(n)=formatted line is returned if passed by ref
 N Q
 S ARRAY(1)="Payer reported the following was billed to them:"
 S ARRAY(2)=" "_$S($P(IB0,U,21)="NU":"Rev Cd",1:"Proc")_": "_$S($P(IB0,U,10)'="":$P(IB0,U,10),1:"Same as adjudicated")_"  Chg: "_$J($P(IB0,U,15)/100,"",2)_"  Units: "_$S($P(IB0,U,16):$P(IB0,U,16),1:1)
 S ARRAY(3)="  Svc Date(s): "_$S($P(IB0,U,19)'="":$$FDT($P(IB0,U,19)),1:"??")_$S($P(IB0,U,20)'="":"-"_$$FDT($P(IB0,U,20)),1:"")
 I $P(IB0,U,11)'="" S ARRAY(3)=ARRAY(3)_"  Mods: " F Q=11:1:14 I $P(IB0,U,Q)'="" S ARRAY(3)=ARRAY(3)_$P(IB0,U,Q)_$S(Q=14:"",$P(IB0,U,Q+1)'="":",",1:"")
 S ARRAY(4)="Payer reported adjudication on:"
 S ARRAY(5)=" "_$S($P(IB0,U,21)="NU":"Rev Cd",1:"Proc")_": "_$S($P(IB0,U,3)'="":$P(IB0,U,3),1:$P(IB0,U,4))
 S ARRAY(5)=ARRAY(5)_"  Type: "_$P(IB0,U,21)_$S($P(IB0,U,21)'="NU":"  Rev Cd: "_$P(IB0,U,4),1:"")_"  Units: "_$S($P(IB0,U,18):$P(IB0,U,18)/100,1:1)_"  Amt: "_$J($P(IB0,U,17)/100,"",2)
 I $P(IB0,U,5)'="" S ARRAY(5)=ARRAY(5)_"  Mods: " F Q=5:1:8 I $P(IB0,U,Q)'="" S ARRAY(5)=ARRAY(5)_$P(IB0,U,Q)_$S(Q=8:"",$P(IB0,U,Q+1)'="":",",1:"")
 Q
 ;
DET4X(RECID,IB0,ARRAY) ; Format important details of record 41-45 for error
 ; RECID = 41,42,45
 ; IB0 = data on RECID record
 ;  ARRAY(n)=formatted line is returned if passed by ref
 N CT,Q
 I RECID=41 D  Q
 . S ARRAY(1)="Allowed Amt: "_$J($P(IB0,U,3)/100,"",2)_"  Per Diem Amt: "_$J($P(IB0,U,4)/100,"",2)
 ;
 I RECID=42 D  Q
 . S ARRAY(1)="Line Item Remark Code: "_$P(IB0,U,3)
 . I $P(IB0,U,4)'="" S CT=1 F Q=0:80:190 I $E($P(IB0,U,4),Q+1,Q+80)'="" S CT=CT+1,ARRAY(CT)=$E($P(IB0,U,4),Q+1,Q+80)
 ;
 I RECID=45 D
 . S ARRAY(1)="Adj Group Cd: "_$P(IB0,U,3)_"  Reason Cd: "_$P(IB0,U,4)_"  Amt: "_$J($P(IB0,U,5)/100,"",2)_"  Quantity: "_+$P(IB0,U,6)
 . I $P(IB0,U,7)'="" S CT=1 F Q=0:80:190 I $E($P(IB0,U,7),Q+1,Q+80)'="" S CT=CT+1,ARRAY(CT)=$E($P(IB0,U,7),Q+1,Q+80)
 Q
 ; 
FDT(X) ; Format date in X (YYYYMMDD) to MM/DD/YYYY
 S:X'="" X=$E(X,5,6)_"/"_$E(X,7,8)_"/"_$E(X,1,4)
 Q X
 ;
