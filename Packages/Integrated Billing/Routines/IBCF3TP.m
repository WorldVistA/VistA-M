IBCF3TP ;ALB/BGA - TEST PATTERN UB92 FORM ; 12-AUG-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;This program performs a test print function. The results of this
 ;test will align the fields of the IB routines to the field locators
 ;on form UB92.
 ;
 ;
ZIS S %ZIS="QM" D ^%ZIS G:POP END
 I $D(IO("Q")) S ZTRTN="ENP^IBCF3TP",ZTSAVE("IBCF31")="",ZTDESC="PRINT TEST BILL" D ^%ZTLOAD K IO("Q") D HOME^%ZIS G END
 U IO
ENP ;
 W "##SR",?34,"*** UB-92 TEST PATTERN ***"
 W !,"AGENT CASHIER"
 W !,"AGENT CASHIER STREET",?57,"BN XXX ",?77,"XXX"
 W !,"CITY  STATE  ZIP"
5 W !,"PHONE #",?26,"TAX# XXXX",?37,"5/1/93",?44,"5/4/93"
 W !
 W !,"PATIENT NAME",?31,"PT SHORT ADDRESS"
 W !
 W !,"DOB",?9,"X",?12,"X",?14,"DATE",?21,"HR",?25,"X",?28,"X",?30,"DR",?33,"ST",?36,"000-00-0000" S IBI=54 F IBJ=1:1:7 W ?IBI,"CC" S IBI=IBI+3
 W !!
11 S IBI=0 F IBJ=1:1:5 W ?IBI,"OC",?(IBI+3),"DATE" S IBI=IBI+10
 W !!,"RESPONSIBLE PARTY'S NAME"
 W !,"STREET ADDRESS 1",!,"STREET ADDRESS 2",!,"STREET ADDRESS 3",!,"CITY  STATE  ZIP"
 W !
19 W !,"CD1",?5,"REV CODE description",?48,"xx",?57,"xxxx.xx"
 W !,"CD2",?5,"REV CODE description",?48,"xx",?57,"xxxx.xx"
 W !,"CD3",?5,"REV CODE description",?48,"xx",?57,"xxxx.xx"
 W !,?5,"Subtotal",?57,"xxxx.xx"
 W !!,?5,"Total",?57,"xxxx.xx"
 W !!!!!!!!!
32 W !,"For your information, even though the patient may be otherwise eligible"
 W !,"for Medicare, no payment may be made under Medicare to any Federal provider"
 W !,"of medical care or services and may not be used as a reason for non-payment."
 W !,"Please make your check payable to the Department of Veterans Affairs and"
 W !,"send to the address listed above."
 W !
 W !,"The undersigned certifies that treatment rendered is not for a"
 W !,"service connected disability."
 W !
43 W !,"Name of Payer 1",?26,"Provider #",?40,"x",?43,"x"
 W !,"Name of Payer 2",?26,"Provider #",?40,"x",?43,"x"
 W !,"Name of Payer 3",?26,"Provider #",?40,"x",?43,"x"
 W !!
48 W !,"Insured's Name 1",?26,"x",?29,"Insurance #",?49,"Group Name",?64,"Group #"
 W !,"Insured's Name 2",?26,"x",?29,"Insurance #",?49,"Group Name",?64,"Group #"
 W !,"Insured's Name 3",?26,"x",?29,"Insurance #",?49,"Group Name",?64,"Group #"
 W !
 W !,"Treatment Auth. Cd",?19,"x",?21,"Employer Name",?47,"Employer Location"
 W !,?19,"x",?21,"Employer Name",?47,"Employer Location"
 W !,?19,"x",?21,"Employer Name",?47,"Employer Location"
 W !
56 W !,"PDX" S IBI=7 F IBJ=1:1:8 W ?IBI,"Dx Cd" S IBI=IBI+7
 W ?64,"ADMT DX",!!
 S IBI=3 F IBJ=1:1:3 W ?IBI,"P-code",?(IBI+8),"mmddyy" S IBI=IBI+15
 W ?52,"Attending Phys. ID#",!!
 S IBI=3 F IBJ=1:1:3 W ?IBI,"P-code",?(IBI+8),"mmddyy" S IBI=IBI+15
 W ?52,"Other Phys. ID#"
61 W !,?7,"Patient ID#: xxx-xx-xxxx"
 W !,"Bill Type: xxx xxxxxx"
 W !,"UB 92 TEST PATTERN",?52,"Provider Representative DATE"
 W !,"*** comment ***"
 K IBI,IBJ
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
END Q
