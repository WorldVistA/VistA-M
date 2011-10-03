PSJIPST3 ;BIR/MLM-CONVERT PSJ 4.5 QUICK ORDERS FOR USE IN OE/RR 3.0 ; 15 May 98 / 10:56 AM
 ;;5.0; INPATIENT MEDICATIONS ;**3,5**;16 DEC 97
 ;
EN(PROTIEN)        ;
 ; THIS CALL NOT USED ANYMORE... IT IS IN ^PSSQOC
 Q
 ;
GTPC ; Set up TMP for provider comments
 I $O(^PS(57.1,+PSJQOPTR,2,0))  D
 .S CNT=0 F X=0:0 S X=$O(^PS(57.1,+PSJQOPTR,2,X)) Q:'X  D
 ..S Y=$G(^PS(57.1,PSJQOPTR,2,X,0)) S:Y]"" CNT=CNT+1,^TMP("PSJQO",$J,"PC",CNT,0)=Y
 .S:$O(^TMP("PSJQO",$J,"PC",0)) ^TMP("PSJQO",$J,"PC",0)=CNT_U_CNT
 Q
111 ; Order Set Conversion
CONVOS ;Convert Order Sets in ^PS(53.2,
 D MES^XPDUTL(" ") D MES^XPDUTL("Converting Unit Dose Order Sets......")
 N PSJNUM,PSJNUM2,PSJND,S,PSJCC,FLAG,PSJOCNT,PSJ50P7
 S S="PSJOS" K ^TMP(S,$J)
 F PSJNUM=0:0 S PSJNUM=$O(^PS(53.2,PSJNUM)) Q:'PSJNUM  D
 .Q:'$O(^PS(53.2,PSJNUM,1,0))
 .S ^TMP(S,$J,PSJNUM,0)=$P(^PS(53.2,PSJNUM,0),"^")
 .F PSJNUM2=0:0 S PSJNUM2=$O(^PS(53.2,PSJNUM,1,PSJNUM2)) Q:'PSJNUM2  D
 ..S ^TMP(S,$J,PSJNUM,1,PSJNUM2,0)=^PS(53.2,PSJNUM,1,PSJNUM2,0)
 ..S ^TMP(S,$J,PSJNUM,1,PSJNUM2,1)=$G(^PS(53.2,PSJNUM,1,PSJNUM2,1))
 ..F PSJND=0:0 S PSJND=$O(^PS(53.2,PSJNUM,1,PSJNUM2,2,PSJND)) Q:'PSJND  D
 ...S ^TMP(S,$J,PSJNUM,1,PSJNUM2,2,PSJND,0)=^PS(53.2,PSJNUM,1,PSJNUM2,2,PSJND,0)
 ..I '$$CHECK(PSJNUM,PSJNUM2,S) S ^TMP(S,$J,"BAD",PSJNUM)=1
 ..E  S ^TMP(S,$J,PSJNUM,2,PSJNUM2,"50.7PT")=PSJ50P7
 D CONVERT D:$D(^TMP(S,$J)) MAILMESS(PSJOCNT) K ^TMP(S,$J)
 D NOW^%DTC S $P(^PS(59.7,1,20.5),U,4)=%
 D MES^XPDUTL("                                      .....finished") W !
 D SDCON ; queue up conversion of Order sets to OERR quick orders
 Q
CONVERT ;
 N PSJNUM,PSJNUM2,PSJND,PSJT,M1,L1,M2,L2
 F PSJNUM=0:0 S PSJNUM=$O(^TMP(S,$J,PSJNUM)) Q:'PSJNUM  D
 .Q:$D(^TMP(S,$J,"BAD",PSJNUM))  ; doesn't convert the bad ones
 .S PSJOCNT=$S('$D(PSJOCNT):1,1:PSJOCNT+1)
 .S M1=^PS(53.2,PSJNUM,1,0),L1=$L(M1),M1=$E(M1,(L1-3),L1)
 .S ^PS(53.2,PSJNUM,2,0)="^53.22PA"_M1
 .F PSJNUM2=0:0 S PSJNUM2=$O(^TMP(S,$J,PSJNUM,1,PSJNUM2)) Q:'PSJNUM2  D
 ..S ^PS(53.2,PSJNUM,2,PSJNUM2,0)=^TMP(S,$J,PSJNUM,1,PSJNUM2,0)
 ..S $P(^PS(53.2,PSJNUM,2,PSJNUM2,0),"^")=^TMP(S,$J,PSJNUM,2,PSJNUM2,"50.7PT")
 ..S PSJT=$S($L(^TMP(S,$J,PSJNUM,1,PSJNUM2,1)):1,1:0)
 ..I PSJT S ^PS(53.2,PSJNUM,2,PSJNUM2,1)=$G(^TMP(S,$J,PSJNUM,1,PSJNUM2,1))
 ..F PSJND=0:0 S PSJND=$O(^TMP(S,$J,PSJNUM,1,PSJNUM2,2,PSJND)) Q:'PSJND  D
 ...S ^PS(53.2,PSJNUM,2,PSJNUM2,2,PSJND,0)=^TMP(S,$J,PSJNUM,1,PSJNUM2,2,PSJND,0)
 ..I $D(^PS(53.2,PSJNUM,1,PSJNUM2,2,0)) D   ;if no disp. drug don't set
 ...S M2=^PS(53.2,PSJNUM,1,PSJNUM2,2,0),L2=$L(M2),M2=$E(M2,(L2-3),L2)
 ...S ^PS(53.2,PSJNUM,2,PSJNUM2,2,0)="^53.23P"_M2
 S DIK="^PS(53.2," D IXALL^DIK
 Q
CHECK(PSJNUM,PSJNUM2,S) ; check to see if different Orderable Items
 N PSJFIRST,PSJCC,PSDRUG S FLAG=1
 F PSJCC=0:0 S PSJCC=$O(^TMP(S,$J,PSJNUM,1,PSJNUM2,2,PSJCC)) Q:'PSJCC  D
 .Q:'FLAG
 .S PSDRUG=$P(^TMP(S,$J,PSJNUM,1,PSJNUM2,2,PSJCC,0),"^")
 .S PSJ50P7=+$P($G(^PSDRUG(PSDRUG,2)),"^")
 .I '$D(PSJFIRST) S PSJFIRST=PSJ50P7,FLAG=1
 .E  S FLAG=(PSJFIRST=PSJ50P7)
 .S:PSJ50P7=0 FLAG=0 ; sets flag to quit if drug has no Ord Item
 Q FLAG
MAILMESS(C) ;  send mail msg for Order Set conversion
 K XMY N LOOP,CNT S XMSUB="Inpatient Medications ORDER SETS conversion"
 S XMDUZ="INPATIENT MEDICATIONS Version 5.0 Install",XMTEXT="PSJTEXT1("
 F LOOP=0:0 S LOOP=$O(^XUSEC("PSJU MGR",LOOP)) Q:'LOOP  D
 .S XMY(LOOP)=""
 S XMY(DUZ)=""
 S PSJTEXT1(1,0)="The conversion of the Unit Dose Order sets has completed."
 S PSJTEXT1(2,0)="A total of "_C_" order sets were converted."
 I $D(^TMP(S,$J,"BAD")) D
 .S (PSJTEXT1(3,0),PSJTEXT1(8,0))=""
 .S PSJTEXT1(5,0)="The following Order Sets contained drugs that have"
 .S PSJTEXT1(5,0)=PSJTEXT1(5,0)_" more than one Dispense drug,"
 .S PSJTEXT1(6,0)="or dispense drugs that are inactive."
 .S PSJTEXT1(7,0)="These Dispense drugs are not linked to the same Ordera"
 .S PSJTEXT1(7,0)=PSJTEXT1(7,0)_"ble item."
 .S PSJTEXT1(8,0)="Please REENTER these Order Sets through the menu option."
 .F LOOP=0:0 S LOOP=$O(^TMP(S,$J,"BAD",LOOP)) Q:'LOOP  D
 ..S CNT=$S('$D(CNT):1,1:CNT+1)
 ..S PSJTEXT1(CNT+9,0)=" ** "_$P($G(^PS(53.2,LOOP,0)),"^")_" needs to be reentered"
 N DIFROM D ^XMD K XMSUB,XMDUZ,XMTEXT,PSJTEXT1
 Q
BADNAMES ;
 D NOW^%DTC S $P(^PS(59.7,1,20.5),U,2)=%
 I '$O(^XTMP("PSJ NEW PERSON",0)) K ^XTMP("PSJ NEW PERSON") Q
 ;   fill in ^XTMP zero node
 N PSJDATE1,PSJDATE2
 D NOW^%DTC S PSJDATE1=X,X1=X,X2=7 D C^%DTC S PSJDATE2=X
 S ^XTMP("PSJ NEW PERSON",0)=PSJDATE2_"^"_PSJDATE1_"^"_"List of changed User Names in IV orders"
 S ^XTMP("PSJ NEW1",0)=PSJDATE2_"^"_PSJDATE1_"^"_"List of changed User Names in IV orders"
 S Y=PSJDATE2 X ^DD("DD") S PSJDATE2=Y
 K XMY S XMSUB="Changed user names in IV file"
 S XMDUZ="INPATIENT MEDICATIONS Version 5.0 Install",XMTEXT="PSJTEXT1("
 F LOOP=0:0 S LOOP=$O(^XUSEC("PSJI MGR",LOOP)) Q:'LOOP  D
 .S XMY(LOOP)=""
 S PSJTEXT1(1,0)="The following names were found in IV orders and don't have exact matches in"
 S PSJTEXT1(2,0)="the NEW PERSON FILE."
 S PSJTEXT1(3,0)=""
 N CNT S LOOP=0 F  S LOOP=$O(^XTMP("PSJ NEW PERSON",LOOP)) Q:LOOP=""  D
 .S CNT=$S('$D(CNT):1,1:CNT+1)
 .S PSJTEXT1((CNT+4),0)=" "_LOOP
 S PSJTEXT1((CNT+5),0)=" "
 S PSJTEXT1((CNT+6),0)="This message is sent to all the Inpatient pharmacists."
 S PSJTEXT1((CNT+7),0)="This job should most likely be handled by the Pharmacy Service ADP coordinator."
 S PSJTEXT1((CNT+8),0)="It is VERY IMPORTANT that these names be corrected.  Please have IRM assign"
 S PSJTEXT1((CNT+9),0)="someone the Inpatient Medications option, PSJI 200, ""Correct changed User"
 S PSJTEXT1((CNT+10),0)="Names in IV orders"". Then run this option to correct the names."
 S PSJTEXT1((CNT+11),0)="This correction should be done as soon as possible, or at the latest "
 S PSJTEXT1((CNT+12),0)="by "_PSJDATE2_"."
 N DIFROM D ^XMD K XMSUB,XMDUZ,XMTEXT,PSJTEXT1
 ; PSJ*5*5 cleanup jobs
 D BADN^PSJ005
 Q
 ;
SDCON ;    begin convertion of S. Order Sets to OERR quick orders
 S ZTDTH=$H,ZTIO="",ZTRTN="SDOT^PSJIPST3",ZTDESC="Conversion of Unit Dose Order sets to OERR Quick Orders" D ^%ZTLOAD
 I $D(ZTSK) D MES^XPDUTL(" Job to convert Unit Dose Order Sets to OERR Quick Orders is queued. TASK #"_$G(ZTSK))
 Q
SDOT ;
 S PS="PSJQOS" F PSJ1=0:0 S PSJ1=$O(^PS(53.2,PSJ1)) Q:'PSJ1  D
 . Q:'$D(^PS(53.2,PSJ1,2))  K ^TMP(PS) S ^TMP(PS,$J,"NM")=^PS(53.2,PSJ1,0)
 . F PSJ2=0:0 S PSJ2=$O(^PS(53.2,PSJ1,2,PSJ2)) Q:'PSJ2  D
 .. S $P(^TMP(PS,$J,PSJ2,1),"^")=$P($G(^PS(53.2,PSJ1,2,PSJ2,0)),"^")
 .. S $P(^TMP(PS,$J,PSJ2,1),"^",2)=$P($G(^PS(53.2,PSJ1,2,PSJ2,0)),"^",3)
 .. S $P(^TMP(PS,$J,PSJ2,1),"^",3)=$P($G(^PS(53.2,PSJ1,2,PSJ2,0)),"^",5)
 .. S $P(^TMP(PS,$J,PSJ2,1),"^",4)=$P($G(^PS(53.2,PSJ1,2,PSJ2,0)),"^",9)
 .. S ^TMP(PS,$J,PSJ2,2)=$G(^PS(53.2,PSJ1,2,PSJ2,1)) K CNTT
 .. F PSJDS=0:0 S PSJDS=$O(^PS(53.2,PSJ1,2,PSJ2,2,PSJDS)) Q:'PSJDS  D
 ... Q:$D(CNTT)
 ... S $P(^TMP(PS,$J,PSJ2,3),"^")=$P($G(^PS(53.2,PSJ1,2,PSJ2,2,PSJDS,0)),"^")
 ... S $P(^TMP(PS,$J,PSJ2,3),"^",2)=$P($G(^PS(53.2,PSJ1,2,PSJ2,2,PSJDS,0)),"^",2),CNTT=1
 . D PSJQOS^ORCONV3 ;  call to OERR to process each Order Set
 K CNTT,^TMP(PS),PS,PSJ1,PSJ2,PSJDS Q
