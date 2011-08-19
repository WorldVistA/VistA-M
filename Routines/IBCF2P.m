IBCF2P ;ALB/ARH - PRINT HCFA 1500 12-90 FORM ; 17-JUL-93
 ;;2.0;INTEGRATED BILLING;**8,52,133**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
PRINT ; print the form, IBFLD required
 S IBADDM=+$P($G(^IBE(350.9,1,1)),U,27),IBPAGE=1
 F IBI=1:1:6 W !,?IBADDM,$G(IBFLD(0,IBI)) ;mailing address
LINE8 ; insured's ID number
 W !!,?49,$E(IBFLD("1A"),1,28)
LINE10 ; patient name, DOB, sex; insured's name ("SAME" if patient)
 W !!,$E(IBFLD(2),1,28),?30,IBFLD("3D"),?($S(IBFLD("3X")="M":41,1:46)),"X",?49,$E(IBFLD(4),1,28)
LINE12 ; patient's address (street); pt. rel to ins.; insured's address
 W !!,$E(IBFLD(5,1),1,28),?($S(+IBFLD(6)=1:32,+IBFLD(6)=2:37,+IBFLD(6)=3:41,1:46)),"X",?49,$E(IBFLD(7),1,28)
LINE14 ; patient addr city, state code, marital status; insured's city, state
 W !!,$E(IBFLD(5,2),1,24),?25,IBFLD("5S"),?($S(IBFLD("8M")="S":34,IBFLD("8M")="M":40,1:46)),"X",?49
LINE16 ; patient zip code, phone; patient employment status; insured's zip code, phone
 W !!,$E(IBFLD(5,3),1,12),?14,IBFLD("5T"),?34,$S(IBFLD("8E")="E":"X",1:""),?49
LINE18 ; other insured's name; insured's policy group
 W !!,$E(IBFLD(9),1,28),?49,$E(IBFLD(11),1,28)
LINE20 ; other insured's policy number; condition related to employment?; insured's date of birth and sex
 W !!,$E(IBFLD("9A"),1,28),?($S(+IBFLD("10A"):34,1:40)),"X"
 W ?53,IBFLD("11AD") I IBFLD("11AX")'="" W ?($S(IBFLD("11AX")="M":67,1:74)),"X"
LINE22 ; other insured's DOB, sex; patient auto accident & place; insured's employer
 W !!,?1,IBFLD("9BD") I IBFLD("9BX")'="" W ?($S(IBFLD("9BX")="M":17,1:23)),"X"
 W ?($S(+IBFLD("10B"):34,1:40)),"X",?44,IBFLD("10BS"),?49,$E(IBFLD("11B"),1,28)
LINE24 ; other insured's employer; patient other accident; insured's insurance plan name
 W !!,$E(IBFLD("9C"),1,28),?($S(+IBFLD("10C"):34,1:40)),"X",?49,$E(IBFLD("11C"),1,28)
LINE26 ; other insured's plan name; is there another benefit plan
 W !!,$E(IBFLD("9D"),1,28),?($S(+IBFLD("11D"):51,1:56)),"X"
LINE29 ; patient's signature; insured's signature (use PL 99-272, SECTION 1729 TITLE 38)
 W !!!,?3,IBFLD(12),?56,IBFLD(13)
LINE32 ; date of current illness; date of similar illness; dates unable to work
 W !!!,?1,IBFLD(14),?36,IBFLD(15),?53,IBFLD("16A"),?67,IBFLD("16B")
LINE34 ; name of referring physician; ID# referring physician; hospitalization dates related to services
 W !!,?53,IBFLD("18A"),?67,IBFLD("18B")
LINE35 ; "not for SC" note line 1
 W !,?14,$E(IBFLD(19),1,31)_"-"
LINE36 ; "not for SC" note line 2; outside lab (now defaults to "no" in IBEHCFA)
 W !,$E(IBFLD(19),32,999),?56,"X"
LINE38 ; diagnosis codes 1 and 2; field 22 (MEDICAID) left blank
 W !!,?2,IBFLD(21,1),?30,IBFLD(21,3)
LINE40 ; diagnosis codes 3 and 4; field 23 (prior authorization #)
 W !!,?2,IBFLD(21,2),?30,IBFLD(21,4),?49,IBFLD(23)
LINE44 ;lines 44,46,48,50,52,54 all the same
 W !! S IBI=+$P(IBFLD(24),U,2) F IBJ=1:1:6 S IBI=IBI+1 D
 . W ! I $D(IBFLD(24,IBI_"A")) W ?25,$E(IBFLD(24,IBI_"A"),1,15)
 . W ! I $D(IBFLD(24,IBI)) D  S IBFLD(24)=IBFLD(24)-1
 .. W $P(IBFLD(24,IBI),U,1),?9,$P(IBFLD(24,IBI),U,2),?18,$P(IBFLD(24,IBI),U,3),?21,$P(IBFLD(24,IBI),U,4),?25,$E($P(IBFLD(24,IBI),U,5),1,15)
 .. I $P(IBFLD(24,IBI),U,9) W ?32,$P($$MOD^ICPTMOD(+$P(IBFLD(24,IBI),U,9),"I",DT),U,2)
 .. W ?41,$P(IBFLD(24,IBI),U,6),?48,$S(+$P(IBFLD(24,IBI),U,7):$J($P(IBFLD(24,IBI),U,7),9,2),1:""),?57,$J($P(IBFLD(24,IBI),U,8),3)
 S $P(IBFLD(24),U,2)=IBI
 ;
LINE56 W !!,IBFLD(25),?18,"X",?22,IBFLD(26),?49,$J(IBFLD(28),10,2)
 W:IBFLD(29) ?62,$J(IBFLD(29),7,2),?71,$J(IBFLD(30),7,2)
LINE58 W !!,?22,$E(IBFLD(32,1),1,26),?49,$E(IBFLD(33,1),1,26)
LINE69 W !,$E(IBFLD(31),1,21),?22,$E(IBFLD(32,2),1,26),?49,$E(IBFLD(33,2),1,26)
LINE60 W !,$E(IBFLD(31),22,42)
 W ?22,$E(IBFLD(32,3),1,(26-2-$L(IBFLD(32,"X")))) I IBFLD(32,"X")'="" W ", "_IBFLD(32,"X")
 W ?49,$E(IBFLD(33,3),1,(26-2-$L(IBFLD(33,"X")))) I IBFLD(33,"X")'="" W ", "_IBFLD(33,"X")
LINE61 W !,$E(IBFLD(31),43,63),?49,IBFLD(33,4)
 ;
 I +IBFLD(24)>0 D  G LINE38 ;multiple pages
 . S IBPAGE=IBPAGE+1
 . W @IOF,!,?IBADDM,"PAGE ",IBPAGE,!!!!!!!,?49,IBFLD("1A"),!!,IBFLD(2)
 . F IBI=1:1:26 W !
 ;
END K IBADDM,IBPAGE
 Q
